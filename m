Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB2D75196C
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jul 2023 09:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234147AbjGMHKh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jul 2023 03:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234149AbjGMHKd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Jul 2023 03:10:33 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C56C119;
        Thu, 13 Jul 2023 00:10:32 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36D5QCOs006157;
        Thu, 13 Jul 2023 07:10:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=T9H/joa8i3z+04yWseOBwYveNeLbratgjd+8XxajjYM=;
 b=k5mEecWLJZF2lgBJ5VXcRO3vOAJO5MXNQrzmecEfPGhir7iuRj+VjQtQwHxNYBBr6qZA
 2L1BQJFyK1vLAKg/alwmE+oGrTzKHJIrDuPlimY29o6iKJgDXH6VSkVzZyEahpM1vIBT
 zHSkKX7PEgwZ9QkBZzHec2CGDHqJSYKMgl+EkWO74Cx2upHtj4uKkNcSh+O3BMwur5/j
 DkxtgBEZvZMFwt73kQc5b3oq4Aiqe5m/7l8u191BE6+pOhMcZ6plxA1UHj6Cwsj9JsxH
 BC+8yG+cx0rO24QaV248EkXG56NlxZIy4A6MYiL9Fa5BQJ33G64I4zpUT8PDkX998H6g 5A== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rt3f00vsp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jul 2023 07:10:25 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 36D7AMpg030167;
        Thu, 13 Jul 2023 07:10:22 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3rq0vkymh3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 13 Jul 2023 07:10:22 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36D7AM99030157;
        Thu, 13 Jul 2023 07:10:22 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-krichai-hyd.qualcomm.com [10.213.110.112])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 36D7ALIm030149;
        Thu, 13 Jul 2023 07:10:22 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 4058933)
        id 6211047BB; Thu, 13 Jul 2023 12:40:21 +0530 (+0530)
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
Subject: [PATCH v4 2/9] PCI: qcom-ep: Add support for D-state change notification
Date:   Thu, 13 Jul 2023 12:40:11 +0530
Message-Id: <1689232218-28265-3-git-send-email-quic_krichai@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1689232218-28265-1-git-send-email-quic_krichai@quicinc.com>
References: <1689232218-28265-1-git-send-email-quic_krichai@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: HkmAFijEPS4aW-7xLYeo_r8C5bnpWiFN
X-Proofpoint-ORIG-GUID: HkmAFijEPS4aW-7xLYeo_r8C5bnpWiFN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-13_04,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 bulkscore=0
 phishscore=0 mlxscore=0 spamscore=0 adultscore=0 priorityscore=1501
 mlxlogscore=886 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307130061
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
index 0fe7f06..66fd421 100644
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
+		pci_epc_dstate_notify(pci->ep.epc, state);
 	} else if (FIELD_GET(PARF_INT_ALL_LINK_UP, status)) {
 		dev_dbg(dev, "Received Linkup event. Enumeration complete!\n");
 		dw_pcie_ep_linkup(&pci->ep);
-- 
2.7.4

