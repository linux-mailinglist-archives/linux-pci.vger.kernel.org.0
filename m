Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF756AB5FF
	for <lists+linux-pci@lfdr.de>; Mon,  6 Mar 2023 06:25:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjCFFZX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Mar 2023 00:25:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjCFFZU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Mar 2023 00:25:20 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02DE319699;
        Sun,  5 Mar 2023 21:25:19 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3260fEUv002862;
        Mon, 6 Mar 2023 05:25:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=GuWbCQIzm85+Bc59yG1o9ccOhTr41bmLM1BvGRg7llY=;
 b=LQ+nns9jfAVcXSduZHQvOBVNXAvGRzKezZX5q7PEey9FIPfrooV6d1Cr6r17lSx4EWXv
 824Xvbhx4tWrwh2EvIBysCcwj5cIw1HJWPvK5nDv8f3SyVkFFSZl2yHUGDxMhQiY3CZR
 GJmhdKeF/Le1dSjb7HUqVzkEX2g8P+TpQUufMw/X7fQuS+A93fDudzrkEgKNukmQ0y15
 L0lldKG5R3CZ1x9FbiidLzWhiMrysu6KbqxiZeKaXEXHc7FIq+SqWGke02F38V2x2XKx
 Blq0pRvuvx3GfPxTW+C9HqIZKnIwMBGw0FESAAkQmG+BSTDYQlHzXHDBlAYvOyTkGw3E tw== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p41873hnc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Mar 2023 05:25:10 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3265P64C016140;
        Mon, 6 Mar 2023 05:25:06 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3p4fgk739x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 06 Mar 2023 05:25:06 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3265P6XP016096;
        Mon, 6 Mar 2023 05:25:06 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-rohiagar-hyd.qualcomm.com [10.213.106.138])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3265P6N4016093;
        Mon, 06 Mar 2023 05:25:06 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id 90D2A4F94; Mon,  6 Mar 2023 10:55:05 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mani@kernel.org,
        lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com,
        manivannan.sadhasivam@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH 4/6] ARM: dts: qcom: sdx65: Add support for PCIe EP
Date:   Mon,  6 Mar 2023 10:55:00 +0530
Message-Id: <1678080302-29691-5-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1678080302-29691-1-git-send-email-quic_rohiagar@quicinc.com>
References: <1678080302-29691-1-git-send-email-quic_rohiagar@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Yohqqix1Fr_PhHGtfBM1nS4rTDWrb5-3
X-Proofpoint-ORIG-GUID: Yohqqix1Fr_PhHGtfBM1nS4rTDWrb5-3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-05_12,2023-03-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 priorityscore=1501 mlxscore=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 mlxlogscore=961 bulkscore=0 suspectscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303060044
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support for PCIe Endpoint controller on the Qualcomm SDX65 platform.

Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
---
 arch/arm/boot/dts/qcom-sdx65.dtsi | 44 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-sdx65.dtsi b/arch/arm/boot/dts/qcom-sdx65.dtsi
index 246290d..93ea94e 100644
--- a/arch/arm/boot/dts/qcom-sdx65.dtsi
+++ b/arch/arm/boot/dts/qcom-sdx65.dtsi
@@ -11,6 +11,7 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
+#include <dt-bindings/gpio/gpio.h>
 
 / {
 	#address-cells = <1>;
@@ -292,6 +293,44 @@
 			status = "disabled";
 		};
 
+		pcie_ep: pcie-ep@1c00000 {
+			compatible = "qcom,sdx65-pcie-ep", "qcom,sdx55-pcie-ep";
+			reg = <0x01c00000 0x3000>,
+				  <0x40000000 0xf1d>,
+				  <0x40000f20 0xa8>,
+				  <0x40001000 0x1000>,
+				  <0x40200000 0x100000>,
+				  <0x01c03000 0x3000>;
+			reg-names = "parf", "dbi", "elbi", "atu", "addr_space",
+						"mmio";
+
+			qcom,perst-regs = <&tcsr 0xb258 0xb270>;
+
+			clocks = <&gcc GCC_PCIE_AUX_CLK>,
+					 <&gcc GCC_PCIE_CFG_AHB_CLK>,
+					 <&gcc GCC_PCIE_MSTR_AXI_CLK>,
+					 <&gcc GCC_PCIE_SLV_AXI_CLK>,
+					 <&gcc GCC_PCIE_SLV_Q2A_AXI_CLK>,
+					 <&gcc GCC_PCIE_SLEEP_CLK>,
+					 <&gcc GCC_PCIE_0_CLKREF_EN>;
+			clock-names = "aux", "cfg", "bus_master", "bus_slave",
+							"slave_q2a", "sleep", "ref";
+
+			interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>,
+						 <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "global", "doorbell";
+			reset-gpios = <&tlmm 57 GPIO_ACTIVE_LOW>;
+			wake-gpios = <&tlmm 53 GPIO_ACTIVE_LOW>;
+			resets = <&gcc GCC_PCIE_BCR>;
+			reset-names = "core";
+			power-domains = <&gcc PCIE_GDSC>;
+			phys = <&pcie0_lane>;
+			phy-names = "pciephy";
+			max-link-speed = <3>;
+			num-lanes = <2>;
+			status = "disabled";
+		};
+
 		pcie0_phy: phy@1c07000 {
 			compatible = "qcom,sdx65-qmp-pcie-phy";
 			reg = <0x01c07000 0x1e4>;
@@ -330,6 +369,11 @@
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

