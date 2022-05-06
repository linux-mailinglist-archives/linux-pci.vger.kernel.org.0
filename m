Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF3E551D969
	for <lists+linux-pci@lfdr.de>; Fri,  6 May 2022 15:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441813AbiEFNoc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 May 2022 09:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390629AbiEFNo2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 May 2022 09:44:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3DBCFE1;
        Fri,  6 May 2022 06:40:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C8104620B6;
        Fri,  6 May 2022 13:40:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3EDDC385A9;
        Fri,  6 May 2022 13:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651844443;
        bh=WvnVIg1hef4nrXhZHTrWqUClNiZv4syHGI0wmAo4Hx0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u0/AITSQ7ltDttphUqkNhUajMFminqCiZEQPffxyraZ9DrhVZSM9hBnBqF7NeMhpR
         CpZjbrvByyq2xjVp8I0gA5WJV5jHXsqcqJ6+5L6rxNgyPMf5uwKa8VyFWjUi6nS491
         A3ngrkthDt5LOvXP0+tCmMNVjrrRujPWVqUE9pZrEw2DQoY+OMYvAzbgpzYIZLbFbF
         XFr9v37CQIzJsD3GNWRdYuYpJ0Xr6b/9HVh3W3nE32G/QepIrGge0AJ989w6QovASm
         S6M0BKousb7dWIhAxcqpv6N8FEX9XJ3YXHDfB3iV1qhrrsNheFajxpDXvQasfvv0Zh
         HyJWla2iijlNA==
Received: by pali.im (Postfix)
        id 4BC4C125F; Fri,  6 May 2022 15:40:40 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/6] irqchip/armada-370-xp: Implement SoC Error interrupts
Date:   Fri,  6 May 2022 15:40:25 +0200
Message-Id: <20220506134029.21470-3-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220506134029.21470-1-pali@kernel.org>
References: <20220506134029.21470-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

MPIC IRQ 4 is used as SoC Error Summary interrupt and provides access to
another hierarchy of SoC Error interrupts. Implement a new IRQ chip and
domain for accessing this IRQ hierarchy.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 drivers/irqchip/irq-armada-370-xp.c | 213 +++++++++++++++++++++++++++-
 1 file changed, 210 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada-370-xp.c
index ebd76ea1c69b..71578b65f5c8 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -117,6 +117,8 @@
 /* Registers relative to main_int_base */
 #define ARMADA_370_XP_INT_CONTROL		(0x00)
 #define ARMADA_370_XP_SW_TRIG_INT_OFFS		(0x04)
+#define ARMADA_370_XP_INT_SOC_ERR_0_CAUSE_OFFS	(0x20)
+#define ARMADA_370_XP_INT_SOC_ERR_1_CAUSE_OFFS	(0x24)
 #define ARMADA_370_XP_INT_SET_ENABLE_OFFS	(0x30)
 #define ARMADA_370_XP_INT_CLEAR_ENABLE_OFFS	(0x34)
 #define ARMADA_370_XP_INT_SOURCE_CTL(irq)	(0x100 + irq*4)
@@ -130,6 +132,8 @@
 #define ARMADA_370_XP_CPU_INTACK_OFFS		(0x44)
 #define ARMADA_370_XP_INT_SET_MASK_OFFS		(0x48)
 #define ARMADA_370_XP_INT_CLEAR_MASK_OFFS	(0x4C)
+#define ARMADA_370_XP_INT_SOC_ERR_0_MASK_OFF	(0x50)
+#define ARMADA_370_XP_INT_SOC_ERR_1_MASK_OFF	(0x54)
 #define ARMADA_370_XP_INT_FABRIC_MASK_OFFS	(0x54)
 #define ARMADA_370_XP_INT_CAUSE_PERF(cpu)	(1 << cpu)
 
@@ -146,6 +150,8 @@
 static void __iomem *per_cpu_int_base;
 static void __iomem *main_int_base;
 static struct irq_domain *armada_370_xp_mpic_domain;
+static struct irq_domain *armada_370_xp_soc_err_domain;
+static unsigned int soc_err_irq_num_regs;
 static u32 doorbell_mask_reg;
 static int parent_irq;
 #ifdef CONFIG_PCI_MSI
