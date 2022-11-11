Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D297625BC0
	for <lists+linux-pci@lfdr.de>; Fri, 11 Nov 2022 14:56:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233907AbiKKN4h (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 08:56:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233860AbiKKN4A (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 08:56:00 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B6667101;
        Fri, 11 Nov 2022 05:54:52 -0800 (PST)
Message-ID: <20221111122014.870888193@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668174890;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=r4FcKRBwb0S/6DX5J7gWRuaqhtaapFFj+24TyV6TJ3Q=;
        b=oC1efg0/7x7qL8AThd8flu4wRif16nNAbDPPmci8lhL2eADwgyBsYfEPHZSyI4yt8S+KJs
        Fly00rs/559MEIcgi9Gpww+9i6Iy4cQ3IWLL7y6p4eOn3TnfrtdrN2roLpKG6K+9zqLY4v
        g1KKU7xm4GzvZba1B8TViWnJhxeB7nJLyuymIW3Ni5ndgdwq/NUfrTUVt45sm3FKPWkwHK
        3z1dwn6Fp7VjupcerdcMuAQAoVkB3fPh1EGTAU5atc2aHrIgDue3GqFMP23kj9jVwEFGY8
        CIsWWqG23OelAGykN8OM25EcPbMu1aReKe9VPoRftrGjpfFHeLaNv3kuAzWvyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668174890;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=r4FcKRBwb0S/6DX5J7gWRuaqhtaapFFj+24TyV6TJ3Q=;
        b=VBvji6CxYo3GJQJlKIkZ/fYFOTR9TrLHNIQBSnUKIR7abDARxG+AtzidhVRS0UQrQpqhJD
        8rkdL7juWBEUqVBw==
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
Subject: [patch 22/39] PCI/MSI: Move pci_alloc_irq_vectors() to api.c
References: <20221111120501.026511281@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 11 Nov 2022 14:54:50 +0100 (CET)
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

Make pci_alloc_irq_vectors() a real function instead of wrapper and add
proper kernel doc to it.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 drivers/pci/msi/api.c | 33 +++++++++++++++++++++++++++++++++
 include/linux/pci.h   | 17 +++++++++--------
 2 files changed, 42 insertions(+), 8 deletions(-)
---
diff --git a/drivers/pci/msi/api.c b/drivers/pci/msi/api.c
index d48050555d55..1714905943fb 100644
--- a/drivers/pci/msi/api.c
+++ b/drivers/pci/msi/api.c
@@ -90,3 +90,36 @@ int pci_enable_msix_range(struct pci_dev *dev, struct msix_entry *entries,
 	return __pci_enable_msix_range(dev, entries, minvec, maxvec, NULL, 0);
 }
 EXPORT_SYMBOL(pci_enable_msix_range);
+
+/**
+ * pci_alloc_irq_vectors() - Allocate multiple device interrupt vectors
+ * @dev:      the PCI device to operate on
+ * @min_vecs: minimum required number of vectors (must be >= 1)
+ * @max_vecs: maximum desired number of vectors
+ * @flags:    One or more of:
+ *            %PCI_IRQ_MSIX      Allow trying MSI-X vector allocations
+ *            %PCI_IRQ_MSI       Allow trying MSI vector allocations
+ *            %PCI_IRQ_LEGACY    Allow trying legacy INTx interrupts, if
+ *                               and only if @min_vecs == 1
+ *            %PCI_IRQ_AFFINITY  Auto-manage IRQs affinity by spreading
+ *                               the vectors around available CPUs
+ *
+ * Allocate up to @max_vecs interrupt vectors on device. MSI-X irq
+ * vector allocation has a higher precedence over plain MSI, which has a
+ * higher precedence over legacy INTx emulation.
+ *
+ * Upon a successful allocation, the caller should use pci_irq_vector()
+ * to get the Linux IRQ number to be passed to request_threaded_irq().
+ * The driver must call pci_free_irq_vectors() on cleanup.
+ *
+ * Return: number of allocated vectors (which might be smaller than
+ * @max_vecs), -ENOSPC if less than @min_vecs interrupt vectors are
+ * available, other errnos otherwise.
+ */
+int pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
+			  unsigned int max_vecs, unsigned int flags)
+{
+	return pci_alloc_irq_vectors_affinity(dev, min_vecs, max_vecs,
+					      flags, NULL);
+}
+EXPORT_SYMBOL(pci_alloc_irq_vectors);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 2bda4a4e47e8..6a356a39ba94 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1553,6 +1553,8 @@ static inline int pci_enable_msix_exact(struct pci_dev *dev,
 		return rc;
 	return 0;
 }
+int pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
+			  unsigned int max_vecs, unsigned int flags);
 int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
 				   unsigned int max_vecs, unsigned int flags,
 				   struct irq_affinity *affd);
@@ -1586,6 +1588,13 @@ pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
 		return 1;
 	return -ENOSPC;
 }
+static inline int
+pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
+		      unsigned int max_vecs, unsigned int flags)
+{
+	return pci_alloc_irq_vectors_affinity(dev, min_vecs, max_vecs,
+					      flags, NULL);
+}
 
 static inline void pci_free_irq_vectors(struct pci_dev *dev)
 {
@@ -1900,14 +1909,6 @@ pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
 }
 #endif /* CONFIG_PCI */
 
-static inline int
-pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
-		      unsigned int max_vecs, unsigned int flags)
-{
-	return pci_alloc_irq_vectors_affinity(dev, min_vecs, max_vecs, flags,
-					      NULL);
-}
-
 /* Include architecture-dependent settings and functions */
 
 #include <asm/pci.h>

