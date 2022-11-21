Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12CD56326E5
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 15:51:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231795AbiKUOve (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 09:51:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231847AbiKUOuz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 09:50:55 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F05D5388;
        Mon, 21 Nov 2022 06:42:53 -0800 (PST)
Message-ID: <20221121140050.386216606@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669041610;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=nXitai8NNW5ZoGV4iB4WLsBQcUEV2ql1w841y8zrkC4=;
        b=ZYjAx1f+bZbDKdv0NCiPkFN8hoq6CJWlh96007mt0tRK0Ub323b+2n517CIn0+NrKI0snq
        4m32CtJ6w+66nzOz7nnHU2Ae6NJGZaq/QDWLulrNXg1KVZAK37sdI9NKZgxLg9pllh4TJc
        pBM3J8f8kHcz4v+5tRqEJElXW2LacXj8w8Pv2ljOuhIkAmBFMCQefIOgu8W/JSnUGhH/5A
        nnWC60NaYZZf8pdR82dGpLivH139/emTx4OQg0Q0OnvobUm02Qds0CsU/Z0zdK5KQiT6Xd
        Dhp+Dm1uI0MjfoRze8bR2A0PhBwyoZqa1cFlCEXqpZrP7pMDI8FLJPHAPHbp4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669041610;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=nXitai8NNW5ZoGV4iB4WLsBQcUEV2ql1w841y8zrkC4=;
        b=hVEfbaTkojXgD9cFeu7P71Xwu6mIMOCS255HaFo1vemiQOefBL/PBPbky/jxxsmaJJ7YQr
        MTYUcEIZIv9lIgBA==
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
Subject: [patch V2 33/40] irqchip/imx-mu-msi: Switch to MSI parent
References: <20221121135653.208611233@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 21 Nov 2022 15:40:09 +0100 (CET)
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
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
---
 drivers/irqchip/Kconfig           |    1 
 drivers/irqchip/irq-gic-msi-lib.c |    2 +
 drivers/irqchip/irq-imx-mu-msi.c  |   53 +++++++++++++++-----------------------
 3 files changed, 25 insertions(+), 31 deletions(-)

--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -494,6 +494,7 @@ config IMX_MU_MSI
 	select IRQ_DOMAIN
 	select IRQ_DOMAIN_HIERARCHY
 	select GENERIC_MSI_IRQ
+	select ARM_GIC_MSI_LIB
 	help
 	  Provide a driver for the i.MX Messaging Unit block used as a
 	  CPU-to-CPU MSI controller. This requires a specially crafted DT
--- a/drivers/irqchip/irq-gic-msi-lib.c
+++ b/drivers/irqchip/irq-gic-msi-lib.c
@@ -90,6 +90,8 @@ bool gic_msi_lib_init_dev_msi_info(struc
 	/* Chip updates for all child bus types */
 	if (!info->chip->irq_eoi)
 		info->chip->irq_eoi	= irq_chip_eoi_parent;
+	if (!info->chip->irq_ack)
+		info->chip->irq_ack	= irq_chip_ack_parent;
 
 	/*
 	 * The device MSI domain can never have a set affinity callback it
--- a/drivers/irqchip/irq-imx-mu-msi.c
+++ b/drivers/irqchip/irq-imx-mu-msi.c
@@ -24,6 +24,8 @@
 #include <linux/pm_domain.h>
 #include <linux/spinlock.h>
 
+#include "irq-gic-msi-lib.h"
+
 #define IMX_MU_CHANS            4
 
 enum imx_mu_xcr {
@@ -114,20 +116,6 @@ static void imx_mu_msi_parent_ack_irq(st
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
@@ -195,6 +183,7 @@ static void imx_mu_msi_domain_irq_free(s
 }
 
 static const struct irq_domain_ops imx_mu_msi_domain_ops = {
+	.select	= gic_msi_lib_irq_domain_select,
 	.alloc	= imx_mu_msi_domain_irq_alloc,
 	.free	= imx_mu_msi_domain_irq_free,
 };
@@ -216,35 +205,37 @@ static void imx_mu_msi_irq_handler(struc
 	chained_irq_exit(chip, desc);
 }
 
+#define IMX_MU_MSI_FLAGS_REQUIRED	(MSI_FLAG_USE_DEF_DOM_OPS |	\
+					 MSI_FLAG_USE_DEF_CHIP_OPS |	\
+					 MSI_FLAG_PARENT_PM_DEV)
+
+#define IMX_MU_MSI_FLAGS_SUPPORTED	(MSI_GENERIC_FLAGS_MASK)
+
+static const struct msi_parent_ops imx_mu_msi_parent_ops = {
+	.supported_flags	= IMX_MU_MSI_FLAGS_SUPPORTED,
+	.required_flags		= IMX_MU_MSI_FLAGS_REQUIRED,
+	.bus_select_token       = DOMAIN_BUS_NEXUS,
+	.bus_select_mask	= MATCH_PLATFORM_MSI,
+	.prefix			= "MU-MSI-",
+	.init_dev_msi_info	= gic_msi_lib_init_dev_msi_info,
+};
+
 static int imx_mu_msi_domains_init(struct imx_mu_msi *msi_data, struct device *dev)
 {
 	struct fwnode_handle *fwnodes = dev_fwnode(dev);
 	struct irq_domain *parent;
 
 	/* Initialize MSI domain parent */
-	parent = irq_domain_create_linear(fwnodes,
-					    IMX_MU_CHANS,
-					    &imx_mu_msi_domain_ops,
-					    msi_data);
+	parent = irq_domain_create_linear(fwnodes, IMX_MU_CHANS, &imx_mu_msi_domain_ops, msi_data);
 	if (!parent) {
 		dev_err(dev, "failed to create IRQ domain\n");
 		return -ENOMEM;
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
 

