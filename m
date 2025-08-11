Return-Path: <linux-pci+bounces-33833-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70212B21CA5
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 07:05:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 292571889A5B
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 05:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919272E2DD9;
	Tue, 12 Aug 2025 05:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="RdyvJPvv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149E32E62CF
	for <linux-pci@vger.kernel.org>; Tue, 12 Aug 2025 05:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754974964; cv=none; b=E4XqNYA5FoQrj5w6Ux3teqZCBcanUGAiZB+L/q21Z4PKWwWszWGQuUipIosYMwwijUiisw0gONI+uUGW1xEyARV2eusUdAEzrP9pz2CejvN+FIb8ITPSpFxxBJxxGUjEv8GrUjP1GXE+pPFkeTsP99/kQ8atv/cGI0xAgMc7b3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754974964; c=relaxed/simple;
	bh=L7C0xr/WBrl/p6MxwQRpjLnBG9fB3gAS6iEdt3Ry9Kc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=ovktCwUFfWRsxQpAUwlg7H2u7XSbzzfBUIL8f5cTiqTzGcwBmbRdledTuQDvF7x1FoZyEXvElfr5rn7G4U5h0iGeErQkj3IPTXD+/f5RgQ3UCLkwrcltSNE6VNqnYmZKnxGFEzzvI3O1sAXHW5eMANmchLH9ikfGSIcfbADMWMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=RdyvJPvv; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250812050240epoutp0162d06e20090035fc3c561b0ad40367fc~a7G2jBP031032510325epoutp018
	for <linux-pci@vger.kernel.org>; Tue, 12 Aug 2025 05:02:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250812050240epoutp0162d06e20090035fc3c561b0ad40367fc~a7G2jBP031032510325epoutp018
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1754974960;
	bh=GbttRDwtQL6F01nXCzc3MsPtDdrZZyXIeBWI7o9ayMM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RdyvJPvvGWYDdNmZJxikTLkYHJk7q0pMFc7VAr6fhRVzlBpA0QJ0dAlc3twsm0L3o
	 tFGJg8U/4Z5FsdNvhwKCe2ZcUcVaOEW4oPMycdqYd9mI0LCHDNZBx8prDAg33d4ogz
	 Jc0llaqcuvFHMR3hSJwiucvJlTn9sN1s4LuymCi4=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20250812050239epcas5p2665d847e9747feb3822dd9ef7bf52bc8~a7G155p7l1168411684epcas5p20;
	Tue, 12 Aug 2025 05:02:39 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.93]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4c1KBQ4T9Cz2SSKy; Tue, 12 Aug
	2025 05:02:38 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20250811154746epcas5p261ba0c811f9dd8748f8f241b76be6525~awQz1S7tk3176231762epcas5p2X;
	Mon, 11 Aug 2025 15:47:46 +0000 (GMT)
Received: from cheetah.samsungds.net (unknown [107.109.115.53]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250811154743epsmtip137f9e1f9210743d87301c6ac42b9438d~awQxMaCYf2596225962epsmtip1K;
	Mon, 11 Aug 2025 15:47:43 +0000 (GMT)
From: Shradha Todi <shradha.t@samsung.com>
To: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
Cc: mani@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org,
	robh@kernel.org, bhelgaas@google.com, jingoohan1@gmail.com,
	krzk+dt@kernel.org, conor+dt@kernel.org, alim.akhtar@samsung.com,
	vkoul@kernel.org, kishon@kernel.org, arnd@arndb.de,
	m.szyprowski@samsung.com, jh80.chung@samsung.com, pankaj.dubey@samsung.com,
	Shradha Todi <shradha.t@samsung.com>
Subject: [PATCH v3 12/12] arm64: dts: fsd: Add PCIe support for Tesla FSD
 SoC
Date: Mon, 11 Aug 2025 21:16:38 +0530
Message-ID: <20250811154638.95732-13-shradha.t@samsung.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250811154638.95732-1-shradha.t@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250811154746epcas5p261ba0c811f9dd8748f8f241b76be6525
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-541,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250811154746epcas5p261ba0c811f9dd8748f8f241b76be6525
References: <20250811154638.95732-1-shradha.t@samsung.com>
	<CGME20250811154746epcas5p261ba0c811f9dd8748f8f241b76be6525@epcas5p2.samsung.com>

Add the support for PCIe controller driver and phy driver for Tesla FSD.
It includes support for both RC and EP.

Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Signed-off-by: Shradha Todi <shradha.t@samsung.com>
---
 arch/arm64/boot/dts/tesla/fsd-evb.dts      |  34 +++++
 arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi |  65 +++++++++
 arch/arm64/boot/dts/tesla/fsd.dtsi         | 147 +++++++++++++++++++++
 3 files changed, 246 insertions(+)

diff --git a/arch/arm64/boot/dts/tesla/fsd-evb.dts b/arch/arm64/boot/dts/tesla/fsd-evb.dts
index 9ff22e1c8723..1b63c5d72d19 100644
--- a/arch/arm64/boot/dts/tesla/fsd-evb.dts
+++ b/arch/arm64/boot/dts/tesla/fsd-evb.dts
@@ -130,3 +130,37 @@ &serial_0 {
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
index a5ebb3f9b18f..8ed8d2131855 100644
--- a/arch/arm64/boot/dts/tesla/fsd.dtsi
+++ b/arch/arm64/boot/dts/tesla/fsd.dtsi
@@ -1009,6 +1009,16 @@ ethernet1: ethernet@14300000 {
 			status = "disabled";
 		};
 
+		pciephy0: pcie-phy@15080000 {
+			compatible = "tesla,fsd-pcie-phy0";
+			reg = <0x0 0x15080000 0x0 0x2000>,
+			      <0x0 0x150a0000 0x0 0x1000>;
+			#phy-cells = <0>;
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
+			phys = <&pciephy0>;
+			iommu-map = <0x0 &smmu_fsys0 0x4 0x10000>;
+			iommu-map-mask = <0x0>;
+			samsung,syscon-pcie = <&sysreg_fsys0 0x434>;
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
+			phys = <&pciephy0>;
+			samsung,syscon-pcie = <&sysreg_fsys0 0x434>;
+			status = "disabled";
+		};
+
+		pciephy1: pcie-phy@16880000 {
+			compatible = "tesla,fsd-pcie-phy1";
+			reg = <0x0 0x16880000 0x0 0x2000>,
+			      <0x0 0x16860000 0x0 0x1000>;
+			#phy-cells = <0>;
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
+			phys = <&pciephy1>;
+			iommu-map = <0x0 &smmu_imem 0x0 0x10000>;
+			iommu-map-mask = <0x0>;
+			samsung,syscon-pcie = <&sysreg_fsys1 0x50c>;
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
+			phys = <&pciephy1>;
+			samsung,syscon-pcie = <&sysreg_fsys1 0x50c>;
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
+			phys = <&pciephy1>;
+			samsung,syscon-pcie = <&sysreg_fsys1 0x510>;
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
+			phys = <&pciephy1>;
+			samsung,syscon-pcie = <&sysreg_fsys1 0x510>;
+			status = "disabled";
+		};
 	};
 };
 
-- 
2.49.0


