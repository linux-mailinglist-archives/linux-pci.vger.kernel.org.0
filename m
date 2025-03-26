Return-Path: <linux-pci+bounces-24743-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE643A7122A
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 09:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB1B33B3FCA
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 08:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16C31A3168;
	Wed, 26 Mar 2025 08:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rD0sqafh"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B7E1A2398;
	Wed, 26 Mar 2025 08:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742976664; cv=none; b=Hgf9DLVIgliTrNTQuBZC7lgK+A5wX/jmzQJr9EHDrAaqLwOTtRN/KD9tMyZyDIwsyLksBVIImnxHD5OPlaUt+bGeBp4yJNfJZ8hMX0baICh3pT7fjRri+oIeqQYGa9K8YYTNjyu8kv+Ay4LgCkHww1sXgqsRUMbMGKCo7iDbhOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742976664; c=relaxed/simple;
	bh=wJyVaOsFACio1MvSMoZtveK4jVWOZ89MWmtXiR+nX/A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KMENXoK+kTD4yXyYj5UKQ+7PBS2A5xAIySG0hSzpD0K2T2ABPA3nZzMl13LJt+t9HjraTQ+oVx1kwaUJ75UIA9YrW/coyB4hnN0XY5M9h/qTDu7fjj8KfN3m2pZwaZ06RHjimUL9r01h25yfbGmhix77SRv3VoxBWVIQK1fTESk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rD0sqafh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F0086C4CEFF;
	Wed, 26 Mar 2025 08:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742976664;
	bh=wJyVaOsFACio1MvSMoZtveK4jVWOZ89MWmtXiR+nX/A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=rD0sqafhLSNYHToLFj/mJx/F92KVear3JE35T9BrfxbjpMqj0zjAl650Tzrx5mHIY
	 sxaAA+rojlv3Bp/5qLxILViNXiPlU3caSMNv0QvDK6i0Ogn+33eyUKPo8EM9L/w+vY
	 +AE9or7oUtG7tGvrPhBeGWE/fJYsmYkkv+vwtkIaqid/84GNa6lOoGqwe1Gd7cFe9X
	 qXdwUClBkpxz80wy36Cp2QZrZ0lfZcE0yRXlTWyTTWIZezI8N8cjqgghOzpoJmyPol
	 3CiPYyNfJkAtXIkjXIIMu4GcyLTOOpO/cov38cV3HLDn60cNZqA964m+m+KAw6RD9D
	 5ksgl5wviBBBg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E29F4C3600E;
	Wed, 26 Mar 2025 08:11:03 +0000 (UTC)
From: George Moussalem via B4 Relay <devnull+george.moussalem.outlook.com@kernel.org>
Date: Wed, 26 Mar 2025 12:10:59 +0400
Subject: [PATCH v7 5/6] arm64: dts: qcom: ipq5018: Add PCIe related nodes
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250326-ipq5018-pcie-v7-5-e1828fef06c9@outlook.com>
References: <20250326-ipq5018-pcie-v7-0-e1828fef06c9@outlook.com>
In-Reply-To: <20250326-ipq5018-pcie-v7-0-e1828fef06c9@outlook.com>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Nitheesh Sekar <quic_nsekar@quicinc.com>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Praveenkumar I <quic_ipkumar@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, George Moussalem <george.moussalem@outlook.com>, 
 20250317100029.881286-1-quic_varada@quicinc.com, 
 20250317100029.881286-2-quic_varada@quicinc.com, 
 Sricharan R <quic_srichara@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742976660; l=7966;
 i=george.moussalem@outlook.com; s=20250321; h=from:subject:message-id;
 bh=1yrxZRal9ZwjHU6ICJjYaPOtrrqlq7QA9H56yqsikjw=;
 b=sPTiMXvEiV83/c65WaMN8s5v3UeaBcbp9Wwt3j9v2LSm19Csg/aauFwK7RIY1qHqf2iodH86g
 lQ2unmeHTAeD4lg48cqZ131xvOkYh+hXmQ7Q9bX/8esUPrBVw/S5vzO
X-Developer-Key: i=george.moussalem@outlook.com; a=ed25519;
 pk=/PuRTSI9iYiHwcc6Nrde8qF4ZDhJBlUgpHdhsIjnqIk=
X-Endpoint-Received: by B4 Relay for george.moussalem@outlook.com/20250321
 with auth_id=364
X-Original-From: George Moussalem <george.moussalem@outlook.com>
Reply-To: george.moussalem@outlook.com

From: Nitheesh Sekar <quic_nsekar@quicinc.com>

Add phy and controller nodes for a 2-lane Gen2 and
a 1-lane Gen2 PCIe bus. IPQ5018 has 8 MSI SPI interrupts and
one global interrupt.

NOTE: the PCIe controller supports gen3, yet the phy is limited to gen2.

