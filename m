Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A71937974FA
	for <lists+linux-pci@lfdr.de>; Thu,  7 Sep 2023 17:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbjIGPmk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Sep 2023 11:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345034AbjIGPe0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Sep 2023 11:34:26 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 198A51B2;
        Thu,  7 Sep 2023 08:34:07 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3875ROiQ032686;
        Thu, 7 Sep 2023 06:01:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=KSARd/qNcU715jGJf6E1vkYmquFBHags1tvdcZIWVoE=;
 b=L5r6nGkbUP0yJEJfo5nJ1pwXpDJ/HzVBcqfH06ewrxfQAGmbJ6bAlN7qpkDNV0OYlrgY
 0VG2TFTA87bhbVhtZF+bw0TiL1/lBSWSTsfSqofGd89UrRriPT+aJsXfv2dr4tUcWIlx
 E99d3Sal2FmmG7AMDBAebkZT1KcFJdii7A6yKvGX+ATMAzsKaD6ZMHPhaFV4S5q38+fo
 /CQaT2+JeH56sxvknAvLXZLcysVl9SHHwtlp9rEnTzhAWhwan0+2Wyq49SmvxQg4kiLL
 PnWVTMb/rebb5kefHT0VcOXw73CWYt9Mpfk/QLAeKYLdXhVdZMD9udG2BnrgnZro9twE Pg== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sxxbbh4ex-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Sep 2023 06:01:02 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 38760tH8011303;
        Thu, 7 Sep 2023 06:00:58 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3sux4kjqux-1;
        Thu, 07 Sep 2023 06:00:58 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38760wYJ011325;
        Thu, 7 Sep 2023 06:00:58 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-krichai-hyd.qualcomm.com [10.213.110.112])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 38760wsW011322;
        Thu, 07 Sep 2023 06:00:58 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 4058933)
        id E10C213BA; Thu,  7 Sep 2023 11:30:57 +0530 (+0530)
From:   Krishna chaitanya chundru <quic_krichai@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        vireshk@kernel.org, nm@ti.com, sboyd@kernel.org, mani@kernel.org
Cc:     lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, rafael@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, quic_vbadigan@quicinc.com,
        quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
        quic_ramkri@quicinc.com, quic_parass@quicinc.com,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>
Subject: [PATCH v5 2/5] arm64: dts: qcom: sm8450: Add opp table support to PCIe
Date:   Thu,  7 Sep 2023 11:30:30 +0530
Message-Id: <1694066433-8677-3-git-send-email-quic_krichai@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1694066433-8677-1-git-send-email-quic_krichai@quicinc.com>
References: <1694066433-8677-1-git-send-email-quic_krichai@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Iv7xJpj7QecdvITKG1jz78tc2f240a1H
X-Proofpoint-GUID: Iv7xJpj7QecdvITKG1jz78tc2f240a1H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-06_12,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 mlxlogscore=782 clxscore=1015 bulkscore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2308100000 definitions=main-2309070052
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCIe needs to choose the appropriate performance state of RPMH power
domain based up on the PCIe gen speed.

So let's add the OPP table support to specify RPMH performance states.

Use opp-level for the PCIe gen speed for easier use.

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 47 ++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 2a60cf8..a6264a5 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -1820,7 +1820,28 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&pcie0_default_state>;
 
+			operating-points-v2 = <&pcie0_opp_table>;
+
 			status = "disabled";
+
+			pcie0_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-1 {
+					opp-level = <1>;
+					required-opps = <&rpmhpd_opp_low_svs>;
+				};
+
+				opp-2 {
+					opp-level = <2>;
+					required-opps = <&rpmhpd_opp_low_svs>;
+				};
+
+				opp-3 {
+					opp-level = <3>;
+					required-opps = <&rpmhpd_opp_nom>;
+				};
+			};
 		};
 
 		pcie0_phy: phy@1c06000 {
@@ -1932,7 +1953,33 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&pcie1_default_state>;
 
+			operating-points-v2 = <&pcie1_opp_table>;
+
 			status = "disabled";
+
+			pcie1_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-1 {
+					opp-level = <1>;
+					required-opps = <&rpmhpd_opp_low_svs>;
+				};
+
+				opp-2 {
+					opp-level = <2>;
+					required-opps = <&rpmhpd_opp_low_svs>;
+				};
+
+				opp-3 {
+					opp-level = <3>;
+					required-opps = <&rpmhpd_opp_low_svs>;
+				};
+
+				opp-4 {
+					opp-level = <4>;
+					required-opps = <&rpmhpd_opp_nom>;
+				};
+			};
 		};
 
 		pcie1_phy: phy@1c0f000 {
-- 
2.7.4

