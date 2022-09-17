Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C57D5BB817
	for <lists+linux-pci@lfdr.de>; Sat, 17 Sep 2022 14:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbiIQMEA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 17 Sep 2022 08:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiIQMDm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 17 Sep 2022 08:03:42 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 342833AB26;
        Sat, 17 Sep 2022 05:03:39 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 6F3F692009C; Sat, 17 Sep 2022 14:03:38 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 6858C92009B;
        Sat, 17 Sep 2022 13:03:38 +0100 (BST)
Date:   Sat, 17 Sep 2022 13:03:38 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Bjorn Helgaas <bhelgaas@google.com>
cc:     Stefan Roese <sr@denx.de>, Jim Wilson <wilson@tuliptree.org>,
        David Abdurachmanov <david.abdurachmanov@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 5/5] PCI: Work around PCIe link training failures
In-Reply-To: <alpine.DEB.2.21.2209061238050.2275@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2209130050380.60554@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2209061238050.2275@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Attempt to handle cases such as with a downstream port of the ASMedia 
ASM2824 PCIe switch where link training never completes and the link 
continues switching between speeds indefinitely with the data link layer 
never reaching the active state.

It has been observed with a downstream port of the ASMedia ASM2824 Gen 3 
switch wired to the upstream port of the Pericom PI7C9X2G304 Gen 2 
switch, using a Delock Riser Card PCI Express x1 > 2 x PCIe x1 device, 
P/N 41433, wired to a SiFive HiFive Unmatched board.  In this setup the 
switches are supposed to negotiate the link speed of preferably 5.0GT/s, 
falling back to 2.5GT/s.

Instead the link continues oscillating between the two speeds, at the 
rate of 34-35 times per second, with link training reported repeatedly 
active ~84% of the time.  Forcibly limiting the target link speed to 
2.5GT/s with the upstream ASM2824 device however makes the two switches 
communicate correctly.  Removing the speed restriction afterwards makes 
the two devices switch to 5.0GT/s then.

Make use of these observations then and detect the inability to train 
the link, by checking for the Data Link Layer Link Active status bit 
being off while the Link Bandwidth Management Status indicating that 
hardware has changed the link speed or width in an attempt to correct 
unreliable link operation.

Restrict the speed to 2.5GT/s then with the Target Link Speed field, 
request a retrain and wait 200ms for the data link to go up.  If this 
turns out successful, then lift the restriction, letting the devices 
negotiate a higher speed.

Also check for a 2.5GT/s speed restriction the firmware may have already 
arranged and lift it too with ports of devices known to continue working 
afterwards, currently the ASM2824 only, that already report their data 
link being up.

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
Link: https://lore.kernel.org/lkml/alpine.DEB.2.21.2203022037020.56670@angie.orcam.me.uk/
Link: https://source.denx.de/u-boot/u-boot/-/commit/a398a51ccc68
---
Changes from v4:

- Remove <linux/bug.h> inclusion no longer needed.

- Make the quirk generic based on probing device features rather than 
  specific to the ASM2824 part only; take the Retrain Link bit erratum 
  into account.

- Still lift the 2.5GT/s speed restriction with the ASM2824 only.

- Increase retrain timeout from 200ms to 1s (PCIE_LINK_RETRAIN_TIMEOUT).

- Remove retrain success notification.

- Use PCIe helpers rather than generic PCI functions throughout.

- Trim down and update the wording of the change description for the 
  switch from an ASM2824-specific to a generic fixup.

Changes from v3:

- Remove the <linux/pci_ids.h> entry for the ASM2824.

Changes from v2:

- Regenerate for 5.17-rc2 for a merge conflict.

- Replace BUG_ON for a missing PCI Express capability with WARN_ON and an
  early return.

Changes from v1:

- Regenerate for a merge conflict.
---
 drivers/pci/quirks.c |  118 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 118 insertions(+)

