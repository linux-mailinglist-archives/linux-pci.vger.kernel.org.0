Return-Path: <linux-pci+bounces-30680-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53BDDAE944A
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 04:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AE3A7B3AC9
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 02:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D797220E6F7;
	Thu, 26 Jun 2025 02:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="QjzfzeDz"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86C023770A
	for <linux-pci@vger.kernel.org>; Thu, 26 Jun 2025 02:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750905482; cv=none; b=OuPituzf+q7auyOMpaDEaPathxSeh9Uzy/V/Rq2RAWxqElu8eANl3sJWNoa80eZ80slupNqvpJAHHW94edl+Yv5GNonwGR+rZHOyFzo1r3alIeUYqlcqALPPB2PZs2oitefzCk5GGrQDe7/X2CfbdnmtTqBmoMH8cMg0GtpqwFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750905482; c=relaxed/simple;
	bh=FKLQu0+uWVlKGUZ1wJN/GzcsmbKVFDMojnxvBYfT7v8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=X09784v/NqpZwOXP6gKRoBHmS7GqWWzM0LRog01KSdj8GUf8p090byhbtrEvv79EhFidM6n3Knm2as+Y6LLJdxrNJwIJiiUtEWcpWPBg4lk3PraMi9x92Yi+rdV36+a1B3p5dFc5myohdPbjNVYhV85xmFipFQoIW1dCpqlfQJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=QjzfzeDz; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250626023759epoutp0422cf202a8406efdcb3ac947374bd6efd~Md0GyBdB52539025390epoutp04q
	for <linux-pci@vger.kernel.org>; Thu, 26 Jun 2025 02:37:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250626023759epoutp0422cf202a8406efdcb3ac947374bd6efd~Md0GyBdB52539025390epoutp04q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1750905479;
	bh=g/dIw6y8kcmo8LyyHZHnCh5ijJd2K5kh6Hh1rXMgcz4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QjzfzeDzSu11dJtU03IFmwks7HTQtYobUEFeMtWjMBlywO7uzes2YYd8QVLSOtzNb
	 xV3gy+hvjB0DJKC2xaOC5CiHMR0USNCj4my89vu8oW/lGZV6DXFJOcx5t/xV0GagR1
	 Cv6i/jA1JK+cEm5e/HubiGjbaefCAAWMcli237Uw=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20250626023758epcas5p4b32b1be235660e5c1f067356e4728958~Md0GSjQ4W0510205102epcas5p44;
	Thu, 26 Jun 2025 02:37:58 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.179]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4bSNC838BWz6B9m5; Thu, 26 Jun
	2025 02:37:56 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250625165332epcas5p4e138b7f7c8ebb938dc526c5dc29412bb~MV1z_GoE62849628496epcas5p4H;
	Wed, 25 Jun 2025 16:53:32 +0000 (GMT)
