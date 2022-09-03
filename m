Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00B0A5ABC40
	for <lists+linux-pci@lfdr.de>; Sat,  3 Sep 2022 04:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbiICCNd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Sep 2022 22:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiICCNc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Sep 2022 22:13:32 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB590E42D3;
        Fri,  2 Sep 2022 19:13:31 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2831x4DK021313;
        Sat, 3 Sep 2022 02:13:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=ZFXrryaYjDttXiD4SZkuchQKUakT1Az9vh77aUMaUWA=;
 b=Qx9jlOjsxSzmmN8379fn1IqPtj1uiHCmWf5hSZtm6QkFFbUC6e98rHwsBmx9/mH+5cre
 MMPJYMxKDe9G/ZKIvVOk1fDSq7wF2lAK8unKvDnDnhBidGvcVto8wwMciX+Os1tZjtr7
 zGbs/kc9Ow/EuVPZ8rahj+Cia/+lPjT5v01siWn/LAGti80ONPKuXaSzwkuWPnjcYDOJ
 0Z59INO1u0FerZua8IIP2WIi6/6i13X20t/tC/5G37YIdkZJJWAk6DBJAyH0Mou2gv4i
 oWtX8vj3poxsZBCuzO5020S+Ni1YYVw0UbjRY42Ldk/rNtbc6RhasCX+hwWYovHCZVRp dA== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jbj0m2307-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 03 Sep 2022 02:13:19 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 2832COXB005554;
        Sat, 3 Sep 2022 02:13:15 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3j7cbktgw1-1;
        Sat, 03 Sep 2022 02:13:15 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2832DETI006205;
        Sat, 3 Sep 2022 02:13:14 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-krichai-hyd.qualcomm.com [10.213.110.37])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 2832D7nW006175;
        Sat, 03 Sep 2022 02:13:14 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 4058933)
        id E6F6F447F; Sat,  3 Sep 2022 07:43:06 +0530 (+0530)
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
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS)
Subject: [PATCH v3 2/3] dt-bindings: pci: QCOM Add missing sc7280 aggre0, aggre1 clocks
Date:   Sat,  3 Sep 2022 07:43:03 +0530
Message-Id: <1662171184-25211-3-git-send-email-quic_krichai@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1662171184-25211-1-git-send-email-quic_krichai@quicinc.com>
References: <1662171184-25211-1-git-send-email-quic_krichai@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 4frPmzU8UWmTee_u1N_lZuw2h219-Xtm
X-Proofpoint-ORIG-GUID: 4frPmzU8UWmTee_u1N_lZuw2h219-Xtm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-02_08,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 mlxscore=0 malwarescore=0 phishscore=0 spamscore=0
 adultscore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 mlxlogscore=989 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209030010
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
changes since v2:
	- Increase the max items of clock's in common properties.
---
 Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index 0b69b12..b759465 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -53,11 +53,11 @@ properties:
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
@@ -423,8 +423,8 @@ allOf:
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
@@ -437,6 +437,8 @@ allOf:
             - const: bus_slave # Slave AXI clock
             - const: slave_q2a # Slave Q2A clock
             - const: tbu # PCIe TBU clock
+            - const: aggre0 # Aggre NoC PCIe CENTER SF AXI clock
+            - const: aggre1 # Aggre NoC PCIe1 AXI clock
             - const: ddrss_sf_tbu # PCIe SF TBU clock
         resets:
           maxItems: 1
-- 
2.7.4

