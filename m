Return-Path: <linux-pci+bounces-20225-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 391D1A18C2C
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jan 2025 07:36:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 636833ACA7E
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jan 2025 06:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F01A1BD9D5;
	Wed, 22 Jan 2025 06:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aZItLzMo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C57D1BD9C7;
	Wed, 22 Jan 2025 06:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737527716; cv=none; b=BmJpy1HWBQzGTp487l62+KbVH2+0QCEpZl1FuEmxLrJjZvvosrApBP7oIdMqgoUnD4xiv3Won/2F5xxNawZRmF5q+hDq8SSCsqviXluU944XbZyw/wumcAuJSXsFjzLt7Bj17vpmAMr5bLCMOehdMhuXM5QgHyL3s0cTa/eaU9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737527716; c=relaxed/simple;
	bh=mU3rdEo1DWy1hFrfE9w32FizZZbRhUSgxvP5KbHKHuY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KF3K2Ld385hTLZRf2oiyADYD/KBiQct7pKMZ/MLLsryXtYk9g4JpYsFPlSTh+SqV6Oy/c8SKLqLBSvNroYN2ncmhwZlhQ9rClNoOiqTIJSEKBNmUqeYf0R50TqgrShryQB/4C2W4EjqOOYhHqRGLHXH0Y+a0ErvcnGlPZMHk7oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=aZItLzMo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50M4uc4O016020;
	Wed, 22 Jan 2025 06:35:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rzkd2BwEgWm188Rxe+mZ0ZXv/CWSM0llyfhEeEFjLnM=; b=aZItLzMoy2pY4Z9W
	b1pcjn1JghFDCoRc1Fj+SE5GQIm/WkOiMzKmx7vw18dNG1kqP/MX0PIo6Kr8sngJ
	sGldBw4jBLa4jdXs/smeH6hlEkUxZYKW3jAncMivzAJDA3Q6MVUd6/wadvSItuNu
	Bxz/tL0nvZxVolmuS54zExA1vr7d8qp7OmUbwebwSZsN+orXv3m2gy9xQY+vHCVs
	Jgs4PshJRb6CoTxvnpHkDO6elkDWSJaJolOa2EC94EQPYjQqeuTUc/tWoIlAvFgi
	L2q5aUVWeAGzki/4EVtVfaz+oi6MQs1iFUViwvx5ysSVnIXlfcKxK3in0yRm0lO9
	OIA7QA==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44at3g06rv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jan 2025 06:35:01 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50M6Z00M001422
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jan 2025 06:35:00 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 21 Jan 2025 22:34:54 -0800
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <andersson@kernel.org>, <konradybcio@kernel.org>,
        <p.zabel@pengutronix.de>, <dmitry.baryshkov@linaro.org>,
        <quic_nsekar@quicinc.com>, <quic_varada@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>
Subject: [PATCH v7 5/7] dt-bindings: PCI: qcom: Document the IPQ5332 PCIe controller
Date: Wed, 22 Jan 2025 12:04:09 +0530
Message-ID: <20250122063411.3503097-6-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250122063411.3503097-1-quic_varada@quicinc.com>
References: <20250122063411.3503097-1-quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: CnUP2cPGxXTAbRRzH-mkyZKhvLIYRiqJ
X-Proofpoint-GUID: CnUP2cPGxXTAbRRzH-mkyZKhvLIYRiqJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-22_02,2025-01-22_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 clxscore=1015 mlxscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501220046

Document the PCIe controller on IPQ5332 platform. IPQ5332 will
use IPQ9574 as the fall back compatible.

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
v7: Moved ipq9574 related changes to a separate patch
    Add 'global' interrupt

v6: Commit message update only. Add info regarding the moving of
    ipq9574 from 5 "reg" definition to 5 or 6 reg definition.

v5: Re-arrange 5332 and 9574 compatibles to handle fallback usage in dts

v4: * v3 reused ipq9574 bindings for ipq5332. Instead add one for ipq5332
    * DTS uses ipq9574 compatible as fallback. Hence move ipq9574 to be able
      to use the 'reg' section for both ipq5332 and ipq9574. Else, dtbs_check
      and dt_binding_check flag errors.
---
 .../devicetree/bindings/pci/qcom,pcie.yaml          | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index 413c6b76c26c..ead97286fd41 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -34,6 +34,10 @@ properties:
       - items:
           - const: qcom,pcie-msm8998
           - const: qcom,pcie-msm8996
+      - items:
+          - enum:
+              - qcom,pcie-ipq5332
+          - const: qcom,pcie-ipq9574
 
   reg:
     minItems: 4
@@ -45,11 +49,11 @@ properties:
 
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
@@ -205,6 +209,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,pcie-ipq5332
               - qcom,pcie-ipq9574
               - qcom,pcie-sdx55
     then:
@@ -407,6 +412,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,pcie-ipq5332
               - qcom,pcie-ipq9574
     then:
       properties:
@@ -439,6 +445,7 @@ allOf:
         interrupts:
           minItems: 8
         interrupt-names:
+          minItems: 8
           items:
             - const: msi0
             - const: msi1
@@ -448,6 +455,7 @@ allOf:
             - const: msi5
             - const: msi6
             - const: msi7
+            - const: global
 
   - if:
       properties:
@@ -555,6 +563,7 @@ allOf:
               enum:
                 - qcom,pcie-apq8064
                 - qcom,pcie-ipq4019
+                - qcom,pcie-ipq5332
                 - qcom,pcie-ipq8064
                 - qcom,pcie-ipq8064v2
                 - qcom,pcie-ipq8074
-- 
2.34.1


