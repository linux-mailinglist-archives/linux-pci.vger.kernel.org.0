Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07D6676C5A5
	for <lists+linux-pci@lfdr.de>; Wed,  2 Aug 2023 08:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231337AbjHBGuO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Aug 2023 02:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231620AbjHBGta (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Aug 2023 02:49:30 -0400
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C23D2735;
        Tue,  1 Aug 2023 23:49:12 -0700 (PDT)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id DAFF7201A3D;
        Wed,  2 Aug 2023 08:41:14 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id ACB58200E7D;
        Wed,  2 Aug 2023 08:41:14 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 1CDC11820F57;
        Wed,  2 Aug 2023 14:41:13 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     l.stach@pengutronix.de, shawnguo@kernel.org, lpieralisi@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     hongxing.zhu@nxp.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com
Subject: [PATCH 5/9] arm: dts: nxp: Add i.MX6SX PCIe EP support
Date:   Wed,  2 Aug 2023 14:06:47 +0800
Message-Id: <1690956412-2439-6-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1690956412-2439-1-git-send-email-hongxing.zhu@nxp.com>
References: <1690956412-2439-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add i.MX6SX PCIe EP support.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 arch/arm/boot/dts/nxp/imx/imx6sx.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6sx.dtsi b/arch/arm/boot/dts/nxp/imx/imx6sx.dtsi
index 3a4308666552..fc3a73b408d0 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6sx.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6sx.dtsi
@@ -1465,5 +1465,22 @@ pcie: pcie@8ffc000 {
 			power-domain-names = "pcie", "pcie_phy";
 			status = "disabled";
 		};
+
+		pcie_ep: pcie-ep@8ffc000 {
+			compatible = "fsl,imx6sx-pcie-ep";
+			reg = <0x08ffc000 0x04000>, <0x08000000 0xf00000>;
+			reg-names = "dbi", "addr_space";
+			num-lanes = <1>;
+			clocks = <&clks IMX6SX_CLK_PCIE_AXI>,
+				 <&clks IMX6SX_CLK_LVDS1_OUT>,
+				 <&clks IMX6SX_CLK_PCIE_REF_125M>,
+				 <&clks IMX6SX_CLK_DISPLAY_AXI>;
+			clock-names = "pcie", "pcie_bus", "pcie_phy", "pcie_inbound_axi";
+			power-domains = <&pd_disp>, <&pd_pci>;
+			power-domain-names = "pcie", "pcie_phy";
+			num-ib-windows = <4>;
+			num-ob-windows = <4>;
+			status = "disabled";
+		};
 	};
 };
-- 
2.34.1

