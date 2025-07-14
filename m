Return-Path: <linux-pci+bounces-32054-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B539B03945
	for <lists+linux-pci@lfdr.de>; Mon, 14 Jul 2025 10:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FAF018823C2
	for <lists+linux-pci@lfdr.de>; Mon, 14 Jul 2025 08:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736D3239E82;
	Mon, 14 Jul 2025 08:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="J32RBz1d"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BC01F12F8;
	Mon, 14 Jul 2025 08:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752481287; cv=none; b=IuMj6prTZH0BWiFZ7vxIitNJnjczFOgaSis5Y7Nn2750SvigptMP4oWPI4zUavbTWPn23rNJOR+19/HzEA0R0lXPF0YYeo9IQJIUEqAbWuayPka8kEC+QPJ/b6g/DB5XY9/dZbgcAjsLfvCBRAmhpj5l7rQ61doH8a+LV8ZaMvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752481287; c=relaxed/simple;
	bh=xf8E3mTKLKNDt/uFoPbwF0rKkjiqqp4ib0qQLHjwONE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IPmiKvYmbjFeGejLftNuMCZdPxuFSIpmV58QFKoeCT/yICG8jbGHXR34qIfjSOlW09r+No5tTPcrI50hSsujJTVSBwAnWYrNWBD5FGMDatoXc5J6cn2q0FCn9UAKNBqvtRqasTEHnNP5WpAMFe2yalhyXDeoo/IszbeNZpDxXm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=J32RBz1d; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56DLNams011767;
	Mon, 14 Jul 2025 08:21:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=5KIqd5dXmDA
	Ssnu5jDhDvZylTgu0oselmBmhCj+Y0oM=; b=J32RBz1dRoFAzu9Yc/yRMdwt7Ta
	wgyCbxguyWuSPbJ4UIS/vXTfvGTYXEZPBu6gW5Vpfe4sm85wO9QVdgYc5MGE1ctJ
	Lnvun1RkhhUedr/j+5ctKhWrS3ZNtj/hW/JHjfkIctbMb4gvFt80maKItLWnmbT+
	vt4WySCq8vEKEmdBcE4gA1JNU52SZA74T7p95L8oH8NVnIRIYURISkFvZhoVbqK5
	JTQHLoev7ajHy75qz9HEmECEinzeSkNh6oBEXN8YZiMMVN2s7zDmuWiKKoFXMTVy
	f/N7RolfbMGv4XPjBk0XepHxdOIVPVNkU0eaxLg2UqIlcUgvospARvkovyg==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ufut3s0r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Jul 2025 08:21:16 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 56E8LDKU032020;
	Mon, 14 Jul 2025 08:21:13 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 47ugsm6338-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Jul 2025 08:21:13 +0000
Received: from APTAIPPMTA02.qualcomm.com (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 56E8LDKE032008;
	Mon, 14 Jul 2025 08:21:13 GMT
Received: from cse-cd01-lnx.ap.qualcomm.com (cse-cd01-lnx.qualcomm.com [10.64.75.209])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 56E8LCCd032002
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Jul 2025 08:21:13 +0000
Received: by cse-cd01-lnx.ap.qualcomm.com (Postfix, from userid 4438065)
	id CC9E420F45; Mon, 14 Jul 2025 16:21:11 +0800 (CST)
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
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: [PATCH v4 3/3] arm64: dts: qcom: sa8775p: Add PCIe lane equalization preset properties
Date: Mon, 14 Jul 2025 16:21:10 +0800
Message-Id: <20250714082110.3890821-4-ziyue.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250714082110.3890821-1-ziyue.zhang@oss.qualcomm.com>
References: <20250714082110.3890821-1-ziyue.zhang@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=e7gGSbp/ c=1 sm=1 tr=0 ts=6874bdfc cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=XhQEiPrLEPsAcZFVs94A:9
X-Proofpoint-GUID: rzsydKhOlECfmiL0gSDhNmalWlCFsJd6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDA0OCBTYWx0ZWRfXw3ZEPXEyIW92
 4tO88oFBuwO57mdZt6uSRB05VHDznfT5JwZISLttNV/V7XKXhAsEdsQ+oqjbw92BuZE4lCALVXk
 7rz5NQ1k02UoPI6tUlIFq/GkHonogE+bYDAHwLVtnLzyrfJHkqfdypBhv57Z7xXAtyiUSYAYSFE
 mOb26qXsWwa0dgrGVako8zUbGCmsY6wAsBIBJ5L/ScUWe4Q90653IUtDxHVgNtphvZg8xuco0uU
 PDLgcncMsEn1ScDvktJSjYW6jLY2YksocF+vI+kJGZ8h731tihwXfydy4LFjWwsMoQlyoqaprjj
 75QcwA6NsH48ZcBA5mTTdS7wH/Cl1vzvADKT6WXl2Xv37aJ0eCwvKft11k9dPapR8AxTF3qwaL9
 znk9dnUU/au8gsJAAlEZFYwTMqmUe7rAd/kZDwWWx8REItorfCLt+5dg3ngMiNUBMYWgo1na
X-Proofpoint-ORIG-GUID: rzsydKhOlECfmiL0gSDhNmalWlCFsJd6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 spamscore=0 suspectscore=0
 phishscore=0 bulkscore=0 impostorscore=0 clxscore=1015 adultscore=0
 malwarescore=0 mlxlogscore=956 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507140048

Add PCIe lane equalization preset properties with all values set to 5 for
8.0 GT/s and 16.0 GT/s data rates to enhance link stability.

Co-developed-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
Signed-off-by: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Acked-by: Manivannan Sadhasivam <mani@kernel.org>
---
 arch/arm64/boot/dts/qcom/sa8775p.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
index fed34717460f..61f094c51815 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
@@ -7642,6 +7642,9 @@ pcie0: pcie@1c00000 {
 		phys = <&pcie0_phy>;
 		phy-names = "pciephy";
 
+		eq-presets-8gts = /bits/ 16 <0x5555 0x5555>;
+		eq-presets-16gts = /bits/ 8 <0x55 0x55>;
+
 		status = "disabled";
 
 		pcieport0: pcie@0 {
@@ -7808,6 +7811,9 @@ pcie1: pcie@1c10000 {
 		phys = <&pcie1_phy>;
 		phy-names = "pciephy";
 
+		eq-presets-8gts = /bits/ 16 <0x5555 0x5555 0x5555 0x5555>;
+		eq-presets-16gts = /bits/ 8 <0x55 0x55 0x55 0x55>;
+
 		status = "disabled";
 
 		pcie@0 {
-- 
2.34.1


