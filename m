Return-Path: <linux-pci+bounces-8819-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 421C59089E7
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 12:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A2FB1C21EEC
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 10:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AFA319E7C2;
	Fri, 14 Jun 2024 10:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="X71C7hoW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0T0EnBLY"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24C519DF6B;
	Fri, 14 Jun 2024 10:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718360760; cv=none; b=uJMd/66AVyHNviwxsSzzLgUBImy0L6l2Y19tacSiQTutwXm9Qb9lGO8n6/OTcb5gzANzH7VehBzGODFniJ5FGQxmuvE3ER1XuVDD9hQrUIJAckwUQkEjbGMkp+Yj/XWCHnlTDuBBF/9uPPPtxvTVyzbpXImS8xlRFa4W1HAFKPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718360760; c=relaxed/simple;
	bh=0cSodHSOEAlwkAnAeElvP8B/CnkXA55z5zr+2uaX0VE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sUAj/cGdaFdsYc6yf36DuyrgtfhuZQAbsEAqsI/wRKTO71ioargnbyqGV7/1Zc4y5nOdJPrKSgju6fXhnnIIWA6SOXEGAqC7YWlMGuzgJ1+0RJJZzSttJ0tWgQjHQaGmT0NKE5gQ1LHXfcsoAeKBhdea/LNyuB3HCGCVSFUz9wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=X71C7hoW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0T0EnBLY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718360757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mgj6w/3xgVK6TS19aCscO7mr2b2ilgdiI2acSGVXxh4=;
	b=X71C7hoWO0rY/4fzMJlCVAM7N8rkXQdPB0Dz+n9TiAp2ZVmPxNxLfvPpc0/W9001ZcOFKW
	l5D4SzJxTtVV9/LMJ4B8D7nvwJkuKtZtGFfGSZtadCXpCbONyyHiwD2/gbpG6tQOgoOI0T
	8aGNDi9xoRrLFRmP5QDjeiYqdLhIk+HuzqjdvzafjDYSUryLEPc+LrbRX56mdgHooKssi0
	+iUNPcyCwYV6idfZmL9iW7Q84r9s6uYXkXoAuvKDpllvkBK+hEQChT8WL5XTWM2U9hQGqc
	ptA5UYiUAGmD4T3H/eOI7lQXS1UtfxGbGGnnsJUpSkuh87dcCGOm20ai9Q+7iw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718360757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mgj6w/3xgVK6TS19aCscO7mr2b2ilgdiI2acSGVXxh4=;
	b=0T0EnBLYsKUoTPORkULIVowImw+qErsePi5v+AbFtkb2o0gMZ/khTK4kNYy5schx8tGbG/
	BLzVoB5S/4rRkuCg==
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
Subject: [PATCH v3 20/24] irqchip/mvebu-odmi: Switch to parent MSI
Date: Fri, 14 Jun 2024 12:23:59 +0200
Message-Id: <20240614102403.13610-21-shivamurthy.shastri@linutronix.de>
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
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@bootlin.com>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
v3: enabled MSI_FLAG_PCI_MSI_MASK_PARENT in msi_parent_ops::supported_flags 
---
 drivers/irqchip/Kconfig          |  1 +
 drivers/irqchip/irq-mvebu-odmi.c | 38 ++++++++++++++++----------------
 2 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index a0fa59928913..4def6dc76fa6 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -379,6 +379,7 @@ config MVEBU_ICU
 
 config MVEBU_ODMI
 	bool
+	select IRQ_MSI_LIB
 	select GENERIC_MSI_IRQ
 
 config MVEBU_PIC
diff --git a/drivers/irqchip/irq-mvebu-odmi.c b/drivers/irqchip/irq-mvebu-odmi.c
index 108091533e10..78e23fcdff8d 100644
--- a/drivers/irqchip/irq-mvebu-odmi.c
+++ b/drivers/irqchip/irq-mvebu-odmi.c
@@ -17,6 +17,9 @@
 #include <linux/msi.h>
 #include <linux/of_address.h>
 #include <linux/slab.h>
+
+#include "irq-msi-lib.h"
+
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 
 #define GICP_ODMIN_SET			0x40
@@ -141,27 +144,30 @@ static void odmi_irq_domain_free(struct irq_domain *domain,
 }
 
 static const struct irq_domain_ops odmi_domain_ops = {
+	.select	= msi_lib_irq_domain_select,
 	.alloc	= odmi_irq_domain_alloc,
 	.free	= odmi_irq_domain_free,
 };
 
-static struct irq_chip odmi_msi_irq_chip = {
-	.name	= "ODMI",
-};
+#define ODMI_MSI_FLAGS_REQUIRED  (MSI_FLAG_USE_DEF_DOM_OPS |	\
+				  MSI_FLAG_USE_DEF_CHIP_OPS)
 
-static struct msi_domain_ops odmi_msi_ops = {
-};
+#define ODMI_MSI_FLAGS_SUPPORTED (MSI_GENERIC_FLAGS_MASK |	\
+				  MSI_FLAG_PCI_MSI_MASK_PARENT)
 
-static struct msi_domain_info odmi_msi_domain_info = {
-	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS),
-	.ops	= &odmi_msi_ops,
-	.chip	= &odmi_msi_irq_chip,
+static const struct msi_parent_ops odmi_msi_parent_ops = {
+	.supported_flags	= ODMI_MSI_FLAGS_SUPPORTED,
+	.required_flags		= ODMI_MSI_FLAGS_REQUIRED,
+	.bus_select_token	= DOMAIN_BUS_GENERIC_MSI,
+	.bus_select_mask	= MATCH_PLATFORM_MSI,
+	.prefix			= "ODMI-",
+	.init_dev_msi_info	= msi_lib_init_dev_msi_info,
 };
 
 static int __init mvebu_odmi_init(struct device_node *node,
 				  struct device_node *parent)
 {
-	struct irq_domain *parent_domain, *inner_domain, *plat_domain;
+	struct irq_domain *parent_domain, *inner_domain;
 	int ret, i;
 
 	if (of_property_read_u32(node, "marvell,odmi-frames", &odmis_count))
@@ -208,18 +214,12 @@ static int __init mvebu_odmi_init(struct device_node *node,
 		goto err_unmap;
 	}
 
-	plat_domain = platform_msi_create_irq_domain(of_node_to_fwnode(node),
-						     &odmi_msi_domain_info,
-						     inner_domain);
-	if (!plat_domain) {
-		ret = -ENOMEM;
-		goto err_remove_inner;
-	}
+	irq_domain_update_bus_token(inner_domain, DOMAIN_BUS_GENERIC_MSI);
+	inner_domain->flags |= IRQ_DOMAIN_FLAG_MSI_PARENT;
+	inner_domain->msi_parent_ops = &odmi_msi_parent_ops;
 
 	return 0;
 
-err_remove_inner:
-	irq_domain_remove(inner_domain);
 err_unmap:
 	for (i = 0; i < odmis_count; i++) {
 		struct odmi_data *odmi = &odmis[i];
-- 
2.34.1


