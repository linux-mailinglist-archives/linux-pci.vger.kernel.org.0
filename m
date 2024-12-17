Return-Path: <linux-pci+bounces-18594-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B39FB9F4863
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 11:06:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB28216F529
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 10:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5E01E104E;
	Tue, 17 Dec 2024 10:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CuxxdVGQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F481E130F;
	Tue, 17 Dec 2024 10:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734429896; cv=none; b=qIKzMo4UD8mpAM9tuM/Tqal0YWoZMbXy7wq8DDc1t4NxjpY9isi3pi5s9adjUSiFplweqYllPl0A0chXlTVjKOtYdCM/ZDozJ08PU1yZ6ogv4SBzTO3jbBH+9mCvGD6pOG5t85P0g1w2sXiFQQMFgBSWi+HuXVltxaszAWZcMKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734429896; c=relaxed/simple;
	bh=3Mu56iiDF4NQ7rIl1SN/H07Hmgkf6n5GB2kjtrRmNf4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fGb8HQxV1P0UlsrE86CozmDCxF4modChN/l7kKxkOEKXjFKfwXwEs1KHlb2mKv+siwlHKdnpVYv/QMsIkAu5Ds9vXaAgKNPAJzFvF84eZQeZZAWMtcmNQ1FIjacMlqAsBK8HhsdsTY3CU6OtXfj2fvuWI7Qlubb+kAA25sHQ39M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=CuxxdVGQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BH9kR99019189;
	Tue, 17 Dec 2024 10:04:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	r5mqYf2pyjzPtxZQ024xu2nzuH4ZPJYOEDRJ/wdC+3E=; b=CuxxdVGQjdbaHzHF
	abd9A5rO1YAQCwsd7DNhg6/2FeijTC3W3AHVfkozBjgyrMtOmaoHy6dax8jg/Xvr
	kjykWrd7XkrMuyC+qBWUnBS72LRCfVyZ16ziX+z+ZIZWHy093s5WUX+yZlqE4yX0
	dG3BsG3BfxppKq/oPZvJKFg2kgFeN/tcFx3J+Q9bZBFhjexeDXWBtnA2D5IP0tgG
	LnPqSs0BCtd2zEg4uF63fhqg2bgn7Vq5MlmdHz206Vf6y4C3uF7ajIh9ACctduzm
	UqAAEnyKElNTK4BqFfQYT6SjFl6EBSRDV1LpCEqcnwUFhxdTBXtIe1TFnWEteYAX
	zOVIcg==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43jvs81hh7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Dec 2024 10:04:42 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BHA4fG2015070
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Dec 2024 10:04:41 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 17 Dec 2024 02:04:35 -0800
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <andersson@kernel.org>, <konradybcio@kernel.org>,
        <p.zabel@pengutronix.de>, <quic_varada@quicinc.com>,
        <quic_nsekar@quicinc.com>, <dmitry.baryshkov@linaro.org>,
        <quic_srichara@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>
CC: Praveenkumar I <quic_ipkumar@quicinc.com>
Subject: [PATCH v3 4/5] arm64: dts: qcom: ipq5332: Add PCIe related nodes
Date: Tue, 17 Dec 2024 15:33:58 +0530
Message-ID: <20241217100359.4017214-5-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241217100359.4017214-1-quic_varada@quicinc.com>
References: <20241217100359.4017214-1-quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ORI6WNyr425-RdA8PzHZy5Dh1uVHTwxN
X-Proofpoint-ORIG-GUID: ORI6WNyr425-RdA8PzHZy5Dh1uVHTwxN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 clxscore=1015 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412170082

From: Praveenkumar I <quic_ipkumar@quicinc.com>

Add phy and controller nodes for pcie0_x1 and pcie1_x2.

Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
v3: Fix compatible string for phy nodes
    Use ipq9574 as backup compatible instead of new compatible for ipq5332
    Fix mixed case hex addresses
    Add "mhi" space
    Removed unnecessary comments and stray blank lines

v2: Fix nodes' location per address
---

 arch/arm64/boot/dts/qcom/ipq5332.dtsi | 212 +++++++++++++++++++++++++-
 1 file changed, 210 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq5332.dtsi b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
index d3c3e215a15c..add5d50b5fb0 100644
--- a/arch/arm64/boot/dts/qcom/ipq5332.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
@@ -186,6 +186,46 @@ rng: rng@e3000 {
 			clock-names = "core";
 		};
 
