Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADECF6326D9
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 15:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbiKUOuv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 09:50:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbiKUOuZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 09:50:25 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B74FE2DC5;
        Mon, 21 Nov 2022 06:42:32 -0800 (PST)
Message-ID: <20221121140049.941784867@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669041601;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=nbwC+lgSL6ozvNItgfyZXaBzbrAk8SyOeMtfmXA2KHc=;
        b=aEgfAOyK0g42Cs3T2dxIWhy//sAG4P5ZapNnQgaQh9DuK8zQMyeI5zLD7Y7BfBMisRqTx0
        0zl/4156RrkOu78eKsoGlTmCXTpSRdPA3tafW1ywAPTtarU3O/xrHNqUEEcSNxBYqtS3a6
        aKI2sC/BTWzBjaTM7W7/q5NOm+ygGYVdLbqe2HgTTpj80rpk2En4wkxI1+qYoGtVwl8hVG
        z6qcNymeKvL2zxjXLOX/d4Jb4gUmdYf7D+3vaM9kAYbq1yKAPR/WqPet1dlACjXVMr11BR
        9RWcap4yPMkAkpFtgHQ71WevieedMIdVyuvr61FvWKn4zv1rFDlxlRI2TdG7cg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669041601;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=nbwC+lgSL6ozvNItgfyZXaBzbrAk8SyOeMtfmXA2KHc=;
        b=Kk+3p8BYmhT8c6maSO8QdSKAeHmnWeAxMJKZR+aGs12evof84V8083yd4eHATRf8ebrrgy
        VaRf97lPkmQ3V7AQ==
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
Subject: [patch V2 26/40] irqchip/gic-v3-its: Switch platform MSI to MSI parent
References: <20221121135653.208611233@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 21 Nov 2022 15:40:01 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Similar to the previous conversion of the PCI/MSI support lift the
prepare() callback from the existing platform MSI code and enable
platform MSI and the related device domain bus tokens in select
and the child domain initialization code.

All platform MSI users are automatically using the new per device MSI model
now.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/irqchip/Makefile                      |    2 
 drivers/irqchip/irq-gic-v3-its-msi-parent.c   |   73 +++++++++++
 drivers/irqchip/irq-gic-v3-its-platform-msi.c |  163 --------------------------
 3 files changed, 73 insertions(+), 165 deletions(-)

--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -33,7 +33,7 @@ obj-$(CONFIG_ARCH_REALVIEW)		+= irq-gic-
 obj-$(CONFIG_ARM_GIC_MSI_LIB)		+= irq-gic-msi-lib.o
 obj-$(CONFIG_ARM_GIC_V2M)		+= irq-gic-v2m.o
 obj-$(CONFIG_ARM_GIC_V3)		+= irq-gic-v3.o irq-gic-v3-mbi.o irq-gic-common.o
-obj-$(CONFIG_ARM_GIC_V3_ITS)		+= irq-gic-v3-its.o irq-gic-v3-its-platform-msi.o irq-gic-v4.o irq-gic-v3-its-msi-parent.o
+obj-$(CONFIG_ARM_GIC_V3_ITS)		+= irq-gic-v3-its.o irq-gic-v4.o irq-gic-v3-its-msi-parent.o
 obj-$(CONFIG_ARM_GIC_V3_ITS_FSL_MC)	+= irq-gic-v3-its-fsl-mc-msi.o
 obj-$(CONFIG_PARTITION_PERCPU)		+= irq-partition-percpu.o
 obj-$(CONFIG_HISILICON_IRQ_MBIGEN)	+= irq-mbigen.o
--- a/drivers/irqchip/irq-gic-v3-its-msi-parent.c
+++ b/drivers/irqchip/irq-gic-v3-its-msi-parent.c
@@ -4,6 +4,7 @@
 // Copyright (C) 2022 Linutronix GmbH
 // Copyright (C) 2022 Intel
 
+#include <linux/acpi_iort.h>
 #include <linux/pci.h>
 
 #include "irq-gic-common.h"
