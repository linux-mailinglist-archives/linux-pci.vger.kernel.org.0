Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC9D06326D6
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 15:50:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbiKUOud (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 09:50:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbiKUOtr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 09:49:47 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15FF3D48D3;
        Mon, 21 Nov 2022 06:42:24 -0800 (PST)
Message-ID: <20221121140049.807060253@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669041598;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=FKeWOHgG+aHIXBCujh1JES3kINokE+MytWoAnu2BWBo=;
        b=qpTzA5pDWuxLVdyFMtO6/TMmtYgjp6g69hOtYoU5lf+erQvfYb2MGr190Z27zK3RW7ocW6
        VaiUWDem6lQexzCwcH0nZQzaxrMB3W0WTeo5CVcwGev8yl6E9L4y8l8QxvkTU2RAl+MQcI
        /E9LialgECosISytwvcLi+99PhZr5/b4PENSoY9XYxA1CZtW6nhDqnmzZ54bPyCBrS3rVG
        SvFp+vhAAzOOEhgbXz0j6fNrUQ4RgyFP8nYV3x0J5iYJ6ZVVSUbNJHqG3n6DR/cjmWoqaV
        8BgURHFsQK0AZ3LI1zc+zvndbm5pDyhedPBdonpY7Dlyigc9yWnloDwfI2zzVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669041598;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=FKeWOHgG+aHIXBCujh1JES3kINokE+MytWoAnu2BWBo=;
        b=KHn7pDOVwpDBH1OyyefDBTTQc9TR/pjDnWNMzDLDTvr0sx9OEct6SJme9etfQBYaTQMhAo
        YhOnzZXa6BV/zFBg==
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
Subject: [patch V2 24/40] irqchip/mbigen: Prepare for real per device MSI
References: <20221121135653.208611233@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 21 Nov 2022 15:39:58 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The core infrastructure has everything in place to switch MBIGEN to per
device MSI domains and avoid the convoluted construct of the existing
platform-MSI layering violation.

The new infrastructure provides a wired interrupt specific interface in the
MSI core which converts the 'hardware interrupt number + trigger type'
allocation which is required for wired interrupts in the regular irqdomain
code to a normal MSI allocation.

The hardware interrupt number and the trigger type are stored in the MSI
descriptor device cookie by the core code so the MBIGEN specific code can
retrieve them.

The new per device domain is only instantiated when the irqdomain which is
associated to the MBIGEN device provides MSI parent functionality. Up to
that point it invokes the existing code. Once the parent is converted the
code for the current platform-MSI mechanism is removed.

The new domain shares the interrupt chip callbacks and the translation
function. The only new functionality aside of filling out the
msi_domain_template is a domain specific set_desc() callback, which will go
away once all platform-MSI code has been converted.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc: Zenghui Yu <yuzenghui@huawei.com>
---
 drivers/irqchip/irq-mbigen.c |  100 ++++++++++++++++++++++++++++++-------------
 1 file changed, 71 insertions(+), 29 deletions(-)

--- a/drivers/irqchip/irq-mbigen.c
+++ b/drivers/irqchip/irq-mbigen.c
@@ -135,24 +135,14 @@ static int mbigen_set_type(struct irq_da
 	return 0;
 }
 
-static struct irq_chip mbigen_irq_chip = {
-	.name =			"mbigen-v2",
-	.irq_mask =		irq_chip_mask_parent,
-	.irq_unmask =		irq_chip_unmask_parent,
-	.irq_eoi =		mbigen_eoi_irq,
-	.irq_set_type =		mbigen_set_type,
-	.irq_set_affinity =	irq_chip_set_affinity_parent,
-};
-
-static void mbigen_write_msg(struct msi_desc *desc, struct msi_msg *msg)
+static void mbigen_write_msi_msg(struct irq_data *d, struct msi_msg *msg)
 {
-	struct irq_data *d = irq_get_irq_data(desc->irq);
 	void __iomem *base = d->chip_data;
 	u32 val;
 
 	if (!msg->address_lo && !msg->address_hi)
 		return;
- 
+
 	base += get_mbigen_vec_reg(d->hwirq);
 	val = readl_relaxed(base);
 
@@ -165,10 +155,8 @@ static void mbigen_write_msg(struct msi_
 	writel_relaxed(val, base);
 }
 
-static int mbigen_domain_translate(struct irq_domain *d,
-				    struct irq_fwspec *fwspec,
-				    unsigned long *hwirq,
-				    unsigned int *type)
+static int mbigen_domain_translate(struct irq_domain *d, struct irq_fwspec *fwspec,
+				   unsigned long *hwirq, unsigned int *type)
 {
 	if (is_of_node(fwspec->fwnode) || is_acpi_device_node(fwspec->fwnode)) {
 		if (fwspec->param_count != 2)
@@ -192,6 +180,17 @@ static int mbigen_domain_translate(struc
 	return -EINVAL;
 }
 
+/* The following section will go away once ITS provides a MSI parent */
+
+static struct irq_chip mbigen_irq_chip = {
+	.name =			"mbigen-v2",
+	.irq_mask =		irq_chip_mask_parent,
+	.irq_unmask =		irq_chip_unmask_parent,
+	.irq_eoi =		mbigen_eoi_irq,
+	.irq_set_type =		mbigen_set_type,
+	.irq_set_affinity =	irq_chip_set_affinity_parent,
+};
+
 static int mbigen_irq_domain_alloc(struct irq_domain *domain,
 					unsigned int virq,
 					unsigned int nr_irqs,
@@ -232,13 +231,65 @@ static const struct irq_domain_ops mbige
 	.free		= mbigen_irq_domain_free,
 };
 
+static void mbigen_write_msg(struct msi_desc *desc, struct msi_msg *msg)
+{
+	mbigen_write_msi_msg(irq_get_irq_data(desc->irq), msg);
+}
+
+/* End of to be removed section */
+
+static void mbigen_domain_set_desc(msi_alloc_info_t *arg, struct msi_desc *desc)
+{
+	arg->desc = desc;
+	arg->hwirq = (u32)desc->data.icookie.value;
+}
+
+static const struct msi_domain_template mbigen_msi_template = {
+	.chip = {
+		.name			= "mbigen-v2",
+		.irq_mask		= irq_chip_mask_parent,
+		.irq_unmask		= irq_chip_unmask_parent,
+		.irq_eoi		= mbigen_eoi_irq,
+		.irq_set_type		= mbigen_set_type,
+		.irq_write_msi_msg	= mbigen_write_msi_msg,
+	},
+
+	.ops = {
+		.set_desc		= mbigen_domain_set_desc,
+		.msi_translate		= mbigen_domain_translate,
+	},
+
+	.info = {
+		.bus_token		= DOMAIN_BUS_WIRED_TO_MSI,
+		.flags			= MSI_FLAG_USE_DEV_FWNODE,
+	},
+};
+
+static bool mbigen_create_device_domain(struct device *dev, unsigned int size,
+					struct mbigen_device *mgn_chip)
+{
+	struct irq_domain *domain = dev->msi.domain;
+
+	if (WARN_ON_ONCE(!domain))
+		return false;
+
+	if (irq_domain_is_msi_parent(domain)) {
+		return msi_create_device_irq_domain(dev, MSI_DEFAULT_DOMAIN,
+						    &mbigen_msi_template, size,
+						    NULL, mgn_chip->base);
+	}
+
+	/* Remove once ITS provides MSI parent */
+	return !!platform_msi_create_device_domain(dev, size, mbigen_write_msg,
+						   &mbigen_domain_ops, mgn_chip);
+}
+
 static int mbigen_of_create_domain(struct platform_device *pdev,
 				   struct mbigen_device *mgn_chip)
 {
-	struct device *parent;
 	struct platform_device *child;
-	struct irq_domain *domain;
 	struct device_node *np;
+	struct device *parent;
 	u32 num_pins;
 
 	for_each_child_of_node(pdev->dev.of_node, np) {
@@ -259,11 +310,7 @@ static int mbigen_of_create_domain(struc
 			return -EINVAL;
 		}
 
-		domain = platform_msi_create_device_domain(&child->dev, num_pins,
-							   mbigen_write_msg,
-							   &mbigen_domain_ops,
-							   mgn_chip);
-		if (!domain) {
+		if (!mbigen_create_device_domain(&child->dev, num_pins, mgn_chip)) {
 			of_node_put(np);
 			return -ENOMEM;
 		}
@@ -282,7 +329,6 @@ MODULE_DEVICE_TABLE(acpi, mbigen_acpi_ma
 static int mbigen_acpi_create_domain(struct platform_device *pdev,
 				     struct mbigen_device *mgn_chip)
 {
-	struct irq_domain *domain;
 	u32 num_pins = 0;
 	int ret;
 
@@ -313,11 +359,7 @@ static int mbigen_acpi_create_domain(str
 	if (ret || num_pins == 0)
 		return -EINVAL;
 
-	domain = platform_msi_create_device_domain(&pdev->dev, num_pins,
-						   mbigen_write_msg,
-						   &mbigen_domain_ops,
-						   mgn_chip);
-	if (!domain)
+	if (!mbigen_create_device_domain(&pdev->dev, num_pins, mgn_chip))
 		return -ENOMEM;
 
 	return 0;

