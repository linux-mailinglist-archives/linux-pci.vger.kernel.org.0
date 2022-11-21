Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 233F66326CB
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 15:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbiKUOts (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 09:49:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbiKUOsR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 09:48:17 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E6AD39CC;
        Mon, 21 Nov 2022 06:42:12 -0800 (PST)
Message-ID: <20221121140049.112451419@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669041585;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=jpf4uTDZSxvRjVAE3WgmDcW+YtGdj2bZVH5YpiSoOUo=;
        b=G9DBuITpemF9kibAhhPqyHeoHh8ExTBDmwMhPjBZh0I0DnioHVrhMPH+wlUSSc+NbtZJKD
        EPf3WK33eJaIiCZuBpBye2OhETYwXEnMwwhJ8Uvr9V3vofViIbUQ79o+aKDHTh0b77ylQA
        nLazQ1U0hjaMoO9atHzYEgZZMtzXGNopdb+Dss2PvhGpd0lQnoyjz3tAgU1i+fJpITYrix
        NznzSqq3vZPseHhxG+gvNKLIg6GZZmZ42g41huXCtozTLWBBoEAKdwabp+Cw8yCpx9EqG0
        gsYqjEc4SeVbdGRTU7ZKf2kMt+svMm+eBIFH0/pe02WQgPGOX/YgCvo2eIjAAw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669041585;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=jpf4uTDZSxvRjVAE3WgmDcW+YtGdj2bZVH5YpiSoOUo=;
        b=YQ3dUE5uR8oBuOat+5zzb0nbJD4JBkAS060GpXpRCNgwgcZn8InxqEW06CNV5Mtrh8QUkf
        yMFJIAUMcLViWtDg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Will Deacon <will@kernel.org>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Vinod Koul <vkoul@kernel.org>, Sinan Kaya <okaya@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Subject: [patch V2 13/40] irqchip/gic-v3-its: Provide MSI parent for PCI/MSI[-X]
References: <20221121135653.208611233@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 21 Nov 2022 15:39:44 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Lift the its_pci_msi_prepare() function from the ITS-PCI/MSI code which
provides the 'global' PCI/MSI domains and amend it to use the domain
hardware size, which is the MSI[X] vector count, for allocating the ITS
slots for the PCI device.

Enable PCI matching in msi_parent_ops and provide the necessary update to
the ITS specific child domain initialization function so that the prepare
callback gets invoked on allocations.

The latter might be optimized to do the allocation right at the point where
the child domain is initialized, but keep it simple for now.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/Makefile                    |    1 
 drivers/irqchip/irq-gic-v3-its-msi-parent.c |  106 ++++++++++++++
 drivers/irqchip/irq-gic-v3-its-pci-msi.c    |  202 ----------------------------
 3 files changed, 106 insertions(+), 203 deletions(-)

--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -34,7 +34,6 @@ obj-$(CONFIG_ARM_GIC_MSI_LIB)		+= irq-gi
 obj-$(CONFIG_ARM_GIC_V2M)		+= irq-gic-v2m.o
 obj-$(CONFIG_ARM_GIC_V3)		+= irq-gic-v3.o irq-gic-v3-mbi.o irq-gic-common.o
 obj-$(CONFIG_ARM_GIC_V3_ITS)		+= irq-gic-v3-its.o irq-gic-v3-its-platform-msi.o irq-gic-v4.o irq-gic-v3-its-msi-parent.o
-obj-$(CONFIG_ARM_GIC_V3_ITS_PCI)	+= irq-gic-v3-its-pci-msi.o
 obj-$(CONFIG_ARM_GIC_V3_ITS_FSL_MC)	+= irq-gic-v3-its-fsl-mc-msi.o
 obj-$(CONFIG_PARTITION_PERCPU)		+= irq-partition-percpu.o
 obj-$(CONFIG_HISILICON_IRQ_MBIGEN)	+= irq-mbigen.o
--- a/drivers/irqchip/irq-gic-v3-its-msi-parent.c
+++ b/drivers/irqchip/irq-gic-v3-its-msi-parent.c
@@ -1,7 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0-only
+// Copyright (C) 2013-2015 ARM Limited, All Rights Reserved.
+// Author: Marc Zyngier <marc.zyngier@arm.com>
 // Copyright (C) 2022 Linutronix GmbH
 // Copyright (C) 2022 Intel
 
+#include <linux/pci.h>
+
 #include "irq-gic-common.h"
 #include "irq-gic-msi-lib.h"
 
@@ -12,12 +16,113 @@
 				 MSI_FLAG_PCI_MSIX      |	\
 				 MSI_FLAG_MULTI_PCI_MSI)
 
