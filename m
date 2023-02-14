Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECC8A696A1A
	for <lists+linux-pci@lfdr.de>; Tue, 14 Feb 2023 17:44:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231944AbjBNQoR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Feb 2023 11:44:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232597AbjBNQoE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Feb 2023 11:44:04 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41DD2733;
        Tue, 14 Feb 2023 08:43:28 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31EEftHO028695;
        Tue, 14 Feb 2023 16:43:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=Ljxg738oJT4BOxjkUxfy4Az/Ef4uLfup4KDAZrHarIw=;
 b=ZmgVGBQV5hLkcdbafkOa82okbdaql16WC+A3FcbS/V5J7yVJpQLN8+XVDYK5D+WRKzJx
 XIHL43sxZE93y2JkozBil1Fq9Jah/+FKwGXrlTyNzlwGYPhB1cLloQn+vDO/1jbfcbBC
 9F0ZDiI0ZG4Q8VDZL9o6zsKeYFwimekVQJVTawqaK2DQXK7TaGm6Cd8beXyt5ls/C87R
 438cnv0hlrDaFtKnSibwzAGu+RWmAiQybfuudsfiG2spu6UcUXc/RFNEx3dIz86l58D+
 vW+c9NTe6JBqHkgj8GPMELveQXDKiAi/M7l8ZJxN22poxaPNNSE1x0yEdcAgcVO35NL+ CA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nr6ps17vv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 16:43:03 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31EGh2v8003674
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 16:43:02 GMT
Received: from devipriy-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 14 Feb 2023 08:42:54 -0800
From:   Devi Priya <quic_devipriy@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <lpieralisi@kernel.org>,
        <kw@linux.com>, <robh@kernel.org>, <bhelgaas@google.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <mani@kernel.org>, <p.zabel@pengutronix.de>,
        <svarbanov@mm-sol.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <linux-clk@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_anusha@quicinc.com>
Subject: [PATCH 7/7] arm64: dts: qcom: ipq9574: Add PCIe PHYs and controller nodes
Date:   Tue, 14 Feb 2023 22:11:35 +0530
Message-ID: <20230214164135.17039-8-quic_devipriy@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230214164135.17039-1-quic_devipriy@quicinc.com>
References: <20230214164135.17039-1-quic_devipriy@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: biw0OAk3ZTgXrZbag_Bdr22VaMOF7d-Q
X-Proofpoint-GUID: biw0OAk3ZTgXrZbag_Bdr22VaMOF7d-Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-14_11,2023-02-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 impostorscore=0 adultscore=0 mlxlogscore=999 malwarescore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 lowpriorityscore=0
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302140142
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add PCIe0, PCIe1, PCIe2, PCIe3 (and corresponding PHY) devices
found on IPQ9574 platform. The PCIe0 & PCIe1 are 1-lane Gen3
host whereas PCIe2 & PCIe3 are 2-lane Gen3 host.

Co-developed-by: Anusha Rao <quic_anusha@quicinc.com>
Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
---
 arch/arm64/boot/dts/qcom/ipq9574-al02-c7.dts |  28 ++
 arch/arm64/boot/dts/qcom/ipq9574.dtsi        | 477 ++++++++++++++++++-
 2 files changed, 499 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq9574-al02-c7.dts b/arch/arm64/boot/dts/qcom/ipq9574-al02-c7.dts
index 2c8430197ec0..21b53f34ce84 100644
--- a/arch/arm64/boot/dts/qcom/ipq9574-al02-c7.dts
+++ b/arch/arm64/boot/dts/qcom/ipq9574-al02-c7.dts
@@ -8,6 +8,7 @@
 
 /dts-v1/;
 
+#include <dt-bindings/gpio/gpio.h>
 #include "ipq9574.dtsi"
 
 / {
@@ -29,6 +30,33 @@
 	status = "okay";
 };
 
