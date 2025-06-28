Return-Path: <linux-pci+bounces-31014-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9435CAEC972
	for <lists+linux-pci@lfdr.de>; Sat, 28 Jun 2025 19:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3BA77ADA59
	for <lists+linux-pci@lfdr.de>; Sat, 28 Jun 2025 17:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8587F2882BE;
	Sat, 28 Jun 2025 17:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mmOUmfTm"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C32D2882A2;
	Sat, 28 Jun 2025 17:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751131830; cv=none; b=qIyg9UJSQI+jgvqqiD3TDT8eZx6M/LPOuEGWAWyFf4eckUhKihCFBrF180Z+2H1FzFJCCoQTfkmkTRcpqCJh2hEZliuf+1eQw8qJjfdh55F7m+4c0tsxL99S57va75eyA5hUcvayYNalNwaNfXbEDdOoHkX6wbOVcYJJMJ9wFow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751131830; c=relaxed/simple;
	bh=rYCQKGb1ZqPdvdaV2zXhlkoVVymsw18Qy4NODhcH3ZU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uGa0Bzhy322nahqlTwDOcMJ4nX6vjlgu1SwbczYbljd4OykTiDCT7+GVjYk4aLPx3BCTSwOfXkKiLeg0O2OwfIDI6pbiEyVMOQG7jAYzxEIpBpg3ZHYRj9+jJIl0HZdyqRXq1hKhZcsJtBGgqhPjMS8QSWU07oAl95LdRys6apE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mmOUmfTm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6415C4CEED;
	Sat, 28 Jun 2025 17:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751131829;
	bh=rYCQKGb1ZqPdvdaV2zXhlkoVVymsw18Qy4NODhcH3ZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mmOUmfTmwFZLwjKLAY8QqNR38lRHuU+tfuzbWXK3c1BNS/Ugp/VATFdJ2i+jLWwrT
	 IT5DffEw1nS4I2uhqSJQ9YTM99JT7Hl7Gl4iWFu4tKQZGLM3gQfI2inG/l6NwC4HuK
	 14s+fFxCGERkuDlAOZ6rBJ+LcsdRVN7cTnAAuE2wVOnNTb/L6BozTRb+mMagow/V10
	 CGXgHAduH0nByQ9JVG4M5sWbfw/WbJK+XzkP18Hb7cZk7XHGO29nERKo/zzkSSNjIO
	 42qwKZ/C08KhJ0/yWMHRmtw8t+4kaFKdC/sZRKBFpHd2bMsx983RBnDcBB3BOp1Nsb
	 T8GxZx/ogMi+w==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1uVZNj-00AqZC-Sf;
	Sat, 28 Jun 2025 18:30:28 +0100
From: Marc Zyngier <maz@kernel.org>
To: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Toan Le <toan@os.amperecomputing.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 09/12] PCI: xgene-msi: Sanitise MSI allocation and affinity setting
Date: Sat, 28 Jun 2025 18:30:02 +0100
Message-Id: <20250628173005.445013-10-maz@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250628173005.445013-1-maz@kernel.org>
References: <20250628173005.445013-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, toan@os.amperecomputing.com, lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org, bhelgaas@google.com, tglx@linutronix.de
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

Plugging a device that doesn't use managed affinity on an XGene-1
machine results in messages such as:

genirq: irq_chip PCI-MSIX-0000:01:00.0 did not update eff. affinity mask of irq 39

As it turns out, the driver was never updated to populate the effective
affinity on irq_set_affinity() call, and the core code is prickly about
that.

But upon further investigation, it appears that the driver keeps repainting
the hwirq field of the irq_data structure as a way to track the affinity
of the MSI, something that is very much frowned upon as it breaks the
fundamentals of an IRQ domain (an array indexed by hwirq).

Fixing this results more or less in a rewrite of the driver:

- Define how a hwirq and a cpu affinity map onto the MSI termination
  registers

- Allocate a single entry in the bitmap per MSI instead of *8*

- Correctly track CPU affinity

- Fix the documentation so that it actually means something (to me)

- Use standard bitmap iterators

- and plenty of other cleanups

With this, the driver behaves correctly on my vintage Mustang board.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/pci/controller/pci-xgene-msi.c | 212 ++++++++++---------------
 1 file changed, 82 insertions(+), 130 deletions(-)

diff --git a/drivers/pci/controller/pci-xgene-msi.c b/drivers/pci/controller/pci-xgene-msi.c
index 4be79b9ff80df..fbfdc80942596 100644
--- a/drivers/pci/controller/pci-xgene-msi.c
+++ b/drivers/pci/controller/pci-xgene-msi.c
@@ -6,6 +6,7 @@
  * Author: Tanmay Inamdar <tinamdar@apm.com>
  *	   Duc Dang <dhdang@apm.com>
  */