+#ifdef CONFIG_PCI_MSI
+static int its_pci_msi_vec_count(struct pci_dev *pdev, void *data)
+{
+	int msi, msix, *count = data;
+
+	msi = max(pci_msi_vec_count(pdev), 0);
+	msix = max(pci_msix_vec_count(pdev), 0);
+	*count += max(msi, msix);
+	return 0;
+}
+
+static int its_get_pci_alias(struct pci_dev *pdev, u16 alias, void *data)
+{
+	struct pci_dev **alias_dev = data;
+
+	*alias_dev = pdev;
+	return 0;
+}
+
+static int its_pci_msi_prepare(struct irq_domain *domain, struct device *dev,
+			       int nvec, msi_alloc_info_t *info)
+{
+	struct pci_dev *pdev, *alias_dev;
+	struct msi_domain_info *msi_info;
+	int alias_count = 0, minnvec = 1;
+
+	if (!dev_is_pci(dev))
+		return -EINVAL;
+
+	pdev = to_pci_dev(dev);
+	/*
+	 * If pdev is downstream of any aliasing bridges, take an upper
+	 * bound of how many other vectors could map to the same DevID.
+	 * Also tell the ITS that the signalling will come from a proxy
+	 * device, and that special allocation rules apply.
+	 */
+	pci_for_each_dma_alias(pdev, its_get_pci_alias, &alias_dev);
+	if (alias_dev != pdev) {
+		if (alias_dev->subordinate)
+			pci_walk_bus(alias_dev->subordinate,
+				     its_pci_msi_vec_count, &alias_count);
+		info->flags |= MSI_ALLOC_FLAGS_PROXY_DEVICE;
+	}
+
+	/* ITS specific DeviceID, as the core ITS ignores dev. */
+	info->scratchpad[0].ul = pci_msi_domain_get_msi_rid(domain, pdev);
+
+	/*
+	 * @domain->msi_domain_info->hwsize contains the size of the
+	 * MSI[-X] domain, but vector allocation happens one by one. This
+	 * needs some thought when IMS comes into play as the size of IMS
+	 * might be unknown at domain creation time and therefore set to
+	 * MSI_MAX_INDEX.
+	 */
+	msi_info = msi_get_domain_info(domain);
+	if (msi_info->hwsize > nvec)
+		nvec = msi_info->hwsize;
+
+	/*
+	 * Always allocate a power of 2, and special case device 0 for
+	 * broken systems where the DevID is not wired (and all devices
+	 * appear as DevID 0). For that reason, we generously allocate a
+	 * minimum of 32 MSIs for DevID 0. If you want more because all
+	 * your devices are aliasing to DevID 0, consider fixing your HW.
+	 */
+	nvec = max(nvec, alias_count);
+	if (!info->scratchpad[0].ul)
+		minnvec = 32;
+	nvec = max_t(int, minnvec, roundup_pow_of_two(nvec));
+
+	msi_info = msi_get_domain_info(domain->parent);
+	return msi_info->ops->msi_prepare(domain->parent, dev, nvec, info);
+}
+#else /* CONFIG_PCI_MSI */
+#define its_pci_msi_prepare	NULL
+#endif /* !CONFIG_PCI_MSI */
+
 static bool its_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
 				  struct irq_domain *real_parent, struct msi_domain_info *info)
 {
 	if (!gic_msi_lib_init_dev_msi_info(dev, domain, real_parent, info))
 		return false;
 
+	switch(info->bus_token) {
+	case DOMAIN_BUS_PCI_DEVICE_MSI:
+	case DOMAIN_BUS_PCI_DEVICE_MSIX:
+		/*
+		 * FIXME: This probably should be done after a (not yet
+		 * existing) post domain creation callback once to make
+		 * support for dynamic post-enable MSI-X allocations
+		 * work without having to reevaluate the domain size
+		 * over and over. It is known already at allocation
+		 * time via info->hwsize.
+		 *
+		 * That should work perfectly fine for MSI/MSI-X but needs
+		 * some thoughts for purely software managed IMS domains
+		 * where the index space is only limited artificially via
+		 * %MSI_MAX_INDEX.
+		 */
+		info->ops->msi_prepare = its_pci_msi_prepare;
+		break;
+	default:
+		/* Confused. How did the lib return true? */
+		WARN_ON_ONCE(1);
+		return false;
+	}
+
 	return true;
 }
 
