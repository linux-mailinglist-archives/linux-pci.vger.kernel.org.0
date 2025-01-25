Return-Path: <linux-pci+bounces-20347-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15736A1C0CF
	for <lists+linux-pci@lfdr.de>; Sat, 25 Jan 2025 05:00:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A09D13ABCDF
	for <lists+linux-pci@lfdr.de>; Sat, 25 Jan 2025 04:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23413206F2C;
	Sat, 25 Jan 2025 03:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LE2kH6hY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C35126C05;
	Sat, 25 Jan 2025 03:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737777596; cv=none; b=qY/AftJUMG4gH3Q1lCqde0neui9va4OgqSJ8W7WTJgv7ECVmwASB10PRQAEbBL6TSge3+K+3ot0FuovyrkYpMgDZc0LkzaHMfAsGl1112rridojHY8EQbPbyuxt//HwCKshTJWtmWqr0PQECh96HWBaM0kfBWhGiVgAsUrVgSDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737777596; c=relaxed/simple;
	bh=kApNVCGN4sIiwnrB3oLpVuJ8tMoqDHH+K8Ix3g901Fw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i8aQ5SzZmg9gpilySIY7rXYHvaE3NQSCyPjjwnBTn0f8J1aMlq2r6KrHFUII7iSrEv1Y5Ie4QQgVy1aUWUw2w3FvoDxJ1Nc8YNwQxvGboP7qOxdxbai1Zn8g2z0GrD3K6gs3v44OD5q26M4ig3gOwlUiipsohLNiP/5Fgu0uwww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LE2kH6hY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50P3jUGG003631;
	Sat, 25 Jan 2025 03:59:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ykB143rwgwrphhBJ+KnOmXoreJG8iEPdHDHbotqa5eQ=; b=LE2kH6hYa4EmecJt
	0o75SFy6vDU/bM9/L0I5RXCZyDFwwfEgte7ZylzFhhNVh0x1eZMWCc9fZR9ap4tA
	+UCSp1UcuYYZw194zM9OF/FWjSzP8MQvtej461tt+pde53KpzF+L+0ij0whX9d9A
	qX8ogIy/UBqL84c2cjqjcd1ZQrLbWxfoIH9ToIVJc8x0JlaIRAixSPCGluJCPMbs
	DgDDva25YxJHdysHLHixqFRdWc60xMMzm4W/gqfrTeFej/5/z5+RIzE1cgxssUME
	i7++KxLsXhbAZsvPgD12X3TsRpdH+E9rU7sAuolis/U2EiOdnFbfBsqO6O8qzk3S
	F9XWtA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44crb600jv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 25 Jan 2025 03:59:45 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50P3xhfG004516
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 25 Jan 2025 03:59:43 GMT
Received: from hu-mmanikan-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 24 Jan 2025 19:59:38 -0800
From: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
To: <andersson@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <lpieralisi@kernel.org>, <kw@linux.com>,
        <manivannan.sadhasivam@linaro.org>, <bhelgaas@google.com>,
        <konradybcio@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
CC: <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>
Subject: [PATCH v3 1/4] dt-bindings: PCI: qcom: add global interrupt for ipq5424
Date: Sat, 25 Jan 2025 09:29:17 +0530
Message-ID: <20250125035920.2651972-2-quic_mmanikan@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250125035920.2651972-1-quic_mmanikan@quicinc.com>
References: <20250125035920.2651972-1-quic_mmanikan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: rzLXFRGReYUBPxXKWU6s5FtQ2Ua38CZT
X-Proofpoint-GUID: rzLXFRGReYUBPxXKWU6s5FtQ2Ua38CZT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-25_01,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 adultscore=0 mlxscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=831 clxscore=1015 spamscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501250024

Document the global interrupt found on IPQ5424 platform.

Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
---
 Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index 7235d6554cfb..1fd6aea08bf0 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -49,11 +49,11 @@ properties:
 
   interrupts:
     minItems: 1
-    maxItems: 8
+    maxItems: 9
 
   interrupt-names:
     minItems: 1
-    maxItems: 8
+    maxItems: 9
 
   iommu-map:
     minItems: 1
@@ -443,6 +443,7 @@ allOf:
         interrupts:
           minItems: 8
         interrupt-names:
+          minItems: 8
           items:
             - const: msi0
             - const: msi1
@@ -452,6 +453,7 @@ allOf:
             - const: msi5
             - const: msi6
             - const: msi7
+            - const: global
 
   - if:
       properties:
-- 
2.34.1


