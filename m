Return-Path: <linux-pci+bounces-18855-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 072DF9F8C26
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2024 06:56:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1AD01896546
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2024 05:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB0EC1A9B34;
	Fri, 20 Dec 2024 05:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="c4vFIlbq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460FF1A2C0B;
	Fri, 20 Dec 2024 05:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734674060; cv=none; b=n3eDq2/my03ZCP0OXzE+1uBsVjUVLFw0D2zDvRlt9R+Dsqt+TH0cIZIN22LL9Dnip8MwFib5yRpVnuF8Q9577i/1as26Pj2bvcfY8m8J/Cq5ETPzQB1Ye2T4/WN4ylmnNsB+GWDmQGu4dDnBbyV1AbDcV82OaqPHAYimwG1S+mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734674060; c=relaxed/simple;
	bh=JDmxumleWLVJQCY+OI7NTcCMiXiBIzuCIXT1RnGA9uQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a1Bf51JwJgi6JbMC2wQQkDYWta4JkIF9yJ11glHcrju7L4dTvrGWtp5/kOxeLI1HtSsAmTvD3j/H+kC2CCMKBvwshp19+v0WwEElY6GOzfYOVaixZfc2r/ZL22Ba/tICuZ6XkcDZPUVKvAW7tH2pE5TD3to9xBKgrrQ7ZYJWGoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=c4vFIlbq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BJJrU50024248;
	Fri, 20 Dec 2024 05:54:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=cXZH0+BMKtF
	+YyJ8cTuN0wA+v6mRNPKggR4Rs3Sn2Jc=; b=c4vFIlbqyDuq7dnEM2u3D267T57
	ZCAmpruh2NrHvfNBLRgnW01VVCncEbyYfpcHjytGuCbLYpEGEi0u4G0YXHkaxjWI
	G8mnuWpS8XhjhFBaYydA0fjn/Uwp1/G52ZWTpJ60mK5+WOhTYiRSrHIB1FU73wkg
	V2nAtIPG4SwGRqxpqwx5eZz2yGSgJ/HrKk2QOYqukppREgoob+SUO0dGoRanojmi
	FH7u8pngy6kxo5vyKs/ee4ZvEvkwguUI2NEopVqeUutRqBf2U5o192/6nJ0ngGj6
	MQtY3WKkpGrX6J5bdvYcwRM8aVDD+JYBDh1e9J082rttpwDlu/hS3pWaPDg==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43mt1ws4hr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Dec 2024 05:54:07 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BK5s5oE024013;
	Fri, 20 Dec 2024 05:54:05 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 43h33kv4qs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Dec 2024 05:54:05 +0000
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4BK5s5lA024004;
	Fri, 20 Dec 2024 05:54:05 GMT
Received: from cse-cd02-lnx.ap.qualcomm.com (cse-cd02-lnx.qualcomm.com [10.64.75.246])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 4BK5s4qM023990
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Dec 2024 05:54:05 +0000
Received: by cse-cd02-lnx.ap.qualcomm.com (Postfix, from userid 4438065)
	id E6A3E1C3B; Fri, 20 Dec 2024 13:54:03 +0800 (CST)
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
        Ziyue Zhang <quic_ziyuzhan@quicinc.com>
Subject: [PATCH v3 8/8] arm64: dts: qcom: qcs8300: enable pcie1 for qcs8300 platform
Date: Fri, 20 Dec 2024 13:52:39 +0800
Message-Id: <20241220055239.2744024-9-quic_ziyuzhan@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241220055239.2744024-1-quic_ziyuzhan@quicinc.com>
References: <20241220055239.2744024-1-quic_ziyuzhan@quicinc.com>
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
X-Proofpoint-GUID: 3byS_kPkS6BE0kL4cXTKSRZfh1oX_qWv
X-Proofpoint-ORIG-GUID: 3byS_kPkS6BE0kL4cXTKSRZfh1oX_qWv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 mlxlogscore=835 priorityscore=1501 mlxscore=0 spamscore=0
 clxscore=1015 phishscore=0 bulkscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412200048

Add configurations in devicetree for PCIe1, board related gpios,
PMIC regulators, etc.

Signed-off-by: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
---
 arch/arm64/boot/dts/qcom/qcs8300-ride.dts | 40 +++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs8300-ride.dts b/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
index fe3200914f79..d4b0488a2e23 100644
--- a/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
+++ b/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
@@ -213,6 +213,23 @@ &pcie0_phy {
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
@@ -255,6 +272,29 @@ perst-pins {
 			bias-pull-down;
 		};
 	};
+
+	pcie1_default_state: pcie1-default-state {
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


