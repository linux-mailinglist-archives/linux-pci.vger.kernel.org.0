Return-Path: <linux-pci+bounces-21047-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 065C0A2E561
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 08:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F675188A7BF
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 07:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C1F22097;
	Mon, 10 Feb 2025 07:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZoweThxE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89653433BE
	for <linux-pci@vger.kernel.org>; Mon, 10 Feb 2025 07:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739172626; cv=none; b=SbP7W02Z5NSqWRasS0D721yHU35WOf0syMYeA205JNT9tBAtq0Em/mIbpICPBURsrMqJwOyevYR6k8DA3hWOBjhNM9TA/bhd+rqUPTaH1tuqnitXiPWnYyNwDi+nI2Ab57R0uAyk10gBHiDOfVlS5aULPdLM1EXMi0iHREAxA6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739172626; c=relaxed/simple;
	bh=gMfLPv9UUnIIr3ePCONcx6NmkEgm/zgCqiGlQYseZ88=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r0GYbysERS8lFnqeO0HiEz629de1Y4U4odUu5eN2eEWQh2uqK7dYMlaehoeTmcP0X0M23kPxeYkwkguaoZhGdcvz1GqtfDmRg4KwuO1dwTT3Lvjag5XG6YqjhvtTC3OT8B9xxku9znytJUCLKfGrPvQZdHa1zt9YhKbD1xzGPkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZoweThxE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51A2Lsxm011113
	for <linux-pci@vger.kernel.org>; Mon, 10 Feb 2025 07:30:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BJmMNfxRFNQoAHOf8dBIWpMupTDw8D14/mVeDwq2G8I=; b=ZoweThxEqPL75PU5
	9NY0JRMd4N5tfowzfko2aY9FnKxIjYpi0DxvI++rCuylxVPgyz+99wyOLgiCwPSK
	cS87l2Gk0Wuq8rt3HE9yJooWLWEsSMjGA51FtLB2BxWFs/12jKNLOjwyLeHeN5Of
	UQDE7pCV5S8owKqnum90hRxWcAFvM+bn4E9a5PZD53GWVO5vJAcpYNJosPivkUPe
	twcZb/n7S31YAFrYt/eJzn3cyZ0uiblcr9qq8ZLsITya2FGBBOLK4E+RP2Ka+2sB
	0xq/o9OAYNnY0VRx0mHhBnwQYyWfJtloDRY0doBhfbzGSWnvPqM/cy6hnkAhINYt
	p6dkHA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44q8ky8k6y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 10 Feb 2025 07:30:23 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2fa480350a5so3058824a91.3
        for <linux-pci@vger.kernel.org>; Sun, 09 Feb 2025 23:30:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739172623; x=1739777423;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BJmMNfxRFNQoAHOf8dBIWpMupTDw8D14/mVeDwq2G8I=;
        b=bu05WDKDyqqkJLHAHgzkMvThB4khtDQeLlH8i98JCkjUJBO7rRHdarcsnXQNn9gtm1
         VMpHAAVPPoEwL+7LvMVwHYjicqata87oUqaonHkJ3n5nfLKI2vQy65jzA6ci8D7BOS7/
         WelsMjd8HbRuGwSaVUa8achMX9TbeYNBtrWAXigNo5EKzzEtpCOVGdrV8t3TwHdpUHvG
         g4XLqOkP6ZCTM23hPDujHncPk2AJdWw2LjPnAlIEIwDybc69ko1zzwmwaH99pTZXqfAr
         LxFnMc+6erFUtwsDX0JmnZUixFqdqlpBk9tasgcxFh9IZrBKPT6z+Ibq5YRYTlFwkeZF
         9D8A==
X-Forwarded-Encrypted: i=1; AJvYcCVG+MYyEJRbw4J2Ji+RAuxGz3V/37P5/pSndccNb+IfQEwKAy5ETkFUavrwArwNuyIm/QSm0s/hwOU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1dYXa9dzcqnxn29m9PSaGQnqgoccymm8wg0tbbGhu2BG+/rQZ
	fXDg9Xtho7hmQw4YBhnb/WiOT7roH+UcKkjLlVw2BifZroYCGfJLsusXZG33QCeARXz4d6coDJw
	xqWr2MXraCZ2FhWfBqxDTGnLFJtk5wxw/5LMifEmvKY5WoGBuDCgoIXvscIM=
