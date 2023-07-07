Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1484474AF58
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jul 2023 13:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjGGLEU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Jul 2023 07:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjGGLEQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Jul 2023 07:04:16 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B9EAFF;
        Fri,  7 Jul 2023 04:04:15 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3679Km2i006277;
        Fri, 7 Jul 2023 11:04:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=ek5WLwSvjXSVCr9SmWwANF2/cFWSzE8fMO2GvxyqURo=;
 b=NGxxKT9OD8DhF7AoY5U+L4Kx4jbTB87mD7kCugiOCpr+BGdi7qN/GabPc79HVadM2Clh
 NcDQ1JmxL1url08mlHhRJnJDAreAN+8jzUcnRNLQSEA31iJ0Af8Qjf7CcD9IKTdqgYtX
 BmcvdZLyfUWqLqdUnsGMG18le0neRDuu7WEUmuxNXP3ycY/jYohwpEQ1BN7+ENajy5G4
 j5nDkJXUZjBnmTWM+8uS4nAMvdp2QGei71+KI67PQLNwLMMd8dxIKTlzE96b4sr6IcGm
 M8CAw8D5n6E4VBTjhjs7kC7vs/itQvRIw9Jm94vp/FpK7gA32u412VcNkJ3+sW/RoHwG KQ== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rpfyw8cm0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Jul 2023 11:04:06 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 367B40bk022751;
        Fri, 7 Jul 2023 11:04:03 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3rjd7kq59b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 07 Jul 2023 11:04:03 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 367B4203022792;
        Fri, 7 Jul 2023 11:04:02 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-krichai-hyd.qualcomm.com [10.213.110.112])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 367B42HV022786;
        Fri, 07 Jul 2023 11:04:02 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 4058933)
        id 39FCE473F; Fri,  7 Jul 2023 16:34:02 +0530 (+0530)
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
Subject: [PATCH v3 7/9] PCI: qcom-ep: Add wake up host op to dw_pcie_ep_ops
Date:   Fri,  7 Jul 2023 16:33:54 +0530
Message-Id: <1688727836-11141-8-git-send-email-quic_krichai@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1688727836-11141-1-git-send-email-quic_krichai@quicinc.com>
References: <1688727836-11141-1-git-send-email-quic_krichai@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: xnFJSSuiJjVawiArsz3v82GIRTFT8plF
X-Proofpoint-ORIG-GUID: xnFJSSuiJjVawiArsz3v82GIRTFT8plF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-07_07,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 adultscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 clxscore=1015 mlxlogscore=999
 impostorscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2307070102
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
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

