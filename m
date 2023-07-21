Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6414975D09A
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jul 2023 19:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbjGURZE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Jul 2023 13:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbjGURY7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Jul 2023 13:24:59 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF542691;
        Fri, 21 Jul 2023 10:24:57 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36L9cj4d019572;
        Fri, 21 Jul 2023 17:24:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=85UC/4/Geciipqr3eLRLQLu1VtLSki/byJNTttdKQ+U=;
 b=BQctjkdwmXky1ogAZE8KcZQDePSzckhJ06NpF42rUkgVaYtXyl1zU4tfCGwkkfSlpCxh
 C2v7W9HiH7ym62Ey5xu8jeAD5kckfMb+ZgAltr134sK+r7L9a0TIV34G9/LOmcpwqtyS
 zcOUbE7vXkO72/tJTWTDwlgiZgjTpgfaJrrCup39ak5e2GxbRjJeoKAOFXCOiCLzr+I8
 r7Z+3JiBE+3zmrnnlUr7HRW+ZKUvcWKdGOWgMWQxKfUZYcdNxxqcvZ02BZYXPGgZtiQO
 WRNLQ2PdtN74Vih02jtx3LfdphhFpNTS8inr0Bg4i7s73//rUZbNFv/STs0VrQtJzI9n Jw== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rynfqsbam-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jul 2023 17:24:50 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 36LHOlin023788;
        Fri, 21 Jul 2023 17:24:47 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3rumhknepr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 21 Jul 2023 17:24:47 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36LHOlED023783;
        Fri, 21 Jul 2023 17:24:47 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-msarkar-hyd.qualcomm.com [10.213.111.194])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 36LHOkmQ023782;
        Fri, 21 Jul 2023 17:24:47 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3891782)
        id 55CE632C9; Fri, 21 Jul 2023 22:54:46 +0530 (+0530)
From:   Mrinmay Sarkar <quic_msarkar@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        konrad.dybcio@linaro.org, mani@kernel.org
Cc:     quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com,
        quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com,
        dmitry.baryshkov@linaro.org,
        Mrinmay Sarkar <quic_msarkar@quicinc.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/4] arm64: dts: qcom: sa8775p: Add pcie0 and pcie1 nodes
Date:   Fri, 21 Jul 2023 22:54:34 +0530
Message-Id: <1689960276-29266-4-git-send-email-quic_msarkar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1689960276-29266-1-git-send-email-quic_msarkar@quicinc.com>
References: <1689960276-29266-1-git-send-email-quic_msarkar@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Buy7lTc0HZpSzw2aToXtieGhuNufd8cX
X-Proofpoint-GUID: Buy7lTc0HZpSzw2aToXtieGhuNufd8cX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-21_10,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 mlxscore=0 bulkscore=0 spamscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2307210151
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add pcie dtsi nodes for two controllers found on sa8775p platform.

Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sa8775p.dtsi | 204 +++++++++++++++++++++++++++++++++-
 1 file changed, 202 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
index 59eedfc..7b55cb7 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
@@ -481,8 +481,8 @@
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
@@ -2357,4 +2357,204 @@
 			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
 			     <GIC_PPI 12 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>;
 	};
