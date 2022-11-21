Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA8D2632716
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 15:57:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbiKUO5r (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 09:57:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231959AbiKUO4i (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 09:56:38 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE77CD14E1;
        Mon, 21 Nov 2022 06:47:22 -0800 (PST)
Message-ID: <20221121140050.514874045@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669041612;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=MWbome5dgm/wPYmMLcr+2vFNZotgfJG19zwD6ENHzgY=;
        b=HWoN44KmyafpTrxe6ukQ35xbvm2lQnIatKWOJR3CwzpHyHqEYi9TXM7ThjDPAcL9JTQN9d
        GJ5JUinAXVGHRQ5+Q/N7VLn0f5O9V8ziXYy3EvYUXzKbOZm5hfaWP0bvefbsXcRdm1O1VM
        crxRUVEGA6HTVP18CgeaMRijMvzn4mDrmSTkrq3t8FmkJj6UWMBp2p/ibCZWDtTNig3odc
        UjAG1XojBBej4P4fDiBC+Qbyhrz1os+epccZTyxiPWvmd+w2APnl/iFXaK9bq+4HD78h/T
        Dbh4W2Dya68SQqxY5hBVMPu+/rxic19kP4fW9Kn5xIZY0h7zGC18GqToNhpuFg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669041612;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=MWbome5dgm/wPYmMLcr+2vFNZotgfJG19zwD6ENHzgY=;
        b=aS68KBaR83xW3NNx1pE5zTjxAqACHvln9C6Du58Up/9KL0ohcWRLbx3uCul7Y6Dp0o8dYC
        g64BrRAEntnflfBA==
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
Subject: [patch V2 35/40] irqchip/mvebu-gicp: Switch to MSI parent
References: <20221121135653.208611233@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 21 Nov 2022 15:40:12 +0100 (CET)
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
 drivers/irqchip/Kconfig          |    1 
 drivers/irqchip/irq-mvebu-gicp.c |   44 ++++++++++++++++-----------------------
 2 files changed, 20 insertions(+), 25 deletions(-)

--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -373,6 +373,7 @@ config MSCC_OCELOT_IRQ
 	select GENERIC_IRQ_CHIP
 
 config MVEBU_GICP
+	select ARM_GIC_MSI_LIB
 	bool
 
 config MVEBU_ICU
--- a/drivers/irqchip/irq-mvebu-gicp.c
+++ b/drivers/irqchip/irq-mvebu-gicp.c
@@ -17,6 +17,8 @@
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 
+#include "irq-gic-msi-lib.h"
+
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 
 #define GICP_SETSPI_NSR_OFFSET	0x0
@@ -145,32 +147,32 @@ static void gicp_irq_domain_free(struct
 }
 
 static const struct irq_domain_ops gicp_domain_ops = {
+	.select	= gic_msi_lib_irq_domain_select,
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
+	.init_dev_msi_info	= gic_msi_lib_init_dev_msi_info,
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
@@ -233,17 +235,9 @@ static int mvebu_gicp_probe(struct platf
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
 

