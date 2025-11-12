Return-Path: <linux-pci+bounces-40972-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95121C5149E
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 10:11:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CAEE3B8DB3
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 09:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C70F2FE591;
	Wed, 12 Nov 2025 09:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mpGYL0EE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916102FDC39;
	Wed, 12 Nov 2025 09:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762938217; cv=none; b=ZAVA9VQCpRRfGWYeiARBkxnuF0cjY+KrsIymYWZs9v/ur//VXJ+CzhfMU+3C+RVdA2T7KbUrnTSl4vO4IJyWP2Ooys4m1VNI5NcDsI4OjKNgfYLzQUJpB+ikF049Hde59msZ6YyQhJ6mWzri88R0KUO6EQOmg5d2fDImqSSILaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762938217; c=relaxed/simple;
	bh=txFpmIdhDx/Q/DSrOD/q29y2aMbwAGswhKDCJZW9o0o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=erB9ghDe80CFoYcLwyN0ngxoBtRhb561JENfS9ZgqW+YYwBBrcfGCE4Q3zzMsZjWIWBA+NPz8GsTdFGMfyKC5tlMT3NvWEW34LLUYG57nNkll2hbuE5lDyIieOn6Ax0kW52lLAMcgsxUUH2nWm8k238w1zxiyPuV8oFeZkVgNRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mpGYL0EE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AC1iCbH4076902;
	Wed, 12 Nov 2025 09:03:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=IUFT0z23+i3
	ue8LqgRdaBNM5idwojLC1bky4XOv4j8I=; b=mpGYL0EEEnpCiLoxAGWJ2IaK6bJ
	5+v1vVn+ToMpSgJITtB+x5r4Z4poML270IK/8y4zUIMSsjiD0UKnyN5rQZdnpSNv
	ydhg/4TOBTwUgXuPS0+mcXWjaTFI1jRthMcAR1gKxyhoYxgGTtoBfJYhyeCaLU0y
	gxmroYTTqaCsxluuQBoBNJ0MgsNomKKpI1fyVdNaClCV/58vLv7/leCdUvXz959Z
	1OICr555vAKRIptXiTp5mQDBKYSxRCqbsyFWNroEv3tfgR2Cnb4qTpDVnEr4KQjh
	ybDXJVuXyZWBh4X5sjzNtE/cU/lnRcs9I1SxmRT364UhceC/45Lgc6yfi9w==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4acguah4c0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 09:03:24 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AC93L5h010909;
	Wed, 12 Nov 2025 09:03:21 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 4a9xxmeqsb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 09:03:21 +0000
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5AC93LP4010903;
	Wed, 12 Nov 2025 09:03:21 GMT
Received: from cse-cd02-lnx.ap.qualcomm.com (cse-cd02-lnx.qualcomm.com [10.64.75.246])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 5AC93KMg010902
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 09:03:21 +0000
Received: by cse-cd02-lnx.ap.qualcomm.com (Postfix, from userid 4438065)
	id 7A309792; Wed, 12 Nov 2025 17:03:19 +0800 (CST)
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
        krishna.chundru@oss.qualcomm.com, quic_vbadigan@quicinc.com,
        Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
Subject: [PATCH v3 2/2] arm64: dts: qcom: Add PCIe3 and PCIe5 regulators for HAMAO-IOT-EVK board
Date: Wed, 12 Nov 2025 17:03:16 +0800
Message-Id: <20251112090316.936187-3-ziyue.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251112090316.936187-1-ziyue.zhang@oss.qualcomm.com>
References: <20251112090316.936187-1-ziyue.zhang@oss.qualcomm.com>
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
X-Proofpoint-GUID: N_y0qKtyRZlquWxBoVDhzcLz1ltm4V-j
X-Authority-Analysis: v=2.4 cv=ao2/yCZV c=1 sm=1 tr=0 ts=69144d5d cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=qQkGquXN9PvF_GGjQ98A:9 a=nl4s5V0KI7Kw-pW0DWrs:22 a=pHzHmUro8NiASowvMSCR:22
 a=xoEH_sTeL_Rfw54TyV31:22
X-Proofpoint-ORIG-GUID: N_y0qKtyRZlquWxBoVDhzcLz1ltm4V-j
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDA3MCBTYWx0ZWRfXzBaDO2yB6HtN
 +OMe3qhDT8IL8CaeJRQBY/GSLqJQZRMJsDhXDTsdNkmj5hBzG5hATKIcicGkDkxvP89Whc1d0OA
 Uemk7IM0dVcnMfxMIq8WJ9RBz+EGSL1jALlkUIiBx6jMeLvloTaUo9fIGqogrDR9ZFooWbaTX3C
 R0jAG60J/9yfoiRrnlvJ7aqHm1Ojv6eBuWXo44uZxmTjoCSWdS7gpDeSd0UqTAR6ogymX9WrTXP
 8cWRir1Eb2O/qpbGCfKdGWW9flF/01ygLXvPfhbZQO7ZlIavrp8/dMPlrgN2VrfpxNzWBQTQnyv
 MdM+o38/xGi7Vbw1a45rQw5zlL61ykXPZl0PbrbGnQcKIvQmigXDyL8S94zN8igtMmOErPeO3qT
 T8fc2EL1B/dU3YULqV2SLSDHCVhMiQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_03,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 phishscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511120070

