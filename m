Return-Path: <linux-pci+bounces-44352-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE4ED08B22
	for <lists+linux-pci@lfdr.de>; Fri, 09 Jan 2026 11:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D797E30B3723
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jan 2026 10:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A419B33A715;
	Fri,  9 Jan 2026 10:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SNSzK9wc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39893382E4;
	Fri,  9 Jan 2026 10:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767955535; cv=none; b=sUZwbWcJK1xEK1H9caiG/33KZj4gYXNhgeULrd5P7LblEG1Q6gYQ05vvRd9r1i8kmEQFiOPthVVpFf6vPBMKFIFKyYHyOTyk05oeyD/MnCNs0Q9M46dt9lfW1CrcI3flgVSJr+ZlZLP1+HrB2nMJQdCP/e0BF1MblZxDvGloImc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767955535; c=relaxed/simple;
	bh=ba49HhQU4dlf77RsGXQPT1htCOydFoYs2J3IhdsdC8M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gVdiKDY9WKUZLONxRNd516Z7L/edsGX8Bowc9nnUjutKx89aDvpqfkjqG8/EYwcUukJPDtYz3g0IDnVn4jxrb6Stw43YT+NOrDbBJtwc+IJiSMh3gU+yU07GtNBSjrA8Q+MSmI4CabJDfFYegQ65XEdc5rrem5oRDJeIV6MpcMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SNSzK9wc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6099N9wS472846;
	Fri, 9 Jan 2026 10:45:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=74F6HprV81y
	g26/Yb/dQKd0rGRI459HNGis0OvpCGr8=; b=SNSzK9wcINm4v0TdZDEEDYyrQRB
	udPyKNz5fLmMjbeMJMbIvql0jqeL2T1KYLkdKVt9TOBDXx2NEXUsfYU+C+KogB/j
	n2B6rafh9TFtfjrsx6I51KIDOUmXVW/0PMkk7eDNWpzFtEL07tTW4B+eVN8E/g6a
	7tvEsCHo5fFvIF1MGSZRZvIUuxcEwgoJBIGEHUMX1Ol2WZ8sYRM4Rlyb4ukLaoG7
	cGadyvHIWVgUaBj24xkX3BJi2aaIetq/LcAfYA0xkPWfcHvllJVNYtAp92jX1lQn
	sdzsjGPNzShFQXFbNG39cy/a6HeUluwm+wmHEh6VxTyOOL42Zfb1dMVw9Bg==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bjy0a084c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Jan 2026 10:45:19 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 609AjHeD007216;
	Fri, 9 Jan 2026 10:45:17 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 4bev6mpxxv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Jan 2026 10:45:17 +0000
