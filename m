Return-Path: <linux-pci+bounces-13426-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B55D98434E
	for <lists+linux-pci@lfdr.de>; Tue, 24 Sep 2024 12:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CD3FB249A7
	for <lists+linux-pci@lfdr.de>; Tue, 24 Sep 2024 10:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD72176AA5;
	Tue, 24 Sep 2024 10:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="EwQMXeO7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0A31714D9;
	Tue, 24 Sep 2024 10:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727172901; cv=none; b=k5P6br6cf41jiRED14FdKqcjnC6K+dqbZprUDOt2XOCMIskABUJdBjrx0n2OYTh/15Y9oq1hPBv0hufFTZt3T2i+ioYCI8/b1BSsbpcS+jh95bSUwdtGd6byzRE6A2f5sK6enncCwezfFPJ5Wp6pimu1/YNvHUM3fLA9CtpExgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727172901; c=relaxed/simple;
	bh=tSc/5jKYwHOo80LzJTmceHoRtIhcvCiHgAqHKczEVyI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sELXAxgNNmaYeBk4UhvXdnzwN5i4jxz142VIqZkParyYDweav69wsUz5rwLFEe9xDimEdakV39LNglD9CDfDehYiUPTkyIA8k8zw6Val7iVRSUrJT+neBRieHN3yVfFjDLafdhWOUP5sWdLtWS913UwFCCbQwiGpIup+1InKd4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=EwQMXeO7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48O6jNfX004886;
	Tue, 24 Sep 2024 10:14:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=HI9fqOFrJ8d
	NwCtjPwqcyklQ/dgCKqxAQalyfBfSw6g=; b=EwQMXeO7ykuL5JgghSrgKCjYpkW
	i75m8/UaPgzh1bS2FuQHR1eopzTiCv7Y59oK/co6IXaJY7FYVRoU9vYAkzmhaa0U
	UB4sVKYtr+eQde16BjqwyNTVa+rNZr0bRhxfBd5emC2iG7/LwXZZyJnSUohvTQEj
	gCnTxnzeX4NURdJukNt0dZ75slVBaQB540YWvJPpQtFAvLo07nxhAt90cinSWaY1
	s2khG4jSA0AOqCy+iA2cLf/Q/V2eiFN3FE8zIbZDL6wbakbWCzKhJrvlpvKat6yQ
	t5z8+dI4gO6CKtGiEL8s7b8QjTY9d03Ezbb4I2hCOD0aAJ8Ej+AJ27TffTQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41sqe97xr5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Sep 2024 10:14:52 +0000 (GMT)
Received: from pps.filterd (NALASPPMTA04.qualcomm.com [127.0.0.1])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 48OAEBNj005190;
	Tue, 24 Sep 2024 10:14:52 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by NALASPPMTA04.qualcomm.com (PPS) with ESMTPS id 41urt1hx6b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Sep 2024 10:14:52 +0000
Received: from NALASPPMTA04.qualcomm.com (NALASPPMTA04.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 48OAEAlY005169;
	Tue, 24 Sep 2024 10:14:51 GMT
Received: from hu-devc-lv-u22-c.qualcomm.com (hu-qianyu-lv.qualcomm.com [10.81.25.114])
	by NALASPPMTA04.qualcomm.com (PPS) with ESMTPS id 48OAEpLq005513
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Sep 2024 10:14:51 +0000
Received: by hu-devc-lv-u22-c.qualcomm.com (Postfix, from userid 4098150)
	id B9A4865F; Tue, 24 Sep 2024 03:14:51 -0700 (PDT)
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
Subject: [PATCH v4 6/6] arm64: dts: qcom: x1e80100: Add support for PCIe3 on x1e80100
Date: Tue, 24 Sep 2024 03:14:44 -0700
Message-Id: <20240924101444.3933828-7-quic_qianyu@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240924101444.3933828-1-quic_qianyu@quicinc.com>
References: <20240924101444.3933828-1-quic_qianyu@quicinc.com>
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
X-Proofpoint-ORIG-GUID: JRJUx05yqHcMIABHa1rXoORBa6YFxc0K
X-Proofpoint-GUID: JRJUx05yqHcMIABHa1rXoORBa6YFxc0K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 spamscore=0 lowpriorityscore=0 adultscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 phishscore=0 impostorscore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409240071

Describe PCIe3 controller and PHY. Also add required system resources like
regulators, clocks, interrupts and registers configuration for PCIe3.

Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
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


