Return-Path: <linux-pci+bounces-24429-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF80AA6C750
	for <lists+linux-pci@lfdr.de>; Sat, 22 Mar 2025 04:01:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E84A618963A3
	for <lists+linux-pci@lfdr.de>; Sat, 22 Mar 2025 03:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A44580604;
	Sat, 22 Mar 2025 03:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="V3YOo5E4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA22137923
	for <linux-pci@vger.kernel.org>; Sat, 22 Mar 2025 03:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742612468; cv=none; b=GrJMmGRt27BEZLhUHme+z+sT8CPHkcWFDnEoXdmTsVYDizwpkFokIBAQmik655GqUlyoYUvwIg8e0ZGRr+c4nN5tiZro/m9UzJcQK1+9vViUi6J5XhzvabhGBQlYXsCO9/h2kIxIJ11l9B3clig89DYHppnS2JJ9pDc4F2WMQ4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742612468; c=relaxed/simple;
	bh=Mk1edLjeulLTMsWslHQkThKj73LmX8ZgbviMLPagnkI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CbwMivbSHn0i2PWUGKY8fjjoWcwHaf6SmHuiyhh9X6WNQ+VqA7igkbUEpoYEdpTzDNeU8FYYHmZo+NLeQbIZ+8GMb6kDJlZev5dhhG1W+t+jltMPzp21StIFEOrLEIf+IwmKLBMEz8h262N1oYEKyd3uFb5BgfXhkU4xPct78NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=V3YOo5E4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52M2Y97s008300
	for <linux-pci@vger.kernel.org>; Sat, 22 Mar 2025 03:01:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qnbsTuO3wM+rIKG65q6tA+xSo4IfOE/hHH/Jylcd7ZY=; b=V3YOo5E4FzWH4/I3
	dcYMFDexS2rhJ0w9f28sdrT5xrHP9j7crvf9K7uLx8XpsEdDG7ttmVBCSw/RJuNO
	5cginZBfL4kkDWpKUUNfD6iAN7OLszzTlK0LugjAS7VJEbt4dD50k1Y3ftE5BBft
	AJRY/2xote52JtMMdh4vxCRBmFibgS7YYSkwnu4BIjRgKTFZg9rrdhLA9H8HVQrb
	YxnE52gElN3hGl1GiFuJTYhZO3b02pLsxp+4/oV/mboN6lp9bufccS55AvT7qdDy
	/2j66gqjYJgPRENqQydt/npWwTjnztHmpAsIwg1jFH2XZ4t25AuN7qYJUdZbrWM7
	D0r7Mg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45hmhk01f2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sat, 22 Mar 2025 03:01:05 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ff52e1c56fso6586337a91.2
        for <linux-pci@vger.kernel.org>; Fri, 21 Mar 2025 20:01:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742612464; x=1743217264;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qnbsTuO3wM+rIKG65q6tA+xSo4IfOE/hHH/Jylcd7ZY=;
        b=pTje0n6q/sTZ+ECL8gfbONOMq8CSmKWjdE2/NqS1s9AF/fq4ofmNixYFG6Z8m/Tc8t
         yWEPzralV0T84v11EjEdlPNR9/95YRquG8URkNd/rijhLiaxfiLKb3hRk7hjlVqFCCEB
         dFC2yA5thtKbmPjZ571Ny//L0BdK0T+QRXyUFGEECEZTQ4dxdDPDH2O7zOJ+sxFB12/Z
         o2RNaxmIvKvsHqOWS++6duOa0+FJO4PKbxtT0qTGjp4SMIblc73n0CYRDKUUW0dQNNac
         WbPNGDW+nI98MIdXVrkycpXjYbvdaJt+NV0iwwP1JwV8dPrI+FTf4bk5Rrwdz6t/pzTY
         xBSQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2tIO8oM3q6qhVwaEaUesRT3LN5EA2ni+vLLYeLLsHwDkfolyCM3hBQv2OIg3GrdVbEgxuHdK7yq4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2mGNz8NnLuzxupq2PqJd3zsNep0oobS8Pylkn+HL6Rh2I/IyQ
	jDXShus8hy7OsmgqV6O9whsySHKPTok66P/vSjtEcttUzutvFeHzux4LZj07JYYbBGOhkGo3XFo
	Otnj8V5TQ0ijHHCVG+gaMXptJUo5fLb2hVU4CpwkmxDky5N1M4vI2Az8Wf7g=
X-Gm-Gg: ASbGncuBSlWA9loxJC9tPuBpuwO196y/YeTDgB0BgoJZAIw0kZLcjInEKQKuJfAcwWa
	L9b6L3bTLQjjhTOffNUk1W62A1Qs8zW+c8+1d50y2TKd/qwbzMjnQo6kTceqm/eFXGaHfWtRmtL
	DlYeeghTRthOm+xnF5lE9AAYmYmDo1adQqEBuMfLUlL/XyTBHB+PJnTOiqP71R3o3a2i2iP6L7C
	gG+Cf3CoSo2Zs1LgeA6SH1CnMRm2NXJSgaRU75Ur0bvngtNFOBGTR408Qc4aFixWJLg8kMSEX0B
	dPp3AwbRtzBa6B5ySjtNVQKMwlL/E4OSFe6AnqCoRbuQwp+JgqE=
