Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 299213DAF15
	for <lists+linux-pci@lfdr.de>; Fri, 30 Jul 2021 00:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233398AbhG2WfS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Jul 2021 18:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234019AbhG2WfF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Jul 2021 18:35:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F737C0613C1;
        Thu, 29 Jul 2021 15:34:59 -0700 (PDT)
Message-ID: <20210729222542.939798136@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627598097;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=CWkvWsXP5joIr9x9FuJs2oTkmXN95ZjHWWuJ4EOrAb8=;
        b=s9d9Sv36yjh+ZyH5u1+2vJjlLuzSVEkLPeHehuLMcaLGsAG4kObUXNsC+HYP0c+J8mZtos
        1+3e/Rz1y9dCe6OkZEdt2LOJd/DibOTe1Ai1s1HkIgnsAPPuG+E0FlvQHeXQC7Jnz4vylE
        3AGFrD7LPSJ5EPndTbmVGK+2/URCzIOtgH8B0QkRv8qLK++ZI7xbYCcEayCykZtcAw12Hw
        9/wr2r44spFddD0AUCryMEnUbDBtFkQEvNl+UFq4axmA5OPvi0f5IiphHFasXcXRFRWrie
        slt1FXp8S8kfQsNFj+A5ckJICQvUaIepXS0FKweYef/SUErFSPb97kp+8pTRHA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627598097;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=CWkvWsXP5joIr9x9FuJs2oTkmXN95ZjHWWuJ4EOrAb8=;
        b=LcaC8YufCcyzSpzgXf8ckLkdHBg7VCGyzq3yNglxvdlgVUQ7XjyMHSR+JN6YmlXX32UvCn
        HCoph775bw9w06Cg==
Date:   Thu, 29 Jul 2021 23:51:51 +0200
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
Subject: [patch V2 12/19] s390/pci: Do not mask MSI[-X] entries on teardown
References: <20210729215139.889204656@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The PCI core already ensures that the MSI[-X] state is correct when MSI[-X]
is disabled. For MSI the reset state is all entries unmasked and for MSI-X
all vectors are masked.

S390 masks all MSI entries and masks the already masked MSI-X entries
again. Remove it and let the device in the correct state.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-s390@vger.kernel.org
Cc: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/pci/pci_irq.c |    4 ----
 drivers/pci/msi.c       |    4 ++--
 include/linux/msi.h     |    2 --
 3 files changed, 2 insertions(+), 8 deletions(-)

--- a/arch/s390/pci/pci_irq.c
+++ b/arch/s390/pci/pci_irq.c
@@ -365,10 +365,6 @@ void arch_teardown_msi_irqs(struct pci_d
 	for_each_pci_msi_entry(msi, pdev) {
 		if (!msi->irq)
 			continue;
-		if (msi->msi_attrib.is_msix)
-			__pci_msix_desc_mask_irq(msi, 1);
-		else
-			__pci_msi_desc_mask_irq(msi, 1, 1);
 		irq_set_msi_desc(msi->irq, NULL);
 		irq_free_desc(msi->irq);
 		msi->msg.address_lo = 0;
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -143,7 +143,7 @@ static inline __attribute_const__ u32 ms
  * reliably as devices without an INTx disable bit will then generate a
  * level IRQ which will never be cleared.
  */
-void __pci_msi_desc_mask_irq(struct msi_desc *desc, u32 mask, u32 flag)
+static void __pci_msi_desc_mask_irq(struct msi_desc *desc, u32 mask, u32 flag)
 {
 	raw_spinlock_t *lock = &desc->dev->msi_lock;
 	unsigned long flags;
@@ -180,7 +180,7 @@ static void __iomem *pci_msix_desc_addr(
  * file.  This saves a few milliseconds when initialising devices with lots
  * of MSI-X interrupts.
  */
-u32 __pci_msix_desc_mask_irq(struct msi_desc *desc, u32 flag)
+static u32 __pci_msix_desc_mask_irq(struct msi_desc *desc, u32 flag)
 {
 	u32 mask_bits = desc->masked;
 	void __iomem *desc_addr;
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -232,8 +232,6 @@ void free_msi_entry(struct msi_desc *ent
 void __pci_read_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
 void __pci_write_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
 
-u32 __pci_msix_desc_mask_irq(struct msi_desc *desc, u32 flag);
-void __pci_msi_desc_mask_irq(struct msi_desc *desc, u32 mask, u32 flag);
 void pci_msi_mask_irq(struct irq_data *data);
 void pci_msi_unmask_irq(struct irq_data *data);
 

