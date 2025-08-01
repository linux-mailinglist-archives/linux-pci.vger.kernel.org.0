Return-Path: <linux-pci+bounces-33283-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B74D3B18085
	for <lists+linux-pci@lfdr.de>; Fri,  1 Aug 2025 13:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13AF41AA6DC5
	for <lists+linux-pci@lfdr.de>; Fri,  1 Aug 2025 11:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE4A233D64;
	Fri,  1 Aug 2025 11:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XRwbF60t"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C10223C8A8
	for <linux-pci@vger.kernel.org>; Fri,  1 Aug 2025 10:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754046000; cv=none; b=EkqjykPFqnDFu9t8dOdogMPra69jkN0gYGDhlVTbabhjTWMkgdtWbpRLiD6sWYAagI1BvemISkniMO8ChJ03EsFTjnbU2SoxOksxZqRhBCkkyJcen8tRQRMx0fefSLBVCvOgPaiymZpPW/ksXp00RBbdAobibSRIfM6+jyGYi9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754046000; c=relaxed/simple;
	bh=kqM2UJNmrb/fSX3UCt1h9vdMR3u3jBs70+i33jP23cQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tfnsRrwWU6Q/C64aTbLjbE4y8UprL88IzLYRZCkoS1YlgFAcOk9qU/DsmYE5tVWizAPKmTEFNQiQuI6fyM3zMKJPFqN1GdvSpejWdaymAfOiVMAKkqTw+FLh4LXK0Dk+drZkViqaCWGMuiEX9+0dBAqTHtnqsJK8jwVAsDo8Nxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XRwbF60t; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5718l7iv018752
	for <linux-pci@vger.kernel.org>; Fri, 1 Aug 2025 10:59:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NIoKaKcPZtwiX+swSioauTE3Fw73UI3bAxPdIEpZvFE=; b=XRwbF60tEBBk6ODt
	VYiH1ChqtyG264CqL7vPESmbgaFhBU4exj1yajxG8x+O4whdfZGpXqBpgSddf8eq
	d9b+Uxs2CzRKwDoWCseydZIQ2wjfVtHgO+eXJ/J2VRs3W18owUH/mlRuInddgnoS
	Z5oE+gJookLeITm1zbhcXa6g2ZakGNGiz3K48xM28ZF8TNExZzwmDhKQvs+RVDfH
	1/JlPGicDzA5gBvmuOI9+OEzU452wpuZZXZyAdV57ilFP+T+D7yhZoCi63Go4BvF
	3qmhdvhb54GCNAAqIzKp6Sjj/KHDUmNqrwEBSdLZhUcZXl4G0M0wzR7Mho2a31p1
	C5mjIQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 487jwgg4ca-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 01 Aug 2025 10:59:58 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2403e4c82ddso12752155ad.1
        for <linux-pci@vger.kernel.org>; Fri, 01 Aug 2025 03:59:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754045997; x=1754650797;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NIoKaKcPZtwiX+swSioauTE3Fw73UI3bAxPdIEpZvFE=;
        b=Hk9iGuMLdwuX/MN+zAjr8dO5u8GQ/mijNs+N4C8yBt/EGBXRgSkbDuGARRgDFWD6KL
         aYsMAsvUTS2XbXBEwJihfbjq1DvwvsH8eKk5prlc8igNHh3GPMsFwpf7AGAPw2rsZu77
         w8BpVAJnIZu/YMNxis3G4dA441pLZ1duyY2JvaZF3rnLFPNOoXv1xuK6gTfzzO2hqSwE
         roxxJW2+1ezzGi9O99flw4LokzAFkIp5eAa8f+AAB7pR/FeS1QKqY9C019JkhH3XVAtz
         xB3r3lq5ccuVTLaqsRExL8nXQwcp4idBvQBbgwFxpa8Ms50TWIrs4aYq3Ydi7HSXj+lC
         9WqA==
X-Forwarded-Encrypted: i=1; AJvYcCVxuDawbbf0skhrTPlWD07BTjSa/4hBGVk7r04XSQZ3rqtW6IIopclkEgzaH7pspr8A3xVHo4puFVI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxW7fEfP/Jgjs8eqeDOUyO6ahxJHwsgyy8EeXwTOXLMR2I2Ufzf
	wp5wx475l/5P4xQTpJdlgMzrR0yhT7qibQzAxEZi/Wn9CDMxhH8YeVt7lgMrkwzT82Bqh2wwkXB
	+qQlbhdzrVwT+VL+83Va/hvmsVX+qRadhaWG7GGeOSdTQopyit57X0sEiKaiQbLU=
X-Gm-Gg: ASbGncvGV8I2bucqZn+cSTOgfyyjMJK4/R8b1QFSeXuUjpEJNvIEkhD/HNHr6/XyxjB
	DHCcCBhILux02KWwzJGpc5wtrn3vgbQBJRWFkiZXhGOdohZouCjZC/tMs8ytWsuszEbtGiBeaYA
	BRUtuMZq+zL00nGvLuKAFjelmPzAMaB300v40b8qxH3O0pbeR7B46ajKgThy6y73GUX6NBeTAUj
	nfW8Kgq++LdhdU1/DZ0rtFMNUyAUL4X9mczkJ8hFZEfizxxLcsnxCgPUmW7nlrrQjMpBd8S9KU3
	AuzNxowxxs+qGPVQvrN/Zzzzkb/TIZ14nrphEDbx57RJRG6whjeC3VpByhrBbvFFUnKy5+3wHhg
	=
