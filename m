Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4DD5F9A9B
	for <lists+linux-pci@lfdr.de>; Mon, 10 Oct 2022 10:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231682AbiJJIF6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 Oct 2022 04:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231555AbiJJIF4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 Oct 2022 04:05:56 -0400
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FCB330F6D;
        Mon, 10 Oct 2022 01:05:56 -0700 (PDT)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D936321DE44;
        Mon, 10 Oct 2022 10:05:54 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 99BA521DE3F;
        Mon, 10 Oct 2022 10:05:54 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 961B41820F5B;
        Mon, 10 Oct 2022 16:05:52 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     vkoul@kernel.org, a.fatoum@pengutronix.de, p.zabel@pengutronix.de,
        l.stach@pengutronix.de, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, robh@kernel.org, shawnguo@kernel.org,
        alexander.stein@ew.tq-group.com, marex@denx.de,
        richard.leitner@linux.dev
Cc:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com, Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v12 2/4] phy: freescale: imx8m-pcie: Refine register definitions
Date:   Mon, 10 Oct 2022 15:46:09 +0800
Message-Id: <1665387971-17114-3-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1665387971-17114-1-git-send-email-hongxing.zhu@nxp.com>
References: <1665387971-17114-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

No function changes, refine PHY register definitions.
- Keep align with other CMN PHY registers, refine the definitions of
  PHY_CMN_REG75.
- Remove two BIT definitions that are not used at all.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Tested-by: Marek Vasut <marex@denx.de>
Tested-by: Richard Leitner <richard.leitner@skidata.com>
Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/phy/freescale/phy-fsl-imx8m-pcie.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/phy/freescale/phy-fsl-imx8m-pcie.c b/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
index ad7d2edfc414..2377ed307b53 100644
--- a/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
+++ b/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
@@ -31,12 +31,10 @@
 #define IMX8MM_PCIE_PHY_CMN_REG065	0x194
 #define  ANA_AUX_RX_TERM		(BIT(7) | BIT(4))
 #define  ANA_AUX_TX_LVL			GENMASK(3, 0)
-#define IMX8MM_PCIE_PHY_CMN_REG75	0x1D4
-#define  PCIE_PHY_CMN_REG75_PLL_DONE	0x3
+#define IMX8MM_PCIE_PHY_CMN_REG075	0x1D4
+#define  ANA_PLL_DONE			0x3
 #define PCIE_PHY_TRSV_REG5		0x414
-#define  PCIE_PHY_TRSV_REG5_GEN1_DEEMP	0x2D
 #define PCIE_PHY_TRSV_REG6		0x418
-#define  PCIE_PHY_TRSV_REG6_GEN2_DEEMP	0xF
 
 #define IMX8MM_GPR_PCIE_REF_CLK_SEL	GENMASK(25, 24)
 #define IMX8MM_GPR_PCIE_REF_CLK_PLL	FIELD_PREP(IMX8MM_GPR_PCIE_REF_CLK_SEL, 0x3)
@@ -131,9 +129,8 @@ static int imx8_pcie_phy_init(struct phy *phy)
 	reset_control_deassert(imx8_phy->reset);
 
 	/* Polling to check the phy is ready or not. */
-	ret = readl_poll_timeout(imx8_phy->base + IMX8MM_PCIE_PHY_CMN_REG75,
-				 val, val == PCIE_PHY_CMN_REG75_PLL_DONE,
-				 10, 20000);
+	ret = readl_poll_timeout(imx8_phy->base + IMX8MM_PCIE_PHY_CMN_REG075,
+				 val, val == ANA_PLL_DONE, 10, 20000);
 	return ret;
 }
 
-- 
2.25.1

