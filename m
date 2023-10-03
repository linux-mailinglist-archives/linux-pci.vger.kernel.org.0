Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D746F7B68B9
	for <lists+linux-pci@lfdr.de>; Tue,  3 Oct 2023 14:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240060AbjJCMKY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Oct 2023 08:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240051AbjJCMKV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Oct 2023 08:10:21 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E97101;
        Tue,  3 Oct 2023 05:10:15 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 393AjI7w014947;
        Tue, 3 Oct 2023 12:09:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=Xb0TW84ggVQbz/JKcpZ6dj6owbb8/W8zYkCPSr5z4co=;
 b=JYy1e2osUBMA+SrtZIXPNNxcC9D4kMuctKcBij8j/EG/g2jlnPrOgUn0X5yLUO+dGuXi
 aR1ogKffroQZW45LEP5MJnTa5nDkEaHuoTJViDe8KUSPh1s99XC9IuY7RsIYiqcJxXoX
 4K7woOwg/gROXxh0vBn6qH5O58B6rSllV25Ql83IRlwy9HQEQjYRRwszpKHD48MLclSy
 k014V3ga5RYP3EYZUZnSc4FB/2IQogLSrAQN3FL5Cg+Cec8Z87pPu7IjtaNUHKSLih6U
 tKQ/Mfc3pK1bRrtG2mUvDYbUSFbUSy9DVuDBkkcJn/Hs++XRIoeziXO3LuwTGXo692d0 rQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tg1v3a47v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Oct 2023 12:09:52 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 393C9o1h017427
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 3 Oct 2023 12:09:50 GMT
Received: from nsekar-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Tue, 3 Oct 2023 05:09:43 -0700
From:   Nitheesh Sekar <quic_nsekar@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <lpieralisi@kernel.org>,
        <kw@linux.com>, <robh@kernel.org>, <bhelgaas@google.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <vkoul@kernel.org>, <kishon@kernel.org>, <mani@kernel.org>,
        <p.zabel@pengutronix.de>, <quic_nsekar@quicinc.com>,
        <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>,
        <quic_ipkumar@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>
Subject: [PATCH 5/6] arm64: dts: qcom: ipq5018: Add PCIe related nodes
Date:   Tue, 3 Oct 2023 17:38:45 +0530
Message-ID: <20231003120846.28626-6-quic_nsekar@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231003120846.28626-1-quic_nsekar@quicinc.com>
References: <20231003120846.28626-1-quic_nsekar@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: nMID8XLOgUG7Tc_Lx3A8QxvvrAaYxW_u
X-Proofpoint-ORIG-GUID: nMID8XLOgUG7Tc_Lx3A8QxvvrAaYxW_u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-03_08,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 clxscore=1015 spamscore=0 impostorscore=0 priorityscore=1501 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310030088
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add phy and controller nodes for PCIe_x2 and PCIe_x1.
PCIe_x2 is 2-lane Gen2 and PCIe_x1 is 1-lane Gen2.

Signed-off-by: Nitheesh Sekar <quic_nsekar@quicinc.com>
---
 arch/arm64/boot/dts/qcom/ipq5018.dtsi | 186 +++++++++++++++++++++++++-
 1 file changed, 184 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq5018.dtsi b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
index 38ffdc3cbdcd..0818fdd1e693 100644
--- a/arch/arm64/boot/dts/qcom/ipq5018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
@@ -8,6 +8,7 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/qcom,gcc-ipq5018.h>
 #include <dt-bindings/reset/qcom,gcc-ipq5018.h>
+#include <dt-bindings/gpio/gpio.h>
 
 / {
 	interrupt-parent = <&intc>;
@@ -94,6 +95,38 @@
 		#size-cells = <1>;
 		ranges = <0 0 0 0xffffffff>;
 
+		pcie_x1phy: phy@7e000{
+			compatible = "qcom,ipq5018-uniphy-pcie-gen2x1";
+			reg = <0x0007e000 0x800>;
+			#phy-cells = <0>;
+			#clock-cells = <0>;
+			clocks = <&gcc GCC_PCIE1_PIPE_CLK>;
+			clock-names = "pipe_clk";
+			clock-output-names = "pcie1_pipe_clk";
+			assigned-clocks = <&gcc GCC_PCIE1_PIPE_CLK>;
+			assigned-clock-rates = <125000000>;
+			resets = <&gcc GCC_PCIE1_PHY_BCR>,
+				 <&gcc GCC_PCIE1PHY_PHY_BCR>;
+			reset-names = "phy", "phy_phy";
+			status = "disabled";
+		};
+
+		pcie_x2phy: phy@86000{
+			compatible = "qcom,ipq5018-uniphy-pcie-gen2x2";
+			reg = <0x00086000 0x800>;
+			#phy-cells = <0>;
+			#clock-cells = <0>;
+			clocks = <&gcc GCC_PCIE0_PIPE_CLK>;
+			clock-names = "pipe_clk";
+			clock-output-names = "pcie0_pipe_clk";
+			assigned-clocks = <&gcc GCC_PCIE0_PIPE_CLK>;
+			assigned-clock-rates = <125000000>;
+			resets = <&gcc GCC_PCIE0_PHY_BCR>,
+				 <&gcc GCC_PCIE0PHY_PHY_BCR>;
+			reset-names = "phy", "phy_phy";
+			status = "disabled";
+		};
+
 		tlmm: pinctrl@1000000 {
 			compatible = "qcom,ipq5018-tlmm";
 			reg = <0x01000000 0x300000>;
@@ -117,8 +150,8 @@
 			reg = <0x01800000 0x80000>;
 			clocks = <&xo_board_clk>,
 				 <&sleep_clk>,
-				 <0>,
-				 <0>,
+				 <&pcie_x2phy>,
+				 <&pcie_x1phy>,
 				 <0>,
 				 <0>,
 				 <0>,
@@ -246,6 +279,155 @@
 				status = "disabled";
 			};
 		};
