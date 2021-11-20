Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6216B4580E0
	for <lists+linux-pci@lfdr.de>; Sun, 21 Nov 2021 00:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236940AbhKTXLS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 20 Nov 2021 18:11:18 -0500
Received: from angie.orcam.me.uk ([78.133.224.34]:37754 "EHLO
        angie.orcam.me.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236806AbhKTXLS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 20 Nov 2021 18:11:18 -0500
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 1F92192009C; Sun, 21 Nov 2021 00:08:13 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 0FB7392009B;
        Sat, 20 Nov 2021 23:08:13 +0000 (GMT)
Date:   Sat, 20 Nov 2021 23:08:12 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Bjorn Helgaas <bhelgaas@google.com>
cc:     Stefan Roese <sr@denx.de>, Jim Wilson <wilson@tuliptree.org>,
        David Abdurachmanov <david.abdurachmanov@sifive.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] pci: Work around ASMedia ASM2824 PCIe link training
 failures
Message-ID: <alpine.DEB.2.21.2111201924390.10804@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Attempt to handle cases with a downstream port of the ASMedia ASM2824 
PCIe switch where link training never completes and the link continues 
switching between speeds indefinitely with the data link layer never 
reaching the active state.

It has been observed with a downstream port of the ASMedia ASM2824 Gen 3 
switch wired to the upstream port of the Pericom PI7C9X2G304 Gen 2 
switch, using a Delock Riser Card PCI Express x1 > 2 x PCIe x1 device, 
P/N 41433, wired to a SiFive HiFive Unmatched board.  In this setup the 
switches are supposed to negotiate the link speed of preferably 5.0GT/s, 
falling back to 2.5GT/s.

However the link continues oscillating between the two speeds, at the 
rate of 34-35 times per second, with link training reported repeatedly 
active ~84% of the time, e.g.:

02:03.0 PCI bridge [0604]: ASMedia Technology Inc. ASM2824 PCIe Gen3 Packet Switch [1b21:2824] (rev 01) (prog-if 00 [Normal decode])
[...]
	Bus: primary=02, secondary=05, subordinate=05, sec-latency=0
[...]
	Capabilities: [80] Express (v2) Downstream Port (Slot+), MSI 00
[...]
		LnkSta:	Speed 5GT/s (downgraded), Width x1 (ok)
			TrErr- Train+ SlotClk+ DLActive- BWMgmt+ ABWMgmt-
[...]
		LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis+, Selectable De-emphasis: -3.5dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
[...]

Forcibly limiting the target link speed to 2.5GT/s with the upstream 
ASM2824 device makes the two switches communicate correctly however:

02:03.0 PCI bridge [0604]: ASMedia Technology Inc. ASM2824 PCIe Gen3 Packet Switch [1b21:2824] (rev 01) (prog-if 00 [Normal decode])
[...]
	Bus: primary=02, secondary=05, subordinate=09, sec-latency=0
[...]
	Capabilities: [80] Express (v2) Downstream Port (Slot+), MSI 00
[...]
		LnkSta:	Speed 2.5GT/s (downgraded), Width x1 (ok)
			TrErr- Train- SlotClk+ DLActive+ BWMgmt- ABWMgmt-
[...]
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis+, Selectable De-emphasis: -3.5dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
[...]

and then:

05:00.0 PCI bridge [0604]: Pericom Semiconductor PI7C9X2G304 EL/SL PCIe2 3-Port/4-Lane Packet Switch [12d8:2304] (rev 05) (prog-if 00 [Normal decode])
[...]
	Bus: primary=05, secondary=06, subordinate=09, sec-latency=0
[...]
	Capabilities: [c0] Express (v2) Upstream Port, MSI 00
[...]
		LnkSta:	Speed 2.5GT/s (downgraded), Width x1 (downgraded)
			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
[...]
		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
[...]

Removing the speed restriction afterwards makes the two devices switch 
to 5.0GT/s then.

Make use of these observations then and detect the inability to train 
the link, by checking for the Data Link Layer Link Active status bit 
implemented by the ASM2824 being off while the Link Bandwidth Management 
Status indicating that hardware has changed the link speed or width in 
an attempt to correct unreliable link operation.

Restrict the speed to 2.5GT/s then with the Target Link Speed field, 
request a retrain and wait 200ms for the data link to go up.  If this 
turns out successful, then lift the restriction, letting the devices 
negotiate a higher speed.  Also check for a 2.5GT/s speed restriction 
the firmware may have already arranged and lift it too with ports that 
already report their data link being up.

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
---
Hi,

 This proposal includes support for a scenario where the firmware has 
