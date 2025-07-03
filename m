Return-Path: <linux-pci+bounces-31371-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0959EAF7042
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 12:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61D757B6F9F
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 10:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6762E49AC;
	Thu,  3 Jul 2025 10:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m3/usFBl"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728322E3372;
	Thu,  3 Jul 2025 10:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751538424; cv=none; b=YWN9ewZi6hULFhGtsrmmAzGsWRRDZIMEA5gEYJTgMHyQ4rIjHmz6gMiQ/SuJzfqh044L7C4zNLKKW3q/UOV+scIRIwyItyihOQZtYFQa5k9e4+p+HNrpS1AU5a2Kic3VdQs7OTaUgoEUvKortWekZd0zX3jPHStQJZ/7Cg9ZWBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751538424; c=relaxed/simple;
	bh=Ax+SoIbLlloOYsF4kGPHc9cyYRgERc2Qye8N42Rd+QM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VmEimms89Jsxp4kWKGemM1g9f0adI8U9VYqgYNYneF4iwe1XjHC6RBPyYzdh+uUX/NrUw3x5kcOR9bv8AUAxun/ipThMHVKVyrQK+KGAruezKVjMBNQJSfFu6ZuPPIHEd4GkWZWasmpouZNVITgYocsuI7Ulg//LV0ydNxeAI6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m3/usFBl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E48E4C4CEEB;
	Thu,  3 Jul 2025 10:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751538424;
	bh=Ax+SoIbLlloOYsF4kGPHc9cyYRgERc2Qye8N42Rd+QM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=m3/usFBl7w57ug7J9zh+Z85OSUVBn4LvvI+qcQ3lSBphr1Yw/9ayUfsuIGBTzKKHh
	 PYj3bstPnyZW73w25PwEXWOeJFfddIPPiHAONmGdztsuBxUy0IQFNc6nPIQTmsESWx
	 oVCmCrpt8W9nleQ+sxmylcHV77ME0+XZe1LyDUQG183YRN+wa29jzCgn9IsYPCYgHX
	 F9qVzifbFaK6Pu1dJ5IV1bA5WJMex1uqdHnLg+A8hovcQsazBp/7aKDVKFLBhvMBVD
	 mGUr7wMBR6GVwKgByTXPe8eDvVLsiV1UucaDo90wnuDsvcP0Hj1roVSty2s9TSsoqs
	 N9LhNuYWe9A1g==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
Date: Thu, 03 Jul 2025 12:25:10 +0200
Subject: [PATCH v7 20/31] irqchip/gic-v5: Add GICv5 PPI support
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250703-gicv5-host-v7-20-12e71f1b3528@kernel.org>
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

The GICv5 CPU interface implements support for PE-Private Peripheral
Interrupts (PPI), that are handled (enabled/prioritized/delivered)
entirely within the CPU interface hardware.

To enable PPI interrupts, implement the baseline GICv5 host kernel
driver infrastructure required to handle interrupts on a GICv5 system.

Add the exception handling code path and definitions for GICv5
instructions.

Add GICv5 PPI handling code as a specific IRQ domain to:

- Set-up PPI priority
- Manage PPI configuration and state
- Manage IRQ flow handler
- IRQs allocation/free
- Hook-up a PPI specific IRQchip to provide the relevant methods

PPI IRQ priority is chosen as the minimum allowed priority by the
system design (after probing the number of priority bits implemented
by the CPU interface).

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
 MAINTAINERS                        |   2 +
 arch/arm64/include/asm/sysreg.h    |  19 ++
 drivers/irqchip/Kconfig            |   5 +
 drivers/irqchip/Makefile           |   1 +
 drivers/irqchip/irq-gic-v5.c       | 464 +++++++++++++++++++++++++++++++++++++
 include/linux/irqchip/arm-gic-v5.h |  19 ++
 6 files changed, 510 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f02a768adecb..222a668f3fb6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1971,6 +1971,8 @@ M:	Marc Zyngier <maz@kernel.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	Documentation/devicetree/bindings/interrupt-controller/arm,gic-v5*.yaml
