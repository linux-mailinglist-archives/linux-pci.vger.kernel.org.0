Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5573675D08B
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jul 2023 19:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjGURY5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Jul 2023 13:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjGURYz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Jul 2023 13:24:55 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FCFD198D;
        Fri, 21 Jul 2023 10:24:54 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36LEaO0i017179;
        Fri, 21 Jul 2023 17:24:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=nzXg4rxxm/IsnnjqRB+/U/wN1SxeBjmYAZbAhFXWSrU=;
 b=kc+KdujOn/8bLY2yVSdcmfluH/AUY7r8z8eWSCLwTcPucGXIFBkaXTNetPFNIw4psbEh
 tIjaj8u1VpoCoSW89BKOc8ezN2iPHcaIDGeoQWRVZSNZUv6TIJkX43Q2YiLIxPoHljxo
 T7NmIQH5UQDo3Kv1WldgrrSU0KFAsKRGIi8CFsb2JXtIAqfHaK+QdowdWGASq/h2EhAB
 a16Lqztm0f5Ifxadz6WvKtj1lxPBIO2pESCcOSeV4b4J065wa/5Qqsx0BxO6unRDgage
 Xz1XxbKiA4LWEaSASBHrQ3XEauNt0f+oPQ/pHtWF1/OV4Ub8qYKvQIOlq2LSbR8DK4vK Zg== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ryhdy9r3y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jul 2023 17:24:47 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 36LHOiQn023756;
        Fri, 21 Jul 2023 17:24:44 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3rumhknepf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 21 Jul 2023 17:24:44 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36LHOi6i023745;
        Fri, 21 Jul 2023 17:24:44 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-msarkar-hyd.qualcomm.com [10.213.111.194])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 36LHOhsa023744;
        Fri, 21 Jul 2023 17:24:44 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3891782)
        id 1811C32C9; Fri, 21 Jul 2023 22:54:43 +0530 (+0530)
From:   Mrinmay Sarkar <quic_msarkar@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        konrad.dybcio@linaro.org, mani@kernel.org
Cc:     quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com,
        quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com,
        dmitry.baryshkov@linaro.org,
        Mrinmay Sarkar <quic_msarkar@quicinc.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/4] dt-bindings: PCI: qcom: Add sa8775p compatible
Date:   Fri, 21 Jul 2023 22:54:32 +0530
Message-Id: <1689960276-29266-2-git-send-email-quic_msarkar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1689960276-29266-1-git-send-email-quic_msarkar@quicinc.com>
References: <1689960276-29266-1-git-send-email-quic_msarkar@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: X5AusCD69MkcwNt_90B0Pn4Gw7Fj_lsN
X-Proofpoint-ORIG-GUID: X5AusCD69MkcwNt_90B0Pn4Gw7Fj_lsN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-21_10,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 spamscore=0 malwarescore=0 clxscore=1015 priorityscore=1501 adultscore=0
 mlxlogscore=999 impostorscore=0 phishscore=0 lowpriorityscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307210153
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add sa8775p platform to the binding.

Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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

