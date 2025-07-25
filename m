Return-Path: <linux-pci+bounces-32929-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFFCB11B38
	for <lists+linux-pci@lfdr.de>; Fri, 25 Jul 2025 11:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD5A23A807E
	for <lists+linux-pci@lfdr.de>; Fri, 25 Jul 2025 09:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF612D4B7C;
	Fri, 25 Jul 2025 09:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NHU4h2Dk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2E62D46BB;
	Fri, 25 Jul 2025 09:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753437215; cv=none; b=ZbxQyi2vo0BTQe25ZVIZ+Xyuhem1mdnUfNiL/FAxK97QUf2wIoeWFgGsMByWR5PsIWLgl+d2BmIX1mTogcXWtEDKaIGWGRs8PhPFzBpZX4LayuQsISAO7hZLM8xXZ9TymnJp/BwCqLMc8fGUKOdUucC+xW+U1ByPdi6EpqU8OOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753437215; c=relaxed/simple;
	bh=yYKz3D7ymOacwbp9D4nGg/5wP2lvzHAjvPOQUFc8AvU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rqQ9IM1Kp7CUUfujIzZ/+OBZg4cp8otp+5bN5m5O1cHzO3YZJsZt3kRb9FdYyhzYB6WdoEWom9iDS+qxgWoV6NK/D1iCkiFeqxbaxpNI9MD71XCT2qsUG6U1ktqSFUzeosBRkcwZAx3SAuoKgf5XoJbRcNzGbb3QB/zuPQcNt/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NHU4h2Dk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56P8xFKX018079;
	Fri, 25 Jul 2025 09:53:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=e2pMOb44GjZ
	xUmO0PQqWhI/o5itASW+/ugix0zxB83A=; b=NHU4h2DkS4k5pWnMEAVb0Ofcz8e
	+j1137Oe0cX2OG+Wo2EOAEVOlvDgupHR2JebZU+BNMCjVFJPiZBpmPmCbMhuqR8o
	G++VmsWJ5Dqlx5oXbp8Y+xpt+AjvLZcdXbQZd8/0JZdTulacgx9fPf+2zZO2uTvo
	TDr6KMS2n1qi6aLOxe4XSOjx0lvF0RoLiwkEJ2cdBJVOKN7NXYzm5u4QUr/Qq5ed
	k/v3xRFGHK1a2ASvK7WpfmS+qWAWDCWOHrGW+EQT8yqUV3EgKdb0c95YcXgvMXGB
	/vx5Ht0G7Lpw6GxvVimXHVuHyB2gkuTXTvbiI+eFisDQsWjN4PeL64RhD2w==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 483w2s1m8w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Jul 2025 09:53:24 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 56P9rLl2001606;
	Fri, 25 Jul 2025 09:53:21 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 4804emta1x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Jul 2025 09:53:21 +0000
Received: from APTAIPPMTA02.qualcomm.com (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 56P9rLZ5001595;
	Fri, 25 Jul 2025 09:53:21 GMT
Received: from cse-cd01-lnx.ap.qualcomm.com (cse-cd01-lnx.qualcomm.com [10.64.75.209])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 56P9rKXx001592
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Jul 2025 09:53:21 +0000
Received: by cse-cd01-lnx.ap.qualcomm.com (Postfix, from userid 4438065)
	id 9CD3E20D5E; Fri, 25 Jul 2025 17:53:19 +0800 (CST)
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
Subject: [PATCH v6 3/3] arm64: dts: qcom: sa8775p: add link_down reset for pcie
Date: Fri, 25 Jul 2025 17:53:02 +0800
Message-Id: <20250725095302.3408875-4-ziyue.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250725095302.3408875-1-ziyue.zhang@oss.qualcomm.com>
References: <20250725095302.3408875-1-ziyue.zhang@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: 168nhMsRxGLNM_7OomxIDf-R_-CVggXh
X-Authority-Analysis: v=2.4 cv=IZyHWXqa c=1 sm=1 tr=0 ts=68835414 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=UMluCPnEzjiUAf4N7sYA:9
X-Proofpoint-GUID: 168nhMsRxGLNM_7OomxIDf-R_-CVggXh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDA4NCBTYWx0ZWRfX3vhAIRsI5Fpk
 mhRKDrqgw+ZpyHPq0Kx1IKZGQwLplPNFs9s9JPaWH4XrUCyZ/W19wp104NQ7pNvTAUWZ8QHaAQD
 3l1SbozbAbQ0qrFQU78OWyh9fUHl8PixldYcFqBgIvME83vVJuR/UALuMma9gKsXuIUO+sVBG1h
 WVIfON3Si4zVnvbbOhDewenG+ZxwdV6t8r77sIT5ShieoILVEu8KoT6xwgX3qq3GARcaF2swjWg
 e8WrBCOgPI1LqDmRPZoIKyihIdngo2qFXAMn6CketfAqeCRSP0z4d7nOwwroPyJLvRUtu1hX2Vr
 q7zn1EM+Q6kcfM/Ta5I6H+kdCcwsgq4Xoa1xLJ/OzSb6DR07Wu7kbaTYA6SCbXY+509hutUr378
 s2idt0EzzQhnAfRR4q4ZQGP6PAcSbW/6EdiF8pwp1CslAllJKaOYBhEEI8nQ8Mccqur4Cz9c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_02,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0 adultscore=0
 phishscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 clxscore=1015 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507250084

SA8775p supports 'link_down' reset on hardware, so add it for both pcie0
and pcie1, which can provide a better user experience.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
Signed-off-by: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sa8775p.dtsi | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
index 39a4f59d8925..76bced68a2d2 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
@@ -7635,8 +7635,11 @@ pcie0: pcie@1c00000 {
 		iommu-map = <0x0 &pcie_smmu 0x0000 0x1>,
 			    <0x100 &pcie_smmu 0x0001 0x1>;
 
-		resets = <&gcc GCC_PCIE_0_BCR>;
-		reset-names = "pci";
+		resets = <&gcc GCC_PCIE_0_BCR>,
+			 <&gcc GCC_PCIE_0_LINK_DOWN_BCR>;
+		reset-names = "pci",
+			      "link_down";
+
 		power-domains = <&gcc PCIE_0_GDSC>;
 
 		phys = <&pcie0_phy>;
@@ -7803,8 +7806,11 @@ pcie1: pcie@1c10000 {
 		iommu-map = <0x0 &pcie_smmu 0x0080 0x1>,
 			    <0x100 &pcie_smmu 0x0081 0x1>;
 
-		resets = <&gcc GCC_PCIE_1_BCR>;
-		reset-names = "pci";
+		resets = <&gcc GCC_PCIE_1_BCR>,
+			 <&gcc GCC_PCIE_1_LINK_DOWN_BCR>;
+		reset-names = "pci",
+			      "link_down";
+
 		power-domains = <&gcc PCIE_1_GDSC>;
 
 		phys = <&pcie1_phy>;
-- 
2.34.1


