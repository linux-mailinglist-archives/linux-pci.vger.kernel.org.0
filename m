Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD43568B82
	for <lists+linux-pci@lfdr.de>; Wed,  6 Jul 2022 16:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233414AbiGFOlg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Jul 2022 10:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233413AbiGFOlg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Jul 2022 10:41:36 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D705237D3;
        Wed,  6 Jul 2022 07:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657118495; x=1688654495;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=Hr9yV/i11+naZBUagnWE5HaqO+SDNFfP01uIpud54bQ=;
  b=QeontSuISPdiGgRlQ57Pj+KlhZvaz4o+qoWNYD+a6cT8rixGBIAUtvGS
   DCJqteOCeKTGQGPb1+jRHCI+m6yZ4M9zK1chjQ71J93SAi3gHoMdDK3tP
   tcRQsuE+PCm//HzVgGvYw9S1mrfI2taetk/hT4iY/q4QxQxpWR3q+pfwB
   8=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 06 Jul 2022 07:41:35 -0700
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 06 Jul 2022 07:40:49 -0700
X-QCInternal: smtphost
Received: from hu-krichai-hyd.qualcomm.com (HELO hu-sgudaval-hyd.qualcomm.com) ([10.213.110.37])
  by ironmsg02-blr.qualcomm.com with ESMTP; 06 Jul 2022 20:10:27 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 4058933)
        id D6C9642A4; Wed,  6 Jul 2022 20:10:26 +0530 (+0530)
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
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH v4 2/2] PCI: qcom: Restrict pci transactions after pci suspend
Date:   Wed,  6 Jul 2022 20:10:25 +0530
Message-Id: <1657118425-10304-3-git-send-email-quic_krichai@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1657118425-10304-1-git-send-email-quic_krichai@quicinc.com>
References: <1656684800-31278-1-git-send-email-quic_krichai@quicinc.com>
 <1657118425-10304-1-git-send-email-quic_krichai@quicinc.com>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
index 2fa86f3..2a46b40 100644
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
index 0a9d1ee..78bc463 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1342,11 +1342,41 @@ static int qcom_pcie_suspend_2_7_0(struct qcom_pcie *pcie)
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
 
@@ -1590,6 +1620,8 @@ static const struct qcom_pcie_cfg sc7280_cfg = {
 static const struct dw_pcie_ops dw_pcie_ops = {
 	.link_up = qcom_pcie_link_up,
 	.start_link = qcom_pcie_start_link,
+	.read_dbi = qcom_pcie_read_dbi,
+	.write_dbi = qcom_pcie_write_dbi,
 };
 
 static int qcom_pcie_probe(struct platform_device *pdev)
-- 
2.7.4

