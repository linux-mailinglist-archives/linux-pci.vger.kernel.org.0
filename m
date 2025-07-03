Return-Path: <linux-pci+bounces-31372-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D78AF7043
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 12:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAFCF1C813BF
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 10:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1672E9757;
	Thu,  3 Jul 2025 10:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rZvtfPl/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48D52E3372;
	Thu,  3 Jul 2025 10:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751538430; cv=none; b=lQfOMVvTjHpRMeRLOzjuNrPCoeXx4OzfFQB3B9l8CzUQzuorK70DiAJkxJ+iKWqvJ8OjbZKV2tWfWy7FZRsIDIhfOmYc5IeCB+2bribwZ1LrX3uPGIBjGXwUSGWnCjJVlsFCoY7rwB4rk1+75EnEvv26MJFw0vCnkWDUUyx3miU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751538430; c=relaxed/simple;
	bh=vm0Dl1hyjJ3h2Mc9RhWqahNVc3sEEdjpQzCpGzJ+s4k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mGQlD2HBlW5wKAvI2CC90DDhQm5tLTgK4IslDtOQL8rwuXVDvVKe6uGFq49OSWrIZvMWMZe/tS401Dkj4pMj0iyGzplSnJG2SseK2WiYjIOz9a9yT0ahGzP0hlY06J3p4VU560+sVt70XpzbX3QJ1+0FAP/dFhUa9PYKZDy6b+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rZvtfPl/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8FCEC4CEED;
	Thu,  3 Jul 2025 10:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751538430;
	bh=vm0Dl1hyjJ3h2Mc9RhWqahNVc3sEEdjpQzCpGzJ+s4k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rZvtfPl/ykUkpy32AyULyifj998toOjgTPaTADBluNG3dZGW7bgo/e/0SEwrnFdQQ
	 g/fRMh6yYXZXgjpDgGgF5BiRmzONMPD0FgvGkijrVPfZ0XHWb3tcdX17l550QZ0sSz
	 pt2F65T7MsiQrkbhFXIjfOp8zeEoCHitswaD4YRmQUOjDTLwlBgTIU2lw5fvvtxAwv
	 tOxtMVic4DM1GKys8SS/DqptEhz52Y3dXAUhJt/BqCJz0WZXx3Q7rmx+6WZ5f9vaKw
	 aUXzMqIrYGr9mjzCpzbjcFzm79e6+59oPKyq6pwbJ54vvJOsSKMT1gLooH/dQPO9fQ
	 xUU5ywcL/6ZMA==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
Date: Thu, 03 Jul 2025 12:25:11 +0200
Subject: [PATCH v7 21/31] irqchip/gic-v5: Add GICv5 IRS/SPI support
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250703-gicv5-host-v7-21-12e71f1b3528@kernel.org>
References: <20250703-gicv5-host-v7-0-12e71f1b3528@kernel.org>
In-Reply-To: <20250703-gicv5-host-v7-0-12e71f1b3528@kernel.org>
To: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, 
 Sascha Bischoff <sascha.bischoff@arm.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Timothy Hayes <timothy.hayes@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Mark Rutland <mark.rutland@arm.com>, Jiri Slaby <jirislaby@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-pci@vger.kernel.org, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>
X-Mailer: b4 0.15-dev-6f78e

The GICv5 Interrupt Routing Service (IRS) component implements
interrupt management and routing in the GICv5 architecture.

A GICv5 system comprises one or more IRSes, that together
handle the interrupt routing and state for the system.

An IRS supports Shared Peripheral Interrupts (SPIs), that are
interrupt sources directly connected to the IRS; they do not
rely on memory for storage. The number of supported SPIs is
fixed for a given implementation and can be probed through IRS
IDR registers.

SPI interrupt state and routing are managed through GICv5
instructions.

Each core (PE in GICv5 terms) in a GICv5 system is identified with
an Interrupt AFFinity ID (IAFFID).

An IRS manages a set of cores that are connected to it.

Firmware provides a topology description that the driver uses
to detect to which IRS a CPU (ie an IAFFID) is associated with.

Use probeable information and firmware description to initialize
the IRSes and implement GICv5 IRS SPIs support through an
SPI-specific IRQ domain.

The GICv5 IRS driver:

- Probes IRSes in the system to detect SPI ranges
- Associates an IRS with a set of cores connected to it
- Adds an IRQchip structure for SPI handling

SPIs priority is set to a value corresponding to the lowest
permissible priority in the system (taking into account the
implemented priority bits of the IRS and CPU interface).

Since all IRQs are set to the same priority value, the value
itself does not matter as long as it is a valid one.

Co-developed-by: Sascha Bischoff <sascha.bischoff@arm.com>
Signed-off-by: Sascha Bischoff <sascha.bischoff@arm.com>
Co-developed-by: Timothy Hayes <timothy.hayes@arm.com>
Signed-off-by: Timothy Hayes <timothy.hayes@arm.com>
Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/include/asm/sysreg.h    |  36 +++
 drivers/irqchip/Makefile           |   2 +-
 drivers/irqchip/irq-gic-v5-irs.c   | 434 +++++++++++++++++++++++++++++++++++++
 drivers/irqchip/irq-gic-v5.c       | 347 +++++++++++++++++++++++++++--
 include/linux/irqchip/arm-gic-v5.h | 140 ++++++++++++
 5 files changed, 937 insertions(+), 22 deletions(-)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 36b82d74db37..efd2e7a1fbe2 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -1085,14 +1085,50 @@
 /*
  * Definitions for GICv5 instructions
  */
+#define GICV5_OP_GIC_CDAFF		sys_insn(1, 0, 12, 1, 3)
 #define GICV5_OP_GIC_CDDI		sys_insn(1, 0, 12, 2, 0)
+#define GICV5_OP_GIC_CDDIS		sys_insn(1, 0, 12, 1, 0)
+#define GICV5_OP_GIC_CDEN		sys_insn(1, 0, 12, 1, 1)
 #define GICV5_OP_GIC_CDEOI		sys_insn(1, 0, 12, 1, 7)
+#define GICV5_OP_GIC_CDPEND		sys_insn(1, 0, 12, 1, 4)
+#define GICV5_OP_GIC_CDPRI		sys_insn(1, 0, 12, 1, 2)
+#define GICV5_OP_GIC_CDRCFG		sys_insn(1, 0, 12, 1, 5)
 #define GICV5_OP_GICR_CDIA		sys_insn(1, 0, 12, 3, 0)
 
+/* Definitions for GIC CDAFF */
+#define GICV5_GIC_CDAFF_IAFFID_MASK	GENMASK_ULL(47, 32)
+#define GICV5_GIC_CDAFF_TYPE_MASK	GENMASK_ULL(31, 29)
+#define GICV5_GIC_CDAFF_IRM_MASK	BIT_ULL(28)
+#define GICV5_GIC_CDAFF_ID_MASK		GENMASK_ULL(23, 0)
+
 /* Definitions for GIC CDDI */
 #define GICV5_GIC_CDDI_TYPE_MASK	GENMASK_ULL(31, 29)
 #define GICV5_GIC_CDDI_ID_MASK		GENMASK_ULL(23, 0)
 
