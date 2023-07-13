Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB55751978
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jul 2023 09:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234182AbjGMHKu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jul 2023 03:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234176AbjGMHKk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Jul 2023 03:10:40 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D9231FEA;
        Thu, 13 Jul 2023 00:10:38 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36D5Be6m025642;
        Thu, 13 Jul 2023 07:10:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=Th449/IbmKpfLvLcCpwNm4V2rmIZbJUdLkYDeQXFsjM=;
 b=a2ic52s5NMRkBRKnBZYgkAIcMe6cEFTISrex7eiaMjOKt0iFJ1aVQ+Gb622VkE0viavl
 MO6jWqlxJ/Dz4cV+bnSi65SaRK9QPAT5DJA9ACPkUA/R2Ygo+U2vqxQoUUCnMfVH+dhL
 a115/5PUryaFmqznue0h4PWIkxS402CbpvBcPDRFx5oZk76yHPLmlEA/qJd/fUsZXWhI
 mmpwqfqo0H3Wp6GViZN0eJ73jEhsGpZv7Xd/hdn/HjY3/nhQVVH6eFQGBE7Ce/Plr9j5
 KIoL8OQwuMrTmOPaEjLBprQehSQQ3PMUQyZe+otWKGKzHYgz4ofngkxL1rOX0YRoyTo6 Sg== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rt73tghm7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jul 2023 07:10:30 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 36D7AQgp030209;
        Thu, 13 Jul 2023 07:10:26 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3rq0vkymhs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 13 Jul 2023 07:10:26 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36D7AQEA030201;
        Thu, 13 Jul 2023 07:10:26 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-krichai-hyd.qualcomm.com [10.213.110.112])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 36D7APwO030195;
        Thu, 13 Jul 2023 07:10:26 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 4058933)
        id 77E0947B2; Thu, 13 Jul 2023 12:40:25 +0530 (+0530)
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
Subject: [PATCH v4 4/9] PCI: qcom-ep: Update the D-state log
Date:   Thu, 13 Jul 2023 12:40:13 +0530
Message-Id: <1689232218-28265-5-git-send-email-quic_krichai@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1689232218-28265-1-git-send-email-quic_krichai@quicinc.com>
References: <1689232218-28265-1-git-send-email-quic_krichai@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: jaMr-kkjVLGtxq2RWqS_59YJ3XJ-kzm6
X-Proofpoint-GUID: jaMr-kkjVLGtxq2RWqS_59YJ3XJ-kzm6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-13_04,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 phishscore=0 malwarescore=0 priorityscore=1501 mlxlogscore=882
 suspectscore=0 adultscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

Updated the D-state log which prints in D-state in string format.

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 66fd421..75ab6d6 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -583,7 +583,6 @@ static irqreturn_t qcom_pcie_ep_global_irq_thread(int irq, void *data)
 	} else if (FIELD_GET(PARF_INT_ALL_DSTATE_CHANGE, status)) {
 		dstate = dw_pcie_readl_dbi(pci, DBI_CON_STATUS) &
 					   DBI_CON_STATUS_POWER_STATE_MASK;
-		dev_dbg(dev, "Received D%d state event\n", dstate);
 		state = dstate;
 		if (dstate == 3) {
 			val = readl_relaxed(pcie_ep->parf + PARF_PM_CTRL);
@@ -593,6 +592,7 @@ static irqreturn_t qcom_pcie_ep_global_irq_thread(int irq, void *data)
 			if (gpiod_get_value(pcie_ep->reset))
 				state = PCI_D3cold;
 		}
+		dev_dbg(dev, "Received D-state:%s event\n", pci_power_name(state));
 		pci_epc_dstate_notify(pci->ep.epc, state);
 	} else if (FIELD_GET(PARF_INT_ALL_LINK_UP, status)) {
 		dev_dbg(dev, "Received Linkup event. Enumeration complete!\n");
-- 
2.7.4

