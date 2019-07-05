Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9147603C9
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jul 2019 12:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727565AbfGEKHI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 5 Jul 2019 06:07:08 -0400
Received: from inva020.nxp.com ([92.121.34.13]:60670 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727275AbfGEKHI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 5 Jul 2019 06:07:08 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 093B01A0772;
        Fri,  5 Jul 2019 12:07:05 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 44FA91A077A;
        Fri,  5 Jul 2019 12:06:56 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id A8FBD402E1;
        Fri,  5 Jul 2019 18:06:45 +0800 (SGT)
From:   Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
To:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        l.subrahmanya@mobiveil.co.in, shawnguo@kernel.org,
        leoyang.li@nxp.com, lorenzo.pieralisi@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com
Cc:     Mingkai.Hu@nxp.com, Minghuan.Lian@nxp.com, Xiaowei.Bao@nxp.com,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCHv6 01/28] PCI: mobiveil: Unify register accessors
Date:   Fri,  5 Jul 2019 17:56:29 +0800
Message-Id: <20190705095656.19191-2-Zhiqiang.Hou@nxp.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20190705095656.19191-1-Zhiqiang.Hou@nxp.com>
References: <20190705095656.19191-1-Zhiqiang.Hou@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

It is confusing to have two sets of functions to read/write
registers, some with csr_readl()/csr_writel(), while others with
read_paged_register()/write_paged_register().

In the register space the lower 3KB of 4KB PCIe configure space can be
accessed directly and higher 1KB through a simple paging mechanism.

Unify the register accessors in csr_readl() and csr_writel() by
comparing the register offset with page access boundary 3KB in the
accessor internal so that the paging mechanism is hidden behind
the csr_read()/write() common function calls.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
Reviewed-by: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
---
V6:
 - No change.

 drivers/pci/controller/pcie-mobiveil.c |  179 ++++++++++++++++++++++----------
 1 files changed, 124 insertions(+), 55 deletions(-)

diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controller/pcie-mobiveil.c
index 77052a0..d55c7e7 100644
--- a/drivers/pci/controller/pcie-mobiveil.c
+++ b/drivers/pci/controller/pcie-mobiveil.c
@@ -47,7 +47,6 @@
 #define  PAGE_SEL_SHIFT	13
 #define  PAGE_SEL_MASK		0x3f
 #define  PAGE_LO_MASK		0x3ff
-#define  PAGE_SEL_EN		0xc00
 #define  PAGE_SEL_OFFSET_SHIFT	10
 
 #define PAB_AXI_PIO_CTRL	0x0840
@@ -117,6 +116,12 @@
 #define LINK_WAIT_MIN	90000
 #define LINK_WAIT_MAX	100000
 
