Return-Path: <linux-pci+bounces-12988-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C96E6973B70
	for <lists+linux-pci@lfdr.de>; Tue, 10 Sep 2024 17:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE4481C24E02
	for <lists+linux-pci@lfdr.de>; Tue, 10 Sep 2024 15:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4A81A0B04;
	Tue, 10 Sep 2024 15:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uqmjhRB7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dPpx8Yq7";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uqmjhRB7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dPpx8Yq7"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2665919FA8A;
	Tue, 10 Sep 2024 15:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725981557; cv=none; b=b6RR8nznG2Om4RwoAJQmgym2iZdk/T3Ki+Y2gfM17/bF8oM5oli/k1/kVEQ6fgqbgjFtT5vN8iK1KKYTv/bm0fYSDqFvDv0AwFfKQ3laf3JEAHU/iPw8ZxSFryXGt/Z6+sjKlZegiY2CDUNW6tlZ5Ohc6kv5Xp5fOiACXllMQVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725981557; c=relaxed/simple;
	bh=Ef7oXx12PFcSj7Towrr9tPXWNc3ZBCDOR7TkXidjhOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gpa0qp56A/IEszuykQxg3h2SSUQhdrJx4vjmJKJt2But5p47CXFLQth4osUfby44Bu320qSD1qH5QibI0fq3cTuMYPzOdJpAD86AqlMYX8JvNDtN4mGRbHLprLWIsiJbvmk5MaC5RLbUhKRVta0WDmyYwca8aBeAYVIwRjSe8Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uqmjhRB7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=dPpx8Yq7; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uqmjhRB7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=dPpx8Yq7; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1DD251F820;
	Tue, 10 Sep 2024 15:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725981553; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UMmWmlRnQQ1iT07I1UqpVQcIMEgTEWsT4x4sI91NHLs=;
	b=uqmjhRB7WiBsXY/QoSuvc5TqFwFuMv0cOnXM7TPHd9inV8hA7nhqNwbvjibK25VRWCzTPV
	11EBiVMQWj/ORxdcGrBXvbDUZN8bx1/j1JMJNakPGMK4SCzrYVxfrGGRwKvRr13OqTTA18
	E1WB65rQOAqFuD27n9a7qQHIGoWUYjg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725981553;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UMmWmlRnQQ1iT07I1UqpVQcIMEgTEWsT4x4sI91NHLs=;
	b=dPpx8Yq7RqBAruDX8rXSroY1gXZcgXL3dXpsHfpjXIHDT71zKnLQ1eL95wNq4yqyRpToYT
	tDA67EOp7dyDfGAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725981553; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UMmWmlRnQQ1iT07I1UqpVQcIMEgTEWsT4x4sI91NHLs=;
	b=uqmjhRB7WiBsXY/QoSuvc5TqFwFuMv0cOnXM7TPHd9inV8hA7nhqNwbvjibK25VRWCzTPV
	11EBiVMQWj/ORxdcGrBXvbDUZN8bx1/j1JMJNakPGMK4SCzrYVxfrGGRwKvRr13OqTTA18
	E1WB65rQOAqFuD27n9a7qQHIGoWUYjg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725981553;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UMmWmlRnQQ1iT07I1UqpVQcIMEgTEWsT4x4sI91NHLs=;
	b=dPpx8Yq7RqBAruDX8rXSroY1gXZcgXL3dXpsHfpjXIHDT71zKnLQ1eL95wNq4yqyRpToYT
	tDA67EOp7dyDfGAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F247813A8F;
	Tue, 10 Sep 2024 15:19:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ANeVOG9j4GaxQgAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Tue, 10 Sep 2024 15:19:11 +0000
From: Stanimir Varbanov <svarbanov@suse.de>
To: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jim Quinlan <jim2101024@gmail.com>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	kw@linux.com,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Andrea della Porta <andrea.porta@suse.com>,
	Phil Elwell <phil@raspberrypi.com>,
	Jonathan Bell <jonathan@raspberrypi.com>,
	Stanimir Varbanov <svarbanov@suse.de>
Subject: [PATCH v2 -next 03/11] irqchip: mip: Add Broadcom bcm2712 MSI-X interrupt controller
Date: Tue, 10 Sep 2024 18:18:37 +0300
Message-ID: <20240910151845.17308-4-svarbanov@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240910151845.17308-1-svarbanov@suse.de>
References: <20240910151845.17308-1-svarbanov@suse.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-5.30 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FREEMAIL_CC(0.00)[linutronix.de,kernel.org,broadcom.com,gmail.com,google.com,linux.com,pengutronix.de,suse.com,raspberrypi.com,suse.de];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_RATELIMIT(0.00)[to_ip_from(RL7mwea5a3cdyragbzqhrtit3y)];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Score: -5.30
X-Spam-Flag: NO

