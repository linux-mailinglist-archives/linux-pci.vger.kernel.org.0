Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAEE8751FCA
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jul 2023 13:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233984AbjGMLUm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jul 2023 07:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234395AbjGMLUh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Jul 2023 07:20:37 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 572782703;
        Thu, 13 Jul 2023 04:20:33 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36D6RLps008957;
        Thu, 13 Jul 2023 11:20:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=a/X1FFHaWN2vRp3imLzc9nrTHycORh/+rtRoKayrDF8=;
 b=NBsZnySsogpgApqYviOjs5HnnFI7Vj6DUJR9xLq841Zt6npaJeoC8V81JzObPvkgHGtO
 +LtXtwfYLKmH+QDLHUm8oSohzaiICRC964j/tLQB4i4Rdsfomoxhrh/wn8SiCcAkH9fW
 LRdGErtIhRlQBfRWWMM3OQuSlGAxEqg/NGGMFqTyeyaElGS/oojbc9GrG5p8KQmnLflc
 8gXAK8H5is0EwHP3sdC9KN4zX4I4FBt8opnESChpIXIga3t0usjZ3Y5s+SMqsYEQq5il
 NpvE1l/85P7Vkcs10lYRtBlTSYGTWSMQWiG50EwSwDDVvG1olY8IGLjgn6EHSh4nAv4K /Q== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rshyubphe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jul 2023 11:20:24 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 36DBKJ51011992;
        Thu, 13 Jul 2023 11:20:19 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3rq0vm0p8u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 13 Jul 2023 11:20:19 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36DBKJEb011969;
        Thu, 13 Jul 2023 11:20:19 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-krichai-hyd.qualcomm.com [10.213.110.112])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 36DBKIFg011966;
        Thu, 13 Jul 2023 11:20:19 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 4058933)
        id 6F3C147C7; Thu, 13 Jul 2023 16:50:18 +0530 (+0530)
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
Subject: [PATCH v8 1/3] dt-bindings: PCI: qcom: ep: Add interconnects path
Date:   Thu, 13 Jul 2023 16:50:11 +0530
Message-Id: <1689247213-13569-2-git-send-email-quic_krichai@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1689247213-13569-1-git-send-email-quic_krichai@quicinc.com>
References: <1689247213-13569-1-git-send-email-quic_krichai@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: UByQcKmYHZC2P1v21HJjIyAkGNCiF8I8
X-Proofpoint-ORIG-GUID: UByQcKmYHZC2P1v21HJjIyAkGNCiF8I8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-13_04,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 bulkscore=0 spamscore=0 mlxlogscore=999 phishscore=0
 clxscore=1015 mlxscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307130099
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
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

Add the "pcie-mem" interconnect path as a required property
to the bindings.

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
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

