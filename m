Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 199366D173D
	for <lists+linux-pci@lfdr.de>; Fri, 31 Mar 2023 08:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbjCaGSq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 31 Mar 2023 02:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbjCaGSm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 31 Mar 2023 02:18:42 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D322139;
        Thu, 30 Mar 2023 23:18:41 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32V4UlgL001134;
        Fri, 31 Mar 2023 06:18:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=raJSyLbuj6AZNZQxvZzHT259us+hxzpDGHg3diYclz8=;
 b=jY0fRKUMHgi/3elVtiIxaB/AOwZFkZnQ5xGyBra4f9FNcxZTk29lavCIdxy3Ig0qsmE4
 Rn1GfxqE4wdrrh9z5cPwgrTvgn0fAvWUBdFNuIS4ORAsQgj2uSeYq89520ETLXTEm3cu
 qToyCKGvpgYZmc93IP/F3umwr6ndCf2DbSPI6Ko010zQUJTTM6PArbJSJeMhu4TYbxsW
 NBbRMnXeBgowvscpP1lreZku7BAIoCLyrrJdKl0VUuNfjUC6+jt5KAFvSvwjLwKA5MiL
 Ou73vdIi0yPUaPSehh0//8uUY8SWP8t/XBFJ/goqOFD+V9BMtNuog/ClqbRMbetJbL+A dQ== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pn934tjbc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 31 Mar 2023 06:18:35 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 32V6IV6x013884;
        Fri, 31 Mar 2023 06:18:32 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3pht1knm22-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 31 Mar 2023 06:18:31 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32V6IV8r013872;
        Fri, 31 Mar 2023 06:18:31 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-rohiagar-hyd.qualcomm.com [10.213.106.138])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 32V6IVW4013871;
        Fri, 31 Mar 2023 06:18:31 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id CB1F54EED; Fri, 31 Mar 2023 11:48:30 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mani@kernel.org, bhelgaas@google.com, lpieralisi@kernel.org,
        kw@linux.com, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        manivannan.sadhasivam@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH v5 1/5] dt-bindings: PCI: qcom: Add SDX65 SoC
Date:   Fri, 31 Mar 2023 11:48:18 +0530
Message-Id: <1680243502-23744-2-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1680243502-23744-1-git-send-email-quic_rohiagar@quicinc.com>
References: <1680243502-23744-1-git-send-email-quic_rohiagar@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 1q_FV2AIgQxvTvO0hAKmXc66jEc0WDpb
X-Proofpoint-ORIG-GUID: 1q_FV2AIgQxvTvO0hAKmXc66jEc0WDpb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-31_02,2023-03-30_04,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 mlxscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 spamscore=0 mlxlogscore=783 clxscore=1011 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303310050
X-Spam-Status: No, score=0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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

