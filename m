Return-Path: <linux-pci+bounces-6895-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F02F8B7C5C
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 17:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2D121F23EE5
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 15:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485EA179949;
	Tue, 30 Apr 2024 15:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DWHvUhRk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E96176FC0;
	Tue, 30 Apr 2024 15:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714492568; cv=none; b=PDKKajD1swKzwZY0RKBQnA9fCDT44A+p0BxYC/exq1Dup/ckcRUKZrJcGgC4e9kiB6E27auhrfWHSWxd301iPLTwhyBQ/VZ9EupIRVG2bPFCUGvHNFXDaWvs5+ZEziP8WBTfAfxDFx3b0VXU6C7oJ9zm0ZmgM1TI5AfPH2P0MVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714492568; c=relaxed/simple;
	bh=mZpt3dZM4BBIz/t1NRUqOGaGIzIhJTHB7CsKY0Va4pA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=jlA4N9Zx1/5HiCQMm5SoHeTz7x4h8Yv7l/wCZxmH6l2twE/SXvMTwb99Uz5HjBwNsz6BX5ce1uKXWg/DKWBrxpY59sh+RHXM75w4+QtXqvLFTkOrUNOJxtBmwZq9S+g6J7mPzq6t448pNLGAyGbquoGkxk2hV+8TNdarV5LK5NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=DWHvUhRk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43UFRTRg026998;
	Tue, 30 Apr 2024 15:55:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references; s=
	qcppdkim1; bh=YN8vQUMxmhQlcWxNxVZPsR0KZOt+VasnGzuMhnLqvXI=; b=DW
	HvUhRkNRAp0yKX+fb69za5PL1KGx6lGFg4OEXoE/Ikq9vI+g3tUE9SrPW38yr30X
	7j7I/0OaG/YRMI0Ulfrdo+CDnkdanEyP1kB7yjzMAsJMqwIioUSmiHI7evaGU3bx
	OO177h5i2zQTJksUiAIAu17wFmO/E1yNrMfog1JG+OZaYIlcmN2kteIssvc88Ldj
	3zxH+xxTRsrLdpeaZ9yvcrUuYOc5cPJjx3Zz6hIhSzcPNq428x+/UlnepxuEj5X5
	MwTxkUhQLpGf5igVVDpdLqz/Wo1gHw31YPjESjkzmStGE3MFRSDP/BpC24VLm8sT
	fN3rDEz2pRBJU5YnaIqQ==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xtm3ujurw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 15:55:58 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 43UFtt0g032565;
	Tue, 30 Apr 2024 15:55:55 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3xrtem1a82-1;
	Tue, 30 Apr 2024 15:55:55 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43UFqTUJ029625;
	Tue, 30 Apr 2024 15:55:55 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-msarkar-hyd.qualcomm.com [10.213.111.194])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 43UFtsU7032557;
	Tue, 30 Apr 2024 15:55:55 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3891782)
	id 33BDA3BD6; Tue, 30 Apr 2024 21:25:54 +0530 (+0530)
From: Mrinmay Sarkar <quic_msarkar@quicinc.com>
To: andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, konrad.dybcio@linaro.org,
        manivannan.sadhasivam@linaro.org
Cc: quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com,
        quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com,
        quic_krichai@quicinc.com, quic_vbadigan@quicinc.com,
        quic_schintav@quicinc.com, Mrinmay Sarkar <quic_msarkar@quicinc.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v11 3/3] arm64: dts: qcom: sa8775p: Add ep pcie0 controller node
Date: Tue, 30 Apr 2024 21:25:39 +0530
Message-Id: <1714492540-15419-4-git-send-email-quic_msarkar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1714492540-15419-1-git-send-email-quic_msarkar@quicinc.com>
References: <1714492540-15419-1-git-send-email-quic_msarkar@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: mbGaF1h_8HkLzpSC7S_PzVpF1WHucuCv
X-Proofpoint-GUID: mbGaF1h_8HkLzpSC7S_PzVpF1WHucuCv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-30_08,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0
 priorityscore=1501 mlxlogscore=999 adultscore=0 mlxscore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404300111
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Add ep pcie dtsi node for pcie0 controller found on sa8775p platform.
It supports gen4 and x2 link width. Limiting the speed to Gen3 due to
stability issues.

Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sa8775p.dtsi | 46 +++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
index 31de7359..4084e77 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
@@ -3689,6 +3689,52 @@
 		};
 	};
 
+	pcie0_ep: pcie-ep@1c00000 {
+		compatible = "qcom,sa8775p-pcie-ep";
+		reg = <0x0 0x01c00000 0x0 0x3000>,
+		      <0x0 0x40000000 0x0 0xf20>,
+		      <0x0 0x40000f20 0x0 0xa8>,
+		      <0x0 0x40001000 0x0 0x4000>,
+		      <0x0 0x40200000 0x0 0x100000>,
+		      <0x0 0x01c03000 0x0 0x1000>,
+		      <0x0 0x40005000 0x0 0x2000>;
+		reg-names = "parf", "dbi", "elbi", "atu", "addr_space",
+			    "mmio", "dma";
+
+		clocks = <&gcc GCC_PCIE_0_AUX_CLK>,
+			<&gcc GCC_PCIE_0_CFG_AHB_CLK>,
+			<&gcc GCC_PCIE_0_MSTR_AXI_CLK>,
+			<&gcc GCC_PCIE_0_SLV_AXI_CLK>,
+			<&gcc GCC_PCIE_0_SLV_Q2A_AXI_CLK>;
+
+		clock-names = "aux",
+			      "cfg",
+			      "bus_master",
+			      "bus_slave",
+			      "slave_q2a";
+
+		interrupts = <GIC_SPI 306 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 630 IRQ_TYPE_LEVEL_HIGH>;
+
+		interrupt-names = "global", "doorbell", "dma";
+
+		interconnects = <&pcie_anoc MASTER_PCIE_0 0 &mc_virt SLAVE_EBI1 0>,
+				<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_PCIE_0 0>;
+		interconnect-names = "pcie-mem", "cpu-pcie";
+
+		iommus = <&pcie_smmu 0x0000 0x7f>;
+		resets = <&gcc GCC_PCIE_0_BCR>;
+		reset-names = "core";
+		power-domains = <&gcc PCIE_0_GDSC>;
+		phys = <&pcie0_phy>;
+		phy-names = "pciephy";
+		max-link-speed = <3>; /* FIXME: Limiting the Gen speed due to stability issues */
+		num-lanes = <2>;
+
+		status = "disabled";
+	};
+
 	pcie0_phy: phy@1c04000 {
 		compatible = "qcom,sa8775p-qmp-gen4x2-pcie-phy";
 		reg = <0x0 0x1c04000 0x0 0x2000>;
-- 
2.7.4


