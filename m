Return-Path: <linux-pci+bounces-944-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62504812822
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 07:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D482B1F21A84
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 06:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C560D285;
	Thu, 14 Dec 2023 06:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="oxHT3je5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA9CE4;
	Wed, 13 Dec 2023 22:30:27 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BE5uhsN002303;
	Thu, 14 Dec 2023 06:30:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=TqsYi/GLvr1dtXxkw/HLOJUf5YR9fORp7rKJGaPNwT0=; b=ox
	HT3je5A1Rsn2amQ6dg0817kdgz3NTTAut9rpmXbMMcQB76ysrh52hJmATAqiexm7
	TB1SSMa3lh30xPFIK8Qj62vMR7YQoSL1f72sotp0lYyIXSHhH1+pgSJVvX/TEaCl
	kVLUamk8nzkKNgVz/n1XW4AcJmTia4aWRMa/4vFyBl3QnLmqvcp/wRT0qmsKLX8E
	ZC+29yurHutXg33XPOumVQYXaAUAuVHhAqDAgfBh0eFU+eCw+nMFG+40oSIpdO+W
	q2evPxU4w51xJ7Q2vIHM6DVF3qWgC/p4vsLsKguJDzdzWCXMDkf98irwv3EkqI2a
	OFv1Xmu9lswmp9H2k6ig==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uyq9t0ka9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Dec 2023 06:30:18 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BE6UH7n022494
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Dec 2023 06:30:17 GMT
Received: from hu-ipkumar-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 13 Dec 2023 22:30:08 -0800
From: Praveenkumar I <quic_ipkumar@quicinc.com>
To: <agross@kernel.org>, <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <vkoul@kernel.org>, <kishon@kernel.org>, <mani@kernel.org>,
        <quic_nsekar@quicinc.com>, <quic_srichara@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-phy@lists.infradead.org>
CC: <quic_varada@quicinc.com>, <quic_devipriy@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_anusha@quicinc.com>
Subject: [PATCH 09/10] arm64: dts: qcom: ipq5332: Add PCIe related nodes
Date: Thu, 14 Dec 2023 11:58:46 +0530
Message-ID: <20231214062847.2215542-10-quic_ipkumar@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231214062847.2215542-1-quic_ipkumar@quicinc.com>
References: <20231214062847.2215542-1-quic_ipkumar@quicinc.com>
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
X-Proofpoint-ORIG-GUID: eednlrUkOYIg9M2BM2LpThRBCJJCBA_z
X-Proofpoint-GUID: eednlrUkOYIg9M2BM2LpThRBCJJCBA_z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2312140039

Add phy and controller nodes for pcie0_x1 and pcie1_x2.

Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
---
 arch/arm64/boot/dts/qcom/ipq5332.dtsi | 189 +++++++++++++++++++++++++-
 1 file changed, 187 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq5332.dtsi b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
index f0d92effb783..367641ab4938 100644
--- a/arch/arm64/boot/dts/qcom/ipq5332.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
@@ -166,6 +166,58 @@ usbphy0: phy@7b000 {
 			status = "disabled";
 		};
 
