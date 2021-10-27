Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 631CF43C6D3
	for <lists+linux-pci@lfdr.de>; Wed, 27 Oct 2021 11:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238819AbhJ0Jwv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Oct 2021 05:52:51 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39566 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241289AbhJ0Jwm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Oct 2021 05:52:42 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635328216;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R6HIFHpD6EcdYz7reZvQoCoHmuw7azptYwwiCQ/462A=;
        b=s5FI1XoOJnu3DWuAjQT9oMfvwzWnRyRjqgbREBvPHSIdBxd0Tt+btuL3eWpbAHJEozHQsk
        5oCeOrUnC+GxJoz1NRwzZH+i1MZY6KRc2nQGeBTLsU3EM8o8CZuzcTOXMbfT52+uNpWHGU
        Zgn6VpT6KcNwYUvI7fevXm3Vx6GN7MlDitE+tAgok6ewuZFw1p+pHFWiBL0KHIbKVZg+wf
        XD1CHUPGEdgjwjEWii5/dUOLU/J/iPlQu671Oa5R2pnRfyKQFlsn0+qMyx0z6ta+zOxUyv
        ou54HCFpyd0hHUYIQPStT6lolTkFfUHIROMiikYNn2hRe9+kx+oRWTUN5BCTFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635328216;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R6HIFHpD6EcdYz7reZvQoCoHmuw7azptYwwiCQ/462A=;
        b=GjeNq8UVPat0Fum4HvNLZzqlAOxC37IV1okHyikLt5oTECPz45x+VmPxYQRujP+BrJq/eZ
        Zxp766A3FFhkeSCQ==
To:     Jason Andryuk <jandryuk@gmail.com>, josef@oderland.se
Cc:     boris.ostrovsky@oracle.com, helgaas@kernel.org, jandryuk@gmail.com,
        jgross@suse.com, linux-pci@vger.kernel.org, maz@kernel.org,
        xen-devel@lists.xenproject.org,
        David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH] PCI/MSI: Move non-mask check back into low level accessors
In-Reply-To: <87fssmg8k4.ffs@tglx>
References: <90277228-cf14-0cfa-c95e-d42e7d533353@oderland.se>
 <20211025012503.33172-1-jandryuk@gmail.com> <87fssmg8k4.ffs@tglx>
Date:   Wed, 27 Oct 2021 11:50:15 +0200
Message-ID: <87cznqg5k8.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The recent rework of PCI/MSI[X] masking moved the non-mask checks from the
low level accessors into the higher level mask/unmask functions.

This missed the fact that these accessors can be invoked from other places
as well. The missing checks break XEN-PV which sets pci_msi_ignore_mask and
also violates the virtual MSIX and the msi_attrib.maskbit protections.

Instead of sprinkling checks all over the place, lift them back into the
low level accessor functions. To avoid checking three different conditions
combine them into one property of msi_desc::msi_attrib.

Reported-by: Josef Johansson <josef@oderland.se>
Fixes: fcacdfbef5a1 ("PCI/MSI: Provide a new set of mask and unmask functions")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Andryuk <jandryuk@gmail.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Cc: xen-devel <xen-devel@lists.xenproject.org>
Cc: Juergen Gross <jgross@suse.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: David Woodhouse <dwmw2@infradead.org>
---
 drivers/pci/msi.c   |   26 ++++++++++++++------------
 include/linux/msi.h |    2 +-
 2 files changed, 15 insertions(+), 13 deletions(-)

--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -148,6 +148,9 @@ static noinline void pci_msi_update_mask
 	raw_spinlock_t *lock = &desc->dev->msi_lock;
 	unsigned long flags;
 
+	if (!desc->msi_attrib.can_mask)
+		return;
+
 	raw_spin_lock_irqsave(lock, flags);
 	desc->msi_mask &= ~clear;
 	desc->msi_mask |= set;
@@ -181,7 +184,8 @@ static void pci_msix_write_vector_ctrl(s
 {
 	void __iomem *desc_addr = pci_msix_desc_addr(desc);
 
-	writel(ctrl, desc_addr + PCI_MSIX_ENTRY_VECTOR_CTRL);
+	if (desc->msi_attrib.can_mask)
+		writel(ctrl, desc_addr + PCI_MSIX_ENTRY_VECTOR_CTRL);
 }
 
 static inline void pci_msix_mask(struct msi_desc *desc)
@@ -200,23 +204,17 @@ static inline void pci_msix_unmask(struc
 
 static void __pci_msi_mask_desc(struct msi_desc *desc, u32 mask)
 {
-	if (pci_msi_ignore_mask || desc->msi_attrib.is_virtual)
-		return;
-
 	if (desc->msi_attrib.is_msix)
 		pci_msix_mask(desc);
-	else if (desc->msi_attrib.maskbit)
+	else
 		pci_msi_mask(desc, mask);
 }
 
 static void __pci_msi_unmask_desc(struct msi_desc *desc, u32 mask)
 {
-	if (pci_msi_ignore_mask || desc->msi_attrib.is_virtual)
-		return;
-
 	if (desc->msi_attrib.is_msix)
 		pci_msix_unmask(desc);
-	else if (desc->msi_attrib.maskbit)
+	else
 		pci_msi_unmask(desc, mask);
 }
 
@@ -484,7 +482,8 @@ msi_setup_entry(struct pci_dev *dev, int
 	entry->msi_attrib.is_64		= !!(control & PCI_MSI_FLAGS_64BIT);
 	entry->msi_attrib.is_virtual    = 0;
 	entry->msi_attrib.entry_nr	= 0;
-	entry->msi_attrib.maskbit	= !!(control & PCI_MSI_FLAGS_MASKBIT);
+	entry->msi_attrib.can_mask	= !pci_msi_ignore_mask &&
+					  !!(control & PCI_MSI_FLAGS_MASKBIT);
 	entry->msi_attrib.default_irq	= dev->irq;	/* Save IOAPIC IRQ */
 	entry->msi_attrib.multi_cap	= (control & PCI_MSI_FLAGS_QMASK) >> 1;
 	entry->msi_attrib.multiple	= ilog2(__roundup_pow_of_two(nvec));
@@ -495,7 +494,7 @@ msi_setup_entry(struct pci_dev *dev, int
 		entry->mask_pos = dev->msi_cap + PCI_MSI_MASK_32;
 
 	/* Save the initial mask status */
-	if (entry->msi_attrib.maskbit)
+	if (entry->msi_attrib.can_mask)
 		pci_read_config_dword(dev, entry->mask_pos, &entry->msi_mask);
 
 out:
@@ -638,10 +637,13 @@ static int msix_setup_entries(struct pci
 		entry->msi_attrib.is_virtual =
 			entry->msi_attrib.entry_nr >= vec_count;
 
+		entry->msi_attrib.can_mask	= !pci_msi_ignore_mask &&
+						  !entry->msi_attrib.is_virtual;
+
 		entry->msi_attrib.default_irq	= dev->irq;
 		entry->mask_base		= base;
 
-		if (!entry->msi_attrib.is_virtual) {
+		if (!entry->msi_attrib.can_mask) {
 			addr = pci_msix_desc_addr(entry);
 			entry->msix_ctrl = readl(addr + PCI_MSIX_ENTRY_VECTOR_CTRL);
 		}
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -148,7 +148,7 @@ struct msi_desc {
 				u8	is_msix		: 1;
 				u8	multiple	: 3;
 				u8	multi_cap	: 3;
-				u8	maskbit		: 1;
+				u8	can_mask	: 1;
 				u8	is_64		: 1;
 				u8	is_virtual	: 1;
 				u16	entry_nr;
