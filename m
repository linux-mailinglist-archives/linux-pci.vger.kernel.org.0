Return-Path: <linux-pci+bounces-15294-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 383679B02CA
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 14:46:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B28651F226F8
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 12:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2013DAC06;
	Fri, 25 Oct 2024 12:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fJLoP7nu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="C1K/li4t";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fJLoP7nu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="C1K/li4t"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51DC22B66F;
	Fri, 25 Oct 2024 12:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729860335; cv=none; b=TrEIpz9eMCZRG46fVtMNAhPNKVmJOu0sscL08AgM3l91apUJaSzSYYOjGfztp3f5Xc4qOBNc/nwaYgWLrBdNRz9+QVcMhDEXF3S4E4WMS1lo8lsy1pzCaD9M4z7aqZXJQ1PDHRabSB6kQKkso8ZHGt+k4CW2VolWJ3Bcp21wa9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729860335; c=relaxed/simple;
	bh=lRKZJTcN0terUZ03vTLIQ76VJwdGmCD429O4cFeL3VU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YWU3YWYc53BoQx8pHK6xuAsDJzqIiJXHWpMy7n3f/uxe/E5A+syeQwdpp0XjSx8ELJckpVH/iE082JpGLe+ij61R+aFtRlgEgkZXzHakLboXFXC1f1h8Kk1o/o/NUbu48tosbBfTRs+Jue2tt5f5R0XEUQDnytUEFObNomafgho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fJLoP7nu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=C1K/li4t; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fJLoP7nu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=C1K/li4t; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 238D81FE70;
	Fri, 25 Oct 2024 12:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729860331; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c+uowGpwUz5NCg78o2YaCLio5zeWFG4cEvQGLiJUC+8=;
	b=fJLoP7nu8RvnLSMPOjuFFhjBS0/Auc5a2ZdCNFdYAVV2Sm0sLUpMXkEPUPtxuxmIsQm1pU
	mzETq6vwoxzoz8yOEy5NxJtfJ4U3p3hDKLqn9ND5nek75t+gTJegC+4q6Wz4+koLVukQlh
	wToHvgygOfjdPHhwBe5oVWHSZTwNd5M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729860331;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c+uowGpwUz5NCg78o2YaCLio5zeWFG4cEvQGLiJUC+8=;
	b=C1K/li4t+9hKT7sIMCkW4VRMhEH9Z3F2rYYIgY2SP46BfaSAc+oOodNQRiXO70bv3JmK0v
	YIS9vqZwmW7pTBDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729860331; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c+uowGpwUz5NCg78o2YaCLio5zeWFG4cEvQGLiJUC+8=;
	b=fJLoP7nu8RvnLSMPOjuFFhjBS0/Auc5a2ZdCNFdYAVV2Sm0sLUpMXkEPUPtxuxmIsQm1pU
	mzETq6vwoxzoz8yOEy5NxJtfJ4U3p3hDKLqn9ND5nek75t+gTJegC+4q6Wz4+koLVukQlh
	wToHvgygOfjdPHhwBe5oVWHSZTwNd5M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729860331;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c+uowGpwUz5NCg78o2YaCLio5zeWFG4cEvQGLiJUC+8=;
	b=C1K/li4t+9hKT7sIMCkW4VRMhEH9Z3F2rYYIgY2SP46BfaSAc+oOodNQRiXO70bv3JmK0v
	YIS9vqZwmW7pTBDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 625B213B16;
	Fri, 25 Oct 2024 12:45:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YNGVFemSG2fzOAAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Fri, 25 Oct 2024 12:45:29 +0000
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
Subject: [PATCH v4 03/10] irqchip: Add Broadcom bcm2712 MSI-X interrupt controller
Date: Fri, 25 Oct 2024 15:45:08 +0300
Message-ID: <20241025124515.14066-4-svarbanov@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241025124515.14066-1-svarbanov@suse.de>
References: <20241025124515.14066-1-svarbanov@suse.de>
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
v3 -> v4:
 - Addressed the comments for wrongly used PCI/MSI flags (Thomas)

 drivers/irqchip/Kconfig           |  16 ++
 drivers/irqchip/Makefile          |   1 +
 drivers/irqchip/irq-bcm2712-mip.c | 310 ++++++++++++++++++++++++++++++
 3 files changed, 327 insertions(+)
 create mode 100644 drivers/irqchip/irq-bcm2712-mip.c

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 341cd9ca5a05..c9bd0a4f6871 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -116,6 +116,22 @@ config I8259
 	bool
 	select IRQ_DOMAIN
 
