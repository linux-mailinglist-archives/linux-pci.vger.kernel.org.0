Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 129FC7236F2
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jun 2023 07:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbjFFFuA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Jun 2023 01:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbjFFFt7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Jun 2023 01:49:59 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77EDF9E;
        Mon,  5 Jun 2023 22:49:58 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3561Jvq2007753;
        Tue, 6 Jun 2023 05:49:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=aQ6KnwOt1mwRRlCCHY+UFOi0CAj60uT8JU+m6VHJT9I=;
 b=Xu44K9su7X2iH4DmyKH+Lu6InkbauADcpZSlksSjsLeD8/F936yL5xjM4SNchIaTiZW6
 9vhu8Ydx04eGWEAHw9/nUcKYQGtK4g7ro7jpvI4fpkFWPYhVym/I6dBtWFPJr2Rt8Av7
 vflwolp4VIsJXXmZtyMh5jnXAlbSa6JO0/AlVLhjgkNokIf6QZBzDSAoEmUpUvjsYWVT
 9w13oIkyxhRTngI4LymJ1rcRZRuwO6anaHdwR32ZvZhuSXECxjwGih2EcGzdmLDQDPw2
 Mj3u9B0PI3iMELW5ZIv22YOdzFYmrP9dUswHpHzbmPTY+gWMTF6QiEBJnxkc/xsena3J YA== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r1d4et5vx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Jun 2023 05:49:45 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3565nef8022823;
        Tue, 6 Jun 2023 05:49:40 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3qyxkka702-1;
        Tue, 06 Jun 2023 05:49:40 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3565neGi022817;
        Tue, 6 Jun 2023 05:49:40 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-krichai-hyd.qualcomm.com [10.213.110.112])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3565ndPT022816;
        Tue, 06 Jun 2023 05:49:40 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 4058933)
        id 2CD50376D; Tue,  6 Jun 2023 11:19:39 +0530 (+0530)
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
Subject: [PATCH] PCI: qcom-ep: Add ICC bandwidth voting support
Date:   Tue,  6 Jun 2023 11:19:29 +0530
Message-Id: <1686030570-5439-1-git-send-email-quic_krichai@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 1DPZgL_PPjqpcx1wvrIyr-YKE5TnYmq_
X-Proofpoint-GUID: 1DPZgL_PPjqpcx1wvrIyr-YKE5TnYmq_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-06_03,2023-06-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 clxscore=1011 priorityscore=1501 malwarescore=0 mlxscore=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 spamscore=0
 mlxlogscore=964 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2306060049
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support to vote for ICC bandwidth based up on the link
speed and width.

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 73 +++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 19b3283..79e7559 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -17,6 +17,7 @@
 #include <linux/phy/pcie.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/interconnect.h>
 #include <linux/pm_domain.h>
 #include <linux/regmap.h>
 #include <linux/reset.h>
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
+#define DBI_LINKCTRKSTATUS_SHIFT	16
+
 #define XMLH_LINK_UP				0x400
 #define CORE_RESET_TIME_US_MIN			1000
 #define CORE_RESET_TIME_US_MAX			1005
@@ -187,6 +192,8 @@ struct qcom_pcie_ep {
 	enum qcom_pcie_ep_link_status link_status;
 	int global_irq;
 	int perst_irq;
+
+	struct icc_path *icc;
 };
 
 static int qcom_pcie_ep_core_reset(struct qcom_pcie_ep *pcie_ep)
@@ -253,9 +260,56 @@ static void qcom_pcie_dw_stop_link(struct dw_pcie *pci)
 	disable_irq(pcie_ep->perst_irq);
 }
 
+static void qcom_pcie_icc_update(struct qcom_pcie_ep *pcie_ep)
+{
+	struct dw_pcie *pci = &pcie_ep->pci;
+	u32 val, bw;
+	int speed, width;
+	int ret;
+
+	if (!pcie_ep->icc)
+		return;
+
+	val = dw_pcie_readl_dbi(pci, DBI_LINKCTRLSTATUS);
+	val = val >> DBI_LINKCTRKSTATUS_SHIFT;
+
+	speed = FIELD_GET(PCI_EXP_LNKSTA_CLS, val);
+	width = FIELD_GET(PCI_EXP_LNKSTA_NLW, val);
+
+	/*
+	 * ICC needs avg bw in KBps.
+	 *
+	 * For example for 2Gbps the avg BW = 2x1000x1000x1000/8*1000 = 250000
+	 */
+	switch (speed) {
+	case 1:
+		bw = 250000;	/* avg bw for GEN1 per lane: 2Gbps, peak bw: no vote */
+		break;
+	case 2:
+		bw = 500000;	/* avg bw for GEN2 per lane: 4Gbps, peak bw no vote */
+		break;
+	case 3:
+		bw = 1000000;	/* avg bw for GEN3 per lane: 8Gbps, peak bw no vote */
+		break;
+	default:
+		WARN_ON_ONCE(1);
+		fallthrough;
+	case 4:
+		bw = 2000000;	/* avg bw for GEN4 per lane: 16Gbps, peak bw no vote */
+		break;
+	}
+
+	ret = icc_set_bw(pcie_ep->icc, width * bw, 0);
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
+	 * Set an initial average bandwidth corresponding to single-lane Gen 1
+	 * for the pcie to mem path.
+	 */
+	ret = icc_set_bw(pcie_ep->icc, 250000, 0); /* avg bw: 2Gbps, peak bw: no vote */
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
 
+	pcie_ep->icc = devm_of_icc_get(dev, "pci");
+	if (IS_ERR(pcie_ep->icc))
+		ret = PTR_ERR(pcie_ep->icc);
+
 	return ret;
 }
 
@@ -572,6 +644,7 @@ static irqreturn_t qcom_pcie_ep_global_irq_thread(int irq, void *data)
 	} else if (FIELD_GET(PARF_INT_ALL_BME, status)) {
 		dev_dbg(dev, "Received BME event. Link is enabled!\n");
 		pcie_ep->link_status = QCOM_PCIE_EP_LINK_ENABLED;
+		qcom_pcie_icc_update(pcie_ep);
 	} else if (FIELD_GET(PARF_INT_ALL_PM_TURNOFF, status)) {
 		dev_dbg(dev, "Received PM Turn-off event! Entering L23\n");
 		val = readl_relaxed(pcie_ep->parf + PARF_PM_CTRL);
-- 
2.7.4

