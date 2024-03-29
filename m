Return-Path: <linux-pci+bounces-5417-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B09892065
	for <lists+linux-pci@lfdr.de>; Fri, 29 Mar 2024 16:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BFF41C297B2
	for <lists+linux-pci@lfdr.de>; Fri, 29 Mar 2024 15:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3554137C4A;
	Fri, 29 Mar 2024 15:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DCJXh75J"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55610136E2D;
	Fri, 29 Mar 2024 15:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711725744; cv=none; b=mRMLmz6/V3PiCrBPr6OTqqJj+vdQAzg/jzw34JFiuIXX2k5yq/ePsmaGZ1V++8H7wA08ciaboXZLvRb7wT2xGhvBbPE4YpXEAKgFux/8N/OL/Tz5UTKo+3niz8vxIoCqq/Ppy3nPpc59cxoTZoNR6uvcjHK6noHrtR0Iroam+/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711725744; c=relaxed/simple;
	bh=nUeLNnDpGTQ8y7SaH6xF7dPGjlruKEbLRTeFsoqCrto=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=taJfVCNtHZHkj/b0qMcpt3v7ya0Qeu/0hMhjkLbOfgzZwNImzoq4o/JwBYvctBIS5bxl0tNSNfBgv0q7RDva9AWUsjQ2o9JQBcXXzKiPSzL3vgEGFYMTzABr+2NFlVkGVz1oHsCt8pthwbsB1D2bwU4eyILgrufUlKMJdzwlE50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=DCJXh75J; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42TEMgsL026502;
	Fri, 29 Mar 2024 15:22:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references; s=
	qcppdkim1; bh=3z7tTu3vHsIre5hBJss/48GAtbHvOmc4TtZZL0fZtEU=; b=DC
	JXh75JXcvZOBit2AEF/ex3yiMQHGqN+aYIvRZUYQpNQLIWWSflcdH9LV4hgXhEyP
	IYIbnXloesaZflx7ODCpq7RWuV5ii/jkibYOTlFBlzBN+PQbB4S0kL+p6dpQCXs0
	JRutp5q8mLfbciskaj64xXIPzuk2rKWmpbqWsc60S5Rz+rJ0e4g4D5r7F//W4N8t
	lsQ/w2PvKK925eBlgJmZ0QzhrDkQx1mTjSV5aNVtvFW7um7drorCKCpAfifnfd1u
	hKQBH9rHMqco6Ng5oQuV+wRK90d3sSUpjAhCn61srIcmedXD/8kWHhMVd5cTabsq
	fzFawDZ/51RvS4ou0ilA==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x5ybmr42b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 15:22:09 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 42TFM6vX008936;
	Fri, 29 Mar 2024 15:22:06 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3x1r5mk6j3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 29 Mar 2024 15:22:06 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42TFM6ba008922;
	Fri, 29 Mar 2024 15:22:06 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-msarkar-hyd.qualcomm.com [10.213.111.194])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 42TFM5fI008905;
	Fri, 29 Mar 2024 15:22:06 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3891782)
	id 7BE853C2F; Fri, 29 Mar 2024 20:52:03 +0530 (+0530)
From: Mrinmay Sarkar <quic_msarkar@quicinc.com>
To: andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, konrad.dybcio@linaro.org,
        manivannan.sadhasivam@linaro.org
Cc: quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com,
        quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com,
        quic_krichai@quicinc.com, quic_vbadigan@quicinc.com,
        quic_schintav@quicinc.com, Mrinmay Sarkar <quic_msarkar@quicinc.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v10 1/3] dt-bindings: PCI: qcom-ep: Add support for SA8775P SoC
