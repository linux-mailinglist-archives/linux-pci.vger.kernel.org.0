Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48DBB3DAF25
	for <lists+linux-pci@lfdr.de>; Fri, 30 Jul 2021 00:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234819AbhG2Wfu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Jul 2021 18:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234449AbhG2WfM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Jul 2021 18:35:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F30ECC06179E;
        Thu, 29 Jul 2021 15:35:08 -0700 (PDT)
Message-ID: <20210729222543.257079238@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627598107;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=qCOSKfEnl3o4/mZfiuDpWaLIrkNMwSoGIlOo9G4CfEE=;
        b=YbzP5MrRXs1pMhsPQrfSBxalc/mCCCJnrFrY22Zhg5CqXFXtjQX42T9rLthXL0zTb/m3A2
        4s+X188gD48e3u42Km39KjwsntsGurGCgnY8tLIdbRI79T042bLGaF8jKVuvtOJJbRhHeU
        h63gNh+jDPaHN52tQmPRCIYJa97VkGMakDnq3kDzvZaTJVqideMtMbafrt7fhnGbrdUvy4
        bsq7O1ZtyFmWLofnhPcoRKqCXE6ZzXMAt2sswRS6xYkU0h12efgLroVqq1jchTVk4V3d6z
        FZc53M8DXQ0pcqVlEQVQYw6gJfps4SCSCpHdAxJULLmsPoRD4z0/Ua0lu74dww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627598107;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=qCOSKfEnl3o4/mZfiuDpWaLIrkNMwSoGIlOo9G4CfEE=;
        b=3LHWmLNrasrWI5g7TAO4i8R1vj9nIw0rSzMKCNKf7KD/DC6bl9itmjLN13QMOfgUa9HrM6
        iudZJmtq19TM3GBQ==
Date:   Thu, 29 Jul 2021 23:51:57 +0200
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
Subject: [patch V2 18/19] PCI/MSI: Provide a new set of mask and unmask functions
References: <20210729215139.889204656@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The existing mask/unmask functions are convoluted and generate suboptimal
assembly code.

Provide a new set of functions which will be used in later patches to
replace the exisiting ones.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: New patch
---
 drivers/pci/msi.c |   72 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -211,6 +211,78 @@ static inline __attribute_const__ u32 ms
 	return (1 << (1 << desc->msi_attrib.multi_cap)) - 1;
 }
 
+static noinline void pci_msi_update_mask(struct msi_desc *desc, u32 clear, u32 set)
+{
+	raw_spinlock_t *lock = &desc->dev->msi_lock;
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(lock, flags);
+	desc->msi_mask &= ~clear;
+	desc->msi_mask |= set;
+	pci_write_config_dword(msi_desc_to_pci_dev(desc), desc->mask_pos,
+			       desc->msi_mask);
+	raw_spin_unlock_irqrestore(lock, flags);
+}
+
+static inline void pci_msi_mask(struct msi_desc *desc, u32 mask)
+{
+	pci_msi_update_mask(desc, 0, mask);
+}
+
+static inline void pci_msi_unmask(struct msi_desc *desc, u32 mask)
+{
+	pci_msi_update_mask(desc, mask, 0);
+}
+
+/*
+ * This internal function does not flush PCI writes to the device.  All
+ * users must ensure that they read from the device before either assuming
+ * that the device state is up to date, or returning out of this file.
+ * It does not affect the msi_desc::msix_ctrl cache either. Use with care!
+ */
+static void pci_msix_write_vector_ctrl(struct msi_desc *desc, u32 ctrl)
+{
+	void __iomem *desc_addr = pci_msix_desc_addr(desc);
+
+	writel(ctrl, desc_addr + PCI_MSIX_ENTRY_VECTOR_CTRL);
+}
+
+static inline void pci_msix_mask(struct msi_desc *desc)
+{
+	desc->msix_ctrl |= PCI_MSIX_ENTRY_CTRL_MASKBIT;
+	pci_msix_write_vector_ctrl(desc, desc->msix_ctrl);
+	/* Flush write to device */
+	readl(desc->mask_base);
+}
+
+static inline void pci_msix_unmask(struct msi_desc *desc)
+{
+	desc->msix_ctrl &= ~PCI_MSIX_ENTRY_CTRL_MASKBIT;
+	pci_msix_write_vector_ctrl(desc, desc->msix_ctrl);
+}
+
+static void __pci_msi_mask_desc(struct msi_desc *desc, u32 mask)
+{
+	if (pci_msi_ignore_mask || desc->msi_attrib.is_virtual)
+		return;
+
+	if (desc->msi_attrib.is_msix)
+		pci_msix_mask(desc);
+	else if (!desc->msi_attrib.maskbit)
+		pci_msi_mask(desc, mask);
+}
+
+static void __pci_msi_unmask_desc(struct msi_desc *desc, u32 mask)
+{
+	if (pci_msi_ignore_mask || desc->msi_attrib.is_virtual)
+		return;
+
+	if (desc->msi_attrib.is_msix)
+		pci_msix_unmask(desc);
+	else if (!desc->msi_attrib.maskbit)
+		pci_msi_unmask(desc, mask);
+}
+
 /**
  * pci_msi_mask_irq - Generic IRQ chip callback to mask PCI/MSI interrupts
  * @data:	pointer to irqdata associated to that interrupt

