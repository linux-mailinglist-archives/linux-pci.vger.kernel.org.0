Return-Path: <linux-pci+bounces-19829-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 265DFA11A67
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 08:07:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 859B77A1A18
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 07:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57F922F853;
	Wed, 15 Jan 2025 07:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4we7FB4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52091BEF9E;
	Wed, 15 Jan 2025 07:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736924829; cv=none; b=EkirXYgoqaJIw/K2C5PAkZng5MCaaybmBTzJbkTcgBgHcqvNT/dgt6zpETtx/PIWCLeeNPQH7DDWZExkVN8OIlJEeIu1D7gG3SkgBXRTILPg+rs+kdddV5EVM1OWIIa6WAU0EzloV0XLF2O4+/W/v/UtFycgkywiQHmpkStJFHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736924829; c=relaxed/simple;
	bh=gF/M0n0QNPR53j6burAtsSWpReBGRHG1J0tkSyad8dM=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OCHuU0VAdsmlsLgKe+QqiLDwqbotX8bAQyZ81ekM9oab47FXhqiqBdPXVjvgpL7puDkG/LmktbdV7PE3jAp67KWYMv2wEbt6H+by9gyYNR84DOeHJKII6hq4gT6sIF8Oo+iQckWdAA/B2xfq9xuzz/qMqML+okJgKr2W3bdtqHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D4we7FB4; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5f4cc48ab37so1835018eaf.1;
        Tue, 14 Jan 2025 23:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736924826; x=1737529626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=abobXy0SXY71oXKljRUVM/MN4IZYip5SxUDW7tMtbSU=;
        b=D4we7FB4c5EA0SXgdojkkGE05nRImyrOxpzMALP8QyGLkLjvGbPrvNuUeSnUgY8Mco
         zN6gx0FNsImrTqlnwtItNowMJUcTZ72IMmdSkRHQlvRUwDznmVuBHiOdTjhmO3eo7gMM
         Rx7/plusy22Zt/wcpQvc2uYlb0jlCz9AXgiYLOPfLhTRV5YQ1B3ur4FWrMCRcTb3sEBn
         JEFZqrG2FDFT/3QFqINo1P5Ik5c0EvESq84afvfHD315mrgUPKiVeZddkTW8AkWnzn4n
         y78sqO56CKsXeC5kf339quhQ1aFWrGJtYforI5E55Wb88FmpkhlLNwoDvSbGOhNKhg1a
         O8zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736924826; x=1737529626;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=abobXy0SXY71oXKljRUVM/MN4IZYip5SxUDW7tMtbSU=;
        b=ZeqPw2otJj7y3A2lCsRrlaoPanPLDDmx6V8XSDr0P8rSM0PMdDk1d6+hGSVfBp0ogZ
         +fxeTg7BcMZNXqLiHgZN9Hi28NRJ3cqqWL+gob45fmRfiIzuewFFItawppeX9/VYMPQm
         cSZhcej2+jsPdfOcjPK3TM9KmCq/i5Hq7oSOn1uR7LkKGSWBXNbtBzZ8NeVPKwu2Qhz0
         sP2WYtOQlA7oqrP+HQJk5tUNyLJzw2pww0Hl9pV0Fs00Pq1HmiJ5mKzUp7aWrUPKaXZI
         rz4Mdttl4Nm0TC8CaigJOVwY3dvfEneJADUJ4AWmeNc4+I7YWoct0BIXeakMpVqS238i
         H4ig==
X-Forwarded-Encrypted: i=1; AJvYcCVjrLeNNem04mY46024ud+klNHpxRMAgdmGlVZGPA6GGWRI45THVmCWcgWF8cubvNuY5pTnwldRCHJlIE8i@vger.kernel.org, AJvYcCX29alJaho+xWk+6P5BdHY2/uujbDnYYuJZxEqmLYbOQamvzDy6CIdXcuejZiDUe8LYntZ2dyzLCrhp@vger.kernel.org, AJvYcCXhfJJ5E/t9B7/zqIwrbBQMYaVsn2PwVKFjRAzA//PbhRszG1DGjK2SphuD97MdzXBXAQN998vBiraR@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2JY43vcAMXe5OFtfAifjLQULYIGHw+Ug0va5veuahGsfByORp
	9S9HS6X2s/HnEpL1ehHcoTGDqDwr2gV7SqUa4+IvyGodq8SuCqQU
