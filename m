Return-Path: <linux-pci+bounces-44353-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0944AD08B29
	for <lists+linux-pci@lfdr.de>; Fri, 09 Jan 2026 11:49:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B03A30B50E3
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jan 2026 10:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC49633A9CB;
	Fri,  9 Jan 2026 10:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YdaC+KZX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE8A3382D4;
	Fri,  9 Jan 2026 10:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767955535; cv=none; b=pZ4Zl/zd3Nm3uEkqDohZqKzt4uQhLiWDZdQGvxDx6I7sRWNWkD7iDLoaN1v0YwGhY3dPvq5gd9jjq9vOO+NhofrTVtLyF9x/LXMIKGuEKJvQiKrFwK68JfyfypmwpV7gCbsEq23JexZ3LevzbvR8XhRb/tvXSlhLopXkPDK5J3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767955535; c=relaxed/simple;
	bh=9PFo81dzNXmJnq2Y+YmD7k+VFOW2LuKu7KqFq7DN9WA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IVGBLa9Qz6fxmSPOe38NHhw7r94087ttvLfxJ7LibA56MBOqDE/hSylbN7CQPPuuuDk27rBCQeoND2ivEvpj7b9rVCZZ2zaGeCrKpnmHsl+Wfp3H77zcpqWKTUmcS797ZNttq/t/zunqCGJ1G648zqteuvKFbdg0agG1h+P8lCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YdaC+KZX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6098JUIT3219827;
	Fri, 9 Jan 2026 10:45:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=hgzvY5/ak9H
	0SsOfm+TlCiiwuICAtq/YrINziKYr6wM=; b=YdaC+KZXDdki3R/qly9Bh8Y+163
	UYRVeGfTqyX4OdtqQLncxvjCpG2+2f4ixoyAP6/qXPSOnbq08pg2a+J4in5BlTYC
	Emnu9zPtYLBKxIiioQrYrAG5sq4GY0zFpDBvTb/S5RZMzdb9P4mF6CcTdsUWsU1F
	LLeBGxgJy/qxsjdiLwjmcgYf7TSLgYu9aY2WLlU4nVgYK7UGv6D+YpkWDXUhrKew
	+J+OV3bivanKOG+t5gF5Mw7ZAdfKjtJE4l3FET+7viRN0r7LGqaOMUf09wVFRmA/
	8KaeukdyRGZo+J8kma3zKRpP37ICRwnqeKicXaCd48wjInyrArlgUhYkFLA==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bjjt0j6x7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Jan 2026 10:45:19 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 609AjHeC007216;
	Fri, 9 Jan 2026 10:45:17 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 4bev6mpxxu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Jan 2026 10:45:17 +0000
Received: from APTAIPPMTA02.qualcomm.com (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 609AjGLd007201;
	Fri, 9 Jan 2026 10:45:16 GMT
Received: from cse-cd02-lnx.ap.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 609AjGCL007196
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Jan 2026 10:45:16 +0000
Received: by cse-cd02-lnx.ap.qualcomm.com (Postfix, from userid 4438065)
	id 096B67AA; Fri,  9 Jan 2026 18:45:15 +0800 (CST)
From: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
To: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, ziyue.zhang@oss.qualcomm.com,
        jingoohan1@gmail.com, mani@kernel.org, lpieralisi@kernel.org,
        kwilczynski@kernel.org, bhelgaas@google.com, johan+linaro@kernel.org,
        vkoul@kernel.org, kishon@kernel.org, neil.armstrong@linaro.org,
        abel.vesa@linaro.org, kw@linux.com
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org, qiang.yu@oss.qualcomm.com,
        quic_krichai@quicinc.com, quic_vbadigan@quicinc.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH v4 2/3] arm64: dts: qcom: Add PCIe3 and PCIe5 support for HAMOA-IOT-SOM platform
