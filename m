Return-Path: <linux-pci+bounces-26268-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE566A941CF
	for <lists+linux-pci@lfdr.de>; Sat, 19 Apr 2025 07:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E93168E1BB8
	for <lists+linux-pci@lfdr.de>; Sat, 19 Apr 2025 05:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B722B18B46E;
	Sat, 19 Apr 2025 05:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iUv6Au/h"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1DC189906
	for <linux-pci@vger.kernel.org>; Sat, 19 Apr 2025 05:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745041411; cv=none; b=gt/LD49AdyVnUCcF6Q9cjaP1fn1jQOMI/5VADRAUT2wH2NkavBX7BhNAZOd/3cC9LL1KVJniTcpyI/nxi1ArDVZ9IADR+ADoxFIRY5e/bLM1tijIItHWJC+8DQYSe3xP9y4IMnPD+vT6ABlyy2wMNWS4p7b4Gm2Ib8Pk8Zk0my4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745041411; c=relaxed/simple;
	bh=2UXuX1AMMSWXufAarokzPiIVXoyWp7dxY3qIHpMjNV0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dibXC0ngfFu0B9Pbja8StLgXzd6yQ+ep+fhrFpEKv7Q2rlZSGQD4f3vzIAUjUSZhIgSy6MCIG11QZHwX3aJ2rYUqYWgbQzZLWHmO0qdfCJ7wqjsNLHeT9hVb2cFp4hokal7VjnT2Q1/pef9mqElS2j+dQVel7iINjlMCnz4hbiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iUv6Au/h; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53J4idGJ017131
	for <linux-pci@vger.kernel.org>; Sat, 19 Apr 2025 05:43:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JVIxJwxtqh/xBODLl5IXRK6VBOMqf0w0YODMOA6QzRM=; b=iUv6Au/hp5Ur9SSo
	aZs7mUE3/N/V6mOYu02aAjOo7RCInTIstPJ8zKbelYumyP3kP7Bp7hwftN42drCZ
	k7NsNLYUP8gAh5GZfDT9o3b1xHuiAamMPO0+FTokfweK1GWNWvkb3OgSBDpmcFb+
	q8/yrgRAS01ap45DRR/6T+0M/WFN8GaeotP+WM4DGF1dUPRbHHFvaV8lS7TBSBwk
	ZIjb0fJmZwusujLx23694jVWwNAfHWgNm8MRf89/9YpfSM6rZrrseWYUfclQ5+H+
	2qSILOV1FgSHhhCPGSvA9xVL6Fw2kTdUWnoSwVOZuKJju/K56ntt8nyrWTrF0WP4
	cK77LA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46435j85rq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sat, 19 Apr 2025 05:43:28 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2240a96112fso36435015ad.2
        for <linux-pci@vger.kernel.org>; Fri, 18 Apr 2025 22:43:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745041407; x=1745646207;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JVIxJwxtqh/xBODLl5IXRK6VBOMqf0w0YODMOA6QzRM=;
        b=guWKxBWJeYRBmfHIuEp1UTAPa+okY4irOvORsQzsyOFK32V8h4glNN+e1QV17k+4Gr
         ww6B/2B57dDUkTfedcNOzSYezydqzOHMkYOhhQB2dxjlbULTZ1R/Q9lFywQTp17aWRJV
         Y3eWsq7EPzWM4hUc/x+LIhRL+ADCZtnXLfUsHZUA2lGfwAe68IObjhEkFCRiire3ucSZ
         IZkGa0OXznlfHGK+BFd6K+SC+9Uk5qc7n3lD7rrqfL6tf9SZZbkTb19r0UtaKCEwch/2
         Q6O2t3j+XHpeC8Y22It+N088DmWaWBfBrndhWi0YTdC/lnFDIuL73xSkGfjCk3Kkvizo
         NWnw==
X-Forwarded-Encrypted: i=1; AJvYcCUx3tnX8APrLd4V+UXTLnDl4DzhOFuUF/g1zi3wtfFkN0rmLlFXBuy91toRmnqHg/2bsLCCvYA4RpM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk9K1VflQMNAFuBGWEUlsz6fdfEb7kJnk+dmPMOHLQtq4ABtTo
	yH84USmfy1JhoB2aEZ5sfZOWXYxs0I/IWh2dBpkESo4Y5Yw+YVwxoKpY+A6IQrPSLguXz6+tVyJ
	U1KWUFGamf8lZQNDsRY8V/lWIfFXuvvkdOqZ3AGvh24B/mptvWFnxsI+bggo=
