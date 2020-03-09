Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2296B17DAC0
	for <lists+linux-pci@lfdr.de>; Mon,  9 Mar 2020 09:24:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbgCIIX7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Mar 2020 04:23:59 -0400
Received: from mail.loongson.cn ([114.242.206.163]:56046 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726820AbgCIIX6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 9 Mar 2020 04:23:58 -0400
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxb9_+_GVesb4YAA--.12S8;
        Mon, 09 Mar 2020 16:23:41 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Huacai Chen <chenhc@lemote.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-mips@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jianmin Lv <lvjianmin@loongson.cn>
Subject: [PATCH 6/6] MIPS: Loongson: Add support for 7A1000 interrupt controller
Date:   Mon,  9 Mar 2020 16:23:26 +0800
Message-Id: <1583742206-29163-7-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1583742206-29163-1-git-send-email-yangtiezhu@loongson.cn>
References: <1583742206-29163-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf9Dxb9_+_GVesb4YAA--.12S8
X-Coremail-Antispam: 1UD129KBjvAXoW3uFW5KF1fCFyfXr1rKry8Krg_yoW8WFyfZo
        WxWrs3XrWrK3y8ZrWSgFs8JF1xur10vrn8AF1fZrs0yFsxtr98WFyjgw4rWF1fArnIkFWx
        Jry5Xrn5W3yIyFn3n29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
        AaLaJ3UjIYCTnIWjp_UUUOc7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20EY4v20xva
        j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r126s0DM28Irc
        Ia0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l
        84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j6r
        4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F4U
        JVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7V
        C0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j
        6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x0262
        8vn2kIc2xKxwCY02Avz4vE14v_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
        Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
        AY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAI
        cVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
        AIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2
        KfnxnUUI43ZEXa7VUj8pntUUUUU==
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use interrupt model to support interrupt controller of Loongson
7A1000 bridge chip.

Co-developed-by: Jianmin Lv <lvjianmin@loongson.cn>
Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/mips/include/asm/mach-loongson64/ioaicu.h | 166 ++++++++++++++
 arch/mips/include/asm/mach-loongson64/irq.h    |   2 +
 arch/mips/loongson64/Makefile                  |   2 +-
 arch/mips/loongson64/ioaicu.c                  | 305 +++++++++++++++++++++++++
 arch/mips/loongson64/irq.c                     |  20 +-
 arch/mips/loongson64/smp.c                     |  11 +-
 6 files changed, 497 insertions(+), 9 deletions(-)
 create mode 100644 arch/mips/include/asm/mach-loongson64/ioaicu.h
 create mode 100644 arch/mips/loongson64/ioaicu.c

diff --git a/arch/mips/include/asm/mach-loongson64/ioaicu.h b/arch/mips/include/asm/mach-loongson64/ioaicu.h
new file mode 100644
index 0000000..e55de0d
--- /dev/null
+++ b/arch/mips/include/asm/mach-loongson64/ioaicu.h
@@ -0,0 +1,166 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020 Loongson Technology Corporation Limited
+ *
+ * Author: Jianmin Lv <lvjianmin@loongson.cn>
+ * Author: Tiezhu Yang <yangtiezhu@loongson.cn>
+ */
+
+#ifndef _ASM_LOONGSON_IOAICU_H
+#define _ASM_LOONGSON_IOAICU_H
+
+#define LS_CFG_BASE	0x3ff00000
+#define LS_CFG_OFF(x)	((void *)TO_UNCAC(LS_CFG_BASE) + (x))
+
+#define LS_IRC_BASE	LS_CFG_OFF(0x1400)
+#define LS_IRC_OFF(x)	(LS_IRC_BASE + x)
+
+#define LS_IRC_ENT(x)	LS_IRC_OFF(x)
+#define LS_IRC_EN	LS_IRC_OFF(0x24)
+#define LS_IRC_ENSET	LS_IRC_OFF(0x28)
+
+#define MAX_IOAICUS		16
+#define LS3A_MAX_IPI_IRQ	26
+#define LS3A_MAX_IO_VECTOR	64
+#define LS3A_MAX_IO_IRQ		256
+
+#define LS7A_PCH_REG_BASE	0x10000000
+#define LS7A_IOAICU_IRQ_BASE	64
+
+#define IOAICU_BASE	0x90000e0000000000ULL
+#define IOAICU_IMR	0x20
+#define IOAICU_IER	0x60
+#define IOAICU_ICR	0x80
+#define IOAICU_IRR	0x100
+#define IOAICU_ISR	0x3a0
+#define IOAICU_IPR	0x3e0
+
+#define USE_HTH_INT0	0x1
+
+#define LS3A_IOIRQ2VECTOR(irq) (irq - LS3A_MAX_IO_VECTOR)
+#define LS3A_VECTOR2IOIRQ(vector) (vector + LS3A_MAX_IO_VECTOR)
+
+struct ioaicu_config {
+	unsigned char aicuid;
+	unsigned char aicuver;
+	unsigned int aicuaddr;
+};
+
+struct ioaicu_gsi {
+	u32 gsi_base;
+	u32 gsi_end;
+};
+
+struct ioaicu {
+	int nr_registers;
+	struct ioaicu_config config;
+	struct ioaicu_gsi gsi_config;
+};
+
+struct loongson_irq_dispatch_ops {
+	void (*irq_dispatch)(void);
+};
+
+extern void setup_ioaicu(void);
+extern struct ioaicu ioaicus[MAX_IOAICUS];
+extern struct loongson_irq_dispatch_ops loongson_pch;
+extern unsigned short ls3a_ipi_pos2irq[LS3A_MAX_IO_VECTOR];
+
+extern void loongson3_send_irq_by_ipi(int cpu, int irqs);
+extern int plat_set_irq_affinity(struct irq_data *d,
+				 const struct cpumask *affinity, bool force);
+
+static inline unsigned long ioaicu_read64(unsigned int aicu, unsigned int reg)
+{
+	unsigned long addr = ioaicus[aicu].config.aicuaddr;
+
+	return *(unsigned long *)(IOAICU_BASE + addr + reg);
+}
+
+static inline void ioaicu_write64(unsigned int aicu,
+				  unsigned int reg, unsigned long value)
+{
+	unsigned long addr = ioaicus[aicu].config.aicuaddr;
+	*(unsigned long *)(IOAICU_BASE + addr + reg) = value;
+}
+
+static inline unsigned char ioaicu_read8(unsigned int aicu, unsigned int reg)
+{
+	unsigned long addr = ioaicus[aicu].config.aicuaddr;
+
+	return *(unsigned char *)(IOAICU_BASE + addr + reg);
+}
+
+static inline void ioaicu_write8(unsigned int aicu,
+				 unsigned int reg, unsigned char value)
+{
+	unsigned long addr = ioaicus[aicu].config.aicuaddr;
+	*(unsigned char *)(IOAICU_BASE + addr + reg) = value;
+}
+
+static inline int ioaicu_get_redir_entries(int ioaicu)
+{
+	return 64;
+}
+
+static inline struct ioaicu_gsi *ioaicu_gsi_routing(int ioaicu_idx)
+{
+	return &ioaicus[ioaicu_idx].gsi_config;
+}
+
+static inline int ioaicu_id(int ioaicu_idx)
+{
+	return ioaicus[ioaicu_idx].config.aicuid;
+}
+
+static inline unsigned int ioaicu_addr(int ioaicu_idx)
+{
+	return ioaicus[ioaicu_idx].config.aicuaddr;
+}
+
+#define ioaicu_ver(ioaicu_idx) ioaicus[ioaicu_idx].config.aicuver
+
+static inline void ls64_conf_write64(u64 val64, void __iomem *addr)
+{
+	asm volatile (
+	"	.set push\n"
+	"	.set noreorder\n"
+	"	sd	%[v], (%[hw])\n"
+	"	lb	$0, (%[hw])\n"
+	"	.set pop\n"
+	:
+	: [hw] "r" (addr),  [v] "r" (val64)
+	);
+}
+
+static inline void ls64_conf_write32(u32 val, void __iomem *addr)
+{
+	asm volatile (
+	"	.set push\n"
+	"	.set noreorder\n"
+	"	sw	%[v], (%[hw])\n"
+	"	lb	$0, (%[hw])\n"
+	"	.set pop\n"
+	:
+	: [hw] "r" (addr), [v] "r" (val)
+	);
+}
+
+static inline void ls64_conf_write8(u8 val, void __iomem *addr)
+{
+	asm volatile (
+	"	.set push\n"
+	"	.set noreorder\n"
+	"	sb	%[v], (%[hw])\n"
+	"	lb	$0, (%[hw])\n"
+	"	.set pop\n"
+	:
+	: [hw] "r" (addr), [v] "r" (val)
+	);
+}
+
+#define ls64_conf_read64(addr) readq(addr)
+#define ls64_conf_read32(addr) readl(addr)
+#define ls64_conf_read8(addr) readb(addr)
+
+#endif /* _ASM_LOONGSON_IOAICU_H */
diff --git a/arch/mips/include/asm/mach-loongson64/irq.h b/arch/mips/include/asm/mach-loongson64/irq.h
index 73a8991..10568be 100644
--- a/arch/mips/include/asm/mach-loongson64/irq.h
+++ b/arch/mips/include/asm/mach-loongson64/irq.h
@@ -4,6 +4,8 @@
 
 #include <boot_param.h>
 
+#define NR_IRQS (64 + 256)
+
 /* cpu core interrupt numbers */
 #define MIPS_CPU_IRQ_BASE 56
 
diff --git a/arch/mips/loongson64/Makefile b/arch/mips/loongson64/Makefile
index 7821891..3db50c6 100644
--- a/arch/mips/loongson64/Makefile
+++ b/arch/mips/loongson64/Makefile
@@ -3,7 +3,7 @@
 # Makefile for Loongson-3 family machines
 #
 obj-$(CONFIG_MACH_LOONGSON64) += irq.o cop2-ex.o platform.o acpi_init.o dma.o \
-				setup.o init.o env.o time.o reset.o \
+				setup.o init.o env.o time.o reset.o ioaicu.o \
 
 obj-$(CONFIG_SMP)	+= smp.o
 obj-$(CONFIG_NUMA)	+= numa.o
diff --git a/arch/mips/loongson64/ioaicu.c b/arch/mips/loongson64/ioaicu.c
new file mode 100644
index 0000000..904ac75
--- /dev/null
+++ b/arch/mips/loongson64/ioaicu.c
@@ -0,0 +1,305 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2020 Loongson Technology Corporation Limited
+ *
+ * Author: Jianmin Lv <lvjianmin@loongson.cn>
+ * Author: Tiezhu Yang <yangtiezhu@loongson.cn>
+ */
+
+#include <loongson.h>
+#include <ioaicu.h>
+
+static DEFINE_SPINLOCK(pch_irq_lock);
+DECLARE_BITMAP(ls3a_ipi_in_use, LS3A_MAX_IPI_IRQ);
+struct loongson_irq_dispatch_ops loongson_pch;
+struct ioaicu ioaicus[MAX_IOAICUS];
+
+unsigned short ls3a_ipi_pos2irq[LS3A_MAX_IO_VECTOR] = {
+					[0 ... LS3A_MAX_IO_VECTOR-1] = -1 };
+unsigned char ls3a_ipi_irq2pos[LS3A_MAX_IO_IRQ] = {
+					[0 ... LS3A_MAX_IO_IRQ-1] = -1 };
+unsigned int cpu_for_irq[LS3A_MAX_IO_IRQ] = {
+					[0 ... LS3A_MAX_IO_IRQ-1] = -1};
+
+u32 gsi_top;
+int nr_ioaicus;
+#define for_each_ioaicu(idx)	\
+	for ((idx) = 0; (idx) < nr_ioaicus; (idx)++)
+#define for_each_pin(idx, pin)	\
+	for ((pin) = 0; (pin) < ioaicus[(idx)].nr_registers; (pin)++)
+
+static int bad_ioaicu(unsigned long address)
+{
+	if (nr_ioaicus >= MAX_IOAICUS) {
+		pr_warn("WARNING: Max # of I/O AICUs (%d) exceeded (found %d), skipping\n",
+			MAX_IOAICUS, nr_ioaicus);
+		return 1;
+	}
+
+	if (!address) {
+		pr_warn("WARNING: Bogus (zero) I/O AICU address found in table, skipping!\n");
+		return 1;
+	}
+
+	return 0;
+}
+
+static void register_ioaicu(int id, u32 address, u32 gsi_base)
+{
+	int idx = 0;
+	int entries;
+	struct ioaicu_gsi *gsi_cfg;
+
+	if (bad_ioaicu(address))
+		return;
+
+	idx = nr_ioaicus;
+	ioaicus[idx].config.aicuaddr = address;
+	ioaicus[idx].config.aicuid = id;
+	ioaicus[idx].config.aicuver = 0;
+
+	entries = ioaicu_get_redir_entries(idx);
+	gsi_cfg = ioaicu_gsi_routing(idx);
+	gsi_cfg->gsi_base = gsi_base;
+	gsi_cfg->gsi_end = gsi_base + entries - 1;
+
+	ioaicus[idx].nr_registers = entries;
+
+	if (gsi_cfg->gsi_end >= gsi_top)
+		gsi_top = gsi_cfg->gsi_end + 1;
+
+	pr_info("IOAICU[%d]: aicu_id %d, version %d, address 0x%x, GSI %d-%d\n",
+		idx, ioaicu_id(idx), ioaicu_ver(idx), ioaicu_addr(idx),
+		gsi_cfg->gsi_base, gsi_cfg->gsi_end);
+
+	nr_ioaicus++;
+}
+
+static int find_ioaicu(u32 gsi)
+{
+	int i;
+
+	if (nr_ioaicus == 0)
+		return -1;
+
+	for_each_ioaicu(i) {
+		struct ioaicu_gsi *gsi_cfg = ioaicu_gsi_routing(i);
+
+		if (gsi >= gsi_cfg->gsi_base && gsi <= gsi_cfg->gsi_end)
+			return i;
+	}
+
+	pr_err("ERROR: Unable to locate IOAICU for GSI %d\n", gsi);
+
+	return -1;
+}
+
+static int pch_create_dirq(unsigned int irq)
+{
+	unsigned long flags;
+	int pos;
+
+	spin_lock_irqsave(&pch_irq_lock, flags);
+again:
+	pos = find_first_zero_bit(ls3a_ipi_in_use, LS3A_MAX_IPI_IRQ);
+	if (pos == LS3A_MAX_IPI_IRQ) {
+		spin_unlock_irqrestore(&pch_irq_lock, flags);
+		return -ENOSPC;
+	}
+
+	if (test_and_set_bit(pos, ls3a_ipi_in_use))
+		goto again;
+
+	ls3a_ipi_pos2irq[pos] = irq;
+	ls3a_ipi_irq2pos[LS3A_IOIRQ2VECTOR(irq)] = pos;
+	spin_unlock_irqrestore(&pch_irq_lock, flags);
+
+	return 0;
+}
+
+static void pch_destroy_dirq(unsigned int irq)
+{
+	unsigned long flags;
+	int pos;
+
+	spin_lock_irqsave(&pch_irq_lock, flags);
+	pos = ls3a_ipi_irq2pos[LS3A_IOIRQ2VECTOR(irq)];
+	if (pos >= 0) {
+		clear_bit(pos, ls3a_ipi_in_use);
+		ls3a_ipi_irq2pos[LS3A_IOIRQ2VECTOR(irq)] = -1;
+		ls3a_ipi_pos2irq[pos] = -1;
+	}
+	spin_unlock_irqrestore(&pch_irq_lock, flags);
+}
+
+static void line_mask_pch_irq(struct irq_data *d)
+{
+	unsigned long flags, data;
+	unsigned int ioaicu;
+	unsigned long irq_nr = d->irq;
+
+	ioaicu = (unsigned int)find_ioaicu((u32)irq_nr);
+
+	spin_lock_irqsave(&pch_irq_lock, flags);
+	data = ioaicu_read64(ioaicu, IOAICU_IMR);
+	data |= (1ULL << LS3A_IOIRQ2VECTOR(irq_nr));
+	ioaicu_write64(ioaicu, IOAICU_IMR, data);
+	spin_unlock_irqrestore(&pch_irq_lock, flags);
+}
+
+static void line_unmask_pch_irq(struct irq_data *d)
+{
+	unsigned long flags, data;
+	unsigned int ioaicu;
+	unsigned long irq_nr = d->irq;
+
+	ioaicu = (unsigned int)find_ioaicu((u32)irq_nr);
+
+	spin_lock_irqsave(&pch_irq_lock, flags);
+	data = ioaicu_read64(ioaicu, IOAICU_IMR);
+	data &= ~(1ULL << LS3A_IOIRQ2VECTOR(irq_nr));
+	ioaicu_write64(ioaicu, IOAICU_IMR, data);
+	spin_unlock_irqrestore(&pch_irq_lock, flags);
+}
+
+static unsigned int line_startup_pch_irq(struct irq_data *d)
+{
+	pch_create_dirq(d->irq);
+	line_unmask_pch_irq(d);
+
+	return 0;
+}
+
+static void line_shutdown_pch_irq(struct irq_data *d)
+{
+	line_mask_pch_irq(d);
+	pch_destroy_dirq(d->irq);
+}
+
+static struct irq_chip ioaicu_line_chip = {
+	.name			= "IOAICU-LINE",
+	.irq_mask		= line_mask_pch_irq,
+	.irq_unmask		= line_unmask_pch_irq,
+	.irq_startup		= line_startup_pch_irq,
+	.irq_shutdown		= line_shutdown_pch_irq,
+	.irq_set_affinity	= plat_set_irq_affinity,
+};
+
+static void line_route_init(void)
+{
+	unsigned int dummy;
+
+	/* route 3A CPU0 INT0 to node0 core0 INT1(IP3) */
+	dummy = LOONGSON_INT_COREx_INTy(loongson_sysconf.boot_cpu_id, 1);
+	ls64_conf_write8(dummy, LS_IRC_ENT(0));
+
+	dummy = ls64_conf_read32(LS_IRC_EN);
+	dummy |= 0x1;
+	ls64_conf_write32(dummy, LS_IRC_ENSET);
+}
+
+static void init_pin_route(unsigned int ioaicu, int vec)
+{
+	ioaicu_write8(ioaicu, IOAICU_IRR + vec, USE_HTH_INT0);
+}
+
+static void init_ioaicu_pin(unsigned int ioaicu, int pin,
+			    struct irq_chip *pirq_chip)
+{
+	init_pin_route(ioaicu, LS3A_IOIRQ2VECTOR(pin));
+	irq_set_chip_and_handler(pin, pirq_chip, handle_level_irq);
+}
+
+static void setup_ioaicu_irqs(struct irq_chip *pirq_chip)
+{
+	unsigned int ioaicu, pin;
+	struct ioaicu_gsi *gsi_cfg;
+
+	for_each_ioaicu(ioaicu) {
+		ioaicu_write64(ioaicu, IOAICU_IER, 0);
+		ioaicu_write64(ioaicu, IOAICU_IPR, (1ULL << 59));
+		ioaicu_write64(ioaicu, IOAICU_ISR, 0);
+		ioaicu_write64(ioaicu, IOAICU_IMR, -1ULL);
+		ioaicu_write64(ioaicu, IOAICU_ICR, -1ULL);
+	}
+
+	for (ioaicu = 0; ioaicu < nr_ioaicus; ioaicu++) {
+		for (pin = 0; pin < ioaicus[ioaicu].nr_registers; pin++) {
+			gsi_cfg = ioaicu_gsi_routing(ioaicu);
+			init_ioaicu_pin(ioaicu,
+					pin + gsi_cfg->gsi_base, pirq_chip);
+		}
+	}
+}
+
+static void handle_irqs(unsigned long long irqs, int i)
+{
+	unsigned int irq;
+	struct irq_data *irqd;
+	struct cpumask affinity;
+	int cpu = smp_processor_id();
+
+	while (irqs) {
+		irq = __ffs(irqs);
+		irqs &= ~(1ULL<<irq);
+		irq += (i << 6);
+
+		/* handled by local core */
+		if (ls3a_ipi_irq2pos[irq] == (unsigned char)-1) {
+			do_IRQ(LS3A_VECTOR2IOIRQ(irq));
+			continue;
+		}
+
+		irqd = irq_get_irq_data(LS3A_VECTOR2IOIRQ(irq));
+		cpumask_and(&affinity, irqd->common->affinity, cpu_active_mask);
+		if (cpumask_empty(&affinity)) {
+			do_IRQ(LS3A_VECTOR2IOIRQ(irq));
+			continue;
+		}
+
+		cpu_for_irq[irq] = cpumask_next(cpu_for_irq[irq], &affinity);
+		if (cpu_for_irq[irq] >= nr_cpu_ids)
+			cpu_for_irq[irq] = cpumask_first(&affinity);
+
+		if (cpu_for_irq[irq] == cpu) {
+			do_IRQ(LS3A_VECTOR2IOIRQ(irq));
+			continue;
+		}
+
+		/* balanced by other cores */
+		loongson3_send_irq_by_ipi(cpu_for_irq[irq],
+					  (0x1 << (ls3a_ipi_irq2pos[irq])));
+	}
+}
+
+static void ioaicu_line_dispatch(void)
+{
+	unsigned long flags;
+	unsigned int ioaicu;
+	unsigned long long intstatus;
+	unsigned long long intmask;
+
+	for_each_ioaicu(ioaicu) {
+		/* read irq status register */
+		intstatus = ioaicu_read64(ioaicu, IOAICU_ISR);
+
+		spin_lock_irqsave(&pch_irq_lock, flags);
+		intmask = ioaicu_read64(ioaicu, IOAICU_IMR);
+		intmask |= intstatus;
+		ioaicu_write64(ioaicu, IOAICU_IMR, intmask);
+		intmask = ioaicu_read64(ioaicu, IOAICU_IMR);
+		spin_unlock_irqrestore(&pch_irq_lock, flags);
+
+		handle_irqs(intstatus, 0);
+	}
+}
+
+/* ioaicu: input/output advanced interrupt control unit */
+void __init setup_ioaicu(void)
+{
+	register_ioaicu(0, LS7A_PCH_REG_BASE, LS7A_IOAICU_IRQ_BASE);
+
+	line_route_init();
+	setup_ioaicu_irqs(&ioaicu_line_chip);
+	loongson_pch.irq_dispatch = ioaicu_line_dispatch;
+}
diff --git a/arch/mips/loongson64/irq.c b/arch/mips/loongson64/irq.c
index 79ad797..988f21f 100644
--- a/arch/mips/loongson64/irq.c
+++ b/arch/mips/loongson64/irq.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <loongson.h>
 #include <irq.h>
+#include <ioaicu.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
 
@@ -71,6 +72,8 @@ static void ht_irqdispatch(void)
 			continue;
 		}
 
