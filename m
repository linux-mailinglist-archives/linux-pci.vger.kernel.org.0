Return-Path: <linux-pci+bounces-10363-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E8D9322C2
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2024 11:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CC88B22C22
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2024 09:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6307A1990D2;
	Tue, 16 Jul 2024 09:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="g/ptM9Sn"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567B21990AE;
	Tue, 16 Jul 2024 09:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721121892; cv=none; b=qHj9ASVzLC0KDK5nKdfUBTwplTjlmlXRRPxk6pFM0IFE0VX9veRrkOgz9LaObgRKBR9VG4OSCZIqAv9tkAwWbHNCK39CMIFuMEvHLHv6ECiY9mVhFvER65QUC2psbctVJu5NF/gajhFcEVNTQ2ROKt1YZzr0P9ulJ3Y6wuYVVxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721121892; c=relaxed/simple;
	bh=HJdkmImKG4FaOFKN6ANpx3eOTx2ZBRVSEQ05yDHEa5Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BtAYVMm9ZPNZHYKPsKRbZuccpMnAjRTYG+0NqXMRp5Z44BcYuySG+MuDXcZwKfMrRTdvVtJo1MWWVaNCpT62+AScN77Nq68EQx01DdkNCo1+xdzrz6QFcpP+mjnDeCettC2qvfxhOGmlRnsMY5UBTYDINQsC/iDt80PT8U8voeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=g/ptM9Sn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46G4X8VW023646;
	Tue, 16 Jul 2024 09:24:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	blWE8Xk2GyDjnvsBg6wvle1FeTMtGvEs+J7zvAa1Dhw=; b=g/ptM9SnDcNxUX9M
	5sRLTCG1fhfZ17CVPFosXIp0uxIEBV54z8oHcBXDRZMIbjzy/jgwZFza6bbwy9ER
	FG6SI0N9tyAlEUjBqRXcm0zIpM+CesV68XVx4gozkQdnMhMotZFKnYk8NQj0rm0S
	jcjf5RVgRH2pbws5jyLa/pAoU8SO+2genaslvYpG5ejLPf1FHYxS9vo2fkV05r3S
	kQF4RXBD0zIJrRh5Jo+KH69vrHfAfwmOAXFkWss27UH1yNYMNTSJaNpTY6QmzejK
	flz8S1U+Z+a+MR3gHr5liNi6B4xGWSaCVwmxc/pcwh5jjlvbizl11D9JggY/kOUv
	R0TsUw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40bhy6xkyc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jul 2024 09:24:35 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46G9OXuT014249
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jul 2024 09:24:33 GMT
Received: from hu-srichara-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 16 Jul 2024 02:24:28 -0700
From: Sricharan R <quic_srichara@quicinc.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <manivannan.sadhasivam@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_srichara@quicinc.com>
CC: devi priya <quic_devipriy@quicinc.com>
Subject: [PATCH V6 2/4] arm64: dts: qcom: ipq9574: Add PCIe PHYs and controller nodes
Date: Tue, 16 Jul 2024 14:53:45 +0530
Message-ID: <20240716092347.2177153-3-quic_srichara@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240716092347.2177153-1-quic_srichara@quicinc.com>
References: <20240716092347.2177153-1-quic_srichara@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: SSVi-pquyrtYi1PmRtlKSsWnmJNWn9F-
X-Proofpoint-ORIG-GUID: SSVi-pquyrtYi1PmRtlKSsWnmJNWn9F-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-15_19,2024-07-16_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 mlxscore=0 malwarescore=0 adultscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407160067

From: devi priya <quic_devipriy@quicinc.com>

Add PCIe0, PCIe1, PCIe2, PCIe3 (and corresponding PHY) devices
found on IPQ9574 platform. The PCIe0 & PCIe1 are 1-lane Gen3
host whereas PCIe2 & PCIe3 are 2-lane Gen3 host.

Signed-off-by: devi priya <quic_devipriy@quicinc.com>
Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
---
 [V6] Addressed all comments from Manivannan and increased the irq/msi
      to '8'. Fixed the clk's order as per .yaml binding.

 arch/arm64/boot/dts/qcom/ipq9574.dtsi | 425 +++++++++++++++++++++++++-
 1 file changed, 421 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
index 48dfafea46a7..f4d4cba0b117 100644
--- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
@@ -226,6 +226,52 @@ rpm_msg_ram: sram@60000 {
 			reg = <0x00060000 0x6000>;
 		};
 
