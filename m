Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09573588B37
	for <lists+linux-pci@lfdr.de>; Wed,  3 Aug 2022 13:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237433AbiHCL3d (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Aug 2022 07:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236427AbiHCL3V (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Aug 2022 07:29:21 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F903DF0B;
        Wed,  3 Aug 2022 04:29:19 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 273B06pJ032051;
        Wed, 3 Aug 2022 11:29:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=cM9js6ta2w5+ckztW+938s3rdW0FxLPPx34fOkjCQwk=;
 b=UapNWfXVeDIhgyufQ9pTh0gkLXcXKQJH2VCRMp0wWnYa3vNOR4F+wjtE867op2qwwQos
 5ez4oPpQy5mLJy48/zI9u1WskEp7rJaSMX+TxqJQ06pzdXZUSN2TxdKgs6lmfSwUxoCk
 oUEOCzG9nvxO84b4yMv13EMAq48+ZOBhngRSs2CvViqOOmSFSCj6cqg9xffnQEInJ2NH
 /06Ef0NmzAx2zitpVJJWUNhvZ624mXMjvM9b/kNa34UVDRqhNU4EIy+4rS7RizV20MiD
 9bLe0yVhOO5Te3Hr611jJGwZyDEqFTWGJUBzdqXPLe4qNqr2XGKC3KX1jSyIhCFtkc2v 7w== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3hq5q329a6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 Aug 2022 11:29:03 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 273BSwwp023588;
        Wed, 3 Aug 2022 11:28:58 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3hmwqkd7da-1;
        Wed, 03 Aug 2022 11:28:58 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 273BSwCr023566;
        Wed, 3 Aug 2022 11:28:58 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-krichai-hyd.qualcomm.com [10.213.110.37])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 273BSwSj023561;
        Wed, 03 Aug 2022 11:28:58 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 4058933)
        id DFEE941C7; Wed,  3 Aug 2022 16:58:57 +0530 (+0530)
From:   Krishna chaitanya chundru <quic_krichai@quicinc.com>
To:     helgaas@kernel.org
Cc:     linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mka@chromium.org,
        quic_vbadigan@quicinc.com, quic_hemantk@quicinc.com,
        quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
        quic_ramkri@quicinc.com, manivannan.sadhasivam@linaro.org,
        swboyd@chromium.org, dmitry.baryshkov@linaro.org,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>
Subject: [PATCH v5 2/3] PCI: qcom: Restrict pci transactions after pci suspend
Date:   Wed,  3 Aug 2022 16:58:53 +0530
Message-Id: <1659526134-22978-3-git-send-email-quic_krichai@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1659526134-22978-1-git-send-email-quic_krichai@quicinc.com>
References: <1659526134-22978-1-git-send-email-quic_krichai@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ctF_dPLIGYVMEhTuBs7oyUefvqRcLNn9
X-Proofpoint-ORIG-GUID: ctF_dPLIGYVMEhTuBs7oyUefvqRcLNn9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-03_03,2022-08-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 spamscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=999 phishscore=0 adultscore=0 clxscore=1011
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208030050
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

If the endpoint device state is D0 and irq's are not freed, then
kernel try to mask interrupts in system suspend path by writing
in to the vector table (for MSIX interrupts) and config space (for MSI's).

These transactions are initiated in the pm suspend after pcie clocks got
disabled as part of platform driver pm  suspend call. Due to it, these
transactions are resulting in un-clocked access and eventually to crashes.

So added a logic in qcom driver to restrict these unclocked access.
And updated the logic to check the link state before masking
or unmasking the interrupts.

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 14 +++++++--
 drivers/pci/controller/dwc/pcie-qcom.c            | 36 +++++++++++++++++++++--
 2 files changed, 46 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 9979302..2b1e395 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -29,13 +29,23 @@ static void dw_msi_ack_irq(struct irq_data *d)
 
 static void dw_msi_mask_irq(struct irq_data *d)
 {
-	pci_msi_mask_irq(d);
+	struct pcie_port *pp = irq_data_get_irq_chip_data(d->parent_data);
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+
+	if (dw_pcie_link_up(pci))
+		pci_msi_mask_irq(d);
+
 	irq_chip_mask_parent(d);
 }
 
 static void dw_msi_unmask_irq(struct irq_data *d)
 {
-	pci_msi_unmask_irq(d);
+	struct pcie_port *pp = irq_data_get_irq_chip_data(d->parent_data);
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+
+	if (dw_pcie_link_up(pci))
+		pci_msi_unmask_irq(d);
+
 	irq_chip_unmask_parent(d);
 }
 
diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 9dd50fc0..f7dd5dc 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1433,11 +1433,41 @@ static int qcom_pcie_post_init_2_9_0(struct qcom_pcie *pcie)
 	return 0;
 }
 
+static u32 qcom_pcie_read_dbi(struct dw_pcie *pci, void __iomem *base,
+				u32 reg, size_t size)
+{
+	struct qcom_pcie *pcie = to_qcom_pcie(pci);
+	u32 val;
+
+	if (pcie->is_suspended)
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+
+	dw_pcie_read(base + reg, size, &val);
+	return val;
+}
+
+static void qcom_pcie_write_dbi(struct dw_pcie *pci, void __iomem *base,
+				u32 reg, size_t size, u32 val)
+{
+	struct qcom_pcie *pcie = to_qcom_pcie(pci);
+
+	if (pcie->is_suspended)
+		return;
+
+	dw_pcie_write(base + reg, size, val);
+}
+
 static int qcom_pcie_link_up(struct dw_pcie *pci)
 {
-	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
-	u16 val = readw(pci->dbi_base + offset + PCI_EXP_LNKSTA);
+	struct qcom_pcie *pcie = to_qcom_pcie(pci);
+	u16 offset;
+	u16 val;
+
+	if (pcie->is_suspended)
+		return false;
 
+	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	val = readw(pci->dbi_base + offset + PCI_EXP_LNKSTA);
 	return !!(val & PCI_EXP_LNKSTA_DLLLA);
 }
 
@@ -1702,6 +1732,8 @@ static const struct qcom_pcie_cfg ipq6018_cfg = {
 static const struct dw_pcie_ops dw_pcie_ops = {
 	.link_up = qcom_pcie_link_up,
 	.start_link = qcom_pcie_start_link,
+	.read_dbi = qcom_pcie_read_dbi,
+	.write_dbi = qcom_pcie_write_dbi,
 };
 
 static int qcom_pcie_probe(struct platform_device *pdev)
-- 
2.7.4

