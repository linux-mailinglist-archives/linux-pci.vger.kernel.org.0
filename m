Return-Path: <linux-pci+bounces-32935-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC95AB11C4A
	for <lists+linux-pci@lfdr.de>; Fri, 25 Jul 2025 12:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F6441CE224F
	for <lists+linux-pci@lfdr.de>; Fri, 25 Jul 2025 10:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66FDF2D94BD;
	Fri, 25 Jul 2025 10:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ImghXpC5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53041A4F3C;
	Fri, 25 Jul 2025 10:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753439270; cv=none; b=LEK9uKbR/pdkmHTNk62jIg1MxvaftD6SnZE66nIxLN3SMkCHE+dggbkCs63g/nAA1gqG0rqVIJrXBSzCZ9bSrfmlHmq/l1lKbIIZgIV+ZZ4LyJ4AVICVRutcMU6UBfGcmXt84cuWWcXD+hrKJvBTvmCfaqVL+5zSZENnaIlFhXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753439270; c=relaxed/simple;
	bh=sQ7uzt9SXfJr5GeXHepdE4WwwB4TM8p65bnfn7hxErA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bHWwV2P/aCFNvpIrlUAVgA1b9uo/3GMNk7N2zD8H8EDkuOr/+mxsRaBbyriwY8/CkJBVj0gCgMgM56nl5BtyNFjDZ7JsbFbnrXm9ETK0AiH1sFIPYYlx0gtDEGUPr3uaUPfU5RpbviY1MueiL0LImmmuxj9FFU2F+uWtlXjsnwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ImghXpC5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56P9VTqr001346;
	Fri, 25 Jul 2025 10:27:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YJ9QlUzgzZXAp2fSa1A+U0eHeKeBWWmFU68JYNEh+X8=; b=ImghXpC58h+f2lFo
	BlP0LC4LTvteD28081z9SKJ2/9ehE1+VoYUxvaIOampQAstuLnOQIat3vlDX4LnN
	3BXadIBKQ2aF7UB6+MX72kvS5Zscnp49kqCHjJiVtzrMxEmeYU6x9HjQuGII745z
	MCDP7AxWHHvu9pp1Wt1PWKa5QiogAod/QwKDiV4lpvm0QfgGLYqxFWbC9pULEE1I
	EBwst+wk4UP1JBxfpbuNpYZeqbhUANUBQIzv1EaIJXt4SZt5wz9y2uxW6neo3Bn3
	SpgV25YWfuZOvHMoomBhDgTAYhHcSdzbSfnA7XDNxYgprqTTX3ySRYg2Klbuvcgx
	GxPiEg==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 483w2xhp5n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Jul 2025 10:27:37 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 56PAMYfP027664;
	Fri, 25 Jul 2025 10:22:34 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 4804emsyty-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Jul 2025 10:22:34 +0000
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 56PAHwm6023681;
	Fri, 25 Jul 2025 10:22:34 GMT
Received: from cse-cd01-lnx.ap.qualcomm.com (cse-cd01-lnx.qualcomm.com [10.64.75.209])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 56PAMXvV027645
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Jul 2025 10:22:34 +0000
Received: by cse-cd01-lnx.ap.qualcomm.com (Postfix, from userid 4438065)
	id E2458211E6; Fri, 25 Jul 2025 18:22:32 +0800 (CST)
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
        Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
Subject: [PATCH v7 2/3] arm64: dts: qcom: sa8775p: remove aux clock from pcie phy
Date: Fri, 25 Jul 2025 18:22:30 +0800
Message-Id: <20250725102231.3608298-3-ziyue.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250725102231.3608298-1-ziyue.zhang@oss.qualcomm.com>
References: <20250725102231.3608298-1-ziyue.zhang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: skjv_WB98foTsT_rtvwRi_8ej5HyGAw_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDA4OCBTYWx0ZWRfXzX2BxlzP87MZ
 9BUgmXaRk4zgTU++lG6wn6BqZ4Ic42fOUyfJrJxGjqngICt4Uh3lcI0tbRei2l3zfGRdWIoZYJX
 ZpHgsTm6d7Z0/3irzOHaSiDbz7XJ4nbWpdNFx13KVoeqqiRPBIT8AcTbrMEflkttBHZMB7vnN8x
 Ipua174wLJT0NXtM0NWBB4ehVZT3Nhq9pNm8ZOBPiXSgLok4VvTndAz7vPzCpDEXDE5w2MQtHu2
 Nyf5JzeFQxJzTItGKtRI4pVbksYPPu/hTnkhwZyu3ikfWpIxrI7zBFqUY0ILoJb2G4SgnDPzRZP
 /b8MlA1rvb7r2BLhqshiHpDaNHHn6sxMSVcFOx8ByzaALxBq/FNWtjeaoqmkOuze8QM2PiRzGbs
 Qa+zG4hJ0jmdQfvqfzbTVTEsBAN6Lnrz8ebXjacOgI59BCMnwa6wk962YQYqMwNjVTXOpJGy
X-Proofpoint-GUID: skjv_WB98foTsT_rtvwRi_8ej5HyGAw_
X-Authority-Analysis: v=2.4 cv=S8bZwJsP c=1 sm=1 tr=0 ts=68835c19 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=EluF0xcg-2KMSqT-UJQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_03,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 mlxlogscore=999 bulkscore=0 impostorscore=0
 spamscore=0 malwarescore=0 adultscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507250088

The gcc_aux_clk is used by the PCIe Root Complex (RC) and is not required
by the PHY. The correct clock for the PHY is gcc_phy_aux_clk, which this
patch uses to replace the incorrect reference.

The distinction between AUX_CLK and PHY_AUX_CLK is important: AUX_CLK is
typically used by the controller, while PHY_AUX_CLK is required by certain
PHYs—particularly Gen4 QMP PHYs—for internal operations such as clock
gating and power management. Some non-Gen4 Qualcomm PHYs also use
PHY_AUX_CLK, but they do not require AUX_CLK.

This change ensures proper clock configuration and avoids unnecessary
dependencies.

Signed-off-by: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sa8775p.dtsi | 28 +++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
index 9997a29901f5..39a4f59d8925 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
@@ -7707,16 +7707,18 @@ pcie0_phy: phy@1c04000 {
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
@@ -7873,16 +7875,18 @@ pcie1_phy: phy@1c14000 {
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


