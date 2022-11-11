Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFCD5625C9D
	for <lists+linux-pci@lfdr.de>; Fri, 11 Nov 2022 15:09:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234593AbiKKOJg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 09:09:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234874AbiKKOHs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 09:07:48 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E25C09B55B;
        Fri, 11 Nov 2022 06:00:23 -0800 (PST)
Message-ID: <20221111135206.688367117@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668175131;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=8LlK3JaLUlNPvY1OMKf4DIZ6KPBnqoAfjrM8HhykhKw=;
        b=Er05wIV3y7qyjvKHAe9RHM3QTy3fJwOqgzu/VcwYLfx7ZwsTTFjMF6+0Imrtr3ibuoQ0nN
        55tOvYFkgvSXcp5RTRpXkGT0EUEnkV9etxGpkhwWAnEF4da/H3bR7ENs0l2Uj5i4y58FPU
        PQkdHSe0AbeD/q90EluphJalKYr2NRkxgM/LisWMiKJPG5dUCZKIaZFJwRM+yTnN477C7U
        tu97FdP0R5lnrjOOT3FavfkvBmoKlTYvojRlIrwPWRr3Qi/JJcVRBMNESn1EmknKSqS9ve
        RFbq3mdQjyh9b+8Mvp1U2fd4/3AglhXpr0krNJsEg72XetXqTtEe1PSlOFL34A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668175131;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=8LlK3JaLUlNPvY1OMKf4DIZ6KPBnqoAfjrM8HhykhKw=;
        b=ptkecwef/JW8RO3aUBfzxGKEs8ZReI0FnVOn86e6JdzESmIs6tI37lSrIEayOc1aaQ1gCb
        PgR6vQUlhV/dEnAw==
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
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [patch 25/33] PCI/MSI: Provide post-enable dynamic allocation
 interfaces for MSI-X
References: <20221111133158.196269823@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 11 Nov 2022 14:58:51 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

MSI-X vectors can be allocated after the initial MSI-X enablement, but this
needs explicit support of the underlying interrupt domains.

Provide a function to query the ability and functions to allocate/free
individual vectors post-enable.

The allocation can either request a specific index in the MSI-X table or
with the index argument MSI_ANY_INDEX it allocates the next free vector.

The return value is a struct msi_map which on success contains both index
and the Linux interrupt number. In case of failure index is negative and
the Linux interrupt number is 0.

The allocation function is for a single MSI-X index at a time as that's
sufficient for the most urgent use case VFIO to get rid of the 'disable
MSI-X, reallocate, enable-MSI-X' cycle which is prone to lost interrupts
and redirections to the legacy and obviously unhandled INTx.

Also for the use cases Jason Gunthorpe pointed a single index allocation
is sufficient.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/pci/msi/api.c       |   67 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/msi/irqdomain.c |    3 +
 include/linux/pci.h         |    6 +++
 3 files changed, 75 insertions(+), 1 deletion(-)

