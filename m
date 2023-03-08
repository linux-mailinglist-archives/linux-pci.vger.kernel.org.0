Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 459646B0972
	for <lists+linux-pci@lfdr.de>; Wed,  8 Mar 2023 14:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbjCHNiV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Mar 2023 08:38:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbjCHNh6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Mar 2023 08:37:58 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C404C1C32;
        Wed,  8 Mar 2023 05:36:15 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 328CrCZ2032634;
        Wed, 8 Mar 2023 13:35:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=uA6patfQInAS6eLCjrfij202KXCL/uL5PQVR2kSnDnM=;
 b=lsaXeWWwOtOt8wHez67uiC0o0vU/56uqEgLjrxfuf0K1iTljITS1J5iL1UX/4HlZWApn
 2F8k1KlWE+H2g+DVGTjBF1s9yZFF8kBhQ9aVvi2fiWNoQEkgY1iuVoQjR3XVHGAm65PZ
 I1l5/DpLsCoAgT60YoFwOywcRFWwhhm0RwYcqS64SKJg7paqdHgc1Nj7e1C6yulJD492
 +5SCbp4Kmzuy0lp0/+ylYOr0sPDUmZw3XyJlhNWYAUPYFUXqrnk4Zm0An2YybIESFVXm
 1zlDNSqhlkhee6Odo2pknZY1va538cKt3arVXlLzCZlhxJQY3VP06s2CKox/qPWeTY/0 rg== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p6ffksrtb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Mar 2023 13:35:46 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 328DZh3v020615;
        Wed, 8 Mar 2023 13:35:43 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3p4fftbxxp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 08 Mar 2023 13:35:43 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 328DZhV0020595;
        Wed, 8 Mar 2023 13:35:43 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-rohiagar-hyd.qualcomm.com [10.213.106.138])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 328DZgD2020588;
        Wed, 08 Mar 2023 13:35:43 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id 5EF014FB4; Wed,  8 Mar 2023 19:05:42 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mani@kernel.org,
        lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com,
        manivannan.sadhasivam@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH v3 3/5] ARM: dts: qcom: sdx65: Add support for PCIe EP
Date:   Wed,  8 Mar 2023 19:05:30 +0530
Message-Id: <1678282532-16635-4-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1678282532-16635-1-git-send-email-quic_rohiagar@quicinc.com>
References: <1678282532-16635-1-git-send-email-quic_rohiagar@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: -dbD-lYIQ_RPq8vmXQAaxP2An5IGzafo
X-Proofpoint-ORIG-GUID: -dbD-lYIQ_RPq8vmXQAaxP2An5IGzafo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-08_08,2023-03-08_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 mlxlogscore=977
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

Add support for PCIe Endpoint controller on the
Qualcomm SDX65 platform.

Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
---
 arch/arm/boot/dts/qcom-sdx65.dtsi | 59 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-sdx65.dtsi b/arch/arm/boot/dts/qcom-sdx65.dtsi
index 084daf8..47d7379 100644
--- a/arch/arm/boot/dts/qcom-sdx65.dtsi
+++ b/arch/arm/boot/dts/qcom-sdx65.dtsi
@@ -11,6 +11,7 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
+#include <dt-bindings/gpio/gpio.h>
 
 / {
 	#address-cells = <1>;
@@ -293,6 +294,59 @@
 			status = "disabled";
 		};
 
+		pcie_ep: pcie-ep@1c00000 {
+			compatible = "qcom,sdx65-pcie-ep", "qcom,sdx55-pcie-ep";
+			reg = <0x01c00000 0x3000>,
+			      <0x40000000 0xf1d>,
+			      <0x40000f20 0xa8>,
+			      <0x40001000 0x1000>,
+			      <0x40200000 0x100000>,
+			      <0x01c03000 0x3000>;
+			reg-names = "parf",
+				    "dbi",
+				    "elbi",
+				    "atu",
+				    "addr_space",
+				    "mmio";
+
+			qcom,perst-regs = <&tcsr 0xb258 0xb270>;
+
+			clocks = <&gcc GCC_PCIE_AUX_CLK>,
+				 <&gcc GCC_PCIE_CFG_AHB_CLK>,
+				 <&gcc GCC_PCIE_MSTR_AXI_CLK>,
+				 <&gcc GCC_PCIE_SLV_AXI_CLK>,
+				 <&gcc GCC_PCIE_SLV_Q2A_AXI_CLK>,
+				 <&gcc GCC_PCIE_SLEEP_CLK>,
+				 <&gcc GCC_PCIE_0_CLKREF_EN>;
+			clock-names = "aux",
+				      "cfg",
+				      "bus_master",
+				      "bus_slave",
+				      "slave_q2a",
+				      "sleep",
+				      "ref";
+
+			interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "global", "doorbell";
+
+			reset-gpios = <&tlmm 57 GPIO_ACTIVE_LOW>;
+			wake-gpios = <&tlmm 53 GPIO_ACTIVE_LOW>;
+
+			resets = <&gcc GCC_PCIE_BCR>;
+			reset-names = "core";
+
+			power-domains = <&gcc PCIE_GDSC>;
+
+			phys = <&pcie_phy>;
+			phy-names = "pcie-phy";
+
+			max-link-speed = <3>;
+			num-lanes = <2>;
+
+			status = "disabled";
+		};
+
 		pcie_phy: phy@1c06000 {
 			compatible = "qcom,sdx65-qmp-gen4x2-pcie-phy";
 			reg = <0x01c06000 0x2000>;
@@ -330,6 +384,11 @@
 			#hwlock-cells = <1>;
 		};
 
+		tcsr: syscon@1fcb000 {
+			compatible = "qcom,sdx65-tcsr", "syscon";
+			reg = <0x01fc0000 0x1000>;
+		};
+
 		remoteproc_mpss: remoteproc@4080000 {
 			compatible = "qcom,sdx55-mpss-pas";
 			reg = <0x04080000 0x4040>;
-- 
2.7.4

