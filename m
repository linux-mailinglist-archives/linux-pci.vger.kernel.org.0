Return-Path: <linux-pci+bounces-36627-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2BFCB8F5B9
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 09:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 720993B5ABB
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 07:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D4D2F9992;
	Mon, 22 Sep 2025 07:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="M4iX09m5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6316A2F747A;
	Mon, 22 Sep 2025 07:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758527732; cv=none; b=pGjm9ZLGzHDwWq66Z/CrAyqtgl63mA04k89ad/6wk0qc5oZyBJ2/vDsArvFcq1+FF3a5Fq7OqkHlGhtjme91EDjhSaCV/14lZcLsrhaKI/3Vxe+uZxIAo0OipMdJ/NTagHQ4tJX4N3234rIqgTsCeoelmxHP+UeYR9M1bNsRJm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758527732; c=relaxed/simple;
	bh=XouSCueg0+yFvRXI85Ikk2tFZJODO+X8A4ATtz6XncU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z99MGjDhuwAMAaQCTggsl198lCBcuIEH8eIPxm7VvisCZzQI4jji3xt0Wc5u78TEnbsFJNPKuFZZ4OahhqpIP8a6XJgM0DOyGQNaDG46xFQHkZl98+4SnOMTPW53cC71DzNmZjlmymKLsXmTPKHvW9SUlLPQxnyhQlf6vOeIG4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=M4iX09m5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58M0Tt7w001157;
	Mon, 22 Sep 2025 07:55:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=uiNifafr+z5
	LlsCGU/i8kv1NxH8DYrT4tPquHPc2ybE=; b=M4iX09m5EtQm7zMqubXnMUgn0Od
	NsGcbn+pJRz10ngmA0rCpnSEbivc1V3Y2heVTq0jEWSSnaF3azLaBoiGvV8pn7i0
	vFvd/pQ/YkZtC+0ivUgNl0uRx16PbWNTfV+fquWvDYkIROCvS5HO02WP3Ea5Hs3g
	1FRWSrz9vgMduP45Y0+ChMgFEQ8C8UIwdcXHG7/5YYs6Gmu8u6tuNvzL/WF5bpiA
	QpQsS4+OpqjUSF3j7HuLHJnkL1V2sLsCdaGm92yHez1J5NZJEYewJ5qHyWYeXm33
	5mgBBL1TZQTmqQ/c6WdCLhn4yl0b2q5MFtisFbiP6gKI65IR+NBEDquIlPQ==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499kv0uu55-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Sep 2025 07:55:22 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 58M7tGLQ003015;
	Mon, 22 Sep 2025 07:55:16 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 499nbkqvtb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Sep 2025 07:55:16 +0000
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 58M7tGrv003004;
	Mon, 22 Sep 2025 07:55:16 GMT
Received: from cse-cd02-lnx.ap.qualcomm.com (cse-cd02-lnx.qualcomm.com [10.64.75.246])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 58M7tFKQ002996
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Sep 2025 07:55:16 +0000
Received: by cse-cd02-lnx.ap.qualcomm.com (Postfix, from userid 4438065)
	id 8397D536; Mon, 22 Sep 2025 15:55:14 +0800 (CST)
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
Subject: [PATCH v1 1/4] arm64: dts: qcom: Add PCIe 5 support for HAMOA-IOT-SOM platform
Date: Mon, 22 Sep 2025 15:55:06 +0800
Message-Id: <20250922075509.3288419-2-ziyue.zhang@oss.qualcomm.com>
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
X-Proofpoint-GUID: yJSeozVl9jf3PgSX4tblDGs1HKiGvOey
X-Authority-Analysis: v=2.4 cv=RO2zH5i+ c=1 sm=1 tr=0 ts=68d100ea cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=AKi9O1JBWpYc0O-Ep20A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAyNSBTYWx0ZWRfX/Z/FaHJpOeNu
 XsHMUlfNJL7EnSsrviIbEAPJvKRLoeARU/h4i2NxGDr3QuuB2nW58nXCvhprwaIwgqP1zeBKVmS
 p6hHbGuNrx1yxhLGlpMX7xVdnK3hcMlNloPSR76hl3bqn+bDOGjGKNKxb8unamfPNi3Am67fPQz
 0nRAVZ+iTTPv2Wh5TsfVDAPY+XnxfDoYLY6iECEO3xwD8kQf7ZHI+JnYXDCy/swoxDofFKXauG9
 QyXdKelqDl4J9ug5FwWRo991i+JhE2/SkUPjsW+xCQRn9ut1nm01E/5YsNWBaf8FJsRJVF118v8
 vAq2E116m2i/F197WDB2vkaq6dIipNY2Ioy9kp8WX0phb4qIcC9neacpGzpIsr3yJYFjUKcWRJs
 pEKYdQxM
X-Proofpoint-ORIG-GUID: yJSeozVl9jf3PgSX4tblDGs1HKiGvOey
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_01,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200025

Update the HAMOA-IOT-SOM device tree to enable PCIe 5 support. Add perst
wake and clkreq sideband signals and required regulators in  PCIe5
controller and PHY device tree node.

Signed-off-by: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/hamoa-iot-som.dtsi | 40 +++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/hamoa-iot-som.dtsi b/arch/arm64/boot/dts/qcom/hamoa-iot-som.dtsi
index 1aead50b8920..0c8ae34c1f37 100644
--- a/arch/arm64/boot/dts/qcom/hamoa-iot-som.dtsi
+++ b/arch/arm64/boot/dts/qcom/hamoa-iot-som.dtsi
@@ -407,6 +407,23 @@ &pcie4_phy {
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
@@ -477,6 +494,29 @@ wake-n-pins {
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


