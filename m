Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9670751975
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jul 2023 09:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234188AbjGMHKr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jul 2023 03:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234170AbjGMHKi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Jul 2023 03:10:38 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 968B11BF0;
        Thu, 13 Jul 2023 00:10:37 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36D73e6M031273;
        Thu, 13 Jul 2023 07:10:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=ek5WLwSvjXSVCr9SmWwANF2/cFWSzE8fMO2GvxyqURo=;
 b=nau+A1pPSZ4FItATw3m1bTXvQXybs+eQ64jluOXVcmCDv35IBVNKuXRRrtTsKXNlz0AB
 0zpkNr9Zvl6+q5RkMXFjl0DbAwMn4HuNlB9Q8M4vNHviY5cQSpeW5FJR5XLsNFKUfJFA
 TVxZ3Odrs5I5hAjPt6XVbTyBzaHh34lxjfZr1ZZgM093cnYJmk83gUmV4aFRGhTBxyeV
 kRbZg105JK5+e7Ky80l3LGPL5+26BQ0dBOVg/zB9o8uXa+038V0ri4Zyy7NB0w0TbmVy
 tXHgc8WPMRm9c6zTDzOjJMCAg14ZQhGLHZvdiwn4aAjGflckbXQYIYc53wf1x9cdo8ay 3g== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rt3qfguw7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jul 2023 07:10:30 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 36D7AMpi030167;
        Thu, 13 Jul 2023 07:10:27 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3rq0vkymj8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 13 Jul 2023 07:10:27 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36D7AM65030152;
        Thu, 13 Jul 2023 07:10:27 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-krichai-hyd.qualcomm.com [10.213.110.112])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 36D7AQh8030218;
        Thu, 13 Jul 2023 07:10:27 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 4058933)
        id 4A38047AD; Thu, 13 Jul 2023 12:40:26 +0530 (+0530)
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
Subject: [PATCH v4 7/9] PCI: qcom-ep: Add wake up host op to dw_pcie_ep_ops
Date:   Thu, 13 Jul 2023 12:40:16 +0530
Message-Id: <1689232218-28265-8-git-send-email-quic_krichai@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1689232218-28265-1-git-send-email-quic_krichai@quicinc.com>
References: <1689232218-28265-1-git-send-email-quic_krichai@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: RyRawv_cGTgpQvoGveRdG9e9tsZogUI7
X-Proofpoint-GUID: RyRawv_cGTgpQvoGveRdG9e9tsZogUI7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-13_04,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 mlxscore=0 suspectscore=0 adultscore=0 priorityscore=1501 mlxlogscore=999
 phishscore=0 malwarescore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307130061
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add wakeup host op to dw_pcie_ep_ops to wake up host.
If the wakeup type is PME, then trigger inband PME by writing to the PARF
PARF_PM_CTRL register, otherwise toggle #WAKE.

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 75ab6d6..6472554 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -89,6 +89,7 @@
 /* PARF_PM_CTRL register fields */
 #define PARF_PM_CTRL_REQ_EXIT_L1		BIT(1)
 #define PARF_PM_CTRL_READY_ENTR_L23		BIT(2)
+#define PARF_PM_CTRL_XMT_PME			BIT(4)
 #define PARF_PM_CTRL_REQ_NOT_ENTR_L1		BIT(5)
 
 /* PARF_MHI_CLOCK_RESET_CTRL fields */
@@ -729,10 +730,37 @@ static void qcom_pcie_ep_init(struct dw_pcie_ep *ep)
 		dw_pcie_ep_reset_bar(pci, bar);
 }
 
+static bool qcom_pcie_ep_wakeup_host(struct dw_pcie_ep *ep, u8 func_no,
+					enum pci_epc_wakeup_host_type type)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+	struct qcom_pcie_ep *pcie_ep = to_pcie_ep(pci);
+	struct device *dev = pci->dev;
+	u32 val;
+
+	if (type == PCI_WAKEUP_TOGGLE_WAKE) {
+		dev_dbg(dev, "Waking up the host by toggling WAKE#\n");
+		gpiod_set_value_cansleep(pcie_ep->wake, 1);
+		usleep_range(WAKE_DELAY_US, WAKE_DELAY_US + 500);
+		gpiod_set_value_cansleep(pcie_ep->wake, 0);
+
+	} else if (type == PCI_WAKEUP_SEND_PME) {
+		dev_dbg(dev, "Waking up the host using PME\n");
+		val = readl_relaxed(pcie_ep->parf + PARF_PM_CTRL);
+		writel_relaxed(val | PARF_PM_CTRL_XMT_PME, pcie_ep->parf + PARF_PM_CTRL);
+		writel_relaxed(val, pcie_ep->parf + PARF_PM_CTRL);
+
+	} else
+		return false;
+
+	return true;
+}
+
 static const struct dw_pcie_ep_ops pci_ep_ops = {
 	.ep_init = qcom_pcie_ep_init,
 	.raise_irq = qcom_pcie_ep_raise_irq,
 	.get_features = qcom_pcie_epc_get_features,
+	.wakeup_host = qcom_pcie_ep_wakeup_host,
 };
 
 static int qcom_pcie_ep_probe(struct platform_device *pdev)
-- 
2.7.4

