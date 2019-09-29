Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 912A6C12A9
	for <lists+linux-pci@lfdr.de>; Sun, 29 Sep 2019 03:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728640AbfI2BSo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 28 Sep 2019 21:18:44 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:45984 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728569AbfI2BSo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 28 Sep 2019 21:18:44 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A4ED52E78899C66D0026;
        Sun, 29 Sep 2019 09:18:41 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Sun, 29 Sep 2019 09:18:34 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Minghuan Lian <Minghuan.Lian@nxp.com>,
        Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>,
        Christoph Hellwig <hch@infradead.org>,
        "Andrew Murray" <andrew.murray@arm.com>
Subject: [PATCH v2] PCI: mobiveil: Fix csr_read/write build issue
Date:   Sun, 29 Sep 2019 09:35:05 +0800
Message-ID: <20190929013505.131396-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190927231504.GA13714@infradead.org>
References: <20190927231504.GA13714@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The riscv has csr_read/write macro, see arch/riscv/include/asm/csr.h,
the same function naming will cause build error, using such generic names
in a driver is bad, rename csr_[read,write][l,] to mobiveil_csr_read/write
to fix it.

drivers/pci/controller/pcie-mobiveil.c:238:69: error: macro "csr_read" passed 3 arguments, but takes just 1
 static u32 csr_read(struct mobiveil_pcie *pcie, u32 off, size_t size)

drivers/pci/controller/pcie-mobiveil.c:253:80: error: macro "csr_write" passed 4 arguments, but takes just 2
 static void csr_write(struct mobiveil_pcie *pcie, u32 val, u32 off, size_t size)

Cc: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Minghuan Lian <Minghuan.Lian@nxp.com>
Cc: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Andrew Murray <andrew.murray@arm.com> 
Fixes: bcbe0d9a8d93 ("PCI: mobiveil: Unify register accessors")
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---

v2:
- using mobiveil prefix suggested by Andrew and Christoph 

 drivers/pci/controller/pcie-mobiveil.c | 115 +++++++++++++------------
 1 file changed, 58 insertions(+), 57 deletions(-)

diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controller/pcie-mobiveil.c
index a45a6447b01d..5e6144b0fb95 100644
--- a/drivers/pci/controller/pcie-mobiveil.c
+++ b/drivers/pci/controller/pcie-mobiveil.c
@@ -235,7 +235,7 @@ static int mobiveil_pcie_write(void __iomem *addr, int size, u32 val)
 	return PCIBIOS_SUCCESSFUL;
 }
 
-static u32 csr_read(struct mobiveil_pcie *pcie, u32 off, size_t size)
+static u32 mobiveil_csr_read(struct mobiveil_pcie *pcie, u32 off, size_t size)
 {
 	void *addr;
 	u32 val;
@@ -250,7 +250,8 @@ static u32 csr_read(struct mobiveil_pcie *pcie, u32 off, size_t size)
 	return val;
 }
 
-static void csr_write(struct mobiveil_pcie *pcie, u32 val, u32 off, size_t size)
+static void mobiveil_csr_write(struct mobiveil_pcie *pcie, u32 val, u32 off,
+			       size_t size)
 {
 	void *addr;
 	int ret;
@@ -262,19 +263,19 @@ static void csr_write(struct mobiveil_pcie *pcie, u32 val, u32 off, size_t size)
 		dev_err(&pcie->pdev->dev, "write CSR address failed\n");
 }
 
-static u32 csr_readl(struct mobiveil_pcie *pcie, u32 off)
+static u32 mobiveil_csr_readl(struct mobiveil_pcie *pcie, u32 off)
 {
-	return csr_read(pcie, off, 0x4);
+	return mobiveil_csr_read(pcie, off, 0x4);
 }
 
