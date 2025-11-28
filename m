Return-Path: <linux-pci+bounces-42248-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B6010C91B5A
	for <lists+linux-pci@lfdr.de>; Fri, 28 Nov 2025 11:49:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4127534B570
	for <lists+linux-pci@lfdr.de>; Fri, 28 Nov 2025 10:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627A330C631;
	Fri, 28 Nov 2025 10:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="U5PwWgce"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69102E62B3;
	Fri, 28 Nov 2025 10:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764326989; cv=none; b=ou/cRnkm4Dedk4I0EG38Wl98JFtP5pPK2rS4SnfA6bX5Hfs5zFds4UQgQ/tVxUILvRW+Fyc+nvNGDEqieKQHHfPToyWBWdOUe0EzFSa4qKB9shodk778IYAeAlCd7aXMkRRkoQZJkPime25dZf64di6BjJu6g/9QXWAl4zKCDFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764326989; c=relaxed/simple;
	bh=zwYc03gE9i5Ws5sxqQHu/4jeFLFZdA0/OihtvOsta9s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=blTQelRUccukCjHRgb6ITtMJoV7a9KhY8ctK7zaOqQFUmTVhp5wYFxk6vYRif6K03eF7PzogOSFcsjD2nHnLLt4KbFg4Ypf44wXR/dhrNAvvgkiB4L9CpJU7T2i9QhePi30UkXyQkjLnok1Dv+ar9L4kv6C629PIhgagPpHYl3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=U5PwWgce; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AS8OMmf3967407;
	Fri, 28 Nov 2025 10:49:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=XOv43bH80aT
	uObCz8M2ge9QC9lBOIRg02jqoIxfCx8A=; b=U5PwWgceN/X0tRKH7vqNQ4OvxJY
	H5IUBmV1JHvNgvmw7RiGeQgWKzmkBdkB2D1FInDftYxbJK7p+tRjjzZrx9w+HHKb
	I8pqDjEerkbn8OC8JCTdVFkkH9M9FJ0uopaOsfygP3fmOBREpOjqc09AfSk6ab65
	Dd8RpUUT7YBE4pVzMkdvU4rp/jIstugr39YJjizhqiMRsLKJ/JgCijpdsK2xtIil
	JUFA95DRQaCsXavW+Cptqf9BiEJ5s+cSJnRu1Jq2Cg9mPJWzcQtj6HYV+VgEkjyR
	nclEZ6ORj5kvO9vjgOgCwuwW2XYAlUbAtDcNRyV/CcHbAx4rlAvU1ZatC6g==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4apkv5k96u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Nov 2025 10:49:37 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 5ASAnYBN000881;
	Fri, 28 Nov 2025 10:49:34 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 4ak68mvqhj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Nov 2025 10:49:34 +0000
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5ASAnXUm000858;
	Fri, 28 Nov 2025 10:49:33 GMT
Received: from cse-cd02-lnx.ap.qualcomm.com (cse-cd02-lnx.qualcomm.com [10.64.75.246])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 5ASAnXnQ000849
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Nov 2025 10:49:33 +0000
Received: by cse-cd02-lnx.ap.qualcomm.com (Postfix, from userid 4438065)
	id 25FEE7AD; Fri, 28 Nov 2025 18:49:32 +0800 (CST)
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
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: [PATCH v15 3/6] arm64: dts: qcom: qcs8300-ride: enable pcie0 interface
Date: Fri, 28 Nov 2025 18:49:25 +0800
Message-Id: <20251128104928.4070050-4-ziyue.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251128104928.4070050-1-ziyue.zhang@oss.qualcomm.com>
References: <20251128104928.4070050-1-ziyue.zhang@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: h1vgwn2WKR6JynovnnRpfiQSDCWc8wJD
X-Authority-Analysis: v=2.4 cv=O8k0fR9W c=1 sm=1 tr=0 ts=69297e41 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=IKGGdEyG_brSza0xPGIA:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI4MDA3OCBTYWx0ZWRfXxoH+MxAJ2seW
 qHbw1JELSFbGk++lIsFtVKpfGQQTAa2rSpM+4YO+MAjMm+OUsCRdT1RJINAZtR4G/Aj8XEvqVYB
 peQ6gzsOE9VIt+5mN5m19WWxJoiEyUQ8DYnmVlVO2vvVwxMssgTJ6E0id8xhwJMMe/htits/Yoa
 Rwk1+F5SyYY7MipPjHwS9BdHRoSiP9Ez06hS/kABcNs4UNj1DPMmzjBZEzqQTH4ii7UaFewJG8I
 INyqDOQ1DgUcpa5RMDXjT9cO+jksXdsCgpPyGQ9cjWBq2mHkZcH+cxedgFuti8wiPXL0/yGPULf
 R/R7skBXTd2FKAwchhoFHS0Xfz//FWZvrhF6gChauD/nP40ylKJDAhatTOraOmy0dZSVQNKb8sk
 rLMaBO7yQr541JFJKCymfDIitgMKFw==
X-Proofpoint-GUID: h1vgwn2WKR6JynovnnRpfiQSDCWc8wJD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-28_03,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 adultscore=0 clxscore=1015 impostorscore=0
 spamscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511280078

Add configurations in devicetree for PCIe0, board related gpios,
PMIC regulators, etc for qcs8300-ride board.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/qcs8300-ride.dts | 42 +++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs8300-ride.dts b/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
index 9bcb869dd270..7ab01dc3bbc9 100644
--- a/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
+++ b/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
@@ -317,6 +317,25 @@ &iris {
 	status = "okay";
 };
 
+&pcie0 {
+	pinctrl-0 = <&pcie0_default_state>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+
+&pcieport0 {
+	reset-gpios = <&tlmm 2 GPIO_ACTIVE_LOW>;
+	wake-gpios = <&tlmm 0 GPIO_ACTIVE_HIGH>;
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
@@ -377,6 +396,29 @@ ethernet0_mdio: ethernet0-mdio-pins {
 			bias-pull-up;
 		};
 	};
+
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
 };
 
 &uart7 {
-- 
2.34.1