Date: Fri,  9 Jan 2026 18:45:03 +0800
Message-Id: <20260109104504.3147745-3-ziyue.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260109104504.3147745-1-ziyue.zhang@oss.qualcomm.com>
References: <20260109104504.3147745-1-ziyue.zhang@oss.qualcomm.com>
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
X-Proofpoint-GUID: PMmYzIKmeY9hDt3afjYeaQmFqYZH2eoR
X-Authority-Analysis: v=2.4 cv=VJzQXtPX c=1 sm=1 tr=0 ts=6960dc40 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=fLguakaJfclCSsbpy6UA:9
X-Proofpoint-ORIG-GUID: PMmYzIKmeY9hDt3afjYeaQmFqYZH2eoR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDA3OCBTYWx0ZWRfXzu83W84ber4Q
 oH0cmNptffaDWXj337svqhlgHJgmaKuD8le7KL2tULvsvJme1EBeId/pVCRCGakPp5slS7yCAWF
 Qxiwyr8St9Ikv+Au6bEItWMH+iBHBJw8WQc4Kbesu3uQlYZeXGaRlGZufvE+B2KiYZ5PIJF7VzG
 sVLGfogr5VQGHokfqvJnqvKj4Fd7Jf5i7lfaAsf/GowtDu1duJXPyTDV4ymShEIeuZua7FvTS35
 GrzTVB5qFKWbeoaTbD/Whe/iGSjgi1n+K4cfONJ8Z/KbbnbA7yi3UP3WyrB+VU5kjyqapeqnJdP
 PaK2D6NnxoVU1Bp+a7bHW8Yi1Gn0JSKWBIaaBlpP9LL5p5JrAZ95Tz6OfEZ8jHXSfL38vlgVnXL
 fpPreSyqnvWLtpKZaPOKWrP8w2Le8HhYvfi24gd5XW/7sbw32qLHX0l+I68HanxHJT9Ry6H/c7P
 whU7ePGpwO1UEri8Aqg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_03,2026-01-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 bulkscore=0 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601090078

HAMOA IoT SOM requires PCIe3 and PCIe5 connectivity for SATA controller
and SDX65.

Add the required sideband signals (PERST#, WAKE#, CLKREQ#), pinctrl states
and power supply properties in the device tree, which PCIe3 and PCIe5
require.

Signed-off-by: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
Reviewed-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/hamoa-iot-som.dtsi | 74 +++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/hamoa-iot-som.dtsi b/arch/arm64/boot/dts/qcom/hamoa-iot-som.dtsi
index 4a69852e9176..81866f94fe01 100644
--- a/arch/arm64/boot/dts/qcom/hamoa-iot-som.dtsi
+++ b/arch/arm64/boot/dts/qcom/hamoa-iot-som.dtsi
@@ -390,6 +390,20 @@ &gpu_zap_shader {
 	firmware-name = "qcom/x1e80100/gen70500_zap.mbn";
 };
 
+&pcie3 {
+	pinctrl-0 = <&pcie3_default>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+
+&pcie3_phy {
+	vdda-phy-supply = <&vreg_l3c_0p8>;
+	vdda-pll-supply = <&vreg_l3e_1p2>;
+
+	status = "okay";
+};
+
 &pcie4 {
 	perst-gpios = <&tlmm 146 GPIO_ACTIVE_LOW>;
 	wake-gpios = <&tlmm 148 GPIO_ACTIVE_LOW>;
@@ -407,6 +421,20 @@ &pcie4_phy {
 	status = "okay";
 };
 
+&pcie5 {
+	pinctrl-0 = <&pcie5_default>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+
+&pcie5_phy {
+	vdda-phy-supply = <&vreg_l3i_0p8>;
+	vdda-pll-supply = <&vreg_l3e_1p2>;
+
+	status = "okay";
+};
+
 &pcie6a {
 	perst-gpios = <&tlmm 152 GPIO_ACTIVE_LOW>;
 	wake-gpios = <&tlmm 154 GPIO_ACTIVE_LOW>;
@@ -453,6 +481,29 @@ &remoteproc_cdsp {
 &tlmm {
 	gpio-reserved-ranges = <34 2>; /* TPM LP & INT */
 
+	pcie3_default: pcie3-default-state {
+		clkreq-n-pins {
+			pins = "gpio144";
+			function = "pcie3_clk";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+
+		perst-n-pins {
+			pins = "gpio143";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-disable;
+		};
+
+		wake-n-pins {
+			pins = "gpio145";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+	};
+
 	pcie4_default: pcie4-default-state {
 		clkreq-n-pins {
 			pins = "gpio147";
@@ -476,6 +527,29 @@ wake-n-pins {
 		};
 	};
 
+	pcie5_default: pcie5-default-state {
+		clkreq-n-pins {
+			pins = "gpio150";
+			function = "pcie5_clk";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+
+		perst-n-pins {
+			pins = "gpio149";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-disable;
+		};
+
+		wake-n-pins {
+			pins = "gpio151";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+	};
+
 	pcie6a_default: pcie6a-default-state {
 		clkreq-n-pins {
 			pins = "gpio153";
-- 
2.34.1