@@ -93,6 +94,68 @@ static int its_pci_msi_prepare(struct ir
 #define its_pci_msi_prepare	NULL
 #endif /* !CONFIG_PCI_MSI */
 
+static int of_pmsi_get_dev_id(struct irq_domain *domain, struct device *dev,
+				  u32 *dev_id)
+{
+	int ret, index = 0;
+
+	/* Suck the DeviceID out of the msi-parent property */
+	do {
+		struct of_phandle_args args;
+
+		ret = of_parse_phandle_with_args(dev->of_node,
+						 "msi-parent", "#msi-cells",
+						 index, &args);
+		if (args.np == irq_domain_get_of_node(domain)) {
+			if (WARN_ON(args.args_count != 1))
+				return -EINVAL;
+			*dev_id = args.args[0];
+			break;
+		}
+		index++;
+	} while (!ret);
+
+	return ret;
+}
+
+int __weak iort_pmsi_get_dev_id(struct device *dev, u32 *dev_id)
+{
+	return -1;
+}
+
+static int its_pmsi_prepare(struct irq_domain *domain, struct device *dev,
+			    int nvec, msi_alloc_info_t *info)
+{
+	struct msi_domain_info *msi_info;
+	u32 dev_id;
+	int ret;
+
+	if (dev->of_node)
+		ret = of_pmsi_get_dev_id(domain, dev, &dev_id);
+	else
+		ret = iort_pmsi_get_dev_id(dev, &dev_id);
+	if (ret)
+		return ret;
+
+	/* ITS specific DeviceID, as the core ITS ignores dev. */
+	info->scratchpad[0].ul = dev_id;
+
+	/*
+	 * @domain->msi_domain_info->hwsize contains the size of the device
+	 * domain, but vector allocation happens one by one.
+	 */
+	msi_info = msi_get_domain_info(domain);
+	if (msi_info->hwsize > nvec)
+		nvec = msi_info->hwsize;
+
+	/* Allocate at least 32 MSIs, and always as a power of 2 */
+	nvec = max_t(int, 32, roundup_pow_of_two(nvec));
+
+	msi_info = msi_get_domain_info(domain->parent);
+	return msi_info->ops->msi_prepare(domain->parent,
+					  dev, nvec, info);
+}
+
 static bool its_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
 				  struct irq_domain *real_parent, struct msi_domain_info *info)
 {
@@ -117,6 +180,14 @@ static bool its_init_dev_msi_info(struct
 		 */
 		info->ops->msi_prepare = its_pci_msi_prepare;
 		break;
+	case DOMAIN_BUS_DEVICE_IMS:
+	case DOMAIN_BUS_WIRED_TO_MSI:
+		/*
+		 * FIXME: See the above PCI prepare comment. The domain
+		 * size is also known at domain creation time.
+		 */
+		info->ops->msi_prepare = its_pmsi_prepare;
+		break;
 	default:
 		/* Confused. How did the lib return true? */
 		WARN_ON_ONCE(1);
@@ -130,7 +201,7 @@ const struct msi_parent_ops gic_v3_its_m
 	.supported_flags	= ITS_MSI_FLAGS_SUPPORTED,
 	.required_flags		= ITS_MSI_FLAGS_REQUIRED,
 	.bus_select_token	= DOMAIN_BUS_NEXUS,
-	.bus_select_mask	= MATCH_PCI_MSI,
+	.bus_select_mask	= MATCH_PCI_MSI | MATCH_PLATFORM_MSI,
 	.prefix			= "ITS-",
 	.init_dev_msi_info	= its_init_dev_msi_info,
 };
--- a/drivers/irqchip/irq-gic-v3-its-platform-msi.c
+++ /dev/null
@@ -1,163 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Copyright (C) 2013-2015 ARM Limited, All Rights Reserved.
- * Author: Marc Zyngier <marc.zyngier@arm.com>
- */
-
-#include <linux/acpi_iort.h>
-#include <linux/device.h>
-#include <linux/msi.h>
-#include <linux/of.h>
-#include <linux/of_irq.h>
-
-static struct irq_chip its_pmsi_irq_chip = {
-	.name			= "ITS-pMSI",
-};
-
-static int of_pmsi_get_dev_id(struct irq_domain *domain, struct device *dev,
-				  u32 *dev_id)
-{
-	int ret, index = 0;
-
-	/* Suck the DeviceID out of the msi-parent property */
-	do {
-		struct of_phandle_args args;
-
-		ret = of_parse_phandle_with_args(dev->of_node,
-						 "msi-parent", "#msi-cells",
-						 index, &args);
-		if (args.np == irq_domain_get_of_node(domain)) {
-			if (WARN_ON(args.args_count != 1))
-				return -EINVAL;
-			*dev_id = args.args[0];
-			break;
-		}
-		index++;
-	} while (!ret);
-
-	return ret;
-}
-
-int __weak iort_pmsi_get_dev_id(struct device *dev, u32 *dev_id)
-{
-	return -1;
-}
-
-static int its_pmsi_prepare(struct irq_domain *domain, struct device *dev,
-			    int nvec, msi_alloc_info_t *info)
-{
-	struct msi_domain_info *msi_info;
-	u32 dev_id;
-	int ret;
-
-	msi_info = msi_get_domain_info(domain->parent);
-
-	if (dev->of_node)
-		ret = of_pmsi_get_dev_id(domain, dev, &dev_id);
-	else
-		ret = iort_pmsi_get_dev_id(dev, &dev_id);
-	if (ret)
-		return ret;
-
-	/* ITS specific DeviceID, as the core ITS ignores dev. */
-	info->scratchpad[0].ul = dev_id;
-
-	/* Allocate at least 32 MSIs, and always as a power of 2 */
-	nvec = max_t(int, 32, roundup_pow_of_two(nvec));
-	return msi_info->ops->msi_prepare(domain->parent,
-					  dev, nvec, info);
-}
-
-static struct msi_domain_ops its_pmsi_ops = {
-	.msi_prepare	= its_pmsi_prepare,
-};
-
-static struct msi_domain_info its_pmsi_domain_info = {
-	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS),
-	.ops	= &its_pmsi_ops,
-	.chip	= &its_pmsi_irq_chip,
-};
-
-static const struct of_device_id its_device_id[] = {
-	{	.compatible	= "arm,gic-v3-its",	},
-	{},
-};
-
-static int __init its_pmsi_init_one(struct fwnode_handle *fwnode,
-				const char *name)
-{
-	struct irq_domain *parent;
-
-	parent = irq_find_matching_fwnode(fwnode, DOMAIN_BUS_NEXUS);
-	if (!parent || !msi_get_domain_info(parent)) {
-		pr_err("%s: unable to locate ITS domain\n", name);
-		return -ENXIO;
-	}
-
-	if (!platform_msi_create_irq_domain(fwnode, &its_pmsi_domain_info,
-					    parent)) {
-		pr_err("%s: unable to create platform domain\n", name);
-		return -ENXIO;
-	}
-
-	pr_info("Platform MSI: %s domain created\n", name);
-	return 0;
-}
-
-#ifdef CONFIG_ACPI
-static int __init
-its_pmsi_parse_madt(union acpi_subtable_headers *header,
-			const unsigned long end)
-{
-	struct acpi_madt_generic_translator *its_entry;
-	struct fwnode_handle *domain_handle;
-	const char *node_name;
-	int err = -ENXIO;
-
-	its_entry = (struct acpi_madt_generic_translator *)header;
-	node_name = kasprintf(GFP_KERNEL, "ITS@0x%lx",
-			      (long)its_entry->base_address);
-	domain_handle = iort_find_domain_token(its_entry->translation_id);
-	if (!domain_handle) {
-		pr_err("%s: Unable to locate ITS domain handle\n", node_name);
-		goto out;
-	}
-
-	err = its_pmsi_init_one(domain_handle, node_name);
-
-out:
-	kfree(node_name);
-	return err;
-}
-
-static void __init its_pmsi_acpi_init(void)
-{
-	acpi_table_parse_madt(ACPI_MADT_TYPE_GENERIC_TRANSLATOR,
-			      its_pmsi_parse_madt, 0);
-}
-#else
-static inline void its_pmsi_acpi_init(void) { }
-#endif
-
-static void __init its_pmsi_of_init(void)
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
-		its_pmsi_init_one(of_node_to_fwnode(np), np->full_name);
-	}
-}
-
-static int __init its_pmsi_init(void)
-{
-	its_pmsi_of_init();
-	its_pmsi_acpi_init();
-	return 0;
-}
-early_initcall(its_pmsi_init);