Received: from cheetah.samsungds.net (unknown [107.109.115.53]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250625165329epsmtip2fc6e559e500702fdd2b1ad06ee61e433~MV1xNmFnm1255612556epsmtip2e;
	Wed, 25 Jun 2025 16:53:28 +0000 (GMT)
From: Shradha Todi <shradha.t@samsung.com>
To: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-fsd@tesla.com
Cc: manivannan.sadhasivam@linaro.org, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, bhelgaas@google.com, jingoohan1@gmail.com,
	krzk+dt@kernel.org, conor+dt@kernel.org, alim.akhtar@samsung.com,
	vkoul@kernel.org, kishon@kernel.org, arnd@arndb.de,
	m.szyprowski@samsung.com, jh80.chung@samsung.com, pankaj.dubey@samsung.com,
	Shradha Todi <shradha.t@samsung.com>
Subject: [PATCH v2 10/10] arm64: dts: fsd: Add PCIe support for Tesla FSD
 SoC
Date: Wed, 25 Jun 2025 22:22:29 +0530
Message-ID: <20250625165229.3458-11-shradha.t@samsung.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250625165229.3458-1-shradha.t@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250625165332epcas5p4e138b7f7c8ebb938dc526c5dc29412bb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-541,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250625165332epcas5p4e138b7f7c8ebb938dc526c5dc29412bb
References: <20250625165229.3458-1-shradha.t@samsung.com>
	<CGME20250625165332epcas5p4e138b7f7c8ebb938dc526c5dc29412bb@epcas5p4.samsung.com>

Add the support for PCIe controller driver and phy driver for Tesla FSD.
It includes support for both RC and EP.

Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Signed-off-by: Shradha Todi <shradha.t@samsung.com>
---
 arch/arm64/boot/dts/tesla/fsd-evb.dts      |  36 +++++
 arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi |  65 +++++++++
 arch/arm64/boot/dts/tesla/fsd.dtsi         | 147 +++++++++++++++++++++
 3 files changed, 248 insertions(+)

diff --git a/arch/arm64/boot/dts/tesla/fsd-evb.dts b/arch/arm64/boot/dts/tesla/fsd-evb.dts
index 9ff22e1c8723..c8f2019e6abf 100644
--- a/arch/arm64/boot/dts/tesla/fsd-evb.dts
+++ b/arch/arm64/boot/dts/tesla/fsd-evb.dts
@@ -19,6 +19,8 @@ / {
 	aliases {
 		serial0 = &serial_0;
 		serial1 = &serial_1;
+		pciephy0 = &pciephy0;
+		pciephy1 = &pciephy1;
 	};
 
 	chosen {
@@ -130,3 +132,37 @@ &serial_0 {
 &ufs {
 	status = "okay";
 };
+
+&pcierc2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie1_clkreq>, <&pcie1_wake>, <&pcie1_preset>,
+			<&pcie0_slot1>;
+};
+
+&pcieep2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie1_clkreq>, <&pcie1_wake>, <&pcie1_preset>,
+			<&pcie0_slot1>;
+};
+
+&pcierc0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie0_clkreq>, <&pcie0_wake0>, <&pcie0_preset0>,
+			 <&pcie0_slot0>;
+};
+
+&pcieep0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie0_clkreq>, <&pcie0_wake0>, <&pcie0_preset0>,
+			 <&pcie0_slot0>;
+};
+
+&pcierc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie0_clkreq>, <&pcie0_wake1>, <&pcie0_preset0>;
+};
+
+&pcieep1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie0_clkreq>, <&pcie0_wake1>, <&pcie0_preset0>;
+};
diff --git a/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi b/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi
index 6f4658f57453..fa99aa4b9906 100644
--- a/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi
+++ b/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi
@@ -120,6 +120,27 @@ eth0_mdio: eth0-mdio-pins {
 		samsung,pin-pud = <FSD_PIN_PULL_NONE>;
 		samsung,pin-drv = <FSD_PIN_DRV_LV4>;
 	};
