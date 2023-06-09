Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF13729862
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jun 2023 13:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233218AbjFILrt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Jun 2023 07:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbjFILrs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Jun 2023 07:47:48 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E791A2;
        Fri,  9 Jun 2023 04:47:47 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 359BhXK7012286;
        Fri, 9 Jun 2023 11:47:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=jPjdIT4c2cHjtUFgvsSH76hoyHy2Cd0Yd8pyA4UMsII=;
 b=UelNutOgbBudpINBTEg/i3J39B4yjQezgRmKTvwV6d2hiNHSsdK6hwnKguAgG874ThG4
 tdhwMpZoO4HGB3XkpNLYmq751T5MgvRb7r8bk7damSt3HIhtZODtCh+9U8vrJClABAeo
 E3QvJ+AUaxE8ciyw40rhil6Vd5X1wYUmKVmcQgdkjAEW/qWgWAQDnAprffOeRlDnKS+s
 wuOvrCEMRtte8NFNVXe+R7UlEg+vwtQ5ueJjysRIZKBYSIqJ3pRc4AGNMoyV8y51uOGO
 wfokR2Wss5bzW/VL6WPqpbGwM566fRPAHOAgnFfsQae7u17zI+BuRdbwOfhf8jwJRZas ig== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r3tyxrwpc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Jun 2023 11:47:41 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 359BlcqW004160;
        Fri, 9 Jun 2023 11:47:38 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3qyxkmeq3a-1;
        Fri, 09 Jun 2023 11:47:38 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 359BlcSX004140;
        Fri, 9 Jun 2023 11:47:38 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-krichai-hyd.qualcomm.com [10.213.110.112])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 359Blbpe004112;
        Fri, 09 Jun 2023 11:47:38 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 4058933)
        id 04D9D3313; Fri,  9 Jun 2023 17:17:37 +0530 (+0530)
From:   Krishna chaitanya chundru <quic_krichai@quicinc.com>
To:     manivannan.sadhasivam@linaro.org
Cc:     quic_vbadigan@quicinc.com, quic_ramkri@quicinc.com,
        linux-arm-msm@vger.kernel.org,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-pci@vger.kernel.org (open list:PCIE ENDPOINT DRIVER FOR QUALCOMM),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 1/3] dt-bindings: PCI: qcom: ep: Add interconnects path
Date:   Fri,  9 Jun 2023 17:17:26 +0530
Message-Id: <1686311249-6857-2-git-send-email-quic_krichai@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1686311249-6857-1-git-send-email-quic_krichai@quicinc.com>
References: <1686311249-6857-1-git-send-email-quic_krichai@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: -OIYfkTeX6F8QtpV4tlnJvM1vDCe34JW
X-Proofpoint-ORIG-GUID: -OIYfkTeX6F8QtpV4tlnJvM1vDCe34JW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-09_08,2023-06-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 phishscore=0
 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306090099
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Some platforms may not boot if a device driver doesn't initialize
the interconnect path. Mostly it is handled by the bootloader but
we have starting to see cases where bootloader simply ignores them.

Add the "pcie-mem" interconnect path as a required property to the
bindings.

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
 Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
index b3c22eb..656e362 100644
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
@@ -194,6 +203,8 @@ examples:
         interrupt-names = "global", "doorbell";
         reset-gpios = <&tlmm 57 GPIO_ACTIVE_LOW>;
         wake-gpios = <&tlmm 53 GPIO_ACTIVE_LOW>;
+	interconnects = <&system_noc MASTER_PCIE_0 &mc_virt SLAVE_EBI1>;
+	interconnect-names = "pci-mem";
         resets = <&gcc GCC_PCIE_BCR>;
         reset-names = "core";
         power-domains = <&gcc PCIE_GDSC>;
-- 
2.7.4

