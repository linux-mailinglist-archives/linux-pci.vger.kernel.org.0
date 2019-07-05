Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74A1F603F2
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jul 2019 12:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbfGEKIQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 5 Jul 2019 06:08:16 -0400
Received: from inva021.nxp.com ([92.121.34.21]:48476 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728369AbfGEKHl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 5 Jul 2019 06:07:41 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id C1108200E78;
        Fri,  5 Jul 2019 12:07:39 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 41FE5200E86;
        Fri,  5 Jul 2019 12:07:31 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 3D63B40305;
        Fri,  5 Jul 2019 18:07:21 +0800 (SGT)
From:   Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
To:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        l.subrahmanya@mobiveil.co.in, shawnguo@kernel.org,
        leoyang.li@nxp.com, lorenzo.pieralisi@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com
Cc:     Mingkai.Hu@nxp.com, Minghuan.Lian@nxp.com, Xiaowei.Bao@nxp.com,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCHv6 23/28] PCI: mobiveil: Add upper 32-bit CPU base address setup in outbound window
Date:   Fri,  5 Jul 2019 17:56:51 +0800
Message-Id: <20190705095656.19191-24-Zhiqiang.Hou@nxp.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20190705095656.19191-1-Zhiqiang.Hou@nxp.com>
References: <20190705095656.19191-1-Zhiqiang.Hou@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The current code only setup the lower 32-bit CPU base address in
outbound window, it will result in outbound transactions drop on
64-bit platforms.

Fixes: 9af6bcb11e12 ("PCI: mobiveil: Add Mobiveil PCIe Host Bridge IP driver")
Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
Reviewed-by: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
---
V6:
 - Splited from #9 of v5 patches, no functional change.

 drivers/pci/controller/pcie-mobiveil.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controller/pcie-mobiveil.c
index 4f50fe6..9382fed 100644
--- a/drivers/pci/controller/pcie-mobiveil.c
+++ b/drivers/pci/controller/pcie-mobiveil.c
@@ -70,6 +70,7 @@
 
 #define PAB_EXT_AXI_AMAP_SIZE(win)	PAB_EXT_REG_ADDR(0xbaf0, win)
 
+#define PAB_EXT_AXI_AMAP_AXI_WIN(win)	PAB_EXT_REG_ADDR(0x80a0, win)
 #define PAB_AXI_AMAP_AXI_WIN(win)	PAB_REG_ADDR(0x0ba4, win)
 #define  AXI_WINDOW_ALIGN_MASK		3
 
@@ -518,8 +519,10 @@ static void program_ob_windows(struct mobiveil_pcie *pcie, int win_num,
 	 * program AXI window base with appropriate value in
 	 * PAB_AXI_AMAP_AXI_WIN0 register
 	 */
-	csr_writel(pcie, cpu_addr & (~AXI_WINDOW_ALIGN_MASK),
+	csr_writel(pcie, lower_32_bits(cpu_addr) & (~AXI_WINDOW_ALIGN_MASK),
 		   PAB_AXI_AMAP_AXI_WIN(win_num));
+	csr_writel(pcie, upper_32_bits(cpu_addr),
+		   PAB_EXT_AXI_AMAP_AXI_WIN(win_num));
 
 	csr_writel(pcie, lower_32_bits(pci_addr),
 		   PAB_AXI_AMAP_PEX_WIN_L(win_num));
-- 
1.7.1

