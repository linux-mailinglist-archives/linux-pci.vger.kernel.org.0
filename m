Return-Path: <linux-pci+bounces-9287-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA6B0917EB1
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 12:47:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4659A1F280B6
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 10:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91BD017E445;
	Wed, 26 Jun 2024 10:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vlvb8ZlK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ygBS/fyW";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vlvb8ZlK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ygBS/fyW"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC7617BB2C;
	Wed, 26 Jun 2024 10:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719398807; cv=none; b=tUY1yuiABydjYwOZxFeWU15OvXWp3StNwRAz73rd31qCsQ/ilLzS64xn/herQyXpAb/vzR9DFcR4/+Z1Qftu8n4xQ0enwjV6LD6LdJLOqXeos5c24XOItt+yi0n/Zu9nv2l6GDhfWdpd/OT6qfdHv/+ZJaSzzM3rOWq1/2vAbrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719398807; c=relaxed/simple;
	bh=DMimCdehX5+0M3DGK74xCoZag2cIjwy9y1TOt3Y9nAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MrSQQG3jZyd75ikhhg5G6haTxYiC5uRt+5qJd12DDJNaZwwwHA84Mtj+EVuXxpbj9Dqzf2qMOyDpZ7Se/rZe/z3J2ESKaGa8fE6kYa2iVuNSK0lmCaZBMe+EnFXq8ZPCF2ZHXnLlujyjkHeWz/Z1KXff8VgB+862k4eeOq51zOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vlvb8ZlK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ygBS/fyW; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vlvb8ZlK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ygBS/fyW; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 869CB1FB50;
	Wed, 26 Jun 2024 10:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719398803; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lp6J8bbaE8qg5meMzUWOXYht8Jr62yy0NGISLVX9MAQ=;
	b=vlvb8ZlKBZCfmApkdyiBX5unod0/kr9LJcKB0/k5GDBWWT0cOoK/uSt6hG5R0RGepzQBiY
	z39RKzklpnJmFOAqGdmjylX5FtZEpw2ehXviHDOdkp6m0MWpMn8hzmJ9FPU7khGvvUu6wi
	cSItJkDwDEJC1St0O03R511032A4WWQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719398803;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lp6J8bbaE8qg5meMzUWOXYht8Jr62yy0NGISLVX9MAQ=;
	b=ygBS/fyW52/0nIiabfIZn/EUOL+ryC7X8UqDvnFv5f/LOsUzE7oNfvJooI3vDEl90kbQ1m
	mFXrCc4j/fR+CcCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719398803; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lp6J8bbaE8qg5meMzUWOXYht8Jr62yy0NGISLVX9MAQ=;
	b=vlvb8ZlKBZCfmApkdyiBX5unod0/kr9LJcKB0/k5GDBWWT0cOoK/uSt6hG5R0RGepzQBiY
	z39RKzklpnJmFOAqGdmjylX5FtZEpw2ehXviHDOdkp6m0MWpMn8hzmJ9FPU7khGvvUu6wi
	cSItJkDwDEJC1St0O03R511032A4WWQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719398803;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lp6J8bbaE8qg5meMzUWOXYht8Jr62yy0NGISLVX9MAQ=;
	b=ygBS/fyW52/0nIiabfIZn/EUOL+ryC7X8UqDvnFv5f/LOsUzE7oNfvJooI3vDEl90kbQ1m
	mFXrCc4j/fR+CcCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 702C913AD2;
	Wed, 26 Jun 2024 10:46:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mO+0GJLxe2ZuDQAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Wed, 26 Jun 2024 10:46:42 +0000
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
Subject: [PATCH 3/7] irqchip: Add Broadcom bcm2712 MSI-X interrupt controller
Date: Wed, 26 Jun 2024 13:45:40 +0300
Message-ID: <20240626104544.14233-4-svarbanov@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240626104544.14233-1-svarbanov@suse.de>
References: <20240626104544.14233-1-svarbanov@suse.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-1.30 / 50.00];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FREEMAIL_CC(0.00)[linutronix.de,kernel.org,broadcom.com,gmail.com,google.com,linux.com,pengutronix.de,suse.com,raspberrypi.com,suse.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	R_RATELIMIT(0.00)[to_ip_from(RL7mwea5a3cdyragbzqhrtit3y)];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]

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
 drivers/irqchip/irq-bcm2712-mip.c | 287 ++++++++++++++++++++++++++++++
 3 files changed, 300 insertions(+)
 create mode 100644 drivers/irqchip/irq-bcm2712-mip.c

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 72c07a12f5e1..4297bd1c0e13 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -111,6 +111,18 @@ config I8259
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
index ec4a18380998..7df7b7338a9f 100644
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
index 000000000000..c95fef488d6d
--- /dev/null
+++ b/drivers/irqchip/irq-bcm2712-mip.c
@@ -0,0 +1,287 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2024 Raspberry Pi Ltd., All Rights Reserved.
+ */
+
+#include <linux/pci.h>
+#include <linux/msi.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/of_pci.h>
+#include <linux/irqchip.h>
+
+#define MIP_INT_RAISED		0x00
+#define MIP_INT_CLEARED		0x10
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
+	/* used to protect alloc/free bitmap ops */
+	spinlock_t	msi_map_lock;
+	void __iomem	*base;
+	phys_addr_t	msg_addr;
+	u32		msi_base;	/* The SGI number that MSIs start */
+	u32		num_msis;	/* The number of SGIs for MSIs */
+	u32		msi_offset;	/* Shift the allocated msi up by N */
+	unsigned long	*msi_map;
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
+static void mip_compose_msi_msg(struct irq_data *d, struct msi_msg *msg)
+{
+	struct mip_priv *priv = irq_data_get_irq_chip_data(d);
+
+	msg->address_hi = upper_32_bits(priv->msg_addr);
+	msg->address_lo = lower_32_bits(priv->msg_addr);
+	msg->data = d->hwirq;
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
+static int mip_allocate_sgi(struct mip_priv *priv, int nr_irqs)
+{
+	int irq;
+
+	spin_lock(&priv->msi_map_lock);
+	irq = bitmap_find_free_region(priv->msi_map, priv->num_msis,
+				      ilog2(nr_irqs));
+	spin_unlock(&priv->msi_map_lock);
+
+	if (irq < 0)
+		return -ENOSPC;
+
+	return irq + priv->msi_offset;
+}
+
+static void mip_free_sgi(struct mip_priv *priv, unsigned int sgi, int nr_irqs)
+{
+	unsigned int irq = sgi - priv->msi_offset;
+
+	if (sgi < priv->msi_offset) {
+		pr_err("MIP: sgi should be greater than %u\n", priv->msi_offset);
+		return;
+	}
+
+	spin_lock(&priv->msi_map_lock);
+	bitmap_release_region(priv->msi_map, irq, ilog2(nr_irqs));
+	spin_unlock(&priv->msi_map_lock);
+}
+
+static int mip_gic_domain_alloc(struct irq_domain *domain, unsigned int virq,
+				int sgi)
+{
+	struct mip_priv *priv = domain->host_data;
+	struct irq_fwspec fwspec;
+	struct irq_data *irqd;
+	int ret;
+
+	if (!is_of_node(domain->parent->fwnode))
+		return -EINVAL;
+
+	fwspec.fwnode = domain->parent->fwnode;
+	fwspec.param_count = 3;
+	fwspec.param[0] = 0;
+	fwspec.param[1] = sgi + priv->msi_base;
+	fwspec.param[2] = IRQ_TYPE_EDGE_RISING;
+
+	ret = irq_domain_alloc_irqs_parent(domain, virq, 1, &fwspec);
+	if (ret)
+		return ret;
+
+	irqd = irq_domain_get_irq_data(domain->parent, virq);
+	irqd->chip->irq_set_type(irqd, IRQ_TYPE_EDGE_RISING);
+
+	return 0;
+}
+
+static int mip_middle_domain_alloc(struct irq_domain *domain, unsigned int virq,
+				   unsigned int nr_irqs, void *args)
+{
+	struct mip_priv *priv = domain->host_data;
+	struct irq_data *irqd;
+	int hwirq, ret, i;
+
+	hwirq = mip_allocate_sgi(priv, nr_irqs);
+	if (hwirq < 0)
+		return hwirq;
+
+	for (i = 0; i < nr_irqs; i++) {
+		ret = mip_gic_domain_alloc(domain, virq + i, hwirq + i);
+		if (ret)
+			goto err_sgi;
+
+		irq_domain_set_hwirq_and_chip(domain, virq + i, hwirq + i,
+					      &mip_middle_irq_chip, priv);
+		irqd = irq_get_irq_data(virq + i);
+		irqd_set_single_target(irqd);
+		irqd_set_affinity_on_activate(irqd);
+	}
+
+	return 0;
+
+err_sgi:
+	irq_domain_free_irqs_parent(domain, virq, i - 1);
+	mip_free_sgi(priv, hwirq, nr_irqs);
+	return ret;
+}
+
+static void mip_middle_domain_free(struct irq_domain *domain, unsigned int virq,
+				   unsigned int nr_irqs)
+{
+	struct irq_data *d = irq_domain_get_irq_data(domain, virq);
+	struct mip_priv *priv = irq_data_get_irq_chip_data(d);
+
+	irq_domain_free_irqs_parent(domain, virq, nr_irqs);
+	mip_free_sgi(priv, d->hwirq, nr_irqs);
+}
+
+static const struct irq_domain_ops mip_middle_domain_ops = {
+	.alloc	= mip_middle_domain_alloc,
+	.free	= mip_middle_domain_free,
+};
+
+static int mip_init_domains(struct mip_priv *priv, struct device_node *node)
+{
+	struct irq_domain *middle_domain, *msi_domain, *gic_domain;
+	struct device_node *gic_node;
+
+	gic_node = of_irq_find_parent(node);
+	if (!gic_node)
+		return -ENODEV;
+
+	gic_domain = irq_find_host(gic_node);
+	of_node_put(gic_node);
+	if (!gic_domain)
+		return -ENXIO;
+
+	middle_domain = irq_domain_add_hierarchy(gic_domain, 0, 0, NULL,
+						 &mip_middle_domain_ops,
+						 priv);
+	if (!middle_domain)
+		return -ENOMEM;
+
+	msi_domain = pci_msi_create_irq_domain(of_node_to_fwnode(node),
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
+	spin_lock_init(&priv->msi_map_lock);
+
+	if (of_property_read_u32(node, "brcm,msi-base-spi", &priv->msi_base)) {
+		ret = -EINVAL;
+		goto err_priv;
+	}
+
+	if (of_property_read_u32(node, "brcm,msi-num-spis", &priv->num_msis)) {
+		ret = -EINVAL;
+		goto err_priv;
+	}
+
+	if (of_property_read_u32(node, "brcm,msi-offset", &priv->msi_offset))
+		priv->msi_offset = 0;
+
+	if (of_property_read_u64(node, "brcm,msi-pci-addr", &priv->msg_addr)) {
+		ret = -EINVAL;
+		goto err_priv;
+	}
+
+	priv->base = of_iomap(node, 0);
+	if (!priv->base) {
+		ret = -ENOMEM;
+		goto err_priv;
+	}
+
+	priv->msi_map = bitmap_zalloc(priv->num_msis, GFP_KERNEL);
+	if (!priv->msi_map) {
+		ret = -ENOMEM;
+		goto err_base;
+	}
+
+	/*
+	 * Begin with all MSI-X masked in for the host, masked out for the
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
+	pr_debug("Registered %u MSI-X, starting at %u\n",
+		 priv->num_msis, priv->msi_base);
+
+	return 0;
+
+err_map:
+	bitmap_free(priv->msi_map);
+err_base:
+	iounmap(priv->base);
+err_priv:
+	kfree(priv);
+	return ret;
+}
+
+IRQCHIP_DECLARE(bcm_mip, "brcm,bcm2712-mip-intc", mip_of_msi_init);
-- 
2.43.0


