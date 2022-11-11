Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7073625BC9
	for <lists+linux-pci@lfdr.de>; Fri, 11 Nov 2022 14:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233870AbiKKN5E (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 08:57:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233678AbiKKN4F (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 08:56:05 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB7A2B25B;
        Fri, 11 Nov 2022 05:55:00 -0800 (PST)
Message-ID: <20221111122015.156785224@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668174898;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=sTSauIHtQe8nkxj9vWG7an7hER/OZbQ0yiXscxhOHpY=;
        b=GCdtHiG1mb1fVSYh20ExvLEgwnR3bMna0MV/l5dzAxH4jfJF15HxOOhRez2F2sTkSkN2rE
        3/uBzQAfXv8r/lDQ/bQ0HAgpcTfjq2J2UDjO3iwycl2Q+jrsyJr//OwbLU2VIZLpxn2NRN
        adFz/JEvDxevHKf15fZHh1DU3NcrOADkt9ul5zltTwQQyKC0f0k5XT9RW50IgaQfty3oc8
        cLVj/5ydTRp0JAjS0IJeJ0iYQhdlGdk+zgCWfFHvaRjCbO4kQ+2PYWABD6ZZ/bNWOeJ1hF
        rJ9JtygHZ/oYVMg2RMhjmJlSJQwzKdf5qHoW7MyVyWQ09MLE5oq2DHddS4+qTQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668174898;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=sTSauIHtQe8nkxj9vWG7an7hER/OZbQ0yiXscxhOHpY=;
        b=eTjnEvqLANPRFPDzNmMJb0aixvOkBMzGLcVDG/D78BrlL+s4esd4umI5YvkWIFmjtWzfxv
        1qpBSZvBZJ+hbBAg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ashok Raj <ashok.raj@intel.com>, Jon Mason <jdmason@kudzu.us>,
        Allen Hubbe <allenbh@gmail.com>,
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org
Subject: [patch 27/39] PCI/MSI: Move pci_disable_msix() to api.c
References: <20221111120501.026511281@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 11 Nov 2022 14:54:58 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Ahmed S. Darwish <darwi@linutronix.de>

To distangle the maze in msi.c, all exported device-driver MSI APIs are
now to be grouped in one file, api.c.

Move pci_disable_msix() and make its kernel-doc comprehensive.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 drivers/pci/msi/api.c | 24 ++++++++++++++++++++++++
 drivers/pci/msi/msi.c | 14 +-------------
 drivers/pci/msi/msi.h |  1 +
 3 files changed, 26 insertions(+), 13 deletions(-)
---
diff --git a/drivers/pci/msi/api.c b/drivers/pci/msi/api.c
index 83ea38ffa116..653a61868ae6 100644
--- a/drivers/pci/msi/api.c
+++ b/drivers/pci/msi/api.c
@@ -112,6 +112,30 @@ int pci_enable_msix_range(struct pci_dev *dev, struct msix_entry *entries,
 EXPORT_SYMBOL(pci_enable_msix_range);
 
 /**
+ * pci_disable_msix() - Disable MSI-X interrupt mode on device
+ * @dev: the PCI device to operate on
+ *
+ * Legacy device driver API to disable MSI-X interrupt mode on device,
+ * free earlier-allocated interrupt vectors, and restore INTx emulation.
+ * The PCI device Linux IRQ (@dev->irq) is restored to its default pin
+ * assertion IRQ. This is the cleanup pair of pci_enable_msix_range().
+ *
+ * NOTE: The newer pci_alloc_irq_vectors() / pci_free_irq_vectors() API
+ * pair should, in general, be used instead.
+ */
+void pci_disable_msix(struct pci_dev *dev)
+{
+	if (!pci_msi_enabled() || !dev || !dev->msix_enabled)
+		return;
+
+	msi_lock_descs(&dev->dev);
+	pci_msix_shutdown(dev);
+	pci_free_msi_irqs(dev);
+	msi_unlock_descs(&dev->dev);
+}
+EXPORT_SYMBOL(pci_disable_msix);
+
+/**
  * pci_alloc_irq_vectors() - Allocate multiple device interrupt vectors
  * @dev:      the PCI device to operate on
  * @min_vecs: minimum required number of vectors (must be >= 1)
diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index 1226d66da992..6fa90d07d2e4 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -736,7 +736,7 @@ static int __pci_enable_msix(struct pci_dev *dev, struct msix_entry *entries,
 	return msix_capability_init(dev, entries, nvec, affd);
 }
 
-static void pci_msix_shutdown(struct pci_dev *dev)
+void pci_msix_shutdown(struct pci_dev *dev)
 {
 	struct msi_desc *desc;
 
@@ -758,18 +758,6 @@ static void pci_msix_shutdown(struct pci_dev *dev)
 	pcibios_alloc_irq(dev);
 }
 
-void pci_disable_msix(struct pci_dev *dev)
-{
-	if (!pci_msi_enable || !dev || !dev->msix_enabled)
-		return;
-
-	msi_lock_descs(&dev->dev);
-	pci_msix_shutdown(dev);
-	pci_free_msi_irqs(dev);
-	msi_unlock_descs(&dev->dev);
-}
-EXPORT_SYMBOL(pci_disable_msix);
-
 int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec,
 			   struct irq_affinity *affd)
 {
diff --git a/drivers/pci/msi/msi.h b/drivers/pci/msi/msi.h
index 8c4a5289432d..77e2587f7e4f 100644
--- a/drivers/pci/msi/msi.h
+++ b/drivers/pci/msi/msi.h
@@ -86,6 +86,7 @@ static inline __attribute_const__ u32 msi_multi_mask(struct msi_desc *desc)
 
 /* MSI internal functions invoked from the public APIs */
 void pci_msi_shutdown(struct pci_dev *dev);
+void pci_msix_shutdown(struct pci_dev *dev);
 void pci_free_msi_irqs(struct pci_dev *dev);
 int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec, struct irq_affinity *affd);
 int __pci_enable_msix_range(struct pci_dev *dev, struct msix_entry *entries, int minvec,

