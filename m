Return-Path: <linux-pci+bounces-31238-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65103AF1218
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 12:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A77D3B67DE
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 10:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA142638BC;
	Wed,  2 Jul 2025 10:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PZv9wqfy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F3C25EF87;
	Wed,  2 Jul 2025 10:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751452583; cv=none; b=hxAveg91jyXwdggYgrU7rhrR7UxxX/DobAzAnZyW/teJ5qezbksW0qBdfc+Hw71JCB3nGKrbQnbRYQXhycahxHwIIywveGKLa46As7khVxAGNFon/O4+VuoyYHzBR7/Jg0je4D6eoT2TjhWRgwfWS/A+Szk0B5r6zaGe7Q0Owec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751452583; c=relaxed/simple;
	bh=2D04ihMMnPbEEYqtJZX9IeIE/oUIxCvYm6Hc6D0nJBI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y5MfdhTOHG7sOxO27OzBSnd6SH4zo6ftFk7K8xwsemg7wGu7Bb3wpW5tZa/pCVq8aKDSBRhLoUT/E4bFFaWMJvOWSgvPGijRQwxiz+W9ZRgVh3YdFqpVBJVHc66FhEb0TAbamA807H7aFtDRLe98ShRKkMwnfu8i7H44DuXnL6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PZv9wqfy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 562A9Ns6013520;
	Wed, 2 Jul 2025 10:36:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=JqIX9rFpG6n
	eNeKrc6CB7qwOOUGY5Qw523TOvTTnG0E=; b=PZv9wqfyvM7nmeo1a/q39yfjRKt
	xj7ioFgP6B0+Y4q6w7s2PVRj7LFxGhzUryDQHO6xcPjSXyjta8TCU4lAXW7tP1ZP
	YgEbYKcw7hKUIxNDrfT3OW5IITGhv9ONpT7XUS4TdbGHMIZQXE6SADNBGkBrYrof
	bihikzk8Ea4Fa43gVBrT9wae5ZFYQqZgEXjD4tBNTA7I3PupVXiOCVc9z7fPqvu4
	laD76o++gXH4dmwdiEaFyjvsXiPHmtFBCkSc9pANn45uUn554MQ1qMVQiqJRGuEG
	ipTrShAaYiaLiq27ro/3vzqOwxammQsicki2NngHfNF3tTxO8Bdd/nKfP/Q==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47j80244w8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Jul 2025 10:36:09 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 562Aa6Mb003675;
	Wed, 2 Jul 2025 10:36:06 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 47j9fmbh2v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Jul 2025 10:36:06 +0000
Received: from APTAIPPMTA02.qualcomm.com (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 562Aa5Gk003661;
	Wed, 2 Jul 2025 10:36:05 GMT
Received: from cse-cd02-lnx.ap.qualcomm.com (cse-cd02-lnx.qualcomm.com [10.64.75.246])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 562Aa4AR003655
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Jul 2025 10:36:05 +0000
Received: by cse-cd02-lnx.ap.qualcomm.com (Postfix, from userid 4438065)
	id BD9AD3926; Wed,  2 Jul 2025 18:36:03 +0800 (CST)
From: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
To: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, jingoohan1@gmail.com,
        mani@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org,
        bhelgaas@google.com, johan+linaro@kernel.org, vkoul@kernel.org,
        kishon@kernel.org, neil.armstrong@linaro.org, abel.vesa@linaro.org,
        kw@linux.com
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org, qiang.yu@oss.qualcomm.com,
        quic_krichai@quicinc.com, quic_vbadigan@quicinc.com,
        Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: [PATCH v7 2/3] arm64: dts: qcom: qcs615: enable pcie
Date: Wed,  2 Jul 2025 18:35:48 +0800
Message-Id: <20250702103549.712039-3-ziyue.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250702103549.712039-1-ziyue.zhang@oss.qualcomm.com>
References: <20250702103549.712039-1-ziyue.zhang@oss.qualcomm.com>
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
X-Proofpoint-GUID: 9ZhoNPBo8j4nPZrJfo9UmWeaQs9_b4q_
X-Authority-Analysis: v=2.4 cv=YPWfyQGx c=1 sm=1 tr=0 ts=68650b99 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=njE0_qILy6epUr2_7ooA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 9ZhoNPBo8j4nPZrJfo9UmWeaQs9_b4q_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDA4NiBTYWx0ZWRfX7wk4keRdG076
 8LaAT4by55rgM5YyTnhrGb8hrsIBWWj73r/o2mfgdTpozYtvG7d3I4nPpKpmyX91oLvuWh3/wUz
 XgronbLAqi87rvjT7Rrd2c4KeleYYPK/iaU6DOqtYZGmyLI/wJmDLdgzDGCZZf6ekokdyUwGj0U
 lkP9zZZIxxfs4yxA2joe4YatJMtzmeBKrQcL4TG4QwcHEjUNCKWHU96kky9LByvnQ5Qi6aGhLd6
 /us2yH6WACe0fCr8U5BUTKqKioMyQrzkaBhz8BdspSfw13595GEDxOnF8elVcM6IT8MggA60YnZ
 WZaYGYyRrFzJrNdUqZVOMPTPRRBG4iWiNjzh13Osj2swnl8zrdaPOi6DFDJ0+wjMBewWDjExkhx
 NlQbjec9VOg8aGJEULLGEQgH15KWQtRdnoDG+yGSLzrAZ8ZyaCdU3SNWCbU5uKonyEqk5VmA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-02_01,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507020086

From: Krishna chaitanya chundru <quic_krichai@quicinc.com>

Add configurations in devicetree for PCIe0, including registers, clocks,
interrupts and phy setting sequence.

Add PCIe lane equalization preset properties for 8 GT/s.

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Signed-off-by: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
---
 arch/arm64/boot/dts/qcom/qcs615.dtsi | 138 +++++++++++++++++++++++++++
 1 file changed, 138 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs615.dtsi b/arch/arm64/boot/dts/qcom/qcs615.dtsi
index bfbb21035492..f4b51cca17de 100644
--- a/arch/arm64/boot/dts/qcom/qcs615.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs615.dtsi
@@ -1066,6 +1066,144 @@ mmss_noc: interconnect@1740000 {
 			qcom,bcm-voters = <&apps_bcm_voter>;
 		};
 
+		pcie: pcie@1c08000 {
+			device_type = "pci";
+			compatible = "qcom,pcie-qcs615", "qcom,pcie-sm8150";
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
+			interrupt-map = <0 0 0 1 &intc GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 2 &intc GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 3 &intc GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 4 &intc GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>;
+
+			clocks = <&gcc GCC_PCIE_0_PIPE_CLK>,
+				 <&gcc GCC_PCIE_0_AUX_CLK>,
+				 <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
+				 <&gcc GCC_PCIE_0_MSTR_AXI_CLK>,
+				 <&gcc GCC_PCIE_0_SLV_AXI_CLK>,
+				 <&gcc GCC_PCIE_0_SLV_Q2A_AXI_CLK>;
+			clock-names = "pipe",
+				      "aux",
+				      "cfg",
+				      "bus_master",
+				      "bus_slave",
+				      "slave_q2a";
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
+			max-link-speed = <2>;
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


