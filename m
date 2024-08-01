Return-Path: <linux-pci+bounces-11103-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1059442DB
	for <lists+linux-pci@lfdr.de>; Thu,  1 Aug 2024 07:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A3401F21F96
	for <lists+linux-pci@lfdr.de>; Thu,  1 Aug 2024 05:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C3B9158552;
	Thu,  1 Aug 2024 05:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="os5QWxR+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B781B158542;
	Thu,  1 Aug 2024 05:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722491330; cv=none; b=ouNkB7gFD9FO5c96X0cEloiQGb/0xsC8T/1FXWFuYXAvDKGHM8C5tk0gCRzLduakS0W/eBol8UHlgpq2OD9rWQ4Q6JEEUWbJ8FoSVZpgVEt6/n445QuVdWGt8eh1NNSeAcoAtTr8Qoy/Y1HTMthFJL22qgIt8geaOtX7dlJTNvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722491330; c=relaxed/simple;
	bh=IPhahkZ6qy7uRjZHpGdmaK0Lu+Kr00TpXw/OcLHYSfI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H7Egv6XRwbJ+YpekVmTV5deobIAINw68R4uJf0qocHd5D9RVx0vNHVehMHxm/vWVJX3EoUK0Thpx1WiEBsREPZw0ucQxgAVHnUCM7JxeCpRAFuduvUQWu9X6pEHxPTpGBCQQB5+pRCI9aybK6L3oOG+6IBz/pBcaLoFQYyvh42g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=os5QWxR+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46VMxS1A030520;
	Thu, 1 Aug 2024 05:48:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hGO9keNVUrvs9IXj4FJ+VEBdkTXZ7TVnpLE++TZrl9s=; b=os5QWxR+3BXCMtTN
	AbMLiIuZNhyp5deKGmK9AefD2SqSwr0EdLGidwSVsNqgbdijxrKLY+pNHpB2AZUR
	n+UMZ7NIPnEcSNOSaF13g8+IEoekh/JC2gUgr74LtuhZkCw6znEHiviUx1MvGXdA
	NJmBGgO1/47nWLwIdnnGL1WFyfkkM6OP1CqO6um2eDoTn0fjPs0I9mf7dL+dLS5m
	Jy06BuuFctVsux7a5NVpP4kAs2HTqTIaKfEA8WyUUGDJUg4uWwcTAbhAFwAXv3hq
	qDdn7Jnziz2M4ez9rmhlLhKgypaiBnGVOno6P9r6jBbMf6opNsJYVsfmCk3Gj8o+
	6QKaUA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40qm082qxn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Aug 2024 05:48:35 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 4715mZ1r011964
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 1 Aug 2024 05:48:35 GMT
Received: from hu-srichara-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 31 Jul 2024 22:48:30 -0700
From: Sricharan R <quic_srichara@quicinc.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <manivannan.sadhasivam@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <quic_srichara@quicinc.com>
Subject: [PATCH V7 3/4] arm64: dts: qcom: ipq9574: Enable PCIe PHYs and controllers
Date: Thu, 1 Aug 2024 11:18:02 +0530
Message-ID: <20240801054803.3015572-4-quic_srichara@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240801054803.3015572-1-quic_srichara@quicinc.com>
References: <20240801054803.3015572-1-quic_srichara@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: oUrSxAYDY2AM5Dd0FUSsy3HYokUTDhMy
X-Proofpoint-ORIG-GUID: oUrSxAYDY2AM5Dd0FUSsy3HYokUTDhMy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-01_02,2024-07-31_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 mlxscore=0 priorityscore=1501 mlxlogscore=941 spamscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 phishscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408010031

From: devi priya <quic_devipriy@quicinc.com>

Enable the PCIe controller and PHY nodes corresponding to RDP 433.

Signed-off-by: devi priya <quic_devipriy@quicinc.com>
Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
---
 [V7] Fixed review comments from Konrad

 arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts | 113 ++++++++++++++++++++
 1 file changed, 113 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts b/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
index 1bb8d96c9a82..165ebbb59511 100644
--- a/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
+++ b/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
@@ -8,6 +8,7 @@
 
 /dts-v1/;
 
+#include <dt-bindings/gpio/gpio.h>
 #include "ipq9574-rdp-common.dtsi"
 
 / {
@@ -15,6 +16,45 @@ / {
 	compatible = "qcom,ipq9574-ap-al02-c7", "qcom,ipq9574";
 };
 
+&pcie1_phy {
+	status = "okay";
+};
+
+&pcie1 {
+	pinctrl-0 = <&pcie1_default>;
+	pinctrl-names = "default";
+
+	perst-gpios = <&tlmm 26 GPIO_ACTIVE_LOW>;
+	wake-gpios = <&tlmm 27 GPIO_ACTIVE_LOW>;
+	status = "okay";
+};
+
+&pcie2_phy {
+	status = "okay";
+};
+
+&pcie2 {
+	pinctrl-0 = <&pcie2_default>;
+	pinctrl-names = "default";
+
+	perst-gpios = <&tlmm 29 GPIO_ACTIVE_LOW>;
+	wake-gpios = <&tlmm 30 GPIO_ACTIVE_LOW>;
+	status = "okay";
+};
+
+&pcie3_phy {
+	status = "okay";
+};
+
+&pcie3 {
+	pinctrl-0 = <&pcie3_default>;
+	pinctrl-names = "default";
+
+	perst-gpios = <&tlmm 32 GPIO_ACTIVE_LOW>;
+	wake-gpios = <&tlmm 33 GPIO_ACTIVE_LOW>;
+	status = "okay";
+};
+
 &sdhc_1 {
 	pinctrl-0 = <&sdc_default_state>;
 	pinctrl-names = "default";
@@ -28,6 +68,79 @@ &sdhc_1 {
 };
 
 &tlmm {
+
+	pcie1_default: pcie1-default-state {
+		clkreq-n-pins {
+			pins = "gpio25";
+			function = "pcie1_clk";
+			drive-strength = <6>;
+			bias-pull-up;
+		};
+
+		perst-n-pins {
+			pins = "gpio26";
+			function = "gpio";
+			drive-strength = <8>;
+			bias-pull-down;
+			output-low;
+		};
+
+		wake-n-pins {
+			pins = "gpio27";
+			function = "pcie1_wake";
+			drive-strength = <6>;
+			bias-pull-up;
+		};
+	};
+
+	pcie2_default: pcie2-default-state {
+		clkreq-n-pins {
+			pins = "gpio28";
+			function = "pcie2_clk";
+			drive-strength = <6>;
+			bias-pull-up;
+		};
+
+		perst-n-pins {
+			pins = "gpio29";
+			function = "gpio";
+			drive-strength = <8>;
+			bias-pull-down;
+			output-low;
+		};
+
+		wake-n-pins {
+			pins = "gpio30";
+			function = "pcie2_wake";
+			drive-strength = <6>;
+			bias-pull-up;
+		};
+	};
+
+	pcie3_default: pcie3-default-state {
+		clkreq-n-pins {
+			pins = "gpio31";
+			function = "pcie3_clk";
+			drive-strength = <6>;
+			bias-pull-up;
+		};
+
+		perst-n-pins {
+			pins = "gpio32";
+			function = "gpio";
+			drive-strength = <8>;
+			bias-pull-up;
+			output-low;
+		};
+
+		wake-n-pins {
+			pins = "gpio33";
+			function = "pcie3_wake";
+			drive-strength = <6>;
+			bias-pull-up;
+		};
+	};
+
 	sdc_default_state: sdc-default-state {
 		clk-pins {
 			pins = "gpio5";
-- 
2.34.1


