Return-Path: <linux-pci+bounces-29405-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D5EAD5125
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 12:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87A3F3A8EA9
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 10:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A9EB2750EE;
	Wed, 11 Jun 2025 10:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="d+954Id+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B8A274FD4;
	Wed, 11 Jun 2025 10:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749636259; cv=none; b=o7kgT6b42V6uzZrMmArlI3yLDe8Ui8kzOCBQfhjwxnvzBENNJZaeu2Sq5zxQXm8EVVE5+ze4hznVPdhrHVzHQNUIXRfUpRiB9gRrCF/uF7opnhDGpbV/H3QyXy37Ata34a47vDs+GT+k1FUkE6nMJTSH/2fPSjvLsbgi4lUtinU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749636259; c=relaxed/simple;
	bh=RFgCtVMofSj20DC2HsTXRYIKA4GXKaTzKHDuAym8P3Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kqenjlIi8f2GcOUDtkhdOOJ1SxGM9E9YCqIGruOhGwDAEo9LfAf2REDO+S8PJp4DFbgvKOX9P9eVdwsQv8roqqtN4V1FTadai+U11ZjMS43NVNmcNdB00IBCq+2ql5ZMLRVXzGk37zCJ3V0FE9Ehxb1tqBALGcleT529xubSVBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=d+954Id+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55B9DDAE027374;
	Wed, 11 Jun 2025 10:04:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=PyTMukYKDHU
	2sykGqMCmcg2+gvtVPkpU7oukT+Wla2U=; b=d+954Id+Gd1/wRII975Y52UDOLc
	qUJ2DtIw0hH3SjH4Hx8NwxRjsJbqm5hUfRO7UEsEKjlPd/dtK3jHOFTYS3fgFtCM
	DrFbWcP86jlObalWHOmwsN1vU380gn6QvyzRJKGd2svUTAmlxMnSYqeHe+x7XusM
	WcqB/xvdoR63B6HQAPWodZbo9/YtSpcH31N2Tx0BTiuQ2E/Ba8prGc+3qO32to/Z
	xw0O+6xoNk6ePEgmLcly/uDWbP9rNXcYrfxW6Zn7Jd7ONpgkd6OMdDgAmJ65JKp1
	mh5RsGCwkbeD5vhCiIl4RQhG+hF0AA1DHV30LUXi3m59KXabiZPPbuOsXug==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 476jrhbga2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Jun 2025 10:04:01 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 55BA3x6E003268;
	Wed, 11 Jun 2025 10:03:59 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 474egm8eb3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Jun 2025 10:03:59 +0000
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55BA3wnK003263;
	Wed, 11 Jun 2025 10:03:58 GMT
Received: from cse-cd02-lnx.ap.qualcomm.com (cse-cd02-lnx.qualcomm.com [10.64.75.246])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 55BA3v7Z003259
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Jun 2025 10:03:58 +0000
Received: by cse-cd02-lnx.ap.qualcomm.com (Postfix, from userid 4438065)
	id A6CB13699; Wed, 11 Jun 2025 18:03:56 +0800 (CST)
From: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
To: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, jingoohan1@gmail.com,
        mani@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org,
        bhelgaas@google.com, johan+linaro@kernel.org, vkoul@kernel.org,
        kishon@kernel.org, dmitry.baryshkov@linaro.org,
        manivannan.sadhasivam@linaro.org, neil.armstrong@linaro.org,
        abel.vesa@linaro.org, kw@linux.com
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org, qiang.yu@oss.qualcomm.com,
        quic_krichai@quicinc.com, quic_vbadigan@quicinc.com,
        Ziyue Zhang <quic_ziyuzhan@quicinc.com>
Subject: [PATCH v2 2/2] arm64: dts: qcom: sa8775p: Add PCIe lane equalization preset properties
Date: Wed, 11 Jun 2025 18:03:19 +0800
Message-Id: <20250611100319.464803-3-quic_ziyuzhan@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250611100319.464803-1-quic_ziyuzhan@quicinc.com>
References: <20250611100319.464803-1-quic_ziyuzhan@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=EovSrTcA c=1 sm=1 tr=0 ts=68495492 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=XhQEiPrLEPsAcZFVs94A:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: q6XU97VsqnWmWczYSP2sak5ceS1q-dvj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjExMDA4NiBTYWx0ZWRfX8ir4l6S4ysi6
 4gzOE0nRn15A+Ycq3UjyIHWcILsz0lU3h+NYvkH/n3Ax+RwD7q83niKswjmDXou2AX/o0Lj9dbH
 k/CgcwYlNqqpEsxQdIv0yvEXlgdpZmmrgbWKxqpZXACLBfbxiTs9a3kEU8BIJ7jM5SoqIqSB5vD
 /7V5D1ICaWDwU9HE2z2RoIo7ypc8/LHbkiU2/R6pHSsjsukpY8apWjMjL9XS7uasH0tHPDkJfu+
 hsiLc5DyDvPPwJwMirkzUyy18VEwoZ+DbOcWGO8XPeeFPMTcpfW5W5CMVT3l/ljuoV4M0sv2/Ug
 XFiO8ckhvRZxQdRJcqHn+hv835l08MC22TuuGleW/O/Y+1osz8yFX/aSRnmyFw28shUopoZNHyF
 lAe3y8Pmai+PGtSzgPoZSgfsKjQZ5YVwGLeMR6ACSq0iSLOtcIVWDWY6t9lJEKO4jUi6z1R7
X-Proofpoint-GUID: q6XU97VsqnWmWczYSP2sak5ceS1q-dvj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-11_04,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 suspectscore=0 priorityscore=1501 mlxlogscore=888
 mlxscore=0 clxscore=1011 malwarescore=0 adultscore=0 lowpriorityscore=0
 phishscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506110086

Add PCIe lane equalization preset properties with all values set to 5 for
8.0 GT/s and 16.0 GT/s data rates to enhance link stability.

Co-developed-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
Signed-off-by: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
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


