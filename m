Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC3743DAF1E
	for <lists+linux-pci@lfdr.de>; Fri, 30 Jul 2021 00:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234758AbhG2Wfc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Jul 2021 18:35:32 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49220 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234157AbhG2WfG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Jul 2021 18:35:06 -0400
Message-ID: <20210729222543.045993608@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627598101;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=G8gQA2Hvd9tJ7CHOY+IkR1yc+vWQ4JZgR6mssB9yHa4=;
        b=w33s6zt0+y7ZqR3NSyKuA8XtQ2UFBIfomm87N2PPX2DshaTKExLdy9yPkdm2IuWDZ/eFAY
        KH3LujTG1wiJVTqG2zDXUYfP5+UY7OjtxZQ5Rw+/63I5LpDgid1ZeXy+CNF77fHT8hNGo+
        DZol6qZPtFpDigXe+pPHtkWNuDnEWKzakrFNfIkYWChJS080TGDKHrRxpjCsbAsUzEZ5Ik
        iYX4bY1Om2ZHOFq2rVVy+D5ewymJp0jwgLUY9yxw5Y2SJoiKJUga0HE3E2jffStSbVTBUj
        RXfgunZ0KHdiI6ScoJNkvbj4h6+8LVyIFPsRqt75HlGEVkbhYE4JD1z1EONLfw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627598101;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=G8gQA2Hvd9tJ7CHOY+IkR1yc+vWQ4JZgR6mssB9yHa4=;
        b=ShafdiCyyOvmkxcq0R3499rKzklPUgxI9y9kkvRgYEGYJsx8KQAfQ2fgixc6ea4Cp5OAY3
        V9/Sm46v7MExXvDQ==
Date:   Thu, 29 Jul 2021 23:51:53 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Kevin Tian <kevin.tian@intel.com>,
        Marc Zyngier <maz@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, linux-s390@vger.kernel.org,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [patch V2 14/19] PCI/MSI: Rename msi_desc::masked
References: <20210729215139.889204656@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

msi_desc::masked is a misnomer. For MSI it's used to cache the MSI mask
bits when the device supports per vector masking. For MSI-X it's used to
cache the content of the vector control word which contains the mask bit
for the vector.

Replace it with a union of msi_mask and msix_ctrl to make the purpose clear
and fix up the usage sites.

No functional change

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: New patch
---
 drivers/pci/msi.c   |   30 +++++++++++++++---------------
 include/linux/msi.h |    8 ++++++--
 2 files changed, 21 insertions(+), 17 deletions(-)

--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -152,10 +152,10 @@ static void __pci_msi_desc_mask_irq(stru
 		return;
 
 	raw_spin_lock_irqsave(lock, flags);
-	desc->masked &= ~mask;
-	desc->masked |= flag;
+	desc->msi_mask &= ~mask;
+	desc->msi_mask |= flag;
 	pci_write_config_dword(msi_desc_to_pci_dev(desc), desc->mask_pos,
-			       desc->masked);
+			       desc->msi_mask);
 	raw_spin_unlock_irqrestore(lock, flags);
 }
 
