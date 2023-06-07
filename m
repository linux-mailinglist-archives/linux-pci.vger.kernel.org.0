Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41C307265AA
	for <lists+linux-pci@lfdr.de>; Wed,  7 Jun 2023 18:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231940AbjFGQS0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Jun 2023 12:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232477AbjFGQSY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Jun 2023 12:18:24 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 636FD1BEC;
        Wed,  7 Jun 2023 09:18:22 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 357ErL41010213;
        Wed, 7 Jun 2023 16:18:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=VeSbAxWEvoQCsQCbDJ4cOXZRowdK7XhoiI7gBf8qkcg=;
 b=blkcMsm5pt4KsGLvLy6Yz+K8K/xG4xScbZ9czIQn8Sf6IAFiDeLM+XdMbiyVz8k/QpmV
 Ec/9Y22DVi26Iuzs2sCjcnp2RNY0yHyl7gQSAYhqmiGrC0zPQVEjy+baQB4rCqUimtA5
 SdgEKVIXKiTu4/arOUXwLiRktNBL/1DBqgwP9SgF7pH4KahPhR4K8f/PExTRVt7Ro+oG
 uDxpJ99bM1cZhc6dMQGsbbYzJmMv16kxbLMSiGzV6+qOBNW6DaeNNrllhug1PivWQTgn
 Oi3/+tYwxDdwg6PGUobUmKq6fG3zrH/IRjQ1hlik8cn9/uhWLTPDqHxPYLOUnX0/Yxhd 2w== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r2a7k2bhp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Jun 2023 16:18:13 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 357GIAwv029266;
        Wed, 7 Jun 2023 16:18:10 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3qyxkm3buk-1;
        Wed, 07 Jun 2023 16:18:10 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 357GI92I029191;
        Wed, 7 Jun 2023 16:18:10 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-krichai-hyd.qualcomm.com [10.213.110.112])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 357GI9cJ029203;
        Wed, 07 Jun 2023 16:18:09 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 4058933)
        id E2FCC3935; Wed,  7 Jun 2023 21:48:08 +0530 (+0530)
From:   Krishna chaitanya chundru <quic_krichai@quicinc.com>
To:     manivannan.sadhasivam@linaro.org
Cc:     quic_vbadigan@quicinc.com, quic_ramkri@quicinc.com,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org (open list:PCIE ENDPOINT DRIVER FOR QUALCOMM),
        linux-arm-msm@vger.kernel.org (open list:PCIE ENDPOINT DRIVER FOR
        QUALCOMM), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 3/3] PCI: qcom-ep: Add ICC bandwidth voting support
Date:   Wed,  7 Jun 2023 21:48:07 +0530
Message-Id: <1686154687-29356-4-git-send-email-quic_krichai@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1686154687-29356-1-git-send-email-quic_krichai@quicinc.com>
References: <1686154687-29356-1-git-send-email-quic_krichai@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: TxFsakLNEaTdOeXWqubTjoNOdUdID8SN
X-Proofpoint-GUID: TxFsakLNEaTdOeXWqubTjoNOdUdID8SN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_07,2023-06-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 impostorscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306070138
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support to vote for ICC bandwidth based on the link
speed and width.

This patch is inspired from pcie-qcom driver to add basic
interconnect support.

Link:https://patchwork.kernel.org/project/linux-pci/patch/20221102090705.23634-3-johan+linaro@kernel.org/
Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 68 +++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 19b3283..5f9139d 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -13,6 +13,7 @@
 #include <linux/debugfs.h>
 #include <linux/delay.h>
 #include <linux/gpio/consumer.h>
+#include <linux/interconnect.h>
 #include <linux/mfd/syscon.h>
 #include <linux/phy/pcie.h>
 #include <linux/phy/phy.h>
@@ -28,6 +29,7 @@
 #define PARF_SYS_CTRL				0x00
 #define PARF_DB_CTRL				0x10
 #define PARF_PM_CTRL				0x20
+#define PARF_PM_STTS				0x24
 #define PARF_MHI_CLOCK_RESET_CTRL		0x174
 #define PARF_MHI_BASE_ADDR_LOWER		0x178
 #define PARF_MHI_BASE_ADDR_UPPER		0x17c
@@ -128,6 +130,9 @@
 /* DBI register fields */
 #define DBI_CON_STATUS_POWER_STATE_MASK		GENMASK(1, 0)
 
