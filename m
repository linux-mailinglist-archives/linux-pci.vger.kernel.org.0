Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B37DE6326F4
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 15:52:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbiKUOwU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 09:52:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbiKUOvz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 09:51:55 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B50CD9043;
        Mon, 21 Nov 2022 06:43:16 -0800 (PST)
Message-ID: <20221121140050.450294627@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669041611;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=JQNj2efQHu5+rY5wiZgLPG62/dR4d8wZTuePfy6MX5I=;
        b=WZM46VMuDWnGQidFfKDaLidgydx5WjMuaj/EUzPtBp9YBqrfO+ggWmqc8anMf9ig2Dnf/V
        lINuXizBV6HNAWenzAyXHCy8dItHQypiIA+YXlrf16JVw6xmRTw4uyq82ezqgkDl0H4zUY
        W/WLPugXnzvJ7IV+FHAoHGJpUYHuegd+hOoVnTj0g3AnJN5QDapxVtgt0NiuSBijXs+Uae
        oDq/sgIAt9CQ3j9fgciKsn0Zyy4Bv4XE7D6365dPgvKXla5QsHIoFgFnnIGwSuvPFAgRcJ
        N+BXmyRasREkPPlbj6rHYOd6VBvMZJBxnlRsQeRXyIdqOOhdmlmuU+cDMAv0aw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669041611;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=JQNj2efQHu5+rY5wiZgLPG62/dR4d8wZTuePfy6MX5I=;
        b=iY7zODOzabGxCsVgoG+R9UwXFnScPwXafGEgTeqKfmDpgQ57lm9bGVKu0PfY2vgcNExo5m
        80X4X+Oktzl/IQBw==
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
Subject: [patch V2 34/40] irqchip/irq-mvebu-icu: Prepare for real per device MSI
References: <20221121135653.208611233@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 21 Nov 2022 15:40:11 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The core infrastructure has everything in place to switch ICU to per
device MSI domains and avoid the convoluted construct of the existing
platform-MSI layering violation.

The new infrastructure provides a wired interrupt specific interface in the
MSI core which converts the 'hardware interrupt number + trigger type'
allocation which is required for wired interrupts in the regular irqdomain
code to a normal MSI allocation.

The hardware interrupt number and the trigger type are stored in the MSI
descriptor device cookie by the core code so the ICU specific code can
retrieve them.

The new per device domain is only instantiated when the irqdomain which is
associated to the ICU device provides MSI parent functionality. Up to
that point it invokes the existing code. Once the parent is converted the
code for the current platform-MSI mechanism is removed.

The new domain shares the interrupt chip callbacks and the translation
function. The only new functionality aside of filling out the
msi_domain_templates is a domain specific set_desc() callback, which will go
away once all platform-MSI code has been converted.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@bootlin.com>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
 drivers/irqchip/irq-mvebu-icu.c |  181 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 170 insertions(+), 11 deletions(-)

--- a/drivers/irqchip/irq-mvebu-icu.c
+++ b/drivers/irqchip/irq-mvebu-icu.c
@@ -20,6 +20,8 @@
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 
+#include "irq-gic-msi-lib.h"
+
 #include <dt-bindings/interrupt-controller/mvebu-icu.h>
 
 /* ICU registers */
@@ -60,14 +62,52 @@ struct mvebu_icu_msi_data {
 	const struct mvebu_icu_subset_data *subset_data;
 };
 
-struct mvebu_icu_irq_data {
-	struct mvebu_icu *icu;
-	unsigned int icu_group;
-	unsigned int type;
-};
-
 static DEFINE_STATIC_KEY_FALSE(legacy_bindings);
 
