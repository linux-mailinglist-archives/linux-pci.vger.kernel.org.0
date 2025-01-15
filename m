Return-Path: <linux-pci+bounces-19824-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E21A11A03
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 07:48:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7AE3164913
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 06:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA13722FAFC;
	Wed, 15 Jan 2025 06:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Ip9JFv5H"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABF222FE00;
	Wed, 15 Jan 2025 06:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736923705; cv=none; b=M4zGC331p79UoQkyd9Dax3qe3Ui0cqg3WFI0aeAYclfRQIXK2S36rbyQz3OOTXXGw8hDdIWONtWAxre4AZ5ySCP3Cq1MyU1KVFoA0HeV2STj/wsfEWmtQ4xx4dvR9eMi4tKw3ZXaAdXDIxo62TZsCemgIPasnePm154xL248Lyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736923705; c=relaxed/simple;
	bh=AS9tDuz8r833/+XR22PLXZ749uY8RIdwJCQbnIymsXA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n02XY+udG8BPKH8EFGUz9Rjuupvv0RBKr+l2XBE8/zQIMzt8dOdwaW1AlFKiDnmAu2M51lOqjY9Cy1SZ860eJVg8w3G+2qizM/RmZv8LZJf8YpS/RcXwNSR7OLqMoUBbRfGMqX/+uSgkPe8kJA2LANqo01I1TOjLHAcOEsJc5Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Ip9JFv5H; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50F0aXsR000721;
	Wed, 15 Jan 2025 06:48:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	I3gXbpcq84cM7GurzxFruphrIAdGMB46DSqLzxsoBCA=; b=Ip9JFv5HMWLGHgI7
	NTnHo2n4pO/fZ39e4m+R3v4YiB7tcokV40XRntpNdwq2F1ZiEjy7+M5LqT+jJD54
	Lz9KDfpv9DPrZUzF4uK4VOKd360+pwUBuR2klhu6YiY/jKgf87/ShwFVwTRVqU6u
	DDIEl7huuh05lAvjmerNlK16mc7hTUvKB4OR8z0oSTm37bZI2b+69EmuQhklXr8c
	n4/j+iJ6Cet4BgKvOl6OfKQCyILkmS7QTAGganSZ4NAKY8B8YU14Ax4nwIG7UhUx
	+38g6nfb0ZsGdFlp8DtvL2dea1M8FuJ0zJur1GACdw2lT35CPdg2p+9+V95FLAAS
	RVk7Vg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4462mkgr5p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 06:48:13 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50F6mCCC019217
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 06:48:12 GMT
Received: from hu-mmanikan-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 14 Jan 2025 22:48:07 -0800
From: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
To: <lpieralisi@kernel.org>, <kw@linux.com>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <bhelgaas@google.com>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <andersson@kernel.org>, <konradybcio@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>
Subject: [PATCH v2 2/3] arm64: dts: qcom: ipq5424: Add PCIe PHYs and controller nodes
Date: Wed, 15 Jan 2025 12:17:46 +0530
Message-ID: <20250115064747.3302912-3-quic_mmanikan@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250115064747.3302912-1-quic_mmanikan@quicinc.com>
References: <20250115064747.3302912-1-quic_mmanikan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: JZkQsP8Drmo5k8KwnUSdpIO2H5Q1mCW5
X-Proofpoint-GUID: JZkQsP8Drmo5k8KwnUSdpIO2H5Q1mCW5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-15_02,2025-01-13_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 impostorscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=999 clxscore=1015 mlxscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501150049

Add PCIe0, PCIe1, PCIe2, PCIe3 (and corresponding PHY) devices
found on IPQ5424 platform. The PCIe0 & PCIe1 are 1-lane Gen3
host whereas PCIe2 & PCIe3 are 2-lane Gen3 host.

Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
---
Changes in V2:
	- Add a newline above status in all pcie nodes.
	- Changed reg-names to a vertical list format in
	  all pcie nodes.
	- Updated the order of pcie phy clocks in gcc node,
	  move the <0> entry to the end of clock list.
	- Updated the ranges property in the soc@0 node to align
	  with the linux-next tip.

 arch/arm64/boot/dts/qcom/ipq5424.dtsi | 500 +++++++++++++++++++++++++-
 1 file changed, 496 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq5424.dtsi b/arch/arm64/boot/dts/qcom/ipq5424.dtsi
index 7034d378b1ef..708cd709a495 100644
--- a/arch/arm64/boot/dts/qcom/ipq5424.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq5424.dtsi
@@ -9,6 +9,7 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/qcom,ipq5424-gcc.h>
 #include <dt-bindings/reset/qcom,ipq5424-gcc.h>
