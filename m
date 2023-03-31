Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17D4E6D1740
	for <lists+linux-pci@lfdr.de>; Fri, 31 Mar 2023 08:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbjCaGSr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 31 Mar 2023 02:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbjCaGSn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 31 Mar 2023 02:18:43 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE4D535B5;
        Thu, 30 Mar 2023 23:18:42 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32V4nrG9023751;
        Fri, 31 Mar 2023 06:18:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=fOP6/r5JzqdqcvR/nc0CQKYOBjsULOzHa737f9KMAzE=;
 b=niLHekbSqnaKHZUN3n15Xs6RjEeClY72PnPrq+s+TCdz0Fhw3IZiIGrJZkdTTzraIChM
 JhA2C6ginSYoikMh5+5FrhZ71zC7VMDjV8BXMEMxFfMkEqze7IwV/Ivk9jMjR34iBQDA
 MWDkpzxNka6bSFcS8FXPoVOqRFPLoT15BBzW3tzs14jI1OPIxN/H16ag3ZvqnWT3BsYG
 4AhBTRu70rs4RyyMuHtP3RX1f9JjcwAsM/ogf8jpntJRpO3wGKvU5kNL7nQfjepPxp9L
 8MKO5aevyMMAAmZF0hXhYSAVxfC6B6qZjLxte6q/HXh2dbo7QvsEUydiK/3jFO9uBrAh fw== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pn5xr3402-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 31 Mar 2023 06:18:35 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 32V6IVNA013885;
        Fri, 31 Mar 2023 06:18:32 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3pht1knm2h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 31 Mar 2023 06:18:32 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32V6IWLx013910;
        Fri, 31 Mar 2023 06:18:32 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-rohiagar-hyd.qualcomm.com [10.213.106.138])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 32V6IWMc013901;
        Fri, 31 Mar 2023 06:18:32 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id ACE984EE8; Fri, 31 Mar 2023 11:48:31 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mani@kernel.org, bhelgaas@google.com, lpieralisi@kernel.org,
        kw@linux.com, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        manivannan.sadhasivam@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH v5 4/5] ARM: dts: qcom: sdx65-mtp: Enable PCIe PHY
Date:   Fri, 31 Mar 2023 11:48:21 +0530
Message-Id: <1680243502-23744-5-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1680243502-23744-1-git-send-email-quic_rohiagar@quicinc.com>
References: <1680243502-23744-1-git-send-email-quic_rohiagar@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 2MQm8a90qwUU2Jw7tRdQVMUFxzwoxK5B
X-Proofpoint-GUID: 2MQm8a90qwUU2Jw7tRdQVMUFxzwoxK5B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-31_02,2023-03-30_04,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 phishscore=0 priorityscore=1501 impostorscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 mlxlogscore=538 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303310050
X-Spam-Status: No, score=0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Enable PCIe PHY on SDX65 MTP for PCIe EP. While at it,
updating status as last property for each node.

Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
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

