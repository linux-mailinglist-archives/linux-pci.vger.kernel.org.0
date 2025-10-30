Return-Path: <linux-pci+bounces-39769-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C121C1F1A3
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 09:52:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5A78189F4E6
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 08:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27FD7311C21;
	Thu, 30 Oct 2025 08:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="b8mPjh42"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6922B17B43F;
	Thu, 30 Oct 2025 08:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761814104; cv=none; b=SSQypAr9i14JRAFCMffSPj9Fie5egBqRH3xlBHNB3Xl2vqIUW2+/Hqa79SeOTRst8cf8fn8AYvDM7RtXfWjF1YJD7zcn+HbdiPJ7Oiz13NxY/5Y0I3VWxp26akY02eU8xOh/PZdG1DVuG7OAVw6Ed7pYMczyJHbd0e7NUeoFF+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761814104; c=relaxed/simple;
	bh=8sD0ns+uWb+QlPVtoeEaFgWIbwbwraDE1fo162MrNeE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UDqdvInGYwnnMmOGBdibqbQ80mlwv51pAk9xRy+EU9t2MzzhMzDrn9HnWJs9PaH+V83/iBuM8F8n6Hbe+Mzizm/fA9Tc9WmqVvqGLtZvxU1Pl09t1+pzV+3gZrmvEgBX0d2+ojXZY8aD/0LkOUG7Ow6Qj2EgIzrAmfxwKw/E7NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=b8mPjh42; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59TNDOom569432;
	Thu, 30 Oct 2025 08:48:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=T8kDteBa32Z
	Z3REFXFeQzifFsW38kLJueXZX9kgf+Kw=; b=b8mPjh42h3BOIcpGEpU+E+XlgWL
	b6GMFXVbvY/nsbSaltNx8I5h7LCU1/sK+I13YEz4yRDB+kO+XL2mULjb34wHQklk
	IrK52lOJDlW/1uf9MXLtsuGhiA2JYBzZyk+Gtrfb8PxDyL0yECykHHjsbGHlUr0x
	z3lc3RNmRxdOEX7YdnRA+R/Bfe01zMXK6oWYazMtXjm7tgs64iSAiS2n/a2QQj5b
	5xyiqr0YY0b6TCT7UKBl7k8UuO+xa4Hckd4RGFwucU/quY8V49N8WrD0tHt7AuNw
	6bNfyTjDeHc8EjjDuB2XFjJ+0LXI2gwrcoFllSEnrWTr7I7S9yhQDsXV62Q==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a3m0bk4kx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Oct 2025 08:48:11 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 59U8m8jl027984;
	Thu, 30 Oct 2025 08:48:08 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 4a0qmmec4m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Oct 2025 08:48:08 +0000
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 59U8m8Xa027969;
	Thu, 30 Oct 2025 08:48:08 GMT
Received: from cse-cd02-lnx.ap.qualcomm.com (cse-cd02-lnx.qualcomm.com [10.64.75.246])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 59U8m7iQ027966
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Oct 2025 08:48:08 +0000
Received: by cse-cd02-lnx.ap.qualcomm.com (Postfix, from userid 4438065)
	id 476087AF; Thu, 30 Oct 2025 16:48:06 +0800 (CST)
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
Subject: [PATCH v2 4/4] arm64: dts: qcom: Add PCIe 3 regulators for HAMOA-IOT-EVK board
Date: Thu, 30 Oct 2025 16:48:04 +0800
Message-Id: <20251030084804.1682744-5-ziyue.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251030084804.1682744-1-ziyue.zhang@oss.qualcomm.com>
References: <20251030084804.1682744-1-ziyue.zhang@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: 3XuDuN8aZ6fFOiyJtTNJC3iElh85e0D1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDA3MSBTYWx0ZWRfX7h34hR5FK3ra
 R/Uk51mXBD9ivVvURO0AkbVDjHJgoMH+u+g+qDABZfe3I80tk7/TsZY7rzn79rHUOD3qsSpn+Bi
 ZHgX58yi0hAKKspVt3XnfT5C83WhUUK6iIip8jTvtLnoa3ROkbno1F8q3ROzKJKVe+WbGkA452K
 WLebAFx0i/0Hx1LeXyMiDefW2Kf5DUSGrtPV7mWbI50ZhjZxoG+LBF30CHjE31dTF0ypBwyGA0u
 2pK8iB8DmiClAr4LzYtfNGFPoZAIFbpXZqBUG9Y5upFHx3zIw3iuS9kcbAKYUn/riP+k/RZdum+
 2N8Gvd0XBWK5YsgbxMlIN+GEvV60om7qBPmGIeGZL6cisl78nLsBcySSweZG5Gp3cNXgtlSX622
 aPy5tGMydHZwwRa8rUqnm15P34PbwQ==
X-Proofpoint-GUID: 3XuDuN8aZ6fFOiyJtTNJC3iElh85e0D1
X-Authority-Analysis: v=2.4 cv=YLySCBGx c=1 sm=1 tr=0 ts=6903264c cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=sPBEuoHp8yVuwt2A19AA:9 a=nl4s5V0KI7Kw-pW0DWrs:22 a=pHzHmUro8NiASowvMSCR:22
 a=xoEH_sTeL_Rfw54TyV31:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 spamscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510300071

HAMOA-IOT-EVK board includes a PCIe3 controller and x8 slot that require
proper power rail and control signal configuration. This update adds
`vddpe-3v3-supply` and `regulator-pcie-12v` to provide 3.3V to the PHY
and 12V to the slot for external devices.

It also introduces PM GPIOs to manage power enable and reset signals,
ensuring stable power sequencing and reliable PCIe3 operation.

Signed-off-by: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts | 79 ++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts b/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
index 24c2dcef0ba8..0984a6eed226 100644
--- a/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
+++ b/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
@@ -414,6 +414,48 @@ vreg_wwan: regulator-wwan {
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
+};
+
 	sound {
 		compatible = "qcom,x1e80100-sndcard";
 		model = "X1E80100-EVK";
@@ -844,6 +886,12 @@ &mdss_dp3_phy {
 	status = "okay";
 };
 
+&pcie3_port {
+	vpcie12v-supply = <&vreg_pcie_12v>;
+	vpcie3v3-supply = <&vreg_pcie_3v3>;
+	vpcie3v3aux-supply = <&vreg_pcie_3v3_aux>;
+};
+
 &pcie5 {
 	vddpe-3v3-supply = <&vreg_wwan>;
 };
@@ -872,6 +920,17 @@ usb0_3p3_reg_en: usb0-3p3-reg-en-state {
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
@@ -883,6 +942,26 @@ usb0_1p8_reg_en: usb0-1p8-reg-en-state {
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