X-Gm-Gg: ASbGncvSh7nBkUlq5GGomuygjCOadnjhwGfWpV4SuhpqwrDSC7zDmYc6Nbl3SkJM7bO
	Qag+w7hMPNJYHWC7A3ycwvVQc44zFlG2+pm+Fe14LTTanBP2LNDXGFIOMS3wGj5yJdiSXBddJij
	PvrVF7szrRbVEaR3AP5UplSxTf0lRybDEEgYmm0YS7DsMZBk0HZj/j0YAIsyagU4XU09G1RsUvD
	V5gvPuwbkwb80aJRQzI+NksvT9Yay+9VAxXFBzGJoc1j6Jz3G8Orm1rxPbPFB3gQ5uaTSqMhA+Q
	tzyDspwkzZHDCAKbudrowHw77jmGg/DXDBgdiVcQ
X-Received: by 2002:a17:90a:f94e:b0:2f2:a664:df19 with SMTP id 98e67ed59e1d1-2fa23f436d6mr20237502a91.7.1739172622559;
        Sun, 09 Feb 2025 23:30:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHhS63tBINw5qq8xbtvKGNc9R5wmcpR9u/pn2/Pg/C4zsy3eLmGArmBCeuoVXU5ZpUJxHLshA==
X-Received: by 2002:a17:90a:f94e:b0:2f2:a664:df19 with SMTP id 98e67ed59e1d1-2fa23f436d6mr20237461a91.7.1739172622184;
        Sun, 09 Feb 2025 23:30:22 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fa09a6fe28sm7918507a91.26.2025.02.09.23.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2025 23:30:21 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Mon, 10 Feb 2025 13:00:00 +0530
Subject: [PATCH v6 1/4] arm64: dts: qcom: x1e80100: Add PCIe lane
 equalization preset properties
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250210-preset_v6-v6-1-cbd837d0028d@oss.qualcomm.com>
References: <20250210-preset_v6-v6-0-cbd837d0028d@oss.qualcomm.com>
In-Reply-To: <20250210-preset_v6-v6-0-cbd837d0028d@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        quic_mrana@quicinc.com, quic_vbadigan@quicinc.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739172612; l=1811;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=gMfLPv9UUnIIr3ePCONcx6NmkEgm/zgCqiGlQYseZ88=;
 b=5BiNxVQWdPVGWgiP8dsIzGFr3CmnOisZPiF9dT5F+KUJfHqe1FNdshFpEA0uUcg1yT/Vufs6y
 NmQQ9g3z8N/AoEEbBJ7yd+CaIPGFCzuhNXI+KvR4kS2Z9HpiJ6Q3GH5
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: RnSs5r3o8vqhqT3o24w6V2hGHfaghIED
X-Proofpoint-ORIG-GUID: RnSs5r3o8vqhqT3o24w6V2hGHfaghIED
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-10_04,2025-02-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 mlxlogscore=957 spamscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502100062

Add PCIe lane equalization preset properties for 8 GT/s and 16 GT/s data
rates used in lane equalization procedure.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
This patch depends on the this dt binding pull request which got recently
merged: https://github.com/devicetree-org/dt-schema/pull/146
---
---
 arch/arm64/boot/dts/qcom/x1e80100.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
index 4936fa5b98ff..1b815d4eed5c 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
@@ -3209,6 +3209,11 @@ &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
 			phys = <&pcie3_phy>;
 			phy-names = "pciephy";
 
+			eq-presets-8gts = /bits/ 16 <0x5555 0x5555 0x5555 0x5555>,
+					  /bits/ 16 <0x5555 0x5555 0x5555 0x5555>;
+
+			eq-presets-16gts = /bits/ 8 <0x55 0x55 0x55 0x55 0x55 0x55 0x55 0x55>;
+
 			operating-points-v2 = <&pcie3_opp_table>;
 
 			status = "disabled";
@@ -3411,6 +3416,10 @@ &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
 			phys = <&pcie6a_phy>;
 			phy-names = "pciephy";
 
+			eq-presets-8gts = /bits/ 16 <0x5555 0x5555 0x5555 0x5555>;
+
+			eq-presets-16gts = /bits/ 8 <0x55 0x55 0x55 0x55>;
+
 			status = "disabled";
 		};
 
@@ -3538,6 +3547,8 @@ &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
 			phys = <&pcie5_phy>;
 			phy-names = "pciephy";
 
+			eq-presets-8gts = /bits/ 16 <0x5555 0x5555>;
+
 			status = "disabled";
 		};
 
@@ -3662,6 +3673,8 @@ &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
 			phys = <&pcie4_phy>;
 			phy-names = "pciephy";
 
+			eq-presets-8gts = /bits/ 16 <0x5555 0x5555>;
+
 			status = "disabled";
 
 			pcie4_port0: pcie@0 {

-- 
2.34.1


