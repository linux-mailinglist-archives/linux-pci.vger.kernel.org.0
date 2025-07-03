Return-Path: <linux-pci+bounces-31373-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C10B0AF7046
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 12:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B546C189D8D8
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 10:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D64C2EA145;
	Thu,  3 Jul 2025 10:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VsVJwb35"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D3B2E9EDB;
	Thu,  3 Jul 2025 10:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751538438; cv=none; b=nOQfH53XM9LUzKU/WOiwigWsfepWcwaAVV/L0tYgtgI3aCWtz8TUmXtSSoVbqmB1YL6xzKf8h+lK7oe15iLqNmW13QkCtMzkrJsdq4hQz0iPtoxPEIjPlgJSyVgdGJLG/7XsrGl86cjdgT/52ZFkjD1AKGaEJnHqfhZZnfl2jdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751538438; c=relaxed/simple;
	bh=NUCCGK6hiUQUvqPaOoNklzaPM52Rkpd9zx9s+VBXJqE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ODatCIRm+p1C/TbT0+VLGj+gkYeEkoW9CYDDgaQADtjnQL/sgyNvg3dHeiZoLCkeCzqHKusQqyFeZzfEpwtpzDO2ADYodjhdJumE3yu2NENbvNjkI54/diYE2mTDS3XDXA9D/Ij5GBbiAloeMrx0uAMfKK7KdybjucnBJ3RbNho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VsVJwb35; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 217D2C4CEF4;
	Thu,  3 Jul 2025 10:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751538436;
	bh=NUCCGK6hiUQUvqPaOoNklzaPM52Rkpd9zx9s+VBXJqE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VsVJwb35SFvqfT4ciD/dqNH4TM2gvqT9CJfi96ZR2eN9h0hyhZFsxS1hUGqu/aeIo
	 NdeuIjc880MQAy2JZ5KWK1mbx7GUC9vsUshm7z1l5tqWnuJOD13fOWiJvuA1VG44NR
	 vIE3dEtNC7aJx3KqtAuCZb63Upls1DLeyD6UaHY0JWeKfJy5WDf9DlqFcftbhoytYq
	 5szgB4eBIeHe+xO/f3W8vTbwSeIH5jaiFzBRC7kRpDdTuVLO4hIY6Z0Xe/1kUnWM9F
	 kc4EgGEYV5klPaMxfGebGTE+ubUD/oJhMETjW1TWKwHDQN6tci2bHoxAhSfLN5mjHh
	 TYUhsRetjlB1g==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
Date: Thu, 03 Jul 2025 12:25:12 +0200
Subject: [PATCH v7 22/31] irqchip/gic-v5: Add GICv5 LPI/IPI support
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250703-gicv5-host-v7-22-12e71f1b3528@kernel.org>
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

An IRS supports Logical Peripheral Interrupts (LPIs) and implement
Linux IPIs on top of it.

LPIs are used for interrupt signals that are translated by a
GICv5 ITS (Interrupt Translation Service) but also for software
generated IRQs - namely interrupts that are not driven by a HW
signal, ie IPIs.

LPIs rely on memory storage for interrupt routing and state.

LPIs state and routing information is kept in the Interrupt
State Table (IST).

IRSes provide support for 1- or 2-level IST tables configured
to support a maximum number of interrupts that depend on the
OS configuration and the HW capabilities.

On systems that provide 2-level IST support, always allow
the maximum number of LPIs; On systems with only 1-level
support, limit the number of LPIs to 2^12 to prevent
wasting memory (presumably a system that supports a 1-level
only IST is not expecting a large number of interrupts).

On a 2-level IST system, L2 entries are allocated on
demand.

The IST table memory is allocated using the kmalloc() interface;
the allocation required may be smaller than a page and must be
made up of contiguous physical pages if larger than a page.

On systems where the IRS is not cache-coherent with the CPUs,
cache mainteinance operations are executed to clean and
invalidate the allocated memory to the point of coherency
making it visible to the IRS components.

On GICv5 systems, IPIs are implemented using LPIs.

Add an LPI IRQ domain and implement an IPI-specific IRQ domain created
as a child/subdomain of the LPI domain to allocate the required number
of LPIs needed to implement the IPIs.

IPIs are backed by LPIs, add LPIs allocation/de-allocation
functions.

The LPI INTID namespace is managed using an IDA to alloc/free LPI INTIDs.

Associate an IPI irqchip with IPI IRQ descriptors to provide
core code with the irqchip.ipi_send_single() method required
to raise an IPI.

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
 arch/arm64/include/asm/smp.h       |  17 ++
 arch/arm64/include/asm/sysreg.h    |   6 +
 arch/arm64/kernel/smp.c            |  17 --
 drivers/irqchip/irq-gic-v5-irs.c   | 364 +++++++++++++++++++++++++++++++++++++
 drivers/irqchip/irq-gic-v5.c       | 299 +++++++++++++++++++++++++++++-
 include/linux/irqchip/arm-gic-v5.h |  63 ++++++-
 6 files changed, 746 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/include/asm/smp.h b/arch/arm64/include/asm/smp.h
index d6fd6efb66a6..d48ef6d5abcc 100644
--- a/arch/arm64/include/asm/smp.h
+++ b/arch/arm64/include/asm/smp.h
@@ -50,6 +50,23 @@ struct seq_file;
  */
 extern void smp_init_cpus(void);
 
+enum ipi_msg_type {
+	IPI_RESCHEDULE,
+	IPI_CALL_FUNC,
+	IPI_CPU_STOP,
+	IPI_CPU_STOP_NMI,
+	IPI_TIMER,
+	IPI_IRQ_WORK,
+	NR_IPI,
+	/*
+	 * Any enum >= NR_IPI and < MAX_IPI is special and not tracable
+	 * with trace_ipi_*
+	 */
+	IPI_CPU_BACKTRACE = NR_IPI,
+	IPI_KGDB_ROUNDUP,
+	MAX_IPI
+};
+
 /*
  * Register IPI interrupts with the arch SMP code
  */
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index efd2e7a1fbe2..948007cd3684 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -1088,6 +1088,7 @@
 #define GICV5_OP_GIC_CDAFF		sys_insn(1, 0, 12, 1, 3)
 #define GICV5_OP_GIC_CDDI		sys_insn(1, 0, 12, 2, 0)
 #define GICV5_OP_GIC_CDDIS		sys_insn(1, 0, 12, 1, 0)