Received: from APTAIPPMTA02.qualcomm.com (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 609AjGLT007202;
	Fri, 9 Jan 2026 10:45:16 GMT
Received: from cse-cd02-lnx.ap.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 609AjGiK007195
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Jan 2026 10:45:16 +0000
Received: by cse-cd02-lnx.ap.qualcomm.com (Postfix, from userid 4438065)
	id 0293277E; Fri,  9 Jan 2026 18:45:15 +0800 (CST)
From: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
To: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, ziyue.zhang@oss.qualcomm.com,
        jingoohan1@gmail.com, mani@kernel.org, lpieralisi@kernel.org,
        kwilczynski@kernel.org, bhelgaas@google.com, johan+linaro@kernel.org,
        vkoul@kernel.org, kishon@kernel.org, neil.armstrong@linaro.org,
        abel.vesa@linaro.org, kw@linux.com
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org, qiang.yu@oss.qualcomm.com,
        quic_krichai@quicinc.com, quic_vbadigan@quicinc.com
Subject: [PATCH v4 1/3] arm64: dts: qcom: hamoa: Move PHY, PERST, and Wake GPIOs to PCIe port nodes and add port Nodes for all PCIe ports
Date: Fri,  9 Jan 2026 18:45:02 +0800
Message-Id: <20260109104504.3147745-2-ziyue.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260109104504.3147745-1-ziyue.zhang@oss.qualcomm.com>
References: <20260109104504.3147745-1-ziyue.zhang@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDA3OCBTYWx0ZWRfXzXpu1DDYh7Wh
 XMf+PaIta7OWnPn9FmtZIJefmrh7ArhCDN8mXLy6j6Ii4k/l0GI7W5+827cNy9xWZgF4zdl+Vns
 GBxqhyk4A3WS/3sEQr1X4ANycniY9lOVkAMHNd3RTaV2VnfjGLJJuSzt44D7N2Km8tNIjkg6kyx
 wVRQjf1WAMj+AS81tgJRJX2vGdEQCzga80YkvXsrxD7n/F5EZROeLx178gL1eD1GJmADcYr864L
 ekCc4Yih9QaJIr6UncVe6InRAhDAojd8HXl4VWFRZ4pDnP+EjxpYoCWG7y7gh0ps126jehgvzfy
 8bl3H58JdXF091ljMRgA5vCqCCd5dqREwmP0dgyH6jFcKvmhHMpA4Q95She0+9Gf43F7yJ+Vp37
 Tje1XB6ROfIHMepUDFI7qS+r6lbY45M+2iAn4FF0tZXb1qSPv47wgd5B6YFK3r5G2unwoQ6Igjl
 xkZw+GNnnrc+4sjC5/Q==
X-Proofpoint-ORIG-GUID: 3HaNlheKjElwUT99LnPjCtvnD2mMpzav
X-Proofpoint-GUID: 3HaNlheKjElwUT99LnPjCtvnD2mMpzav
X-Authority-Analysis: v=2.4 cv=QPFlhwLL c=1 sm=1 tr=0 ts=6960dc3f cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=aKaZ7cjhLP4wjK1lvm8A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_03,2026-01-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 adultscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601090078

Since describing the PCIe PHY directly under the RC node is now
deprecated, move the references to the respective PCIe port nodes,
creating them where necessary.Also add port nodes for PCIe5 and PCIe6a
with proper PHY references.

And also move the PCIe PERST and wake GPIOs from the controller nodes to
the corresponding PCIe port nodes on Hamoa-based platforms:

 - x1e001de-devkit
 - x1e78100-lenovo-thinkpad-t14s
 - x1e80100-asus-vivobook-s15
 - x1e80100-asus-zenbook-a14
 - x1e80100-dell-xps13-9345
 - x1e80100-lenovo-yoga-slim7x
 - x1e80100-microsoft-romulus
 - x1e80100-qcp

Signed-off-by: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/hamoa.dtsi           | 42 +++++++++++++------
 arch/arm64/boot/dts/qcom/x1e001de-devkit.dts  | 24 +++++++----
 .../qcom/x1e78100-lenovo-thinkpad-t14s.dtsi   | 24 +++++++----
 .../dts/qcom/x1e80100-asus-vivobook-s15.dts   | 14 ++++---
 .../dts/qcom/x1e80100-asus-zenbook-a14.dts    |  3 ++
 .../dts/qcom/x1e80100-dell-xps13-9345.dts     | 14 ++++---
 .../dts/qcom/x1e80100-lenovo-yoga-slim7x.dts  |  8 ++--
 .../dts/qcom/x1e80100-microsoft-romulus.dtsi  | 19 ++++++---
 arch/arm64/boot/dts/qcom/x1e80100-qcp.dts     | 21 ++++++----
 9 files changed, 108 insertions(+), 61 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/hamoa.dtsi b/arch/arm64/boot/dts/qcom/hamoa.dtsi
index a559f6340af9..f464ff3b89cb 100644
--- a/arch/arm64/boot/dts/qcom/hamoa.dtsi
+++ b/arch/arm64/boot/dts/qcom/hamoa.dtsi
@@ -3261,9 +3261,6 @@ &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
 
 			power-domains = <&gcc GCC_PCIE_3_GDSC>;
 
-			phys = <&pcie3_phy>;
-			phy-names = "pciephy";
-
 			eq-presets-8gts = /bits/ 16 <0x5555 0x5555 0x5555 0x5555
 						     0x5555 0x5555 0x5555 0x5555>;
 			eq-presets-16gts = /bits/ 8 <0x55 0x55 0x55 0x55 0x55 0x55 0x55 0x55>;
@@ -3404,12 +3401,14 @@ opp-128000000-4 {
 				};
 			};
 
