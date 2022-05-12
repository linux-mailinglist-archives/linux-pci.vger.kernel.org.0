Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E757524AB3
	for <lists+linux-pci@lfdr.de>; Thu, 12 May 2022 12:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243226AbiELKqU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 May 2022 06:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352817AbiELKqA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 May 2022 06:46:00 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 153BC10FF9
        for <linux-pci@vger.kernel.org>; Thu, 12 May 2022 03:45:54 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id l19so5951171ljb.7
        for <linux-pci@vger.kernel.org>; Thu, 12 May 2022 03:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bEuWr9saiyl5tUbiZ8gu0ZtQD70Wt8dxuj/o+yE0DyA=;
        b=HcJilZ61NtMXpLLiYklNIVTzI3mcMbFOTuuVndWVmBKO4oMtbBeCMu9K9l4wLRqnUM
         2OAxKB4nVPig8c+uAZHGiNedq36qYSzZToYQxVXil4180IgM3CkDhf+WESGzA94kFFoq
         VLYGZ5MpNn1+iEBvx77F7X53f1WukI30OrwxhvoDQkZXigK4C/mLj/1MJQ5roCrHsaxv
         9opanrTnzU7KbFVuIk8GZAXholOoa9N2NkzWJCuxL31k7oEGpr/befC3+Vv1jRw+V5CP
         g2cysWKscK5FQk/zDsO4Rir7QFzGEEBBjcjMv0ZTibVFj7s4uRv3QdSii/jCCZm/cj5k
         11Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bEuWr9saiyl5tUbiZ8gu0ZtQD70Wt8dxuj/o+yE0DyA=;
        b=wEUynfdBtjRbSQAYlTgTbwT9Bzx9NVMHwr2QvOWiz7/ogPS6hvnxzU3fJB1/7VWS0k
         gB9efteHtsjzZeix6iNQ9kwAmoNh0X2HvlFON4CsTdG6CZ3Uzqn7LJlRMTS0YM/idY3V
         j2M8SbIaD0KE21UFV79PuY1csFVoZLfJWvQLQNLS6jgSpksZIXvIBEKdzcUiS1cGn5VG
         IPjzB+6ikfJi71unAMKihNtuMexVPhEG24TxJwAdzG5gjVjTwPC059Tjvk0cDTn7p8m2
         k2qVNoXff3d6auSvYr5FbtgmfLyjs9OdT/UTsFGqWye/o0rUHRwzO7dYChyWISpKf0ou
         pUyg==
X-Gm-Message-State: AOAM533t7R4BboBN1bEiO8gwF/PqP3H5uOFw08gsgnQAp8RHB+0tu784
        qwSw73qqEJDcxra+t8M4jIsysg==
X-Google-Smtp-Source: ABdhPJwzgMj9zAXhLGoKb1Uc8o1gRDm7D+WTzMxEPYJYUVfI+751aU0Z+/B3OYjB0hPWQs93bnru8Q==
X-Received: by 2002:a2e:bc19:0:b0:24f:4de2:38ba with SMTP id b25-20020a2ebc19000000b0024f4de238bamr19993139ljf.351.1652352352374;
        Thu, 12 May 2022 03:45:52 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id q21-20020a2e9695000000b0024f3d1daeafsm831660lji.55.2022.05.12.03.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 03:45:52 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v8 08/10] PCI: dwc: Implement special ISR handler for split MSI IRQ setup
Date:   Thu, 12 May 2022 13:45:43 +0300
Message-Id: <20220512104545.2204523-9-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220512104545.2204523-1-dmitry.baryshkov@linaro.org>
References: <20220512104545.2204523-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

If the PCIe DWC controller uses split MSI IRQs for reporting MSI
vectors, it is possible to detect, which group triggered the interrupt.
Provide an optimized version of MSI ISR handler that will handle just a
single MSI group instead of handling all of them.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 .../pci/controller/dwc/pcie-designware-host.c | 83 ++++++++++++++-----
 1 file changed, 62 insertions(+), 21 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 258bafa306dc..b1b8d924ea8c 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -52,34 +52,42 @@ static struct msi_domain_info dw_pcie_msi_domain_info = {
 	.chip	= &dw_pcie_msi_irq_chip,
 };
 
