Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4586069768D
	for <lists+linux-pci@lfdr.de>; Wed, 15 Feb 2023 07:44:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233454AbjBOGom (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Feb 2023 01:44:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233443AbjBOGok (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Feb 2023 01:44:40 -0500
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 230972A154;
        Tue, 14 Feb 2023 22:44:39 -0800 (PST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id CA552200621;
        Wed, 15 Feb 2023 07:44:37 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 9439D200613;
        Wed, 15 Feb 2023 07:44:37 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 9C7F4180C2DA;
        Wed, 15 Feb 2023 14:44:35 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        l.stach@pengutronix.de, shawnguo@kernel.org,
        lorenzo.pieralisi@arm.com, peng.fan@nxp.com, marex@denx.de,
        marcel.ziswiler@toradex.com, tharvey@gateworks.com,
        frank.li@nxp.com
Cc:     hongxing.zhu@nxp.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com
Subject: [RESEND v10 2/4] arm64: dts: Add i.MX8MM PCIe EP support
Date:   Wed, 15 Feb 2023 14:18:33 +0800
Message-Id: <1676441915-1394-3-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1676441915-1394-1-git-send-email-hongxing.zhu@nxp.com>
References: <1676441915-1394-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add i.MX8MM PCIe EP support.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mm.dtsi | 24 +++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index 31f4548f85cf..a9552867e547 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -1315,6 +1315,30 @@ pcie0: pcie@33800000 {
 			status = "disabled";
 		};
 
+		pcie0_ep: pcie-ep@33800000 {
+			compatible = "fsl,imx8mm-pcie-ep";
+			reg = <0x33800000 0x400000>,
+			      <0x18000000 0x8000000>;
+			reg-names = "dbi", "addr_space";
+			num-lanes = <1>;
+			interrupts = <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "dma";
+			fsl,max-link-speed = <2>;
+			clocks = <&clk IMX8MM_CLK_PCIE1_ROOT>,
+				 <&clk IMX8MM_CLK_PCIE1_PHY>,
+				 <&clk IMX8MM_CLK_PCIE1_AUX>;
+			clock-names = "pcie", "pcie_bus", "pcie_aux";
+			power-domains = <&pgc_pcie>;
+			resets = <&src IMX8MQ_RESET_PCIE_CTRL_APPS_EN>,
+				 <&src IMX8MQ_RESET_PCIE_CTRL_APPS_TURNOFF>;
+			reset-names = "apps", "turnoff";
+			phys = <&pcie_phy>;
+			phy-names = "pcie-phy";
+			num-ib-windows = <4>;
+			num-ob-windows = <4>;
+			status = "disabled";
+		};
+
 		gpu_3d: gpu@38000000 {
 			compatible = "vivante,gc";
 			reg = <0x38000000 0x8000>;
-- 
2.34.1