Add an interrupt controller driver for MSI-X Interrupt Peripheral (MIP)
hardware block found in bcm2712. The interrupt controller is used to
handle MSI-X interrupts from peripherials behind PCIe endpoints like
RP1 south bridge found in RPi5.

There are two MIPs on bcm2712, the first has 64 consecutive SPIs
assigned to 64 output vectors, and the second has 17 SPIs, but only
8 of them are consecutive starting at the 8th output vector.

Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
---
 drivers/irqchip/Kconfig           |  12 ++
 drivers/irqchip/Makefile          |   1 +
 drivers/irqchip/irq-bcm2712-mip.c | 310 ++++++++++++++++++++++++++++++
 3 files changed, 323 insertions(+)
 create mode 100644 drivers/irqchip/irq-bcm2712-mip.c

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 341cd9ca5a05..49b18da4d237 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -116,6 +116,18 @@ config I8259
 	bool
 	select IRQ_DOMAIN
 
+config BCM2712_MIP
+	bool "Broadcom BCM2712 MSI-X Interrupt Peripheral support"
+	depends on ARCH_BRCMSTB
+	default ARCH_BRCMSTB
+	depends on ARM_GIC
+	select GENERIC_IRQ_CHIP
+	select IRQ_DOMAIN
+	help
+	  Enable support for the Broadcom BCM2712 MSI-X target peripheral
+	  (MIP) needed by PCIe brcmstb to handle MSI-X interrupts on
+	  Raspberry Pi 5.
+
 config BCM6345_L1_IRQ
 	bool
 	select GENERIC_IRQ_CHIP
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index e3679ec2b9f7..a11307b1b610 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -62,6 +62,7 @@ obj-$(CONFIG_XTENSA_MX)			+= irq-xtensa-mx.o
 obj-$(CONFIG_XILINX_INTC)		+= irq-xilinx-intc.o
 obj-$(CONFIG_IRQ_CROSSBAR)		+= irq-crossbar.o
 obj-$(CONFIG_SOC_VF610)			+= irq-vf610-mscm-ir.o
+obj-$(CONFIG_BCM2712_MIP)               += irq-bcm2712-mip.o
 obj-$(CONFIG_BCM6345_L1_IRQ)		+= irq-bcm6345-l1.o
 obj-$(CONFIG_BCM7038_L1_IRQ)		+= irq-bcm7038-l1.o
 obj-$(CONFIG_BCM7120_L2_IRQ)		+= irq-bcm7120-l2.o
