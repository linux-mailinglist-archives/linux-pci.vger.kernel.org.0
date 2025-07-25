Return-Path: <linux-pci+bounces-32932-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E906B11C32
	for <lists+linux-pci@lfdr.de>; Fri, 25 Jul 2025 12:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A2173B3A86
	for <lists+linux-pci@lfdr.de>; Fri, 25 Jul 2025 10:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E2132DC322;
	Fri, 25 Jul 2025 10:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Q+2oOEqb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF8C2DAFA8;
	Fri, 25 Jul 2025 10:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753438973; cv=none; b=SDRaNshnRRA14Z4cS9u0MiexB97ZdDuKtwCCshnP4zVaqrkoFLgAXcFTD4taXtFUXHxQkz+Tb0J6xC/J92zGcZEDJsla14I+nUgwUOhWmg5VaKIg/uvQVE5ByGoU/6KLp8clSIlovh9O8gVz225q+amGBBZhEaVpswkvDXUcQTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753438973; c=relaxed/simple;
	bh=yYKz3D7ymOacwbp9D4nGg/5wP2lvzHAjvPOQUFc8AvU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A6AfnovehuFABRvAQf77EdhiHq5lZWuLlg8zoaM4dStW1wH0/MrGBvK9p06WeU2DDzSLzcfYpM006k4EeXuRRyNnYuf3z+rdSmMTp+VfyuvD6sbu/BJInVb935TjULCsIyxJZaW/i/4Rq2ZmRl7b8DSR2UhxDzFW62ef6ogI2iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Q+2oOEqb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56P9Ghdv018080;
	Fri, 25 Jul 2025 10:22:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=e2pMOb44GjZ
	xUmO0PQqWhI/o5itASW+/ugix0zxB83A=; b=Q+2oOEqb/6jw4K2ZPNSKKM9hZht
	EiIEYEYvPhqFVOCx7vEqosX6nsVhpPSD12lMIBaSJmTn1Hlcgb1kOKw6hdNuQ6SY
	YyvaOXu0qnUqPkUT6NyEQNqZUQoCV/vB2eLxHHebkgFY5GKkLKORSBT4M1xAyckZ
	4+Y9bD8zOxNK0+b0pIzOj2PymL0+68ziF+CXNayPB34ZNE4UiWYyGla3LsnKIB29
	Py26YiozrdK7+b8pcrFnkH1afVDrp3ZGeOt8PH9SHj4UK2y0039Zt1m1JQ12X/o+
	S9G9FJtEq7+ixqcOssRIx16HRFKnSNqJzmR9feaq4iOwNGc8TOpcgQ+HUnA==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 483w2s1prr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Jul 2025 10:22:40 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 56PAMYYR027665;
	Fri, 25 Jul 2025 10:22:34 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 4804emsyu1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Jul 2025 10:22:34 +0000
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 56PAMYds027651;
	Fri, 25 Jul 2025 10:22:34 GMT
Received: from cse-cd01-lnx.ap.qualcomm.com (cse-cd01-lnx.qualcomm.com [10.64.75.209])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 56PAMXm7027646
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Jul 2025 10:22:34 +0000
Received: by cse-cd01-lnx.ap.qualcomm.com (Postfix, from userid 4438065)
	id E63012184A; Fri, 25 Jul 2025 18:22:32 +0800 (CST)
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
Subject: [PATCH v7 3/3] arm64: dts: qcom: sa8775p: add link_down reset for pcie
Date: Fri, 25 Jul 2025 18:22:31 +0800
Message-Id: <20250725102231.3608298-4-ziyue.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250725102231.3608298-1-ziyue.zhang@oss.qualcomm.com>
References: <20250725102231.3608298-1-ziyue.zhang@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: pbtC51jlJPUlLMSnIT1D62ZCW-TyoIb4
X-Authority-Analysis: v=2.4 cv=IZyHWXqa c=1 sm=1 tr=0 ts=68835af1 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=UMluCPnEzjiUAf4N7sYA:9
X-Proofpoint-GUID: pbtC51jlJPUlLMSnIT1D62ZCW-TyoIb4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDA4OCBTYWx0ZWRfX4RrXGlDRKHej
 NI8mKGysI3DeSRoAfsp82UOAX8v2NMN2FJxbNp36u9a8g7FPEnN907n/NwejFpP+4V5hlwbdEUe
 ibh4n3JBTanafWe8oUiesZSoENPzN5+MxfR8uCKjbnO9wCqMH9Pt5DBJVL2RsbgI/r8IILUsmTA
 mIlt5DDqGJufZbHGaFross1PHp4+xV4TT/FxvCd9y/gIgtdcMeEILqxhUOnz4TrlPzUXiRrOfcM
 LZh7GhU5gQX4aiLipkI7nu4NIuMBetSBYHtzoeQiQ95XoCqOCLG8UsRf2DsY1tuiYagKa26nc1C
 AQOJm7TZcL3DA1PyMEvGjuZevZn7Bp3B/9H2QsTycHnxOt9cNOkT+wJgTzYhVJRmzmVqTZDaBF8
 lkzQAWhI7Ln3TbupUd4172yc7Mq7bcBzyGFw8Q9ekvPjUSH4kz18f4v55IkWe1Jxsb/++ftF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_03,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0 adultscore=0
 phishscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 clxscore=1015 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507250088

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


