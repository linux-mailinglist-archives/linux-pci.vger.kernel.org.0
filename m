Return-Path: <linux-pci+bounces-31344-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16562AF6F6C
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 11:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 354051C81CFA
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 09:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B1F2E0407;
	Thu,  3 Jul 2025 09:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="m6uaYoDE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B752E03E5;
	Thu,  3 Jul 2025 09:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751536609; cv=none; b=p5gCAI2EXAkLsoFffb7fGipKdXyEThJEgm+hQjfYsVAbVGrML5UCMFL9ojnNo9UYKE4XhSFxwmh5PfZZwbMUa98zY1FzJEJbQiI38Zkd4b+CSOVTLf7FF3O37RLEtc4rhJCRbbmC2AgF2iWiY/s4wpCOFrOuk7QaNTavN3e7Wqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751536609; c=relaxed/simple;
	bh=XK9k3Mh6uQMbWe9PXpjQuuqE3KxexxUEdn6IH4a+Wug=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JHK4BOjPnw0oqMpyBvy/lTj+49WnPVglNIcTtc6shQSheT6Hhk+cDAU7ZXRqIuAHd63Qxiq6G4i4dGLJG4viZ5f5QF38+LIP81uytyQfKLiE9Yia/ko6Efy15377hfia/FfuCCkrpSLD19mPNw2/EIWilYdfbLXVzZTgefFilE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=m6uaYoDE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5636XxaE022911;
	Thu, 3 Jul 2025 09:56:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=sq85Q/vJxoA
	eidtGD92wyNYWRLccThyg6rGim2z8SQw=; b=m6uaYoDElUbSkLwgqCDbOQ4uH+n
	qyuDKN/mMwOJfFMaHdnyM/z+MnEx+g+AsHVYvtiqT33vsT2FSqYSVkkA93qNNYx9
	ckafopZCtxVXqG7qW8LhAC55kyAocRCrcCTcm9FR1FHvTYAyRkDAs3Z0tOv6qjOc
	YSOgwwYNL7LWyxyjYRpclQ3CiuGjhYO43ERmo8j5lVlRYG3Mc6zCrrGGnYoxx8qp
	T7UD3Ko1naW/hz/aeJ5YmDE8NgeTIRYz7sRKxbS5GputD+pl7hVeZuRdC+ac3TRs
	8aR+WpZ9j+Q2RWDPYE208430I0ThYeq6PhG/yND9JM2DC/PBtjSF4cAP/dw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47mhxn6kak-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Jul 2025 09:56:37 +0000 (GMT)
Received: from pps.filterd (NALASPPMTA02.qualcomm.com [127.0.0.1])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 5639tBho016579;
	Thu, 3 Jul 2025 09:56:36 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by NALASPPMTA02.qualcomm.com (PPS) with ESMTPS id 47nesbvtkn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Jul 2025 09:56:36 +0000
Received: from NALASPPMTA02.qualcomm.com (NALASPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5639r4Ht013611;
	Thu, 3 Jul 2025 09:56:35 GMT
Received: from hu-devc-lv-u22-a.qualcomm.com (hu-ziyuzhan-lv.qualcomm.com [10.81.25.41])
	by NALASPPMTA02.qualcomm.com (PPS) with ESMTPS id 5639uZQ1018799
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Jul 2025 09:56:35 +0000
Received: by hu-devc-lv-u22-a.qualcomm.com (Postfix, from userid 4438065)
	id 8D43C5AA; Thu,  3 Jul 2025 02:56:35 -0700 (PDT)
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
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
Subject: [PATCH v8 3/3] arm64: dts: qcom: qcs615-ride: Enable PCIe interface
Date: Thu,  3 Jul 2025 02:56:30 -0700
Message-Id: <20250703095630.669044-4-ziyue.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250703095630.669044-1-ziyue.zhang@oss.qualcomm.com>
References: <20250703095630.669044-1-ziyue.zhang@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAzMDA4MSBTYWx0ZWRfX9a9IBzlRrgY0
 sFHNek2HyHhivGDERDdrMwO79nwjcmmEevPPSmyxZ6DOc7/pRZZLS+GgBX3xHcRLZPQ4TdayqNn
 vi7IqoBtKkFAIjvL6YaFjJR7SohAnz1q4ac7y/sNUBP53aNuBEPFlLCOY2M1mlb1NRHQN/Mtk85
 rHYIAlfRuI5sQS/ypZhWEHtdrrTC+7Dcd+EaQnvfrY2TLsE/c9g3MeS+0oTna6GyDKhAuXv45hI
 d464RsMsEJEyVTxXkbEamlwkYlkFje/q10g0QKAyOgcPQkW7YIeamE6B5j4vJATl8LvKASpJrzy
 eFObVCr/dyfUc3m4fbcWnqkNDEcCwQelGbyYExIo5etNqdJ5V4Cg3W7THDuAgpvXKb+tXR1kDvC
 ksi8hvMoJCV3YoveFDXbiXU2dM1+kn80KM3ZrKlTQwEI229nYmS0usaiomLisz+qKbGxUkxP
X-Authority-Analysis: v=2.4 cv=EbvIQOmC c=1 sm=1 tr=0 ts=686653d5 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=3zbVK_edIv7hY8gRkFcA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: EA_R8Qrk8PB_dNvKX-a0pOaE6HKl8kP2
X-Proofpoint-GUID: EA_R8Qrk8PB_dNvKX-a0pOaE6HKl8kP2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-03_03,2025-07-02_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 mlxscore=0 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0
 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 spamscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507030081

From: Krishna chaitanya chundru <quic_krichai@quicinc.com>

Add platform configurations in devicetree for PCIe, board related
gpios, PMIC regulators, etc.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Signed-off-by: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
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


