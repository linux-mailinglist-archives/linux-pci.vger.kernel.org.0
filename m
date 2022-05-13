Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD9AE526862
	for <lists+linux-pci@lfdr.de>; Fri, 13 May 2022 19:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382993AbiEMR0n (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 May 2022 13:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382987AbiEMR0l (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 May 2022 13:26:41 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0ED96FD3E
        for <linux-pci@vger.kernel.org>; Fri, 13 May 2022 10:26:29 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id p26so15642343lfh.10
        for <linux-pci@vger.kernel.org>; Fri, 13 May 2022 10:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vhMx9quQctQ4oGEtfI4X3eZwD+AkXKzdig9qM2UsicE=;
        b=XfKq9aDN0K+bIZtRTSwFR43VoPx6B45ngljP3cJcf9/AUycUfc1Ary9OUWgLjJtOm1
         sjTbWERvGpvzlMqnTLElVvAxgNpX6DMJz2YM81AuQJnbargigxeRgyUaqi0a2gNb2D69
         ELyjUzC5VyijtPQOzFgfnbNcqzN2pb3MRNO/N+Dqb7Mt7OjzXZvNbYxGRyIoMnHcltdJ
         5/sCwKOYgwMT6+mQpF1jA2KD/bf7gh7TJIyakMVPAtTVPM8M2PjlowjogUKF/SsecsIY
         giZCFnEtbsqn9fd0uMbTVofz4RCH47dTNWkhSmnmmfD/5wOe8RDJhMZGsXo9S7yOUJ1C
         SBOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vhMx9quQctQ4oGEtfI4X3eZwD+AkXKzdig9qM2UsicE=;
        b=1I/MfWtSWuB1uHnkWXN4PeAT7AQk8HQN0xEPIkkfi35Rl4+BMgetQCmdXqAvunaw+/
         94O9qctzUxwD2ERswRmTj2Qs7YqYEUCjB0bhh+/8/X3PpY7R6HrTPCAVzQBO1bY1TriD
         cT0UvS7seozlr2YfqUXr1BLmnukN44PpKuReDJrQ2K6eLFg2JWvJlErwIBjMPWF+nI+G
         bYZL4HcB4Q+PsNWFnzcMCkhjiGc4QGy44FxudIC+15ak8rKqhv4ipwSLFya9WJeft49y
         wCdXOLd/Ky0c/bjX31+AJ4Ar4DI5DRsWVlY+kZu5b+bC8N1VxojsdA3bq9PF60ie7Nls
         zcsA==
X-Gm-Message-State: AOAM533uqPNb1jiM8lER5U2Yik/fn9pN1nRE3QTvcEjlOqNSWIZk5sOD
        3pYnZe97JISHE+2AjPLGGDtIrQ==
X-Google-Smtp-Source: ABdhPJxvM7YthgMhQJRrcgIdlU6ZVWpfX4ocmeCsLlFeFNT9IiD1Iow0ltQhm0fNx4g72Su1f2goGg==
X-Received: by 2002:a05:6512:68c:b0:473:da9a:66c3 with SMTP id t12-20020a056512068c00b00473da9a66c3mr4100227lfe.531.1652462789316;
        Fri, 13 May 2022 10:26:29 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id e3-20020a2e8183000000b0024f3d1daec0sm511157ljg.72.2022.05.13.10.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 10:26:28 -0700 (PDT)
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
Subject: [PATCH v10 07/10] PCI: dwc: Implement special ISR handler for split MSI IRQ setup
Date:   Fri, 13 May 2022 20:26:19 +0300
Message-Id: <20220513172622.2968887-8-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220513172622.2968887-1-dmitry.baryshkov@linaro.org>
References: <20220513172622.2968887-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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
index 320a968dd366..c0abf098dc78 100644
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
@@ -356,6 +396,7 @@ static int dw_pcie_msi_host_init(struct pcie_port *pp)
 	for (ctrl = 0; ctrl < num_ctrls; ctrl++)
 		if (pp->msi_irq[ctrl] > 0)
 			irq_set_chained_handler_and_data(pp->msi_irq[ctrl],
+							 pp->has_split_msi_irq ? dw_split_msi_isr :
 							 dw_chained_msi_isr,
 							 pp);
 
-- 
2.35.1

