Return-Path: <linux-pci+bounces-18596-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 810D19F4867
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 11:06:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B3357A177E
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 10:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5B91DF27F;
	Tue, 17 Dec 2024 10:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fS5m6B+t"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA141DEFF3;
	Tue, 17 Dec 2024 10:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734429928; cv=none; b=nolqx/CPDql0He43GC8IVnorhfOhadmy8O8O1DrOqeYhDHAjUkIZo/REhbtiwOU2+3rFd+VT2HEsjI+jBZGjf1sC4TXS8MEJOfUqw52Jlo7kpNP5kQessPk24Jq0nKYlzE3KkidqboXXLqlWBYn+dTknywIFpFNEcYt66aJV53c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734429928; c=relaxed/simple;
	bh=DxUUQhMybSyCKy/MdqkB/V3SmHhkaLgHupuPL2IESVU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B93j/gFw9nW3dKT9gn5zNvZLtDpMJsRQadHday5HbcVVWLtMTfHrBWhh3auLS3n7Glepo80PNUgBN9+iIidU7cbh/knP5+XV4OziiG8Xm17F8lMFx343dKoZ6e1e/DMrV/ydqDRmPOU0Z5gyCg059yf6//1A/nN+qMtsWuA1NC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fS5m6B+t; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BH9sptp012176;
	Tue, 17 Dec 2024 10:04:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yu7YgqN2nrc8ynkibn+3q09CupDgDNnszhFzFN/wNx8=; b=fS5m6B+t9CFxoJDC
	IpdrrHL5KIBsiUjPsL4wSk+36flPafao5ZVH/C8kS1nNSo16tJBKDhI5P64CUKPj
	VmASgBr6Ww4Mk3NmT+yj69YScgJ8EZYRq1G7btnCCWUK2Wg7uznmrpYGKwQMDQxo
	Pu6r5T8Fa+MDgDill3J+k6xPHIxRmY8pjeNVW4lN0icCYlh+e1KE2RBIs2mlDsUc
	iEBSIjIQVE58RvjgfXuUj3mtK2rMXepeIjIB0JqdwnUrH3n7IeFVD1LEId6JCyoE
	R/8ab0g/v8qrGvZPiwJzNgEOBurXOSZsGzq+RdyJU1aydNPoFEXWn1Y3Z6Ony0zH
	rS3S6g==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43jw069h72-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Dec 2024 10:04:49 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BHA4luD008464
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Dec 2024 10:04:48 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 17 Dec 2024 02:04:41 -0800
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <andersson@kernel.org>, <konradybcio@kernel.org>,
        <p.zabel@pengutronix.de>, <quic_varada@quicinc.com>,
        <quic_nsekar@quicinc.com>, <dmitry.baryshkov@linaro.org>,
        <quic_srichara@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>
CC: Praveenkumar I <quic_ipkumar@quicinc.com>
Subject: [PATCH v3 5/5] arm64: dts: qcom: ipq5332-rdp441: Enable PCIe phys and controllers
Date: Tue, 17 Dec 2024 15:33:59 +0530
Message-ID: <20241217100359.4017214-6-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241217100359.4017214-1-quic_varada@quicinc.com>
References: <20241217100359.4017214-1-quic_varada@quicinc.com>
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
X-Proofpoint-ORIG-GUID: acak2HG5KYTFAtI1zPr-sDOtJO1jEkkG
X-Proofpoint-GUID: acak2HG5KYTFAtI1zPr-sDOtJO1jEkkG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 mlxscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 clxscore=1015 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412170082

From: Praveenkumar I <quic_ipkumar@quicinc.com>

Enable the PCIe controller and PHY nodes for RDP 441.

Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
v3: Reorder nodes alphabetically
    Fix commit subject
---
 arch/arm64/boot/dts/qcom/ipq5332-rdp441.dts | 74 +++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq5332-rdp441.dts b/arch/arm64/boot/dts/qcom/ipq5332-rdp441.dts
index 846413817e9a..2be23827b481 100644
--- a/arch/arm64/boot/dts/qcom/ipq5332-rdp441.dts
+++ b/arch/arm64/boot/dts/qcom/ipq5332-rdp441.dts
@@ -32,6 +32,32 @@ &sdhc {
 	status = "okay";
 };
 
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
+};
+
 &tlmm {
 	i2c_1_pins: i2c-1-state {
 		pins = "gpio29", "gpio30";
@@ -40,6 +66,54 @@ i2c_1_pins: i2c-1-state {
 		bias-pull-up;
 	};
 
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
+
 	sdc_default_state: sdc-default-state {
 		clk-pins {
 			pins = "gpio13";
-- 
2.34.1


