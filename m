Return-Path: <linux-pci+bounces-29906-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C02AADBEFC
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jun 2025 04:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E519F7A2AE1
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jun 2025 02:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8768F211A31;
	Tue, 17 Jun 2025 02:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Lpqr3VgG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05892AF1D;
	Tue, 17 Jun 2025 02:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750126608; cv=none; b=U0bPr7eFmo0XN00SrHdKZv5RsjAKXf3Safrv/VstyrdrgrqS+DzyQlbSTzFLyn+mGW0nE6KuKSdaCzwDwIBD6u8AZrjqRGvutGoPaxobKKIhhA5eZzDA7nJQxoh+ZgbKcekmioVIrYT5lhk5qyQXKRIW11ge60bKJMMa4+SQpDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750126608; c=relaxed/simple;
	bh=MohB8b0jetfLvQWZjPuvt1ApwDTNubif7c8An1OBEXM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jmDpIB1vbIdVq1ooDxsbHpPQ4FNcqEU969zSUqIRWU3mSxSYs8BZ+L+EJYRe4Fs9PL7hHmPoud5h6yEVCgVwB6O+KZ6Nd266PW5CDLT+McEPKUC4zwAINnnRBcnvZw7e3U0BffBjEmRhStxCGIkWoe41zX4tiOshL0xvpKGnOic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Lpqr3VgG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55GGsfKM003266;
	Tue, 17 Jun 2025 02:16:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=/1vS8/JqNxG
	VLp00mgEn6g+HuGaGexP6qrS1Tms27X0=; b=Lpqr3VgG9WHkrC+jYNcMaeES6aY
	qcevs4PiKL6sgwa3Vjf4YyDPXneJTMiqXwh0OwAUka+1PFCGrxwjWJU2uiyKkSD2
	L8iy8qZzX+6oOtBZOMV44q7cxNtdSDqG5O//N1J0oiCEDg0gt8Zff11F6mDL+vT5
	QzJ3F68p6VPp2BK41qO8fUCBq2nTjf0NHhBFFPun6JHhBoy9oA2gOYINeAfigC7S
	lu1qb1dBH4jh59ylk8K84uBUm6DRTaVkavb/zlnJc5uT+YZHo4L1PJ2RNuWGWDes
	9T30kVSqfPqnF5S2W7wF0XQzyWQbT6I574u9ujr8oL47ja/mk4lfG/iNwcw==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 479qp5n2y1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Jun 2025 02:16:31 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 55H2GT9Q014431;
	Tue, 17 Jun 2025 02:16:29 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 479jt4gb0p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Jun 2025 02:16:29 +0000
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55H2GSh2014405;
	Tue, 17 Jun 2025 02:16:29 GMT
Received: from cse-cd02-lnx.ap.qualcomm.com (cse-cd02-lnx.qualcomm.com [10.64.75.246])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 55H2GS0k014400
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Jun 2025 02:16:29 +0000
Received: by cse-cd02-lnx.ap.qualcomm.com (Postfix, from userid 4438065)
	id D2D913659; Tue, 17 Jun 2025 10:16:26 +0800 (CST)
From: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
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
        Ziyue Zhang <quic_ziyuzhan@quicinc.com>
Subject: [PATCH v2 3/4] arm64: dts: qcom: sa8775p: remove aux clock from pcie phy
Date: Tue, 17 Jun 2025 10:16:16 +0800
Message-Id: <20250617021617.2793902-4-quic_ziyuzhan@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250617021617.2793902-1-quic_ziyuzhan@quicinc.com>
References: <20250617021617.2793902-1-quic_ziyuzhan@quicinc.com>
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
X-Proofpoint-GUID: epbQ4azd4ekgf-_c-Dn9gB5zmU_rkyHg
X-Proofpoint-ORIG-GUID: epbQ4azd4ekgf-_c-Dn9gB5zmU_rkyHg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE3MDAxOSBTYWx0ZWRfX8By/HVTnSWgf
 oJDgKLbBltRFfiqTclsirebKo5x8OmDOHxLzrNPHtkcIU4P7XiZRoyVlbI/z0uLbyxASmASucT6
 o5DWZGajdOKwxxuSAinOgJngv0RRgfnUxG7Gadrgj89JdboUPl3IWrYQQ/5J4X7gZe8Wo6lmGjj
 HeUM4PTxl4soP68wtcYjvmCUz4MOmltL0H0TjApu6ISf8HYrWqXmpOitROsBLviYo7q3NhJxDNY
 eIITWD1o1qtJZQEsH47XVJLp1zwBfLxu9B1LLlfYOY1dYsz6t/ilBxVsabTX/v8CvwGL5vzFxM9
 cx+490L1v+MU/eWkz7JX6E4eJnz1hpfjkrF6gGs8hTudgyZbyFViYaCrzHyRyy6im8ljxrWOAxA
 1mXpm6iI1QRg5j1B8cb4G8AiIfnEt+MDwrB95+lJWVWSRstnharm/r22sASuxxMG7e4+Djv0