+F:	drivers/irqchip/irq-gic-v5*.[ch]
+F:	include/linux/irqchip/arm-gic-v5.h
 
 ARM HDLCD DRM DRIVER
 M:	Liviu Dudau <liviu.dudau@arm.com>
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 9b5fc6389715..36b82d74db37 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -1082,6 +1082,25 @@
 
 #define GCS_CAP(x)	((((unsigned long)x) & GCS_CAP_ADDR_MASK) | \
 					       GCS_CAP_VALID_TOKEN)
+/*
+ * Definitions for GICv5 instructions
+ */
+#define GICV5_OP_GIC_CDDI		sys_insn(1, 0, 12, 2, 0)
+#define GICV5_OP_GIC_CDEOI		sys_insn(1, 0, 12, 1, 7)
+#define GICV5_OP_GICR_CDIA		sys_insn(1, 0, 12, 3, 0)
+
+/* Definitions for GIC CDDI */
+#define GICV5_GIC_CDDI_TYPE_MASK	GENMASK_ULL(31, 29)
+#define GICV5_GIC_CDDI_ID_MASK		GENMASK_ULL(23, 0)
+
+/* Definitions for GICR CDIA */
+#define GICV5_GIC_CDIA_VALID_MASK	BIT_ULL(32)
+#define GICV5_GICR_CDIA_VALID(r)	FIELD_GET(GICV5_GIC_CDIA_VALID_MASK, r)
+#define GICV5_GIC_CDIA_TYPE_MASK	GENMASK_ULL(31, 29)
+#define GICV5_GIC_CDIA_ID_MASK		GENMASK_ULL(23, 0)
+
+#define gicr_insn(insn)			read_sysreg_s(GICV5_OP_GICR_##insn)
+#define gic_insn(v, insn)		write_sysreg_s(v, GICV5_OP_GIC_##insn)
 
 #define ARM64_FEATURE_FIELD_BITS	4
 
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 0d196e447142..3e4fb08b7a4d 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -54,6 +54,11 @@ config ARM_GIC_V3_ITS_FSL_MC
 	depends on FSL_MC_BUS
 	default ARM_GIC_V3_ITS
 
+config ARM_GIC_V5
+	bool
+	select IRQ_DOMAIN_HIERARCHY
+	select GENERIC_IRQ_EFFECTIVE_AFF_MASK
+
 config ARM_NVIC
 	bool
 	select IRQ_DOMAIN_HIERARCHY
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 23ca4959e6ce..3d75659d99eb 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -36,6 +36,7 @@ obj-$(CONFIG_ARM_GIC_V3)		+= irq-gic-v3.o irq-gic-v3-mbi.o irq-gic-common.o
 obj-$(CONFIG_ARM_GIC_V3_ITS)		+= irq-gic-v3-its.o irq-gic-v4.o irq-gic-v3-its-msi-parent.o
 obj-$(CONFIG_ARM_GIC_V3_ITS_FSL_MC)	+= irq-gic-v3-its-fsl-mc-msi.o
 obj-$(CONFIG_PARTITION_PERCPU)		+= irq-partition-percpu.o
+obj-$(CONFIG_ARM_GIC_V5)		+= irq-gic-v5.o
 obj-$(CONFIG_HISILICON_IRQ_MBIGEN)	+= irq-mbigen.o
 obj-$(CONFIG_ARM_NVIC)			+= irq-nvic.o
 obj-$(CONFIG_ARM_VIC)			+= irq-vic.o
