Return-Path: <linux-pci+bounces-32511-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B255B09DA4
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 10:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE64E1C45D6D
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 08:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 515EC293B7E;
	Fri, 18 Jul 2025 08:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="K5Ctw+Qd"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050B81F8AC5;
	Fri, 18 Jul 2025 08:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752826659; cv=none; b=dc3A3k6CvHOfgWSVmphe0K6wh9Iz0qt/q2/1xo9y98acE7/2CCrESD+Sv4IpDw9QzrUFZrgSuPyBb3vPCiIg9fBBVtKXd1d0+1Q0YGLw8Ho9stpDgE2qlUXiV41u9SOapUBmXNxNWPKoXoaxEtvNa8Oq8i6RBM1tObOz9E4VTjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752826659; c=relaxed/simple;
	bh=hBC0QLD0d5YhLBibiZKhrzdUFllASy4vdlwVKsE8aXQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FaMvQQFJYVfaJg2aQE0GzG0WnBYWLnzy9CWG9KjCPA72QsIUZO5PD28ySU6m8OQP2DuaUo6jQO2xLEI9j8+2pcRSb0HcmKY7MdE8To0a/R/jecoEKsCMfk5Fb3duFTIpmyVUDhzzJ1G0a/OGCtUthGoYGwm9AlhaAZA5i1qagJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=K5Ctw+Qd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56I7crL9032408;
	Fri, 18 Jul 2025 08:17:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=r1sqdo9BRCR
	2sQEamMdCjHsX1DdbqHtCQfOOpdOX890=; b=K5Ctw+QdpQpuqf61s96BhwuLOff
	tPP4al23kz+W3zAyOz1sgsAMItDzl+Du+/fdcV+iVjfbjHCElSsoo7KosgLhm+IA
	vwzsWJFcyKL7spma+aZ5F5rM6JrOewIWfJr1k8l7JdVfIwYGcLH17BOvLtpAP7Ty
	5yh51UOvxnZAIGF/5s7d4xT3X70BNfX7ebXeEiw/t2OIdUk9zarFJW27a49HG0av
	0GuoD9IUziQzRV/fed44VOEZC4XG7SPBufdTin4jKiy65yRiCPMnw5gAoEkZ7hn8
	GFepFLlYYqpoNk3+Z23/a1i/fuw3XyWfVZZSM4US6Bamm798kigajClRA7w==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ug38avm5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Jul 2025 08:17:24 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 56I8HMhI009039;
	Fri, 18 Jul 2025 08:17:22 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 47ugsn1e3m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Jul 2025 08:17:22 +0000
Received: from APTAIPPMTA02.qualcomm.com (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 56I8HLKX009025;
	Fri, 18 Jul 2025 08:17:21 GMT
Received: from cse-cd01-lnx.ap.qualcomm.com (cse-cd01-lnx.qualcomm.com [10.64.75.209])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 56I8HLVN009019
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Jul 2025 08:17:21 +0000
Received: by cse-cd01-lnx.ap.qualcomm.com (Postfix, from userid 4438065)
	id CE6BD20F21; Fri, 18 Jul 2025 16:17:19 +0800 (CST)
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
Subject: [PATCH v5 4/4] arm64: dts: qcom: sa8775p: add link_down reset for pcie
Date: Fri, 18 Jul 2025 16:17:18 +0800
Message-Id: <20250718081718.390790-5-ziyue.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250718081718.390790-1-ziyue.zhang@oss.qualcomm.com>
References: <20250718081718.390790-1-ziyue.zhang@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDA2NCBTYWx0ZWRfX556J9A2iHR0E
 PRWGf60HqHjQi6X20AIKPRGWKTFcy9v04n15ckbsFZ0M1ufmJIY6VULWaOvMFY3fSFve7ztoLDc
 KIEVMF+midS3QT2l7A59Wm/Ax+HyLXxDxR/CyOPWm3mC5vGwUmCwFuMBToceAQvQhTiv0zd8r4V
 bOgQ+G4uy2CQ9/Q+3ZCyKDumLnQ4CVrJkTEB9kIlGKKkBr8IF1JQ6ublKztu8eFW+ZXaVRtgSgz
 lzHF4Gle1IxbD4g5jNDAWOmuTdUo9FAlBZ98/cMURjF7T6iaRTGVASb2tKEgB+5U9Z+x+qMmfIb
 MdtomrDl8fDB87L2nMZqvE6zYA/6BEz/UI5yGMN95vQp4iWpPzbaV8ThIbKjgH1cI2JP+Ye+VXF
 k4qGqlWuUkisn862tzcnb/Qbn3ginHLXjz3NyEgea8xg1JXCkGu1qXHBM5VidSEbx2k7S8lf
X-Proofpoint-GUID: LHGcv2tjgp2uiEj88sgslubYgOoDwszm
X-Authority-Analysis: v=2.4 cv=SZT3duRu c=1 sm=1 tr=0 ts=687a0314 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=UMluCPnEzjiUAf4N7sYA:9
X-Proofpoint-ORIG-GUID: LHGcv2tjgp2uiEj88sgslubYgOoDwszm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_01,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=999 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0
 phishscore=0 spamscore=0 suspectscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507180064

SA8775p supports 'link_down' reset on hardware, so add it for both pcie0
and pcie1, which can provide a better user experience.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
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


