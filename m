Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB427A5F8E
	for <lists+linux-pci@lfdr.de>; Tue, 19 Sep 2023 12:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbjISKal (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Sep 2023 06:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjISKak (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Sep 2023 06:30:40 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F96E8;
        Tue, 19 Sep 2023 03:30:35 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38J3wpiX010036;
        Tue, 19 Sep 2023 10:30:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=J4hOINlXke9uREob4JWDzUId/9wjHUUxaSUVg5YcoIM=;
 b=Ba/uSBhA5GPVKW2xU6y+vkppV/ZxqEe9gaOV7c+ZS+PuuncYajMujbUDdQwr5m7fNMLL
 wBx9nbhuCI9cb05hX6w5s4xG6Vv4rl9iSINpFmBD207vLZAnp3ggKf1Q0pMzm5VSdBoH
 6yzRKnEniDr62lZhnf3xHlgZZJE5f5FYxhCQIyzaY56XAJYD4y/iBZ0cEgy4mvN/xNEq
 Uj3YgPniqt/OYWk8GNp5yvurcoPY3Xvv35B4XmXYYFH2QcYjeC17jyaDpPP7/buTfnhN
 fSY6b7eJabq274+EURFUp0xPw515+JdUETPFMAB23YVRPh0s//3VtD+jwLtC8f9fz4dX dg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t6pmq2b0n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Sep 2023 10:30:12 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38JAUBq8009078
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Sep 2023 10:30:11 GMT
Received: from win-platform-upstream01.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 19 Sep 2023 03:30:06 -0700
From:   Sricharan Ramabadhran <quic_srichara@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh@kernel.org>, <mani@kernel.org>,
        <lpieralisi@kernel.org>, <bhelgaas@google.com>, <kw@linux.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <gregkh@linuxfoundation.org>,
        <dmitry.baryshkov@linaro.org>, <stable@vger.kernel.org>,
        <robimarko@gmail.com>, <quic_srichara@quicinc.com>
CC:     <Stable@vger.kernel.org>
Subject: [PATCH V6] PCI: qcom: Fix broken pcie enumeration for 2_3_3 configs ops
Date:   Tue, 19 Sep 2023 15:59:48 +0530
Message-ID: <20230919102948.1844909-1-quic_srichara@quicinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: f00P1RcoxC1xV01SXBnn0XiJmT3ATX3I
X-Proofpoint-ORIG-GUID: f00P1RcoxC1xV01SXBnn0XiJmT3ATX3I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-19_05,2023-09-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=999 mlxscore=0 phishscore=0
 clxscore=1011 lowpriorityscore=0 adultscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309190089
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PARF_SLV_ADDR_SPACE_SIZE_2_3_3 macro is used for qcom_pcie_post_init_2_3_3.
PCIe slave address space size register offset is 0x358, but was wrongly
changed to 0x16c as a part of commit 39171b33f652 ("PCI: qcom: Remove
PCIE20_ prefix from register definitions"). Fixing it, by using the right
macro and remove the unused PARF_SLV_ADDR_SPACE_SIZE_2_3_3.

Without this access to the registers of slave addr space like iATU etc
are broken leading to PCIe enumeration failure on IPQ8074.

Fixes: 39171b33f652 ("PCI: qcom: Remove PCIE20_ prefix from register definitions")
Cc: <Stable@vger.kernel.org>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Tested-by: Robert Marko <robimarko@gmail.com>
Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
---
 [V6] Fixed subject and commit text as per Bjorn Helgaas

 drivers/pci/controller/dwc/pcie-qcom.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index e2f29404c84e..64420ecc24d1 100644
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
@@ -797,8 +796,7 @@ static int qcom_pcie_post_init_2_3_3(struct qcom_pcie *pcie)
 	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
 	u32 val;
 
-	writel(SLV_ADDR_SPACE_SZ,
-		pcie->parf + PARF_SLV_ADDR_SPACE_SIZE_2_3_3);
+	writel(SLV_ADDR_SPACE_SZ, pcie->parf + PARF_SLV_ADDR_SPACE_SIZE);
 
 	val = readl(pcie->parf + PARF_PHY_CTRL);
 	val &= ~PHY_TEST_PWR_DOWN;
-- 
2.34.1

