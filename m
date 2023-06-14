Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 061787301CC
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jun 2023 16:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236737AbjFNO0p (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Jun 2023 10:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245622AbjFNOYo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Jun 2023 10:24:44 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A86E2681;
        Wed, 14 Jun 2023 07:24:38 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35EDoFrT025189;
        Wed, 14 Jun 2023 14:24:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=BfHmvk+g9AQJGd01j+KoLrwIjXWmP0hV9e13Sp23ExM=;
 b=kXdTFcIQK6NIAAb5MSVSSZZrWWK7KzqrFP7+/IQWndjYvS3flf6ahvgLGaIHW9wNcVLP
 aQOacSY9Roq51sdp8on+WIk3cjv3VoA92IRuMTPhKnFEJRcnV0BYb4Lu14oGcV6q00hK
 fk25Uqrc3gbUsm+O57oW5zhCnx2xhX1kh5SFyVk7dyx4QCcGlnVkjuquO+qsQT4igdEH
 Bw7CjJJ+YvtAMZeIVrQKzgfCcwnAhGv5yPpe9EJhNnImx08f/Rw9BtvjFJ+GwGs8u859
 upaSAC+HoMyE1+OZ8+3qsI8VldRk74ahvAy6eyvTo19T4QkdL/qO8V975AL648AvtNpK nA== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r7eceg406-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Jun 2023 14:24:33 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 35EEOS6G027280;
        Wed, 14 Jun 2023 14:24:28 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3r4j8m2a8p-1;
        Wed, 14 Jun 2023 14:24:28 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35EEOSVP027268;
        Wed, 14 Jun 2023 14:24:28 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-krichai-hyd.qualcomm.com [10.213.110.112])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 35EEOSXJ027263;
        Wed, 14 Jun 2023 14:24:28 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 4058933)
        id 1179A45A1; Wed, 14 Jun 2023 19:54:28 +0530 (+0530)
From:   Krishna chaitanya chundru <quic_krichai@quicinc.com>
To:     manivannan.sadhasivam@linaro.org
Cc:     quic_vbadigan@quicinc.com, quic_ramkri@quicinc.com,
        linux-arm-msm@vger.kernel.org, konrad.dybcio@linaro.org,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-pci@vger.kernel.org (open list:PCIE ENDPOINT DRIVER FOR QUALCOMM),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 1/3] dt-bindings: PCI: qcom: ep: Add interconnects path
Date:   Wed, 14 Jun 2023 19:54:24 +0530
Message-Id: <1686752666-13426-2-git-send-email-quic_krichai@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1686752666-13426-1-git-send-email-quic_krichai@quicinc.com>
References: <1686752666-13426-1-git-send-email-quic_krichai@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: hOq_7iKr6DQZeG3rOsFNCyTx-2E6Wdwh
X-Proofpoint-ORIG-GUID: hOq_7iKr6DQZeG3rOsFNCyTx-2E6Wdwh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-14_10,2023-06-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2306140125
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
---
 Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
index b3c22eb..154a08e 100644
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
@@ -165,7 +174,9 @@ examples:
   - |
     #include <dt-bindings/clock/qcom,gcc-sdx55.h>
     #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interconnect/qcom,sdx55.h>
     #include <dt-bindings/interrupt-controller/arm-gic.h>
+
     pcie_ep: pcie-ep@1c00000 {
         compatible = "qcom,sdx55-pcie-ep";
         reg = <0x01c00000 0x3000>,
@@ -192,6 +203,8 @@ examples:
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

