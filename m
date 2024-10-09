Return-Path: <linux-pci+bounces-14049-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D229964BE
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 11:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58F871F258D3
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 09:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7395618F2C4;
	Wed,  9 Oct 2024 09:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lU3ysoGs"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA3B18F2C5;
	Wed,  9 Oct 2024 09:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728465368; cv=none; b=lptqyTVJz9+TgSnNytAKiRQo0mf5KeZAjeg8pIrWOLwh9zQXcXmk6z45wmIjGfOrnzAv67MUQ/aZ5D38pmAOyK8k9sAkwFCAltVGXvhFJPmsF6S7JeZzlmkg0mN8bNMhI0Xgr/auE4PPCWvNO6VEZTRjM0LJ1a96r1vtBxG7r/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728465368; c=relaxed/simple;
	bh=eBFW8CfQ3gEDPL7ZftKPyZ/FKbZzXRdT+yLK3E1jol0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cJ6R9CbTbn9mp6znGt8CiMgm04cWd2UVi7v1EHPoElLlHHIeSQJOcduqoIU8BLowHoRPl10n5f3hFpPsifCLdiQLf2MSVljC3mEj1eXPf/ynJHXYItOHd0oaeYKrkPoInvzmwuQBssKuYj6t6ftIGBZ+hZzXTeF9WdmkZHPRj8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lU3ysoGs; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4998sZKG001747;
	Wed, 9 Oct 2024 09:15:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=ksjmpu+gP6F
	6t3NW+fwH7MutOFcoJ/x3YG3lGuhFixw=; b=lU3ysoGsF6k+oi6SsY40CODx8Ft
	zCJ3lA0DIBI9K7z2aFwO0IPON3t4cjtvNGR2gdMs1VrxqwFsRBUUVy8Ax5cbCt5E
	+F3gdFciddDqY/DqVHAiB2LTROs+6CKc3nSwNR4Gs/wvT8pfhHnHq3Yq7ETckKgH
	upI2Qb5r+shkZ3lDDStmN/f7Iif261Jn9c5+73+tLeYL3ITo/XEKgsaX/ll7gyAX
	8NdJ0g7drapM9KMC10DLTlqR+d4Gpr4AvzUpl2/yBFfpNDOBm0hQs7+pntz+WbRm
	mOMuqwAXAcT3LVZwOX+j8Bin7U+Rm2VM2rmePpOxpYwAq6h1qmIg3IWwRyg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42513u3nwy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Oct 2024 09:15:51 +0000 (GMT)
Received: from pps.filterd (NALASPPMTA03.qualcomm.com [127.0.0.1])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 499903WT020905;
	Wed, 9 Oct 2024 09:15:50 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 425fv1utj9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Oct 2024 09:15:50 +0000
