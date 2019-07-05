Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0997260408
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jul 2019 12:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbfGEKIo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 5 Jul 2019 06:08:44 -0400
Received: from inva021.nxp.com ([92.121.34.21]:48200 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728226AbfGEKH2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 5 Jul 2019 06:07:28 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id AE9D120070A;
        Fri,  5 Jul 2019 12:07:25 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id EEB0A2006F9;
        Fri,  5 Jul 2019 12:07:16 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 85D1E402E1;
        Fri,  5 Jul 2019 18:07:06 +0800 (SGT)
From:   Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
To:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        l.subrahmanya@mobiveil.co.in, shawnguo@kernel.org,
        leoyang.li@nxp.com, lorenzo.pieralisi@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com
Cc:     Mingkai.Hu@nxp.com, Minghuan.Lian@nxp.com, Xiaowei.Bao@nxp.com,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCHv6 14/28] PCI: mobiveil: Make the register updating more readable
Date:   Fri,  5 Jul 2019 17:56:42 +0800
Message-Id: <20190705095656.19191-15-Zhiqiang.Hou@nxp.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20190705095656.19191-1-Zhiqiang.Hou@nxp.com>
References: <20190705095656.19191-1-Zhiqiang.Hou@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

To make the register updating more readable, outstand the fields
to update by changing the register updating sequence to:
a. Read out the original value from the target register.
b. Update the value in one sentence.
c. Program the updated value back to the register.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
---
V6:
 - Splited from #2 of v5 patches, no functional change.

 drivers/pci/controller/pcie-mobiveil.c |   43 ++++++++++++++++++-------------
 1 files changed, 25 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controller/pcie-mobiveil.c
index 0767f19..906299b 100644
--- a/drivers/pci/controller/pcie-mobiveil.c
+++ b/drivers/pci/controller/pcie-mobiveil.c
@@ -299,6 +299,7 @@ static bool mobiveil_pcie_valid_device(struct pci_bus *bus, unsigned int devfn)
 					   unsigned int devfn, int where)
 {
 	struct mobiveil_pcie *pcie = bus->sysdata;
+	u32 value;
 
 	if (!mobiveil_pcie_valid_device(bus, devfn))
 		return NULL;
@@ -313,10 +314,12 @@ static bool mobiveil_pcie_valid_device(struct pci_bus *bus, unsigned int devfn)
 	 * (BDF) in PAB_AXI_AMAP_PEX_WIN_L0 Register.
 	 * Relies on pci_lock serialization
 	 */
-	csr_writel(pcie, bus->number << PAB_BUS_SHIFT |
-		   PCI_SLOT(devfn) << PAB_DEVICE_SHIFT |
-		   PCI_FUNC(devfn) << PAB_FUNCTION_SHIFT,
-		   PAB_AXI_AMAP_PEX_WIN_L(WIN_NUM_0));
+	value = bus->number << PAB_BUS_SHIFT |
+		PCI_SLOT(devfn) << PAB_DEVICE_SHIFT |
+		PCI_FUNC(devfn) << PAB_FUNCTION_SHIFT;
+
+	csr_writel(pcie, value, PAB_AXI_AMAP_PEX_WIN_L(WIN_NUM_0));
+
 	return pcie->config_axi_slave_base + where;
 }
 
@@ -463,19 +466,20 @@ static void program_ib_windows(struct mobiveil_pcie *pcie, int win_num,
 	}
 
 	pio_ctrl_val = csr_readl(pcie, PAB_PEX_PIO_CTRL);
-	csr_writel(pcie, pio_ctrl_val | (1 << PIO_ENABLE_SHIFT),
-		   PAB_PEX_PIO_CTRL);
-	amap_ctrl_dw = csr_readl(pcie, PAB_PEX_AMAP_CTRL(win_num));
-	amap_ctrl_dw = (amap_ctrl_dw | (type << AMAP_CTRL_TYPE_SHIFT));
-	amap_ctrl_dw = (amap_ctrl_dw | (1 << AMAP_CTRL_EN_SHIFT));
+	pio_ctrl_val |= 1 << PIO_ENABLE_SHIFT;
+	csr_writel(pcie, pio_ctrl_val, PAB_PEX_PIO_CTRL);
 
