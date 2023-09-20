Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98BC37A843B
	for <lists+linux-pci@lfdr.de>; Wed, 20 Sep 2023 15:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236475AbjITN5A (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Sep 2023 09:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236024AbjITNzz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Sep 2023 09:55:55 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F159B181;
        Wed, 20 Sep 2023 06:55:46 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38KCsUpn019752;
        Wed, 20 Sep 2023 13:55:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=szlrYCP/Y088fMt/CKKLhRpReT/g5wA7KhUarKQWpJ0=;
 b=oyF8e9ydBpUG4Dx3+NSwBfy5dV2hGPv0mF18jurbjsYG8i7s1U7FGrk4Ug5of2M27+vk
 72UkaCkQ0t7LGrEKarcMlH9iPDKje/miecVn8GtWlRQI0zHeagTQb26ovst1gh0syQbc
 Fl0NRU7531rxKgAhu74gJ+vOZwwQRTGnDAqe1qPPYmIbQF4xj47DSVez9TGa+EKANhjb
 hiz1irK6+qU05s6do/dduzbKWeb2Y4dRkLefiTcMFwnb3D7+8HQSCY8p6gyhThIuPdMO
 oW0lxisS/WAcx5/D9C90klodLr75KoKmvdoPWN7XoFH2WZAsOPc79gELt/9H1+jNEZWU tg== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t7sh3s3h6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Sep 2023 13:55:25 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 38KDtJfR008187;
        Wed, 20 Sep 2023 13:55:21 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3t55ekk8nm-1;
        Wed, 20 Sep 2023 13:55:21 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38KDtL6p008196;
        Wed, 20 Sep 2023 13:55:21 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-msarkar-hyd.qualcomm.com [10.213.111.194])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 38KDtLBh008195;
        Wed, 20 Sep 2023 13:55:21 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3891782)
        id 9EC1B4070; Wed, 20 Sep 2023 19:25:20 +0530 (+0530)
From:   Mrinmay Sarkar <quic_msarkar@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        konrad.dybcio@linaro.org, mani@kernel.org
Cc:     quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com,
        quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com,
        quic_krichai@quicinc.com, quic_vbadigan@quicinc.com,
        quic_parass@quicinc.com, Mrinmay Sarkar <quic_msarkar@quicinc.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mhi@lists.linux.dev,
        linux-phy@lists.infradead.org
Subject: [PATCH v1 1/5] dt-bindings: PCI: qcom-ep: Add support for SA8775P SoC
Date:   Wed, 20 Sep 2023 19:25:08 +0530
Message-Id: <1695218113-31198-2-git-send-email-quic_msarkar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1695218113-31198-1-git-send-email-quic_msarkar@quicinc.com>
References: <1695218113-31198-1-git-send-email-quic_msarkar@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 3cXgrAgb97XpKgSnOv01UtdP3yaGUSZ5
X-Proofpoint-GUID: 3cXgrAgb97XpKgSnOv01UtdP3yaGUSZ5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-20_05,2023-09-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=947
 spamscore=0 adultscore=0 mlxscore=0 phishscore=0 impostorscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309200114
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add devicetree bindings support for SA8775P SoC.
Define reg and interrupt per platform.

Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
---
 .../devicetree/bindings/pci/qcom,pcie-ep.yaml      | 130 +++++++++++++++++----
 1 file changed, 108 insertions(+), 22 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
index a223ce0..e860e8f 100644
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
@@ -20,29 +21,19 @@ properties:
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
@@ -57,14 +48,12 @@ properties:
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
@@ -122,6 +111,51 @@ allOf:
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
+            - description: DMA memory region
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
@@ -173,6 +207,58 @@ allOf:
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