+
+	pcie0: pci@1c00000{
+		compatible = "qcom,pcie-sa8775p";
+		reg = <0x0 0x01c00000 0x0 0x3000>,
+		      <0x0 0x40000000 0x0 0xf20>,
+		      <0x0 0x40000f20 0x0 0xa8>,
+		      <0x0 0x40001000 0x0 0x4000>,
+		      <0x0 0x40100000 0x0 0x100000>,
+		      <0x0 0x01c03000 0x0 0x1000>;
+		reg-names = "parf", "dbi", "elbi", "atu", "config", "mhi";
+		device_type = "pci";
+
+		#address-cells = <3>;
+		#size-cells = <2>;
+		ranges = <0x01000000 0x0 0x00000000 0x0 0x40200000 0x0 0x100000>,
+			 <0x02000000 0x0 0x40300000 0x0 0x40300000 0x0 0x1fd00000>;
+		bus-range = <0x00 0xff>;
+
+		dma-coherent;
+
+		linux,pci-domain = <0>;
+		num-lanes = <2>;
+
+		interrupts = <GIC_SPI 307 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 308 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 309 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 312 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 313 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 314 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 374 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 375 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "msi0", "msi1", "msi2", "msi3",
+				  "msi4", "msi5", "msi6", "msi7";
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 0 0 0x7>;
+		interrupt-map = <0 0 0 1 &intc GIC_SPI 434 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 0 2 &intc GIC_SPI 435 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 0 3 &intc GIC_SPI 438 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 0 4 &intc GIC_SPI 439 IRQ_TYPE_LEVEL_HIGH>;
+
+		clocks = <&gcc GCC_PCIE_0_AUX_CLK>,
+			 <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
+			 <&gcc GCC_PCIE_0_MSTR_AXI_CLK>,
+			 <&gcc GCC_PCIE_0_SLV_AXI_CLK>,
+			 <&gcc GCC_PCIE_0_SLV_Q2A_AXI_CLK>;
+
+		clock-names = "aux",
+			      "cfg",
+			      "bus_master",
+			      "bus_slave",
+			      "slave_q2a";
+
+		assigned-clocks = <&gcc GCC_PCIE_0_AUX_CLK>;
+		assigned-clock-rates = <19200000>;
+
+		interconnects = <&pcie_anoc MASTER_PCIE_0 0 &mc_virt SLAVE_EBI1 0>,
+				<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_PCIE_0 0>;
+		interconnect-names = "pcie-mem", "cpu-pcie";
+
+		iommu-map = <0x0 &pcie_smmu 0x0000 0x1>,
+			    <0x100 &pcie_smmu 0x0001 0x1>;
+
+		resets = <&gcc GCC_PCIE_0_BCR>;
+		reset-names = "pci";
+		power-domains = <&gcc PCIE_0_GDSC>;
+
+		phys = <&pcie0_phy>;
+		phy-names = "pciephy";
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
+			 <&gcc GCC_PCIE_0_PIPE_CLK>,
+			 <&gcc GCC_PCIE_0_PIPEDIV2_CLK>,
+			 <&gcc GCC_PCIE_0_PHY_AUX_CLK>;
+
+		clock-names = "aux", "cfg_ahb", "ref", "rchng", "pipe",
+			      "pipediv2", "phy_aux";
+
+		assigned-clocks = <&gcc GCC_PCIE_0_PHY_RCHNG_CLK>;
+		assigned-clock-rates = <100000000>;
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
+		compatible = "qcom,pcie-sa8775p";
+		reg = <0x0 0x01c10000 0x0 0x3000>,
+		      <0x0 0x60000000 0x0 0xf20>,
+		      <0x0 0x60000f20 0x0 0xa8>,
+		      <0x0 0x60001000 0x0 0x4000>,
+		      <0x0 0x60100000 0x0 0x100000>,
+		      <0x0 0x01c13000 0x0 0x1000>;
+		reg-names = "parf", "dbi", "elbi", "atu", "config", "mhi";
+		device_type = "pci";
+
+		#address-cells = <3>;
+		#size-cells = <2>;
+		ranges = <0x01000000 0x0 0x00000000 0x0 0x60200000 0x0 0x100000>,
+			 <0x02000000 0x0 0x60300000 0x0 0x60300000 0x0 0x1fd00000>;
+		bus-range = <0x00 0xff>;
+
+		dma-coherent;
+
+		linux,pci-domain = <1>;
+		num-lanes = <4>;
+
+		interrupts = <GIC_SPI 519 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "msi0", "msi1", "msi2", "msi3",
+				  "msi4", "msi5", "msi6", "msi7";
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 0 0 0x7>;
+		interrupt-map = <0 0 0 1 &intc GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 0 2 &intc GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 0 3 &intc GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 0 4 &intc GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>;
+
+		clocks = <&gcc GCC_PCIE_1_AUX_CLK>,
+			 <&gcc GCC_PCIE_1_CFG_AHB_CLK>,
+			 <&gcc GCC_PCIE_1_MSTR_AXI_CLK>,
+			 <&gcc GCC_PCIE_1_SLV_AXI_CLK>,
+			 <&gcc GCC_PCIE_1_SLV_Q2A_AXI_CLK>;
+
+		clock-names = "aux",
+			      "cfg",
+			      "bus_master",
+			      "bus_slave",
+			      "slave_q2a";
+
+		assigned-clocks = <&gcc GCC_PCIE_1_AUX_CLK>;
+		assigned-clock-rates = <19200000>;
+
+		interconnects = <&pcie_anoc MASTER_PCIE_1 0 &mc_virt SLAVE_EBI1 0>,
+				<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_PCIE_1 0>;
+		interconnect-names = "pcie-mem", "cpu-pcie";
+
+		iommu-map = <0x0 &pcie_smmu 0x0080 0x1>,
+			    <0x100 &pcie_smmu 0x0081 0x1>;
+
+		resets = <&gcc GCC_PCIE_1_BCR>;
+		reset-names = "pci";
+		power-domains = <&gcc PCIE_1_GDSC>;
+
+		phys = <&pcie1_phy>;
+		phy-names = "pciephy";
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
+			 <&gcc GCC_PCIE_1_PIPE_CLK>,
+			 <&gcc GCC_PCIE_1_PIPEDIV2_CLK>,
+			 <&gcc GCC_PCIE_1_PHY_AUX_CLK>;
+
+		clock-names = "aux", "cfg_ahb", "ref", "rchng", "pipe",
+			      "pipediv2", "phy_aux";
+
+		assigned-clocks = <&gcc GCC_PCIE_1_PHY_RCHNG_CLK>;
+		assigned-clock-rates = <100000000>;
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
+	};
 };
-- 
2.7.4

