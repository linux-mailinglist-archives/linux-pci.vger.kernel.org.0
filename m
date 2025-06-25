Return-Path: <linux-pci+bounces-30598-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8D0AE7D6A
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 11:39:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 861075A1A1B
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 09:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB632BEC2B;
	Wed, 25 Jun 2025 09:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QG3FDG6/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12EEA29B232;
	Wed, 25 Jun 2025 09:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750843562; cv=none; b=seikPwRFIank/JqfSvgvyJDEzHJFesqRClfy0umwqCq6FxeG3dp7y6+iUzu3NCUPqS85XHnLH8gr+BnCMIDGXUWOr+cosC9gd20xcfN4sEdpYk+T7P/VMlTx/GD8o2fpn1wk6SBopa2mlZvVcwx1ZATTa478bz2aZYbxmCxyiUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750843562; c=relaxed/simple;
	bh=DMxABzn9Q/LNeWIKjL84Poq2r4gHFJAc56xCHlCoZZM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h9addAA7MumYXbeZILnPDA68Cuj4j0Vdbcfni9siB3DhFbZa5Xe4nBE69McX9DaheqcbYs0n0G7Mgy2HXgF5qzBQ/kBd+lw2dywrF2eladwLuPADsa5vyPMeXW78JAhe2dqzDcc9nsKWvNBrKb1zZmRHs4U9OnCOWMXhBAPUr20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QG3FDG6/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55P20Som032291;
	Wed, 25 Jun 2025 09:25:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=tcdcCjhN1kQ
	qkrSRaE028Kk2TL8h/mHB4la3MB9/22o=; b=QG3FDG6/CFSon8Vvx4UzaQWqmzS
	/wtWeMDYgnMl+NfsvjhaDjzaGUR5C62QT2Zspy8pEqUu5gXH+R/nxYP5ZFDO9fmb
	st2qZFZHiUamifmZs+5aiedZBxlldkI1AQQohnEbl2wPOoEFjobmwHJuqYgD4Mjr
	IP5reR19w6b5QrRMbco0Wo0t5W9Bo+2SKeFFRGI5zShmoT6RukhZC/6V5m2qf0K8
	nHP2z+VWZpuwrit8s02LySiu3xWbxFeg6kHURBl/AOysq74EIlUURytBFuWbyQVQ
	ZNjDNO+M0z6aeVuR4rc94QpS6cmVgaxxE60xtBXYuthQ8LlZmwZjNqF4fbQ==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47fbm1ww5k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 09:25:49 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 55P9PkK4024667;
	Wed, 25 Jun 2025 09:25:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 47dntmauy9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 09:25:46 +0000
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55P9PkjD024662;
	Wed, 25 Jun 2025 09:25:46 GMT
Received: from cse-cd02-lnx.ap.qualcomm.com (cse-cd02-lnx.qualcomm.com [10.64.75.246])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 55P9PjBN024659
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 09:25:46 +0000
Received: by cse-cd02-lnx.ap.qualcomm.com (Postfix, from userid 4438065)
	id D5D2F3866; Wed, 25 Jun 2025 17:25:42 +0800 (CST)
From: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
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
        Ziyue Zhang <quic_ziyuzhan@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: [PATCH v7 5/5] arm64: dts: qcom: qcs8300-ride: enable pcie1 interface
Date: Wed, 25 Jun 2025 17:25:39 +0800
Message-Id: <20250625092539.762075-6-quic_ziyuzhan@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250625092539.762075-1-quic_ziyuzhan@quicinc.com>
References: <20250625092539.762075-1-quic_ziyuzhan@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=YYu95xRf c=1 sm=1 tr=0 ts=685bc09d cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=0LYZJ8Fh9g_wO_RM1qMA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: R6irlamBveMzrA2DZ2ui-7HJ_0Pxoalx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDA3MCBTYWx0ZWRfX1u02zJ8MPPFc
 si/KOM+3CdnnDHBLmY8r4MUwsrKLz0JK9zy6o+OWRZFGCO5jvE2X4WEgZu/OFCWWST9oaW720Dk
 V7ffkOIEYnijLcTqTBgHZySflvyu1qOT3DUuqqk0PJKtIE93xcy9pyxrsjDlIxxglHTN/jBaiTL
 5qWcOgepIp4QEM5S7HJkbGixm5GeiBEqh4wCeW0Lt3yQSHSHTIZQgvx0lFLP8va93CDabUy9xB1
 /+BgJPCyfNCT9o2SKMjxQF3KNTcjPg/oxQxRRVsr0Bqa5G/BdOoQeDBtyXZTMYEECusSSOKncBp
 xbrAr4W9mANPd4+DuH6KJe0U6+PCNDGjYeH4dtXivByRSrIspe9j+bmC2qhnuiGJ+Ynzo7HSTm/
 jDaLlFgzOZeR6VjGGOqqFeJzvQZ82kIy6a3RzrZBahVraC0HRDSc2KwiOq7yOE64dbJ/a1Y2
X-Proofpoint-ORIG-GUID: R6irlamBveMzrA2DZ2ui-7HJ_0Pxoalx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-25_02,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 spamscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 mlxlogscore=999
 clxscore=1015 mlxscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506250070

Add configurations in devicetree for PCIe1, board related gpios,
PMIC regulators, etc for qcs8300-ride platform.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
---
 arch/arm64/boot/dts/qcom/qcs8300-ride.dts | 40 +++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs8300-ride.dts b/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
index e8e382db2b99..bec2905c5d8f 100644
--- a/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
+++ b/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
@@ -325,6 +325,23 @@ &pcie0_phy {
 	status = "okay";
 };
 
+&pcie1 {
+	perst-gpios = <&tlmm 23 GPIO_ACTIVE_LOW>;
+	wake-gpios = <&tlmm 21 GPIO_ACTIVE_HIGH>;
+
+	pinctrl-0 = <&pcie1_default_state>;
+	pinctrl-names = "default";
+
+	status = "okay";
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
@@ -388,6 +405,29 @@ perst-pins {
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
2.34.1


