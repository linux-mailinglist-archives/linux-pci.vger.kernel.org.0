Return-Path: <linux-pci+bounces-9150-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15CC4913C2E
	for <lists+linux-pci@lfdr.de>; Sun, 23 Jun 2024 17:22:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 394741C20313
	for <lists+linux-pci@lfdr.de>; Sun, 23 Jun 2024 15:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87488187551;
	Sun, 23 Jun 2024 15:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AEkwBgL5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+2tp1q+R"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D71187549;
	Sun, 23 Jun 2024 15:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719155942; cv=none; b=Pltu/N0EH/J69Lxrs6icVGW98tbMbDHjYTfnRGIi5am1hlMh0hFk3Y5MROD4PtjitATLtjzpBEZY0x+t63kosTwmim3kBqiXcdrGC1czAg1esmOWpkScX6uyXP9jU5iCIx4jL/CVLhbCABVDoGz2SPhr5wwnMonph9ZyigYXrzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719155942; c=relaxed/simple;
	bh=hwqt7/ytRG7DMMSOtJIVRVoslqAO5zPhmsdMj2ai7FM=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=CkmbNadPbytiibGuyHsM5HruVf1eFDZ2SIpp7/QTu1+npdbSuFA098tb8UieATnNH5zEeRTS3Q4ZeamHMEQ7q/NVSLIiNYrxOyLnAS6MmF8tTNVxF3JQHTP1DV6zjraRAUo4MjOxb+3UQZT/AQxH2082gdAP8f9h0rh2nj7gS1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AEkwBgL5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+2tp1q+R; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240623142235.699780279@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719155939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=sk+eMs1XLCviOuPEBWKOXUmCisbNe1qwc5qCH1jFRKc=;
	b=AEkwBgL5HtCqurUkupF1wsZ0XFbwx9Szi4DL6vXLoefC+bynJdfi2QWu49zQIEhz/EuXvc
	1c3u3kdCXLLVZZMSzigGfg/c0sUJm/h+mirdZ4YwO8XrDSAf8klZEHA+COsLt21+vjgjfh
	mGBk8ni2CT4yxOHg0JTO/bTOYi98ZBE9rj02c1PVokDjLKAKfdIf8Rvi2xL7Avsy2GuREl
	4OVHsedSSTIeArFkymhUWVm813In23RxEdhf1Q3ZlzKMJajMo/FRRT2bml2IXbw/oH3GFJ
	BN7K27qbi2adPW+UhN8UQ2CzuCkHPbbH4f0U+DEa8RixN7sgtbkU6oEohqxEIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719155939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=sk+eMs1XLCviOuPEBWKOXUmCisbNe1qwc5qCH1jFRKc=;
	b=+2tp1q+RumwVGQWJH83MzPzKaVZiTVKztohLTUPqQfF9hkTSnYgEVPyW05Fid2mBpq5Jaw
	HcR35tqVnS2GwaDg==
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
Subject: [patch V4 16/21] irqchip/mvebu-gicp: Switch to MSI parent
References: <20240623142137.448898081@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Sun, 23 Jun 2024 17:18:58 +0200 (CEST)

From: Thomas Gleixner <tglx@linutronix.de>

All platform MSI users and the PCI/MSI code handle per device MSI domains
when the irqdomain associated to the device provides MSI parent
functionality.

Remove the "global" platform domain related code and provide the MSI parent
functionality by filling in msi_parent_ops.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>


---
v3: enabled MSI_FLAG_PCI_MSI_MASK_PARENT in msi_parent_ops::supported_flags 
---
 drivers/irqchip/Kconfig          |    1 
 drivers/irqchip/irq-mvebu-gicp.c |   44 ++++++++++++++++-----------------------
 2 files changed, 20 insertions(+), 25 deletions(-)

--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -371,6 +371,7 @@ config MSCC_OCELOT_IRQ
 	select GENERIC_IRQ_CHIP
 
 config MVEBU_GICP
+	select IRQ_MSI_LIB
 	bool
 
 config MVEBU_ICU
--- a/drivers/irqchip/irq-mvebu-gicp.c
+++ b/drivers/irqchip/irq-mvebu-gicp.c
@@ -17,6 +17,8 @@
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 
+#include "irq-msi-lib.h"
+
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 
 #define GICP_SETSPI_NSR_OFFSET	0x0
@@ -145,32 +147,32 @@ static void gicp_irq_domain_free(struct
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
+				  MSI_FLAG_LEVEL_CAPABLE)
 
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
@@ -234,17 +236,9 @@ static int mvebu_gicp_probe(struct platf
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
 


