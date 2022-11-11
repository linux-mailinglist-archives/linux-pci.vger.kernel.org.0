Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 563E3625BBF
	for <lists+linux-pci@lfdr.de>; Fri, 11 Nov 2022 14:56:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233900AbiKKN4f (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 08:56:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233599AbiKKNzw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 08:55:52 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 549A37B229;
        Fri, 11 Nov 2022 05:54:50 -0800 (PST)
Message-ID: <20221111122014.813792885@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668174889;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=+/SWQaPmmzQa3dI8BJSuUqTvToJtImL4OX5ekaSehDs=;
        b=Er02kSdmpSjpT/V3BnAH5gksYjlj5/BOkn1q9Xk0ByEwka7MmN00jjbggDtJ7CZn4JzwVE
        ER6d7eoeYN47fJi4hCN+Sok9ndfjzIKmFHUZu8xK7YQJ47q/TvEcVto6FzM6vIyHsnRgqs
        YgL6IDrUPtVRYLx8axV/P7RZ1srb/8C9YsnF4lxfzZyBgLgb+RhJZcNxQctOuwT0brjkvo
        VQDsYYqQscWHYak5X6s3xXhnNBK0x1opWlUPifFxluya48bGoRG9NqWQhRGYw04zGbfIJF
        I2et5ZGYIRLFpCoOT2KjezCk3ej3bKoSX7SQxaCNCf/G+6nDFBugigSPpvStew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668174889;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=+/SWQaPmmzQa3dI8BJSuUqTvToJtImL4OX5ekaSehDs=;
        b=sZGbJ5v4ibSkVPeghlcKhY6RC7l93AZXEiSKmfJOLLjyOWr1rWHGxN49ajUHEOk1wCsitu
        8ECbcklJiJTpKNDA==
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
Subject: [patch 21/39] PCI/MSI: Move pci_enable_msix_range() to api.c
References: <20221111120501.026511281@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 11 Nov 2022 14:54:48 +0100 (CET)
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

Move pci_enable_msix_range() and make its kernel-doc comprehensive.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 drivers/pci/msi/api.c | 32 ++++++++++++++++++++++++++++++++
 drivers/pci/msi/msi.c | 30 ++++--------------------------
 drivers/pci/msi/msi.h |  3 +++
 3 files changed, 39 insertions(+), 26 deletions(-)
---
diff --git a/drivers/pci/msi/api.c b/drivers/pci/msi/api.c
index 63d7f8f6a284..d48050555d55 100644
--- a/drivers/pci/msi/api.c
+++ b/drivers/pci/msi/api.c
@@ -58,3 +58,35 @@ void pci_disable_msi(struct pci_dev *dev)
 	msi_unlock_descs(&dev->dev);
 }
 EXPORT_SYMBOL(pci_disable_msi);
+
+/**
+ * pci_enable_msix_range() - Enable MSI-X interrupt mode on device
+ * @dev:     the PCI device to operate on
+ * @entries: input/output parameter, array of MSI-X configuration entries
+ * @minvec:  minimum required number of MSI-X vectors
+ * @maxvec:  maximum desired number of MSI-X vectors
+ *
+ * Legacy device driver API to enable MSI-X interrupt mode on device and
+ * configure its MSI-X capability structure as appropriate.  The passed
+ * @entries array must have each of its members "entry" field set to a
+ * desired (valid) MSI-X vector number, where the range of valid MSI-X
+ * vector numbers can be queried through pci_msix_vec_count().  If
+ * successful, the driver must invoke pci_disable_msix() on cleanup.
+ *
+ * NOTE: The newer pci_alloc_irq_vectors() / pci_free_irq_vectors() API
+ * pair should, in general, be used instead.
+ *
+ * Return: number of MSI-X vectors allocated (which might be smaller
+ * than @maxvecs), where Linux IRQ numbers for such allocated vectors
+ * are saved back in the @entries array elements' "vector" field. Return
+ * -ENOSPC if less than @minvecs interrupt vectors are available.
+ * Return -EINVAL if one of the passed @entries members "entry" field
+ * was invalid or a duplicate, or if plain MSI interrupts mode was
+ * earlier enabled on device. Return other errnos otherwise.
+ */
+int pci_enable_msix_range(struct pci_dev *dev, struct msix_entry *entries,
+			  int minvec, int maxvec)
+{
+	return __pci_enable_msix_range(dev, entries, minvec, maxvec, NULL, 0);
+}
+EXPORT_SYMBOL(pci_enable_msix_range);
diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index 98f07ad9af62..6700ef1c734e 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -844,10 +844,10 @@ int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec,
 	}
 }
 
-static int __pci_enable_msix_range(struct pci_dev *dev,
-				   struct msix_entry *entries, int minvec,
-				   int maxvec, struct irq_affinity *affd,
-				   int flags)
+int __pci_enable_msix_range(struct pci_dev *dev,
+			    struct msix_entry *entries, int minvec,
+			    int maxvec, struct irq_affinity *affd,
+			    int flags)
 {
 	int rc, nvec = maxvec;
 
@@ -887,28 +887,6 @@ static int __pci_enable_msix_range(struct pci_dev *dev,
 }
 
 /**
- * pci_enable_msix_range - configure device's MSI-X capability structure
- * @dev: pointer to the pci_dev data structure of MSI-X device function
- * @entries: pointer to an array of MSI-X entries
- * @minvec: minimum number of MSI-X IRQs requested
- * @maxvec: maximum number of MSI-X IRQs requested
- *
- * Setup the MSI-X capability structure of device function with a maximum
- * possible number of interrupts in the range between @minvec and @maxvec
- * upon its software driver call to request for MSI-X mode enabled on its
- * hardware device function. It returns a negative errno if an error occurs.
- * If it succeeds, it returns the actual number of interrupts allocated and
- * indicates the successful configuration of MSI-X capability structure
- * with new allocated MSI-X interrupts.
- **/
-int pci_enable_msix_range(struct pci_dev *dev, struct msix_entry *entries,
-		int minvec, int maxvec)
-{
-	return __pci_enable_msix_range(dev, entries, minvec, maxvec, NULL, 0);
-}
-EXPORT_SYMBOL(pci_enable_msix_range);
-
-/**
  * pci_alloc_irq_vectors_affinity - allocate multiple IRQs for a device
  * @dev:		PCI device to operate on
  * @min_vecs:		minimum number of vectors required (must be >= 1)
diff --git a/drivers/pci/msi/msi.h b/drivers/pci/msi/msi.h
index 00bb98d5bb0e..8c4a5289432d 100644
--- a/drivers/pci/msi/msi.h
+++ b/drivers/pci/msi/msi.h
@@ -88,8 +88,11 @@ static inline __attribute_const__ u32 msi_multi_mask(struct msi_desc *desc)
 void pci_msi_shutdown(struct pci_dev *dev);
 void pci_free_msi_irqs(struct pci_dev *dev);
 int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec, struct irq_affinity *affd);
+int __pci_enable_msix_range(struct pci_dev *dev, struct msix_entry *entries, int minvec,
+			    int maxvec,  struct irq_affinity *affd, int flags);
 
 /* Legacy (!IRQDOMAIN) fallbacks */
+
 #ifdef CONFIG_PCI_MSI_ARCH_FALLBACKS
 int pci_msi_legacy_setup_msi_irqs(struct pci_dev *dev, int nvec, int type);
 void pci_msi_legacy_teardown_msi_irqs(struct pci_dev *dev);

