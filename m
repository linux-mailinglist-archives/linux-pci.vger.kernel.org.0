Return-Path: <linux-pci+bounces-27313-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD42AAD3D8
	for <lists+linux-pci@lfdr.de>; Wed,  7 May 2025 05:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D931C3A3359
	for <lists+linux-pci@lfdr.de>; Wed,  7 May 2025 03:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B551139579;
	Wed,  7 May 2025 03:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aUwsj5Je"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64D46A33F;
	Wed,  7 May 2025 03:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746587777; cv=none; b=hjCWoTA3XbYYLKuDnR+LcNFlT5AnIFhIeGHv5R5roIgTtqnJDu6u/nDEvRreY2THBm2gqu0Kw+rwOjSl0ahIFsVERjFIyAo/17ElduzQC23Q6mp2kJRaFqvYgqLEOEb86CDZ3ItKQ+AXHmvvL9K3y7vKPWJwVrtje7yUdHtmJeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746587777; c=relaxed/simple;
	bh=Af5JGQDNFErASgJTBbhnnFv0biZDgKqjN19JbWYDb2M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LRZBnsfvnjv0hD6WQpyVGbrFuJmyPBpSzdaSFvk80jeDDbesNQpypWEOr6/N4ZEjGUKk+lv5K4wd6F6cLnqiKXNH3ONh0LZJhzFNKVNOPxqdZFN5bI/D92mtD+3QEIbmpyvzzAdamh3+/CH12dAOJhHfAYwSgLkQUvwHB9tIE/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=aUwsj5Je; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5471GqRp003295;
	Wed, 7 May 2025 03:16:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=kPqr+5GgSaO
	92Eh7Ig0+igNrDMaeDs/7ZJ3QBAjcN/g=; b=aUwsj5JeCkpqTuTg0zyz+CDv4yX
	32ZXUFcLrPS1PCC8xjczcAwP+H46VYP3vmaC3ieifPo/6YhYBUsFDmqGpkD8JkJJ
	a0GZToxxsztPTDwoBr2hMevV0NEpwTDkVRPLjY96b+anf1dioNhnaJVbjoVU6FNc
	+Pei/fLGJQcTuo956gBDUfm3mcaRQxFbRiDp6wHCOFMj+g2NJysQQ9DaRKBKkFw/
	8aHYhH8CSJPyza6Rk1L6l3KAlhSBNGqhN3VQ6O9zFCTPBt63XwFaOdcNq6wM2XbX
	m6rTVVU96jdUHgWcZmlcYZOvtvBLp4KkK7pqp2BF7cjECd2LUd/JE7znTFg==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46f5sv4bjy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 May 2025 03:16:07 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 5473G5E2012844;
	Wed, 7 May 2025 03:16:05 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 46dc7m60tt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 May 2025 03:16:05 +0000
