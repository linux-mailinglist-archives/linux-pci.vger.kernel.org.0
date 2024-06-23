Return-Path: <linux-pci+bounces-9141-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D92913C1B
	for <lists+linux-pci@lfdr.de>; Sun, 23 Jun 2024 17:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 293FA1F22383
	for <lists+linux-pci@lfdr.de>; Sun, 23 Jun 2024 15:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4E1184106;
	Sun, 23 Jun 2024 15:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AUklk/uo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yrx3Nzk3"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE5A1836E7;
	Sun, 23 Jun 2024 15:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719155927; cv=none; b=iGylSlfsBpQ/A7vEL6gezgGb8g87EpPu3eO0OKAAlBhZgUlmMID4lfG707RkdPu8KLVoVOkrNvx6XzFhK5vwLTultcZYEaIrcJtu0Spi0xPreaFMFiW7cscqpCBNsIM2lDDHF3xiLWF3rM5i3qo2fWBe9pTm+kUqaIGxwoICFqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719155927; c=relaxed/simple;
	bh=tNzu84DTmgxbG/eMT1KMrg4IrQZAnMh/6GA/bbjLynw=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=jZ2RPdXUWC9H0tteKx8rdpQfbQxczG65twrsXRUaIO/0wr86RjngPT/uXWTPffXbrqJjHMmE3dbxO2qOLJZ/cBxbW5Yyv6LJc32sqdlXuQzQ6uPaqnDwnljjWvw0Ha1qq9gPuQYK2kc8glXoAUN0uANp4ck9nilYO0ZAfzYmSIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AUklk/uo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yrx3Nzk3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240623142235.146579575@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719155923;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=bZNrOQHuGjzNL636+v7dedIX42R52KRRiIwxHGODrFk=;
	b=AUklk/uoyhNHNWN/+k38t+zLjj7heFrWPvx03lBm+5oKABurRBuWWwt10lSmeb17EaU0BH
	liAV8kAo9MxSO3pcBkJMLUz2UN5JHqlqr29Nae5QK+yykBWwSFxfScjCMDJ3c0xN7AagwN
	f7AWSr81K3DCOol0VXQglGZp+RIDKZtibPTMxaw1A2OiXWcK16N86NrYUPOfhBPq1R52UV
	gEnHyErrcanESKPX3r09dX5WOzz0TG/ItcqBMTMU0eVhA8ghc0hQ+VrNpzIEWbalqMb95D
	WdNSMZqrSfLA9aAwRo8cSu7PWRRtoMeKTGwK+OuIc8QGHdvJTXQSnla35s/zDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719155923;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=bZNrOQHuGjzNL636+v7dedIX42R52KRRiIwxHGODrFk=;
	b=yrx3Nzk3fd23WTdimhWl8Zo0f7HdQ2op+EsJzKJGQp4onDi44ZVaMr2x3gop//vWoQFqCI
	wn5Ge5eqzXAx0MAw==
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
Subject: [patch V4 07/21] irqchip/mbigen: Prepare for real per device MSI
References: <20240623142137.448898081@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Sun, 23 Jun 2024 17:18:43 +0200 (CEST)

From: Thomas Gleixner <tglx@linutronix.de>

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
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>


---
v3: removed unused variable 'parent' in the function
'mbigen_of_create_domain'
---
 drivers/irqchip/irq-mbigen.c | 98 +++++++++++++++++++++++++-----------
 1 file changed, 70 insertions(+), 28 deletions(-)

diff --git a/drivers/irqchip/irq-mbigen.c b/drivers/irqchip/irq-mbigen.c
index 58881d313979..db0fa80330d9 100644
--- a/drivers/irqchip/irq-mbigen.c
+++ b/drivers/irqchip/irq-mbigen.c
@@ -135,24 +135,14 @@ static int mbigen_set_type(struct irq_data *data, unsigned int type)
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
 
@@ -165,10 +155,8 @@ static void mbigen_write_msg(struct msi_desc *desc, struct msi_msg *msg)
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
@@ -192,6 +180,17 @@ static int mbigen_domain_translate(struct irq_domain *d,
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
@@ -232,11 +231,63 @@ static const struct irq_domain_ops mbigen_domain_ops = {
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
 	struct platform_device *child;
-	struct irq_domain *domain;
 	struct device_node *np;
 	u32 num_pins;
 	int ret = 0;
@@ -258,11 +309,7 @@ static int mbigen_of_create_domain(struct platform_device *pdev,
 			break;
 		}
 
-		domain = platform_msi_create_device_domain(&child->dev, num_pins,
-							   mbigen_write_msg,
-							   &mbigen_domain_ops,
-							   mgn_chip);
-		if (!domain) {
+		if (!mbigen_create_device_domain(&child->dev, num_pins, mgn_chip)) {
 			ret = -ENOMEM;
 			break;
 		}
@@ -284,7 +331,6 @@ MODULE_DEVICE_TABLE(acpi, mbigen_acpi_match);
 static int mbigen_acpi_create_domain(struct platform_device *pdev,
 				     struct mbigen_device *mgn_chip)
 {
-	struct irq_domain *domain;
 	u32 num_pins = 0;
 	int ret;
 
@@ -315,11 +361,7 @@ static int mbigen_acpi_create_domain(struct platform_device *pdev,
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
-- 
2.34.1



