Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D49C76C3BB
	for <lists+linux-pci@lfdr.de>; Wed,  2 Aug 2023 05:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbjHBDvf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Aug 2023 23:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231862AbjHBDvd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Aug 2023 23:51:33 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C691BC1;
        Tue,  1 Aug 2023 20:51:33 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3722GsF1022850;
        Wed, 2 Aug 2023 03:51:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=TaeRWReqvlw5oeq0VnEnbW0TbAf8oYK+e4Krcr1lFc4=;
 b=FrxcZiFH1/H918xnWlbr0LCCUvi6pWVd+6i64Fhc7qsJlz1iBqk6ioH8eDgB+S+q9K6Q
 3ZDp6aaPkwzv1lzhQ/mEME8iVCpWMUhdVOMpQywcU7Nq8yoMMy8YoVeWjbSwfkkhDQ88
 CwUF+dRZ5kIKaA/74O6toqSWE9jp5ry112uMfnTvcF+3oqlwXyehyfRJWNbWuNlA6M6R
 PRjUtuCe3xVzDcOcFqM2MBRsS4VUCzGgtkjVt+aX2314wjVR+pulbyuU2Hb0tpOBSOIx
 TcFbXU6wLfHS74NowBZgSC/3KifPzpLKovokqHJ9/Qm0mJw00rBLhMy0y1W0rlOCseeE /Q== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s7bw9gb2x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Aug 2023 03:51:27 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3723pOnO022483;
        Wed, 2 Aug 2023 03:51:24 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3s4uukryxm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 02 Aug 2023 03:51:24 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3723pOXv022469;
        Wed, 2 Aug 2023 03:51:24 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-krichai-hyd.qualcomm.com [10.213.110.112])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3723pOTv022457;
        Wed, 02 Aug 2023 03:51:24 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 4058933)
        id 757A64B62; Wed,  2 Aug 2023 09:21:23 +0530 (+0530)
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
Subject: [PATCH v5 3/4] PCI: qcom-ep: Update the D-state log
Date:   Wed,  2 Aug 2023 09:21:20 +0530
Message-Id: <1690948281-2143-4-git-send-email-quic_krichai@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1690948281-2143-1-git-send-email-quic_krichai@quicinc.com>
References: <1690948281-2143-1-git-send-email-quic_krichai@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: G_I9p1_7jruPRs3eSB6QCm5MIBm_rYJM
X-Proofpoint-GUID: G_I9p1_7jruPRs3eSB6QCm5MIBm_rYJM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-01_22,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 adultscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 spamscore=0 mlxscore=0 mlxlogscore=692 phishscore=0 lowpriorityscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308020033
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Now that the state event is stored as pci_power_t, let's use the PCI helper
pci_power_name() to print the state event.

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 22545ff..0c69a61 100644
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
@@ -594,6 +593,7 @@ static irqreturn_t qcom_pcie_ep_global_irq_thread(int irq, void *data)
 			if (gpiod_get_value(pcie_ep->reset))
 				state = PCI_D3cold;
 		}
+		dev_dbg(dev, "Received %s event\n", pci_power_name(state));
 		pci_epc_dstate_notify(pci->ep.epc, state);
 	} else if (FIELD_GET(PARF_INT_ALL_LINK_UP, status)) {
 		dev_dbg(dev, "Received Linkup event. Enumeration complete!\n");
-- 
2.7.4