X-Authority-Analysis: v=2.4 cv=fMc53Yae c=1 sm=1 tr=0 ts=6850cfff cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=6IFa9wvqVegA:10 a=COk6AnOGAAAA:8 a=9zbhvFfKP0O2o0OFYOYA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-17_01,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 mlxlogscore=999 spamscore=0 lowpriorityscore=0 impostorscore=0 mlxscore=0
 priorityscore=1501 suspectscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506170019

gcc_aux_clk is used in PCIe RC and it is not required in pcie phy, in
pcie phy it should be gcc_phy_aux_clk, so remove gcc_aux_clk and
replace it with gcc_phy_aux_clk.

Signed-off-by: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sa8775p.dtsi | 28 +++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
index 45f536633f64..d7248014368b 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
@@ -7224,16 +7224,18 @@ pcie0_phy: phy@1c04000 {
 		compatible = "qcom,sa8775p-qmp-gen4x2-pcie-phy";
 		reg = <0x0 0x1c04000 0x0 0x2000>;
 
-		clocks = <&gcc GCC_PCIE_0_AUX_CLK>,
+		clocks = <&gcc GCC_PCIE_0_PHY_AUX_CLK>,
 			 <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
 			 <&gcc GCC_PCIE_CLKREF_EN>,
 			 <&gcc GCC_PCIE_0_PHY_RCHNG_CLK>,
 			 <&gcc GCC_PCIE_0_PIPE_CLK>,
-			 <&gcc GCC_PCIE_0_PIPEDIV2_CLK>,
-			 <&gcc GCC_PCIE_0_PHY_AUX_CLK>;
-
-		clock-names = "aux", "cfg_ahb", "ref", "rchng", "pipe",
-			      "pipediv2", "phy_aux";
+			 <&gcc GCC_PCIE_0_PIPEDIV2_CLK>;
+		clock-names = "aux",
+			      "cfg_ahb",
+			      "ref",
+			      "rchng",
+			      "pipe",
+			      "pipediv2";
 
 		assigned-clocks = <&gcc GCC_PCIE_0_PHY_RCHNG_CLK>;
 		assigned-clock-rates = <100000000>;
@@ -7382,16 +7384,18 @@ pcie1_phy: phy@1c14000 {
 		compatible = "qcom,sa8775p-qmp-gen4x4-pcie-phy";
 		reg = <0x0 0x1c14000 0x0 0x4000>;
 
-		clocks = <&gcc GCC_PCIE_1_AUX_CLK>,
+		clocks = <&gcc GCC_PCIE_1_PHY_AUX_CLK>,
 			 <&gcc GCC_PCIE_1_CFG_AHB_CLK>,
 			 <&gcc GCC_PCIE_CLKREF_EN>,
 			 <&gcc GCC_PCIE_1_PHY_RCHNG_CLK>,
 			 <&gcc GCC_PCIE_1_PIPE_CLK>,
-			 <&gcc GCC_PCIE_1_PIPEDIV2_CLK>,
-			 <&gcc GCC_PCIE_1_PHY_AUX_CLK>;
-
-		clock-names = "aux", "cfg_ahb", "ref", "rchng", "pipe",
-			      "pipediv2", "phy_aux";
+			 <&gcc GCC_PCIE_1_PIPEDIV2_CLK>;
+		clock-names = "aux",
+			      "cfg_ahb",
+			      "ref",
+			      "rchng",
+			      "pipe",
+			      "pipediv2";
 
 		assigned-clocks = <&gcc GCC_PCIE_1_PHY_RCHNG_CLK>;
 		assigned-clock-rates = <100000000>;
-- 
2.34.1


