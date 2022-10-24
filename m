Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 257B2609A2C
	for <lists+linux-pci@lfdr.de>; Mon, 24 Oct 2022 08:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbiJXGDg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Oct 2022 02:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbiJXGDf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Oct 2022 02:03:35 -0400
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C8C5AC48;
        Sun, 23 Oct 2022 23:03:34 -0700 (PDT)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id A2CDD217410;
        Mon, 24 Oct 2022 08:03:32 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 6AA9E21740F;
        Mon, 24 Oct 2022 08:03:32 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 91BFA180226C;
        Mon, 24 Oct 2022 14:03:30 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     l.stach@pengutronix.de, marex@denx.de, tharvey@gateworks.com,
        vkoul@kernel.org, bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        shawnguo@kernel.org, alexander.stein@ew.tq-group.com,
        richard.leitner@linux.dev
Cc:     devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-imx@nxp.com,
        Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v1] soc: imx: imx8mp-blk-ctrl: Add PCIe SYSPLL configurations
Date:   Mon, 24 Oct 2022 13:43:09 +0800
Message-Id: <1666590189-1364-1-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add PCIe SYSPLL configurations, thus the internal SYSPLL can be used as
i.MX8MP PCIe reference clock.

The following properties of PHY dts node should be changed accordingly.
  - Set 'fsl,refclk-pad-mode' as '<IMX8_PCIE_REFCLK_PAD_OUTPUT>'.
  - Change 'clocks' to '<&clk IMX8MP_CLK_HSIO_ROOT>'.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
Base on 6.1-rc1, and the following PHY changes [1],
the PCIe works fine when SYSPLL is used as reference clock on i.MX8MP
EVK board(schematic-46370) after removing R131/R132/R137/R138, and
populating R135/R136.

[1] https://patchwork.kernel.org/project/linux-pci/cover/1665625622-20551-1-git-send-email-hongxing.zhu@nxp.com/
---
 drivers/soc/imx/imx8mp-blk-ctrl.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/soc/imx/imx8mp-blk-ctrl.c b/drivers/soc/imx/imx8mp-blk-ctrl.c
index 0e3b6ba22f94..5ad20a8ea25e 100644
--- a/drivers/soc/imx/imx8mp-blk-ctrl.c
+++ b/drivers/soc/imx/imx8mp-blk-ctrl.c
@@ -21,6 +21,16 @@
 #define  USB_CLOCK_MODULE_EN	BIT(1)
 #define  PCIE_PHY_APB_RST	BIT(4)
 #define  PCIE_PHY_INIT_RST	BIT(5)
+#define GPR_REG2		0x8
+#define  P_PLL_MASK		GENMASK(5, 0)
+#define  M_PLL_MASK		GENMASK(15, 6)
+#define  S_PLL_MASK		GENMASK(18, 16)
+#define  P_PLL			(0xc << 0)
+#define  M_PLL			(0x320 << 6)
+#define  S_PLL			(0x4 << 16)
+#define GPR_REG3		0xc
+#define  PLL_CKE		BIT(17)
+#define  PLL_RST		BIT(31)
 
 struct imx8mp_blk_ctrl_domain;
 
@@ -86,6 +96,18 @@ static void imx8mp_hsio_blk_ctrl_power_on(struct imx8mp_blk_ctrl *bc,
 	case IMX8MP_HSIOBLK_PD_PCIE_PHY:
 		regmap_set_bits(bc->regmap, GPR_REG0,
 				PCIE_PHY_APB_RST | PCIE_PHY_INIT_RST);
+
+		/* Set the PLL configurations, P = 12, M = 800, S = 4. */
+		regmap_update_bits(bc->regmap, GPR_REG2,
+				   P_PLL_MASK | M_PLL_MASK | S_PLL_MASK,
+				   P_PLL | M_PLL | S_PLL);
+		udelay(1);
+
+		regmap_update_bits(bc->regmap, GPR_REG3, PLL_RST, PLL_RST);
+		udelay(10);
+
+		/* Set 1b'1 to pll_cke of GPR_REG3 */
+		regmap_update_bits(bc->regmap, GPR_REG3, PLL_CKE, PLL_CKE);
 		break;
 	default:
 		break;
-- 
2.25.1

