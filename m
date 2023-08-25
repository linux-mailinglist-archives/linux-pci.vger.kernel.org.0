Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6208878839B
	for <lists+linux-pci@lfdr.de>; Fri, 25 Aug 2023 11:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244292AbjHYJcp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Aug 2023 05:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244255AbjHYJc2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Aug 2023 05:32:28 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0CCCE1FC4;
        Fri, 25 Aug 2023 02:32:25 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.02,195,1688396400"; 
   d="scan'208";a="177667242"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 25 Aug 2023 18:32:23 +0900
Received: from localhost.localdomain (unknown [10.166.15.32])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id BDCFA40071FF;
        Fri, 25 Aug 2023 18:32:23 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        manivannan.sadhasivam@linaro.org, bhelgaas@google.com,
        kishon@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     marek.vasut+renesas@gmail.com, fancer.lancer@gmail.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Manivannan Sadhasivam <mani@kernel.org>
Subject: [PATCH v20 06/19] PCI: dwc: Add dw_pcie_link_set_max_link_width()
Date:   Fri, 25 Aug 2023 18:32:06 +0900
Message-Id: <20230825093219.2685912-7-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230825093219.2685912-1-yoshihiro.shimoda.uh@renesas.com>
References: <20230825093219.2685912-1-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch is a preparation before adding the Max-Link-width capability
setup which would in its turn complete the max-link-width setup
procedure defined by Synopsys in the HW-manual. Seeing there is
a max-link-speed setup method defined in the DW PCIe core driver
it would be good to have a similar function for the link width setup.
That's why we need to define a dedicated function first from already
implemented but incomplete link-width setting up code.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>3
---
 drivers/pci/controller/dwc/pcie-designware.c | 86 ++++++++++----------
 1 file changed, 41 insertions(+), 45 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 2d0f816fa0ab..5cca34140d2a 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -728,6 +728,46 @@ static void dw_pcie_link_set_max_speed(struct dw_pcie *pci, u32 link_gen)
 
 }
 
+static void dw_pcie_link_set_max_link_width(struct dw_pcie *pci, u32 num_lanes)
+{
+	u32 lwsc, plc;
+
+	if (!num_lanes)
+		return;
+
+	/* Set the number of lanes */
+	plc = dw_pcie_readl_dbi(pci, PCIE_PORT_LINK_CONTROL);
+	plc &= ~PORT_LINK_FAST_LINK_MODE;
+	plc &= ~PORT_LINK_MODE_MASK;
+
+	/* Set link width speed control register */
+	lwsc = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
+	lwsc &= ~PORT_LOGIC_LINK_WIDTH_MASK;
+	switch (num_lanes) {
+	case 1:
+		plc |= PORT_LINK_MODE_1_LANES;
+		lwsc |= PORT_LOGIC_LINK_WIDTH_1_LANES;
+		break;
+	case 2:
+		plc |= PORT_LINK_MODE_2_LANES;
+		lwsc |= PORT_LOGIC_LINK_WIDTH_2_LANES;
+		break;
+	case 4:
+		plc |= PORT_LINK_MODE_4_LANES;
+		lwsc |= PORT_LOGIC_LINK_WIDTH_4_LANES;
+		break;
+	case 8:
+		plc |= PORT_LINK_MODE_8_LANES;
+		lwsc |= PORT_LOGIC_LINK_WIDTH_8_LANES;
+		break;
+	default:
+		dev_err(pci->dev, "num-lanes %u: invalid value\n", num_lanes);
+		return;
+	}
+	dw_pcie_writel_dbi(pci, PCIE_PORT_LINK_CONTROL, plc);
+	dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, lwsc);
+}
+
 void dw_pcie_iatu_detect(struct dw_pcie *pci)
 {
 	int max_region, ob, ib;
@@ -1009,49 +1049,5 @@ void dw_pcie_setup(struct dw_pcie *pci)
 	val |= PORT_LINK_DLL_LINK_EN;
 	dw_pcie_writel_dbi(pci, PCIE_PORT_LINK_CONTROL, val);
 
-	if (!pci->num_lanes) {
-		dev_dbg(pci->dev, "Using h/w default number of lanes\n");
-		return;
-	}
-
-	/* Set the number of lanes */
-	val &= ~PORT_LINK_FAST_LINK_MODE;
-	val &= ~PORT_LINK_MODE_MASK;
-	switch (pci->num_lanes) {
-	case 1:
-		val |= PORT_LINK_MODE_1_LANES;
-		break;
-	case 2:
-		val |= PORT_LINK_MODE_2_LANES;
-		break;
-	case 4:
-		val |= PORT_LINK_MODE_4_LANES;
-		break;
-	case 8:
-		val |= PORT_LINK_MODE_8_LANES;
-		break;
-	default:
-		dev_err(pci->dev, "num-lanes %u: invalid value\n", pci->num_lanes);
-		return;
-	}
-	dw_pcie_writel_dbi(pci, PCIE_PORT_LINK_CONTROL, val);
-
-	/* Set link width speed control register */
-	val = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
-	val &= ~PORT_LOGIC_LINK_WIDTH_MASK;
-	switch (pci->num_lanes) {
-	case 1:
-		val |= PORT_LOGIC_LINK_WIDTH_1_LANES;
-		break;
-	case 2:
-		val |= PORT_LOGIC_LINK_WIDTH_2_LANES;
-		break;
-	case 4:
-		val |= PORT_LOGIC_LINK_WIDTH_4_LANES;
-		break;
-	case 8:
-		val |= PORT_LOGIC_LINK_WIDTH_8_LANES;
-		break;
-	}
-	dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
+	dw_pcie_link_set_max_link_width(pci, pci->num_lanes);
 }
-- 
2.25.1

