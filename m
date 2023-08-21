Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9D90782B57
	for <lists+linux-pci@lfdr.de>; Mon, 21 Aug 2023 16:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235733AbjHUOP4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Aug 2023 10:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235726AbjHUOPz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Aug 2023 10:15:55 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11ECE6;
        Mon, 21 Aug 2023 07:15:52 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37LCxK2U021713;
        Mon, 21 Aug 2023 14:15:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=X+rJ3T/Gy3rI3w8mOb6ImsrazsNMPv4JQ55QQJsJnOY=;
 b=mte/qwd6H6OlQdIKuPqhTBjU1WbjO2gjQ9kH2XudMD3KB1BWRWDprSe9/xwwVleyfsFu
 n2AgzfzaG6G2Uayv1qNtvCTBapdnSwdPzm5YHGrjLdMhns6umQn+QUsQiCmtqD4gfmtP
 yEQN396+0IMTTTnil61aFsWiGL5cYxil6ya2Mv9I9LygIYjKbRIFXwFqAWTBHCDI6M/5
 Wr+htzMl08017oQkznWyFzlFHgdS0nDn/RrnGIJTkqubwogGrgzAof1ify0TppSNTVGH
 A061wOSYMKLc0X5RJWQCFJbMVtM4vnghJkgrjB/eluQbFpHRc/jXh1/MgdmSvCCNUwf/ RA== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sjmrekt0q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Aug 2023 14:15:48 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 37LEFjwj010017;
        Mon, 21 Aug 2023 14:15:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3sjptkpqf9-1;
        Mon, 21 Aug 2023 14:15:45 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37LEFjbD010003;
        Mon, 21 Aug 2023 14:15:45 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-krichai-hyd.qualcomm.com [10.213.110.112])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 37LEFjVP009995;
        Mon, 21 Aug 2023 14:15:45 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 4058933)
        id BED8E4C16; Mon, 21 Aug 2023 19:45:44 +0530 (+0530)
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
Subject: [PATCH v3 2/3] arm64: dts: qcom: sm8450: Add opp table support to PCIe
Date:   Mon, 21 Aug 2023 19:45:42 +0530
Message-Id: <1692627343-4380-3-git-send-email-quic_krichai@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1692627343-4380-1-git-send-email-quic_krichai@quicinc.com>
References: <1692627343-4380-1-git-send-email-quic_krichai@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: l0pA4s8EGlCHBPCHFVBr8XsOBA4Xsnyl
X-Proofpoint-ORIG-GUID: l0pA4s8EGlCHBPCHFVBr8XsOBA4Xsnyl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-21_01,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 mlxscore=0 lowpriorityscore=0 impostorscore=0 mlxlogscore=748
 malwarescore=0 adultscore=0 bulkscore=0 clxscore=1015 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308210131
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
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
index 595533a..3af0cf9 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -1803,7 +1803,28 @@
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
@@ -1915,7 +1936,33 @@
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

