Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79914758EBD
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jul 2023 09:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbjGSHVL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Jul 2023 03:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbjGSHUy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Jul 2023 03:20:54 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2051FE8;
        Wed, 19 Jul 2023 00:20:38 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36J7477V011074;
        Wed, 19 Jul 2023 07:20:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=9o7YPoNhptdVPiBy2o7oEDnBNhfZkA/Z5kBzrOCyRO4=;
 b=WwoeuLtt7QeD8UC80QWlPUj3YdNrDE2MG5w3f+ONt/M76VUlVjr702b4EEd+Vs5uJzXm
 9oyv0JilkHiJakabA8i691jOZ1zhaCBIqc2j2cS69fyjaGTbgwWzTSEp1BL9SxVTN5Iz
 K+2I6MmVlK5TkLHXZ8mv8hewmz3x7rUT1C43ApprIZuxR33fvHYtmYBLsTn776t0vzlb
 d1PC/ED1rLDEUihMkcq0wBf/Md+KMWFE5+Na/b2vseM8/aVFz8VpryAdVMrrKb0fG/hA
 lY6An0j3HCtM9IrdNjPLifvgCZaZUc7k1+hwLDkW9TC1Vm4A7MVN3YZrpZUmpt4kHgno Rg== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rwn90asa6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jul 2023 07:20:24 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 36J7KLr2022656;
        Wed, 19 Jul 2023 07:20:21 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3rumhm1v77-1;
        Wed, 19 Jul 2023 07:20:21 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36J7KKor022629;
        Wed, 19 Jul 2023 07:20:21 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-krichai-hyd.qualcomm.com [10.213.110.112])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 36J7KKpN022619;
        Wed, 19 Jul 2023 07:20:20 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 4058933)
        id 4468A4B0E; Wed, 19 Jul 2023 12:50:20 +0530 (+0530)
From:   Krishna chaitanya chundru <quic_krichai@quicinc.com>
To:     manivannan.sadhasivam@linaro.org
Cc:     helgaas@kernel.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_nitegupt@quicinc.com,
        quic_skananth@quicinc.com, quic_ramkri@quicinc.com,
        krzysztof.kozlowski@linaro.org,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS)
Subject: [PATCH v10 3/4] arm: dts: qcom: sdx55: Add CPU PCIe EP interconnect path
Date:   Wed, 19 Jul 2023 12:50:17 +0530
Message-Id: <1689751218-24492-4-git-send-email-quic_krichai@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1689751218-24492-1-git-send-email-quic_krichai@quicinc.com>
References: <1689751218-24492-1-git-send-email-quic_krichai@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: V2Z42PCaNRR-f_ZsEK6VmEHnQy6f8Js8
X-Proofpoint-ORIG-GUID: V2Z42PCaNRR-f_ZsEK6VmEHnQy6f8Js8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-19_04,2023-07-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 bulkscore=0 phishscore=0 spamscore=0 adultscore=0 mlxlogscore=801
 lowpriorityscore=0 mlxscore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
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

Add cpu-pcie interconnect path for PCIe EP to sdx55 platform.

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
 arch/arm/boot/dts/qcom/qcom-sdx55.dtsi | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi b/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi
index df3cd9c..a7c0c26 100644
--- a/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi
@@ -422,8 +422,9 @@
 			interrupt-names = "global",
 					  "doorbell";
 
-			interconnects = <&system_noc MASTER_PCIE &mc_virt SLAVE_EBI_CH0>;
-			interconnect-names = "pcie-mem";
+			interconnects = <&system_noc MASTER_PCIE &mc_virt SLAVE_EBI_CH0>,
+					<&mem_noc MASTER_AMPSS_M0 &system_noc SLAVE_PCIE_0>;
+			interconnect-names = "pcie-mem", "cpu-pcie";
 
 			resets = <&gcc GCC_PCIE_BCR>;
 			reset-names = "core";
-- 
2.7.4