@@ -156,6 +162,8 @@ static DEFINE_MUTEX(msi_used_lock);
 static phys_addr_t msi_doorbell_addr;
 #endif
 
+static void armada_370_xp_soc_err_irq_unmask(struct irq_data *d);
+
 static inline bool is_percpu_irq(irq_hw_number_t irq)
 {
 	if (irq <= ARMADA_370_XP_MAX_PER_CPU_IRQS)
@@ -509,6 +517,27 @@ static void armada_xp_mpic_reenable_percpu(void)
 		armada_370_xp_irq_unmask(data);
 	}
 
+	/* Re-enable per-CPU SoC Error interrupts that were enabled before suspend */
+	for (irq = 0; irq < soc_err_irq_num_regs * 32; irq++) {
+		struct irq_data *data;
+		int virq;
+
+		virq = irq_linear_revmap(armada_370_xp_soc_err_domain, irq);
+		if (virq == 0)
+			continue;
+
+		data = irq_get_irq_data(virq);
+
+		if (!irq_percpu_is_enabled(virq))
+			continue;
+
+		armada_370_xp_soc_err_irq_unmask(data);
+	}
+
+	/* Unmask summary SoC Error Interrupt */
+	if (soc_err_irq_num_regs > 0)
+		writel(4, per_cpu_int_base + ARMADA_370_XP_INT_CLEAR_MASK_OFFS);
+
 	ipi_resume();
 }
 
