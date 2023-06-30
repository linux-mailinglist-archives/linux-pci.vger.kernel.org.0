Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5046743389
	for <lists+linux-pci@lfdr.de>; Fri, 30 Jun 2023 06:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbjF3EZn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Jun 2023 00:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjF3EZj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Jun 2023 00:25:39 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF352102;
        Thu, 29 Jun 2023 21:25:38 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35U4PVME021868;
        Fri, 30 Jun 2023 04:25:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=JmG68rcV4TQD2haswqJP94DrA0oEodIz4a6wZbUIeY0=;
 b=e2xjPa2fO6ZDk2sPibHBJ/td6NXRUjDV4O58xP3j8XY7QG1X38hmj0RN7Kj0iPl5DhHk
 Dnf26mhN0MR26uMsCnY1aH5CjL7NIWCrFrenz3z6kAj4rI57n4V+iKl+g892u3Lt6Gg1
 qkkRpZ74QtdvS83pQgKSy4wVlFSeGv62PoJgllEb3o81cLCmSQDfc/e6mAaFj6IrlniV
 mxpB8a99oS3iDiO7V5oDgDsxedwFO4RECPzchTGERkQkLaAphLwqRLhVnicg7+lTpLzn
 OB4Ly/w0cY7G7u7ZqTnI7J8sM9oytiZZ0b46MlAQpblG+W+NgwzOlBKAkj5eN7WMHd49 Iw== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rh7s2t1jr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Jun 2023 04:25:30 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 35U4PRP2013225;
        Fri, 30 Jun 2023 04:25:27 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3rdsjknf4r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 30 Jun 2023 04:25:27 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35U4PR2h013207;
        Fri, 30 Jun 2023 04:25:27 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-krichai-hyd.qualcomm.com [10.213.110.112])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 35U4PQDF013194;
        Fri, 30 Jun 2023 04:25:26 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 4058933)
        id 4974C4AC3; Fri, 30 Jun 2023 09:55:26 +0530 (+0530)
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
Subject: [PATCH v7 3/3] PCI: qcom-ep: Add ICC bandwidth voting support
Date:   Fri, 30 Jun 2023 09:55:23 +0530
Message-Id: <1688099123-28036-4-git-send-email-quic_krichai@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1688099123-28036-1-git-send-email-quic_krichai@quicinc.com>
References: <1688099123-28036-1-git-send-email-quic_krichai@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: DHDOxsshdI8GxnJpVEB95HJTEJZxJ-Za
X-Proofpoint-ORIG-GUID: DHDOxsshdI8GxnJpVEB95HJTEJZxJ-Za
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-30_02,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=999 impostorscore=0
 mlxscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306300037
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support for voting interconnect (ICC) bandwidth based
on the link speed and width.

This commit is inspired from the basic interconnect support added
to pcie-qcom driver in commit c4860af88d0c ("PCI: qcom: Add basic
interconnect support").

The interconnect support is kept optional to be backward compatible
with legacy devicetrees.

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 71 +++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 1435f51..cfe3061 100644
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
 
@@ -253,8 +262,49 @@ static void qcom_pcie_dw_stop_link(struct dw_pcie *pci)
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
+	struct dw_pcie *pci = &pcie_ep->pci;
 	int ret;
 
 	ret = clk_bulk_prepare_enable(pcie_ep->num_clks, pcie_ep->clks);
@@ -277,8 +327,24 @@ static int qcom_pcie_enable_resources(struct qcom_pcie_ep *pcie_ep)
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
+		goto err_phy_off;
+	}
+
 	return 0;
 
+err_phy_off:
+	phy_power_off(pcie_ep->phy);
 err_phy_exit:
 	phy_exit(pcie_ep->phy);
 err_disable_clk:
@@ -550,6 +616,10 @@ static int qcom_pcie_ep_get_resources(struct platform_device *pdev,
 	if (IS_ERR(pcie_ep->phy))
 		ret = PTR_ERR(pcie_ep->phy);
 
+	pcie_ep->icc_mem = devm_of_icc_get(dev, "pcie-mem");
+	if (IS_ERR(pcie_ep->icc_mem))
+		ret = PTR_ERR(pcie_ep->icc_mem);
+
 	return ret;
 }
 
@@ -573,6 +643,7 @@ static irqreturn_t qcom_pcie_ep_global_irq_thread(int irq, void *data)
 	} else if (FIELD_GET(PARF_INT_ALL_BME, status)) {
 		dev_dbg(dev, "Received BME event. Link is enabled!\n");
 		pcie_ep->link_status = QCOM_PCIE_EP_LINK_ENABLED;
+		qcom_pcie_ep_icc_update(pcie_ep);
 		pci_epc_bme_notify(pci->ep.epc);
 	} else if (FIELD_GET(PARF_INT_ALL_PM_TURNOFF, status)) {
 		dev_dbg(dev, "Received PM Turn-off event! Entering L23\n");
-- 
2.7.4