Received: from APTAIPPMTA02.qualcomm.com (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5473G4xQ012839;
	Wed, 7 May 2025 03:16:05 GMT
Received: from cse-cd02-lnx.ap.qualcomm.com (cse-cd02-lnx.qualcomm.com [10.64.75.246])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 5473G42O012830
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 May 2025 03:16:04 +0000
Received: by cse-cd02-lnx.ap.qualcomm.com (Postfix, from userid 4438065)
	id 5E5CA2F3F; Wed,  7 May 2025 11:16:03 +0800 (CST)
From: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
To: vkoul@kernel.org, kishon@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, dmitry.baryshkov@linaro.org,
        neil.armstrong@linaro.org, abel.vesa@linaro.org,
        manivannan.sadhasivam@linaro.org, lpieralisi@kernel.org, kw@linux.com,
        bhelgaas@google.com, andersson@kernel.org, konradybcio@kernel.org
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, quic_qianyu@quicinc.com,
        quic_krichai@quicinc.com, quic_vbadigan@quicinc.com,
        Ziyue Zhang <quic_ziyuzhan@quicinc.com>
Subject: [PATCH v4 3/5] arm64: dts: qcom: qcs615: enable pcie
Date: Wed,  7 May 2025 11:15:57 +0800
Message-Id: <20250507031559.4085159-4-quic_ziyuzhan@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250507031559.4085159-1-quic_ziyuzhan@quicinc.com>
References: <20250507031559.4085159-1-quic_ziyuzhan@quicinc.com>
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
X-Proofpoint-GUID: WasE_KBgv8I2OIaSvCFqE4yVen_kOdT-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA3MDAyOCBTYWx0ZWRfX77hrpfElQxcr
 1fvWxvBKIoE4h3kFJuADb1vcgzq1Njyd4kEPSJT3jEx0htPAc4QXue1XwrgvV2CUIlC4dgzvpbj
 NWq+UTIwlimfRacAwu4P95EmEqajPBaBNTUbdzt5/FxeaYRi9EHGv6B+dBsk4v/mSIII7701212
 dsbb0N7wQ33RCTvsNJZgM2Xe9l8AXRmZlKWYsxI76Ta0qglkBcJzicFfmyTMesWIi4MvWILCIIb
 cnluDlo/pmwF67wE5xkCAWtIwxOaDfVbVEfe453yZfvceswm5RR9dkwD3Ootw7VmGXKGAa20ZKy
 l/BG4qRF9FPa4QcSTzuSBVriIaf+zTYuczbSFPpK/AuHGH5DgEUFM1AwDRxoTKk//4E6i95lbBL
 RoiUpDm7kvUpglzCT+3CzbwRu0oJ30OMhKYR+MYhjF0yy9BjSj5Rsq67vOhZYip3DsJmyov3
X-Authority-Analysis: v=2.4 cv=cOXgskeN c=1 sm=1 tr=0 ts=681ad077 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8 a=njE0_qILy6epUr2_7ooA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: WasE_KBgv8I2OIaSvCFqE4yVen_kOdT-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-07_01,2025-05-06_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 clxscore=1015 suspectscore=0 priorityscore=1501 bulkscore=0
 mlxlogscore=999 adultscore=0 impostorscore=0 malwarescore=0 spamscore=0
 phishscore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2505070028

From: Krishna chaitanya chundru <quic_krichai@quicinc.com>

Add configurations in devicetree for PCIe0, including registers, clocks,
interrupts and phy setting sequence.

Add PCIe lane equalization preset properties for 8 GT/s.

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Signed-off-by: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
---
 arch/arm64/boot/dts/qcom/qcs615.dtsi | 146 +++++++++++++++++++++++++++
 1 file changed, 146 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs615.dtsi b/arch/arm64/boot/dts/qcom/qcs615.dtsi
index 7c377f3402c1..f7e9b5bbd253 100644
--- a/arch/arm64/boot/dts/qcom/qcs615.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs615.dtsi
@@ -1012,6 +1012,152 @@ mmss_noc: interconnect@1740000 {
 			qcom,bcm-voters = <&apps_bcm_voter>;
 		};
 
+		pcie: pcie@1c08000 {
+			device_type = "pci";
+			compatible = "qcom,qcs615-pcie";
+			reg = <0x0 0x01c08000 0x0 0x3000>,
+			      <0x0 0x40000000 0x0 0xf1d>,
+			      <0x0 0x40000f20 0x0 0xa8>,
+			      <0x0 0x40001000 0x0 0x1000>,
+			      <0x0 0x40100000 0x0 0x100000>,
+			      <0x0 0x01c0b000 0x0 0x1000>;
+			reg-names = "parf",
+				    "dbi",
+				    "elbi",
+				    "atu",
+				    "config",
+				    "mhi";
+			#address-cells = <3>;
+			#size-cells = <2>;
+			ranges = <0x01000000 0x0 0x00000000 0x0 0x40200000 0x0 0x100000>,
+				 <0x02000000 0x0 0x40300000 0x0 0x40300000 0x0 0x1fd00000>;
+			bus-range = <0x00 0xff>;
+
+			dma-coherent;
+
+			linux,pci-domain = <0>;
+			num-lanes = <1>;
+
+			interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
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
+			interrupt-map = <0 0 0 1 &intc 0 0 0 149 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 2 &intc 0 0 0 150 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 3 &intc 0 0 0 151 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 4 &intc 0 0 0 152 IRQ_TYPE_LEVEL_HIGH>;
+
+			clocks = <&gcc GCC_PCIE_0_AUX_CLK>,
+				 <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
+				 <&gcc GCC_PCIE_0_MSTR_AXI_CLK>,
+				 <&gcc GCC_PCIE_0_SLV_AXI_CLK>,
+				 <&gcc GCC_PCIE_0_SLV_Q2A_AXI_CLK>,
+				 <&rpmhcc RPMH_CXO_CLK>;
+			clock-names = "aux",
+				      "cfg",
+				      "bus_master",
+				      "bus_slave",
+				      "slave_q2a",
+				      "ref";
+			assigned-clocks = <&gcc GCC_PCIE_0_AUX_CLK>;
+			assigned-clock-rates = <19200000>;
+
+			interconnects = <&aggre1_noc MASTER_PCIE QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
+					<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &config_noc SLAVE_PCIE_0 QCOM_ICC_TAG_ACTIVE_ONLY>;
+			interconnect-names = "pcie-mem", "cpu-pcie";
+
+			iommu-map = <0x0 &apps_smmu 0x400 0x1>,
+				    <0x100 &apps_smmu 0x401 0x1>;
+
+			resets = <&gcc GCC_PCIE_0_BCR>;
+			reset-names = "pci";
+
+			power-domains = <&gcc PCIE_0_GDSC>;
+
+			phys = <&pcie_phy>;
+			phy-names = "pciephy";
+
+			eq-presets-8gts = /bits/ 16 <0x5555 0x5555 0x5555 0x5555
+					  0x5555 0x5555 0x5555 0x5555>;
+
+			operating-points-v2 = <&pcie_opp_table>;
+
+			status = "disabled";
+
+			pcie_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				/* GEN 1 x1 */
+				opp-2500000 {
+					opp-hz = /bits/ 64 <2500000>;
+					required-opps = <&rpmhpd_opp_low_svs>;
+					opp-peak-kBps = <250000 1>;
+				};
+
+				/* GEN 2 x1 */
+				opp-5000000 {
+					opp-hz = /bits/ 64 <5000000>;
+					required-opps = <&rpmhpd_opp_low_svs>;
+					opp-peak-kBps = <500000 1>;
+				};
+
+				/* GEN 3 x1 */
+				opp-8000000 {
+					opp-hz = /bits/ 64 <8000000>;
+					required-opps = <&rpmhpd_opp_svs_l1>;
+					opp-peak-kBps = <984500 1>;
+				};
+			};
+		};
+
+		pcie_phy: phy@1c0e000 {
+			compatible = "qcom,qcs615-qmp-gen3x1-pcie-phy";
+			reg = <0x0 0x01c0e000 0x0 0x1000>;
+
+			clocks = <&gcc GCC_PCIE_PHY_AUX_CLK>,
+				 <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
+				 <&gcc GCC_PCIE_0_CLKREF_CLK>,
+				 <&gcc GCC_PCIE0_PHY_REFGEN_CLK>,
+				 <&gcc GCC_PCIE_0_PIPE_CLK>;
+			clock-names = "aux",
+				      "cfg_ahb",
+				      "ref",
+				      "refgen",
+				      "pipe";
+
+			resets = <&gcc GCC_PCIE_0_PHY_BCR>;
+			reset-names = "phy";
+
+			assigned-clocks = <&gcc GCC_PCIE0_PHY_REFGEN_CLK>;
+			assigned-clock-rates = <100000000>;
+
+			#clock-cells = <0>;
+			clock-output-names = "pcie_0_pipe_clk";
+
+			#phy-cells = <0>;
+
+			status = "disabled";
+		};
+
 		ufs_mem_hc: ufshc@1d84000 {
 			compatible = "qcom,qcs615-ufshc", "qcom,ufshc", "jedec,ufs-2.0";
 			reg = <0x0 0x01d84000 0x0 0x3000>,
-- 
2.34.1