restricted the speed for a port already, for access to any downstream boot 
devices if nothing else, such as with the U-Boot change proposed here: 
<https://lists.denx.de/pipermail/u-boot/2021-November/467852.html>.  This 
is why the removal of the 2.5GT/s speed restriction is done regardless of 
whether it was us to put it in place in the first place.

 Credit goes to Stefan for a suggestion to check for any interaction with
the de-emphasis level, which gave me incentive for further experimentation 
that has eventually made me discover that lifting the restriction makes 
the two devices negotiate 5GT/s.  This is especially worthwhile given that 
the Delock part (<https://www.delock.com/produkt/41433/merkmale.html>), 
since discontinued, has a 5GT/s x1 upstream port and a pair of 2.5GT/s x1 
downstream ports so keeping the upstream port at it's maximum speed avoids
a bottleneck there.

 For the background story as to how I tried to get the manufacturers of 
the devices involved, unsuccessfully, except for the guys from SiFive who 
were at least sympathetic (thank you!), but this level of hardware debug 
was beyond their skills and/or resources, and then how I discovered how to
persuade the two devices to talk to each other at all, at 2.5GT/s, see:
<https://lists.denx.de/pipermail/u-boot/2021-November/467199.html>.

 One case that has been nurturing me though is the reverse scenario, that 
is where the Pericom PI7C9X2G304 switch is upstream while the ASMedia 
ASM2824 switch is downstream.  Presumably the same situation will happen, 
so matching on the ASM2824 ID only would be a problem.  Unfortunately the 
other device does not implement the Data Link Layer Link Active status 
bit, so a more complex approach, such as clearing and then checking for 
the Link Bandwidth Management Status having been set again might be an 
option.  Unlike U-Boot we cannot do aggressive polling of the Link 
Training bit.

 Option hardware with M.2 slots is commercially available with the ASM2824 
onboard, so a test environment can be in principle arranged, though I'm 
not sure if just for the sake of such an experiment I'm willing to spend 
money that will ultimately go to a manufacturer that cannot be bothered to 
take responsibility for their faults and at the very least respond to a 
problem report.  And without verifying the actual problem exists I'm 
reluctant to try and implement a workaround.  On the other hand the 
problem with the Unmatched board is real and this change addresses it, at 
least for me.

 NB the BUG_ON there is a safety valve really for an "impossible" case.  
The ASM2824 is a PCIe device and necessarily it does have the PCI Express 
capability.  Poking at that unguarded though just didn't feel right to me, 
while doing any kind of full-fledged recovery seemed like an overkill.

 Questions, comments, concerns?  Otherwise please apply.

  Maciej
---
 drivers/pci/quirks.c    |   96 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pci_ids.h |    1 
 2 files changed, 97 insertions(+)

linux-pcie-asm2824-manual-retrain.diff
Index: linux/drivers/pci/quirks.c
===================================================================
--- linux.orig/drivers/pci/quirks.c
+++ linux/drivers/pci/quirks.c
@@ -12,6 +12,7 @@
  * file, where their drivers can use them.
  */
 
+#include <linux/bug.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/export.h>
@@ -5795,3 +5796,98 @@ static void apex_pci_fixup_class(struct
 }
 DECLARE_PCI_FIXUP_CLASS_HEADER(0x1ac1, 0x089a,
 			       PCI_CLASS_NOT_DEFINED, 8, apex_pci_fixup_class);
+
+/*
+ * Retrain the link of a downstream PCIe port by hand if necessary.
+ *
+ * This is needed at least where a downstream port of the ASMedia ASM2824
+ * Gen 3 switch is wired to the upstream port of the Pericom PI7C9X2G304
+ * Gen 2 switch, and observed with the Delock Riser Card PCI Express x1 >
+ * 2 x PCIe x1 device, P/N 41433, plugged into the SiFive HiFive Unmatched
+ * board.
+ *
+ * In such a configuration the switches are supposed to negotiate the link
+ * speed of preferably 5.0GT/s, falling back to 2.5GT/s.  However the link
+ * continues switching between the two speeds indefinitely and the data
+ * link layer never reaches the active state, with link training reported
+ * repeatedly active ~84% of the time.  Forcing the target link speed to
+ * 2.5GT/s with the upstream ASM2824 device makes the two switches talk to
+ * each other correctly however.  And more interestingly retraining with a
+ * higher target link speed afterwards lets the two successfully negotiate
+ * 5.0GT/s.
+ *
+ * With the ASM2824 we can rely on the otherwise optional Data Link Layer
+ * Link Active status bit and in the failed link training scenario it will
+ * be off along with the Link Bandwidth Management Status indicating that
+ * hardware has changed the link speed or width in an attempt to correct
+ * unreliable link operation.  For a port that has been left unconnected
+ * both bits will be clear.  So use this information to detect the problem
+ * rather than polling the Link Training bit and watching out for flips or
+ * at least the active status.
+ *
+ * Restrict the speed to 2.5GT/s then with the Target Link Speed field,
+ * request a retrain and wait 200ms for the data link to go up.  If this
+ * turns out successful, then lift the restriction, letting the devices
+ * negotiate a higher speed.  Also check for a 2.5GT/s speed restriction
+ * the firmware may have already arranged and lift it too with ports that
+ * already report their data link being up.
+ */
+static void pcie_downstream_link_retrain(struct pci_dev *dev)
+{
+	u16 lnksta, lnkctl2;
+	u8 pos;
+
+	pos = pci_find_capability(dev, PCI_CAP_ID_EXP);
+	BUG_ON(!pos);
+
+	pci_read_config_word(dev, pos + PCI_EXP_LNKCTL2, &lnkctl2);
+	pci_read_config_word(dev, pos + PCI_EXP_LNKSTA, &lnksta);
+	if ((lnksta & (PCI_EXP_LNKSTA_LBMS | PCI_EXP_LNKSTA_DLLLA)) ==
+	    PCI_EXP_LNKSTA_LBMS) {
+		unsigned long timeout;
+		u16 lnkctl;
+
+		pci_info(dev, "broken device, retraining non-functional downstream link at 2.5GT/s...\n");
+
+		pci_read_config_word(dev, pos + PCI_EXP_LNKCTL, &lnkctl);
+		lnkctl |= PCI_EXP_LNKCTL_RL;
+		lnkctl2 &= ~PCI_EXP_LNKCTL2_TLS;
+		lnkctl2 |= PCI_EXP_LNKCTL2_TLS_2_5GT;
+		pci_write_config_word(dev, pos + PCI_EXP_LNKCTL2, lnkctl2);
+		pci_write_config_word(dev, pos + PCI_EXP_LNKCTL, lnkctl);
+
+		timeout = jiffies + msecs_to_jiffies(200);
+		do {
+			pci_read_config_word(dev, pos + PCI_EXP_LNKSTA,
+					     &lnksta);
+			if (lnksta & PCI_EXP_LNKSTA_DLLLA)
+				break;
+			usleep_range(10000, 20000);
+		} while (time_before(jiffies, timeout));
+
+		pci_info(dev, "retraining %s!\n",
+			 lnksta & PCI_EXP_LNKSTA_DLLLA ?
+			 "succeeded" : "failed");
+	}
+
+	if ((lnksta & PCI_EXP_LNKSTA_DLLLA) &&
+	    (lnkctl2 & PCI_EXP_LNKCTL2_TLS) == PCI_EXP_LNKCTL2_TLS_2_5GT) {
+		u32 lnkcap;
+		u16 lnkctl;
+
+		pci_info(dev, "removing 2.5GT/s downstream link speed restriction\n");
+		pci_read_config_word(dev, pos + PCI_EXP_LNKCTL, &lnkctl);
+		pci_read_config_dword(dev, pos + PCI_EXP_LNKCAP, &lnkcap);
+		lnkctl |= PCI_EXP_LNKCTL_RL;
+		lnkctl2 &= ~PCI_EXP_LNKCTL2_TLS;
+		lnkctl2 |= lnkcap & PCI_EXP_LNKCAP_SLS;
+		pci_write_config_word(dev, pos + PCI_EXP_LNKCTL2, lnkctl2);
+		pci_write_config_word(dev, pos + PCI_EXP_LNKCTL, lnkctl);
+	}
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ASMEDIA,
+			 PCI_DEVICE_ID_ASMEDIA_ASM2824,
+			 pcie_downstream_link_retrain);
+DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_ASMEDIA,
+			       PCI_DEVICE_ID_ASMEDIA_ASM2824,
+			       pcie_downstream_link_retrain);
Index: linux/include/linux/pci_ids.h
===================================================================
--- linux.orig/include/linux/pci_ids.h
+++ linux/include/linux/pci_ids.h
@@ -2562,6 +2562,7 @@
 #define PCI_SUBDEVICE_ID_QEMU            0x1100
 
 #define PCI_VENDOR_ID_ASMEDIA		0x1b21
+#define PCI_DEVICE_ID_ASMEDIA_ASM2824	0x2824
 
 #define PCI_VENDOR_ID_REDHAT		0x1b36
 