+#define DBI_LINKCTRLSTATUS			0x80
+#define DBI_LINKCTRLSTATUS_SHIFT		16
+
 #define XMLH_LINK_UP				0x400
 #define CORE_RESET_TIME_US_MIN			1000
 #define CORE_RESET_TIME_US_MAX			1005
@@ -178,6 +183,8 @@ struct qcom_pcie_ep {
 	struct phy *phy;
 	struct dentry *debugfs;
 
+	struct icc_path *icc;
+
 	struct clk_bulk_data *clks;
 	int num_clks;
 
@@ -253,9 +260,51 @@ static void qcom_pcie_dw_stop_link(struct dw_pcie *pci)
 	disable_irq(pcie_ep->perst_irq);
 }
 
+static void qcom_pcie_ep_icc_update(struct qcom_pcie_ep *pcie_ep)
+{
+	struct dw_pcie *pci = &pcie_ep->pci;
+	int speed, width;
+	u32 val, bw;
+	int ret;
+
+	if (!pcie_ep->icc)
+		return;
+
+	val = dw_pcie_readl_dbi(pci, DBI_LINKCTRLSTATUS);
+	val = val >> DBI_LINKCTRLSTATUS_SHIFT;
+
+	speed = FIELD_GET(PCI_EXP_LNKSTA_CLS, val);
+	width = FIELD_GET(PCI_EXP_LNKSTA_NLW, val);
+
+	switch (speed) {
+	case 1:
+		bw = MBps_to_icc(250);	/* BW for GEN1 per lane: 250MBps */
+		break;
+	case 2:
+		bw = MBps_to_icc(500);	/* BW for GEN2 per lane: 500MBps */
+		break;
+	case 3:
+		bw = MBps_to_icc(985);	/* BW for GEN3 per lane: 985MBps */
+		break;
+	default:
+		WARN_ON_ONCE(1);
+		fallthrough;
+	case 4:
+		bw = MBps_to_icc(1969);	/* BW for GEN4 per lane: 985MBps */
+		break;
+	}
+
+	ret = icc_set_bw(pcie_ep->icc, 0, width * bw);
+	if (ret) {
+		dev_err(pci->dev, "failed to set interconnect bandwidth: %d\n",
+			ret);
+	}
+}
+
 static int qcom_pcie_enable_resources(struct qcom_pcie_ep *pcie_ep)
 {
 	int ret;
+	struct dw_pcie *pci = &pcie_ep->pci;
 
 	ret = clk_bulk_prepare_enable(pcie_ep->num_clks, pcie_ep->clks);
 	if (ret)
@@ -277,6 +326,20 @@ static int qcom_pcie_enable_resources(struct qcom_pcie_ep *pcie_ep)
 	if (ret)
 		goto err_phy_exit;
 
+	/*
+	 * Some Qualcomm platforms require interconnect bandwidth constraints
+	 * to be set before enabling interconnect clocks.
+	 *
+	 * Set an initial average bandwidth corresponding to single-lane Gen 1
+	 * for the pcie to mem path.
+	 */
+	ret = icc_set_bw(pcie_ep->icc, 0, MBps_to_icc(250)); /* BW for GEN1 per lane: 250MBps */
+	if (ret) {
+		dev_err(pci->dev, "failed to set interconnect bandwidth: %d\n",
+			ret);
+		goto err_phy_exit;
+	}
+
 	return 0;
 
 err_phy_exit:
@@ -550,6 +613,10 @@ static int qcom_pcie_ep_get_resources(struct platform_device *pdev,
 	if (IS_ERR(pcie_ep->phy))
 		ret = PTR_ERR(pcie_ep->phy);
 
+	pcie_ep->icc = devm_of_icc_get(dev, "pcie-mem");
+	if (IS_ERR(pcie_ep->icc))
+		ret = PTR_ERR(pcie_ep->icc);
+
 	return ret;
 }
 
@@ -572,6 +639,7 @@ static irqreturn_t qcom_pcie_ep_global_irq_thread(int irq, void *data)
 	} else if (FIELD_GET(PARF_INT_ALL_BME, status)) {
 		dev_dbg(dev, "Received BME event. Link is enabled!\n");
 		pcie_ep->link_status = QCOM_PCIE_EP_LINK_ENABLED;
+		qcom_pcie_ep_icc_update(pcie_ep);
 	} else if (FIELD_GET(PARF_INT_ALL_PM_TURNOFF, status)) {
 		dev_dbg(dev, "Received PM Turn-off event! Entering L23\n");
 		val = readl_relaxed(pcie_ep->parf + PARF_PM_CTRL);
-- 
2.7.4

