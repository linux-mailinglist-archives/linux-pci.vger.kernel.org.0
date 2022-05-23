Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B55B3531A22
	for <lists+linux-pci@lfdr.de>; Mon, 23 May 2022 22:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232268AbiEWSmY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 May 2022 14:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243596AbiEWSjC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 23 May 2022 14:39:02 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031AF177062
        for <linux-pci@vger.kernel.org>; Mon, 23 May 2022 11:19:03 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id p22so26960575lfo.10
        for <linux-pci@vger.kernel.org>; Mon, 23 May 2022 11:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zEITd+UQOjrSEvyPgGY/OvViZtZMyUILasfRec32oOQ=;
        b=ieZtEfIsS00nBwjjPJgAcgh36FoK+FZU2cBqunROxOQugaRhnct88rck0YWP+EipEj
         yafnggRUIOH62fbOtIkO2TeuApsvb0JImfh/d6PHAgJldB4Cz57dFA7sNO89oIMpQ2HL
         BHs2zN3bgDJ4inHMub/WmYzOA7wJJLtrgUCV7IQ1KsbCP5hMQ/xWtFsc9Wjs0Srsr98O
         1aAWFXOjnFtbK/D7I/PMu8KmDq+fa1jhDOluQFQ/8ZZGL03IPxO+OFBV3t8Yz3vBzM9n
         OAosumbF6s6GZkUs5+auyW0v5nF5ftPdMoaohHF6j6lY0BQur8Rk8K8Ckr0PHmHgKB4k
         XIlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zEITd+UQOjrSEvyPgGY/OvViZtZMyUILasfRec32oOQ=;
        b=710nv3vM6cMRQNmyyRYop+mgIcTZnYVFBi35Zqm4sTNtox8pWszZKUP6IQOXclb0MT
         3CjqaP6nriMa+k5oVJvqqYGhca+1SHo0at/DRRciFm8r/xGlH3O/LpBCJQLqB1mjmJlq
         1J4nZv8n9q8s/tGLNC0tFWUDFmCE2iky5Rbb1V6H7xMoz31X67JunTIbWpd7RdXnFQ/B
         VIfxVD2uETGTJWPKGBGT75I3Pnv4KYnOKlFwTvN/tYCete2Z6MQ4jiIEOqE453NXy5ig
         qjoypvdxsczJbLwWlFLHstBSMjPYZsgOaKrQL8zAgmKTmHQnNhk66cL03QNiBJc/voMu
         4K0Q==
X-Gm-Message-State: AOAM53029pOoi0nCA0tOZYEFG9YZJIIkZEm6V/fyZGoaP/HvFZwugfg+
        yn8t/cygDF4/agCpLDqpCg1VRA==
X-Google-Smtp-Source: ABdhPJyKe/QHnyAw65Ooblh/C4YWH6FqtQPYI2Kt9j3rfCYaFlO5Wib4FXvbCc/jdtoAX3Hi+wC0SQ==
X-Received: by 2002:a05:6512:3f86:b0:44a:f5bf:ec9a with SMTP id x6-20020a0565123f8600b0044af5bfec9amr17549964lfa.490.1653329924197;
        Mon, 23 May 2022 11:18:44 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id j20-20020a2e6e14000000b0024f3d1daedesm1904127ljc.102.2022.05.23.11.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 11:18:43 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v12 6/8] PCI: dwc: Implement special ISR handler for split MSI IRQ setup
Date:   Mon, 23 May 2022 21:18:34 +0300
Message-Id: <20220523181836.2019180-7-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220523181836.2019180-1-dmitry.baryshkov@linaro.org>
References: <20220523181836.2019180-1-dmitry.baryshkov@linaro.org>
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
 .../pci/controller/dwc/pcie-designware-host.c | 86 ++++++++++++++-----
 1 file changed, 65 insertions(+), 21 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 98a57249ecaf..2b2de517301a 100644
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
@@ -336,6 +376,7 @@ static int dw_pcie_msi_host_init(struct pcie_port *pp)
 	struct platform_device *pdev = to_platform_device(dev);
 	int ret;
 	u32 ctrl, num_ctrls;
+	bool has_split_msi_irq = false;
 
 	for (ctrl = 0; ctrl < MAX_MSI_CTRLS; ctrl++)
 		pp->irq_mask[ctrl] = ~0;
@@ -344,6 +385,8 @@ static int dw_pcie_msi_host_init(struct pcie_port *pp)
 		ret = dw_pcie_parse_split_msi_irq(pp);
 		if (ret < 0 && ret != -ENXIO)
 			return ret;
+		else if (!ret)
+			has_split_msi_irq = true;
 	}
 
 	if (!pp->num_vectors)
@@ -372,6 +415,7 @@ static int dw_pcie_msi_host_init(struct pcie_port *pp)
 	for (ctrl = 0; ctrl < num_ctrls; ctrl++)
 		if (pp->msi_irq[ctrl] > 0)
 			irq_set_chained_handler_and_data(pp->msi_irq[ctrl],
+							 has_split_msi_irq ? dw_split_msi_isr :
 							 dw_chained_msi_isr,
 							 pp);
 
-- 
2.35.1

