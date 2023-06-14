Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0BE47301CF
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jun 2023 16:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244467AbjFNO0q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Jun 2023 10:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245629AbjFNOYp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Jun 2023 10:24:45 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F307C268A;
        Wed, 14 Jun 2023 07:24:38 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35EEMatw001791;
        Wed, 14 Jun 2023 14:24:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=kXz1Ul5Hj81iYG4Qz4eo2J8gTFCnud567jRelPMka3M=;
 b=cQnsYIB7nvwatNbzhw92cihSOXXm6cFjPtaQxQJ658PoLrEVHkNoMeheF4p7tN0WU5WS
 1C63LOdRZjE21H9Kh4sHU5d4/IXuVY1seI5lacLivBx8ugwiz4a0YI5XbNPr5XFecgo3
 r5vwfN/t50+9zfPsSAR6i3PXabZrvW9bUFEhVwMJ3maMy/oDxDW4G+xcMGDFoPXDKqAP
 vl+K+/vgIXBcoYl2GOU7yIUMB1QGWN24P3Hyl/kNmhFB/nAIm0KfLW+2hOxKtNBt+Xve
 m8507Uh8YWaFkflSwyGcyxaD0nsKTWZeKKl45bDcuH6JyB8TTHfIkwUv9S7OqRiUlO1I Dg== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r71tvsp3w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Jun 2023 14:24:32 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 35EEOTxD027300;
        Wed, 14 Jun 2023 14:24:29 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3r4j8m2a8y-1;
        Wed, 14 Jun 2023 14:24:29 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35EEOT0N027291;
        Wed, 14 Jun 2023 14:24:29 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-krichai-hyd.qualcomm.com [10.213.110.112])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 35EEOSJn027281;
        Wed, 14 Jun 2023 14:24:29 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 4058933)
        id 7556F4A52; Wed, 14 Jun 2023 19:54:28 +0530 (+0530)
From:   Krishna chaitanya chundru <quic_krichai@quicinc.com>
To:     manivannan.sadhasivam@linaro.org
Cc:     quic_vbadigan@quicinc.com, quic_ramkri@quicinc.com,
        linux-arm-msm@vger.kernel.org, konrad.dybcio@linaro.org,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org (open list:PCIE ENDPOINT DRIVER FOR QUALCOMM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 3/3] PCI: qcom-ep: Add ICC bandwidth voting support
Date:   Wed, 14 Jun 2023 19:54:26 +0530
Message-Id: <1686752666-13426-4-git-send-email-quic_krichai@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1686752666-13426-1-git-send-email-quic_krichai@quicinc.com>
References: <1686752666-13426-1-git-send-email-quic_krichai@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 62sg7hstbGvq7zcDrnhzPrdacxr4KeXn
X-Proofpoint-ORIG-GUID: 62sg7hstbGvq7zcDrnhzPrdacxr4KeXn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-14_10,2023-06-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 lowpriorityscore=0 spamscore=0
 phishscore=0 priorityscore=1501 adultscore=0 suspectscore=0 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306140125
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
index 19b3283..5d146ec 100644
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
+		WARN_ON_ONCE(1);
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
+	 * Set an initial average bandwidth corresponding to GEN1x1
+	 * for the pcie to mem path.
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
 
@@ -572,6 +644,7 @@ static irqreturn_t qcom_pcie_ep_global_irq_thread(int irq, void *data)
 	} else if (FIELD_GET(PARF_INT_ALL_BME, status)) {
 		dev_dbg(dev, "Received BME event. Link is enabled!\n");
 		pcie_ep->link_status = QCOM_PCIE_EP_LINK_ENABLED;
+		qcom_pcie_ep_icc_update(pcie_ep);
 	} else if (FIELD_GET(PARF_INT_ALL_PM_TURNOFF, status)) {
 		dev_dbg(dev, "Received PM Turn-off event! Entering L23\n");
 		val = readl_relaxed(pcie_ep->parf + PARF_PM_CTRL);
-- 
2.7.4

