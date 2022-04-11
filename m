Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07B914FBB48
	for <lists+linux-pci@lfdr.de>; Mon, 11 Apr 2022 13:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344976AbiDKLvq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Apr 2022 07:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344963AbiDKLvp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Apr 2022 07:51:45 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5BD5192AF
        for <linux-pci@vger.kernel.org>; Mon, 11 Apr 2022 04:49:30 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id t25so26114592lfg.7
        for <linux-pci@vger.kernel.org>; Mon, 11 Apr 2022 04:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xkSQ9TEO9WGbmQdOXtjBGv8wQE8xvgbaKh/X2ncgG4c=;
        b=hVztS2wpinFYv5hyhrK/g9KJqM6c8HgBVcyB8HlrrqK1qc1QZ0HG/2t6Jwa7CrXUN5
         j5uwNxtbXkr50U+Db9n15RnmhtXBu5a9cAwOD2ci3eExXHag7bgTz7BNoNOdKRX177uN
         sOGMSOIPKCUX7LUSLBIhvWFzM/pPyO3wlPooUfd4q+7O8EvtNCEJMwr1ZGFsyS4uxSoY
         qe1x6Bd5t9WiT1iMDTFjifxIy7Ea0fNGebMDH1Xpv7DhtiZ/M4nFCPUqR9ysGw+oFT5r
         dkoD0NRiaYAuN7OsaGbtUT1eOG8SUJHqPLROqLAJ1DVPaHnWGWTK8HN8VDmF9aFLUckB
         IvdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xkSQ9TEO9WGbmQdOXtjBGv8wQE8xvgbaKh/X2ncgG4c=;
        b=0IsgG+xvu4edEw+l5cTBpr5HGwijahb2CrO526XSPcnkNL5vlGSv3WI0tMdI0MwdDN
         w7+QQ8zTJonGiuuXqvKDXnnqLzk/MEhOxcj91qMxgZNvk3umXFXDRKZTmjk2Jm/QFo9Q
         ijOyE6sIG+o2862tBCtAsbXuS4UGD2Te/C5C7nWwtFcD4uqghTvvCaAQcQm80S6mUSng
         js17TxSGEueMSjCStU7kOg10YfMYS0uashE6KLbkTu1w37rr4IQh6aqYNBJjtGMpC7CY
         plfDjtoqhtvMsfGi5nlbCIA+I/WV+MelCgsifLN6HeHEYSfO+li8d7w4qpLZy5jwWGXQ
         zGqg==
X-Gm-Message-State: AOAM5314I3NJr5tNvF5fw6Q4Hdr23MgZjY9dnlhQIDIg+FtzNXYQ62yE
        scHSusvtaYv2MD9OLChQTemqqg==
X-Google-Smtp-Source: ABdhPJyg3Xi5EW05/GhfP4zTc1X7HLspCFArbT4p3XQdtNvI64UGIAebEJ6yTQSYMxVyv5DKFbDRDA==
X-Received: by 2002:a05:6512:110b:b0:46b:a0d9:4675 with SMTP id l11-20020a056512110b00b0046ba0d94675mr5224838lfg.380.1649677768490;
        Mon, 11 Apr 2022 04:49:28 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id y21-20020a05651c021500b0024b5d56484dsm587973ljn.83.2022.04.11.04.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 04:49:27 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, Manivannan Sadhasivam <mani@kernel.org>
Subject: [PATCH 1/4] PCI: qcom: Handle MSI IRQs properly
Date:   Mon, 11 Apr 2022 14:49:23 +0300
Message-Id: <20220411114926.1975363-2-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220411114926.1975363-1-dmitry.baryshkov@linaro.org>
References: <20220411114926.1975363-1-dmitry.baryshkov@linaro.org>
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

On Qualcomm platforms each group of MSI interrupts is routed to the
separate GIC interrupt. Thus to receive higher MSI vectors properly,
we have to setup and chain more MSI interrupts. However to remain
compatible with existing DTS files, do not fail if the platform doesn't
provide all 8 MSI interrupts. Instead of that, limit the amount of
supported MSI vectors.

