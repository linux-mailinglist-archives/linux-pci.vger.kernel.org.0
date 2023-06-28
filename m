Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7E50740833
	for <lists+linux-pci@lfdr.de>; Wed, 28 Jun 2023 04:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbjF1CTs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Jun 2023 22:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjF1CTp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Jun 2023 22:19:45 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D1B2D6A;
        Tue, 27 Jun 2023 19:19:44 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35S1WZ34003033;
        Wed, 28 Jun 2023 02:19:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=ttJH+Q+I3EfsLN6bXozDeQAWJd5T2I47/qF5gVd0jWs=;
 b=N47c2hC7WpzHSxj0k3/NEfRXxit6BNTLcO5hiKgFaiPW2NmOa1uw1pBWpogXEP4FmxQJ
 wpJ8tjcDHF/3MeZKXGKhj9VeB9HH+a6oTPs17WOr+1HRMwnC2IdwcUTUd3HEzpPPNiWm
 KbR1aAiUrNNOAnsQpcoBKRbw8zl2g29cWs7UI5e+q/Wo5TyRPyGcrwvwsjdpCPgKdb/p
 rAXTgd7ci0Oep0rb4Zh1hJcngGKX8pBQFT2y2dZSYyrdM5c58VWW9JKtRNJsDb9rqC/B
 EqSBD7HyL+sg8el9wzWsNlGdvcvHwKU5A33VtlwlRcEeH+vhwMlwN+hZwtA8PtdRJJwX 5A== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rfrdtahbb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 02:19:37 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 35S2JYLl023401;
        Wed, 28 Jun 2023 02:19:34 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3rdsjkqpku-1;
        Wed, 28 Jun 2023 02:19:34 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35S2JYi4023365;
        Wed, 28 Jun 2023 02:19:34 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-krichai-hyd.qualcomm.com [10.213.110.112])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 35S2JYWm023378;
        Wed, 28 Jun 2023 02:19:34 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 4058933)
        id CAD9B4AB0; Wed, 28 Jun 2023 07:49:33 +0530 (+0530)
From:   Krishna chaitanya chundru <quic_krichai@quicinc.com>
To:     manivannan.sadhasivam@linaro.org
Cc:     helgaas@kernel.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_nitegupt@quicinc.com,
        quic_skananth@quicinc.com, quic_ramkri@quicinc.com,
        krzysztof.kozlowski@linaro.org,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v6 3/3] PCI: qcom-ep: Add ICC bandwidth voting support
Date:   Wed, 28 Jun 2023 07:49:30 +0530
Message-Id: <1687918770-28416-4-git-send-email-quic_krichai@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1687918770-28416-1-git-send-email-quic_krichai@quicinc.com>
References: <1687918770-28416-1-git-send-email-quic_krichai@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 4c_IRJWZn8azrW_71qhcIFw_Gsof8pWm
X-Proofpoint-GUID: 4c_IRJWZn8azrW_71qhcIFw_Gsof8pWm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-27_16,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 suspectscore=0 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 clxscore=1015 adultscore=0 mlxscore=0 bulkscore=0
 spamscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306280019
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

