Return-Path: <linux-pci+bounces-40971-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C658C514AD
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 10:12:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 621703ADC84
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 09:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC38F2FE06B;
	Wed, 12 Nov 2025 09:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Y4YAvoRI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D594D28CF52;
	Wed, 12 Nov 2025 09:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762938216; cv=none; b=paMoSJFsvMma2RvCXQ2EgIUL11buVv1/sLg2tlmLYhvojRSCisVJ1chcENXlbrGJqpw2izz7ok2fszX/nJh3n7nK56dIqR85y4WRxkeKQxKKkW1KIivKDMOHyXSnj0fmSxLwqKM5Lur38q55DlETrtaNZobQaY9pKwsxGmPthfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762938216; c=relaxed/simple;
	bh=fljxTaMzFX2Sjct1pVGqFWmYdx2AMO6OBI5nO8Epd+s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VxyboDw/lkg2NZqJ3Cp6NrBaU90bFkc5RFYZsk7TFq90g66VUlaKe0j+PTBwBY1bofLewQu+ZANll3EzzZOk4reUSt+S9iB4Igwb5cpuZown0xhfXLMUztmmelc1nPLZ4mWkUCijJ+hYuys0rsCnq06eFWsLxOPNfV7p5Kbb2Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Y4YAvoRI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AC2X3R72813765;
	Wed, 12 Nov 2025 09:03:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=W3Ek7lW/6JS
	6FfHVzcyjaSTlCTonVsRPSZKWIETuY1c=; b=Y4YAvoRI3WD25qPxelxgRv9NlQj
	IJqpLmILSZBVVH7dGQDu4g0PI7Y8Nku44dsW557Mb5I8osD+HUXHc6WRW67UKMTv
	FM4+BUcaZKBw9AZsTudDpsyXR1P3E9J2cwC/DuVClFLJjCFSsuako+ef9jlgEbvW
	LSs694tWrsWvFe2nMbcwNvX+219lW/GIklpI7cvsjUNPBWfIk1Cr+bBeTVi3/Dcp
	KWbezJgd2p32Edlhx/xpBBcOySqpv0MX1u0ygsYqsK06EFco9LXgNxbTHrb2l3ws
	FU+zO5yb2Jhtit2uQxpJ3NbpXouRDJM1wGUMX+D/MLLhIXeDwktV8xGLCsA==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ac855jk84-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 09:03:25 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AC93LGH012296;
	Wed, 12 Nov 2025 09:03:21 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 4a9xxmq755-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 09:03:21 +0000
Received: from APTAIPPMTA02.qualcomm.com (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5AC93LG4012284;
	Wed, 12 Nov 2025 09:03:21 GMT
Received: from cse-cd02-lnx.ap.qualcomm.com (cse-cd02-lnx.qualcomm.com [10.64.75.246])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 5AC93KXq012281
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 09:03:21 +0000
Received: by cse-cd02-lnx.ap.qualcomm.com (Postfix, from userid 4438065)
	id 74E6673F; Wed, 12 Nov 2025 17:03:19 +0800 (CST)
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
Subject: [PATCH v3 1/2] arm64: dts: qcom: Add PCIe3 and PCIe5 support for HAMOA-IOT-SOM platform
Date: Wed, 12 Nov 2025 17:03:15 +0800
Message-Id: <20251112090316.936187-2-ziyue.zhang@oss.qualcomm.com>
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
X-Proofpoint-GUID: SvyYy3S2kwz3IkCDy0dFREdnNbqSztof
X-Authority-Analysis: v=2.4 cv=DYwaa/tW c=1 sm=1 tr=0 ts=69144d5d cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=bvY3E1ByFFb03tV5gjAA:9 a=nl4s5V0KI7Kw-pW0DWrs:22 a=pHzHmUro8NiASowvMSCR:22
 a=xoEH_sTeL_Rfw54TyV31:22
X-Proofpoint-ORIG-GUID: SvyYy3S2kwz3IkCDy0dFREdnNbqSztof
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDA3MCBTYWx0ZWRfX/qPuyssSDHt8
 wElXyBziAjMl6oafChJFgzNUnvN01bNP+m4NDmNTVw1MupUiekwmFR7jpWlQr7KLUdyGXizY5sM
 idMShSXmYLDDRucYj9k4xNrhcvquHtQn7KPm3+xlmLV/+Y/ddSJLuBA/JP34zQc/L7onxFC7+ZS
 lbOKE1tK+dcQmEkDR5S7wezz7zFJ2w7sSWULcLMWE5Owv83pVPrs2rLFwGVVZc5/3DKf9QakQyN
 8S+Nczl1KHhJopgBS6qe0ysUSNlZdDSaowvmtFYZx68rx44sIbkt/sxHok7IvjMRa3sdeMRLJFZ
 FJpUrabyM7bmhVWmxLqsPkNG0ObdZPv8PNmfomgexRURJMsBAESF9fGfKapgUiOZVCQxIqVncUI
 Qmx2G8c8uRvaIw9i4j+k+y9wDWbthg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_03,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 spamscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511120070

HAMOA IoT SOM requires PCIe3 and PCIe5 connectivity for SATA controller
and SDX65.
Add the required sideband signals (PERST#, WAKE#, CLKREQ#), pinctrl states
and power supply properties in the device tree, which PCIe3 and PCIe5
require.

Signed-off-by: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
Reviewed-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/hamoa-iot-som.dtsi | 79 +++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/hamoa-iot-som.dtsi b/arch/arm64/boot/dts/qcom/hamoa-iot-som.dtsi
index 4de7c0abb25a..abb8ea323d78 100644
--- a/arch/arm64/boot/dts/qcom/hamoa-iot-som.dtsi
+++ b/arch/arm64/boot/dts/qcom/hamoa-iot-som.dtsi
@@ -390,6 +390,22 @@ &gpu_zap_shader {
 	firmware-name = "qcom/x1e80100/gen70500_zap.mbn";
 };
 
+&pcie3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie3_default>;
+	perst-gpios = <&tlmm 143 GPIO_ACTIVE_LOW>;
+	wake-gpios = <&tlmm 145 GPIO_ACTIVE_LOW>;
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
@@ -407,6 +423,23 @@ &pcie4_phy {
 	status = "okay";
 };
 
+&pcie5 {
+	perst-gpios = <&tlmm 149 GPIO_ACTIVE_LOW>;
+	wake-gpios = <&tlmm 151 GPIO_ACTIVE_LOW>;
+
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
@@ -454,6 +487,29 @@ &tlmm {
 	gpio-reserved-ranges = <34 2>, /* TPM LP & INT */
 			       <44 4>; /* SPI (TPM) */
 
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
@@ -477,6 +533,29 @@ wake-n-pins {
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


