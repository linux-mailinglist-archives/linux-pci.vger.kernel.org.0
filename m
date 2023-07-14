Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F27907530F7
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jul 2023 07:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234657AbjGNFJU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Jul 2023 01:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234849AbjGNFJQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Jul 2023 01:09:16 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC85330DF;
        Thu, 13 Jul 2023 22:09:10 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36E4wSRV026226;
        Fri, 14 Jul 2023 05:09:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=85UC/4/Geciipqr3eLRLQLu1VtLSki/byJNTttdKQ+U=;
 b=DNx/zm76nv12CUtk9HvheiVDL64PFP1efEaY9M4QKtoGMjBxu3MFKe8B8flMx6VjO9cI
 75Kmdhbsfc4swdnrvkVSpgbCjar8j2IzyNf+w2Swsp8dqoAa1GBRn9U70+2OEceuksju
 Q8yojK7xW3Ucc0paPmz+kSHcWEEGVUPzkCK5eBUx/6TbfgwsgEMfr9/OEp2lTC/6d7Dg
 KPto2ZjRBYTdlP12dneSquKtLsXYhN7qA/hs6xIPEg0fOjV6nB0FnHP8a/zv4s3+bFGs
 nVtVchPc4Yem50hkyM68fEGVwCJA0nNto4y2edMxNEM2recV6oER1IGbsQsGJPydChkW Ow== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rtptu8w8c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jul 2023 05:09:00 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 36E58vlu001399;
        Fri, 14 Jul 2023 05:08:57 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3rq0vm577w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 14 Jul 2023 05:08:57 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36E58ucU001391;
        Fri, 14 Jul 2023 05:08:56 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-msarkar-hyd.qualcomm.com [10.213.111.194])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 36E58uMr001390;
        Fri, 14 Jul 2023 05:08:56 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3891782)
        id F05E1333B; Fri, 14 Jul 2023 10:38:55 +0530 (+0530)
From:   Mrinmay Sarkar <quic_msarkar@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        konrad.dybcio@linaro.org, mani@kernel.org
Cc:     quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com,
        quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com,
        dmitry.baryshkov@linaro.org,
        Mrinmay Sarkar <quic_msarkar@quicinc.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org
Subject: [PATCH v2 5/6] arm64: dts: qcom: sa8775p: Add pcie0 and pcie1 nodes
Date:   Fri, 14 Jul 2023 10:38:37 +0530
Message-Id: <1689311319-22054-6-git-send-email-quic_msarkar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1689311319-22054-1-git-send-email-quic_msarkar@quicinc.com>
References: <1689311319-22054-1-git-send-email-quic_msarkar@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: yhBUXB1oF24lg2xTmIPtBRt99Yx_DQB7
X-Proofpoint-ORIG-GUID: yhBUXB1oF24lg2xTmIPtBRt99Yx_DQB7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-14_02,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 mlxscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 spamscore=0 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307140046
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

