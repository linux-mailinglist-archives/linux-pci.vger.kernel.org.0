Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB2EF3DAF27
	for <lists+linux-pci@lfdr.de>; Fri, 30 Jul 2021 00:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235249AbhG2Wfw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Jul 2021 18:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234445AbhG2WfQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Jul 2021 18:35:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78AE3C0617A0;
        Thu, 29 Jul 2021 15:35:10 -0700 (PDT)
Message-ID: <20210729222543.311207034@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627598108;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=0EFERMseOgGp4ED8VGrniueRywqbBbmEkuB4rNqG78M=;
        b=iK0/YPv7B6vrRwygNr/aWJnd4VVkL1ZKn2kQxcI/dQnLtz4ft5VuCOlaqUc0kIiEGBJBBN
        GugXI1BpHhXUee/zOtQ3QYIkQtoADzIgpO66fLYCUXA99uL/eVGkBU8+FjaNVFSDh90xOx
        ttbd4eCIlG4LzZPnOdODCjUZEAUmpm+A5ttd92ox6GYtcI6rILn2yd0kYasy8M2/MzGZlQ
        dfb4A1+oNObxX+o9RjZR7UwxskIYDhgotxxjBsMZqaUjFq4GsXZMIsJSGzhxRk56UP4dbb
        G+YAA0m5fmB2uw21y2YeLNLkVrTZio7gl7BtTbjZmL4b7s52vrzu9mgn4SGYXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627598108;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=0EFERMseOgGp4ED8VGrniueRywqbBbmEkuB4rNqG78M=;
        b=rAEPIoE0COfVWKBOWFxx8T9/cGARQwv/RBsWXCm3fq8hcG1iXWzNzYxnWm4W/QkhcApOdC
        uLZsHfb3XCaAhiCA==
Date:   Thu, 29 Jul 2021 23:51:58 +0200
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
Subject: [patch V2 19/19] PCI/MSI: Use new mask/unmask functions
References: <20210729215139.889204656@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Switch the PCI/MSI core to use the new mask/unmask functions. No functional
change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: New patch
---
 drivers/pci/msi.c |  102 +++++++++++-------------------------------------------
 1 file changed, 21 insertions(+), 81 deletions(-)