+/* Definitions for GIC CDDIS */
+#define GICV5_GIC_CDDIS_TYPE_MASK	GENMASK_ULL(31, 29)
+#define GICV5_GIC_CDDIS_TYPE(r)		FIELD_GET(GICV5_GIC_CDDIS_TYPE_MASK, r)
+#define GICV5_GIC_CDDIS_ID_MASK		GENMASK_ULL(23, 0)
+#define GICV5_GIC_CDDIS_ID(r)		FIELD_GET(GICV5_GIC_CDDIS_ID_MASK, r)
+
+/* Definitions for GIC CDEN */
+#define GICV5_GIC_CDEN_TYPE_MASK	GENMASK_ULL(31, 29)
+#define GICV5_GIC_CDEN_ID_MASK		GENMASK_ULL(23, 0)
+
+/* Definitions for GIC CDPEND */
+#define GICV5_GIC_CDPEND_PENDING_MASK	BIT_ULL(32)
+#define GICV5_GIC_CDPEND_TYPE_MASK	GENMASK_ULL(31, 29)
+#define GICV5_GIC_CDPEND_ID_MASK	GENMASK_ULL(23, 0)
+
+/* Definitions for GIC CDPRI */
+#define GICV5_GIC_CDPRI_PRIORITY_MASK	GENMASK_ULL(39, 35)
+#define GICV5_GIC_CDPRI_TYPE_MASK	GENMASK_ULL(31, 29)
+#define GICV5_GIC_CDPRI_ID_MASK		GENMASK_ULL(23, 0)
+
+/* Definitions for GIC CDRCFG */
+#define GICV5_GIC_CDRCFG_TYPE_MASK	GENMASK_ULL(31, 29)
+#define GICV5_GIC_CDRCFG_ID_MASK	GENMASK_ULL(23, 0)
+
 /* Definitions for GICR CDIA */
 #define GICV5_GIC_CDIA_VALID_MASK	BIT_ULL(32)
 #define GICV5_GICR_CDIA_VALID(r)	FIELD_GET(GICV5_GIC_CDIA_VALID_MASK, r)
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 3d75659d99eb..7a0e6cee09e1 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -36,7 +36,7 @@ obj-$(CONFIG_ARM_GIC_V3)		+= irq-gic-v3.o irq-gic-v3-mbi.o irq-gic-common.o
 obj-$(CONFIG_ARM_GIC_V3_ITS)		+= irq-gic-v3-its.o irq-gic-v4.o irq-gic-v3-its-msi-parent.o
 obj-$(CONFIG_ARM_GIC_V3_ITS_FSL_MC)	+= irq-gic-v3-its-fsl-mc-msi.o
 obj-$(CONFIG_PARTITION_PERCPU)		+= irq-partition-percpu.o
-obj-$(CONFIG_ARM_GIC_V5)		+= irq-gic-v5.o
+obj-$(CONFIG_ARM_GIC_V5)		+= irq-gic-v5.o irq-gic-v5-irs.o
 obj-$(CONFIG_HISILICON_IRQ_MBIGEN)	+= irq-mbigen.o
 obj-$(CONFIG_ARM_NVIC)			+= irq-nvic.o
 obj-$(CONFIG_ARM_VIC)			+= irq-vic.o
