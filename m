Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89A8C708747
	for <lists+linux-pci@lfdr.de>; Thu, 18 May 2023 19:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjERRss (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 May 2023 13:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjERRsR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 May 2023 13:48:17 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F3C10E6;
        Thu, 18 May 2023 10:48:12 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34IFgecP012352;
        Thu, 18 May 2023 17:48:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=WH2q1eTTzCem1++Dct9CVIebrtgMtbEilSLzBsm7Ang=;
 b=Ywyb7hHov5CCfbYPL7ikMgJhCkgGB5UB21cIgJMY1b6bLv+EOxHaB7/FEyaDrtwE9uns
 HIZ6/1ezLjFeUK7PCTJq+1SbykqhGqUDHV7bo/DDrn8nvnHCp/JEPZ+bGJ9jg5RmIPey
 o+aQRowteriAZZwEUZLAH+1Wo7ZLGe47ihHyl9zjbjUCCQ3AZBaIqfcKjmtsaIyXXKA9
 4srwBhTOcQg5HVo2Jm8pDXkWpaxlBxw5YGg81OzEHuqxpk0SQfJwQcx/sIpnfhfGQVXg
 xDDGNisFpji7dYeQMy3ALVhywQEq7KJqZndeBAai8LPj1CCT/8yt89bXuznjSOxy8qMX Gw== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qnfpw1emm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 May 2023 17:48:06 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 34IHm23L012137;
        Thu, 18 May 2023 17:48:02 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3qj3mkakxc-1;
        Thu, 18 May 2023 17:48:02 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34IHm1BK012014;
        Thu, 18 May 2023 17:48:02 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-rohiagar-hyd.qualcomm.com [10.213.106.138])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 34IHm120011967;
        Thu, 18 May 2023 17:48:01 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id 1D3DC5EC0; Thu, 18 May 2023 23:18:01 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mani@kernel.org, bhelgaas@google.com, lpieralisi@kernel.org,
        kw@linux.com, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, manivannan.sadhasivam@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH v6 1/5] dt-bindings: PCI: qcom: Add SDX65 SoC
Date:   Thu, 18 May 2023 23:17:49 +0530
Message-Id: <1684432073-28490-2-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1684432073-28490-1-git-send-email-quic_rohiagar@quicinc.com>
References: <1684432073-28490-1-git-send-email-quic_rohiagar@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: BdoyNiSrwIV_5HBvzws9LbkHKlmTtQHw
X-Proofpoint-GUID: BdoyNiSrwIV_5HBvzws9LbkHKlmTtQHw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_13,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 suspectscore=0 clxscore=1011 bulkscore=0
 adultscore=0 phishscore=0 mlxlogscore=781 impostorscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305180144
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add PCIe EP compatible string for SDX65 SoC.

Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
index b3c22eb..8111122 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
@@ -13,6 +13,7 @@ properties:
   compatible:
     enum:
       - qcom,sdx55-pcie-ep
+      - qcom,sdx65-pcie-ep
       - qcom,sm8450-pcie-ep
 
   reg:
@@ -109,6 +110,7 @@ allOf:
           contains:
             enum:
               - qcom,sdx55-pcie-ep
+              - qcom,sdx65-pcie-ep
     then:
       properties:
         clocks:
-- 
2.7.4

