Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04CFA73B3F6
	for <lists+linux-pci@lfdr.de>; Fri, 23 Jun 2023 11:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbjFWJpR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Jun 2023 05:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231887AbjFWJpC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Jun 2023 05:45:02 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB1321FF5;
        Fri, 23 Jun 2023 02:44:51 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35N9W1sF023206;
        Fri, 23 Jun 2023 09:44:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=Bbl2GUsX/+aU3++gosIdUgd7In2HdktUDbQX2d7ZDtw=;
 b=LvzzD6Ni0V1t2xso25ZScpvR7Dt9Dt39sLmoQgdQVOvTsEQqXQcNjYV6BmNUR8BZkYMS
 OXc5JYYJvcwG90IXCG9eEDHAMo7axLUUEoY2ZFFfzJgxRNHwO0320pTLnsOi2BRhXEEK
 +c5pZtPoHUsZ0zXMsMe1UZd3/WY6j5JJI/EYYtznRlxuwqQrv6yDW4TA9r3bqBOALFTN
 vu22YiSG5phIEOA/xtbVi+A7lbp7/jjVyQonIICdtsLIB92S+yvVZgJ3ixUKAU9k5kwD
 2jIQbwIqrYM0VFhUOnjVxIKQ1hjpcvaK8GkTMqKeURs56caQHUN5ha8/Bq7JBab8851M 6Q== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rd64a0cw2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jun 2023 09:44:45 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35N9iiKU010101
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jun 2023 09:44:44 GMT
Received: from win-platform-upstream01.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 23 Jun 2023 02:44:39 -0700
From:   Sricharan Ramabadhran <quic_srichara@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <sboyd@kernel.org>, <mturquette@baylibre.com>, <mani@kernel.org>,
        <lpieralisi@kernel.org>, <bhelgaas@google.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <quic_srichara@quicinc.com>
Subject: [PATCH 4/4] dts: Reserve memory region for NSS and TZ
Date:   Fri, 23 Jun 2023 15:14:03 +0530
Message-ID: <20230623094403.3978838-5-quic_srichara@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230623094403.3978838-1-quic_srichara@quicinc.com>
References: <20230623094403.3978838-1-quic_srichara@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: XCI8-8PcmvfJo-CB1Fqor9MKfxqj2TjI
X-Proofpoint-ORIG-GUID: XCI8-8PcmvfJo-CB1Fqor9MKfxqj2TjI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-23_04,2023-06-22_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 spamscore=0 phishscore=0 mlxscore=0 adultscore=0
 mlxlogscore=624 clxscore=1015 priorityscore=1501 suspectscore=0
 bulkscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306230087
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add reserved memory region for NSS and fix the name
for tz region explicitly.

Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
---
 arch/arm64/boot/dts/qcom/ipq8074.dtsi | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
index 791af73334cb..d51ff9b4f5c1 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
@@ -86,6 +86,11 @@ reserved-memory {
 		#size-cells = <2>;
 		ranges;
 
+		nss@40000000 {
+			reg = <0x0 0x40000000 0x0 0x01000000>;
+			no-map;
+		};
+
 		bootloader@4a600000 {
 			reg = <0x0 0x4a600000 0x0 0x400000>;
 			no-map;
@@ -104,7 +109,7 @@ smem@4ab00000 {
 			hwlocks = <&tcsr_mutex 0>;
 		};
 
-		memory@4ac00000 {
+		tz@4ac00000 {
 			reg = <0x0 0x4ac00000 0x0 0x400000>;
 			no-map;
 		};
-- 
2.34.1

