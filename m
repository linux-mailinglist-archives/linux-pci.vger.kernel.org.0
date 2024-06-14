Return-Path: <linux-pci+bounces-8818-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D10679089E5
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 12:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BB151F2799D
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 10:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17EC0194C8F;
	Fri, 14 Jun 2024 10:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MVA7Q+aT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FPCRcBil"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BE919DF49;
	Fri, 14 Jun 2024 10:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718360757; cv=none; b=mNfzLvQfPXYD6B7+gS/KVuIucA4GHvc9kykz6Kf+6+OjwXXEawrJKs06/64R4iV9SRvZYtVj9KwtOfHagaYgVydlxv0fyuHXpyb4gkZgO1bi1RkUo45i/44GxLIuIMktDpjGF4fHsQo/LLjIToZ61/1ZUg4XmzmoIRFXIB4QuRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718360757; c=relaxed/simple;
	bh=YX2PCjd8hElH0Xgx6GLK1zgmlg/hMXWIRN4e3FhbyyY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Lw4z7KjJbX5+WSn+XRjgu1xjPJiDwtw5BRCC+ct6GReQNfNGVh/whd0oJ6oP0GrTOSCfAuLaIa9T50nAVSghjIg6dSOSc1HqdA3mxbampmb7MU96FFa4m1ethfFkqst4/qZ9nUnnnSlMg+YD337rXmlYgKq3C0PilPBiDJQKP4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MVA7Q+aT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FPCRcBil; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718360754;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0rgMurdNhvld6IltR2rC1kPUNWorrmjQx1og1mHkrxA=;
	b=MVA7Q+aTXWDpOHwos6Q4e9r4nFcMGuGwcMpE8zmyIUmmuJDgT4n/I65SvStZA6wfmcrsyz
	ay0ZpHMJkQv6UI1i5A+4PmHfLZka03rXfvMf4V1EjdhAql4HHoPcon9x9am3pOdWGyFw5+
	DLvzwtUiezUM3f+rUxD4YZJpb7xV4K8LKw7TbhU+1Xm4+WHgbb7PKDCd1CdhV2SCuUrECj
	FUVmVom4qPzlcPIiAHqk8Ahc+vCv5IxXl0/7xfOIlaJjRO7aFHwYmDFb/zIbYAaJxTLJ/M
	wzE6z20cfCBHbzCHh8XiAl3jny+LNJfYa51opjRaZViEkiN/EoKhhsWyinQwUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718360754;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0rgMurdNhvld6IltR2rC1kPUNWorrmjQx1og1mHkrxA=;
	b=FPCRcBilVNKIcg/czr2ZcxkLex4SyZFX8lE+vczYfHBuolHZvDENFWnck28U0wev2Z/gnE
	vOSeVfP/npmJUfDg==
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
Subject: [PATCH v3 19/24] irqchip/mvebu-gicp: Switch to MSI parent
Date: Fri, 14 Jun 2024 12:23:58 +0200
Message-Id: <20240614102403.13610-20-shivamurthy.shastri@linutronix.de>
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
 drivers/irqchip/irq-mvebu-gicp.c | 45 ++++++++++++++------------------
 2 files changed, 21 insertions(+), 25 deletions(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index e7a57b3dc4b1..a0fa59928913 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -371,6 +371,7 @@ config MSCC_OCELOT_IRQ
 	select GENERIC_IRQ_CHIP
 
 config MVEBU_GICP
+	select IRQ_MSI_LIB
 	bool
 
 config MVEBU_ICU
diff --git a/drivers/irqchip/irq-mvebu-gicp.c b/drivers/irqchip/irq-mvebu-gicp.c
index c43a345061d5..aaa01ff89d41 100644
--- a/drivers/irqchip/irq-mvebu-gicp.c
+++ b/drivers/irqchip/irq-mvebu-gicp.c
@@ -17,6 +17,8 @@
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 
+#include "irq-msi-lib.h"
+
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 
 #define GICP_SETSPI_NSR_OFFSET	0x0
@@ -145,32 +147,33 @@ static void gicp_irq_domain_free(struct irq_domain *domain,
 }
 
 static const struct irq_domain_ops gicp_domain_ops = {
+	.select	= msi_lib_irq_domain_select,
 	.alloc	= gicp_irq_domain_alloc,
 	.free	= gicp_irq_domain_free,
 };
 
-static struct irq_chip gicp_msi_irq_chip = {
-	.name		= "GICP",
-	.irq_set_type	= irq_chip_set_type_parent,
-	.flags		= IRQCHIP_SUPPORTS_LEVEL_MSI,
-};
+#define GICP_MSI_FLAGS_REQUIRED  (MSI_FLAG_USE_DEF_DOM_OPS |	\
+				  MSI_FLAG_USE_DEF_CHIP_OPS)
 
-static struct msi_domain_ops gicp_msi_ops = {
-};
+#define GICP_MSI_FLAGS_SUPPORTED (MSI_GENERIC_FLAGS_MASK |	\
+				  MSI_FLAG_LEVEL_CAPABLE |	\
+				  MSI_FLAG_PCI_MSI_MASK_PARENT)
 
-static struct msi_domain_info gicp_msi_domain_info = {
-	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
-		   MSI_FLAG_LEVEL_CAPABLE),
-	.ops	= &gicp_msi_ops,
-	.chip	= &gicp_msi_irq_chip,
+static const struct msi_parent_ops gicp_msi_parent_ops = {
+	.supported_flags	= GICP_MSI_FLAGS_SUPPORTED,
+	.required_flags		= GICP_MSI_FLAGS_REQUIRED,
+	.bus_select_token       = DOMAIN_BUS_GENERIC_MSI,
+	.bus_select_mask	= MATCH_PLATFORM_MSI,
+	.prefix			= "GICP-",
+	.init_dev_msi_info	= msi_lib_init_dev_msi_info,
 };
 
 static int mvebu_gicp_probe(struct platform_device *pdev)
 {
-	struct mvebu_gicp *gicp;
-	struct irq_domain *inner_domain, *plat_domain, *parent_domain;
+	struct irq_domain *inner_domain, *parent_domain;
 	struct device_node *node = pdev->dev.of_node;
 	struct device_node *irq_parent_dn;
+	struct mvebu_gicp *gicp;
 	int ret, i;
 
 	gicp = devm_kzalloc(&pdev->dev, sizeof(*gicp), GFP_KERNEL);
@@ -234,17 +237,9 @@ static int mvebu_gicp_probe(struct platform_device *pdev)
 	if (!inner_domain)
 		return -ENOMEM;
 
-
-	plat_domain = platform_msi_create_irq_domain(of_node_to_fwnode(node),
-						     &gicp_msi_domain_info,
-						     inner_domain);
-	if (!plat_domain) {
-		irq_domain_remove(inner_domain);
-		return -ENOMEM;
-	}
-
-	platform_set_drvdata(pdev, gicp);
-
+	irq_domain_update_bus_token(inner_domain, DOMAIN_BUS_GENERIC_MSI);
+	inner_domain->flags |= IRQ_DOMAIN_FLAG_MSI_PARENT;
+	inner_domain->msi_parent_ops = &gicp_msi_parent_ops;
 	return 0;
 }
 
-- 
2.34.1


