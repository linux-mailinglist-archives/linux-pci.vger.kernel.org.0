Return-Path: <linux-pci+bounces-27309-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7937BAAD3C1
	for <lists+linux-pci@lfdr.de>; Wed,  7 May 2025 05:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D946D466D30
	for <lists+linux-pci@lfdr.de>; Wed,  7 May 2025 03:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A82C1C84C4;
	Wed,  7 May 2025 03:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Gaa0Obuu"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00619198A2F;
	Wed,  7 May 2025 03:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746587441; cv=none; b=QJQyxTtcjyrYo41rHzRuRTUUZ8zwTA3p0LqlMfUPRPaN7rob1ORZqFHJ4p1Rx8LfZ7mEPFTbuEpgJX933fhNtsW4Y90qOrEeneACX9TLLOSdS9f/TyfFPZgTrukQEsP4vlPfkNLFpmb+X3StUCAOeEeXJUB5XqK+L0JnpFcET5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746587441; c=relaxed/simple;
	bh=FJ2KByaAYjEkQMGujq0K6Dmh3OWcZtTDYtzMgBr2Tu0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WJTVu7PqHScD2GibDleVNwqJTGX7t6udcQZ1Vx5UGg68JuoPM+0+HVwpi3K6PeDkXdGUGlmiAKLhbdIitylKcUJJydvo5wiZvbMtT03/RSPe31Y9uK4LwGiShXDNTtBucFErtafHi4aCY9lTSv/02UvLdnOQn/GT782KhYp62vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Gaa0Obuu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5471H2LA021158;
	Wed, 7 May 2025 03:10:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=JqvccdkFw6z
	Ly9lukoo8fOSGsoy9YBHomf6f2cM0rlU=; b=Gaa0ObuuHTr2VZVTTRb2P8Hn9pd
	r1v8MnSRUfCy1qHgQPH6Nht2LR/6wf+CXqmr9GxXcqi73vQwsnnvqtgOyJO+NDOC
	Tg8H4QJYFwONKh3hXPNs2kT0v1HbDs5Slr8ro2mTeYWz+hjDf52l4p1NIzQ1zHpw
	CZq5MqE4Zyu4LW4lizmIB0H4NH1DQ6aNG2j+xnEAhRdtPc++nIeYEV1a23ePoHtX
	nPlrjarwZ36sqsKUG4wQ8sEh7SML356RB488WeNOliavX7BOn/Wu3wikHsyW3RE+
	zjDYJ83lf9vlvMoD6nQh/QHpFA+/AeWsgiu9UjTyKz8NRrgXH74/7IO/80Q==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46d9ep9qsm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 May 2025 03:10:28 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 5473AQjN014725;
	Wed, 7 May 2025 03:10:26 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 46dc7mdwp4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 May 2025 03:10:26 +0000
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5473AQEQ014705;
	Wed, 7 May 2025 03:10:26 GMT
Received: from cse-cd02-lnx.ap.qualcomm.com (cse-cd02-lnx.qualcomm.com [10.64.75.246])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 5473APRD014694
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 May 2025 03:10:26 +0000
Received: by cse-cd02-lnx.ap.qualcomm.com (Postfix, from userid 4438065)
	id 7F6472F3D; Wed,  7 May 2025 11:10:24 +0800 (CST)
From: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
To: vkoul@kernel.org, kishon@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, dmitry.baryshkov@linaro.org,
        neil.armstrong@linaro.org, abel.vesa@linaro.org,
        manivannan.sadhasivam@linaro.org, lpieralisi@kernel.org, kw@linux.com,
        bhelgaas@google.com, andersson@kernel.org, konradybcio@kernel.org
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, quic_qianyu@quicinc.com,
        quic_krichai@quicinc.com, quic_vbadigan@quicinc.com,
        Ziyue Zhang <quic_ziyuzhan@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: [PATCH v5 4/6] arm64: dts: qcom: qcs8300-ride: enable pcie0 interface
Date: Wed,  7 May 2025 11:10:17 +0800
Message-Id: <20250507031019.4080541-5-quic_ziyuzhan@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250507031019.4080541-1-quic_ziyuzhan@quicinc.com>
References: <20250507031019.4080541-1-quic_ziyuzhan@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=EOUG00ZC c=1 sm=1 tr=0 ts=681acf24 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=dt9VzEwgFbYA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=Ukq1jWRXX9In9DvyudYA:9 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: hw6_1St1vxreUZ1TD36bWQEMbvtWiB2Y
X-Proofpoint-GUID: hw6_1St1vxreUZ1TD36bWQEMbvtWiB2Y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA3MDAyNyBTYWx0ZWRfX6QQto7oyq+Z0
 GbZ3P3w+p0lgdE640OIJWY09/1Sbj8uK78NDTHrWzUym8t8B5GbZbw4p+GR1XpMvGfpsdK6+tJd
 3s1AWRvazRN1MsOeO/7R+kFWvSDu96kL+73SL3TVBenOrrGUf8s/3nzoMHnh1fRZ795aYoGrhBW
 dJvY31D4z1VySK7mzKxnkbT+hvt/JzEhS+Gr0IUyzs8Hc6x9cp3+OBWE3gbkuluPI1WUjxm0/rI
 BNAxOo0z6/BXYJI7tnVTTEgs1Jqt6QOry+8xHEsTC+EZv4BuFex6DLE7gmt0w6DX435zIuGBbUs
 dNnSl21OkEVsMH78BVEUs09lColYxh/jedmN1a1VxCJXrv9caM/HicJxaAxHemi3uqL3nVlAIng
 p84Ibr9J0YdO/b9Q4/DOzXOjcJQVyMXUF2++tKoc9MtC4QUITGCvdc7WjcGmBdHVx8y2P3Y4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-07_01,2025-05-06_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1011 impostorscore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 suspectscore=0 mlxlogscore=960 mlxscore=0
 priorityscore=1501 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2505070027

Add configurations in devicetree for PCIe0, board related gpios,
PMIC regulators, etc for qcs8300-ride board.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
---
 arch/arm64/boot/dts/qcom/qcs8300-ride.dts | 40 +++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs8300-ride.dts b/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
index b5c9f89b3435..c3fe3b98b1b6 100644
--- a/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
+++ b/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
@@ -285,6 +285,23 @@ queue3 {
 	};
 };
 
+&pcie0 {
+	perst-gpios = <&tlmm 2 GPIO_ACTIVE_LOW>;
+	wake-gpios = <&tlmm 0 GPIO_ACTIVE_HIGH>;
+
+	pinctrl-0 = <&pcie0_default_state>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+
+&pcie0_phy {
+	vdda-phy-supply = <&vreg_l6a>;
+	vdda-pll-supply = <&vreg_l5a>;
+
+	status = "okay";
+};
+
 &qupv3_id_0 {
 	status = "okay";
 };
@@ -310,6 +327,29 @@ &serdes0 {
 };
 
 &tlmm {
+	pcie0_default_state: pcie0-default-state {
+		wake-pins {
+			pins = "gpio0";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+
+		clkreq-pins {
+			pins = "gpio1";
+			function = "pcie0_clkreq";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+
+		perst-pins {
+			pins = "gpio2";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-pull-down;
+		};
+	};
+
 	ethernet0_default: ethernet0-default-state {
 		ethernet0_mdc: ethernet0-mdc-pins {
 			pins = "gpio5";
-- 
2.34.1


