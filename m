Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37E526AB601
	for <lists+linux-pci@lfdr.de>; Mon,  6 Mar 2023 06:25:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjCFFZ2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Mar 2023 00:25:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjCFFZZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Mar 2023 00:25:25 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E00871A951;
        Sun,  5 Mar 2023 21:25:23 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32624YP0032741;
        Mon, 6 Mar 2023 05:25:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=bFq6zL0ySHaidn8J978nE3ke39z8YbaPQUvVcMdr5zg=;
 b=I8xZ6PL3/3XxfVIn7xpeHlcZV+Yc2wzCIG4UCdmKvZZcWAHOquCnXVBgVxmoeXDWiVHn
 ba3cOl0mzPwLD5IBgdFIDhuKUHKnxyaPYfQZACL8w7+6jLStTnJslCfASHQJeRhbvGTv
 gMnf9WA0rRvXPbfgkiiS7DAhhS6Ohm5oMgkeJB526/H61/c0CgUZTKGdv52daRa51DEM
 DZaaoSGjlQdCipErxeo2xeS8V2tFck83GGUBfIM4x6z4j4h+M8aEKfAaRhEW2EhjVHMf
 W5udlc2pAvhevd0z+9QZn7tK+3uJ6LeyiAEhJESqUyx0yDYLUjQtsTe94vrgnZCgOWS8 mg== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p41jaud0x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Mar 2023 05:25:18 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3265P7na016184;
        Mon, 6 Mar 2023 05:25:07 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3p4fgk73a4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 06 Mar 2023 05:25:07 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3265P6XR016096;
        Mon, 6 Mar 2023 05:25:06 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-rohiagar-hyd.qualcomm.com [10.213.106.138])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3265P6N6016093;
        Mon, 06 Mar 2023 05:25:06 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id 490A14F8A; Mon,  6 Mar 2023 10:55:06 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mani@kernel.org,
        lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com,
        manivannan.sadhasivam@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH 6/6] ARM: dts: qcom: sdx65-mtp: Enable PCIe EP
Date:   Mon,  6 Mar 2023 10:55:02 +0530
Message-Id: <1678080302-29691-7-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1678080302-29691-1-git-send-email-quic_rohiagar@quicinc.com>
References: <1678080302-29691-1-git-send-email-quic_rohiagar@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: _7fS3Ob5HlSLbkQcfhwzKN6ll36epcTW
X-Proofpoint-GUID: _7fS3Ob5HlSLbkQcfhwzKN6ll36epcTW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-05_12,2023-03-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 malwarescore=0 adultscore=0 spamscore=0 bulkscore=0 impostorscore=0
 mlxlogscore=576 suspectscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303060044
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Enable PCIe Endpoint controller on the SDX65 MTP board based
on Qualcomm SDX65 platform.

Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
---
 arch/arm/boot/dts/qcom-sdx65-mtp.dts | 46 ++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-sdx65-mtp.dts b/arch/arm/boot/dts/qcom-sdx65-mtp.dts
index 86bb853..952de105 100644
--- a/arch/arm/boot/dts/qcom-sdx65-mtp.dts
+++ b/arch/arm/boot/dts/qcom-sdx65-mtp.dts
@@ -252,6 +252,14 @@
 	vdda-pll-supply = <&vreg_l4b_0p88>;
 };
 
+&pcie_ep {
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie_ep_clkreq_default &pcie_ep_perst_default
+			&pcie_ep_wake_default>;
+};
+
 &qpic_bam {
 	status = "okay";
 };
@@ -276,6 +284,44 @@
 	memory-region = <&mpss_adsp_mem>;
 };
 
++&tlmm {
+	pcie_ep_clkreq_default: pcie_ep_clkreq_default {
+		mux {
+			pins = "gpio56";
+			function = "pcie_clkreq";
+		};
+		config {
+			pins = "gpio56";
+			drive-strength = <2>;
+			bias-disable;
+		};
+	};
+
+	pcie_ep_perst_default: pcie_ep_perst_default {
+		mux {
+			pins = "gpio57";
+			function = "gpio";
+		};
+		config {
+			pins = "gpio57";
+			drive-strength = <2>;
+			bias-pull-down;
+		};
+	};
+
+	pcie_ep_wake_default: pcie_ep_wake_default {
+		mux {
+			pins = "gpio53";
+			function = "gpio";
+		};
+		config {
+			pins = "gpio53";
+			drive-strength = <2>;
+			bias-disable;
+		};
+	};
+};
+
 &usb {
 	status = "okay";
 };
-- 
2.7.4