@@ -182,7 +182,7 @@ static void __iomem *pci_msix_desc_addr(
  */
 static u32 __pci_msix_desc_mask_irq(struct msi_desc *desc, u32 flag)
 {
-	u32 mask_bits = desc->masked;
+	u32 ctrl = desc->msix_ctrl;
 	void __iomem *desc_addr;
 
 	if (pci_msi_ignore_mask)
@@ -192,18 +192,18 @@ static u32 __pci_msix_desc_mask_irq(stru
 	if (!desc_addr)
 		return 0;
 
-	mask_bits &= ~PCI_MSIX_ENTRY_CTRL_MASKBIT;
-	if (flag & PCI_MSIX_ENTRY_CTRL_MASKBIT)
-		mask_bits |= PCI_MSIX_ENTRY_CTRL_MASKBIT;
+	ctrl &= ~PCI_MSIX_ENTRY_CTRL_MASKBIT;
+	if (ctrl & PCI_MSIX_ENTRY_CTRL_MASKBIT)
+		ctrl |= PCI_MSIX_ENTRY_CTRL_MASKBIT;
 
-	writel(mask_bits, desc_addr + PCI_MSIX_ENTRY_VECTOR_CTRL);
+	writel(ctrl, desc_addr + PCI_MSIX_ENTRY_VECTOR_CTRL);
 
-	return mask_bits;
+	return ctrl;
 }
 
 static void msix_mask_irq(struct msi_desc *desc, u32 flag)
 {
-	desc->masked = __pci_msix_desc_mask_irq(desc, flag);
+	desc->msix_ctrl = __pci_msix_desc_mask_irq(desc, flag);
 }
 
 static void msi_set_mask_bit(struct irq_data *data, u32 flag)
@@ -290,7 +290,7 @@ void __pci_write_msi_msg(struct msi_desc
 		/* Don't touch the hardware now */
 	} else if (entry->msi_attrib.is_msix) {
 		void __iomem *base = pci_msix_desc_addr(entry);
-		bool unmasked = !(entry->masked & PCI_MSIX_ENTRY_CTRL_MASKBIT);
+		bool unmasked = !(entry->msix_ctrl & PCI_MSIX_ENTRY_CTRL_MASKBIT);
 
 		if (!base)
 			goto skip;
@@ -430,7 +430,7 @@ static void __pci_restore_msi_state(stru
 
 	pci_read_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, &control);
 	msi_mask_irq(entry, msi_mask(entry->msi_attrib.multi_cap),
-		     entry->masked);
+		     entry->msi_mask);
 	control &= ~PCI_MSI_FLAGS_QSIZE;
 	control |= (entry->msi_attrib.multiple << 4) | PCI_MSI_FLAGS_ENABLE;
 	pci_write_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, control);
@@ -461,7 +461,7 @@ static void __pci_restore_msix_state(str
 
 	arch_restore_msi_irqs(dev);
 	for_each_pci_msi_entry(entry, dev)
-		msix_mask_irq(entry, entry->masked);
+		msix_mask_irq(entry, entry->msix_ctrl);
 
 	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_MASKALL, 0);
 }
@@ -602,7 +602,7 @@ msi_setup_entry(struct pci_dev *dev, int
 
 	/* Save the initial mask status */
 	if (entry->msi_attrib.maskbit)
-		pci_read_config_dword(dev, entry->mask_pos, &entry->masked);
+		pci_read_config_dword(dev, entry->mask_pos, &entry->msi_mask);
 
 out:
 	kfree(masks);
@@ -750,7 +750,7 @@ static int msix_setup_entries(struct pci
 
 		addr = pci_msix_desc_addr(entry);
 		if (addr)
-			entry->masked = readl(addr + PCI_MSIX_ENTRY_VECTOR_CTRL);
+			entry->msix_ctrl = readl(addr + PCI_MSIX_ENTRY_VECTOR_CTRL);
 
 		list_add_tail(&entry->list, dev_to_msi_list(&dev->dev));
 		if (masks)
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -107,7 +107,8 @@ struct ti_sci_inta_msi_desc {
  *			address or data changes
  * @write_msi_msg_data:	Data parameter for the callback.
  *
- * @masked:	[PCI MSI/X] Mask bits
+ * @msi_mask:	[PCI MSI]   MSI cached mask bits
+ * @msix_ctrl:	[PCI MSI-X] MSI-X cached per vector control bits
  * @is_msix:	[PCI MSI/X] True if MSI-X
  * @multiple:	[PCI MSI/X] log2 num of messages allocated
  * @multi_cap:	[PCI MSI/X] log2 num of messages supported
@@ -139,7 +140,10 @@ struct msi_desc {
 	union {
 		/* PCI MSI/X specific data */
 		struct {
-			u32 masked;
+			union {
+				u32 msi_mask;
+				u32 msix_ctrl;
+			};
 			struct {
 				u8	is_msix		: 1;
 				u8	multiple	: 3;

