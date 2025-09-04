Return-Path: <linux-pci+bounces-35434-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0ECFB432E3
	for <lists+linux-pci@lfdr.de>; Thu,  4 Sep 2025 08:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A187A1C257CE
	for <lists+linux-pci@lfdr.de>; Thu,  4 Sep 2025 06:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6A8286D63;
	Thu,  4 Sep 2025 06:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="I2LZhG1b"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D93427932D;
	Thu,  4 Sep 2025 06:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756968770; cv=none; b=NJA1dPh+OCg8aCDK2/10KGX0Lm+pztSJslmI8d0bu23jek2/rrRfvNntHiIw+/b++MEhfs/XLkqb7Tac3XNWBTXJxCzdXanZltlrqhGjzh31F/lL7WJhFkbNfqXVgE5gcnXEbe594niMXzmu3G9rqf27jRLd2xyKcvSVG/mZdkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756968770; c=relaxed/simple;
	bh=BFiVUX5SnGpXTU5EPsk3g7ynGmoCRddVJ9DCtF02gxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kl9BTzi42QLCYW1evAe6U26Z7s9k5ZVRZrV51y9eLWKOnkGZSBEbBEtPguTM1f4xPNMW//JCbrNJv/k2EomCtrSNFUlhfjkmqcdx8lFNSrI8zdI1vh/yeyweaOmGluzUOAwZj9XnBTR0usWLY42blz3SKJAxNod1CZVyR0N0AQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=I2LZhG1b; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5841dIqU003427;
	Thu, 4 Sep 2025 06:52:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=ueVIig/TQlb
	tPgNi5E+6EzlMvVG+rDHGGgCXB11FwGs=; b=I2LZhG1bygSHD/ir6kKs0dnWEO6
	i55DQU8f5N6Jb1q+cB0B20MzRxUrcPzFXLFEAZeP1q7/k1PKjNwsuEMT3QcVju7H
	LjU1ExIwzzYqDSRSx7CSnpL7JE7LSxAljvCf65F3zwfVYg84Nd1ogCFzGpY6NGPD
	bfvqkmBUdh12M74UlsdqFXNKuYQyrUnPPLJxDY7vw76RzpfuhxWxAj16c3gMTofZ
	LaTzCVjQQ49Sjx7D8CVmlUk6OvhXDpDsVpfMO2q3gYhJPb+3kqekwz4BWVjBVqfb
	+eYsoGIkXsWs14WAwBGo9icbt0jawmVkguUN3M5bsSYNN5CY09IC/cXlUtQ==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ura8xd04-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Sep 2025 06:52:37 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 5846qZGd027255;
	Thu, 4 Sep 2025 06:52:35 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 48utcmhds2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Sep 2025 06:52:35 +0000
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5846qYhQ027247;
	Thu, 4 Sep 2025 06:52:35 GMT
Received: from ziyuzhan-gv.ap.qualcomm.com (ziyuzhan-gv.qualcomm.com [10.64.66.102])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 5846qYgm027242
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Sep 2025 06:52:34 +0000
Received: by ziyuzhan-gv.ap.qualcomm.com (Postfix, from userid 4438065)
	id 2DF80526; Thu,  4 Sep 2025 14:52:33 +0800 (CST)
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
Subject: [PATCH v6 3/3] arm64: dts: qcom: lemans: Add PCIe lane equalization preset properties
Date: Thu,  4 Sep 2025 14:52:25 +0800
Message-ID: <20250904065225.1762793-4-ziyue.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250904065225.1762793-1-ziyue.zhang@oss.qualcomm.com>
References: <20250904065225.1762793-1-ziyue.zhang@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: -CFzjaiGUGMpSZ7dT3JPLUgiSFozmDex
X-Proofpoint-GUID: -CFzjaiGUGMpSZ7dT3JPLUgiSFozmDex
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyMCBTYWx0ZWRfX1T2uJ7sfeDE6
 psUBpSmDG/jvJ3LMOsxFtinz6YtjgIE+S9hlyMVKLk7Dl479Bqt8ILgvX7OYqQeDNB/EBNq0uf+
 wOnt/Qgqwx76Cswy5oGBM7eyvXKzARLY7cPAvsFgrPvAZEHcM1Dna7UMAoyXpQk/6w284/0MglW
 3GANAbEqk9J4jz275qsRTxA3CFaQ7ap5eMlisV1k7tRUe+Xeb8mqwK1tU6F2q0+RESaOXy+MMyh
 asg+LhGjXqe/MD1VSgAqEzy50jZmQw3G56RFKQAnRjd2jRKF/yXuFJfAjYNoKRJqIMnse/i7aVA
 NRN1DSTRtDgMG/7q22fErWWCvmRXwzafezB2CGdSm7E0aJHmr8DzRut+GQhWQ5c9z5dHidQutcS
 mrWiXECJ
X-Authority-Analysis: v=2.4 cv=VNndn8PX c=1 sm=1 tr=0 ts=68b93736 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=XhQEiPrLEPsAcZFVs94A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_02,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300020

Add PCIe lane equalization preset properties with all values set to 5 for
8.0 GT/s and 16.0 GT/s data rates to enhance link stability.

Co-developed-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
Signed-off-by: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Acked-by: Manivannan Sadhasivam <mani@kernel.org>
---
 arch/arm64/boot/dts/qcom/lemans.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans.dtsi b/arch/arm64/boot/dts/qcom/lemans.dtsi
index 64f5378c6a47..c88bf206ea82 100644
--- a/arch/arm64/boot/dts/qcom/lemans.dtsi
+++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
@@ -7657,6 +7657,9 @@ pcie0: pcie@1c00000 {
 		phys = <&pcie0_phy>;
 		phy-names = "pciephy";
 
+		eq-presets-8gts = /bits/ 16 <0x5555 0x5555>;
+		eq-presets-16gts = /bits/ 8 <0x55 0x55>;
+
 		status = "disabled";
 
 		pcieport0: pcie@0 {
@@ -7827,6 +7830,9 @@ pcie1: pcie@1c10000 {
 		phys = <&pcie1_phy>;
 		phy-names = "pciephy";
 
+		eq-presets-8gts = /bits/ 16 <0x5555 0x5555 0x5555 0x5555>;
+		eq-presets-16gts = /bits/ 8 <0x55 0x55 0x55 0x55>;
+
 		status = "disabled";
 
 		pcie@0 {
-- 
2.43.0


