Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7136252F2C5
	for <lists+linux-pci@lfdr.de>; Fri, 20 May 2022 20:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352760AbiETSb4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 May 2022 14:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352731AbiETSbx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 May 2022 14:31:53 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23EEE2FFF3
        for <linux-pci@vger.kernel.org>; Fri, 20 May 2022 11:31:24 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id h8so10558234ljb.6
        for <linux-pci@vger.kernel.org>; Fri, 20 May 2022 11:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=daZndMg0kEU8eEgJutQNdVqIiPADzzsq4OPoZ6nz57Y=;
        b=UPitSudAMpRdbZklPmUkSpem3iflcmo5ZqwcckTr736EN1WnEmKZRAhBJzWJ/NrzsB
         F/MUglZ2KbUZY7ck3t67aQ+QRDvsK56Yx7mFftyEqL9um3jScOi21tBHGQGjB3zFk/3g
         JRH6WnRESAD4p8A63KqZ1VrltDmkHLSKFHdyze9HlMzDcxKCAGWzjMaINIxTp5aPjVPU
         l4WoN6qkgtiRVhw4bKWFxTnBPpUwLL2uipTo2JSAiZnzJQD68pErNP58NfH/S/Hd7XUn
         TtWLKdDrNZbFrI7a90mm9n+ebBvMRFSkZHBUzxlLfvlXLOFbEtBrFuW3ZdD0bMa6IxGX
         U7jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=daZndMg0kEU8eEgJutQNdVqIiPADzzsq4OPoZ6nz57Y=;
        b=2c0v8hIuelGk+QQEq6yt5a5aUqdSUawYs7a1FSIDgC/shz6f0tiGb39ctkKhRrjziM
         oFRmgQOGoCO/Xu4z1zhB6lPJFN9JPkLhixICoj1NKdRjmIe7o0I5+X07MsNId8XfLVRX
         qmvs0A+QUQz68b6wKY6o6RyS2obqgJ9d3dS1+H5Hc2Y64K/Ogqv0p0czc62v1WSjlIte
         Z0Qis7OHQisJgdFtc5j8UkBtFh+6r5H+wrpsb/Xn4J0+4bBQX979Z5T7rf8nMYcOEvjc
         dnt6Wcav6gGNAFC1FDg6iHr0s8a4C191MuzNo+EAkMTr0W88hrI8fO/doOn9DG8YurQM
         Bh4w==
X-Gm-Message-State: AOAM531h3mmpyMz/tahQAjA+koAyfU6Qeus0vean2Ml4VnUdv33pH37S
        z2UtN+T1GfkP+jTgwvrmSy5GaQ==
X-Google-Smtp-Source: ABdhPJypgO+f3jaTe7Kgob6uFFSKjxBHclEYCLyvV9op6f73j3Ph/VG87J0O3panxahjT4Fti28V1Q==
X-Received: by 2002:a2e:9c0c:0:b0:24e:e2e0:f61e with SMTP id s12-20020a2e9c0c000000b0024ee2e0f61emr6242417lji.75.1653071484229;
        Fri, 20 May 2022 11:31:24 -0700 (PDT)
Received: from eriador.lan ([2001:470:dd84:abc0::8a5])
        by smtp.gmail.com with ESMTPSA id t22-20020a2e9556000000b0024f3d1daef4sm392951ljh.124.2022.05.20.11.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 11:31:23 -0700 (PDT)
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
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH v11 4/7] PCI: dwc: Implement special ISR handler for split MSI IRQ setup
Date:   Fri, 20 May 2022 21:31:11 +0300
Message-Id: <20220520183114.1356599-5-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220520183114.1356599-1-dmitry.baryshkov@linaro.org>
References: <20220520183114.1356599-1-dmitry.baryshkov@linaro.org>
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
 .../pci/controller/dwc/pcie-designware-host.c | 85 ++++++++++++++-----
 1 file changed, 64 insertions(+), 21 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 381bc24d5715..20ab8a0c6359 100644
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
@@ -341,6 +381,8 @@ static int dw_pcie_msi_host_init(struct pcie_port *pp)
 		ret = dw_pcie_parse_split_msi_irq(pp);
 		if (ret < 0 && ret != -ENXIO)
 			return ret;
+		else if (!ret)
+			has_split_msi_irq = true;
 	}
 
 	if (!pp->num_vectors)
@@ -369,6 +411,7 @@ static int dw_pcie_msi_host_init(struct pcie_port *pp)
 	for (ctrl = 0; ctrl < num_ctrls; ctrl++)
 		if (pp->msi_irq[ctrl] > 0)
 			irq_set_chained_handler_and_data(pp->msi_irq[ctrl],
+							 has_split_msi_irq ? dw_split_msi_isr :
 							 dw_chained_msi_isr,
 							 pp);
 
-- 
2.35.1

