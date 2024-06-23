Return-Path: <linux-pci+bounces-9143-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17CF8913C1F
	for <lists+linux-pci@lfdr.de>; Sun, 23 Jun 2024 17:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AF7C1C20919
	for <lists+linux-pci@lfdr.de>; Sun, 23 Jun 2024 15:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB25A1849F9;
	Sun, 23 Jun 2024 15:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hln9HdQu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nUGh4qIt"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DB418412E;
	Sun, 23 Jun 2024 15:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719155930; cv=none; b=k+8rscI2TAaZkb3tivWAlL45J/J3DSJ5zWAGLdTzQA8vlc1e/UkmyJRBUKO+bwpnHGWzv1V6/OtqTsYOm0d7UcfEGesVzHNO6uUuoQzsak6gaSfXMmRr6KpfftmybaRFnnoKA/1zzlprsIFPltuutYX2pAdLa8aSXqttdv4WlV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719155930; c=relaxed/simple;
	bh=SxJQ56pQNK1VHM8uYMUvOaLsAVuRbCzHb6ScHPMSa/g=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=gD1JJ5G+s0l40i3tINJI3amVmdOMPDNbAZbB2cwsxQl6ipioW8goGX5oFKs5N/JzjeRkNPYqrabhDTYKd8BIioMDeA8R52NZnfCxf61EqpcM/wh38B7GHJalgGoaJIQqt/KIYNKFB/MFG9prODwONRRNA90d4tsUf6SXSwTWE3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hln9HdQu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nUGh4qIt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240623142235.271734124@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719155927;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=7NLQmhItVCF6ac1l+OXuVeyrliNnbO3hLWLzBiwXoaM=;
	b=hln9HdQu3Jxpl6QBABzMuYDjNJUWHRwsprspEWIeLPDOfE90Yuzhws2Lsh9zwY4KEvTnNb
	O9ojDf+F90fmNaOZxEOU7yNdkhuDpS2UctFIHEuXyjoEFeKxuXedgPu8E/leewyQRlrflX
	8HVo2n1cvOT9kjJSmUvDjd40ivS0Be1RvU6O5b7Ct3wyx8/jA5n3aInEfakMLuTAr7C7jP
	G3+v56phUCk3/01qTjRtcY+bviua5JP7eAip7DpdKcypAW1/+opoLwemSTLpk5PJS5fXD7
	ELZNPY4NFMwCoMXxPktiB3NdIHPuYWK+GFlL1RPkqZfMSAraZzDsIphggbySOQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719155927;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=7NLQmhItVCF6ac1l+OXuVeyrliNnbO3hLWLzBiwXoaM=;
	b=nUGh4qItV/3V02OxayQM6B/8MrSx6ithG/gVZaHzhB709e7cNvcngb8ePXEPv4yzsgft1X
	NCsQaehOHagYcYBw==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
 linux-pci@vger.kernel.org,
 maz@kernel.org,
 tglx@linutronix.de,
 anna-maria@linutronix.de,
 shawnguo@kernel.org,
 s.hauer@pengutronix.de,
 festevam@gmail.com,
 bhelgaas@google.com,
 rdunlap@infradead.org,
 vidyas@nvidia.com,
 ilpo.jarvinen@linux.intel.com,
 apatel@ventanamicro.com,
 kevin.tian@intel.com,
 nipun.gupta@amd.com,
 den@valinux.co.jp,
 andrew@lunn.ch,
 gregory.clement@bootlin.com,
 sebastian.hesselbarth@gmail.com,
 gregkh@linuxfoundation.org,
 rafael@kernel.org,
 alex.williamson@redhat.com,
 will@kernel.org,
 lorenzo.pieralisi@arm.com,
 jgg@mellanox.com,
 ammarfaizi2@gnuweeb.org,
 robin.murphy@arm.com,
 lpieralisi@kernel.org,
 nm@ti.com,
 kristo@kernel.org,
 vkoul@kernel.org,
 okaya@kernel.org,
 agross@kernel.org,
 andersson@kernel.org,
 mark.rutland@arm.com,
 shameerali.kolothum.thodi@huawei.com,
 yuzenghui@huawei.com,
 shivamurthy.shastri@linutronix.de