+#define GICV5_OP_GIC_CDHM		sys_insn(1, 0, 12, 2, 1)
 #define GICV5_OP_GIC_CDEN		sys_insn(1, 0, 12, 1, 1)
 #define GICV5_OP_GIC_CDEOI		sys_insn(1, 0, 12, 1, 7)
 #define GICV5_OP_GIC_CDPEND		sys_insn(1, 0, 12, 1, 4)
@@ -1115,6 +1116,11 @@
 #define GICV5_GIC_CDEN_TYPE_MASK	GENMASK_ULL(31, 29)
 #define GICV5_GIC_CDEN_ID_MASK		GENMASK_ULL(23, 0)
 
+/* Definitions for GIC CDHM */
+#define GICV5_GIC_CDHM_HM_MASK		BIT_ULL(32)
+#define GICV5_GIC_CDHM_TYPE_MASK	GENMASK_ULL(31, 29)
+#define GICV5_GIC_CDHM_ID_MASK		GENMASK_ULL(23, 0)
+
 /* Definitions for GIC CDPEND */
 #define GICV5_GIC_CDPEND_PENDING_MASK	BIT_ULL(32)
 #define GICV5_GIC_CDPEND_TYPE_MASK	GENMASK_ULL(31, 29)
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 2c501e917d38..4797e2c70014 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -64,23 +64,6 @@ struct secondary_data secondary_data;
 /* Number of CPUs which aren't online, but looping in kernel text. */
 static int cpus_stuck_in_kernel;
 
-enum ipi_msg_type {
-	IPI_RESCHEDULE,
-	IPI_CALL_FUNC,
-	IPI_CPU_STOP,
-	IPI_CPU_STOP_NMI,
-	IPI_TIMER,
-	IPI_IRQ_WORK,
-	NR_IPI,
-	/*
-	 * Any enum >= NR_IPI and < MAX_IPI is special and not tracable
-	 * with trace_ipi_*
-	 */
-	IPI_CPU_BACKTRACE = NR_IPI,
-	IPI_KGDB_ROUNDUP,
-	MAX_IPI
-};
-
 static int ipi_irq_base __ro_after_init;
 static int nr_ipi __ro_after_init = NR_IPI;
 
diff --git a/drivers/irqchip/irq-gic-v5-irs.c b/drivers/irqchip/irq-gic-v5-irs.c
index fba8efceb26e..f00a4a6fece7 100644
--- a/drivers/irqchip/irq-gic-v5-irs.c
+++ b/drivers/irqchip/irq-gic-v5-irs.c
@@ -5,12 +5,20 @@
 
 #define pr_fmt(fmt)	"GICv5 IRS: " fmt
 
+#include <linux/log2.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 
 #include <linux/irqchip.h>
 #include <linux/irqchip/arm-gic-v5.h>
 
+/*
+ * Hardcoded ID_BITS limit for systems supporting only a 1-level IST
+ * table. Systems supporting only a 1-level IST table aren't expected
+ * to require more than 2^12 LPIs. Tweak as required.
+ */
+#define LPI_ID_BITS_LINEAR		12
+
 #define IRS_FLAGS_NON_COHERENT		BIT(0)
 
 static DEFINE_PER_CPU_READ_MOSTLY(struct gicv5_irs_chip_data *, per_cpu_irs_data);
@@ -28,6 +36,331 @@ static void irs_writel_relaxed(struct gicv5_irs_chip_data *irs_data,
 	writel_relaxed(val, irs_data->irs_base + reg_offset);
 }
 