+#include <dt-bindings/interconnect/qcom,ipq5424.h>
 #include <dt-bindings/gpio/gpio.h>
 
 / {
@@ -152,6 +153,98 @@ soc@0 {
 		#size-cells = <2>;
 		ranges = <0 0 0 0 0x10 0>;
 
+		pcie0_phy: phy@84000 {
+			compatible = "qcom,ipq5424-qmp-gen3x1-pcie-phy",
+				     "qcom,ipq9574-qmp-gen3x1-pcie-phy";
+			reg = <0 0x00084000 0 0x2000>;
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
+		pcie1_phy: phy@8c000 {
+			compatible = "qcom,ipq5424-qmp-gen3x1-pcie-phy",
+				     "qcom,ipq9574-qmp-gen3x1-pcie-phy";
+			reg = <0 0x0008c000 0 0x2000>;
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
+		pcie2_phy: phy@f4000 {
+			compatible = "qcom,ipq5424-qmp-gen3x2-pcie-phy",
+				     "qcom,ipq9574-qmp-gen3x2-pcie-phy";
+			reg = <0 0x000f4000 0 0x2000>;
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
+		pcie3_phy: phy@fc000 {
+			compatible = "qcom,ipq5424-qmp-gen3x2-pcie-phy",
+				     "qcom,ipq9574-qmp-gen3x2-pcie-phy";
+			reg = <0 0x000fc000 0 0x2000>;
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
 		rng: rng@4c3000 {
 			compatible = "qcom,ipq5424-trng", "qcom,trng";
 			reg = <0 0x004c3000 0 0x1000>;
@@ -189,10 +282,10 @@ gcc: clock-controller@1800000 {
 			reg = <0 0x01800000 0 0x40000>;
 			clocks = <&xo_board>,
 				 <&sleep_clk>,
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
@@ -506,6 +599,405 @@ frame@f42d000 {
 			};
 		};
 
+		pcie3: pcie@40000000 {
+			compatible = "qcom,pcie-ipq5424",
+				     "qcom,pcie-ipq9574";
+			reg = <0 0x40000000 0 0xf1d>,
+			      <0 0x40000f20 0 0xa8>,
+			      <0 0x40001000 0 0x1000>,
+			      <0 0x000f8000 0 0x3000>,
+			      <0 0x40100000 0 0x1000>;
+			reg-names = "dbi",
+				    "elbi",
+				    "atu",
+				    "parf",
+				    "config";
+			device_type = "pci";
+			linux,pci-domain = <3>;
+			bus-range = <0x00 0xff>;
+			num-lanes = <2>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+
+			ranges = <0x01000000 0x0 0x00000000 0x0 0x40200000 0x0 0x00100000>,
+				 <0x02000000 0x0 0x40300000 0x0 0x40300000 0x0 0x0fd00000>;
+			interrupts = <GIC_SPI 470 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 471 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 472 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 473 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 474 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 475 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 476 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 477 IRQ_TYPE_LEVEL_HIGH>;
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
+			interrupt-map = <0 0 0 1 &intc 0 479 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 2 &intc 0 480 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 3 &intc 0 481 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 4 &intc 0 482 IRQ_TYPE_LEVEL_HIGH>;
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
+			assigned-clocks = <&gcc GCC_PCIE3_AHB_CLK>,
+					  <&gcc GCC_PCIE3_AUX_CLK>,
+					  <&gcc GCC_PCIE3_AXI_M_CLK>,
+					  <&gcc GCC_PCIE3_AXI_S_BRIDGE_CLK>,
+					  <&gcc GCC_PCIE3_AXI_S_CLK>,
+					  <&gcc GCC_PCIE3_RCHNG_CLK>;
+			assigned-clock-rates = <100000000>,
+					       <20000000>,
+					       <266666666>,
+					       <240000000>,
+					       <240000000>,
+					       <100000000>;
+
+			resets = <&gcc GCC_PCIE3_PIPE_ARES>,
+				 <&gcc GCC_PCIE3_CORE_STICKY_RESET>,
+				 <&gcc GCC_PCIE3_AXI_S_STICKY_RESET>,
+				 <&gcc GCC_PCIE3_AXI_S_ARES>,
+				 <&gcc GCC_PCIE3_AXI_M_STICKY_RESET>,
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
+			msi-map = <0x0 &intc 0x0 0x1000>;
+
+			phys = <&pcie3_phy>;
+			phy-names = "pciephy";
+			interconnects = <&gcc MASTER_ANOC_PCIE3 &gcc SLAVE_ANOC_PCIE3>,
+					<&gcc MASTER_CNOC_PCIE3 &gcc SLAVE_CNOC_PCIE3>;
+			interconnect-names = "pcie-mem", "cpu-pcie";
+
+			status = "disabled";
+		};
+
+		pcie2: pcie@50000000 {
+			compatible = "qcom,pcie-ipq5424",
+				     "qcom,pcie-ipq9574";
+			reg = <0 0x50000000 0 0xf1d>,
+			      <0 0x50000f20 0 0xa8>,
+			      <0 0x50001000 0 0x1000>,
+			      <0 0x000f0000 0 0x3000>,
+			      <0 0x50100000 0 0x1000>;
+			reg-names = "dbi",
+				    "elbi",
+				    "atu",
+				    "parf",
+				    "config";
+			device_type = "pci";
+			linux,pci-domain = <2>;
+			bus-range = <0x00 0xff>;
+			num-lanes = <2>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+
+			ranges = <0x01000000 0x0 0x00000000 0x0 0x50200000 0x0 0x00100000>,
+				 <0x02000000 0x0 0x50300000 0x0 0x50300000 0x0 0x0fd00000>;
+			interrupts = <GIC_SPI 455 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 456 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 457 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 458 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 459 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 460 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 461 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 462 IRQ_TYPE_LEVEL_HIGH>;
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
+			interrupt-map = <0 0 0 1 &intc 0 464 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 2 &intc 0 465 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 3 &intc 0 466 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 4 &intc 0 467 IRQ_TYPE_LEVEL_HIGH>;
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
+			assigned-clocks = <&gcc GCC_PCIE2_AHB_CLK>,
+					  <&gcc GCC_PCIE2_AUX_CLK>,
+					  <&gcc GCC_PCIE2_AXI_M_CLK>,
+					  <&gcc GCC_PCIE2_AXI_S_BRIDGE_CLK>,
+					  <&gcc GCC_PCIE2_AXI_S_CLK>,
+					  <&gcc GCC_PCIE2_RCHNG_CLK>;
+			assigned-clock-rates = <100000000>,
+					       <20000000>,
+					       <266666666>,
+					       <240000000>,
+					       <240000000>,
+					       <100000000>;
+
+			resets = <&gcc GCC_PCIE2_PIPE_ARES>,
+				 <&gcc GCC_PCIE2_CORE_STICKY_RESET>,
+				 <&gcc GCC_PCIE2_AXI_S_STICKY_RESET>,
+				 <&gcc GCC_PCIE2_AXI_S_ARES>,
+				 <&gcc GCC_PCIE2_AXI_M_STICKY_RESET>,
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
+			msi-map = <0x0 &intc 0x0 0x1000>;
+
+			phys = <&pcie2_phy>;
+			phy-names = "pciephy";
+			interconnects = <&gcc MASTER_ANOC_PCIE2 &gcc SLAVE_ANOC_PCIE2>,
+					<&gcc MASTER_CNOC_PCIE2 &gcc SLAVE_CNOC_PCIE2>;
+			interconnect-names = "pcie-mem", "cpu-pcie";
+
+			status = "disabled";
+		};
+
+		pcie1: pcie@60000000 {
+			compatible = "qcom,pcie-ipq5424",
+				     "qcom,pcie-ipq9574";
+			reg = <0 0x60000000 0 0xf1d>,
+			      <0 0x60000f20 0 0xa8>,
+			      <0 0x60001000 0 0x1000>,
+			      <0 0x00088000 0 0x3000>,
+			      <0 0x60100000 0 0x1000>;
+			reg-names = "dbi",
+				    "elbi",
+				    "atu",
+				    "parf",
+				    "config";
+			device_type = "pci";
+			linux,pci-domain = <1>;
+			bus-range = <0x00 0xff>;
+			num-lanes = <1>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+
+			ranges = <0x01000000 0x0 0x00000000 0x0 0x60200000 0x0 0x00100000>,
+				 <0x02000000 0x0 0x60300000 0x0 0x60300000 0x0 0x0fd00000>;
+			interrupts = <GIC_SPI 440 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 441 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 442 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 443 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 444 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 445 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 446 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 447 IRQ_TYPE_LEVEL_HIGH>;
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
+			interrupt-map = <0 0 0 1 &intc 0 449 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 2 &intc 0 450 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 3 &intc 0 451 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 4 &intc 0 452 IRQ_TYPE_LEVEL_HIGH>;
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
+			assigned-clocks = <&gcc GCC_PCIE1_AHB_CLK>,
+					  <&gcc GCC_PCIE1_AUX_CLK>,
+					  <&gcc GCC_PCIE1_AXI_M_CLK>,
+					  <&gcc GCC_PCIE1_AXI_S_BRIDGE_CLK>,
+					  <&gcc GCC_PCIE1_AXI_S_CLK>,
+					  <&gcc GCC_PCIE1_RCHNG_CLK>;
+			assigned-clock-rates = <100000000>,
+					       <20000000>,
+					       <240000000>,
+					       <240000000>,
+					       <240000000>,
+					       <100000000>;
+
+			resets = <&gcc GCC_PCIE1_PIPE_ARES>,
+				 <&gcc GCC_PCIE1_CORE_STICKY_RESET>,
+				 <&gcc GCC_PCIE1_AXI_S_STICKY_RESET>,
+				 <&gcc GCC_PCIE1_AXI_S_ARES>,
+				 <&gcc GCC_PCIE1_AXI_M_STICKY_RESET>,
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
+			msi-map = <0x0 &intc 0x0 0x1000>;
+
+			phys = <&pcie1_phy>;
+			phy-names = "pciephy";
+			interconnects = <&gcc MASTER_ANOC_PCIE1 &gcc SLAVE_ANOC_PCIE1>,
+					<&gcc MASTER_CNOC_PCIE1 &gcc SLAVE_CNOC_PCIE1>;
+			interconnect-names = "pcie-mem", "cpu-pcie";
+
+			status = "disabled";
+		};
+
+		pcie0: pcie@70000000 {
+			compatible = "qcom,pcie-ipq5424",
+				     "qcom,pcie-ipq9574";
+			reg = <0 0x70000000 0 0xf1d>,
+			      <0 0x70000f20 0 0xa8>,
+			      <0 0x70001000 0 0x1000>,
+			      <0 0x00080000 0 0x3000>,
+			      <0 0x70100000 0 0x1000>;
+			reg-names = "dbi",
+				    "elbi",
+				    "atu",
+				    "parf",
+				    "config";
+			device_type = "pci";
+			linux,pci-domain = <0>;
+			bus-range = <0x00 0xff>;
+			num-lanes = <1>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+
+			ranges = <0x01000000 0x0 0x00000000 0x0 0x70200000 0x0 0x00100000>,
+				 <0x02000000 0x0 0x70300000 0x0 0x70300000 0x0 0x0fd00000>;
+			interrupts = <GIC_SPI 425 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 426 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 427 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 428 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 429 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 430 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 431 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 432 IRQ_TYPE_LEVEL_HIGH>;
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
+			interrupt-map = <0 0 0 1 &intc 0 434 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 2 &intc 0 435 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 3 &intc 0 436 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 4 &intc 0 437 IRQ_TYPE_LEVEL_HIGH>;
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
+			assigned-clocks = <&gcc GCC_PCIE0_AHB_CLK>,
+					  <&gcc GCC_PCIE0_AUX_CLK>,
+					  <&gcc GCC_PCIE0_AXI_M_CLK>,
+					  <&gcc GCC_PCIE0_AXI_S_BRIDGE_CLK>,
+					  <&gcc GCC_PCIE0_AXI_S_CLK>,
+					  <&gcc GCC_PCIE0_RCHNG_CLK>;
+			assigned-clock-rates = <100000000>,
+					       <20000000>,
+					       <240000000>,
+					       <240000000>,
+					       <240000000>,
+					       <100000000>;
+
+			resets = <&gcc GCC_PCIE0_PIPE_ARES>,
+				 <&gcc GCC_PCIE0_CORE_STICKY_RESET>,
+				 <&gcc GCC_PCIE0_AXI_S_STICKY_RESET>,
+				 <&gcc GCC_PCIE0_AXI_S_ARES>,
+				 <&gcc GCC_PCIE0_AXI_M_STICKY_RESET>,
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
+			msi-map = <0x0 &intc 0x0 0x1000>;
+
+			phys = <&pcie0_phy>;
+			phy-names = "pciephy";
+			interconnects = <&gcc MASTER_ANOC_PCIE0 &gcc SLAVE_ANOC_PCIE0>,
+					<&gcc MASTER_CNOC_PCIE0 &gcc SLAVE_CNOC_PCIE0>;
+			interconnect-names = "pcie-mem", "cpu-pcie";
+
+			status = "disabled";
+		};
 	};
 
 	timer {
-- 
2.34.1