diff --git a/drivers/irqchip/irq-gic-v5.c b/drivers/irqchip/irq-gic-v5.c
new file mode 100644
index 000000000000..0bb940212e20
--- /dev/null
+++ b/drivers/irqchip/irq-gic-v5.c
@@ -0,0 +1,464 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2024-2025 ARM Limited, All Rights Reserved.
+ */
+
+#define pr_fmt(fmt)	"GICv5: " fmt
+
+#include <linux/irqdomain.h>
+#include <linux/wordpart.h>
+
+#include <linux/irqchip.h>
+#include <linux/irqchip/arm-gic-v5.h>
+
+#include <asm/cpufeature.h>
+#include <asm/exception.h>
+
+static u8 pri_bits __ro_after_init = 5;
+
+#define GICV5_IRQ_PRI_MASK	0x1f
+#define GICV5_IRQ_PRI_MI	(GICV5_IRQ_PRI_MASK & GENMASK(4, 5 - pri_bits))
+
+#define PPI_NR	128
+
+static bool gicv5_cpuif_has_gcie(void)
+{
+	return this_cpu_has_cap(ARM64_HAS_GICV5_CPUIF);
+}
+
+struct gicv5_chip_data {
+	struct fwnode_handle	*fwnode;
+	struct irq_domain	*ppi_domain;
+};
+
+static struct gicv5_chip_data gicv5_global_data __read_mostly;
+
+static void gicv5_ppi_priority_init(void)
+{
+	write_sysreg_s(REPEAT_BYTE(GICV5_IRQ_PRI_MI), SYS_ICC_PPI_PRIORITYR0_EL1);
+	write_sysreg_s(REPEAT_BYTE(GICV5_IRQ_PRI_MI), SYS_ICC_PPI_PRIORITYR1_EL1);
+	write_sysreg_s(REPEAT_BYTE(GICV5_IRQ_PRI_MI), SYS_ICC_PPI_PRIORITYR2_EL1);
+	write_sysreg_s(REPEAT_BYTE(GICV5_IRQ_PRI_MI), SYS_ICC_PPI_PRIORITYR3_EL1);
+	write_sysreg_s(REPEAT_BYTE(GICV5_IRQ_PRI_MI), SYS_ICC_PPI_PRIORITYR4_EL1);
+	write_sysreg_s(REPEAT_BYTE(GICV5_IRQ_PRI_MI), SYS_ICC_PPI_PRIORITYR5_EL1);
+	write_sysreg_s(REPEAT_BYTE(GICV5_IRQ_PRI_MI), SYS_ICC_PPI_PRIORITYR6_EL1);
+	write_sysreg_s(REPEAT_BYTE(GICV5_IRQ_PRI_MI), SYS_ICC_PPI_PRIORITYR7_EL1);
+	write_sysreg_s(REPEAT_BYTE(GICV5_IRQ_PRI_MI), SYS_ICC_PPI_PRIORITYR8_EL1);
+	write_sysreg_s(REPEAT_BYTE(GICV5_IRQ_PRI_MI), SYS_ICC_PPI_PRIORITYR9_EL1);
+	write_sysreg_s(REPEAT_BYTE(GICV5_IRQ_PRI_MI), SYS_ICC_PPI_PRIORITYR10_EL1);
+	write_sysreg_s(REPEAT_BYTE(GICV5_IRQ_PRI_MI), SYS_ICC_PPI_PRIORITYR11_EL1);
+	write_sysreg_s(REPEAT_BYTE(GICV5_IRQ_PRI_MI), SYS_ICC_PPI_PRIORITYR12_EL1);
+	write_sysreg_s(REPEAT_BYTE(GICV5_IRQ_PRI_MI), SYS_ICC_PPI_PRIORITYR13_EL1);
+	write_sysreg_s(REPEAT_BYTE(GICV5_IRQ_PRI_MI), SYS_ICC_PPI_PRIORITYR14_EL1);
+	write_sysreg_s(REPEAT_BYTE(GICV5_IRQ_PRI_MI), SYS_ICC_PPI_PRIORITYR15_EL1);
+
+	/*
+	 * Context syncronization required to make sure system register writes
+	 * effects are synchronised.
+	 */
+	isb();
+}
+
+static void gicv5_ppi_irq_mask(struct irq_data *d)
+{
+	u64 hwirq_id_bit = BIT_ULL(d->hwirq % 64);
+
+	if (d->hwirq < 64)
+		sysreg_clear_set_s(SYS_ICC_PPI_ENABLER0_EL1, hwirq_id_bit, 0);
+	else
+		sysreg_clear_set_s(SYS_ICC_PPI_ENABLER1_EL1, hwirq_id_bit, 0);
+
+	/*
+	 * We must ensure that the disable takes effect immediately to
+	 * guarantee that the lazy-disabled IRQ mechanism works.
+	 * A context synchronization event is required to guarantee it.
+	 * Reference: I_ZLTKB/R_YRGMH GICv5 specification - section 2.9.1.
+	 */
+	isb();
+}
+
+static void gicv5_ppi_irq_unmask(struct irq_data *d)
+{
+	u64 hwirq_id_bit = BIT_ULL(d->hwirq % 64);
+
+	if (d->hwirq < 64)
+		sysreg_clear_set_s(SYS_ICC_PPI_ENABLER0_EL1, 0, hwirq_id_bit);
+	else
+		sysreg_clear_set_s(SYS_ICC_PPI_ENABLER1_EL1, 0, hwirq_id_bit);
+	/*
+	 * We must ensure that the enable takes effect in finite time - a
+	 * context synchronization event is required to guarantee it, we
+	 * can not take for granted that would happen (eg a core going straight
+	 * into idle after enabling a PPI).
+	 * Reference: I_ZLTKB/R_YRGMH GICv5 specification - section 2.9.1.
+	 */
+	isb();
+}
+
+static void gicv5_hwirq_eoi(u32 hwirq_id, u8 hwirq_type)
+{
+	u64 cddi;
+
+	cddi = FIELD_PREP(GICV5_GIC_CDDI_ID_MASK, hwirq_id)	|
+	       FIELD_PREP(GICV5_GIC_CDDI_TYPE_MASK, hwirq_type);
+
+	gic_insn(cddi, CDDI);
+
+	gic_insn(0, CDEOI);
+}
+
+static void gicv5_ppi_irq_eoi(struct irq_data *d)
+{
+	gicv5_hwirq_eoi(d->hwirq, GICV5_HWIRQ_TYPE_PPI);
+}
+
+enum ppi_reg {
+	PPI_PENDING,
+	PPI_ACTIVE,
+	PPI_HM
+};
+
+static __always_inline u64 read_ppi_sysreg_s(unsigned int irq,
+					     const enum ppi_reg which)
+{
+	switch (which) {
+	case PPI_PENDING:
+		return irq < 64	? read_sysreg_s(SYS_ICC_PPI_SPENDR0_EL1) :
+				  read_sysreg_s(SYS_ICC_PPI_SPENDR1_EL1);
+	case PPI_ACTIVE:
+		return irq < 64	? read_sysreg_s(SYS_ICC_PPI_SACTIVER0_EL1) :
+				  read_sysreg_s(SYS_ICC_PPI_SACTIVER1_EL1);
+	case PPI_HM:
+		return irq < 64	? read_sysreg_s(SYS_ICC_PPI_HMR0_EL1) :
+				  read_sysreg_s(SYS_ICC_PPI_HMR1_EL1);
+	default:
+		BUILD_BUG_ON(1);
+	}
+}
+
+static __always_inline void write_ppi_sysreg_s(unsigned int irq, bool set,
+					       const enum ppi_reg which)
+{
+	u64 bit = BIT_ULL(irq % 64);
+
+	switch (which) {
+	case PPI_PENDING:
+		if (set) {
+			if (irq < 64)
+				write_sysreg_s(bit, SYS_ICC_PPI_SPENDR0_EL1);
+			else
+				write_sysreg_s(bit, SYS_ICC_PPI_SPENDR1_EL1);
+		} else {
+			if (irq < 64)
+				write_sysreg_s(bit, SYS_ICC_PPI_CPENDR0_EL1);
+			else
+				write_sysreg_s(bit, SYS_ICC_PPI_CPENDR1_EL1);
+		}
+		return;
+	case PPI_ACTIVE:
+		if (set) {
+			if (irq < 64)
+				write_sysreg_s(bit, SYS_ICC_PPI_SACTIVER0_EL1);
+			else
+				write_sysreg_s(bit, SYS_ICC_PPI_SACTIVER1_EL1);
+		} else {
+			if (irq < 64)
+				write_sysreg_s(bit, SYS_ICC_PPI_CACTIVER0_EL1);
+			else
+				write_sysreg_s(bit, SYS_ICC_PPI_CACTIVER1_EL1);
+		}
+		return;
+	default:
+		BUILD_BUG_ON(1);
+	}
+}
+
+static int gicv5_ppi_irq_get_irqchip_state(struct irq_data *d,
+					   enum irqchip_irq_state which,
+					   bool *state)
+{
+	u64 hwirq_id_bit = BIT_ULL(d->hwirq % 64);
+
+	switch (which) {
+	case IRQCHIP_STATE_PENDING:
+		*state = !!(read_ppi_sysreg_s(d->hwirq, PPI_PENDING) & hwirq_id_bit);
+		return 0;
+	case IRQCHIP_STATE_ACTIVE:
+		*state = !!(read_ppi_sysreg_s(d->hwirq, PPI_ACTIVE) & hwirq_id_bit);
+		return 0;
+	default:
+		pr_debug("Unexpected PPI irqchip state\n");
+		return -EINVAL;
+	}
+}
+
+static int gicv5_ppi_irq_set_irqchip_state(struct irq_data *d,
+					   enum irqchip_irq_state which,
+					   bool state)
+{
+	switch (which) {
+	case IRQCHIP_STATE_PENDING:
+		write_ppi_sysreg_s(d->hwirq, state, PPI_PENDING);
+		return 0;
+	case IRQCHIP_STATE_ACTIVE:
+		write_ppi_sysreg_s(d->hwirq, state, PPI_ACTIVE);
+		return 0;
+	default:
+		pr_debug("Unexpected PPI irqchip state\n");
+		return -EINVAL;
+	}
+}
+
+static bool gicv5_ppi_irq_is_level(irq_hw_number_t hwirq)
+{
+	u64 bit = BIT_ULL(hwirq % 64);
+
+	return !!(read_ppi_sysreg_s(hwirq, PPI_HM) & bit);
+}
+
+static const struct irq_chip gicv5_ppi_irq_chip = {
+	.name			= "GICv5-PPI",
+	.irq_mask		= gicv5_ppi_irq_mask,
+	.irq_unmask		= gicv5_ppi_irq_unmask,
+	.irq_eoi		= gicv5_ppi_irq_eoi,
+	.irq_get_irqchip_state	= gicv5_ppi_irq_get_irqchip_state,
+	.irq_set_irqchip_state	= gicv5_ppi_irq_set_irqchip_state,
+	.flags			= IRQCHIP_SKIP_SET_WAKE	  |
+				  IRQCHIP_MASK_ON_SUSPEND,
+};
+
+static int gicv5_irq_ppi_domain_translate(struct irq_domain *d,
+					  struct irq_fwspec *fwspec,
+					  irq_hw_number_t *hwirq,
+					  unsigned int *type)
+{
+	if (!is_of_node(fwspec->fwnode))
+		return -EINVAL;
+
+	if (fwspec->param_count < 3)
+		return -EINVAL;
+
+	if (fwspec->param[0] != GICV5_HWIRQ_TYPE_PPI)
+		return -EINVAL;
+
+	*hwirq = fwspec->param[1];
+
+	/*
+	 * Handling mode is hardcoded for PPIs, set the type using
+	 * HW reported value.
+	 */
+	*type = gicv5_ppi_irq_is_level(*hwirq) ? IRQ_TYPE_LEVEL_LOW : IRQ_TYPE_EDGE_RISING;
+
+	return 0;
+}
+
+static int gicv5_irq_ppi_domain_alloc(struct irq_domain *domain, unsigned int virq,
+				      unsigned int nr_irqs, void *arg)
+{
+	unsigned int type = IRQ_TYPE_NONE;
+	struct irq_fwspec *fwspec = arg;
+	irq_hw_number_t hwirq;
+	int ret;
+
+	if (WARN_ON_ONCE(nr_irqs != 1))
+		return -EINVAL;
+
+	ret = gicv5_irq_ppi_domain_translate(domain, fwspec, &hwirq, &type);
+	if (ret)
+		return ret;
+
+	if (type & IRQ_TYPE_LEVEL_MASK)
+		irq_set_status_flags(virq, IRQ_LEVEL);
+
+	irq_set_percpu_devid(virq);
+	irq_domain_set_info(domain, virq, hwirq, &gicv5_ppi_irq_chip, NULL,
+			    handle_percpu_devid_irq, NULL, NULL);
+
+	return 0;
+}
+
+static void gicv5_irq_domain_free(struct irq_domain *domain, unsigned int virq,
+				  unsigned int nr_irqs)
+{
+	struct irq_data *d;
+
+	if (WARN_ON_ONCE(nr_irqs != 1))
+		return;
+
+	d = irq_domain_get_irq_data(domain, virq);
+
+	irq_set_handler(virq, NULL);
+	irq_domain_reset_irq_data(d);
+}
+
+static int gicv5_irq_ppi_domain_select(struct irq_domain *d, struct irq_fwspec *fwspec,
+				       enum irq_domain_bus_token bus_token)
+{
+	if (fwspec->fwnode != d->fwnode)
+		return 0;
+
+	if (fwspec->param[0] != GICV5_HWIRQ_TYPE_PPI)
+		return 0;
+
+	return (d == gicv5_global_data.ppi_domain);
+}
+
+static const struct irq_domain_ops gicv5_irq_ppi_domain_ops = {
+	.translate	= gicv5_irq_ppi_domain_translate,
+	.alloc		= gicv5_irq_ppi_domain_alloc,
+	.free		= gicv5_irq_domain_free,
+	.select		= gicv5_irq_ppi_domain_select
+};
+
+static void handle_irq_per_domain(u32 hwirq)
+{
+	u8 hwirq_type = FIELD_GET(GICV5_HWIRQ_TYPE, hwirq);
+	u32 hwirq_id = FIELD_GET(GICV5_HWIRQ_ID, hwirq);
+	struct irq_domain *domain;
+
+	switch (hwirq_type) {
+	case GICV5_HWIRQ_TYPE_PPI:
+		domain = gicv5_global_data.ppi_domain;
+		break;
+	default:
+		pr_err_once("Unknown IRQ type, bail out\n");
+		return;
+	}
+
+	if (generic_handle_domain_irq(domain, hwirq_id)) {
+		pr_err_once("Could not handle, hwirq = 0x%x", hwirq_id);
+		gicv5_hwirq_eoi(hwirq_id, hwirq_type);
+	}
+}
+
+static void __exception_irq_entry gicv5_handle_irq(struct pt_regs *regs)
+{
+	bool valid;
+	u32 hwirq;
+	u64 ia;
+
+	ia = gicr_insn(CDIA);
+	valid = GICV5_GICR_CDIA_VALID(ia);
+
+	if (!valid)
+		return;
+
+	/*
+	 * Ensure that the CDIA instruction effects (ie IRQ activation) are
+	 * completed before handling the interrupt.
+	 */
+	gsb_ack();
+
+	/*
+	 * Ensure instruction ordering between an acknowledgment and subsequent
+	 * instructions in the IRQ handler using an ISB.
+	 */
+	isb();
+
+	hwirq = FIELD_GET(GICV5_HWIRQ_INTID, ia);
+
+	handle_irq_per_domain(hwirq);
+}
+
+static void gicv5_cpu_disable_interrupts(void)
+{
+	u64 cr0;
+
+	cr0 = FIELD_PREP(ICC_CR0_EL1_EN, 0);
+	write_sysreg_s(cr0, SYS_ICC_CR0_EL1);
+}
+
+static void gicv5_cpu_enable_interrupts(void)
+{
+	u64 cr0, pcr;
+
+	write_sysreg_s(0, SYS_ICC_PPI_ENABLER0_EL1);
+	write_sysreg_s(0, SYS_ICC_PPI_ENABLER1_EL1);
+
+	gicv5_ppi_priority_init();
+
+	pcr = FIELD_PREP(ICC_PCR_EL1_PRIORITY, GICV5_IRQ_PRI_MI);
+	write_sysreg_s(pcr, SYS_ICC_PCR_EL1);
+
+	cr0 = FIELD_PREP(ICC_CR0_EL1_EN, 1);
+	write_sysreg_s(cr0, SYS_ICC_CR0_EL1);
+}
+
+static int gicv5_starting_cpu(unsigned int cpu)
+{
+	if (WARN(!gicv5_cpuif_has_gcie(),
+		 "GICv5 system components present but CPU does not have FEAT_GCIE"))
+		return -ENODEV;
+
+	gicv5_cpu_enable_interrupts();
+
+	return 0;
+}
+
+static void __init gicv5_free_domains(void)
+{
+	if (gicv5_global_data.ppi_domain)
+		irq_domain_remove(gicv5_global_data.ppi_domain);
+
+	gicv5_global_data.ppi_domain = NULL;
+}
+
+static int __init gicv5_init_domains(struct fwnode_handle *handle)
+{
+	struct irq_domain *d;
+
+	d = irq_domain_create_linear(handle, PPI_NR, &gicv5_irq_ppi_domain_ops, NULL);
+	if (!d)
+		return -ENOMEM;
+
+	irq_domain_update_bus_token(d, DOMAIN_BUS_WIRED);
+	gicv5_global_data.ppi_domain = d;
+	gicv5_global_data.fwnode = handle;
+
+	return 0;
+}
+
+static void gicv5_set_cpuif_pribits(void)
+{
+	u64 icc_idr0 = read_sysreg_s(SYS_ICC_IDR0_EL1);
+
+	switch (FIELD_GET(ICC_IDR0_EL1_PRI_BITS, icc_idr0)) {
+	case ICC_IDR0_EL1_PRI_BITS_4BITS:
+		pri_bits = 4;
+		break;
+	case ICC_IDR0_EL1_PRI_BITS_5BITS:
+		pri_bits = 5;
+		break;
+	default:
+		pr_err("Unexpected ICC_IDR0_EL1_PRI_BITS value, default to 4");
+		pri_bits = 4;
+		break;
+	}
+}
+
+static int __init gicv5_of_init(struct device_node *node, struct device_node *parent)
+{
+	int ret = gicv5_init_domains(of_fwnode_handle(node));
+	if (ret)
+		return ret;
+
+	gicv5_set_cpuif_pribits();
+
+	ret = gicv5_starting_cpu(smp_processor_id());
+	if (ret)
+		goto out_dom;
+
+	ret = set_handle_irq(gicv5_handle_irq);
+	if (ret)
+		goto out_int;
+
+	return 0;
+
+out_int:
+	gicv5_cpu_disable_interrupts();
+out_dom:
+	gicv5_free_domains();
+
+	return ret;
+}
+IRQCHIP_DECLARE(gic_v5, "arm,gic-v5", gicv5_of_init);
diff --git a/include/linux/irqchip/arm-gic-v5.h b/include/linux/irqchip/arm-gic-v5.h
new file mode 100644
index 000000000000..b08ec0308a9b
--- /dev/null
+++ b/include/linux/irqchip/arm-gic-v5.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2025 ARM Limited, All Rights Reserved.
+ */
+#ifndef __LINUX_IRQCHIP_ARM_GIC_V5_H
+#define __LINUX_IRQCHIP_ARM_GIC_V5_H
+
+#include <asm/sysreg.h>
+
+/*
+ * INTID handling
+ */
+#define GICV5_HWIRQ_ID			GENMASK(23, 0)
+#define GICV5_HWIRQ_TYPE		GENMASK(31, 29)
+#define GICV5_HWIRQ_INTID		GENMASK_ULL(31, 0)
+
+#define GICV5_HWIRQ_TYPE_PPI		UL(0x1)
+
+#endif

-- 
2.48.0