diff --git a/drivers/irqchip/irq-gic-v5-irs.c b/drivers/irqchip/irq-gic-v5-irs.c
new file mode 100644
index 000000000000..fba8efceb26e
--- /dev/null
+++ b/drivers/irqchip/irq-gic-v5-irs.c
@@ -0,0 +1,434 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2024-2025 ARM Limited, All Rights Reserved.
+ */
+
+#define pr_fmt(fmt)	"GICv5 IRS: " fmt
+
+#include <linux/of.h>
+#include <linux/of_address.h>
+
+#include <linux/irqchip.h>
+#include <linux/irqchip/arm-gic-v5.h>
+
+#define IRS_FLAGS_NON_COHERENT		BIT(0)
+
+static DEFINE_PER_CPU_READ_MOSTLY(struct gicv5_irs_chip_data *, per_cpu_irs_data);
+static LIST_HEAD(irs_nodes);
+
+static u32 irs_readl_relaxed(struct gicv5_irs_chip_data *irs_data,
+			     const u32 reg_offset)
+{
+	return readl_relaxed(irs_data->irs_base + reg_offset);
+}
+
+static void irs_writel_relaxed(struct gicv5_irs_chip_data *irs_data,
+			       const u32 val, const u32 reg_offset)
+{
+	writel_relaxed(val, irs_data->irs_base + reg_offset);
+}
+
+struct iaffid_entry {
+	u16	iaffid;
+	bool	valid;
+};
+
+static DEFINE_PER_CPU(struct iaffid_entry, cpu_iaffid);
+
+int gicv5_irs_cpu_to_iaffid(int cpuid, u16 *iaffid)
+{
+	if (!per_cpu(cpu_iaffid, cpuid).valid) {
+		pr_err("IAFFID for CPU %d has not been initialised\n", cpuid);
+		return -ENODEV;
+	}
+
+	*iaffid = per_cpu(cpu_iaffid, cpuid).iaffid;
+
+	return 0;
+}
+
+struct gicv5_irs_chip_data *gicv5_irs_lookup_by_spi_id(u32 spi_id)
+{
+	struct gicv5_irs_chip_data *irs_data;
+	u32 min, max;
+
+	list_for_each_entry(irs_data, &irs_nodes, entry) {
+		if (!irs_data->spi_range)
+			continue;
+
+		min = irs_data->spi_min;
+		max = irs_data->spi_min + irs_data->spi_range - 1;
+		if (spi_id >= min && spi_id <= max)
+			return irs_data;
+	}
+
+	return NULL;
+}
+
+static int gicv5_irs_wait_for_spi_op(struct gicv5_irs_chip_data *irs_data)
+{
+	u32 statusr;
+	int ret;
+
+	ret = gicv5_wait_for_op_atomic(irs_data->irs_base, GICV5_IRS_SPI_STATUSR,
+				       GICV5_IRS_SPI_STATUSR_IDLE, &statusr);
+	if (ret)
+		return ret;
+
+	return !!FIELD_GET(GICV5_IRS_SPI_STATUSR_V, statusr) ? 0 : -EIO;
+}
+
+static int gicv5_irs_wait_for_irs_pe(struct gicv5_irs_chip_data *irs_data,
+				     bool selr)
+{
+	bool valid = true;
+	u32 statusr;
+	int ret;
+
+	ret = gicv5_wait_for_op_atomic(irs_data->irs_base, GICV5_IRS_PE_STATUSR,
+				       GICV5_IRS_PE_STATUSR_IDLE, &statusr);
+	if (ret)
+		return ret;
+
+	if (selr)
+		valid = !!FIELD_GET(GICV5_IRS_PE_STATUSR_V, statusr);
+
+	return valid ? 0 : -EIO;
+}
+
+static int gicv5_irs_wait_for_pe_selr(struct gicv5_irs_chip_data *irs_data)
+{
+	return gicv5_irs_wait_for_irs_pe(irs_data, true);
+}
+
+static int gicv5_irs_wait_for_pe_cr0(struct gicv5_irs_chip_data *irs_data)
+{
+	return gicv5_irs_wait_for_irs_pe(irs_data, false);
+}
+
+int gicv5_spi_irq_set_type(struct irq_data *d, unsigned int type)
+{
+	struct gicv5_irs_chip_data *irs_data = d->chip_data;
+	u32 selr, cfgr;
+	bool level;
+	int ret;
+
+	/*
+	 * There is no distinction between HIGH/LOW for level IRQs
+	 * and RISING/FALLING for edge IRQs in the architecture,
+	 * hence consider them equivalent.
+	 */
+	switch (type) {
+	case IRQ_TYPE_EDGE_RISING:
+	case IRQ_TYPE_EDGE_FALLING:
+		level = false;
+		break;
+	case IRQ_TYPE_LEVEL_HIGH:
+	case IRQ_TYPE_LEVEL_LOW:
+		level = true;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	guard(raw_spinlock)(&irs_data->spi_config_lock);
+
+	selr = FIELD_PREP(GICV5_IRS_SPI_SELR_ID, d->hwirq);
+	irs_writel_relaxed(irs_data, selr, GICV5_IRS_SPI_SELR);
+	ret = gicv5_irs_wait_for_spi_op(irs_data);
+	if (ret)
+		return ret;
+
+	cfgr = FIELD_PREP(GICV5_IRS_SPI_CFGR_TM, level);
+	irs_writel_relaxed(irs_data, cfgr, GICV5_IRS_SPI_CFGR);
+
+	return gicv5_irs_wait_for_spi_op(irs_data);
+}
+
+static int gicv5_irs_wait_for_idle(struct gicv5_irs_chip_data *irs_data)
+{
+	return gicv5_wait_for_op_atomic(irs_data->irs_base, GICV5_IRS_CR0,
+					GICV5_IRS_CR0_IDLE, NULL);
+}
+
+int gicv5_irs_register_cpu(int cpuid)
+{
+	struct gicv5_irs_chip_data *irs_data;
+	u32 selr, cr0;
+	u16 iaffid;
+	int ret;
+
+	ret = gicv5_irs_cpu_to_iaffid(cpuid, &iaffid);
+	if (ret) {
+		pr_err("IAFFID for CPU %d has not been initialised\n", cpuid);
+		return ret;
+	}
+
+	irs_data = per_cpu(per_cpu_irs_data, cpuid);
+	if (!irs_data) {
+		pr_err("No IRS associated with CPU %u\n", cpuid);
+		return -ENXIO;
+	}
+
+	selr = FIELD_PREP(GICV5_IRS_PE_SELR_IAFFID, iaffid);
+	irs_writel_relaxed(irs_data, selr, GICV5_IRS_PE_SELR);
+
+	ret = gicv5_irs_wait_for_pe_selr(irs_data);
+	if (ret) {
+		pr_err("IAFFID 0x%x used in IRS_PE_SELR is invalid\n", iaffid);
+		return -ENXIO;
+	}
+
+	cr0 = FIELD_PREP(GICV5_IRS_PE_CR0_DPS, 0x1);
+	irs_writel_relaxed(irs_data, cr0, GICV5_IRS_PE_CR0);
+
+	ret = gicv5_irs_wait_for_pe_cr0(irs_data);
+	if (ret)
+		return ret;
+
+	pr_debug("CPU %d enabled PE IAFFID 0x%x\n", cpuid, iaffid);
+
+	return 0;
+}
+
+static void __init gicv5_irs_init_bases(struct gicv5_irs_chip_data *irs_data,
+					void __iomem *irs_base,
+					struct fwnode_handle *handle)
+{
+	struct device_node *np = to_of_node(handle);
+	u32 cr0, cr1;
+
+	irs_data->fwnode = handle;
+	irs_data->irs_base = irs_base;
+
+	if (of_property_read_bool(np, "dma-noncoherent")) {
+		/*
+		 * A non-coherent IRS implies that some cache levels cannot be
+		 * used coherently by the cores and GIC. Our only option is to mark
+		 * memory attributes for the GIC as non-cacheable; by default,
+		 * non-cacheable memory attributes imply outer-shareable
+		 * shareability, the value written into IRS_CR1_SH is ignored.
+		 */
+		cr1 = FIELD_PREP(GICV5_IRS_CR1_VPED_WA, GICV5_NO_WRITE_ALLOC)	|
+			FIELD_PREP(GICV5_IRS_CR1_VPED_RA, GICV5_NO_READ_ALLOC)	|
+			FIELD_PREP(GICV5_IRS_CR1_VMD_WA, GICV5_NO_WRITE_ALLOC)	|
+			FIELD_PREP(GICV5_IRS_CR1_VMD_RA, GICV5_NO_READ_ALLOC)	|
+			FIELD_PREP(GICV5_IRS_CR1_VPET_RA, GICV5_NO_READ_ALLOC)	|
+			FIELD_PREP(GICV5_IRS_CR1_VMT_RA, GICV5_NO_READ_ALLOC)	|
+			FIELD_PREP(GICV5_IRS_CR1_IST_WA, GICV5_NO_WRITE_ALLOC)	|
+			FIELD_PREP(GICV5_IRS_CR1_IST_RA, GICV5_NO_READ_ALLOC)	|
+			FIELD_PREP(GICV5_IRS_CR1_IC, GICV5_NON_CACHE)		|
+			FIELD_PREP(GICV5_IRS_CR1_OC, GICV5_NON_CACHE);
+			irs_data->flags |= IRS_FLAGS_NON_COHERENT;
+	} else {
+		cr1 = FIELD_PREP(GICV5_IRS_CR1_VPED_WA, GICV5_WRITE_ALLOC)	|
+			FIELD_PREP(GICV5_IRS_CR1_VPED_RA, GICV5_READ_ALLOC)	|
+			FIELD_PREP(GICV5_IRS_CR1_VMD_WA, GICV5_WRITE_ALLOC)	|
+			FIELD_PREP(GICV5_IRS_CR1_VMD_RA, GICV5_READ_ALLOC)	|
+			FIELD_PREP(GICV5_IRS_CR1_VPET_RA, GICV5_READ_ALLOC)	|
+			FIELD_PREP(GICV5_IRS_CR1_VMT_RA, GICV5_READ_ALLOC)	|
+			FIELD_PREP(GICV5_IRS_CR1_IST_WA, GICV5_WRITE_ALLOC)	|
+			FIELD_PREP(GICV5_IRS_CR1_IST_RA, GICV5_READ_ALLOC)	|
+			FIELD_PREP(GICV5_IRS_CR1_IC, GICV5_WB_CACHE)		|
+			FIELD_PREP(GICV5_IRS_CR1_OC, GICV5_WB_CACHE)		|
+			FIELD_PREP(GICV5_IRS_CR1_SH, GICV5_INNER_SHARE);
+	}
+
+	irs_writel_relaxed(irs_data, cr1, GICV5_IRS_CR1);
+
+	cr0 = FIELD_PREP(GICV5_IRS_CR0_IRSEN, 0x1);
+	irs_writel_relaxed(irs_data, cr0, GICV5_IRS_CR0);
+	gicv5_irs_wait_for_idle(irs_data);
+}
+
+static int __init gicv5_irs_of_init_affinity(struct device_node *node,
+					     struct gicv5_irs_chip_data *irs_data,
+					     u8 iaffid_bits)
+{
+	/*
+	 * Detect IAFFID<->CPU mappings from the device tree and
+	 * record IRS<->CPU topology information.
+	 */
+	u16 iaffid_mask = GENMASK(iaffid_bits - 1, 0);
+	int ret, i, ncpus, niaffids;
+
+	ncpus = of_count_phandle_with_args(node, "cpus", NULL);
+	if (ncpus < 0)
+		return -EINVAL;
+
+	niaffids = of_property_count_elems_of_size(node, "arm,iaffids",
+						   sizeof(u16));
+	if (niaffids != ncpus)
+		return -EINVAL;
+
+	u16 *iaffids __free(kfree) = kcalloc(niaffids, sizeof(*iaffids), GFP_KERNEL);
+	if (!iaffids)
+		return -ENOMEM;
+
+	ret = of_property_read_u16_array(node, "arm,iaffids", iaffids, niaffids);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < ncpus; i++) {
+		struct device_node *cpu_node;
+		int cpu;
+
+		cpu_node = of_parse_phandle(node, "cpus", i);
+		if (WARN_ON(!cpu_node))
+			continue;
+
+		cpu = of_cpu_node_to_id(cpu_node);
+		of_node_put(cpu_node);
+		if (WARN_ON(cpu < 0))
+			continue;
+
+		if (iaffids[i] & ~iaffid_mask) {
+			pr_warn("CPU %d iaffid 0x%x exceeds IRS iaffid bits\n",
+				cpu, iaffids[i]);
+			continue;
+		}
+
+		per_cpu(cpu_iaffid, cpu).iaffid = iaffids[i];
+		per_cpu(cpu_iaffid, cpu).valid = true;
+
+		/* We also know that the CPU is connected to this IRS */
+		per_cpu(per_cpu_irs_data, cpu) = irs_data;
+	}
+
+	return ret;
+}
+
+static void irs_setup_pri_bits(u32 idr1)
+{
+	switch (FIELD_GET(GICV5_IRS_IDR1_PRIORITY_BITS, idr1)) {
+	case GICV5_IRS_IDR1_PRIORITY_BITS_1BITS:
+		gicv5_global_data.irs_pri_bits = 1;
+		break;
+	case GICV5_IRS_IDR1_PRIORITY_BITS_2BITS:
+		gicv5_global_data.irs_pri_bits = 2;
+		break;
+	case GICV5_IRS_IDR1_PRIORITY_BITS_3BITS:
+		gicv5_global_data.irs_pri_bits = 3;
+		break;
+	case GICV5_IRS_IDR1_PRIORITY_BITS_4BITS:
+		gicv5_global_data.irs_pri_bits = 4;
+		break;
+	case GICV5_IRS_IDR1_PRIORITY_BITS_5BITS:
+		gicv5_global_data.irs_pri_bits = 5;
+		break;
+	default:
+		pr_warn("Detected wrong IDR priority bits value 0x%lx\n",
+			FIELD_GET(GICV5_IRS_IDR1_PRIORITY_BITS, idr1));
+		gicv5_global_data.irs_pri_bits = 1;
+		break;
+	}
+}
+
+static int __init gicv5_irs_init(struct device_node *node)
+{
+	struct gicv5_irs_chip_data *irs_data;
+	void __iomem *irs_base;
+	u32 idr, spi_count;
+	u8 iaffid_bits;
+	int ret;
+
+	irs_data = kzalloc(sizeof(*irs_data), GFP_KERNEL);
+	if (!irs_data)
+		return -ENOMEM;
+
+	raw_spin_lock_init(&irs_data->spi_config_lock);
+
+	ret = of_property_match_string(node, "reg-names", "ns-config");
+	if (ret < 0) {
+		pr_err("%pOF: ns-config reg-name not present\n", node);
+		goto out_err;
+	}
+
+	irs_base = of_io_request_and_map(node, ret, of_node_full_name(node));
+	if (IS_ERR(irs_base)) {
+		pr_err("%pOF: unable to map GICv5 IRS registers\n", node);
+		ret = PTR_ERR(irs_base);
+		goto out_err;
+	}
+
+	gicv5_irs_init_bases(irs_data, irs_base, &node->fwnode);
+
+	idr = irs_readl_relaxed(irs_data, GICV5_IRS_IDR1);
+	iaffid_bits = FIELD_GET(GICV5_IRS_IDR1_IAFFID_BITS, idr) + 1;
+
+	ret = gicv5_irs_of_init_affinity(node, irs_data, iaffid_bits);
+	if (ret) {
+		pr_err("Failed to parse CPU IAFFIDs from the device tree!\n");
+		goto out_iomem;
+	}
+
+	idr = irs_readl_relaxed(irs_data, GICV5_IRS_IDR7);
+	irs_data->spi_min = FIELD_GET(GICV5_IRS_IDR7_SPI_BASE, idr);
+
+	idr = irs_readl_relaxed(irs_data, GICV5_IRS_IDR6);
+	irs_data->spi_range = FIELD_GET(GICV5_IRS_IDR6_SPI_IRS_RANGE, idr);
+
+	if (irs_data->spi_range) {
+		pr_info("%s detected SPI range [%u-%u]\n",
+						of_node_full_name(node),
+						irs_data->spi_min,
+						irs_data->spi_min +
+						irs_data->spi_range - 1);
+	}
+
+	/*
+	 * Do the global setting only on the first IRS.
+	 * Global properties (iaffid_bits, global spi count) are guaranteed to
+	 * be consistent across IRSes by the architecture.
+	 */
+	if (list_empty(&irs_nodes)) {
+
+		idr = irs_readl_relaxed(irs_data, GICV5_IRS_IDR1);
+		irs_setup_pri_bits(idr);
+
+		idr = irs_readl_relaxed(irs_data, GICV5_IRS_IDR5);
+
+		spi_count = FIELD_GET(GICV5_IRS_IDR5_SPI_RANGE, idr);
+		gicv5_global_data.global_spi_count = spi_count;
+
+		pr_debug("Detected %u SPIs globally\n", spi_count);
+	}
+
+	list_add_tail(&irs_data->entry, &irs_nodes);
+
+	return 0;
+
+out_iomem:
+	iounmap(irs_base);
+out_err:
+	kfree(irs_data);
+	return ret;
+}
+
+void __init gicv5_irs_remove(void)
+{
+	struct gicv5_irs_chip_data *irs_data, *tmp_data;
+
+	list_for_each_entry_safe(irs_data, tmp_data, &irs_nodes, entry) {
+		iounmap(irs_data->irs_base);
+		list_del(&irs_data->entry);
+		kfree(irs_data);
+	}
+}
+
+int __init gicv5_irs_of_probe(struct device_node *parent)
+{
+	struct device_node *np;
+	int ret;
+
+	for_each_available_child_of_node(parent, np) {
+		if (!of_device_is_compatible(np, "arm,gic-v5-irs"))
+			continue;
+
+		ret = gicv5_irs_init(np);
+		if (ret)
+			pr_err("Failed to init IRS %s\n", np->full_name);
+	}
+
+	return list_empty(&irs_nodes) ? -ENODEV : 0;
+}
diff --git a/drivers/irqchip/irq-gic-v5.c b/drivers/irqchip/irq-gic-v5.c
index 0bb940212e20..9c55ddcfa0df 100644
--- a/drivers/irqchip/irq-gic-v5.c
+++ b/drivers/irqchip/irq-gic-v5.c
@@ -26,12 +26,7 @@ static bool gicv5_cpuif_has_gcie(void)
 	return this_cpu_has_cap(ARM64_HAS_GICV5_CPUIF);
 }
 
