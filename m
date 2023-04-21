Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 526116EAAE7
	for <lists+linux-pci@lfdr.de>; Fri, 21 Apr 2023 14:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232401AbjDUMvO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Apr 2023 08:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232300AbjDUMu6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Apr 2023 08:50:58 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9DB4D313;
        Fri, 21 Apr 2023 05:50:40 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33L9ZRmW013877;
        Fri, 21 Apr 2023 12:50:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=Mv7+Q3rUwjBXw2l0GlF5KTcCcnUbQGf2VMcuQYLUuks=;
 b=VZR1fBEhq35vw0Fc7imALTtrGbSIejHsVQbuFLp3B08CpNIzuK60sgC+oLCJEzckNrzZ
 rU9WJ3eQEpx6FaML2He0cDEJzo2rnmc695xov7USBmpXgWx2R8K50bDpzxV+mij+Fa5D
 x2MgIVu2SnAsuTu2Zg4gkUJ76WKXdgiHHw4mWDx0FTPpW2ROrITZerlnIysj7P4d3JWe
 vwlgDzC0Rm8P6lg5AWVfT95PjZK1mi+s0z9pQkp1iRWGiaAT0SC5m704CoCZcwMEdDSM
 VZImL2RRWL3XPkpegnSGmMVbgyCD5k4IWCbN8sv5ZizHEYJD3qPbjWhd0vFD/BzHs4+L LQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q3e34sh24-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Apr 2023 12:50:35 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33LCoY6P008790
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Apr 2023 12:50:34 GMT
Received: from devipriy-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 21 Apr 2023 05:50:27 -0700
From:   Devi Priya <quic_devipriy@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <lpieralisi@kernel.org>,
        <kw@linux.com>, <robh@kernel.org>, <bhelgaas@google.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <mani@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-clk@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_arajkuma@quicinc.com>,
        <quic_anusha@quicinc.com>, <quic_ipkumar@quicinc.com>
Subject: [PATCH V3 5/6] arm64: dts: qcom: ipq9574: Enable PCIe PHYs and controllers
Date:   Fri, 21 Apr 2023 18:19:37 +0530
Message-ID: <20230421124938.21974-6-quic_devipriy@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230421124938.21974-1-quic_devipriy@quicinc.com>
References: <20230421124938.21974-1-quic_devipriy@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: OqVhLUaWnXQR9dv0wtILg9xHYL1LSZq5
X-Proofpoint-GUID: OqVhLUaWnXQR9dv0wtILg9xHYL1LSZq5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-21_06,2023-04-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 clxscore=1015 malwarescore=0 phishscore=0 mlxlogscore=877 spamscore=0
 impostorscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304210111
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Enable the PCIe controller and PHY nodes corresponding to
RDP 433.

Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
---
 Changes in V3:
	- No change

 arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts | 62 +++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts b/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
index 7be578017bf7..3ae38cf327ea 100644
--- a/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
+++ b/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
@@ -8,6 +8,7 @@
 
 /dts-v1/;
 
+#include <dt-bindings/gpio/gpio.h>
 #include "ipq9574.dtsi"
 
 / {
@@ -43,6 +44,42 @@
 	};
 };
 
+&pcie1_phy {
+	status = "okay";
+};
+
+&pcie1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie_1_pin>;
+
+	perst-gpios = <&tlmm 26 GPIO_ACTIVE_LOW>;
+	status = "okay";
+};
+
+&pcie2_phy {
+	status = "okay";
+};
+
+&pcie2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie_2_pin>;
+
+	perst-gpios = <&tlmm 29 GPIO_ACTIVE_LOW>;
+	status = "okay";
+};
+
+&pcie3_phy {
+	status = "okay";
+};
+
+&pcie3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie_3_pin>;
+
+	perst-gpios = <&tlmm 32 GPIO_ACTIVE_LOW>;
+	status = "okay";
+};
+
 &sdhc_1 {
 	pinctrl-0 = <&sdc_default_state>;
 	pinctrl-names = "default";
@@ -60,6 +97,31 @@
 };
 
 &tlmm {
+
+	pcie_1_pin: pcie-1-state {
+		pins = "gpio26";
+		function = "gpio";
+		drive-strength = <8>;
+		bias-pull-down;
+		output-low;
+	};
+
+	pcie_2_pin: pcie-2-state {
+		pins = "gpio29";
+		function = "gpio";
+		drive-strength = <8>;
+		bias-pull-down;
+		output-low;
+	};
+
+	pcie_3_pin: pcie-3-state {
+		pins = "gpio32";
+		function = "gpio";
+		drive-strength = <8>;
+		bias-pull-up;
+		output-low;
+	};
+
 	sdc_default_state: sdc-default-state {
 		clk-pins {
 			pins = "gpio5";
-- 
2.17.1