+static inline irqreturn_t dw_handle_single_msi_group(struct pcie_port *pp, int i)
+{
+	int pos;
+	unsigned long val;
+	u32 status;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+
+	status = dw_pcie_readl_dbi(pci, PCIE_MSI_INTR0_STATUS +
+				   (i * MSI_REG_CTRL_BLOCK_SIZE));
+	if (!status)
+		return IRQ_NONE;
+
+	val = status;
+	pos = 0;
+	while ((pos = find_next_bit(&val, MAX_MSI_IRQS_PER_CTRL,
+				    pos)) != MAX_MSI_IRQS_PER_CTRL) {
+		generic_handle_domain_irq(pp->irq_domain,
+					  (i * MAX_MSI_IRQS_PER_CTRL) +
+					  pos);
+		pos++;
+	}
+
+	return IRQ_HANDLED;
+}
+
 /* MSI int handler */
 irqreturn_t dw_handle_msi_irq(struct pcie_port *pp)
 {
-	int i, pos;
-	unsigned long val;
-	u32 status, num_ctrls;
+	int i;
+	u32 num_ctrls;
 	irqreturn_t ret = IRQ_NONE;
-	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 
 	num_ctrls = pp->num_vectors / MAX_MSI_IRQS_PER_CTRL;
 
-	for (i = 0; i < num_ctrls; i++) {
-		status = dw_pcie_readl_dbi(pci, PCIE_MSI_INTR0_STATUS +
-					   (i * MSI_REG_CTRL_BLOCK_SIZE));
-		if (!status)
-			continue;
-
-		ret = IRQ_HANDLED;
-		val = status;
-		pos = 0;
-		while ((pos = find_next_bit(&val, MAX_MSI_IRQS_PER_CTRL,
-					    pos)) != MAX_MSI_IRQS_PER_CTRL) {
-			generic_handle_domain_irq(pp->irq_domain,
-						  (i * MAX_MSI_IRQS_PER_CTRL) +
-						  pos);
-			pos++;
-		}
-	}
+	for (i = 0; i < num_ctrls; i++)
+		ret |= dw_handle_single_msi_group(pp, i);
 
 	return ret;
 }
@@ -98,6 +106,38 @@ static void dw_chained_msi_isr(struct irq_desc *desc)
 	chained_irq_exit(chip, desc);
 }
 
+static void dw_split_msi_isr(struct irq_desc *desc)
+{
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	int irq = irq_desc_get_irq(desc);
+	struct pcie_port *pp;
+	int i;
+	u32 num_ctrls;
+	struct dw_pcie *pci;
+
+	chained_irq_enter(chip, desc);
+
+	pp = irq_desc_get_handler_data(desc);
+	pci = to_dw_pcie_from_pp(pp);
+
+	/*
+	 * Unlike generic dw_handle_msi_irq(), we can determine which group of
+	 * MSIs triggered the IRQ, so process just that group.
+	 */
+	num_ctrls = pp->num_vectors / MAX_MSI_IRQS_PER_CTRL;
+
+	for (i = 0; i < num_ctrls; i++) {
+		if (pp->msi_irq[i] == irq) {
+			dw_handle_single_msi_group(pp, i);
+			break;
+		}
+	}
+
+	WARN_ON_ONCE(i == num_ctrls);
+
+	chained_irq_exit(chip, desc);
+}
+
 static void dw_pci_setup_msi_msg(struct irq_data *d, struct msi_msg *msg)
 {
 	struct pcie_port *pp = irq_data_get_irq_chip_data(d);
@@ -350,6 +390,7 @@ static int dw_pcie_msi_host_init(struct pcie_port *pp)
 	for (ctrl = 0; ctrl < num_ctrls; ctrl++)
 		if (pp->msi_irq[ctrl] > 0)
 			irq_set_chained_handler_and_data(pp->msi_irq[ctrl],
+							 pp->has_split_msi_irq ? dw_split_msi_isr :
 							 dw_chained_msi_isr,
 							 pp);
 
-- 
2.35.1

