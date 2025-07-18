Return-Path: <linux-pci+bounces-32500-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43223B09C15
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 09:12:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4AB21894C11
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 07:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70E021C9EA;
	Fri, 18 Jul 2025 07:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="p1R6L2VY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DD42163B2;
	Fri, 18 Jul 2025 07:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752822747; cv=none; b=eaptDTJSGQQhyaY+5ahPQISu/9x3dAGwwsCZxGkpEEhl/vnGoigBMTgO2volC0XuU+76bHAJxswU+Cw0YSVichz1hNT0yGZFBGDrTyFgvCPTnJFBiZaX+vKvx7VLQLP10iB7Q87PR069a/1/MIGDSWlbCGjKpzdQpUHH4u7MbMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752822747; c=relaxed/simple;
	bh=5F3rJh53OGfhTG6OkGEjNQ4u6hNt6y4sVMVgFxE0Gpc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B1UmTzSj6EcEb2TS1fujX+hZKSOIIDE9pQZV8aJ8tpGRbrBIGCvenzX4hDxfv/KLJD0hz1WGi4SQdt3TRNLDIoBim+fyErGnucbHgwFQfU/UfNnoiyui+Oxkvd2LEBMr8e6fN2F1+8YaBWDUVKzQ0S2GkKqgABRAOSeLZUboTng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=p1R6L2VY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56I5QrOv020649;
	Fri, 18 Jul 2025 07:12:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=UWQZ0nNWnlj
	s6goigZQ9Wp5EzPuV+qmj7TVM8pqS9x4=; b=p1R6L2VYvR+rbYE0ErhAlxR3Jd5
	QApqbPGLEGNjNAY1SGXalBXp4Dc3tR02HFFPxtxIJCRjhaqSBH81xaaUAhuRD8Ka
	GqZPhqUjA+G4HXhZide2EOaM18hRfgd1rJQuMsroM0KEwiwikWDxccm5A7oTmiMU
	WJskzWiAuetoraerIR+clMIwaAX821owAPMeBMVJ/q/OY3nvKJebPXbfd90j0M+4
	8xYJTSwbaVuhvEiIREJ3xm0FsIKMIka2SaBMutH6Rt8dDBZxjBI4GPvXTjVqZFRs
	vjQ236i7ri0CzcRy3OYjJ7ou/Inw0NulZ9xHDInRGu6d2r3RAQ9VmCm/Ijg==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47w5dpnjyv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Jul 2025 07:12:15 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 56I7CCnw006328;
	Fri, 18 Jul 2025 07:12:12 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 47ugsn143x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Jul 2025 07:12:12 +0000
Received: from APTAIPPMTA02.qualcomm.com (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 56I7CCTE006311;
	Fri, 18 Jul 2025 07:12:12 GMT
Received: from cse-cd01-lnx.ap.qualcomm.com (cse-cd01-lnx.qualcomm.com [10.64.75.209])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 56I7CB7B006304
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Jul 2025 07:12:12 +0000
Received: by cse-cd01-lnx.ap.qualcomm.com (Postfix, from userid 4438065)
	id 06E2220F23; Fri, 18 Jul 2025 15:12:10 +0800 (CST)
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
Subject: [PATCH v4 4/4] arm64: dts: qcom: sa8775p: add link_down reset for pcie
Date: Fri, 18 Jul 2025 15:12:07 +0800
Message-Id: <20250718071207.160988-5-ziyue.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250718071207.160988-1-ziyue.zhang@oss.qualcomm.com>
References: <20250718071207.160988-1-ziyue.zhang@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDA1NSBTYWx0ZWRfX//Z/P3nxct/6
 K2YvvgFPjCdgoLpP05w48eQ5DU/yk4HrRnXSA9sT9RkXUPY/H8O1EfEWoUjGR5FI1NwPf8VpGyn
 xb0kmjxJHqGG8ezypsVtUf/XhF1YXwSrLq6dAgJ2jFwFCyZf0aCeZnl2G+KjRhOnzH79KDiSxtH
 oOxcI7ijBVWN3UFhloEFjsGv3LrTT9kJQA6Df2x46P0ZpwQG/YOG5YfE31olM//+JApO3n8q1de
 jQgsrSsT8KGjfo737YkGYQkWCm+1XBVGnWGnn9gCpl7+ZwgrTwpNVGyXUk05fvMZS/Ozq0KMGVu
 eLsigafwem+KeQ8bo6wveGK6yUXmWk+9epbZJRrS9sDGCFO5X3tHOU4YTyj9PAmDkBjbNum/4pz
 rkiYzO4nHOjK3xjohYWPqjAXRP6MyyDavAt3m3KH4fYAuc+TOQY7MvtD22TBqHaCEBWT4skl
X-Proofpoint-GUID: yfLTp_vpkimuWxa5cg1tI4BXKGlihcTF
X-Proofpoint-ORIG-GUID: yfLTp_vpkimuWxa5cg1tI4BXKGlihcTF
X-Authority-Analysis: v=2.4 cv=Y+r4sgeN c=1 sm=1 tr=0 ts=6879f3cf cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=UMluCPnEzjiUAf4N7sYA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_01,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=999 phishscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 impostorscore=0 mlxscore=0 suspectscore=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507180055

SA8775p supports 'link_down' reset on hardware, so add it for both pcie0
and pcie1, which can provide a better user experience.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sa8775p.dtsi | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
index 731bd80fc806..d0a6303cb133 100644
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


