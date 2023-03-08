Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBBF66B096F
	for <lists+linux-pci@lfdr.de>; Wed,  8 Mar 2023 14:38:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjCHNiT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Mar 2023 08:38:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231342AbjCHNh5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Mar 2023 08:37:57 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F4FC1C30;
        Wed,  8 Mar 2023 05:36:14 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 328CrFi6032664;
        Wed, 8 Mar 2023 13:35:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=6cwO3O+eq4pLy1weshDptqqYgNJjJdfRLoJ8gn059r0=;
 b=PV67SA26UYjxzJdDIDsMSAV+pKPEFLvae/I+snfdmAg+9NtX6B4D95HWJ3JBezaGHme5
 9z9zRXQ71GIXzNHQCTIWVqCkpHmF51U6CyrJ+qCvfFOdXqmuBanuR1uUE1QiBI6TkKn/
 4HRiTNmMQFzPvEBNdLbOZtsrPjk0ixwakzy/aKu78wHywbrtT0RKOa6dlisRVZHm8kMK
 ZAXbCyRseVtzmBTQ8uRrVzC/X1wU2heNtcE5Lo/bYNt3VUUGyS7nytv2WOiP2muoMk53
 W9gLTgd1vCfP+u1eSkYX7BowzrfXIv7or3ykUwgQDDFhK4dYozU4lwsdUYtlKwfcVGK/ kA== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p6ffksrtc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Mar 2023 13:35:47 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 328DZi9k020635;
        Wed, 8 Mar 2023 13:35:44 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3p4fftbxy0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 08 Mar 2023 13:35:44 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 328DZhV2020595;
        Wed, 8 Mar 2023 13:35:43 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-rohiagar-hyd.qualcomm.com [10.213.106.138])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 328DZgD4020588;
        Wed, 08 Mar 2023 13:35:43 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id 0CB484FBA; Wed,  8 Mar 2023 19:05:43 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mani@kernel.org,
        lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com,
        manivannan.sadhasivam@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH v3 5/5] ARM: dts: qcom: sdx65-mtp: Enable PCIe EP
Date:   Wed,  8 Mar 2023 19:05:32 +0530
Message-Id: <1678282532-16635-6-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1678282532-16635-1-git-send-email-quic_rohiagar@quicinc.com>
References: <1678282532-16635-1-git-send-email-quic_rohiagar@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: HT0OrL9sej4vJXp5S-8GNnuuLV1tban4
X-Proofpoint-ORIG-GUID: HT0OrL9sej4vJXp5S-8GNnuuLV1tban4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-08_08,2023-03-08_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 mlxlogscore=552
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303080115
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
 arch/arm/boot/dts/qcom-sdx65-mtp.dts | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-sdx65-mtp.dts b/arch/arm/boot/dts/qcom-sdx65-mtp.dts
index 70720e6..13c71f5 100644
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
@@ -277,6 +285,29 @@
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

