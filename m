Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8D350CABA
	for <lists+linux-pci@lfdr.de>; Sat, 23 Apr 2022 15:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235819AbiDWNnV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 23 Apr 2022 09:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235828AbiDWNmn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 23 Apr 2022 09:42:43 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3BEB1759F2
        for <linux-pci@vger.kernel.org>; Sat, 23 Apr 2022 06:39:44 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id w1so18806142lfa.4
        for <linux-pci@vger.kernel.org>; Sat, 23 Apr 2022 06:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CDwkASM9CJ+e3T14sU+DD4Z2q62VFhOP6cklNoMqPXY=;
        b=GdtxHObKgFjXdkmJ669X/Zn3OY+Z3NvjzQfWa5z50ScsnI34oRT4FHYQJVr34X/kAd
         ogX5n+k/Kev/nUKSFyq7LjNekVwN6DOoheude2lGZWi0Nc9fvHRopKntmSmrpcHA59np
         6bnVTwp6A1XlEwVieIsMU5e5IsxYZzWAbZV2Tjd9SFFNulw43nQBHvxj49FiKerheOt7
         +vqqsWbE/GYJZkjtntdQyJKSsiUQRpnzy/7L3Ao3x5Jz4T6FdIr8/fBbZUZNF5og8wJI
         jd5m9wzXOjL7OOh1YLNRA/t02tMT6y5x2witdCpZWOD8uK6fuVDdnPb49bIN+3LAhPMu
         Jk5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CDwkASM9CJ+e3T14sU+DD4Z2q62VFhOP6cklNoMqPXY=;
        b=C1jQhlYITPyBPqaH1KcWeM1m25puGzs6QugoYJb2AG1oTKRAcbPgbGwKgJACSAwUIm
         kqdv7EP8l3luW496JT/x1hXJflD+tYwY8nzgG7BUuqXCyCQOpLp8SJgry4h2WLEwCNaM
         YbzDvosQx8nUpF87j2MWY/OA8ZSgR/J+UeEwzgcZlWZUJ9MOTUnkVvmZ7OSFV7zcopao
         wU0AgO5GQYYh47lrs48dmPqS57jj7EljW33mcv0U15u9813AAhq+mSOwIv0nFRE74QhS
         kKcl13ACWNCPsuoIkhBYFXaUh3HARPULGnFFptsb3zEOxUC71nB80Vdj5kEBROP6P4Ah
         zXjw==
X-Gm-Message-State: AOAM530GE+zTAXlIuHpETa8Ny1lCy0F/QDK0Sg+akxNGJO/07IrpZriM
        1ZwkOk2Hnhx1Fr2kMxuCLmPw/g==
X-Google-Smtp-Source: ABdhPJz2KMIFxWRPSfMMPl806Mhi/I5x/Mmi9JwT4IZ6B4llV51mJHpKAY/WiXFWLfSTZ13qPaSSuQ==
X-Received: by 2002:ac2:48a4:0:b0:471:fc7f:b54d with SMTP id u4-20020ac248a4000000b00471fc7fb54dmr535057lfg.538.1650721183144;
        Sat, 23 Apr 2022 06:39:43 -0700 (PDT)
Received: from eriador.lumag.spb.ru ([94.25.228.223])
        by smtp.gmail.com with ESMTPSA id c21-20020a2ea795000000b0024ee0f8ef92sm544535ljf.36.2022.04.23.06.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 06:39:42 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Vinod Koul <vkoul@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 1/5] PCI: dwc: Convert msi_irq to the array
Date:   Sat, 23 Apr 2022 16:39:35 +0300
Message-Id: <20220423133939.2123449-2-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220423133939.2123449-1-dmitry.baryshkov@linaro.org>
References: <20220423133939.2123449-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Qualcomm version of DWC PCIe controller supports more than 32 MSI
interrupts, but they are routed to separate interrupts in groups of 32
vectors. To support such configuration, change the msi_irq field into an
array. Let the DWC core handle all interrupts that were set in this
array.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/pci/controller/dwc/pci-dra7xx.c       |  2 +-
 drivers/pci/controller/dwc/pci-exynos.c       |  2 +-
 .../pci/controller/dwc/pcie-designware-host.c | 30 +++++++++++--------
 drivers/pci/controller/dwc/pcie-designware.h  |  2 +-
 drivers/pci/controller/dwc/pcie-keembay.c     |  2 +-
 drivers/pci/controller/dwc/pcie-spear13xx.c   |  2 +-
 drivers/pci/controller/dwc/pcie-tegra194.c    |  2 +-
 7 files changed, 24 insertions(+), 18 deletions(-)

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
index 2fa86f32d964..5d90009a0f73 100644
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
@@ -368,13 +371,15 @@ int dw_pcie_host_init(struct pcie_port *pp)
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
 				}
+				pp->msi_irq[0] = irq;
 			}
 
 			pp->msi_irq_chip = &dw_pci_msi_bottom_irq_chip;
@@ -383,10 +388,11 @@ int dw_pcie_host_init(struct pcie_port *pp)
 			if (ret)
 				return ret;
 
-			if (pp->msi_irq > 0)
-				irq_set_chained_handler_and_data(pp->msi_irq,
-							    dw_chained_msi_isr,
-							    pp);
+			for (ctrl = 0; ctrl < num_ctrls; ctrl++)
+				if (pp->msi_irq[ctrl] > 0)
+					irq_set_chained_handler_and_data(pp->msi_irq[ctrl],
+									 dw_chained_msi_isr,
+									 pp);
 
 			ret = dma_set_mask(pci->dev, DMA_BIT_MASK(32));
 			if (ret)
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 7d6e9b7576be..9c1a38b0a6b3 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -187,7 +187,7 @@ struct pcie_port {
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

