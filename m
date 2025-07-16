Return-Path: <linux-pci+bounces-32227-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 269BCB06D5C
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 07:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 348C33BB010
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 05:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB292E888D;
	Wed, 16 Jul 2025 05:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=huaqian.li@siemens.com header.b="WNvUccwX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4612E2E7BA9
	for <linux-pci@vger.kernel.org>; Wed, 16 Jul 2025 05:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752644448; cv=none; b=QA2o7X+AqBzmkeHPRmScJdblx45YG0c8tASARRezkq2qrknOJQelDg+2qI2UbgiZeqvON5Dg1NMePPhe5akOvTCSZj8ecCx4P/LzNlBUoR2XfDC2oO8wf7/ACzyaEKGpNRK8qABUmS5XjzVYcw+2ZQ2eT8JgmldltesLkGLcowU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752644448; c=relaxed/simple;
	bh=N7JGZAXy2CN8CBdsb0dJ2qSAJ7eA6zAiVcdESTIVu5M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b0ai5wS61X27TcXdMy+Mwr2mtMZDqlCdSXZ8+aMOS/HQCmTDZUR9az/Y2emaitVbniV4w1tDFzjmNQVzxYUvsGDghGkABCPcFyEvwPysnOIGN3GP69yPKi0dHangSIp0QwFZJCPqN9x/5NUl3TQd+jUD0bMX3dCaAeaTC+YbA4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=huaqian.li@siemens.com header.b=WNvUccwX; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202507160540438ed5dfe8821bbb5422
        for <linux-pci@vger.kernel.org>;
        Wed, 16 Jul 2025 07:40:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=huaqian.li@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=7KKlKsyWBMFhvLQRuvSvZsxl+EKLaAI+mZf9xSsCBzo=;
 b=WNvUccwXdnCafI0QvLZxSjaLQloHlvx66KUtSsYkc9arFFKLpvZG8nt9tKRugGAB0GXF14
 ah5/BG7Y28Hfjd8Gngk/7qspu8LfWvRo0iP5lBOF19+gcf4fnlGk3Aqk+9vXhE3ZwGm0Uivq
 +hMmJrzBFtQNHHtk5xJTDITJfsHjCJrzsKiH4eNotw96lf6ukWlVRdwK89NnJjB4LoeHDgKs
 Gq90u96P4Pmmkb3ql/YOS5ATGJj31vO1UI9XsdxKwz+/zHqF6K3/cVjBn8b8UOGA/egJMoMW
 Rq5OMj9ToY7n9wPYDEWcEphhEcXl/pVkWW9f7nzqQQIBJN6WfMaeGGhg==;
From: huaqian.li@siemens.com
To: s-vadapalli@ti.com
Cc: baocheng.su@siemens.com,
	bhelgaas@google.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	diogo.ivo@siemens.com,
	helgaas@kernel.org,
	huaqian.li@siemens.com,
	jan.kiszka@siemens.com,
	kristo@kernel.org,
	krzk+dt@kernel.org,
	kw@linux.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	lpieralisi@kernel.org,
	nm@ti.com,
	robh@kernel.org,
	ssantosh@kernel.org,
	vigneshr@ti.com
Subject: [PATCH v9 (RESEND) 3/7] soc: ti: Add IOMMU-like PVU driver
Date: Wed, 16 Jul 2025 13:39:46 +0800
Message-Id: <20250716053950.199079-4-huaqian.li@siemens.com>
In-Reply-To: <20250716053950.199079-1-huaqian.li@siemens.com>
References: <e21c6ead-2bcb-422b-a1b9-eb9dd63b7dc7@ti.com>
 <20250716053950.199079-1-huaqian.li@siemens.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-959203:519-21489:flowmailer

From: Jan Kiszka <jan.kiszka@siemens.com>

The TI Peripheral Virtualization Unit (PVU) permits to define a limited
set of mappings for DMA requests on the system memory. Unlike with an
IOMMU, there is no fallback to a memory-backed page table, only a fixed
set of register-backed TLBs. Emulating an IOMMU behavior appears to be
the more fragile the more fragmentation of pending requests occur.

Therefore, this driver does not expose the PVU as an IOMMU. It rather
introduces a simple, static interface to devices that are under
restricted-dma-pool constraints. They can register their pools with the
PVUs, enabling only those pools to work for DMA. As also MSI is issued
as DMA, the PVU already register the related translator region of the
AM654 as valid DMA target.

