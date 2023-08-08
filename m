Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4954F77491D
	for <lists+linux-pci@lfdr.de>; Tue,  8 Aug 2023 21:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234234AbjHHTsq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Aug 2023 15:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234803AbjHHTsf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Aug 2023 15:48:35 -0400
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E8724DEB7;
        Tue,  8 Aug 2023 09:53:06 -0700 (PDT)
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id BC76D1A11CE;
        Tue,  8 Aug 2023 08:08:59 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 825CA1A11C8;
        Tue,  8 Aug 2023 08:08:59 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id D35B51800319;
        Tue,  8 Aug 2023 14:08:57 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     frank.li@nxp.com, l.stach@pengutronix.de, shawnguo@kernel.org,
        lpieralisi@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     hongxing.zhu@nxp.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com
Subject: [PATCH v3 5/9] arm: dts: nxp: Add i.MX6SX PCIe EP support
Date:   Tue,  8 Aug 2023 13:34:14 +0800
Message-Id: <1691472858-9383-6-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1691472858-9383-1-git-send-email-hongxing.zhu@nxp.com>
References: <1691472858-9383-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
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
index f6b35923ad83..13411a843e07 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6sx.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6sx.dtsi
@@ -1471,5 +1471,22 @@ pcie: pcie@8ffc000 {
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

