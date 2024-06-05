Return-Path: <linux-pci+bounces-8330-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F2E88FCF95
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 15:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7246B314A4
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 13:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B8C196C6D;
	Wed,  5 Jun 2024 13:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EFpxg2sq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pepBbe65"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011F41E89C;
	Wed,  5 Jun 2024 13:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717592571; cv=none; b=HvCj4vg8tGRu+mn4SxCqrvoPKZEuPtHNgzYvi4IRE0o2TeQeFmnzalPeHvYibmr9CVLC9OqAt4DGpGkMj3hlKksDDoy4vK53C3Htww+zBjbsK9SC1W6PpkkCT5iTBDlzdxYy7Vd25J7si0M3tQVka9iJUMeVIDL4ZHNvbAdV3wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717592571; c=relaxed/simple;
	bh=AsQ5dSTQksgTT8gijrM3vyVSHRh/Oa8eI/Z5hUKOQHg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mEBF5ddW3ZQJfGf6Puceothvv7BQB9MkkOwh05QrQqvh4zI9r1ZJFlRaAW3PE9wa02xCAwYpaaO0LZKJen5oBz3Ir41N6fyAOos2Hv9RLN11n41Yf/ycsqvla/gPOQb6gQCAZjDMj1EuFmAC/uwaY2sww6c4QvmTR8nR6WCW9+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EFpxg2sq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pepBbe65; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717592566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NYSaBAIFrJaUpsP5G20xJAbfQKX5Ug/3BATokkBagWs=;
	b=EFpxg2sqDdk79reB/xDRTChM+84kQ8jE2WgnfqFl71p45vQdEyBMWxbz4zC0m72HxP4atu
	Ato9XvVbGlbyyNxbTRgKUTsVUZMtjomB0AFN4UdQhRwdCi0MxMYKfcKiF9oAGb+AnghN0B
	+hwmEEJL+ietaLxoGc6GO1cibZn8ih8WQ0E66YHJrPxmf8IDKorgooztLrjL7XRJXKytx/
	ctLi8yx4MVpIHfT3tDFmG2Drc82Sy2wJaqoJIKvEVAnfyW1RSZUb8PWwokcMJG7Vt0Dd+x
	VrLLjrXRgU2G2uVij2hL9TFbVi6uMlZohmzAwfxmx2SLFrfIzntWWwgfjpWcKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717592566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NYSaBAIFrJaUpsP5G20xJAbfQKX5Ug/3BATokkBagWs=;
	b=pepBbe65/2QQTUlT2N49TJnBOuvfEoYX6Ff9Ad1bwrvD+aSjHP5vB6e1JnDq3OMk3lErJD
	3A4lCFK6aLCMEbBw==
To: Herve Codina <herve.codina@bootlin.com>, Simon Horman
 <horms@kernel.org>, Sai Krishna Gajula <saikrishnag@marvell.com>, Herve
 Codina <herve.codina@bootlin.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Lee Jones <lee@kernel.org>, Arnd Bergmann
 <arnd@arndb.de>, Horatiu Vultur <horatiu.vultur@microchip.com>,
 UNGLinuxDriver@microchip.com, Andrew Lunn <andrew@lunn.ch>, Heiner
 Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
 Saravana Kannan <saravanak@google.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Philipp Zabel <p.zabel@pengutronix.de>, Lars
 Povlsen <lars.povlsen@microchip.com>, Steen Hegelund
 <Steen.Hegelund@microchip.com>, Daniel Machon
 <daniel.machon@microchip.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 netdev@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Allan Nielsen
 <allan.nielsen@microchip.com>, Steen Hegelund
 <steen.hegelund@microchip.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 10/19] irqdomain: Introduce irq_domain_alloc() and
 irq_domain_publish()
In-Reply-To: <20240527161450.326615-11-herve.codina@bootlin.com>
References: <20240527161450.326615-1-herve.codina@bootlin.com>
 <20240527161450.326615-11-herve.codina@bootlin.com>
Date: Wed, 05 Jun 2024 15:02:46 +0200
Message-ID: <8734pr5yq1.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, May 27 2024 at 18:14, Herve Codina wrote:
> The irq_domain_add_*() family functions create an irq_domain and also
> publish this newly created to domain. Once an irq_domain is published,
> consumers can request IRQ in order to use them.
>
> Some interrupt controller drivers have to perform some more operations
> with the created irq_domain in order to have it ready to be used.
> For instance:
>   - Allocate generic irq chips with irq_alloc_domain_generic_chips()
>   - Retrieve the generic irq chips with irq_get_domain_generic_chip()
>   - Initialize retrieved chips: set register base address and offsets,
>     set several hooks such as irq_mask, irq_unmask, ...
>
> To avoid a window where the domain is published but not yet ready to be

