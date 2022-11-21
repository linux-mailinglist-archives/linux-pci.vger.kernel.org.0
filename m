Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C39ED6326EC
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 15:51:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbiKUOv4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 09:51:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbiKUOvV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 09:51:21 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3920D5A16;
        Mon, 21 Nov 2022 06:43:01 -0800 (PST)
Message-ID: <20221121140050.577105827@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669041613;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=iMSiO35Q4nvqZnp/wnDAlFhYvzI37wmUM9mH/DHSckY=;
        b=KSocjNeRJrC3ExVVlFIpdGXfkPZikicdmxhwqpVLEvE02aVnHCgmWUiumDo5550RX0DqfP
        3AXLtn4ahhEdl/FmzyKSDljzwyCNLfmCVI9BhE2UOC391CLPc8plNzamAQll3Dvy8lUcJh
        Vm7/9jRpBiVvHQLy+5DICLjH7pOnd+sC8lXGTq1mSWfwfKcm8dUnNG940HupgIW2+tp5jx
        5XeC3gmMnG3E0T+13QDLA17qT7ZZ+CMIRaSDZTekgJcAR3jv+dHDPmKUY0mHdxr/OcMhCk
        E5XtyDzG7dKgXEo6nZZuc3ciYBUlV4ion9s9CG1JLIhA6T6wyBPItw8VgM10zQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669041613;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=iMSiO35Q4nvqZnp/wnDAlFhYvzI37wmUM9mH/DHSckY=;
        b=TvgWE26In1d44LFP7SA1WqKMrQFhhbqs7Wl4wsrLhksZY8jBfZXbJ9kHiv9CSa9ubjdwf6
        WJFNOnZVQsFwdZBg==
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
Subject: [patch V2 36/40] irqchip/mvebu-odmi: Switch to parent MSI
References: <20221121135653.208611233@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 21 Nov 2022 15:40:13 +0100 (CET)
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
 drivers/irqchip/Kconfig          |    1 +
 drivers/irqchip/irq-mvebu-odmi.c |   39 ++++++++++++++++++---------------------
 2 files changed, 19 insertions(+), 21 deletions(-)

--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -381,6 +381,7 @@ config MVEBU_ICU
 
 config MVEBU_ODMI
 	bool
+	select ARM_GIC_MSI_LIB
 	select GENERIC_MSI_IRQ
 
 config MVEBU_PIC
--- a/drivers/irqchip/irq-mvebu-odmi.c
+++ b/drivers/irqchip/irq-mvebu-odmi.c
@@ -17,6 +17,9 @@
 #include <linux/msi.h>
 #include <linux/of_address.h>
 #include <linux/slab.h>
+
+#include "irq-gic-msi-lib.h"
+
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 
 #define GICP_ODMIN_SET			0x40
@@ -141,27 +144,29 @@ static void odmi_irq_domain_free(struct
 }
 
 static const struct irq_domain_ops odmi_domain_ops = {
+	.select	= gic_msi_lib_irq_domain_select,
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
+#define ODMI_MSI_FLAGS_SUPPORTED (MSI_GENERIC_FLAGS_MASK)
 
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
+	.init_dev_msi_info	= gic_msi_lib_init_dev_msi_info,
 };
 
 static int __init mvebu_odmi_init(struct device_node *node,
 				  struct device_node *parent)
 {
-	struct irq_domain *inner_domain, *plat_domain;
+	struct irq_domain *inner_domain;
 	int ret, i;
 
 	if (of_property_read_u32(node, "marvell,odmi-frames", &odmis_count))
@@ -206,19 +211,11 @@ static int __init mvebu_odmi_init(struct
 	}
 
 	inner_domain->parent = irq_find_host(parent);
-
-	plat_domain = platform_msi_create_irq_domain(of_node_to_fwnode(node),
-						     &odmi_msi_domain_info,
-						     inner_domain);
-	if (!plat_domain) {
-		ret = -ENOMEM;
-		goto err_remove_inner;
-	}
-
+	irq_domain_update_bus_token(inner_domain, DOMAIN_BUS_GENERIC_MSI);
+	inner_domain->flags |= IRQ_DOMAIN_FLAG_MSI_PARENT;
+	inner_domain->msi_parent_ops = &odmi_msi_parent_ops;
 	return 0;
 
-err_remove_inner:
-	irq_domain_remove(inner_domain);
 err_unmap:
 	for (i = 0; i < odmis_count; i++) {
 		struct odmi_data *odmi = &odmis[i];