-			pcie3_port: pcie@0 {
+			pcie3_port0: pcie@0 {
 				device_type = "pci";
 				compatible = "pciclass,0604";
 				reg = <0x0 0x0 0x0 0x0 0x0>;
 				bus-range = <0x01 0xff>;
 
+				phys = <&pcie3_phy>;
+
 				#address-cells = <3>;
 				#size-cells = <2>;
 				ranges;
@@ -3538,13 +3537,22 @@ &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
 			power-domains = <&gcc GCC_PCIE_6A_GDSC>;
 			required-opps = <&rpmhpd_opp_nom>;
 
-			phys = <&pcie6a_phy>;
-			phy-names = "pciephy";
-
 			eq-presets-8gts = /bits/ 16 <0x5555 0x5555 0x5555 0x5555>;
 			eq-presets-16gts = /bits/ 8 <0x55 0x55 0x55 0x55>;
 
 			status = "disabled";
+
+			pcie6a_port0: pcie@0 {
+				device_type = "pci";
+				reg = <0x0 0x0 0x0 0x0 0x0>;
+				bus-range = <0x01 0xff>;
+
+				phys = <&pcie6a_phy>;
+
+				#address-cells = <3>;
+				#size-cells = <2>;
+				ranges;
+			};
 		};
 
 		pcie6a_phy: phy@1bfc000 {
@@ -3670,12 +3678,21 @@ &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
 			power-domains = <&gcc GCC_PCIE_5_GDSC>;
 			required-opps = <&rpmhpd_opp_nom>;
 
-			phys = <&pcie5_phy>;
-			phy-names = "pciephy";
-
 			eq-presets-8gts = /bits/ 16 <0x5555 0x5555>;
 
 			status = "disabled";
+
+			pcie5_port0: pcie@0 {
+				device_type = "pci";
+				reg = <0x0 0x0 0x0 0x0 0x0>;
+				bus-range = <0x01 0xff>;
+
+				phys = <&pcie5_phy>;
+
+				#address-cells = <3>;
+				#size-cells = <2>;
+				ranges;
+			};
 		};
 
 		pcie5_phy: phy@1c06000 {
@@ -3800,9 +3817,6 @@ &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
 			power-domains = <&gcc GCC_PCIE_4_GDSC>;
 			required-opps = <&rpmhpd_opp_nom>;
 
-			phys = <&pcie4_phy>;
-			phy-names = "pciephy";
-
 			eq-presets-8gts = /bits/ 16 <0x5555 0x5555>;
 
 			status = "disabled";
@@ -3812,6 +3826,8 @@ pcie4_port0: pcie@0 {
 				reg = <0x0 0x0 0x0 0x0 0x0>;
 				bus-range = <0x01 0xff>;
 
+				phys = <&pcie4_phy>;
+
 				#address-cells = <3>;
 				#size-cells = <2>;
 				ranges;
diff --git a/arch/arm64/boot/dts/qcom/x1e001de-devkit.dts b/arch/arm64/boot/dts/qcom/x1e001de-devkit.dts
index a9643cd746d5..d5a60671a383 100644
--- a/arch/arm64/boot/dts/qcom/x1e001de-devkit.dts
+++ b/arch/arm64/boot/dts/qcom/x1e001de-devkit.dts
@@ -1003,9 +1003,6 @@ &mdss_dp2_out {
 };
 
 &pcie4 {
-	perst-gpios = <&tlmm 146 GPIO_ACTIVE_LOW>;
-	wake-gpios = <&tlmm 148 GPIO_ACTIVE_LOW>;
-
 	pinctrl-0 = <&pcie4_default>;
 	pinctrl-names = "default";
 
@@ -1019,10 +1016,12 @@ &pcie4_phy {
 	status = "okay";
 };
 
-&pcie5 {
-	perst-gpios = <&tlmm 149 GPIO_ACTIVE_LOW>;
-	wake-gpios = <&tlmm 151 GPIO_ACTIVE_LOW>;
+&pcie4_port0 {
+	reset-gpios = <&tlmm 146 GPIO_ACTIVE_LOW>;
+	wake-gpios = <&tlmm 148 GPIO_ACTIVE_LOW>;
+};
 
+&pcie5 {
 	vddpe-3v3-supply = <&vreg_wwan>;
 
 	pinctrl-0 = <&pcie5_default>;
@@ -1038,10 +1037,12 @@ &pcie5_phy {
 	status = "okay";
 };
 
-&pcie6a {
-	perst-gpios = <&tlmm 152 GPIO_ACTIVE_LOW>;
-	wake-gpios = <&tlmm 154 GPIO_ACTIVE_LOW>;
+&pcie5_port0 {
+	reset-gpios = <&tlmm 149 GPIO_ACTIVE_LOW>;
+	wake-gpios = <&tlmm 151 GPIO_ACTIVE_LOW>;
+};
 
+&pcie6a {
 	vddpe-3v3-supply = <&vreg_nvme>;
 
 	pinctrl-names = "default";
@@ -1057,6 +1058,11 @@ &pcie6a_phy {
 	status = "okay";
 };
 
+&pcie6a_port0 {
+	reset-gpios = <&tlmm 152 GPIO_ACTIVE_LOW>;
+	wake-gpios = <&tlmm 154 GPIO_ACTIVE_LOW>;
+};
+
 &pm8550_gpios {
 	rtmr0_default: rtmr0-reset-n-active-state {
 		pins = "gpio10";
diff --git a/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi b/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi
index 7aee9a20c6df..b45e377a22c6 100644
--- a/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi
@@ -1113,9 +1113,6 @@ &mdss_dp3_phy {
 };
 
 &pcie4 {
-	perst-gpios = <&tlmm 146 GPIO_ACTIVE_LOW>;
-	wake-gpios = <&tlmm 148 GPIO_ACTIVE_LOW>;
-
 	pinctrl-0 = <&pcie4_default>;
 	pinctrl-names = "default";
 
@@ -1129,10 +1126,12 @@ &pcie4_phy {
 	status = "okay";
 };
 
-&pcie5 {
-	perst-gpios = <&tlmm 149 GPIO_ACTIVE_LOW>;
-	wake-gpios = <&tlmm 151 GPIO_ACTIVE_LOW>;
+&pcie4_port0 {
+	reset-gpios = <&tlmm 146 GPIO_ACTIVE_LOW>;
+	wake-gpios = <&tlmm 148 GPIO_ACTIVE_LOW>;
+};
 
+&pcie5 {
 	vddpe-3v3-supply = <&vreg_wwan>;
 
 	pinctrl-0 = <&pcie5_default>;
@@ -1148,10 +1147,12 @@ &pcie5_phy {
 	status = "okay";
 };
 
-&pcie6a {
-	perst-gpios = <&tlmm 152 GPIO_ACTIVE_LOW>;
-	wake-gpios = <&tlmm 154 GPIO_ACTIVE_LOW>;
+&pcie5_port0 {
+	reset-gpios = <&tlmm 149 GPIO_ACTIVE_LOW>;
+	wake-gpios = <&tlmm 151 GPIO_ACTIVE_LOW>;
+};
 
+&pcie6a {
 	vddpe-3v3-supply = <&vreg_nvme>;
 
 	pinctrl-0 = <&pcie6a_default>;
@@ -1167,6 +1168,11 @@ &pcie6a_phy {
 	status = "okay";
 };
 
+&pcie6a_port0 {
+	reset-gpios = <&tlmm 152 GPIO_ACTIVE_LOW>;
+	wake-gpios = <&tlmm 154 GPIO_ACTIVE_LOW>;
+};
+
 &pm8550_gpios {
 	rtmr0_default: rtmr0-reset-n-active-state {
 		pins = "gpio10";
diff --git a/arch/arm64/boot/dts/qcom/x1e80100-asus-vivobook-s15.dts b/arch/arm64/boot/dts/qcom/x1e80100-asus-vivobook-s15.dts
index 34467b84a2fa..17269eb0638a 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-asus-vivobook-s15.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-asus-vivobook-s15.dts
@@ -907,9 +907,6 @@ &mdss_dp3_phy {
 };
 
 &pcie4 {
-	perst-gpios = <&tlmm 146 GPIO_ACTIVE_LOW>;
-	wake-gpios = <&tlmm 148 GPIO_ACTIVE_LOW>;
-
 	pinctrl-0 = <&pcie4_default>;
 	pinctrl-names = "default";
 
@@ -924,6 +921,9 @@ &pcie4_phy {
 };
 
 &pcie4_port0 {
+	reset-gpios = <&tlmm 146 GPIO_ACTIVE_LOW>;
+	wake-gpios = <&tlmm 148 GPIO_ACTIVE_LOW>;
+
 	wifi@0 {
 		compatible = "pci17cb,1107";
 		reg = <0x10000 0x0 0x0 0x0 0x0>;
@@ -941,9 +941,6 @@ wifi@0 {
 };
 
 &pcie6a {
-	perst-gpios = <&tlmm 152 GPIO_ACTIVE_LOW>;
-	wake-gpios = <&tlmm 154 GPIO_ACTIVE_LOW>;
-
 	vddpe-3v3-supply = <&vreg_nvme>;
 
 	pinctrl-0 = <&pcie6a_default>;
@@ -959,6 +956,11 @@ &pcie6a_phy {
 	status = "okay";
 };
 
+&pcie6a_port0 {
+	reset-gpios = <&tlmm 152 GPIO_ACTIVE_LOW>;
+	wake-gpios = <&tlmm 154 GPIO_ACTIVE_LOW>;
+};
+
 &pm8550_gpios {
 	rtmr0_default: rtmr0-reset-n-active-state {
 		pins = "gpio10";
diff --git a/arch/arm64/boot/dts/qcom/x1e80100-asus-zenbook-a14.dts b/arch/arm64/boot/dts/qcom/x1e80100-asus-zenbook-a14.dts
index 0408ade7150f..b42318c75ed2 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-asus-zenbook-a14.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-asus-zenbook-a14.dts
@@ -82,6 +82,9 @@ &gpu_zap_shader {
 };
 
 &pcie4_port0 {
+	reset-gpios = <&tlmm 146 GPIO_ACTIVE_LOW>;
+	wake-gpios = <&tlmm 148 GPIO_ACTIVE_LOW>;
+
 	wifi@0 {
 		compatible = "pci17cb,1107";
 		reg = <0x10000 0x0 0x0 0x0 0x0>;
diff --git a/arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dts b/arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dts
index 2f533e56c8c8..4c95b1af2c64 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dts
@@ -941,9 +941,6 @@ &mdss_dp3_phy {
 };
 
 &pcie4 {
-	perst-gpios = <&tlmm 146 GPIO_ACTIVE_LOW>;
-	wake-gpios = <&tlmm 148 GPIO_ACTIVE_LOW>;
-
 	pinctrl-0 = <&pcie4_default>;
 	pinctrl-names = "default";
 
@@ -958,6 +955,9 @@ &pcie4_phy {
 };
 
 &pcie4_port0 {
+	reset-gpios = <&tlmm 146 GPIO_ACTIVE_LOW>;
+	wake-gpios = <&tlmm 148 GPIO_ACTIVE_LOW>;
+
 	wifi@0 {
 		compatible = "pci17cb,1107";
 		reg = <0x10000 0x0 0x0 0x0 0x0>;
@@ -975,9 +975,6 @@ wifi@0 {
 };
 
 &pcie6a {
-	perst-gpios = <&tlmm 152 GPIO_ACTIVE_LOW>;
-	wake-gpios = <&tlmm 154 GPIO_ACTIVE_LOW>;
-
 	vddpe-3v3-supply = <&vreg_nvme>;
 
 	pinctrl-0 = <&pcie6a_default>;
@@ -993,6 +990,11 @@ &pcie6a_phy {
 	status = "okay";
 };
 
+&pcie6a_port0 {
+	reset-gpios = <&tlmm 152 GPIO_ACTIVE_LOW>;
+	wake-gpios = <&tlmm 154 GPIO_ACTIVE_LOW>;
+};
+
 &pm8550_gpios {
 	rtmr0_default: rtmr0-reset-n-active-state {
 		pins = "gpio10";
diff --git a/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts b/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts
index 4c31d14a07bc..d6472e5a3f9f 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts
@@ -1160,9 +1160,6 @@ wifi@0 {
 };
 
 &pcie6a {
-	perst-gpios = <&tlmm 152 GPIO_ACTIVE_LOW>;
-	wake-gpios = <&tlmm 154 GPIO_ACTIVE_LOW>;
-
 	vddpe-3v3-supply = <&vreg_nvme>;
 
 	pinctrl-0 = <&pcie6a_default>;
@@ -1178,6 +1175,11 @@ &pcie6a_phy {
 	status = "okay";
 };
 
+&pcie6a_port0 {
+	reset-gpios = <&tlmm 152 GPIO_ACTIVE_LOW>;
+	wake-gpios = <&tlmm 154 GPIO_ACTIVE_LOW>;
+};
+
 &pm8550_gpios {
 	rtmr0_default: rtmr0-reset-n-active-state {
 		pins = "gpio10";
diff --git a/arch/arm64/boot/dts/qcom/x1e80100-microsoft-romulus.dtsi b/arch/arm64/boot/dts/qcom/x1e80100-microsoft-romulus.dtsi
index 7e1e808ea983..37539a09b76e 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-microsoft-romulus.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100-microsoft-romulus.dtsi
@@ -1094,9 +1094,6 @@ &mdss_dp3_phy {
 };
 
 &pcie3 {
-	perst-gpios = <&tlmm 143 GPIO_ACTIVE_LOW>;
-	wake-gpios = <&tlmm 145 GPIO_ACTIVE_HIGH>;
-
 	pinctrl-0 = <&pcie3_default>;
 	pinctrl-names = "default";
 
@@ -1112,6 +1109,11 @@ &pcie3_phy {
 	status = "okay";
 };
 
+&pcie3_port0 {
+	reset-gpios = <&tlmm 143 GPIO_ACTIVE_LOW>;
+	wake-gpios = <&tlmm 145 GPIO_ACTIVE_LOW>;
+};
+
 &pcie4 {
 	status = "okay";
 };
@@ -1124,6 +1126,9 @@ &pcie4_phy {
 };
 
 &pcie4_port0 {
+	reset-gpios = <&tlmm 146 GPIO_ACTIVE_LOW>;
+	wake-gpios = <&tlmm 148 GPIO_ACTIVE_LOW>;
+
 	wifi@0 {
 		compatible = "pci17cb,1107";
 		reg = <0x10000 0x0 0x0 0x0 0x0>;
@@ -1141,9 +1146,6 @@ wifi@0 {
 };
 
 &pcie6a {
-	perst-gpios = <&tlmm 152 GPIO_ACTIVE_LOW>;
-	wake-gpios = <&tlmm 154 GPIO_ACTIVE_LOW>;
-
 	vddpe-3v3-supply = <&vreg_nvme>;
 
 	pinctrl-0 = <&pcie6a_default>;
@@ -1159,6 +1161,11 @@ &pcie6a_phy {
 	status = "okay";
 };
 
+&pcie6a_port0 {
+	reset-gpios = <&tlmm 152 GPIO_ACTIVE_LOW>;
+	wake-gpios = <&tlmm 154 GPIO_ACTIVE_LOW>;
+};
+
 &pm8550_gpios {
 	rtmr0_default: rtmr0-reset-n-active-state {
 		pins = "gpio10";
diff --git a/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts b/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts
index b742aabd9c04..1d402ef86512 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts
@@ -979,8 +979,6 @@ pm_sde7_main_3p3_en: pcie-main-3p3-default-state {
 &pcie3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pcie3_default>;
-	perst-gpios = <&tlmm 143 GPIO_ACTIVE_LOW>;
-	wake-gpios = <&tlmm 145 GPIO_ACTIVE_LOW>;
 
 	status = "okay";
 };
@@ -992,16 +990,16 @@ &pcie3_phy {
 	status = "okay";
 };
 
-&pcie3_port {
+&pcie3_port0 {
 	vpcie12v-supply = <&vreg_pcie_12v>;
 	vpcie3v3-supply = <&vreg_pcie_3v3>;
 	vpcie3v3aux-supply = <&vreg_pcie_3v3_aux>;
+
+	reset-gpios = <&tlmm 143 GPIO_ACTIVE_LOW>;
+	wake-gpios = <&tlmm 145 GPIO_ACTIVE_LOW>;
 };
 
 &pcie4 {
-	perst-gpios = <&tlmm 146 GPIO_ACTIVE_LOW>;
-	wake-gpios = <&tlmm 148 GPIO_ACTIVE_LOW>;
-
 	pinctrl-0 = <&pcie4_default>;
 	pinctrl-names = "default";
 
@@ -1016,6 +1014,9 @@ &pcie4_phy {
 };
 
 &pcie4_port0 {
+	reset-gpios = <&tlmm 146 GPIO_ACTIVE_LOW>;
+	wake-gpios = <&tlmm 148 GPIO_ACTIVE_LOW>;
+
 	wifi@0 {
 		compatible = "pci17cb,1107";
 		reg = <0x10000 0x0 0x0 0x0 0x0>;
@@ -1033,9 +1034,6 @@ wifi@0 {
 };
 
 &pcie6a {
-	perst-gpios = <&tlmm 152 GPIO_ACTIVE_LOW>;
-	wake-gpios = <&tlmm 154 GPIO_ACTIVE_LOW>;
-
 	vddpe-3v3-supply = <&vreg_nvme>;
 
 	pinctrl-names = "default";
@@ -1051,6 +1049,11 @@ &pcie6a_phy {
 	status = "okay";
 };
 
+&pcie6a_port0 {
+	reset-gpios = <&tlmm 152 GPIO_ACTIVE_LOW>;
+	wake-gpios = <&tlmm 154 GPIO_ACTIVE_LOW>;
+};
+
 &qupv3_0 {
 	status = "okay";
 };
-- 
2.34.1