Subject: [patch V4 09/21] irqchip/gic-v3-its: Switch platform MSI to MSI
 parent
References: <20240623142137.448898081@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Sun, 23 Jun 2024 17:18:46 +0200 (CEST)

From: Thomas Gleixner <tglx@linutronix.de>

Similar to the previous conversion of the PCI/MSI support lift the
prepare() callback from the existing platform MSI code and enable
platform MSI and the related device domain bus tokens in select
and the child domain initialization code.

All platform MSI users are automatically using the new per device MSI model
now.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>


---
v3: adopted to IMS->MSI rename
---
 drivers/irqchip/Makefile                      |   2 +-
 drivers/irqchip/irq-gic-v3-its-msi-parent.c   |  73 +++++++-
 drivers/irqchip/irq-gic-v3-its-platform-msi.c | 163 ------------------
 3 files changed, 73 insertions(+), 165 deletions(-)
 delete mode 100644 drivers/irqchip/irq-gic-v3-its-platform-msi.c

diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index c5316634637f..afc44f4709a6 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -32,7 +32,7 @@ obj-$(CONFIG_ARCH_REALVIEW)		+= irq-gic-realview.o
 obj-$(CONFIG_IRQ_MSI_LIB)		+= irq-msi-lib.o
 obj-$(CONFIG_ARM_GIC_V2M)		+= irq-gic-v2m.o
 obj-$(CONFIG_ARM_GIC_V3)		+= irq-gic-v3.o irq-gic-v3-mbi.o irq-gic-common.o
-obj-$(CONFIG_ARM_GIC_V3_ITS)		+= irq-gic-v3-its.o irq-gic-v3-its-platform-msi.o irq-gic-v4.o irq-gic-v3-its-msi-parent.o
+obj-$(CONFIG_ARM_GIC_V3_ITS)		+= irq-gic-v3-its.o irq-gic-v4.o irq-gic-v3-its-msi-parent.o
 obj-$(CONFIG_ARM_GIC_V3_ITS_FSL_MC)	+= irq-gic-v3-its-fsl-mc-msi.o
 obj-$(CONFIG_PARTITION_PERCPU)		+= irq-partition-percpu.o
 obj-$(CONFIG_HISILICON_IRQ_MBIGEN)	+= irq-mbigen.o
diff --git a/drivers/irqchip/irq-gic-v3-its-msi-parent.c b/drivers/irqchip/irq-gic-v3-its-msi-parent.c
index e81fefa428e2..21daa452ffa6 100644
--- a/drivers/irqchip/irq-gic-v3-its-msi-parent.c
+++ b/drivers/irqchip/irq-gic-v3-its-msi-parent.c
@@ -4,6 +4,7 @@
 // Copyright (C) 2022 Linutronix GmbH
 // Copyright (C) 2022 Intel
 
+#include <linux/acpi_iort.h>
 #include <linux/pci.h>
 
 #include "irq-gic-common.h"
@@ -96,6 +97,68 @@ static int its_pci_msi_prepare(struct irq_domain *domain, struct device *dev,
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
@@ -120,6 +183,14 @@ static bool its_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
 		 */
 		info->ops->msi_prepare = its_pci_msi_prepare;
 		break;
+	case DOMAIN_BUS_DEVICE_MSI:
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
@@ -133,7 +204,7 @@ const struct msi_parent_ops gic_v3_its_msi_parent_ops = {
 	.supported_flags	= ITS_MSI_FLAGS_SUPPORTED,
 	.required_flags		= ITS_MSI_FLAGS_REQUIRED,
 	.bus_select_token	= DOMAIN_BUS_NEXUS,
-	.bus_select_mask	= MATCH_PCI_MSI,
+	.bus_select_mask	= MATCH_PCI_MSI | MATCH_PLATFORM_MSI,
 	.prefix			= "ITS-",
 	.init_dev_msi_info	= its_init_dev_msi_info,
 };
diff --git a/drivers/irqchip/irq-gic-v3-its-platform-msi.c b/drivers/irqchip/irq-gic-v3-its-platform-msi.c
deleted file mode 100644
index daa6d5053bc3..000000000000
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
-- 
2.34.1




