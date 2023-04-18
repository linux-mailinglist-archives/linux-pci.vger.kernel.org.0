Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53C8B6E617C
	for <lists+linux-pci@lfdr.de>; Tue, 18 Apr 2023 14:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbjDRMZ3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Apr 2023 08:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjDRMZ2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Apr 2023 08:25:28 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AF5469031;
        Tue, 18 Apr 2023 05:25:01 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.99,207,1677510000"; 
   d="scan'208";a="159867443"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 18 Apr 2023 21:24:14 +0900
Received: from localhost.localdomain (unknown [10.166.15.32])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 5F0CE423C459;
        Tue, 18 Apr 2023 21:24:14 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     jingoohan1@gmail.com, mani@kernel.org,
        gustavo.pimentel@synopsys.com, fancer.lancer@gmail.com,
        lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        bhelgaas@google.com, kishon@kernel.org
Cc:     marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v13 11/22] PCI: dwc: Add dw_pcie_link_set_max_width()
Date:   Tue, 18 Apr 2023 21:23:52 +0900
Message-Id: <20230418122403.3178462-12-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230418122403.3178462-1-yoshihiro.shimoda.uh@renesas.com>
References: <20230418122403.3178462-1-yoshihiro.shimoda.uh@renesas.com>
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

To improve code readability, add dw_pcie_link_set_max_width().
The original code writes the PCIE_PORT_LINK_CONTROL register twice
if the pci->num_lanes is not zero. But, it should avoid to write
the register twice. So, refactor it.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/pci/controller/dwc/pcie-designware.c | 65 ++++++++++----------
 1 file changed, 34 insertions(+), 31 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 69358dc202f0..c76fa78c6468 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -737,6 +737,39 @@ static void dw_pcie_link_set_max_speed(struct dw_pcie *pci, u32 link_gen)
 	dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCAP, cap | link_speed);
 }
 
+static void dw_pcie_link_set_max_width(struct dw_pcie *pci, u32 num_lanes)
+{
+	u32 val;
+
+	/* Set the number of lanes */
+	val = dw_pcie_readl_dbi(pci, PCIE_PORT_LINK_CONTROL);
+	val &= ~PORT_LINK_FAST_LINK_MODE;
+	val |= PORT_LINK_DLL_LINK_EN;
+
+	/* Mask LINK_MODE if num_lanes is not zero */
+	if (num_lanes)
+		val &= ~PORT_LINK_MODE_MASK;
+
+	switch (num_lanes) {
+	case 1:
+		val |= PORT_LINK_MODE_1_LANES;
+		break;
+	case 2:
+		val |= PORT_LINK_MODE_2_LANES;
+		break;
+	case 4:
+		val |= PORT_LINK_MODE_4_LANES;
+		break;
+	case 8:
+		val |= PORT_LINK_MODE_8_LANES;
+		break;
+	default:
+		dev_dbg(pci->dev, "Using h/w default number of lanes\n");
+		return;
+	}
+	dw_pcie_writel_dbi(pci, PCIE_PORT_LINK_CONTROL, val);
+}
+
 static void dw_pcie_link_set_max_link_width(struct dw_pcie *pci, u32 num_lanes)
 {
 	u32 val;
@@ -1040,36 +1073,6 @@ void dw_pcie_setup(struct dw_pcie *pci)
 		dw_pcie_writel_dbi(pci, PCIE_PL_CHK_REG_CONTROL_STATUS, val);
 	}
 
-	val = dw_pcie_readl_dbi(pci, PCIE_PORT_LINK_CONTROL);
-	val &= ~PORT_LINK_FAST_LINK_MODE;
-	val |= PORT_LINK_DLL_LINK_EN;
-	dw_pcie_writel_dbi(pci, PCIE_PORT_LINK_CONTROL, val);
-
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
+	dw_pcie_link_set_max_width(pci, pci->num_lanes);
 	dw_pcie_link_set_max_link_width(pci, pci->num_lanes);
 }
-- 
2.25.1

