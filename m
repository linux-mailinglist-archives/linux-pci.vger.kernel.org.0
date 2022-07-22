Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 788E357E092
	for <lists+linux-pci@lfdr.de>; Fri, 22 Jul 2022 13:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234548AbiGVLIE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Jul 2022 07:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234301AbiGVLIA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Jul 2022 07:08:00 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8C88BA896D;
        Fri, 22 Jul 2022 04:07:59 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.93,185,1654527600"; 
   d="scan'208";a="128784530"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 22 Jul 2022 20:07:57 +0900
Received: from localhost.localdomain (unknown [10.166.15.32])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id B5FB541FF8A7;
        Fri, 22 Jul 2022 20:07:57 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        bhelgaas@google.com, krzk+dt@kernel.org, geert+renesas@glider.be,
        magnus.damm@gmail.com
Cc:     marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v4 07/12] PCI: dwc: Avoid reading a register to detect whether eDMA exists
Date:   Fri, 22 Jul 2022 20:07:39 +0900
Message-Id: <20220722110744.2274466-8-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220722110744.2274466-1-yoshihiro.shimoda.uh@renesas.com>
References: <20220722110744.2274466-1-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Since reading value of PCIE_DMA_VIEWPORT_BASE + PCIE_DMA_CTRL was
0x00000000 on one of SoCs (R-Car S4-8), it cannot find the eDMA.
So, directly read the eDMA register if edma.red_base is not zero.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/pci/controller/dwc/pcie-designware.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index e04128a22bbe..8a274953e25d 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -839,8 +839,7 @@ static int dw_pcie_edma_find_chip(struct dw_pcie *pci)
 {
 	u32 val;
 
-	val = dw_pcie_readl_dbi(pci, PCIE_DMA_VIEWPORT_BASE + PCIE_DMA_CTRL);
-	if (val == 0xFFFFFFFF && pci->edma.reg_base) {
+	if (pci->edma.reg_base) {
 		pci->edma.mf = EDMA_MF_EDMA_UNROLL;
 
 		val = dw_pcie_readl_dma(pci, PCIE_DMA_CTRL);
@@ -848,6 +847,7 @@ static int dw_pcie_edma_find_chip(struct dw_pcie *pci)
 		pci->edma.mf = EDMA_MF_EDMA_LEGACY;
 
 		pci->edma.reg_base = pci->dbi_base + PCIE_DMA_VIEWPORT_BASE;
+		val = dw_pcie_readl_dbi(pci, PCIE_DMA_VIEWPORT_BASE + PCIE_DMA_CTRL);
 	} else {
 		return -ENODEV;
 	}
-- 
2.25.1