+		pcie0_phy: phy@4b0000{
+			compatible = "qcom,ipq5332-uniphy-gen3x1-pcie-phy";
+			reg = <0x004b0000 0x800>;
+
+			clocks = <&gcc GCC_PCIE3X1_0_PIPE_CLK>,
+				 <&gcc GCC_PCIE3X1_PHY_AHB_CLK>;
+
+			resets = <&gcc GCC_PCIE3X1_0_PHY_BCR>,
+				 <&gcc GCC_PCIE3X1_PHY_AHB_CLK_ARES>,
+				 <&gcc GCC_PCIE3X1_0_PHY_PHY_BCR>;
+			reset-names = "phy",
+				      "phy_ahb",
+				      "phy_cfg";
+
+			#clock-cells = <0>;
+			clock-output-names = "pcie0_pipe_clk_src";
+
+			#phy-cells = <0>;
+			status = "disabled";
+		};
+
+		pcie1_phy: phy@4b1000 {
+			compatible = "qcom,ipq5332-uniphy-gen3x2-pcie-phy";
+			reg = <0x004b1000 0x1000>;
+
+			clocks = <&gcc GCC_PCIE3X2_PIPE_CLK>,
+				 <&gcc GCC_PCIE3X2_PHY_AHB_CLK>;
+
+			resets = <&gcc GCC_PCIE3X2_PHY_BCR>,
+				 <&gcc GCC_PCIE3X2_PHY_AHB_CLK_ARES>;
+			reset-names = "phy",
+				      "phy_ahb";
+
+			#clock-cells = <0>;
+			clock-output-names = "pcie1_pipe_clk_src";
+
+			#phy-cells = <0>;
+			status = "disabled";
+		};
+
 		tlmm: pinctrl@1000000 {
 			compatible = "qcom,ipq5332-tlmm";
 			reg = <0x01000000 0x300000>;
@@ -212,8 +252,8 @@ gcc: clock-controller@1800000 {
 			#interconnect-cells = <1>;
 			clocks = <&xo_board>,
 				 <&sleep_clk>,
-				 <0>,
-				 <0>,
+				 <&pcie1_phy>,
+				 <&pcie0_phy>,
 				 <0>;
 		};
 
@@ -364,6 +404,174 @@ usb_dwc: usb@8a00000 {
 			};
 		};
 
