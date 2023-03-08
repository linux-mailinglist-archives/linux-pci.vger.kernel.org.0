Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03C336B06D7
	for <lists+linux-pci@lfdr.de>; Wed,  8 Mar 2023 13:20:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbjCHMUX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Mar 2023 07:20:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbjCHMUW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Mar 2023 07:20:22 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288C699D48;
        Wed,  8 Mar 2023 04:20:16 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32853GTa022514;
        Wed, 8 Mar 2023 12:20:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=EHvfW6t0u3XxmURtdWPAeOeSYrfJtK2LhlJz6/zB9Aw=;
 b=goKMWnzMPJaxjzJxDzOuAu4b+S07X68t5RvkqdSBRK8WHI/tgKzGDu4Ps3mAl93+6Evo
 Cb8MxNSqXPioMRULhljqQ2rjXBHGwDZd+CDDHBOCbTBIqJasiLoZVi9VKMqIEqnJL7mP
 Ag7gs5bry8PeK+evlP7ARdt/sCpY4R8/5JW1zoJviSIsi44f157hbxyCfxXhcYnq/LVG
 2nwPii+6iswrLwf+o/QKEotl4qU45JQAuxQERHItvRdy9ntImTeZOFMIVBlUZuimJNrk
 d90qrZrS9+A/AXRGIMfx7COwTcCnSWV2h4fIwZJ8BDRkSa3KlIleCdzxANM1JLSl/78I AQ== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p6fga1ju6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Mar 2023 12:20:09 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 328CK5fl031425;
        Wed, 8 Mar 2023 12:20:05 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3p4fgkn0c1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 08 Mar 2023 12:20:05 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 328CK58W031402;
        Wed, 8 Mar 2023 12:20:05 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-rohiagar-hyd.qualcomm.com [10.213.106.138])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 328CK4tX031397;
        Wed, 08 Mar 2023 12:20:05 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id 51C9A4FB4; Wed,  8 Mar 2023 17:50:04 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mani@kernel.org,
        lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com,
        manivannan.sadhasivam@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH v2 2/6] dt-bindings: PCI: qcom: Add SDX65 SoC
Date:   Wed,  8 Mar 2023 17:49:49 +0530
Message-Id: <1678277993-18836-3-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1678277993-18836-1-git-send-email-quic_rohiagar@quicinc.com>
References: <1678277993-18836-1-git-send-email-quic_rohiagar@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Eqendsu02NQ87RcoozG41Rb_mvPB2rlQ
X-Proofpoint-ORIG-GUID: Eqendsu02NQ87RcoozG41Rb_mvPB2rlQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-08_07,2023-03-08_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 spamscore=0 mlxscore=0 clxscore=1015 mlxlogscore=744 impostorscore=0
 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303080106
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add PCIe EP compatible string for SDX65 SoC.

Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
index 89cfdee..096540b 100644
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