-struct gicv5_chip_data {
-	struct fwnode_handle	*fwnode;
-	struct irq_domain	*ppi_domain;
-};
-
-static struct gicv5_chip_data gicv5_global_data __read_mostly;
+struct gicv5_chip_data gicv5_global_data __read_mostly;
 
 static void gicv5_ppi_priority_init(void)
 {
@@ -59,6 +54,30 @@ static void gicv5_ppi_priority_init(void)
 	isb();
 }
 
+static void gicv5_hwirq_init(irq_hw_number_t hwirq, u8 priority, u8 hwirq_type)
+{
+	u64 cdpri, cdaff;
+	u16 iaffid;
+	int ret;
+
+	if (hwirq_type == GICV5_HWIRQ_TYPE_SPI) {
+		cdpri = FIELD_PREP(GICV5_GIC_CDPRI_PRIORITY_MASK, priority)	|
+			FIELD_PREP(GICV5_GIC_CDPRI_TYPE_MASK, hwirq_type)	|
+			FIELD_PREP(GICV5_GIC_CDPRI_ID_MASK, hwirq);
+		gic_insn(cdpri, CDPRI);
+
+		ret = gicv5_irs_cpu_to_iaffid(smp_processor_id(), &iaffid);
+
+		if (WARN_ON_ONCE(ret))
+			return;
+
+		cdaff = FIELD_PREP(GICV5_GIC_CDAFF_IAFFID_MASK, iaffid)		|
+			FIELD_PREP(GICV5_GIC_CDAFF_TYPE_MASK, hwirq_type)	|
+			FIELD_PREP(GICV5_GIC_CDAFF_ID_MASK, hwirq);
+		gic_insn(cdaff, CDAFF);
+	}
+}
+
 static void gicv5_ppi_irq_mask(struct irq_data *d)
 {
 	u64 hwirq_id_bit = BIT_ULL(d->hwirq % 64);
@@ -77,6 +96,32 @@ static void gicv5_ppi_irq_mask(struct irq_data *d)
 	isb();
 }
 