X-Gm-Gg: ASbGnctKopBtgFm19PcYh/d5kaUtBhUF0kCAmzNE/iJ2VzlOlxJ3BsjQylcXV8l2P+l
	q8Kh6P0hNKnMFnrM/eFiRW0XX431emmcZxj9HPgJe6Hd+pmISyRTUUVnAWApIAnvPjsWwoyNsFY
	vsrfwpagsYvogLgTwHiD98v5kKv6+TVTh8FD1TDLDbKualasjTxUiufnio/zyvUPN1AeuE900xD
	H80ikz5BcZ+NgFO5zsL1ZyIHR+LVAf55GPzke9ZnSGDp6JSpOhQhHZD3JfsSu2cY3M=
X-Google-Smtp-Source: AGHT+IGvjn4v1+QVeijX68j9UlTXjSg+4mSDzzJHyrs4Sxhtm8AkRzw+g+ojXPw3T9jDHtbkdIFdrw==
X-Received: by 2002:a4a:a503:0:b0:5f7:30bf:dc61 with SMTP id 006d021491bc7-5f730bfe0b6mr11797499eaf.5.1736924826321;
        Tue, 14 Jan 2025 23:07:06 -0800 (PST)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7231861bf71sm5382880a34.52.2025.01.14.23.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 23:07:05 -0800 (PST)
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
	fengchun.li@sophgo.com,
	helgaas@kernel.org
Subject: [PATCH v3 2/5] PCI: sg2042: Add Sophgo SG2042 PCIe driver
Date: Wed, 15 Jan 2025 15:06:57 +0800
Message-Id: <ddedd8f76f83fea2c6d3887132d2fe6f2a6a02c1.1736923025.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1736923025.git.unicorn_wang@outlook.com>
References: <cover.1736923025.git.unicorn_wang@outlook.com>
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
 drivers/pci/controller/cadence/Kconfig       |  13 +
 drivers/pci/controller/cadence/Makefile      |   1 +
 drivers/pci/controller/cadence/pcie-sg2042.c | 528 +++++++++++++++++++
 3 files changed, 542 insertions(+)
 create mode 100644 drivers/pci/controller/cadence/pcie-sg2042.c

diff --git a/drivers/pci/controller/cadence/Kconfig b/drivers/pci/controller/cadence/Kconfig
index 8a0044bb3989..292eb2b20e9c 100644
--- a/drivers/pci/controller/cadence/Kconfig
+++ b/drivers/pci/controller/cadence/Kconfig
@@ -42,6 +42,18 @@ config PCIE_CADENCE_PLAT_EP
 	  endpoint mode. This PCIe controller may be embedded into many
 	  different vendors SoCs.
 
+config PCIE_SG2042
+	bool "Sophgo SG2042 PCIe controller (host mode)"
+	depends on ARCH_SOPHGO || COMPILE_TEST
+	depends on OF
+	select IRQ_MSI_LIB
+	select PCI_MSI
+	select PCIE_CADENCE_HOST
+	help
+	  Say Y here if you want to support the Sophgo SG2042 PCIe platform
+	  controller in host mode. Sophgo SG2042 PCIe controller uses Cadence
+	  PCIe core.
+
 config PCI_J721E
 	bool
 
@@ -67,4 +79,5 @@ config PCI_J721E_EP
 	  Say Y here if you want to support the TI J721E PCIe platform
 	  controller in endpoint mode. TI J721E PCIe controller uses Cadence PCIe
 	  core.
+
 endmenu
