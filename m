Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1354758EC3
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jul 2023 09:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229447AbjGSHVO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Jul 2023 03:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbjGSHVA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Jul 2023 03:21:00 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E030B210B;
        Wed, 19 Jul 2023 00:20:43 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36J7G9oC032355;
        Wed, 19 Jul 2023 07:20:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=X8U7m6oeXAUjm/N5kYm0WAl5wvbpfFgciZSimFM50A8=;
 b=G0dEsCpqrJY9vH8e3Kil2NAt8GTB9Boy2ZCQP2GyJ0IA8KGMlvYwJWhAsqxcG/M1oKPt
 c1DFSDgCeIr2BJG18MCSxkP1yhpCsHQf4PV5GfmLfqd+bTVghtgtXAMY2TIWOWfhUrip
 NThmO3sLfZ9EMnljsSKTtvIJm22p+3dczhmGdulSA+/Spd3VAfse4P2L3vgAJ7l7EsGl
 SOnpIXJv1qPYSiNKAhHKUjh+aqOcIZAda4fQr/tJ3BAo2x4aKfHtopvVHEkJJsLOE3wm
 Xpt7sV1jqScnVZQF4jmo/zNEtQFiE4V+0in3Y2ItVOANs6LxYznEK9FMW7NQUdmnrUa9 Ow== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rx8sk087t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jul 2023 07:20:24 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 36J7KKSo022626;
        Wed, 19 Jul 2023 07:20:20 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3rumhm1v72-1;
        Wed, 19 Jul 2023 07:20:20 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36J7KKI9022612;
        Wed, 19 Jul 2023 07:20:20 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-krichai-hyd.qualcomm.com [10.213.110.112])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 36J7KKre022582;
        Wed, 19 Jul 2023 07:20:20 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 4058933)
        id D5D014B07; Wed, 19 Jul 2023 12:50:19 +0530 (+0530)
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
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS)
Subject: [PATCH v10 1/4] dt-bindings: PCI: qcom: ep: Add interconnects path
Date:   Wed, 19 Jul 2023 12:50:15 +0530
Message-Id: <1689751218-24492-2-git-send-email-quic_krichai@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1689751218-24492-1-git-send-email-quic_krichai@quicinc.com>
References: <1689751218-24492-1-git-send-email-quic_krichai@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: j5RE-AyD1ly7aUPmN4MrNP51q2U9nhI_
X-Proofpoint-ORIG-GUID: j5RE-AyD1ly7aUPmN4MrNP51q2U9nhI_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-19_04,2023-07-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 malwarescore=0 bulkscore=0 phishscore=0 mlxlogscore=999 impostorscore=0
 lowpriorityscore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307190066
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Some platforms may not boot if a device driver doesn't
initialize the interconnect path. Mostly it is handled
by the bootloader but we have starting to see cases
where bootloader simply ignores them.

Add the "pcie-mem" & "cpu-pcie" interconnect path as a required
property to the bindings.

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
index 8111122..e553341 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
@@ -71,6 +71,14 @@ properties:
     description: GPIO used as WAKE# output signal
     maxItems: 1
 
+  interconnects:
+    maxItems: 2
+
+  interconnect-names:
+    items:
+      - const: pcie-mem
+      - const: cpu-pcie
+
   resets:
     maxItems: 1
 
@@ -98,6 +106,8 @@ required:
   - interrupts
   - interrupt-names
   - reset-gpios
+  - interconnects
+  - interconnect-names
   - resets
   - reset-names
   - power-domains
@@ -167,7 +177,9 @@ examples:
   - |
     #include <dt-bindings/clock/qcom,gcc-sdx55.h>
     #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interconnect/qcom,sdx55.h>
     #include <dt-bindings/interrupt-controller/arm-gic.h>
+
     pcie_ep: pcie-ep@1c00000 {
         compatible = "qcom,sdx55-pcie-ep";
         reg = <0x01c00000 0x3000>,
@@ -194,6 +206,9 @@ examples:
         interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>,
                      <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
         interrupt-names = "global", "doorbell";
+        interconnects = <&system_noc MASTER_PCIE &mc_virt SLAVE_EBI_CH0>,
+                        <&mem_noc MASTER_AMPSS_M0 &system_noc SLAVE_PCIE_0>;
+        interconnect-names = "pcie-mem", "cpu-pcie";
         reset-gpios = <&tlmm 57 GPIO_ACTIVE_LOW>;
         wake-gpios = <&tlmm 53 GPIO_ACTIVE_LOW>;
         resets = <&gcc GCC_PCIE_BCR>;
-- 
2.7.4

