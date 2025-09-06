Return-Path: <linux-pci+bounces-35597-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47DD4B46F12
	for <lists+linux-pci@lfdr.de>; Sat,  6 Sep 2025 15:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 133B15A1F93
	for <lists+linux-pci@lfdr.de>; Sat,  6 Sep 2025 13:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35C42F0C6B;
	Sat,  6 Sep 2025 13:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="lPB73zZ5"
X-Original-To: linux-pci@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79F02F0689;
	Sat,  6 Sep 2025 13:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757166800; cv=none; b=ZtvLhzzanIoqiDhN8aRLNKrYsLKAjnLBvnIlMVqdL5xOiD/xDN2gNn6YUh67pdVD/ygWIT5bU7sEVcuBUPpTzP72JUt4RINn+epb8yVMjnldugijRbz4hpr+3zdbpQ9BUBzInNVaLKo9ZD+/79X19X0pQY7P+NDkwsCbV6g08o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757166800; c=relaxed/simple;
	bh=HWREdHG3YnglsO1xpZ5cZDYeUf4qqnVsw5wTGJIyxYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WttvQk4RlYaJW6a/Ra6pi2hLi8zWRiup4EsPgH0tuF/wK3Rnv2ynnLjFcoYj7y4m4We6mHUznErH0KsqkWDNdId14kRSR9Bt8pX4g/HdcIn/ZAAyNxX/dWBvMJjJjPxSs5ipqwtyIP0lCHlnRGRoScwqyAfmQqdsTFNKksP3SdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=lPB73zZ5; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 32B362072F;
	Sat,  6 Sep 2025 15:53:17 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9acWT6tHLmOh; Sat,  6 Sep 2025 15:53:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1757166796; bh=HWREdHG3YnglsO1xpZ5cZDYeUf4qqnVsw5wTGJIyxYE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lPB73zZ5HFQWeRVaZeab0F1DPNpkih931WxzhVIy40gnwElxXZQ524OtcdKGilkh9
	 uJna4epMkzb7jPnrX3yLAJHV30XxyolC31E8i+T5x1UgiVoFXzP4Tfx+yQSEmRyQaa
	 aVGpkii+XkWLAIXoIbdULfL3HQCw0UW9fd6fOD3f3up36vTRVoof8rD5BohgeaBuEL
	 SydcSii9yNOMhZNUfn5FuRVj5GGADMFI5D7I5L3Uxodijz911OlBfqN/i3yscj8B4V
	 7600XjmFUBN4m5NQeVMdb+KZILQzDmfPcQ+l1CiaKawEz0uLk5iXnLi0rZLxDLzxmI
	 EG/lN8ueuKo1A==
From: Yao Zi <ziyao@disroot.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Simon Xue <xxm@rock-chips.com>
Cc: linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jonas Karlman <jonas@kwiboo.se>,
	Chukun Pan <amadeus@jmu.edu.cn>,
	Yao Zi <ziyao@disroot.org>
Subject: [PATCH 2/3] arm64: dts: rockchip: Add PCIe Gen2x1 controller for RK3528
Date: Sat,  6 Sep 2025 13:52:45 +0000
Message-ID: <20250906135246.19398-3-ziyao@disroot.org>
In-Reply-To: <20250906135246.19398-1-ziyao@disroot.org>
References: <20250906135246.19398-1-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Describes the PCIe Gen2x1 controller integrated in RK3528 SoC. The SoC
doesn't provide a separate MSI controller, thus the one integrated in
designware PCIe IP must be used.

Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 arch/arm64/boot/dts/rockchip/rk3528.dtsi | 56 +++++++++++++++++++++++-
 1 file changed, 55 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3528.dtsi b/arch/arm64/boot/dts/rockchip/rk3528.dtsi
index db5dbcac7756..2d2af467e5ab 100644
--- a/arch/arm64/boot/dts/rockchip/rk3528.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3528.dtsi
@@ -7,6 +7,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/phy/phy.h>
 #include <dt-bindings/pinctrl/rockchip.h>
 #include <dt-bindings/clock/rockchip,rk3528-cru.h>
 #include <dt-bindings/power/rockchip,rk3528-power.h>
@@ -239,7 +240,7 @@ gmac0_clk: clock-gmac50m {
 
 	soc {
 		compatible = "simple-bus";
-		ranges = <0x0 0xfe000000 0x0 0xfe000000 0x0 0x2000000>;
+		ranges = <0x0 0xfc000000 0x0 0xfc000000 0x0 0x44400000>;
 		#address-cells = <2>;
 		#size-cells = <2>;
 
@@ -1133,6 +1134,59 @@ combphy: phy@ffdc0000 {
 			rockchip,pipe-phy-grf = <&pipe_phy_grf>;
 			status = "disabled";
 		};
+
+		pcie: pcie@fe4f0000 {
+			compatible = "rockchip,rk3528-pcie",
+				     "rockchip,rk3568-pcie";
+			reg = <0x1 0x40000000 0x0 0x400000>,
+			      <0x0 0xfe4f0000 0x0 0x10000>,
+			      <0x0 0xfc000000 0x0 0x100000>;
+			reg-names = "dbi", "apb", "config";
+			bus-range = <0x0 0xff>;
+			clocks = <&cru ACLK_PCIE>, <&cru HCLK_PCIE_SLV>,
+				 <&cru HCLK_PCIE_DBI>, <&cru PCLK_PCIE>,
+				 <&cru CLK_PCIE_AUX>, <&cru PCLK_PCIE_PHY>;
+			clock-names = "aclk_mst", "aclk_slv",
+				      "aclk_dbi", "pclk",
+				      "aux", "pipe";
+			device_type = "pci";
+			interrupts = <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "sys", "pmc", "msg", "legacy", "err",
+					  "msi";
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 7>;
+			interrupt-map = <0 0 0 1 &pcie_intc 0>,
+					<0 0 0 2 &pcie_intc 1>,
+					<0 0 0 3 &pcie_intc 2>,
+					<0 0 0 4 &pcie_intc 3>;
+			linux,pci-domain = <0>;
+			max-link-speed = <2>;
+			num-lanes = <1>;
+			phys = <&combphy PHY_TYPE_PCIE>;
+			phy-names = "pcie-phy";
+			power-domains = <&power RK3528_PD_VPU>;
+			ranges = <0x01000000 0x0 0xfc100000 0x0 0xfc100000 0x0 0x100000>,
+				 <0x02000000 0x0 0xfc200000 0x0 0xfc200000 0x0 0x1e00000>,
+				 <0x03000000 0x1 0x00000000 0x1 0x00000000 0x0 0x40000000>;
+			resets = <&cru SRST_PCIE_POWER_UP>, <&cru SRST_P_PCIE>;
+			reset-names = "pwr", "pipe";
+			#address-cells = <3>;
+			#size-cells = <2>;
+			status = "disabled";
+
+			pcie_intc: legacy-interrupt-controller {
+				interrupt-controller;
+				interrupt-parent = <&gic>;
+				interrupts = <GIC_SPI 155 IRQ_TYPE_EDGE_RISING>;
+				#address-cells = <0>;
+				#interrupt-cells = <1>;
+			};
+		};
 	};
 };
 
-- 
2.50.1


