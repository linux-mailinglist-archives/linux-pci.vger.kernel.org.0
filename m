Return-Path: <linux-pci+bounces-16950-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 804639CFC29
	for <lists+linux-pci@lfdr.de>; Sat, 16 Nov 2024 02:38:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2069C2880B6
	for <lists+linux-pci@lfdr.de>; Sat, 16 Nov 2024 01:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C095019149F;
	Sat, 16 Nov 2024 01:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hWRoc7AA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490AB19066D;
	Sat, 16 Nov 2024 01:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731721082; cv=none; b=Zo7Ov3FmTkYaWX67gs0NKT+0vBLu+8D2IGIeVlf1WEq6G8x2P1/IQ11/mVC5BBU48LOpM5U0nFwnpUK8FQWy8ULG4WuntwSgoIxhINYmGcU+w+3yv2eeHCw/glTbpP8qFwAiplogXx6d/eeTREWwWoB+gEsM3xFlLzTf6PIuipc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731721082; c=relaxed/simple;
	bh=pwZvnyv6qDCbpznbV8W3dD3o92sRzf62XzQBwDrGy+s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Sq68tdPzoO8r+3ylXsdTA3grmXPULKdTOyc0/H4bfbAo1rZ2A4D4CdkIIZ6eE4P+isszCCHBVfrqfJL02VK6OFFhpPRb2Iv6hvE43X0Zm/xk9Y+BrRBdmVdMD7CL9y5Xv48XoxS5KMW/WtPi1bHjSUAaHP25XE0e+zBo2RayTao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hWRoc7AA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFBmlrR014249;
	Sat, 16 Nov 2024 01:37:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	up93JY/54vUH41AYL6hMWDNcD057lk+BWeQKbhHzAl4=; b=hWRoc7AA6R5ioX+W
	qJqkRa9jerx7uHcgZ6nxznmAswsmZSaLDZNtFKoAae6qsZPN3sXVcYsAf+FGGIBF
	CVUoV8PcCo053dEyVOTg1xclukwqHsgafq06j7p1zXlCQRBcLNOqfnvCroUDv+wv
	mB5cPWfjS7j9KZ685wHCcVfZsJ077igmRUhHWt3v2qZZnN9xd4a5IrTVj3l4rt3h
	uNJBKUNTSnTnWD3glw2MzK7MKYlUzE2FcBN4EJzf+AlECAZN4PE0XjQLPIf1Icz8
	IqlCcfUxA03tnrnsLVBm+hj7c286RIPOiFijyqsBqGynpoa+PUtsXZrbKIwPjWDi
	P354fg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42wwddb8b3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Nov 2024 01:37:50 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AG1bouV022885
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Nov 2024 01:37:50 GMT
Received: from hu-krichai-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 15 Nov 2024 17:37:43 -0800
From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Date: Sat, 16 Nov 2024 07:07:30 +0530
Subject: [PATCH 1/4] arm64: dts: qcom: x1e80100: Add PCIe lane equalization
 preset properties
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241116-presets-v1-1-878a837a4fee@quicinc.com>
References: <20241116-presets-v1-0-878a837a4fee@quicinc.com>
In-Reply-To: <20241116-presets-v1-0-878a837a4fee@quicinc.com>
To: <quic_mrana@quicinc.com>, <quic_vbadigan@quicinc.com>,
        <kernel@quicinc.com>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Helgaas
	<bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        "Manivannan
 Sadhasivam" <manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi
	<lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        "Krishna
 chaitanya chundru" <quic_krichai@quicinc.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731721058; l=1230;
 i=quic_krichai@quicinc.com; s=20230907; h=from:subject:message-id;
 bh=pwZvnyv6qDCbpznbV8W3dD3o92sRzf62XzQBwDrGy+s=;
 b=hTI2C00fhl3jD2Sgr/J0YQFzKPeHlIYaADTKl2A2Ot85f1Tm8Zwh2JX8NwSxyczP5HwstJ1iz
 uDXh55bf+s4AIm6fnhk7G4f2+J384avggN7+8lTcPGpFxGorer1GxQ6
X-Developer-Key: i=quic_krichai@quicinc.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: OavDK87WgCuZo4qhvNWOIpY8xIhc8ktc
X-Proofpoint-ORIG-GUID: OavDK87WgCuZo4qhvNWOIpY8xIhc8ktc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=732 mlxscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 phishscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411160011

Add PCIe lane equalization preset properties for 8 GT/s and 16 GT/s data
rates used in lane equalization procedure.

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
 arch/arm64/boot/dts/qcom/x1e80100.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
index a36076e3c56b..6a2074297030 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
@@ -2993,6 +2993,10 @@ &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
 			phys = <&pcie6a_phy>;
 			phy-names = "pciephy";
 
+			eq-presets-8gts = /bits/ 16 <0x5555 0x5555>;
+
+			eq-presets-16gts = /bits/ 8 <0x55 0x55>;
+
 			status = "disabled";
 		};
 
@@ -3115,6 +3119,8 @@ &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
 			phys = <&pcie5_phy>;
 			phy-names = "pciephy";
 
+			eq-presets-8gts = /bits/ 16 <0x5555 0x5555>;
+
 			status = "disabled";
 		};
 
@@ -3235,6 +3241,8 @@ &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
 			phys = <&pcie4_phy>;
 			phy-names = "pciephy";
 
+			eq-presets-8gts = /bits/ 16 <0x5555 0x5555>;
+
 			status = "disabled";
 
 			pcie4_port0: pcie@0 {

-- 
2.34.1