--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -135,74 +135,6 @@ void __weak arch_restore_msi_irqs(struct
  * reliably as devices without an INTx disable bit will then generate a
  * level IRQ which will never be cleared.
  */
-static void __pci_msi_desc_mask_irq(struct msi_desc *desc, u32 mask, u32 flag)
-{
-	raw_spinlock_t *lock = &desc->dev->msi_lock;
-	unsigned long flags;
-
-	if (pci_msi_ignore_mask || !desc->msi_attrib.maskbit)
-		return;
-
-	raw_spin_lock_irqsave(lock, flags);
-	desc->msi_mask &= ~mask;
-	desc->msi_mask |= flag;
-	pci_write_config_dword(msi_desc_to_pci_dev(desc), desc->mask_pos,
-			       desc->msi_mask);
-	raw_spin_unlock_irqrestore(lock, flags);
-}
-
-static void msi_mask_irq(struct msi_desc *desc, u32 mask, u32 flag)
-{
-	__pci_msi_desc_mask_irq(desc, mask, flag);
-}
-
-static void __iomem *pci_msix_desc_addr(struct msi_desc *desc)
-{
-	return desc->mask_base + desc->msi_attrib.entry_nr * PCI_MSIX_ENTRY_SIZE;
-}
-
-/*
- * This internal function does not flush PCI writes to the device.
- * All users must ensure that they read from the device before either
- * assuming that the device state is up to date, or returning out of this
- * file.  This saves a few milliseconds when initialising devices with lots
- * of MSI-X interrupts.
- */
-static u32 __pci_msix_desc_mask_irq(struct msi_desc *desc, u32 flag)
-{
-	void __iomem *desc_addr = pci_msix_desc_addr(desc);
-	u32 ctrl = desc->msix_ctrl;
-
-	if (pci_msi_ignore_mask || desc->msi_attrib.is_virtual)
-		return 0;
-
-	ctrl &= ~PCI_MSIX_ENTRY_CTRL_MASKBIT;
-	if (ctrl & PCI_MSIX_ENTRY_CTRL_MASKBIT)
-		ctrl |= PCI_MSIX_ENTRY_CTRL_MASKBIT;
-
-	writel(ctrl, desc_addr + PCI_MSIX_ENTRY_VECTOR_CTRL);
-
-	return ctrl;
-}
-
-static void msix_mask_irq(struct msi_desc *desc, u32 flag)
-{
-	desc->msix_ctrl = __pci_msix_desc_mask_irq(desc, flag);
-}
-
-static void msi_set_mask_bit(struct irq_data *data, u32 flag)
-{
-	struct msi_desc *desc = irq_data_get_msi_desc(data);
-
-	if (desc->msi_attrib.is_msix) {
-		msix_mask_irq(desc, flag);
-		readl(desc->mask_base);		/* Flush write to device */
-	} else {
-		unsigned offset = data->irq - desc->irq;
-		msi_mask_irq(desc, 1 << offset, flag << offset);
-	}
-}
-
 static inline __attribute_const__ u32 msi_multi_mask(struct msi_desc *desc)
 {
 	/* Don't shift by >= width of type */
@@ -234,6 +166,11 @@ static inline void pci_msi_unmask(struct
 	pci_msi_update_mask(desc, mask, 0);
 }
 
+static inline void __iomem *pci_msix_desc_addr(struct msi_desc *desc)
+{
+	return desc->mask_base + desc->msi_attrib.entry_nr * PCI_MSIX_ENTRY_SIZE;
+}
+
 /*
  * This internal function does not flush PCI writes to the device.  All
  * users must ensure that they read from the device before either assuming
@@ -289,7 +226,9 @@ static void __pci_msi_unmask_desc(struct
  */
 void pci_msi_mask_irq(struct irq_data *data)
 {
-	msi_set_mask_bit(data, 1);
+	struct msi_desc *desc = irq_data_get_msi_desc(data);
+
+	__pci_msi_mask_desc(desc, BIT(data->irq - desc->irq));
 }
 EXPORT_SYMBOL_GPL(pci_msi_mask_irq);
 
@@ -299,7 +238,9 @@ EXPORT_SYMBOL_GPL(pci_msi_mask_irq);
  */
 void pci_msi_unmask_irq(struct irq_data *data)
 {
-	msi_set_mask_bit(data, 0);
+	struct msi_desc *desc = irq_data_get_msi_desc(data);
+
+	__pci_msi_unmask_desc(desc, BIT(data->irq - desc->irq));
 }
 EXPORT_SYMBOL_GPL(pci_msi_unmask_irq);
 
@@ -352,7 +293,8 @@ void __pci_write_msi_msg(struct msi_desc
 		/* Don't touch the hardware now */
 	} else if (entry->msi_attrib.is_msix) {
 		void __iomem *base = pci_msix_desc_addr(entry);
-		bool unmasked = !(entry->msix_ctrl & PCI_MSIX_ENTRY_CTRL_MASKBIT);
+		u32 ctrl = entry->msix_ctrl;
+		bool unmasked = !(ctrl & PCI_MSIX_ENTRY_CTRL_MASKBIT);
 
 		if (entry->msi_attrib.is_virtual)
 			goto skip;
@@ -366,14 +308,14 @@ void __pci_write_msi_msg(struct msi_desc
 		 * undefined."
 		 */
 		if (unmasked)
-			__pci_msix_desc_mask_irq(entry, PCI_MSIX_ENTRY_CTRL_MASKBIT);
+			pci_msix_write_vector_ctrl(entry, ctrl | PCI_MSIX_ENTRY_CTRL_MASKBIT);
 
 		writel(msg->address_lo, base + PCI_MSIX_ENTRY_LOWER_ADDR);
 		writel(msg->address_hi, base + PCI_MSIX_ENTRY_UPPER_ADDR);
 		writel(msg->data, base + PCI_MSIX_ENTRY_DATA);
 
 		if (unmasked)
-			__pci_msix_desc_mask_irq(entry, 0);
+			pci_msix_write_vector_ctrl(entry, ctrl);
 
 		/* Ensure that the writes are visible in the device */
 		readl(base + PCI_MSIX_ENTRY_DATA);
@@ -491,7 +433,7 @@ static void __pci_restore_msi_state(stru
 	arch_restore_msi_irqs(dev);
 
 	pci_read_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, &control);
-	msi_mask_irq(entry, msi_multi_mask(entry), entry->msi_mask);
+	pci_msi_update_mask(entry, 0, 0);
 	control &= ~PCI_MSI_FLAGS_QSIZE;
 	control |= (entry->msi_attrib.multiple << 4) | PCI_MSI_FLAGS_ENABLE;
 	pci_write_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, control);
@@ -522,7 +464,7 @@ static void __pci_restore_msix_state(str
 
 	arch_restore_msi_irqs(dev);
 	for_each_pci_msi_entry(entry, dev)
-		msix_mask_irq(entry, entry->msix_ctrl);
+		pci_msix_write_vector_ctrl(entry, entry->msix_ctrl);
 
 	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_MASKALL, 0);
 }
@@ -704,7 +646,6 @@ static int msi_capability_init(struct pc
 {
 	struct msi_desc *entry;
 	int ret;
-	unsigned mask;
 
 	pci_msi_set_enable(dev, 0);	/* Disable MSI during set up */
 
@@ -713,8 +654,7 @@ static int msi_capability_init(struct pc
 		return -ENOMEM;
 
 	/* All MSIs are unmasked by default; mask them all */
-	mask = msi_multi_mask(entry);
-	msi_mask_irq(entry, mask, mask);
+	pci_msi_mask(entry, msi_multi_mask(entry));
 
 	list_add_tail(&entry->list, dev_to_msi_list(&dev->dev));
 
@@ -741,7 +681,7 @@ static int msi_capability_init(struct pc
 	return 0;
 
 err:
-	msi_mask_irq(entry, mask, 0);
+	pci_msi_unmask(entry, msi_multi_mask(entry));
 	free_msi_irqs(dev);
 	return ret;
 }
@@ -1021,7 +961,7 @@ static void pci_msi_shutdown(struct pci_
 	dev->msi_enabled = 0;
 
 	/* Return the device with MSI unmasked as initial states */
-	msi_mask_irq(desc, msi_multi_mask(desc), 0);
+	pci_msi_unmask(desc, msi_multi_mask(desc));
 
 	/* Restore dev->irq to its default pin-assertion IRQ */
 	dev->irq = desc->msi_attrib.default_irq;
@@ -1107,7 +1047,7 @@ static void pci_msix_shutdown(struct pci
 
 	/* Return the device with MSI-X masked as initial states */
 	for_each_pci_msi_entry(entry, dev)
-		__pci_msix_desc_mask_irq(entry, 1);
+		pci_msix_mask(entry);
 
 	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_ENABLE, 0);
 	pci_intx_for_msi(dev, 1);

