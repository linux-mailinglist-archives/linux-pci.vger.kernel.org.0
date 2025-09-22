Return-Path: <linux-pci+bounces-36628-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA3E1B8F5C2
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 09:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B71D18912C9
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 07:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D2622A7E5;
	Mon, 22 Sep 2025 07:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dFTiHKBT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA77D2F83C4;
	Mon, 22 Sep 2025 07:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758527734; cv=none; b=aUj2vfzzuK9Ugg9hU0FdbFWQiSNIR/i3GQ/LyJHHkzAYZWcKl5YPinmdCAQOAyv8qxEwNE6jjV0tMqbAgyIZVSPmVd3VJ/9tp/WL0ln7A4rU8IUzMLH3nnFsy2QxMRH94OLSiK+QZBemTTIQw3ZmmTgfmxW485qg83SAuLKwUQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758527734; c=relaxed/simple;
	bh=rvIu5zMEMRE1yE/C181B5+A+0B38zf2ro59WPtC+Y1c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JZ6zgOoFBtNNgHVMeTj1GCeGXv6v3ylTER2kroIABTtCXRbuTooMPtQOtzx7/izqUBrYwpy0lZKDp43u0Geq81SVC6nvaPbTWZ+Xm64qFti+9sGByWCmGDvmvQ9Ez0RhU6Xci+tVQLsOPtm7X7Q3cqhSv0hB+2vWYBlrdeP1ESM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dFTiHKBT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58LLwTMC012252;
	Mon, 22 Sep 2025 07:55:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=kOaHQ2YfFAD
	Ren506vQozlJIqAMpYTtuEoX36Y/rVVw=; b=dFTiHKBT+HdwgoDoV0bdk22HKVN
	bWkNNAoKjdaqmSzW9Dfiqh30/4pwzPY9UUu6jh73dTjNmvEdN2C5OnlnzvLcz7Fr
	Xji2rb5L9o2afEcJ71yHZCeIB9rNOK/65Ow9c9gEyeuvlvMKQU4ybFSwNWZXm3xq
	nAjB6pRY2TOi2PxkAVErqoYbF08XBij+/W4+6Y3K4qP8cDQDw1ydlv/3HtaTobwb
	/S2fxH8Jm2qZym67lemEmwcheWF5yjynU5GcIic0LvtM4Han6LQnB5wAbNYv8dSL
	uV7Dc4/0oJ4ulxDJkeDcurpMMhK4jNADH0hksdWWFumaZMTwqC2wticMJaA==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499mn7buab-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Sep 2025 07:55:19 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 58M7tGXn022235;
	Mon, 22 Sep 2025 07:55:16 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 499nbm0543-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Sep 2025 07:55:16 +0000
Received: from APTAIPPMTA02.qualcomm.com (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 58M7tGse022220;
	Mon, 22 Sep 2025 07:55:16 GMT
Received: from cse-cd02-lnx.ap.qualcomm.com (cse-cd02-lnx.qualcomm.com [10.64.75.246])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 58M7tFbS022212
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Sep 2025 07:55:16 +0000
Received: by cse-cd02-lnx.ap.qualcomm.com (Postfix, from userid 4438065)
	id 89C1FB63; Mon, 22 Sep 2025 15:55:14 +0800 (CST)
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
Subject: [PATCH v1 2/4] arm64: dts: qcom: Add PCIe 5 wwan regulator for HAMOA-IOT-EVK board
Date: Mon, 22 Sep 2025 15:55:07 +0800
Message-Id: <20250922075509.3288419-3-ziyue.zhang@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAzMyBTYWx0ZWRfX65NSD3YExanu
 1PpsfkFLMGGHPYOuvUzsa9fuatxyRf8okpcJBQv9INw7ukgkQaQKw0Xsuz7WxNlqIv8c91EBjrd
 A3j4w5yuJZySS+ZVLAXUrXzjCnneQcdXmss2gcyvVCM9Lm6vN/Q2zvOisKX7TvcCUojKsY86Sp9
 Et0xZn2ceiPQfq+90Ful11gIlJqjhs5iZDHFGt1izNsTue3EqjjqStuL2To0iqtkeVpBbXkGp4m
 wSy7IJ7YDt+IiIg7EXZNSlHDLACdjyNAHUUkxq62UeduaT1VpEg0dJ0EQck5sQc0EmzP4IzTMLR
 WlKoqroEnxs+Gn9Wnb09gc+pj/LcqlnHvyO0V2hsuAWJ1fDOhihDZfv9us3AaO37WdeHI52g1SX
 yuVHbiZl
X-Proofpoint-GUID: JTMsXMio4Xer13sYUSFoSEimkSpzJ7sA
X-Proofpoint-ORIG-GUID: JTMsXMio4Xer13sYUSFoSEimkSpzJ7sA
X-Authority-Analysis: v=2.4 cv=EZrIQOmC c=1 sm=1 tr=0 ts=68d100e7 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=_IkY_lzJfHiZts_ofaAA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_01,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 spamscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509200033

Specify the vddpe-3v3-supply regulator for PCIe5 using &vreg_wwan to
ensure proper power configuration.

Signed-off-by: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts b/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
index df8d6e5c1f45..f0e4abbcc1ac 100644
--- a/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
+++ b/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
@@ -832,6 +832,10 @@ &mdss_dp3_phy {
 	status = "okay";
 };
 
+&pcie5 {
+	vddpe-3v3-supply = <&vreg_wwan>;
+};
+
 &pcie6a {
 	vddpe-3v3-supply = <&vreg_nvme>;
 };
-- 
2.34.1


