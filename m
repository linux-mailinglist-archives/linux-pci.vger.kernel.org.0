Return-Path: <linux-pci+bounces-30593-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F8EAE7B43
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 11:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30E1F1BC4573
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 09:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 763BC29AB18;
	Wed, 25 Jun 2025 09:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TDmYPDKA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80D829AB02;
	Wed, 25 Jun 2025 09:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750842081; cv=none; b=EaYFKLt9kAb7d2CEm4wTCdcdA8o2B3HItOuIFbc37tnWDQyJWV+iSW9J51dwj8gD+DdOIXP2Y3HIZPT1sV9RSTOEVxATYgEiSP5K8S7qqJKOALzEjas8jHcthmQSFZEHs51gbah0CuzKFa9fXxSNvztrtYqupCPh7L6UcF/bprU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750842081; c=relaxed/simple;
	bh=llIoZ65iZRbE6HKRxtDXoE+2sFnVDysUCy+rkRbLInw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nJPoF86KI1a9dZjGaF3TYQwhnSPyWkHVjVTPJpr0o9QQ5zLkNki0jv3RFDp5p/b+vdKQQzQK07OX+M3nnsLvgP1GxH5mMvzwRJns9+T6GeVou6DSDQgR0xhW1flpKWz2fruR4T3OYA+XOHUELvD1JVa9qkWcWQ7tHdzN/0BIig0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=TDmYPDKA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55P1q5KG002448;
	Wed, 25 Jun 2025 09:01:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=EF6AjC4MUUF
	M1cgFCRP63nmXpijP6PySoR7J70JajKg=; b=TDmYPDKAnoBX3MHJDmhRzgUN/aL
	wjMZ2OjxuSdJYiHrMxYQr8z9ZvavzuoqnOkaJ4WwoRFnpmLgdwBe0jFIQHAkk0QC
	ElV4ySsr62BssW9P2pf47hQG+mta+9JS3bqEL9RNyJlnavO3o4eLzDPSNF3maqw7
	qSImKvSGcwSU+y5s1WUstSGK6Psd4gBC2xerh+Q0AS4ZM3npTr1wt+9DQl2NSGfc
	oc7VQxOo9YDHd68l9bOSrYPH/o5oTKbbAm+b90JtWIJPvPjG2CoF6HYAE1b0NlRy
	ke/lkOQJQRlir3YbnBuyvxTxgYN7ac72BqOo9X0aSIejPW4EnJFkhjJ08PQ==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47g7td921d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 09:01:02 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 55P910or032353;
	Wed, 25 Jun 2025 09:01:00 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 47dntmargj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 09:01:00 +0000
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55P90xxr032337;
	Wed, 25 Jun 2025 09:00:59 GMT
Received: from cse-cd02-lnx.ap.qualcomm.com (cse-cd02-lnx.qualcomm.com [10.64.75.246])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 55P90x6U032334
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 09:00:59 +0000
Received: by cse-cd02-lnx.ap.qualcomm.com (Postfix, from userid 4438065)
	id 25A143864; Wed, 25 Jun 2025 17:00:58 +0800 (CST)
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
Subject: [PATCH v3 4/4] arm64: dts: qcom: sa8775p: add link_down reset for pcie
Date: Wed, 25 Jun 2025 17:00:48 +0800
Message-Id: <20250625090048.624399-5-quic_ziyuzhan@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250625090048.624399-1-quic_ziyuzhan@quicinc.com>
References: <20250625090048.624399-1-quic_ziyuzhan@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=CPYqXQrD c=1 sm=1 tr=0 ts=685bbace cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=UMluCPnEzjiUAf4N7sYA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDA2NyBTYWx0ZWRfXxF7PsBNX5ZT0
 KfSBZ4/fb59o7KkYMBVxxLF2DtloynEMvoJ5HkzhR+uwoQ4yBPkwtPwV2R4Z6cMNANLrQVdRQ9X
 jrnipQcOM1Nnduk6h6cqmcwpMV9lXa7QlvDviiZEE0wnnDG9JHXq5PCasVkDTw6LUKknqmNjSLX
 OtiiFixV4FvbgMikyrbeFHuEV4aEFmvJ0jasr9Dr5m+4QPu9oKJBvvKi1VIY0joYSERrnxJD1ep
 CtXNKCqqPnqLyRlm4ag7FbjggrkI6Zog8UGajGkkf5ncLeWR0QVZCNpQL2NtrvveW9tmDdLqQRR
 7kND6fnztAIq/9gchEbwo1t2D8+IS7pMj20B3hMX0LQ1Z7MRfEXo2PITcqef7wimiUj+kZ8wxPn
 McAgGu8FOiulhnWH0FsKrtOnp/0cgKi+FpI3BgPBKDkmaVsu5pwPmfKNuL4zq8b/gXMhnsJm
X-Proofpoint-GUID: dyx6eiLlFOj_jh9uXRcZ1JWQDNoy6omj
X-Proofpoint-ORIG-GUID: dyx6eiLlFOj_jh9uXRcZ1JWQDNoy6omj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-25_02,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 mlxlogscore=999 lowpriorityscore=0 malwarescore=0
 impostorscore=0 suspectscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 adultscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506250067

SA8775p supports 'link_down' reset on hardware, so add it for both pcie0
and pcie1, which can provide a better user experience.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
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


