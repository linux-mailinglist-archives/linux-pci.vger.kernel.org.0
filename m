Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C941B747F48
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jul 2023 10:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232068AbjGEISJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Jul 2023 04:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232564AbjGEIRy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Jul 2023 04:17:54 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A87421982;
        Wed,  5 Jul 2023 01:17:49 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3656llTh024298;
        Wed, 5 Jul 2023 08:17:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=G1CBJnij9cSKtPpysHIBpDdDxy+ojc/2Tm12jyKhlZY=;
 b=Ce1CGzdW0/P182mJDlYffBwJimgyjMZuwLDCDzVHpfAymdZtuB8RtH8EWUkhz4VHAu7t
 CFB2fBiBkO1s9i7WvwPSGVpz15RcTkc1aIQf+C0ufFJRb1CN25jRC6Ti13vCSqjCqj5q
 dWHriZ6cqz9RRpqIbsoxvsUeYNTma2eK91BW2f5tZPIWpXdN23Hpy9PzAsd6HXJKKSLq
 R8cnTb364i7S4zBCodgYES9oKEDkJMrEafuFrffXpY18hrLlo47J09DwekhDdss7RgWy
 iK4nmcFn4hzKs/0tBsIdhf9xnwDjrZS8ZOCRMh46s+e1dcZsaa46ps3bZ8F35PhNW+LU Cg== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rn2cp88ut-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Jul 2023 08:17:40 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3658HTed021561;
        Wed, 5 Jul 2023 08:17:37 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3rjd7krn99-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 05 Jul 2023 08:17:37 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3658HLrP021317;
        Wed, 5 Jul 2023 08:17:36 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-msarkar-hyd.qualcomm.com [10.213.111.194])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3658HaOS022048;
        Wed, 05 Jul 2023 08:17:36 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3891782)
        id DC507244; Wed,  5 Jul 2023 13:47:35 +0530 (+0530)
From:   Mrinmay Sarkar <quic_msarkar@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        konrad.dybcio@linaro.org, mani@kernel.org
Cc:     quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com,
        quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com,
        Mrinmay Sarkar <quic_msarkar@quicinc.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org
Subject: [PATCH v1 5/6] arm64: dts: qcom: sa8775p: Add pcie0 and pcie1 nodes
Date:   Wed,  5 Jul 2023 13:47:10 +0530
Message-Id: <1688545032-17748-6-git-send-email-quic_msarkar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1688545032-17748-1-git-send-email-quic_msarkar@quicinc.com>
References: <1688545032-17748-1-git-send-email-quic_msarkar@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: of13ORcAeikGCUovEybWdpGe_MPxwoUX
X-Proofpoint-ORIG-GUID: of13ORcAeikGCUovEybWdpGe_MPxwoUX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-04_16,2023-07-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 suspectscore=0 impostorscore=0 mlxscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307050075
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add pcie dtsi nodes for two controllers found on sa8775p platform.

Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sa8775p.dtsi | 201 +++++++++++++++++++++++++-
 1 file changed, 199 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
