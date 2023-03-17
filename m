Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FEE66BE196
	for <lists+linux-pci@lfdr.de>; Fri, 17 Mar 2023 07:54:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbjCQGyQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Mar 2023 02:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjCQGyP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Mar 2023 02:54:15 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7414A12F3E;
        Thu, 16 Mar 2023 23:54:14 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32H6JnEc030674;
        Fri, 17 Mar 2023 06:54:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=Zo8HWx/v61xwLS9kssmqHorazwKPNDeTeO4Da4+/G20=;
 b=eZ8Hwy8XvUtRXyeQJxlq7DOv5f81cH8E6KJjMg5Ci0vuLiOcbRxTpbCtaYLr0Acordi2
 yrikgq7eNnrsBDqBYSwnOjZhX1ZuPvGUI234DPeIxrMK5+JkoQB9S1G07D2EnS+3RiM8
 6en9tfEkylbidrQ6BMEk7LBr331s+H1nQTr/LYq18ShyGB28ueH+ry0S9eNkdCehX+oA
 VftYlwcxpX7qz+ezGbYopPeeA/fTEIX8ynnBMLxMdQp7el3ifIiqe8Yu3oq/mj+elvUh
 jnM2ubBLU9Jqk1LuXaun3ZxWCmVnnt+wI+GUsinMA9MgDzMlt6KVDG2ZBIVwsbxeyeZu wA== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pc5r1a1kv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Mar 2023 06:54:07 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 32H6s3aR016066;
        Fri, 17 Mar 2023 06:54:03 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3p8jqmd9dc-1;
        Fri, 17 Mar 2023 06:54:03 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32H6s3Hi016039;
        Fri, 17 Mar 2023 06:54:03 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-rohiagar-hyd.qualcomm.com [10.213.106.138])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 32H6s2oi016025;
        Fri, 17 Mar 2023 06:54:03 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id DF86E4F3A; Fri, 17 Mar 2023 12:24:01 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mani@kernel.org,
        lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com,
        manivannan.sadhasivam@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH v4 4/5] ARM: dts: qcom: sdx65-mtp: Enable PCIe PHY
Date:   Fri, 17 Mar 2023 12:23:58 +0530
Message-Id: <1679036039-27157-5-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1679036039-27157-1-git-send-email-quic_rohiagar@quicinc.com>
References: <1679036039-27157-1-git-send-email-quic_rohiagar@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: _ljpIgthh24Y1-dzdgEcM3H68GQFIyWY
X-Proofpoint-ORIG-GUID: _ljpIgthh24Y1-dzdgEcM3H68GQFIyWY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-17_03,2023-03-16_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0 suspectscore=0
 mlxscore=0 clxscore=1015 mlxlogscore=498 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303170045
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Enable PCIe PHY on SDX65 MTP for PCIe EP. While at it,
updating status as last property for each node.

Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
---
 arch/arm/boot/dts/qcom-sdx65-mtp.dts | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-sdx65-mtp.dts b/arch/arm/boot/dts/qcom-sdx65-mtp.dts
index ed98c83..70720e6 100644
--- a/arch/arm/boot/dts/qcom-sdx65-mtp.dts
+++ b/arch/arm/boot/dts/qcom-sdx65-mtp.dts
@@ -245,6 +245,13 @@
 	status = "okay";
 };
 
+&pcie_phy {
+	vdda-phy-supply = <&vreg_l1b_1p2>;
+	vdda-pll-supply = <&vreg_l4b_0p88>;
+
+	status = "okay";
+};
+
 &qpic_bam {
 	status = "okay";
 };
@@ -265,8 +272,9 @@
 };
 
 &remoteproc_mpss {
-	status = "okay";
 	memory-region = <&mpss_adsp_mem>;
+
+	status = "okay";
 };
 
 &usb {
@@ -278,14 +286,16 @@
 };
 
 &usb_hsphy {
-	status = "okay";
 	vdda-pll-supply = <&vreg_l4b_0p88>;
 	vdda33-supply = <&vreg_l10b_3p08>;
 	vdda18-supply = <&vreg_l5b_1p8>;
+
+	status = "okay";
 };
 
 &usb_qmpphy {
-	status = "okay";
 	vdda-phy-supply = <&vreg_l4b_0p88>;
 	vdda-pll-supply = <&vreg_l1b_1p2>;
+
+	status = "okay";
 };
-- 
2.7.4