X-Received: by 2002:a17:902:cecb:b0:235:1171:6d1d with SMTP id d9443c01a7336-2422a3397a5mr34208805ad.9.1754045997445;
        Fri, 01 Aug 2025 03:59:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEn3uuJ6/npS5s/+514G69an++VV+1tUUwFkBrCXT2If4SlR2wwHXkuuU7hgP3fLjupXOMCA==
X-Received: by 2002:a17:902:cecb:b0:235:1171:6d1d with SMTP id d9443c01a7336-2422a3397a5mr34208495ad.9.1754045997016;
        Fri, 01 Aug 2025 03:59:57 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f63f0b4aesm7154395a91.26.2025.08.01.03.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 03:59:56 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Fri, 01 Aug 2025 16:29:42 +0530
Subject: [PATCH v4 1/3] arm64: dts: qcom: sc7280: Add wake GPIO
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250801-wake_irq_support-v4-1-6b6639013a1a@oss.qualcomm.com>
References: <20250801-wake_irq_support-v4-0-6b6639013a1a@oss.qualcomm.com>
In-Reply-To: <20250801-wake_irq_support-v4-0-6b6639013a1a@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Danilo Krummrich <dakr@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_mrana@quicinc.com, sherry.sun@nxp.com,
        linux-pm@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754045985; l=1912;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=kqM2UJNmrb/fSX3UCt1h9vdMR3u3jBs70+i33jP23cQ=;
 b=M/s/K0jsjJjsKJfhnhbfBRl5qzZ/9wMgwvbqgXKoHbhCG9heH2HYi43dpvsIGG/PbDoEsSmGz
 iaqUUYq392wDy1UfbMk184tHI//wD72iirhQvuhJcS6+bSjnd672QD3
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Authority-Analysis: v=2.4 cv=WvgrMcfv c=1 sm=1 tr=0 ts=688c9e2e cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=3vADZrDGUz89oz24Pk8A:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: Eu9kvh-vNN2K5eYzhtLOpAWfE8sI9EjU
X-Proofpoint-GUID: Eu9kvh-vNN2K5eYzhtLOpAWfE8sI9EjU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDA3OSBTYWx0ZWRfX4hBcqTBqN7z1
 2Y907k6DLU2ubVea4oJ4Aa04uMC5DxCYMmgVVPHRaykQtciIYRtZcjutQ/v9A2ePWtEANuEFKoI
 KGsF6tvjXrvpG+KHrISQdGLKW64CCDgRcqcloE0RykUh2KdB1X03QtWYpYl1uPpIH0X8gtsX+tY
 secSmFHdh8gsum6wZhT4BbId6rW230urykeQ9mhm9pHXA2izzkybZ0FF6mDJtDLPHtffFfzzajB
 km64dtEDbTml2rgeZUMuGOD66Y9n9C79tXhRYxxFS3FizIayKjjF+R+HIk1NaI8JHqfiHRvL7HO
 ZO31s/wytIzuiEc2xWYxaLwJYNyQFBakEaw8zRmNbF9Z2CorxghC5ruQDw4+ULOy/LigCr1W6Ex
 GdA17n1NesG0fX0gGMtdlccaLRthZ05p3rFizFmhs8WSXEB2InhQZ9Etih1LSzzDpNR8CxQQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_03,2025-07-31_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 spamscore=0 mlxscore=0 impostorscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=929 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2508010079

Add WAKE# gpio which is needed to bring PCIe device state
from D3cold to D0.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts   | 1 +
 arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi | 1 +
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi       | 1 +
 3 files changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
index 10c152ac03c874df5f1dc386d9079d3db1c55362..a4d85772f86955ad061433b138581fa9d81110a4 100644
--- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
+++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
@@ -810,6 +810,7 @@ &mdss_edp_phy {
 
 &pcieport1 {
 	reset-gpios = <&tlmm 2 GPIO_ACTIVE_LOW>;
+	wake-gpios = <&tlmm 3 GPIO_ACTIVE_HIGH>;
 };
 
 &pcie1 {
diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
index 60b3cf50ea1d61dd5e8b573b5f1c6faa1c291eee..5e73060771329cade097bf1a71056a456a7937d7 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
@@ -477,6 +477,7 @@ &pcie1 {
 
 &pcieport1 {
 	reset-gpios = <&tlmm 2 GPIO_ACTIVE_LOW>;
+	wake-gpios = <&tlmm 3 GPIO_ACTIVE_HIGH>;
 };
 
 &pm8350c_pwm {
diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
index 0b0212b670797a364d7f0e7a458fc73245fff8db..240513774612fb2bfcdb951e5a5a77c49f49eb82 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
@@ -418,6 +418,7 @@ &lpass_va_macro {
 
 &pcieport1 {
 	reset-gpios = <&tlmm 2 GPIO_ACTIVE_LOW>;
+	wake-gpios = <&tlmm 3 GPIO_ACTIVE_HIGH>;
 };
 
 &pcie1 {

-- 
2.34.1


