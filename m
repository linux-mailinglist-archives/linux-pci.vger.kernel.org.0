Return-Path: <linux-pci+bounces-10361-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84BE89322B4
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2024 11:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1240B22AA8
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2024 09:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EAEC196C7C;
	Tue, 16 Jul 2024 09:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jmG9RAq/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F279196450;
	Tue, 16 Jul 2024 09:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721121883; cv=none; b=gcC1RJbL0MCl4S/O8LB7EXaagVFXjCuIn5PoEeOMftNiRBSlsj823JNjD7obEIpu6PsLR/vmHKbfKz2wiWR+3/U4nXtUd6iFecslx28Y/vesdeHvJFE6dEgFc1WyMopCs/7pWUSakbD1XwTbPdhpD4q937BayWYKqdVfX2qbuGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721121883; c=relaxed/simple;
	bh=8XToHCoAr+iqy8AADMqAeouVNJrJia7QVV55lFR5ECY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OxW3Ol7lq1DUgPdd6EP71I42VBy4S6cwQGUqS3yX4NXUzVaXKWkoopj3QulaaMEoW2rMF0kMCPqEcq2Z23xxw2XEuVfoujP4ZRxxVJNYuQImzPfeBFmdomQOpXY66thbBjGlnM7o5245nRsRija3INdMI5JI/JIyresMBwZ5yd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jmG9RAq/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46G4WJsb016233;
	Tue, 16 Jul 2024 09:24:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8wP3eWUy7tdjG0YOZA5gmwaDqcbW9m/5TGb6y9BMrNw=; b=jmG9RAq/LjygLeGm
	W2ytuvjiJGkzCxD4/TgUucVDNo5KRFsZc7bweYaJK9GLkUiscdyMCJwDLACNG9lW
	GjpGW3SNrwlwjJ6VEf0mxiyKJgBehkNOPKtkWuNvPRsIPfh3QK1CpapvXe43FhxW
	pvfUwU3jaOl9eyfSDcRSbwD0Bwj9O5VKGjWRgD1hz1PkykSKqjU4u3DKCLt/q4Nw
	V5AA4mLmZ253QzBJnkTIVafZHPVO62UiDOsfCVX7BDun71Dz2k2xkAiPy242+4YV
	Op/XEIkUtwofUDCbAsPLqjOZhfa1enlyU51toEgfv9Mkqp5Tl1CiVmH9q7XjoTMd
	ZJwLTg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40bf9eeru8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jul 2024 09:24:29 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46G9OS3q025751
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jul 2024 09:24:28 GMT
Received: from hu-srichara-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 16 Jul 2024 02:24:23 -0700
From: Sricharan R <quic_srichara@quicinc.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <manivannan.sadhasivam@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_srichara@quicinc.com>
CC: devi priya <quic_devipriy@quicinc.com>
Subject: [PATCH V6 1/4] dt-bindings: PCI: qcom: Document the IPQ9574 PCIe controller.
Date: Tue, 16 Jul 2024 14:53:44 +0530
Message-ID: <20240716092347.2177153-2-quic_srichara@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240716092347.2177153-1-quic_srichara@quicinc.com>
References: <20240716092347.2177153-1-quic_srichara@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Y-tLWzEWqEPQh8DL7kyTMj8Q1wplAWXs
X-Proofpoint-GUID: Y-tLWzEWqEPQh8DL7kyTMj8Q1wplAWXs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-15_19,2024-07-16_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 spamscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2406140001 definitions=main-2407160067

From: devi priya <quic_devipriy@quicinc.com>

Document the PCIe controller on IPQ9574 platform.

Signed-off-by: devi priya <quic_devipriy@quicinc.com>
Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
---
 [V6] Fixed the clocks order and dropped unnessecary names as per
      Krzysztof's comments.
      Changed the interrupt numbers/msi to '8'.

 .../devicetree/bindings/pci/qcom,pcie.yaml    | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index f867746b1ae5..2d61fb9f206d 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -26,6 +26,7 @@ properties:
           - qcom,pcie-ipq8064-v2
           - qcom,pcie-ipq8074
           - qcom,pcie-ipq8074-gen3
+          - qcom,pcie-ipq9574
           - qcom,pcie-msm8996
           - qcom,pcie-qcs404
           - qcom,pcie-sdm845
@@ -161,6 +162,7 @@ allOf:
             enum:
               - qcom,pcie-ipq6018
               - qcom,pcie-ipq8074-gen3
+              - qcom,pcie-ipq9574
     then:
       properties:
         reg:
@@ -397,6 +399,53 @@ allOf:
             - const: axi_m_sticky # AXI Master Sticky reset
             - const: axi_s_sticky # AXI Slave Sticky reset
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,pcie-ipq9574
+    then:
+      properties:
+        clocks:
+          minItems: 6
+          maxItems: 6
+        clock-names:
+          items:
+            - const: axi_m # AXI Master clock
+            - const: axi_s # AXI Slave clock
+            - const: axi_bridge
+            - const: rchng
+            - const: ahb
+            - const: aux
+
+        resets:
+          minItems: 8
+          maxItems: 8
+        reset-names:
+          items:
+            - const: pipe # PIPE reset
+            - const: sticky # Core Sticky reset
+            - const: axi_s_sticky # AXI Slave Sticky reset
+            - const: axi_s # AXI Slave reset
+            - const: axi_m_sticky # AXI Master Sticky reset
+            - const: axi_m # AXI Master reset
+            - const: aux # AUX Reset
+            - const: ahb # AHB Reset
+
+        interrupts:
+          minItems: 8
+        interrupt-names:
+          items:
+            - const: msi0
+            - const: msi1
+            - const: msi2
+            - const: msi3
+            - const: msi4
+            - const: msi5
+            - const: msi6
+            - const: msi7
+
   - if:
       properties:
         compatible:
@@ -507,6 +556,7 @@ allOf:
                 - qcom,pcie-ipq8064v2
                 - qcom,pcie-ipq8074
                 - qcom,pcie-ipq8074-gen3
+                - qcom,pcie-ipq9574
                 - qcom,pcie-qcs404
     then:
       required:
-- 
2.34.1


