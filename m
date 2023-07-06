Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20816749B86
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jul 2023 14:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbjGFMQG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Jul 2023 08:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbjGFMQF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Jul 2023 08:16:05 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A25171A;
        Thu,  6 Jul 2023 05:16:04 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 366AbvCt021882;
        Thu, 6 Jul 2023 12:15:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=GcBIT0sS7MrSeyjv3sE6TIt3m0HTmwbA2u/pvCo3jIo=;
 b=L6aUxjbvJVWcvwGNn4JdOQ0tm1YcQXaJRBZ7pXl3jydat39ar8+hnJ7SPFZqWZH3sM1t
 z+BD9UD0liRDoSEIN1Aj+7H2SJbysHDAA2lp/SiLMUa+yZNf61+fFnFoyhM3x/aqw4qs
 s32FBXCzwcwGMmF0yVtw4/1RrjyPA7Z2DcRO1OLdJpPwhCS7p2Z1ssZsxOsa/sBrC9jw
 JfFItp+pz2XBjqc8n0JJeBcxKfSXgkr4o8GJSpj+1wpQZS0tP1Jzab02v1/h1im1vgJ8
 3NM1IaC1YfmsoOVjH5Cpw4F+W1NYw3Pe/HvW62EvsNQmLCzKg4p8o2wPIqw5y33Gt4i/ 2Q== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rnsu70d5d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Jul 2023 12:15:57 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 366CFuPp010670
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 6 Jul 2023 12:15:56 GMT
Received: from win-platform-upstream01.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 6 Jul 2023 05:15:51 -0700
From:   Sricharan Ramabadhran <quic_srichara@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh@kernel.org>, <mani@kernel.org>,
        <lpieralisi@kernel.org>, <bhelgaas@google.com>, <kw@linux.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <quic_srichara@quicinc.com>
CC:     <stable@vger.kernel.org>
Subject: [PATCH V3] PCI: qcom: Fix broken pcie bring up for 2_3_3 configs ops
Date:   Thu, 6 Jul 2023 17:45:37 +0530
Message-ID: <20230706121537.3129617-1-quic_srichara@quicinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: V_WrC91rPDWp0UVredRq6u4fr3iOmPoI
X-Proofpoint-ORIG-GUID: V_WrC91rPDWp0UVredRq6u4fr3iOmPoI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-06_07,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 clxscore=1011 priorityscore=1501 suspectscore=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307060109
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PARF_SLV_ADDR_SPACE_SIZE_2_3_3 macro is used for IPQ8074
2_3_3 post_init ops. PCIe slave addr size was initially set
to 0x358, but was wrongly changed to 0x168 as a part of

commit 39171b33f652 ("PCI: qcom: Remove PCIE20_ prefix from
register definitions"). Fixing it, by using the right macro
PARF_SLV_ADDR_SPACE_SIZE and removing the unused
PARF_SLV_ADDR_SPACE_SIZE_2_3_3.

Without this pcie bring up on IPQ8074 is broken now.

Fixes: 39171b33f652 ("PCI: qcom: Remove PCIE20_ prefix from register definitions")
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
---
 [v3] Added reviewed-by tag, fixed subject, commit text

 drivers/pci/controller/dwc/pcie-qcom.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 4ab30892f6ef..8418894b3de7 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -43,7 +43,6 @@
 #define PARF_PHY_REFCLK				0x4c
 #define PARF_CONFIG_BITS			0x50
 #define PARF_DBI_BASE_ADDR			0x168
-#define PARF_SLV_ADDR_SPACE_SIZE_2_3_3		0x16c /* Register offset specific to IP ver 2.3.3 */
 #define PARF_MHI_CLOCK_RESET_CTRL		0x174
 #define PARF_AXI_MSTR_WR_ADDR_HALT		0x178
 #define PARF_AXI_MSTR_WR_ADDR_HALT_V2		0x1a8
@@ -810,8 +809,7 @@ static int qcom_pcie_post_init_2_3_3(struct qcom_pcie *pcie)
 	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
 	u32 val;
 
-	writel(SLV_ADDR_SPACE_SZ,
-		pcie->parf + PARF_SLV_ADDR_SPACE_SIZE_2_3_3);
+	writel(SLV_ADDR_SPACE_SZ, pcie->parf + PARF_SLV_ADDR_SPACE_SIZE);
 
 	val = readl(pcie->parf + PARF_PHY_CTRL);
 	val &= ~PHY_TEST_PWR_DOWN;
-- 
2.34.1

