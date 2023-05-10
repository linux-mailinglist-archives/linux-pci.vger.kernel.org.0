Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7F596FD6CD
	for <lists+linux-pci@lfdr.de>; Wed, 10 May 2023 08:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236073AbjEJGWs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 May 2023 02:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235998AbjEJGWn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 May 2023 02:22:43 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E170540F8;
        Tue,  9 May 2023 23:22:40 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.99,263,1677510000"; 
   d="scan'208";a="162314834"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 10 May 2023 15:22:37 +0900
Received: from localhost.localdomain (unknown [10.166.15.32])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 681E7401140C;
        Wed, 10 May 2023 15:22:37 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     jingoohan1@gmail.com, mani@kernel.org,
        gustavo.pimentel@synopsys.com, fancer.lancer@gmail.com,
        lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        bhelgaas@google.com, kishon@kernel.org
Cc:     marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v16 10/22] PCI: dwc: Modify PCIE_PORT_LINK_CONTROL handling
Date:   Wed, 10 May 2023 15:22:22 +0900
Message-Id: <20230510062234.201499-11-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230510062234.201499-1-yoshihiro.shimoda.uh@renesas.com>
References: <20230510062234.201499-1-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

To improve code readability, modify PCIE_PORT_LINK_CONTROL handling.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/pci/controller/dwc/pcie-designware.c | 40 +++++++-------------
 1 file changed, 13 insertions(+), 27 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 68aefbbcd68c..5dc423dd2f21 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -721,28 +721,40 @@ static void dw_pcie_link_set_max_speed(struct dw_pcie *pci, u32 link_gen)
 
 static void dw_pcie_link_set_max_link_width(struct dw_pcie *pci, u32 num_lanes)
 {
-	u32 lwsc;
+	u32 lwsc, plc;
 
 	if (!num_lanes)
 		return;
 
+	/* Set the number of lanes */
+	plc = dw_pcie_readl_dbi(pci, PCIE_PORT_LINK_CONTROL);
+	plc &= ~PORT_LINK_MODE_MASK;
+
 	/* Set link width speed control register */
 	lwsc = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
 	lwsc &= ~PORT_LOGIC_LINK_WIDTH_MASK;
 	switch (num_lanes) {
 	case 1:
+		plc |= PORT_LINK_MODE_1_LANES;
 		lwsc |= PORT_LOGIC_LINK_WIDTH_1_LANES;
 		break;
 	case 2:
+		plc |= PORT_LINK_MODE_2_LANES;
 		lwsc |= PORT_LOGIC_LINK_WIDTH_2_LANES;
 		break;
 	case 4:
+		plc |= PORT_LINK_MODE_4_LANES;
 		lwsc |= PORT_LOGIC_LINK_WIDTH_4_LANES;
 		break;
 	case 8:
+		plc |= PORT_LINK_MODE_8_LANES;
 		lwsc |= PORT_LOGIC_LINK_WIDTH_8_LANES;
 		break;
+	default:
+		dev_err(pci->dev, "num-lanes %u: invalid value\n", num_lanes);
+		return;
 	}
+	dw_pcie_writel_dbi(pci, PCIE_PORT_LINK_CONTROL, plc);
 	dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, lwsc);
 }
 
@@ -1027,31 +1039,5 @@ void dw_pcie_setup(struct dw_pcie *pci)
 	val |= PORT_LINK_DLL_LINK_EN;
 	dw_pcie_writel_dbi(pci, PCIE_PORT_LINK_CONTROL, val);
 
-	if (!pci->num_lanes) {
-		dev_dbg(pci->dev, "Using h/w default number of lanes\n");
-		return;
-	}
-
-	/* Set the number of lanes */
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
 	dw_pcie_link_set_max_link_width(pci, pci->num_lanes);
 }
-- 
2.25.1

