Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 621C37439E4
	for <lists+linux-pci@lfdr.de>; Fri, 30 Jun 2023 12:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232382AbjF3Kwb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Jun 2023 06:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232267AbjF3Kw2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Jun 2023 06:52:28 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7F8E2D56;
        Fri, 30 Jun 2023 03:52:25 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35U8b8Fl032143;
        Fri, 30 Jun 2023 10:52:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=fnIhTCp+MlvMAwkxciT/Qbgxin4Zzhi8x3rzJuJvxXg=;
 b=ZOtVHruumekKQmxP0dR/i64+a6CL1wUvyFmuK/WIVLdJ3tviGFvtEqDFxyyPOkAzS+DQ
 ntQ/fnUh/zixKRb2L6rKSxrqlMq685ipJ4MH5Kes1q602LDyxxCVxZruM/Ll5OmYXasI
 o4grDS6L//+iOLMypFXWcuc+3Cc/wUFd7Q6jYZ8LMM2hVse77691OJ/z0lEUG1LO9Oi8
 tFfetbO3onsMnqw1RhRe1mJLNTDJwUhPT0nBqjuQhJxpBm+bImyDeJ5Sgrt/TJaBFEfv
 UuovxC0hdNl2gBNSS3h1Yew0CdDC03LbPhIi5QIuA55ZmGlhLGkLb4QxCpZ49Q6ZVcZG EA== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rh7s2tsee-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Jun 2023 10:52:17 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 35UAqDK0004625;
        Fri, 30 Jun 2023 10:52:13 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3rdsjkpf1x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 30 Jun 2023 10:52:13 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35UAqDA1004618;
        Fri, 30 Jun 2023 10:52:13 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-krichai-hyd.qualcomm.com [10.213.110.112])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 35UAqCND004609;
        Fri, 30 Jun 2023 10:52:13 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 4058933)
        id 9582E4AC3; Fri, 30 Jun 2023 16:22:12 +0530 (+0530)
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
Subject: [PATCH v2 2/8] PCI: qcom-ep: Add support for D-state change notification
Date:   Fri, 30 Jun 2023 16:22:05 +0530
Message-Id: <1688122331-25478-3-git-send-email-quic_krichai@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1688122331-25478-1-git-send-email-quic_krichai@quicinc.com>
References: <1688122331-25478-1-git-send-email-quic_krichai@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: csYUlFRARr1i_fKnLHIs8lTJRR9WcS2A
X-Proofpoint-ORIG-GUID: csYUlFRARr1i_fKnLHIs8lTJRR9WcS2A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-30_05,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=924 impostorscore=0
 mlxscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306300092
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support to pass D-state change notification to Endpoint
function driver.

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 1435f51..e75aec4 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -561,6 +561,7 @@ static irqreturn_t qcom_pcie_ep_global_irq_thread(int irq, void *data)
 	struct device *dev = pci->dev;
 	u32 status = readl_relaxed(pcie_ep->parf + PARF_INT_ALL_STATUS);
 	u32 mask = readl_relaxed(pcie_ep->parf + PARF_INT_ALL_MASK);
+	pci_power_t state;
 	u32 dstate, val;
 
 	writel_relaxed(status, pcie_ep->parf + PARF_INT_ALL_CLEAR);
@@ -583,11 +584,16 @@ static irqreturn_t qcom_pcie_ep_global_irq_thread(int irq, void *data)
 		dstate = dw_pcie_readl_dbi(pci, DBI_CON_STATUS) &
 					   DBI_CON_STATUS_POWER_STATE_MASK;
 		dev_dbg(dev, "Received D%d state event\n", dstate);
+		state = dstate;
 		if (dstate == 3) {
 			val = readl_relaxed(pcie_ep->parf + PARF_PM_CTRL);
 			val |= PARF_PM_CTRL_REQ_EXIT_L1;
 			writel_relaxed(val, pcie_ep->parf + PARF_PM_CTRL);
+			state = PCI_D3hot;
+			if (gpiod_get_value(pcie_ep->reset))
+				state = PCI_D3cold;
 		}
+		pci_epc_dstate_change(pci->ep.epc, state);
 	} else if (FIELD_GET(PARF_INT_ALL_LINK_UP, status)) {
 		dev_dbg(dev, "Received Linkup event. Enumeration complete!\n");
 		dw_pcie_ep_linkup(&pci->ep);
-- 
2.7.4