+		pcie0_phy: phy@84000 {
+			compatible = "qcom,ipq9574-qmp-gen3x1-pcie-phy";
+			reg = <0x00084000 0x1000>;
+
+			clocks = <&gcc GCC_PCIE0_AUX_CLK>,
+				 <&gcc GCC_PCIE0_AHB_CLK>,
+				 <&gcc GCC_PCIE0_PIPE_CLK>;
+			clock-names = "aux", "cfg_ahb", "pipe";
+
+			assigned-clocks = <&gcc GCC_PCIE0_AUX_CLK>;
+			assigned-clock-rates = <20000000>;
+
+			resets = <&gcc GCC_PCIE0_PHY_BCR>,
+				 <&gcc GCC_PCIE0PHY_PHY_BCR>;
+			reset-names = "phy", "common";
+
+			#clock-cells = <0>;
+			clock-output-names = "gcc_pcie0_pipe_clk_src";
+
+			#phy-cells = <0>;
+			status = "disabled";
+		};
+
+		pcie2_phy: phy@8c000 {
+			compatible = "qcom,ipq9574-qmp-gen3x2-pcie-phy";
+			reg = <0x0008c000 0x2000>;
+
+			clocks = <&gcc GCC_PCIE2_AUX_CLK>,
+				 <&gcc GCC_PCIE2_AHB_CLK>,
+				 <&gcc GCC_PCIE2_PIPE_CLK>;
+			clock-names = "aux", "cfg_ahb", "pipe";
+
+			assigned-clocks = <&gcc GCC_PCIE2_AUX_CLK>;
+			assigned-clock-rates = <20000000>;
+
+			resets = <&gcc GCC_PCIE2_PHY_BCR>,
+				 <&gcc GCC_PCIE2PHY_PHY_BCR>;
+			reset-names = "phy", "common";
+
+			#clock-cells = <0>;
+			clock-output-names = "gcc_pcie2_pipe_clk_src";
+
+			#phy-cells = <0>;
+			status = "disabled";
+		};
+
 		rng: rng@e3000 {
 			compatible = "qcom,prng-ee";
 			reg = <0x000e3000 0x1000>;
@@ -243,6 +289,52 @@ mdio: mdio@90000 {
 			status = "disabled";
 		};
 
+		pcie3_phy: phy@f4000 {
+			compatible = "qcom,ipq9574-qmp-gen3x2-pcie-phy";
+			reg = <0x000f4000 0x2000>;
+
+			clocks = <&gcc GCC_PCIE3_AUX_CLK>,
+				 <&gcc GCC_PCIE3_AHB_CLK>,
+				 <&gcc GCC_PCIE3_PIPE_CLK>;
+			clock-names = "aux", "cfg_ahb", "pipe";
+
+			assigned-clocks = <&gcc GCC_PCIE3_AUX_CLK>;
+			assigned-clock-rates = <20000000>;
+
+			resets = <&gcc GCC_PCIE3_PHY_BCR>,
+				 <&gcc GCC_PCIE3PHY_PHY_BCR>;
+			reset-names = "phy", "common";
+
+			#clock-cells = <0>;
+			clock-output-names = "gcc_pcie3_pipe_clk_src";
+
+			#phy-cells = <0>;
+			status = "disabled";
+		};
+
+		pcie1_phy: phy@fc000 {
+			compatible = "qcom,ipq9574-qmp-gen3x1-pcie-phy";
+			reg = <0x000fc000 0x1000>;
+
+			clocks = <&gcc GCC_PCIE1_AUX_CLK>,
+				 <&gcc GCC_PCIE1_AHB_CLK>,
+				 <&gcc GCC_PCIE1_PIPE_CLK>;
+			clock-names = "aux", "cfg_ahb", "pipe";
+
+			assigned-clocks = <&gcc GCC_PCIE1_AUX_CLK>;
+			assigned-clock-rates = <20000000>;
+
+			resets = <&gcc GCC_PCIE1_PHY_BCR>,
+				 <&gcc GCC_PCIE1PHY_PHY_BCR>;
+			reset-names = "phy", "common";
+
+			#clock-cells = <0>;
+			clock-output-names = "gcc_pcie1_pipe_clk_src";
+
+			#phy-cells = <0>;
+			status = "disabled";
+		};
+
 		qfprom: efuse@a4000 {
 			compatible = "qcom,ipq9574-qfprom", "qcom,qfprom";
 			reg = <0x000a4000 0x5a1>;
@@ -309,10 +401,10 @@ gcc: clock-controller@1800000 {
 			clocks = <&xo_board_clk>,
 				 <&sleep_clk>,
 				 <0>,
-				 <0>,
-				 <0>,
-				 <0>,
-				 <0>,
+				 <&pcie0_phy>,
+				 <&pcie1_phy>,
+				 <&pcie2_phy>,
+				 <&pcie3_phy>,
 				 <0>;
 			#clock-cells = <1>;
 			#reset-cells = <1>;
@@ -756,6 +848,331 @@ frame@b128000 {
 				status = "disabled";
 			};
 		};
+
+		pcie1: pcie@10000000 {
+			compatible = "qcom,pcie-ipq9574";
+			reg =  <0x10000000 0xf1d>,
+			       <0x10000f20 0xa8>,
+			       <0x10001000 0x1000>,
+			       <0x000f8000 0x4000>,
+			       <0x10100000 0x1000>;
+			reg-names = "dbi", "elbi", "atu", "parf", "config";
+			device_type = "pci";
+			linux,pci-domain = <2>;
+			bus-range = <0x00 0xff>;
+			num-lanes = <1>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+
+			ranges = <0x01000000 0x0 0x00000000 0x10200000 0x0 0x100000>,  /* I/O */
+				 <0x02000000 0x0 0x10300000 0x10300000 0x0 0x7d00000>; /* MEM */
+
+			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
+
+			interrupt-names = "msi0",
+					  "msi1",
+					  "msi2",
+					  "msi3",
+					  "msi4",
+					  "msi5",
+					  "msi6",
+					  "msi7";
+
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0x7>;
+			interrupt-map = <0 0 0 1 &intc 0 0 35 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
+					<0 0 0 2 &intc 0 0 49 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
+					<0 0 0 3 &intc 0 0 84 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
+					<0 0 0 4 &intc 0 0 85 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
+
+			clocks = <&gcc GCC_PCIE1_AXI_M_CLK>,
+				 <&gcc GCC_PCIE1_AXI_S_CLK>,
+				 <&gcc GCC_PCIE1_AXI_S_BRIDGE_CLK>,
+				 <&gcc GCC_PCIE1_RCHNG_CLK>,
+				 <&gcc GCC_PCIE1_AHB_CLK>,
+				 <&gcc GCC_PCIE1_AUX_CLK>;
+			clock-names = "axi_m",
+				      "axi_s",
+				      "axi_bridge",
+				      "rchng",
+				      "ahb",
+				      "aux";
+
+			resets = <&gcc GCC_PCIE1_PIPE_ARES>,
+				 <&gcc GCC_PCIE1_CORE_STICKY_ARES>,
+				 <&gcc GCC_PCIE1_AXI_S_STICKY_ARES>,
+				 <&gcc GCC_PCIE1_AXI_S_ARES>,
+				 <&gcc GCC_PCIE1_AXI_M_STICKY_ARES>,
+				 <&gcc GCC_PCIE1_AXI_M_ARES>,
+				 <&gcc GCC_PCIE1_AUX_ARES>,
+				 <&gcc GCC_PCIE1_AHB_ARES>;
+			reset-names = "pipe",
+				      "sticky",
+				      "axi_s_sticky",
+				      "axi_s",
+				      "axi_m_sticky",
+				      "axi_m",
+				      "aux",
+				      "ahb";
+
+			phys = <&pcie1_phy>;
+			phy-names = "pciephy";
+			interconnects = <&gcc MASTER_ANOC_PCIE1 &gcc SLAVE_ANOC_PCIE1>,
+					<&gcc MASTER_SNOC_PCIE1 &gcc SLAVE_SNOC_PCIE1>;
+			interconnect-names = "pcie-mem", "cpu-pcie";
+			status = "disabled";
+		};
+
+		pcie3: pcie@18000000 {
+			compatible = "qcom,pcie-ipq9574";
+			reg =  <0x18000000 0xf1d>,
+			       <0x18000f20 0xa8>,
+			       <0x18001000 0x1000>,
+			       <0x000f0000 0x4000>,
+			       <0x18100000 0x1000>;
+			reg-names = "dbi", "elbi", "atu", "parf", "config";
+			device_type = "pci";
+			linux,pci-domain = <4>;
+			bus-range = <0x00 0xff>;
+			num-lanes = <2>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+
+			ranges = <0x01000000 0x0 0x00000000 0x18200000 0x0 0x100000>,  /* I/O */
+				 <0x02000000 0x0 0x18300000 0x18300000 0x0 0x7d00000>; /* MEM */
+
+			interrupts = <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
+
+			interrupt-names = "msi0",
+					  "msi1",
+					  "msi2",
+					  "msi3",
+					  "msi4",
+					  "msi5",
+					  "msi6",
+					  "msi7";
+
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0x7>;
+			interrupt-map = <0 0 0 1 &intc 0 0 189 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
+					<0 0 0 2 &intc 0 0 190 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
+					<0 0 0 3 &intc 0 0 191 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
+					<0 0 0 4 &intc 0 0 192 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
+
+			clocks = <&gcc GCC_PCIE3_AXI_M_CLK>,
+				 <&gcc GCC_PCIE3_AXI_S_CLK>,
+				 <&gcc GCC_PCIE3_AXI_S_BRIDGE_CLK>,
+				 <&gcc GCC_PCIE3_RCHNG_CLK>,
+				 <&gcc GCC_PCIE3_AHB_CLK>,
+				 <&gcc GCC_PCIE3_AUX_CLK>;
+			clock-names = "axi_m",
+				      "axi_s",
+				      "axi_bridge",
+				      "rchng",
+				      "ahb",
+				      "aux";
+
+			resets = <&gcc GCC_PCIE3_PIPE_ARES>,
+				 <&gcc GCC_PCIE3_CORE_STICKY_ARES>,
+				 <&gcc GCC_PCIE3_AXI_S_STICKY_ARES>,
+				 <&gcc GCC_PCIE3_AXI_S_ARES>,
+				 <&gcc GCC_PCIE3_AXI_M_STICKY_ARES>,
+				 <&gcc GCC_PCIE3_AXI_M_ARES>,
+				 <&gcc GCC_PCIE3_AUX_ARES>,
+				 <&gcc GCC_PCIE3_AHB_ARES>;
+			reset-names = "pipe",
+				      "sticky",
+				      "axi_s_sticky",
+				      "axi_s",
+				      "axi_m_sticky",
+				      "axi_m",
+				      "aux",
+				      "ahb";
+
+			phys = <&pcie3_phy>;
+			phy-names = "pciephy";
+			interconnects = <&gcc MASTER_ANOC_PCIE3 &gcc SLAVE_ANOC_PCIE3>,
+					<&gcc MASTER_SNOC_PCIE3 &gcc SLAVE_SNOC_PCIE3>;
+			interconnect-names = "pcie-mem", "cpu-pcie";
+			status = "disabled";
+		};
+
+		pcie2: pcie@20000000 {
+			compatible = "qcom,pcie-ipq9574";
+			reg =  <0x20000000 0xf1d>,
+			       <0x20000f20 0xa8>,
+			       <0x20001000 0x1000>,
+			       <0x00088000 0x4000>,
+			       <0x20100000 0x1000>;
+			reg-names = "dbi", "elbi", "atu", "parf", "config";
+			device_type = "pci";
+			linux,pci-domain = <3>;
+			bus-range = <0x00 0xff>;
+			num-lanes = <2>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+
+			ranges = <0x01000000 0x0 0x00000000 0x20200000 0x0 0x100000>,  /* I/O */
+				 <0x02000000 0x0 0x20300000 0x20300000 0x0 0x7d00000>; /* MEM */
+
+			interrupts = <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
+
+			interrupt-names = "msi0",
+					  "msi1",
+					  "msi2",
+					  "msi3",
+					  "msi4",
+					  "msi5",
+					  "msi6",
+					  "msi7";
+
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0x7>;
+			interrupt-map = <0 0 0 1 &intc 0 0 164 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
+					<0 0 0 2 &intc 0 0 165 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
+					<0 0 0 3 &intc 0 0 186 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
+					<0 0 0 4 &intc 0 0 187 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
+
+			clocks = <&gcc GCC_PCIE2_AXI_M_CLK>,
+				 <&gcc GCC_PCIE2_AXI_S_CLK>,
+				 <&gcc GCC_PCIE2_AXI_S_BRIDGE_CLK>,
+				 <&gcc GCC_PCIE2_RCHNG_CLK>,
+				 <&gcc GCC_PCIE2_AHB_CLK>,
+				 <&gcc GCC_PCIE2_AUX_CLK>;
+			clock-names = "axi_m",
+				      "axi_s",
+				      "axi_bridge",
+				      "rchng",
+				      "ahb",
+				      "aux";
+
+			resets = <&gcc GCC_PCIE2_PIPE_ARES>,
+				 <&gcc GCC_PCIE2_CORE_STICKY_ARES>,
+				 <&gcc GCC_PCIE2_AXI_S_STICKY_ARES>,
+				 <&gcc GCC_PCIE2_AXI_S_ARES>,
+				 <&gcc GCC_PCIE2_AXI_M_STICKY_ARES>,
+				 <&gcc GCC_PCIE2_AXI_M_ARES>,
+				 <&gcc GCC_PCIE2_AUX_ARES>,
+				 <&gcc GCC_PCIE2_AHB_ARES>;
+			reset-names = "pipe",
+				      "sticky",
+				      "axi_s_sticky",
+				      "axi_s",
+				      "axi_m_sticky",
+				      "axi_m",
+				      "aux",
+				      "ahb";
+
+			phys = <&pcie2_phy>;
+			phy-names = "pciephy";
+			interconnects = <&gcc MASTER_ANOC_PCIE2 &gcc SLAVE_ANOC_PCIE2>,
+					<&gcc MASTER_SNOC_PCIE2 &gcc SLAVE_SNOC_PCIE2>;
+			interconnect-names = "pcie-mem", "cpu-pcie";
+			status = "disabled";
+		};
+
+		pcie0: pci@28000000 {
+			compatible = "qcom,pcie-ipq9574";
+			reg =  <0x28000000 0xf1d>,
+			       <0x28000f20 0xa8>,
+			       <0x28001000 0x1000>,
+			       <0x00080000 0x4000>,
+			       <0x28100000 0x1000>;
+			reg-names = "dbi", "elbi", "atu", "parf", "config";
+			device_type = "pci";
+			linux,pci-domain = <1>;
+			bus-range = <0x00 0xff>;
+			num-lanes = <1>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+
+			ranges = <0x01000000 0x0 0x00000000 0x28200000 0x0 0x100000>,  /* I/O */
+				 <0x02000000 0x0 0x28300000 0x28300000 0x0 0x7d00000>; /* MEM */
+
+			interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
+
+			interrupt-names = "msi0",
+					  "msi1",
+					  "msi2",
+					  "msi3",
+					  "msi4",
+					  "msi5",
+					  "msi6",
+					  "msi7";
+
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0x7>;
+			interrupt-map = <0 0 0 1 &intc 0 0 75 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
+					<0 0 0 2 &intc 0 0 78 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
+					<0 0 0 3 &intc 0 0 79 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
+					<0 0 0 4 &intc 0 0 83 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
+
+			clocks = <&gcc GCC_PCIE0_AXI_M_CLK>,
+				 <&gcc GCC_PCIE0_AXI_S_CLK>,
+				 <&gcc GCC_PCIE0_AXI_S_BRIDGE_CLK>,
+				 <&gcc GCC_PCIE0_RCHNG_CLK>,
+				 <&gcc GCC_PCIE0_AHB_CLK>,
+				 <&gcc GCC_PCIE0_AUX_CLK>;
+			clock-names = "axi_m",
+				      "axi_s",
+				      "axi_bridge",
+				      "rchng",
+				      "ahb",
+				      "aux";
+
+			resets = <&gcc GCC_PCIE0_PIPE_ARES>,
+				 <&gcc GCC_PCIE0_CORE_STICKY_ARES>,
+				 <&gcc GCC_PCIE0_AXI_S_STICKY_ARES>,
+				 <&gcc GCC_PCIE0_AXI_S_ARES>,
+				 <&gcc GCC_PCIE0_AXI_M_STICKY_ARES>,
+				 <&gcc GCC_PCIE0_AXI_M_ARES>,
+				 <&gcc GCC_PCIE0_AUX_ARES>,
+				 <&gcc GCC_PCIE0_AHB_ARES>;
+			reset-names = "pipe",
+				      "sticky",
+				      "axi_s_sticky",
+				      "axi_s",
+				      "axi_m_sticky",
+				      "axi_m",
+				      "aux",
+				      "ahb";
+
+			phys = <&pcie0_phy>;
+			phy-names = "pciephy";
+			interconnects = <&gcc MASTER_ANOC_PCIE0 &gcc SLAVE_ANOC_PCIE0>,
+					<&gcc MASTER_SNOC_PCIE0 &gcc SLAVE_SNOC_PCIE0>;
+			interconnect-names = "pcie-mem", "cpu-pcie";
+			status = "disabled";
+		};
+
 	};
 
 	thermal-zones {
-- 
2.34.1


