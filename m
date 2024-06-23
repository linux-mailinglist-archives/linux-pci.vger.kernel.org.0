Return-Path: <linux-pci+bounces-9152-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE78913C32
	for <lists+linux-pci@lfdr.de>; Sun, 23 Jun 2024 17:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D56FE286F83
	for <lists+linux-pci@lfdr.de>; Sun, 23 Jun 2024 15:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D26187549;
	Sun, 23 Jun 2024 15:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RzpHatcC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AFA81dxm"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612911891B9;
	Sun, 23 Jun 2024 15:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719155946; cv=none; b=NpID124SxPUsMoGYwzeoHM2tps0RJA2yz6Hg7uFGFuV/mFcPztrNSb+xY0Pgut9DrJIvJxCh+AOMaPsEGkuZTUZmRZf2PXYrifcDrXMmnMnePhzImQtujb/C8lLMu6N85HCT8hcUzNjPYrTLSkY2SRruQLDpIDNSm8XP/+qsbms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719155946; c=relaxed/simple;
	bh=2Sn9M798R3yxrv029hBIrMdm9tJ6X6XPnUsxP1vIlYw=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=ribmUI/yWTm+wQnUP28cK17v7cwZnIgDguJbf3QIYtqFUvdIRuPATY4G4Z+QqgT9nMivEVbT0Q+ZkKVfHXocw0VMzNlV75kwHHAwYb5ZGyNwIGJkt10u1oiVmK2dbSBEbfopQfA5tSNZp7MFvSwO0L++IRT+1bpMqALN2rIvmCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RzpHatcC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AFA81dxm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240623142235.820275215@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719155942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=nGWDOjtyMSm8zvDkeUOY0e05Vmhq/G0vpnyhDGefeGY=;
	b=RzpHatcC8WgJJNlzwqgZOWEKtuuDZo6q1F4/xLu79gBfWjMhwVCRALI9slW0oVPwqSP/9o
	bSHZ5JeIjzHXOLcBdnParkwtfF8ZMb0DEf+5aX9qHaENBrGH7KyFcybDe0tgvbsjS9M25V
	U/f0H5TCXwV+Q5nKzAuUIVRoXWZWCzrs/7PTjXytzalS2qSTvwokt9p+dL4SO6IOz4ZNXt
	u52lhuvyd4/MmIFgYY0+6nJLhIlZa0hXMJcLvzWJoCj7t1JGfMFicx1VyCN87GAK4eYMdn
	vMXqfsJMz39gJz31H7jRnZr+b/yup+7GYmW9LAxR2zL8KvYBtn4D8pGL1Me7Kw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719155942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=nGWDOjtyMSm8zvDkeUOY0e05Vmhq/G0vpnyhDGefeGY=;
	b=AFA81dxmdiX4VBL2yfNSZhA2suE3lAWThtmEDuI5R80HeASln5zixNHSD61uY4TSfH4imw
	r8fqYIdk64XA+1CA==
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
Subject: [patch V4 18/21] irqchip/irq-mvebu-sei: Switch to MSI parent
References: <20240623142137.448898081@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Sun, 23 Jun 2024 17:19:02 +0200 (CEST)

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
 drivers/irqchip/irq-mvebu-sei.c |   52 +++++++++++++++-------------------------
 1 file changed, 20 insertions(+), 32 deletions(-)

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
@@ -190,6 +192,7 @@ static void mvebu_sei_domain_free(struct
 }
 
 static const struct irq_domain_ops mvebu_sei_domain_ops = {
+	.select	= msi_lib_irq_domain_select,
 	.alloc	= mvebu_sei_domain_alloc,
 	.free	= mvebu_sei_domain_free,
 };
@@ -307,21 +310,6 @@ static const struct irq_domain_ops mvebu
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
@@ -360,10 +348,23 @@ static void mvebu_sei_reset(struct mvebu
 	}
 }
 
+#define SEI_MSI_FLAGS_REQUIRED	(MSI_FLAG_USE_DEF_DOM_OPS |	\
+				 MSI_FLAG_USE_DEF_CHIP_OPS)
+
+#define SEI_MSI_FLAGS_SUPPORTED	(MSI_GENERIC_FLAGS_MASK)
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
@@ -440,33 +441,20 @@ static int mvebu_sei_probe(struct platfo
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
 


