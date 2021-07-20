Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33EB63CF5CB
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jul 2021 10:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233854AbhGTHaB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Jul 2021 03:30:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:49072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233139AbhGTH2l (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Jul 2021 03:28:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7DE61611EF;
        Tue, 20 Jul 2021 08:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626768559;
        bh=hFWGGPOo8IffrLf2mAyywYfMVp92Yc9SBhf1dfFMTcw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cskzJO8Wsov2c4ra3deXGnRxhUJ99gXPfQ9TR9REzInKuig+awftl8pwt6MVRn2r9
         7TDNmOxeoOVR9s6c2giHXTdo05wVQr5puhSprwM8XG0vjl0IZc0Uru/8G3u5kJKL9v
         YJQeFvKAqbhwk9ON6jHDsdEMZSKcs+62Euuud+Q1ZhtwLi8Y371XSbW04nQbdPmORD
         FnFCf6D+4W8xt1HGmndiJWX82JiRlPSRtxaSNHxBLKNT2906gcr2LqPsoWflzFQQgS
         /Pa9dOIBPyg+mRidgpOimmY13JiUS1xGwxQDOGyr99dSfn1vNIzW1fG2Mi4S+oVFCJ
         RH5v2bUeJAA3Q==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1m5koX-000eTZ-Ou; Tue, 20 Jul 2021 10:09:17 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>, Rob Herring <robh@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Wei Xu <xuwei5@hisilicon.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH v6 7/9] arm64: dts: HiSilicon: Add support for HiKey 970 PCIe controller hardware
Date:   Tue, 20 Jul 2021 10:09:09 +0200
Message-Id: <7ede6693e5cc2bbd23c1a68cbc571b5f4876917d.1626768323.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1626768323.git.mchehab+huawei@kernel.org>
References: <cover.1626768323.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Add DTS bindings for the HiKey 970 board's PCIe hardware.

Co-developed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 arch/arm64/boot/dts/hisilicon/hi3670.dtsi     | 71 +++++++++++++++++++
 .../boot/dts/hisilicon/hikey970-pmic.dtsi     |  1 -
 drivers/pci/controller/dwc/pcie-kirin.c       | 12 ----
 3 files changed, 71 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
index 1f228612192c..6dfcfcfeedae 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
@@ -177,6 +177,12 @@ sctrl: sctrl@fff0a000 {
 			#clock-cells = <1>;
 		};
 