Received: from NALASPPMTA03.qualcomm.com (NALASPPMTA03.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 49990PPj021832;
	Wed, 9 Oct 2024 09:15:50 GMT
Received: from hu-devc-lv-u22-c.qualcomm.com (hu-qianyu-lv.qualcomm.com [10.81.25.114])
	by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 4999Fo0K002624
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Oct 2024 09:15:50 +0000
Received: by hu-devc-lv-u22-c.qualcomm.com (Postfix, from userid 4098150)
	id 15B5C656; Wed,  9 Oct 2024 02:15:50 -0700 (PDT)
From: Qiang Yu <quic_qianyu@quicinc.com>
To: manivannan.sadhasivam@linaro.org, vkoul@kernel.org, kishon@kernel.org,
        robh@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, abel.vesa@linaro.org, quic_msarkar@quicinc.com,
        quic_devipriy@quicinc.com
Cc: dmitry.baryshkov@linaro.org, kw@linux.com, lpieralisi@kernel.org,
        neil.armstrong@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, Qiang Yu <quic_qianyu@quicinc.com>
Subject: [PATCH v5 7/7] arm64: dts: qcom: x1e80100: Add support for PCIe3 on x1e80100
Date: Wed,  9 Oct 2024 02:15:40 -0700
Message-Id: <20241009091540.1446-8-quic_qianyu@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241009091540.1446-1-quic_qianyu@quicinc.com>
References: <20241009091540.1446-1-quic_qianyu@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: bnWTbxowXOG_K0NVL0gYhHDRu1KDQ4nm
X-Proofpoint-GUID: bnWTbxowXOG_K0NVL0gYhHDRu1KDQ4nm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 spamscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 suspectscore=0 bulkscore=0
 mlxscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410090060

Describe PCIe3 controller and PHY. Also add required system resources like
regulators, clocks, interrupts and registers configuration for PCIe3.

Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/x1e80100.dtsi | 204 ++++++++++++++++++++++++-
 1 file changed, 203 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
index a36076e3c56b..c615c930cf0c 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
@@ -744,7 +744,7 @@ gcc: clock-controller@100000 {
 
 			clocks = <&bi_tcxo_div2>,
 				 <&sleep_clk>,
-				 <0>,
+				 <&pcie3_phy>,
 				 <&pcie4_phy>,
 				 <&pcie5_phy>,
 				 <&pcie6a_phy>,
@@ -2907,6 +2907,208 @@ mmss_noc: interconnect@1780000 {
 			#interconnect-cells = <2>;
 		};
 
+		pcie3: pcie@1bd0000 {
+			device_type = "pci";
+			compatible = "qcom,pcie-x1e80100";
+			reg = <0x0 0x01bd0000 0x0 0x3000>,
+			      <0x0 0x78000000 0x0 0xf1d>,
+			      <0x0 0x78000f40 0x0 0xa8>,
+			      <0x0 0x78001000 0x0 0x1000>,
+			      <0x0 0x78100000 0x0 0x100000>,
+			      <0x0 0x01bd3000 0x0 0x1000>;
+			reg-names = "parf",
+				    "dbi",
+				    "elbi",
+				    "atu",
+				    "config",
+				    "mhi";
+			#address-cells = <3>;
+			#size-cells = <2>;
+			ranges = <0x01000000 0x0 0x00000000 0x0 0x78200000 0x0 0x100000>,
+				 <0x02000000 0x0 0x78300000 0x0 0x78300000 0x0 0x3d00000>,
+				 <0x03000000 0x7 0x40000000 0x7 0x40000000 0x0 0x40000000>;
+			bus-range = <0x00 0xff>;
+
+			dma-coherent;
+
+			linux,pci-domain = <3>;
+			num-lanes = <8>;
+
+			interrupts = <GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 166 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 769 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 836 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 671 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 200 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 218 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 219 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>;
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
+			interrupt-map = <0 0 0 1 &intc 0 0 GIC_SPI 220 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 2 &intc 0 0 GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 3 &intc 0 0 GIC_SPI 237 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 4 &intc 0 0 GIC_SPI 238 IRQ_TYPE_LEVEL_HIGH>;
+
+			clocks = <&gcc GCC_PCIE_3_AUX_CLK>,
+				 <&gcc GCC_PCIE_3_CFG_AHB_CLK>,
+				 <&gcc GCC_PCIE_3_MSTR_AXI_CLK>,
+				 <&gcc GCC_PCIE_3_SLV_AXI_CLK>,
+				 <&gcc GCC_PCIE_3_SLV_Q2A_AXI_CLK>,
+				 <&gcc GCC_CFG_NOC_PCIE_ANOC_NORTH_AHB_CLK>,
+				 <&gcc GCC_CNOC_PCIE_NORTH_SF_AXI_CLK>;
+			clock-names = "aux",
+				      "cfg",
+				      "bus_master",
+				      "bus_slave",
+				      "slave_q2a",
+				      "noc_aggr",
+				      "cnoc_sf_axi";
+
+			assigned-clocks = <&gcc GCC_PCIE_3_AUX_CLK>;
+			assigned-clock-rates = <19200000>;
+
+			interconnects = <&pcie_south_anoc MASTER_PCIE_3 QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
+					<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
+					 &cnoc_main SLAVE_PCIE_3 QCOM_ICC_TAG_ALWAYS>;
+			interconnect-names = "pcie-mem",
+					     "cpu-pcie";
+
+			resets = <&gcc GCC_PCIE_3_BCR>,
+				 <&gcc GCC_PCIE_3_LINK_DOWN_BCR>;
+			reset-names = "pci",
+				      "link_down";
+
+			power-domains = <&gcc GCC_PCIE_3_GDSC>;
+
+			phys = <&pcie3_phy>;
+			phy-names = "pciephy";
+
+			operating-points-v2 = <&pcie3_opp_table>;
+
+			status = "disabled";
+
+			pcie3_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				/* GEN 1 x1 */
+				opp-2500000 {
+					opp-hz = /bits/ 64 <2500000>;
+					required-opps = <&rpmhpd_opp_low_svs>;
+					opp-peak-kBps = <250000 1>;
+				};
+
+				/* GEN 1 x2 and GEN 2 x1 */
+				opp-5000000 {
+					opp-hz = /bits/ 64 <5000000>;
+					required-opps = <&rpmhpd_opp_low_svs>;
+					opp-peak-kBps = <500000 1>;
+				};
+
+				/* GEN 1 x4 and GEN 2 x2 */
+				opp-10000000 {
+					opp-hz = /bits/ 64 <10000000>;
+					required-opps = <&rpmhpd_opp_low_svs>;
+					opp-peak-kBps = <1000000 1>;
+				};
+
+				/* GEN 1 x8 and GEN 2 x4 */
+				opp-20000000 {
+					opp-hz = /bits/ 64 <20000000>;
+					required-opps = <&rpmhpd_opp_low_svs>;
+					opp-peak-kBps = <2000000 1>;
+				};
+
+				/* GEN 2 x8 */
+				opp-40000000 {
+					opp-hz = /bits/ 64 <40000000>;
+					required-opps = <&rpmhpd_opp_low_svs>;
+					opp-peak-kBps = <4000000 1>;
+				};
+
+				/* GEN 3 x1 */
+				opp-8000000 {
+					opp-hz = /bits/ 64 <8000000>;
+					required-opps = <&rpmhpd_opp_svs>;
+					opp-peak-kBps = <984500 1>;
+				};
+
+				/* GEN 3 x2 and GEN 4 x1 */
+				opp-16000000 {
+					opp-hz = /bits/ 64 <16000000>;
+					required-opps = <&rpmhpd_opp_svs>;
+					opp-peak-kBps = <1969000 1>;
+				};
+
+				/* GEN 3 x4 and GEN 4 x2 */
+				opp-32000000 {
+					opp-hz = /bits/ 64 <32000000>;
+					required-opps = <&rpmhpd_opp_svs>;
+					opp-peak-kBps = <3938000 1>;
+				};
+
+				/* GEN 3 x8 and GEN 4 x4 */
+				opp-64000000 {
+					opp-hz = /bits/ 64 <64000000>;
+					required-opps = <&rpmhpd_opp_svs>;
+					opp-peak-kBps = <7876000 1>;
+				};
+
+				/* GEN 4 x8 */
+				opp-128000000 {
+					opp-hz = /bits/ 64 <128000000>;
+					required-opps = <&rpmhpd_opp_svs>;
+					opp-peak-kBps = <15753000 1>;
+				};
+			};
+		};
+
+		pcie3_phy: phy@1be0000 {
+			compatible = "qcom,x1e80100-qmp-gen4x8-pcie-phy";
+			reg = <0 0x01be0000 0 0x10000>;
+
+			clocks = <&gcc GCC_PCIE_3_PHY_AUX_CLK>,
+				 <&gcc GCC_PCIE_3_CFG_AHB_CLK>,
+				 <&tcsr TCSR_PCIE_8L_CLKREF_EN>,
+				 <&gcc GCC_PCIE_3_PHY_RCHNG_CLK>,
+				 <&gcc GCC_PCIE_3_PIPE_CLK>,
+				 <&gcc GCC_PCIE_3_PIPEDIV2_CLK>;
+			clock-names = "aux",
+				      "cfg_ahb",
+				      "ref",
+				      "rchng",
+				      "pipe",
+				      "pipediv2";
+
+			resets = <&gcc GCC_PCIE_3_PHY_BCR>,
+				 <&gcc GCC_PCIE_3_NOCSR_COM_PHY_BCR>;
+			reset-names = "phy",
+				      "phy_nocsr";
+
+			assigned-clocks = <&gcc GCC_PCIE_3_PHY_RCHNG_CLK>;
+			assigned-clock-rates = <100000000>;
+
+			power-domains = <&gcc GCC_PCIE_3_PHY_GDSC>;
+
+			#clock-cells = <0>;
+			clock-output-names = "pcie3_pipe_clk";
+
+			#phy-cells = <0>;
+
+			status = "disabled";
+		};
+
 		pcie6a: pci@1bf8000 {
 			device_type = "pci";
 			compatible = "qcom,pcie-x1e80100";
-- 
2.34.1


