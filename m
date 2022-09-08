Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E65945B178F
	for <lists+linux-pci@lfdr.de>; Thu,  8 Sep 2022 10:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbiIHIrW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Sep 2022 04:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231699AbiIHIq6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Sep 2022 04:46:58 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C4EFD221;
        Thu,  8 Sep 2022 01:46:43 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28887nmB011099;
        Thu, 8 Sep 2022 08:46:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=qTr6NX0nU5Dt4X9zra8IX/RB9sp9h+qsIwTZ4S5p0Ms=;
 b=NK3PhQnkhVLJkzc9liQUjh8FbBta0FuoKsMD8suoK/LsSYuuuTZAcv9xaVFPlS3WNP+J
 ra/BeIG0E/PkHp/gh8Xqt5ge/9j8gAcxmhMtSZolAm1QS6KWywGuF2zIwxS5G0vgoSMQ
 j1Rll3s2ygOXniASN/GKrEYWPR2E7+31cJcEF33D0sKWpHwpgCQusVatm0Cbz3p0mDxd
 1TUIs93FxYjdUk5R4cxx4Cz8kGi4700E5zn5mwaCte5cVlLhH5JP4ZjzHHbj9R61imgs
 GrSkmZz9kH3Fa64iB8TGML/6sucZoQDebpf3FSAofsDFDavWPcjV/7ZBed5SvIB8jdo8 Ug== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jenmjv9cp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Sep 2022 08:46:23 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 2888kKVp014080;
        Thu, 8 Sep 2022 08:46:20 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3jc00m3e15-1;
        Thu, 08 Sep 2022 08:46:20 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2888gNm6008440;
        Thu, 8 Sep 2022 08:46:20 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-krichai-hyd.qualcomm.com [10.213.110.37])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 2888kJDl014065;
        Thu, 08 Sep 2022 08:46:19 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 4058933)
        id 0E08A44A2; Thu,  8 Sep 2022 14:16:19 +0530 (+0530)
From:   Krishna chaitanya chundru <quic_krichai@quicinc.com>
To:     helgaas@kernel.org
Cc:     linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mka@chromium.org,
        quic_vbadigan@quicinc.com, quic_hemantk@quicinc.com,
        quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
        quic_ramkri@quicinc.com, manivannan.sadhasivam@linaro.org,
        swboyd@chromium.org, dmitry.baryshkov@linaro.org,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS)
Subject: [PATCH v4 2/2] dt-bindings: pci: QCOM Add missing sc7280 aggre0, aggre1 clocks
Date:   Thu,  8 Sep 2022 14:16:16 +0530
Message-Id: <1662626776-19636-3-git-send-email-quic_krichai@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1662626776-19636-1-git-send-email-quic_krichai@quicinc.com>
References: <1662626776-19636-1-git-send-email-quic_krichai@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: OkrfsiW35YNSxNOlCbI124ffix3nVzOJ
X-Proofpoint-ORIG-GUID: OkrfsiW35YNSxNOlCbI124ffix3nVzOJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-08_06,2022-09-07_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 impostorscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 spamscore=0 adultscore=0
 phishscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2207270000 definitions=main-2209080031
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add missing aggre0 and aggre1 clocks.

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
changes since v3:
	- Changed the order of the clocks.
---
 Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index 22a2aac..54f0785 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -56,11 +56,11 @@ properties:
   # Platform constraints are described later.
   clocks:
     minItems: 3
-    maxItems: 12
+    maxItems: 13
 
   clock-names:
     minItems: 3
-    maxItems: 12
+    maxItems: 13
 
   resets:
     minItems: 1
@@ -427,8 +427,8 @@ allOf:
     then:
       properties:
         clocks:
-          minItems: 11
-          maxItems: 11
+          minItems: 13
+          maxItems: 13
         clock-names:
           items:
             - const: pipe # PIPE clock
@@ -442,6 +442,8 @@ allOf:
             - const: slave_q2a # Slave Q2A clock
             - const: tbu # PCIe TBU clock
             - const: ddrss_sf_tbu # PCIe SF TBU clock
+            - const: aggre0 # Aggre NoC PCIe CENTER SF AXI clock
+            - const: aggre1 # Aggre NoC PCIe1 AXI clock
         resets:
           maxItems: 1
         reset-names:
-- 
2.7.4

