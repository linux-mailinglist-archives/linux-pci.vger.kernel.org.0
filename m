Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAE9F6B06DC
	for <lists+linux-pci@lfdr.de>; Wed,  8 Mar 2023 13:20:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbjCHMUZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Mar 2023 07:20:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbjCHMUW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Mar 2023 07:20:22 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 292109E501;
        Wed,  8 Mar 2023 04:20:16 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32804VHh025438;
        Wed, 8 Mar 2023 12:20:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=PwIMQ5dS15R9CdvHptxSKFEBTDUUY+aMIeHdEhCspR8=;
 b=N7uVceKY89lqG3eka5i0QMHgF2TWI8lm+wQn6pY93T8OnZMWYDWMRT6l2Z0P9ueNuACX
 EBQ3WGK70IrKPWL2Szm2/WC/LPhjQLaAPt2tUUDcjRqaXLppxdWNzyAaWA+/f5R9+fu0
 n8h1hNA8Mr6Lvr7I3HTg0Dg/0rwLEvNlJXFt8jYgxbHsbdjRCc6rKNn/kSJRN68jfst6
 wWsEJlFShV/qkiNZRUVbdCfqo5s4a64ktdppO8CFx7uamcWnl+C65qrPCoCMcrlfedRH
 LTiqg8GXh0VaVocM59meQBT0ayM9nIm+cpogdJkNvObcFTpW1NtTad3jDl6Iwj3CgimE 4w== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p6fgfsk0s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Mar 2023 12:20:09 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 328CK5uh031412;
        Wed, 8 Mar 2023 12:20:06 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3p4fgkn0cg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 08 Mar 2023 12:20:06 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 328CK5xQ031430;
        Wed, 8 Mar 2023 12:20:06 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-rohiagar-hyd.qualcomm.com [10.213.106.138])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 328CK5cB031422;
        Wed, 08 Mar 2023 12:20:06 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id A3D3D4F94; Wed,  8 Mar 2023 17:50:05 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mani@kernel.org,
        lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com,
        manivannan.sadhasivam@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH v2 6/6] ARM: dts: qcom: sdx65-mtp: Enable PCIe EP
Date:   Wed,  8 Mar 2023 17:49:53 +0530
Message-Id: <1678277993-18836-7-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1678277993-18836-1-git-send-email-quic_rohiagar@quicinc.com>
References: <1678277993-18836-1-git-send-email-quic_rohiagar@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: rAvZphh5NDZNKmnYRWBT1I_e2FNGi8qL
X-Proofpoint-ORIG-GUID: rAvZphh5NDZNKmnYRWBT1I_e2FNGi8qL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-08_07,2023-03-08_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 impostorscore=0 mlxscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=551
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303080106
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Enable PCIe Endpoint controller on the SDX65 MTP board based
on Qualcomm SDX65 platform.

Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
---
 arch/arm/boot/dts/qcom-sdx65-mtp.dts | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-sdx65-mtp.dts b/arch/arm/boot/dts/qcom-sdx65-mtp.dts
index facb8e2..97459bb 100644
--- a/arch/arm/boot/dts/qcom-sdx65-mtp.dts
+++ b/arch/arm/boot/dts/qcom-sdx65-mtp.dts
@@ -245,6 +245,14 @@
 	status = "okay";
 };
 
+&pcie_ep {
+	pinctrl-0 = <&pcie_ep_clkreq_default &pcie_ep_perst_default
+			&pcie_ep_wake_default>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+
 &pcie_phy {
 	vdda-phy-supply = <&vreg_l1b_1p2>;
 	vdda-pll-supply = <&vreg_l4b_0p88>;
@@ -277,6 +285,28 @@
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
+
 &usb {
 	status = "okay";
 };
-- 
2.7.4

