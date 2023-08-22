Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D20FD784523
	for <lists+linux-pci@lfdr.de>; Tue, 22 Aug 2023 17:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235438AbjHVPMo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Aug 2023 11:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234167AbjHVPMn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Aug 2023 11:12:43 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A6F3198;
        Tue, 22 Aug 2023 08:12:39 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37MB20rB004797;
        Tue, 22 Aug 2023 15:12:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=X+rJ3T/Gy3rI3w8mOb6ImsrazsNMPv4JQ55QQJsJnOY=;
 b=lu5GXKpbb+ruciax/ueUOl4fAJyPCcyVP9X085rdio/cZNqkFze5vHrJRRf+OjP5sa1n
 82oNkIFKrlLD4r3lUKC0SZa4Q5SMxuKRf26PFi/Q09Czee2m7cjc82kpXUjzLnUNs+J+
 rnTxfAoxeFuBL7WeGZUB9mf6Xz14sEwLqSHvMcnSLRRFzgPP3+3ZHc7KRulKQPLDoxt2
 Dh4PeJJd2z+5Y9b+xWvnPFp371hIK537Xh3IZl+mLmLvd1jd9PiXp63IEJp9p9rnbK8H
 RSwjHBemuEXjLzvH5DVmWA8CJHHRiCG7w2iMiRAsFs+pg8vI7R+16XColgcY4dygYVay ng== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3smusbrkv2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Aug 2023 15:12:27 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 37MFCO3N032361;
        Tue, 22 Aug 2023 15:12:24 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3sjptkwbvr-1;
        Tue, 22 Aug 2023 15:12:24 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37MFCN3m032349;
        Tue, 22 Aug 2023 15:12:23 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-krichai-hyd.qualcomm.com [10.213.110.112])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 37MFCNqd032337;
        Tue, 22 Aug 2023 15:12:23 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 4058933)
        id 162A24B8A; Tue, 22 Aug 2023 20:42:23 +0530 (+0530)
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
Subject: [PATCH v4 2/4] arm64: dts: qcom: sm8450: Add opp table support to PCIe
Date:   Tue, 22 Aug 2023 20:42:19 +0530
Message-Id: <1692717141-32743-3-git-send-email-quic_krichai@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1692717141-32743-1-git-send-email-quic_krichai@quicinc.com>
References: <1692717141-32743-1-git-send-email-quic_krichai@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 8dCBgGvIh6S8vjRQqfEYy24LgVg6hs3B
X-Proofpoint-GUID: 8dCBgGvIh6S8vjRQqfEYy24LgVg6hs3B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-22_13,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 bulkscore=0 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 mlxlogscore=748 suspectscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308220116
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

