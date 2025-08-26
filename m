Return-Path: <linux-pci+bounces-34736-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D007AB35850
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 11:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD7167B5461
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 09:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F55830AAC2;
	Tue, 26 Aug 2025 09:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OJzfI2ak"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9BB3009CD;
	Tue, 26 Aug 2025 09:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756199549; cv=none; b=HP/jMAp9juXILI3VvBptuApnMhrkcJKSMD5Y1GbCiw0QYdqQWncX/3atIfOZvRYPx0yZKT5jRr7rziHQeNWzoi5c/x/kro5OFvcZGUFQpr6ResitUhw1yphFGDMdz/nyn+kqr78LPR8shqrj/KJFgEHwOofkIjY7OahLu7sGUoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756199549; c=relaxed/simple;
	bh=URV8aagyNXhcV74duf3+Gb4YOl16inU4YZ6GRjaBTPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g2R7eP7zzfi6wvbXEo7iraunIBC+RmHKiFlX/9gmlLKf1uy/BfbLyc7dh9CMyA4j6Rz27etF+SBaz0IdaKfUEziAZcQbv74pH6ADeFkPB7YB/Q0bwWtLiT/yttFn1F7eaaMpaQlr14GUzlPSLLCjC0OPJyblDGdn/2ml2Ow5kZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OJzfI2ak; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57Q4lvoF007038;
	Tue, 26 Aug 2025 09:12:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=FjFWcJ+slIN
	PLLLGM2/NXcjtvFX1V8uxVOqcuDTk8ZM=; b=OJzfI2ak2ovR47MTMgmzLDnc5hy
	6cLmjBPJmZfTqX0R4kkfLhhPZnI9eqFdgbL90Z6ugZsWg9yVE2hgJV/MoJbu01Rv
	ZoelEhLjwFDLS2Wq3tmwNa8cVZFPRLQv8reTLu/hc8qgQMy3vslkdkqcZwHEwvEh
	pEG8Up8YnPDIegL4pCq72mP5hVXAIm+OzrU4nuCETGQqhqElMTsHocZcJqB2d8iQ
	d3oTjnG43utByhgYNWgPds6iJWixy0HzFdfUxUPrmsV94cuah9rnFv3aOq5JJaYM
	DW3+ljJCEOogPIrp5NcQ5EEuelQqOZNmhTz2JbgTN/H+bYWlGxTIX+Itixg==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5um8a65-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Aug 2025 09:12:15 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 57Q9CDGw003427;
	Tue, 26 Aug 2025 09:12:13 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 48q6qksr6c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Aug 2025 09:12:13 +0000
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 57Q99QTW031990;
	Tue, 26 Aug 2025 09:12:13 GMT
Received: from ziyuzhan-gv.ap.qualcomm.com (ziyuzhan-gv.qualcomm.com [10.64.66.102])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 57Q9CCj2003413
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Aug 2025 09:12:13 +0000
Received: by ziyuzhan-gv.ap.qualcomm.com (Postfix, from userid 4438065)
	id A0F0D528; Tue, 26 Aug 2025 17:12:09 +0800 (CST)
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
        Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: [PATCH v11 5/5] arm64: dts: qcom: qcs8300-ride: enable pcie1 interface
Date: Tue, 26 Aug 2025 17:12:05 +0800
Message-ID: <20250826091205.3625138-6-ziyue.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250826091205.3625138-1-ziyue.zhang@oss.qualcomm.com>
References: <20250826091205.3625138-1-ziyue.zhang@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=VtIjA/2n c=1 sm=1 tr=0 ts=68ad7a6f cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=niF0sU1HcdIRAeZIowcA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMiBTYWx0ZWRfX9B/w1eKMbiOj
 wXcjrz38fZg5/3Dvu5ABn4EWi5S7R89GADbh/IZ4+7+wo+2OVrZO5cLrtDiKUovq20FRtcXndVZ
 e7JHzZICUVCdzHaIm51NryLUrKycC7O05i/+a0QAp6ZZNk3IwitNNryU7WAojkDtFHFlFCkIfJb
 F/7LgJprsbyKp818EJEBds1zS1xP2WFMrL17GM5wr+t1QgjufUlvYeRLoyj50UyHVEdxCXYJwHy
 Q8+NTxfzDid/+o9++GxUR5C+0Uu/SoV6ngsS3SsE77hgib+GqpOhlQ8qmmwj9AKR+Nhcfbclcnn
 iSsVdFe/43GGQrpUBaOdkWGNxe0QoP6qE8U559jU6nGktG1flw6z5LcUVqzruT8UvOdrc79LtzO
 y7xH0XSU
X-Proofpoint-GUID: 0G6wq43y0V2nbF-HnCVw_zN2tb8K4oO1
X-Proofpoint-ORIG-GUID: 0G6wq43y0V2nbF-HnCVw_zN2tb8K4oO1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 adultscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508230032

Add configurations in devicetree for PCIe1, board related gpios,
PMIC regulators, etc for qcs8300-ride platform.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/qcs8300-ride.dts | 42 +++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs8300-ride.dts b/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
index 9d2653007866..51f299fff910 100644
--- a/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
+++ b/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
@@ -328,6 +328,25 @@ &pcie0_phy {
 	status = "okay";
 };
 
+&pcie1 {
+	pinctrl-0 = <&pcie1_default_state>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+
+&pcieport1 {
+	reset-gpios = <&tlmm 23 GPIO_ACTIVE_LOW>;
+	wake-gpios = <&tlmm 21 GPIO_ACTIVE_HIGH>;
+};
+
+&pcie1_phy {
+	vdda-phy-supply = <&vreg_l6a>;
+	vdda-pll-supply = <&vreg_l5a>;
+
+	status = "okay";
+};
+
 &qupv3_id_0 {
 	status = "okay";
 };
@@ -411,6 +430,29 @@ perst-pins {
 			bias-pull-down;
 		};
 	};
+
+   pcie1_default_state: pcie1-default-state {
+		wake-pins {
+			pins = "gpio21";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+
+		clkreq-pins {
+			pins = "gpio22";
+			function = "pcie1_clkreq";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+
+		perst-pins {
+			pins = "gpio23";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-pull-down;
+		};
+	};
 };
 
 &uart7 {
-- 
2.43.0