+&pcie1_phy {
+	status = "okay";
+};
+
+&pcie1_x1 {
+	perst-gpios = <&tlmm 26 GPIO_ACTIVE_LOW>;
+	status = "okay";
+};
+
+&pcie2_phy {
+	status = "okay";
+};
+
+&pcie2_x2 {
+	perst-gpios = <&tlmm 29 GPIO_ACTIVE_LOW>;
+	status = "okay";
+};
+
+&pcie3_phy {
+	status = "okay";
+};
+
+&pcie3_x2 {
+	perst-gpios = <&tlmm 32 GPIO_ACTIVE_LOW>;
+	status = "okay";
+};
+
 &sdhc_1 {
 	pinctrl-0 = <&sdc_default_state>;
 	pinctrl-names = "default";
diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
index 062f80798ebb..a32dbdeb5bed 100644
--- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
@@ -6,8 +6,8 @@
  * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
-#include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/qcom,ipq9574-gcc.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/reset/qcom,ipq9574-gcc.h>
 
 / {
@@ -22,11 +22,41 @@
 			#clock-cells = <0>;
 		};
 
+		pcie30_phy0_pipe_clk: pcie30_phy0_pipe_clk {
+			compatible = "fixed-clock";
+			clock-frequency = <250000000>;
+			#clock-cells = <0>;
+		};
+
+		pcie30_phy1_pipe_clk: pcie30_phy1_pipe_clk {
+			compatible = "fixed-clock";
+			clock-frequency = <250000000>;
+			#clock-cells = <0>;
+		};
+
+		pcie30_phy2_pipe_clk: pcie30_phy2_pipe_clk {
+			compatible = "fixed-clock";
+			clock-frequency = <250000000>;
+			#clock-cells = <0>;
+		};
+
+		pcie30_phy3_pipe_clk: pcie30_phy3_pipe_clk {
+			compatible = "fixed-clock";
+			clock-frequency = <250000000>;
+			#clock-cells = <0>;
+		};
+
 		sleep_clk: sleep-clk {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
 		};
 
+		usb3phy_0_cc_pipe_clk: usb3phy_0_cc_pipe_clk {
+			compatible = "fixed-clock";
+			clock-frequency = <125000000>;
+			#clock-cells = <0>;
+		};
+
 		xo_board_clk: xo-board-clk {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
@@ -121,6 +151,155 @@
 		#size-cells = <1>;
 		ranges = <0 0 0 0xffffffff>;
 
+		pcie0_phy: phy@84000 {
+			compatible = "qcom,ipq9574-qmp-gen3x1-pcie-phy";
+			reg = <0x00084000 0x1bc>; /* Serdes PLL */
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+			clocks = <&gcc GCC_PCIE0_AUX_CLK>,
+				 <&gcc GCC_PCIE0_AHB_CLK>,
+				 <&gcc GCC_ANOC_PCIE0_1LANE_M_CLK>,
+				 <&gcc GCC_SNOC_PCIE0_1LANE_S_CLK>;
+			clock-names = "aux", "cfg_ahb", "anoc_lane", "snoc_lane";
+
+			assigned-clocks = <&gcc GCC_PCIE0_AUX_CLK>;
+			assigned-clock-rates = <20000000>;
+
+			resets = <&gcc GCC_PCIE0_PHY_BCR>,
+				 <&gcc GCC_PCIE0PHY_PHY_BCR>;
+			reset-names = "phy", "common";
+
+			status = "disabled";
+
+			pcie0_lane: phy@84200 {
+				reg = <0x00084200 0x16c>, /* Serdes Tx */
+				      <0x00084400 0x200>, /* Serdes Rx */
+				      <0x00084800 0x1f0>, /* PCS: Lane0, COM, PCIE */
+				      <0x00084c00 0xf4>;  /* pcs_misc */
+				#phy-cells = <0>;
+
+				clocks = <&gcc GCC_PCIE0_PIPE_CLK>;
+				clock-names = "pipe0";
+				clock-output-names = "gcc_pcie0_pipe_clk_src";
+				#clock-cells = <0>;
+			};
+		};
+
+		pcie2_phy: phy@8c000 {
+			compatible = "qcom,ipq9574-qmp-gen3x2-pcie-phy";
+			reg = <0x0008c000 0x1bc>; /* Serdes PLL */
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			clocks = <&gcc GCC_PCIE2_AUX_CLK>,
+				 <&gcc GCC_PCIE2_AHB_CLK>,
+				 <&gcc GCC_ANOC_PCIE2_2LANE_M_CLK>,
+				 <&gcc GCC_SNOC_PCIE2_2LANE_S_CLK>;
+			clock-names = "aux", "cfg_ahb", "anoc_lane", "snoc_lane";
+
+			assigned-clocks = <&gcc GCC_PCIE2_AUX_CLK>;
+			assigned-clock-rates = <20000000>;
+
+			resets = <&gcc GCC_PCIE2_PHY_BCR>,
+				 <&gcc GCC_PCIE2PHY_PHY_BCR>;
+			reset-names = "phy", "common";
+
+			status = "disabled";
+
+			pcie2_lanes: phy@8c200 {
+				reg = <0x0008c200 0x16c>, /* Serdes Tx0 */
+				      <0x0008c400 0x200>, /* Serdes Rx0 */
+				      <0x0008d000 0x1f0>, /* PCS: Lane0, COM, PCIE */
+				      <0x0008c600 0x16c>, /* Serdes Tx1 */
+				      <0x0008c800 0x200>, /* Serdes Rx1 */
+				      <0x0008d400 0x0f8>; /* pcs_misc */
+
+				#phy-cells = <0>;
+
+				clocks = <&gcc GCC_PCIE2_PIPE_CLK>;
+				clock-names = "pipe0";
+				clock-output-names = "gcc_pcie2_pipe_clk_src";
+				#clock-cells = <0>;
+			};
+		};
+
+		pcie3_phy: phy@f4000 {
+			compatible = "qcom,ipq9574-qmp-gen3x2-pcie-phy";
+			reg = <0x000f4000 0x1bc>; /* Serdes PLL */
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			clocks = <&gcc GCC_PCIE3_AUX_CLK>,
+				 <&gcc GCC_PCIE3_AHB_CLK>,
+				 <&gcc GCC_ANOC_PCIE3_2LANE_M_CLK>,
+				 <&gcc GCC_SNOC_PCIE3_2LANE_S_CLK>;
+			clock-names = "aux", "cfg_ahb", "anoc_lane", "snoc_lane";
+
+			assigned-clocks = <&gcc GCC_PCIE3_AUX_CLK>;
+			assigned-clock-rates = <20000000>;
+
+			resets = <&gcc GCC_PCIE3_PHY_BCR>,
+				 <&gcc GCC_PCIE3PHY_PHY_BCR>;
+			reset-names = "phy", "common";
+
+			status = "disabled";
+
+			pcie3_lanes: phy@f4200 {
+				reg = <0x000f4200 0x16c>, /* Serdes Tx0 */
+				      <0x000f4400 0x200>, /* Serdes Rx0 */
+				      <0x000f5000 0x1f0>, /* PCS: Lane0, COM, PCIE */
+				      <0x000f4600 0x16c>, /* Serdes Tx1 */
+				      <0x000f4800 0x200>, /* Serdes Rx1 */
+				      <0x000f5400 0x0f8>; /* pcs_misc */
+
+				#phy-cells = <0>;
+
+				clocks = <&gcc GCC_PCIE3_PIPE_CLK>;
+				clock-names = "pipe0";
+				clock-output-names = "gcc_pcie3_pipe_clk_src";
+				#clock-cells = <0>;
+			};
+		};
+
+		pcie1_phy: phy@fc000 {
+			compatible = "qcom,ipq9574-qmp-gen3x1-pcie-phy";
+			reg = <0x000fc000 0x1bc>; /* Serdes PLL */
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			clocks = <&gcc GCC_PCIE1_AUX_CLK>,
+				 <&gcc GCC_PCIE1_AHB_CLK>,
+				 <&gcc GCC_ANOC_PCIE1_1LANE_M_CLK>,
+				 <&gcc GCC_SNOC_PCIE1_1LANE_S_CLK>;
+			clock-names = "aux", "cfg_ahb", "anoc_lane", "snoc_lane";
+
+			assigned-clocks = <&gcc GCC_PCIE1_AUX_CLK>;
+			assigned-clock-rates = <20000000>;
+
+			resets = <&gcc GCC_PCIE1_PHY_BCR>,
+				 <&gcc GCC_PCIE1PHY_PHY_BCR>;
+			reset-names = "phy", "common";
+
+			status = "disabled";
+
+			pcie1_lane: phy@fc200 {
+				reg = <0x000fc200 0x16c>, /* Serdes Tx */
+				      <0x000fc400 0x200>, /* Serdes Rx */
+				      <0x000fc800 0x1f0>, /* PCS: Lane0, COM, PCIE */
+				      <0x000fcc00 0xf4>;  /* pcs_misc */
+				#phy-cells = <0>;
+
+				clocks = <&gcc GCC_PCIE1_PIPE_CLK>;
+				clock-names = "pipe0";
+				clock-output-names = "gcc_pcie1_pipe_clk_src";
+				#clock-cells = <0>;
+			};
+		};
+
 		tlmm: pinctrl@1000000 {
 			compatible = "qcom,ipq9574-tlmm";
 			reg = <0x01000000 0x300000>;
@@ -145,11 +324,11 @@
 			clocks = <&xo_board_clk>,
 				 <&sleep_clk>,
 				 <&bias_pll_ubi_nc_clk>,
-				 <0>,
-				 <0>,
-				 <0>,
-				 <0>,
-				 <0>;
+				 <&pcie30_phy0_pipe_clk>,
+				 <&pcie30_phy1_pipe_clk>,
+				 <&pcie30_phy2_pipe_clk>,
+				 <&pcie30_phy3_pipe_clk>,
+				 <&usb3phy_0_cc_pipe_clk>;
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 			#power-domain-cells = <1>;
@@ -282,6 +461,292 @@
 				status = "disabled";
 			};
 		};
+
+		pcie1_x1: pci@10000000 {
+			compatible = "qcom,pcie-ipq9574";
+			reg =  <0x10000000 0xf1d>,
+			       <0x10000F20 0xa8>,
+			       <0x10001000 0x1000>,
+			       <0x000F8000 0x4000>,
+			       <0x10100000 0x1000>,
+			       <0x00618108 0x4>;
+			reg-names = "dbi", "elbi", "atu", "parf", "config", "aggr_noc";
+			device_type = "pci";
+			linux,pci-domain = <2>;
+			bus-range = <0x00 0xff>;
+			num-lanes = <1>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+
+			ranges = <0x81000000 0 0x10200000 0x10200000
+				  0 0x00100000   /* downstream I/O */
+				  0x82000000 0 0x10300000 0x10300000
+				  0 0x07d00000>; /* non-prefetchable memory */
+
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0x7>;
+			interrupt-map = <0 0 0 1 &intc 0 35
+					IRQ_TYPE_LEVEL_HIGH>, /* int_a */
+					<0 0 0 2 &intc 0 49
+					IRQ_TYPE_LEVEL_HIGH>, /* int_b */
+					<0 0 0 3 &intc 0 84
+					IRQ_TYPE_LEVEL_HIGH>, /* int_c */
+					<0 0 0 4 &intc 0 85
+					IRQ_TYPE_LEVEL_HIGH>; /* int_d */
+
+			interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "global_irq";
+
+			/* clocks and clock-names are used to enable the clock in CBCR */
+			clocks = <&gcc GCC_PCIE1_AHB_CLK>,
+				 <&gcc GCC_PCIE1_AUX_CLK>,
+				 <&gcc GCC_PCIE1_AXI_M_CLK>,
+				 <&gcc GCC_PCIE1_AXI_S_CLK>,
+				 <&gcc GCC_PCIE1_AXI_S_BRIDGE_CLK>,
+				 <&gcc GCC_PCIE1_RCHNG_CLK>;
+			clock-names = "ahb",
+				      "aux",
+				      "axi_m",
+				      "axi_s",
+				      "axi_bridge",
+				      "rchng";
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
+			phys = <&pcie1_lane>;
+			phy-names = "pciephy";
+			msi-parent = <&v2m0>;
+			status = "disabled";
+		};
+
+		pcie3_x2: pci@18000000 {
+			compatible = "qcom,pcie-ipq9574";
+			reg =  <0x18000000 0xf1d>,
+			       <0x18000F20 0xa8>,
+			       <0x18001000 0x1000>,
+			       <0x000F0000 0x4000>,
+			       <0x18100000 0x1000>;
+			reg-names = "dbi", "elbi", "atu", "parf", "config";
+			device_type = "pci";
+			linux,pci-domain = <4>;
+			bus-range = <0x00 0xff>;
+			num-lanes = <2>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+
+			ranges = <0x81000000 0 0x18200000 0x18200000
+				  0 0x00100000   /* downstream I/O */
+				  0x82000000 0 0x18300000 0x18300000
+				  0 0x07d00000>; /* non-prefetchable memory */
+
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0x7>;
+			interrupt-map = <0 0 0 1 &intc 0 189
+					 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
+					<0 0 0 2 &intc 0 190
+					 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
+					<0 0 0 3 &intc 0 191
+					 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
+					<0 0 0 4 &intc 0 192
+					 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
+
+			interrupts = <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "global_irq";
+
+			/* clocks and clock-names are used to enable the clock in CBCR */
+			clocks = <&gcc GCC_PCIE3_AHB_CLK>,
+				 <&gcc GCC_PCIE3_AUX_CLK>,
+				 <&gcc GCC_PCIE3_AXI_M_CLK>,
+				 <&gcc GCC_PCIE3_AXI_S_CLK>,
+				 <&gcc GCC_PCIE3_AXI_S_BRIDGE_CLK>,
+				 <&gcc GCC_PCIE3_RCHNG_CLK>;
+			clock-names = "ahb",
+				      "aux",
+				      "axi_m",
+				      "axi_s",
+				      "axi_bridge",
+				      "rchng";
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
+			phys = <&pcie3_lanes>;
+			phy-names = "pciephy";
+			msi-parent = <&v2m0>;
+			status = "disabled";
+		};
+
+		pcie2_x2: pci@20000000 {
+			compatible = "qcom,pcie-ipq9574";
+			reg =  <0x20000000 0xf1d>,
+			       <0x20000F20 0xa8>,
+			       <0x20001000 0x1000>,
+			       <0x00088000 0x4000>,
+			       <0x20100000 0x1000>;
+			reg-names = "dbi", "elbi", "atu", "parf", "config";
+			device_type = "pci";
+			linux,pci-domain = <3>;
+			bus-range = <0x00 0xff>;
+			num-lanes =<2>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+
+			ranges = <0x81000000 0 0x20200000 0x20200000
+				  0 0x00100000   /* downstream I/O */
+				  0x82000000 0 0x20300000 0x20300000
+				  0 0x07d00000>; /* non-prefetchable memory */
+
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0x7>;
+			interrupt-map = <0 0 0 1 &intc 0 164
+					 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
+					<0 0 0 2 &intc 0 165
+					 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
+					<0 0 0 3 &intc 0 186
+					 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
+					<0 0 0 4 &intc 0 187
+					 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
+
+			interrupts = <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "global_irq";
+
+			/* clocks and clock-names are used to enable the clock in CBCR */
+			clocks = <&gcc GCC_PCIE2_AHB_CLK>,
+				 <&gcc GCC_PCIE2_AUX_CLK>,
+				 <&gcc GCC_PCIE2_AXI_M_CLK>,
+				 <&gcc GCC_PCIE2_AXI_S_CLK>,
+				 <&gcc GCC_PCIE2_AXI_S_BRIDGE_CLK>,
+				 <&gcc GCC_PCIE2_RCHNG_CLK>;
+			clock-names = "ahb",
+				      "aux",
+				      "axi_m",
+				      "axi_s",
+				      "axi_bridge",
+				      "rchng";
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
+			phys = <&pcie2_lanes>;
+			phy-names = "pciephy";
+			msi-parent = <&v2m0>;
+			status = "disabled";
+		};
+
+		pcie0_x1: pci@28000000 {
+			compatible = "qcom,pcie-ipq9574";
+			reg =  <0x28000000 0xf1d>,
+			       <0x28000F20 0xa8>,
+			       <0x28001000 0x1000>,
+			       <0x00080000 0x2000>,
+			       <0x28100000 0x1000>,
+			       <0x00618088 0x4>;
+			reg-names = "dbi", "elbi", "atu", "parf", "config", "aggr_noc";
+			device_type = "pci";
+			linux,pci-domain = <1>;
+			bus-range = <0x00 0xff>;
+			num-lanes = <1>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+
+			ranges = <0x81000000 0 0x28200000 0x28200000
+				  0 0x00100000   /* downstream I/O */
+				  0x82000000 0 0x28300000 0x28300000
+				  0 0x07d00000>; /* non-prefetchable memory */
+
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0x7>;
+			interrupt-map = <0 0 0 1 &intc 0 75
+					 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
+					<0 0 0 2 &intc 0 78
+					 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
+					<0 0 0 3 &intc 0 79
+					 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
+					<0 0 0 4 &intc 0 83
+					 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
+
+			interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "global_irq";
+
+			/* clocks and clock-names are used to enable the clock in CBCR */
+			clocks = <&gcc GCC_PCIE0_AHB_CLK>,
+				 <&gcc GCC_PCIE0_AUX_CLK>,
+				 <&gcc GCC_PCIE0_AXI_M_CLK>,
+				 <&gcc GCC_PCIE0_AXI_S_CLK>,
+				 <&gcc GCC_PCIE0_AXI_S_BRIDGE_CLK>,
+				 <&gcc GCC_PCIE0_RCHNG_CLK>;
+			clock-names = "ahb",
+				      "aux",
+				      "axi_m",
+				      "axi_s",
+				      "axi_bridge",
+				      "rchng";
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
+			phys = <&pcie0_lane>;
+			phy-names = "pciephy";
+			msi-parent = <&v2m0>;
+			status = "disabled";
+		};
 	};
 
 	timer {
-- 
2.17.1