diff --git a/drivers/pci/controller/cadence/Makefile b/drivers/pci/controller/cadence/Makefile
index 9bac5fb2f13d..4df4456d9539 100644
--- a/drivers/pci/controller/cadence/Makefile
+++ b/drivers/pci/controller/cadence/Makefile
@@ -4,3 +4,4 @@ obj-$(CONFIG_PCIE_CADENCE_HOST) += pcie-cadence-host.o
 obj-$(CONFIG_PCIE_CADENCE_EP) += pcie-cadence-ep.o
 obj-$(CONFIG_PCIE_CADENCE_PLAT) += pcie-cadence-plat.o
 obj-$(CONFIG_PCI_J721E) += pci-j721e.o
+obj-$(CONFIG_PCIE_SG2042) += pcie-sg2042.o
diff --git a/drivers/pci/controller/cadence/pcie-sg2042.c b/drivers/pci/controller/cadence/pcie-sg2042.c
new file mode 100644
index 000000000000..56797c2af755
--- /dev/null
+++ b/drivers/pci/controller/cadence/pcie-sg2042.c
@@ -0,0 +1,528 @@
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
+#include "../../../irqchip/irq-msi-lib.h"
+
+#include "pcie-cadence.h"
+
+/*
+ * SG2042 PCIe controller supports two ways to report MSI:
+ *
+ * - Method A, the PCIe controller implements an MSI interrupt controller
+ *   inside, and connect to PLIC upward through one interrupt line.
+ *   Provides memory-mapped MSI address, and by programming the upper 32
+ *   bits of the address to zero, it can be compatible with old PCIe devices
+ *   that only support 32-bit MSI address.
+ *
+ * - Method B, the PCIe controller connects to PLIC upward through an
+ *   independent MSI controller "sophgo,sg2042-msi" on the SOC. The MSI
+ *   controller provides multiple(up to 32) interrupt sources to PLIC.
+ *   Compared with the first method, the advantage is that the interrupt
+ *   source is expanded, but because for SG2042, the MSI address provided by
+ *   the MSI controller is fixed and only supports 64-bit address(> 2^32),
+ *   it is not compatible with old PCIe devices that only support 32-bit MSI
+ *   address.
+ *
+ * Method A & B can be configured in DTS, default is Method B.
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
+struct sg2042_pcie {
+	struct cdns_pcie	*cdns_pcie;
+
+	struct regmap		*syscon;
+
+	u32			link_id;
+
+	struct irq_domain	*msi_domain;
+
+	int			msi_irq;
+
+	dma_addr_t		msi_phys;
+	void			*msi_virt;
+
+	u32			num_applied_vecs; /* used to speed up ISR */
+
+	raw_spinlock_t		msi_lock;
+	DECLARE_BITMAP(msi_irq_in_use, MAX_MSI_IRQS);
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
+	if (d->hwirq > pcie->num_applied_vecs)
+		pcie->num_applied_vecs = d->hwirq;
+
+	dev_dbg(dev, "compose MSI msg hwirq[%ld] address_hi[%#x] address_lo[%#x]\n",
+		d->hwirq, msg->address_hi, msg->address_lo);
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
+	.irq_set_affinity	= sg2042_pcie_msi_irq_set_affinity,
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
+	raw_spin_lock_irqsave(&pcie->msi_lock, flags);
+
+	bit = bitmap_find_free_region(pcie->msi_irq_in_use, MSI_DEF_NUM_VECTORS,
+				      order_base_2(nr_irqs));
+
+	raw_spin_unlock_irqrestore(&pcie->msi_lock, flags);
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
+	raw_spin_lock_irqsave(&pcie->msi_lock, flags);
+
+	bitmap_release_region(pcie->msi_irq_in_use, d->hwirq,
+			      order_base_2(nr_irqs));
+
+	raw_spin_unlock_irqrestore(&pcie->msi_lock, flags);
+}
+
+static const struct irq_domain_ops sg2042_pcie_msi_domain_ops = {
+	.alloc	= sg2042_pcie_irq_domain_alloc,
+	.free	= sg2042_pcie_irq_domain_free,
+};
+
+static int sg2042_pcie_init_msi_data(struct sg2042_pcie *pcie)
+{
+	struct device *dev = pcie->cdns_pcie->dev;
+	u32 value;
+	int ret;
+
+	raw_spin_lock_init(&pcie->msi_lock);
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
+	/* Program the MSI address and size */
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
+			generic_handle_domain_irq(pcie->msi_domain,
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
+#define SG2042_PCIE_MSI_FLAGS_REQUIRED (MSI_FLAG_USE_DEF_DOM_OPS |	\
+					MSI_FLAG_USE_DEF_CHIP_OPS)
+
+#define SG2042_PCIE_MSI_FLAGS_SUPPORTED MSI_GENERIC_FLAGS_MASK
+
+static struct msi_parent_ops sg2042_pcie_msi_parent_ops = {
+	.required_flags		= SG2042_PCIE_MSI_FLAGS_REQUIRED,
+	.supported_flags	= SG2042_PCIE_MSI_FLAGS_SUPPORTED,
+	.bus_select_mask	= MATCH_PCI_MSI,
+	.bus_select_token	= DOMAIN_BUS_NEXUS,
+	.prefix			= "SG2042-",
+	.init_dev_msi_info	= msi_lib_init_dev_msi_info,
+};
+
+static int sg2042_pcie_setup_msi(struct sg2042_pcie *pcie,
+				 struct device_node *msi_node)
+{
+	struct device *dev = pcie->cdns_pcie->dev;
+	struct fwnode_handle *fwnode = of_node_to_fwnode(dev->of_node);
+	struct irq_domain *parent_domain;
+	int ret = 0;
+
+	if (!of_property_read_bool(msi_node, "msi-controller"))
+		return -ENODEV;
+
+	ret = of_irq_get_byname(msi_node, "msi");
+	if (ret <= 0) {
+		dev_err(dev, "%pOF: failed to get MSI irq\n", msi_node);
+		return ret;
+	}
+	pcie->msi_irq = ret;
+
+	irq_set_chained_handler_and_data(pcie->msi_irq,
+					 sg2042_pcie_msi_chained_isr, pcie);
+
+	parent_domain = irq_domain_create_linear(fwnode, MSI_DEF_NUM_VECTORS,
+						 &sg2042_pcie_msi_domain_ops, pcie);
+	if (!parent_domain) {
+		dev_err(dev, "%pfw: Failed to create IRQ domain\n", fwnode);
+		return -ENOMEM;
+	}
+	irq_domain_update_bus_token(parent_domain, DOMAIN_BUS_NEXUS);
+
+	parent_domain->flags |= IRQ_DOMAIN_FLAG_MSI_PARENT;
+	parent_domain->msi_parent_ops = &sg2042_pcie_msi_parent_ops;
+
+	pcie->msi_domain = parent_domain;
+
+	ret = sg2042_pcie_init_msi_data(pcie);
+	if (ret) {
+		dev_err(dev, "Failed to initialize MSI data!\n");
+		return ret;
+	}
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
+/*
+ * SG2042 only support 4-byte aligned access, so for the rootbus (i.e. to read
+ * the Root Port itself, read32 is required. For non-rootbus (i.e. to read
+ * the PCIe peripheral registers, supports 1/2/4 byte aligned access, so
+ * directly using read should be fine.
+ *
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
+/* Dummy ops which will be assigned to cdns_pcie.ops, which must be !NULL. */
+static const struct cdns_pcie_ops sg2042_cdns_pcie_ops = {};
+
+static int sg2042_pcie_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	struct pci_host_bridge *bridge;
+	struct device_node *np_syscon;
+	struct device_node *msi_node;
+	struct cdns_pcie *cdns_pcie;
+	struct sg2042_pcie *pcie;
+	struct cdns_pcie_rc *rc;
+	struct regmap *syscon;
+	int ret;
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
+
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
+		dev_err(dev, "Unable to parse sophgo,link-id\n");
+		return -EINVAL;
+	}
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
+	msi_node = of_parse_phandle(dev->of_node, "msi-parent", 0);
+	if (!msi_node) {
+		dev_err(dev, "Failed to get msi-parent!\n");
+		return -1;
+	}
+
+	if (of_device_is_compatible(msi_node, "sophgo,sg2042-pcie-msi")) {
+		ret = sg2042_pcie_setup_msi(pcie, msi_node);
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


