Return-Path: <linux-pci+bounces-9149-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7284A913C2C
	for <lists+linux-pci@lfdr.de>; Sun, 23 Jun 2024 17:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95A911C208DD
	for <lists+linux-pci@lfdr.de>; Sun, 23 Jun 2024 15:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7DBF18754C;
	Sun, 23 Jun 2024 15:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OrydrbOY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mTiwwIWB"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5C0186E4B;
	Sun, 23 Jun 2024 15:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719155940; cv=none; b=bYWmLwakjtPttH/+E0/WSKo4S/SfanpTzeySBsp9jbQ5uM9TmVxspyYGMm7lebf74zrFXGjsjmQW/xRnYhNiN/yzkJqEi1aTsOYeZ4ORE5htyA2QCI4miei6pvj5I9MuwrjrkAUj2CZA5pkkjWDLLbV5DpxeFAIMi9j5+vb0u+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719155940; c=relaxed/simple;
	bh=E6qjPEEYwVmw+F4gqTEKSAvsF63jIWc0obp5peBUnnA=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=bfb9Uvi46COWNH/tp67pe9aQw95qD6HUGO2gLgM2yBBurBC4YZLfvUaTiwgDwbg2j5s7yUC7Nri9Nn3vaEQXr8XGThkZNW56w0L3usycONvxKm2bgaVrggMzm22ESDVarCGznw3FZGZU13/1zfaJA+g+NvcpGNhVG8eEKH9k28M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OrydrbOY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mTiwwIWB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240623142235.635015886@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719155937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=WVDuduzaV0/NeHCSHHMPqtE30cncmaLGfawg765I8yw=;
	b=OrydrbOYbU5fXP3HIlMx4WVB/1mriKWZtneS6oJ7JCWx4Pa/2AUZKhrMNAkt7k3GW4JZZT
	gRnJv9ceRXnmz9wfgGmPgsCSM212No83MrSMNOX9P45ueUPEzAtrqWiy4XiNbzQpxqMWT5
	fLJmVrIkI/VgccssVS+gSwqD/cpHD5yomz5DZetKlHt1cNevqomcKogfHqMP++662eGC6t
	mxzre+4LnUj3cHC3spz0eZA3fN88eoLLevgU+yQGxkyLtdMCY7/sztB88LUFbVOL7DQAM4
	6+00vzIyvX+yq5tYKafU+Kp2nk2f8KQfXGSl6ozK7eDBztI1CQQvHaQtCu5rUg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719155937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=WVDuduzaV0/NeHCSHHMPqtE30cncmaLGfawg765I8yw=;
	b=mTiwwIWBZYNK56HlKxfWJqV8xXn91nuQCTtMIu8chqdUV7glv/y833CGovUXvOetCN+2fh
	kcjtjC/wjRKYTuAA==
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
Subject: [patch V4 15/21] irqchip/irq-mvebu-icu: Prepare for real per device
 MSI
References: <20240623142137.448898081@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Sun, 23 Jun 2024 17:18:56 +0200 (CEST)

From: Thomas Gleixner <tglx@linutronix.de>

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
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>


---
 drivers/irqchip/irq-mvebu-icu.c | 181 ++++++++++++++++++++++++++++++--
 1 file changed, 170 insertions(+), 11 deletions(-)

diff --git a/drivers/irqchip/irq-mvebu-icu.c b/drivers/irqchip/irq-mvebu-icu.c
index 3c77acc7ec6a..2a210cd9482e 100644
--- a/drivers/irqchip/irq-mvebu-icu.c
+++ b/drivers/irqchip/irq-mvebu-icu.c
@@ -20,6 +20,8 @@
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 
+#include "irq-msi-lib.h"
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
@@ -89,6 +129,14 @@ static void mvebu_icu_init(struct mvebu_icu *icu,
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
@@ -269,6 +317,109 @@ static const struct irq_domain_ops mvebu_icu_domain_ops = {
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
@@ -298,7 +449,6 @@ static const struct of_device_id mvebu_icu_subset_of_match[] = {
 static int mvebu_icu_subset_probe(struct platform_device *pdev)
 {
 	struct mvebu_icu_msi_data *msi_data;
-	struct device_node *msi_parent_dn;
 	struct device *dev = &pdev->dev;
 	struct irq_domain *irq_domain;
 
@@ -314,15 +464,24 @@ static int mvebu_icu_subset_probe(struct platform_device *pdev)
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
-- 
2.34.1



