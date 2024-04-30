Return-Path: <linux-pci+bounces-6896-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A62868B7C5F
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 17:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20A891F21153
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 15:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C373917B4E9;
	Tue, 30 Apr 2024 15:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="M0xt2S6Y"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6446417556B;
	Tue, 30 Apr 2024 15:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714492568; cv=none; b=p1uwSV+YbT1h4t67lyNQtPnXwFGfEn7rXXcM+qojYDPRnZTJlT+pFvEnnmPyo0TLF+R5Zol5dBiHQ/K5eVEC0B7fsDl7ahQUo4NqjpP9VwgGx/pmx+g85k/GAvF/L9udjWqHCV+A/6nlauUOVGnyMjs6gofc58ISqQiKX1ALeXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714492568; c=relaxed/simple;
	bh=nUeLNnDpGTQ8y7SaH6xF7dPGjlruKEbLRTeFsoqCrto=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=UOxPUeFxX7i5wp6iuiyck2NaunO22fBCN/u98ycXXE7s0u2n6eb8MigwScK7ZfWErc5PqfqgDdejh0t+FSD5gS/CxX4oHW6yZfoI5RlEQqHo9gdxaxRs2ZsN0cOG69aMrQQavYs5Vv3RtDAUqd6cS9eTMZDZc0p6E2pp0mM8tBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=M0xt2S6Y; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43UDwI3E024796;
	Tue, 30 Apr 2024 15:55:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references; s=
	qcppdkim1; bh=3z7tTu3vHsIre5hBJss/48GAtbHvOmc4TtZZL0fZtEU=; b=M0
	xt2S6YvyMY/aDIK5XflSCc1hPPRjTK2FwgPoUVDlCXB9Fnbnqn4YYNkULeCSYOhe
	sPtxAhciG6akdp6tnKaAXakfUGIkB/TGc0OKlIGd1LN5oyUpDhYIstNCGIt+HTQd
	3HLqS5NKyzjSEFLR6ASYtYTuPE8K/4s4ojRLgxjpdWfmZGnUgkWikH8MTEPn+Vjb
	cdEX4j+3ShI6bG+uoMVMtxIehOncKc7q9Hx63q+7vLpK9es99oY9TdbBDT9j9pB3
	jNIv8JyaQHdQVaTyke0E+YWqR9iyEBdgpMw47fqp1ZwSyWYul9YicMEkHERVGJXS
	90N42FWP8QHBzcxmS2xQ==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xthgvud0j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 15:55:52 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 43UFtmgv032497;
	Tue, 30 Apr 2024 15:55:48 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3xrtem1a7h-1;
	Tue, 30 Apr 2024 15:55:48 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43UFtmhM032491;
	Tue, 30 Apr 2024 15:55:48 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-msarkar-hyd.qualcomm.com [10.213.111.194])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 43UFtmQt032490;
	Tue, 30 Apr 2024 15:55:48 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3891782)
	id 8FB263BD6; Tue, 30 Apr 2024 21:25:47 +0530 (+0530)
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
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v11 1/3] dt-bindings: PCI: qcom-ep: Add support for SA8775P SoC
Date: Tue, 30 Apr 2024 21:25:37 +0530
Message-Id: <1714492540-15419-2-git-send-email-quic_msarkar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1714492540-15419-1-git-send-email-quic_msarkar@quicinc.com>
References: <1714492540-15419-1-git-send-email-quic_msarkar@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: jjy2zaXAeV8alu63wSi7H3y7YKUEu3Hn
X-Proofpoint-GUID: jjy2zaXAeV8alu63wSi7H3y7YKUEu3Hn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-30_08,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 adultscore=0 mlxscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 mlxlogscore=999 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404300111
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