Signed-off-by: Nitheesh Sekar <quic_nsekar@quicinc.com>
Signed-off-by: Sricharan R <quic_srichara@quicinc.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: George Moussalem <george.moussalem@outlook.com>
---
 arch/arm64/boot/dts/qcom/ipq5018.dtsi | 246 +++++++++++++++++++++++++++++++++-
 1 file changed, 244 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq5018.dtsi b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
index 8914f2ef0bc47fda243b19174f77ce73fc10757d..9f695f0d9c6b7f29c4564977cadd6a78b55a044f 100644
--- a/arch/arm64/boot/dts/qcom/ipq5018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
@@ -147,6 +147,40 @@ usbphy0: phy@5b000 {
 			status = "disabled";
 		};
 
+		pcie1_phy: phy@7e000{
+			compatible = "qcom,ipq5018-uniphy-pcie-phy";
+			reg = <0x0007e000 0x800>;
+
+			clocks = <&gcc GCC_PCIE1_PIPE_CLK>;
+
+			resets = <&gcc GCC_PCIE1_PHY_BCR>,
+				 <&gcc GCC_PCIE1PHY_PHY_BCR>;
+
+			#clock-cells = <0>;
+			#phy-cells = <0>;
+
+			num-lanes = <1>;
+
+			status = "disabled";
+		};
+
+		pcie0_phy: phy@86000{
+			compatible = "qcom,ipq5018-uniphy-pcie-phy";
+			reg = <0x00086000 0x800>;
+
+			clocks = <&gcc GCC_PCIE0_PIPE_CLK>;
+
+			resets = <&gcc GCC_PCIE0_PHY_BCR>,
+				 <&gcc GCC_PCIE0PHY_PHY_BCR>;
+
+			#clock-cells = <0>;
+			#phy-cells = <0>;
+
+			num-lanes = <2>;
+
+			status = "disabled";
+		};
+
 		tlmm: pinctrl@1000000 {
 			compatible = "qcom,ipq5018-tlmm";
 			reg = <0x01000000 0x300000>;
@@ -170,8 +204,8 @@ gcc: clock-controller@1800000 {
 			reg = <0x01800000 0x80000>;
 			clocks = <&xo_board_clk>,
 				 <&sleep_clk>,
-				 <0>,
-				 <0>,
+				 <&pcie0_phy>,
+				 <&pcie1_phy>,
 				 <0>,
 				 <0>,
 				 <0>,
@@ -387,6 +421,214 @@ frame@b128000 {
 				status = "disabled";
 			};
 		};
+
+		pcie1: pcie@80000000 {
+			compatible = "qcom,pcie-ipq5018";
+			reg = <0x80000000 0xf1d>,
+			      <0x80000f20 0xa8>,
+			      <0x80001000 0x1000>,
+			      <0x00078000 0x3000>,
+			      <0x80100000 0x1000>,
+			      <0x0007b000 0x1000>;
+			reg-names = "dbi",
+				    "elbi",
+				    "atu",
+				    "parf",
+				    "config",
+				    "mhi";
+			device_type = "pci";
+			linux,pci-domain = <0>;
+			bus-range = <0x00 0xff>;
+			num-lanes = <1>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+
+			/*
+			 * In IPQ5018, the PCIe controller supports gen3,
+			 * yet the phy is limited to gen2. Hence, limit
+			 * the link speed to gen2.
+			 */
+			max-link-speed = <2>;
+
+			phys = <&pcie1_phy>;
+			phy-names ="pciephy";
+
+			ranges = <0x01000000 0 0x00000000 0x80200000 0 0x00100000>,
+				 <0x02000000 0 0x80300000 0x80300000 0 0x10000000>;
+
+			msi-map = <0x0 &v2m0 0x0 0xff8>;
+
+			interrupts = <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "msi0",
+					  "msi1",
+					  "msi2",
+					  "msi3",
+					  "msi4",
+					  "msi5",
+					  "msi6",
+					  "msi7",
+					  "global";
+
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0x7>;
+			interrupt-map = <0 0 0 1 &intc 0 0 142 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 2 &intc 0 0 143 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 3 &intc 0 0 144 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 4 &intc 0 0 145 IRQ_TYPE_LEVEL_HIGH>;
+
+			clocks = <&gcc GCC_SYS_NOC_PCIE1_AXI_CLK>,
+				 <&gcc GCC_PCIE1_AXI_M_CLK>,
+				 <&gcc GCC_PCIE1_AXI_S_CLK>,
+				 <&gcc GCC_PCIE1_AHB_CLK>,
+				 <&gcc GCC_PCIE1_AUX_CLK>,
+				 <&gcc GCC_PCIE1_AXI_S_BRIDGE_CLK>;
+			clock-names = "iface",
+				      "axi_m",
+				      "axi_s",
+				      "ahb",
+				      "aux",
+				      "axi_bridge";
+
+			resets = <&gcc GCC_PCIE1_PIPE_ARES>,
+				 <&gcc GCC_PCIE1_SLEEP_ARES>,
+				 <&gcc GCC_PCIE1_CORE_STICKY_ARES>,
+				 <&gcc GCC_PCIE1_AXI_MASTER_ARES>,
+				 <&gcc GCC_PCIE1_AXI_SLAVE_ARES>,
+				 <&gcc GCC_PCIE1_AHB_ARES>,
+				 <&gcc GCC_PCIE1_AXI_MASTER_STICKY_ARES>,
+				 <&gcc GCC_PCIE1_AXI_SLAVE_STICKY_ARES>;
+			reset-names = "pipe",
+				      "sleep",
+				      "sticky",
+				      "axi_m",
+				      "axi_s",
+				      "ahb",
+				      "axi_m_sticky",
+				      "axi_s_sticky";
+
+			status = "disabled";
+
+			pcie@0 {
+				device_type = "pci";
+				reg = <0x0 0x0 0x0 0x0 0x0>;
+
+				#address-cells = <3>;
+				#size-cells = <2>;
+				ranges;
+			};
+		};
+
+		pcie0: pcie@a0000000 {
+			compatible = "qcom,pcie-ipq5018";
+			reg = <0xa0000000 0xf1d>,
+			      <0xa0000f20 0xa8>,
+			      <0xa0001000 0x1000>,
+			      <0x00080000 0x3000>,
+			      <0xa0100000 0x1000>,
+			      <0x00083000 0x1000>;
+			reg-names = "dbi",
+				    "elbi",
+				    "atu",
+				    "parf",
+				    "config",
+				    "mhi";
+			device_type = "pci";
+			linux,pci-domain = <1>;
+			bus-range = <0x00 0xff>;
+			num-lanes = <2>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+
+			/*
+			 * In IPQ5018, the PCIe controller supports gen3,
+			 * yet the phy is limited to gen2. Hence, limit
+			 * the link speed to gen2.
+			 */
+			max-link-speed = <2>;
+
+			phys = <&pcie0_phy>;
+			phy-names ="pciephy";
+
+			ranges = <0x01000000 0 0x00000000 0xa0200000 0 0x00100000>,
+				 <0x02000000 0 0xa0300000 0xa0300000 0 0x10000000>;
+
+			msi-map = <0x0 &v2m0 0x0 0xff8>;
+
+			interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "msi0",
+					  "msi1",
+					  "msi2",
+					  "msi3",
+					  "msi4",
+					  "msi5",
+					  "msi6",
+					  "msi7",
+					  "global";
+
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0x7>;
+			interrupt-map = <0 0 0 1 &intc 0 0 75 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 2 &intc 0 0 78 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 3 &intc 0 0 79 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 4 &intc 0 0 83 IRQ_TYPE_LEVEL_HIGH>;
+
+			clocks = <&gcc GCC_SYS_NOC_PCIE0_AXI_CLK>,
+				 <&gcc GCC_PCIE0_AXI_M_CLK>,
+				 <&gcc GCC_PCIE0_AXI_S_CLK>,
+				 <&gcc GCC_PCIE0_AHB_CLK>,
+				 <&gcc GCC_PCIE0_AUX_CLK>,
+				 <&gcc GCC_PCIE0_AXI_S_BRIDGE_CLK>;
+			clock-names = "iface",
+				      "axi_m",
+				      "axi_s",
+				      "ahb",
+				      "aux",
+				      "axi_bridge";
+
+			resets = <&gcc GCC_PCIE0_PIPE_ARES>,
+				 <&gcc GCC_PCIE0_SLEEP_ARES>,
+				 <&gcc GCC_PCIE0_CORE_STICKY_ARES>,
+				 <&gcc GCC_PCIE0_AXI_MASTER_ARES>,
+				 <&gcc GCC_PCIE0_AXI_SLAVE_ARES>,
+				 <&gcc GCC_PCIE0_AHB_ARES>,
+				 <&gcc GCC_PCIE0_AXI_MASTER_STICKY_ARES>,
+				 <&gcc GCC_PCIE0_AXI_SLAVE_STICKY_ARES>;
+			reset-names = "pipe",
+				      "sleep",
+				      "sticky",
+				      "axi_m",
+				      "axi_s",
+				      "ahb",
+				      "axi_m_sticky",
+				      "axi_s_sticky";
+
+			status = "disabled";
+
+			pcie@0 {
+				device_type = "pci";
+				reg = <0x0 0x0 0x0 0x0 0x0>;
+
+				#address-cells = <3>;
+				#size-cells = <2>;
+				ranges;
+			};
+		};
 	};
 
 	timer {

-- 
2.49.0



