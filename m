Return-Path: <linux-pci+bounces-20350-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D73A1C0DE
	for <lists+linux-pci@lfdr.de>; Sat, 25 Jan 2025 05:00:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4548C188E258
	for <lists+linux-pci@lfdr.de>; Sat, 25 Jan 2025 04:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D5A156887;
	Sat, 25 Jan 2025 04:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lBmZ5J2F"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0850238DC8;
	Sat, 25 Jan 2025 04:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737777613; cv=none; b=ajyQxYPsYAnaEMjo/+U+p4K23+8cKjM1c5EUOeIlhx8obaGZTZg9wKeKr3K2i2oplp1piyDF8LpTXk4+Ft9IBFUal+xr7kmUOqVcyZ1PHB7UHwK4Dv6XlaUtYu94tZqvlnTslfLqT8f2AOq8HA/TyRZ8pseAYG35bSw9o2XNQS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737777613; c=relaxed/simple;
	bh=u9DdFPRF9N6dOCs6lNTwPHLiRF7yWCGS7KMXryCClrA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QBYdUH2WU4dXHfwp0/ORb8CCfLvxPMlFFx/sQksLwPLfL08nNj5kYF36e4kwswudgfJpENcGhpI4enDgmsX7JwYdJE8Lu1hBL2WWHLfOu3oeQk7gtFTvbSGZlGegPMUc7h2cOxcUHlyLi2LFlnF62sh/Gzkekyrhw4GY6KX9Aog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lBmZ5J2F; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50P3l9HG023311;
	Sat, 25 Jan 2025 04:00:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eiOcsnv62MOAjjxBvHSWAYanWeHv/Cwz1Gw/BGLD46w=; b=lBmZ5J2F9vimMNB9
	nuAiDaAVOwisqiNycCCMSb0xIi3WD4gxqhVCITiRZ1S0Add+YV8iJSPCaOXdvRP+
	i2AearOl31Hmp3lVEvyXaIYgs99ZY7Mb5c5QERK3ApI1CmcNw9g11R1nr4NyR+eY
	U7qMuWFydvXZ8TjO0CfheaqykHRGsKLpnjrgNykZ/CuzKoDFVreMIjZ7pUPj7JNy
	GrwM5P3EPzX0lvrVGkl98MFGqXjAjxMcPvCVnBsT3tTWno60SDeoGRj61DGEuL2x
	7vQ6h86SbrOBuOUX9nmO07ukViX05P6QGnpAqnEiVQBzWO2lGUysaA1ep/85erOl
	ZSC82Q==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44cpy5r452-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 25 Jan 2025 04:00:01 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50P400tY008864
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 25 Jan 2025 04:00:00 GMT
Received: from hu-mmanikan-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 24 Jan 2025 19:59:55 -0800
From: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
To: <andersson@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <lpieralisi@kernel.org>, <kw@linux.com>,
        <manivannan.sadhasivam@linaro.org>, <bhelgaas@google.com>,
        <konradybcio@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
CC: <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>
Subject: [PATCH v3 4/4] arm64: dts: qcom: ipq5424: Enable PCIe PHYs and controllers
Date: Sat, 25 Jan 2025 09:29:20 +0530
Message-ID: <20250125035920.2651972-5-quic_mmanikan@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250125035920.2651972-1-quic_mmanikan@quicinc.com>
References: <20250125035920.2651972-1-quic_mmanikan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: n3KSvy9iIoMG6P2eLloq4G5MVEALKtEj
X-Proofpoint-GUID: n3KSvy9iIoMG6P2eLloq4G5MVEALKtEj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-25_01,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 impostorscore=0 suspectscore=0 bulkscore=0 mlxscore=0 mlxlogscore=878
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501250024

Enable the PCIe controller and PHY nodes corresponding to RDP466.

Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
---
Changes in V3:
	- No change.

 arch/arm64/boot/dts/qcom/ipq5424-rdp466.dts | 41 ++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq5424-rdp466.dts b/arch/arm64/boot/dts/qcom/ipq5424-rdp466.dts
index b6e4bb3328b3..73e6b38ecc26 100644
--- a/arch/arm64/boot/dts/qcom/ipq5424-rdp466.dts
+++ b/arch/arm64/boot/dts/qcom/ipq5424-rdp466.dts
@@ -53,6 +53,30 @@ &dwc_1 {
 	dr_mode = "host";
 };
 
+&pcie2 {
+	pinctrl-0 = <&pcie2_default_state>;
+	pinctrl-names = "default";
+
+	perst-gpios = <&tlmm 31 GPIO_ACTIVE_LOW>;
+	status = "okay";
+};
+
+&pcie2_phy {
+	status = "okay";
+};
+
+&pcie3 {
+	pinctrl-0 = <&pcie3_default_state>;
+	pinctrl-names = "default";
+
+	perst-gpios = <&tlmm 34 GPIO_ACTIVE_LOW>;
+	status = "okay";
+};
+
+&pcie3_phy {
+	status = "okay";
+};
+
 &qusb_phy_0 {
 	vdd-supply = <&vreg_misc_0p925>;
 	vdda-pll-supply = <&vreg_misc_1p8>;
@@ -147,6 +171,22 @@ data-pins {
 			bias-pull-up;
 		};
 	};
+
+	pcie2_default_state: pcie2-default-state {
+		pins = "gpio31";
+		function = "gpio";
+		drive-strength = <8>;
+		bias-pull-up;
+		output-low;
+	};
+
+	pcie3_default_state: pcie3-default-state {
+		pins = "gpio34";
+		function = "gpio";
+		drive-strength = <8>;
+		bias-pull-up;
+		output-low;
+	};
 };
 
 &uart1 {
@@ -166,4 +206,3 @@ &usb3 {
 &xo_board {
 	clock-frequency = <24000000>;
 };
-
-- 
2.34.1


