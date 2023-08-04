Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C587F76F7FB
	for <lists+linux-pci@lfdr.de>; Fri,  4 Aug 2023 04:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233753AbjHDCoH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Aug 2023 22:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233716AbjHDCoG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Aug 2023 22:44:06 -0400
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CAF419A7;
        Thu,  3 Aug 2023 19:44:05 -0700 (PDT)
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id DB2371A13C7;
        Fri,  4 Aug 2023 04:44:03 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A10751A13C5;
        Fri,  4 Aug 2023 04:44:03 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 07D1C181D0E5;
        Fri,  4 Aug 2023 10:44:01 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     frank.li@nxp.com, l.stach@pengutronix.de, shawnguo@kernel.org,
        lpieralisi@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     hongxing.zhu@nxp.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com
Subject: [PATCH v2 4/9] arm: dts: nxp: Add i.MX6QDL and i.MX6QP PCIe EP supports
Date:   Fri,  4 Aug 2023 10:09:30 +0800
Message-Id: <1691114975-4750-5-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1691114975-4750-1-git-send-email-hongxing.zhu@nxp.com>
References: <1691114975-4750-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add i.MX6QDL and i.MX6QP PCIe EP supports.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi | 14 ++++++++++++++
 arch/arm/boot/dts/nxp/imx/imx6qp.dtsi  |  4 ++++
 2 files changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi
index bda182edc589..be02f7882c68 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi
@@ -289,6 +289,20 @@ pcie: pcie@1ffc000 {
 			status = "disabled";
 		};
 
+		pcie_ep: pcie-ep@1ffc000 {
+			compatible = "fsl,imx6q-pcie-ep";
+			reg = <0x01ffc000 0x04000>, <0x01000000 0xf00000>;
+			reg-names = "dbi", "addr_space";
+			num-lanes = <1>;
+			clocks = <&clks IMX6QDL_CLK_PCIE_AXI>,
+				 <&clks IMX6QDL_CLK_LVDS1_GATE>,
+				 <&clks IMX6QDL_CLK_PCIE_REF_125M>;
+			clock-names = "pcie", "pcie_bus", "pcie_phy";
+			num-ib-windows = <4>;
+			num-ob-windows = <4>;
+			status = "disabled";
+		};
+
 		aips1: bus@2000000 { /* AIPS1 */
 			compatible = "fsl,aips-bus", "simple-bus";
 			#address-cells = <1>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qp.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qp.dtsi
index fc164991d2ae..4ca53a4c254c 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qp.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qp.dtsi
@@ -118,3 +118,7 @@ &mmdc0 {
 &pcie {
 	compatible = "fsl,imx6qp-pcie";
 };
+
+&pcie_ep {
+	compatible = "fsl,imx6qp-pcie-ep";
+};
-- 
2.34.1