X-Gm-Gg: ASbGncuFL2PccayRH6nm/HVGUPV7XXR0TientzTzqNMbT+0PAOVAO7E3lscPWfrICFk
	pmQXn9niXn+zBG5G0dyuhHGNGflyJKdNyMq1JqHKLQk6Yif4NddDaqEHzjPS/KClNdjXDrY5Whs
	q+FOv2+QanqGqqwJMbFqxfGRR8s5i+lSa+67cCMEao3IY/cyuk+2YZG7IMnyzJEKwImrp3mDWI6
	jKD5Gf7kP5CaBeOAPYtyQEEkUbH/akw7k/RYiy4fqxTDUsuOd2SgRSw+d2+onJXTJa/eT+W+QMl
	QyTEDEu01Uky1IsBl1O43Wrxr8V3TWkj1RRliYj0m1shCmk=
X-Received: by 2002:a17:902:db0f:b0:215:7421:262 with SMTP id d9443c01a7336-22c5357f020mr78333005ad.12.1745041407561;
        Fri, 18 Apr 2025 22:43:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHSsbahsMRfG/4z86xbXbowPG0/DP1oZBDFE0qvKHdxA0AzCGEdY+IPLHyi4u+NrnSKX3G6Q==
X-Received: by 2002:a17:902:db0f:b0:215:7421:262 with SMTP id d9443c01a7336-22c5357f020mr78332775ad.12.1745041407188;
        Fri, 18 Apr 2025 22:43:27 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50eceb37sm26014945ad.179.2025.04.18.22.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 22:43:26 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Sat, 19 Apr 2025 11:13:03 +0530
Subject: [PATCH v2 1/2] arm64: dts: qcom: sc7280: Add wake GPIO
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250419-wake_irq_support-v2-1-06baed9a87a1@oss.qualcomm.com>
References: <20250419-wake_irq_support-v2-0-06baed9a87a1@oss.qualcomm.com>
In-Reply-To: <20250419-wake_irq_support-v2-0-06baed9a87a1@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_mrana@quicinc.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745041398; l=1775;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=2UXuX1AMMSWXufAarokzPiIVXoyWp7dxY3qIHpMjNV0=;
 b=gBL4vztZXZCAn2qIluS5f2KOeeR0s5jscWXDczQOYDel5KYk/jOcN3a0coRdAikCk61Td8IA2
 Mtj5jm/Kc3QD4lhd9EqUizsREyq4rZXVBD9jdMushdibIeTQRHnMDVH
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Authority-Analysis: v=2.4 cv=EOYG00ZC c=1 sm=1 tr=0 ts=68033800 cx=c_pps a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=_k9ig2nQFDp-gxZIyLcA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: v4wel_0vUDqWPUzW8u_anTmqgHfPMetY
X-Proofpoint-ORIG-GUID: v4wel_0vUDqWPUzW8u_anTmqgHfPMetY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-19_02,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=936 mlxscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 spamscore=0 adultscore=0 impostorscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504190043

Add wake gpio which is needed to bring PCIe device state from D3cold to D0.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts   | 1 +
 arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi | 1 +
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi       | 1 +
 3 files changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
index f54db6345b7af6f77bde496d4a07b857bf9d5f6e..ebfe2c5347be02ea730039e61401633fa49479d2 100644
--- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
+++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
@@ -711,6 +711,7 @@ &mdss_edp_phy {
 
 &pcieport1 {
 	reset-gpios = <&tlmm 2 GPIO_ACTIVE_LOW>;
+	wake-gpios = <&tlmm 3 GPIO_ACTIVE_LOW>;
 };
 
 &pcie1 {
diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
index 60b3cf50ea1d61dd5e8b573b5f1c6faa1c291eee..d435db860625d52842bf8e92d6223f67343121db 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
@@ -477,6 +477,7 @@ &pcie1 {
 
 &pcieport1 {
 	reset-gpios = <&tlmm 2 GPIO_ACTIVE_LOW>;
+	wake-gpios = <&tlmm 3 GPIO_ACTIVE_LOW>;
 };
 
 &pm8350c_pwm {
diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
index 19910670fc3a74628e6def6b8faf2fa17991d576..e107ae0d62460d0d0909c7351c17b0b15f99a235 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
@@ -416,6 +416,7 @@ &lpass_va_macro {
 
 &pcieport1 {
 	reset-gpios = <&tlmm 2 GPIO_ACTIVE_LOW>;
+	wake-gpios = <&tlmm 3 GPIO_ACTIVE_LOW>;
 };
 
 &pcie1 {

-- 
2.34.1