+
+		pcie_x1: pci@80000000 {
+			compatible = "qcom,pcie-ipq5018";
+			reg =  <0x80000000 0xf1d
+				0x80000F20 0xa8
+				0x80001000 0x1000
+				0x78000 0x3000
+				0x80100000 0x1000>;
+			reg-names = "dbi", "elbi", "atu", "parf", "config";
+			device_type = "pci";
+			linux,pci-domain = <0>;
+			bus-range = <0x00 0xff>;
+			num-lanes = <1>;
+			max-link-speed = <2>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+
+			phys = <&pcie_x1phy>;
+			phy-names ="pciephy";
+
+			ranges = <0x81000000 0 0x80200000 0x80200000
+				  0 0x00100000   /* downstream I/O */
+				  0x82000000 0 0x80300000 0x80300000
+				  0 0x10000000>; /* non-prefetchable memory */
+
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0x7>;
+			interrupt-map = <0 0 0 1 &intc 0 142
+					 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
+					<0 0 0 2 &intc 0 143
+					 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
+					<0 0 0 3 &intc 0 144
+					 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
+					<0 0 0 4 &intc 0 145
+					 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
+
+			interrupts = <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "global_irq";
+
+			clocks = <&gcc GCC_SYS_NOC_PCIE1_AXI_CLK>,
+				 <&gcc GCC_PCIE1_AXI_M_CLK>,
+				 <&gcc GCC_PCIE1_AXI_S_CLK>,
+				 <&gcc GCC_PCIE1_AHB_CLK>,
+				 <&gcc GCC_PCIE1_AUX_CLK>,
+				 <&gcc GCC_PCIE1_AXI_S_BRIDGE_CLK>;
+
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
+
+			reset-names = "pipe",
+				      "sleep",
+				      "sticky",
+				      "axi_m",
+				      "axi_s",
+				      "ahb",
+				      "axi_m_sticky",
+				      "axi_s_sticky";
+
+			msi-map = <0x0 &v2m0 0x0 0xff8>;
+			status = "disabled";
+		};
+
+		pcie_x2: pci@a0000000 {
+			compatible = "qcom,pcie-ipq5018";
+			reg =  <0xa0000000 0xf1d
+				0xa0000F20 0xa8
+				0xa0001000 0x1000
+				0x80000 0x3000
+				0xa0100000 0x1000>;
+			reg-names = "dbi", "elbi", "atu", "parf", "config";
+			device_type = "pci";
+			linux,pci-domain = <1>;
+			bus-range = <0x00 0xff>;
+			num-lanes = <2>;
+			max-link-speed = <2>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+
+			phys = <&pcie_x2phy>;
+			phy-names ="pciephy";
+
+			ranges = <0x81000000 0 0xa0200000 0xa0200000
+				  0 0x00100000   /* downstream I/O */
+				  0x82000000 0 0xa0300000 0xa0300000
+				  0 0x10000000>; /* non-prefetchable memory */
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
+			clocks = <&gcc GCC_SYS_NOC_PCIE0_AXI_CLK>,
+				 <&gcc GCC_PCIE0_AXI_M_CLK>,
+				 <&gcc GCC_PCIE0_AXI_S_CLK>,
+				 <&gcc GCC_PCIE0_AHB_CLK>,
+				 <&gcc GCC_PCIE0_AUX_CLK>,
+				 <&gcc GCC_PCIE0_AXI_S_BRIDGE_CLK>;
+
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
+
+			reset-names = "pipe",
+				      "sleep",
+				      "sticky",
+				      "axi_m",
+				      "axi_s",
+				      "ahb",
+				      "axi_m_sticky",
+				      "axi_s_sticky";
+
+			msi-map = <0x0 &v2m0 0x0 0xff8>;
+			status = "disabled";
+		};
+
 	};
 
 	timer {
-- 
2.17.1