+		pmctrl: pmctrl@fff31000 {
+			compatible = "hisilicon,hi3670-pmctrl", "syscon";
+			reg = <0x0 0xfff31000 0x0 0x1000>;
+			#clock-cells = <1>;
+		};
+
 		iomcu: iomcu@ffd7e000 {
 			compatible = "hisilicon,hi3670-iomcu", "syscon";
 			reg = <0x0 0xffd7e000 0x0 0x1000>;
@@ -660,6 +666,71 @@ gpio28: gpio@fff1d000 {
 			clock-names = "apb_pclk";
 		};
 
+		its_pcie: interrupt-controller@f4000000 {
+			compatible = "arm,gic-v3-its";
+			msi-controller;
+			reg = <0x0 0xf5100000 0x0 0x100000>;
+		};
+
+		pcie_phy: pcie-phy@fc000000 {
+			compatible = "hisilicon,hi970-pcie-phy";
+			reg = <0x0 0xfc000000 0x0 0x80000>;
+
+			phy-supply = <&ldo33>;
+
+			clocks = <&crg_ctrl HI3670_CLK_GATE_PCIEPHY_REF>,
+				 <&crg_ctrl HI3670_CLK_GATE_PCIEAUX>,
+				 <&crg_ctrl HI3670_PCLK_GATE_PCIE_PHY>,
+				 <&crg_ctrl HI3670_PCLK_GATE_PCIE_SYS>,
+				 <&crg_ctrl HI3670_ACLK_GATE_PCIE>;
+			clock-names = "phy_ref", "aux",
+				      "apb_phy", "apb_sys",
+				      "aclk";
+
+			reset-gpios = <&gpio7 0 0 >, <&gpio25 2 0 >,
+				      <&gpio3 1 0 >, <&gpio27 4 0 >;
+
+			clkreq-gpios = <&gpio20 6 0 >, <&gpio27 3 0 >,
+				       <&gpio17 0 0 >;
+
+			/* vboost iboost pre post main */
+			hisilicon,eye-diagram-param = <0xFFFFFFFF 0xFFFFFFFF
+						       0xFFFFFFFF 0xFFFFFFFF
+						       0xFFFFFFFF>;
+
+			#phy-cells = <0>;
+		};
+
+		pcie@f4000000 {
+			compatible = "hisilicon,kirin970-pcie";
+			reg = <0x0 0xf4000000 0x0 0x1000000>,
+			      <0x0 0xfc180000 0x0 0x1000>,
+			      <0x0 0xf5000000 0x0 0x2000>;
+			reg-names = "dbi", "apb", "config";
+			bus-range = <0x0  0x1>;
+			msi-parent = <&its_pcie>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			phys = <&pcie_phy>;
+			ranges = <0x02000000 0x0 0x00000000
+				  0x0 0xf6000000
+				  0x0 0x02000000>;
+			num-lanes = <1>;
+			#interrupt-cells = <1>;
+			interrupts = <0 283 4>;
+			interrupt-names = "msi";
+			interrupt-map-mask = <0 0 0 7>;
+			interrupt-map = <0x0 0 0 1
+					 &gic GIC_SPI 282 IRQ_TYPE_LEVEL_HIGH>,
+					<0x0 0 0 2
+					 &gic GIC_SPI 283 IRQ_TYPE_LEVEL_HIGH>,
+					<0x0 0 0 3
+					 &gic GIC_SPI 284 IRQ_TYPE_LEVEL_HIGH>,
+					<0x0 0 0 4
+					 &gic GIC_SPI 285 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
 		/* UFS */
 		ufs: ufs@ff3c0000 {
 			compatible = "hisilicon,hi3670-ufs", "jedec,ufs-2.1";
diff --git a/arch/arm64/boot/dts/hisilicon/hikey970-pmic.dtsi b/arch/arm64/boot/dts/hisilicon/hikey970-pmic.dtsi
index 48c739eacba0..03452e627641 100644
--- a/arch/arm64/boot/dts/hisilicon/hikey970-pmic.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hikey970-pmic.dtsi
@@ -73,7 +73,6 @@ ldo33: LDO33 { /* PEX8606 */
 					regulator-name = "ldo33";
 					regulator-min-microvolt = <2500000>;
 					regulator-max-microvolt = <3300000>;
-					regulator-boot-on;
 				};
 
 				ldo34: LDO34 { /* GPS AUX IN VDD */
diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
index 7a92f633d746..4657a6d33f6f 100644
--- a/drivers/pci/controller/dwc/pcie-kirin.c
+++ b/drivers/pci/controller/dwc/pcie-kirin.c
@@ -347,18 +347,6 @@ static const struct regmap_config pcie_kirin_regmap_conf = {
 	.reg_stride = 4,
 };
 
-/* Registers in PCIeCTRL */
-static inline void kirin_apb_ctrl_writel(struct kirin_pcie *kirin_pcie,
-					 u32 val, u32 reg)
-{
-	writel(val, kirin_pcie->apb_base + reg);
-}
-
-static inline u32 kirin_apb_ctrl_readl(struct kirin_pcie *kirin_pcie, u32 reg)
-{
-	return readl(kirin_pcie->apb_base + reg);
-}
-
 static long kirin_pcie_get_resource(struct kirin_pcie *kirin_pcie,
 				    struct platform_device *pdev)
 {
-- 
2.31.1