-static void csr_writel(struct mobiveil_pcie *pcie, u32 val, u32 off)
+static void mobiveil_csr_writel(struct mobiveil_pcie *pcie, u32 val, u32 off)
 {
-	csr_write(pcie, val, off, 0x4);
+	mobiveil_csr_write(pcie, val, off, 0x4);
 }
 
 static bool mobiveil_pcie_link_up(struct mobiveil_pcie *pcie)
 {
-	return (csr_readl(pcie, LTSSM_STATUS) &
+	return (mobiveil_csr_readl(pcie, LTSSM_STATUS) &
 		LTSSM_STATUS_L0_MASK) == LTSSM_STATUS_L0;
 }
 
@@ -323,7 +324,7 @@ static void __iomem *mobiveil_pcie_map_bus(struct pci_bus *bus,
 		PCI_SLOT(devfn) << PAB_DEVICE_SHIFT |
 		PCI_FUNC(devfn) << PAB_FUNCTION_SHIFT;
 
-	csr_writel(pcie, value, PAB_AXI_AMAP_PEX_WIN_L(WIN_NUM_0));
+	mobiveil_csr_writel(pcie, value, PAB_AXI_AMAP_PEX_WIN_L(WIN_NUM_0));
 
 	return pcie->config_axi_slave_base + where;
 }
@@ -353,13 +354,13 @@ static void mobiveil_pcie_isr(struct irq_desc *desc)
 	chained_irq_enter(chip, desc);
 
 	/* read INTx status */
-	val = csr_readl(pcie, PAB_INTP_AMBA_MISC_STAT);
-	mask = csr_readl(pcie, PAB_INTP_AMBA_MISC_ENB);
+	val = mobiveil_csr_readl(pcie, PAB_INTP_AMBA_MISC_STAT);
+	mask = mobiveil_csr_readl(pcie, PAB_INTP_AMBA_MISC_ENB);
 	intr_status = val & mask;
 
 	/* Handle INTx */
 	if (intr_status & PAB_INTP_INTX_MASK) {
-		shifted_status = csr_readl(pcie, PAB_INTP_AMBA_MISC_STAT);
+		shifted_status = mobiveil_csr_readl(pcie, PAB_INTP_AMBA_MISC_STAT);
 		shifted_status &= PAB_INTP_INTX_MASK;
 		shifted_status >>= PAB_INTX_START;
 		do {
@@ -373,12 +374,12 @@ static void mobiveil_pcie_isr(struct irq_desc *desc)
 							    bit);
 
 				/* clear interrupt handled */
-				csr_writel(pcie, 1 << (PAB_INTX_START + bit),
-					   PAB_INTP_AMBA_MISC_STAT);
+				mobiveil_csr_writel(pcie, 1 << (PAB_INTX_START + bit),
+						    PAB_INTP_AMBA_MISC_STAT);
 			}
 
-			shifted_status = csr_readl(pcie,
-						   PAB_INTP_AMBA_MISC_STAT);
+			shifted_status = mobiveil_csr_readl(pcie,
+							    PAB_INTP_AMBA_MISC_STAT);
 			shifted_status &= PAB_INTP_INTX_MASK;
 			shifted_status >>= PAB_INTX_START;
 		} while (shifted_status != 0);
@@ -413,7 +414,7 @@ static void mobiveil_pcie_isr(struct irq_desc *desc)
 	}
 
 	/* Clear the interrupt status */
-	csr_writel(pcie, intr_status, PAB_INTP_AMBA_MISC_STAT);
+	mobiveil_csr_writel(pcie, intr_status, PAB_INTP_AMBA_MISC_STAT);
 	chained_irq_exit(chip, desc);
 }
 
@@ -474,24 +475,24 @@ static void program_ib_windows(struct mobiveil_pcie *pcie, int win_num,
 		return;
 	}
 
-	value = csr_readl(pcie, PAB_PEX_AMAP_CTRL(win_num));
+	value = mobiveil_csr_readl(pcie, PAB_PEX_AMAP_CTRL(win_num));
 	value &= ~(AMAP_CTRL_TYPE_MASK << AMAP_CTRL_TYPE_SHIFT | WIN_SIZE_MASK);
 	value |= type << AMAP_CTRL_TYPE_SHIFT | 1 << AMAP_CTRL_EN_SHIFT |
 		 (lower_32_bits(size64) & WIN_SIZE_MASK);
-	csr_writel(pcie, value, PAB_PEX_AMAP_CTRL(win_num));
+	mobiveil_csr_writel(pcie, value, PAB_PEX_AMAP_CTRL(win_num));
 
-	csr_writel(pcie, upper_32_bits(size64),
-		   PAB_EXT_PEX_AMAP_SIZEN(win_num));
+	mobiveil_csr_writel(pcie, upper_32_bits(size64),
+			    PAB_EXT_PEX_AMAP_SIZEN(win_num));
 
-	csr_writel(pcie, lower_32_bits(cpu_addr),
-		   PAB_PEX_AMAP_AXI_WIN(win_num));
-	csr_writel(pcie, upper_32_bits(cpu_addr),
-		   PAB_EXT_PEX_AMAP_AXI_WIN(win_num));
+	mobiveil_csr_writel(pcie, lower_32_bits(cpu_addr),
+			    PAB_PEX_AMAP_AXI_WIN(win_num));
+	mobiveil_csr_writel(pcie, upper_32_bits(cpu_addr),
+			    PAB_EXT_PEX_AMAP_AXI_WIN(win_num));
 
