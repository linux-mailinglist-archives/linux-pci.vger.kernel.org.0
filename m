Return-Path: <linux-pci+bounces-30588-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20DADAE7B22
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 10:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7449E168D46
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 08:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9F129AAE3;
	Wed, 25 Jun 2025 08:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Nxp25/KU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E98A29899A;
	Wed, 25 Jun 2025 08:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750841906; cv=none; b=rPSESbCCOD9hG+YlAXGdii/N9jcS4GMTWbpC+6kqjMkyo/HaGC1z8qViiVRE0f1Vmj/g3Cgbn6hEWXyKTHgVtGEZqcldH+fPenjaths+3LxziH3rAAhVpUanJ4pMMc94315M0x24+yaCdQJcfG1p2dfRwo2PAtb/L+XJB9oY4x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750841906; c=relaxed/simple;
	bh=yhjZTBhU/CMRtbEz7y3DxrZl7CgmLF/IsLHlNdjaslA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H+SkSevpdM/vOfrXoifeZNfeO+MFKa+jMDlPO2V2P1cEHTBLMLjR/f8gni8rzPwx1eHtLqnGkjzuDsadLVBpjm/EUy7AyYASpA1V43Dsh5ztu049qliACk8hNiV4ZZhbLqpMfAR2AS19tTclevqcuGO0O+1fTbuJNFcZ3OZlsLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Nxp25/KU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55P62hg2027443;
	Wed, 25 Jun 2025 08:58:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=G1+lkP2gGBx
	hf/sz6pg4wT4ELrreQYXqFDPuhwZPnDA=; b=Nxp25/KUWHcgA+VP4rMxCrrbxec
	kzjSS11/jmV1EBr3rku7yufqSNxlw7u2T9Ii848+hws6XSZGaRyny3KZJ1V90Vkf
	rsMHlCCIiOjmyEcbWBXEejPgywjF8ovuY/NA7ZikAz6OMqfGYG/97RgvoqWFz4FQ
	z+1+H9kogOye8ETK/oeLlRn6q8CJ1rUGQEi/FurGagXAcqGV74SrpxifwxrbhIR3
	JhbU+kOHch1xGiePqSf6Pqpw1AOnnUPYB/6JepyXjoelaixQgBju0esxtLkUfqlM
	3Vf3dxVXaxIJL9JBRC8D89KkMX4oJA0kPIdaLcEYMRpMqAlsm7jjLBwuytQ==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47esa4re8w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 08:58:07 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 55P8w4oa029382;
	Wed, 25 Jun 2025 08:58:04 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 47dntmar3c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 08:58:04 +0000
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55P8w4k8029376;
	Wed, 25 Jun 2025 08:58:04 GMT
Received: from cse-cd02-lnx.ap.qualcomm.com (cse-cd02-lnx.qualcomm.com [10.64.75.246])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 55P8w37D029370
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 08:58:04 +0000
Received: by cse-cd02-lnx.ap.qualcomm.com (Postfix, from userid 4438065)
	id E3BB23834; Wed, 25 Jun 2025 16:58:02 +0800 (CST)
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
Subject: [PATCH v3 3/3] arm64: dts: qcom: sa8775p: Add PCIe lane equalization preset properties
Date: Wed, 25 Jun 2025 16:58:01 +0800
Message-Id: <20250625085801.526669-4-quic_ziyuzhan@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250625085801.526669-1-quic_ziyuzhan@quicinc.com>
References: <20250625085801.526669-1-quic_ziyuzhan@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=eLYTjGp1 c=1 sm=1 tr=0 ts=685bba1f cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=XhQEiPrLEPsAcZFVs94A:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: j-5xmPzXLYCl-Ba9u4oLdWJCOk-fQ2Vu
X-Proofpoint-ORIG-GUID: j-5xmPzXLYCl-Ba9u4oLdWJCOk-fQ2Vu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDA2NiBTYWx0ZWRfX2RH456irvrVB
 256toBcwNhm4bQCfsS0QwDyion+p0APjIE6E2SESQg9iiUYOEmEXaEcJgXBI8wsaDbO2Unyxasu
 9g1aRrZiOdJljx0l5lqjJzzmxzf0+7Kb6Jf7viuIdd/t1YY2j+ydHA0kiZl3iG3H/z8snLp5AbY
 /PrsdX8xS4l93ftQGZBJtuFWeHPRnFjlrdHGbf8Jxka0E32RJ97mIZvqtVKzrlUv255+uoexQ4I
 CrkAaJ2FZuVRO3V3bDNsvs9RWdS0Pzq07ViXoCg0LG7MyEBiDOO9uWK7QtBJJKK8xzHfUnQfrE7
 DVyH9TCurbi7Fo8iFOfs4k9jXEj36chf70tuGm111gqcGnHnpnc37xfq38cuzlKnQnvpdQsCy5R
 PHcOlTWi1r4LMpnf1xaLljb628sBpVTgdi2Iv3l14kIrRKvOed6latFcDWmQwG6ofo5cUjt4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-25_02,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 mlxscore=0 clxscore=1015 mlxlogscore=948
 suspectscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 adultscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506250066

Add PCIe lane equalization preset properties with all values set to 5 for
8.0 GT/s and 16.0 GT/s data rates to enhance link stability.

Co-developed-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
Signed-off-by: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sa8775p.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
index 45f536633f64..16caf1da0708 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
@@ -7159,6 +7159,9 @@ pcie0: pcie@1c00000 {
 		phys = <&pcie0_phy>;
 		phy-names = "pciephy";
 
+		eq-presets-8gts = /bits/ 16 <0x5555 0x5555>;
+		eq-presets-16gts = /bits/ 8 <0x55 0x55>;
+
 		status = "disabled";
 
 		pcieport0: pcie@0 {
@@ -7317,6 +7320,9 @@ pcie1: pcie@1c10000 {
 		phys = <&pcie1_phy>;
 		phy-names = "pciephy";
 
+		eq-presets-8gts = /bits/ 16 <0x5555 0x5555 0x5555 0x5555>;
+		eq-presets-16gts = /bits/ 8 <0x55 0x55 0x55 0x55>;
+
 		status = "disabled";
 
 		pcie@0 {
-- 
2.34.1


