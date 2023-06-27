Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3D6373F017
	for <lists+linux-pci@lfdr.de>; Tue, 27 Jun 2023 03:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbjF0BC5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Jun 2023 21:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjF0BC4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Jun 2023 21:02:56 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F2091FCF;
        Mon, 26 Jun 2023 18:02:19 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35R0fxXH015642;
        Tue, 27 Jun 2023 01:01:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=FgB4bodO1ovCgHDSqrkKk5ANFL0PagqKtToIH6HGxVM=;
 b=L1HyfEBhRozhTdArHdNgSRyuIGWGr3symhmU17e9EDAo+66MHGbFgQ0R+l/N8t/FtCkk
 YrAKWVWK3FSnb2J3+iEW8e4in8zIwyct3Pmw3Yy9SLW+BaIKMjb1L7ZEGbBB0DbYXX+b
 wHc4jdb5RCTnRfgVv1t18/3vwkzPxnxukS2RQM39P/4WCxl9R78Spy2oxyK6e4M3a3xT
 48q4JUD3+f5ZvydZccl1Fe0MBtGeoMTjSi9LoAVuETW6Onus9mUOy2SrMzyuKRCD1cVc
 jp6NW8uTqQotIet66f2FxC7q7vQpFl4k8fOvpMJf1exw0bVaPUagVcF7H1g70avf+32b ZQ== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rfc0d977a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Jun 2023 01:01:46 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 35R11haJ006895;
        Tue, 27 Jun 2023 01:01:43 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3rdsjkh3ca-1;
        Tue, 27 Jun 2023 01:01:43 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35R10HFV005417;
        Tue, 27 Jun 2023 01:01:43 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-krichai-hyd.qualcomm.com [10.213.110.112])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 35R11hmQ006762;
        Tue, 27 Jun 2023 01:01:43 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 4058933)
        id 2ACB44AAC; Tue, 27 Jun 2023 06:31:43 +0530 (+0530)
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
Subject: [PATCH v5 3/3] PCI: qcom-ep: Add ICC bandwidth voting support
Date:   Tue, 27 Jun 2023 06:31:31 +0530
Message-Id: <1687827692-6181-4-git-send-email-quic_krichai@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1687827692-6181-1-git-send-email-quic_krichai@quicinc.com>
References: <1687827692-6181-1-git-send-email-quic_krichai@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: zHGx88Xi-MSCdPvJwLyn6YCTDTy45RD2
X-Proofpoint-ORIG-GUID: zHGx88Xi-MSCdPvJwLyn6YCTDTy45RD2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-26_20,2023-06-26_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 mlxlogscore=999 clxscore=1015 mlxscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306270007
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
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 73 +++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 1435f51..b613817 100644
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
@@ -128,11 +130,19 @@
 /* DBI register fields */
 #define DBI_CON_STATUS_POWER_STATE_MASK		GENMASK(1, 0)
 
+#define DBI_LINKCTRLSTATUS			0x80
+#define DBI_LINKCTRLSTATUS_SHIFT		16
+
 #define XMLH_LINK_UP				0x400
 #define CORE_RESET_TIME_US_MIN			1000
 #define CORE_RESET_TIME_US_MAX			1005
 #define WAKE_DELAY_US				2000 /* 2 ms */
 
+#define PCIE_GEN1_BW_MBPS			250
+#define PCIE_GEN2_BW_MBPS			500
+#define PCIE_GEN3_BW_MBPS			985
+#define PCIE_GEN4_BW_MBPS			1969
+
 #define to_pcie_ep(x)				dev_get_drvdata((x)->dev)
 
 enum qcom_pcie_ep_link_status {
@@ -178,6 +188,8 @@ struct qcom_pcie_ep {
 	struct phy *phy;
 	struct dentry *debugfs;
 
+	struct icc_path *icc_mem;
+
 	struct clk_bulk_data *clks;
 	int num_clks;
 
@@ -253,9 +265,51 @@ static void qcom_pcie_dw_stop_link(struct dw_pcie *pci)
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
@@ -277,6 +331,20 @@ static int qcom_pcie_enable_resources(struct qcom_pcie_ep *pcie_ep)
 	if (ret)
 		goto err_phy_exit;
 
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
+		goto err_phy_exit;
+	}
+
 	return 0;
 
 err_phy_exit:
@@ -550,6 +618,10 @@ static int qcom_pcie_ep_get_resources(struct platform_device *pdev,
 	if (IS_ERR(pcie_ep->phy))
 		ret = PTR_ERR(pcie_ep->phy);
 
+	pcie_ep->icc_mem = devm_of_icc_get(dev, "pcie-mem");
+	if (IS_ERR(pcie_ep->icc_mem))
+		ret = PTR_ERR(pcie_ep->icc_mem);
+
 	return ret;
 }
 
@@ -573,6 +645,7 @@ static irqreturn_t qcom_pcie_ep_global_irq_thread(int irq, void *data)
 	} else if (FIELD_GET(PARF_INT_ALL_BME, status)) {
 		dev_dbg(dev, "Received BME event. Link is enabled!\n");
 		pcie_ep->link_status = QCOM_PCIE_EP_LINK_ENABLED;
+		qcom_pcie_ep_icc_update(pcie_ep);
 		pci_epc_bme_notify(pci->ep.epc);
 	} else if (FIELD_GET(PARF_INT_ALL_PM_TURNOFF, status)) {
 		dev_dbg(dev, "Received PM Turn-off event! Entering L23\n");
-- 
2.7.4

