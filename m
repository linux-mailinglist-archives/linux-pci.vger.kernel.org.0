Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E91C6B06D1
	for <lists+linux-pci@lfdr.de>; Wed,  8 Mar 2023 13:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbjCHMUV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Mar 2023 07:20:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbjCHMUT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Mar 2023 07:20:19 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600AC9CBD9;
        Wed,  8 Mar 2023 04:20:15 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3288pewV017438;
        Wed, 8 Mar 2023 12:20:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=DZJoIsxo/zgQXK7QhMjEwAKSjof6zqSVhvIplApFrbc=;
 b=IRXVbG19FGsgGSSuNyKUSwVJUZNmY1e8TkIHD2nqufrj4XUTm9L59+7V5IdWrhCvhtyU
 kBen2z5X7T6VDdoghuQztnyuC0vKWAQ3VA+wPdLPPQ6jvDWhib72mu74S/KjwN5a/Bke
 GeL1Ni6Wc3ei3EHOt6IGS407/k2p1X1PGpupV+kW+x9MJxa5FIivkSE008U7mmGbZigi
 AwAzSIOfA5PTTRr3dd0zOEB5NHqyka2+20iGB5J5mmOcwv/ApejRmtVTENbq/ofS7zYT
 QhjqROqbLbDsHVGZud/Oms2l8BojsKq7UI04KMrr1x+9PydWNDidGuVfzvJ90xAMb6ao sQ== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p6fmm1hq4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Mar 2023 12:20:08 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 328CK5uf031412;
        Wed, 8 Mar 2023 12:20:05 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3p4fgkn0bq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 08 Mar 2023 12:20:05 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 328CK42A031391;
        Wed, 8 Mar 2023 12:20:04 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-rohiagar-hyd.qualcomm.com [10.213.106.138])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 328CK48i031387;
        Wed, 08 Mar 2023 12:20:04 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id F35FE4FAE; Wed,  8 Mar 2023 17:50:03 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mani@kernel.org,
        lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com,
        manivannan.sadhasivam@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH v2 1/6] dt-bindings: mfd: qcom,tcsr: Add compatible for sdx65
Date:   Wed,  8 Mar 2023 17:49:48 +0530
Message-Id: <1678277993-18836-2-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1678277993-18836-1-git-send-email-quic_rohiagar@quicinc.com>
References: <1678277993-18836-1-git-send-email-quic_rohiagar@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: eIgRJGVg6jwyacdXX8t8Jq773C0nmT1e
X-Proofpoint-ORIG-GUID: eIgRJGVg6jwyacdXX8t8Jq773C0nmT1e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-08_07,2023-03-08_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0
 mlxscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 mlxlogscore=778 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2303080106
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add the qcom,sdx65-tcsr compatible.

Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml b/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
index 2eeebe9..c5d5e3d 100644
--- a/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
+++ b/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
@@ -25,6 +25,7 @@ properties:
           - qcom,sc8280xp-tcsr
           - qcom,sdm630-tcsr
           - qcom,sdm845-tcsr
+          - qcom,sdx65-tcsr
           - qcom,sm8150-tcsr
           - qcom,tcsr-apq8064
           - qcom,tcsr-apq8084
-- 
2.7.4

