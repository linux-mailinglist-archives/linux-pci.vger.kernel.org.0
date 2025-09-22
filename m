Return-Path: <linux-pci+bounces-36629-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D99AB8F5CE
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 09:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CFCE189FE58
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 07:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57932F7AAF;
	Mon, 22 Sep 2025 07:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="B9LsRG9q"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043032F7AA1;
	Mon, 22 Sep 2025 07:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758527739; cv=none; b=CXBcZTKSt8ZGwgQVsNOgnb+cKm+WDSHNQv4nA7NwWUJjrJf4W8lb5c96G6pEiok7RgXgP6A8KtK33A3YzYtxTdcVj+WRfJqYMLyDGgzQT3lmJiMiUJtLvimBgGXlbzgvUDwAH7La3ghaQMk7i7/EILdWnH9dPWy6g9oQIxm4ntQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758527739; c=relaxed/simple;
	bh=I+yH+M/v6VALw0Byp/bOv9n4QqquVbQpkv9IZj09e+Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oQq23iNxO8jHNmkf+yBPxNGK2PV9JwWWUYuEz5blDEPfrFRDVf8wPP07rcyGM8qJFeAVCEZyd/pw8vMJBOMTFsTctMnXbCmq4vrdZGGcWk7pMzTRvYkH1pnX1/J8uTzQKtzU+wCN/PyPa/tXu7o5j9s+jQBvYsuD4B1k7sZR69c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B9LsRG9q; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58M0PVwr002772;
	Mon, 22 Sep 2025 07:55:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=rdJxzHfvzX5
	WtcrI5o5fZy/SiE8TWllcqK31NirN9Y4=; b=B9LsRG9qFA/QLWzqnOJu3fa4irD
	OMkzjv02FY+01FFnDEt6dFyXMyXCQrmyDjMk2DqL8GoearkvpJjOS/8pva0HHcMV
	BwxyWF84DtGs3dw4WfVstEgB+PsIJILfUg8DHE7wwn20VPkLD+/XpSztpWcFwia6
	U0ZBIPIwE2o23NkGPrtPfVKkCzmfO9I4pmYt1vwrWGuG52Mch+j4VWn98Ce0Hbxq
	QExEnyBtwG8PGgrE/G+IkJiVnRvDxpDtlv8Gnsdj4hAfOeNyXfxUedLdWxK7aY9z
	fNu0hYejBS/88JA2hWjRlON2J6HTD7CL8JfAH4EMzoB3Pq9aXSog58HKEIQ==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499k98bvrj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Sep 2025 07:55:22 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 58M7tG5F003013;
	Mon, 22 Sep 2025 07:55:16 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 499nbkqvta-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Sep 2025 07:55:16 +0000
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 58M7tGib003003;
	Mon, 22 Sep 2025 07:55:16 GMT
Received: from cse-cd02-lnx.ap.qualcomm.com (cse-cd02-lnx.qualcomm.com [10.64.75.246])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 58M7tFpG002995
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Sep 2025 07:55:16 +0000
Received: by cse-cd02-lnx.ap.qualcomm.com (Postfix, from userid 4438065)
	id 8F0D8B68; Mon, 22 Sep 2025 15:55:14 +0800 (CST)
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
Subject: [PATCH v1 3/4] arm64: dts: qcom: Add PCIe 3 support for HAMOA-IOT-SOM platform
Date: Mon, 22 Sep 2025 15:55:08 +0800
Message-Id: <20250922075509.3288419-4-ziyue.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250922075509.3288419-1-ziyue.zhang@oss.qualcomm.com>
References: <20250922075509.3288419-1-ziyue.zhang@oss.qualcomm.com>
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
X-Proofpoint-GUID: G4fE2PZyZM60TZmKgkP_APl8-8-UTwbY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxOCBTYWx0ZWRfX6cba8rS3U2xA
 92m3WBJFg7yVPyuK9E3dxO7YFcebdEI6/xO9kfR7IpkVKJaq/d0/zfyTMGGZJX9KpffquVeHZS/
 CDHhB+tqpVp1Rg4H6/zannHTPUwCrz2R7lyaCV+tatupRfAuvDpOzbf0x95ocjuolbBatcJ6nRL
 8zQ8s5Av7UM2Glt645Xqvs3PVBaqg4w9O+gr6PscsWvhQoUilEE4rD45Q/Z6odZrMOZ4r/QRzXZ
 BsPXYrmeLVlyP5E0dGeAoZ+jlpYqDmEAdSyHPLN2y52Tn+cGZk/in98W13QqDAzf7f3yGL6H2Mt
 chI1mr0MTumg9uCIZWXyRJulShX2ha2xvMoski8t0bpvGwmfmDWjYOZ2tImdXVIMm9+ogeKoZ26
 8vVTvneJ
X-Proofpoint-ORIG-GUID: G4fE2PZyZM60TZmKgkP_APl8-8-UTwbY
X-Authority-Analysis: v=2.4 cv=Dp1W+H/+ c=1 sm=1 tr=0 ts=68d100ea cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=wcWuBB4AhrRTeZBF1NMA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_01,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200018

Update the HAMOA-IOT-SOM device tree to enable PCIe 3 support. Add perst
wake and clkreq sideband signals and required regulators in PCIe3
controller and PHY device tree node.

Signed-off-by: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/hamoa-iot-som.dtsi | 70 +++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/hamoa-iot-som.dtsi b/arch/arm64/boot/dts/qcom/hamoa-iot-som.dtsi
index 0c8ae34c1f37..7486204a4a46 100644
--- a/arch/arm64/boot/dts/qcom/hamoa-iot-som.dtsi
+++ b/arch/arm64/boot/dts/qcom/hamoa-iot-som.dtsi
@@ -390,6 +390,53 @@ &gpu_zap_shader {
 	firmware-name = "qcom/x1e80100/gen70500_zap.mbn";
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
@@ -471,6 +518,29 @@ &tlmm {
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
+			bias-pull-down;
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
-- 
2.34.1