+
+	pcie1_clkreq: pcie1-clkreq-pins {
+		samsung,pins = "gpf6-0";
+		samsung,pin-function = <FSD_PIN_FUNC_2>;
+		samsung,pin-pud = <FSD_PIN_PULL_UP>;
+		samsung,pin-drv = <FSD_PIN_DRV_LV4>;
+	};
+
+	pcie1_wake: pcie1-wake-pins {
+		samsung,pins = "gpf6-1";
+		samsung,pin-function = <FSD_PIN_FUNC_2>;
+		samsung,pin-pud = <FSD_PIN_PULL_UP>;
+		samsung,pin-drv = <FSD_PIN_DRV_LV4>;
+	};
+
+	pcie1_preset: pcie1-preset-pins {
+		samsung,pins = "gpf6-2";
+		samsung,pin-function = <FSD_PIN_FUNC_2>;
+		samsung,pin-pud = <FSD_PIN_PULL_UP>;
+		samsung,pin-drv = <FSD_PIN_DRV_LV4>;
+	};
 };
 
 &pinctrl_peric {
@@ -493,6 +514,50 @@ eth1_mdio: eth1-mdio-pins {
 		samsung,pin-pud = <FSD_PIN_PULL_UP>;
 		samsung,pin-drv = <FSD_PIN_DRV_LV4>;
 	};
+
+	pcie0_clkreq: pcie0-clkreq-pins {
+		samsung,pins = "gpc8-0";
+		samsung,pin-function = <FSD_PIN_FUNC_2>;
+		samsung,pin-pud = <FSD_PIN_PULL_UP>;
+		samsung,pin-drv = <FSD_PIN_DRV_LV4>;
+	};
+
+	pcie0_wake0: pcie0-wake0-pins {
+		samsung,pins = "gpc8-1";
+		samsung,pin-function = <FSD_PIN_FUNC_2>;
+		samsung,pin-pud = <FSD_PIN_PULL_UP>;
+		samsung,pin-drv = <FSD_PIN_DRV_LV4>;
+	};
+
+	pcie0_preset0: pcie0-preset0-pins {
+		samsung,pins = "gpc8-2";
+		samsung,pin-function = <FSD_PIN_FUNC_2>;
+		samsung,pin-pud = <FSD_PIN_PULL_UP>;
+		samsung,pin-drv = <FSD_PIN_DRV_LV4>;
+	};
+
+	pcie0_wake1: pcie0-wake1-pins {
+		samsung,pins = "gpc8-3";
+		samsung,pin-function = <FSD_PIN_FUNC_2>;
+		samsung,pin-pud = <FSD_PIN_PULL_UP>;
+		samsung,pin-drv = <FSD_PIN_DRV_LV4>;
+	};
+
+	pcie0_slot0: pcie0-gpio22-pins {
+		samsung,pins = "gpg2-6";
+		samsung,pin-function = <FSD_PIN_FUNC_OUTPUT>;
+		samsung,pin-pud = <FSD_PIN_PULL_UP>;
+		samsung,pin-drv = <FSD_PIN_DRV_LV4>;
+		samsung,pin-val = <1>;
+	};
+
+	pcie0_slot1: pcie0-gpio23-pins {
+		samsung,pins = "gpg2-7";
+		samsung,pin-function = <FSD_PIN_FUNC_OUTPUT>;
+		samsung,pin-pud = <FSD_PIN_PULL_UP>;
+		samsung,pin-drv = <FSD_PIN_DRV_LV4>;
+		samsung,pin-val = <1>;
+	};
 };
 
 &pinctrl_pmu {
diff --git a/arch/arm64/boot/dts/tesla/fsd.dtsi b/arch/arm64/boot/dts/tesla/fsd.dtsi
index a5ebb3f9b18f..9e2d095546fa 100644
--- a/arch/arm64/boot/dts/tesla/fsd.dtsi
+++ b/arch/arm64/boot/dts/tesla/fsd.dtsi
@@ -1009,6 +1009,16 @@ ethernet1: ethernet@14300000 {
 			status = "disabled";
 		};
 
+		pciephy0: pcie-phy@15080000 {
+			compatible = "tesla,fsd-pcie-phy";
+			#phy-cells = <0>;
+			reg = <0x0 0x15080000 0x0 0x2000>,
+			      <0x0 0x150a0000 0x0 0x1000>;
+			samsung,pmu-syscon = <&pmu_system_controller>;
+			samsung,fsys-sysreg = <&sysreg_fsys0>;
+			status = "disabled";
+		};
+
 		ufs: ufs@15120000 {
 			compatible = "tesla,fsd-ufs";
 			reg = <0x0 0x15120000 0x0 0x200>,  /* 0: HCI standard */
@@ -1057,6 +1067,143 @@ ethernet0: ethernet@15300000 {
 			iommus = <&smmu_fsys0 0x0 0x1>;
 			status = "disabled";
 		};
+
+		pcierc2: pcie@15400000 {
+			compatible = "tesla,fsd-pcie";
+			reg = <0x0 0x15400000 0x0 0x2000>,
+			      <0x0 0x15090000 0x0 0x1000>,
+			      <0x0 0x15800000 0x0 0x1000>;
+			reg-names = "dbi", "elbi", "config";
+			ranges =  <0x82000000 0 0x15801000 0 0x15801000 0 0xffefff>;
+			clocks = <&clock_fsys0 PCIE_SUBCTRL_INST0_AUX_CLK_SOC>,
+				 <&clock_fsys0 PCIE_SUBCTRL_INST0_DBI_ACLK_SOC>,
+				 <&clock_fsys0 PCIE_SUBCTRL_INST0_MSTR_ACLK_SOC>,
+				 <&clock_fsys0 PCIE_SUBCTRL_INST0_SLV_ACLK_SOC>;
+			clock-names = "aux", "dbi", "mstr", "slv";
+			#address-cells = <3>;
+			#size-cells = <2>;
+			dma-coherent;
+			device_type = "pci";
+			interrupts = <GIC_SPI 93 IRQ_TYPE_EDGE_RISING>;
+			num-lanes = <4>;
+			samsung,syscon-pcie = <&sysreg_fsys0 0x434>;
+			phys = <&pciephy0>;
+			iommu-map = <0x0 &smmu_fsys0 0x4 0x10000>;
+			iommu-map-mask = <0x0>;
+			status = "disabled";
+		};
+
+		pcieep2: pcie-ep@15400000 {
+			compatible = "tesla,fsd-pcie-ep";
+			reg = <0x0 0x15090000 0x0 0x1000>,
+			      <0x0 0x15400000 0x0 0x2000>,
+			      <0x0 0x15402000 0x0 0x80>,
+			      <0x0 0x15800000 0x0 0xff0000>;
+			reg-names = "elbi", "dbi", "dbi2", "addr_space";
+			clocks = <&clock_fsys0 PCIE_SUBCTRL_INST0_AUX_CLK_SOC>,
+				 <&clock_fsys0 PCIE_SUBCTRL_INST0_DBI_ACLK_SOC>,
+				 <&clock_fsys0 PCIE_SUBCTRL_INST0_MSTR_ACLK_SOC>,
+				 <&clock_fsys0 PCIE_SUBCTRL_INST0_SLV_ACLK_SOC>;
+			clock-names = "aux", "dbi", "mstr", "slv";
+			num-lanes = <4>;
+			samsung,syscon-pcie = <&sysreg_fsys0 0x434>;
+			phys = <&pciephy0>;
+			status = "disabled";
+		};
+
+		pciephy1: pcie-phy@16880000 {
+			compatible = "tesla,fsd-pcie-phy";
+			#phy-cells = <0>;
+			reg = <0x0 0x16880000 0x0 0x2000>,
+			      <0x0 0x16860000 0x0 0x1000>;
+			samsung,pmu-syscon = <&pmu_system_controller>;
+			samsung,fsys-sysreg = <&sysreg_fsys1>;
+			status = "disabled";
+		};
+
+		pcierc0: pcie@16a00000 {
+			compatible = "tesla,fsd-pcie";
+			reg = <0x0 0x16a00000 0x0 0x2000>,
+			      <0x0 0x168b0000 0x0 0x1000>,
+			      <0x0 0x17000000 0x0 0x1000>;
+			reg-names = "dbi", "elbi", "config";
+			ranges =  <0x82000000 0 0x17001000 0 0x17001000 0 0xffefff>;
+			clocks = <&clock_fsys1 PCIE_LINK0_IPCLKPORT_AUX_ACLK>,
+				 <&clock_fsys1 PCIE_LINK0_IPCLKPORT_DBI_ACLK>,
+				 <&clock_fsys1 PCIE_LINK0_IPCLKPORT_MSTR_ACLK>,
+				 <&clock_fsys1 PCIE_LINK0_IPCLKPORT_SLV_ACLK>;
+			clock-names = "aux", "dbi", "mstr", "slv";
+			#address-cells = <3>;
+			#size-cells = <2>;
+			dma-coherent;
+			device_type = "pci";
+			interrupts = <GIC_SPI 115 IRQ_TYPE_EDGE_RISING>;
+			num-lanes = <4>;
+			samsung,syscon-pcie = <&sysreg_fsys1 0x50c>;
+			phys = <&pciephy1>;
+			iommu-map = <0x0 &smmu_imem 0x0 0x10000>;
+			iommu-map-mask = <0x0>;
+			status = "disabled";
+		};
+
+		pcieep0: pcie-ep@16a00000 {
+			compatible = "tesla,fsd-pcie-ep";
+			reg = <0x0 0x168b0000 0x0 0x1000>,
+			      <0x0 0x16a00000 0x0 0x2000>,
+			      <0x0 0x16a02000 0x0 0x80>,
+			      <0x0 0x17000000 0x0 0xff0000>;
+			reg-names = "elbi", "dbi", "dbi2", "addr_space";
+			clocks = <&clock_fsys1 PCIE_LINK0_IPCLKPORT_AUX_ACLK>,
+				 <&clock_fsys1 PCIE_LINK0_IPCLKPORT_DBI_ACLK>,
+				 <&clock_fsys1 PCIE_LINK0_IPCLKPORT_MSTR_ACLK>,
+				 <&clock_fsys1 PCIE_LINK0_IPCLKPORT_SLV_ACLK>;
+			clock-names = "aux", "dbi", "mstr", "slv";
+			num-lanes = <4>;
+			samsung,syscon-pcie = <&sysreg_fsys1 0x50c>;
+			phys = <&pciephy1>;
+			status = "disabled";
+		};
+
+		pcierc1: pcie@16b00000 {
+			compatible = "tesla,fsd-pcie";
+			reg = <0x0 0x16b00000 0x0 0x2000>,
+			      <0x0 0x168c0000 0x0 0x1000>,
+			      <0x0 0x18000000 0x0 0x1000>;
+			reg-names = "dbi", "elbi", "config";
+			ranges =  <0x82000000 0 0x18001000 0 0x18001000 0 0xffefff>;
+			clocks = <&clock_fsys1 PCIE_LINK1_IPCLKPORT_AUX_ACLK>,
+				 <&clock_fsys1 PCIE_LINK1_IPCLKPORT_DBI_ACLK>,
+				 <&clock_fsys1 PCIE_LINK1_IPCLKPORT_MSTR_ACLK>,
+				 <&clock_fsys1 PCIE_LINK1_IPCLKPORT_SLV_ACLK>;
+			clock-names = "aux", "dbi", "mstr", "slv";
+			#address-cells = <3>;
+			#size-cells = <2>;
+			dma-coherent;
+			device_type = "pci";
+			interrupts = <GIC_SPI 117 IRQ_TYPE_EDGE_RISING>;
+			num-lanes = <4>;
+			samsung,syscon-pcie = <&sysreg_fsys1 0x510>;
+			phys = <&pciephy1>;
+			status = "disabled";
+		};
+
+		pcieep1: pcie-ep@16b00000 {
+			compatible = "tesla,fsd-pcie-ep";
+			reg = <0x0 0x168c0000 0x0 0x1000>,
+			      <0x0 0x16b00000 0x0 0x2000>,
+			      <0x0 0x16b02000 0x0 0x80>,
+			      <0x0 0x18000000 0x0 0xff0000>;
+			reg-names = "elbi", "dbi", "dbi2", "addr_space";
+			clocks = <&clock_fsys1 PCIE_LINK1_IPCLKPORT_AUX_ACLK>,
+				 <&clock_fsys1 PCIE_LINK1_IPCLKPORT_DBI_ACLK>,
+				 <&clock_fsys1 PCIE_LINK1_IPCLKPORT_MSTR_ACLK>,
+				 <&clock_fsys1 PCIE_LINK1_IPCLKPORT_SLV_ACLK>;
+			clock-names = "aux", "dbi", "mstr", "slv";
+			num-lanes = <4>;
+			samsung,syscon-pcie = <&sysreg_fsys1 0x510>;
+			phys = <&pciephy1>;
+			status = "disabled";
+		};
 	};
 };
 
-- 
2.49.0


