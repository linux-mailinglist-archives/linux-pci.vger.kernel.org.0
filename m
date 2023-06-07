Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3D867265AC
	for <lists+linux-pci@lfdr.de>; Wed,  7 Jun 2023 18:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232646AbjFGQS0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Jun 2023 12:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232353AbjFGQSY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Jun 2023 12:18:24 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 595AC199D;
        Wed,  7 Jun 2023 09:18:21 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 357ErJHX030519;
        Wed, 7 Jun 2023 16:18:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=61vBZyVK0yu2dGKEX+jl2JNYtBVOpZg+u5PQ1Clhego=;
 b=RqCIUKfdVfU+DCkJC0HvRIv6vyV0Xofzxf18yzTyzAxwVOXBQ5gze0TCYlc+NhfnDQDL
 iczVfiNTgucllYrFz9FBlL3WfKY5pq3CA8XM45FQc7OC5maVTyCdtsi+PvtIve8+yY//
 8x7KNPPUqmhkCSbRU9pQ3ZBufQJt40B3S+qKh2glsMbbXx8cS/flZQS0pOeM2EA2owyJ
 8ARUPE9G3UFOBpWIHtpoBOAYxwEG4LOHtm7TrwMfc+q2Qjej3U0stLscIe5INFi1AfWd
 1GGTWjekrmu4y3C96oGvlpHML4tJBU7oXV5Mtddf8GiM0K6BYRrG63EGKj48AFOtS2g8 OQ== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r2a9taa5g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Jun 2023 16:18:13 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 357GI9bu029209;
        Wed, 7 Jun 2023 16:18:09 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3qyxkm3bua-1;
        Wed, 07 Jun 2023 16:18:09 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 357GI9Na029187;
        Wed, 7 Jun 2023 16:18:09 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-krichai-hyd.qualcomm.com [10.213.110.112])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 357GI9i0029181;
        Wed, 07 Jun 2023 16:18:09 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 4058933)
        id 7F3B437F1; Wed,  7 Jun 2023 21:48:08 +0530 (+0530)
From:   Krishna chaitanya chundru <quic_krichai@quicinc.com>
To:     manivannan.sadhasivam@linaro.org
Cc:     quic_vbadigan@quicinc.com, quic_ramkri@quicinc.com,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org (open list:ARM/QUALCOMM SUPPORT),
        linux-pci@vger.kernel.org (open list:PCIE ENDPOINT DRIVER FOR QUALCOMM),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 1/3] dt-bindings: PCI: qcom: ep: Add interconnects path
Date:   Wed,  7 Jun 2023 21:48:05 +0530
Message-Id: <1686154687-29356-2-git-send-email-quic_krichai@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1686154687-29356-1-git-send-email-quic_krichai@quicinc.com>
References: <1686154687-29356-1-git-send-email-quic_krichai@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: fYNWjBnjsuVGdglBZbo2ghLCjPXAHmF3
X-Proofpoint-GUID: fYNWjBnjsuVGdglBZbo2ghLCjPXAHmF3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_07,2023-06-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 phishscore=0 clxscore=1015 impostorscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=919 spamscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306070138
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add the "pcie-mem" interconnect path to the bindings.

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
 Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
index b3c22eb..6fc5440 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
@@ -70,6 +70,13 @@ properties:
     description: GPIO used as WAKE# output signal
     maxItems: 1
 
+  interconnects:
+    maxItems: 1
+
+  interconnect-names:
+    items:
+      - const: pcie-mem
+
   resets:
     maxItems: 1
 
@@ -97,6 +104,8 @@ required:
   - interrupts
   - interrupt-names
   - reset-gpios
+  - interconnects
+  - interconnect-names
   - resets
   - reset-names
   - power-domains
-- 
2.7.4