linux-pcie-asm2824-manual-retrain.diff
Index: linux-macro/drivers/pci/quirks.c
===================================================================
--- linux-macro.orig/drivers/pci/quirks.c
+++ linux-macro/drivers/pci/quirks.c
@@ -5956,3 +5956,121 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_I
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56c0, aspm_l1_acceptable_latency);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56c1, aspm_l1_acceptable_latency);
 #endif
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
+ * Since the exact nature of the problem isn't known and in principle this
+ * could trigger where an ASM2824 device is downstream rather upstream,
+ * apply this erratum workaround to any downstream ports as long as they
+ * support Link Active reporting and have the Link Control 2 register.
+ * Restrict the speed to 2.5GT/s then with the Target Link Speed field,
+ * request a retrain and wait 200ms for the data link to go up.
+ *
+ * If this turns out successful and we know by the Vendor:Device ID it is
+ * safe to do so, then lift the restriction, letting the devices negotiate
+ * a higher speed.  Also check for a similar 2.5GT/s speed restriction the
+ * firmware may have already arranged and lift it with ports that already
+ * report their data link being up.
+ */
+static void pcie_downstream_link_retrain(struct pci_dev *dev)
+{
+	static const struct pci_device_id ids[] = {
+		{ PCI_VDEVICE(ASMEDIA, 0x2824) }, /* ASMedia ASM2824 */
+		{}
+	};
+	u16 lnksta, lnkctl2;
+	u32 lnkcap;
+
+	if (!pci_is_pcie(dev) || !pcie_downstream_port(dev)
+	    || !pcie_cap_has_lnkctl2(dev))
+		return;
+
+	/* It's too early yet to use `dev->link_active_reporting'.  */
+	pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &lnkcap);
+	if (!(lnkcap & PCI_EXP_LNKCAP_DLLLARC))
+		return;
+
+	pcie_capability_read_word(dev, PCI_EXP_LNKCTL2, &lnkctl2);
+	pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
+	if ((lnksta & (PCI_EXP_LNKSTA_LBMS | PCI_EXP_LNKSTA_DLLLA)) ==
+	    PCI_EXP_LNKSTA_LBMS) {
+		unsigned long timeout;
+		u16 lnkctl;
+
+		pci_info(dev, "broken device, retraining non-functional downstream link at 2.5GT/s\n");
+
+		pcie_capability_read_word(dev, PCI_EXP_LNKCTL, &lnkctl);
+		lnkctl |= PCI_EXP_LNKCTL_RL;
+		lnkctl2 &= ~PCI_EXP_LNKCTL2_TLS;
+		lnkctl2 |= PCI_EXP_LNKCTL2_TLS_2_5GT;
+		pcie_capability_write_word(dev, PCI_EXP_LNKCTL2, lnkctl2);
+		pcie_capability_write_word(dev, PCI_EXP_LNKCTL, lnkctl);
+		/*
+		 * Due to an erratum in some devices the Retrain Link bit
+		 * needs to be cleared again manually to allow the link
+		 * training to succeed.
+		 */
+		lnkctl &= ~PCI_EXP_LNKCTL_RL;
+		if (dev->clear_retrain_link)
+			pcie_capability_write_word(dev, PCI_EXP_LNKCTL,
+						   lnkctl);
+
+		timeout = jiffies + PCIE_LINK_RETRAIN_TIMEOUT;
+		do {
+			pcie_capability_read_word(dev, PCI_EXP_LNKSTA,
+					     &lnksta);
+			if (lnksta & PCI_EXP_LNKSTA_DLLLA)
+				break;
+			usleep_range(10000, 20000);
+		} while (time_before(jiffies, timeout));
+
+		if (!(lnksta & PCI_EXP_LNKSTA_DLLLA)) {
+			pci_info(dev, "retraining failed\n");
+			return;
+		}
+	}
+
+	if ((lnksta & PCI_EXP_LNKSTA_DLLLA) &&
+	    (lnkctl2 & PCI_EXP_LNKCTL2_TLS) == PCI_EXP_LNKCTL2_TLS_2_5GT &&
+	    pci_match_id(ids, dev)) {
+		u16 lnkctl;
+
+		pci_info(dev, "removing 2.5GT/s downstream link speed restriction\n");
+		pcie_capability_read_word(dev, PCI_EXP_LNKCTL, &lnkctl);
+		lnkctl |= PCI_EXP_LNKCTL_RL;
+		lnkctl2 &= ~PCI_EXP_LNKCTL2_TLS;
+		lnkctl2 |= lnkcap & PCI_EXP_LNKCAP_SLS;
+		pcie_capability_write_word(dev, PCI_EXP_LNKCTL2, lnkctl2);
+		pcie_capability_write_word(dev, PCI_EXP_LNKCTL, lnkctl);
+	}
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI_ANY_ID,
+			 pcie_downstream_link_retrain);
+DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_ANY_ID, PCI_ANY_ID,
+			       pcie_downstream_link_retrain);
