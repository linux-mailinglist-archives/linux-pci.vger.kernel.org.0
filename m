Return-Path: <linux-pci+bounces-32930-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB48B11B3E
	for <lists+linux-pci@lfdr.de>; Fri, 25 Jul 2025 11:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CD6D540F37
	for <lists+linux-pci@lfdr.de>; Fri, 25 Jul 2025 09:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1319B2D63F6;
	Fri, 25 Jul 2025 09:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JptcL0p9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED862D46C4;
	Fri, 25 Jul 2025 09:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753437216; cv=none; b=p9EeKPFtc/GwrVTL0scfExVxm1dCt8V5bXz4P6e/taqIKEZrk9a4oghb7GncMMDIA+IqHlgteahR+33ECJlUMrzReK+ia3VLxVZP3kGosKyHttE3VFS23TQVp+qd+txdFxRrxVYEslrmzY6IUHMrkazKcOfJ9mmrKO5dV6YR7Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753437216; c=relaxed/simple;
	bh=sQ7uzt9SXfJr5GeXHepdE4WwwB4TM8p65bnfn7hxErA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RbUV7RH1JldcfIm+Nuzn/Azs8bqzhhql/SbCHeVmvv9Sn8EkbfQi4fp1q4GYoyTvCvztLhoNY4OqqdmGfZQjOn0h4V0WW6lI3AF7KqeUe3TrOGbvTY+zOMh2PorOxV0OZaiAmEFZS/t6VUktl2KHya6GxpuJBeH49S6BNISsDXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JptcL0p9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56P8ZEQv015331;
	Fri, 25 Jul 2025 09:53:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YJ9QlUzgzZXAp2fSa1A+U0eHeKeBWWmFU68JYNEh+X8=; b=JptcL0p9KkuWy4Gv
	1bjiV/k8u/X7k0Q7HjGaTsYvsHh4qaax+PPWwqVZVjGAmJxOKTdeaOJfRc3ixneA
	5L38QZ2MIr8Q+5Jv1ZbEr+XEziJ9R/K3cML9KZNP+SRmqN2SvuaP6V0ZmY3NlLu2
	asjGts5zBRqNh11c23xIh88hkzOmEpsPvAmJbv7piDTM+mjCJVvibudKhNM7AYMO
	Cwas24zi333dtLDxCx/HZ+XOrWOpgn0vS9f7I59rmLEctKktz87vkO29zZpomOax
	ucfmYMuUJtveeMOfV5R5bkH1glg5bni9eiVtqIldCggs+p+zHW3n5u9b9eFcZs6v
	5WMH6A==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 483w2qhmyb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Jul 2025 09:53:21 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 56P9rJYt030905;
	Fri, 25 Jul 2025 09:53:19 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 4804emsuvt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Jul 2025 09:53:19 +0000
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 56P9rJwl030897;
	Fri, 25 Jul 2025 09:53:19 GMT
Received: from cse-cd01-lnx.ap.qualcomm.com (cse-cd01-lnx.qualcomm.com [10.64.75.209])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 56P9rIu7030894
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Jul 2025 09:53:19 +0000
Received: by cse-cd01-lnx.ap.qualcomm.com (Postfix, from userid 4438065)
	id 090B3210DE; Fri, 25 Jul 2025 17:53:18 +0800 (CST)
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
Subject: [PATCH v6 2/3] arm64: dts: qcom: sa8775p: remove aux clock from pcie phy
Date: Fri, 25 Jul 2025 17:53:01 +0800
Message-Id: <20250725095302.3408875-3-ziyue.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250725095302.3408875-1-ziyue.zhang@oss.qualcomm.com>
References: <20250725095302.3408875-1-ziyue.zhang@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=RbqQC0tv c=1 sm=1 tr=0 ts=68835411 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=EluF0xcg-2KMSqT-UJQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDA4NCBTYWx0ZWRfXxCw+gnq0iYet
 Gs4OSmsRdoWzyeOTE0oirtUVdwoPKvKygQIeFr/iX0l1Uww5ABbYpiiFHeDLi0YFCbvjWf00FX9
 T1rChNad340HS40wJzVM/PIZbSJaE3GbureesUcb0vRqIXs8Dt1OoKWFIc797+tko8tRTcr4dWa
 dvSosZKcsGOwFduIJgxqDuzOp6bwVIoJuR9066ZrhGkwokUj1+L/9icLDAvCmI0ep8nP9XpTv13
 sGXGR1TrO2oOsrrS2ipWhJ2xl7BRLCTzokbkRkgNnJQt7Ln+RreofRQZ+ZR76lAwrl+xW4sWpVc
 SaAc17S91sTzmUaM7S8tKCuEUOOZcBRb/frd6fkZ1ZAsVSWBQ+S+Y9H4Wdk1atRIUEYz/y5h7Tu
 QPlDQ+V8VF8KzLkn8pUXy1BruLSDfbVUIQmaB+/Raird+3cimZC9FCDvlYJ5EwMichgutGpO
X-Proofpoint-GUID: -8JBj7VUZaZQrzYXFYKttEr1qrIkx3iP
X-Proofpoint-ORIG-GUID: -8JBj7VUZaZQrzYXFYKttEr1qrIkx3iP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_02,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 spamscore=0 mlxlogscore=999
 priorityscore=1501 malwarescore=0 impostorscore=0 mlxscore=0 adultscore=0
 phishscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507250084

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