+static void gicv5_iri_irq_mask(struct irq_data *d, u8 hwirq_type)
+{
+	u64 cddis;
+
+	cddis = FIELD_PREP(GICV5_GIC_CDDIS_ID_MASK, d->hwirq)	|
+		FIELD_PREP(GICV5_GIC_CDDIS_TYPE_MASK, hwirq_type);
+
+	gic_insn(cddis, CDDIS);
+	/*
+	 * We must make sure that GIC CDDIS write effects are propagated
+	 * immediately to make sure the disable takes effect to guarantee
+	 * that the lazy-disabled IRQ mechanism works.
+	 * Rule R_XCLJC states that the effects of a GIC system instruction
+	 * complete in finite time.
+	 * The GSB ensures completion of the GIC instruction and prevents
+	 * loads, stores and GIC instructions from executing part of their
+	 * functionality before the GSB SYS.
+	 */
+	gsb_sys();
+}
+
+static void gicv5_spi_irq_mask(struct irq_data *d)
+{
+	gicv5_iri_irq_mask(d, GICV5_HWIRQ_TYPE_SPI);
+}
+
 static void gicv5_ppi_irq_unmask(struct irq_data *d)
 {
 	u64 hwirq_id_bit = BIT_ULL(d->hwirq % 64);
@@ -95,6 +140,25 @@ static void gicv5_ppi_irq_unmask(struct irq_data *d)
 	isb();
 }
 
+static void gicv5_iri_irq_unmask(struct irq_data *d, u8 hwirq_type)
+{
+	u64 cden;
+
+	cden = FIELD_PREP(GICV5_GIC_CDEN_ID_MASK, d->hwirq)	|
+	       FIELD_PREP(GICV5_GIC_CDEN_TYPE_MASK, hwirq_type);
+	/*
+	 * Rule R_XCLJC states that the effects of a GIC system instruction
+	 * complete in finite time and that's the only requirement when
+	 * unmasking an SPI IRQ.
+	 */
+	gic_insn(cden, CDEN);
+}
+
+static void gicv5_spi_irq_unmask(struct irq_data *d)
+{
+	gicv5_iri_irq_unmask(d, GICV5_HWIRQ_TYPE_SPI);
+}
+
 static void gicv5_hwirq_eoi(u32 hwirq_id, u8 hwirq_type)
 {
 	u64 cddi;
@@ -112,6 +176,46 @@ static void gicv5_ppi_irq_eoi(struct irq_data *d)
 	gicv5_hwirq_eoi(d->hwirq, GICV5_HWIRQ_TYPE_PPI);
 }
 
+static void gicv5_spi_irq_eoi(struct irq_data *d)
+{
+	gicv5_hwirq_eoi(d->hwirq, GICV5_HWIRQ_TYPE_SPI);
+}
+
+static int gicv5_iri_irq_set_affinity(struct irq_data *d,
+				      const struct cpumask *mask_val,
+				      bool force, u8 hwirq_type)
+{
+	int ret, cpuid;
+	u16 iaffid;
+	u64 cdaff;
+
+	if (force)
+		cpuid = cpumask_first(mask_val);
+	else
+		cpuid = cpumask_any_and(mask_val, cpu_online_mask);
+
+	ret = gicv5_irs_cpu_to_iaffid(cpuid, &iaffid);
+	if (ret)
+		return ret;
+
+	cdaff = FIELD_PREP(GICV5_GIC_CDAFF_IAFFID_MASK, iaffid)		|
+		FIELD_PREP(GICV5_GIC_CDAFF_TYPE_MASK, hwirq_type)	|
+		FIELD_PREP(GICV5_GIC_CDAFF_ID_MASK, d->hwirq);
+	gic_insn(cdaff, CDAFF);
+
+	irq_data_update_effective_affinity(d, cpumask_of(cpuid));
+
+	return IRQ_SET_MASK_OK_DONE;
+}
+
+static int gicv5_spi_irq_set_affinity(struct irq_data *d,
+				      const struct cpumask *mask_val,
+				      bool force)
+{
+	return gicv5_iri_irq_set_affinity(d, mask_val, force,
+					  GICV5_HWIRQ_TYPE_SPI);
+}
+
 enum ppi_reg {
 	PPI_PENDING,
 	PPI_ACTIVE,
@@ -192,6 +296,46 @@ static int gicv5_ppi_irq_get_irqchip_state(struct irq_data *d,
 	}
 }
 
