Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F80360401
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jul 2019 12:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728583AbfGEKI2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 5 Jul 2019 06:08:28 -0400
Received: from inva021.nxp.com ([92.121.34.21]:48328 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728304AbfGEKHe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 5 Jul 2019 06:07:34 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B2FC1200E90;
        Fri,  5 Jul 2019 12:07:31 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id E725E200E78;
        Fri,  5 Jul 2019 12:07:22 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id E2811402EC;
        Fri,  5 Jul 2019 18:07:12 +0800 (SGT)
From:   Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
To:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        l.subrahmanya@mobiveil.co.in, shawnguo@kernel.org,
        leoyang.li@nxp.com, lorenzo.pieralisi@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com
Cc:     Mingkai.Hu@nxp.com, Minghuan.Lian@nxp.com, Xiaowei.Bao@nxp.com,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCHv6 18/28] PCI: mobiveil: Remove redundant var definitions and register read operations
Date:   Fri,  5 Jul 2019 17:56:46 +0800
Message-Id: <20190705095656.19191-19-Zhiqiang.Hou@nxp.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20190705095656.19191-1-Zhiqiang.Hou@nxp.com>
References: <20190705095656.19191-1-Zhiqiang.Hou@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From the function program_ob_windows(), remove the redundant read
operations to registers PAB_AXI_AMAP_AXI_WIN and PAB_AXI_AMAP_PEX_WIN_H,
and remove the useless definition of 'value'. Rename the parameter
'config_io_bit' to 'type' and then remove the definition of 'type'.
From the function program_ib_windows(), remove the definitions of
'pio_ctrl_val' and 'amap_ctrl_dw' and reduce to only one var 'value'
to keep the temporary value read from registers.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
Reviewed-by: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
---
V6:
 - Splited from #9 of v5 patches, no functional change.

 drivers/pci/controller/pcie-mobiveil.c |   25 ++++++++-----------------
 1 files changed, 8 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controller/pcie-mobiveil.c
index ddc20d3..ccf9bb1 100644
--- a/drivers/pci/controller/pcie-mobiveil.c
+++ b/drivers/pci/controller/pcie-mobiveil.c
@@ -455,8 +455,7 @@ static int mobiveil_pcie_parse_dt(struct mobiveil_pcie *pcie)
 static void program_ib_windows(struct mobiveil_pcie *pcie, int win_num,
 			       int pci_addr, u32 type, u64 size)
 {
-	int pio_ctrl_val;
-	int amap_ctrl_dw;
+	u32 value;
 	u64 size64 = ~(size - 1);
 
 	if ((pcie->ib_wins_configured + 1) > pcie->ppio_wins) {
@@ -465,15 +464,15 @@ static void program_ib_windows(struct mobiveil_pcie *pcie, int win_num,
 		return;
 	}
 
-	pio_ctrl_val = csr_readl(pcie, PAB_PEX_PIO_CTRL);
-	pio_ctrl_val |= 1 << PIO_ENABLE_SHIFT;
-	csr_writel(pcie, pio_ctrl_val, PAB_PEX_PIO_CTRL);
+	value = csr_readl(pcie, PAB_PEX_PIO_CTRL);
+	value |= 1 << PIO_ENABLE_SHIFT;
+	csr_writel(pcie, value, PAB_PEX_PIO_CTRL);
 
-	amap_ctrl_dw = csr_readl(pcie, PAB_PEX_AMAP_CTRL(win_num));
-	amap_ctrl_dw |= (type << AMAP_CTRL_TYPE_SHIFT) |
+	value = csr_readl(pcie, PAB_PEX_AMAP_CTRL(win_num));
+	value |= (type << AMAP_CTRL_TYPE_SHIFT) |
 			(1 << AMAP_CTRL_EN_SHIFT) |
 			lower_32_bits(size64);
-	csr_writel(pcie, amap_ctrl_dw, PAB_PEX_AMAP_CTRL(win_num));
+	csr_writel(pcie, value, PAB_PEX_AMAP_CTRL(win_num));
 
 	csr_writel(pcie, upper_32_bits(size64),
 		   PAB_EXT_PEX_AMAP_SIZEN(win_num));
@@ -488,11 +487,8 @@ static void program_ib_windows(struct mobiveil_pcie *pcie, int win_num,
  * routine to program the outbound windows
  */
 static void program_ob_windows(struct mobiveil_pcie *pcie, int win_num,
-			       u64 cpu_addr, u64 pci_addr,
-			       u32 config_io_bit, u64 size)
+			       u64 cpu_addr, u64 pci_addr, u32 type, u64 size)
 {
-
-	u32 value, type;
 	u64 size64 = ~(size - 1);
 
 	if ((pcie->ob_wins_configured + 1) > pcie->apio_wins) {
@@ -505,8 +501,6 @@ static void program_ob_windows(struct mobiveil_pcie *pcie, int win_num,
 	 * program Enable Bit to 1, Type Bit to (00) base 2, AXI Window Size Bit
 	 * to 4 KB in PAB_AXI_AMAP_CTRL register
 	 */
-	type = config_io_bit;
-	value = csr_readl(pcie, PAB_AXI_AMAP_CTRL(win_num));
 	csr_writel(pcie, 1 << WIN_ENABLE_SHIFT | type << WIN_TYPE_SHIFT |
 		   lower_32_bits(size64), PAB_AXI_AMAP_CTRL(win_num));
 
@@ -516,12 +510,9 @@ static void program_ob_windows(struct mobiveil_pcie *pcie, int win_num,
 	 * program AXI window base with appropriate value in
 	 * PAB_AXI_AMAP_AXI_WIN0 register
 	 */
-	value = csr_readl(pcie, PAB_AXI_AMAP_AXI_WIN(win_num));
 	csr_writel(pcie, cpu_addr & (~AXI_WINDOW_ALIGN_MASK),
 		   PAB_AXI_AMAP_AXI_WIN(win_num));
 
-	value = csr_readl(pcie, PAB_AXI_AMAP_PEX_WIN_H(win_num));
-
 	csr_writel(pcie, lower_32_bits(pci_addr),
 		   PAB_AXI_AMAP_PEX_WIN_L(win_num));
 	csr_writel(pcie, upper_32_bits(pci_addr),
-- 
1.7.1

