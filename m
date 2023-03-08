Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E607B6B097B
	for <lists+linux-pci@lfdr.de>; Wed,  8 Mar 2023 14:38:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbjCHNi4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Mar 2023 08:38:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231195AbjCHNiO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Mar 2023 08:38:14 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEFEDBE5D8;
        Wed,  8 Mar 2023 05:36:29 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 328CkP3m024276;
        Wed, 8 Mar 2023 13:36:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=Zo8HWx/v61xwLS9kssmqHorazwKPNDeTeO4Da4+/G20=;
 b=ipH28Nt9q50WkBODPf4oRS2D3IbNNBP7UsebJA7/oHfSOKf7gXQY2+ugrrv0dgH7k8eb
 nn7JoIiLdfTQ3X1n036iUz/ja1ABLrmy7G7IwKgaUJKMb5kg2jHIIjPqBornCTfvAJmK
 qfCjlXCy3DYJ0O5DiGDSfEie+2JVYKx8rjgYwp03TNeTv13v6Z//JmT+yO4l37faXN8K
 RlNEsgilnBwD6y0vhGvBxPfQNM71aBi6izDNSpu9yDxCKiIub/LYLmFhKBAIgRrFNBVQ
 2riCO5CTXcLxhbNwFAxfa8KJP+sSXYtatBUNa40zeqFdCFN+7ldB+5DWaS0IpkBxHfNP Pw== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p6fgfsrm5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Mar 2023 13:36:21 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 328DZiA9020632;
        Wed, 8 Mar 2023 13:35:44 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3p4fftbxxy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 08 Mar 2023 13:35:44 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 328DZhce020620;
        Wed, 8 Mar 2023 13:35:43 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-rohiagar-hyd.qualcomm.com [10.213.106.138])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 328DZhH9020602;
        Wed, 08 Mar 2023 13:35:43 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id B00E64FB6; Wed,  8 Mar 2023 19:05:42 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mani@kernel.org,
        lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com,
        manivannan.sadhasivam@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH v3 4/5] ARM: dts: qcom: sdx65-mtp: Enable PCIe PHY
Date:   Wed,  8 Mar 2023 19:05:31 +0530
Message-Id: <1678282532-16635-5-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1678282532-16635-1-git-send-email-quic_rohiagar@quicinc.com>
References: <1678282532-16635-1-git-send-email-quic_rohiagar@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: MX_OF50JPuj-nRbgRnJ7kkNU9IdHySaO
X-Proofpoint-ORIG-GUID: MX_OF50JPuj-nRbgRnJ7kkNU9IdHySaO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-08_08,2023-03-08_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 impostorscore=0 mlxscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=468
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303080116
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
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

