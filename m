Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA32746AD74
	for <lists+linux-pci@lfdr.de>; Mon,  6 Dec 2021 23:51:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376374AbhLFWzZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Dec 2021 17:55:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359125AbhLFWys (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Dec 2021 17:54:48 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC01C061359;
        Mon,  6 Dec 2021 14:51:18 -0800 (PST)
Message-ID: <20211206210748.089085131@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638831077;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=O192gTv7DVMCmoiFcAQ4tyGbPvViDQQz5Lq/A3dCGdU=;
        b=yAGXeCWb/MLSFOWdyqn+f3X7iRs0IbPpmDQ2LDClgWe2kyw40xFdfg87fcMA3GSkbXdpRp
        P4jKMgelmsbNP+ajv6QuUI/YvPD46YfxdK/tIkaJKr7oJKF88KyOGJA/Eg9ozHpz5UyDs+
        X2UpRnC2ETnBVHswRo5ju3uaspL1Hr8L2VEKC/WMii0ILQ1aJmADFWDY+tKFUqX+W5sS7+
        JLHMYFCndpVQwB1ty7SXBw0CRNc3HOmjKE1mpn3ehsl0bA/07CL8htyJb/5ZrAZjVo5nf7
        BWLZh62Sv60QedOoRKVKKhpCTkQF6rUQzyYh2zRmZFcoScESSB7zYoCJNupn4Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638831077;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=O192gTv7DVMCmoiFcAQ4tyGbPvViDQQz5Lq/A3dCGdU=;
        b=LOPeM1wwdBLryYGVoFatNH/lCkc91JRDEBARe01ZXRbr1hoNxRJB3rT3CyT0HQcyqz5EUa
        dcAfNimcrSAi4SCA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
        Cedric Le Goater <clg@kaod.org>,
        xen-devel@lists.xenproject.org, Juergen Gross <jgross@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com
Subject: [patch V2 09/31] PCI/MSI: Let core code free MSI descriptors
References: <20211206210600.123171746@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon,  6 Dec 2021 23:51:16 +0100 (CET)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Set the domain info flag which tells the core code to free the MSI
descriptors from msi_domain_free_irqs() and add an explicit call to the
core function into the legacy code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/pci/msi/irqdomain.c |    3 ++-
 drivers/pci/msi/legacy.c    |    1 +
 drivers/pci/msi/msi.c       |   14 --------------
 3 files changed, 3 insertions(+), 15 deletions(-)

--- a/drivers/pci/msi/irqdomain.c
+++ b/drivers/pci/msi/irqdomain.c
@@ -171,7 +171,8 @@ struct irq_domain *pci_msi_create_irq_do
 	if (info->flags & MSI_FLAG_USE_DEF_CHIP_OPS)
 		pci_msi_domain_update_chip_ops(info);
 
-	info->flags |= MSI_FLAG_ACTIVATE_EARLY | MSI_FLAG_DEV_SYSFS;
+	info->flags |= MSI_FLAG_ACTIVATE_EARLY | MSI_FLAG_DEV_SYSFS |
+		       MSI_FLAG_FREE_MSI_DESCS;
 	if (IS_ENABLED(CONFIG_GENERIC_IRQ_RESERVATION_MODE))
 		info->flags |= MSI_FLAG_MUST_REACTIVATE;
 
--- a/drivers/pci/msi/legacy.c
+++ b/drivers/pci/msi/legacy.c
@@ -80,4 +80,5 @@ void pci_msi_legacy_teardown_msi_irqs(st
 {
 	msi_device_destroy_sysfs(&dev->dev);
 	arch_teardown_msi_irqs(dev);
+	msi_free_msi_descs(&dev->dev);
 }
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -224,22 +224,8 @@ EXPORT_SYMBOL_GPL(pci_write_msi_msg);
 
 static void free_msi_irqs(struct pci_dev *dev)
 {
-	struct list_head *msi_list = dev_to_msi_list(&dev->dev);
-	struct msi_desc *entry, *tmp;
-	int i;
-
-	for_each_pci_msi_entry(entry, dev)
-		if (entry->irq)
-			for (i = 0; i < entry->nvec_used; i++)
-				BUG_ON(irq_has_action(entry->irq + i));
-
 	pci_msi_teardown_msi_irqs(dev);
 
-	list_for_each_entry_safe(entry, tmp, msi_list, list) {
-		list_del(&entry->list);
-		free_msi_entry(entry);
-	}
-
 	if (dev->msix_base) {
 		iounmap(dev->msix_base);
 		dev->msix_base = NULL;

