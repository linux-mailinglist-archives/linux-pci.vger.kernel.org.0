Return-Path: <linux-pci+bounces-8816-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D102D9089E4
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 12:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D9D01F2AC06
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 10:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA85E19CD09;
	Fri, 14 Jun 2024 10:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lgA4aUkz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RYKbEKfB"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB41719CCEA;
	Fri, 14 Jun 2024 10:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718360751; cv=none; b=HkweNoSzWb3CL+Q3BjDvZ3kQ26ycQjC+Hg135UgPvBiT0TWMRYpmptwzeSGXTSpkhp1Vs/M0MckYNM0PYsUPXqhS6guH5gF6hjOJhIj3zSQOZzGN4Rhqe2x3AFIYVZ7j7QkzA6crioavnMgJ+IWwiZzPt0wibX+5YSSbo5bonnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718360751; c=relaxed/simple;
	bh=3DRkWlhMhomnd9fSD8R3l5Vs6htU/F3knwhaRck5W/E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p/SLA+UN5GoM9sYM2UtGUbwi2uH/i1iuT9+RC3+h2+WRBnnqxou3re183x3X0IDloWf/KZa8pDDwM6VxwAhtIt6j7IGk3yICvbw4TkkQVsOYmfu55i0VvDfao0YFYxYKZIEGxBCd8OtRwW/gqA594kYOPLnL1nMJWSz1RSqJV7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lgA4aUkz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RYKbEKfB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718360748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4ytSnk4se8QEiisTNTKx45jzEP5bNgddAJmqeAZTdt8=;
	b=lgA4aUkz/g5CGe2UQoPQMAwjvJk75tJcasoup/HYwyOGUqO9KYHrfGUUSDL3MweAqYkEKs
	SY8iC03kcY8dyfi8O7H+URluygo02VxWyWHjkz0Xvsc/vhRyuKvRGCLrYPMU7HghKCFLmg
	42283AS3z9aAUT+Zw6h5DC1QsxnFThw7q9WTdeprp2W9WQc1ps6ZkLCgGNTwHysEELuhEy
	4AR7Bl29dmsEtbUGFlbn6sWkFfH9I5gH5dRG5vTV/Le97meYWVx0Eh2eRI6GrLI5NmThZp
	oY9N4v8SUY8BvhBUJv2fr4YN2BtJy1FfsW19fY3GmllF2g0LFovv2rmQLaxLEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718360748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4ytSnk4se8QEiisTNTKx45jzEP5bNgddAJmqeAZTdt8=;
	b=RYKbEKfB34wm1ll5bAsoSXnRoVpLnbGuAE6W+LbvS3ag+o/XJ5FcVzmhJWS3m0+n0cqzdq
	E58GH5Lq9PsxX0Bg==
To: linux-kernel@vger.kernel.org
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
Subject: [PATCH v3 17/24] irqchip/imx-mu-msi: Switch to MSI parent
Date: Fri, 14 Jun 2024 12:23:56 +0200
Message-Id: <20240614102403.13610-18-shivamurthy.shastri@linutronix.de>
In-Reply-To: <20240614102403.13610-1-shivamurthy.shastri@linutronix.de>
References: <20240614102403.13610-1-shivamurthy.shastri@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thomas Gleixner <tglx@linutronix.de>

All platform MSI users and the PCI/MSI code handle per device MSI domains
when the irqdomain associated to the device provides MSI parent
functionality.