+#define PAGED_ADDR_BNDRY			0xc00
+#define OFFSET_TO_PAGE_ADDR(off)		\
+	((off & PAGE_LO_MASK) | PAGED_ADDR_BNDRY)
+#define OFFSET_TO_PAGE_IDX(off)			\
+	((off >> PAGE_SEL_OFFSET_SHIFT) & PAGE_SEL_MASK)
+
 struct mobiveil_msi {			/* MSI information */
 	struct mutex lock;		/* protect bitmap variable */
 	struct irq_domain *msi_domain;
@@ -145,15 +150,119 @@ struct mobiveil_pcie {
 	struct mobiveil_msi msi;
 };
 
-static inline void csr_writel(struct mobiveil_pcie *pcie, const u32 value,
-		const u32 reg)
+/*
+ * mobiveil_pcie_sel_page - routine to access paged register
+ *
+ * Registers whose address greater than PAGED_ADDR_BNDRY (0xc00) are paged,
+ * for this scheme to work extracted higher 6 bits of the offset will be
+ * written to pg_sel field of PAB_CTRL register and rest of the lower 10
+ * bits enabled with PAGED_ADDR_BNDRY are used as offset of the register.
+ */
+static void mobiveil_pcie_sel_page(struct mobiveil_pcie *pcie, u8 pg_idx)
 {
-	writel_relaxed(value, pcie->csr_axi_slave_base + reg);
+	u32 val;
+
+	val = readl(pcie->csr_axi_slave_base + PAB_CTRL);
+	val &= ~(PAGE_SEL_MASK << PAGE_SEL_SHIFT);
+	val |= (pg_idx & PAGE_SEL_MASK) << PAGE_SEL_SHIFT;
+
+	writel(val, pcie->csr_axi_slave_base + PAB_CTRL);
 }
 
-static inline u32 csr_readl(struct mobiveil_pcie *pcie, const u32 reg)
+static void *mobiveil_pcie_comp_addr(struct mobiveil_pcie *pcie, u32 off)
 {
-	return readl_relaxed(pcie->csr_axi_slave_base + reg);
+	if (off < PAGED_ADDR_BNDRY) {
+		/* For directly accessed registers, clear the pg_sel field */
+		mobiveil_pcie_sel_page(pcie, 0);
+		return pcie->csr_axi_slave_base + off;
+	}
+
+	mobiveil_pcie_sel_page(pcie, OFFSET_TO_PAGE_IDX(off));
+	return pcie->csr_axi_slave_base + OFFSET_TO_PAGE_ADDR(off);
+}
+
+static int mobiveil_pcie_read(void __iomem *addr, int size, u32 *val)
+{
+	if ((uintptr_t)addr & (size - 1)) {
+		*val = 0;
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+	}
+
+	switch (size) {
+	case 4:
+		*val = readl(addr);
+		break;
+	case 2:
+		*val = readw(addr);
+		break;
+	case 1:
+		*val = readb(addr);
+		break;
+	default:
+		*val = 0;
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+	}
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static int mobiveil_pcie_write(void __iomem *addr, int size, u32 val)
+{
+	if ((uintptr_t)addr & (size - 1))
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+
+	switch (size) {
+	case 4:
+		writel(val, addr);
+		break;
+	case 2:
+		writew(val, addr);
+		break;
+	case 1:
+		writeb(val, addr);
+		break;
+	default:
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+	}
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static u32 csr_read(struct mobiveil_pcie *pcie, u32 off, size_t size)
+{
+	void *addr;
+	u32 val;
+	int ret;
+
+	addr = mobiveil_pcie_comp_addr(pcie, off);
+
+	ret = mobiveil_pcie_read(addr, size, &val);
+	if (ret)
+		dev_err(&pcie->pdev->dev, "read CSR address failed\n");
+
+	return val;
+}
+
+static void csr_write(struct mobiveil_pcie *pcie, u32 val, u32 off, size_t size)
+{
+	void *addr;
+	int ret;
+
+	addr = mobiveil_pcie_comp_addr(pcie, off);
+
+	ret = mobiveil_pcie_write(addr, size, val);
+	if (ret)
+		dev_err(&pcie->pdev->dev, "write CSR address failed\n");
+}
+
+static u32 csr_readl(struct mobiveil_pcie *pcie, u32 off)
+{
+	return csr_read(pcie, off, 0x4);
+}
+
+static void csr_writel(struct mobiveil_pcie *pcie, u32 val, u32 off)
+{
+	csr_write(pcie, val, off, 0x4);
 }
 
 static bool mobiveil_pcie_link_up(struct mobiveil_pcie *pcie)
@@ -342,45 +451,6 @@ static int mobiveil_pcie_parse_dt(struct mobiveil_pcie *pcie)
 	return 0;
 }
 
-/*
- * select_paged_register - routine to access paged register of root complex
- *
- * registers of RC are paged, for this scheme to work
- * extracted higher 6 bits of the offset will be written to pg_sel
- * field of PAB_CTRL register and rest of the lower 10 bits enabled with
- * PAGE_SEL_EN are used as offset of the register.
- */
-static void select_paged_register(struct mobiveil_pcie *pcie, u32 offset)
-{
-	int pab_ctrl_dw, pg_sel;
-
-	/* clear pg_sel field */
-	pab_ctrl_dw = csr_readl(pcie, PAB_CTRL);
-	pab_ctrl_dw = (pab_ctrl_dw & ~(PAGE_SEL_MASK << PAGE_SEL_SHIFT));
-
-	/* set pg_sel field */
-	pg_sel = (offset >> PAGE_SEL_OFFSET_SHIFT) & PAGE_SEL_MASK;
-	pab_ctrl_dw |= ((pg_sel << PAGE_SEL_SHIFT));
-	csr_writel(pcie, pab_ctrl_dw, PAB_CTRL);
-}
-
-static void write_paged_register(struct mobiveil_pcie *pcie,
-		u32 val, u32 offset)
-{
-	u32 off = (offset & PAGE_LO_MASK) | PAGE_SEL_EN;
-
-	select_paged_register(pcie, offset);
-	csr_writel(pcie, val, off);
-}
-
-static u32 read_paged_register(struct mobiveil_pcie *pcie, u32 offset)
-{
-	u32 off = (offset & PAGE_LO_MASK) | PAGE_SEL_EN;
-
-	select_paged_register(pcie, offset);
-	return csr_readl(pcie, off);
-}
-
 static void program_ib_windows(struct mobiveil_pcie *pcie, int win_num,
 		int pci_addr, u32 type, u64 size)
 {
@@ -397,19 +467,19 @@ static void program_ib_windows(struct mobiveil_pcie *pcie, int win_num,
 	pio_ctrl_val = csr_readl(pcie, PAB_PEX_PIO_CTRL);
 	csr_writel(pcie,
 		pio_ctrl_val | (1 << PIO_ENABLE_SHIFT), PAB_PEX_PIO_CTRL);
-	amap_ctrl_dw = read_paged_register(pcie, PAB_PEX_AMAP_CTRL(win_num));
+	amap_ctrl_dw = csr_readl(pcie, PAB_PEX_AMAP_CTRL(win_num));
 	amap_ctrl_dw = (amap_ctrl_dw | (type << AMAP_CTRL_TYPE_SHIFT));
 	amap_ctrl_dw = (amap_ctrl_dw | (1 << AMAP_CTRL_EN_SHIFT));
 
-	write_paged_register(pcie, amap_ctrl_dw | lower_32_bits(size64),
-				PAB_PEX_AMAP_CTRL(win_num));
+	csr_writel(pcie, amap_ctrl_dw | lower_32_bits(size64),
+		   PAB_PEX_AMAP_CTRL(win_num));
 
-	write_paged_register(pcie, upper_32_bits(size64),
-				PAB_EXT_PEX_AMAP_SIZEN(win_num));
+	csr_writel(pcie, upper_32_bits(size64),
+		   PAB_EXT_PEX_AMAP_SIZEN(win_num));
 
-	write_paged_register(pcie, pci_addr, PAB_PEX_AMAP_AXI_WIN(win_num));
-	write_paged_register(pcie, pci_addr, PAB_PEX_AMAP_PEX_WIN_L(win_num));
-	write_paged_register(pcie, 0, PAB_PEX_AMAP_PEX_WIN_H(win_num));
+	csr_writel(pcie, pci_addr, PAB_PEX_AMAP_AXI_WIN(win_num));
+	csr_writel(pcie, pci_addr, PAB_PEX_AMAP_PEX_WIN_L(win_num));
+	csr_writel(pcie, 0, PAB_PEX_AMAP_PEX_WIN_H(win_num));
 }
 
 /*
@@ -437,8 +507,7 @@ static void program_ob_windows(struct mobiveil_pcie *pcie, int win_num,
 	csr_writel(pcie, 1 << WIN_ENABLE_SHIFT | type << WIN_TYPE_SHIFT |
 			lower_32_bits(size64), PAB_AXI_AMAP_CTRL(win_num));
 
-	write_paged_register(pcie, upper_32_bits(size64),
-				PAB_EXT_AXI_AMAP_SIZE(win_num));
+	csr_writel(pcie, upper_32_bits(size64), PAB_EXT_AXI_AMAP_SIZE(win_num));
 
 	/*
 	 * program AXI window base with appropriate value in
-- 
1.7.1

