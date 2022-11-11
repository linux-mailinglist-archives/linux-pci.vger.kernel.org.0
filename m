Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A312D625BC1
	for <lists+linux-pci@lfdr.de>; Fri, 11 Nov 2022 14:56:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234011AbiKKN4i (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 08:56:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233613AbiKKN4B (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 08:56:01 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F21F60698;
        Fri, 11 Nov 2022 05:54:53 -0800 (PST)
Message-ID: <20221111122014.927531290@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668174892;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=uefv1SQ/kFaCIoG5nEqNjtgMsMbRPxf/+/AfGMMS3ME=;
        b=pRX56ARtPVj6OyQEIMCqiah6CjQfsbUUjLKE1htpO78jveI+lbUJsRZyFxv6ZjkAjUyoAN
        OmuwsBOTCOZcYbdo31sYBZJJ2JMMjsySbe+r7TtEcQbauOlB6obK1AaxPUm0xLZPC4vEfj
        fcveslvLUX0yyTCArZBpUr0GgvLaxk/Zt48uV76R6Xz6gsOtk073eqv6iPhtoDfylIPEcH
        5WvyxYOkjFBFl2nOpoe9vzRcON0FKzSVhz9TXniJi/Fp6trJaG8/k4uD/ZGjZ0rqx/oUuu
        l8gSGVtbJBM/cwnAWhdq2WZdx3Vm6vpnKMcgPrP6Bm73HGnTvINn1tgoOm64CA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668174892;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=uefv1SQ/kFaCIoG5nEqNjtgMsMbRPxf/+/AfGMMS3ME=;
        b=AJ1J3mtq3gNBb0E5N58gtI7ISk9ECj7NVJw8fMFn44Fh4eLBVHxpY55lAGhoZtOWr1SC8R
        peJFrH/L1nyrdiAg==
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
Subject: [patch 23/39] PCI/MSI: Move pci_alloc_irq_vectors_affinity() to api.c
References: <20221111120501.026511281@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 11 Nov 2022 14:54:51 +0100 (CET)
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

Move pci_alloc_irq_vectors_affinity() and let its kernel-doc reference
pci_alloc_irq_vectors() documentation added in parent commit.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 drivers/pci/msi/api.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++-
 drivers/pci/msi/msi.c | 65 +----------------------------------------------------
 2 files changed, 59 insertions(+), 65 deletions(-)
---
diff --git a/drivers/pci/msi/api.c b/drivers/pci/msi/api.c
index 1714905943fb..8546749afa6e 100644
--- a/drivers/pci/msi/api.c
+++ b/drivers/pci/msi/api.c
@@ -123,3 +123,62 @@ int pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
 					      flags, NULL);
 }
 EXPORT_SYMBOL(pci_alloc_irq_vectors);
+
+/**
+ * pci_alloc_irq_vectors_affinity() - Allocate multiple device interrupt
+ *                                    vectors with affinity requirements
+ * @dev:      the PCI device to operate on
+ * @min_vecs: minimum required number of vectors (must be >= 1)
+ * @max_vecs: maximum desired number of vectors
+ * @flags:    allocation flags, as in pci_alloc_irq_vectors()
+ * @affd:     affinity requirements (can be %NULL).
+ *
+ * Same as pci_alloc_irq_vectors(), but with the extra @affd parameter.
+ * Check that function docs, and &struct irq_affinity, for more details.
+ */
+int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
+				   unsigned int max_vecs, unsigned int flags,
+				   struct irq_affinity *affd)
+{
+	struct irq_affinity msi_default_affd = {0};
+	int nvecs = -ENOSPC;
+
+	if (flags & PCI_IRQ_AFFINITY) {
+		if (!affd)
+			affd = &msi_default_affd;
+	} else {
+		if (WARN_ON(affd))
+			affd = NULL;
+	}
+
+	if (flags & PCI_IRQ_MSIX) {
+		nvecs = __pci_enable_msix_range(dev, NULL, min_vecs, max_vecs,
+						affd, flags);
+		if (nvecs > 0)
+			return nvecs;
+	}
+
+	if (flags & PCI_IRQ_MSI) {
+		nvecs = __pci_enable_msi_range(dev, min_vecs, max_vecs, affd);
+		if (nvecs > 0)
+			return nvecs;
+	}
+
+	/* use legacy IRQ if allowed */
+	if (flags & PCI_IRQ_LEGACY) {
+		if (min_vecs == 1 && dev->irq) {
+			/*
+			 * Invoke the affinity spreading logic to ensure that
+			 * the device driver can adjust queue configuration
+			 * for the single interrupt case.
+			 */
+			if (affd)
+				irq_create_affinity_masks(1, affd);
+			pci_intx(dev, 1);
+			return 1;
+		}
+	}
+
+	return nvecs;
+}
+EXPORT_SYMBOL(pci_alloc_irq_vectors_affinity);
diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index 6700ef1c734e..a028774f438d 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -887,71 +887,6 @@ int __pci_enable_msix_range(struct pci_dev *dev,
 }
 
 /**
- * pci_alloc_irq_vectors_affinity - allocate multiple IRQs for a device
- * @dev:		PCI device to operate on
- * @min_vecs:		minimum number of vectors required (must be >= 1)
- * @max_vecs:		maximum (desired) number of vectors
- * @flags:		flags or quirks for the allocation
- * @affd:		optional description of the affinity requirements
- *
- * Allocate up to @max_vecs interrupt vectors for @dev, using MSI-X or MSI
- * vectors if available, and fall back to a single legacy vector
- * if neither is available.  Return the number of vectors allocated,
- * (which might be smaller than @max_vecs) if successful, or a negative
- * error code on error. If less than @min_vecs interrupt vectors are
- * available for @dev the function will fail with -ENOSPC.
- *
- * To get the Linux IRQ number used for a vector that can be passed to
- * request_irq() use the pci_irq_vector() helper.
- */
-int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
-				   unsigned int max_vecs, unsigned int flags,
-				   struct irq_affinity *affd)
-{
-	struct irq_affinity msi_default_affd = {0};
-	int nvecs = -ENOSPC;
-
-	if (flags & PCI_IRQ_AFFINITY) {
-		if (!affd)
-			affd = &msi_default_affd;
-	} else {
-		if (WARN_ON(affd))
-			affd = NULL;
-	}
-
-	if (flags & PCI_IRQ_MSIX) {
-		nvecs = __pci_enable_msix_range(dev, NULL, min_vecs, max_vecs,
-						affd, flags);
-		if (nvecs > 0)
-			return nvecs;
-	}
-
-	if (flags & PCI_IRQ_MSI) {
-		nvecs = __pci_enable_msi_range(dev, min_vecs, max_vecs, affd);
-		if (nvecs > 0)
-			return nvecs;
-	}
-
-	/* use legacy IRQ if allowed */
-	if (flags & PCI_IRQ_LEGACY) {
-		if (min_vecs == 1 && dev->irq) {
-			/*
-			 * Invoke the affinity spreading logic to ensure that
-			 * the device driver can adjust queue configuration
-			 * for the single interrupt case.
-			 */
-			if (affd)
-				irq_create_affinity_masks(1, affd);
-			pci_intx(dev, 1);
-			return 1;
-		}
-	}
-
-	return nvecs;
-}
-EXPORT_SYMBOL(pci_alloc_irq_vectors_affinity);
-
-/**
  * pci_free_irq_vectors - free previously allocated IRQs for a device
  * @dev:		PCI device to operate on
  *

