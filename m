Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E60BE73F013
	for <lists+linux-pci@lfdr.de>; Tue, 27 Jun 2023 03:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbjF0BBz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Jun 2023 21:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbjF0BBy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Jun 2023 21:01:54 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 956A8FD;
        Mon, 26 Jun 2023 18:01:53 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35R0u4w2011038;
        Tue, 27 Jun 2023 01:01:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=sDwBxXejWXDBtWl1o+jOBgjUmJEiZx7qI5LRlD/XWpY=;
 b=E7s6GknhGubKLDBVMwMbPXtTljxjhz0dZ9PmpK2DKmzro0LI/j1InBpCnq7bMLHaVPTI
 uHmHuj12JtCI6OOJgdJ/jr/qWUnbsQhFBPvYxeZGuvyyZzSm+De5AELigHZVVrK7UjnZ
 Du2y28+prkL0r/r9VRBmi6K4bvO20lNYwSkHLvSrUvdrBvZs5+MzQa90eG7w8AZfSZ+J
 lNubEoCPouQi8Uje9BFUWpZ3PefSx05/naVdzWbuSuLM0FTx2jGioqwftLzLCepDnPqO
 n+rybvLvQGOivR4iXgZ+j9nzyg70LNzyCoqzWkeIXqpzJuGDYDtLjjYE1/wBqRg3D3Qb Og== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rfc0d9779-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Jun 2023 01:01:46 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 35R11h4u006812;
        Tue, 27 Jun 2023 01:01:43 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3rdsjkh3c2-1;
        Tue, 27 Jun 2023 01:01:43 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35R11hIs006713;
        Tue, 27 Jun 2023 01:01:43 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-krichai-hyd.qualcomm.com [10.213.110.112])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 35R11hPG006662;
        Tue, 27 Jun 2023 01:01:43 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 4058933)
        id BA9184AA9; Tue, 27 Jun 2023 06:31:42 +0530 (+0530)
From:   Krishna chaitanya chundru <quic_krichai@quicinc.com>
To:     manivannan.sadhasivam@linaro.org
Cc:     helgaas@kernel.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_nitegupt@quicinc.com,
        quic_skananth@quicinc.com, quic_ramkri@quicinc.com,
        krzysztof.kozlowski@linaro.org,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS)
Subject: [PATCH v5 1/3] dt-bindings: PCI: qcom: ep: Add interconnects path
Date:   Tue, 27 Jun 2023 06:31:29 +0530
Message-Id: <1687827692-6181-2-git-send-email-quic_krichai@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1687827692-6181-1-git-send-email-quic_krichai@quicinc.com>
References: <1687827692-6181-1-git-send-email-quic_krichai@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: YqehASMTlpiQOY43AzczmrZvgwMFIA8H
X-Proofpoint-ORIG-GUID: YqehASMTlpiQOY43AzczmrZvgwMFIA8H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-26_20,2023-06-26_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 mlxlogscore=999 clxscore=1015 mlxscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306270007
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Some platforms may not boot if a device driver doesn't
initialize the interconnect path. Mostly it is handled
by the bootloader but we have starting to see cases
where bootloader simply ignores them.

Add the "pcie-mem" interconnect path as a required property
to the bindings.

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
index 8111122..bc32e13 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
@@ -71,6 +71,13 @@ properties:
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
 
@@ -98,6 +105,8 @@ required:
   - interrupts
   - interrupt-names
   - reset-gpios
+  - interconnects
+  - interconnect-names
   - resets
   - reset-names
   - power-domains
@@ -167,7 +176,9 @@ examples:
   - |
     #include <dt-bindings/clock/qcom,gcc-sdx55.h>
     #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interconnect/qcom,sdx55.h>
     #include <dt-bindings/interrupt-controller/arm-gic.h>
+
     pcie_ep: pcie-ep@1c00000 {
         compatible = "qcom,sdx55-pcie-ep";
         reg = <0x01c00000 0x3000>,
@@ -194,6 +205,8 @@ examples:
         interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>,
                      <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
         interrupt-names = "global", "doorbell";
+        interconnects = <&system_noc MASTER_PCIE &mc_virt SLAVE_EBI_CH0>;
+        interconnect-names = "pcie-mem";
         reset-gpios = <&tlmm 57 GPIO_ACTIVE_LOW>;
         wake-gpios = <&tlmm 53 GPIO_ACTIVE_LOW>;
         resets = <&gcc GCC_PCIE_BCR>;
-- 
2.7.4