+static int gicv5_iri_irq_get_irqchip_state(struct irq_data *d,
+					   enum irqchip_irq_state which,
+					   bool *state, u8 hwirq_type)
+{
+	u64 icsr, cdrcfg;
+
+	cdrcfg = d->hwirq | FIELD_PREP(GICV5_GIC_CDRCFG_TYPE_MASK, hwirq_type);
+
+	gic_insn(cdrcfg, CDRCFG);
+	isb();
+	icsr = read_sysreg_s(SYS_ICC_ICSR_EL1);
+
+	if (FIELD_GET(ICC_ICSR_EL1_F, icsr)) {
+		pr_err("ICSR_EL1 is invalid\n");
+		return -EINVAL;
+	}
+
+	switch (which) {
+	case IRQCHIP_STATE_PENDING:
+		*state = !!(FIELD_GET(ICC_ICSR_EL1_Pending, icsr));
+		return 0;
+
+	case IRQCHIP_STATE_ACTIVE:
+		*state = !!(FIELD_GET(ICC_ICSR_EL1_Active, icsr));
+		return 0;
+
+	default:
+		pr_debug("Unexpected irqchip_irq_state\n");
+		return -EINVAL;
+	}
+}
+
+static int gicv5_spi_irq_get_irqchip_state(struct irq_data *d,
+					   enum irqchip_irq_state which,
+					   bool *state)
+{
+	return gicv5_iri_irq_get_irqchip_state(d, which, state,
+					       GICV5_HWIRQ_TYPE_SPI);
+}
+
 static int gicv5_ppi_irq_set_irqchip_state(struct irq_data *d,
 					   enum irqchip_irq_state which,
 					   bool state)
@@ -209,6 +353,45 @@ static int gicv5_ppi_irq_set_irqchip_state(struct irq_data *d,
 	}
 }
 