-	csr_writel(pcie, amap_ctrl_dw | lower_32_bits(size64),
-		   PAB_PEX_AMAP_CTRL(win_num));
+	amap_ctrl_dw = csr_readl(pcie, PAB_PEX_AMAP_CTRL(win_num));
+	amap_ctrl_dw |= (type << AMAP_CTRL_TYPE_SHIFT) |
+			(1 << AMAP_CTRL_EN_SHIFT) |
+			lower_32_bits(size64);
+	csr_writel(pcie, amap_ctrl_dw, PAB_PEX_AMAP_CTRL(win_num));
 
 	csr_writel(pcie, upper_32_bits(size64),
 		   PAB_EXT_PEX_AMAP_SIZEN(win_num));
 
 	csr_writel(pcie, pci_addr, PAB_PEX_AMAP_AXI_WIN(win_num));
+
 	csr_writel(pcie, pci_addr, PAB_PEX_AMAP_PEX_WIN_L(win_num));
 	csr_writel(pcie, 0, PAB_PEX_AMAP_PEX_WIN_H(win_num));
 }
@@ -575,16 +579,16 @@ static int mobiveil_host_init(struct mobiveil_pcie *pcie)
 	 * Space
 	 */
 	value = csr_readl(pcie, PCI_COMMAND);
-	csr_writel(pcie, value | PCI_COMMAND_IO | PCI_COMMAND_MEMORY |
-		   PCI_COMMAND_MASTER, PCI_COMMAND);
+	value |= PCI_COMMAND_IO | PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER;
+	csr_writel(pcie, value, PCI_COMMAND);
 
 	/*
 	 * program PIO Enable Bit to 1 (and PEX PIO Enable to 1) in PAB_CTRL
 	 * register
 	 */
 	pab_ctrl = csr_readl(pcie, PAB_CTRL);
-	csr_writel(pcie, pab_ctrl | (1 << AMBA_PIO_ENABLE_SHIFT) |
-		   (1 << PEX_PIO_ENABLE_SHIFT), PAB_CTRL);
+	pab_ctrl |= (1 << AMBA_PIO_ENABLE_SHIFT) | (1 << PEX_PIO_ENABLE_SHIFT);
+	csr_writel(pcie, pab_ctrl, PAB_CTRL);
 
 	csr_writel(pcie, (PAB_INTP_INTX_MASK | PAB_INTP_MSI_MASK),
 		   PAB_INTP_AMBA_MISC_ENB);
@@ -594,7 +598,8 @@ static int mobiveil_host_init(struct mobiveil_pcie *pcie)
 	 * PAB_AXI_PIO_CTRL Register
 	 */
 	value = csr_readl(pcie, PAB_AXI_PIO_CTRL);
-	csr_writel(pcie, value | APIO_EN_MASK, PAB_AXI_PIO_CTRL);
+	value |= APIO_EN_MASK;
+	csr_writel(pcie, value, PAB_AXI_PIO_CTRL);
 
 	/*
 	 * we'll program one outbound window for config reads and
@@ -649,7 +654,8 @@ static void mobiveil_mask_intx_irq(struct irq_data *data)
 	mask = 1 << ((data->hwirq + PAB_INTX_START) - 1);
 	raw_spin_lock_irqsave(&pcie->intx_mask_lock, flags);
 	shifted_val = csr_readl(pcie, PAB_INTP_AMBA_MISC_ENB);
-	csr_writel(pcie, (shifted_val & (~mask)), PAB_INTP_AMBA_MISC_ENB);
+	shifted_val &= ~mask;
+	csr_writel(pcie, shifted_val, PAB_INTP_AMBA_MISC_ENB);
 	raw_spin_unlock_irqrestore(&pcie->intx_mask_lock, flags);
 }
 
@@ -664,7 +670,8 @@ static void mobiveil_unmask_intx_irq(struct irq_data *data)
 	mask = 1 << ((data->hwirq + PAB_INTX_START) - 1);
 	raw_spin_lock_irqsave(&pcie->intx_mask_lock, flags);
 	shifted_val = csr_readl(pcie, PAB_INTP_AMBA_MISC_ENB);
-	csr_writel(pcie, (shifted_val | mask), PAB_INTP_AMBA_MISC_ENB);
+	shifted_val |= mask;
+	csr_writel(pcie, shifted_val, PAB_INTP_AMBA_MISC_ENB);
 	raw_spin_unlock_irqrestore(&pcie->intx_mask_lock, flags);
 }
 
-- 
1.7.1

