Return-Path: <linux-pci+bounces-8820-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A9759089EA
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 12:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D86C1C21569
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 10:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5AA519DF7C;
	Fri, 14 Jun 2024 10:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Bqt17WEC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qs5BzFo8"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F3919E7C6;
	Fri, 14 Jun 2024 10:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718360762; cv=none; b=OG9Nugvurk/lG85sEzU7Tw7BnglYvXbEzhqNzzmVV04kuDC0iWj6t+E2HroDwCafS83hx8SGFStifECgg74aS+7LDGNCtA8g8lvfzCFOs05qQZ1WD/oMPOAESJ/tlMrOnqAeMtF14nnN6VbPHzH1dQLKT/VdeYC5EJueIM82g/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718360762; c=relaxed/simple;
	bh=ZaQ3YTMz50ghQLDXhkEjBEruAqRy3q7tt9NkrtGLa7g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f3km5jf6ToYd3HMVBD7wXksHOvhFb0/HOdBrBJQSBDR7x1vbwNJGQZTr/US/B9wSOHCOROTD8agaxqBE5EDAWK4z9qdtnlfvWYpIw1oKDq/G/WZiNw2vrPFSEjaBtpkXiRY0FMKzevZuq8y+VDoFqa/fQFVKa2egltPmIuClOVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Bqt17WEC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qs5BzFo8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718360759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z00+l2MfGkai09pEURcQHWk/pi+JDRb+aWSm78cMLcY=;
	b=Bqt17WECgth5zBNXpjwDRI/1Ewi7Fl6p920MJ7rWNhakEVl9824l4c9wZNcHj8gRV2sA7E
	ivCLDw9gdeLBaCD3POyEZMp0PGqG6iE4mgA5hk8Sw/uvtAPfT1VI5E4i41+OEz4ndChHYV
	6sSdLDufPXEgDgWF/BZE4kCF4/CRcGesrZz1XnFpiAX2uCUPYUVWD3Nr9FEQRNIbAwGPjC
	dig5iyHptQ62B8P7knvn/ZWXVMoJKrxOwFu9iuAKlj7bDIGAiKQ1k2IXjuJ1sUVCKvS6fO
	WhOJgaAWGY8CdRPO06YPEjx0w/9uR1/OgSX/Bhgzog5J/ADWafscZNEHvmoJxA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718360759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z00+l2MfGkai09pEURcQHWk/pi+JDRb+aWSm78cMLcY=;
	b=qs5BzFo83ZelEhuy+ASTsPGM537vli1yd05JW0iR5m1ZBmNJ/CfZIbT/5pp7l8CxuhZkho
	mdb3guU7Kz7bviDQ==
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
Subject: [PATCH v3 21/24] irqchip/irq-mvebu-sei: Switch to MSI parent
Date: Fri, 14 Jun 2024 12:24:00 +0200
Message-Id: <20240614102403.13610-22-shivamurthy.shastri@linutronix.de>
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
 drivers/irqchip/irq-mvebu-sei.c | 53 +++++++++++++--------------------
 1 file changed, 21 insertions(+), 32 deletions(-)

diff --git a/drivers/irqchip/irq-mvebu-sei.c b/drivers/irqchip/irq-mvebu-sei.c
index a48dbe91b036..b52007f884d0 100644
--- a/drivers/irqchip/irq-mvebu-sei.c
+++ b/drivers/irqchip/irq-mvebu-sei.c
@@ -14,6 +14,8 @@
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
 
+#include "irq-msi-lib.h"
+
 /* Cause register */
 #define GICP_SECR(idx)		(0x0  + ((idx) * 0x4))
 /* Mask register */
@@ -190,6 +192,7 @@ static void mvebu_sei_domain_free(struct irq_domain *domain, unsigned int virq,
 }
 
 static const struct irq_domain_ops mvebu_sei_domain_ops = {
+	.select	= msi_lib_irq_domain_select,
 	.alloc	= mvebu_sei_domain_alloc,
 	.free	= mvebu_sei_domain_free,
 };
