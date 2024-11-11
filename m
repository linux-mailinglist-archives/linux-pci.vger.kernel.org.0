Return-Path: <linux-pci+bounces-16420-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5719C381B
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2024 07:00:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F37B1C213B5
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2024 06:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7849614EC55;
	Mon, 11 Nov 2024 06:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U+qFU4pT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1417F477;
	Mon, 11 Nov 2024 06:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731304809; cv=none; b=hyaD3pnLU6INM9uxt8PP6VSI9rhT265T7NChgO4lHWI7b4ZEbdy3rgJdnMMAeAaVde2nedGInCzKMcmP/YxDiUYTfy1q/jG/lcAvmZ4/i3rUTg+VlJDqqJQW3HSHYcVvL2KhQWVeL+6rlxZufDIv0RzAOkHHmYIMcBJQAPb+abk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731304809; c=relaxed/simple;
	bh=DdAdT+H4NWuTmq02p5pMjKVRqdMYBZLMH24DDbJ0dvE=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YL11uyFEtrdJmO8liFWVfGr++YZF8zBir4NU8MD4kxezU1vw4n3fIDIypqStf6I6Q8QFxTuU3CWkHWc9MoXrC1pI0XMvgZGTwlHJJ1iLAlZb6w0FF1z3JQu2Bi/7pVT3nbH/Tb+sUZazBmWvo2yQn2vPqzUzVP5iJ+VM/Ke2ARA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U+qFU4pT; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3e5f6e44727so2652515b6e.0;
        Sun, 10 Nov 2024 22:00:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731304806; x=1731909606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yTvANXTv/aWffsiW3Z8BnaLjvFYPVRyPf6OKa3zX8yI=;
        b=U+qFU4pTt6epQ9vrpSHypbuEG0s18uRmqoOHD+vDA7jBdtgZnQYGlFwWVU+fKf+xny
         Gs54ABlG45GTU7asqd+NEltSwZsVdBXCWe5f/xjRH5fMIbQl7Xv2TFWIPZ3HONL5HlwQ
         vWxDM+7ZaLcl49Z0yCn8TzInyQazsRYxBdKT1LC9d8+aCPV7UMhPQJJj5tH4eDOFmsYA
         hZafDGImar/zOznm1q9BiLYvJnBGeGUklrJJusT7et7bPi5a/94/VPBW7X6TB8T/xLio
         NimDuUZHQmz0ZhJ/TPeD8OdoLNBEY2x296pVddpx6yy6RiuFcgv0vASOqOZgzhwCE9k1
         PMHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731304806; x=1731909606;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yTvANXTv/aWffsiW3Z8BnaLjvFYPVRyPf6OKa3zX8yI=;
        b=jdLB8W4jEeD2CCxteuJOUHswH0RwkUi0sSiMF0dwnx06iLWZAvpwiOfP6++AxHpSFd
         3568oioOjxz8nEkZFmrQH+oCPVHtL0KvcemS5z4+2v6Y28Am6ailixN0uMyU0AXyXnzv
         byTgwUzkxt2eDAP/fZKHkWH5b7eoC40XIV+HvM2GtOFl4FXvdd6rppllPBKQv1otCs9F
         MFf0qVIX7bm/I3ovhomkQwu62YQ5vv/1L2eAk3jrar87qEyoHUuzo9nqEKAgC8mg8mT9
         T/Xw8alOLoB4iu0bPuwkBh0V3t0U+cWCeypeSUDM5TKmujwa+cb6LFUx+Qy4PorT6ME6
         8GFg==
X-Forwarded-Encrypted: i=1; AJvYcCW0Ve7u+/WV/qfD0d4RzyYcLMqYhGAiJHUaCPht2Forf9jOuVXaww19H2KUESTtSEzB+8NmFXdDNXQL54Wf@vger.kernel.org, AJvYcCWL+Il8CO3JZV5yBwfB9RwuMAH91LVZoAITZt3f9R5oeGoT7wMiuZV5hMeWP35kEJy9ikcRHvQgvhVI@vger.kernel.org, AJvYcCWZP5RZbuR9gyOruytQgfsgt1wjC/+PsKRGMUHgdodqYeObcFmBaU6PFySlEVUZaO3TNRnGml+lAYTP@vger.kernel.org
X-Gm-Message-State: AOJu0YxpEsxD3457Bf59DVWnJOQzcaKqhCk8UP4o1zXl1LPxjU9v2ru5
	Uxbb5lhzF9lKTljThOaNaLJ6F1niEBFOXH/rNfIDwEGsdeJA6YUq