Reference: commit c4860af88d0c ("PCI: qcom: Add basic interconnect
support").
Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 72 ++++++++++++++++++++++++++++++-
 1 file changed, 71 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 1435f51..b7d7038 100644
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
@@ -133,6 +135,11 @@
 #define CORE_RESET_TIME_US_MAX			1005
 #define WAKE_DELAY_US				2000 /* 2 ms */
 
+#define PCIE_GEN1_BW_MBPS			250
+#define PCIE_GEN2_BW_MBPS			500
+#define PCIE_GEN3_BW_MBPS			985
+#define PCIE_GEN4_BW_MBPS			1969
+
 #define to_pcie_ep(x)				dev_get_drvdata((x)->dev)
 
 enum qcom_pcie_ep_link_status {
@@ -178,6 +185,8 @@ struct qcom_pcie_ep {
 	struct phy *phy;
 	struct dentry *debugfs;
 
+	struct icc_path *icc_mem;
+
 	struct clk_bulk_data *clks;
 	int num_clks;
 
@@ -253,9 +262,50 @@ static void qcom_pcie_dw_stop_link(struct dw_pcie *pci)
 	disable_irq(pcie_ep->perst_irq);
 }
 
+static void qcom_pcie_ep_icc_update(struct qcom_pcie_ep *pcie_ep)
+{
+	struct dw_pcie *pci = &pcie_ep->pci;
+	u32 offset, status, bw;
+	int speed, width;
+	int ret;
+
+	if (!pcie_ep->icc_mem)
+		return;
+
+	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	status = readw(pci->dbi_base + offset + PCI_EXP_LNKSTA);
+
+	speed = FIELD_GET(PCI_EXP_LNKSTA_CLS, status);
+	width = FIELD_GET(PCI_EXP_LNKSTA_NLW, status);
+
+	switch (speed) {
+	case 1:
+		bw = MBps_to_icc(PCIE_GEN1_BW_MBPS);
+		break;
+	case 2:
+		bw = MBps_to_icc(PCIE_GEN2_BW_MBPS);
+		break;
+	case 3:
+		bw = MBps_to_icc(PCIE_GEN3_BW_MBPS);
+		break;
+	default:
+		dev_warn(pci->dev, "using default GEN4 bandwidth\n");
+		fallthrough;
+	case 4:
+		bw = MBps_to_icc(PCIE_GEN4_BW_MBPS);
+		break;
+	}
+
+	ret = icc_set_bw(pcie_ep->icc_mem, 0, width * bw);
+	if (ret)
+		dev_err(pci->dev, "failed to set interconnect bandwidth: %d\n",
+			ret);
+}
+
 static int qcom_pcie_enable_resources(struct qcom_pcie_ep *pcie_ep)
 {
 	int ret;
+	struct dw_pcie *pci = &pcie_ep->pci;
 
 	ret = clk_bulk_prepare_enable(pcie_ep->num_clks, pcie_ep->clks);
 	if (ret)
@@ -277,8 +327,23 @@ static int qcom_pcie_enable_resources(struct qcom_pcie_ep *pcie_ep)
 	if (ret)
 		goto err_phy_exit;
 
-	return 0;
+	/*
+	 * Some Qualcomm platforms require interconnect bandwidth constraints
+	 * to be set before enabling interconnect clocks.
+	 *
+	 * Set an initial peak bandwidth corresponding to single-lane Gen 1
+	 * for the pcie-mem path.
+	 */
+	ret = icc_set_bw(pcie_ep->icc_mem, 0, MBps_to_icc(PCIE_GEN1_BW_MBPS));
+	if (ret) {
+		dev_err(pci->dev, "failed to set interconnect bandwidth: %d\n",
+			ret);
+		goto err_phy_off;
+	}
 
+	return 0;
+err_phy_off:
+	phy_power_off(pcie_ep->phy);
 err_phy_exit:
 	phy_exit(pcie_ep->phy);
 err_disable_clk:
@@ -550,6 +615,10 @@ static int qcom_pcie_ep_get_resources(struct platform_device *pdev,
 	if (IS_ERR(pcie_ep->phy))
 		ret = PTR_ERR(pcie_ep->phy);
 
+	pcie_ep->icc_mem = devm_of_icc_get(dev, "pcie-mem");
+	if (IS_ERR(pcie_ep->icc_mem))
+		ret = PTR_ERR(pcie_ep->icc_mem);
+
 	return ret;
 }
 
@@ -573,6 +642,7 @@ static irqreturn_t qcom_pcie_ep_global_irq_thread(int irq, void *data)
 	} else if (FIELD_GET(PARF_INT_ALL_BME, status)) {
 		dev_dbg(dev, "Received BME event. Link is enabled!\n");
 		pcie_ep->link_status = QCOM_PCIE_EP_LINK_ENABLED;
+		qcom_pcie_ep_icc_update(pcie_ep);
 		pci_epc_bme_notify(pci->ep.epc);
 	} else if (FIELD_GET(PARF_INT_ALL_PM_TURNOFF, status)) {
 		dev_dbg(dev, "Received PM Turn-off event! Entering L23\n");
-- 
2.7.4