Date: Fri, 29 Mar 2024 20:51:55 +0530
Message-Id: <1711725718-6362-2-git-send-email-quic_msarkar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1711725718-6362-1-git-send-email-quic_msarkar@quicinc.com>
References: <1711725718-6362-1-git-send-email-quic_msarkar@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: _KX9zdpWIMbofC4F5I7td-chCAokxXcI
X-Proofpoint-GUID: _KX9zdpWIMbofC4F5I7td-chCAokxXcI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-29_13,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 phishscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 priorityscore=1501 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2403290135
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Add devicetree bindings support for SA8775P SoC. It has DMA register
space and dma interrupt to support HDMA.

Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/pci/qcom,pcie-ep.yaml      | 64 +++++++++++++++++++++-
 1 file changed, 62 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
index a223ce0..46802f7 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
@@ -13,6 +13,7 @@ properties:
   compatible:
     oneOf:
       - enum:
+          - qcom,sa8775p-pcie-ep
           - qcom,sdx55-pcie-ep
           - qcom,sm8450-pcie-ep
       - items:
@@ -20,6 +21,7 @@ properties:
           - const: qcom,sdx55-pcie-ep
 
   reg:
+    minItems: 6
     items:
       - description: Qualcomm-specific PARF configuration registers
       - description: DesignWare PCIe registers
@@ -27,8 +29,10 @@ properties:
       - description: Address Translation Unit (ATU) registers
       - description: Memory region used to map remote RC address space
       - description: BAR memory region
+      - description: DMA register space
 
   reg-names:
+    minItems: 6
     items:
       - const: parf
       - const: dbi
@@ -36,13 +40,14 @@ properties:
       - const: atu
       - const: addr_space
       - const: mmio
+      - const: dma
 
   clocks:
-    minItems: 7
+    minItems: 5
     maxItems: 8
 
   clock-names:
-    minItems: 7
+    minItems: 5
     maxItems: 8
 
   qcom,perst-regs:
@@ -57,14 +62,18 @@ properties:
           - description: Perst separation enable offset
 
   interrupts:
+    minItems: 2
     items:
       - description: PCIe Global interrupt
       - description: PCIe Doorbell interrupt
+      - description: DMA interrupt
 
   interrupt-names:
+    minItems: 2
     items:
       - const: global
       - const: doorbell
+      - const: dma
 
   reset-gpios:
     description: GPIO used as PERST# input signal
@@ -125,6 +134,10 @@ allOf:
               - qcom,sdx55-pcie-ep
     then:
       properties:
+        reg:
+          maxItems: 6
+        reg-names:
+          maxItems: 6
         clocks:
           items:
             - description: PCIe Auxiliary clock
@@ -143,6 +156,10 @@ allOf:
             - const: slave_q2a
             - const: sleep
             - const: ref
+        interrupts:
+          maxItems: 2
+        interrupt-names:
+          maxItems: 2
 
   - if:
       properties:
@@ -152,6 +169,10 @@ allOf:
               - qcom,sm8450-pcie-ep
     then:
       properties:
+        reg:
+          maxItems: 6
+        reg-names:
+          maxItems: 6
         clocks:
           items:
             - description: PCIe Auxiliary clock
@@ -172,6 +193,45 @@ allOf:
             - const: ref
             - const: ddrss_sf_tbu
             - const: aggre_noc_axi
+        interrupts:
+          maxItems: 2
+        interrupt-names:
+          maxItems: 2
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sa8775p-pcie-ep
+    then:
+      properties:
+        reg:
+          minItems: 7
+          maxItems: 7
+        reg-names:
+          minItems: 7
+          maxItems: 7
+        clocks:
+          items:
+            - description: PCIe Auxiliary clock
+            - description: PCIe CFG AHB clock
+            - description: PCIe Master AXI clock
+            - description: PCIe Slave AXI clock
+            - description: PCIe Slave Q2A AXI clock
+        clock-names:
+          items:
+            - const: aux
+            - const: cfg
+            - const: bus_master
+            - const: bus_slave
+            - const: slave_q2a
+        interrupts:
+          minItems: 3
+          maxItems: 3
+        interrupt-names:
+          minItems: 3
+          maxItems: 3
 
 unevaluatedProperties: false
 
-- 
2.7.4


