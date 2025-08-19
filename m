Return-Path: <linux-pci+bounces-34255-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6FAEB2BA77
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 09:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6A891881A45
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 07:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96FFD30F81D;
	Tue, 19 Aug 2025 07:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SmRyhrOv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88222D24B5;
	Tue, 19 Aug 2025 07:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755587832; cv=none; b=M2/ReAaZF7Dt5aTfNjTrZndq4jgTEQL8GThmumh3kGV/1jgkemX1DzN8vAJYO8PoezOdPfHqzFVAeDtoIC0GqPhcEi/ZUbJUmZKy0UwvMsrcszlNbiREySTnv2x79mPlJm7OgrD6ZgN8uqrrUAgWSyszcXcBRenJEOc5ltitMow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755587832; c=relaxed/simple;
	bh=AO3Svb7amvH3U1MStab6ii4uX+OvYJMu0QBbS3RBxrg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HEUBQ+viDTckrzvKRcjhSBHHfV9KE6p2tfV+OhALtqtzsCyhTt9gNKYXgeGbP8kXXmdBvtvgxklQ1Pul3KG0opJyvQIMTe8Or4T4GDGuGIftpbp9/JVgU0QE2DNL3++GMEPRZicb8BxB3tiX6U060WF1q92MDltYkiH37UHTbe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SmRyhrOv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57J2XO6m025437;
	Tue, 19 Aug 2025 07:17:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=//1D9BhlkxD
	UMN81wQ6h1zTzvFR0McEnfmR7capf9gc=; b=SmRyhrOvszwe47aF9PWdIeM817U
	RV8N+lpbKiWQItHBsB3DkJYhuxa9MC2VA92JwVhcO2oN0lCrlJKFpMY7hw3PW6bB
	ZoQ4egD/zLXK4EyA7BNV2EWOZDnHWF1laRIs2xrQjC/a3822beMUwthbjvVklfMc
	8AYRhiv36hm1g/fkWSBwcAZYw3lRgU4D8jYemxhFDPqMhuyOTdiATzFk3AZIkv67
	CePIai1UMbpAVasKBWiWXvB6Jl5E3Lh4gqK9PaTmx965shYBS7pTgQvHPA04GpNx
	33Hnfja/G7Tmc2aHUxZgmLYJYFQEpZg6nCmviWz5lwGtohYB1DU9QUZ3EXQ==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48m71cja5x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Aug 2025 07:17:00 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 57J7GvVq023673;
	Tue, 19 Aug 2025 07:16:57 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 48jk2m3aeq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Aug 2025 07:16:57 +0000
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 57J7GvxR023663;
	Tue, 19 Aug 2025 07:16:57 GMT
Received: from ziyuzhan-gv.ap.qualcomm.com (ziyuzhan-gv.qualcomm.com [10.64.66.102])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 57J7Gu9N023660
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Aug 2025 07:16:57 +0000
Received: by ziyuzhan-gv.ap.qualcomm.com (Postfix, from userid 4438065)
	id 32A4F522; Tue, 19 Aug 2025 15:16:55 +0800 (CST)
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
Subject: [PATCH v5 3/3] arm64: dts: qcom: lemans: Add PCIe lane equalization preset properties
Date: Tue, 19 Aug 2025 15:16:48 +0800
Message-ID: <20250819071649.1531437-4-ziyue.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250819071649.1531437-1-ziyue.zhang@oss.qualcomm.com>
References: <20250819071649.1531437-1-ziyue.zhang@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: 1XUpdL3SLKl8GS8WupVk43IarHkXwmFV
X-Proofpoint-GUID: 1XUpdL3SLKl8GS8WupVk43IarHkXwmFV
X-Authority-Analysis: v=2.4 cv=IvQecK/g c=1 sm=1 tr=0 ts=68a424ec cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=XhQEiPrLEPsAcZFVs94A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE4MDE0NyBTYWx0ZWRfXwZ7aui0N68zB
 M/WTTO1Lh1dk9FuGsk8h9YMoOv3WrUDJOkITulpmuTvouw1llIzSDjeQ5b7kt3wYfmXzbZuGaFl
 s+ak6hPAhR/M4o4Uj8xYypV/K4YClJNoKM8PSYCfZpq2MXXgIUOfEV5jqMpVwTYsKlO1an+Kh4q
 GcZZJGgkLLXjQEnBLhdVPbMkv+Vin/G/Ud9fdRH2J1LAEly+NkYpDsBxEvsckPbQIeaesPVEkz+
 JHdixMCwHAmB0kfGAM9dFWKxLSfwOTzAgIi6gs5o9UGBUxMZEW6kYshDUAv4HF2Z5QJX932ARvX
 HNmVrCq02rVNSl629e4hGV628yt9sErrWHASzlhYjrxNbw+ff3wssroCUNmtFo2zxFaS7K54iT4
 1aLool1l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_01,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508180147

Add PCIe lane equalization preset properties with all values set to 5 for
8.0 GT/s and 16.0 GT/s data rates to enhance link stability.

Co-developed-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
Signed-off-by: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Acked-by: Manivannan Sadhasivam <mani@kernel.org>
---
 arch/arm64/boot/dts/qcom/lemans.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans.dtsi b/arch/arm64/boot/dts/qcom/lemans.dtsi
index 64f5378c6a47..c7a09c3605a7 100644
--- a/arch/arm64/boot/dts/qcom/lemans.dtsi
+++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
@@ -7657,6 +7657,10 @@ pcie0: pcie@1c00000 {
 		phys = <&pcie0_phy>;
 		phy-names = "pciephy";
 
+		eq-presets-8gts = /bits/ 16 <0x5555 0x5555>;
+		eq-presets-16gts = /bits/ 8 <0x55 0x55>;
+
+
 		status = "disabled";
 
 		pcieport0: pcie@0 {
@@ -7827,6 +7831,9 @@ pcie1: pcie@1c10000 {
 		phys = <&pcie1_phy>;
 		phy-names = "pciephy";
 
+		eq-presets-8gts = /bits/ 16 <0x5555 0x5555 0x5555 0x5555>;
+		eq-presets-16gts = /bits/ 8 <0x55 0x55 0x55 0x55>;
+
 		status = "disabled";
 
 		pcie@0 {
-- 
2.43.0


