Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E96EC747F3B
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jul 2023 10:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232046AbjGEIRl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Jul 2023 04:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231958AbjGEIRj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Jul 2023 04:17:39 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78FA71719;
        Wed,  5 Jul 2023 01:17:38 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3657rSZa023285;
        Wed, 5 Jul 2023 08:17:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=BZCOCbcf3tjCgT7VICbftvYbIBdhPLUkBBYxBXdIf6A=;
 b=lPvok6Qt3WgcPf59HchHj/SxoZjtQFAQCVMzfzQKTiwsjhaZcE4ZgNsBTkST4pXvAuSM
 Pf8medstFPdBZ8xpvwJetcfDx0VXqwlxROSAJB3FIEHFGQoU2qZaG4oAuDOa2Yxz4QL2
 P5iZWkQVxmQbCyoU4+0j5iVSkFc4OxcDYWG1bYLrM8nI4eX7D7T+PCEJi43hkr0sLZ1I
 IYTsfFdiw9g7PnTraood2vb+NR2jX5A7T/pLZCjUvILlkXNJo3CvHwgJKcuAtyc4ayyy
 CCFsyfW8Cshp97yQHeX8ZnKItMlgqaIUHNWjSKo+NxgjVzggYV85Ng55dhlZgolePBk8 dw== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rmnw6h7tx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Jul 2023 08:17:30 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3658HRZZ021547;
        Wed, 5 Jul 2023 08:17:27 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3rjd7krn86-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 05 Jul 2023 08:17:27 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3658HQ7W021540;
        Wed, 5 Jul 2023 08:17:26 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-msarkar-hyd.qualcomm.com [10.213.111.194])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3658HQCe021539;
        Wed, 05 Jul 2023 08:17:26 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3891782)
        id BD350244; Wed,  5 Jul 2023 13:47:25 +0530 (+0530)
From:   Mrinmay Sarkar <quic_msarkar@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        konrad.dybcio@linaro.org, mani@kernel.org
Cc:     quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com,
        quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com,
        Mrinmay Sarkar <quic_msarkar@quicinc.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org
Subject: [PATCH v1 1/6] dt-bindings: PCI: qcom: Add sa8775p compatible
Date:   Wed,  5 Jul 2023 13:47:06 +0530
Message-Id: <1688545032-17748-2-git-send-email-quic_msarkar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1688545032-17748-1-git-send-email-quic_msarkar@quicinc.com>
References: <1688545032-17748-1-git-send-email-quic_msarkar@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: sdJFXv1jqVOY6if6_Ak38XBmYaqWOU1n
X-Proofpoint-ORIG-GUID: sdJFXv1jqVOY6if6_Ak38XBmYaqWOU1n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-04_16,2023-07-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 lowpriorityscore=0 mlxscore=0 phishscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=999 adultscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307050075
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add sa8775p platform to the binding.

Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
---
 .../devicetree/bindings/pci/qcom,pcie.yaml    | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index 81971be4e554..2c79585a2d1e 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -40,6 +40,7 @@ properties:
           - qcom,pcie-sm8450-pcie0
           - qcom,pcie-sm8450-pcie1
           - qcom,pcie-sm8550
+          - qcom,pcie-sa8775p
       - items:
           - const: qcom,pcie-msm8998
           - const: qcom,pcie-msm8996
@@ -220,6 +221,7 @@ allOf:
               - qcom,pcie-sm8450-pcie0
               - qcom,pcie-sm8450-pcie1
               - qcom,pcie-sm8550
+              - qcom,pcie-sa8775p
     then:
       properties:
         reg:
@@ -743,6 +745,30 @@ allOf:
           items:
             - const: pci # PCIe core reset
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+                - qcom,pcie-sa8775p
+    then:
+      properties:
+        clocks:
+          minItems: 5
+          maxItems: 5
+        clock-names:
+          items:
+            - const: aux # Auxiliary clock
+            - const: cfg # Configuration clock
+            - const: bus_master # Master AXI clock
+            - const: bus_slave # Slave AXI clock
+            - const: slave_q2a # Slave Q2A clock
+        resets:
+          maxItems: 1
+        reset-names:
+          items:
+            - const: pci # PCIe core reset
+
   - if:
       properties:
         compatible:
@@ -750,6 +776,7 @@ allOf:
             enum:
               - qcom,pcie-sa8540p
               - qcom,pcie-sc8280xp
+              - qcom,pcie-sa8775p
     then:
       required:
         - interconnects
@@ -854,6 +881,7 @@ allOf:
               - qcom,pcie-ipq8074-gen3
               - qcom,pcie-qcs404
               - qcom,pcie-sa8540p
+              - qcom,pcie-sa8775p
     then:
       properties:
         interrupts:
-- 
2.39.2