+		pcie0: pcie@20000000 {
+			compatible = "qcom,pcie-ipq9574";
+			reg = <0x00080000 0x3000>,
+			      <0x20000000 0xf1d>,
+			      <0x20000f20 0xa8>,
+			      <0x20001000 0x1000>,
+			      <0x20100000 0x1000>,
+			      <0x00083000 0x1000>;
+			reg-names = "parf", "dbi", "elbi", "atu", "config", "mhi";
+			device_type = "pci";
+			linux,pci-domain = <0>;
+			bus-range = <0x00 0xff>;
+			num-lanes = <1>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+
+			ranges = <0x01000000 0 0x20200000 0x20200000 0 0x00100000>,
+				 <0x02000000 0 0x20300000 0x20300000 0 0x0fd00000>;
+
+			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
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
+			interrupt-map = <0 0 0 1 &intc 0 0 35 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 2 &intc 0 0 36 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 3 &intc 0 0 37 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 4 &intc 0 0 38 IRQ_TYPE_LEVEL_HIGH>;
+
+			clocks = <&gcc GCC_PCIE3X1_0_AXI_M_CLK>,
+				 <&gcc GCC_PCIE3X1_0_AXI_S_CLK>,
+				 <&gcc GCC_PCIE3X1_0_AXI_S_BRIDGE_CLK>,
+				 <&gcc GCC_PCIE3X1_0_RCHG_CLK>,
+				 <&gcc GCC_PCIE3X1_0_AHB_CLK>,
+				 <&gcc GCC_PCIE3X1_0_AUX_CLK>;
+			clock-names = "axi_m",
+				      "axi_s",
+				      "axi_bridge",
+				      "rchng",
+				      "ahb",
+				      "aux";
+
+			resets = <&gcc GCC_PCIE3X1_0_PIPE_ARES>,
+				 <&gcc GCC_PCIE3X1_0_CORE_STICKY_ARES>,
+				 <&gcc GCC_PCIE3X1_0_AXI_S_STICKY_ARES>,
+				 <&gcc GCC_PCIE3X1_0_AXI_S_CLK_ARES>,
+				 <&gcc GCC_PCIE3X1_0_AXI_M_STICKY_ARES>,
+				 <&gcc GCC_PCIE3X1_0_AXI_M_CLK_ARES>,
+				 <&gcc GCC_PCIE3X1_0_AUX_CLK_ARES>,
+				 <&gcc GCC_PCIE3X1_0_AHB_CLK_ARES>;
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
+
+			interconnects = <&gcc MASTER_SNOC_PCIE3_1_M &gcc SLAVE_SNOC_PCIE3_1_M>,
+					<&gcc MASTER_ANOC_PCIE3_1_S &gcc SLAVE_ANOC_PCIE3_1_S>;
+			interconnect-names = "pcie-mem", "cpu-pcie";
+
+			msi-map = <0x0 &v2m0 0x0 0xffd>;
+			status = "disabled";
+		};
+
+		pcie1: pcie@18000000 {
+			compatible = "qcom,pcie-ipq9574";
+			reg = <0x00088000 0x3000>,
+			      <0x18000000 0xf1d>,
+			      <0x18000f20 0xa8>,
+			      <0x18001000 0x1000>,
+			      <0x18100000 0x1000>,
+			      <0x0008b000 0x1000>;
+			reg-names = "parf", "dbi", "elbi", "atu", "config", "mhi";
+			device_type = "pci";
+			linux,pci-domain = <1>;
+			bus-range = <0x00 0xff>;
+			num-lanes = <2>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+
+			ranges = <0x01000000 0 0x18200000 0x18200000 0 0x00100000>,
+				 <0x02000000 0 0x18300000 0x18300000 0 0x07d00000>;
+
+			interrupts = <GIC_SPI 403 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 404 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 405 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 406 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 407 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 408 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 409 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 410 IRQ_TYPE_LEVEL_HIGH>;
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
+			interrupt-map = <0 0 0 1 &intc 0 0 412 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 2 &intc 0 0 413 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 3 &intc 0 0 414 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 4 &intc 0 0 415 IRQ_TYPE_LEVEL_HIGH>;
+
+			clocks = <&gcc GCC_PCIE3X2_AXI_M_CLK>,
+				 <&gcc GCC_PCIE3X2_AXI_S_CLK>,
+				 <&gcc GCC_PCIE3X2_AXI_S_BRIDGE_CLK>,
+				 <&gcc GCC_PCIE3X2_RCHG_CLK>,
+				 <&gcc GCC_PCIE3X2_AHB_CLK>,
+				 <&gcc GCC_PCIE3X2_AUX_CLK>;
+			clock-names = "axi_m",
+				      "axi_s",
+				      "axi_bridge",
+				      "rchng",
+				      "ahb",
+				      "aux";
+
+			resets = <&gcc GCC_PCIE3X2_PIPE_ARES>,
+				 <&gcc GCC_PCIE3X2_CORE_STICKY_ARES>,
+				 <&gcc GCC_PCIE3X2_AXI_S_STICKY_ARES>,
+				 <&gcc GCC_PCIE3X2_AXI_S_CLK_ARES>,
+				 <&gcc GCC_PCIE3X2_AXI_M_STICKY_ARES>,
+				 <&gcc GCC_PCIE3X2_AXI_M_CLK_ARES>,
+				 <&gcc GCC_PCIE3X2_AUX_CLK_ARES>,
+				 <&gcc GCC_PCIE3X2_AHB_CLK_ARES>;
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
+
+			interconnects = <&gcc MASTER_SNOC_PCIE3_2_M &gcc SLAVE_SNOC_PCIE3_2_M>,
+					<&gcc MASTER_ANOC_PCIE3_2_S &gcc SLAVE_ANOC_PCIE3_2_S>;
+			interconnect-names = "pcie-mem", "cpu-pcie";
+
+			msi-map = <0x0 &v2m0 0x0 0xffd>;
+			status = "disabled";
+		};
+
 		intc: interrupt-controller@b000000 {
 			compatible = "qcom,msm-qgic2";
 			reg = <0x0b000000 0x1000>,	/* GICD */
-- 
2.34.1