X-Google-Smtp-Source: AGHT+IE3v9OKk7/ZZ1EhbQsAltY55IOxcpt4L/XvmjK+OgLTOKKEVpwX2jTyucXcN5dpWcFx1TPARA==
X-Received: by 2002:a05:6808:1794:b0:3e6:3878:13c4 with SMTP id 5614622812f47-3e79468354bmr9275319b6e.2.1731304805752;
        Sun, 10 Nov 2024 22:00:05 -0800 (PST)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e78cc67520sm1981181b6e.9.2024.11.10.22.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2024 22:00:04 -0800 (PST)
From: Chen Wang <unicornxw@gmail.com>
To: kw@linux.com,
	u.kleine-koenig@baylibre.com,
	aou@eecs.berkeley.edu,
	arnd@arndb.de,
	bhelgaas@google.com,
	unicorn_wang@outlook.com,
	conor+dt@kernel.org,
	guoren@kernel.org,
	inochiama@outlook.com,
	krzk+dt@kernel.org,
	lee@kernel.org,
	lpieralisi@kernel.org,
	manivannan.sadhasivam@linaro.org,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	pbrobinson@gmail.com,
	robh@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	chao.wei@sophgo.com,
	xiaoguang.xing@sophgo.com,
	fengchun.li@sophgo.com
Subject: [PATCH 2/5] PCI: sg2042: Add Sophgo SG2042 PCIe driver
Date: Mon, 11 Nov 2024 13:59:56 +0800
Message-Id: <5051f2375ff6218e7d44ce0c298efd5f9ee56964.1731303328.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1731303328.git.unicorn_wang@outlook.com>
References: <cover.1731303328.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Wang <unicorn_wang@outlook.com>

Add support for PCIe controller in SG2042 SoC. The controller
uses the Cadence PCIe core programmed by pcie-cadence*.c. The
PCIe controller will work in host mode only.

Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
---
 drivers/pci/controller/cadence/Kconfig       |  11 +
 drivers/pci/controller/cadence/Makefile      |   1 +
 drivers/pci/controller/cadence/pcie-sg2042.c | 611 +++++++++++++++++++
 3 files changed, 623 insertions(+)
 create mode 100644 drivers/pci/controller/cadence/pcie-sg2042.c

diff --git a/drivers/pci/controller/cadence/Kconfig b/drivers/pci/controller/cadence/Kconfig
index 8a0044bb3989..45a16215ea94 100644
--- a/drivers/pci/controller/cadence/Kconfig
+++ b/drivers/pci/controller/cadence/Kconfig
@@ -67,4 +67,15 @@ config PCI_J721E_EP
 	  Say Y here if you want to support the TI J721E PCIe platform
 	  controller in endpoint mode. TI J721E PCIe controller uses Cadence PCIe
 	  core.
+
+config PCIE_SG2042
+	bool "Sophgo SG2042 PCIe controller (host mode)"
+	depends on ARCH_SOPHGO || COMPILE_TEST
+	depends on OF
+	select PCIE_CADENCE_HOST
+	help
+	  Say Y here if you want to support the Sophgo SG2042 PCIe platform
+	  controller in host mode. Sophgo SG2042 PCIe controller uses Cadence
+	  PCIe core.
+
 endmenu
diff --git a/drivers/pci/controller/cadence/Makefile b/drivers/pci/controller/cadence/Makefile
index 9bac5fb2f13d..89aa316f54ac 100644
--- a/drivers/pci/controller/cadence/Makefile
+++ b/drivers/pci/controller/cadence/Makefile
@@ -4,3 +4,4 @@ obj-$(CONFIG_PCIE_CADENCE_HOST) += pcie-cadence-host.o
 obj-$(CONFIG_PCIE_CADENCE_EP) += pcie-cadence-ep.o
 obj-$(CONFIG_PCIE_CADENCE_PLAT) += pcie-cadence-plat.o
 obj-$(CONFIG_PCI_J721E) += pci-j721e.o