I can see the point, but why is this suddenly a problem? There are tons
of interrupt chip drivers which have exactly that pattern.

Also why is all of this burried in a series which aims to add a network
driver and touches the world and some more. If you had sent the two irq
domain patches seperately w/o spamming 100 people on CC then this would
have been solved long ago. That's documented clearly, no?

>  void irq_domain_free_fwnode(struct fwnode_handle *fwnode);
> +struct irq_domain *irq_domain_alloc(struct fwnode_handle *fwnode, unsigned int size,
> +				    irq_hw_number_t hwirq_max, int direct_max,
> +				    const struct irq_domain_ops *ops,
> +				    void *host_data);
> +
> +static inline struct irq_domain *irq_domain_alloc_linear(struct fwnode_handle *fwnode,
> +							 unsigned int size,
> +							 const struct irq_domain_ops *ops,
> +							 void *host_data)
> +{
> +	return irq_domain_alloc(fwnode, size, size, 0, ops, host_data);
> +}

So this creates exactly one wrapper, which means we'll grow another ton
of wrappers if that becomes popular for whatever reason. We have already
too many of variants for creating domains.

But what's worse is that this does not work for hierarchical domains and
is just an ad hoc scratch my itch solution.

Also looking at the irq chip drivers which use generic interrupt
chips. There are 24 instances of irq_alloc_domain_generic_chips() and
most of this code is just boilerplate.

So what we really want is a proper solution to get rid of this mess
instead of creating interfaces which just proliferate and extend it.

Something like the uncompiled below allows to convert all the
boilerplate into a template based setup/remove.

I just converted a random driver over to it and the result is pretty
neutral in terms of lines, but the amount of code to get wrong is
significantly smaller. I'm sure that more complex drivers will benefit
even more and your problem should be completely solved by that.

The below is just an initial sketch which allows further consolidation
in the irqdomain space. You get the idea.

Thanks,

        tglx
