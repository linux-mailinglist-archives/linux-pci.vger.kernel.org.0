Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5C6EE4D1
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2019 17:39:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728959AbfKDQj3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Nov 2019 11:39:29 -0500
Received: from foss.arm.com ([217.140.110.172]:46920 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728346AbfKDQj2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 4 Nov 2019 11:39:28 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DEE5B68D;
        Mon,  4 Nov 2019 08:39:26 -0800 (PST)
Received: from e119886-lin.cambridge.arm.com (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9FAFA3F71A;
        Mon,  4 Nov 2019 08:39:17 -0800 (PST)
From:   Andrew Murray <andrew.murray@arm.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Ley Foon Tan <lftan@altera.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Will Deacon <will@kernel.org>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        David Daney <david.daney@cavium.com>,
        Jonathan Chocron <jonnyc@amazon.com>,
        Andy Gross <agross@kernel.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Toan Le <toan@os.amperecomputing.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, rfi@lists.rocketboards.org,
        linux-arm-kernel@axis.com, linux-mediatek@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-omap@vger.kernel.org
Subject: [PATCH v1 7/7] dt-bindings: PCI: Use IRQ flags for legacy PCI IRQ interrupts
Date:   Mon,  4 Nov 2019 16:38:21 +0000
Message-Id: <20191104163834.8932-8-andrew.murray@arm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191104163834.8932-1-andrew.murray@arm.com>
References: <20191104163834.8932-1-andrew.murray@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Replace magic numbers used to describe legacy PCI IRQ interrupts
with #define.

Signed-off-by: Andrew Murray <andrew.murray@arm.com>
---
 .../devicetree/bindings/pci/83xx-512x-pci.txt | 18 ++---
 .../devicetree/bindings/pci/aardvark-pci.txt  | 10 +--
 .../devicetree/bindings/pci/altera-pcie.txt   | 10 +--
 .../bindings/pci/axis,artpec6-pcie.txt        | 10 +--
 .../bindings/pci/cdns,cdns-pcie-host.txt      | 10 +--
 .../bindings/pci/faraday,ftpci100.txt         | 68 +++++++++----------
 .../bindings/pci/fsl,imx6q-pcie.txt           | 10 +--
 .../bindings/pci/hisilicon-pcie.txt           | 20 +++---
 .../bindings/pci/host-generic-pci.txt         | 10 +--
 .../devicetree/bindings/pci/kirin-pcie.txt    | 10 +--
 .../bindings/pci/layerscape-pci.txt           | 10 +--
 .../devicetree/bindings/pci/mediatek-pcie.txt | 40 +++++------
 .../devicetree/bindings/pci/mobiveil-pcie.txt |  8 +--
 .../devicetree/bindings/pci/pci-rcar-gen2.txt |  8 +--
 .../bindings/pci/pci-thunder-pem.txt          | 10 +--
 .../devicetree/bindings/pci/pcie-al.txt       |  4 +-
 .../devicetree/bindings/pci/qcom,pcie.txt     | 20 +++---
 .../bindings/pci/ralink,rt3883-pci.txt        | 18 ++---
 .../bindings/pci/rockchip-pcie-host.txt       | 10 +--
 .../devicetree/bindings/pci/ti-pci.txt        | 10 +--
 .../devicetree/bindings/pci/uniphier-pcie.txt | 10 +--
 .../bindings/pci/v3-v360epc-pci.txt           | 34 +++++-----
 .../devicetree/bindings/pci/versatile.txt     | 40 +++++------
 .../devicetree/bindings/pci/xgene-pci-msi.txt | 10 +--
 .../devicetree/bindings/pci/xgene-pci.txt     | 10 +--
 .../bindings/pci/xilinx-nwl-pcie.txt          | 10 +--
 .../devicetree/bindings/pci/xilinx-pcie.txt   | 20 +++---
 27 files changed, 224 insertions(+), 224 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/83xx-512x-pci.txt b/Documentation/devicetree/bindings/pci/83xx-512x-pci.txt
index 3abeecf4983f..cb80b9e49a2b 100644
--- a/Documentation/devicetree/bindings/pci/83xx-512x-pci.txt
+++ b/Documentation/devicetree/bindings/pci/83xx-512x-pci.txt
@@ -9,19 +9,19 @@ Freescale 83xx and 512x SOCs include the same PCI bridge core.
 
 Example (MPC8313ERDB)
 	pci0: pci@e0008500 {
-		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
+		interrupt-map-mask = <0xf800 0x0 0x0 IRQ_INT_ALL>;
 		interrupt-map = <
 				/* IDSEL 0x0E -mini PCI */
-				 0x7000 0x0 0x0 0x1 &ipic 18 0x8
-				 0x7000 0x0 0x0 0x2 &ipic 18 0x8
-				 0x7000 0x0 0x0 0x3 &ipic 18 0x8
-				 0x7000 0x0 0x0 0x4 &ipic 18 0x8
+				 0x7000 0x0 0x0 IRQ_INTA &ipic 18 0x8
+				 0x7000 0x0 0x0 IRQ_INTB &ipic 18 0x8
+				 0x7000 0x0 0x0 IRQ_INTC &ipic 18 0x8
+				 0x7000 0x0 0x0 IRQ_INTD &ipic 18 0x8
 
 				/* IDSEL 0x0F - PCI slot */
-				 0x7800 0x0 0x0 0x1 &ipic 17 0x8
-				 0x7800 0x0 0x0 0x2 &ipic 18 0x8
-				 0x7800 0x0 0x0 0x3 &ipic 17 0x8
-				 0x7800 0x0 0x0 0x4 &ipic 18 0x8>;
+				 0x7800 0x0 0x0 IRQ_INTA &ipic 17 0x8
+				 0x7800 0x0 0x0 IRQ_INTB &ipic 18 0x8
+				 0x7800 0x0 0x0 IRQ_INTC &ipic 17 0x8
+				 0x7800 0x0 0x0 IRQ_INTD &ipic 18 0x8>;
 		interrupt-parent = <&ipic>;
 		interrupts = <66 0x8>;
 		bus-range = <0x0 0x0>;
diff --git a/Documentation/devicetree/bindings/pci/aardvark-pci.txt b/Documentation/devicetree/bindings/pci/aardvark-pci.txt
index 310ef7145c47..ca8fe542edc9 100644
--- a/Documentation/devicetree/bindings/pci/aardvark-pci.txt
+++ b/Documentation/devicetree/bindings/pci/aardvark-pci.txt
@@ -43,11 +43,11 @@ Example:
 		msi-parent = <&pcie0>;
 		ranges = <0x82000000 0 0xe8000000   0 0xe8000000 0 0x1000000 /* Port 0 MEM */
 			  0x81000000 0 0xe9000000   0 0xe9000000 0 0x10000>; /* Port 0 IO*/
-		interrupt-map-mask = <0 0 0 7>;
-		interrupt-map = <0 0 0 1 &pcie_intc 0>,
-				<0 0 0 2 &pcie_intc 1>,
-				<0 0 0 3 &pcie_intc 2>,
-				<0 0 0 4 &pcie_intc 3>;
+		interrupt-map-mask = <0 0 0 IRQ_INT_ALL>;
+		interrupt-map = <0 0 0 IRQ_INTA &pcie_intc 0>,
+				<0 0 0 IRQ_INTB &pcie_intc 1>,
+				<0 0 0 IRQ_INTC &pcie_intc 2>,
+				<0 0 0 IRQ_INTD &pcie_intc 3>;
 		pcie_intc: interrupt-controller {
 			interrupt-controller;
 			#interrupt-cells = <1>;
diff --git a/Documentation/devicetree/bindings/pci/altera-pcie.txt b/Documentation/devicetree/bindings/pci/altera-pcie.txt
index 816b244a221e..f9902dca1a03 100644
--- a/Documentation/devicetree/bindings/pci/altera-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/altera-pcie.txt
@@ -40,11 +40,11 @@ Example
 		msi-parent = <&msi_to_gic_gen_0>;
 		#address-cells = <3>;
 		#size-cells = <2>;
-		interrupt-map-mask = <0 0 0 7>;
-		interrupt-map = <0 0 0 1 &pcie_0 1>,
-			            <0 0 0 2 &pcie_0 2>,
-			            <0 0 0 3 &pcie_0 3>,
-			            <0 0 0 4 &pcie_0 4>;
+		interrupt-map-mask = <0 0 0 IRQ_INT_ALL>;
+		interrupt-map = <0 0 0 IRQ_INTA &pcie_0 1>,
+			            <0 0 0 IRQ_INTB &pcie_0 2>,
+			            <0 0 0 IRQ_INTC &pcie_0 3>,
+			            <0 0 0 IRQ_INTD &pcie_0 4>;
 		ranges = <0x82000000 0x00000000 0x00000000 0xc0000000 0x00000000 0x10000000
 			  0x82000000 0x00000000 0x10000000 0xd0000000 0x00000000 0x10000000>;
 	};
diff --git a/Documentation/devicetree/bindings/pci/axis,artpec6-pcie.txt b/Documentation/devicetree/bindings/pci/axis,artpec6-pcie.txt
index 979dc7b6cfe8..c71dbe94f0eb 100644
--- a/Documentation/devicetree/bindings/pci/axis,artpec6-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/axis,artpec6-pcie.txt
@@ -41,10 +41,10 @@ Example:
 		interrupts = <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "msi";
 		#interrupt-cells = <1>;
-		interrupt-map-mask = <0 0 0 0x7>;
-		interrupt-map = <0 0 0 1 &intc GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>,
-		                <0 0 0 2 &intc GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
-		                <0 0 0 3 &intc GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
-		                <0 0 0 4 &intc GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-map-mask = <0 0 0 IRQ_INT_ALL>;
+		interrupt-map = <0 0 0 IRQ_INTA &intc GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>,
+		                <0 0 0 IRQ_INTB &intc GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
+		                <0 0 0 IRQ_INTC &intc GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
+		                <0 0 0 IRQ_INTD &intc GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>;
 		axis,syscon-pcie = <&syscon>;
 	};
diff --git a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.txt b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.txt
index 91de69c713a9..67845103c8f0 100644
--- a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.txt
+++ b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.txt
@@ -52,12 +52,12 @@ pcie@fb000000 {
 
 	#interrupt-cells = <0x1>;
 
-	interrupt-map = <0x0 0x0 0x0  0x1  &gic  0x0 0x0 0x0 14 0x1
-			 0x0 0x0 0x0  0x2  &gic  0x0 0x0 0x0 15 0x1
-			 0x0 0x0 0x0  0x3  &gic  0x0 0x0 0x0 16 0x1
-			 0x0 0x0 0x0  0x4  &gic  0x0 0x0 0x0 17 0x1>;
+	interrupt-map = <0x0 0x0 0x0  IRQ_INTA  &gic  0x0 0x0 0x0 14 0x1
+			 0x0 0x0 0x0  IRQ_INTB  &gic  0x0 0x0 0x0 15 0x1
+			 0x0 0x0 0x0  IRQ_INTC  &gic  0x0 0x0 0x0 16 0x1
+			 0x0 0x0 0x0  IRQ_INTD  &gic  0x0 0x0 0x0 17 0x1>;
 
-	interrupt-map-mask = <0x0 0x0 0x0  0x7>;
+	interrupt-map-mask = <0x0 0x0 0x0 IRQ_INT_ALL>;
 
 	msi-parent = <&its_pci>;
 
diff --git a/Documentation/devicetree/bindings/pci/faraday,ftpci100.txt b/Documentation/devicetree/bindings/pci/faraday,ftpci100.txt
index 5f8cb4962f8d..b267d4853773 100644
--- a/Documentation/devicetree/bindings/pci/faraday,ftpci100.txt
+++ b/Documentation/devicetree/bindings/pci/faraday,ftpci100.txt
@@ -61,24 +61,24 @@ variant) interrupts assigns the default interrupt mapping/swizzling has
 typically been like this, doing the swizzling on the interrupt controller side
 rather than in the interconnect:
 
-interrupt-map-mask = <0xf800 0 0 7>;
+interrupt-map-mask = <0xf800 0 0 IRQ_INT_ALL>;
 interrupt-map =
-	<0x4800 0 0 1 &pci_intc 0>, /* Slot 9 */
-	<0x4800 0 0 2 &pci_intc 1>,
-	<0x4800 0 0 3 &pci_intc 2>,
-	<0x4800 0 0 4 &pci_intc 3>,
-	<0x5000 0 0 1 &pci_intc 1>, /* Slot 10 */
-	<0x5000 0 0 2 &pci_intc 2>,
-	<0x5000 0 0 3 &pci_intc 3>,
-	<0x5000 0 0 4 &pci_intc 0>,
-	<0x5800 0 0 1 &pci_intc 2>, /* Slot 11 */
-	<0x5800 0 0 2 &pci_intc 3>,
-	<0x5800 0 0 3 &pci_intc 0>,
-	<0x5800 0 0 4 &pci_intc 1>,
-	<0x6000 0 0 1 &pci_intc 3>, /* Slot 12 */
-	<0x6000 0 0 2 &pci_intc 0>,
-	<0x6000 0 0 3 &pci_intc 1>,
-	<0x6000 0 0 4 &pci_intc 2>;
+	<0x4800 0 0 IRQ_INTA &pci_intc 0>, /* Slot 9 */
+	<0x4800 0 0 IRQ_INTB &pci_intc 1>,
+	<0x4800 0 0 IRQ_INTC &pci_intc 2>,
+	<0x4800 0 0 IRQ_INTD &pci_intc 3>,
+	<0x5000 0 0 IRQ_INTA &pci_intc 1>, /* Slot 10 */
+	<0x5000 0 0 IRQ_INTB &pci_intc 2>,
+	<0x5000 0 0 IRQ_INTC &pci_intc 3>,
+	<0x5000 0 0 IRQ_INTD &pci_intc 0>,
+	<0x5800 0 0 IRQ_INTA &pci_intc 2>, /* Slot 11 */
+	<0x5800 0 0 IRQ_INTB &pci_intc 3>,
+	<0x5800 0 0 IRQ_INTC &pci_intc 0>,
+	<0x5800 0 0 IRQ_INTD &pci_intc 1>,
+	<0x6000 0 0 IRQ_INTA &pci_intc 3>, /* Slot 12 */
+	<0x6000 0 0 IRQ_INTB &pci_intc 0>,
+	<0x6000 0 0 IRQ_INTC &pci_intc 1>,
+	<0x6000 0 0 IRQ_INTD &pci_intc 2>;
 
 Example:
 
@@ -108,24 +108,24 @@ pci@50000000 {
 	/* 64MiB at 0x00000000-0x03ffffff */
 	<0x02000000 0 0x00000000 0x00000000 0 0x04000000>;
 
-	interrupt-map-mask = <0xf800 0 0 7>;
+	interrupt-map-mask = <0xf800 0 0 IRQ_INT_ALL>;
 	interrupt-map =
-		<0x4800 0 0 1 &pci_intc 0>, /* Slot 9 */
-		<0x4800 0 0 2 &pci_intc 1>,
-		<0x4800 0 0 3 &pci_intc 2>,
-		<0x4800 0 0 4 &pci_intc 3>,
-		<0x5000 0 0 1 &pci_intc 1>, /* Slot 10 */
-		<0x5000 0 0 2 &pci_intc 2>,
-		<0x5000 0 0 3 &pci_intc 3>,
-		<0x5000 0 0 4 &pci_intc 0>,
-		<0x5800 0 0 1 &pci_intc 2>, /* Slot 11 */
-		<0x5800 0 0 2 &pci_intc 3>,
-		<0x5800 0 0 3 &pci_intc 0>,
-		<0x5800 0 0 4 &pci_intc 1>,
-		<0x6000 0 0 1 &pci_intc 3>, /* Slot 12 */
-		<0x6000 0 0 2 &pci_intc 0>,
-		<0x6000 0 0 3 &pci_intc 0>,
-		<0x6000 0 0 4 &pci_intc 0>;
+		<0x4800 0 0 IRQ_INTA &pci_intc 0>, /* Slot 9 */
+		<0x4800 0 0 IRQ_INTB &pci_intc 1>,
+		<0x4800 0 0 IRQ_INTC &pci_intc 2>,
+		<0x4800 0 0 IRQ_INTD &pci_intc 3>,
+		<0x5000 0 0 IRQ_INTA &pci_intc 1>, /* Slot 10 */
+		<0x5000 0 0 IRQ_INTB &pci_intc 2>,
+		<0x5000 0 0 IRQ_INTC &pci_intc 3>,
+		<0x5000 0 0 IRQ_INTD &pci_intc 0>,
+		<0x5800 0 0 IRQ_INTA &pci_intc 2>, /* Slot 11 */
+		<0x5800 0 0 IRQ_INTB &pci_intc 3>,
+		<0x5800 0 0 IRQ_INTC &pci_intc 0>,
+		<0x5800 0 0 IRQ_INTD &pci_intc 1>,
+		<0x6000 0 0 IRQ_INTA &pci_intc 3>, /* Slot 12 */
+		<0x6000 0 0 IRQ_INTB &pci_intc 0>,
+		<0x6000 0 0 IRQ_INTC &pci_intc 0>,
+		<0x6000 0 0 IRQ_INTD &pci_intc 0>;
 	pci_intc: interrupt-controller {
 		interrupt-parent = <&intcon>;
 		interrupt-controller;
diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
index de4b2baf91e8..dc331885124a 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
@@ -77,11 +77,11 @@ Example:
 		interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "msi";
 		#interrupt-cells = <1>;
-		interrupt-map-mask = <0 0 0 0x7>;
-		interrupt-map = <0 0 0 1 &intc GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
-		                <0 0 0 2 &intc GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>,
-		                <0 0 0 3 &intc GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
-		                <0 0 0 4 &intc GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-map-mask = <0 0 0 IRQ_INT_ALL>;
+		interrupt-map = <0 0 0 IRQ_INTA &intc GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
+		                <0 0 0 IRQ_INTB &intc GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>,
+		                <0 0 0 IRQ_INTC &intc GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
+		                <0 0 0 IRQ_INTD &intc GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&clks 144>, <&clks 206>, <&clks 189>;
 		clock-names = "pcie", "pcie_bus", "pcie_phy";
 	};
diff --git a/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt b/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
index 0dcb87d6554f..3e809c7d9b07 100644
--- a/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
@@ -35,11 +35,11 @@ Hip05 Example (note that Hip06 is the same except compatible):
 		num-lanes = <8>;
 		port-id = <1>;
 		#interrupt-cells = <1>;
-		interrupt-map-mask = <0xf800 0 0 7>;
-		interrupt-map = <0x0 0 0 1 &mbigen_pcie 1 10
-				 0x0 0 0 2 &mbigen_pcie 2 11
-				 0x0 0 0 3 &mbigen_pcie 3 12
-				 0x0 0 0 4 &mbigen_pcie 4 13>;
+		interrupt-map-mask = <0xf800 0 0 IRQ_INT_ALL>;
+		interrupt-map = <0x0 0 0 IRQ_INTA &mbigen_pcie 1 10
+				 0x0 0 0 IRQ_INTB &mbigen_pcie 2 11
+				 0x0 0 0 IRQ_INTC &mbigen_pcie 3 12
+				 0x0 0 0 IRQ_INTD &mbigen_pcie 4 13>;
 	};
 
 HiSilicon Hip06/Hip07 PCIe host bridge DT (almost-ECAM) description.
@@ -77,9 +77,9 @@ Example:
 		ranges = <0x02000000 0 0xb2000000 0x0 0xb2000000 0 0x5ff0000
 			  0x01000000 0 0 0 0xb7ff0000 0 0x10000>;
 		#interrupt-cells = <1>;
-		interrupt-map-mask = <0xf800 0 0 7>;
-		interrupt-map = <0x0 0 0 1 &mbigen_pcie0 650 4
-				 0x0 0 0 2 &mbigen_pcie0 650 4
-				 0x0 0 0 3 &mbigen_pcie0 650 4
-				 0x0 0 0 4 &mbigen_pcie0 650 4>;
+		interrupt-map-mask = <0xf800 0 0 IRQ_INT_ALL>;
+		interrupt-map = <0x0 0 0 IRQ_INTA &mbigen_pcie0 650 4
+				 0x0 0 0 IRQ_INTB &mbigen_pcie0 650 4
+				 0x0 0 0 IRQ_INTC &mbigen_pcie0 650 4
+				 0x0 0 0 IRQ_INTD &mbigen_pcie0 650 4>;
 	};
diff --git a/Documentation/devicetree/bindings/pci/host-generic-pci.txt b/Documentation/devicetree/bindings/pci/host-generic-pci.txt
index 614b594f4e72..51a56ad3f1a9 100644
--- a/Documentation/devicetree/bindings/pci/host-generic-pci.txt
+++ b/Documentation/devicetree/bindings/pci/host-generic-pci.txt
@@ -91,11 +91,11 @@ pci {
     #interrupt-cells = <0x1>;
 
     // PCI_DEVICE(3)  INT#(1)  CONTROLLER(PHANDLE)  CONTROLLER_DATA(3)
-    interrupt-map = <  0x0 0x0 0x0  0x1  &gic  0x0 0x4 0x1
-                     0x800 0x0 0x0  0x1  &gic  0x0 0x5 0x1
-                    0x1000 0x0 0x0  0x1  &gic  0x0 0x6 0x1
-                    0x1800 0x0 0x0  0x1  &gic  0x0 0x7 0x1>;
+    interrupt-map = <  0x0 0x0 0x0 IRQ_INTA  &gic  0x0 0x4 0x1
+                     0x800 0x0 0x0 IRQ_INTA  &gic  0x0 0x5 0x1
+                    0x1000 0x0 0x0 IRQ_INTA  &gic  0x0 0x6 0x1
+                    0x1800 0x0 0x0 IRQ_INTA  &gic  0x0 0x7 0x1>;
 
     // PCI_DEVICE(3)  INT#(1)
-    interrupt-map-mask = <0xf800 0x0 0x0  0x7>;
+    interrupt-map-mask = <0xf800 0x0 0x0 IRQ_MAP_ALL>;
 }
diff --git a/Documentation/devicetree/bindings/pci/kirin-pcie.txt b/Documentation/devicetree/bindings/pci/kirin-pcie.txt
index 6bbe43818ad5..7da640d6578e 100644
--- a/Documentation/devicetree/bindings/pci/kirin-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/kirin-pcie.txt
@@ -34,11 +34,11 @@ Example based on kirin960:
 		ranges = <0x02000000 0x0 0x00000000 0x0 0xf5000000 0x0 0x2000000>;
 		num-lanes = <1>;
 		#interrupt-cells = <1>;
-		interrupt-map-mask = <0xf800 0 0 7>;
-		interrupt-map = <0x0 0 0 1 &gic 0 0 0  282 4>,
-				<0x0 0 0 2 &gic 0 0 0  283 4>,
-				<0x0 0 0 3 &gic 0 0 0  284 4>,
-				<0x0 0 0 4 &gic 0 0 0  285 4>;
+		interrupt-map-mask = <0xf800 0 0 IRQ_INT_ALL>;
+		interrupt-map = <0x0 0 0 IRQ_INTA &gic 0 0 0  282 4>,
+				<0x0 0 0 IRQ_INTB &gic 0 0 0  283 4>,
+				<0x0 0 0 IRQ_INTC &gic 0 0 0  284 4>,
+				<0x0 0 0 IRQ_INTD &gic 0 0 0  285 4>;
 		clocks = <&crg_ctrl HI3660_PCIEPHY_REF>,
 			 <&crg_ctrl HI3660_CLK_GATE_PCIEAUX>,
 			 <&crg_ctrl HI3660_PCLK_GATE_PCIE_PHY>,
diff --git a/Documentation/devicetree/bindings/pci/layerscape-pci.txt b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
index e20ceaab9b38..1016e9f8982a 100644
--- a/Documentation/devicetree/bindings/pci/layerscape-pci.txt
+++ b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
@@ -56,9 +56,9 @@ Example:
 			  0xc2000000 0x0 0x20000000 0x40 0x20000000 0x0 0x20000000   /* prefetchable memory */
 			  0x82000000 0x0 0x40000000 0x40 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
 		#interrupt-cells = <1>;
-		interrupt-map-mask = <0 0 0 7>;
-		interrupt-map = <0000 0 0 1 &gic GIC_SPI 91  IRQ_TYPE_LEVEL_HIGH>,
-				<0000 0 0 2 &gic GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>,
-				<0000 0 0 3 &gic GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>,
-				<0000 0 0 4 &gic GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-map-mask = <0 0 0 IRQ_INT_ALL>;
+		interrupt-map = <0000 0 0 IRQ_INTA &gic GIC_SPI 91  IRQ_TYPE_LEVEL_HIGH>,
+				<0000 0 0 IRQ_INTB &gic GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>,
+				<0000 0 0 IRQ_INTC &gic GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>,
+				<0000 0 0 IRQ_INTD &gic GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>;
 	};
diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie.txt b/Documentation/devicetree/bindings/pci/mediatek-pcie.txt
index 7468d666763a..00728cdad957 100644
--- a/Documentation/devicetree/bindings/pci/mediatek-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/mediatek-pcie.txt
@@ -169,11 +169,11 @@ Examples for MT2712:
 			#size-cells = <2>;
 			#interrupt-cells = <1>;
 			ranges;
-			interrupt-map-mask = <0 0 0 7>;
-			interrupt-map = <0 0 0 1 &pcie_intc0 0>,
-					<0 0 0 2 &pcie_intc0 1>,
-					<0 0 0 3 &pcie_intc0 2>,
-					<0 0 0 4 &pcie_intc0 3>;
+			interrupt-map-mask = <0 0 0 IRQ_INT_ALL>;
+			interrupt-map = <0 0 0 IRQ_INTA &pcie_intc0 0>,
+					<0 0 0 IRQ_INTB &pcie_intc0 1>,
+					<0 0 0 IRQ_INTC &pcie_intc0 2>,
+					<0 0 0 IRQ_INTD &pcie_intc0 3>;
 			pcie_intc0: interrupt-controller {
 				interrupt-controller;
 				#address-cells = <0>;
@@ -187,11 +187,11 @@ Examples for MT2712:
 			#size-cells = <2>;
 			#interrupt-cells = <1>;
 			ranges;
-			interrupt-map-mask = <0 0 0 7>;
-			interrupt-map = <0 0 0 1 &pcie_intc1 0>,
-					<0 0 0 2 &pcie_intc1 1>,
-					<0 0 0 3 &pcie_intc1 2>,
-					<0 0 0 4 &pcie_intc1 3>;
+			interrupt-map-mask = <0 0 0 IRQ_INT_ALL>;
+			interrupt-map = <0 0 0 IRQ_INTA &pcie_intc1 0>,
+					<0 0 0 IRQ_INTB &pcie_intc1 1>,
+					<0 0 0 IRQ_INTC &pcie_intc1 2>,
+					<0 0 0 IRQ_INTD &pcie_intc1 3>;
 			pcie_intc1: interrupt-controller {
 				interrupt-controller;
 				#address-cells = <0>;
@@ -240,11 +240,11 @@ Examples for MT7622:
 			#size-cells = <2>;
 			#interrupt-cells = <1>;
 			ranges;
-			interrupt-map-mask = <0 0 0 7>;
-			interrupt-map = <0 0 0 1 &pcie_intc0 0>,
-					<0 0 0 2 &pcie_intc0 1>,
-					<0 0 0 3 &pcie_intc0 2>,
-					<0 0 0 4 &pcie_intc0 3>;
+			interrupt-map-mask = <0 0 0 IRQ_INT_ALL>;
+			interrupt-map = <0 0 0 IRQ_INTA &pcie_intc0 0>,
+					<0 0 0 IRQ_INTB &pcie_intc0 1>,
+					<0 0 0 IRQ_INTC &pcie_intc0 2>,
+					<0 0 0 IRQ_INTD &pcie_intc0 3>;
 			pcie_intc0: interrupt-controller {
 				interrupt-controller;
 				#address-cells = <0>;
@@ -258,11 +258,11 @@ Examples for MT7622:
 			#size-cells = <2>;
 			#interrupt-cells = <1>;
 			ranges;
-			interrupt-map-mask = <0 0 0 7>;
-			interrupt-map = <0 0 0 1 &pcie_intc1 0>,
-					<0 0 0 2 &pcie_intc1 1>,
-					<0 0 0 3 &pcie_intc1 2>,
-					<0 0 0 4 &pcie_intc1 3>;
+			interrupt-map-mask = <0 0 0 IRQ_INT_ALL>;
+			interrupt-map = <0 0 0 IRQ_INTA &pcie_intc1 0>,
+					<0 0 0 IRQ_INTB &pcie_intc1 1>,
+					<0 0 0 IRQ_INTC &pcie_intc1 2>,
+					<0 0 0 IRQ_INTD &pcie_intc1 3>;
 			pcie_intc1: interrupt-controller {
 				interrupt-controller;
 				#address-cells = <0>;
diff --git a/Documentation/devicetree/bindings/pci/mobiveil-pcie.txt b/Documentation/devicetree/bindings/pci/mobiveil-pcie.txt
index 64156993e052..03070b3bfda1 100644
--- a/Documentation/devicetree/bindings/pci/mobiveil-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/mobiveil-pcie.txt
@@ -62,11 +62,11 @@ Example:
 		interrupt-parent = <&gic>;
 		#interrupt-cells = <1>;
 		interrupts = < 0 89 4 >;
-		interrupt-map-mask = <0 0 0 7>;
+		interrupt-map-mask = <0 0 0 IRQ_INT_ALL>;
 		interrupt-map = <0 0 0 0 &pci_express 0>,
-				<0 0 0 1 &pci_express 1>,
-				<0 0 0 2 &pci_express 2>,
-				<0 0 0 3 &pci_express 3>;
+				<0 0 0 IRQ_INTA &pci_express 1>,
+				<0 0 0 IRQ_INTB &pci_express 2>,
+				<0 0 0 IRQ_INTC &pci_express 3>;
 		ranges = < 0x83000000 0 0x00000000 0xa8000000 0 0x8000000>;
 
 	};
diff --git a/Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt b/Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt
index b94078f58d8e..7c6a19e0b131 100644
--- a/Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt
+++ b/Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt
@@ -56,10 +56,10 @@ Example SoC configuration:
 		#size-cells = <2>;
 		#interrupt-cells = <1>;
 		dma-ranges = <0x42000000 0 0x40000000 0 0x40000000 0 0x40000000>;
-		interrupt-map-mask = <0xff00 0 0 0x7>;
-		interrupt-map = <0x0000 0 0 1 &gic 0 108 IRQ_TYPE_LEVEL_HIGH
-				 0x0800 0 0 1 &gic 0 108 IRQ_TYPE_LEVEL_HIGH
-				 0x1000 0 0 2 &gic 0 108 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-map-mask = <0xff00 0 0 IRQ_INT_ALL>;
+		interrupt-map = <0x0000 0 0 IRQ_INTA &gic 0 108 IRQ_TYPE_LEVEL_HIGH
+				 0x0800 0 0 IRQ_INTA &gic 0 108 IRQ_TYPE_LEVEL_HIGH
+				 0x1000 0 0 IRQ_INTB &gic 0 108 IRQ_TYPE_LEVEL_HIGH>;
 
 		usb@1,0 {
 			reg = <0x800 0 0 0 0>;
diff --git a/Documentation/devicetree/bindings/pci/pci-thunder-pem.txt b/Documentation/devicetree/bindings/pci/pci-thunder-pem.txt
index f131faea3b7c..edfaedfe8c8c 100644
--- a/Documentation/devicetree/bindings/pci/pci-thunder-pem.txt
+++ b/Documentation/devicetree/bindings/pci/pci-thunder-pem.txt
@@ -35,9 +35,9 @@ Example:
 		 <0x03000000 0x87e0 0xc2f00000 0x87e0 0xc2000000 0x00 0x00100000>; /* mem64 PEM BAR4 */
 
 	#interrupt-cells = <1>;
-	interrupt-map-mask = <0 0 0 7>;
-	interrupt-map = <0 0 0 1 &gic0 0 0 0 24 4>, /* INTA */
-			<0 0 0 2 &gic0 0 0 0 25 4>, /* INTB */
-			<0 0 0 3 &gic0 0 0 0 26 4>, /* INTC */
-			<0 0 0 4 &gic0 0 0 0 27 4>; /* INTD */
+	interrupt-map-mask = <0 0 0 IRQ_INT_ALL>;
+	interrupt-map = <0 0 0 IRQ_INTA &gic0 0 0 0 24 4>,
+			<0 0 0 IRQ_INTB &gic0 0 0 0 25 4>,
+			<0 0 0 IRQ_INTC &gic0 0 0 0 26 4>,
+			<0 0 0 IRQ_INTD &gic0 0 0 0 27 4>;
     };
diff --git a/Documentation/devicetree/bindings/pci/pcie-al.txt b/Documentation/devicetree/bindings/pci/pcie-al.txt
index 557a5089229d..8bb3d935d3fa 100644
--- a/Documentation/devicetree/bindings/pci/pcie-al.txt
+++ b/Documentation/devicetree/bindings/pci/pcie-al.txt
@@ -40,7 +40,7 @@ Example:
 		#size-cells = <2>;
 		#interrupt-cells = <1>;
 		interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-map-mask = <0x00 0 0 7>;
-		interrupt-map = <0x0000 0 0 1 &gic GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>; /* INTa */
+		interrupt-map-mask = <0x00 0 0 IRQ_INT_ALL>;
+		interrupt-map = <0x0000 0 0 IRQ_INTA &gic GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
 		ranges = <0x02000000 0x0 0xc0010000 0x0 0xc0010000 0x0 0x07ff0000>;
 	};
diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.txt b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
index ada80b01bf0c..898599eed2e5 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.txt
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
@@ -251,11 +251,11 @@
 		interrupts = <GIC_SPI 238 IRQ_TYPE_NONE>;
 		interrupt-names = "msi";
 		#interrupt-cells = <1>;
-		interrupt-map-mask = <0 0 0 0x7>;
-		interrupt-map = <0 0 0 1 &intc 0 36 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
-				<0 0 0 2 &intc 0 37 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
-				<0 0 0 3 &intc 0 38 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
-				<0 0 0 4 &intc 0 39 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
+		interrupt-map-mask = <0 0 0 IRQ_INT_ALL>;
+		interrupt-map = <0 0 0 IRQ_INTA &intc 0 36 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 0 IRQ_INTB &intc 0 37 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 0 IRQ_INTC &intc 0 38 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 0 IRQ_INTD &intc 0 39 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&gcc PCIE_A_CLK>,
 			 <&gcc PCIE_H_CLK>,
 			 <&gcc PCIE_PHY_CLK>;
@@ -289,11 +289,11 @@
 		interrupts = <GIC_SPI 243 IRQ_TYPE_NONE>;
 		interrupt-names = "msi";
 		#interrupt-cells = <1>;
-		interrupt-map-mask = <0 0 0 0x7>;
-		interrupt-map = <0 0 0 1 &intc 0 244 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
-				<0 0 0 2 &intc 0 245 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
-				<0 0 0 3 &intc 0 247 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
-				<0 0 0 4 &intc 0 248 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
+		interrupt-map-mask = <0 0 0 IRQ_INT_ALL>;
+		interrupt-map = <0 0 0 IRQ_INTA &intc 0 244 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 0 IRQ_INTB &intc 0 245 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 0 IRQ_INTC &intc 0 247 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 0 IRQ_INTD &intc 0 248 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
 			 <&gcc GCC_PCIE_0_MSTR_AXI_CLK>,
 			 <&gcc GCC_PCIE_0_SLV_AXI_CLK>,
diff --git a/Documentation/devicetree/bindings/pci/ralink,rt3883-pci.txt b/Documentation/devicetree/bindings/pci/ralink,rt3883-pci.txt
index ffba4f63d71f..09a4a28fb472 100644
--- a/Documentation/devicetree/bindings/pci/ralink,rt3883-pci.txt
+++ b/Documentation/devicetree/bindings/pci/ralink,rt3883-pci.txt
@@ -131,18 +131,18 @@
 				0x01000000 0 0x00000000 0x10160000 0 0x00010000 /* io space */
 			>;
 
-			interrupt-map-mask = <0xf800 0 0 7>;
+			interrupt-map-mask = <0xf800 0 0 IRQ_INT_ALL>;
 			interrupt-map = <
 				/* IDSEL 17 */
-				0x8800 0 0 1 &pciintc 18
-				0x8800 0 0 2 &pciintc 18
-				0x8800 0 0 3 &pciintc 18
-				0x8800 0 0 4 &pciintc 18
+				0x8800 0 0 IRQ_INTA &pciintc 18
+				0x8800 0 0 IRQ_INTB &pciintc 18
+				0x8800 0 0 IRQ_INTC &pciintc 18
+				0x8800 0 0 IRQ_INTD &pciintc 18
 				/* IDSEL 18 */
-				0x9000 0 0 1 &pciintc 19
-				0x9000 0 0 2 &pciintc 19
-				0x9000 0 0 3 &pciintc 19
-				0x9000 0 0 4 &pciintc 19
+				0x9000 0 0 IRQ_INTA &pciintc 19
+				0x9000 0 0 IRQ_INTB &pciintc 19
+				0x9000 0 0 IRQ_INTC &pciintc 19
+				0x9000 0 0 IRQ_INTD &pciintc 19
 			>;
 
 			pci-bridge@1 {
diff --git a/Documentation/devicetree/bindings/pci/rockchip-pcie-host.txt b/Documentation/devicetree/bindings/pci/rockchip-pcie-host.txt
index af34c65773fd..4538d18b4c3c 100644
--- a/Documentation/devicetree/bindings/pci/rockchip-pcie-host.txt
+++ b/Documentation/devicetree/bindings/pci/rockchip-pcie-host.txt
@@ -112,11 +112,11 @@ pcie0: pcie@f8000000 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pcie_clkreq>;
 	#interrupt-cells = <1>;
-	interrupt-map-mask = <0 0 0 7>;
-	interrupt-map = <0 0 0 1 &pcie0_intc 0>,
-			<0 0 0 2 &pcie0_intc 1>,
-			<0 0 0 3 &pcie0_intc 2>,
-			<0 0 0 4 &pcie0_intc 3>;
+	interrupt-map-mask = <0 0 0 IRQ_INT_ALL>;
+	interrupt-map = <0 0 0 IRQ_INTA &pcie0_intc 0>,
+			<0 0 0 IRQ_INTB &pcie0_intc 1>,
+			<0 0 0 IRQ_INTC &pcie0_intc 2>,
+			<0 0 0 IRQ_INTD &pcie0_intc 3>;
 	pcie0_intc: interrupt-controller {
 		interrupt-controller;
 		#address-cells = <0>;
diff --git a/Documentation/devicetree/bindings/pci/ti-pci.txt b/Documentation/devicetree/bindings/pci/ti-pci.txt
index d5cbfe6b0d89..795b09755977 100644
--- a/Documentation/devicetree/bindings/pci/ti-pci.txt
+++ b/Documentation/devicetree/bindings/pci/ti-pci.txt
@@ -88,11 +88,11 @@ axi {
 		ti,hwmods = "pcie1";
 		phys = <&pcie1_phy>;
 		phy-names = "pcie-phy0";
-		interrupt-map-mask = <0 0 0 7>;
-		interrupt-map = <0 0 0 1 &pcie_intc 1>,
-				<0 0 0 2 &pcie_intc 2>,
-				<0 0 0 3 &pcie_intc 3>,
-				<0 0 0 4 &pcie_intc 4>;
+		interrupt-map-mask = <0 0 0 IRQ_INT_ALL>;
+		interrupt-map = <0 0 0 IRQ_INTA &pcie_intc 1>,
+				<0 0 0 IRQ_INTB &pcie_intc 2>,
+				<0 0 0 IRQ_INTC &pcie_intc 3>,
+				<0 0 0 IRQ_INTD &pcie_intc 4>;
 		pcie_intc: interrupt-controller {
 			interrupt-controller;
 			#address-cells = <0>;
diff --git a/Documentation/devicetree/bindings/pci/uniphier-pcie.txt b/Documentation/devicetree/bindings/pci/uniphier-pcie.txt
index 1fa2c5906d4d..b5416798a638 100644
--- a/Documentation/devicetree/bindings/pci/uniphier-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/uniphier-pcie.txt
@@ -66,11 +66,11 @@ Example:
 		#interrupt-cells = <1>;
 		interrupt-names = "dma", "msi";
 		interrupts = <0 224 4>, <0 225 4>;
-		interrupt-map-mask = <0 0 0  7>;
-		interrupt-map = <0 0 0  1  &pcie_intc 0>,	/* INTA */
-				<0 0 0  2  &pcie_intc 1>,	/* INTB */
-				<0 0 0  3  &pcie_intc 2>,	/* INTC */
-				<0 0 0  4  &pcie_intc 3>;	/* INTD */
+		interrupt-map-mask = <0 0 0 IRQ_INT_ALL>;
+		interrupt-map = <0 0 0  IRQ_INTA  &pcie_intc 0>,
+				<0 0 0  IRQ_INTB  &pcie_intc 1>,
+				<0 0 0  IRQ_INTC  &pcie_intc 2>,
+				<0 0 0  IRQ_INTD  &pcie_intc 3>;
 
 		pcie_intc: legacy-interrupt-controller {
 			interrupt-controller;
diff --git a/Documentation/devicetree/bindings/pci/v3-v360epc-pci.txt b/Documentation/devicetree/bindings/pci/v3-v360epc-pci.txt
index 11063293f761..bfa37aa4933d 100644
--- a/Documentation/devicetree/bindings/pci/v3-v360epc-pci.txt
+++ b/Documentation/devicetree/bindings/pci/v3-v360epc-pci.txt
@@ -50,27 +50,27 @@ pci: pciv3@62000000 {
 		0x20000000 0 0x20000000 /* 512 MB @ LB 20000000 1:1 */
 		0x02000000 0 0x80000000 /* Core module alias memory */
 		0x80000000 0 0x40000000>; /* 1GB @ LB 80000000 */
-	interrupt-map-mask = <0xf800 0 0 0x7>;
+	interrupt-map-mask = <0xf800 0 0 IRQ_INT_ALL>;
 	interrupt-map = <
 	/* IDSEL 9 */
-	0x4800 0 0 1 &pic 13 /* INT A on slot 9 is irq 13 */
-	0x4800 0 0 2 &pic 14 /* INT B on slot 9 is irq 14 */
-	0x4800 0 0 3 &pic 15 /* INT C on slot 9 is irq 15 */
-	0x4800 0 0 4 &pic 16 /* INT D on slot 9 is irq 16 */
+	0x4800 0 0 IRQ_INTA &pic 13 /* INT A on slot 9 is irq 13 */
+	0x4800 0 0 IRQ_INTB &pic 14 /* INT B on slot 9 is irq 14 */
+	0x4800 0 0 IRQ_INTC &pic 15 /* INT C on slot 9 is irq 15 */
+	0x4800 0 0 IRQ_INTD &pic 16 /* INT D on slot 9 is irq 16 */
 	/* IDSEL 10 */
-	0x5000 0 0 1 &pic 14 /* INT A on slot 10 is irq 14 */
-	0x5000 0 0 2 &pic 15 /* INT B on slot 10 is irq 15 */
-	0x5000 0 0 3 &pic 16 /* INT C on slot 10 is irq 16 */
-	0x5000 0 0 4 &pic 13 /* INT D on slot 10 is irq 13 */
+	0x5000 0 0 IRQ_INTA &pic 14 /* INT A on slot 10 is irq 14 */
+	0x5000 0 0 IRQ_INTB &pic 15 /* INT B on slot 10 is irq 15 */
+	0x5000 0 0 IRQ_INTC &pic 16 /* INT C on slot 10 is irq 16 */
+	0x5000 0 0 IRQ_INTD &pic 13 /* INT D on slot 10 is irq 13 */
 	/* IDSEL 11 */
-	0x5800 0 0 1 &pic 15 /* INT A on slot 11 is irq 15 */
-	0x5800 0 0 2 &pic 16 /* INT B on slot 11 is irq 16 */
-	0x5800 0 0 3 &pic 13 /* INT C on slot 11 is irq 13 */
-	0x5800 0 0 4 &pic 14 /* INT D on slot 11 is irq 14 */
+	0x5800 0 0 IRQ_INTA &pic 15 /* INT A on slot 11 is irq 15 */
+	0x5800 0 0 IRQ_INTB &pic 16 /* INT B on slot 11 is irq 16 */
+	0x5800 0 0 IRQ_INTC &pic 13 /* INT C on slot 11 is irq 13 */
+	0x5800 0 0 IRQ_INTD &pic 14 /* INT D on slot 11 is irq 14 */
 	/* IDSEL 12 */
-	0x6000 0 0 1 &pic 16 /* INT A on slot 12 is irq 16 */
-	0x6000 0 0 2 &pic 13 /* INT B on slot 12 is irq 13 */
-	0x6000 0 0 3 &pic 14 /* INT C on slot 12 is irq 14 */
-	0x6000 0 0 4 &pic 15 /* INT D on slot 12 is irq 15 */
+	0x6000 0 0 IRQ_INTA &pic 16 /* INT A on slot 12 is irq 16 */
+	0x6000 0 0 IRQ_INTB &pic 13 /* INT B on slot 12 is irq 13 */
+	0x6000 0 0 IRQ_INTC &pic 14 /* INT C on slot 12 is irq 14 */
+	0x6000 0 0 IRQ_INTD &pic 15 /* INT D on slot 12 is irq 15 */
 	>;
 };
diff --git a/Documentation/devicetree/bindings/pci/versatile.txt b/Documentation/devicetree/bindings/pci/versatile.txt
index 0a702b13d2ac..a02c7b9683ac 100644
--- a/Documentation/devicetree/bindings/pci/versatile.txt
+++ b/Documentation/devicetree/bindings/pci/versatile.txt
@@ -36,24 +36,24 @@ pci-controller@10001000 {
 		  0x02000000 0 0x50000000 0x50000000 0 0x10000000   /* non-prefetchable memory */
 		  0x42000000 0 0x60000000 0x60000000 0 0x10000000>; /* prefetchable memory */
 
-	interrupt-map-mask = <0x1800 0 0 7>;
-	interrupt-map = <0x1800 0 0 1 &sic 28
-			 0x1800 0 0 2 &sic 29
-			 0x1800 0 0 3 &sic 30
-			 0x1800 0 0 4 &sic 27
-
-			 0x1000 0 0 1 &sic 27
-			 0x1000 0 0 2 &sic 28
-			 0x1000 0 0 3 &sic 29
-			 0x1000 0 0 4 &sic 30
-
-			 0x0800 0 0 1 &sic 30
-			 0x0800 0 0 2 &sic 27
-			 0x0800 0 0 3 &sic 28
-			 0x0800 0 0 4 &sic 29
-
-			 0x0000 0 0 1 &sic 29
-			 0x0000 0 0 2 &sic 30
-			 0x0000 0 0 3 &sic 27
-			 0x0000 0 0 4 &sic 28>;
+	interrupt-map-mask = <0x1800 0 0 IRQ_INT_ALL>;
+	interrupt-map = <0x1800 0 0 IRQ_INTA &sic 28
+			 0x1800 0 0 IRQ_INTB &sic 29
+			 0x1800 0 0 IRQ_INTC &sic 30
+			 0x1800 0 0 IRQ_INTD &sic 27
+
+			 0x1000 0 0 IRQ_INTA &sic 27
+			 0x1000 0 0 IRQ_INTB &sic 28
+			 0x1000 0 0 IRQ_INTC &sic 29
+			 0x1000 0 0 IRQ_INTD &sic 30
+
+			 0x0800 0 0 IRQ_INTA &sic 30
+			 0x0800 0 0 IRQ_INTB &sic 27
+			 0x0800 0 0 IRQ_INTC &sic 28
+			 0x0800 0 0 IRQ_INTD &sic 29
+
+			 0x0000 0 0 IRQ_INTA &sic 29
+			 0x0000 0 0 IRQ_INTB &sic 30
+			 0x0000 0 0 IRQ_INTC &sic 27
+			 0x0000 0 0 IRQ_INTD &sic 28>;
 };
diff --git a/Documentation/devicetree/bindings/pci/xgene-pci-msi.txt b/Documentation/devicetree/bindings/pci/xgene-pci-msi.txt
index 85d9b95234f7..0e84e6621b4a 100644
--- a/Documentation/devicetree/bindings/pci/xgene-pci-msi.txt
+++ b/Documentation/devicetree/bindings/pci/xgene-pci-msi.txt
@@ -57,11 +57,11 @@ SoC DTSI:
 			  0x02000000 0x00 0x80000000 0xe1 0x80000000 0x00 0x80000000>; /* mem */
 		dma-ranges = <0x42000000 0x80 0x00000000 0x80 0x00000000 0x00 0x80000000
 			      0x42000000 0x00 0x00000000 0x00 0x00000000 0x80 0x00000000>;
-		interrupt-map-mask = <0x0 0x0 0x0 0x7>;
-		interrupt-map = <0x0 0x0 0x0 0x1 &gic 0x0 0xc2 0x1
-				 0x0 0x0 0x0 0x2 &gic 0x0 0xc3 0x1
-				 0x0 0x0 0x0 0x3 &gic 0x0 0xc4 0x1
-				 0x0 0x0 0x0 0x4 &gic 0x0 0xc5 0x1>;
+		interrupt-map-mask = <0x0 0x0 0x0 IRQ_INT_ALL>;
+		interrupt-map = <0x0 0x0 0x0 IRQ_INTA &gic 0x0 0xc2 0x1
+				 0x0 0x0 0x0 IRQ_INTB &gic 0x0 0xc3 0x1
+				 0x0 0x0 0x0 IRQ_INTC &gic 0x0 0xc4 0x1
+				 0x0 0x0 0x0 IRQ_INTD &gic 0x0 0xc5 0x1>;
 		dma-coherent;
 		clocks = <&pcie0clk 0>;
 		msi-parent= <&msi>;
diff --git a/Documentation/devicetree/bindings/pci/xgene-pci.txt b/Documentation/devicetree/bindings/pci/xgene-pci.txt
index 92490330dc1c..0f0e3eb64101 100644
--- a/Documentation/devicetree/bindings/pci/xgene-pci.txt
+++ b/Documentation/devicetree/bindings/pci/xgene-pci.txt
@@ -39,11 +39,11 @@ Example:
 			  0x02000000 0x00 0x80000000 0xe1 0x80000000 0x00 0x80000000>; /* mem */
 		dma-ranges = <0x42000000 0x80 0x00000000 0x80 0x00000000 0x00 0x80000000
 			      0x42000000 0x00 0x00000000 0x00 0x00000000 0x80 0x00000000>;
-		interrupt-map-mask = <0x0 0x0 0x0 0x7>;
-		interrupt-map = <0x0 0x0 0x0 0x1 &gic 0x0 0xc2 0x1
-				 0x0 0x0 0x0 0x2 &gic 0x0 0xc3 0x1
-				 0x0 0x0 0x0 0x3 &gic 0x0 0xc4 0x1
-				 0x0 0x0 0x0 0x4 &gic 0x0 0xc5 0x1>;
+		interrupt-map-mask = <0x0 0x0 0x0 IRQ_INT_ALL>;
+		interrupt-map = <0x0 0x0 0x0 IRQ_INTA &gic 0x0 0xc2 0x1
+				 0x0 0x0 0x0 IRQ_INTB &gic 0x0 0xc3 0x1
+				 0x0 0x0 0x0 IRQ_INTC &gic 0x0 0xc4 0x1
+				 0x0 0x0 0x0 IRQ_INTD &gic 0x0 0xc5 0x1>;
 		dma-coherent;
 		clocks = <&pcie0clk 0>;
 	};
diff --git a/Documentation/devicetree/bindings/pci/xilinx-nwl-pcie.txt b/Documentation/devicetree/bindings/pci/xilinx-nwl-pcie.txt
index 01bf7fdf4c19..5964fdf752bc 100644
--- a/Documentation/devicetree/bindings/pci/xilinx-nwl-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/xilinx-nwl-pcie.txt
@@ -47,11 +47,11 @@ nwl_pcie: pcie@fd0e0000 {
 	interrupt-parent = <&gic>;
 	interrupts = <0 114 4>, <0 115 4>, <0 116 4>, <0 117 4>, <0 118 4>;
 	interrupt-names = "msi0", "msi1", "intx", "dummy", "misc";
-	interrupt-map-mask = <0x0 0x0 0x0 0x7>;
-	interrupt-map = <0x0 0x0 0x0 0x1 &pcie_intc 0x1>,
-			<0x0 0x0 0x0 0x2 &pcie_intc 0x2>,
-			<0x0 0x0 0x0 0x3 &pcie_intc 0x3>,
-			<0x0 0x0 0x0 0x4 &pcie_intc 0x4>;
+	interrupt-map-mask = <0x0 0x0 0x0 IRQ_INT_ALL>;
+	interrupt-map = <0x0 0x0 0x0 IRQ_INTA &pcie_intc 0x1>,
+			<0x0 0x0 0x0 IRQ_INTB &pcie_intc 0x2>,
+			<0x0 0x0 0x0 IRQ_INTC &pcie_intc 0x3>,
+			<0x0 0x0 0x0 IRQ_INTD &pcie_intc 0x4>;
 
 	msi-parent = <&nwl_pcie>;
 	reg = <0x0 0xfd0e0000 0x0 0x1000>,
diff --git a/Documentation/devicetree/bindings/pci/xilinx-pcie.txt b/Documentation/devicetree/bindings/pci/xilinx-pcie.txt
index fd57a81180a4..82b7d07bda51 100644
--- a/Documentation/devicetree/bindings/pci/xilinx-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/xilinx-pcie.txt
@@ -47,11 +47,11 @@ Zynq:
 		reg = < 0x50000000 0x1000000 >;
 		device_type = "pci";
 		interrupts = < 0 52 4 >;
-		interrupt-map-mask = <0 0 0 7>;
-		interrupt-map = <0 0 0 1 &pcie_intc 1>,
-				<0 0 0 2 &pcie_intc 2>,
-				<0 0 0 3 &pcie_intc 3>,
-				<0 0 0 4 &pcie_intc 4>;
+		interrupt-map-mask = <0 0 0 IRQ_INT_ALL>;
+		interrupt-map = <0 0 0 IRQ_INTA &pcie_intc 1>,
+				<0 0 0 IRQ_INTB &pcie_intc 2>,
+				<0 0 0 IRQ_INTC &pcie_intc 3>,
+				<0 0 0 IRQ_INTD &pcie_intc 4>;
 		ranges = < 0x02000000 0 0x60000000 0x60000000 0 0x10000000 >;
 
 		pcie_intc: interrupt-controller {
@@ -72,11 +72,11 @@ Microblaze:
 		device_type = "pci";
 		interrupt-parent = <&microblaze_0_intc>;
 		interrupts = <1 2>;
-		interrupt-map-mask = <0 0 0 7>;
-		interrupt-map = <0 0 0 1 &pcie_intc 1>,
-				<0 0 0 2 &pcie_intc 2>,
-				<0 0 0 3 &pcie_intc 3>,
-				<0 0 0 4 &pcie_intc 4>;
+		interrupt-map-mask = <0 0 0 IRQ_INT_ALL>;
+		interrupt-map = <0 0 0 IRQ_INTA &pcie_intc 1>,
+				<0 0 0 IRQ_INTB &pcie_intc 2>,
+				<0 0 0 IRQ_INTC &pcie_intc 3>,
+				<0 0 0 IRQ_INTD &pcie_intc 4>;
 		ranges = <0x02000000 0x00000000 0x80000000 0x80000000 0x00000000 0x10000000>;
 
 		pcie_intc: interrupt-controller {
-- 
2.21.0

