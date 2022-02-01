Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB7794A5A87
	for <lists+linux-pci@lfdr.de>; Tue,  1 Feb 2022 11:50:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235708AbiBAKui (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Feb 2022 05:50:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiBAKui (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Feb 2022 05:50:38 -0500
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 661ADC061714;
        Tue,  1 Feb 2022 02:50:38 -0800 (PST)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id C14BA92009C; Tue,  1 Feb 2022 11:50:37 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id B9DBE92009B;
        Tue,  1 Feb 2022 10:50:37 +0000 (GMT)
Date:   Tue, 1 Feb 2022 10:50:37 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Bjorn Helgaas <bhelgaas@google.com>
cc:     Stefan Roese <sr@denx.de>, Jim Wilson <wilson@tuliptree.org>,
        David Abdurachmanov <david.abdurachmanov@sifive.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] pci: Work around ASMedia ASM2824 PCIe link training
 failures
Message-ID: <alpine.DEB.2.21.2202010240190.58572@angie.orcam.me.uk>
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

 Patch regenerated and re-verified against 5.17-rc2.  On this occasion I 
decided to remove BUG_ON after all for a supposedly impossible condition 
of a missing PCI Express capability for this PCIe switch and instead use 
WARN_ON and an early return.  It should be safer this way.

 NB the corresponding U-boot change has since gone in with commit 
a398a51ccc68 ("pci: Work around PCIe link training failures").  See 
<https://lore.kernel.org/lkml/alpine.DEB.2.21.2201022100430.56863@angie.orcam.me.uk/> 
for previous background information.

 Questions, comments, concerns?  Otherwise please apply.

  Maciej

Changes from v2:

- Regenerate for 5.17-rc2 for a merge conflict.

- Replace BUG_ON for a missing PCI Express capability with WARN_ON and an
  early return.

Changes from v1:

- Regenerate for a merge conflict.
---
 drivers/pci/quirks.c    |   98 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pci_ids.h |    1 
 2 files changed, 99 insertions(+)

linux-pcie-asm2824-manual-retrain.diff
Index: linux-macro/drivers/pci/quirks.c
===================================================================
--- linux-macro.orig/drivers/pci/quirks.c
+++ linux-macro/drivers/pci/quirks.c
@@ -12,6 +12,7 @@
  * file, where their drivers can use them.
  */
 
+#include <linux/bug.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/export.h>
@@ -5879,3 +5880,100 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_IN
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1536, rom_bar_overlap_defect);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1537, rom_bar_overlap_defect);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1538, rom_bar_overlap_defect);
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
+	WARN_ON(!pos);
+	if (!pos)
+		return;
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
Index: linux-macro/include/linux/pci_ids.h
===================================================================
--- linux-macro.orig/include/linux/pci_ids.h
+++ linux-macro/include/linux/pci_ids.h
@@ -2545,6 +2545,7 @@
 #define PCI_SUBDEVICE_ID_QEMU            0x1100
 
 #define PCI_VENDOR_ID_ASMEDIA		0x1b21
+#define PCI_DEVICE_ID_ASMEDIA_ASM2824	0x2824
 
 #define PCI_VENDOR_ID_REDHAT		0x1b36
 
