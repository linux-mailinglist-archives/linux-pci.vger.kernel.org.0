Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7120776C466
	for <lists+linux-pci@lfdr.de>; Wed,  2 Aug 2023 06:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232022AbjHBE7k (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Aug 2023 00:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbjHBE7j (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Aug 2023 00:59:39 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 374E92115;
        Tue,  1 Aug 2023 21:59:38 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3724irk7013405;
        Wed, 2 Aug 2023 04:59:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=6dLVofm3MrdWxVB+SKr9lu6ig6LUfi0eY8p7fIS5qxg=;
 b=PSJEQG9SwCdRb0nxtTC8wKac24vhrNdWgq8yCaCqixnv9NsCwIMBBxT6XEATRhmPL/ZY
 11mv92/KtldPgJfyFPXs0VCVJBpjcqkZFHuIJUEDUwI/z8A8h08azZDnd9GVrQhHnjDX
 JfHFI0IUYkuafM1aSfqpmoTGdLC537jofNLx1eeF65OyD0nhiDTI87Ab030HQbVSneei
 OGfen3WDqLU9njl7n5Tmrh9JlzjaNMlTImyNCtmqMPI7N8eRVQbmGkyazWdqvAsmGjy2
 kMzMtrq88xQFHemvD+OFKqm+594OhDc6rS+wsj9sUhbFl67SUZ2yEII7IAkOF9Z3yZ60 9w== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s7gc081a7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Aug 2023 04:59:31 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3724xRPx022308;
        Wed, 2 Aug 2023 04:59:27 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3s4uukd91x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 02 Aug 2023 04:59:27 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3724xRoS022297;
        Wed, 2 Aug 2023 04:59:27 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-krichai-hyd.qualcomm.com [10.213.110.112])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3724xQrn022281;
        Wed, 02 Aug 2023 04:59:27 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 4058933)
        id 16BEA4B62; Wed,  2 Aug 2023 10:29:26 +0530 (+0530)
From:   Krishna chaitanya chundru <quic_krichai@quicinc.com>
To:     manivannan.sadhasivam@linaro.org
Cc:     helgaas@kernel.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_nitegupt@quicinc.com,
        quic_skananth@quicinc.com, quic_ramkri@quicinc.com,
        quic_parass@quicinc.com, krzysztof.kozlowski@linaro.org,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v5 3/5] PCI: qcom-ep: Add wake up host op to dw_pcie_ep_ops
Date:   Wed,  2 Aug 2023 10:29:17 +0530
Message-Id: <1690952359-8625-4-git-send-email-quic_krichai@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1690952359-8625-1-git-send-email-quic_krichai@quicinc.com>
References: <1690952359-8625-1-git-send-email-quic_krichai@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: PVDHyEEx2ur7t7tltrCFEB8-w0ZwfE6o
X-Proofpoint-GUID: PVDHyEEx2ur7t7tltrCFEB8-w0ZwfE6o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-02_03,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 mlxscore=0 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308020044
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
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
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 0c69a61..e78a74a1 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -89,6 +89,7 @@
 /* PARF_PM_CTRL register fields */
 #define PARF_PM_CTRL_REQ_EXIT_L1		BIT(1)
 #define PARF_PM_CTRL_READY_ENTR_L23		BIT(2)
+#define PARF_PM_CTRL_XMT_PME			BIT(4)
 #define PARF_PM_CTRL_REQ_NOT_ENTR_L1		BIT(5)
 
 /* PARF_MHI_CLOCK_RESET_CTRL fields */
@@ -730,10 +731,35 @@ static void qcom_pcie_ep_init(struct dw_pcie_ep *ep)
 		dw_pcie_ep_reset_bar(pci, bar);
 }
 
+static bool qcom_pcie_ep_wakeup_host(struct dw_pcie_ep *ep, u8 func_no, bool send_pme)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+	struct qcom_pcie_ep *pcie_ep = to_pcie_ep(pci);
+	struct device *dev = pci->dev;
+	u32 val;
+
+	if (send_pme) {
+		dev_dbg(dev, "Waking up the host using PME\n");
+		val = readl_relaxed(pcie_ep->parf + PARF_PM_CTRL);
+		writel_relaxed(val | PARF_PM_CTRL_XMT_PME, pcie_ep->parf + PARF_PM_CTRL);
+		writel_relaxed(val, pcie_ep->parf + PARF_PM_CTRL);
+
+	} else {
+		dev_dbg(dev, "Waking up the host by toggling WAKE#\n");
+		gpiod_set_value_cansleep(pcie_ep->wake, 1);
+		usleep_range(WAKE_DELAY_US, WAKE_DELAY_US + 500);
+		gpiod_set_value_cansleep(pcie_ep->wake, 0);
+
+	}
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