-	csr_writel(pcie, lower_32_bits(pci_addr),
-		   PAB_PEX_AMAP_PEX_WIN_L(win_num));
-	csr_writel(pcie, upper_32_bits(pci_addr),
-		   PAB_PEX_AMAP_PEX_WIN_H(win_num));
+	mobiveil_csr_writel(pcie, lower_32_bits(pci_addr),
+			    PAB_PEX_AMAP_PEX_WIN_L(win_num));
+	mobiveil_csr_writel(pcie, upper_32_bits(pci_addr),
+			    PAB_PEX_AMAP_PEX_WIN_H(win_num));
 
 	pcie->ib_wins_configured++;
 }
@@ -515,27 +516,27 @@ static void program_ob_windows(struct mobiveil_pcie *pcie, int win_num,
 	 * program Enable Bit to 1, Type Bit to (00) base 2, AXI Window Size Bit
 	 * to 4 KB in PAB_AXI_AMAP_CTRL register
 	 */
-	value = csr_readl(pcie, PAB_AXI_AMAP_CTRL(win_num));
+	value = mobiveil_csr_readl(pcie, PAB_AXI_AMAP_CTRL(win_num));
 	value &= ~(WIN_TYPE_MASK << WIN_TYPE_SHIFT | WIN_SIZE_MASK);
 	value |= 1 << WIN_ENABLE_SHIFT | type << WIN_TYPE_SHIFT |
 		 (lower_32_bits(size64) & WIN_SIZE_MASK);
-	csr_writel(pcie, value, PAB_AXI_AMAP_CTRL(win_num));
+	mobiveil_csr_writel(pcie, value, PAB_AXI_AMAP_CTRL(win_num));
 
-	csr_writel(pcie, upper_32_bits(size64), PAB_EXT_AXI_AMAP_SIZE(win_num));
+	mobiveil_csr_writel(pcie, upper_32_bits(size64), PAB_EXT_AXI_AMAP_SIZE(win_num));
 
 	/*
 	 * program AXI window base with appropriate value in
 	 * PAB_AXI_AMAP_AXI_WIN0 register
 	 */
-	csr_writel(pcie, lower_32_bits(cpu_addr) & (~AXI_WINDOW_ALIGN_MASK),
-		   PAB_AXI_AMAP_AXI_WIN(win_num));
-	csr_writel(pcie, upper_32_bits(cpu_addr),
-		   PAB_EXT_AXI_AMAP_AXI_WIN(win_num));
+	mobiveil_csr_writel(pcie, lower_32_bits(cpu_addr) & (~AXI_WINDOW_ALIGN_MASK),
+			    PAB_AXI_AMAP_AXI_WIN(win_num));
+	mobiveil_csr_writel(pcie, upper_32_bits(cpu_addr),
+			    PAB_EXT_AXI_AMAP_AXI_WIN(win_num));
 
-	csr_writel(pcie, lower_32_bits(pci_addr),
-		   PAB_AXI_AMAP_PEX_WIN_L(win_num));
-	csr_writel(pcie, upper_32_bits(pci_addr),
-		   PAB_AXI_AMAP_PEX_WIN_H(win_num));
+	mobiveil_csr_writel(pcie, lower_32_bits(pci_addr),
+			    PAB_AXI_AMAP_PEX_WIN_L(win_num));
+	mobiveil_csr_writel(pcie, upper_32_bits(pci_addr),
+			    PAB_AXI_AMAP_PEX_WIN_H(win_num));
 
 	pcie->ob_wins_configured++;
 }
@@ -579,42 +580,42 @@ static int mobiveil_host_init(struct mobiveil_pcie *pcie)
 	struct resource_entry *win;
 
 	/* setup bus numbers */
-	value = csr_readl(pcie, PCI_PRIMARY_BUS);
+	value = mobiveil_csr_readl(pcie, PCI_PRIMARY_BUS);
 	value &= 0xff000000;
 	value |= 0x00ff0100;
-	csr_writel(pcie, value, PCI_PRIMARY_BUS);
+	mobiveil_csr_writel(pcie, value, PCI_PRIMARY_BUS);
 
 	/*
 	 * program Bus Master Enable Bit in Command Register in PAB Config
 	 * Space
 	 */
-	value = csr_readl(pcie, PCI_COMMAND);
+	value = mobiveil_csr_readl(pcie, PCI_COMMAND);
 	value |= PCI_COMMAND_IO | PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER;
-	csr_writel(pcie, value, PCI_COMMAND);
+	mobiveil_csr_writel(pcie, value, PCI_COMMAND);
 
 	/*
 	 * program PIO Enable Bit to 1 (and PEX PIO Enable to 1) in PAB_CTRL
 	 * register
 	 */
