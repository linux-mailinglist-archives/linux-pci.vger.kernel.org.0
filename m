Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3256063266E
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 15:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbiKUOkQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 09:40:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231735AbiKUOiq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 09:38:46 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 182F1C8C80;
        Mon, 21 Nov 2022 06:38:18 -0800 (PST)
Message-ID: <20221121091327.869774994@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669041497;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=ySZBnEyGuRxlvnKXenaibefk4WZuhy1dihAtBCTEudU=;
        b=vDkTvONU4ycWxcJHHxqgO6wzZknMZKOx5ir55rLZMR3QAYSJqRYuZVTRl3fzINaODHhXfR
        GnGXLlW8WBXNsEon+oB54WjtapRuJog/kXZ5kBw8vE1aSOgPSssXDi3dJLVdDRwUjQ/Uy0
        MGHXKc6F1sOFUXu2N453cIaagcO4SjbUe10dj3JCEMRaEdThxiUdNzxxG43O6kPMjti42g
        KD26wNhsM2AYJyEKTRfY55N5mieZY4vzZT0hBoWBqV18ROlkJl2SSyzqY44mEOfpoFg+O/
        03UO7EdvbJijq/K9uxNXLEmbDPU/RkqNBKIY2nr8o5QvGQt9OpDq1TIG3DvSVQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669041497;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=ySZBnEyGuRxlvnKXenaibefk4WZuhy1dihAtBCTEudU=;
        b=7D5J7FBno5xLszNZN2vuCu3a4wHcbaXMhn9N8S22CQb2S2j+YOb7NrbNtGOiYMlFt8at4u
        b/p6LCvgVIgkcKDQ==
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
        Allen Hubbe <allenbh@gmail.com>
Subject: [patch V2 25/33] PCI/MSI: Provide post-enable dynamic allocation
 interfaces for MSI-X
References: <20221121083657.157152924@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 21 Nov 2022 15:38:17 +0100 (CET)
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

As single index allocation is also sufficient for the use cases Jason
Gunthorpe pointed out: Allocation of a MSI-X or IMS vector for a network
queue. See Link below.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Link: https://lore.kernel.org/all/20211126232735.547996838@linutronix.de
---
V2: Added Link to previous discussions (Bjorn)
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