+		ls3a_ipi_pos2irq[ht_irq[i]] = ht_irq[i];
+
 		/* balanced by other cores */
 		loongson3_send_irq_by_ipi(irq_cpu[ht_irq[i]], (0x1 << ht_irq[i]));
 	}
@@ -91,7 +94,7 @@ asmlinkage void plat_irq_dispatch(void)
 		loongson3_ipi_interrupt(NULL);
 #endif
 	if (pending & CAUSEF_IP3)
-		ht_irqdispatch();
+		loongson_pch.irq_dispatch();
 	if (pending & CAUSEF_IP2)
 		do_IRQ(LOONGSON_UART_IRQ);
 	if (pending & UNUSED_IPS) {
@@ -137,11 +140,18 @@ void __init arch_init_irq(void)
 
 	clear_c0_status(ST0_IM | ST0_BEV);
 
-	irq_router_init();
 	mips_cpu_irq_init();
-	init_i8259_irqs();
-	chip = irq_get_chip(I8259A_IRQ_BASE);
-	chip->irq_set_affinity = plat_set_irq_affinity;
+
+	if (strstr(eboard->name, "780E")) {
+		irq_router_init();
+		init_i8259_irqs();
+		loongson_pch.irq_dispatch = ht_irqdispatch;
+		chip = irq_get_chip(I8259A_IRQ_BASE);
+		chip->irq_set_affinity = plat_set_irq_affinity;
+	}
+
+	if (strstr(eboard->name, "7A1000"))
+		setup_ioaicu();
 
 	irq_set_chip_and_handler(LOONGSON_UART_IRQ,
 			&loongson_irq_chip, handle_percpu_irq);
diff --git a/arch/mips/loongson64/smp.c b/arch/mips/loongson64/smp.c
index de8e074..0720df7 100644
--- a/arch/mips/loongson64/smp.c
+++ b/arch/mips/loongson64/smp.c
@@ -20,6 +20,7 @@
 #include <loongson.h>
 #include <loongson_regs.h>
 #include <workarounds.h>
+#include <ioaicu.h>
 
 #include "smp.h"
 
@@ -336,10 +337,14 @@ void loongson3_ipi_interrupt(struct pt_regs *regs)
 	}
 
 	if (irqs) {
-		int irq;
+		int irq, irq1;
+
 		while ((irq = ffs(irqs))) {
-			do_IRQ(irq-1);
-			irqs &= ~(1<<(irq-1));
+			irq1 = ls3a_ipi_pos2irq[irq - 1];
+			if (likely(irq1 != (unsigned short)-1)) {
+				do_IRQ(irq1);
+				irqs &= ~(1 << (irq - 1));
+			}
 		}
 	}
 }
-- 
2.1.0

