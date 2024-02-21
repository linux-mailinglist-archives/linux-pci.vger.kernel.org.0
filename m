Return-Path: <linux-pci+bounces-3824-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B131085DD6B
	for <lists+linux-pci@lfdr.de>; Wed, 21 Feb 2024 15:05:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B644282DC8
	for <lists+linux-pci@lfdr.de>; Wed, 21 Feb 2024 14:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6DFA7E773;
	Wed, 21 Feb 2024 14:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="goVEGZZ2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150F77CF33;
	Wed, 21 Feb 2024 14:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708524275; cv=none; b=DQSGkH/rxDtuQMBDftl2b0HtAFhikJbUFpUSXv6ZJpg2XTNJEG6lnmRz2BXMg/g8DL3HtUMvvchOYRBfqbJZ1jrYwqOFpNEo4wo6Uwlnm4fY5geQkrFMBLxGysL5K+akisQBSjlJg25zvWYOTNyD22z3teP1kN6U84yR2PWkxWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708524275; c=relaxed/simple;
	bh=13M8Fwxd5qbS/Bqd6jnBJB6olP2gXVCbF3jc11UFfgU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lDH7NNGzQDaeFQeCzXXhb2kn9TtL5LylO5H/wTjDRDvzycptdjRdA6dwDkOT6fThx//bEfYSS2cKb0xZIHU4MsWubJnBh8rg8BEWVYyqniWo5t9awoUWsJ6qQWphtINdmrZIQ3CA58kvkTO7pKI26MSHvbE5wnwH4TTGW9GT3Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hu-msarkar-hyd.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=goVEGZZ2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hu-msarkar-hyd.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41L7P0hQ013507;
	Wed, 21 Feb 2024 14:04:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=qcppdkim1; bh=LopbBaJ
	MkUd7zsUQmDUm/ztdJn+MZ4GTTnsFnoD6hMs=; b=goVEGZZ25vOliWe9VzBTN0D
	KY/RXgtaodnM1w2pgceSFZWNMfxAVFUk+CZae1Rh6jUJsAito4p0TSLHA1a4zI+S
	FCcUvXVyN+X1VzKxFQ1IDdnfwdPE/HXF2nMnhB7l2htvRl4vbrBoJ2Vz0iuQejDT
	h9kPm6z/i9LcY0hksYiOvmzbta4mPe6orzXGuUXshPdUwSqImXThxhfOH+qqUqj3
	sLv2lUICUA7fpmlTcnYf+KtNbnTeI2qgNM+eXf7KtrItlnvioOkABk2xNo+tnqCK
	p9gn7OFcTi5BsTsg8c1iszkcE6U49ExSbpUbmJ+ZH5PVvcHOzo5JiIH+6huYenw=
	=
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wdcrs0u78-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 14:04:16 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 41LE4B7b013249;
	Wed, 21 Feb 2024 14:04:13 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3wanvkycg2-1;
	Wed, 21 Feb 2024 14:04:13 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41LE4Dsk013291;
	Wed, 21 Feb 2024 14:04:13 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-msarkar-hyd.qualcomm.com [10.213.111.194])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 41LE4Dn1013288;
	Wed, 21 Feb 2024 14:04:13 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 0)
	id 2F78339C4; Wed, 21 Feb 2024 19:34:12 +0530 (+0530)
From: root <root@hu-msarkar-hyd.qualcomm.com>
To: andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        konrad.dybcio@linaro.org, manivannan.sadhasivam@linaro.org,
        conor+dt@kernel.org, quic_nitegupt@quicinc.com
Cc: quic_shazhuss@quicinc.com, quic_ramkri@quicinc.com,
        quic_nayiluri@quicinc.com, quic_krichai@quicinc.com,
        quic_vbadigan@quicinc.com, Mrinmay Sarkar <quic_msarkar@quicinc.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/3] arm64: dts: qcom: sa8775p: Enable global irq support for SA8775p
Date: Wed, 21 Feb 2024 19:34:03 +0530
Message-Id: <20240221140405.28532-3-root@hu-msarkar-hyd.qualcomm.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240221140405.28532-1-root@hu-msarkar-hyd.qualcomm.com>
References: <20240221140405.28532-1-root@hu-msarkar-hyd.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: 4wALU_qVqBbKAMtbv--65L8fdB7rohgw
X-Proofpoint-GUID: 4wALU_qVqBbKAMtbv--65L8fdB7rohgw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 suspectscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 mlxscore=0 adultscore=0 mlxlogscore=734 bulkscore=0 clxscore=1034
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402210109

From: Mrinmay Sarkar <quic_msarkar@quicinc.com>

Global irq needed for PCIe controller related error reporting.
So adding change to add global irq support for SA8775p RC platform.

Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sa8775p.dtsi | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
index 73c52f465f87..68efccba50b0 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
@@ -3552,9 +3552,11 @@ pcie0: pcie@1c00000 {
 			     <GIC_SPI 313 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 314 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 374 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 375 IRQ_TYPE_LEVEL_HIGH>;
+			     <GIC_SPI 375 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 306 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "msi0", "msi1", "msi2", "msi3",
-				  "msi4", "msi5", "msi6", "msi7";
+				  "msi4", "msi5", "msi6", "msi7",
+				  "global";
 		#interrupt-cells = <1>;
 		interrupt-map-mask = <0 0 0 0x7>;
 		interrupt-map = <0 0 0 1 &intc GIC_SPI 434 IRQ_TYPE_LEVEL_HIGH>,
@@ -3652,9 +3654,11 @@ pcie1: pcie@1c10000 {
 			     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>;
+			     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 518 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "msi0", "msi1", "msi2", "msi3",
-				  "msi4", "msi5", "msi6", "msi7";
+				  "msi4", "msi5", "msi6", "msi7",
+				  "global";
 		#interrupt-cells = <1>;
 		interrupt-map-mask = <0 0 0 0x7>;
 		interrupt-map = <0 0 0 1 &intc GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>,
-- 
2.40.1


