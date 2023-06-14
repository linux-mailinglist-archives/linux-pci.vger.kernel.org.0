Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 433CD7302A9
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jun 2023 17:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245689AbjFNPCJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Jun 2023 11:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245677AbjFNPBu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Jun 2023 11:01:50 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F231BF3;
        Wed, 14 Jun 2023 08:01:38 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35EDLwaD024205;
        Wed, 14 Jun 2023 15:01:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=2+pO9+6YtfcoOB3pvUjrJKOPEF2iL6mRrIG/MmOjYfQ=;
 b=QiExWRnuef3M3Qiy4Uw2IS4ZMRNfXwS1s/PDAg4bbF9fkUdVfkQTlf03x2x0X0y5KXDM
 nMzEHG15mP8UEMgxRGUsn6iyJt90NYxlsH0T1tsSXlYQLHxViN7WmfnHi3oz4NyppINl
 rlYjHV84IPn//c8sNkUIVfsCX39akisyqHMP0jUTKYgkbgcmeDPurAfLJGaNLDOBwALx
 Rj+rws8ECq7FwIYB0Ir3OqiwdeQDSu4s36gFa817Kbi9dXWHKKGfuHEosRytNvXqdFuP
 6cak4mMV+eNVhD7iQLxaINxgmuQ/erVE3wjK8++tCu55qUdnlzu274nqO8ezwvv2+SZZ DA== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r7ebt88dm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Jun 2023 15:01:29 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 35EF0uj5018430;
        Wed, 14 Jun 2023 15:01:08 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3r7271jayd-1;
        Wed, 14 Jun 2023 15:01:08 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35EF18u6018612;
        Wed, 14 Jun 2023 15:01:08 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-krichai-hyd.qualcomm.com [10.213.110.112])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 35EF17rk018604;
        Wed, 14 Jun 2023 15:01:07 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 4058933)
        id 5A2C94A52; Wed, 14 Jun 2023 20:31:07 +0530 (+0530)
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
Subject: [PATCH RFC v1 3/3] PCI: qcom: ep: Add wake up host op to dw_pcie_ep_ops
Date:   Wed, 14 Jun 2023 20:30:49 +0530
Message-Id: <1686754850-29817-4-git-send-email-quic_krichai@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1686754850-29817-1-git-send-email-quic_krichai@quicinc.com>
References: <1686754850-29817-1-git-send-email-quic_krichai@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: DF2tjYUK1wc1SFb7tN9kE64j0b7Scacq
X-Proofpoint-ORIG-GUID: DF2tjYUK1wc1SFb7tN9kE64j0b7Scacq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-14_10,2023-06-14_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 mlxscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0 mlxlogscore=948
 phishscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2306140131
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add wakeup host op to dw_pcie_ep_ops to wake up host from D3cold
or D3hot.

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 34 +++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 5d146ec..916a138 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -91,6 +91,7 @@
 /* PARF_PM_CTRL register fields */
 #define PARF_PM_CTRL_REQ_EXIT_L1		BIT(1)
 #define PARF_PM_CTRL_READY_ENTR_L23		BIT(2)
+#define PARF_PM_CTRL_XMT_PME			BIT(4)
 #define PARF_PM_CTRL_REQ_NOT_ENTR_L1		BIT(5)
 
 /* PARF_MHI_CLOCK_RESET_CTRL fields */
@@ -794,10 +795,43 @@ static void qcom_pcie_ep_init(struct dw_pcie_ep *ep)
 		dw_pcie_ep_reset_bar(pci, bar);
 }
 
+static int qcom_pcie_ep_wakeup_host(struct dw_pcie_ep *ep, u8 func_no)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+	struct qcom_pcie_ep *pcie_ep = to_pcie_ep(pci);
+	struct device *dev = pci->dev;
+	u32 perst, dstate, val;
+
+	perst = gpiod_get_value(pcie_ep->reset);
+	/* Toggle wake GPIO when device is in D3 cold */
+	if (perst) {
+		dev_info(dev, "Device is in D3 cold toggling wake\n");
+		gpiod_set_value_cansleep(pcie_ep->wake, 1);
+		usleep_range(WAKE_DELAY_US, WAKE_DELAY_US + 500);
+		gpiod_set_value_cansleep(pcie_ep->wake, 0);
+		return 0;
+	}
+
+	dstate = dw_pcie_readl_dbi(pci, DBI_CON_STATUS) &
+				   DBI_CON_STATUS_POWER_STATE_MASK;
+	if (dstate == 3) {
+		dev_info(dev, "Device is in D3 hot sending inband PME\n");
+		val = readl_relaxed(pcie_ep->parf + PARF_PM_CTRL);
+		val |= PARF_PM_CTRL_XMT_PME;
+		writel_relaxed(val, pcie_ep->parf + PARF_PM_CTRL);
+	} else {
+		dev_err(dev, "Device is not in D3 state wakeup is not supported\n");
+		return -EPERM;
+	}
+
+	return 0;
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