--- a/drivers/pci/msi/api.c
+++ b/drivers/pci/msi/api.c
@@ -113,6 +113,73 @@ int pci_enable_msix_range(struct pci_dev
 EXPORT_SYMBOL(pci_enable_msix_range);
 
 /**
+ * pci_msix_can_alloc_dyn - Query whether dynamic allocation after enabling
+ *			    MSI-X is supported
+ *
+ * @dev:	PCI device to operate on
+ *
+ * Return: True if supported, false otherwise
+ */
+bool pci_msix_can_alloc_dyn(struct pci_dev *dev)
+{
+	if (!dev->msix_cap)
+		return false;
+
+	return pci_msi_domain_supports(dev, MSI_FLAG_PCI_MSIX_ALLOC_DYN, DENY_LEGACY);
+}
+EXPORT_SYMBOL_GPL(pci_msix_can_alloc_dyn);
+
+/**
+ * pci_msix_alloc_irq_at - Allocate an MSI-X interrupt after enabling MSI-X
+ *			   at a given MSI-X vector index or any free vector index
+ *
+ * @dev:	PCI device to operate on
+ * @index:	Index to allocate. If @index == MSI_ANY_INDEX this allocates
+ *		the next free index in the MSI-X table
+ * @affdesc:	Optional pointer to an affinity descriptor structure. NULL otherwise
+ *
+ * Return: A struct msi_map
+ *
+ *	On success msi_map::index contains the allocated index (>= 0) and
+ *	msi_map::virq the allocated Linux interrupt number (> 0).
+ *
+ *	On fail msi_map::index contains the error code and msi_map::virq
+ *	is set to 0.
+ */
+struct msi_map pci_msix_alloc_irq_at(struct pci_dev *dev, unsigned int index,
+				     const struct irq_affinity_desc *affdesc)
+{
+	struct msi_map map = { .index = -ENOTSUPP };
+
+	if (!dev->msix_enabled)
+		return map;
+
+	if (!pci_msix_can_alloc_dyn(dev))
+		return map;
+
+	return msi_domain_alloc_irq_at(&dev->dev, MSI_DEFAULT_DOMAIN, index, affdesc, NULL);
+}
+EXPORT_SYMBOL_GPL(pci_msix_alloc_irq_at);
+
+/**
+ * pci_msix_free_irq - Free an interrupt on a PCI/MSIX interrupt domain
+ *		      which was allocated via pci_msix_alloc_irq_at()
+ *
+ * @dev:	The PCI device to operate on
+ * @map:	A struct msi_map describing the interrupt to free
+ *		as returned from the allocation function.
+ */
+void pci_msix_free_irq(struct pci_dev *dev, struct msi_map map)
+{
+	if (WARN_ON_ONCE(map.index < 0 || map.virq <= 0))
+		return;
+	if (WARN_ON_ONCE(!pci_msix_can_alloc_dyn(dev)))
+		return;
+	msi_domain_free_irqs_range(&dev->dev, MSI_DEFAULT_DOMAIN, map.index, map.index);
+}
+EXPORT_SYMBOL_GPL(pci_msix_free_irq);
+
+/**
  * pci_disable_msix() - Disable MSI-X interrupt mode on device
  * @dev: the PCI device to operate on
  *
--- a/drivers/pci/msi/irqdomain.c
+++ b/drivers/pci/msi/irqdomain.c
@@ -225,7 +225,8 @@ static struct msi_domain_template pci_ms
 	},
 
 	.info = {
-		.flags			= MSI_COMMON_FLAGS | MSI_FLAG_PCI_MSIX,
+		.flags			= MSI_COMMON_FLAGS | MSI_FLAG_PCI_MSIX |
+					  MSI_FLAG_PCI_MSIX_ALLOC_DYN,
 		.bus_token		= DOMAIN_BUS_PCI_DEVICE_MSIX,
 	},
 };
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -38,6 +38,7 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/resource_ext.h>
+#include <linux/msi_api.h>
 #include <uapi/linux/pci.h>
 
 #include <linux/pci_ids.h>
@@ -1559,6 +1560,11 @@ int pci_alloc_irq_vectors_affinity(struc
 				   unsigned int max_vecs, unsigned int flags,
 				   struct irq_affinity *affd);
 
+bool pci_msix_can_alloc_dyn(struct pci_dev *dev);
+struct msi_map pci_msix_alloc_irq_at(struct pci_dev *dev, unsigned int index,
+				     const struct irq_affinity_desc *affdesc);
+void pci_msix_free_irq(struct pci_dev *pdev, struct msi_map map);
+
 void pci_free_irq_vectors(struct pci_dev *dev);
 int pci_irq_vector(struct pci_dev *dev, unsigned int nr);
 const struct cpumask *pci_irq_get_affinity(struct pci_dev *pdev, int vec);

