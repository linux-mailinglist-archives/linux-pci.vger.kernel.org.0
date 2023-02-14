Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CEED696A05
	for <lists+linux-pci@lfdr.de>; Tue, 14 Feb 2023 17:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232105AbjBNQm5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Feb 2023 11:42:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232447AbjBNQmw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Feb 2023 11:42:52 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A331BC6;
        Tue, 14 Feb 2023 08:42:45 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31E6PGRB029883;
        Tue, 14 Feb 2023 16:42:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=EG9vdCV8I9posIsKwbOaPXOT+W/+oj/Lmc85K6VwWlE=;
 b=W90j7gsw/3CllmKKCVfT1+bRk8Wc157cecV5Ts6ssYR0VnjZoxYf/P1oW8GRl0lX27hZ
 5QEvcfossgy4NGwBEu4s0RMDJwdZaesCzBwae6ktfumBlCVX8wzQIJZPGMP9QQfIn6At
 nw6znmpUgM2YWcC2NkTlnzWkOTQMMJYJSF2aA8Wx9vtwlP6ezmHIuViL50CQt1fmdzeM
 O/bmSP8fGtrIPnzFovLqS3cSFDTIpYyxh/vo2EGh7Lv+tqRoy/+aM3HQyMwpmYKHtPY9
 utuPHDForzzr+sSoAnafhFSaSi7/BHjIYbpd6VQ5g0qF8Dmoz6U5sCkS1dUff7nWvcc4 CQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nqtv0aqx4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 16:42:32 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31EGgVT8003454
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 16:42:31 GMT
Received: from devipriy-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 14 Feb 2023 08:42:23 -0800
From:   Devi Priya <quic_devipriy@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <lpieralisi@kernel.org>,
        <kw@linux.com>, <robh@kernel.org>, <bhelgaas@google.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <mani@kernel.org>, <p.zabel@pengutronix.de>,
        <svarbanov@mm-sol.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <linux-clk@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_anusha@quicinc.com>
Subject: [PATCH 3/7] dt-bindings: phy: qcom,qmp-pcie: Add ipq9574 compatible
Date:   Tue, 14 Feb 2023 22:11:31 +0530
Message-ID: <20230214164135.17039-4-quic_devipriy@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230214164135.17039-1-quic_devipriy@quicinc.com>
References: <20230214164135.17039-1-quic_devipriy@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: sxAABHs8xvTb0-sYiNo6nEjy2lFx_qIT
X-Proofpoint-ORIG-GUID: sxAABHs8xvTb0-sYiNo6nEjy2lFx_qIT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-14_11,2023-02-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302140142
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add the compatible for the PCIe QMP PHYs found on IPQ9574

Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
---
 .../phy/qcom,ipq8074-qmp-pcie-phy.yaml        | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,ipq8074-qmp-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,ipq8074-qmp-pcie-phy.yaml
index 62045dcfb20c..1131f0d87a9c 100644
--- a/Documentation/devicetree/bindings/phy/qcom,ipq8074-qmp-pcie-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,ipq8074-qmp-pcie-phy.yaml
@@ -22,6 +22,8 @@ properties:
       - qcom,ipq6018-qmp-pcie-phy
       - qcom,ipq8074-qmp-gen3-pcie-phy
       - qcom,ipq8074-qmp-pcie-phy
+      - qcom,ipq9574-qmp-gen3x1-pcie-phy
+      - qcom,ipq9574-qmp-gen3x2-pcie-phy
       - qcom,msm8998-qmp-pcie-phy
       - qcom,sc8180x-qmp-pcie-phy
       - qcom,sdm845-qhp-pcie-phy
@@ -165,6 +167,30 @@ allOf:
             - const: phy
             - const: common
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,ipq9574-qmp-gen3x1-pcie-phy
+              - qcom,ipq9574-qmp-gen3x2-pcie-phy
+    then:
+      properties:
+        clocks:
+          maxItems: 4
+        clock-names:
+          items:
+            - const: aux
+            - const: cfg_ahb
+            - const: anoc_lane
+            - const: snoc_lane
+        resets:
+          maxItems: 2
+        reset-names:
+          items:
+            - const: phy
+            - const: common
+
   - if:
       properties:
         compatible:
@@ -203,6 +229,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,ipq9574-qmp-gen3x2-pcie-phy
               - qcom,sm8250-qmp-gen3x2-pcie-phy
               - qcom,sm8250-qmp-modem-pcie-phy
               - qcom,sm8450-qmp-gen4x2-pcie-phy
@@ -224,6 +251,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,ipq9574-qmp-gen3x1-pcie-phy
               - qcom,sc8180x-qmp-pcie-phy
               - qcom,sdm845-qmp-pcie-phy
               - qcom,sdx55-qmp-pcie-phy
-- 
2.17.1

