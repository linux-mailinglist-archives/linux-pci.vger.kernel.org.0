Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8657D99E3
	for <lists+linux-pci@lfdr.de>; Fri, 27 Oct 2023 15:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbjJ0Ne0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Oct 2023 09:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbjJ0NeZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Oct 2023 09:34:25 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A57499D;
        Fri, 27 Oct 2023 06:34:23 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39RDTQ2i028888;
        Fri, 27 Oct 2023 13:33:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=BAVyImNKbXVxc6XIZHl/WVjMCAPa6tolmQ7QKLHI+nQ=;
 b=gL3pHDewcZnGTBjN0FGFFBsBBM0HcVxRB2JCXwgRMo2E4X8LhpvweJ6qBFlhEQVrzmY1
 NMtikm9Y5+1YRTi74faKFXAzrmy4sIq0W8EJLfvbZvFQLGWcvK3xCQjVnSIYHGRLJ641
 k9khr2mlxdiQ1e/2ICeJhifzRXIa3hpZOx5bYGypdLTA6Pv7Uo4qWTrqLWBYFhPeWbQ7
 9QGqA3fsBH2q14i/asc75d7MMC5xlk8jW/75pKGzYwjwZNyrjMO49W6XJ0/B5cv6xpWB
 wEsravtD3SS2LMoxALIGt+xt7AQcpHoIZ67HX0Z/7m45pUbztip551CMu6EnAkSbT+ln UQ== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tyxbva5uh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Oct 2023 13:33:21 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 39RDXHlu026037;
        Fri, 27 Oct 2023 13:33:17 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3tv7qmaapq-1;
        Fri, 27 Oct 2023 13:33:17 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39RDXHkG026029;
        Fri, 27 Oct 2023 13:33:17 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-msarkar-hyd.qualcomm.com [10.213.111.194])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 39RDXH2d026027;
        Fri, 27 Oct 2023 13:33:17 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3891782)
        id 9DC754837; Fri, 27 Oct 2023 19:03:16 +0530 (+0530)
From:   Mrinmay Sarkar <quic_msarkar@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        konrad.dybcio@linaro.org, mani@kernel.org
Cc:     quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com,
        quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com,
        dmitry.baryshkov@linaro.org, robh@kernel.org,
        quic_krichai@quicinc.com, quic_vbadigan@quicinc.com,
        quic_parass@quicinc.com, quic_schintav@quicinc.com,
        Mrinmay Sarkar <quic_msarkar@quicinc.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mhi@lists.linux.dev
Subject: [PATCH v4 1/4] dt-bindings: PCI: qcom-ep: Add support for SA8775P SoC
Date:   Fri, 27 Oct 2023 19:03:09 +0530
Message-Id: <1698413592-26523-2-git-send-email-quic_msarkar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1698413592-26523-1-git-send-email-quic_msarkar@quicinc.com>
References: <1698413592-26523-1-git-send-email-quic_msarkar@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: q5Kt2pkKWelJ-AJV0AKrm1SY3bR7A7aB
X-Proofpoint-GUID: q5Kt2pkKWelJ-AJV0AKrm1SY3bR7A7aB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-27_11,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 adultscore=0 impostorscore=0 mlxlogscore=942
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310270117
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add devicetree bindings support for SA8775P SoC. It has DMA register
space and dma interrupt to support HDMA.

Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
---
 .../devicetree/bindings/pci/qcom,pcie-ep.yaml      | 48 +++++++++++++++++++++-
 1 file changed, 46 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
index a223ce0..567efc4 100644
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
@@ -173,6 +182,41 @@ allOf:
             - const: ddrss_sf_tbu
             - const: aggre_noc_axi
 
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
+
 unevaluatedProperties: false
 
 examples:
-- 
2.7.4

