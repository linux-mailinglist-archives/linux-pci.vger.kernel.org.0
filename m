Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 021CD70873F
	for <lists+linux-pci@lfdr.de>; Thu, 18 May 2023 19:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjERRss (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 May 2023 13:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbjERRsR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 May 2023 13:48:17 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1726A9;
        Thu, 18 May 2023 10:48:12 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34IGpSAf022407;
        Thu, 18 May 2023 17:48:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=7xJ7kmdOUR7XQGH/2mbnFQlKVlyPiQtBE7VhamrXsgU=;
 b=jzRMnwBI0qqLUbW3bi03HPMltYxTPCRtrb+x2lCNaCXkeqkTWlKSEWUl5L+XMtqwYy68
 9WJk+5C1tprn+0DNZFjmA/2icgYNkmlvucH9odh5I5Spg1zbCdp5ODiZQ6veZaaLHsp0
 9uHjhMkCYFu22iAkpT11r5PQn/IwcctEbGfJKRmL1wAxX3NM+ntYVffWmdW8Gi5KQk9M
 MJ+z8rfOiv0oD5Da6AHce9iL8F4lokNuANFc1swoktlfO+neTBxDwd0CNDZ019UKk4jO
 u2U98jqdiwXY5tWQh6X74eIhCmsWfNnWOpEx9vTCDB39OfJufbXHAAt0VQwDPbCMf++n HA== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qmxyp3fxa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 May 2023 17:48:06 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 34IHm2Pb012284;
        Thu, 18 May 2023 17:48:03 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3qj3mkakxw-1;
        Thu, 18 May 2023 17:48:03 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34IHm1pW011968;
        Thu, 18 May 2023 17:48:03 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-rohiagar-hyd.qualcomm.com [10.213.106.138])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 34IHm2Pv012362;
        Thu, 18 May 2023 17:48:03 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id 185125EBF; Thu, 18 May 2023 23:18:02 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mani@kernel.org, bhelgaas@google.com, lpieralisi@kernel.org,
        kw@linux.com, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, manivannan.sadhasivam@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH v6 4/5] ARM: dts: qcom: sdx65-mtp: Enable PCIe PHY
Date:   Thu, 18 May 2023 23:17:52 +0530
Message-Id: <1684432073-28490-5-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1684432073-28490-1-git-send-email-quic_rohiagar@quicinc.com>
References: <1684432073-28490-1-git-send-email-quic_rohiagar@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: gg_9NsLTx2qbzwnk8-o8q6MZmvLso6il
X-Proofpoint-GUID: gg_9NsLTx2qbzwnk8-o8q6MZmvLso6il
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_13,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=590
 priorityscore=1501 impostorscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305180144
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Enable PCIe PHY on SDX65 MTP for PCIe EP.

Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm/boot/dts/qcom-sdx65-mtp.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-sdx65-mtp.dts b/arch/arm/boot/dts/qcom-sdx65-mtp.dts
index 57bc3b0..29ccb158 100644
--- a/arch/arm/boot/dts/qcom-sdx65-mtp.dts
+++ b/arch/arm/boot/dts/qcom-sdx65-mtp.dts
@@ -250,6 +250,13 @@
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
-- 
2.7.4

