Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 206E45262D3
	for <lists+linux-pci@lfdr.de>; Fri, 13 May 2022 15:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380632AbiEMNRK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 May 2022 09:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232625AbiEMNRH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 May 2022 09:17:07 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7261BE0C4
        for <linux-pci@vger.kernel.org>; Fri, 13 May 2022 06:17:05 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id i10so14425125lfg.13
        for <linux-pci@vger.kernel.org>; Fri, 13 May 2022 06:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1r5AS7e2Ap1rx30EGXQILtdJuFs6sWe1b2QM2dOrQko=;
        b=COHdQn34+XKnCGKwsOzSGqZufaiPXE2Zw2CnZGF87PmC3pSbLvi8ho6DkdwsEuqJSA
         3iEs36RU9G1+c0paUPIucJ4NDutd3jeE455Z+XO2AHaJIyWlnXFc6oWJB06wIew5A8db
         5yzp1Qin7XiLL0T0OiNpXjL8Mw8SSlCNnO6zv9t2pB9HrmxMT1Tz1wp+3SrzC3Y5d5iD
         IZb6paFN6I5W9dqJ/ANOmpZctXEmULCWhNq7vxSBy6lcMHaFyQlI7gpGaRgoon838ZbE
         JD2XuSH7rmktMiFQJEFxa9WzvHupt82j6GAHb3F7U6DLuy/zTbUtdpZuTsv+MYs9lWBS
         BHvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1r5AS7e2Ap1rx30EGXQILtdJuFs6sWe1b2QM2dOrQko=;
        b=r4HzR0BNQV8ckoDPMeAwhwIkd0+f+P+MuaWCUUNrSFZIHfpNJkwRlbR031RDn90kvr
         hs51mj/ZFWasdVQUKf9T1hnrjLbfnVnuzmnY3hgzSuVc6r2zWCrAr6uyeyDAozl9l8aq
         luNclYxa8W39gG4qXYctQZKzGuxGkJEhBT/tiIqwZVfaSJXcS0KzOnXoACmx69TQHnmc
         98OTW262Rd3fPZcYLeUDTX5fXqy4m1hpuBGzyNgrVoIMPGT2Iq+YsqnMoSXQkavReTvh
         6JBgh/8Qq4XPOojmFf4cuYF/8BPvHrg2T6Xk7D/VtoGQyMUCvxCS2OnnmLR5FR5ibfKb
         0/CA==
X-Gm-Message-State: AOAM530KQPqu4kH9ESaKlRLYF+LWD5yRuTs5ZAZSAjfJRMYf0LWUeUS+
        dYvP1lheYo2+AQ6jiI75IJ1X7A==
X-Google-Smtp-Source: ABdhPJxRlKCK2KTVl332pCx8J9oo6Rda2l2mtMR3CSxOicWeauXyCxgnU28mrLWWwibT5su6T0CXmw==
X-Received: by 2002:a19:7115:0:b0:473:f2a7:661 with SMTP id m21-20020a197115000000b00473f2a70661mr3209911lfc.586.1652447823701;
        Fri, 13 May 2022 06:17:03 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id u22-20020a2ea176000000b0024f3d1dae8fsm436991ljl.23.2022.05.13.06.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 06:17:03 -0700 (PDT)
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
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Johan Hovold <johan@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v9 07/10] PCI: dwc: Implement special ISR handler for split MSI IRQ setup
Date:   Fri, 13 May 2022 16:16:52 +0300
Message-Id: <20220513131655.2927616-8-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220513131655.2927616-1-dmitry.baryshkov@linaro.org>
References: <20220513131655.2927616-1-dmitry.baryshkov@linaro.org>
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
index 007600524b49..9ba0d73c3a10 100644
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
@@ -349,6 +389,7 @@ static int dw_pcie_msi_host_init(struct pcie_port *pp)
 	for (ctrl = 0; ctrl < num_ctrls; ctrl++)
 		if (pp->msi_irq[ctrl] > 0)
 			irq_set_chained_handler_and_data(pp->msi_irq[ctrl],
+							 pp->has_split_msi_irq ? dw_split_msi_isr :
 							 dw_chained_msi_isr,
 							 pp);
 
-- 
2.35.1

