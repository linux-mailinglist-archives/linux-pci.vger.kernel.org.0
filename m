Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2E5473B3EC
	for <lists+linux-pci@lfdr.de>; Fri, 23 Jun 2023 11:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbjFWJof (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Jun 2023 05:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbjFWJod (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Jun 2023 05:44:33 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E461A3;
        Fri, 23 Jun 2023 02:44:31 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35N9THrB025664;
        Fri, 23 Jun 2023 09:44:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=0LTxr9YIR4qFghBO4pEabh9B3dPBGBcN1vi0qYLTj0s=;
 b=mXzBqsMkErgY8L1tZvZIB05A5RSfE7AS1sRMx6Bkm4zqOQtgTMsjkmTFiWCjxR6F6tDw
 ebhLaR4JAP/ouI6jEqE2wyPY/4d6FlO8RJesaoz3Fmv/etrtYGJLKYvVvVChJZIwDNPL
 bONeyEkgXIIFcQj3BnPhXoxu2S38zAXPPrByrBbetzeSj3k/5dkRmhs9XMyWJId1C5Ov
 /ovfj7SvTs0XEOPeJitv0iQiXbHTZckr0c6PvfrjljZX7UE+fnEO7PMf5wy8aikKmnjk
 FQRDJEIaUu6hYx9Pk13VdhOvIIeWDG2lJPZYYyPZKoor4ktW9NTPsXJ4hcCrXQUzsrO/ FQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rbwvmdrb5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jun 2023 09:44:25 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35N9iOGv009014
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jun 2023 09:44:24 GMT
Received: from win-platform-upstream01.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 23 Jun 2023 02:44:18 -0700
From:   Sricharan Ramabadhran <quic_srichara@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <sboyd@kernel.org>, <mturquette@baylibre.com>, <mani@kernel.org>,
        <lpieralisi@kernel.org>, <bhelgaas@google.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <quic_srichara@quicinc.com>
Subject: [PATCH 0/4]  IPQ8074 pcie/wcss fixes
Date:   Fri, 23 Jun 2023 15:13:59 +0530
Message-ID: <20230623094403.3978838-1-quic_srichara@quicinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: pSPARl6IL4w2QmuxrUVJ8xyQSgrBkm6w
X-Proofpoint-GUID: pSPARl6IL4w2QmuxrUVJ8xyQSgrBkm6w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-23_04,2023-06-22_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 mlxlogscore=612 malwarescore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306230087
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

These are required to have pcie/wcss working on IPQ8074 based
boards. Pcie was broken recently, first patch fixes that and
next 2 are for adding WCSS reset and 1 for adding reserved region
for NSS.

Will be following this up with few more dts updates and pcie
fixes.

Sricharan Ramabadhran (4):
  pcie: qcom: Fix the macro PARF_SLV_ADDR_SPACE_SIZE_2_3_3
  dt-bindings: clock: qcom: Add reset for WCSSAON
  clk: qcom: Add WCSSAON reset
  dts: Reserve memory region for NSS and TZ

 arch/arm64/boot/dts/qcom/ipq8074.dtsi        | 7 ++++++-
 drivers/clk/qcom/gcc-ipq8074.c               | 1 +
 drivers/pci/controller/dwc/pcie-qcom.c       | 2 +-
 include/dt-bindings/clock/qcom,gcc-ipq8074.h | 1 +
 4 files changed, 9 insertions(+), 2 deletions(-)

-- 
2.34.1

