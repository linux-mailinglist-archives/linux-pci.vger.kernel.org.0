Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC5D7C5183
	for <lists+linux-pci@lfdr.de>; Wed, 11 Oct 2023 13:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbjJKLTU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Oct 2023 07:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234824AbjJKLTS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Oct 2023 07:19:18 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B45D5B6;
        Wed, 11 Oct 2023 04:19:16 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39B8qAEB007975;
        Wed, 11 Oct 2023 11:18:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=TNKGPbGDhbLVkw9aPj73i3CiAj6+IyvL5KZ0PLjcvFQ=;
 b=WL1ZgyNP5Uwag2bmpIjG9p9XuG1rid3X9sK09CAvrGrsJBP0gwsSty+nED/xRn2ibXgy
 gDoidZP85ZtQZiQRqFGpGqgGFz/USCzQKHiJIieLN+CpAvhmBIYbyHa8Yu89B2vJiOiJ
 vj1CfpSou/xFVBRvlCno01Jg6kJT5dy0yYAvMWFBQt+MZP5gN/BhpPbEWH6bwls0pd9k
 2meUshj22rYD3KKcMBaWVReCd8lzZXqoiMbsmUfGOHqGp5WTIoKTiAJ5Uo2AHDNKWDSk
 PLezLm+ECtypdHavjYLnMO3/k2mJrJjZUmwr32/Nwa6auvBamjwkHakvr3naX+tqz4A8 vw== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tnn1grq02-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Oct 2023 11:18:43 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 39BBIeeF011211;
        Wed, 11 Oct 2023 11:18:40 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3tk0dkmax4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 11 Oct 2023 11:18:40 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39BBIeJa011205;
        Wed, 11 Oct 2023 11:18:40 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-msarkar-hyd.qualcomm.com [10.213.111.194])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 39BBIedd011204;
        Wed, 11 Oct 2023 11:18:40 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3891782)
        id 3D5C143B8; Wed, 11 Oct 2023 16:48:39 +0530 (+0530)
From:   Mrinmay Sarkar <quic_msarkar@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        konrad.dybcio@linaro.org, mani@kernel.org
Cc:     quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com,
        quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com,
        dmitry.baryshkov@linaro.org, robh@kernel.org,
        quic_krichai@quicinc.com, quic_vbadigan@quicinc.com,
        quic_parass@quicinc.com, Mrinmay Sarkar <quic_msarkar@quicinc.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mhi@lists.linux.dev,
        linux-phy@lists.infradead.org
Subject: [PATCH v2 1/4] dt-bindings: PCI: qcom-ep: Add support for SA8775P SoC
Date:   Wed, 11 Oct 2023 16:48:26 +0530
Message-Id: <1697023109-23671-2-git-send-email-quic_msarkar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1697023109-23671-1-git-send-email-quic_msarkar@quicinc.com>
References: <1697023109-23671-1-git-send-email-quic_msarkar@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: YKT7-gGCyonivAYj82mBxU8keRi90ucR
X-Proofpoint-ORIG-GUID: YKT7-gGCyonivAYj82mBxU8keRi90ucR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-11_09,2023-10-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 mlxlogscore=951 lowpriorityscore=0 suspectscore=0 phishscore=0
 impostorscore=0 mlxscore=0 priorityscore=1501 clxscore=1011 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310110099
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add devicetree bindings support for SA8775P SoC.
Define reg and interrupt per platform.

Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
---
 .../devicetree/bindings/pci/qcom,pcie-ep.yaml      | 131 +++++++++++++++++----
 1 file changed, 109 insertions(+), 22 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
index a223ce0..8f219a6e 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
@@ -13,36 +13,28 @@ properties:
   compatible:
     oneOf:
       - enum:
+          - qcom,sa8775p-pcie-ep
           - qcom,sdx55-pcie-ep
           - qcom,sm8450-pcie-ep
       - items:
+          - const: qcom,sa8775p-pcie-ep
           - const: qcom,sdx65-pcie-ep
           - const: qcom,sdx55-pcie-ep
 
   reg:
-    items:
-      - description: Qualcomm-specific PARF configuration registers
-      - description: DesignWare PCIe registers
-      - description: External local bus interface registers
-      - description: Address Translation Unit (ATU) registers
-      - description: Memory region used to map remote RC address space
-      - description: BAR memory region
+    minItems: 6
+    maxItems: 7
 
   reg-names:
-    items:
-      - const: parf
-      - const: dbi
-      - const: elbi
-      - const: atu
-      - const: addr_space
-      - const: mmio
+    minItems: 6
+    maxItems: 7
 
   clocks:
-    minItems: 7
+    minItems: 5
     maxItems: 8
 
   clock-names:
-    minItems: 7
+    minItems: 5
     maxItems: 8
 
   qcom,perst-regs:
@@ -57,14 +49,12 @@ properties:
           - description: Perst separation enable offset
 
   interrupts:
-    items:
-      - description: PCIe Global interrupt
-      - description: PCIe Doorbell interrupt
+    minItems: 2
+    maxItems: 3
 
   interrupt-names:
-    items:
-      - const: global
-      - const: doorbell
+    minItems: 2
+    maxItems: 3
 
   reset-gpios:
     description: GPIO used as PERST# input signal
@@ -122,6 +112,51 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,sa8775p-pcie-ep
+    then:
+      properties:
+        reg:
+          items:
+            - description: Qualcomm-specific PARF configuration registers
+            - description: DesignWare PCIe registers
+            - description: External local bus interface registers
+            - description: Address Translation Unit (ATU) registers
+            - description: Memory region used to map remote RC address space
+            - description: BAR memory region
+            - description: DMA register space
+        reg-names:
+          items:
+            - const: parf
+            - const: dbi
+            - const: elbi
+            - const: atu
+            - const: addr_space
+            - const: mmio
+            - const: dma
+    else:
+      properties:
+        reg:
+          items:
+            - description: Qualcomm-specific PARF configuration registers
+            - description: DesignWare PCIe registers
+            - description: External local bus interface registers
+            - description: Address Translation Unit (ATU) registers
+            - description: Memory region used to map remote RC address space
+            - description: BAR memory region
+        reg-names:
+          items:
+            - const: parf
+            - const: dbi
+            - const: elbi
+            - const: atu
+            - const: addr_space
+            - const: mmio
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
               - qcom,sdx55-pcie-ep
     then:
       properties:
@@ -173,6 +208,58 @@ allOf:
             - const: ddrss_sf_tbu
             - const: aggre_noc_axi
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sa8775-pcie-ep
+    then:
+      properties:
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
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sa8775p-pcie-ep
+    then:
+      properties:
+        interrupts:
+          items:
+            - description: PCIe Global interrupt
+            - description: PCIe Doorbell interrupt
+            - description: DMA interrupt
+        interrupt-names:
+          items:
+            - const: global
+            - const: doorbell
+            - const: dma
+    else:
+      properties:
+        interrupts:
+          items:
+            - description: PCIe Global interrupt
+            - description: PCIe Doorbell interrupt
+        interrupt-names:
+          items:
+            - const: global
+            - const: doorbell
+
 unevaluatedProperties: false
 
 examples:
-- 
2.7.4