@@ -546,8 +575,8 @@ static struct irq_chip armada_370_xp_irq_chip = {
 static int armada_370_xp_mpic_irq_map(struct irq_domain *h,
 				      unsigned int virq, irq_hw_number_t hw)
 {
-	/* IRQs 0 and 1 cannot be mapped, they are handled internally */
-	if (hw <= 1)
+	/* IRQs 0, 1 and 4 cannot be mapped, they are handled internally */
+	if (hw <= 1 || hw == 4)
 		return -EINVAL;
 
 	armada_370_xp_irq_mask(irq_get_irq_data(virq));
@@ -577,6 +606,99 @@ static const struct irq_domain_ops armada_370_xp_mpic_irq_ops = {
 	.xlate = irq_domain_xlate_onecell,
 };
 
+static DEFINE_RAW_SPINLOCK(armada_370_xp_soc_err_lock);
+
+static void armada_370_xp_soc_err_irq_mask(struct irq_data *d)
+{
+	irq_hw_number_t hwirq = irqd_to_hwirq(d);
+	u32 reg, mask;
+
+	reg = hwirq >= 32 ? ARMADA_370_XP_INT_SOC_ERR_1_MASK_OFF
+			  : ARMADA_370_XP_INT_SOC_ERR_0_MASK_OFF;
+
+	raw_spin_lock(&armada_370_xp_soc_err_lock);
+	mask = readl(per_cpu_int_base + reg);
+	mask &= ~BIT(hwirq % 32);
+	writel(mask, per_cpu_int_base + reg);
+	raw_spin_unlock(&armada_370_xp_soc_err_lock);
+}
+
+static void armada_370_xp_soc_err_irq_unmask(struct irq_data *d)
+{
+	irq_hw_number_t hwirq = irqd_to_hwirq(d);
+	u32 reg, mask;
+
+	reg = hwirq >= 32 ? ARMADA_370_XP_INT_SOC_ERR_1_MASK_OFF
+			  : ARMADA_370_XP_INT_SOC_ERR_0_MASK_OFF;
+
+	raw_spin_lock(&armada_370_xp_soc_err_lock);
+	mask = readl(per_cpu_int_base + reg);
+	mask |= BIT(hwirq % 32);
+	writel(mask, per_cpu_int_base + reg);
+	raw_spin_unlock(&armada_370_xp_soc_err_lock);
+}
+
+static int armada_370_xp_soc_err_irq_mask_on_cpu(void *par)
+{
+	struct irq_data *d = par;
+	armada_370_xp_soc_err_irq_mask(d);
+	return 0;
+}
+
+static int armada_370_xp_soc_err_irq_unmask_on_cpu(void *par)
+{
+	struct irq_data *d = par;
+	armada_370_xp_soc_err_irq_unmask(d);
+	return 0;
+}
+
+static int armada_xp_soc_err_irq_set_affinity(struct irq_data *d,
+					      const struct cpumask *mask,
+					      bool force)
+{
+	unsigned int cpu;
+
+	cpus_read_lock();
+
+	/* First disable IRQ on all cores */
+	for_each_online_cpu(cpu)
+		smp_call_on_cpu(cpu, armada_370_xp_soc_err_irq_mask_on_cpu, d, true);
+
+	/* Select a single core from the affinity mask which is online */
+	cpu = cpumask_any_and(mask, cpu_online_mask);
+	smp_call_on_cpu(cpu, armada_370_xp_soc_err_irq_unmask_on_cpu, d, true);
+
+	cpus_read_unlock();
+
+	irq_data_update_effective_affinity(d, cpumask_of(cpu));
+
+	return IRQ_SET_MASK_OK;
+}
+
+static struct irq_chip armada_370_xp_soc_err_irq_chip = {
+	.name = "MPIC SOC",
+	.irq_mask = armada_370_xp_soc_err_irq_mask,
+	.irq_unmask = armada_370_xp_soc_err_irq_unmask,
+	.irq_set_affinity = armada_xp_soc_err_irq_set_affinity,
+};
+
+static int armada_370_xp_soc_err_irq_map(struct irq_domain *h,
+					 unsigned int virq, irq_hw_number_t hw)
+{
+	armada_370_xp_soc_err_irq_mask(irq_get_irq_data(virq));
+	irq_set_status_flags(virq, IRQ_LEVEL);
+	irq_set_percpu_devid(virq);
+	irq_set_chip_and_handler(virq, &armada_370_xp_soc_err_irq_chip,
+				 handle_percpu_devid_irq);
+	irq_set_probe(virq);
+	return 0;
+}
+
+static const struct irq_domain_ops armada_370_xp_soc_err_irq_ops = {
+	.map = armada_370_xp_soc_err_irq_map,
+	.xlate = irq_domain_xlate_onecell,
+};
+
 #ifdef CONFIG_PCI_MSI
 static void armada_370_xp_handle_msi_irq(struct pt_regs *regs, bool is_chained)
 {
@@ -605,6 +727,32 @@ static void armada_370_xp_handle_msi_irq(struct pt_regs *regs, bool is_chained)
 static void armada_370_xp_handle_msi_irq(struct pt_regs *r, bool b) {}
 #endif
 
+static void armada_370_xp_handle_soc_err_irq(void)
+{
+	unsigned long status, bit;
+	u32 mask, cause;
+
+	if (soc_err_irq_num_regs < 1)
+		return;
+
+	mask = readl(per_cpu_int_base + ARMADA_370_XP_INT_SOC_ERR_0_MASK_OFF);
+	cause = readl(main_int_base + ARMADA_370_XP_INT_SOC_ERR_0_CAUSE_OFFS);
+	status = cause & mask;
+
+	for_each_set_bit(bit, &status, 32)
+		generic_handle_domain_irq(armada_370_xp_soc_err_domain, bit);
+
+	if (soc_err_irq_num_regs < 2)
+		return;
+
+	mask = readl(per_cpu_int_base + ARMADA_370_XP_INT_SOC_ERR_1_MASK_OFF);
+	cause = readl(main_int_base + ARMADA_370_XP_INT_SOC_ERR_1_CAUSE_OFFS);
+	status = cause & mask;
+
+	for_each_set_bit(bit, &status, 32)
+		generic_handle_domain_irq(armada_370_xp_soc_err_domain, bit + 32);
+}
+
 static void armada_370_xp_mpic_handle_cascade_irq(struct irq_desc *desc)
 {
 	struct irq_chip *chip = irq_desc_get_chip(desc);
@@ -630,6 +778,11 @@ static void armada_370_xp_mpic_handle_cascade_irq(struct irq_desc *desc)
 			continue;
 		}
 
+		if (irqn == 4) {
+			armada_370_xp_handle_soc_err_irq();
+			continue;
+		}
+
 		generic_handle_domain_irq(armada_370_xp_mpic_domain, irqn);
 	}
 
@@ -649,7 +802,7 @@ armada_370_xp_handle_irq(struct pt_regs *regs)
 		if (irqnr > 1022)
 			break;
 
-		if (irqnr > 1) {
+		if (irqnr > 1 && irqnr != 4) {
 			generic_handle_domain_irq(armada_370_xp_mpic_domain,
 						  irqnr);
 			continue;
@@ -659,6 +812,10 @@ armada_370_xp_handle_irq(struct pt_regs *regs)
 		if (irqnr == 1)
 			armada_370_xp_handle_msi_irq(regs, false);
 
+		/* SoC Error handling */
+		if (irqnr == 4)
+			armada_370_xp_handle_soc_err_irq();
+
 #ifdef CONFIG_SMP
 		/* IPI Handling */
 		if (irqnr == 0) {
@@ -722,6 +879,26 @@ static void armada_370_xp_mpic_resume(void)
 		}
 	}
 
+	/* Re-enable per-CPU SoC Error interrupts */
+	for (irq = 0; irq < soc_err_irq_num_regs * 32; irq++) {
+		struct irq_data *data;
+		int virq;
+
+		virq = irq_linear_revmap(armada_370_xp_soc_err_domain, irq);
+		if (virq == 0)
+			continue;
+
+		data = irq_get_irq_data(virq);
+
+		/*
+		 * Re-enable on the current CPU,
+		 * armada_xp_mpic_reenable_percpu() will take
+		 * care of secondary CPUs when they come up.
+		 */
+		if (irq_percpu_is_enabled(virq))
+			armada_370_xp_soc_err_irq_unmask(data);
+	}
+
 	/* Reconfigure doorbells for IPIs and MSIs */
 	writel(doorbell_mask_reg,
 	       per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_MSK_OFFS);
@@ -730,6 +907,10 @@ static void armada_370_xp_mpic_resume(void)
 	if (doorbell_mask_reg & PCI_MSI_DOORBELL_MASK)
 		writel(1, per_cpu_int_base + ARMADA_370_XP_INT_CLEAR_MASK_OFFS);
 
+	/* Unmask summary SoC Error Interrupt */
+	if (soc_err_irq_num_regs > 0)
+		writel(4, per_cpu_int_base + ARMADA_370_XP_INT_CLEAR_MASK_OFFS);
+
 	ipi_resume();
 }
 
@@ -742,6 +923,7 @@ static int __init armada_370_xp_mpic_of_init(struct device_node *node,
 					     struct device_node *parent)
 {
 	struct resource main_int_res, per_cpu_int_res;
+	struct device_node *soc_err_node;
 	int nr_irqs, i;
 	u32 control;
 
@@ -775,12 +957,37 @@ static int __init armada_370_xp_mpic_of_init(struct device_node *node,
 	BUG_ON(!armada_370_xp_mpic_domain);
 	irq_domain_update_bus_token(armada_370_xp_mpic_domain, DOMAIN_BUS_WIRED);
 
+	soc_err_node = of_get_next_child(node, NULL);
+	if (!soc_err_node) {
+		pr_warn("Missing SoC Error Interrupt Controller node\n");
+		pr_warn("Extended interrupts are not supported\n");
+	} else {
+		pr_info("Registering MPIC SoC Error Interrupt Controller\n");
+		/*
+		 * Armada 370 and XP have only 32 SoC Error IRQs in one register
+		 * and other Armada platforms have 64 IRQs in two registers.
+		 */
+		soc_err_irq_num_regs =
+			of_machine_is_compatible("marvell,armada-370-xp") ? 1 : 2;
+		armada_370_xp_soc_err_domain =
+			irq_domain_add_hierarchy(armada_370_xp_mpic_domain, 0,
+						 soc_err_irq_num_regs * 32,
+						 soc_err_node,
+						 &armada_370_xp_soc_err_irq_ops,
+						 NULL);
+		BUG_ON(!armada_370_xp_soc_err_domain);
+	}
+
 	/* Setup for the boot CPU */
 	armada_xp_mpic_perf_init();
 	armada_xp_mpic_smp_cpu_init();
 
 	armada_370_xp_msi_init(node, main_int_res.start);
 
+	/* Unmask summary SoC Error Interrupt */
+	if (soc_err_irq_num_regs > 0)
+		writel(4, per_cpu_int_base + ARMADA_370_XP_INT_CLEAR_MASK_OFFS);
+
 	parent_irq = irq_of_parse_and_map(node, 0);
 	if (parent_irq <= 0) {
 		irq_set_default_host(armada_370_xp_mpic_domain);
-- 
2.20.1

