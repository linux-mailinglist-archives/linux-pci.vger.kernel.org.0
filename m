Return-Path: <linux-pci+bounces-28949-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37524ACDACF
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 11:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E67F4168F70
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 09:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E9828C5CE;
	Wed,  4 Jun 2025 09:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BoLSyjv0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20E923E33D;
	Wed,  4 Jun 2025 09:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749028806; cv=none; b=MjdpQCNhikceWKwYJiMrz/WsPIMj6siXcAGjCQCgiUaRZPgRFqFgrwz+GK3dvrNnjn0IC0HSeyrdnM9WaTqiAqq7edepGjEFvndGigu1MD+YPd+FFrocugZIRz/Uc2JmH6qOOEHvJaZpqFjC2HhoPx1PZXvF/kcu4sP+UvO1YR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749028806; c=relaxed/simple;
	bh=1Yizg3AW7rudwg8utdST3YDeVLvPupmLLFkIoSs9HnI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PmqVwdLe9MMNp5AkOLWm8UIlAEFwWlKN+Fy1y8DkadAsyPuB0wiWQAjuYygJqmo+ERjcbYj074JjcDQ78Z0oWUR31KDQ65GBkhD2Pprl+zMOnpoip/2hROYBQMa0Mm9c741rtXdgMsqYADI64lJyuyJRdTlxOO5vb+zj2zk1uf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BoLSyjv0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5547gWxd019377;
	Wed, 4 Jun 2025 09:19:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=6m3a/QMg3fY
	jr15kWuiahxjb0lLfSP0Squ0gUgtTY0A=; b=BoLSyjv0snpBERC5bzAfrHGXDgW
	lQA6G76aELHMz4bCXW3uSWyJJwZd7sM/NPDO1wpxuWgNC9C47OWn5oK3GF+dyULW
	tX8AgWBJdC+q2K+GddVnpI4OFBKoV3UmmYvzsyxizEiH1c9tTT/hE7xQbt0POQ7s
	en0yvrCOeMHcqgUu0PWGyEfhbdrTSzSn14nzBnIIHL1T2pOHMJXPOZdwaDgRFC6U
	80U9gkjj/1sqSS8UGhJk/IKvOoFoQJKcqAM9//V/yshmIzi+78zK7sExFFayQD70
	PhkxOI55ZMBRTEEaYE+//LEy15WD826HSpJAD3wM38z1vo+jHG7ESVhDnTA==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 471g8swhdb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Jun 2025 09:19:56 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 5549Jr7L004758;
	Wed, 4 Jun 2025 09:19:53 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 46ytum70e1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Jun 2025 09:19:53 +0000
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5549JrMt004609;
	Wed, 4 Jun 2025 09:19:53 GMT
Received: from cse-cd02-lnx.ap.qualcomm.com (cse-cd02-lnx.qualcomm.com [10.64.75.246])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 5549JqLL004400
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Jun 2025 09:19:53 +0000
Received: by cse-cd02-lnx.ap.qualcomm.com (Postfix, from userid 4438065)
	id E593035E4; Wed,  4 Jun 2025 17:19:51 +0800 (CST)
From: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
To: lpieralisi@kernel.org, kwilczynski@kernel.org,
        manivannan.sadhasivam@linaro.org, robh@kernel.org, bhelgaas@google.com,
        krzk+dt@kernel.org, neil.armstrong@linaro.org, abel.vesa@linaro.org,
        kw@linux.com, conor+dt@kernel.org, vkoul@kernel.org, kishon@kernel.org,
        andersson@kernel.org, konradybcio@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_qianyu@quicinc.com,
        Ziyue Zhang <quic_ziyuzhan@quicinc.com>,
        Qiang Yu <qiang.yu@oss.qualcomm.com>
Subject: [PATCH v1 2/2] arm64: dts: qcom: sa8775p: Add PCIe lane equalization preset properties
Date: Wed,  4 Jun 2025 17:19:46 +0800
Message-Id: <20250604091946.1890602-3-quic_ziyuzhan@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250604091946.1890602-1-quic_ziyuzhan@quicinc.com>
References: <20250604091946.1890602-1-quic_ziyuzhan@quicinc.com>
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
X-Proofpoint-ORIG-GUID: FMOKRu16ivAd07uhmdNEPMecsczsx0CZ
X-Authority-Analysis: v=2.4 cv=EPcG00ZC c=1 sm=1 tr=0 ts=68400fbc cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=XhQEiPrLEPsAcZFVs94A:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: FMOKRu16ivAd07uhmdNEPMecsczsx0CZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA0MDA2OSBTYWx0ZWRfX1akgKQHfqSbO
 1qyPQZdgKwYJBHbSJjrpIvf7JrA/7v/GBci6R+Q1/Fu6wrcJgGNJbFAKhPAUG6xIMeNwz8Z19wh
 3nUwY6AwDbl8yN5TBmGaRYW31qZIH8kAaRvRuoSmOTOSgZ6kPo1/F4/zbVBzYb2SDzLLtrpjuBO
 6lZOeThA9RmtvU1tuNPuJm1fcfi4xClGFUONPSjKz4iS5CdtkRAIT5GfaiSsKOVKqBOzqPMiVEB
 6kUspVjEhycilyWmI/zzDxc3QhLfLe/tBBjDn2kx7bgRo50ONkHW0CWwOJpMgOCrx2OK1gA9Obz
 Cpwi9/SENSyaqD091vy6wp5d6qrQ9rCaxZJ44wejSCqre6U9hdxI1oxkyVt+m0/pel1F0U8ksM7
 lgoT9gPStsfcx5CbMHHWAGIlAM1GgY+pskvEHJK8Jmyue8VPjcL+GbYxNIQeJWJGLgT8MUkn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-04_02,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 mlxscore=0
 clxscore=1015 mlxlogscore=855 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506040069

Add PCIe lane equalization preset properties with all values set to 5 for
8 GT/s and 16 GT/s data rates to enhance link stability.

Co-developed-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
Signed-off-by: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sa8775p.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
index 45f536633f64..cc5c71891e8b 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
@@ -7159,6 +7159,10 @@ pcie0: pcie@1c00000 {
 		phys = <&pcie0_phy>;
 		phy-names = "pciephy";
 
+		eq-presets-8gts = /bits/ 16 <0x5555 0x5555 0x5555 0x5555
+					     0x5555 0x5555 0x5555 0x5555>;
+		eq-presets-16gts = /bits/ 8 <0x55 0x55 0x55 0x55 0x55 0x55 0x55 0x55>;
+
 		status = "disabled";
 
 		pcieport0: pcie@0 {
@@ -7317,6 +7321,10 @@ pcie1: pcie@1c10000 {
 		phys = <&pcie1_phy>;
 		phy-names = "pciephy";
 
+		eq-presets-8gts = /bits/ 16 <0x5555 0x5555 0x5555 0x5555
+					     0x5555 0x5555 0x5555 0x5555>;
+		eq-presets-16gts = /bits/ 8 <0x55 0x55 0x55 0x55 0x55 0x55 0x55 0x55>;
+
 		status = "disabled";
 
 		pcie@0 {
-- 
2.34.1