+static u64 irs_readq_relaxed(struct gicv5_irs_chip_data *irs_data,
+			     const u32 reg_offset)
+{
+	return readq_relaxed(irs_data->irs_base + reg_offset);
+}
+
+static void irs_writeq_relaxed(struct gicv5_irs_chip_data *irs_data,
+			       const u64 val, const u32 reg_offset)
+{
+	writeq_relaxed(val, irs_data->irs_base + reg_offset);
+}
+
+/*
+ * The polling wait (in gicv5_wait_for_op_s_atomic()) on a GIC register
+ * provides the memory barriers (through MMIO accessors)
+ * required to synchronize CPU and GIC access to IST memory.
+ */
+static int gicv5_irs_ist_synchronise(struct gicv5_irs_chip_data *irs_data)
+{
+	return gicv5_wait_for_op_atomic(irs_data->irs_base, GICV5_IRS_IST_STATUSR,
+					GICV5_IRS_IST_STATUSR_IDLE, NULL);
+}
+
+static int __init gicv5_irs_init_ist_linear(struct gicv5_irs_chip_data *irs_data,
+					    unsigned int lpi_id_bits,
+					    unsigned int istsz)
+{
+	size_t l2istsz;
+	u32 n, cfgr;
+	void *ist;
+	u64 baser;
+	int ret;
+
+	/* Taken from GICv5 specifications 10.2.1.13 IRS_IST_BASER */
+	n = max(5, lpi_id_bits + 1 + istsz);
+
+	l2istsz = BIT(n + 1);
+	/*
+	 * Check memory requirements. For a linear IST we cap the
+	 * number of ID bits to a value that should never exceed
+	 * kmalloc interface memory allocation limits, so this
+	 * check is really belt and braces.
+	 */
+	if (l2istsz > KMALLOC_MAX_SIZE) {
+		u8 lpi_id_cap = ilog2(KMALLOC_MAX_SIZE) - 2 + istsz;
+
+		pr_warn("Limiting LPI ID bits from %u to %u\n",
+			lpi_id_bits, lpi_id_cap);
+		lpi_id_bits = lpi_id_cap;
+		l2istsz = KMALLOC_MAX_SIZE;
+	}
+
+	ist = kzalloc(l2istsz, GFP_KERNEL);
+	if (!ist)
+		return -ENOMEM;
+
+	if (irs_data->flags & IRS_FLAGS_NON_COHERENT)
+		dcache_clean_inval_poc((unsigned long)ist,
+				       (unsigned long)ist + l2istsz);
+	else
+		dsb(ishst);
+
+	cfgr = FIELD_PREP(GICV5_IRS_IST_CFGR_STRUCTURE,
+			  GICV5_IRS_IST_CFGR_STRUCTURE_LINEAR)	|
+	       FIELD_PREP(GICV5_IRS_IST_CFGR_ISTSZ, istsz)	|
+	       FIELD_PREP(GICV5_IRS_IST_CFGR_L2SZ,
+			  GICV5_IRS_IST_CFGR_L2SZ_4K)		|
+	       FIELD_PREP(GICV5_IRS_IST_CFGR_LPI_ID_BITS, lpi_id_bits);
+	irs_writel_relaxed(irs_data, cfgr, GICV5_IRS_IST_CFGR);
+
+	gicv5_global_data.ist.l2 = false;
+
+	baser = (virt_to_phys(ist) & GICV5_IRS_IST_BASER_ADDR_MASK) |
+		FIELD_PREP(GICV5_IRS_IST_BASER_VALID, 0x1);
+	irs_writeq_relaxed(irs_data, baser, GICV5_IRS_IST_BASER);
+
+	ret = gicv5_irs_ist_synchronise(irs_data);
+	if (ret) {
+		kfree(ist);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int __init gicv5_irs_init_ist_two_level(struct gicv5_irs_chip_data *irs_data,
+					       unsigned int lpi_id_bits,
+					       unsigned int istsz,
+					       unsigned int l2sz)
+{
+	__le64 *l1ist;
+	u32 cfgr, n;
+	size_t l1sz;
+	u64 baser;
+	int ret;
+
+	/* Taken from GICv5 specifications 10.2.1.13 IRS_IST_BASER */
+	n = max(5, lpi_id_bits - ((10 - istsz) + (2 * l2sz)) + 2);
+
+	l1sz = BIT(n + 1);
+
+	l1ist = kzalloc(l1sz, GFP_KERNEL);
+	if (!l1ist)
+		return -ENOMEM;
+
+	if (irs_data->flags & IRS_FLAGS_NON_COHERENT)
+		dcache_clean_inval_poc((unsigned long)l1ist,
+				       (unsigned long)l1ist + l1sz);
+	else
+		dsb(ishst);
+
+	cfgr = FIELD_PREP(GICV5_IRS_IST_CFGR_STRUCTURE,
+			  GICV5_IRS_IST_CFGR_STRUCTURE_TWO_LEVEL)	|
+	       FIELD_PREP(GICV5_IRS_IST_CFGR_ISTSZ, istsz)		|
+	       FIELD_PREP(GICV5_IRS_IST_CFGR_L2SZ, l2sz)		|
+	       FIELD_PREP(GICV5_IRS_IST_CFGR_LPI_ID_BITS, lpi_id_bits);
+	irs_writel_relaxed(irs_data, cfgr, GICV5_IRS_IST_CFGR);
+
+	/*
+	 * The L2SZ determine bits required at L2 level. Number of bytes
+	 * required by metadata is reported through istsz - the number of bits
+	 * covered by L2 entries scales accordingly.
+	 */
+	gicv5_global_data.ist.l2_size = BIT(11 + (2 * l2sz) + 1);
+	gicv5_global_data.ist.l2_bits = (10 - istsz) + (2 * l2sz);
+	gicv5_global_data.ist.l1ist_addr = l1ist;
+	gicv5_global_data.ist.l2 = true;
+
+	baser = (virt_to_phys(l1ist) & GICV5_IRS_IST_BASER_ADDR_MASK) |
+		FIELD_PREP(GICV5_IRS_IST_BASER_VALID, 0x1);
+	irs_writeq_relaxed(irs_data, baser, GICV5_IRS_IST_BASER);
+
+	ret = gicv5_irs_ist_synchronise(irs_data);
+	if (ret) {
+		kfree(l1ist);
+		return ret;
+	}
+
+	return 0;
+}
+
+/*
+ * Alloc L2 IST entries on demand.
+ *
+ * Locking/serialization is guaranteed by irqdomain core code by
+ * taking the hierarchical domain struct irq_domain.root->mutex.
+ */
+int gicv5_irs_iste_alloc(const u32 lpi)
+{
+	struct gicv5_irs_chip_data *irs_data;
+	unsigned int index;
+	u32 l2istr, l2bits;
+	__le64 *l1ist;
+	size_t l2size;
+	void *l2ist;
+	int ret;
+
+	if (!gicv5_global_data.ist.l2)
+		return 0;
+
+	irs_data = per_cpu(per_cpu_irs_data, smp_processor_id());
+	if (!irs_data)
+		return -ENOENT;
+
+	l2size = gicv5_global_data.ist.l2_size;
+	l2bits = gicv5_global_data.ist.l2_bits;
+	l1ist = gicv5_global_data.ist.l1ist_addr;
+	index = lpi >> l2bits;
+
+	if (FIELD_GET(GICV5_ISTL1E_VALID, le64_to_cpu(l1ist[index])))
+		return 0;
+
+	l2ist = kzalloc(l2size, GFP_KERNEL);
+	if (!l2ist)
+		return -ENOMEM;
+
+	l1ist[index] = cpu_to_le64(virt_to_phys(l2ist) & GICV5_ISTL1E_L2_ADDR_MASK);
+
+	if (irs_data->flags & IRS_FLAGS_NON_COHERENT) {
+		dcache_clean_inval_poc((unsigned long)l2ist,
+				       (unsigned long)l2ist + l2size);
+		dcache_clean_poc((unsigned long)(l1ist + index),
+				 (unsigned long)(l1ist + index) + sizeof(*l1ist));
+	} else {
+		dsb(ishst);
+	}
+
+	l2istr = FIELD_PREP(GICV5_IRS_MAP_L2_ISTR_ID, lpi);
+	irs_writel_relaxed(irs_data, l2istr, GICV5_IRS_MAP_L2_ISTR);
+
+	ret = gicv5_irs_ist_synchronise(irs_data);
+	if (ret) {
+		l1ist[index] = 0;
+		kfree(l2ist);
+		return ret;
+	}
+
+	/*
+	 * Make sure we invalidate the cache line pulled before the IRS
+	 * had a chance to update the L1 entry and mark it valid.
+	 */
+	if (irs_data->flags & IRS_FLAGS_NON_COHERENT) {
+		/*
+		 * gicv5_irs_ist_synchronise() includes memory
+		 * barriers (MMIO accessors) required to guarantee that the
+		 * following dcache invalidation is not executed before the
+		 * IST mapping operation has completed.
+		 */
+		dcache_inval_poc((unsigned long)(l1ist + index),
+				 (unsigned long)(l1ist + index) + sizeof(*l1ist));
+	}
+
+	return 0;
+}
+
+/*
+ * Try to match the L2 IST size to the pagesize, and if this is not possible
+ * pick the smallest supported L2 size in order to minimise the requirement for
+ * physically contiguous blocks of memory as page-sized allocations are
+ * guaranteed to be physically contiguous, and are by definition the easiest to
+ * find.
+ *
+ * Fall back to the smallest supported size (in the event that the pagesize
+ * itself is not supported) again serves to make it easier to find physically
+ * contiguous blocks of memory.
+ */
+static unsigned int gicv5_irs_l2_sz(u32 idr2)
+{
+	switch (PAGE_SIZE) {
+	case SZ_64K:
+		if (GICV5_IRS_IST_L2SZ_SUPPORT_64KB(idr2))
+			return GICV5_IRS_IST_CFGR_L2SZ_64K;
+		fallthrough;
+	case SZ_4K:
+		if (GICV5_IRS_IST_L2SZ_SUPPORT_4KB(idr2))
+			return GICV5_IRS_IST_CFGR_L2SZ_4K;
+		fallthrough;
+	case SZ_16K:
+		if (GICV5_IRS_IST_L2SZ_SUPPORT_16KB(idr2))
+			return GICV5_IRS_IST_CFGR_L2SZ_16K;
+		break;
+	}
+
+	if (GICV5_IRS_IST_L2SZ_SUPPORT_4KB(idr2))
+		return GICV5_IRS_IST_CFGR_L2SZ_4K;
+
+	return GICV5_IRS_IST_CFGR_L2SZ_64K;
+}
+
+static int __init gicv5_irs_init_ist(struct gicv5_irs_chip_data *irs_data)
+{
+	u32 lpi_id_bits, idr2_id_bits, idr2_min_lpi_id_bits, l2_iste_sz, l2sz;
+	u32 l2_iste_sz_split, idr2;
+	bool two_levels, istmd;
+	u64 baser;
+	int ret;
+
+	baser = irs_readq_relaxed(irs_data, GICV5_IRS_IST_BASER);
+	if (FIELD_GET(GICV5_IRS_IST_BASER_VALID, baser)) {
+		pr_err("IST is marked as valid already; cannot allocate\n");
+		return -EPERM;
+	}
+
+	idr2 = irs_readl_relaxed(irs_data, GICV5_IRS_IDR2);
+	two_levels = !!FIELD_GET(GICV5_IRS_IDR2_IST_LEVELS, idr2);
+
+	idr2_id_bits = FIELD_GET(GICV5_IRS_IDR2_ID_BITS, idr2);
+	idr2_min_lpi_id_bits = FIELD_GET(GICV5_IRS_IDR2_MIN_LPI_ID_BITS, idr2);
+
+	/*
+	 * For two level tables we are always supporting the maximum allowed
+	 * number of IDs.
+	 *
+	 * For 1-level tables, we should support a number of bits that
+	 * is >= min_lpi_id_bits but cap it to LPI_ID_BITS_LINEAR lest
+	 * the level 1-table gets too large and its memory allocation
+	 * may fail.
+	 */
+	if (two_levels) {
+		lpi_id_bits = idr2_id_bits;
+	} else {
+		lpi_id_bits = max(LPI_ID_BITS_LINEAR, idr2_min_lpi_id_bits);
+		lpi_id_bits = min(lpi_id_bits, idr2_id_bits);
+	}
+
+	/*
+	 * Cap the ID bits according to the CPUIF supported ID bits
+	 */
+	lpi_id_bits = min(lpi_id_bits, gicv5_global_data.cpuif_id_bits);
+
+	if (two_levels)
+		l2sz = gicv5_irs_l2_sz(idr2);
+
+	istmd = !!FIELD_GET(GICV5_IRS_IDR2_ISTMD, idr2);
+
+	l2_iste_sz = GICV5_IRS_IST_CFGR_ISTSZ_4;
+
+	if (istmd) {
+		l2_iste_sz_split = FIELD_GET(GICV5_IRS_IDR2_ISTMD_SZ, idr2);
+
+		if (lpi_id_bits < l2_iste_sz_split)
+			l2_iste_sz = GICV5_IRS_IST_CFGR_ISTSZ_8;
+		else
+			l2_iste_sz = GICV5_IRS_IST_CFGR_ISTSZ_16;
+	}
+
+	/*
+	 * Follow GICv5 specification recommendation to opt in for two
+	 * level tables (ref: 10.2.1.14 IRS_IST_CFGR).
+	 */
+	if (two_levels && (lpi_id_bits > ((10 - l2_iste_sz) + (2 * l2sz)))) {
+		ret = gicv5_irs_init_ist_two_level(irs_data, lpi_id_bits,
+						   l2_iste_sz, l2sz);
+	} else {
+		ret = gicv5_irs_init_ist_linear(irs_data, lpi_id_bits,
+						l2_iste_sz);
+	}
+	if (ret)
+		return ret;
+
+	gicv5_init_lpis(BIT(lpi_id_bits));
+
+	return 0;
+}
+
 struct iaffid_entry {
 	u16	iaffid;
 	bool	valid;
@@ -362,6 +695,13 @@ static int __init gicv5_irs_init(struct device_node *node)
 		goto out_iomem;
 	}
 
+	idr = irs_readl_relaxed(irs_data, GICV5_IRS_IDR2);
+	if (WARN(!FIELD_GET(GICV5_IRS_IDR2_LPI, idr),
+		 "LPI support not available - no IPIs, can't proceed\n")) {
+		ret = -ENODEV;
+		goto out_iomem;
+	}
+
 	idr = irs_readl_relaxed(irs_data, GICV5_IRS_IDR7);
 	irs_data->spi_min = FIELD_GET(GICV5_IRS_IDR7_SPI_BASE, idr);
 
@@ -391,6 +731,8 @@ static int __init gicv5_irs_init(struct device_node *node)
 		spi_count = FIELD_GET(GICV5_IRS_IDR5_SPI_RANGE, idr);
 		gicv5_global_data.global_spi_count = spi_count;
 
+		gicv5_init_lpi_domain();
+
 		pr_debug("Detected %u SPIs globally\n", spi_count);
 	}
 
@@ -409,6 +751,9 @@ void __init gicv5_irs_remove(void)
 {
 	struct gicv5_irs_chip_data *irs_data, *tmp_data;
 
+	gicv5_free_lpi_domain();
+	gicv5_deinit_lpis();
+
 	list_for_each_entry_safe(irs_data, tmp_data, &irs_nodes, entry) {
 		iounmap(irs_data->irs_base);
 		list_del(&irs_data->entry);
@@ -416,6 +761,25 @@ void __init gicv5_irs_remove(void)
 	}
 }
 
+int __init gicv5_irs_enable(void)
+{
+	struct gicv5_irs_chip_data *irs_data;
+	int ret;
+
+	irs_data = list_first_entry_or_null(&irs_nodes,
+					    struct gicv5_irs_chip_data, entry);
+	if (!irs_data)
+		return -ENODEV;
+
+	ret = gicv5_irs_init_ist(irs_data);
+	if (ret) {
+		pr_err("Failed to init IST\n");
+		return ret;
+	}
+
+	return 0;
+}
+
 int __init gicv5_irs_of_probe(struct device_node *parent)
 {
 	struct device_node *np;
diff --git a/drivers/irqchip/irq-gic-v5.c b/drivers/irqchip/irq-gic-v5.c
index 9c55ddcfa0df..84ed13c4f2b1 100644
--- a/drivers/irqchip/irq-gic-v5.c
+++ b/drivers/irqchip/irq-gic-v5.c
@@ -5,7 +5,9 @@
 
 #define pr_fmt(fmt)	"GICv5: " fmt
 
+#include <linux/idr.h>
 #include <linux/irqdomain.h>
+#include <linux/slab.h>
 #include <linux/wordpart.h>
 
 #include <linux/irqchip.h>
@@ -28,6 +30,42 @@ static bool gicv5_cpuif_has_gcie(void)
 
 struct gicv5_chip_data gicv5_global_data __read_mostly;
 
+static DEFINE_IDA(lpi_ida);
+static u32 num_lpis __ro_after_init;
+
+void __init gicv5_init_lpis(u32 lpis)
+{
+	num_lpis = lpis;
+}
+
+void __init gicv5_deinit_lpis(void)
+{
+	num_lpis = 0;
+}
+
+static int alloc_lpi(void)
+{
+	if (!num_lpis)
+		return -ENOSPC;
+
+	return ida_alloc_max(&lpi_ida, num_lpis - 1, GFP_KERNEL);
+}
+
+static void release_lpi(u32 lpi)
+{
+	ida_free(&lpi_ida, lpi);
+}
+
+int gicv5_alloc_lpi(void)
+{
+	return alloc_lpi();
+}
+
+void gicv5_free_lpi(u32 lpi)
+{
+	release_lpi(lpi);
+}
+
 static void gicv5_ppi_priority_init(void)
 {
 	write_sysreg_s(REPEAT_BYTE(GICV5_IRQ_PRI_MI), SYS_ICC_PPI_PRIORITYR0_EL1);
@@ -60,7 +98,7 @@ static void gicv5_hwirq_init(irq_hw_number_t hwirq, u8 priority, u8 hwirq_type)
 	u16 iaffid;
 	int ret;
 
-	if (hwirq_type == GICV5_HWIRQ_TYPE_SPI) {
+	if (hwirq_type == GICV5_HWIRQ_TYPE_LPI || hwirq_type == GICV5_HWIRQ_TYPE_SPI) {
 		cdpri = FIELD_PREP(GICV5_GIC_CDPRI_PRIORITY_MASK, priority)	|
 			FIELD_PREP(GICV5_GIC_CDPRI_TYPE_MASK, hwirq_type)	|
 			FIELD_PREP(GICV5_GIC_CDPRI_ID_MASK, hwirq);
@@ -122,6 +160,11 @@ static void gicv5_spi_irq_mask(struct irq_data *d)
 	gicv5_iri_irq_mask(d, GICV5_HWIRQ_TYPE_SPI);
 }
 
+static void gicv5_lpi_irq_mask(struct irq_data *d)
+{
+	gicv5_iri_irq_mask(d, GICV5_HWIRQ_TYPE_LPI);
+}
+
 static void gicv5_ppi_irq_unmask(struct irq_data *d)
 {
 	u64 hwirq_id_bit = BIT_ULL(d->hwirq % 64);
@@ -149,7 +192,7 @@ static void gicv5_iri_irq_unmask(struct irq_data *d, u8 hwirq_type)
 	/*
 	 * Rule R_XCLJC states that the effects of a GIC system instruction
 	 * complete in finite time and that's the only requirement when
-	 * unmasking an SPI IRQ.
+	 * unmasking an SPI/LPI IRQ.
 	 */
 	gic_insn(cden, CDEN);
 }
@@ -159,6 +202,11 @@ static void gicv5_spi_irq_unmask(struct irq_data *d)
 	gicv5_iri_irq_unmask(d, GICV5_HWIRQ_TYPE_SPI);
 }
 
+static void gicv5_lpi_irq_unmask(struct irq_data *d)
+{
+	gicv5_iri_irq_unmask(d, GICV5_HWIRQ_TYPE_LPI);
+}
+
 static void gicv5_hwirq_eoi(u32 hwirq_id, u8 hwirq_type)
 {
 	u64 cddi;
@@ -181,6 +229,11 @@ static void gicv5_spi_irq_eoi(struct irq_data *d)
 	gicv5_hwirq_eoi(d->hwirq, GICV5_HWIRQ_TYPE_SPI);
 }
 
+static void gicv5_lpi_irq_eoi(struct irq_data *d)
+{
+	gicv5_hwirq_eoi(d->hwirq, GICV5_HWIRQ_TYPE_LPI);
+}
+
 static int gicv5_iri_irq_set_affinity(struct irq_data *d,
 				      const struct cpumask *mask_val,
 				      bool force, u8 hwirq_type)
@@ -216,6 +269,14 @@ static int gicv5_spi_irq_set_affinity(struct irq_data *d,
 					  GICV5_HWIRQ_TYPE_SPI);
 }
 
+static int gicv5_lpi_irq_set_affinity(struct irq_data *d,
+				      const struct cpumask *mask_val,
+				      bool force)
+{
+	return gicv5_iri_irq_set_affinity(d, mask_val, force,
+					  GICV5_HWIRQ_TYPE_LPI);
+}
+
 enum ppi_reg {
 	PPI_PENDING,
 	PPI_ACTIVE,
@@ -336,6 +397,14 @@ static int gicv5_spi_irq_get_irqchip_state(struct irq_data *d,
 					       GICV5_HWIRQ_TYPE_SPI);
 }
 
+static int gicv5_lpi_irq_get_irqchip_state(struct irq_data *d,
+					   enum irqchip_irq_state which,
+					   bool *state)
+{
+	return gicv5_iri_irq_get_irqchip_state(d, which, state,
+					       GICV5_HWIRQ_TYPE_LPI);
+}
+
 static int gicv5_ppi_irq_set_irqchip_state(struct irq_data *d,
 					   enum irqchip_irq_state which,
 					   bool state)
@@ -370,6 +439,11 @@ static void gicv5_spi_irq_write_pending_state(struct irq_data *d, bool state)
 	gicv5_iri_irq_write_pending_state(d, state, GICV5_HWIRQ_TYPE_SPI);
 }
 
+static void gicv5_lpi_irq_write_pending_state(struct irq_data *d, bool state)
+{
+	gicv5_iri_irq_write_pending_state(d, state, GICV5_HWIRQ_TYPE_LPI);
+}
+
 static int gicv5_spi_irq_set_irqchip_state(struct irq_data *d,
 					   enum irqchip_irq_state which,
 					   bool state)
@@ -386,12 +460,41 @@ static int gicv5_spi_irq_set_irqchip_state(struct irq_data *d,
 	return 0;
 }
 
+static int gicv5_lpi_irq_set_irqchip_state(struct irq_data *d,
+					   enum irqchip_irq_state which,
+					   bool state)
+{
+	switch (which) {
+	case IRQCHIP_STATE_PENDING:
+		gicv5_lpi_irq_write_pending_state(d, state);
+		break;
+
+	default:
+		pr_debug("Unexpected irqchip_irq_state\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int gicv5_spi_irq_retrigger(struct irq_data *data)
 {
 	return !gicv5_spi_irq_set_irqchip_state(data, IRQCHIP_STATE_PENDING,
 						true);
 }
 
+static int gicv5_lpi_irq_retrigger(struct irq_data *data)
+{
+	return !gicv5_lpi_irq_set_irqchip_state(data, IRQCHIP_STATE_PENDING,
+						true);
+}
+
+static void gicv5_ipi_send_single(struct irq_data *d, unsigned int cpu)
+{
+	/* Mark the LPI pending */
+	irq_chip_retrigger_hierarchy(d);
+}
+
 static bool gicv5_ppi_irq_is_level(irq_hw_number_t hwirq)
 {
 	u64 bit = BIT_ULL(hwirq % 64);
@@ -425,6 +528,32 @@ static const struct irq_chip gicv5_spi_irq_chip = {
 				  IRQCHIP_MASK_ON_SUSPEND,
 };
 
+static const struct irq_chip gicv5_lpi_irq_chip = {
+	.name			= "GICv5-LPI",
+	.irq_mask		= gicv5_lpi_irq_mask,
+	.irq_unmask		= gicv5_lpi_irq_unmask,
+	.irq_eoi		= gicv5_lpi_irq_eoi,
+	.irq_set_affinity	= gicv5_lpi_irq_set_affinity,
+	.irq_retrigger		= gicv5_lpi_irq_retrigger,
+	.irq_get_irqchip_state	= gicv5_lpi_irq_get_irqchip_state,
+	.irq_set_irqchip_state	= gicv5_lpi_irq_set_irqchip_state,
+	.flags			= IRQCHIP_SKIP_SET_WAKE	  |
+				  IRQCHIP_MASK_ON_SUSPEND,
+};
+
+static const struct irq_chip gicv5_ipi_irq_chip = {
+	.name			= "GICv5-IPI",
+	.irq_mask		= irq_chip_mask_parent,
+	.irq_unmask		= irq_chip_unmask_parent,
+	.irq_eoi		= irq_chip_eoi_parent,
+	.irq_set_affinity	= irq_chip_set_affinity_parent,
+	.irq_get_irqchip_state	= irq_chip_get_parent_state,
+	.irq_set_irqchip_state	= irq_chip_set_parent_state,
+	.ipi_send_single	= gicv5_ipi_send_single,
+	.flags			= IRQCHIP_SKIP_SET_WAKE	  |
+				  IRQCHIP_MASK_ON_SUSPEND,
+};
+
 static __always_inline int gicv5_irq_domain_translate(struct irq_domain *d,
 						      struct irq_fwspec *fwspec,
 						      irq_hw_number_t *hwirq,
@@ -585,6 +714,130 @@ static const struct irq_domain_ops gicv5_irq_spi_domain_ops = {
 	.free		= gicv5_irq_domain_free,
 	.select		= gicv5_irq_spi_domain_select
 };
+
+static void gicv5_lpi_config_reset(struct irq_data *d)
+{
+	u64 cdhm;
+
+	/*
+	 * Reset LPIs handling mode to edge by default and clear pending
+	 * state to make sure we start the LPI with a clean state from
+	 * previous incarnations.
+	 */
+	cdhm = FIELD_PREP(GICV5_GIC_CDHM_HM_MASK, 0)				|
+	       FIELD_PREP(GICV5_GIC_CDHM_TYPE_MASK, GICV5_HWIRQ_TYPE_LPI)	|
+	       FIELD_PREP(GICV5_GIC_CDHM_ID_MASK, d->hwirq);
+	gic_insn(cdhm, CDHM);
+
+	gicv5_lpi_irq_write_pending_state(d, false);
+}
+
+static int gicv5_irq_lpi_domain_alloc(struct irq_domain *domain, unsigned int virq,
+				      unsigned int nr_irqs, void *arg)
+{
+	irq_hw_number_t hwirq;
+	struct irq_data *irqd;
+	u32 *lpi = arg;
+	int ret;
+
+	if (WARN_ON_ONCE(nr_irqs != 1))
+		return -EINVAL;
+
+	hwirq = *lpi;
+
+	irqd = irq_domain_get_irq_data(domain, virq);
+
+	irq_domain_set_info(domain, virq, hwirq, &gicv5_lpi_irq_chip, NULL,
+			    handle_fasteoi_irq, NULL, NULL);
+	irqd_set_single_target(irqd);
+
+	ret = gicv5_irs_iste_alloc(hwirq);
+	if (ret < 0)
+		return ret;
+
+	gicv5_hwirq_init(hwirq, GICV5_IRQ_PRI_MI, GICV5_HWIRQ_TYPE_LPI);
+	gicv5_lpi_config_reset(irqd);
+
+	return 0;
+}
+
+static const struct irq_domain_ops gicv5_irq_lpi_domain_ops = {
+	.alloc	= gicv5_irq_lpi_domain_alloc,
+	.free	= gicv5_irq_domain_free,
+};
+
+void __init gicv5_init_lpi_domain(void)
+{
+	struct irq_domain *d;
+
+	d = irq_domain_create_tree(NULL, &gicv5_irq_lpi_domain_ops, NULL);
+	gicv5_global_data.lpi_domain = d;
+}
+
+void __init gicv5_free_lpi_domain(void)
+{
+	irq_domain_remove(gicv5_global_data.lpi_domain);
+	gicv5_global_data.lpi_domain = NULL;
+}
+
+static int gicv5_irq_ipi_domain_alloc(struct irq_domain *domain, unsigned int virq,
+				      unsigned int nr_irqs, void *arg)
+{
+	struct irq_data *irqd;
+	int ret, i;
+	u32 lpi;
+
+	for (i = 0; i < nr_irqs; i++) {
+		ret = gicv5_alloc_lpi();
+		if (ret < 0)
+			return ret;
+
+		lpi = ret;
+
+		ret = irq_domain_alloc_irqs_parent(domain, virq + i, 1, &lpi);
+		if (ret) {
+			gicv5_free_lpi(lpi);
+			return ret;
+		}
+
+		irqd = irq_domain_get_irq_data(domain, virq + i);
+
+		irq_domain_set_hwirq_and_chip(domain, virq + i, i,
+				&gicv5_ipi_irq_chip, NULL);
+
+		irqd_set_single_target(irqd);
+
+		irq_set_handler(virq + i, handle_percpu_irq);
+	}
+
+	return 0;
+}
+
+static void gicv5_irq_ipi_domain_free(struct irq_domain *domain, unsigned int virq,
+				      unsigned int nr_irqs)
+{
+	struct irq_data *d;
+	unsigned int i;
+
+	for (i = 0; i < nr_irqs; i++) {
+		d = irq_domain_get_irq_data(domain, virq + i);
+
+		if (!d)
+			return;
+
+		gicv5_free_lpi(d->parent_data->hwirq);
+
+		irq_set_handler(virq + i, NULL);
+		irq_domain_reset_irq_data(d);
+		irq_domain_free_irqs_parent(domain, virq + i, 1);
+	}
+}
+
+static const struct irq_domain_ops gicv5_irq_ipi_domain_ops = {
+	.alloc	= gicv5_irq_ipi_domain_alloc,
+	.free	= gicv5_irq_ipi_domain_free,
+};
+
 static void handle_irq_per_domain(u32 hwirq)
 {
 	u8 hwirq_type = FIELD_GET(GICV5_HWIRQ_TYPE, hwirq);
@@ -598,6 +851,9 @@ static void handle_irq_per_domain(u32 hwirq)
 	case GICV5_HWIRQ_TYPE_SPI:
 		domain = gicv5_global_data.spi_domain;
 		break;
+	case GICV5_HWIRQ_TYPE_LPI:
+		domain = gicv5_global_data.lpi_domain;
+		break;
 	default:
 		pr_err_once("Unknown IRQ type, bail out\n");
 		return;
@@ -679,9 +935,12 @@ static void __init gicv5_free_domains(void)
 		irq_domain_remove(gicv5_global_data.ppi_domain);
 	if (gicv5_global_data.spi_domain)
 		irq_domain_remove(gicv5_global_data.spi_domain);
+	if (gicv5_global_data.ipi_domain)
+		irq_domain_remove(gicv5_global_data.ipi_domain);
 
 	gicv5_global_data.ppi_domain = NULL;
 	gicv5_global_data.spi_domain = NULL;
+	gicv5_global_data.ipi_domain = NULL;
 }
 
 static int __init gicv5_init_domains(struct fwnode_handle *handle)
@@ -709,6 +968,19 @@ static int __init gicv5_init_domains(struct fwnode_handle *handle)
 		irq_domain_update_bus_token(d, DOMAIN_BUS_WIRED);
 	}
 
+	if (!WARN(!gicv5_global_data.lpi_domain,
+		  "LPI domain uninitialized, can't set up IPIs")) {
+		d = irq_domain_create_hierarchy(gicv5_global_data.lpi_domain,
+						0, GICV5_IPIS_PER_CPU * nr_cpu_ids,
+						NULL, &gicv5_irq_ipi_domain_ops,
+						NULL);
+
+		if (!d) {
+			gicv5_free_domains();
+			return -ENOMEM;
+		}
+		gicv5_global_data.ipi_domain = d;
+	}
 	gicv5_global_data.fwnode = handle;
 
 	return 0;
@@ -732,6 +1004,24 @@ static void gicv5_set_cpuif_pribits(void)
 	}
 }
 
+static void gicv5_set_cpuif_idbits(void)
+{
+	u32 icc_idr0 = read_sysreg_s(SYS_ICC_IDR0_EL1);
+
+	switch (FIELD_GET(ICC_IDR0_EL1_ID_BITS, icc_idr0)) {
+	case ICC_IDR0_EL1_ID_BITS_16BITS:
+		gicv5_global_data.cpuif_id_bits = 16;
+		break;
+	case ICC_IDR0_EL1_ID_BITS_24BITS:
+		gicv5_global_data.cpuif_id_bits = 24;
+		break;
+	default:
+		pr_err("Unexpected ICC_IDR0_EL1_ID_BITS value, default to 16");
+		gicv5_global_data.cpuif_id_bits = 16;
+		break;
+	}
+}
+
 static int __init gicv5_of_init(struct device_node *node, struct device_node *parent)
 {
 	int ret = gicv5_irs_of_probe(node);
@@ -743,6 +1033,7 @@ static int __init gicv5_of_init(struct device_node *node, struct device_node *pa
 		goto out_irs;
 
 	gicv5_set_cpuif_pribits();
+	gicv5_set_cpuif_idbits();
 
 	pri_bits = min_not_zero(gicv5_global_data.cpuif_pri_bits,
 				gicv5_global_data.irs_pri_bits);
@@ -755,6 +1046,10 @@ static int __init gicv5_of_init(struct device_node *node, struct device_node *pa
 	if (ret)
 		goto out_int;
 
+	ret = gicv5_irs_enable();
+	if (ret)
+		goto out_int;
+
 	return 0;
 
 out_int:
diff --git a/include/linux/irqchip/arm-gic-v5.h b/include/linux/irqchip/arm-gic-v5.h
index 1064a69ab33f..680eed794a35 100644
--- a/include/linux/irqchip/arm-gic-v5.h
+++ b/include/linux/irqchip/arm-gic-v5.h
@@ -7,8 +7,12 @@
 
 #include <linux/iopoll.h>
 
+#include <asm/cacheflush.h>
+#include <asm/smp.h>
 #include <asm/sysreg.h>
 
+#define GICV5_IPIS_PER_CPU		MAX_IPI
+
 /*
  * INTID handling
  */
@@ -17,6 +21,7 @@
 #define GICV5_HWIRQ_INTID		GENMASK_ULL(31, 0)
 
 #define GICV5_HWIRQ_TYPE_PPI		UL(0x1)
+#define GICV5_HWIRQ_TYPE_LPI		UL(0x2)
 #define GICV5_HWIRQ_TYPE_SPI		UL(0x3)
 
 /*
@@ -36,7 +41,7 @@
 #define GICV5_INNER_SHARE		0b11
 
 /*
- * IRS registers
+ * IRS registers and tables structures
  */
 #define GICV5_IRS_IDR1			0x0004
 #define GICV5_IRS_IDR2			0x0008
@@ -51,6 +56,10 @@
 #define GICV5_IRS_PE_SELR		0x0140
 #define GICV5_IRS_PE_STATUSR		0x0144
 #define GICV5_IRS_PE_CR0		0x0148
+#define GICV5_IRS_IST_BASER		0x0180
+#define GICV5_IRS_IST_CFGR		0x0190
+#define GICV5_IRS_IST_STATUSR		0x0194
+#define GICV5_IRS_MAP_L2_ISTR		0x01c0
 
 #define GICV5_IRS_IDR1_PRIORITY_BITS	GENMASK(22, 20)
 #define GICV5_IRS_IDR1_IAFFID_BITS	GENMASK(19, 16)
@@ -72,6 +81,11 @@
 #define GICV5_IRS_IDR5_SPI_RANGE	GENMASK(24, 0)
 #define GICV5_IRS_IDR6_SPI_IRS_RANGE	GENMASK(24, 0)
 #define GICV5_IRS_IDR7_SPI_BASE		GENMASK(23, 0)
+
+#define GICV5_IRS_IST_L2SZ_SUPPORT_4KB(r)	FIELD_GET(BIT(11), (r))
+#define GICV5_IRS_IST_L2SZ_SUPPORT_16KB(r)	FIELD_GET(BIT(12), (r))
+#define GICV5_IRS_IST_L2SZ_SUPPORT_64KB(r)	FIELD_GET(BIT(13), (r))
+
 #define GICV5_IRS_CR0_IDLE		BIT(1)
 #define GICV5_IRS_CR0_IRSEN		BIT(0)
 
@@ -103,6 +117,33 @@
 
 #define GICV5_IRS_PE_CR0_DPS		BIT(0)
 
+#define GICV5_IRS_IST_STATUSR_IDLE	BIT(0)
+
+#define GICV5_IRS_IST_CFGR_STRUCTURE	BIT(16)
+#define GICV5_IRS_IST_CFGR_ISTSZ	GENMASK(8, 7)
+#define GICV5_IRS_IST_CFGR_L2SZ		GENMASK(6, 5)
+#define GICV5_IRS_IST_CFGR_LPI_ID_BITS	GENMASK(4, 0)
+
+#define GICV5_IRS_IST_CFGR_STRUCTURE_LINEAR	0b0
+#define GICV5_IRS_IST_CFGR_STRUCTURE_TWO_LEVEL	0b1
+
+#define GICV5_IRS_IST_CFGR_ISTSZ_4	0b00
+#define GICV5_IRS_IST_CFGR_ISTSZ_8	0b01
+#define GICV5_IRS_IST_CFGR_ISTSZ_16	0b10
+
+#define GICV5_IRS_IST_CFGR_L2SZ_4K	0b00
+#define GICV5_IRS_IST_CFGR_L2SZ_16K	0b01
+#define GICV5_IRS_IST_CFGR_L2SZ_64K	0b10
+
+#define GICV5_IRS_IST_BASER_ADDR_MASK	GENMASK_ULL(55, 6)
+#define GICV5_IRS_IST_BASER_VALID	BIT_ULL(0)
+
+#define GICV5_IRS_MAP_L2_ISTR_ID	GENMASK(23, 0)
+
+#define GICV5_ISTL1E_VALID		BIT_ULL(0)
+
+#define GICV5_ISTL1E_L2_ADDR_MASK	GENMASK_ULL(55, 12)
+
 /*
  * Global Data structures and functions
  */
@@ -110,9 +151,18 @@ struct gicv5_chip_data {
 	struct fwnode_handle	*fwnode;
 	struct irq_domain	*ppi_domain;
 	struct irq_domain	*spi_domain;
+	struct irq_domain	*lpi_domain;
+	struct irq_domain	*ipi_domain;
 	u32			global_spi_count;
 	u8			cpuif_pri_bits;
+	u8			cpuif_id_bits;
 	u8			irs_pri_bits;
+	struct {
+		__le64 *l1ist_addr;
+		u32 l2_size;
+		u8 l2_bits;
+		bool l2;
+	} ist;
 };
 
 extern struct gicv5_chip_data gicv5_global_data __read_mostly;
@@ -150,10 +200,21 @@ static inline int gicv5_wait_for_op_s_atomic(void __iomem *addr, u32 offset,
 #define gicv5_wait_for_op_atomic(base, reg, mask, val) \
 	gicv5_wait_for_op_s_atomic(base, reg, #reg, mask, val)
 
+void __init gicv5_init_lpi_domain(void);
+void __init gicv5_free_lpi_domain(void);
+
 int gicv5_irs_of_probe(struct device_node *parent);
 void gicv5_irs_remove(void);
+int gicv5_irs_enable(void);
 int gicv5_irs_register_cpu(int cpuid);
 int gicv5_irs_cpu_to_iaffid(int cpu_id, u16 *iaffid);
 struct gicv5_irs_chip_data *gicv5_irs_lookup_by_spi_id(u32 spi_id);
 int gicv5_spi_irq_set_type(struct irq_data *d, unsigned int type);
+int gicv5_irs_iste_alloc(u32 lpi);
+
+void gicv5_init_lpis(u32 max);
+void gicv5_deinit_lpis(void);
+
+int gicv5_alloc_lpi(void);
+void gicv5_free_lpi(u32 lpi);
 #endif

-- 
2.48.0


