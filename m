Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 412447B68B4
	for <lists+linux-pci@lfdr.de>; Tue,  3 Oct 2023 14:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232491AbjJCMKU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Oct 2023 08:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232324AbjJCMKT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Oct 2023 08:10:19 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21457DD;
        Tue,  3 Oct 2023 05:10:11 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 393BMavx030260;
        Tue, 3 Oct 2023 12:09:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=qInbbyy+IM8JPT5ZOTFZZKq+bJNItdIFiJ1d8D+MZ2E=;
 b=ZetMMeJML4OJcaXnVaWTo6xyrPGabRySvzEgIGtZeKmnC7H56Vp4hdzMA5PuO9x+Ekv/
 753paeHMVm30PbkLhSiKKXZjFcvUzUO+BYwdD3u2jK1Zxj3kdwtQztatwm5pxYeBJONd
 8bsRIR56Bah7Z3pESOQQ/UBaVPLuXxiTAy0M241Rb1shfGb5/DUL4dmP2LYWxAtgIbTg
 9Q1/V+h5sFFUNwo1U9mqjd0co2FG4ghyHQ0UWwcECbF6ICu8cCPcL45uiWoq8vqojUyc
 LpdKCyCq7QRX2DmEyiNeKt+vfVXK5yCpR1pWRiqUzD8O146MMk3rXnQem5Nk1jWtuB+6 3g== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tg9hds3fj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Oct 2023 12:09:58 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 393C9vid011389
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 3 Oct 2023 12:09:57 GMT
Received: from nsekar-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Tue, 3 Oct 2023 05:09:50 -0700
From:   Nitheesh Sekar <quic_nsekar@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <lpieralisi@kernel.org>,
        <kw@linux.com>, <robh@kernel.org>, <bhelgaas@google.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <vkoul@kernel.org>, <kishon@kernel.org>, <mani@kernel.org>,
        <p.zabel@pengutronix.de>, <quic_nsekar@quicinc.com>,
        <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>,
        <quic_ipkumar@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>
Subject: [PATCH 6/6] arm64: dts: qcom: ipq5018: Enable PCIe
Date:   Tue, 3 Oct 2023 17:38:46 +0530
Message-ID: <20231003120846.28626-7-quic_nsekar@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231003120846.28626-1-quic_nsekar@quicinc.com>
References: <20231003120846.28626-1-quic_nsekar@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 35N3MwkT51rMOeebxzeuzucnm1PWmg2s
X-Proofpoint-GUID: 35N3MwkT51rMOeebxzeuzucnm1PWmg2s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-03_08,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 mlxscore=0 suspectscore=0
 impostorscore=0 mlxlogscore=704 malwarescore=0 spamscore=0
 priorityscore=1501 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2309180000 definitions=main-2310030087
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Enable the PCIe controller and PHY nodes for RDP 432-c2.

Signed-off-by: Nitheesh Sekar <quic_nsekar@quicinc.com>
---
 arch/arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts b/arch/arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts
index e636a1cb9b77..be7d92700517 100644
--- a/arch/arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts
+++ b/arch/arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts
@@ -28,6 +28,15 @@
 	status = "okay";
 };
 
+&pcie_x2 {
+	status = "ok";
+	perst-gpios = <&tlmm 15 GPIO_ACTIVE_LOW>;
+};
+
+&pcie_x2phy {
+	status = "ok";
+};
+
 &sdhc_1 {
 	pinctrl-0 = <&sdc_default_state>;
 	pinctrl-names = "default";
-- 
2.17.1

