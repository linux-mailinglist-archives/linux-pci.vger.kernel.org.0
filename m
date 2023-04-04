Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5F96D696A
	for <lists+linux-pci@lfdr.de>; Tue,  4 Apr 2023 18:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235277AbjDDQur (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Apr 2023 12:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235667AbjDDQul (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Apr 2023 12:50:41 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26FAA55B2;
        Tue,  4 Apr 2023 09:50:19 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 334FbMJL032167;
        Tue, 4 Apr 2023 16:50:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=jaOoov2OJ3o9bucwGpoUQb07wCfD5E0bHuPQUCqYsGE=;
 b=RTW3QU4aNaKHtVW5MvhlEiPRjjr25LtlRRqUuMWz+FrwJG2HyIJOkL/wyH/OYGF2iQd4
 0REr3mSMJrMc0MLxLwsngWk/+YqXRNjTC2nqkfrBpj07ZYPETOM/3f86uxS+tGAC+Bew
 wzBT6C+cEIfCI/+MHoPcN6+1UoQ3clTMChC1NvBtY9JqSwSeMUDI90BQMHU2CJzFbYlI
 lmmZSOfZn+GqawVlUT+l49pY+E8ys0H7IE1lnunc6NAbqGMFahi9hJHorYZ8al0OVjdw
 Uh5uMZHYvD1eKhRLLcJRnNbAmwdnDRb0Ni3Cb0xKQugyjWZPaqfTTBbWvDD/5evrYDFN Ag== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3prppug674-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Apr 2023 16:50:04 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 334Go31I030792
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 4 Apr 2023 16:50:03 GMT
Received: from devipriy-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 4 Apr 2023 09:49:54 -0700
From:   Devi Priya <quic_devipriy@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <lpieralisi@kernel.org>,
        <kw@linux.com>, <robh@kernel.org>, <bhelgaas@google.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <mani@kernel.org>, <p.zabel@pengutronix.de>,
        <linus.walleij@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <linux-gpio@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_ipkumar@quicinc.com>
Subject: [PATCH V2 8/9] arm64: dts: qcom: ipq9574: Enable PCIe PHYs and controllers
Date:   Tue, 4 Apr 2023 22:18:27 +0530
Message-ID: <20230404164828.8031-9-quic_devipriy@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230404164828.8031-1-quic_devipriy@quicinc.com>
References: <20230404164828.8031-1-quic_devipriy@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: FtsSCBKJ1dMc7iUCjK76Q5XphGUzRWrg
X-Proofpoint-ORIG-GUID: FtsSCBKJ1dMc7iUCjK76Q5XphGUzRWrg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-04_08,2023-04-04_05,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 adultscore=0 mlxlogscore=818 phishscore=0 bulkscore=0 priorityscore=1501
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304040156
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Enable the PCIe controller and PHY nodes corresponding to
RDP 433

Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
---
 Changes in V2:
	- Moved the Board DT changes to a new patch as suggested
	- Added pinctrl definitions for PCIe perst GPIOs
	- Dropped the suffix denoting the lane config from pcie labels

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