+		pcie0_phy: phy@4b0000{
+			compatible = "qcom,ipq5332-uniphy-pcie-gen3x1";
+			reg = <0x004b0000 0x800>;
+
+			clocks = <&gcc GCC_PCIE3X1_0_PIPE_CLK>,
+				 <&gcc GCC_SNOC_PCIE3_1LANE_M_CLK>,
+				 <&gcc GCC_SNOC_PCIE3_1LANE_S_CLK>,
+				 <&gcc GCC_PCIE3X1_PHY_AHB_CLK>;
+			clock-names = "pipe",
+				      "lane_m",
+				      "lane_s",
+				      "phy_ahb";
+
+			resets = <&gcc GCC_PCIE3X1_0_PHY_BCR>,
+				 <&gcc GCC_PCIE3X1_0_PHY_PHY_BCR>,
+				 <&gcc GCC_PCIE3X1_PHY_AHB_CLK_ARES>;
+			reset-names = "phy",
+				      "phy_cfg",
+				      "phy_ahb";
+
+			#clock-cells = <0>;
+			clock-output-names = "pcie0_pipe_clk_src";
+
+			#phy-cells = <0>;
+			status = "disabled";
+		};
+
+		pcie1_phy: phy@4b1000 {
+			compatible = "qcom,ipq5332-uniphy-pcie-gen3x2";
+			reg = <0x004b1000 0x1000>;
+
+			clocks = <&gcc GCC_PCIE3X2_PIPE_CLK>,
+				 <&gcc GCC_SNOC_PCIE3_2LANE_M_CLK>,
+				 <&gcc GCC_SNOC_PCIE3_2LANE_S_CLK>,
+				 <&gcc GCC_PCIE3X2_PHY_AHB_CLK>;
+			clock-names = "pipe",
+				      "lane_m",
+				      "lane_s",
+				      "phy_ahb";
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
 		qfprom: efuse@a4000 {
 			compatible = "qcom,ipq5332-qfprom", "qcom,qfprom";
 			reg = <0x000a4000 0x721>;
@@ -211,9 +263,9 @@ gcc: clock-controller@1800000 {
 			#power-domain-cells = <1>;
 			clocks = <&xo_board>,
 				 <&sleep_clk>,
+				 <&pcie1_phy>,
 				 <0>,
-				 <0>,
-				 <0>,
+				 <&pcie0_phy>,
 				 <0>;
 		};
 
@@ -359,6 +411,139 @@ usb_dwc: usb@8a00000 {
 			};
 		};
 
+		pcie0: pcie@20000000 {
+			compatible = "qcom,pcie-ipq5332";
+			reg =  <0x20000000 0xf1d>,
+			       <0x20000F20 0xa8>,
+			       <0x20001000 0x1000>,
+			       <0x00080000 0x3000>,
+			       <0x20100000 0x1000>;
+			reg-names = "dbi", "elbi", "atu", "parf", "config";
+			device_type = "pci";
+			linux,pci-domain = <0>;
+			bus-range = <0x00 0xff>;
+			num-lanes = <1>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+
+			ranges = <0x01000000 0 0x20200000 0x20200000 0 0x00100000>, /* I/O */
+				 <0x02000000 0 0x20300000 0x20300000 0 0x0fd00000>; /* MEM */
+
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0x7>;
+			interrupt-map = <0 0 0 1 &intc 0 35 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
+					<0 0 0 2 &intc 0 36 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
+					<0 0 0 3 &intc 0 37 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
+					<0 0 0 4 &intc 0 38 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
+
+			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "global_irq";
+
+			clocks = <&gcc GCC_PCIE3X1_0_AHB_CLK>,
+				 <&gcc GCC_PCIE3X1_0_AUX_CLK>,
+				 <&gcc GCC_PCIE3X1_0_AXI_M_CLK>,
+				 <&gcc GCC_PCIE3X1_0_AXI_S_CLK>,
+				 <&gcc GCC_PCIE3X1_0_AXI_S_BRIDGE_CLK>,
+				 <&gcc GCC_PCIE3X1_0_RCHG_CLK>;
+
+			clock-names = "ahb",
+				      "aux",
+				      "axi_m",
+				      "axi_s",
+				      "axi_bridge",
+				      "rchng";
+
+			resets = <&gcc GCC_PCIE3X1_0_PIPE_ARES>,
+				 <&gcc GCC_PCIE3X1_0_CORE_STICKY_ARES>,
+				 <&gcc GCC_PCIE3X1_0_AXI_M_STICKY_ARES>,
+				 <&gcc GCC_PCIE3X1_0_AXI_M_CLK_ARES>,
+				 <&gcc GCC_PCIE3X1_0_AXI_S_STICKY_ARES>,
+				 <&gcc GCC_PCIE3X1_0_AXI_S_CLK_ARES>,
+				 <&gcc GCC_PCIE3X1_0_AHB_CLK_ARES>,
+				 <&gcc GCC_PCIE3X1_0_AUX_CLK_ARES>;
+
+			reset-names = "pipe",
+				      "sticky",
+				      "axi_m_sticky",
+				      "axi_m",
+				      "axi_s_sticky",
+				      "axi_s",
+				      "ahb",
+				      "aux";
+
+			phys = <&pcie0_phy>;
+			phy-names = "pciephy";
+
+			msi-map = <0x0 &v2m0 0x0 0xffd>;
+			status = "disabled";
+		};
+
+		pcie1: pcie@18000000 {
+			compatible = "qcom,pcie-ipq5332";
+			reg =  <0x18000000 0xf1d>,
+			       <0x18000F20 0xa8>,
+			       <0x18001000 0x1000>,
+			       <0x00088000 0x3000>,
+			       <0x18100000 0x1000>;
+			reg-names = "dbi", "elbi", "atu", "parf", "config";
+			device_type = "pci";
+			linux,pci-domain = <1>;
+			bus-range = <0x00 0xff>;
+			num-lanes = <2>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+
+			ranges = <0x01000000 0 0x18200000 0x18200000 0 0x00100000>, /* I/O */
+				 <0x02000000 0 0x18300000 0x18300000 0 0x07d00000>; /* MEM */
+
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0x7>;
+			interrupt-map = <0 0 0 1 &intc 0 412 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
+					<0 0 0 2 &intc 0 413 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
+					<0 0 0 3 &intc 0 414 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
+					<0 0 0 4 &intc 0 415 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
+
+			interrupts = <GIC_SPI 411 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "global_irq";
+
+			clocks = <&gcc GCC_PCIE3X2_AHB_CLK>,
+				 <&gcc GCC_PCIE3X2_AUX_CLK>,
+				 <&gcc GCC_PCIE3X2_AXI_M_CLK>,
+				 <&gcc GCC_PCIE3X2_AXI_S_CLK>,
+				 <&gcc GCC_PCIE3X2_AXI_S_BRIDGE_CLK>,
+				 <&gcc GCC_PCIE3X2_RCHG_CLK>;
+
+			clock-names = "ahb",
+				      "aux",
+				      "axi_m",
+				      "axi_s",
+				      "axi_bridge",
+				      "rchng";
+
+			resets = <&gcc GCC_PCIE3X2_PIPE_ARES>,
+				 <&gcc GCC_PCIE3X2_CORE_STICKY_ARES>,
+				 <&gcc GCC_PCIE3X2_AXI_M_STICKY_ARES>,
+				 <&gcc GCC_PCIE3X2_AXI_M_CLK_ARES>,
+				 <&gcc GCC_PCIE3X2_AXI_S_STICKY_ARES>,
+				 <&gcc GCC_PCIE3X2_AXI_S_CLK_ARES>,
+				 <&gcc GCC_PCIE3X2_AHB_CLK_ARES>,
+				 <&gcc GCC_PCIE3X2_AUX_CLK_ARES>;
+
+			reset-names = "pipe",
+				      "sticky",
+				      "axi_m_sticky",
+				      "axi_m",
+				      "axi_s_sticky",
+				      "axi_s",
+				      "ahb",
+				      "aux";
+
+			phys = <&pcie1_phy>;
+			phy-names = "pciephy";
+			msi-map = <0x0 &v2m0 0x0 0xffd>;
+			status = "disabled";
+		};
+
 		intc: interrupt-controller@b000000 {
 			compatible = "qcom,msm-qgic2";
 			reg = <0x0b000000 0x1000>,	/* GICD */
-- 
2.34.1