diff --git a/drivers/irqchip/irq-bcm2712-mip.c b/drivers/irqchip/irq-bcm2712-mip.c
new file mode 100644
index 000000000000..51323e8cbe97
--- /dev/null
+++ b/drivers/irqchip/irq-bcm2712-mip.c
@@ -0,0 +1,310 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2024 Raspberry Pi Ltd., All Rights Reserved.
+ * Copyright (c) 2024 SUSE
+ */
+
+#include <linux/bitmap.h>
+#include <linux/irqchip.h>
+#include <linux/irqdomain.h>
+#include <linux/msi.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+
+#define MIP_INT_RAISE		0x00
+#define MIP_INT_CLEAR		0x10
+#define MIP_INT_CFGL_HOST	0x20
+#define MIP_INT_CFGH_HOST	0x30
+#define MIP_INT_MASKL_HOST	0x40
+#define MIP_INT_MASKH_HOST	0x50
+#define MIP_INT_MASKL_VPU	0x60
+#define MIP_INT_MASKH_VPU	0x70
+#define MIP_INT_STATUSL_HOST	0x80
+#define MIP_INT_STATUSH_HOST	0x90
+#define MIP_INT_STATUSL_VPU	0xa0
+#define MIP_INT_STATUSH_VPU	0xb0
+
+struct mip_priv {
+	/* used to protect bitmap alloc/free */
+	spinlock_t lock;
+	void __iomem *base;
+	u64 msg_addr;
+	u32 msi_base;
+	u32 num_msis;
+	unsigned long *bitmap;
+	struct irq_domain *parent;
+};
+
+static void mip_mask_msi_irq(struct irq_data *d)
+{
+	pci_msi_mask_irq(d);
+	irq_chip_mask_parent(d);
+}
+
+static void mip_unmask_msi_irq(struct irq_data *d)
+{
+	pci_msi_unmask_irq(d);
+	irq_chip_unmask_parent(d);
+}
+
+static struct irq_chip mip_msi_irq_chip = {
+	.name			= "MIP-MSI",
+	.irq_unmask		= mip_unmask_msi_irq,
+	.irq_mask		= mip_mask_msi_irq,
+	.irq_eoi		= irq_chip_eoi_parent,
+	.irq_set_affinity	= irq_chip_set_affinity_parent,
+};
+
+static struct msi_domain_info mip_msi_domain_info = {
+	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
+		   MSI_FLAG_PCI_MSIX),
+	.chip	= &mip_msi_irq_chip,
+};
+
+static void mip_compose_msi_msg(struct irq_data *d, struct msi_msg *msg)
+{
+	struct mip_priv *priv = irq_data_get_irq_chip_data(d);
+
+	msg->address_hi = upper_32_bits(priv->msg_addr);
+	msg->address_lo = lower_32_bits(priv->msg_addr);
+	msg->data = d->hwirq;
+}
+
+static struct irq_chip mip_middle_irq_chip = {
+	.name			= "MIP",
+	.irq_mask		= irq_chip_mask_parent,
+	.irq_unmask		= irq_chip_unmask_parent,
+	.irq_eoi		= irq_chip_eoi_parent,
+	.irq_set_affinity	= irq_chip_set_affinity_parent,
+	.irq_set_type		= irq_chip_set_type_parent,
+	.irq_compose_msi_msg	= mip_compose_msi_msg,
+};
+
+static int mip_alloc_hwirq(struct mip_priv *priv, unsigned int nr_irqs,
+			   unsigned int *hwirq)
+{
+	int bit;
+
+	spin_lock(&priv->lock);
+	bit = bitmap_find_free_region(priv->bitmap, priv->num_msis,
+				      ilog2(nr_irqs));
+	spin_unlock(&priv->lock);
+
+	if (bit < 0)
+		return bit;
+
+	if (hwirq)
+		*hwirq = bit + priv->msi_base;
+
+	return 0;
+}
+
+static void mip_free_hwirq(struct mip_priv *priv, unsigned int hwirq,
+			   unsigned int nr_irqs)
+{
+	unsigned int irq = hwirq - priv->msi_base;
+
+	if (hwirq < priv->msi_base) {
+		pr_err("MIP: hwirq must be greater than %u\n", priv->msi_base);
+		return;
+	}
+
+	spin_lock(&priv->lock);
+	bitmap_release_region(priv->bitmap, irq, ilog2(nr_irqs));
+	spin_unlock(&priv->lock);
+}
+
+static int mip_parent_domain_alloc(struct irq_domain *domain, unsigned int virq,
+				   int hwirq)
+{
+	struct irq_fwspec fwspec = {0};
+	struct irq_data *irqd;
+	int ret;
+
+	if (!is_of_node(domain->parent->fwnode))
+		return -EINVAL;
+
+	fwspec.fwnode = domain->parent->fwnode;
+	fwspec.param_count = 3;
+	fwspec.param[0] = 0;
+	fwspec.param[1] = hwirq;
+	fwspec.param[2] = IRQ_TYPE_EDGE_RISING;
+
+	ret = irq_domain_alloc_irqs_parent(domain, virq, 1, &fwspec);
+	if (ret)
+		return ret;
+
+	irqd = irq_domain_get_irq_data(domain->parent, virq);
+	if (irqd)
+		irqd->chip->irq_set_type(irqd, IRQ_TYPE_EDGE_RISING);
+
+	return 0;
+}
+
+static int mip_middle_domain_alloc(struct irq_domain *domain, unsigned int virq,
+				   unsigned int nr_irqs, void *arg)
+{
+	struct mip_priv *priv = domain->host_data;
+	struct irq_data *irqd;
+	unsigned int hwirq, i;
+	int ret;
+
+	ret = mip_alloc_hwirq(priv, nr_irqs, &hwirq);
+	if (ret < 0)
+		return ret;
+
+	for (i = 0; i < nr_irqs; i++) {
+		ret = mip_parent_domain_alloc(domain, virq + i, hwirq + i);
+		if (ret)
+			goto err_free;
+
+		ret = irq_domain_set_hwirq_and_chip(domain, virq + i, hwirq + i,
+						    &mip_middle_irq_chip, priv);
+		if (ret)
+			goto err_free;
+
+		irqd = irq_domain_get_irq_data(domain->parent, virq + i);
+		if (irqd) {
+			irqd_set_single_target(irqd);
+			irqd_set_affinity_on_activate(irqd);
+		}
+	}
+
+	return 0;
+
+err_free:
+	irq_domain_free_irqs_parent(domain, virq, i);
+	mip_free_hwirq(priv, hwirq, nr_irqs);
+	return ret;
+}
+
+static void mip_middle_domain_free(struct irq_domain *domain, unsigned int virq,
+				   unsigned int nr_irqs)
+{
+	struct irq_data *irqd = irq_domain_get_irq_data(domain, virq);
+	struct mip_priv *priv;
+
+	if (!irqd)
+		return;
+
+	priv = irq_data_get_irq_chip_data(irqd);
+	irq_domain_free_irqs_parent(domain, virq, nr_irqs);
+	mip_free_hwirq(priv, irqd->hwirq, nr_irqs);
+}
+
+static const struct irq_domain_ops mip_middle_domain_ops = {
+	.alloc	= mip_middle_domain_alloc,
+	.free	= mip_middle_domain_free,
+};
+
+static int mip_init_domains(struct mip_priv *priv, struct device_node *np)
+{
+	struct irq_domain *middle_domain, *msi_domain;
+
+	middle_domain = irq_domain_add_hierarchy(priv->parent, 0,
+						 priv->num_msis, np,
+						 &mip_middle_domain_ops,
+						 priv);
+	if (!middle_domain)
+		return -ENOMEM;
+
+	msi_domain = pci_msi_create_irq_domain(of_node_to_fwnode(np),
+					       &mip_msi_domain_info,
+					       middle_domain);
+	if (!msi_domain) {
+		irq_domain_remove(middle_domain);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static int mip_parse_dt(struct mip_priv *priv, struct device_node *np)
+{
+	struct of_phandle_args args;
+	u64 size;
+	int ret;
+
+	ret = of_parse_phandle_with_args(np, "msi-ranges", "#interrupt-cells",
+					 0, &args);
+	if (ret)
+		return ret;
+
+	ret = of_property_read_u32_index(np, "msi-ranges", args.args_count + 1,
+					 &priv->num_msis);
+	if (ret)
+		goto err_put;
+
+	ret = of_property_read_reg(np, 1, &priv->msg_addr, &size);
+	if (ret)
+		goto err_put;
+
+	priv->msi_base = args.args[1];
+
+	priv->parent = irq_find_host(args.np);
+	if (!priv->parent)
+		ret = -EINVAL;
+
+err_put:
+	of_node_put(args.np);
+	return ret;
+}
+
+static int __init mip_of_msi_init(struct device_node *node,
+				  struct device_node *parent)
+{
+	struct mip_priv *priv;
+	int ret;
+
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	spin_lock_init(&priv->lock);
+
+	ret = mip_parse_dt(priv, node);
+	if (ret)
+		goto err_priv;
+
+	priv->base = of_iomap(node, 0);
+	if (!priv->base) {
+		ret = -ENXIO;
+		goto err_priv;
+	}
+
+	priv->bitmap = bitmap_zalloc(priv->num_msis, GFP_KERNEL);
+	if (!priv->bitmap) {
+		ret = -ENOMEM;
+		goto err_base;
+	}
+
+	/*
+	 * All MSI-X masked in for the host, masked out for the
+	 * VPU, and edge-triggered.
+	 */
+	writel(0, priv->base + MIP_INT_MASKL_HOST);
+	writel(0, priv->base + MIP_INT_MASKH_HOST);
+	writel(~0, priv->base + MIP_INT_MASKL_VPU);
+	writel(~0, priv->base + MIP_INT_MASKH_VPU);
+	writel(~0, priv->base + MIP_INT_CFGL_HOST);
+	writel(~0, priv->base + MIP_INT_CFGH_HOST);
+
+	ret = mip_init_domains(priv, node);
+	if (ret)
+		goto err_map;
+
+	pr_info("MIP: registered %u MSI-X, starting at %u\n", priv->num_msis,
+		priv->msi_base);
+
+	return 0;
+
+err_map:
+	bitmap_free(priv->bitmap);
+err_base:
+	iounmap(priv->base);
+err_priv:
+	kfree(priv);
+	return ret;
+}
+
+IRQCHIP_DECLARE(bcm_mip, "brcm,bcm2712-mip", mip_of_msi_init);
-- 
2.35.3