HAMAO IoT EVK uses PCIe5 to connect an SDX65 module for WWAN functionality
and PCIe3 to connect a SATA controller. These interfaces require multiple
voltage rails: PCIe5 needs 3.3V supplied by vreg_wwan, while PCIe3 requires
12V, 3.3V, and 3.3V AUX rails, controlled via PMIC GPIOs.

Add the required fixed regulators with related pin configuration, and
connect them to the PCIe3 and PCIe5 ports to ensure proper power for the
SDX65 module and SATA controller.

Signed-off-by: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
Reviewed-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts | 83 ++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts b/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
index 36dd6599402b..ac17f7cb8b3d 100644
--- a/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
+++ b/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
@@ -199,6 +199,48 @@ vreg_nvme: regulator-nvme {
 		regulator-boot-on;
 	};
 
+	vreg_pcie_12v: regulator-pcie-12v {
+		compatible = "regulator-fixed";
+
+		regulator-name = "VREG_PCIE_12V";
+		regulator-min-microvolt = <12000000>;
+		regulator-max-microvolt = <12000000>;
+
+		gpio = <&pm8550ve_8_gpios 8 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+
+		pinctrl-0 = <&pcie_x8_12v>;
+		pinctrl-names = "default";
+	};
+
+	vreg_pcie_3v3: regulator-pcie-3v3 {
+		compatible = "regulator-fixed";
+
+		regulator-name = "VREG_PCIE_3P3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+
+		gpio = <&pmc8380_3_gpios 6 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+
+		pinctrl-0 = <&pm_sde7_main_3p3_en>;
+		pinctrl-names = "default";
+	};
+
+	vreg_pcie_3v3_aux: regulator-pcie-3v3-aux {
+		compatible = "regulator-fixed";
+
+		regulator-name = "VREG_PCIE_3P3_AUX";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+
+		gpio = <&pmc8380_3_gpios 8 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+
+		pinctrl-0 = <&pm_sde7_aux_3p3_en>;
+		pinctrl-names = "default";
+	};
+
 	/* Left unused as the retimer is not used on this board. */
 	vreg_rtmr0_1p15: regulator-rtmr0-1p15 {
 		compatible = "regulator-fixed";
@@ -844,6 +886,16 @@ &mdss_dp3_phy {
 	status = "okay";
 };
 
+&pcie3_port {
+	vpcie12v-supply = <&vreg_pcie_12v>;
+	vpcie3v3-supply = <&vreg_pcie_3v3>;
+	vpcie3v3aux-supply = <&vreg_pcie_3v3_aux>;
+};
+
+&pcie5 {
+	vddpe-3v3-supply = <&vreg_wwan>;
+};
+
 &pcie6a {
 	vddpe-3v3-supply = <&vreg_nvme>;
 };
@@ -868,6 +920,17 @@ usb0_3p3_reg_en: usb0-3p3-reg-en-state {
 	};
 };
 
+&pm8550ve_8_gpios {
+	pcie_x8_12v: pcie-12v-default-state {
+		pins = "gpio8";
+		function = "normal";
+		output-enable;
+		output-high;
+		bias-pull-down;
+		power-source = <0>;
+	};
+};
+
 &pm8550ve_9_gpios {
 	usb0_1p8_reg_en: usb0-1p8-reg-en-state {
 		pins = "gpio8";
@@ -879,6 +942,26 @@ usb0_1p8_reg_en: usb0-1p8-reg-en-state {
 	};
 };
 
+&pmc8380_3_gpios {
+	pm_sde7_aux_3p3_en: pcie-aux-3p3-default-state {
+		pins = "gpio8";
+		function = "normal";
+		output-enable;
+		output-high;
+		bias-pull-down;
+		power-source = <0>;
+	};
+
+	pm_sde7_main_3p3_en: pcie-main-3p3-default-state {
+		pins = "gpio6";
+		function = "normal";
+		output-enable;
+		output-high;
+		bias-pull-down;
+		power-source = <0>;
+	};
+};
+
 &pmc8380_5_gpios {
 	usb0_pwr_1p15_reg_en: usb0-pwr-1p15-reg-en-state {
 		pins = "gpio8";
-- 
2.34.1


