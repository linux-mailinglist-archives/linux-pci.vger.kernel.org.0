Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01FCC7530E6
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jul 2023 07:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234549AbjGNFJE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Jul 2023 01:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjGNFJD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Jul 2023 01:09:03 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 911D92D40;
        Thu, 13 Jul 2023 22:09:02 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36E3IxNF029344;
        Fri, 14 Jul 2023 05:08:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=Pl1sHQHZIOFEno721n5dvwxYsyeHLBK5VUEn0y23m9M=;
 b=hRfhhKJp25V7XRBL4vdTz5TxkcDvJ5mzE8dq70F60RSrlpTnrK8O9fvLb2t0oX/tv2Xp
 pzVFVPCehsF5K2ZrhbH3qtkktwlxENrmTkCyKXhwQ/k53IdsUEkK3IiziKQBg8Hyr9Lw
 qGinPIMLzMUPCzGxtnpiTbETsBRc2JoEXAZ3Z/AoWds4vuCef7AiaEN+5QL6mug+SggS
 BoHapFXcFpbh8qajrmoTMlv5P3LHSKyXbDqNYWb5jss9USHhnYcTjA5ax8fEi8eBin9Q
 FU8nuLmAnH6VkvoE3BOx8bAgp8TZCMOCERPdaMIDFkOnWadzFjjC3vsTmiyNUo45Ol29 3Q== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rtpu90vnt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jul 2023 05:08:52 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 36E58mqT001100;
        Fri, 14 Jul 2023 05:08:48 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3rq0vm576n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 14 Jul 2023 05:08:48 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36E58lOg001094;
        Fri, 14 Jul 2023 05:08:47 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-msarkar-hyd.qualcomm.com [10.213.111.194])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 36E58lde001092;
        Fri, 14 Jul 2023 05:08:47 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3891782)
        id A4934333B; Fri, 14 Jul 2023 10:38:46 +0530 (+0530)
From:   Mrinmay Sarkar <quic_msarkar@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        konrad.dybcio@linaro.org, mani@kernel.org
Cc:     quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com,
        quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com,
        dmitry.baryshkov@linaro.org,
        Mrinmay Sarkar <quic_msarkar@quicinc.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org
Subject: [PATCH v2 1/6] dt-bindings: PCI: qcom: Add sa8775p compatible
Date:   Fri, 14 Jul 2023 10:38:33 +0530
Message-Id: <1689311319-22054-2-git-send-email-quic_msarkar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1689311319-22054-1-git-send-email-quic_msarkar@quicinc.com>
References: <1689311319-22054-1-git-send-email-quic_msarkar@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: UyCNh2zoUetlhmrd51DUgFsIrNx8t_xk
X-Proofpoint-ORIG-GUID: UyCNh2zoUetlhmrd51DUgFsIrNx8t_xk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-14_02,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 mlxlogscore=999 clxscore=1015 adultscore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307140046
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add sa8775p platform to the binding.

Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
---
 .../devicetree/bindings/pci/qcom,pcie.yaml         | 28 ++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index 81971be4..eadba38 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -29,6 +29,7 @@ properties:
           - qcom,pcie-msm8996
           - qcom,pcie-qcs404
           - qcom,pcie-sa8540p
+          - qcom,pcie-sa8775p
           - qcom,pcie-sc7280
           - qcom,pcie-sc8180x
           - qcom,pcie-sc8280xp
@@ -211,6 +212,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,pcie-sa8775p
               - qcom,pcie-sc7280
               - qcom,pcie-sc8180x
               - qcom,pcie-sc8280xp
@@ -748,7 +750,32 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,pcie-sa8775p
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
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
               - qcom,pcie-sa8540p
+              - qcom,pcie-sa8775p
               - qcom,pcie-sc8280xp
     then:
       required:
@@ -790,6 +817,7 @@ allOf:
           contains:
             enum:
               - qcom,pcie-msm8996
+              - qcom,pcie-sa8775p
               - qcom,pcie-sc7280
               - qcom,pcie-sc8180x
               - qcom,pcie-sdm845
-- 
2.7.4

