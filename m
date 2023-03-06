Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F09086AB5F3
	for <lists+linux-pci@lfdr.de>; Mon,  6 Mar 2023 06:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjCFFZV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Mar 2023 00:25:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjCFFZS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Mar 2023 00:25:18 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30CDE1969D;
        Sun,  5 Mar 2023 21:25:17 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 325NXAtg013696;
        Mon, 6 Mar 2023 05:25:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=lmysldI5Smv7G4B6nh6VCy+mpIzTMyWyWs008dqhg98=;
 b=SYgnCcpy+tZ/y29Ir6nqI2zxMrnX+mjd7MBSl7Y0QzEEnIAiEPmIsNpYYK0tDS9vB+NC
 Y5xNLlPyfpFygfqbGJaLIhIR2p1E00q2GerMQKnfmvJCF1RCJQEVH0HCvrErhRptbo4O
 pU0QcOZI0tvCewd9GO0nx1o/XKBCP8/1nE/ncbYraeO7b5eExgP0pYZIXozddx67g4Nz
 VQoOuMkiOrLi6kaummaci8fo7LQ1tW7EzybT/ipLP+pZ+O5jkoaz4sycSP89pnLDAxNX
 m1+okOOSyuVh9ulJ79dkcqc/Fzrg26FI0EKv/NyreDwEJ8JEmjt3pYEGv1nFHmMhnE5a 9w== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p417ekfh6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Mar 2023 05:25:09 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3265P6UW016105;
        Mon, 6 Mar 2023 05:25:06 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3p4fgk739p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 06 Mar 2023 05:25:06 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3265P6ZA016088;
        Mon, 6 Mar 2023 05:25:06 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-rohiagar-hyd.qualcomm.com [10.213.106.138])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3265P5hi016079;
        Mon, 06 Mar 2023 05:25:06 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id 3F3144F8A; Mon,  6 Mar 2023 10:55:05 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mani@kernel.org,
        lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com,
        manivannan.sadhasivam@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH 3/6] ARM: dts: qcom: sdx65: Add support for PCIe PHY
Date:   Mon,  6 Mar 2023 10:54:59 +0530
Message-Id: <1678080302-29691-4-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1678080302-29691-1-git-send-email-quic_rohiagar@quicinc.com>
References: <1678080302-29691-1-git-send-email-quic_rohiagar@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 2PbY9edJb04vOzPaAyXWflP3YUfpnbtG
X-Proofpoint-GUID: 2PbY9edJb04vOzPaAyXWflP3YUfpnbtG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-05_12,2023-03-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 impostorscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2303060044
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add devicetree support for PCIe PHY used in SDX65 platform. This PHY is
used by the PCIe EP controller.

Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
---
 arch/arm/boot/dts/qcom-sdx65.dtsi | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-sdx65.dtsi b/arch/arm/boot/dts/qcom-sdx65.dtsi
index b073e0c..246290d 100644
--- a/arch/arm/boot/dts/qcom-sdx65.dtsi
+++ b/arch/arm/boot/dts/qcom-sdx65.dtsi
@@ -292,6 +292,38 @@
 			status = "disabled";
 		};
 
+		pcie0_phy: phy@1c07000 {
+			compatible = "qcom,sdx65-qmp-pcie-phy";
+			reg = <0x01c07000 0x1e4>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+			clocks = <&gcc GCC_PCIE_AUX_PHY_CLK_SRC>,
+				 <&gcc GCC_PCIE_CFG_AHB_CLK>,
+				 <&gcc GCC_PCIE_0_CLKREF_EN>,
+				 <&gcc GCC_PCIE_RCHNG_PHY_CLK>;
+			clock-names = "aux", "cfg_ahb", "ref", "refgen";
+
+			resets = <&gcc GCC_PCIE_PHY_BCR>;
+			reset-names = "phy";
+			assigned-clocks = <&gcc GCC_PCIE_RCHNG_PHY_CLK>;
+			assigned-clock-rates = <100000000>;
+			status = "disabled";
+
+			pcie0_lane: lanes@1c06000 {
+				reg = <0x01c06000 0xf0>, /* tx0 */
+				      <0x01c06200 0x2f0>, /* rx0 */
+				      <0x01c07200 0x1e8>, /* pcs */
+				      <0x01c06800 0xf0>, /* tx1 */
+				      <0x01c06a00 0x2f0>, /* rx1 */
+				      <0x01c07400 0xc00>; /* pcs_misc */
+				clocks = <&gcc GCC_PCIE_PIPE_CLK>;
+				clock-names = "pipe0";
+				#phy-cells = <0>;
+				clock-output-names = "pcie_pipe_clk";
+			};
+		};
+
 		tcsr_mutex: hwlock@1f40000 {
 			compatible = "qcom,tcsr-mutex";
 			reg = <0x01f40000 0x40000>;
-- 
2.7.4

