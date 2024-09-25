Return-Path: <linux-pci+bounces-13499-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF0F985332
	for <lists+linux-pci@lfdr.de>; Wed, 25 Sep 2024 08:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CA521C23A1C
	for <lists+linux-pci@lfdr.de>; Wed, 25 Sep 2024 06:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7889315B149;
	Wed, 25 Sep 2024 06:47:18 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22611591FC;
	Wed, 25 Sep 2024 06:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727246838; cv=none; b=MzHGjCSMClgFkTwpuQwc1K9Ix5Wgmx7IRgt2N9Sjl1/4xt61z51OCeAjhbMsK9SOPbmvHMcllPY53nAAjSpnN4c7X35CpzaAODpS+q4DFoZAVEYrXATMpYpozxEkGZOEKCeWEmW1ps1KzJhzaAdRf61gwewE0HvaaArt7OVyaBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727246838; c=relaxed/simple;
	bh=dhtuowUS90bkYojYwsBSh7oyuNPvGYsFGnGhqpWqytA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Pv0TCyLD3X3emj5gWNIlPZy6lGEgoG0quaD32Eu7lb0+HzpWZ+zY2xz0AO5RkUUIlpg+3Z25y5vmm/6j/srvFrrjCS5/s6FHtcGmmVmrkVWKNVs89SENF8eGYCRjxwE31bqMBOdXxtxRZ3ktx08PmhSsCH9RgMv02xdLszPS144=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 3A2AA2029F5;
	Wed, 25 Sep 2024 08:47:15 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 0B582202000;
	Wed, 25 Sep 2024 08:47:15 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 08037183AD44;
	Wed, 25 Sep 2024 14:47:12 +0800 (+08)
From: Richard Zhu <hongxing.zhu@nxp.com>
To: l.stach@pengutronix.de,
	kwilczynski@kernel.org,
	bhelgaas@google.com,
	lpieralisi@kernel.org,
	frank.li@nxp.com,
	robh+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	festevam@gmail.com,
	s.hauer@pengutronix.de
Cc: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	kernel@pengutronix.de,
	imx@lists.linux.dev,
	Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v2 9/9] arm64: dts: imx95: Add ref clock for i.MX95 PCIe
Date: Wed, 25 Sep 2024 14:24:37 +0800
Message-Id: <1727245477-15961-10-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1727245477-15961-1-git-send-email-hongxing.zhu@nxp.com>
References: <1727245477-15961-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Add ref clock for i.MX95 PCIe.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx95.dtsi | 25 ++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
index 1bbf9a0468f6..83a6b0a8da3e 100644
--- a/arch/arm64/boot/dts/freescale/imx95.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
@@ -221,6 +221,13 @@ core5 {
 		};
 	};
 
+	clk_dummy: clock-dummy {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+		clock-output-names = "clk_dummy";
+	};
+
 	clk_ext1: clock-ext1 {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
@@ -1055,6 +1062,14 @@ smmu: iommu@490d0000 {
 			};
 		};
 
+		hsio_blk_ctl: syscon@4c0100c0 {
+			compatible = "nxp,imx95-hsio-blk-ctl", "syscon";
+			reg = <0x0 0x4c0100c0 0x0 0x4>;
+			#clock-cells = <1>;
+			clocks = <&clk_dummy>;
+			power-domains = <&scmi_devpd IMX95_PD_HSIO_TOP>;
+		};
+
 		pcie0: pcie@4c300000 {
 			compatible = "fsl,imx95-pcie";
 			reg = <0 0x4c300000 0 0x10000>,
@@ -1082,8 +1097,9 @@ pcie0: pcie@4c300000 {
 			clocks = <&scmi_clk IMX95_CLK_HSIO>,
 				 <&scmi_clk IMX95_CLK_HSIOPLL>,
 				 <&scmi_clk IMX95_CLK_HSIOPLL_VCO>,
-				 <&scmi_clk IMX95_CLK_HSIOPCIEAUX>;
-			clock-names = "pcie", "pcie_bus", "pcie_phy", "pcie_aux";
+				 <&scmi_clk IMX95_CLK_HSIOPCIEAUX>,
+				 <&hsio_blk_ctl 0>;
+			clock-names = "pcie", "pcie_bus", "pcie_phy", "pcie_aux", "ref";
 			assigned-clocks =<&scmi_clk IMX95_CLK_HSIOPLL_VCO>,
 					 <&scmi_clk IMX95_CLK_HSIOPLL>,
 					 <&scmi_clk IMX95_CLK_HSIOPCIEAUX>;
@@ -1149,8 +1165,9 @@ pcie1: pcie@4c380000 {
 			clocks = <&scmi_clk IMX95_CLK_HSIO>,
 				 <&scmi_clk IMX95_CLK_HSIOPLL>,
 				 <&scmi_clk IMX95_CLK_HSIOPLL_VCO>,
-				 <&scmi_clk IMX95_CLK_HSIOPCIEAUX>;
-			clock-names = "pcie", "pcie_bus", "pcie_phy", "pcie_aux";
+				 <&scmi_clk IMX95_CLK_HSIOPCIEAUX>,
+				 <&hsio_blk_ctl 0>;
+			clock-names = "pcie", "pcie_bus", "pcie_phy", "pcie_aux", "ref";
 			assigned-clocks =<&scmi_clk IMX95_CLK_HSIOPLL_VCO>,
 					 <&scmi_clk IMX95_CLK_HSIOPLL>,
 					 <&scmi_clk IMX95_CLK_HSIOPCIEAUX>;
-- 
2.37.1


