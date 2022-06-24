Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBA3A559434
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jun 2022 09:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbiFXH2a (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Jun 2022 03:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbiFXH23 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Jun 2022 03:28:29 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E8527FCE;
        Fri, 24 Jun 2022 00:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1656055708; x=1687591708;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=8jsU1rwYjx0ZdhewYCgxwzh1sgTDUCTIf+ExHA3Cyg0=;
  b=Y+UB+f/dGJ8cTYNdJWE+5HcJqR25k9qzFRCSQ8FrH4PAloapi7887NkU
   ARu/JOsBv5Q3DPPG5bJQU/L5UTgoLLcDC004cTzYBVA42eMk2IBM91orI
   yrfCdQEtqWTAvRzZ+dKLaM8HfD77WTU6pZRwqDi9pEchlXjwWQ3QDWXry
   8=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 24 Jun 2022 00:28:27 -0700
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 24 Jun 2022 00:28:25 -0700
X-QCInternal: smtphost
Received: from hu-krichai-hyd.qualcomm.com (HELO hu-sgudaval-hyd.qualcomm.com) ([10.213.110.37])
  by ironmsg02-blr.qualcomm.com with ESMTP; 24 Jun 2022 12:58:07 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 4058933)
        id 655003D33; Fri, 24 Jun 2022 12:58:06 +0530 (+0530)
From:   Krishna chaitanya chundru <quic_krichai@quicinc.com>
To:     helgaas@kernel.org
Cc:     linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_vbadigan@quicinc.com,
        quic_hemantk@quicinc.com, quic_nitegupt@quicinc.com,
        quic_skananth@quicinc.com, quic_ramkri@quicinc.com,
        manivannan.sadhasivam@linaro.org, swboyd@chromium.org,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>
Subject: [PATCH v1 2/2] PCI: qcom: Restrict pci transactions after pci suspend
Date:   Fri, 24 Jun 2022 12:58:02 +0530
Message-Id: <1656055682-18817-3-git-send-email-quic_krichai@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1656055682-18817-1-git-send-email-quic_krichai@quicinc.com>
References: <1656055682-18817-1-git-send-email-quic_krichai@quicinc.com>
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
kernel try to mask interrupts by writing in to the vector
table (for MSIX interrupts) and config space (for MSI's).

These transactions are initiated after clocks are getting disabled
as part of PM suspend call. Due to it, these transactions are
resulting in un-clocked access and eventual to crashes.

So added a logic in qcom driver to restrict the unclocked access.
And updated the logic to check the link state before masking
or unmasking the interrupts.

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 12 ++++++--
 drivers/pci/controller/dwc/pcie-qcom.c            | 35 +++++++++++++++++++++--
 2 files changed, 43 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 2fa86f3..52ed865 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -29,13 +29,21 @@ static void dw_msi_ack_irq(struct irq_data *d)
 
 static void dw_msi_mask_irq(struct irq_data *d)
 {
-	pci_msi_mask_irq(d);
+	struct pcie_port *pp = irq_data_get_irq_chip_data(d->parent_data);
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+
+	if (dw_pcie_link_up(pci))
+		pci_msi_mask_irq(d);
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
 	irq_chip_unmask_parent(d);
 }
 
diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index b3029ca..af05fa7 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1331,12 +1331,41 @@ static int qcom_pcie_disable_clks_2_7_0(struct qcom_pcie *pcie)
 	return 0;
 }
 
+static u32 qcom_pcie_read_dbi(struct dw_pcie *pci, void __iomem *base,
+				u32 reg, size_t size)
+{
+	struct qcom_pcie *pcie = to_qcom_pcie(pci);
+	u32 val;
+
+	if (pcie->cfg->is_suspended)
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+
+	dw_pcie_read(base + reg, size, &val);
+	return val;
+}
+
+static void qcom_pcie_write_dbi(struct dw_pcie *pci, void __iomem *base,
+					u32 reg, size_t size, u32 val)
+{
+	struct qcom_pcie *pcie = to_qcom_pcie(pci);
+
+	if (pcie->cfg->is_suspended)
+		return;
+
+	dw_pcie_write(base + reg, size, val);
+}
 
 static int qcom_pcie_link_up(struct dw_pcie *pci)
 {
-	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
-	u16 val = readw(pci->dbi_base + offset + PCI_EXP_LNKSTA);
+	struct qcom_pcie *pcie = to_qcom_pcie(pci);
+	u16 offset;
+	u16 val;
+
+	if (pcie->cfg->is_suspended)
+		return false;
 
+	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	val = readw(pci->dbi_base + offset + PCI_EXP_LNKSTA);
 	return !!(val & PCI_EXP_LNKSTA_DLLLA);
 }
 
@@ -1580,6 +1609,8 @@ static const struct qcom_pcie_cfg sc7280_cfg = {
 static const struct dw_pcie_ops dw_pcie_ops = {
 	.link_up = qcom_pcie_link_up,
 	.start_link = qcom_pcie_start_link,
+	.read_dbi = qcom_pcie_read_dbi,
+	.write_dbi = qcom_pcie_write_dbi,
 };
 
 static int qcom_pcie_probe(struct platform_device *pdev)
-- 
2.7.4

