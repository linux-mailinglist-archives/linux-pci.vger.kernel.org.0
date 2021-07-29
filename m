Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 809EE3DAF18
	for <lists+linux-pci@lfdr.de>; Fri, 30 Jul 2021 00:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234812AbhG2WfW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Jul 2021 18:35:22 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49312 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233789AbhG2WfK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Jul 2021 18:35:10 -0400
Message-ID: <20210729222543.203905260@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627598105;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=uZuaut2JpvGfn2gpCKX+rCbymLOSgSIekmfYPWe2CMk=;
        b=nqOaLIUOaTou1DdTA5UvWBfb6j3F1E4jjCsClod7GaYzSXZ4LA/RTex8nTet6F44vLEoPi
        P/wrf2wzvGC6kTvQO5rkJJl/kVPeuqhGHeBMORRTYYffUaVF6z9FALexoQo1Tpc+IXPNi6
        lOFgbKV7fSj4cvLAfqUy0zClZk3Z49K6o62bIaRsyiQOQbs71sAQfEf5tSrRct7umuDii8
        QfAXTpiptOzUFqOSL9SYWacCITKpmjIcWsQp/dBeVBhvnrOWXpNSn74YVuFugN+ElhkbKN
        uoJinNE56XZ6srDKlBLuU/XEt0FrJfh2giY/AXAgy+oNyLgTsLVIqD1DZuj3Gg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627598105;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=uZuaut2JpvGfn2gpCKX+rCbymLOSgSIekmfYPWe2CMk=;
        b=QlTuqPb25LezbZyhxPwNdR0kY61X5X2sJJGk373lsnIIUq02gvWjIcWoq38Ge2Yke+qGCq
        3Mf6AI2iHqpBJbBg==
Date:   Thu, 29 Jul 2021 23:51:56 +0200
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
Subject: [patch V2 17/19] PCI/MSI: Cleanup msi_mask()
References: <20210729215139.889204656@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

msi_mask() is calculating the possible mask bits for MSI per vector
masking.

Rename it to msi_multi_mask() and hand the MSI descriptor pointer into it
to simplify the call sites.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: New patch
---
 drivers/pci/msi.c |   25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -129,14 +129,6 @@ void __weak arch_restore_msi_irqs(struct
 	return default_restore_msi_irqs(dev);
 }
 
-static inline __attribute_const__ u32 msi_mask(unsigned x)
-{
-	/* Don't shift by >= width of type */
-	if (x >= 5)
-		return 0xffffffff;
-	return (1 << (1 << x)) - 1;
-}
-
 /*
  * PCI 2.3 does not specify mask bits for each MSI interrupt.  Attempting to
  * mask all MSI interrupts by clearing the MSI enable bit does not work
@@ -211,6 +203,14 @@ static void msi_set_mask_bit(struct irq_
 	}
 }
 
+static inline __attribute_const__ u32 msi_multi_mask(struct msi_desc *desc)
+{
+	/* Don't shift by >= width of type */
+	if (desc->msi_attrib.multi_cap >= 5)
+		return 0xffffffff;
+	return (1 << (1 << desc->msi_attrib.multi_cap)) - 1;
+}
+
 /**
  * pci_msi_mask_irq - Generic IRQ chip callback to mask PCI/MSI interrupts
  * @data:	pointer to irqdata associated to that interrupt
@@ -419,8 +419,7 @@ static void __pci_restore_msi_state(stru
 	arch_restore_msi_irqs(dev);
 
 	pci_read_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, &control);
-	msi_mask_irq(entry, msi_mask(entry->msi_attrib.multi_cap),
-		     entry->msi_mask);
+	msi_mask_irq(entry, msi_multi_mask(entry), entry->msi_mask);
 	control &= ~PCI_MSI_FLAGS_QSIZE;
 	control |= (entry->msi_attrib.multiple << 4) | PCI_MSI_FLAGS_ENABLE;
 	pci_write_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, control);
@@ -642,7 +641,7 @@ static int msi_capability_init(struct pc
 		return -ENOMEM;
 
 	/* All MSIs are unmasked by default; mask them all */
-	mask = msi_mask(entry->msi_attrib.multi_cap);
+	mask = msi_multi_mask(entry);
 	msi_mask_irq(entry, mask, mask);
 
 	list_add_tail(&entry->list, dev_to_msi_list(&dev->dev));
@@ -938,7 +937,6 @@ EXPORT_SYMBOL(pci_msi_vec_count);
 static void pci_msi_shutdown(struct pci_dev *dev)
 {
 	struct msi_desc *desc;
-	u32 mask;
 
 	if (!pci_msi_enable || !dev || !dev->msi_enabled)
 		return;
@@ -951,8 +949,7 @@ static void pci_msi_shutdown(struct pci_
 	dev->msi_enabled = 0;
 
 	/* Return the device with MSI unmasked as initial states */
-	mask = msi_mask(desc->msi_attrib.multi_cap);
-	msi_mask_irq(desc, mask, 0);
+	msi_mask_irq(desc, msi_multi_mask(desc), 0);
 
 	/* Restore dev->irq to its default pin-assertion IRQ */
 	dev->irq = desc->msi_attrib.default_irq;

