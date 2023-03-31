Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA426D1737
	for <lists+linux-pci@lfdr.de>; Fri, 31 Mar 2023 08:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjCaGSp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 31 Mar 2023 02:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbjCaGSn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 31 Mar 2023 02:18:43 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12AC62720;
        Thu, 30 Mar 2023 23:18:42 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32V4OMiE015993;
        Fri, 31 Mar 2023 06:18:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=CggUURSqAuwsDQM9UjQasHT/j+Iq+2rrs9c1HJaYbCc=;
 b=mtaUNkHwQlyxO8nYNqXtDRVuB7OAO37cs75DL6sdvMQP06t7I+mIkX60TFxQ9Q0foCUU
 +nqTI+WWhtNLEhuOwWT3J7jIDitdy//L3oo0+puFL6bRJc9LK+q/hywojywsS3zLeKQf
 svTMycg+zLu2kN1C8GcQbLyzZIegUiqQKIvzWUPa62U+/e8Bsm7b1HoFiFlgVS+fOKm5
 vfwzNlYhwG69NDaoChsCUy+owFbKR25q+Jjld2AAO15vdhqMuIqvuVouZ1xD3anYX5Z+
 DrGAJ7KuLW4WRfgpMBagIuU6l4GDRMlnzsQaJldf1Maz1gGgdtizawTkTzjBY3xOELWP mQ== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pncx0stjj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 31 Mar 2023 06:18:35 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 32V6IWdK013907;
        Fri, 31 Mar 2023 06:18:32 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3pht1knm28-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 31 Mar 2023 06:18:32 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32V6IV8t013872;
        Fri, 31 Mar 2023 06:18:32 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-rohiagar-hyd.qualcomm.com [10.213.106.138])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 32V6IVC3013882;
        Fri, 31 Mar 2023 06:18:32 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id 1DA404F33; Fri, 31 Mar 2023 11:48:31 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mani@kernel.org, bhelgaas@google.com, lpieralisi@kernel.org,
        kw@linux.com, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        manivannan.sadhasivam@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH v5 2/5] ARM: dts: qcom: sdx65: Add support for PCIe PHY
Date:   Fri, 31 Mar 2023 11:48:19 +0530
Message-Id: <1680243502-23744-3-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1680243502-23744-1-git-send-email-quic_rohiagar@quicinc.com>
References: <1680243502-23744-1-git-send-email-quic_rohiagar@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: KMeU-KtJCqGGF-9LM2blQoUkXinbaht8
X-Proofpoint-GUID: KMeU-KtJCqGGF-9LM2blQoUkXinbaht8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-31_02,2023-03-30_04,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 adultscore=0 clxscore=1015
 suspectscore=0 phishscore=0 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2303310050
X-Spam-Status: No, score=0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add devicetree support for PCIe PHY used in SDX65 platform. This PHY is
used by the PCIe EP controller.

Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm/boot/dts/qcom-sdx65.dtsi | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-sdx65.dtsi b/arch/arm/boot/dts/qcom-sdx65.dtsi
index 192f9f9..084daf8 100644
--- a/arch/arm/boot/dts/qcom-sdx65.dtsi
+++ b/arch/arm/boot/dts/qcom-sdx65.dtsi
@@ -293,6 +293,37 @@
 			status = "disabled";
 		};
 
+		pcie_phy: phy@1c06000 {
+			compatible = "qcom,sdx65-qmp-gen4x2-pcie-phy";
+			reg = <0x01c06000 0x2000>;
+
+			clocks = <&gcc GCC_PCIE_AUX_PHY_CLK_SRC>,
+				 <&gcc GCC_PCIE_CFG_AHB_CLK>,
+				 <&gcc GCC_PCIE_0_CLKREF_EN>,
+				 <&gcc GCC_PCIE_RCHNG_PHY_CLK>,
+				 <&gcc GCC_PCIE_PIPE_CLK>;
+			clock-names = "aux",
+				      "cfg_ahb",
+				      "ref",
+				      "rchng",
+				      "pipe";
+
+			resets = <&gcc GCC_PCIE_PHY_BCR>;
+			reset-names = "phy";
+
+			assigned-clocks = <&gcc GCC_PCIE_RCHNG_PHY_CLK>;
+			assigned-clock-rates = <100000000>;
+
+			power-domains = <&gcc PCIE_GDSC>;
+
+			#clock-cells = <0>;
+			clock-output-names = "pcie_pipe_clk";
+
+			#phy-cells = <0>;
+
+			status = "disabled";
+		};
+
 		tcsr_mutex: hwlock@1f40000 {
 			compatible = "qcom,tcsr-mutex";
 			reg = <0x01f40000 0x40000>;
-- 
2.7.4