+static int mvebu_icu_translate(struct irq_domain *d, struct irq_fwspec *fwspec,
+			       unsigned long *hwirq, unsigned int *type)
+{
+	unsigned int param_count = static_branch_unlikely(&legacy_bindings) ? 3 : 2;
+	struct mvebu_icu_msi_data *msi_data = d->host_data;
+	struct mvebu_icu *icu = msi_data->icu;
+
+	/* Check the count of the parameters in dt */
+	if (WARN_ON(fwspec->param_count != param_count)) {
+		dev_err(icu->dev, "wrong ICU parameter count %d\n",
+			fwspec->param_count);
+		return -EINVAL;
+	}
+
+	if (static_branch_unlikely(&legacy_bindings)) {
+		*hwirq = fwspec->param[1];
+		*type = fwspec->param[2] & IRQ_TYPE_SENSE_MASK;
+		if (fwspec->param[0] != ICU_GRP_NSR) {
+			dev_err(icu->dev, "wrong ICU group type %x\n",
+				fwspec->param[0]);
+			return -EINVAL;
+		}
+	} else {
+		*hwirq = fwspec->param[0];
+		*type = fwspec->param[1] & IRQ_TYPE_SENSE_MASK;
+
+		/*
+		 * The ICU receives level interrupts. While the NSR are also
+		 * level interrupts, SEI are edge interrupts. Force the type
+		 * here in this case. Please note that this makes the interrupt
+		 * handling unreliable.
+		 */
+		if (msi_data->subset_data->icu_group == ICU_GRP_SEI)
+			*type = IRQ_TYPE_EDGE_RISING;
+	}
+
+	if (*hwirq >= ICU_MAX_IRQS) {
+		dev_err(icu->dev, "invalid interrupt number %ld\n", *hwirq);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static void mvebu_icu_init(struct mvebu_icu *icu,
 			   struct mvebu_icu_msi_data *msi_data,
 			   struct msi_msg *msg)
@@ -89,6 +129,14 @@ static void mvebu_icu_init(struct mvebu_
 	writel_relaxed(msg[1].address_lo, icu->base + subset->offset_clr_al);
 }
 
+/* Start of area to be removed once all parent chips provide MSI parent */
+
+struct mvebu_icu_irq_data {
+	struct mvebu_icu *icu;
+	unsigned int icu_group;
+	unsigned int type;
+};
+
 static void mvebu_icu_write_msg(struct msi_desc *desc, struct msi_msg *msg)
 {
 	struct irq_data *d = irq_get_irq_data(desc->irq);
@@ -269,6 +317,109 @@ static const struct irq_domain_ops mvebu
 	.free      = mvebu_icu_irq_domain_free,
 };
 
+/* End of removal area */
+
+static int mvebu_icu_msi_init(struct irq_domain *domain, struct msi_domain_info *info,
+			      unsigned int virq, irq_hw_number_t hwirq, msi_alloc_info_t *arg)
+{
+	irq_domain_set_hwirq_and_chip(domain, virq, hwirq, info->chip, info->chip_data);
+	return irq_set_irqchip_state(virq, IRQCHIP_STATE_PENDING, false);
+}
+
+static void mvebu_icu_set_desc(msi_alloc_info_t *arg, struct msi_desc *desc)
+{
+	arg->desc = desc;
+	arg->hwirq = (u32)desc->data.icookie.value;
+}
+
+static void mvebu_icu_write_msi_msg(struct irq_data *d, struct msi_msg *msg)
+{
+	struct mvebu_icu_msi_data *msi_data = d->chip_data;
+	unsigned int icu_group = msi_data->subset_data->icu_group;
+	struct msi_desc *desc = irq_data_get_msi_desc(d);
+	struct mvebu_icu *icu = msi_data->icu;
+	unsigned int type;
+	u32 icu_int;
+
+	if (msg->address_lo || msg->address_hi) {
+		/* One off initialization per domain */
+		mvebu_icu_init(icu, msi_data, msg);
+		/* Configure the ICU with irq number & type */
+		icu_int = msg->data | ICU_INT_ENABLE;
+		type = (unsigned int)(desc->data.icookie.value >> 32);
+		if (type & IRQ_TYPE_EDGE_RISING)
+			icu_int |= ICU_IS_EDGE;
+		icu_int |= icu_group << ICU_GROUP_SHIFT;
+	} else {
+		/* De-configure the ICU */
+		icu_int = 0;
+	}
+
+	writel_relaxed(icu_int, icu->base + ICU_INT_CFG(d->hwirq));
+
+	/*
+	 * The SATA unit has 2 ports, and a dedicated ICU entry per
+	 * port. The ahci sata driver supports only one irq interrupt
+	 * per SATA unit. To solve this conflict, we configure the 2
+	 * SATA wired interrupts in the south bridge into 1 GIC
+	 * interrupt in the north bridge. Even if only a single port
+	 * is enabled, if sata node is enabled, both interrupts are
+	 * configured (regardless of which port is actually in use).
+	 */
+	if (d->hwirq == ICU_SATA0_ICU_ID || d->hwirq == ICU_SATA1_ICU_ID) {
+		writel_relaxed(icu_int, icu->base + ICU_INT_CFG(ICU_SATA0_ICU_ID));
+		writel_relaxed(icu_int, icu->base + ICU_INT_CFG(ICU_SATA1_ICU_ID));
+	}
+}
+
+static const struct msi_domain_template mvebu_icu_nsr_msi_template = {
+	.chip = {
+		.name			= "ICU-NSR",
+		.irq_mask		= irq_chip_mask_parent,
+		.irq_unmask		= irq_chip_unmask_parent,
+		.irq_eoi		= irq_chip_eoi_parent,
+		.irq_set_type		= irq_chip_set_type_parent,
+		.irq_write_msi_msg	= mvebu_icu_write_msi_msg,
+		.flags			= IRQCHIP_SUPPORTS_LEVEL_MSI,
+	},
+
+	.ops = {
+		.msi_translate		= mvebu_icu_translate,
+		.msi_init		= mvebu_icu_msi_init,
+		.set_desc		= mvebu_icu_set_desc,
+	},
+
+	.info = {
+		.bus_token		= DOMAIN_BUS_WIRED_TO_MSI,
+		.flags			= MSI_FLAG_LEVEL_CAPABLE |
+					  MSI_FLAG_USE_DEV_FWNODE,
+	},
+};
+
+static const struct msi_domain_template mvebu_icu_sei_msi_template = {
+	.chip = {
+		.name			= "ICU-SEI",
+		.irq_mask		= irq_chip_mask_parent,
+		.irq_unmask		= irq_chip_unmask_parent,
+		.irq_ack		= irq_chip_ack_parent,
+		.irq_set_type		= irq_chip_set_type_parent,
+		.irq_write_msi_msg	= mvebu_icu_write_msi_msg,
+		.flags			= IRQCHIP_SUPPORTS_LEVEL_MSI,
+	},
+
+	.ops = {
+		.msi_translate		= mvebu_icu_translate,
+		.msi_init		= mvebu_icu_msi_init,
+		.set_desc		= mvebu_icu_set_desc,
+	},
+
+	.info = {
+		.bus_token		= DOMAIN_BUS_WIRED_TO_MSI,
+		.flags			= MSI_FLAG_LEVEL_CAPABLE |
+					  MSI_FLAG_USE_DEV_FWNODE,
+	},
+};
+
 static const struct mvebu_icu_subset_data mvebu_icu_nsr_subset_data = {
 	.icu_group = ICU_GRP_NSR,
 	.offset_set_ah = ICU_SETSPI_NSR_AH,
@@ -298,7 +449,6 @@ static const struct of_device_id mvebu_i
 static int mvebu_icu_subset_probe(struct platform_device *pdev)
 {
 	struct mvebu_icu_msi_data *msi_data;
-	struct device_node *msi_parent_dn;
 	struct device *dev = &pdev->dev;
 	struct irq_domain *irq_domain;
 
@@ -314,15 +464,24 @@ static int mvebu_icu_subset_probe(struct
 		msi_data->subset_data = of_device_get_match_data(dev);
 	}
 
-	dev->msi.domain = of_msi_get_domain(dev, dev->of_node,
-					    DOMAIN_BUS_PLATFORM_MSI);
+	dev->msi.domain = of_msi_get_domain(dev, dev->of_node, DOMAIN_BUS_PLATFORM_MSI);
 	if (!dev->msi.domain)
 		return -EPROBE_DEFER;
 
-	msi_parent_dn = irq_domain_get_of_node(dev->msi.domain);
-	if (!msi_parent_dn)
+	if (!irq_domain_get_of_node(dev->msi.domain))
 		return -ENODEV;
 
+	if (irq_domain_is_msi_parent(dev->msi.domain)) {
+		bool sei = msi_data->subset_data->icu_group == ICU_GRP_SEI;
+		const struct msi_domain_template *tmpl;
+
+		tmpl = sei ? &mvebu_icu_sei_msi_template : &mvebu_icu_nsr_msi_template;
+
+		if (!msi_create_device_irq_domain(dev, MSI_DEFAULT_DOMAIN, tmpl,
+						  ICU_MAX_IRQS, NULL, msi_data))
+			return -ENOMEM;
+	}
+
 	irq_domain = platform_msi_create_device_tree_domain(dev, ICU_MAX_IRQS,
 							    mvebu_icu_write_msg,
 							    &mvebu_icu_domain_ops,