This driver is the essential building block for limiting DMA from
untrusted devices to clearly defined memory regions in the absence of a
real IOMMU (SMMU).

Co-developed-by: Diogo Ivo <diogo.ivo@siemens.com>
Signed-off-by: Diogo Ivo <diogo.ivo@siemens.com>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Signed-off-by: Li Hua Qian <huaqian.li@siemens.com>
---
 drivers/soc/ti/Kconfig  |   4 +
 drivers/soc/ti/Makefile |   1 +
 drivers/soc/ti/ti-pvu.c | 500 ++++++++++++++++++++++++++++++++++++++++
 include/linux/ti-pvu.h  |  32 +++
 4 files changed, 537 insertions(+)
 create mode 100644 drivers/soc/ti/ti-pvu.c
 create mode 100644 include/linux/ti-pvu.h

diff --git a/drivers/soc/ti/Kconfig b/drivers/soc/ti/Kconfig
index 1a93001c9e36..af7173ad84de 100644
--- a/drivers/soc/ti/Kconfig
+++ b/drivers/soc/ti/Kconfig
@@ -82,6 +82,10 @@ config TI_PRUSS
 	  processors on various TI SoCs. It's safe to say N here if you're
 	  not interested in the PRU or if you are unsure.
 
+config TI_PVU
+	bool "TI Peripheral Virtualization Unit driver"
+	depends on ARCH_K3 && DMA_RESTRICTED_POOL
+
 endif # SOC_TI
 
 config TI_SCI_INTA_MSI_DOMAIN
diff --git a/drivers/soc/ti/Makefile b/drivers/soc/ti/Makefile
index cb800a745e66..ecff3fd8c433 100644
--- a/drivers/soc/ti/Makefile
+++ b/drivers/soc/ti/Makefile
@@ -12,3 +12,4 @@ obj-$(CONFIG_TI_K3_RINGACC)		+= k3-ringacc.o
 obj-$(CONFIG_TI_K3_SOCINFO)		+= k3-socinfo.o
 obj-$(CONFIG_TI_PRUSS)			+= pruss.o
 obj-$(CONFIG_POWER_AVS_OMAP)		+= smartreflex.o
