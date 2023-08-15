Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 925D877CCA0
	for <lists+linux-pci@lfdr.de>; Tue, 15 Aug 2023 14:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235938AbjHOM2H (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Aug 2023 08:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237152AbjHOM1s (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Aug 2023 08:27:48 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91361BD6;
        Tue, 15 Aug 2023 05:27:37 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37FCH3ca005901;
        Tue, 15 Aug 2023 12:27:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=hBoqQNYinRixBsd7z6VRfQIvyEU0m9OlACM0wH7zDYo=;
 b=SBkD8csXcoL4BX+hV+G5sgFRGadv8ILvUGAk8mGgV5cQEswgjMJQWF2TjqH9M9eIfTbK
 pKfeKBIac2ubhZsClTfKmHFjaCuQnsIkl/OWKNAK1Tkj0OUixjl8bNQNZVz1gU/EI78L
 NT63KD6E0VvRYoNNk4YaeGny/fpSXn6TSqTKqhutNeggIxylbqYJNLDfh9EhGRXA6yoU
 6ea7isWOe0TPU72b35V52jlwc6MYxyC8faE5FUJ20+e6krfLy8AwdnHof1DCTrzNY9X7
 fA/jCPqbQKZFN6YVH0upIq42YNVaFQ9HvJGJ5EnZOABIXNVnYIIunAR+oJpe5khZ7LkD KQ== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sg66hr9sy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Aug 2023 12:27:33 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 37FCRUpO022574;
        Tue, 15 Aug 2023 12:27:30 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3se35kb8qh-1;
        Tue, 15 Aug 2023 12:27:30 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37FCRU21022568;
        Tue, 15 Aug 2023 12:27:30 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-krichai-hyd.qualcomm.com [10.213.110.112])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 37FCRUkx022567;
        Tue, 15 Aug 2023 12:27:30 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 4058933)
        id B97F34BC5; Tue, 15 Aug 2023 17:57:29 +0530 (+0530)
From:   Krishna chaitanya chundru <quic_krichai@quicinc.com>
To:     manivannan.sadhasivam@linaro.org
Cc:     helgaas@kernel.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_nitegupt@quicinc.com,
        quic_skananth@quicinc.com, quic_ramkri@quicinc.com,
        quic_parass@quicinc.com, krzysztof.kozlowski@linaro.org,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS)
Subject: [PATCH v1 2/3] arm64: dts: qcom: sm8450: Add opp table support to PCIe
Date:   Tue, 15 Aug 2023 17:56:47 +0530
Message-Id: <1692102408-7010-3-git-send-email-quic_krichai@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1692102408-7010-1-git-send-email-quic_krichai@quicinc.com>
References: <1692102408-7010-1-git-send-email-quic_krichai@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: zEh6PQ6qjuD4fP1KHG26jJ05RNTJbnew
X-Proofpoint-GUID: zEh6PQ6qjuD4fP1KHG26jJ05RNTJbnew
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-15_13,2023-08-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 mlxscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 impostorscore=0 mlxlogscore=778
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308150111
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCIe needs to choose the appropriate performance state of RPMH power
domain based upon the PCIe gen speed.

So, let's add the OPP table support to specify RPMH performance states.

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 47 ++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 595533a..681ea9c 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -381,6 +381,49 @@
 		};
 	};
 
+	pcie0_opp_table: opp-table-pcie0 {
+		compatible = "operating-points-v2";
+
+		opp-2500000 {
+			opp-hz = /bits/ 64 <2500000>;
+			opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
+		};
+
+		opp-5000000 {
+			opp-hz = /bits/ 64 <5000000>;
+			opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
+		};
+
+		opp-8000000 {
+			opp-hz = /bits/ 64 <8000000>;
+			opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
+		};
+	};
+
+	pcie1_opp_table: opp-table-pcie1 {
+		compatible = "operating-points-v2";
+
+		opp-2500000 {
+			opp-hz = /bits/ 64 <2500000>;
+			opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
+		};
+
+		opp-5000000 {
+			opp-hz = /bits/ 64 <5000000>;
+			opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
+		};
+
+		opp-8000000 {
+			opp-hz = /bits/ 64 <8000000>;
+			opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
+		};
+
+		opp-16000000 {
+			opp-hz = /bits/ 64 <16000000>;
+			opp-level = <RPMH_REGULATOR_LEVEL_NOM>;
+		};
+	};
+
 	reserved_memory: reserved-memory {
 		#address-cells = <2>;
 		#size-cells = <2>;
@@ -1803,6 +1846,8 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&pcie0_default_state>;
 
+			operating-points-v2 = <&pcie0_opp_table>;
+
 			status = "disabled";
 		};
 
@@ -1915,6 +1960,8 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&pcie1_default_state>;
 
+			operating-points-v2 = <&pcie1_opp_table>;
+
 			status = "disabled";
 		};
 
-- 
2.7.4