index b130136acffe..88749cbaea8b 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
@@ -481,8 +481,8 @@ gcc: clock-controller@100000 {
 				 <0>,
 				 <0>,
 				 <0>,
-				 <0>,
-				 <0>,
+				 <&pcie0_phy>,
+				 <&pcie1_phy>,
 				 <0>,
 				 <0>,
 				 <0>;
@@ -2315,4 +2315,201 @@ arch_timer: timer {
 			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
 			     <GIC_PPI 12 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>;
 	};
+
+	pcie0: pci@1c00000{
+		device_type = "pci";
+		compatible = "qcom,pcie-sa8775p";
+		reg = <0x0 0x01c00000 0x0 0x3000>,
+		      <0x0 0x40000000 0x0 0xf20>,
+		      <0x0 0x40000f20 0x0 0xa8>,
+		      <0x0 0x40001000 0x0 0x4000>,
+		      <0x0 0x40100000 0x0 0x100000>,
+		      <0x0 0x01c03000 0x0 0x1000>;
+		reg-names = "parf", "dbi", "elbi", "atu", "config", "mhi";
+
+		#address-cells = <3>;
+		#size-cells = <2>;
+		ranges = <0x01000000 0x0 0x40200000 0x0 0x40200000 0x0 0x100000>,
+			<0x02000000 0x0 0x40300000 0x0 0x40300000 0x0 0x1fd00000>;
+		bus-range = <0x00 0xff>;
+
+		linux,pci-domain = <0>;
+		num-lanes = <2>;
+
+		interrupts = <GIC_SPI 307 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "msi";
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 0 0 0x7>;
+		interrupt-map = <0 0 0 1 &intc GIC_SPI 434 IRQ_TYPE_LEVEL_HIGH>,
+			<0 0 0 2 &intc GIC_SPI 435 IRQ_TYPE_LEVEL_HIGH>,
+			<0 0 0 3 &intc GIC_SPI 438 IRQ_TYPE_LEVEL_HIGH>,
+			<0 0 0 4 &intc GIC_SPI 439 IRQ_TYPE_LEVEL_HIGH>;
+
+		clocks = <&gcc GCC_PCIE_0_AUX_CLK>,
+			<&gcc GCC_PCIE_0_CFG_AHB_CLK>,
+			<&gcc GCC_PCIE_0_MSTR_AXI_CLK>,
+			<&gcc GCC_PCIE_0_SLV_AXI_CLK>,
+			<&gcc GCC_PCIE_0_SLV_Q2A_AXI_CLK>;
+
+		clock-names = "aux",
+				"cfg",
+				"bus_master",
+				"bus_slave",
+				"slave_q2a";
+
+		assigned-clocks = <&gcc GCC_PCIE_0_AUX_CLK>;
+		assigned-clock-rates = <19200000>;
+
+		interconnects = <&pcie_anoc MASTER_PCIE_0 0 &mc_virt SLAVE_EBI1 0>;
+		interconnect-names = "pcie-mem";
+
+		resets = <&gcc GCC_PCIE_0_BCR>;
+		reset-names = "pci";
+		power-domains = <&gcc PCIE_0_GDSC>;
+
+		phys = <&pcie0_phy>;
+		phy-names = "pciephy";
+
+		iommus = <&pcie_smmu 0x0000 0x1>;
+		iommu-map = <0x0 &pcie_smmu 0x0000 0x1>,
+			<0x100 &pcie_smmu 0x0001 0x1>;
+
+		perst-gpios = <&tlmm 2 1>;
+		wake-gpios = <&tlmm 0 0>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&pcie0_default_state>;
+
+		status = "disabled";
+	};
+
+	pcie0_phy: phy@1c04000 {
+		compatible = "qcom,sa8775p-qmp-gen4x2-pcie-phy";
+		reg = <0x0 0x1c04000 0x0 0x2000>;
+
+		clocks = <&gcc GCC_PCIE_0_AUX_CLK>,
+			 <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
+			 <&gcc GCC_PCIE_CLKREF_EN>,
+			 <&gcc GCC_PCIE_0_PHY_RCHNG_CLK>,
+			 <&gcc GCC_PCIE_0_PHY_AUX_CLK>,
+			 <&gcc GCC_PCIE_0_PIPE_CLK>,
+			 <&gcc GCC_PCIE_0_PIPEDIV2_CLK>;
+
+		clock-names = "aux", "cfg_ahb", "ref", "rchng", "phy_aux",
+						"pipe", "pipediv2";
+
+		assigned-clocks = <&gcc GCC_PCIE_0_PHY_RCHNG_CLK>;
+		assigned-clock-rates = <100000000>;
+
+		power-domains = <&gcc PCIE_0_GDSC>;
+
+		resets = <&gcc GCC_PCIE_0_PHY_BCR>;
+		reset-names = "phy";
+
+		#clock-cells = <0>;
+		clock-output-names = "pcie_0_pipe_clk";
+
+		#phy-cells = <0>;
+
+		status = "disabled";
+	};
+
+	pcie1: pci@1c10000{
+		device_type = "pci";
+		compatible = "qcom,pcie-sa8775p";
+		reg = <0x0 0x01c10000 0x0 0x3000>,
+		      <0x0 0x60000000 0x0 0xf20>,
+		      <0x0 0x60000f20 0x0 0xa8>,
+		      <0x0 0x60001000 0x0 0x4000>,
+		      <0x0 0x60100000 0x0 0x100000>,
+		      <0x0 0x01c13000 0x0 0x1000>;
+		reg-names = "parf", "dbi", "elbi", "atu", "config", "mhi";
+
+		#address-cells = <3>;
+		#size-cells = <2>;
+		ranges = <0x01000000 0x0 0x60200000 0x0 0x60200000 0x0 0x100000>,
+			<0x02000000 0x0 0x60300000 0x0 0x60300000 0x0 0x1fd00000>;
+		bus-range = <0x00 0xff>;
+
+		linux,pci-domain = <1>;
+		num-lanes = <4>;
+
+		interrupts = <GIC_SPI 519 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "msi";
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 0 0 0x7>;
+		interrupt-map = <0 0 0 1 &intc GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 0 2 &intc GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 0 3 &intc GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 0 4 &intc GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>;
+
+		clocks = <&gcc GCC_PCIE_1_AUX_CLK>,
+			<&gcc GCC_PCIE_1_CFG_AHB_CLK>,
+			<&gcc GCC_PCIE_1_MSTR_AXI_CLK>,
+			<&gcc GCC_PCIE_1_SLV_AXI_CLK>,
+			<&gcc GCC_PCIE_1_SLV_Q2A_AXI_CLK>;
+
+		clock-names = "aux",
+				"cfg",
+				"bus_master",
+				"bus_slave",
+				"slave_q2a";
+
+		assigned-clocks = <&gcc GCC_PCIE_1_AUX_CLK>;
+		assigned-clock-rates = <19200000>;
+
+		interconnects = <&pcie_anoc MASTER_PCIE_1 0 &mc_virt SLAVE_EBI1 0>;
+		interconnect-names = "pcie-mem";
+
+		resets = <&gcc GCC_PCIE_1_BCR>;
+		reset-names = "pci";
+		power-domains = <&gcc PCIE_1_GDSC>;
+
+		phys = <&pcie1_phy>;
+		phy-names = "pciephy";
+
+		iommus = <&pcie_smmu 0x0080 0x1>;
+		iommu-map = <0x0 &pcie_smmu 0x0080 0x1>,
+			<0x100 &pcie_smmu 0x0081 0x1>;
+
+		perst-gpios = <&tlmm 4 1>;
+		wake-gpios = <&tlmm 5 0>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&pcie1_default_state>;
+
+		status = "disabled";
+	};
+
+	pcie1_phy: phy@1c14000 {
+		compatible = "qcom,sa8775p-qmp-gen4x4-pcie-phy";
+		reg = <0x0 0x1c14000 0x0 0x4000>;
+
+		clocks = <&gcc GCC_PCIE_1_AUX_CLK>,
+			 <&gcc GCC_PCIE_1_CFG_AHB_CLK>,
+			 <&gcc GCC_PCIE_CLKREF_EN>,
+			 <&gcc GCC_PCIE_1_PHY_RCHNG_CLK>,
+			 <&gcc GCC_PCIE_1_PHY_AUX_CLK>,
+			 <&gcc GCC_PCIE_1_PIPE_CLK>,
+			 <&gcc GCC_PCIE_1_PIPEDIV2_CLK>;
+
+		clock-names = "aux", "cfg_ahb", "ref", "rchng", "phy_aux",
+						"pipe", "pipediv2";
+
+		assigned-clocks = <&gcc GCC_PCIE_1_PHY_RCHNG_CLK>;
+		assigned-clock-rates = <100000000>;
+
+		power-domains = <&gcc PCIE_1_GDSC>;
+
+		resets = <&gcc GCC_PCIE_1_PHY_BCR>;
+		reset-names = "phy";
+
+		#clock-cells = <0>;
+		clock-output-names = "pcie_1_pipe_clk";
+
+		#phy-cells = <0>;
+
+		status = "disabled";
+
+	};
 };
-- 
2.39.2

