Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7915F6BE199
	for <lists+linux-pci@lfdr.de>; Fri, 17 Mar 2023 07:54:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjCQGyR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Mar 2023 02:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjCQGyQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Mar 2023 02:54:16 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB0124731;
        Thu, 16 Mar 2023 23:54:14 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32H6JYt1023423;
        Fri, 17 Mar 2023 06:54:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=/9dyV5Xq6V5b8tf5RtQHdkaKqWhyTXZtPVIt4IFiap0=;
 b=BuAYVzcpBhOCyeAqDqpDyNRbq73PTcmVrlIOiXoGWNmdtlgPeAT65dwK7vXYoqq1ehAY
 ZWxym7hNnxoIH4p6waSwOD0z3w09nBWYerKlSuvpYLNxnD7Fd6oKBCTTcUcM63LqI7rZ
 2q5Vb62hb1L8cAKknB22wTZuCAEashk1BIgEFNhDjybzf/QvVibWAyPGgaW+FLZJYlMy
 2dkxR6SCQtBqHT2rXZQL+fHGO1OP3A2L19Fpr1iQBrCNgshloz6cwOD8bAElDAWz64G9
 WihhCRDkNWMuGheCfeEajWzCW1Jnko/DWtNxWxMaBxDcuaOJ4h5NkamqLjec0mmfJJiH Lg== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pc624hyx7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Mar 2023 06:54:07 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 32H6s3a0016065;
        Fri, 17 Mar 2023 06:54:04 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3p8jqmd9dw-1;
        Fri, 17 Mar 2023 06:54:04 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32H6s4Zm016111;
        Fri, 17 Mar 2023 06:54:04 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-rohiagar-hyd.qualcomm.com [10.213.106.138])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 32H6s3Rb016108;
        Fri, 17 Mar 2023 06:54:04 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id 314BC4F42; Fri, 17 Mar 2023 12:24:02 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mani@kernel.org,
        lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com,
        manivannan.sadhasivam@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH v4 5/5] ARM: dts: qcom: sdx65-mtp: Enable PCIe EP
Date:   Fri, 17 Mar 2023 12:23:59 +0530
Message-Id: <1679036039-27157-6-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1679036039-27157-1-git-send-email-quic_rohiagar@quicinc.com>
References: <1679036039-27157-1-git-send-email-quic_rohiagar@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: SUnl2wkb7dU-bD46nPMk2220eLTSH9Of
X-Proofpoint-ORIG-GUID: SUnl2wkb7dU-bD46nPMk2220eLTSH9Of
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-17_02,2023-03-16_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 adultscore=0 mlxlogscore=643 priorityscore=1501 spamscore=0 suspectscore=0
 impostorscore=0 mlxscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303170045
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Enable PCIe Endpoint controller on the SDX65 MTP board based
on Qualcomm SDX65 platform.

Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
---
 arch/arm/boot/dts/qcom-sdx65-mtp.dts | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-sdx65-mtp.dts b/arch/arm/boot/dts/qcom-sdx65-mtp.dts
index 70720e6..afe970a 100644
--- a/arch/arm/boot/dts/qcom-sdx65-mtp.dts
+++ b/arch/arm/boot/dts/qcom-sdx65-mtp.dts
@@ -245,6 +245,17 @@
 	status = "okay";
 };
 
+&pcie_ep {
+	pinctrl-0 = <&pcie_ep_clkreq_default &pcie_ep_perst_default
+			&pcie_ep_wake_default>;
+	pinctrl-names = "default";
+
+	reset-gpios = <&tlmm 57 GPIO_ACTIVE_LOW>;
+	wake-gpios = <&tlmm 53 GPIO_ACTIVE_LOW>;
+
+	status = "okay";
+};
+
 &pcie_phy {
 	vdda-phy-supply = <&vreg_l1b_1p2>;
 	vdda-pll-supply = <&vreg_l4b_0p88>;
@@ -277,6 +288,29 @@
 	status = "okay";
 };
 
+&tlmm {
+	pcie_ep_clkreq_default: pcie-ep-clkreq-default-state {
+		pins = "gpio56";
+		function = "pcie_clkreq";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	pcie_ep_perst_default: pcie-ep-perst-default-state {
+		pins = "gpio57";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-down;
+	};
+
+	pcie_ep_wake_default: pcie-ep-wake-default-state {
+		pins = "gpio53";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+};
+
 &usb {
 	status = "okay";
 };
-- 
2.7.4