+config BCM2712_MIP
+	tristate "Broadcom BCM2712 MSI-X Interrupt Peripheral support"
+	depends on ARCH_BRCMSTB || COMPILE_TEST
+	default m if ARCH_BRCMSTB
+	depends on ARM_GIC
+	select GENERIC_IRQ_CHIP
+	select IRQ_DOMAIN_HIERARCHY
+	select GENERIC_MSI_IRQ
+	select IRQ_MSI_LIB
+	help
+	  Enable support for the Broadcom BCM2712 MSI-X target peripheral
+	  (MIP) needed by brcmstb PCIe to handle MSI-X interrupts on
+	  Raspberry Pi 5.
+
+	  If unsure say n.
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
index 000000000000..fd73f2d41279
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
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
+
+#include "irq-msi-lib.h"
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
+/**
+ * struct mip_priv - MSI-X interrupt controller data
+ * @lock:	Used to protect bitmap alloc/free
+ * @base:	Base address of MMIO area
+ * @msg_addr:	PCIe MSI-X address
+ * @msi_base:	MSI base
+ * @num_msis:	Count of MSIs
+ * @msi_offset:	MSI offset
+ * @bitmap:	A bitmap for hwirqs
+ * @parent:	Parent domain (GIC)
+ * @dev:	A device pointer
+ */
+struct mip_priv {
+	spinlock_t		lock;
+	void __iomem		*base;
+	u64			msg_addr;
+	u32			msi_base;
+	u32			num_msis;
+	u32			msi_offset;
+	unsigned long		*bitmap;
+	struct irq_domain	*parent;
+	struct device		*dev;
+};
+
+static void mip_compose_msi_msg(struct irq_data *d, struct msi_msg *msg)
+{
+	struct mip_priv *mip = irq_data_get_irq_chip_data(d);
+
+	msg->address_hi = upper_32_bits(mip->msg_addr);
+	msg->address_lo = lower_32_bits(mip->msg_addr);
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
+static int mip_alloc_hwirq(struct mip_priv *mip, unsigned int nr_irqs,
+			   unsigned int *hwirq)
+{
+	int bit;
+
+	spin_lock(&mip->lock);
+	bit = bitmap_find_free_region(mip->bitmap, mip->num_msis,
+				      ilog2(nr_irqs));
+	spin_unlock(&mip->lock);
+
+	if (bit < 0)
+		return bit;
+
+	if (hwirq)
+		*hwirq = bit;
+
+	return 0;
+}
+
+static void mip_free_hwirq(struct mip_priv *mip, unsigned int hwirq,
+			   unsigned int nr_irqs)
+{
+	spin_lock(&mip->lock);
+	bitmap_release_region(mip->bitmap, hwirq, ilog2(nr_irqs));
+	spin_unlock(&mip->lock);
+}
+
+static int mip_middle_domain_alloc(struct irq_domain *domain, unsigned int virq,
+				   unsigned int nr_irqs, void *arg)
+{
+	struct mip_priv *mip = domain->host_data;
+	struct irq_fwspec fwspec = {0};
+	unsigned int hwirq, irq, i;
+	struct irq_data *irqd;
+	int ret;
+
+	ret = mip_alloc_hwirq(mip, nr_irqs, &irq);
+	if (ret < 0)
+		return ret;
+
+	hwirq = irq + mip->msi_offset;
+
+	fwspec.fwnode = domain->parent->fwnode;
+	fwspec.param_count = 3;
+	fwspec.param[0] = 0;
+	fwspec.param[1] = hwirq + mip->msi_base;
+	fwspec.param[2] = IRQ_TYPE_EDGE_RISING;
+
+	ret = irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, &fwspec);
+	if (ret) {
+		mip_free_hwirq(mip, irq, nr_irqs);
+		return ret;
+	}
+
+	for (i = 0; i < nr_irqs; i++) {
+		irqd = irq_domain_get_irq_data(domain->parent, virq + i);
+		irqd->chip->irq_set_type(irqd, IRQ_TYPE_EDGE_RISING);
+
+		ret = irq_domain_set_hwirq_and_chip(domain, virq + i, hwirq + i,
+						    &mip_middle_irq_chip, mip);
+		if (ret)
+			goto err_free;
+
+		irqd = irq_get_irq_data(virq + i);
+		irqd_set_single_target(irqd);
+		irqd_set_affinity_on_activate(irqd);
+	}
+
+	return 0;
+
+err_free:
+	irq_domain_free_irqs_parent(domain, virq, nr_irqs);
+	mip_free_hwirq(mip, irq, nr_irqs);
+	return ret;
+}
+
+static void mip_middle_domain_free(struct irq_domain *domain, unsigned int virq,
+				   unsigned int nr_irqs)
+{
+	struct irq_data *irqd = irq_domain_get_irq_data(domain, virq);
+	struct mip_priv *mip;
+	unsigned int hwirq;
+
+	if (!irqd)
+		return;
+
+	mip = irq_data_get_irq_chip_data(irqd);
+	hwirq = irqd_to_hwirq(irqd);
+	irq_domain_free_irqs_parent(domain, virq, nr_irqs);
+	mip_free_hwirq(mip, hwirq - mip->msi_offset, nr_irqs);
+}
+
+static const struct irq_domain_ops mip_middle_domain_ops = {
+	.select		= msi_lib_irq_domain_select,
+	.alloc		= mip_middle_domain_alloc,
+	.free		= mip_middle_domain_free,
+};
+
+#define MIP_MSI_FLAGS_REQUIRED	(MSI_FLAG_USE_DEF_DOM_OPS |	\
+				 MSI_FLAG_USE_DEF_CHIP_OPS |	\
+				 MSI_FLAG_PCI_MSI_MASK_PARENT)
+
+#define MIP_MSI_FLAGS_SUPPORTED	(MSI_GENERIC_FLAGS_MASK |	\
+				 MSI_FLAG_MULTI_PCI_MSI |	\
+				 MSI_FLAG_PCI_MSIX)
+
+static const struct msi_parent_ops mip_msi_parent_ops = {
+	.supported_flags	= MIP_MSI_FLAGS_SUPPORTED,
+	.required_flags		= MIP_MSI_FLAGS_REQUIRED,
+	.bus_select_token       = DOMAIN_BUS_GENERIC_MSI,
+	.bus_select_mask	= MATCH_PCI_MSI,
+	.prefix			= "MIP-MSI-",
+	.init_dev_msi_info	= msi_lib_init_dev_msi_info,
+};
+
+static int mip_init_domains(struct mip_priv *mip, struct device_node *np)
+{
+	struct irq_domain *middle;
+
+	middle = irq_domain_add_hierarchy(mip->parent, 0, mip->num_msis, np,
+					  &mip_middle_domain_ops, mip);
+	if (!middle)
+		return -ENOMEM;
+
+	irq_domain_update_bus_token(middle, DOMAIN_BUS_GENERIC_MSI);
+	middle->dev = mip->dev;
+	middle->flags |= IRQ_DOMAIN_FLAG_MSI_PARENT;
+	middle->msi_parent_ops = &mip_msi_parent_ops;
+
+	return 0;
+}
+
+static int mip_parse_dt(struct mip_priv *mip, struct device_node *np)
+{
+	struct of_phandle_args args;
+	u64 size;
+	int ret;
+
+	ret = of_property_read_u32(np, "brcm,msi-offset", &mip->msi_offset);
+	if (ret)
+		mip->msi_offset = 0;
+
+	ret = of_parse_phandle_with_args(np, "msi-ranges", "#interrupt-cells",
+					 0, &args);
+	if (ret)
+		return ret;
+
+	ret = of_property_read_u32_index(np, "msi-ranges", args.args_count + 1,
+					 &mip->num_msis);
+	if (ret)
+		goto err_put;
+
+	ret = of_property_read_reg(np, 1, &mip->msg_addr, &size);
+	if (ret)
+		goto err_put;
+
+	mip->msi_base = args.args[1];
+
+	mip->parent = irq_find_host(args.np);
+	if (!mip->parent)
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
+	struct platform_device *pdev;
+	struct mip_priv *mip;
+	int ret;
+
+	pdev = of_find_device_by_node(node);
+	of_node_put(node);
+	if (!pdev)
+		return -EPROBE_DEFER;
+
+	mip = kzalloc(sizeof(*mip), GFP_KERNEL);
+	if (!mip)
+		return -ENOMEM;
+
+	spin_lock_init(&mip->lock);
+	mip->dev = &pdev->dev;
+
+	ret = mip_parse_dt(mip, node);
+	if (ret)
+		goto err_priv;
+
+	mip->base = of_iomap(node, 0);
+	if (!mip->base) {
+		ret = -ENXIO;
+		goto err_priv;
+	}
+
+	mip->bitmap = bitmap_zalloc(mip->num_msis, GFP_KERNEL);
+	if (!mip->bitmap) {
+		ret = -ENOMEM;
+		goto err_base;
+	}
+
+	/*
+	 * All MSI-X masked in for the host, masked out for the
+	 * VPU, and edge-triggered.
+	 */
+	writel(0, mip->base + MIP_INT_MASKL_HOST);
+	writel(0, mip->base + MIP_INT_MASKH_HOST);
+	writel(~0, mip->base + MIP_INT_MASKL_VPU);
+	writel(~0, mip->base + MIP_INT_MASKH_VPU);
+	writel(~0, mip->base + MIP_INT_CFGL_HOST);
+	writel(~0, mip->base + MIP_INT_CFGH_HOST);
+
+	ret = mip_init_domains(mip, node);
+	if (ret)
+		goto err_map;
+
+	dev_dbg(&pdev->dev,
+		"MIP: MSI-X count: %u, base: %u, offset: %u, msg_addr: %llx\n",
+		mip->num_msis, mip->msi_base, mip->msi_offset, mip->msg_addr);
+
+	return 0;
+
+err_map:
+	bitmap_free(mip->bitmap);
+err_base:
+	iounmap(mip->base);
+err_priv:
+	kfree(mip);
+	return ret;
+}
+
+IRQCHIP_PLATFORM_DRIVER_BEGIN(mip_msi)
+IRQCHIP_MATCH("brcm,bcm2712-mip", mip_of_msi_init)
+IRQCHIP_PLATFORM_DRIVER_END(mip_msi)
+MODULE_DESCRIPTION("Broadcom BCM2712 MSI interrupt controller");
+MODULE_AUTHOR("Phil Elwell <phil@raspberrypi.com>");
+MODULE_AUTHOR("Stanimir Varbanov <svarbanov@suse.de>");
+MODULE_LICENSE("GPL");
-- 
2.43.0


