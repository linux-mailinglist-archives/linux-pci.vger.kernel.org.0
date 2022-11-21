Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F380E632709
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 15:56:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbiKUO4R (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 09:56:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbiKUOz6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 09:55:58 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35730C845D;
        Mon, 21 Nov 2022 06:45:57 -0800 (PST)
Message-ID: <20221121140048.974974729@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669041582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=J680i1QxtZBBm/698AYzrsmPCp2I4TQ8+mHi4G7lF8s=;
        b=YEAcDoKFN2i4HVtKWLa93Rn3Nps5WvYcJZWF3OQBX/wCxYsjmB3/W+naIybJwtc5JKRWMu
        UiDIX9UCYQAVjw5qQ3wTY1RKTVq1L3eSAF5jkp3pxvkByrs8Mw+MIwt92R/E9yxF8XEaYa
        gJJRkH6mQ/tDvHAcA99s1suZuo5qEGBJp7IbGLZNRmD3T9uK7Gtq9xyOynHKBwFkbAeisF
        xoyGgmi95Qk+/TpW8JTT5VqDyoul3M71V6SXNTkLj/avRKqqmt+j1Di39KiBLgt2R7Nq/R
        0jeTEzL1ermxR4Z92SKpXbPimZTev/TvBiGMhTmZk+nLRQwcAq3HetmEAsO3gA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669041582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=J680i1QxtZBBm/698AYzrsmPCp2I4TQ8+mHi4G7lF8s=;
        b=CXynxs3icGJRX156kuitvZRrXMV4gIhHiX9TrvNmBx4NWbVOitTheb3WrmiC6M5iVzAKJ8
        68QizqSKkXZAc4Cw==
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
Subject: [patch V2 11/40] irqchip/gic-v3-its: Provide MSI parent infrastructure
References: <20221121135653.208611233@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 21 Nov 2022 15:39:42 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

To support per device MSI domains the ITS must provide MSI parent domain
functionality.

Provide the basic skeleton for this:

   - msi_parent_ops
   - child domain init callback
   - the MSI parent flag set in irqdomain::flags

This does not make ITS a functional parent domain as there is no bit set in
the bus_select_mask yet, but it provides the base to implement PCI and
platform MSI support gradualy on top.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/Kconfig                     |    1 
 drivers/irqchip/Makefile                    |    2 -
 drivers/irqchip/irq-gic-common.h            |    3 ++
 drivers/irqchip/irq-gic-v3-its-msi-parent.c |   30 ++++++++++++++++++++++++++++
 drivers/irqchip/irq-gic-v3-its.c            |    4 +++
 5 files changed, 39 insertions(+), 1 deletion(-)

--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -42,6 +42,7 @@ config ARM_GIC_V3
 config ARM_GIC_V3_ITS
 	bool
 	select GENERIC_MSI_IRQ
+	select ARM_GIC_MSI_LIB
 	default ARM_GIC_V3
 
 config ARM_GIC_V3_ITS_PCI
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -33,7 +33,7 @@ obj-$(CONFIG_ARCH_REALVIEW)		+= irq-gic-
 obj-$(CONFIG_ARM_GIC_MSI_LIB)		+= irq-gic-msi-lib.o
 obj-$(CONFIG_ARM_GIC_V2M)		+= irq-gic-v2m.o
 obj-$(CONFIG_ARM_GIC_V3)		+= irq-gic-v3.o irq-gic-v3-mbi.o irq-gic-common.o
-obj-$(CONFIG_ARM_GIC_V3_ITS)		+= irq-gic-v3-its.o irq-gic-v3-its-platform-msi.o irq-gic-v4.o
+obj-$(CONFIG_ARM_GIC_V3_ITS)		+= irq-gic-v3-its.o irq-gic-v3-its-platform-msi.o irq-gic-v4.o irq-gic-v3-its-msi-parent.o
 obj-$(CONFIG_ARM_GIC_V3_ITS_PCI)	+= irq-gic-v3-its-pci-msi.o
 obj-$(CONFIG_ARM_GIC_V3_ITS_FSL_MC)	+= irq-gic-v3-its-fsl-mc-msi.o
 obj-$(CONFIG_PARTITION_PERCPU)		+= irq-partition-percpu.o
--- a/drivers/irqchip/irq-gic-common.h
+++ b/drivers/irqchip/irq-gic-common.h
@@ -8,6 +8,7 @@
 
 #include <linux/of.h>
 #include <linux/irqdomain.h>
+#include <linux/msi.h>
 #include <linux/irqchip/arm-gic-common.h>
 
 struct gic_quirk {
@@ -28,4 +29,6 @@ void gic_enable_quirks(u32 iidr, const s
 void gic_enable_of_quirks(const struct device_node *np,
 			  const struct gic_quirk *quirks, void *data);
 
+extern const struct msi_parent_ops gic_v3_its_msi_parent_ops;
+
 #endif /* _IRQ_GIC_COMMON_H */
--- /dev/null
+++ b/drivers/irqchip/irq-gic-v3-its-msi-parent.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (C) 2022 Linutronix GmbH
+// Copyright (C) 2022 Intel
+
+#include "irq-gic-common.h"
+#include "irq-gic-msi-lib.h"
+
+#define ITS_MSI_FLAGS_REQUIRED  (MSI_FLAG_USE_DEF_DOM_OPS |	\
+				 MSI_FLAG_USE_DEF_CHIP_OPS)
+
+#define ITS_MSI_FLAGS_SUPPORTED (MSI_GENERIC_FLAGS_MASK |	\
+				 MSI_FLAG_PCI_MSIX      |	\
+				 MSI_FLAG_MULTI_PCI_MSI)
+
+static bool its_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
+				  struct irq_domain *real_parent, struct msi_domain_info *info)
+{
+	if (!gic_msi_lib_init_dev_msi_info(dev, domain, real_parent, info))
+		return false;
+
+	return true;
+}
+
+const struct msi_parent_ops gic_v3_its_msi_parent_ops = {
+	.supported_flags	= ITS_MSI_FLAGS_SUPPORTED,
+	.required_flags		= ITS_MSI_FLAGS_REQUIRED,
+	.bus_select_token	= DOMAIN_BUS_NEXUS,
+	.prefix			= "ITS-",
+	.init_dev_msi_info	= its_init_dev_msi_info,
+};
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -38,6 +38,7 @@
 #include <asm/exception.h>
 
 #include "irq-gic-common.h"
+#include "irq-gic-msi-lib.h"
 
 #define ITS_FLAGS_CMDQ_NEEDS_FLUSHING		(1ULL << 0)
 #define ITS_FLAGS_WORKAROUND_CAVIUM_22375	(1ULL << 1)
@@ -3656,6 +3657,7 @@ static void its_irq_domain_free(struct i
 }
 
 static const struct irq_domain_ops its_domain_ops = {
+	.select			= gic_msi_lib_irq_domain_select,
 	.alloc			= its_irq_domain_alloc,
 	.free			= its_irq_domain_free,
 	.activate		= its_irq_domain_activate,
@@ -4918,6 +4920,8 @@ static int its_init_domain(struct fwnode
 	inner_domain->parent = its_parent;
 	irq_domain_update_bus_token(inner_domain, DOMAIN_BUS_NEXUS);
 	inner_domain->flags |= its->msi_domain_flags;
+	inner_domain->msi_parent_ops = &gic_v3_its_msi_parent_ops;
+	inner_domain->flags |= IRQ_DOMAIN_FLAG_MSI_PARENT;
 	info->ops = &its_msi_domain_ops;
 	info->data = its;
 	inner_domain->host_data = info;