@@ -25,6 +130,7 @@ const struct msi_parent_ops gic_v3_its_m
 	.supported_flags	= ITS_MSI_FLAGS_SUPPORTED,
 	.required_flags		= ITS_MSI_FLAGS_REQUIRED,
 	.bus_select_token	= DOMAIN_BUS_NEXUS,
+	.bus_select_mask	= MATCH_PCI_MSI,
 	.prefix			= "ITS-",
 	.init_dev_msi_info	= its_init_dev_msi_info,
 };
--- a/drivers/irqchip/irq-gic-v3-its-pci-msi.c
+++ /dev/null
@@ -1,202 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Copyright (C) 2013-2015 ARM Limited, All Rights Reserved.
- * Author: Marc Zyngier <marc.zyngier@arm.com>
- */
-
-#include <linux/acpi_iort.h>
-#include <linux/pci.h>
-#include <linux/msi.h>
-#include <linux/of.h>
-#include <linux/of_irq.h>
-#include <linux/of_pci.h>
-
-static void its_mask_msi_irq(struct irq_data *d)
-{
-	pci_msi_mask_irq(d);
-	irq_chip_mask_parent(d);
-}
-
-static void its_unmask_msi_irq(struct irq_data *d)
-{
-	pci_msi_unmask_irq(d);
-	irq_chip_unmask_parent(d);
-}
-
-static struct irq_chip its_msi_irq_chip = {
-	.name			= "ITS-MSI",
-	.irq_unmask		= its_unmask_msi_irq,
-	.irq_mask		= its_mask_msi_irq,
-	.irq_eoi		= irq_chip_eoi_parent,
-};
-
-static int its_pci_msi_vec_count(struct pci_dev *pdev, void *data)
-{
-	int msi, msix, *count = data;
-
-	msi = max(pci_msi_vec_count(pdev), 0);
-	msix = max(pci_msix_vec_count(pdev), 0);
-	*count += max(msi, msix);
-
-	return 0;
-}
-
-static int its_get_pci_alias(struct pci_dev *pdev, u16 alias, void *data)
-{
-	struct pci_dev **alias_dev = data;
-
-	*alias_dev = pdev;
-
-	return 0;
-}
-
-static int its_pci_msi_prepare(struct irq_domain *domain, struct device *dev,
-			       int nvec, msi_alloc_info_t *info)
-{
-	struct pci_dev *pdev, *alias_dev;
-	struct msi_domain_info *msi_info;
-	int alias_count = 0, minnvec = 1;
-
-	if (!dev_is_pci(dev))
-		return -EINVAL;
-
-	msi_info = msi_get_domain_info(domain->parent);
-
-	pdev = to_pci_dev(dev);
-	/*
-	 * If pdev is downstream of any aliasing bridges, take an upper
-	 * bound of how many other vectors could map to the same DevID.
-	 * Also tell the ITS that the signalling will come from a proxy
-	 * device, and that special allocation rules apply.
-	 */
-	pci_for_each_dma_alias(pdev, its_get_pci_alias, &alias_dev);
-	if (alias_dev != pdev) {
-		if (alias_dev->subordinate)
-			pci_walk_bus(alias_dev->subordinate,
-				     its_pci_msi_vec_count, &alias_count);
-		info->flags |= MSI_ALLOC_FLAGS_PROXY_DEVICE;
-	}
-
-	/* ITS specific DeviceID, as the core ITS ignores dev. */
-	info->scratchpad[0].ul = pci_msi_domain_get_msi_rid(domain, pdev);
-
-	/*
-	 * Always allocate a power of 2, and special case device 0 for
-	 * broken systems where the DevID is not wired (and all devices
-	 * appear as DevID 0). For that reason, we generously allocate a
-	 * minimum of 32 MSIs for DevID 0. If you want more because all
-	 * your devices are aliasing to DevID 0, consider fixing your HW.
-	 */
-	nvec = max(nvec, alias_count);
-	if (!info->scratchpad[0].ul)
-		minnvec = 32;
-	nvec = max_t(int, minnvec, roundup_pow_of_two(nvec));
-	return msi_info->ops->msi_prepare(domain->parent, dev, nvec, info);
-}
-
-static struct msi_domain_ops its_pci_msi_ops = {
-	.msi_prepare	= its_pci_msi_prepare,
-};
-
-static struct msi_domain_info its_pci_msi_domain_info = {
-	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
-		   MSI_FLAG_MULTI_PCI_MSI | MSI_FLAG_PCI_MSIX),
-	.ops	= &its_pci_msi_ops,
-	.chip	= &its_msi_irq_chip,
-};
-
-static struct of_device_id its_device_id[] = {
-	{	.compatible	= "arm,gic-v3-its",	},
-	{},
-};
-
-static int __init its_pci_msi_init_one(struct fwnode_handle *handle,
-				       const char *name)
-{
-	struct irq_domain *parent;
-
-	parent = irq_find_matching_fwnode(handle, DOMAIN_BUS_NEXUS);
-	if (!parent || !msi_get_domain_info(parent)) {
-		pr_err("%s: Unable to locate ITS domain\n", name);
-		return -ENXIO;
-	}
-
-	if (!pci_msi_create_irq_domain(handle, &its_pci_msi_domain_info,
-				       parent)) {
-		pr_err("%s: Unable to create PCI domain\n", name);
-		return -ENOMEM;
-	}
-
-	return 0;
-}
-
-static int __init its_pci_of_msi_init(void)
-{
-	struct device_node *np;
-
-	for (np = of_find_matching_node(NULL, its_device_id); np;
-	     np = of_find_matching_node(np, its_device_id)) {
-		if (!of_device_is_available(np))
-			continue;
-		if (!of_property_read_bool(np, "msi-controller"))
-			continue;
-
-		if (its_pci_msi_init_one(of_node_to_fwnode(np), np->full_name))
-			continue;
-
-		pr_info("PCI/MSI: %pOF domain created\n", np);
-	}
-
-	return 0;
-}
-
-#ifdef CONFIG_ACPI
-
-static int __init
-its_pci_msi_parse_madt(union acpi_subtable_headers *header,
-		       const unsigned long end)
-{
-	struct acpi_madt_generic_translator *its_entry;
-	struct fwnode_handle *dom_handle;
-	const char *node_name;
-	int err = -ENXIO;
-
-	its_entry = (struct acpi_madt_generic_translator *)header;
-	node_name = kasprintf(GFP_KERNEL, "ITS@0x%lx",
-			      (long)its_entry->base_address);
-	dom_handle = iort_find_domain_token(its_entry->translation_id);
-	if (!dom_handle) {
-		pr_err("%s: Unable to locate ITS domain handle\n", node_name);
-		goto out;
-	}
-
-	err = its_pci_msi_init_one(dom_handle, node_name);
-	if (!err)
-		pr_info("PCI/MSI: %s domain created\n", node_name);
-
-out:
-	kfree(node_name);
-	return err;
-}
-
-static int __init its_pci_acpi_msi_init(void)
-{
-	acpi_table_parse_madt(ACPI_MADT_TYPE_GENERIC_TRANSLATOR,
-			      its_pci_msi_parse_madt, 0);
-	return 0;
-}
-#else
-static int __init its_pci_acpi_msi_init(void)
-{
-	return 0;
-}
-#endif
-
-static int __init its_pci_msi_init(void)
-{
-	its_pci_of_msi_init();
-	its_pci_acpi_msi_init();
-
-	return 0;
-}
-early_initcall(its_pci_msi_init);