+#include <linux/bitfield.h>
 #include <linux/cpu.h>
 #include <linux/interrupt.h>
 #include <linux/irqdomain.h>
@@ -22,7 +23,12 @@
 #define IDX_PER_GROUP		8
 #define IRQS_PER_IDX		16
 #define NR_HW_IRQS		16
-#define NR_MSI_VEC		(IDX_PER_GROUP * IRQS_PER_IDX * NR_HW_IRQS)
+#define NR_MSI_BITS		(IDX_PER_GROUP * IRQS_PER_IDX * NR_HW_IRQS)
+#define NR_MSI_VEC		(NR_MSI_BITS / num_possible_cpus())
+
+#define MSI_GROUP_MASK		GENMASK(22, 19)
+#define MSI_INDEX_MASK		GENMASK(18, 16)
+#define MSI_INTR_MASK		GENMASK(19, 16)
 
 struct xgene_msi {
 	struct irq_domain	*inner_domain;
@@ -37,8 +43,21 @@ struct xgene_msi {
 static struct xgene_msi *xgene_msi_ctrl;
 
 /*
- * X-Gene v1 has 16 groups of MSI termination registers MSInIRx, where
- * n is group number (0..F), x is index of registers in each group (0..7)
+ * X-Gene v1 has 16 frames of MSI termination registers MSInIRx, where n is
+ * frame number (0..15), x is index of registers in each frame (0..7).  Each
+ * 32b register is at the beginning of a 64kB region, each frame occupying
+ * 512kB (and the whole thing 8MB of PA space).
+ *
+ * Each register supports 16 MSI vectors (0..15) to generate interrupts.
+ *
+ * Additionally, each MSI termination frame has 1 MSIINTn register (n is
+ * 0..15) to indicate the MSI pending status caused by 1 of its 8 index
+ * registers. Each 32b register is at the beginning of a 64kB region (and
+ * overall occupying an extra 1MB).
+ *
+ * There is one GIC IRQ assigned for each MSI termination frame, 16 in
+ * total.
+ *
  * The register layout is as follows:
  * MSI0IR0			base_addr
  * MSI0IR1			base_addr +  0x10000
@@ -59,13 +78,6 @@ static struct xgene_msi *xgene_msi_ctrl;
  * MSIINT1			base_addr + 0x810000
  * ...				...
  * MSIINTF			base_addr + 0x8F0000
- *
- * Each index register supports 16 MSI vectors (0..15) to generate interrupt.
- * There are total 16 GIC IRQs assigned for these 16 groups of MSI termination
- * registers.
- *
- * Each MSI termination group has 1 MSIINTn register (n is 0..15) to indicate
- * the MSI pending status caused by 1 of its 8 index registers.
  */
 
 /* MSInIRx read helper */
@@ -73,93 +85,60 @@ static u32 xgene_msi_ir_read(struct xgene_msi *msi,
 				    u32 msi_grp, u32 msir_idx)
 {
 	return readl_relaxed(msi->msi_regs + MSI_IR0 +
-			      (msi_grp << 19) + (msir_idx << 16));
+			     (FIELD_PREP(MSI_GROUP_MASK, msi_grp) |
+			      FIELD_PREP(MSI_INDEX_MASK, msir_idx)));
 }
 
 /* MSIINTn read helper */
 static u32 xgene_msi_int_read(struct xgene_msi *msi, u32 msi_grp)
 {
-	return readl_relaxed(msi->msi_regs + MSI_INT0 + (msi_grp << 16));
+	return readl_relaxed(msi->msi_regs + MSI_INT0 +
+			     FIELD_PREP(MSI_INTR_MASK, msi_grp));
 }
 
 /*
- * With 2048 MSI vectors supported, the MSI message can be constructed using
- * following scheme:
- * - Divide into 8 256-vector groups
- *		Group 0: 0-255
- *		Group 1: 256-511
- *		Group 2: 512-767
- *		...
- *		Group 7: 1792-2047
- * - Each 256-vector group is divided into 16 16-vector groups
- *	As an example: 16 16-vector groups for 256-vector group 0-255 is
- *		Group 0: 0-15
- *		Group 1: 16-32
- *		...
- *		Group 15: 240-255
- * - The termination address of MSI vector in 256-vector group n and 16-vector
- *   group x is the address of MSIxIRn
- * - The data for MSI vector in 16-vector group x is x
+ * In order to allow an MSI to be moved from one CPU to another without
+ * having to repaint both the address and the data (which cannot be done
+ * atomically), we statically partitions the MSI frames between CPUs. Given
+ * that XGene-1 has 8 CPUs, each CPU gets two frames assigned to it
+ *
+ * We adopt the convention that when an MSI is moved, it is configured to
+ * target the same register number in the new frame. This reserves a given
+ * MSI across all CPUs, and reduces the MSI capacity from 2048 to 256.
+ *
+ * Effectively, this amounts to:
+ * - hwirq[7]::cpu[2:0] is the target frame number
+ * - hwirq[6:4] is the register index in any given frame
+ * - hwirq[3:0] is the MSI data
  */
-static u32 hwirq_to_reg_set(unsigned long hwirq)
-{
-	return (hwirq / (NR_HW_IRQS * IRQS_PER_IDX));
-}
-
-static u32 hwirq_to_group(unsigned long hwirq)
-{
-	return (hwirq % NR_HW_IRQS);
-}
-
-static u32 hwirq_to_msi_data(unsigned long hwirq)
-{
-	return ((hwirq / NR_HW_IRQS) % IRQS_PER_IDX);
-}
-
 static void xgene_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 {
 	struct xgene_msi *msi = irq_data_get_irq_chip_data(data);
-	u32 reg_set = hwirq_to_reg_set(data->hwirq);
-	u32 group = hwirq_to_group(data->hwirq);
-	u64 target_addr = msi->msi_addr + (((8 * group) + reg_set) << 16);
+	u64 target_addr;
+	u32 frame, msir;
+	int cpu;
 
-	msg->address_hi = upper_32_bits(target_addr);
-	msg->address_lo = lower_32_bits(target_addr);
-	msg->data = hwirq_to_msi_data(data->hwirq);
-}
+	cpu	= cpumask_first(irq_data_get_effective_affinity_mask(data));
+	msir	= FIELD_GET(GENMASK(6, 4), data->hwirq);
+	frame	= FIELD_GET(BIT(7), data->hwirq) << 3 | cpu;
 
-/*
- * X-Gene v1 only has 16 MSI GIC IRQs for 2048 MSI vectors.  To maintain
- * the expected behaviour of .set_affinity for each MSI interrupt, the 16
- * MSI GIC IRQs are statically allocated to 8 X-Gene v1 cores (2 GIC IRQs
- * for each core).  The MSI vector is moved from 1 MSI GIC IRQ to another
- * MSI GIC IRQ to steer its MSI interrupt to correct X-Gene v1 core.  As a
- * consequence, the total MSI vectors that X-Gene v1 supports will be
- * reduced to 256 (2048/8) vectors.
- */
-static int hwirq_to_cpu(unsigned long hwirq)
-{
-	return (hwirq % num_possible_cpus());
-}
+	target_addr = msi->msi_addr;
+	target_addr += (FIELD_PREP(MSI_GROUP_MASK, frame) |
+			FIELD_PREP(MSI_INTR_MASK, msir));
 
-static unsigned long hwirq_to_canonical_hwirq(unsigned long hwirq)
-{
-	return (hwirq - hwirq_to_cpu(hwirq));
+	msg->address_hi = upper_32_bits(target_addr);
+	msg->address_lo = lower_32_bits(target_addr);
+	msg->data = data->hwirq & GENMASK(3, 0);
 }
 
 static int xgene_msi_set_affinity(struct irq_data *irqdata,
 				  const struct cpumask *mask, bool force)
 {
 	int target_cpu = cpumask_first(mask);
-	int curr_cpu;
 
-	curr_cpu = hwirq_to_cpu(irqdata->hwirq);
-	if (curr_cpu == target_cpu)
-		return IRQ_SET_MASK_OK_DONE;
-
-	/* Update MSI number to target the new CPU */
-	irqdata->hwirq = hwirq_to_canonical_hwirq(irqdata->hwirq) + target_cpu;
+	irq_data_update_effective_affinity(irqdata, cpumask_of(target_cpu));
 
+	/* Force the core code to regenerate the message */
 	return IRQ_SET_MASK_OK;
 }
 
@@ -173,23 +152,20 @@ static int xgene_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 				  unsigned int nr_irqs, void *args)
 {
 	struct xgene_msi *msi = domain->host_data;
-	int msi_irq;
+	irq_hw_number_t hwirq;
 
 	mutex_lock(&msi->bitmap_lock);
 
-	msi_irq = bitmap_find_next_zero_area(msi->bitmap, NR_MSI_VEC, 0,
-					     num_possible_cpus(), 0);
-	if (msi_irq < NR_MSI_VEC)
-		bitmap_set(msi->bitmap, msi_irq, num_possible_cpus());
-	else
-		msi_irq = -ENOSPC;
+	hwirq = find_first_zero_bit(msi->bitmap, NR_MSI_VEC);
+	if (hwirq < NR_MSI_VEC)
+		set_bit(hwirq, msi->bitmap);
 
 	mutex_unlock(&msi->bitmap_lock);
 
-	if (msi_irq < 0)
-		return msi_irq;
+	if (hwirq >= NR_MSI_VEC)
+		return -ENOSPC;
 
-	irq_domain_set_info(domain, virq, msi_irq,
+	irq_domain_set_info(domain, virq, hwirq,
 			    &xgene_msi_bottom_irq_chip, domain->host_data,
 			    handle_simple_irq, NULL, NULL);
 
@@ -201,12 +177,10 @@ static void xgene_irq_domain_free(struct irq_domain *domain,
 {
 	struct irq_data *d = irq_domain_get_irq_data(domain, virq);
 	struct xgene_msi *msi = irq_data_get_irq_chip_data(d);
-	u32 hwirq;
 
 	mutex_lock(&msi->bitmap_lock);
 
-	hwirq = hwirq_to_canonical_hwirq(d->hwirq);
-	bitmap_clear(msi->bitmap, hwirq, num_possible_cpus());
+	clear_bit(d->hwirq, msi->bitmap);
 
 	mutex_unlock(&msi->bitmap_lock);
 
@@ -263,55 +237,33 @@ static void xgene_msi_isr(struct irq_desc *desc)
 	unsigned int *irqp = irq_desc_get_handler_data(desc);
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	struct xgene_msi *xgene_msi = xgene_msi_ctrl;
-	int msir_index, msir_val, hw_irq, ret;
-	u32 intr_index, grp_select, msi_grp;
+	unsigned long grp_pending;
+	int msir_idx;
+	u32 msi_grp;
 
 	chained_irq_enter(chip, desc);
 
 	msi_grp = irqp - xgene_msi->gic_irq;
 
-	/*
-	 * MSIINTn (n is 0..F) indicates if there is a pending MSI interrupt
-	 * If bit x of this register is set (x is 0..7), one or more interrupts
-	 * corresponding to MSInIRx is set.
-	 */
-	grp_select = xgene_msi_int_read(xgene_msi, msi_grp);
-	while (grp_select) {
-		msir_index = ffs(grp_select) - 1;
-		/*
-		 * Calculate MSInIRx address to read to check for interrupts
-		 * (refer to termination address and data assignment
-		 * described in xgene_compose_msi_msg() )
-		 */
-		msir_val = xgene_msi_ir_read(xgene_msi, msi_grp, msir_index);
-		while (msir_val) {
-			intr_index = ffs(msir_val) - 1;
-			/*
-			 * Calculate MSI vector number (refer to the termination
-			 * address and data assignment described in
-			 * xgene_compose_msi_msg function)
-			 */
-			hw_irq = (((msir_index * IRQS_PER_IDX) + intr_index) *
-				 NR_HW_IRQS) + msi_grp;
-			/*
-			 * As we have multiple hw_irq that maps to single MSI,
-			 * always look up the virq using the hw_irq as seen from
-			 * CPU0
-			 */
-			hw_irq = hwirq_to_canonical_hwirq(hw_irq);
-			ret = generic_handle_domain_irq(xgene_msi->inner_domain, hw_irq);
+	grp_pending = xgene_msi_int_read(xgene_msi, msi_grp);
+
+	for_each_set_bit(msir_idx, &grp_pending, IDX_PER_GROUP) {
+		unsigned long msir;
+		int intr_idx;
+
+		msir = xgene_msi_ir_read(xgene_msi, msi_grp, msir_idx);
+
+		for_each_set_bit(intr_idx, &msir, IRQS_PER_IDX) {
+			irq_hw_number_t hwirq;
+			int ret;
+
+			hwirq = ((FIELD_GET(BIT(3), msi_grp) << 7)	|
+				 (msir_idx << 4)			|
+				 intr_idx);
+
+			ret = generic_handle_domain_irq(xgene_msi->inner_domain,
+							hwirq);
 			WARN_ON_ONCE(ret);
-			msir_val &= ~(1 << intr_index);
-		}
-		grp_select &= ~(1 << msir_index);
-
-		if (!grp_select) {
-			/*
-			 * We handled all interrupts happened in this group,
-			 * resample this group MSI_INTx register in case
-			 * something else has been made pending in the meantime
-			 */
-			grp_select = xgene_msi_int_read(xgene_msi, msi_grp);
 		}
 	}
 
-- 
2.39.2