---
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -1106,6 +1106,7 @@ enum irq_gc_flags {
  * @irq_flags_to_set:	IRQ* flags to set on irq setup
  * @irq_flags_to_clear:	IRQ* flags to clear on irq setup
  * @gc_flags:		Generic chip specific setup flags
+ * FIXME
  * @gc:			Array of pointers to generic interrupt chips
  */
 struct irq_domain_chip_generic {
@@ -1114,9 +1115,26 @@ struct irq_domain_chip_generic {
 	unsigned int		irq_flags_to_clear;
 	unsigned int		irq_flags_to_set;
 	enum irq_gc_flags	gc_flags;
+	void			(*destroy)(struct irq_chip_generic *c);
 	struct irq_chip_generic	*gc[];
 };
 
+/**
+ * irq_domain_chip_generic_info - Init structure
+ * FIXME
+ */
+struct irq_domain_chip_generic_info {
+	const char		*name;
+	irq_flow_handler_t	handler;
+	void			(*init)(struct irq_chip_generic *d);
+	void			(*destroy)(struct irq_chip_generic *c);
+	unsigned int		irqs_per_chip;
+	unsigned int		num_chips;
+	unsigned int		irq_flags_to_clear;
+	unsigned int		irq_flags_to_set;
+	enum irq_gc_flags	gc_flags;
+};
+
 /* Generic chip callback functions */
 void irq_gc_noop(struct irq_data *d);
 void irq_gc_mask_disable_reg(struct irq_data *d);
@@ -1153,6 +1171,9 @@ int devm_irq_setup_generic_chip(struct d
 
 struct irq_chip_generic *irq_get_domain_generic_chip(struct irq_domain *d, unsigned int hw_irq);
 
+int irq_domain_alloc_generic_chips(struct irq_domain *d, struct irq_domain_chip_generic_info *info);
+void irq_domain_remove_generic_chips(struct irq_domain *d);
+
 int __irq_alloc_domain_generic_chips(struct irq_domain *d, int irqs_per_chip,
 				     int num_ct, const char *name,
 				     irq_flow_handler_t handler,
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -41,13 +41,13 @@ struct device_node;
 struct fwnode_handle;
 struct irq_domain;
 struct irq_chip;
+struct irq_chip_generic;
 struct irq_data;
 struct irq_desc;
 struct cpumask;
 struct seq_file;
 struct irq_affinity_desc;
 struct msi_parent_ops;
-
 #define IRQ_DOMAIN_IRQ_SPEC_PARAMS 16
 
 /**
@@ -169,6 +169,7 @@ struct irq_domain {
 #ifdef CONFIG_GENERIC_MSI_IRQ
 	const struct msi_parent_ops	*msi_parent_ops;
 #endif
+	void				(*destroy)(struct irq_domain *d);
 
 	/* reverse map data. The linear map gets appended to the irq_domain */
 	irq_hw_number_t			hwirq_max;
@@ -208,6 +209,9 @@ enum {
 	/* Irq domain is a MSI device domain */
 	IRQ_DOMAIN_FLAG_MSI_DEVICE	= (1 << 9),
 
+	/* Irq domain must destroy generic chips when removed */
+	IRQ_DOMAIN_FLAG_DESTROY_GC	= (1 << 10),
+
 	/*
 	 * Flags starting from IRQ_DOMAIN_FLAG_NONCORE are reserved
 	 * for implementation specific purposes and ignored by the
@@ -257,6 +261,28 @@ static inline struct fwnode_handle *irq_
 }
 
 void irq_domain_free_fwnode(struct fwnode_handle *fwnode);
+
+struct irq_domain_chip_generic_info;
+
+/**
+ * irq_domain_info - Init structure
+ * FIXME
+ */
+struct irq_domain_info {
+	struct fwnode_handle			*fwnode;
+	unsigned int				domain_flags;
+	unsigned int				size;
+	irq_hw_number_t				hwirq_max;
+	int					direct_max;
+	enum irq_domain_bus_token		bus_token;
+	const struct irq_domain_ops		*ops;
+	void					*host_data;
+	struct irq_domain_chip_generic_info	*gc_info;
+	void					(*init)(struct irq_domain *d);
+};
+
+struct irq_domain *irq_domain_instantiate(struct irq_domain_info *info);
+
 struct irq_domain *__irq_domain_add(struct fwnode_handle *fwnode, unsigned int size,
 				    irq_hw_number_t hwirq_max, int direct_max,
 				    const struct irq_domain_ops *ops,
--- a/kernel/irq/generic-chip.c
+++ b/kernel/irq/generic-chip.c
@@ -274,23 +274,11 @@ irq_gc_init_mask_cache(struct irq_chip_g
 			*mskptr = irq_reg_readl(gc, mskreg);
 	}
 }
-
 /**
- * __irq_alloc_domain_generic_chips - Allocate generic chips for an irq domain
- * @d:			irq domain for which to allocate chips
- * @irqs_per_chip:	Number of interrupts each chip handles (max 32)
- * @num_ct:		Number of irq_chip_type instances associated with this
- * @name:		Name of the irq chip
- * @handler:		Default flow handler associated with these chips
- * @clr:		IRQ_* bits to clear in the mapping function
- * @set:		IRQ_* bits to set in the mapping function
- * @gcflags:		Generic chip specific setup flags
+ * irq_domain_alloc_generic_chips - Allocate generic chips for an irq domain
+ * FIXME
  */
-int __irq_alloc_domain_generic_chips(struct irq_domain *d, int irqs_per_chip,
-				     int num_ct, const char *name,
-				     irq_flow_handler_t handler,
-				     unsigned int clr, unsigned int set,
-				     enum irq_gc_flags gcflags)
+int irq_domain_alloc_generic_chips(struct irq_domain *d, struct irq_domain_chip_generic_info *info)
 {
 	struct irq_domain_chip_generic *dgc;
 	struct irq_chip_generic *gc;
@@ -304,23 +292,24 @@ int __irq_alloc_domain_generic_chips(str
 	if (d->gc)
 		return -EBUSY;
 
-	numchips = DIV_ROUND_UP(d->revmap_size, irqs_per_chip);
+	numchips = DIV_ROUND_UP(d->revmap_size, info->irqs_per_chip);
 	if (!numchips)
 		return -EINVAL;
 
 	/* Allocate a pointer, generic chip and chiptypes for each chip */
-	gc_sz = struct_size(gc, chip_types, num_ct);
+	gc_sz = struct_size(gc, chip_types, info->num_ct);
 	dgc_sz = struct_size(dgc, gc, numchips);
 	sz = dgc_sz + numchips * gc_sz;
 
 	tmp = dgc = kzalloc(sz, GFP_KERNEL);
 	if (!dgc)
 		return -ENOMEM;
-	dgc->irqs_per_chip = irqs_per_chip;
+	dgc->irqs_per_chip = info->irqs_per_chip;
 	dgc->num_chips = numchips;
-	dgc->irq_flags_to_set = set;
-	dgc->irq_flags_to_clear = clr;
-	dgc->gc_flags = gcflags;
+	dgc->irq_flags_to_set = info->irq_flags_to_set;
+	dgc->irq_flags_to_clear = info->irq_flags_to_clear;
+	dgc->gc_flags = info->gcflags;
+	dgc->destroy = info->destroy;
 	d->gc = dgc;
 
 	/* Calc pointer to the first generic chip */
@@ -337,6 +326,9 @@ int __irq_alloc_domain_generic_chips(str
 			gc->reg_writel = &irq_writel_be;
 		}
 
+		if (info->init)
+			info->init(gc);
+
 		raw_spin_lock_irqsave(&gc_lock, flags);
 		list_add_tail(&gc->list, &gc_list);
 		raw_spin_unlock_irqrestore(&gc_lock, flags);
@@ -345,6 +337,56 @@ int __irq_alloc_domain_generic_chips(str
 	}
 	return 0;
 }
+
+/**
+ * irq_domain_remove_generic_chips - Remove generic chips from an interrupt domain
+ * FIXME
+ */
+void irq_domain_remove_generic_chips(struct irq_domain *d)
+{
+	struct irq_domain_chip_generic *dgc = d->gc;
+	struct irq_domain_ops *ops = d->ops;
+
+	if (!dgc)
+		return;
+
+	for (unsigned int i = 0; i < dgc->num_chips, i++) {
+		if (dgc->destroy)
+			dgc->destroy_gc(dgc->gc + i);
+		irq_remove_generic_chip(dgc->gc + i, ~0U, 0, 0);
+	}
+	d->dgc = NULL;
+	kfree(dgc);
+}
+
+/**
+ * __irq_alloc_domain_generic_chips - Allocate generic chips for an irq domain
+ * @d:			irq domain for which to allocate chips
+ * @irqs_per_chip:	Number of interrupts each chip handles (max 32)
+ * @num_ct:		Number of irq_chip_type instances associated with this
+ * @name:		Name of the irq chip
+ * @handler:		Default flow handler associated with these chips
+ * @clr:		IRQ_* bits to clear in the mapping function
+ * @set:		IRQ_* bits to set in the mapping function
+ * @gcflags:		Generic chip specific setup flags
+ */
+int __irq_alloc_domain_generic_chips(struct irq_domain *d, int irqs_per_chip,
+				     int num_ct, const char *name,
+				     irq_flow_handler_t handler,
+				     unsigned int clr, unsigned int set,
+				     enum irq_gc_flags gcflags)
+{
+	struct irq_domain_chip_generic_info info = {
+		.name			= name,
+		.handler		= handler,
+		.irqs_per_chip		= irqs_per_chip,
+		.irq_flags_to_set	= set,
+		.irq_flags_to_clear	= clr,
+		.gc_flags		= gcflags,
+	};
+
+	return irq_domain_alloc_generic_chips(d, &info);
+}
 EXPORT_SYMBOL_GPL(__irq_alloc_domain_generic_chips);
 
 static struct irq_chip_generic *
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -240,6 +240,47 @@ static void __irq_domain_publish(struct
 	pr_debug("Added domain %s\n", domain->name);
 }
 
+static void irq_domain_free(struct irq_domain *domain)
+{
+	fwnode_dev_initialized(domain->fwnode, false);
+	fwnode_handle_put(domain->fwnode);
+	if (domain->flags & IRQ_DOMAIN_NAME_ALLOCATED)
+		kfree(domain->name);
+	kfree(domain);
+}
+
+/**
+ * irq_domain_instantiate() - Instantiate a new irq_domain data structure
+ * FIXME
+ */
+struct irq_domain *irq_domain_instantiate(struct irq_domain_info *info)
+{
+	struct irq_domain *domain;
+
+	// FIXME: Convert irq_domain_create() to use @info
+	domain = __irq_domain_create(info->fwnode, info->size, info->hwirq_max, info->direct_max,
+				     info->ops, info->host_data);
+	if (!domain)
+		return NULL;
+
+	domain->flags |= info->domain_flags;
+
+	if (info->gc_info) {
+		if (!irq_domain_alloc_generic_chips(domain, info->gc_info)) {
+			irq_domain_remove(domain);
+			return NULL;
+		}
+	}
+	if (info->init)
+		info->init(domain);
+	__irq_domain_publish(domain);
+
+	// FIXME: Make this part of irq_domain_create()
+	if (info->bus_token)
+		irq_domain_update_bus_token(domain, info->bus_token);
+	return domain;
+}
+
 /**
  * __irq_domain_add() - Allocate a new irq_domain data structure
  * @fwnode: firmware node for the interrupt controller
@@ -279,6 +320,9 @@ EXPORT_SYMBOL_GPL(__irq_domain_add);
  */
 void irq_domain_remove(struct irq_domain *domain)
 {
+	if (domain->destroy)
+		domain->destroy(domain);
+
 	mutex_lock(&irq_domain_mutex);
 	debugfs_remove_domain_dir(domain);
 
@@ -294,13 +338,11 @@ void irq_domain_remove(struct irq_domain
 
 	mutex_unlock(&irq_domain_mutex);
 
-	pr_debug("Removed domain %s\n", domain->name);
+	if (domain->flags & IRQ_DOMAIN_FLAG_DESTROY_GC)
+		irq_domain_remove_generic_chips(domain);
 
-	fwnode_dev_initialized(domain->fwnode, false);
-	fwnode_handle_put(domain->fwnode);
-	if (domain->flags & IRQ_DOMAIN_NAME_ALLOCATED)
-		kfree(domain->name);
-	kfree(domain);
+	pr_debug("Removed domain %s\n", domain->name);
+	irq_domain_free(domain);
 }
 EXPORT_SYMBOL_GPL(irq_domain_remove);
 
--- a/drivers/irqchip/irq-al-fic.c
+++ b/drivers/irqchip/irq-al-fic.c
@@ -133,32 +133,10 @@ static int al_fic_irq_retrigger(struct i
 	return 1;
 }
 
-static int al_fic_register(struct device_node *node,
-			   struct al_fic *fic)
+static void al_fic_gc_init(struct irq_chip_generic *gc)
 {
-	struct irq_chip_generic *gc;
-	int ret;
+	struct al_fic *fic = gc->domain->host_data;
 
-	fic->domain = irq_domain_add_linear(node,
-					    NR_FIC_IRQS,
-					    &irq_generic_chip_ops,
-					    fic);
-	if (!fic->domain) {
-		pr_err("fail to add irq domain\n");
-		return -ENOMEM;
-	}
-
-	ret = irq_alloc_domain_generic_chips(fic->domain,
-					     NR_FIC_IRQS,
-					     1, fic->name,
-					     handle_level_irq,
-					     0, 0, IRQ_GC_INIT_MASK_CACHE);
-	if (ret) {
-		pr_err("fail to allocate generic chip (%d)\n", ret);
-		goto err_domain_remove;
-	}
-
-	gc = irq_get_domain_generic_chip(fic->domain, 0);
 	gc->reg_base = fic->base;
 	gc->chip_types->regs.mask = AL_FIC_MASK;
 	gc->chip_types->regs.ack = AL_FIC_CAUSE;
@@ -169,16 +147,37 @@ static int al_fic_register(struct device
 	gc->chip_types->chip.irq_retrigger = al_fic_irq_retrigger;
 	gc->chip_types->chip.flags = IRQCHIP_SKIP_SET_WAKE;
 	gc->private = fic;
+}
+
+static void al_fic_domain_init(struct irq_domain *d)
+{
+	struct al_fic *fic = d->host_data;
 
-	irq_set_chained_handler_and_data(fic->parent_irq,
-					 al_fic_irq_handler,
-					 fic);
-	return 0;
+	irq_set_chained_handler_and_data(fic->parent_irq, al_fic_irq_handler, fic);
+}
 
-err_domain_remove:
-	irq_domain_remove(fic->domain);
+static int al_fic_register(struct device_node *node, struct al_fic *fic)
+{
+	struct irq_domain_chip_generic_info gc_info = {
+		.irqs_per_chip		= NR_FIC_IRQS,
+		.num_chips		= 1,
+		.name			= fic->name,
+		.handler		= handle_level_irq,
+		.gc_flags		= IRQ_GC_INIT_MASK_CACHE,
+		.init			= al_fic_gc_init,
+	};
+	struct irq_domain_info info = {
+		.fwnode			= of_node_to_fwnode(node),
+		.size			= NR_FIC_IRQS,
+		.hwirq_max		= NR_FIC_IRQS,
+		.ops			= &irq_generic_chip_ops,
+		.host_data		= fic,
+		.gc_info		= &gc_info,
+		.init			= al_fic_domain_init,
+	};
 
-	return ret;
+	fic->domain = irq_domain_instantiate(&info);
+	return fic->domain ? 0 : -ENOMEM;
 }
 
 /*