@@ -307,21 +310,6 @@ static const struct irq_domain_ops mvebu_sei_cp_domain_ops = {
 	.free	= mvebu_sei_cp_domain_free,
 };
 
-static struct irq_chip mvebu_sei_msi_irq_chip = {
-	.name		= "SEI pMSI",
-	.irq_ack	= irq_chip_ack_parent,
-	.irq_set_type	= irq_chip_set_type_parent,
-};
-
-static struct msi_domain_ops mvebu_sei_msi_ops = {
-};
-
-static struct msi_domain_info mvebu_sei_msi_domain_info = {
-	.flags	= MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS,
-	.ops	= &mvebu_sei_msi_ops,
-	.chip	= &mvebu_sei_msi_irq_chip,
-};
-
 static void mvebu_sei_handle_cascade_irq(struct irq_desc *desc)
 {
 	struct mvebu_sei *sei = irq_desc_get_handler_data(desc);
@@ -360,10 +348,24 @@ static void mvebu_sei_reset(struct mvebu_sei *sei)
 	}
 }
 
+#define SEI_MSI_FLAGS_REQUIRED	(MSI_FLAG_USE_DEF_DOM_OPS |	\
+				 MSI_FLAG_USE_DEF_CHIP_OPS)
+
+#define SEI_MSI_FLAGS_SUPPORTED	(MSI_GENERIC_FLAGS_MASK |	\
+				 MSI_FLAG_PCI_MSI_MASK_PARENT)
+
+static const struct msi_parent_ops sei_msi_parent_ops = {
+	.supported_flags	= SEI_MSI_FLAGS_SUPPORTED,
+	.required_flags		= SEI_MSI_FLAGS_REQUIRED,
+	.bus_select_mask	= MATCH_PLATFORM_MSI,
+	.bus_select_token	= DOMAIN_BUS_GENERIC_MSI,
+	.prefix			= "SEI-",
+	.init_dev_msi_info	= msi_lib_init_dev_msi_info,
+};
+
 static int mvebu_sei_probe(struct platform_device *pdev)
 {
 	struct device_node *node = pdev->dev.of_node;
-	struct irq_domain *plat_domain;
 	struct mvebu_sei *sei;
 	u32 parent_irq;
 	int ret;
@@ -440,33 +442,20 @@ static int mvebu_sei_probe(struct platform_device *pdev)
 	}
 
 	irq_domain_update_bus_token(sei->cp_domain, DOMAIN_BUS_GENERIC_MSI);
-
-	plat_domain = platform_msi_create_irq_domain(of_node_to_fwnode(node),
-						     &mvebu_sei_msi_domain_info,
-						     sei->cp_domain);
-	if (!plat_domain) {
-		pr_err("Failed to create CPs MSI domain\n");
-		ret = -ENOMEM;
-		goto remove_cp_domain;
-	}
+	sei->cp_domain->flags |= IRQ_DOMAIN_FLAG_MSI_PARENT;
+	sei->cp_domain->msi_parent_ops = &sei_msi_parent_ops;
 
 	mvebu_sei_reset(sei);
 
-	irq_set_chained_handler_and_data(parent_irq,
-					 mvebu_sei_handle_cascade_irq,
-					 sei);
-
+	irq_set_chained_handler_and_data(parent_irq, mvebu_sei_handle_cascade_irq, sei);
 	return 0;
 
-remove_cp_domain:
-	irq_domain_remove(sei->cp_domain);
 remove_ap_domain:
 	irq_domain_remove(sei->ap_domain);
 remove_sei_domain:
 	irq_domain_remove(sei->sei_domain);
 dispose_irq:
 	irq_dispose_mapping(parent_irq);
-
 	return ret;
 }
 
-- 
2.34.1