+static void gicv5_iri_irq_write_pending_state(struct irq_data *d, bool state,
+					      u8 hwirq_type)
+{
+	u64 cdpend;
+
+	cdpend = FIELD_PREP(GICV5_GIC_CDPEND_TYPE_MASK, hwirq_type)	|
+		 FIELD_PREP(GICV5_GIC_CDPEND_ID_MASK, d->hwirq)		|
+		 FIELD_PREP(GICV5_GIC_CDPEND_PENDING_MASK, state);
+
+	gic_insn(cdpend, CDPEND);
+}
+
+static void gicv5_spi_irq_write_pending_state(struct irq_data *d, bool state)
+{
+	gicv5_iri_irq_write_pending_state(d, state, GICV5_HWIRQ_TYPE_SPI);
+}
+
+static int gicv5_spi_irq_set_irqchip_state(struct irq_data *d,
+					   enum irqchip_irq_state which,
+					   bool state)
+{
+	switch (which) {
+	case IRQCHIP_STATE_PENDING:
+		gicv5_spi_irq_write_pending_state(d, state);
+		break;
+	default:
+		pr_debug("Unexpected irqchip_irq_state\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int gicv5_spi_irq_retrigger(struct irq_data *data)
+{
+	return !gicv5_spi_irq_set_irqchip_state(data, IRQCHIP_STATE_PENDING,
+						true);
+}
+
 static bool gicv5_ppi_irq_is_level(irq_hw_number_t hwirq)
 {
 	u64 bit = BIT_ULL(hwirq % 64);
@@ -227,10 +410,26 @@ static const struct irq_chip gicv5_ppi_irq_chip = {
 				  IRQCHIP_MASK_ON_SUSPEND,
 };
 
-static int gicv5_irq_ppi_domain_translate(struct irq_domain *d,
-					  struct irq_fwspec *fwspec,
-					  irq_hw_number_t *hwirq,
-					  unsigned int *type)
+static const struct irq_chip gicv5_spi_irq_chip = {
+	.name			= "GICv5-SPI",
+	.irq_mask		= gicv5_spi_irq_mask,
+	.irq_unmask		= gicv5_spi_irq_unmask,
+	.irq_eoi		= gicv5_spi_irq_eoi,
+	.irq_set_type		= gicv5_spi_irq_set_type,
+	.irq_set_affinity	= gicv5_spi_irq_set_affinity,
+	.irq_retrigger		= gicv5_spi_irq_retrigger,
+	.irq_get_irqchip_state	= gicv5_spi_irq_get_irqchip_state,
+	.irq_set_irqchip_state	= gicv5_spi_irq_set_irqchip_state,
+	.flags			= IRQCHIP_SET_TYPE_MASKED |
+				  IRQCHIP_SKIP_SET_WAKE	  |
+				  IRQCHIP_MASK_ON_SUSPEND,
+};
+
+static __always_inline int gicv5_irq_domain_translate(struct irq_domain *d,
+						      struct irq_fwspec *fwspec,
+						      irq_hw_number_t *hwirq,
+						      unsigned int *type,
+						      const u8 hwirq_type)
 {
 	if (!is_of_node(fwspec->fwnode))
 		return -EINVAL;
@@ -238,20 +437,39 @@ static int gicv5_irq_ppi_domain_translate(struct irq_domain *d,
 	if (fwspec->param_count < 3)
 		return -EINVAL;
 
-	if (fwspec->param[0] != GICV5_HWIRQ_TYPE_PPI)
+	if (fwspec->param[0] != hwirq_type)
 		return -EINVAL;
 
 	*hwirq = fwspec->param[1];
 
-	/*
-	 * Handling mode is hardcoded for PPIs, set the type using
-	 * HW reported value.
-	 */
-	*type = gicv5_ppi_irq_is_level(*hwirq) ? IRQ_TYPE_LEVEL_LOW : IRQ_TYPE_EDGE_RISING;
+	switch (hwirq_type) {
+	case GICV5_HWIRQ_TYPE_PPI:
+		/*
+		 * Handling mode is hardcoded for PPIs, set the type using
+		 * HW reported value.
+		 */
+		*type = gicv5_ppi_irq_is_level(*hwirq) ? IRQ_TYPE_LEVEL_LOW :
+							 IRQ_TYPE_EDGE_RISING;
+		break;
+	case GICV5_HWIRQ_TYPE_SPI:
+		*type = fwspec->param[2] & IRQ_TYPE_SENSE_MASK;
+		break;
+	default:
+		BUILD_BUG_ON(1);
+	}
 
 	return 0;
 }
 
+static int gicv5_irq_ppi_domain_translate(struct irq_domain *d,
+					  struct irq_fwspec *fwspec,
+					  irq_hw_number_t *hwirq,
+					  unsigned int *type)
+{
+	return gicv5_irq_domain_translate(d, fwspec, hwirq, type,
+					  GICV5_HWIRQ_TYPE_PPI);
+}
+
 static int gicv5_irq_ppi_domain_alloc(struct irq_domain *domain, unsigned int virq,
 				      unsigned int nr_irqs, void *arg)
 {
@@ -310,6 +528,63 @@ static const struct irq_domain_ops gicv5_irq_ppi_domain_ops = {
 	.select		= gicv5_irq_ppi_domain_select
 };
 
+static int gicv5_irq_spi_domain_translate(struct irq_domain *d,
+					  struct irq_fwspec *fwspec,
+					  irq_hw_number_t *hwirq,
+					  unsigned int *type)
+{
+	return gicv5_irq_domain_translate(d, fwspec, hwirq, type,
+					  GICV5_HWIRQ_TYPE_SPI);
+}
+
+static int gicv5_irq_spi_domain_alloc(struct irq_domain *domain, unsigned int virq,
+				      unsigned int nr_irqs, void *arg)
+{
+	struct gicv5_irs_chip_data *chip_data;
+	unsigned int type = IRQ_TYPE_NONE;
+	struct irq_fwspec *fwspec = arg;
+	struct irq_data *irqd;
+	irq_hw_number_t hwirq;
+	int ret;
+
+	if (WARN_ON_ONCE(nr_irqs != 1))
+		return -EINVAL;
+
+	ret = gicv5_irq_spi_domain_translate(domain, fwspec, &hwirq, &type);
+	if (ret)
+		return ret;
+
+	irqd = irq_desc_get_irq_data(irq_to_desc(virq));
+	chip_data = gicv5_irs_lookup_by_spi_id(hwirq);
+
+	irq_domain_set_info(domain, virq, hwirq, &gicv5_spi_irq_chip, chip_data,
+			    handle_fasteoi_irq, NULL, NULL);
+	irq_set_probe(virq);
+	irqd_set_single_target(irqd);
+
+	gicv5_hwirq_init(hwirq, GICV5_IRQ_PRI_MI, GICV5_HWIRQ_TYPE_SPI);
+
+	return 0;
+}
+
+static int gicv5_irq_spi_domain_select(struct irq_domain *d, struct irq_fwspec *fwspec,
+				       enum irq_domain_bus_token bus_token)
+{
+	if (fwspec->fwnode != d->fwnode)
+		return 0;
+
+	if (fwspec->param[0] != GICV5_HWIRQ_TYPE_SPI)
+		return 0;
+
+	return (d == gicv5_global_data.spi_domain);
+}
+
+static const struct irq_domain_ops gicv5_irq_spi_domain_ops = {
+	.translate	= gicv5_irq_spi_domain_translate,
+	.alloc		= gicv5_irq_spi_domain_alloc,
+	.free		= gicv5_irq_domain_free,
+	.select		= gicv5_irq_spi_domain_select
+};
 static void handle_irq_per_domain(u32 hwirq)
 {
 	u8 hwirq_type = FIELD_GET(GICV5_HWIRQ_TYPE, hwirq);
@@ -320,6 +595,9 @@ static void handle_irq_per_domain(u32 hwirq)
 	case GICV5_HWIRQ_TYPE_PPI:
 		domain = gicv5_global_data.ppi_domain;
 		break;
+	case GICV5_HWIRQ_TYPE_SPI:
+		domain = gicv5_global_data.spi_domain;
+		break;
 	default:
 		pr_err_once("Unknown IRQ type, bail out\n");
 		return;
@@ -392,19 +670,23 @@ static int gicv5_starting_cpu(unsigned int cpu)
 
 	gicv5_cpu_enable_interrupts();
 
-	return 0;
+	return gicv5_irs_register_cpu(cpu);
 }
 
 static void __init gicv5_free_domains(void)
 {
 	if (gicv5_global_data.ppi_domain)
 		irq_domain_remove(gicv5_global_data.ppi_domain);
+	if (gicv5_global_data.spi_domain)
+		irq_domain_remove(gicv5_global_data.spi_domain);
 
 	gicv5_global_data.ppi_domain = NULL;
+	gicv5_global_data.spi_domain = NULL;
 }
 
 static int __init gicv5_init_domains(struct fwnode_handle *handle)
 {
+	u32 spi_count = gicv5_global_data.global_spi_count;
 	struct irq_domain *d;
 
 	d = irq_domain_create_linear(handle, PPI_NR, &gicv5_irq_ppi_domain_ops, NULL);
@@ -413,6 +695,20 @@ static int __init gicv5_init_domains(struct fwnode_handle *handle)
 
 	irq_domain_update_bus_token(d, DOMAIN_BUS_WIRED);
 	gicv5_global_data.ppi_domain = d;
+
+	if (spi_count) {
+		d = irq_domain_create_linear(handle, spi_count,
+					     &gicv5_irq_spi_domain_ops, NULL);
+
+		if (!d) {
+			gicv5_free_domains();
+			return -ENOMEM;
+		}
+
+		gicv5_global_data.spi_domain = d;
+		irq_domain_update_bus_token(d, DOMAIN_BUS_WIRED);
+	}
+
 	gicv5_global_data.fwnode = handle;
 
 	return 0;
@@ -424,26 +720,33 @@ static void gicv5_set_cpuif_pribits(void)
 
 	switch (FIELD_GET(ICC_IDR0_EL1_PRI_BITS, icc_idr0)) {
 	case ICC_IDR0_EL1_PRI_BITS_4BITS:
-		pri_bits = 4;
+		gicv5_global_data.cpuif_pri_bits = 4;
 		break;
 	case ICC_IDR0_EL1_PRI_BITS_5BITS:
-		pri_bits = 5;
+		gicv5_global_data.cpuif_pri_bits = 5;
 		break;
 	default:
 		pr_err("Unexpected ICC_IDR0_EL1_PRI_BITS value, default to 4");
-		pri_bits = 4;
+		gicv5_global_data.cpuif_pri_bits = 4;
 		break;
 	}
 }
 
 static int __init gicv5_of_init(struct device_node *node, struct device_node *parent)
 {
-	int ret = gicv5_init_domains(of_fwnode_handle(node));
+	int ret = gicv5_irs_of_probe(node);
 	if (ret)
 		return ret;
 
+	ret = gicv5_init_domains(of_fwnode_handle(node));
+	if (ret)
+		goto out_irs;
+
 	gicv5_set_cpuif_pribits();
 
+	pri_bits = min_not_zero(gicv5_global_data.cpuif_pri_bits,
+				gicv5_global_data.irs_pri_bits);
+
 	ret = gicv5_starting_cpu(smp_processor_id());
 	if (ret)
 		goto out_dom;
@@ -458,6 +761,8 @@ static int __init gicv5_of_init(struct device_node *node, struct device_node *pa
 	gicv5_cpu_disable_interrupts();
 out_dom:
 	gicv5_free_domains();
+out_irs:
+	gicv5_irs_remove();
 
 	return ret;
 }
diff --git a/include/linux/irqchip/arm-gic-v5.h b/include/linux/irqchip/arm-gic-v5.h
index b08ec0308a9b..1064a69ab33f 100644
--- a/include/linux/irqchip/arm-gic-v5.h
+++ b/include/linux/irqchip/arm-gic-v5.h
@@ -5,6 +5,8 @@
 #ifndef __LINUX_IRQCHIP_ARM_GIC_V5_H
 #define __LINUX_IRQCHIP_ARM_GIC_V5_H
 
+#include <linux/iopoll.h>
+
 #include <asm/sysreg.h>
 
 /*
@@ -15,5 +17,143 @@
 #define GICV5_HWIRQ_INTID		GENMASK_ULL(31, 0)
 
 #define GICV5_HWIRQ_TYPE_PPI		UL(0x1)
+#define GICV5_HWIRQ_TYPE_SPI		UL(0x3)
 
+/*
+ * Tables attributes
+ */
+#define GICV5_NO_READ_ALLOC		0b0
+#define GICV5_READ_ALLOC		0b1
+#define GICV5_NO_WRITE_ALLOC		0b0
+#define GICV5_WRITE_ALLOC		0b1
+
+#define GICV5_NON_CACHE			0b00
+#define GICV5_WB_CACHE			0b01
+#define GICV5_WT_CACHE			0b10
+
+#define GICV5_NON_SHARE			0b00
+#define GICV5_OUTER_SHARE		0b10
+#define GICV5_INNER_SHARE		0b11
+
+/*
+ * IRS registers
+ */
+#define GICV5_IRS_IDR1			0x0004
+#define GICV5_IRS_IDR2			0x0008
+#define GICV5_IRS_IDR5			0x0014
+#define GICV5_IRS_IDR6			0x0018
+#define GICV5_IRS_IDR7			0x001c
+#define GICV5_IRS_CR0			0x0080
+#define GICV5_IRS_CR1			0x0084
+#define GICV5_IRS_SPI_SELR		0x0108
+#define GICV5_IRS_SPI_CFGR		0x0114
+#define GICV5_IRS_SPI_STATUSR		0x0118
+#define GICV5_IRS_PE_SELR		0x0140
+#define GICV5_IRS_PE_STATUSR		0x0144
+#define GICV5_IRS_PE_CR0		0x0148
+
+#define GICV5_IRS_IDR1_PRIORITY_BITS	GENMASK(22, 20)
+#define GICV5_IRS_IDR1_IAFFID_BITS	GENMASK(19, 16)
+
+#define GICV5_IRS_IDR1_PRIORITY_BITS_1BITS	0b000
+#define GICV5_IRS_IDR1_PRIORITY_BITS_2BITS	0b001
+#define GICV5_IRS_IDR1_PRIORITY_BITS_3BITS	0b010
+#define GICV5_IRS_IDR1_PRIORITY_BITS_4BITS	0b011
+#define GICV5_IRS_IDR1_PRIORITY_BITS_5BITS	0b100
+
+#define GICV5_IRS_IDR2_ISTMD_SZ		GENMASK(19, 15)
+#define GICV5_IRS_IDR2_ISTMD		BIT(14)
+#define GICV5_IRS_IDR2_IST_L2SZ		GENMASK(13, 11)
+#define GICV5_IRS_IDR2_IST_LEVELS	BIT(10)
+#define GICV5_IRS_IDR2_MIN_LPI_ID_BITS	GENMASK(9, 6)
+#define GICV5_IRS_IDR2_LPI		BIT(5)
+#define GICV5_IRS_IDR2_ID_BITS		GENMASK(4, 0)
+
+#define GICV5_IRS_IDR5_SPI_RANGE	GENMASK(24, 0)
+#define GICV5_IRS_IDR6_SPI_IRS_RANGE	GENMASK(24, 0)
+#define GICV5_IRS_IDR7_SPI_BASE		GENMASK(23, 0)
+#define GICV5_IRS_CR0_IDLE		BIT(1)
+#define GICV5_IRS_CR0_IRSEN		BIT(0)
+
+#define GICV5_IRS_CR1_VPED_WA		BIT(15)
+#define GICV5_IRS_CR1_VPED_RA		BIT(14)
+#define GICV5_IRS_CR1_VMD_WA		BIT(13)
+#define GICV5_IRS_CR1_VMD_RA		BIT(12)
+#define GICV5_IRS_CR1_VPET_WA		BIT(11)
+#define GICV5_IRS_CR1_VPET_RA		BIT(10)
+#define GICV5_IRS_CR1_VMT_WA		BIT(9)
+#define GICV5_IRS_CR1_VMT_RA		BIT(8)
+#define GICV5_IRS_CR1_IST_WA		BIT(7)
+#define GICV5_IRS_CR1_IST_RA		BIT(6)
+#define GICV5_IRS_CR1_IC		GENMASK(5, 4)
+#define GICV5_IRS_CR1_OC		GENMASK(3, 2)
+#define GICV5_IRS_CR1_SH		GENMASK(1, 0)
+
+#define GICV5_IRS_SPI_STATUSR_V		BIT(1)
+#define GICV5_IRS_SPI_STATUSR_IDLE	BIT(0)
+
+#define GICV5_IRS_SPI_SELR_ID		GENMASK(23, 0)
+
+#define GICV5_IRS_SPI_CFGR_TM		BIT(0)
+
+#define GICV5_IRS_PE_SELR_IAFFID	GENMASK(15, 0)
+
+#define GICV5_IRS_PE_STATUSR_V		BIT(1)
+#define GICV5_IRS_PE_STATUSR_IDLE	BIT(0)
+
+#define GICV5_IRS_PE_CR0_DPS		BIT(0)
+
+/*
+ * Global Data structures and functions
+ */
+struct gicv5_chip_data {
+	struct fwnode_handle	*fwnode;
+	struct irq_domain	*ppi_domain;
+	struct irq_domain	*spi_domain;
+	u32			global_spi_count;
+	u8			cpuif_pri_bits;
+	u8			irs_pri_bits;
+};
+
+extern struct gicv5_chip_data gicv5_global_data __read_mostly;
+
+struct gicv5_irs_chip_data {
+	struct list_head	entry;
+	struct fwnode_handle	*fwnode;
+	void __iomem		*irs_base;
+	u32			flags;
+	u32			spi_min;
+	u32			spi_range;
+	raw_spinlock_t		spi_config_lock;
+};
+
+static inline int gicv5_wait_for_op_s_atomic(void __iomem *addr, u32 offset,
+					     const char *reg_s, u32 mask,
+					     u32 *val)
+{
+	void __iomem *reg = addr + offset;
+	u32 tmp;
+	int ret;
+
+	ret = readl_poll_timeout_atomic(reg, tmp, tmp & mask, 1, 10 * USEC_PER_MSEC);
+	if (unlikely(ret == -ETIMEDOUT)) {
+		pr_err_ratelimited("%s timeout...\n", reg_s);
+		return ret;
+	}
+
+	if (val)
+		*val = tmp;
+
+	return 0;
+}
+
+#define gicv5_wait_for_op_atomic(base, reg, mask, val) \
+	gicv5_wait_for_op_s_atomic(base, reg, #reg, mask, val)
+
+int gicv5_irs_of_probe(struct device_node *parent);
+void gicv5_irs_remove(void);
+int gicv5_irs_register_cpu(int cpuid);
+int gicv5_irs_cpu_to_iaffid(int cpu_id, u16 *iaffid);
+struct gicv5_irs_chip_data *gicv5_irs_lookup_by_spi_id(u32 spi_id);
+int gicv5_spi_irq_set_type(struct irq_data *d, unsigned int type);
 #endif

-- 
2.48.0