-	pab_ctrl = csr_readl(pcie, PAB_CTRL);
+	pab_ctrl = mobiveil_csr_readl(pcie, PAB_CTRL);
 	pab_ctrl |= (1 << AMBA_PIO_ENABLE_SHIFT) | (1 << PEX_PIO_ENABLE_SHIFT);
-	csr_writel(pcie, pab_ctrl, PAB_CTRL);
+	mobiveil_csr_writel(pcie, pab_ctrl, PAB_CTRL);
 
-	csr_writel(pcie, (PAB_INTP_INTX_MASK | PAB_INTP_MSI_MASK),
-		   PAB_INTP_AMBA_MISC_ENB);
+	mobiveil_csr_writel(pcie, (PAB_INTP_INTX_MASK | PAB_INTP_MSI_MASK),
+			    PAB_INTP_AMBA_MISC_ENB);
 
 	/*
 	 * program PIO Enable Bit to 1 and Config Window Enable Bit to 1 in
 	 * PAB_AXI_PIO_CTRL Register
 	 */
-	value = csr_readl(pcie, PAB_AXI_PIO_CTRL);
+	value = mobiveil_csr_readl(pcie, PAB_AXI_PIO_CTRL);
 	value |= APIO_EN_MASK;
-	csr_writel(pcie, value, PAB_AXI_PIO_CTRL);
+	mobiveil_csr_writel(pcie, value, PAB_AXI_PIO_CTRL);
 
 	/* Enable PCIe PIO master */
-	value = csr_readl(pcie, PAB_PEX_PIO_CTRL);
+	value = mobiveil_csr_readl(pcie, PAB_PEX_PIO_CTRL);
 	value |= 1 << PIO_ENABLE_SHIFT;
-	csr_writel(pcie, value, PAB_PEX_PIO_CTRL);
+	mobiveil_csr_writel(pcie, value, PAB_PEX_PIO_CTRL);
 
 	/*
 	 * we'll program one outbound window for config reads and
@@ -647,10 +648,10 @@ static int mobiveil_host_init(struct mobiveil_pcie *pcie)
 	}
 
 	/* fixup for PCIe class register */
-	value = csr_readl(pcie, PAB_INTP_AXI_PIO_CLASS);
+	value = mobiveil_csr_readl(pcie, PAB_INTP_AXI_PIO_CLASS);
 	value &= 0xff;
 	value |= (PCI_CLASS_BRIDGE_PCI << 16);
-	csr_writel(pcie, value, PAB_INTP_AXI_PIO_CLASS);
+	mobiveil_csr_writel(pcie, value, PAB_INTP_AXI_PIO_CLASS);
 
 	/* setup MSI hardware registers */
 	mobiveil_pcie_enable_msi(pcie);
@@ -668,9 +669,9 @@ static void mobiveil_mask_intx_irq(struct irq_data *data)
 	pcie = irq_desc_get_chip_data(desc);
 	mask = 1 << ((data->hwirq + PAB_INTX_START) - 1);
 	raw_spin_lock_irqsave(&pcie->intx_mask_lock, flags);
-	shifted_val = csr_readl(pcie, PAB_INTP_AMBA_MISC_ENB);
+	shifted_val = mobiveil_csr_readl(pcie, PAB_INTP_AMBA_MISC_ENB);
 	shifted_val &= ~mask;
-	csr_writel(pcie, shifted_val, PAB_INTP_AMBA_MISC_ENB);
+	mobiveil_csr_writel(pcie, shifted_val, PAB_INTP_AMBA_MISC_ENB);
 	raw_spin_unlock_irqrestore(&pcie->intx_mask_lock, flags);
 }
 
@@ -684,9 +685,9 @@ static void mobiveil_unmask_intx_irq(struct irq_data *data)
 	pcie = irq_desc_get_chip_data(desc);
 	mask = 1 << ((data->hwirq + PAB_INTX_START) - 1);
 	raw_spin_lock_irqsave(&pcie->intx_mask_lock, flags);
-	shifted_val = csr_readl(pcie, PAB_INTP_AMBA_MISC_ENB);
+	shifted_val = mobiveil_csr_readl(pcie, PAB_INTP_AMBA_MISC_ENB);
 	shifted_val |= mask;
-	csr_writel(pcie, shifted_val, PAB_INTP_AMBA_MISC_ENB);
+	mobiveil_csr_writel(pcie, shifted_val, PAB_INTP_AMBA_MISC_ENB);
 	raw_spin_unlock_irqrestore(&pcie->intx_mask_lock, flags);
 }
 
-- 
2.20.1

