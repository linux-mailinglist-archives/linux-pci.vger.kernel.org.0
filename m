Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A20DF70873E
	for <lists+linux-pci@lfdr.de>; Thu, 18 May 2023 19:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjERRsq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 May 2023 13:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbjERRsQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 May 2023 13:48:16 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F319410E3;
        Thu, 18 May 2023 10:48:11 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34ICmhnE005791;
        Thu, 18 May 2023 17:48:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=il9SipwudKgwDZd7JgviDEKGSp3xyuj8/UA0OhZtHVY=;
 b=M4HUErbxaMdYJKtmCRgkjoLrJ/i+DpUUx6wM0GAQdwVVQKYBC18akQCIb3S2vobwmNtp
 m/emtLbICgB0zJyrndjXKmv0npLodBggMRqhjrKH/jaMjvRe42f48oOEd8JoOrk1dYvj
 zIi/pKk/5fJKKmBIhsHuHppLe7T905OLGKnWpi/9EXuoHw4KIMwSh2yGy8eHQnXmIITP
 yIXIh3k4hQc+qbuj6LU1ij48FmckklFg2P5dXc9yuRXZxa1fvUzXFvMftGxXxDzPgQeQ
 fdJy6rAv+asojUx8XwKNoCSsWfdYI6uniRoaoLaxdfBlLWzwxV9sf/qAsP0zkV7MY6Va 4g== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qnb7h9wha-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 May 2023 17:48:06 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 34IHm2fK012305;
        Thu, 18 May 2023 17:48:02 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3qj3mkakxk-1;
        Thu, 18 May 2023 17:48:02 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34IHm2Do012206;
        Thu, 18 May 2023 17:48:02 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-rohiagar-hyd.qualcomm.com [10.213.106.138])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 34IHm2ba012096;
        Thu, 18 May 2023 17:48:02 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id 6DBD95EC1; Thu, 18 May 2023 23:18:01 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mani@kernel.org, bhelgaas@google.com, lpieralisi@kernel.org,
        kw@linux.com, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, manivannan.sadhasivam@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH v6 2/5] ARM: dts: qcom: sdx65: Add support for PCIe PHY
Date:   Thu, 18 May 2023 23:17:50 +0530
Message-Id: <1684432073-28490-3-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1684432073-28490-1-git-send-email-quic_rohiagar@quicinc.com>
References: <1684432073-28490-1-git-send-email-quic_rohiagar@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 8er7kFDeIjtcfGLz1S7bV0dsr_9PEaI9
X-Proofpoint-GUID: 8er7kFDeIjtcfGLz1S7bV0dsr_9PEaI9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_13,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 mlxscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=999
 adultscore=0 suspectscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305180144
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
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
index 525dd8a1..2fe61c2 100644
--- a/arch/arm/boot/dts/qcom-sdx65.dtsi
+++ b/arch/arm/boot/dts/qcom-sdx65.dtsi
@@ -295,6 +295,37 @@
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