Remove the "global" platform domain related code and provide the MSI parent
functionality by filling in msi_parent_ops.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
---
v3: enabled MSI_FLAG_PCI_MSI_MASK_PARENT in msi_parent_ops::supported_flags
---
 drivers/irqchip/Kconfig          |  1 +
 drivers/irqchip/irq-imx-mu-msi.c | 49 ++++++++++++++------------------
 drivers/irqchip/irq-msi-lib.c    |  2 ++
 3 files changed, 25 insertions(+), 27 deletions(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 2104b8727b1a..e7a57b3dc4b1 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -492,6 +492,7 @@ config IMX_MU_MSI
 	select IRQ_DOMAIN
 	select IRQ_DOMAIN_HIERARCHY
 	select GENERIC_MSI_IRQ
+	select IRQ_MSI_LIB
 	help
 	  Provide a driver for the i.MX Messaging Unit block used as a
 	  CPU-to-CPU MSI controller. This requires a specially crafted DT
diff --git a/drivers/irqchip/irq-imx-mu-msi.c b/drivers/irqchip/irq-imx-mu-msi.c
index 1dceda044db9..87ecf949550c 100644
--- a/drivers/irqchip/irq-imx-mu-msi.c
+++ b/drivers/irqchip/irq-imx-mu-msi.c
@@ -24,6 +24,8 @@
 #include <linux/pm_domain.h>
 #include <linux/spinlock.h>
 
+#include "irq-msi-lib.h"
+
 #define IMX_MU_CHANS            4
 
 enum imx_mu_xcr {
@@ -114,20 +116,6 @@ static void imx_mu_msi_parent_ack_irq(struct irq_data *data)
 	imx_mu_read(msi_data, msi_data->cfg->xRR + data->hwirq * 4);
 }
 
-static struct irq_chip imx_mu_msi_irq_chip = {
-	.name = "MU-MSI",
-	.irq_ack = irq_chip_ack_parent,
-};
-
-static struct msi_domain_ops imx_mu_msi_irq_ops = {
-};
-
-static struct msi_domain_info imx_mu_msi_domain_info = {
-	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS),
-	.ops	= &imx_mu_msi_irq_ops,
-	.chip	= &imx_mu_msi_irq_chip,
-};
-
 static void imx_mu_msi_parent_compose_msg(struct irq_data *data,
 					  struct msi_msg *msg)
 {
@@ -195,6 +183,7 @@ static void imx_mu_msi_domain_irq_free(struct irq_domain *domain,
 }
 
 static const struct irq_domain_ops imx_mu_msi_domain_ops = {
+	.select	= msi_lib_irq_domain_select,
 	.alloc	= imx_mu_msi_domain_irq_alloc,
 	.free	= imx_mu_msi_domain_irq_free,
 };
@@ -216,6 +205,22 @@ static void imx_mu_msi_irq_handler(struct irq_desc *desc)
 	chained_irq_exit(chip, desc);
 }
 
+#define IMX_MU_MSI_FLAGS_REQUIRED	(MSI_FLAG_USE_DEF_DOM_OPS |	\
+					 MSI_FLAG_USE_DEF_CHIP_OPS |	\
+					 MSI_FLAG_PARENT_PM_DEV)
+
+#define IMX_MU_MSI_FLAGS_SUPPORTED	(MSI_GENERIC_FLAGS_MASK |	\
+					 MSI_FLAG_PCI_MSI_MASK_PARENT)
+
+static const struct msi_parent_ops imx_mu_msi_parent_ops = {
+	.supported_flags	= IMX_MU_MSI_FLAGS_SUPPORTED,
+	.required_flags		= IMX_MU_MSI_FLAGS_REQUIRED,
+	.bus_select_token       = DOMAIN_BUS_NEXUS,
+	.bus_select_mask	= MATCH_PLATFORM_MSI,
+	.prefix			= "MU-MSI-",
+	.init_dev_msi_info	= msi_lib_init_dev_msi_info,
+};
+
 static int imx_mu_msi_domains_init(struct imx_mu_msi *msi_data, struct device *dev)
 {
 	struct fwnode_handle *fwnodes = dev_fwnode(dev);
@@ -230,19 +235,9 @@ static int imx_mu_msi_domains_init(struct imx_mu_msi *msi_data, struct device *d
 	}
 
 	irq_domain_update_bus_token(parent, DOMAIN_BUS_NEXUS);
-
-	msi_data->msi_domain = platform_msi_create_irq_domain(fwnodes,
-					&imx_mu_msi_domain_info,
-					parent);
-
-	if (!msi_data->msi_domain) {
-		dev_err(dev, "failed to create MSI domain\n");
-		irq_domain_remove(parent);
-		return -ENOMEM;
-	}
-
-	irq_domain_set_pm_device(msi_data->msi_domain, dev);
-
+	parent->dev = parent->pm_dev = dev;
+	parent->flags |= IRQ_DOMAIN_FLAG_MSI_PARENT;
+	parent->msi_parent_ops = &imx_mu_msi_parent_ops;
 	return 0;
 }
 
diff --git a/drivers/irqchip/irq-msi-lib.c b/drivers/irqchip/irq-msi-lib.c
index 40c19087d719..15f92ce4d1e8 100644
--- a/drivers/irqchip/irq-msi-lib.c
+++ b/drivers/irqchip/irq-msi-lib.c
@@ -89,6 +89,8 @@ bool msi_lib_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
 	/* Chip updates for all child bus types */
 	if (!info->chip->irq_eoi)
 		info->chip->irq_eoi	= irq_chip_eoi_parent;
+	if (!info->chip->irq_ack)
+		info->chip->irq_ack	= irq_chip_ack_parent;
 
 	/*
 	 * The device MSI domain can never have a set affinity callback. It
-- 
2.34.1


