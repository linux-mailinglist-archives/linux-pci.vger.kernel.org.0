Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21B713E4CB7
	for <lists+linux-pci@lfdr.de>; Mon,  9 Aug 2021 21:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235534AbhHITJV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Aug 2021 15:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235246AbhHITJU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Aug 2021 15:09:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C83C0613D3;
        Mon,  9 Aug 2021 12:08:59 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628536137;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T8lZvCBC4BJtqq7gmWPpIICgtsJkk/6DHIBoJxOGCLA=;
        b=V6w49RF5XmlZuFvmbp8rjmO7kZiKyWJ4FIOSVhKfFM3L7t4SpNG3vboiWJLqvyFfJ2InLY
        9c/JITzJ2C815fUKIZqMuwB7jVpMXdTKSf18I0K6VAKbKNWQRBcNZ+u3qLA46MM+F6zIy+
        Rd4UXfpeeXCbm8oV02ubrMT3cQ8co7swWzFnPmPM/3bx6GB/RkhA5RvdRCSP4EqCIkp0YR
        LOGE+bD5YNUrEkXckbJxHvhCddNaEziwF3AsK3u1XCyryD9UNGMKLsfxMSW/4phykPyH/L
        zN8Z+1SQTTLoNaZyGre5jLZPexa7vWl/6Y96Mk9JQ0jN/VETe3XCQaeonEr75Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628536137;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T8lZvCBC4BJtqq7gmWPpIICgtsJkk/6DHIBoJxOGCLA=;
        b=L/eKjXJjdZQIRZYYcT6i/YVwPum+UPbi93UJrmJAReG3o85rpXbc9XPEzSvmNZ8sVHiBCJ
        GDGO1lYW+wzHvrBg==
To:     Marc Zyngier <maz@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Kevin Tian <kevin.tian@intel.com>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-s390@vger.kernel.org,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [patch V3 18/19] PCI/MSI: Provide a new set of mask and unmask
 functions
In-Reply-To: <878s1atpjz.ffs@tglx>
References: <20210729215139.889204656@linutronix.de>
 <20210729222543.257079238@linutronix.de> <87r1f6bpt7.wl-maz@kernel.org>
 <878s1atpjz.ffs@tglx>
Date:   Mon, 09 Aug 2021 21:08:56 +0200
Message-ID: <875ywetozb.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The existing mask/unmask functions are convoluted and generate suboptimal
assembly code.

Provide a new set of functions which will be used in later patches to
replace the exisiting ones.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20210729222543.257079238@linutronix.de

---
V3: Check maskbit when masking (Marc)
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
+	else if (desc->msi_attrib.maskbit)
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
+	else if (desc->msi_attrib.maskbit)
+		pci_msi_unmask(desc, mask);
+}
+
 /**
  * pci_msi_mask_irq - Generic IRQ chip callback to mask PCI/MSI interrupts
  * @data:	pointer to irqdata associated to that interrupt