+obj-$(CONFIG_TI_PVU)			+= ti-pvu.o
diff --git a/drivers/soc/ti/ti-pvu.c b/drivers/soc/ti/ti-pvu.c
new file mode 100644
index 000000000000..38996c74cce7
--- /dev/null
+++ b/drivers/soc/ti/ti-pvu.c
@@ -0,0 +1,500 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * TI Peripheral Virtualization Unit driver for static DMA isolation
+ *
+ * Copyright (c) 2024, Siemens AG
+ */
+
+#include <linux/io.h>
+#include <linux/interrupt.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/ti-pvu.h>
+
+#define PVU_CONFIG					0x4
+#define PVU_ENABLE					0x10
+#define PVU_VIRTID_MAP1					0x14
+#define PVU_VIRTID_MAP2					0x18
+#define PVU_EXCEPTION_LOGGING_CONTROL			0x120
+#define PVU_EXCEPTION_LOGGING_HEADER0			0x124
+#define PVU_EXCEPTION_LOGGING_HEADER1			0x128
+#define PVU_EXCEPTION_LOGGING_DATA0			0x12c
+#define PVU_EXCEPTION_LOGGING_DATA1			0x130
+#define PVU_EXCEPTION_LOGGING_DATA2			0x134
+#define PVU_EXCEPTION_LOGGING_DATA2_SECURE		BIT(0)
+#define PVU_EXCEPTION_LOGGING_DATA2_PRIV		BIT(1)
+#define PVU_EXCEPTION_LOGGING_DATA2_CACHEABLE		BIT(2)
+#define PVU_EXCEPTION_LOGGING_DATA2_DEBUG		BIT(3)
+#define PVU_EXCEPTION_LOGGING_DATA2_READ		BIT(4)
+#define PVU_EXCEPTION_LOGGING_DATA2_WRITE		BIT(5)
+#define PVU_EXCEPTION_LOGGING_DATA3			0x138
+#define PVU_EXCEPTION_ENABLE_SET			0x148
+#define PVU_EOI_REG					0x150
+
+#define PVU_CHAIN			0x0
+#define  PVU_CHAIN_EN			BIT(31)
+#define  PVU_CHAIN_LOG_DIS		BIT(30)
+#define  PVU_CHAIN_FAULT		BIT(29)
+#define  PVU_CHAIN_MASK			0xfff
+#define PVU_ENTRY0			0x20
+#define PVU_ENTRY1			0x24
+#define  PVU_ENTRY1_RESERVED_MASK	0xffff0000
+#define  PVU_ENTRY1_VBASE_H_MASK	0xffff
+#define PVU_ENTRY2			0x28
+#define  PVU_ENTRY2_RESERVED_MASK	0x1fd00080
+#define  PVU_ENTRY2_INVALID		(0U << 30)
+#define  PVU_ENTRY2_VALID		(2U << 30)
+#define  PVU_ENTRY2_MODE_MASK		0xc0000000
+#define  PVU_ENTRY2_PSIZE_SHIFT		16
+#define  PVU_ENTRY2_PSIZE_MASK		0xf
+#define  PVU_ENTRY2_PERM_SX		BIT(15)
+#define  PVU_ENTRY2_PERM_SW		BIT(14)
+#define  PVU_ENTRY2_PERM_SR		BIT(13)
+#define  PVU_ENTRY2_PERM_UX		BIT(12)
+#define  PVU_ENTRY2_PERM_UW		BIT(11)
+#define  PVU_ENTRY2_PERM_UR		BIT(10)
+#define  PVU_ENTRY2_MEM_WRITETHROUGH	(2 << 8)
+#define  PVU_ENTRY2_OUTER_SHARABLE	BIT(4)
+#define  PVU_ENTRY2_IS_NOALLOC		(0 << 2)
+#define  PVU_ENTRY2_OS_NOALLOC		(0 << 0)
+#define PVU_ENTRY4			0x30
+#define PVU_ENTRY5			0x34
+#define  PVU_ENTRY5_RESERVED_MASK	0xffff0000
+#define  PVU_ENTRY5_PBASE_H_MASK	0xffff
+#define PVU_ENTRY6			0x38
+#define  PVU_ENTRY6_RESERVED_MASK	0xffffffe0
+
+#define NUM_VIRTIDS			1
+
+static const struct regmap_config pvu_cfg_regmap_cfg = {
+	.name = "pvu-cfg",
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = PVU_EOI_REG,
+};
+
+enum pvu_cfg_regfields {
+	PVU_TLBS,
+	PVU_TLB_ENTRIES,
+	PVU_ENABLED,
+	PVU_DMA_CNT,
+	PVU_DMA_CL0,
+	PVU_DMA_CL1,
+	PVU_DMA_CL2,
+	PVU_DMA_CL3,
+	PVU_MAX_VIRTID,
+	PVU_EXC_SRC_ID,
+	PVU_EXC_CODE,
+	PVU_EXC_ADDR_L,
+	PVU_EXC_ADDR_H,
+	PVU_EXC_PRIV_ID,
+	PVU_EXC_PROPS,
+	PVU_EXC_ROUTE_ID,
+	PVU_EXC_BYTE_CNT,
+	PVU_EXC_ENABLE,
+	PVU_EOI,
+	PVU_MAX_CFG_FIELDS,
+};
+
+static const struct reg_field pvu_cfg_reg_fields[] = {
+	[PVU_TLBS] = REG_FIELD(PVU_CONFIG, 0, 15),
+	[PVU_TLB_ENTRIES] = REG_FIELD(PVU_CONFIG, 16, 23),
+	[PVU_ENABLED] = REG_FIELD(PVU_ENABLE, 0, 0),
+	[PVU_DMA_CNT] = REG_FIELD(PVU_VIRTID_MAP1, 0, 11),
+	[PVU_DMA_CL0] = REG_FIELD(PVU_VIRTID_MAP1, 16, 17),
+	[PVU_DMA_CL1] = REG_FIELD(PVU_VIRTID_MAP1, 18, 19),
+	[PVU_DMA_CL2] = REG_FIELD(PVU_VIRTID_MAP1, 20, 21),
+	[PVU_DMA_CL3] = REG_FIELD(PVU_VIRTID_MAP1, 22, 23),
+	[PVU_MAX_VIRTID] = REG_FIELD(PVU_VIRTID_MAP2, 0, 11),
+	[PVU_EXC_SRC_ID] = REG_FIELD(PVU_EXCEPTION_LOGGING_HEADER0, 8, 23),
+	[PVU_EXC_CODE] = REG_FIELD(PVU_EXCEPTION_LOGGING_HEADER1, 16, 23),
+	[PVU_EXC_ADDR_L] = REG_FIELD(PVU_EXCEPTION_LOGGING_DATA0, 0, 31),
+	[PVU_EXC_ADDR_H] = REG_FIELD(PVU_EXCEPTION_LOGGING_DATA1, 0, 15),
+	[PVU_EXC_PRIV_ID] = REG_FIELD(PVU_EXCEPTION_LOGGING_DATA2, 0, 7),
+	[PVU_EXC_PROPS] = REG_FIELD(PVU_EXCEPTION_LOGGING_DATA2, 8, 13),
+	[PVU_EXC_ROUTE_ID] = REG_FIELD(PVU_EXCEPTION_LOGGING_DATA2, 16, 27),
+	[PVU_EXC_BYTE_CNT] = REG_FIELD(PVU_EXCEPTION_LOGGING_DATA3, 0, 9),
+	[PVU_EXC_ENABLE] = REG_FIELD(PVU_EXCEPTION_ENABLE_SET, 0, 0),
+	[PVU_EOI] = REG_FIELD(PVU_EOI_REG, 0, 15),
+};
+
+struct ti_pvu {
+	struct list_head entry;
+	struct platform_device *pdev;
+	struct regmap *cfg;
+	struct regmap_field *cfg_fields[PVU_MAX_CFG_FIELDS];
+	void __iomem *tlbif_base;
+	unsigned int num_tlbs;
+	unsigned int num_entries;
+};
+
+static const char *pvu_excp_code_string[] = {
+	"PVU miss",
+	"maximum VirtID violation",
+	"<reserved>",
+	"read permission violation",
+	"write permission violation",
+	"execute permission violation",
+	"prefetch permission violation",
+	"<unknown>",
+};
+
+static const u64 pvu_page_size[] = {
+	4 * 1024ULL,
+	16 * 1024ULL,
+	64 * 1024ULL,
+	2 * 1024 * 1024ULL,
+	32 * 1024 * 1024ULL,
+	512 * 1024 * 1024ULL,
+	1 * 1024 * 1024 * 1024ULL,
+	16 * 1024 * 1024 * 1024ULL
+};
+
+static DEFINE_MUTEX(ti_pvu_lock);
+static LIST_HEAD(ti_pvu_list);
+
+static unsigned int pvu_field_read(struct ti_pvu *pvu, enum pvu_cfg_regfields f)
+{
+	int ret;
+	unsigned int val;
+
+	ret = regmap_field_read(pvu->cfg_fields[f], &val);
+	if (ret)
+		dev_err(&pvu->pdev->dev, "failed to read field\n");
+
+	return val;
+}
+
+static void pvu_field_write(struct ti_pvu *pvu, enum pvu_cfg_regfields f,
+			   unsigned int val)
+{
+	int ret;
+
+	ret = regmap_field_write(pvu->cfg_fields[f], val);
+	if (ret)
+		dev_err(&pvu->pdev->dev, "failed to write field\n");
+}
+
+static irqreturn_t pvu_fault_isr(int irq, void *dev_id)
+{
+	u32 code, bytes, route_id, priv_id, props;
+	struct ti_pvu *pvu = dev_id;
+	const char *code_str;
+	u64 address;
+
+	code = pvu_field_read(pvu, PVU_EXC_CODE);
+	code_str = pvu_excp_code_string[
+		min(code, (u32)ARRAY_SIZE(pvu_excp_code_string) - 1)];
+
+	dev_err(&pvu->pdev->dev, "fault detected, code %d (%s)\n",
+		code, code_str);
+
+	address = pvu_field_read(pvu, PVU_EXC_ADDR_L);
+	address |= (u64)pvu_field_read(pvu, PVU_EXC_ADDR_H) << 32;
+
+	bytes = pvu_field_read(pvu, PVU_EXC_BYTE_CNT);
+
+	route_id = pvu_field_read(pvu, PVU_EXC_ROUTE_ID);
+	priv_id = pvu_field_read(pvu, PVU_EXC_PRIV_ID);
+	props = pvu_field_read(pvu, PVU_EXC_PROPS);
+
+	dev_err(&pvu->pdev->dev,
+		"  address 0x%016llx size %d route-ID %d priv-ID %d flags %c%c%c%c%c%c\n",
+		address, bytes, route_id, priv_id,
+		(props & PVU_EXCEPTION_LOGGING_DATA2_WRITE)     ? 'W' : '-',
+		(props & PVU_EXCEPTION_LOGGING_DATA2_READ)      ? 'R' : '-',
+		(props & PVU_EXCEPTION_LOGGING_DATA2_DEBUG)     ? 'D' : '-',
+		(props & PVU_EXCEPTION_LOGGING_DATA2_CACHEABLE) ? 'C' : '-',
+		(props & PVU_EXCEPTION_LOGGING_DATA2_PRIV)      ? 'P' : '-',
+		(props & PVU_EXCEPTION_LOGGING_DATA2_SECURE)    ? 'S' : '-');
+
+	pvu_field_write(pvu, PVU_EOI, 0);
+
+	return IRQ_HANDLED;
+}
+
+static void __iomem *pvu_get_entry_base(struct ti_pvu *pvu, unsigned int entry)
+{
+	return pvu->tlbif_base + (entry / pvu->num_entries) * 0x1000 +
+		(entry % pvu->num_entries) * 0x20;
+}
+
+static int pvu_get_free_entry(struct ti_pvu *pvu)
+{
+	unsigned int n;
+	u32 val;
+
+	/* We use up to 2 TLBs via chainging */
+	for (n = 0; n < pvu->num_entries * 2; n++) {
+		val = readl(pvu_get_entry_base(pvu, n) + PVU_ENTRY2);
+		if ((val & PVU_ENTRY2_MODE_MASK) == PVU_ENTRY2_INVALID)
+			return n;
+	}
+	return -ENOSPC;
+}
+
+static void pvu_write_entry(struct ti_pvu *pvu, unsigned int entry,
+			    u64 addr, u32 psize)
+{
+	void __iomem *entry_base = pvu_get_entry_base(pvu, entry);
+	u32 val;
+
+	writel((u32)addr, entry_base + PVU_ENTRY0);
+
+	val = readl(entry_base + PVU_ENTRY1);
+	val &= PVU_ENTRY1_RESERVED_MASK;
+	val |= (addr >> 32) & PVU_ENTRY1_VBASE_H_MASK;
+	writel(val, entry_base + PVU_ENTRY1);
+
+	writel((u32)addr, entry_base + PVU_ENTRY4);
+
+	val = readl(entry_base + PVU_ENTRY5);
+	val &= PVU_ENTRY5_RESERVED_MASK;
+	val |= (addr >> 32) & PVU_ENTRY5_PBASE_H_MASK;
+	writel(val, entry_base + PVU_ENTRY5);
+
+	val = readl(entry_base + PVU_ENTRY6);
+	val &= PVU_ENTRY6_RESERVED_MASK;
+	writel(val, entry_base + PVU_ENTRY6);
+
+	val = readl(entry_base + PVU_ENTRY2);
+	val &= PVU_ENTRY2_RESERVED_MASK;
+	val |= psize << PVU_ENTRY2_PSIZE_SHIFT;
+	val |= PVU_ENTRY2_VALID |
+		PVU_ENTRY2_PERM_UR | PVU_ENTRY2_PERM_SR |
+		PVU_ENTRY2_PERM_UW | PVU_ENTRY2_PERM_SW |
+		PVU_ENTRY2_PERM_UX | PVU_ENTRY2_PERM_SX |
+		PVU_ENTRY2_MEM_WRITETHROUGH | PVU_ENTRY2_OUTER_SHARABLE |
+		PVU_ENTRY2_IS_NOALLOC | PVU_ENTRY2_OS_NOALLOC;
+	writel(val, entry_base + PVU_ENTRY2);
+}
+
+static int pvu_create_region(struct ti_pvu *pvu, u64 addr, u64 size)
+{
+	u64 page_size;
+	int psize;
+	int entry;
+
+	while (size > 0) {
+		entry = pvu_get_free_entry(pvu);
+		if (entry < 0) {
+			dev_err(&pvu->pdev->dev, "ran out of TLB entries\n");
+			return -ENOSPC;
+		}
+
+		for (psize = ARRAY_SIZE(pvu_page_size) - 1; psize >= 0; psize--) {
+			page_size = pvu_page_size[psize];
+			if (size >= page_size && (addr & (page_size - 1)) == 0)
+				break;
+		}
+		if (psize < 0) {
+			dev_err(&pvu->pdev->dev, "unaligned region provided\n");
+			return -EINVAL;
+		}
+
+		pvu_write_entry(pvu, entry, addr, psize);
+		dev_info(&pvu->pdev->dev,
+			 "created TLB entry %d.%d: 0x%08llx, psize %d (0x%08llx)\n",
+			 entry / pvu->num_entries, entry % pvu->num_entries,
+			 addr, psize, page_size);
+
+		size -= page_size;
+		addr += page_size;
+	}
+
+	return 0;
+}
+
+static void pvu_remove_region(struct ti_pvu *pvu, u64 addr, u64 size)
+{
+	void __iomem *entry_base;
+	unsigned int n, psize;
+	u64 entry_addr;
+	u32 entry2;
+
+	for (n = 0; n < pvu->num_entries * 2; n++) {
+		entry_base = pvu_get_entry_base(pvu, n);
+		entry2 = readl(entry_base + PVU_ENTRY2);
+		if ((entry2 & PVU_ENTRY2_MODE_MASK) != PVU_ENTRY2_VALID)
+			continue;
+
+		entry_addr = readl(entry_base + PVU_ENTRY0);
+		entry_addr |= (u64)(readl(entry_base + PVU_ENTRY1) &
+			PVU_ENTRY1_VBASE_H_MASK) << 32;
+
+		psize = (entry2 >> PVU_ENTRY2_PSIZE_SHIFT) &
+			PVU_ENTRY2_PSIZE_MASK;
+		if (psize >= ARRAY_SIZE(pvu_page_size))
+			continue;
+
+		if (entry_addr >= addr &&
+		    (entry_addr + pvu_page_size[psize]) <= (addr + size)) {
+			entry2 &= ~PVU_ENTRY2_MODE_MASK;
+			entry2 |= PVU_ENTRY2_INVALID;
+			writel(entry2, entry_base + PVU_ENTRY2);
+
+			dev_info(&pvu->pdev->dev, "removed TLB entry %d.%d\n",
+				 n / pvu->num_entries, n % pvu->num_entries);
+		}
+	}
+}
+
+int ti_pvu_create_region(unsigned int virt_id, const struct resource *region)
+{
+	struct ti_pvu *pvu;
+	int err = 0;
+
+	if (virt_id >= NUM_VIRTIDS)
+		return -EINVAL;
+
+	mutex_lock(&ti_pvu_lock);
+
+	list_for_each_entry(pvu, &ti_pvu_list, entry) {
+		err = pvu_create_region(pvu, region->start,
+					region->end + 1 - region->start);
+		if (err)
+			break;
+	}
+
+	mutex_unlock(&ti_pvu_lock);
+
+	return err;
+}
+
+int ti_pvu_remove_region(unsigned int virt_id, const struct resource *region)
+{
+	struct ti_pvu *pvu;
+
+	if (virt_id >= NUM_VIRTIDS)
+		return -EINVAL;
+
+	mutex_lock(&ti_pvu_lock);
+
+	list_for_each_entry(pvu, &ti_pvu_list, entry) {
+		pvu_remove_region(pvu, region->start,
+				  region->end + 1 - region->start);
+	}
+
+	mutex_unlock(&ti_pvu_lock);
+
+	return 0;
+}
+
+static int ti_pvu_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *its_node;
+	void __iomem *base;
+	struct ti_pvu *pvu;
+	u32 val;
+	int ret;
+
+	pvu = devm_kzalloc(dev, sizeof(*pvu), GFP_KERNEL);
+	if (!pvu)
+		return -ENOMEM;
+
+	pvu->pdev = pdev;
+
+	base = devm_platform_ioremap_resource_byname(pdev, "cfg");
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	pvu->cfg = devm_regmap_init_mmio(dev, base, &pvu_cfg_regmap_cfg);
+	if (IS_ERR(pvu->cfg))
+		return dev_err_probe(dev, PTR_ERR(pvu->cfg), "failed to init cfg regmap");
+
+	ret = devm_regmap_field_bulk_alloc(dev, pvu->cfg, pvu->cfg_fields,
+					   pvu_cfg_reg_fields, PVU_MAX_CFG_FIELDS);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to alloc cfg regmap fields");
+
+	pvu->num_tlbs = pvu_field_read(pvu, PVU_TLBS);
+	pvu->num_entries = pvu_field_read(pvu, PVU_TLB_ENTRIES);
+	dev_info(dev, "TLBs: %d, entries per TLB: %d\n", pvu->num_tlbs,
+		 pvu->num_entries);
+
+	pvu->tlbif_base = devm_platform_ioremap_resource_byname(pdev, "tlbif");
+	if (IS_ERR(pvu->tlbif_base))
+		return PTR_ERR(pvu->tlbif_base);
+
+	its_node = of_find_compatible_node(0, 0, "arm,gic-v3-its");
+	if (its_node) {
+		u32 pre_its_window[2];
+
+		ret = of_property_read_u32_array(its_node,
+						 "socionext,synquacer-pre-its",
+						 pre_its_window,
+						 ARRAY_SIZE(pre_its_window));
+		if (ret) {
+			dev_err(dev, "failed to read pre-its property\n");
+			return ret;
+		}
+
+		ret = pvu_create_region(pvu, pre_its_window[0],
+					pre_its_window[1]);
+		if (ret)
+			return ret;
+	}
+
+	/* Enable the first two TLBs, chaining from 0 to 1 */
+	val = readl(pvu->tlbif_base + PVU_CHAIN);
+	val |= PVU_CHAIN_EN | 1;
+	writel(val, pvu->tlbif_base + PVU_CHAIN);
+
+	val = readl(pvu->tlbif_base + PVU_CHAIN + 0x1000);
+	val |= PVU_CHAIN_EN;
+	writel(val, pvu->tlbif_base + PVU_CHAIN + 0x1000);
+
+	pvu_field_write(pvu, PVU_DMA_CNT, 0);
+	pvu_field_write(pvu, PVU_DMA_CL0, 0);
+	pvu_field_write(pvu, PVU_DMA_CL1, 0);
+	pvu_field_write(pvu, PVU_DMA_CL2, 0);
+	pvu_field_write(pvu, PVU_DMA_CL3, 0);
+	pvu_field_write(pvu, PVU_MAX_VIRTID, NUM_VIRTIDS);
+
+	ret = platform_get_irq(pdev, 0);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "failed to get irq\n");
+
+	ret = devm_request_irq(dev, ret, pvu_fault_isr, 0, dev_name(dev), pvu);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to request irq\n");
+
+	pvu_field_write(pvu, PVU_EXC_ENABLE, 1);
+	pvu_field_write(pvu, PVU_ENABLED, 1);
+
+	dev_set_drvdata(dev, pvu);
+
+	mutex_lock(&ti_pvu_lock);
+	list_add(&pvu->entry, &ti_pvu_list);
+	mutex_unlock(&ti_pvu_lock);
+
+	return 0;
+}
+
+static void ti_pvu_remove(struct platform_device *pdev)
+{
+	struct ti_pvu *pvu = dev_get_drvdata(&pdev->dev);
+
+	mutex_lock(&ti_pvu_lock);
+	list_del(&pvu->entry);
+	mutex_unlock(&ti_pvu_lock);
+}
+
+static const struct of_device_id ti_pvu_of_match[] = {
+	{ .compatible = "ti,am654-pvu", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, ti_pvu_of_match);
+
+static struct platform_driver ti_pvu_driver = {
+	.driver = {
+		.name = "ti-pvu",
+		.of_match_table = ti_pvu_of_match,
+	},
+	.probe = ti_pvu_probe,
+	.remove = ti_pvu_remove,
+};
+module_platform_driver(ti_pvu_driver);
diff --git a/include/linux/ti-pvu.h b/include/linux/ti-pvu.h
new file mode 100644
index 000000000000..7088da8dad9a
--- /dev/null
+++ b/include/linux/ti-pvu.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * TI Peripheral Virtualization Unit driver for static DMA isolation
+ *
+ * Copyright (c) 2024, Siemens AG
+ */
+
+#ifndef _LINUX_TI_PVU_H
+#define _LINUX_TI_PVU_H
+
+#include <linux/ioport.h>
+
+#if IS_ENABLED(CONFIG_TI_PVU)
+int ti_pvu_create_region(unsigned int virt_id,
+	const struct resource *region);
+int ti_pvu_remove_region(unsigned int virt_id,
+	const struct resource *region);
+#else
+static inline int ti_pvu_create_region(unsigned int virt_id,
+	const struct resource *region)
+{
+	return 0;
+}
+
+static inline int ti_pvu_remove_region(unsigned int virt_id,
+	const struct resource *region)
+{
+	return 0;
+}
+#endif
+
+#endif /* _LINUX_TI_PVU_H */
-- 
2.34.1


