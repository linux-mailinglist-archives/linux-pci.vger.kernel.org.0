Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF5473B3EF
	for <lists+linux-pci@lfdr.de>; Fri, 23 Jun 2023 11:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231660AbjFWJon (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Jun 2023 05:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbjFWJoi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Jun 2023 05:44:38 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD1EAE5B;
        Fri, 23 Jun 2023 02:44:36 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35N9LsoA032417;
        Fri, 23 Jun 2023 09:44:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=CA4fFdNXHG6NGLtqd1yEf3yJfAt7381Of5/B0ZNSUOQ=;
 b=gvWzMjAH7o6pAwh9V8/Ca2tIRWoOSEHaV0cBtd6p2qiTiGb1au8/itvj0Ol5+VqUOBBO
 sby0EUF63PohUr3+8A/Y56AIHJW/oc6H4uhMU2VXBNPZBpeW+7YzazRNlcPCvpGt3TTj
 YYlMjjKKZMs5NhBHrWHAkCUDIeX4ZszmSznu2oarlvs3l4q5wW1cd/wq29btvQyOVzv5
 trTljBS/Gky4kwNSfKpVHGFrL8TExmYgDNXJNC89GfGwUf5iPFCbufYOfRqTxEPBcs+p
 xMh5GBbBWztjMGoS/+rqyeZjFukTKsp/DCzMubd4JNUZB5CBU5SSTa8s/WHLIKAuQUPR zQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rc6b2cc00-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jun 2023 09:44:31 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35N9iUoi009484
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jun 2023 09:44:30 GMT
Received: from win-platform-upstream01.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 23 Jun 2023 02:44:24 -0700
From:   Sricharan Ramabadhran <quic_srichara@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <sboyd@kernel.org>, <mturquette@baylibre.com>, <mani@kernel.org>,
        <lpieralisi@kernel.org>, <bhelgaas@google.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <quic_srichara@quicinc.com>
Subject: [PATCH 1/4] pcie: qcom: Fix the macro PARF_SLV_ADDR_SPACE_SIZE_2_3_3
Date:   Fri, 23 Jun 2023 15:14:00 +0530
Message-ID: <20230623094403.3978838-2-quic_srichara@quicinc.com>
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
X-Proofpoint-ORIG-GUID: DFdShY8pvvg1hIh5taMkFBXABXnuVhaT
X-Proofpoint-GUID: DFdShY8pvvg1hIh5taMkFBXABXnuVhaT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-23_04,2023-06-22_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0 priorityscore=1501
 mlxlogscore=999 lowpriorityscore=0 impostorscore=0 mlxscore=0 adultscore=0
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

PARF_SLV_ADDR_SPACE_SIZE_2_3_3 macro used for IPQ8074
pcie slave addr size was initially set to 0x358, but
was wrongly changed to 0x168 as a part of
'PCI: qcom: Sort and group registers and bitfield definitions'
Fixing it back to right value here.

Without this pcie bring up on IPQ8074 is broken now.

Fixes: 769e49d87b15 ("PCI: qcom: Sort and group registers and bitfield definitions")
Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 4ab30892f6ef..59823beed13f 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -43,7 +43,7 @@
 #define PARF_PHY_REFCLK				0x4c
 #define PARF_CONFIG_BITS			0x50
 #define PARF_DBI_BASE_ADDR			0x168
-#define PARF_SLV_ADDR_SPACE_SIZE_2_3_3		0x16c /* Register offset specific to IP ver 2.3.3 */
+#define PARF_SLV_ADDR_SPACE_SIZE_2_3_3		0x358 /* Register offset specific to IP ver 2.3.3 */
 #define PARF_MHI_CLOCK_RESET_CTRL		0x174
 #define PARF_AXI_MSTR_WR_ADDR_HALT		0x178
 #define PARF_AXI_MSTR_WR_ADDR_HALT_V2		0x1a8
-- 
2.34.1

