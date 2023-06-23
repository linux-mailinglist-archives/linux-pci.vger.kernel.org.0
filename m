Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5474173AFA2
	for <lists+linux-pci@lfdr.de>; Fri, 23 Jun 2023 06:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjFWE57 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Jun 2023 00:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjFWE56 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Jun 2023 00:57:58 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B1F189;
        Thu, 22 Jun 2023 21:57:57 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35N4W9hj008366;
        Fri, 23 Jun 2023 04:57:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=j7Bm8l5mYYRm61e7L8igeHe8pJPYWRzXqv07q/u7m/Q=;
 b=a14tQ1YAoaZ4dgyzx+W+UgrNouAtGQjl+49SeJ3heUF2suaSa7XqcYNlU8fyOh2pkiLr
 bZ8v0lnkQo6gAy2AgFDr2Wdp3r76l1Kji1Uc3X5C0mEXkqqKTq4b0QEwkaAlsF/5ZefP
 PEf/5KnZv3OVgzoHNheBO922ACwP5C7Vm304TJsEQhmeaBXhKeJdXIo0XPB95OEooATR
 3CDA4IOWJTw6pFn6+Rcex1iEe6IQ3Hk0xnwPMZ48S6NOU2//7GABTVDgqPclYsRn9ckP
 wD3VNxVQ4gT5sLWTQlTUnn3yVHWEb0bXT1U6AgueA/bJbVI3E8nly1X2bDALEhV6Mv+W CA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rc359mcdt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jun 2023 04:57:50 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35N4vns4003782
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jun 2023 04:57:49 GMT
Received: from devipriy-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 22 Jun 2023 21:57:44 -0700
From:   Devi Priya <quic_devipriy@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <lpieralisi@kernel.org>,
        <kw@linux.com>, <robh@kernel.org>, <bhelgaas@google.com>,
        <mani@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_ipkumar@quicinc.com>
Subject: [PATCH] PCI: qcom: configure the parf halt window size to 1GB
Date:   Fri, 23 Jun 2023 10:27:31 +0530
Message-ID: <20230623045731.29397-1-quic_devipriy@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 6mu3sAqHVH8Ft5UzANOCDEBRyuLhbt20
X-Proofpoint-ORIG-GUID: 6mu3sAqHVH8Ft5UzANOCDEBRyuLhbt20
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-23_02,2023-06-22_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 bulkscore=0 mlxscore=0 malwarescore=0 mlxlogscore=733
 spamscore=0 impostorscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306230043
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Configure the ADDR_BIT_INDEX of PARF_AXI_MSTR_WR_ADDR_HALT_V2 register with
0x1E to increase the halt window size to 1GB so that, when new inbound
posted write transactions whose address crosses 1G address range, the
controller would halt all the incoming writes until all the previous AXI
responses are received.

Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
---
 This patch depends on the below series which adds support for PCIe 
 controllers in IPQ9574
 https://lore.kernel.org/linux-arm-msm/20230519090219.15925-1-quic_devipriy@quicinc.com/

 drivers/pci/controller/dwc/pcie-qcom.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index c7579dfa5b1c..26c40e006120 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -116,6 +116,8 @@
 
 /* PARF_AXI_MSTR_WR_ADDR_HALT register fields */
 #define EN					BIT(31)
+#define ADDR_BIT_INDEX				(BIT(0) | BIT(1) | BIT(2) | \
+						BIT(3) | BIT(4) | BIT(5))
 
 /* PARF_LTSSM register fields */
 #define LTSSM_EN				BIT(8)
@@ -154,6 +156,8 @@
 
 #define QCOM_PCIE_CRC8_POLYNOMIAL		(BIT(2) | BIT(1) | BIT(0))
 
+#define PARF_AXI_MSTR_WR_ADDR_HALT_WINDOW_SIZE	0x1e
+
 #define QCOM_PCIE_1_0_0_MAX_CLOCKS		4
 struct qcom_pcie_resources_1_0_0 {
 	struct clk_bulk_data clks[QCOM_PCIE_1_0_0_MAX_CLOCKS];
@@ -1126,6 +1130,11 @@ static int qcom_pcie_post_init(struct qcom_pcie *pcie)
 
 	writel(0, pcie->parf + PARF_Q2A_FLUSH);
 
+	val = readl(pcie->parf + PARF_AXI_MSTR_WR_ADDR_HALT_V2);
+	val &= ~ADDR_BIT_INDEX;
+	writel(val | PARF_AXI_MSTR_WR_ADDR_HALT_WINDOW_SIZE, pcie->parf +
+			PARF_AXI_MSTR_WR_ADDR_HALT_V2);
+
 	dw_pcie_dbi_ro_wr_en(pci);
 	writel(PCIE_CAP_SLOT_VAL, pci->dbi_base + offset + PCI_EXP_SLTCAP);
 
-- 
2.17.1

