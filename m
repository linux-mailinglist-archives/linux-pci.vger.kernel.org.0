Return-Path: <linux-pci+bounces-19825-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25862A11A08
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 07:48:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE7723A8B8C
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 06:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617A023026F;
	Wed, 15 Jan 2025 06:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="D0/XwgmE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF075223;
	Wed, 15 Jan 2025 06:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736923706; cv=none; b=BaiiwvllARwPTF1l/WCY1v+fXiLUjKC8BryrICAwKGHXw7t5RWnargI8TAQoaa/h2wz5lLswm41aLo7MGcYLNYZoDtgeMi8HtJXA+I/bU6Mn9t+HKJSdJftipre/YNzFKRPv16/KFhWGsK6XCymz05bekhsy3DrNIYjHV/qv8j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736923706; c=relaxed/simple;
	bh=m5OEpVoI63DZwcR9TguGmDDONdRscwKlIGU+8JvzPu8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h9tFc1NfzMX5k/aiUznasCYpyHi1zgrEvYfn/eS66gL7O7hbTr3ypikmB8atzzRD6ckLfIpbPiip3Mzzl14hpnSrC2n2Y1bM2kyvjD0Id++nFSrjYEyGG+GzXrXR4Yfw74wNWcNT5xIqtMWXnZRbcyaYs9ujsc5uSx2+Msve20M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=D0/XwgmE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50F0bhPn002544;
	Wed, 15 Jan 2025 06:48:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	U7y5XI/ogBdlpYlDZW9rMCcRFyBZScGo6nZIm6wSEyU=; b=D0/XwgmEfXOtkGgp
	kxTaZpQm6d6xEzmMvi7RJRpZB56Ux8HLW/dSih2WDuJBZu+eDIvZfQuZJ0t7VXiq
	jKwvjtapTqDyjHRcAGL6NrDntJq17gpyOuru9vckc3Y/yXaPpnfDkNebJmxQD9I5
	Vz0hNYjcFahM0cxq/XuF/ASnVwrY83OSBAN1pRskGl2zsP6h1xfJ+EQlwvCdGo7v
	GY8srbz6MzIPs6TMgChjyQJnpk3lE9kHZXnndz1oOikPKG9EHSEi4WmccVAWkA4T
	nq1aPza4TNqvfzbcI+PPoIFE19bPNVHd4SC6tk2CQeYSZFtERcvaFiVvhr7q+9LT
	FFBftg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4462mkgr5x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 06:48:18 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50F6mH3s019382
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 06:48:17 GMT
Received: from hu-mmanikan-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 14 Jan 2025 22:48:12 -0800
From: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
To: <lpieralisi@kernel.org>, <kw@linux.com>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <bhelgaas@google.com>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <andersson@kernel.org>, <konradybcio@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>
Subject: [PATCH v2 3/3] arm64: dts: qcom: ipq5424: Enable PCIe PHYs and controllers
Date: Wed, 15 Jan 2025 12:17:47 +0530
Message-ID: <20250115064747.3302912-4-quic_mmanikan@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250115064747.3302912-1-quic_mmanikan@quicinc.com>
References: <20250115064747.3302912-1-quic_mmanikan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: dP9mHta9VrNqYQmOW1yL5c6jodqISBvi
X-Proofpoint-GUID: dP9mHta9VrNqYQmOW1yL5c6jodqISBvi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-15_02,2025-01-13_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 impostorscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=827 clxscore=1015 mlxscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501150049

Enable the PCIe controller and PHY nodes corresponding to RDP466.

Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
---
Changes in V2:
	- Drop the inner wrapper in pcie2_default_state and
	  pcie3_default_state nodes.
	- Reordered the pcie nodes.

 arch/arm64/boot/dts/qcom/ipq5424-rdp466.dts | 41 ++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq5424-rdp466.dts b/arch/arm64/boot/dts/qcom/ipq5424-rdp466.dts
index b6e4bb3328b3..73e6b38ecc26 100644
--- a/arch/arm64/boot/dts/qcom/ipq5424-rdp466.dts
+++ b/arch/arm64/boot/dts/qcom/ipq5424-rdp466.dts
@@ -53,6 +53,30 @@ &dwc_1 {
 	dr_mode = "host";
 };
 
+&pcie2 {
+	pinctrl-0 = <&pcie2_default_state>;
+	pinctrl-names = "default";
+
+	perst-gpios = <&tlmm 31 GPIO_ACTIVE_LOW>;
+	status = "okay";
+};
+
+&pcie2_phy {
+	status = "okay";
+};
+
+&pcie3 {
+	pinctrl-0 = <&pcie3_default_state>;
+	pinctrl-names = "default";
+
+	perst-gpios = <&tlmm 34 GPIO_ACTIVE_LOW>;
+	status = "okay";
+};
+
+&pcie3_phy {
+	status = "okay";
+};
+
 &qusb_phy_0 {
 	vdd-supply = <&vreg_misc_0p925>;
 	vdda-pll-supply = <&vreg_misc_1p8>;
@@ -147,6 +171,22 @@ data-pins {
 			bias-pull-up;
 		};
 	};
+
+	pcie2_default_state: pcie2-default-state {
+		pins = "gpio31";
+		function = "gpio";
+		drive-strength = <8>;
+		bias-pull-up;
+		output-low;
+	};
+
+	pcie3_default_state: pcie3-default-state {
+		pins = "gpio34";
+		function = "gpio";
+		drive-strength = <8>;
+		bias-pull-up;
+		output-low;
+	};
 };
 
 &uart1 {
@@ -166,4 +206,3 @@ &usb3 {
 &xo_board {
 	clock-frequency = <24000000>;
 };
-
-- 
2.34.1


