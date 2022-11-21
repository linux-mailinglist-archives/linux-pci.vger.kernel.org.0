Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 798786326EE
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 15:52:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbiKUOv5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 09:51:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbiKUOv0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 09:51:26 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E48E4D5A30;
        Mon, 21 Nov 2022 06:43:03 -0800 (PST)
Message-ID: <20221121140050.641539198@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669041615;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=KSViuYfTgwiHqkPMr1cUO/yCmI9Us9ItW7WKAB/O6sg=;
        b=TF/TaBfwalYY5NgIJvtoZFDbRkhnGrzMqYByARVAjPQD208VbMxlMByf7oCpn1dBdPx6Ba
        9AXFefRbsQBtcYpTtq57xSYKrQ6JPQf8TXGla4yopmDGytM5n9OnNShTd0JvjDl47Yh/p0
        enCSbzITWBiieEmgHjCHvf/Picn9ZI2EbJY7sWYgnTXWfCbkib9JBSXwTWcTlRkj5BBUQt
        ZPsxpQtYRi9uiDA7ppMOzrCBYI91QoiZw/fILIhGnWr9UoeAZmkmestMvBrTA8AgvQP40H
        h0UiXTk+4I98S3gA475TcUc0cS27+SzqmxwjNnwMxjlBpijNCupoLmb/JsRsow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669041615;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=KSViuYfTgwiHqkPMr1cUO/yCmI9Us9ItW7WKAB/O6sg=;
        b=EjjOyWfYMyGc/VU5HDpQ282qtw6nnDB+5MCi4oGoq6k4qqXDzQCAqKPML/V8jR1SIwM4dX
        uWR5vzo+NWYU+wBA==
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
Subject: [patch V2 37/40] irqchip/irq-mvebu-sei: Switch to MSI parent
References: <20221121135653.208611233@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 21 Nov 2022 15:40:14 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

All platform MSI users and the PCI/MSI code handle per device MSI domains
when the irqdomain associated to the device provides MSI parent
functionality.

Remove the "global" platform domain related code and provide the MSI parent
functionality by filling in msi_parent_ops.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@bootlin.com>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
 drivers/irqchip/irq-mvebu-sei.c |   52 +++++++++++++++-------------------------
 1 file changed, 20 insertions(+), 32 deletions(-)

--- a/drivers/irqchip/irq-mvebu-sei.c
+++ b/drivers/irqchip/irq-mvebu-sei.c
@@ -14,6 +14,8 @@
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
 
+#include "irq-gic-msi-lib.h"
+
 /* Cause register */
 #define GICP_SECR(idx)		(0x0  + ((idx) * 0x4))
 /* Mask register */
@@ -190,6 +192,7 @@ static void mvebu_sei_domain_free(struct
 }
 
 static const struct irq_domain_ops mvebu_sei_domain_ops = {
+	.select	= gic_msi_lib_irq_domain_select,
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
+	.init_dev_msi_info	= gic_msi_lib_init_dev_msi_info,
+};
+
 static int mvebu_sei_probe(struct platform_device *pdev)
 {
 	struct device_node *node = pdev->dev.of_node;
-	struct irq_domain *plat_domain;
 	struct mvebu_sei *sei;
 	u32 parent_irq;
 	int ret;
@@ -441,33 +442,20 @@ static int mvebu_sei_probe(struct platfo
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
 

