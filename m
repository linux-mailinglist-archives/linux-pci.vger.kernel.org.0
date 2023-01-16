Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1C7866B734
	for <lists+linux-pci@lfdr.de>; Mon, 16 Jan 2023 07:06:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbjAPGGV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Jan 2023 01:06:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231886AbjAPGGJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Jan 2023 01:06:09 -0500
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BDDCB442;
        Sun, 15 Jan 2023 22:06:06 -0800 (PST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 01801202076;
        Mon, 16 Jan 2023 07:06:05 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id C7814200E53;
        Mon, 16 Jan 2023 07:06:04 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 0C7CF183ABF3;
        Mon, 16 Jan 2023 14:06:02 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     l.stach@pengutronix.de, bhelgaas@google.com, robh+dt@kernel.org,
        lorenzo.pieralisi@arm.com, shawnguo@kernel.org, kishon@ti.com,
        kw@linux.com, frank.li@nxp.com
Cc:     hongxing.zhu@nxp.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com
Subject: [PATCH v5 08/14] arm64: dts: Add i.MX8MP PCIe EP support
Date:   Mon, 16 Jan 2023 13:41:18 +0800
Message-Id: <1673847684-31893-9-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1673847684-31893-1-git-send-email-hongxing.zhu@nxp.com>
References: <1673847684-31893-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add i.MX8MP PCIe EP support.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 26 +++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index 4ef36ebc6bfe..9ad9edd18e09 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -1217,6 +1217,32 @@ pcie: pcie@33800000 {
 			status = "disabled";
 		};
 
+		pcie_ep: pcie_ep@33800000 {
+			compatible = "fsl,imx8mp-pcie-ep";
+			reg = <0x33800000 0x000400000>, <0x18000000 0x08000000>;
+			reg-names = "regs", "addr_space";
+			clocks = <&clk IMX8MP_CLK_HSIO_ROOT>,
+				 <&clk IMX8MP_CLK_PCIE_ROOT>,
+				 <&clk IMX8MP_CLK_HSIO_AXI>;
+			clock-names = "pcie", "pcie_aux", "pcie_bus";
+			assigned-clocks = <&clk IMX8MP_CLK_PCIE_AUX>;
+			assigned-clock-rates = <10000000>;
+			assigned-clock-parents = <&clk IMX8MP_SYS_PLL2_50M>;
+			num-lanes = <1>;
+			interrupts = <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>; /* eDMA */
+			interrupt-names = "dma";
+			fsl,max-link-speed = <3>;
+			power-domains = <&hsio_blk_ctrl IMX8MP_HSIOBLK_PD_PCIE>;
+			resets = <&src IMX8MP_RESET_PCIE_CTRL_APPS_EN>,
+				 <&src IMX8MP_RESET_PCIE_CTRL_APPS_TURNOFF>;
+			reset-names = "apps", "turnoff";
+			phys = <&pcie_phy>;
+			phy-names = "pcie-phy";
+			num-ib-windows = <4>;
+			num-ob-windows = <4>;
+			status = "disabled";
+		};
+
 		gpu3d: gpu@38000000 {
 			compatible = "vivante,gc";
 			reg = <0x38000000 0x8000>;
-- 
2.25.1

