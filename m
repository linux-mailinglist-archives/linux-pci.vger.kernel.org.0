Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1D66603EF
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jul 2019 12:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728529AbfGEKIK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 5 Jul 2019 06:08:10 -0400
Received: from inva021.nxp.com ([92.121.34.21]:48518 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728389AbfGEKHn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 5 Jul 2019 06:07:43 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 5DD3F2006F9;
        Fri,  5 Jul 2019 12:07:41 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D4176200706;
        Fri,  5 Jul 2019 12:07:32 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id CE81D402C0;
        Fri,  5 Jul 2019 18:07:22 +0800 (SGT)
From:   Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
To:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        l.subrahmanya@mobiveil.co.in, shawnguo@kernel.org,
        leoyang.li@nxp.com, lorenzo.pieralisi@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com
Cc:     Mingkai.Hu@nxp.com, Minghuan.Lian@nxp.com, Xiaowei.Bao@nxp.com,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCHv6 24/28] PCI: mobiveil: Add upper 32-bit PCI base address setup in inbound window
Date:   Fri,  5 Jul 2019 17:56:52 +0800
Message-Id: <20190705095656.19191-25-Zhiqiang.Hou@nxp.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20190705095656.19191-1-Zhiqiang.Hou@nxp.com>
References: <20190705095656.19191-1-Zhiqiang.Hou@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The current code only setup the lower 32-bit PCI base address in
inbound window, it can result in inbound transactions drop on
64-bit platforms.

Fixes: 9af6bcb11e12 ("PCI: mobiveil: Add Mobiveil PCIe Host Bridge IP driver")
Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
Reviewed-by: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
---
V6:
 - Splited from #9 of v5 patches, no functional change.

 drivers/pci/controller/pcie-mobiveil.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controller/pcie-mobiveil.c
index 9382fed..75494f0 100644
--- a/drivers/pci/controller/pcie-mobiveil.c
+++ b/drivers/pci/controller/pcie-mobiveil.c
@@ -457,7 +457,7 @@ static int mobiveil_pcie_parse_dt(struct mobiveil_pcie *pcie)
 }
 
 static void program_ib_windows(struct mobiveil_pcie *pcie, int win_num,
-			       int pci_addr, u32 type, u64 size)
+			       u64 pci_addr, u32 type, u64 size)
 {
 	u32 value;
 	u64 size64 = ~(size - 1);
@@ -483,8 +483,11 @@ static void program_ib_windows(struct mobiveil_pcie *pcie, int win_num,
 
 	csr_writel(pcie, pci_addr, PAB_PEX_AMAP_AXI_WIN(win_num));
 
-	csr_writel(pcie, pci_addr, PAB_PEX_AMAP_PEX_WIN_L(win_num));
-	csr_writel(pcie, 0, PAB_PEX_AMAP_PEX_WIN_H(win_num));
+	csr_writel(pcie, lower_32_bits(pci_addr),
+		   PAB_PEX_AMAP_PEX_WIN_L(win_num));
+	csr_writel(pcie, upper_32_bits(pci_addr),
+		   PAB_PEX_AMAP_PEX_WIN_H(win_num));
+
 	pcie->ib_wins_configured++;
 }
 
-- 
1.7.1