X-Received: by 2002:a17:90b:134b:b0:2ea:712d:9a82 with SMTP id 98e67ed59e1d1-3031001d8fcmr8904103a91.29.1742612463774;
        Fri, 21 Mar 2025 20:01:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG90SlEeOzwjAG8/jTpxWL8Qdku9YUbSnYd6BR/NTxrlPlwA20oiADL38sudK5desfQW+oqCg==
X-Received: by 2002:a17:90b:134b:b0:2ea:712d:9a82 with SMTP id 98e67ed59e1d1-3031001d8fcmr8904057a91.29.1742612463252;
        Fri, 21 Mar 2025 20:01:03 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-227811bdca7sm25859945ad.137.2025.03.21.20.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 20:01:02 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Sat, 22 Mar 2025 08:30:44 +0530
Subject: [PATCH 2/3] arm64: qcom: sc7280: Move phy, perst to root port node
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250322-perst-v1-2-e5e4da74a204@oss.qualcomm.com>
References: <20250322-perst-v1-0-e5e4da74a204@oss.qualcomm.com>
In-Reply-To: <20250322-perst-v1-0-e5e4da74a204@oss.qualcomm.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_mrana@quicinc.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742612448; l=2998;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=Mk1edLjeulLTMsWslHQkThKj73LmX8ZgbviMLPagnkI=;
 b=FfuJzofQnA6RaPSugt0Q4M4HToM1ZYgkLq0yF97JcPWlxOf7f4cF22jJfbKML/DxrdBQ+uQ+8
 MUNYHTRqWPxACk98gBHglV38vlOCSGzh61kC0/iulxzxd7glRsCS58k
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Authority-Analysis: v=2.4 cv=C4PpyRP+ c=1 sm=1 tr=0 ts=67de27f1 cx=c_pps a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=bvY3E1ByFFb03tV5gjAA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: yy6KdS57k88gQssbusbVfnv13KGD2pdp
X-Proofpoint-ORIG-GUID: yy6KdS57k88gQssbusbVfnv13KGD2pdp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-22_01,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 priorityscore=1501 impostorscore=0
 bulkscore=0 clxscore=1015 spamscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503220019

Move phy, perst, to root port from the controller node.

Rename perst-gpios to reset-gpios to align with the expected naming
convention of pci-bus-common.yaml.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts   | 5 ++++-
 arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi | 5 ++++-
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi       | 5 ++++-
 arch/arm64/boot/dts/qcom/sc7280.dtsi           | 7 +++----
 4 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
index 7a36c90ad4ec..f54db6345b7a 100644
--- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
+++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
@@ -709,8 +709,11 @@ &mdss_edp_phy {
 	status = "okay";
 };
 
+&pcieport1 {
+	reset-gpios = <&tlmm 2 GPIO_ACTIVE_LOW>;
+};
+
 &pcie1 {
-	perst-gpios = <&tlmm 2 GPIO_ACTIVE_LOW>;
 
 	pinctrl-0 = <&pcie1_reset_n>, <&pcie1_wake_n>;
 	pinctrl-names = "default";
diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
index 2ba4ea60cb14..60b3cf50ea1d 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
@@ -472,10 +472,13 @@ &pcie1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pcie1_clkreq_n>, <&ssd_rst_l>, <&pe_wake_odl>;
 
-	perst-gpios = <&tlmm 2 GPIO_ACTIVE_LOW>;
 	vddpe-3v3-supply = <&pp3300_ssd>;
 };
 
+&pcieport1 {
+	reset-gpios = <&tlmm 2 GPIO_ACTIVE_LOW>;
+};
+
 &pm8350c_pwm {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
index 7370aa0dbf0e..19910670fc3a 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
@@ -414,9 +414,12 @@ &lpass_va_macro {
 	vdd-micb-supply = <&vreg_bob>;
 };
 
+&pcieport1 {
+	reset-gpios = <&tlmm 2 GPIO_ACTIVE_LOW>;
+};
+
 &pcie1 {
 	status = "okay";
-	perst-gpios = <&tlmm 2 GPIO_ACTIVE_LOW>;
 
 	vddpe-3v3-supply = <&nvme_3v3_regulator>;
 
diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 0f2caf36910b..6c21c320a2b5 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -2271,9 +2271,6 @@ pcie1: pcie@1c08000 {
 
 			power-domains = <&gcc GCC_PCIE_1_GDSC>;
 
-			phys = <&pcie1_phy>;
-			phy-names = "pciephy";
-
 			pinctrl-names = "default";
 			pinctrl-0 = <&pcie1_clkreq_n>;
 
@@ -2284,7 +2281,7 @@ pcie1: pcie@1c08000 {
 
 			status = "disabled";
 
-			pcie@0 {
+			pcieport1: pcie@0 {
 				device_type = "pci";
 				reg = <0x0 0x0 0x0 0x0 0x0>;
 				bus-range = <0x01 0xff>;
@@ -2292,6 +2289,8 @@ pcie@0 {
 				#address-cells = <3>;
 				#size-cells = <2>;
 				ranges;
+				phys = <&pcie1_phy>;
+				phy-names = "pciephy";
 			};
 		};
 

-- 
2.34.1