+obj-$(CONFIG_PCIE_SG2042) += pcie-sg2042.o
\ No newline at end of file
diff --git a/drivers/pci/controller/cadence/pcie-sg2042.c b/drivers/pci/controller/cadence/pcie-sg2042.c
new file mode 100644
index 000000000000..809edb8e7259
--- /dev/null
+++ b/drivers/pci/controller/cadence/pcie-sg2042.c
@@ -0,0 +1,611 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * pcie-sg2042 - PCIe controller driver for Sophgo SG2042 SoC
+ *
+ * Copyright (C) 2024 Sophgo Technology Inc.
+ * Copyright (C) 2024 Chen Wang <unicorn_wang@outlook.com>
+ */
+
+#include <linux/bits.h>
+#include <linux/irq.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/irqdomain.h>
+#include <linux/kernel.h>
+#include <linux/mfd/syscon.h>
+#include <linux/msi.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/of_pci.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+
+#include "pcie-cadence.h"
+
+/*
+ * SG2042 PCIe controller supports two ways to report MSI:
+ * - Method A, the PICe controller implements an MSI interrupt controller inside,
+ *   and connect to PLIC upward through one interrupt line. Provides
+ *   memory-mapped msi address, and by programming the upper 32 bits of the
+ *   address to zero, it can be compatible with old pcie devices that only
+ *   support 32-bit msi address.
+ * - Method B, the PICe controller connects to PLIC upward through an
+ *   independent MSI controller "sophgo,sg2042-msi" on the SOC. The MSI
+ *   controller provides multiple(up to 32) interrupt sources to PLIC.
+ *   Compared with the first method, the advantage is that the interrupt source
+ *   is expanded, but because for SG2042, the msi address provided by the MSI
+ *   controller is fixed and only supports 64-bit address(> 2^32), it is not
+ *   compatible with old pcie devices that only support 32-bit msi address.
+ * Method A & B can be configured in DTS with property "sophgo,internal-msi",
+ * default is Method B.
+ */
+
+#define MAX_MSI_IRQS		8
+#define MAX_MSI_IRQS_PER_CTRL	1
+#define MAX_MSI_CTRLS		(MAX_MSI_IRQS / MAX_MSI_IRQS_PER_CTRL)
+#define MSI_DEF_NUM_VECTORS	MAX_MSI_IRQS
+#define BYTE_NUM_PER_MSI_VEC	4
+
+#define REG_CLEAR		0x0804
+#define REG_STATUS		0x0810
+#define REG_LINK0_MSI_ADDR_SIZE	0x085C
+#define REG_LINK1_MSI_ADDR_SIZE	0x080C
+#define REG_LINK0_MSI_ADDR_LOW	0x0860
+#define REG_LINK0_MSI_ADDR_HIGH	0x0864
+#define REG_LINK1_MSI_ADDR_LOW	0x0868
+#define REG_LINK1_MSI_ADDR_HIGH	0x086C
+
+#define REG_CLEAR_LINK0_BIT	2
+#define REG_CLEAR_LINK1_BIT	3
+#define REG_STATUS_LINK0_BIT	2
+#define REG_STATUS_LINK1_BIT	3
+
+#define REG_LINK0_MSI_ADDR_SIZE_MASK	GENMASK(15, 0)
+#define REG_LINK1_MSI_ADDR_SIZE_MASK	GENMASK(31, 16)
+
+#define SG2042_CDNS_PLAT_CPU_TO_BUS_ADDR	0xCFFFFFFFFF
+
+struct sg2042_pcie {
+	struct cdns_pcie *cdns_pcie;
+
+	struct regmap *syscon;
+
+	u32 link_id;
+	u32 internal_msi; /* Flag if use internal MSI controller, default external */
+
+	struct irq_domain *msi_domain;
+
+	int msi_irq;
+
+	dma_addr_t msi_phys;
+	void *msi_virt;
+
+	u32 num_applied_vecs; /* number of applied vectors, used to speed up ISR */
+
+	raw_spinlock_t lock;
+	DECLARE_BITMAP(msi_irq_in_use, MAX_MSI_IRQS);
+};
+
+static void sg2042_pcie_msi_irq_mask_external(struct irq_data *d)
+{
+	pci_msi_mask_irq(d);
+	irq_chip_mask_parent(d);
+}
+
+static void sg2042_pcie_msi_irq_unmask_external(struct irq_data *d)
+{
+	pci_msi_unmask_irq(d);
+	irq_chip_unmask_parent(d);
+}
+
+static struct irq_chip sg2042_pcie_msi_chip_external = {
+	.name		= "SG2042 PCIe MSI External",
+	.irq_ack	= irq_chip_ack_parent,
+	.irq_mask	= sg2042_pcie_msi_irq_mask_external,
+	.irq_unmask	= sg2042_pcie_msi_irq_unmask_external,
+};
+
+static struct msi_domain_info sg2042_pcie_msi_domain_info_external = {
+	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS),
+	.chip	= &sg2042_pcie_msi_chip_external,
+};
+
+static struct irq_chip sg2042_pcie_msi_chip = {
+	.name = "SG2042 PCIe MSI",
+	.irq_ack = irq_chip_ack_parent,
+};
+
+static struct msi_domain_info sg2042_pcie_msi_domain_info = {
+	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS),
+	.chip	= &sg2042_pcie_msi_chip,
+};
+
+static void sg2042_pcie_msi_clear_status(struct sg2042_pcie *pcie)
+{
+	u32 status, clr_msi_in_bit;
+
+	if (pcie->link_id == 1)
+		clr_msi_in_bit = BIT(REG_CLEAR_LINK1_BIT);
+	else
+		clr_msi_in_bit = BIT(REG_CLEAR_LINK0_BIT);
+
+	regmap_read(pcie->syscon, REG_CLEAR, &status);
+	status |= clr_msi_in_bit;
+	regmap_write(pcie->syscon, REG_CLEAR, status);
+
+	/* need write 0 to reset, hardware can not reset automatically */
+	status &= ~clr_msi_in_bit;
+	regmap_write(pcie->syscon, REG_CLEAR, status);
+}
+
+static int sg2042_pcie_msi_irq_set_affinity(struct irq_data *d,
+					    const struct cpumask *mask,
+					    bool force)
+{
+	if (d->parent_data)
+		return irq_chip_set_affinity_parent(d, mask, force);
+
+	return -EINVAL;
+}
+
+static void sg2042_pcie_msi_irq_compose_msi_msg(struct irq_data *d,
+						struct msi_msg *msg)
+{
+	struct sg2042_pcie *pcie = irq_data_get_irq_chip_data(d);
+	struct device *dev = pcie->cdns_pcie->dev;
+
+	msg->address_lo = lower_32_bits(pcie->msi_phys) + BYTE_NUM_PER_MSI_VEC * d->hwirq;
+	msg->address_hi = upper_32_bits(pcie->msi_phys);
+	msg->data = 1;
+
+	pcie->num_applied_vecs = d->hwirq;
+
+	dev_info(dev, "compose msi msg hwirq[%d] address_hi[%#x] address_lo[%#x]\n",
+		 (int)d->hwirq, msg->address_hi, msg->address_lo);
+}
+
+static void sg2042_pcie_msi_irq_ack(struct irq_data *d)
+{
+	struct sg2042_pcie *pcie = irq_data_get_irq_chip_data(d);
+
+	sg2042_pcie_msi_clear_status(pcie);
+}
+
+static struct irq_chip sg2042_pcie_msi_bottom_chip = {
+	.name			= "SG2042 PCIe PLIC-MSI translator",
+	.irq_ack		= sg2042_pcie_msi_irq_ack,
+	.irq_compose_msi_msg	= sg2042_pcie_msi_irq_compose_msi_msg,
+#ifdef CONFIG_SMP
+	.irq_set_affinity	= sg2042_pcie_msi_irq_set_affinity,
+#endif
+};
+
+static int sg2042_pcie_irq_domain_alloc(struct irq_domain *domain,
+					unsigned int virq, unsigned int nr_irqs,
+					void *args)
+{
+	struct sg2042_pcie *pcie = domain->host_data;
+	unsigned long flags;
+	u32 i;
+	int bit;
+
+	raw_spin_lock_irqsave(&pcie->lock, flags);
+
+	bit = bitmap_find_free_region(pcie->msi_irq_in_use, MSI_DEF_NUM_VECTORS,
+				      order_base_2(nr_irqs));
+
+	raw_spin_unlock_irqrestore(&pcie->lock, flags);
+
+	if (bit < 0)
+		return -ENOSPC;
+
+	for (i = 0; i < nr_irqs; i++)
+		irq_domain_set_info(domain, virq + i, bit + i,
+				    &sg2042_pcie_msi_bottom_chip,
+				    pcie, handle_edge_irq,
+				    NULL, NULL);
+
+	return 0;
+}
+
+static void sg2042_pcie_irq_domain_free(struct irq_domain *domain,
+					unsigned int virq, unsigned int nr_irqs)
+{
+	struct irq_data *d = irq_domain_get_irq_data(domain, virq);
+	struct sg2042_pcie *pcie = irq_data_get_irq_chip_data(d);
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&pcie->lock, flags);
+
+	bitmap_release_region(pcie->msi_irq_in_use, d->hwirq,
+			      order_base_2(nr_irqs));
+
+	raw_spin_unlock_irqrestore(&pcie->lock, flags);
+}
+
+static const struct irq_domain_ops sg2042_pcie_msi_domain_ops = {
+	.alloc	= sg2042_pcie_irq_domain_alloc,
+	.free	= sg2042_pcie_irq_domain_free,
+};
+
+/*
+ * We use the usual two domain structure, the top one being a generic PCI/MSI
+ * domain, the bottom one being SG2042-specific and handling the actual HW
+ * interrupt allocation.
+ * At the same time, for internal MSI controller(Method A), bottom chip uses a
+ * chained handler to handle the controller's MSI IRQ edge triggered.
+ */
+static int sg2042_pcie_create_msi_domain(struct sg2042_pcie *pcie,
+					 struct irq_domain *parent)
+{
+	struct device *dev = pcie->cdns_pcie->dev;
+	struct fwnode_handle *fwnode = of_node_to_fwnode(dev->of_node);
+
+	if (pcie->internal_msi)
+		pcie->msi_domain = pci_msi_create_irq_domain(fwnode,
+							     &sg2042_pcie_msi_domain_info,
+							     parent);
+
+	else
+		pcie->msi_domain = pci_msi_create_irq_domain(fwnode,
+							     &sg2042_pcie_msi_domain_info_external,
+							     parent);
+
+	if (!pcie->msi_domain) {
+		dev_err(dev, "Failed to create MSI domain\n");
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static int sg2042_pcie_setup_msi_external(struct sg2042_pcie *pcie)
+{
+	struct device *dev = pcie->cdns_pcie->dev;
+	struct device_node *np = dev->of_node;
+	struct irq_domain *parent_domain;
+	struct device_node *parent_np;
+
+	if (!of_find_property(np, "interrupt-parent", NULL)) {
+		dev_err(dev, "Can't find interrupt-parent!\n");
+		return -EINVAL;
+	}
+
+	parent_np = of_irq_find_parent(np);
+	if (!parent_np) {
+		dev_err(dev, "Can't find node of interrupt-parent!\n");
+		return -ENXIO;
+	}
+
+	parent_domain = irq_find_host(parent_np);
+	of_node_put(parent_np);
+	if (!parent_domain) {
+		dev_err(dev, "Can't find domain of interrupt-parent!\n");
+		return -ENXIO;
+	}
+
+	return sg2042_pcie_create_msi_domain(pcie, parent_domain);
+}
+
+static int sg2042_pcie_init_msi_data(struct sg2042_pcie *pcie)
+{
+	struct device *dev = pcie->cdns_pcie->dev;
+	u32 value;
+	int ret;
+
+	raw_spin_lock_init(&pcie->lock);
+
+	/*
+	 * Though the PCIe controller can address >32-bit address space, to
+	 * facilitate endpoints that support only 32-bit MSI target address,
+	 * the mask is set to 32-bit to make sure that MSI target address is
+	 * always a 32-bit address
+	 */
+	ret = dma_set_coherent_mask(dev, DMA_BIT_MASK(32));
+	if (ret < 0)
+		return ret;
+
+	pcie->msi_virt = dma_alloc_coherent(dev, BYTE_NUM_PER_MSI_VEC * MAX_MSI_IRQS,
+					    &pcie->msi_phys, GFP_KERNEL);
+	if (!pcie->msi_virt)
+		return -ENOMEM;
+
+	/* Program the msi address and size */
+	if (pcie->link_id == 1) {
+		regmap_write(pcie->syscon, REG_LINK1_MSI_ADDR_LOW,
+			     lower_32_bits(pcie->msi_phys));
+		regmap_write(pcie->syscon, REG_LINK1_MSI_ADDR_HIGH,
+			     upper_32_bits(pcie->msi_phys));
+
+		regmap_read(pcie->syscon, REG_LINK1_MSI_ADDR_SIZE, &value);
+		value = (value & REG_LINK1_MSI_ADDR_SIZE_MASK) | MAX_MSI_IRQS;
+		regmap_write(pcie->syscon, REG_LINK1_MSI_ADDR_SIZE, value);
+	} else {
+		regmap_write(pcie->syscon, REG_LINK0_MSI_ADDR_LOW,
+			     lower_32_bits(pcie->msi_phys));
+		regmap_write(pcie->syscon, REG_LINK0_MSI_ADDR_HIGH,
+			     upper_32_bits(pcie->msi_phys));
+
+		regmap_read(pcie->syscon, REG_LINK0_MSI_ADDR_SIZE, &value);
+		value = (value & REG_LINK0_MSI_ADDR_SIZE_MASK) | (MAX_MSI_IRQS << 16);
+		regmap_write(pcie->syscon, REG_LINK0_MSI_ADDR_SIZE, value);
+	}
+
+	return 0;
+}
+
+static irqreturn_t sg2042_pcie_msi_handle_irq(struct sg2042_pcie *pcie)
+{
+	u32 i, pos;
+	unsigned long val;
+	u32 status, num_vectors;
+	irqreturn_t ret = IRQ_NONE;
+
+	num_vectors = pcie->num_applied_vecs;
+	for (i = 0; i <= num_vectors; i++) {
+		status = readl((void *)(pcie->msi_virt + i * BYTE_NUM_PER_MSI_VEC));
+		if (!status)
+			continue;
+
+		ret = IRQ_HANDLED;
+		val = status;
+		pos = 0;
+		while ((pos = find_next_bit(&val, MAX_MSI_IRQS_PER_CTRL,
+					    pos)) != MAX_MSI_IRQS_PER_CTRL) {
+			generic_handle_domain_irq(pcie->msi_domain->parent,
+						  (i * MAX_MSI_IRQS_PER_CTRL) +
+						  pos);
+			pos++;
+		}
+		writel(0, ((void *)(pcie->msi_virt) + i * BYTE_NUM_PER_MSI_VEC));
+	}
+	return ret;
+}
+
+static void sg2042_pcie_msi_chained_isr(struct irq_desc *desc)
+{
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	u32 status, st_msi_in_bit;
+	struct sg2042_pcie *pcie;
+
+	chained_irq_enter(chip, desc);
+
+	pcie = irq_desc_get_handler_data(desc);
+	if (pcie->link_id == 1)
+		st_msi_in_bit = REG_STATUS_LINK1_BIT;
+	else
+		st_msi_in_bit = REG_STATUS_LINK0_BIT;
+
+	regmap_read(pcie->syscon, REG_STATUS, &status);
+	if ((status >> st_msi_in_bit) & 0x1) {
+		sg2042_pcie_msi_clear_status(pcie);
+
+		sg2042_pcie_msi_handle_irq(pcie);
+	}
+
+	chained_irq_exit(chip, desc);
+}
+
+static int sg2042_pcie_setup_msi(struct sg2042_pcie *pcie, struct platform_device *pdev)
+{
+	struct device *dev = pcie->cdns_pcie->dev;
+	struct fwnode_handle *fwnode = of_node_to_fwnode(dev->of_node);
+	struct irq_domain *parent_domain;
+	int ret = 0;
+
+	parent_domain = irq_domain_create_linear(fwnode, MSI_DEF_NUM_VECTORS,
+						 &sg2042_pcie_msi_domain_ops, pcie);
+	if (!parent_domain) {
+		dev_err(dev, "Failed to create IRQ domain\n");
+		return -ENOMEM;
+	}
+	irq_domain_update_bus_token(parent_domain, DOMAIN_BUS_NEXUS);
+
+	ret = sg2042_pcie_create_msi_domain(pcie, parent_domain);
+	if (ret) {
+		irq_domain_remove(parent_domain);
+		return ret;
+	}
+
+	ret = sg2042_pcie_init_msi_data(pcie);
+	if (ret) {
+		dev_err(dev, "Failed to initialize msi data!\n");
+		return ret;
+	}
+
+	ret = platform_get_irq_byname(pdev, "msi");
+	if (ret <= 0) {
+		dev_err(dev, "failed to get MSI irq\n");
+		return ret;
+	}
+	pcie->msi_irq = ret;
+
+	irq_set_chained_handler_and_data(pcie->msi_irq,
+					 sg2042_pcie_msi_chained_isr, pcie);
+
+	return 0;
+}
+
+static void sg2042_pcie_free_msi(struct sg2042_pcie *pcie)
+{
+	struct device *dev = pcie->cdns_pcie->dev;
+
+	if (pcie->msi_irq)
+		irq_set_chained_handler_and_data(pcie->msi_irq, NULL, NULL);
+
+	if (pcie->msi_virt)
+		dma_free_coherent(dev, BYTE_NUM_PER_MSI_VEC * MAX_MSI_IRQS,
+				  pcie->msi_virt, pcie->msi_phys);
+}
+
+static u64 sg2042_cdns_pcie_cpu_addr_fixup(struct cdns_pcie *pcie, u64 cpu_addr)
+{
+	return cpu_addr & SG2042_CDNS_PLAT_CPU_TO_BUS_ADDR;
+}
+
+static const struct cdns_pcie_ops sg2042_cdns_pcie_ops = {
+	.cpu_addr_fixup = sg2042_cdns_pcie_cpu_addr_fixup,
+};
+
+/*
+ * SG2042 only support 4-byte aligned access, so for the rootbus (i.e. to read
+ * the PCIe controller itself, read32 is required. For non-rootbus (i.e. to read
+ * the PCIe peripheral registers, supports 1/2/4 byte aligned access, so
+ * directly use read should be fine.
+ * The same is true for write.
+ */
+static int sg2042_pcie_config_read(struct pci_bus *bus, unsigned int devfn,
+				   int where, int size, u32 *value)
+{
+	if (pci_is_root_bus(bus))
+		return pci_generic_config_read32(bus, devfn, where, size,
+						 value);
+
+	return pci_generic_config_read(bus, devfn, where, size, value);
+}
+
+static int sg2042_pcie_config_write(struct pci_bus *bus, unsigned int devfn,
+				    int where, int size, u32 value)
+{
+	if (pci_is_root_bus(bus))
+		return pci_generic_config_write32(bus, devfn, where, size,
+						  value);
+
+	return pci_generic_config_write(bus, devfn, where, size, value);
+}
+
+static struct pci_ops sg2042_pcie_host_ops = {
+	.map_bus	= cdns_pci_map_bus,
+	.read		= sg2042_pcie_config_read,
+	.write		= sg2042_pcie_config_write,
+};
+
+static int sg2042_pcie_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	struct pci_host_bridge *bridge;
+	struct device_node *np_syscon;
+	struct cdns_pcie *cdns_pcie;
+	struct sg2042_pcie *pcie;
+	struct cdns_pcie_rc *rc;
+	struct regmap *syscon;
+	int ret;
+
+	if (!IS_ENABLED(CONFIG_PCIE_CADENCE_HOST))
+		return -ENODEV;
+
+	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
+	if (!pcie)
+		return -ENOMEM;
+
+	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*rc));
+	if (!bridge) {
+		dev_err(dev, "Failed to alloc host bridge!\n");
+		return -ENOMEM;
+	}
+	bridge->ops = &sg2042_pcie_host_ops;
+
+	rc = pci_host_bridge_priv(bridge);
+	cdns_pcie = &rc->pcie;
+	cdns_pcie->dev = dev;
+	cdns_pcie->ops = &sg2042_cdns_pcie_ops;
+	pcie->cdns_pcie = cdns_pcie;
+
+	np_syscon = of_parse_phandle(np, "sophgo,syscon-pcie-ctrl", 0);
+	if (!np_syscon) {
+		dev_err(dev, "Failed to get syscon node\n");
+		return -ENOMEM;
+	}
+	syscon = syscon_node_to_regmap(np_syscon);
+	if (IS_ERR(syscon)) {
+		dev_err(dev, "Failed to get regmap for syscon\n");
+		return -ENOMEM;
+	}
+	pcie->syscon = syscon;
+
+	if (of_property_read_u32(np, "sophgo,link-id", &pcie->link_id)) {
+		dev_err(dev, "Unable to parse link ID\n");
+		return -EINVAL;
+	}
+
+	pcie->internal_msi = 0;
+	if (of_property_read_bool(np, "sophgo,internal-msi"))
+		pcie->internal_msi = 1;
+
+	platform_set_drvdata(pdev, pcie);
+
+	pm_runtime_enable(dev);
+
+	ret = pm_runtime_get_sync(dev);
+	if (ret < 0) {
+		dev_err(dev, "pm_runtime_get_sync failed\n");
+		goto err_get_sync;
+	}
+
+	if (pcie->internal_msi) {
+		ret = sg2042_pcie_setup_msi(pcie, pdev);
+		if (ret < 0)
+			goto err_setup_msi;
+	} else {
+		ret = sg2042_pcie_setup_msi_external(pcie);
+		if (ret < 0)
+			goto err_setup_msi;
+	}
+
+	ret = cdns_pcie_init_phy(dev, cdns_pcie);
+	if (ret) {
+		dev_err(dev, "Failed to init phy!\n");
+		goto err_setup_msi;
+	}
+
+	ret = cdns_pcie_host_setup(rc);
+	if (ret < 0) {
+		dev_err(dev, "Failed to setup host!\n");
+		goto err_host_setup;
+	}
+
+	return 0;
+
+err_host_setup:
+	cdns_pcie_disable_phy(cdns_pcie);
+
+err_setup_msi:
+	sg2042_pcie_free_msi(pcie);
+
+err_get_sync:
+	pm_runtime_put(dev);
+	pm_runtime_disable(dev);
+
+	return ret;
+}
+
+static void sg2042_pcie_shutdown(struct platform_device *pdev)
+{
+	struct sg2042_pcie *pcie = platform_get_drvdata(pdev);
+	struct cdns_pcie *cdns_pcie = pcie->cdns_pcie;
+	struct device *dev = &pdev->dev;
+
+	sg2042_pcie_free_msi(pcie);
+
+	cdns_pcie_disable_phy(cdns_pcie);
+
+	pm_runtime_put(dev);
+	pm_runtime_disable(dev);
+}
+
+static const struct of_device_id sg2042_pcie_of_match[] = {
+	{ .compatible = "sophgo,sg2042-pcie-host" },
+	{},
+};
+
+static struct platform_driver sg2042_pcie_driver = {
+	.driver = {
+		.name		= "sg2042-pcie",
+		.of_match_table	= sg2042_pcie_of_match,
+		.pm		= &cdns_pcie_pm_ops,
+	},
+	.probe		= sg2042_pcie_probe,
+	.shutdown	= sg2042_pcie_shutdown,
+};
+builtin_platform_driver(sg2042_pcie_driver);
-- 
2.34.1


