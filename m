Return-Path: <linux-pci+bounces-17638-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D290D9E38F7
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 12:36:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 980CF285322
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 11:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779591BFE03;
	Wed,  4 Dec 2024 11:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="duPQ4uni"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D471BCA1C;
	Wed,  4 Dec 2024 11:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733312095; cv=none; b=p+/wJ9OZrAFPFYujdIN4SkxSrJzp5nQB8vHIOlOh5sY16EKw6eUaHeYQGc/cM77A4/0mvfSs4NWL4n6iHZUb06ju4w3igx37YAQgUL3eXB/CrsFRrqVzQcfVwEZxwMzY9bFJGgkCrs8gDV0XidRF7SdMgr6P9v4KX87D0awy8Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733312095; c=relaxed/simple;
	bh=ZNPn3OUHgs654omndsNWSDHy4Rb7fo2Qhuxvg1MRzHk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XH8JXI0FuUYaF3ubFPyNdLOhhNMbl+VCyit9zuNU3cV4saR1+p5dtX9nbtgEP7SWpJ/cj18JxaCJSbl6AAbjuT7zxtltJps4XuoW6+ghkokRFkWCPj1F+LecHy7a5/rrBpC8OzGfskdM5bER+1dZ0r0IsQNkKE0kH/i0pxC3D30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=duPQ4uni; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B43RkWn001101;
	Wed, 4 Dec 2024 11:34:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iiByAk0cX0/wcGs7iFI1tDw/VgKafpo5zFmvzCqogyA=; b=duPQ4univGDIWKls
	bpakfaaEn6nYh7m/5Ybqv7Q3ZWE+QniwV9uZi4LwhNma9m48/BDPnW9quE9XDZIH
	rf3KrpMMwH3TXV4ImFAe51gdcJk5t58+3TYYZ4k96fOLQG6Xw+ao+tf1uvob3xnC
	KI1qJrvraeAGEiM3igJeq1nCSyVoj8xzD3a08l/nQDTy6P3mu0hM52RjYaxJ446f
	UFd+ZBAXWgq846NDOlWMyJXm7uRevAA15Ev1TiomXBGHbciaeFPeuSZPxJBt/ARD
	PpUGzyUY2VlONzIK7l8j8+XFonvhhcMJb0v/elZYI7iqKVOTPab6MpicHFwa5JQ7
	gT8ESA==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 439trbmg0y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Dec 2024 11:34:41 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4B4BYeB2028552
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 4 Dec 2024 11:34:40 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 4 Dec 2024 03:34:34 -0800
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <lpieralisi@kernel.org>, <kw@linux.com>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <bhelgaas@google.com>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <vkoul@kernel.org>, <kishon@kernel.org>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <p.zabel@pengutronix.de>,
        <quic_nsekar@quicinc.com>, <dmitry.baryshkov@linaro.org>,
        <quic_varada@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>
CC: Praveenkumar I <quic_ipkumar@quicinc.com>
Subject: [PATCH v2 6/6] arm64: dts: qcom: ipq5332: Enable PCIe phys and controllers
Date: Wed, 4 Dec 2024 17:03:29 +0530
Message-ID: <20241204113329.3195627-7-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241204113329.3195627-1-quic_varada@quicinc.com>
References: <20241204113329.3195627-1-quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: SjvZoOP9NAs9WFY07JgoiO0CJKxQMbqn
X-Proofpoint-ORIG-GUID: SjvZoOP9NAs9WFY07JgoiO0CJKxQMbqn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=917 mlxscore=0
 suspectscore=0 spamscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 clxscore=1011 phishscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412040090

From: Praveenkumar I <quic_ipkumar@quicinc.com>

Enable the PCIe controller and PHY nodes for RDP 441.

Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
 arch/arm64/boot/dts/qcom/ipq5332-rdp441.dts | 74 +++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq5332-rdp441.dts b/arch/arm64/boot/dts/qcom/ipq5332-rdp441.dts
index 846413817e9a..83eca8435cff 100644
--- a/arch/arm64/boot/dts/qcom/ipq5332-rdp441.dts
+++ b/arch/arm64/boot/dts/qcom/ipq5332-rdp441.dts
@@ -62,4 +62,78 @@ data-pins {
 			bias-pull-up;
 		};
 	};
+
+	pcie0_default: pcie0-default-state {
+		clkreq-n-pins {
+			pins = "gpio37";
+			function = "pcie0_clk";
+			drive-strength = <8>;
+			bias-pull-up;
+		};
+
+		perst-n-pins {
+			pins = "gpio38";
+			function = "gpio";
+			drive-strength = <8>;
+			bias-pull-up;
+			output-low;
+		};
+
+		wake-n-pins {
+			pins = "gpio39";
+			function = "pcie0_wake";
+			drive-strength = <8>;
+			bias-pull-up;
+		};
+	};
+
+	pcie1_default: pcie1-default-state {
+		clkreq-n-pins {
+			pins = "gpio46";
+			function = "pcie1_clk";
+			drive-strength = <8>;
+			bias-pull-up;
+		};
+
+		perst-n-pins {
+			pins = "gpio47";
+			function = "gpio";
+			drive-strength = <8>;
+			bias-pull-up;
+			output-low;
+		};
+
+		wake-n-pins {
+			pins = "gpio48";
+			function = "pcie1_wake";
+			drive-strength = <8>;
+			bias-pull-up;
+		};
+	};
+};
+
+&pcie0_phy {
+	status = "okay";
+};
+
+&pcie0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie0_default>;
+
+	perst-gpios = <&tlmm 38 GPIO_ACTIVE_LOW>;
+	wake-gpios = <&tlmm 39 GPIO_ACTIVE_LOW>;
+	status = "okay";
+};
+
+&pcie1_phy {
+	status = "okay";
+};
+
+&pcie1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie1_default>;
+
+	perst-gpios = <&tlmm 47 GPIO_ACTIVE_LOW>;
+	wake-gpios = <&tlmm 48 GPIO_ACTIVE_LOW>;
+	status = "okay";
 };
-- 
2.34.1