Fixes: 8ae0117418f3 ("PCI: qcom: Add support for handling MSIs from 8 endpoints")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/pci/controller/dwc/pci-dra7xx.c       |  2 +-
 drivers/pci/controller/dwc/pci-exynos.c       |  2 +-
 .../pci/controller/dwc/pcie-designware-host.c | 54 ++++++++++++++-----
 drivers/pci/controller/dwc/pcie-designware.h  |  3 +-
 drivers/pci/controller/dwc/pcie-keembay.c     |  2 +-
 drivers/pci/controller/dwc/pcie-qcom.c        |  1 +
 drivers/pci/controller/dwc/pcie-spear13xx.c   |  2 +-
 drivers/pci/controller/dwc/pcie-tegra194.c    |  2 +-
 8 files changed, 50 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
index dfcdeb432dc8..0919c96dcdbd 100644
--- a/drivers/pci/controller/dwc/pci-dra7xx.c
+++ b/drivers/pci/controller/dwc/pci-dra7xx.c
@@ -483,7 +483,7 @@ static int dra7xx_add_pcie_port(struct dra7xx_pcie *dra7xx,
 		return pp->irq;
 
 	/* MSI IRQ is muxed */
-	pp->msi_irq = -ENODEV;
+	pp->msi_irq[0] = -ENODEV;
 
 	ret = dra7xx_pcie_init_irq_domain(pp);
 	if (ret < 0)
diff --git a/drivers/pci/controller/dwc/pci-exynos.c b/drivers/pci/controller/dwc/pci-exynos.c
index 467c8d1cd7e4..4f2010bd9cd7 100644
--- a/drivers/pci/controller/dwc/pci-exynos.c
+++ b/drivers/pci/controller/dwc/pci-exynos.c
@@ -292,7 +292,7 @@ static int exynos_add_pcie_port(struct exynos_pcie *ep,
 	}
 
 	pp->ops = &exynos_pcie_host_ops;
-	pp->msi_irq = -ENODEV;
+	pp->msi_irq[0] = -ENODEV;
 
 	ret = dw_pcie_host_init(pp);
 	if (ret) {
diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 2fa86f32d964..15e230d6606e 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -257,8 +257,11 @@ int dw_pcie_allocate_domains(struct pcie_port *pp)
 
 static void dw_pcie_free_msi(struct pcie_port *pp)
 {
-	if (pp->msi_irq)
-		irq_set_chained_handler_and_data(pp->msi_irq, NULL, NULL);
+	u32 ctrl;
+
+	for (ctrl = 0; ctrl < MAX_MSI_CTRLS; ctrl++)
+		if (pp->msi_irq[ctrl])
+			irq_set_chained_handler_and_data(pp->msi_irq[ctrl], NULL, NULL);
 
 	irq_domain_remove(pp->msi_domain);
 	irq_domain_remove(pp->irq_domain);
@@ -368,12 +371,37 @@ int dw_pcie_host_init(struct pcie_port *pp)
 			for (ctrl = 0; ctrl < num_ctrls; ctrl++)
 				pp->irq_mask[ctrl] = ~0;
 
-			if (!pp->msi_irq) {
-				pp->msi_irq = platform_get_irq_byname_optional(pdev, "msi");
-				if (pp->msi_irq < 0) {
-					pp->msi_irq = platform_get_irq(pdev, 0);
-					if (pp->msi_irq < 0)
-						return pp->msi_irq;
+			if (!pp->msi_irq[0]) {
+				int irq = platform_get_irq_byname_optional(pdev, "msi");
+
+				if (irq < 0) {
+					irq = platform_get_irq(pdev, 0);
+					if (irq < 0)
+						return irq;
+				}
+				pp->msi_irq[0] = irq;
+			}
+
+			if (pp->has_split_msi_irq) {
+				char irq_name[] = "msiXXX";
+				int irq;
+
+				for (ctrl = 1; ctrl < num_ctrls; ctrl++) {
+					if (pp->msi_irq[ctrl])
+						continue;
+
+					snprintf(irq_name, sizeof(irq_name), "msi%d", ctrl + 1);
+					irq = platform_get_irq_byname_optional(pdev, irq_name);
+					if (irq == -ENXIO) {
+						num_ctrls = ctrl;
+						pp->num_vectors = num_ctrls * MAX_MSI_IRQS_PER_CTRL;
+						dev_warn(dev, "Limiting amount of MSI irqs to %d\n", pp->num_vectors);
+						break;
+					}
+					if (irq < 0)
+						return irq;
+
+					pp->msi_irq[ctrl] = irq;
 				}
 			}
 
@@ -383,10 +411,12 @@ int dw_pcie_host_init(struct pcie_port *pp)
 			if (ret)
 				return ret;
 
-			if (pp->msi_irq > 0)
-				irq_set_chained_handler_and_data(pp->msi_irq,
-							    dw_chained_msi_isr,
-							    pp);
+			for (ctrl = 0; ctrl < num_ctrls; ctrl++) {
+				if (pp->msi_irq[ctrl] > 0)
+					irq_set_chained_handler_and_data(pp->msi_irq[ctrl],
+									 dw_chained_msi_isr,
+									 pp);
+			}
 
 			ret = dma_set_mask(pci->dev, DMA_BIT_MASK(32));
 			if (ret)
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index aadb14159df7..e34076320632 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -179,6 +179,7 @@ struct dw_pcie_host_ops {
 
 struct pcie_port {
 	bool			has_msi_ctrl:1;
+	bool			has_split_msi_irq:1;
 	u64			cfg0_base;
 	void __iomem		*va_cfg0_base;
 	u32			cfg0_size;
@@ -187,7 +188,7 @@ struct pcie_port {
 	u32			io_size;
 	int			irq;
 	const struct dw_pcie_host_ops *ops;
-	int			msi_irq;
+	int			msi_irq[MAX_MSI_CTRLS];
 	struct irq_domain	*irq_domain;
 	struct irq_domain	*msi_domain;
 	u16			msi_msg;
diff --git a/drivers/pci/controller/dwc/pcie-keembay.c b/drivers/pci/controller/dwc/pcie-keembay.c
index 1ac29a6eef22..297e6e926c00 100644
--- a/drivers/pci/controller/dwc/pcie-keembay.c
+++ b/drivers/pci/controller/dwc/pcie-keembay.c
@@ -338,7 +338,7 @@ static int keembay_pcie_add_pcie_port(struct keembay_pcie *pcie,
 	int ret;
 
 	pp->ops = &keembay_pcie_host_ops;
-	pp->msi_irq = -ENODEV;
+	pp->msi_irq[0] = -ENODEV;
 
 	ret = keembay_pcie_setup_msi_irq(pcie);
 	if (ret)
diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 6bb90003ed58..e33811aabc2a 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1534,6 +1534,7 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 	pci->ops = &dw_pcie_ops;
 	pp = &pci->pp;
 	pp->num_vectors = MAX_MSI_IRQS;
+	pp->has_split_msi_irq = true;
 
 	pcie->pci = pci;
 
diff --git a/drivers/pci/controller/dwc/pcie-spear13xx.c b/drivers/pci/controller/dwc/pcie-spear13xx.c
index 1569e82b5568..cc7776833810 100644
--- a/drivers/pci/controller/dwc/pcie-spear13xx.c
+++ b/drivers/pci/controller/dwc/pcie-spear13xx.c
@@ -172,7 +172,7 @@ static int spear13xx_add_pcie_port(struct spear13xx_pcie *spear13xx_pcie,
 	}
 
 	pp->ops = &spear13xx_pcie_host_ops;
-	pp->msi_irq = -ENODEV;
+	pp->msi_irq[0] = -ENODEV;
 
 	ret = dw_pcie_host_init(pp);
 	if (ret) {
diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index b1b5f836a806..e75712db85b0 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -2271,7 +2271,7 @@ static void tegra194_pcie_shutdown(struct platform_device *pdev)
 
 	disable_irq(pcie->pci.pp.irq);
 	if (IS_ENABLED(CONFIG_PCI_MSI))
-		disable_irq(pcie->pci.pp.msi_irq);
+		disable_irq(pcie->pci.pp.msi_irq[0]);
 
 	tegra194_pcie_pme_turnoff(pcie);
 	tegra_pcie_unconfig_controller(pcie);
-- 
2.35.1

