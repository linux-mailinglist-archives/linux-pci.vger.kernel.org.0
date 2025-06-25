Return-Path: <linux-pci+bounces-30574-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC034AE7720
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 08:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 096905A66CF
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 06:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF7D1F9F51;
	Wed, 25 Jun 2025 06:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bfAs61uU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38811F4CBE;
	Wed, 25 Jun 2025 06:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750833163; cv=none; b=EsNhv5MVnfFbiAIElslE3elFBqN3xv7S6OKIQkY4JYlCTN1wh45tazlrklcH5nv1yWqkg6xR2l63SBGBQEt29hvAwvJkeQ4g3faAIYjBvss7IzGM3YjMn3KeMEusRYTpqDlHx1BHre56H19vgT4ZgoldTQWlAtElhHFRUYOF34s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750833163; c=relaxed/simple;
	bh=J2cIrhTJb1tAt+xF0cRJxyboRXrNf66T5q+wxh2vAbA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BBo+zbEajem0cB2aqkAU34tDcmJsjvWPryR6p5lLTGFn8WOBuRwajxw7pOh86l8Df/GVG5XtMnWVQwWsISC/iwVGgbLX8apq2/BN4oniChYV7R0O0eZCzIgP/bGkkp5RzRfzvpk5Q0ij0EkQWKK5zzC8y9NjFbVVP9hCGaq90tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bfAs61uU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55P2eiS0005909;
	Wed, 25 Jun 2025 06:32:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=tikAt8XZpHo
	ce+4trJX3SM0Syq+g0NPg1ReVquG7As4=; b=bfAs61uUPxubwsjzr6ldYEXY+aq
	ST+9cjcqhO87rOpLzAP5vpjBhKdwXg9BhAFBXpRf8e1SsDdAd+KHTM6vH04wH2Xr
	0VZJsyItCPvdoCyQEFePtGKHE+nCR1a7CEQopnhxBpXdbD3nxjkLx1SWdDGNVGue
	luw6IrhZ4BX2GB0sT5AEuba2hdCIszCJDt8IKlzY9d+SUFxabYPoQNfZkHrYMjWu
	zc+YAEX4b0v/r+fQBCoY8sfNmroN5IPBoWqN8+kOPGTilqiK6sdhTEdvC6aP1H+c
	IjNIgb/Vsj8WMKTwoHJ28ij7g75EdmDqzZajJlS+oDGbXN+8YJIs9O2UFiQ==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47f3bgess5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 06:32:30 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 55P6WSGS009137;
	Wed, 25 Jun 2025 06:32:28 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 47dntma31p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 06:32:28 +0000
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55P6WRO3009130;
	Wed, 25 Jun 2025 06:32:28 GMT
Received: from cse-cd02-lnx.ap.qualcomm.com (cse-cd02-lnx.qualcomm.com [10.64.75.246])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 55P6WRt0009124
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 06:32:27 +0000
Received: by cse-cd02-lnx.ap.qualcomm.com (Postfix, from userid 4438065)
	id 1020D3839; Wed, 25 Jun 2025 14:32:26 +0800 (CST)
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
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Ziyue Zhang <quic_ziyuzhan@quicinc.com>
Subject: [PATCH v6 3/3] arm64: dts: qcom: qcs615-ride: Enable PCIe interface
Date: Wed, 25 Jun 2025 14:32:13 +0800
Message-Id: <20250625063213.1416442-4-quic_ziyuzhan@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250625063213.1416442-1-quic_ziyuzhan@quicinc.com>
References: <20250625063213.1416442-1-quic_ziyuzhan@quicinc.com>
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
X-Proofpoint-ORIG-GUID: VLh9eUt4YB79w6quYwANEg8H5udDFVwr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDA0NyBTYWx0ZWRfX6j1PtgGtCJ5z
 6rWnGBRCxOZJvNv6qIZ7bvH9uHARbTQcdKnbHQtts/QkVohp/70meUmPQufEsZM5yInT1X8hQ8R
 EfXaMWUTZ5ApoQBORu20g5sgFRNlPtkCgXXzxVs3+JSJn13DDhI6trcUOCVirWPB1voYQ2d03RP
 EB+rzM7OjLAztftx1qYpEhP/J4mj8RNNenDa8HlpqzM+L7BJ4ew3aX/HesRdtGL4y9Ae8zp3/cP
 /JQQamsmlGXtcC2Xz5dNSm5OV4cTdsUF664nWYwO385IXfsbT2Lum99hk2aIPin9FagREAEMuQV
 aQYR8tPu8l8TC0XOBkjeFwcyqmWq0LQEI+Kho5JfYazV6bgk4QVtk1MrA6L+/7TRIKC10ZdENJG
 g46a9I74G8SRCzaY3PZRfsrHX8THckMIfqvyHdtpB9d+Nay599qmvoXfkpe02nQDT+3CFWkd
X-Authority-Analysis: v=2.4 cv=L4kdQ/T8 c=1 sm=1 tr=0 ts=685b97fe cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=6IFa9wvqVegA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=3zbVK_edIv7hY8gRkFcA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: VLh9eUt4YB79w6quYwANEg8H5udDFVwr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-25_01,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0 bulkscore=0 clxscore=1015 suspectscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 spamscore=0 phishscore=0 mlxlogscore=999 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506250047

From: Krishna chaitanya chundru <quic_krichai@quicinc.com>

Add platform configurations in devicetree for PCIe, board related
gpios, PMIC regulators, etc.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Signed-off-by: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
---
 arch/arm64/boot/dts/qcom/qcs615-ride.dts | 42 ++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs615-ride.dts b/arch/arm64/boot/dts/qcom/qcs615-ride.dts
index a6652e4817d1..011f8ae077c2 100644
--- a/arch/arm64/boot/dts/qcom/qcs615-ride.dts
+++ b/arch/arm64/boot/dts/qcom/qcs615-ride.dts
@@ -217,6 +217,23 @@ &gcc {
 		 <&sleep_clk>;
 };
 
+&pcie {
+	perst-gpios = <&tlmm 101 GPIO_ACTIVE_LOW>;
+	wake-gpios = <&tlmm 100 GPIO_ACTIVE_HIGH>;
+
+	pinctrl-0 = <&pcie_default_state>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+
+&pcie_phy {
+	vdda-phy-supply = <&vreg_l5a>;
+	vdda-pll-supply = <&vreg_l12a>;
+
+	status = "okay";
+};
+
 &pm8150_gpios {
 	usb2_en: usb2-en-state {
 		pins = "gpio10";
@@ -256,6 +273,31 @@ &rpmhcc {
 	clocks = <&xo_board_clk>;
 };
 
+&tlmm {
+	pcie_default_state: pcie-default-state {
+		clkreq-pins {
+			pins = "gpio90";
+			function = "pcie_clk_req";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+
+		perst-pins {
+			pins = "gpio101";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-pull-down;
+		};
+
+		wake-pins {
+			pins = "gpio100";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+	};
+};
+
 &sdhc_1 {
 	pinctrl-0 = <&sdc1_state_on>;
 	pinctrl-1 = <&sdc1_state_off>;
-- 
2.34.1


