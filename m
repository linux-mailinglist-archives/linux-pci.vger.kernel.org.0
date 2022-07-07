Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D50CB56A422
	for <lists+linux-pci@lfdr.de>; Thu,  7 Jul 2022 15:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236133AbiGGNrx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Jul 2022 09:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236046AbiGGNrj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Jul 2022 09:47:39 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0561327B01
        for <linux-pci@vger.kernel.org>; Thu,  7 Jul 2022 06:47:38 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id e20so2460694lfq.11
        for <linux-pci@vger.kernel.org>; Thu, 07 Jul 2022 06:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nCaTaGyflXG3dvr5xp0v7HTcUoryUfnRTZVHXazf9SQ=;
        b=SGkbqwZg0TvJ4C+zXQcZl+QegNhKoLWcW4/rvO+Pv3oA1RTusmhVL8/3wULjMoUyKa
         absWz84j8bjBXBMLbQdiLUBBWxyhjuSJxQ9qz7CKgJWTDBntHhhAGpo9gnb6AExacmn2
         3PjkTYKnss0S7MgCBsKYFYgL9Fmt74oELjP40JYnm60WR82rFbI0SV0/89fIOm18G5fN
         8WIsEAOFy0BeSbjBJTJw0Z5uIytKO65jQ4QWiN8taDSsiWhckM0U2hNLoKLOPknHLJ/I
         2ZkbLSuPBWtso0CjSfNeoq9Eh2/vXKXKnZ71G72Yl6MjhZE/Gtsdg850pqg74eQD6slc
         U7bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nCaTaGyflXG3dvr5xp0v7HTcUoryUfnRTZVHXazf9SQ=;
        b=TZ0SUzq8JnW5XAhcpj3T1Y1zWAxxvNL5tqQ60sD898Mh6oPbQ5GtiipPl5StILvHt3
         nsvr5dCNh/ygK3msOKIMvnbzgnXVroDNiXHxuj/1xeB4C4V1G8YX5NxyK/K/OyTaQq7q
         3/Ju+jtfV5+M7o8hNtNVGVE7hVJqY2o4GxCxNEpdIkd7c/4RdQAc++itRnzXvZi5B/UC
         uJYCG0U6YGvR/xE0O7/tV508k1IJi39JEkzCAYEIX0UWK1Ld8FoGMYLfeGTiCDOhiad0
         wpn7aF9k1K5+tHwCykOPniVWqnqsIXfYnSwE0Tp8c99NiU8Asc4DpIGvjweXEmgEv1HK
         VVMQ==
X-Gm-Message-State: AJIora+gU+/GA/36N6NXc2YjXVBTlSKXbzTFXs9axTAopIoapBmnZ4BV
        K/56JyhrBVC+xIgMevb+ExIpWw==
X-Google-Smtp-Source: AGRyM1sYI7v4EqraDKGTgw+O4t7K1E3xnbvikf7chQUzLy8p2hbSKJO20908xhnU5KtlwQbdawXR1Q==
X-Received: by 2002:ac2:5319:0:b0:485:55b0:7fdd with SMTP id c25-20020ac25319000000b0048555b07fddmr6508568lfh.264.1657201656311;
        Thu, 07 Jul 2022 06:47:36 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id u22-20020a197916000000b0047fa941067fsm6856966lfc.29.2022.07.07.06.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 06:47:35 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        Johan Hovold <johan@kernel.org>, Rob Herring <robh@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v17 2/6] PCI: dwc: Convert msi_irq to the array
Date:   Thu,  7 Jul 2022 16:47:29 +0300
Message-Id: <20220707134733.2436629-3-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220707134733.2436629-1-dmitry.baryshkov@linaro.org>
References: <20220707134733.2436629-1-dmitry.baryshkov@linaro.org>
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

Qualcomm version of DWC PCIe controller supports more than 32 MSI
interrupts, but they are routed to separate interrupts in groups of 32
vectors. To support such configuration, change the msi_irq field into an
array. Let the DWC core handle all interrupts that were set in this
array.

Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/pci/controller/dwc/pci-dra7xx.c       |  2 +-
 drivers/pci/controller/dwc/pci-exynos.c       |  2 +-
 .../pci/controller/dwc/pcie-designware-host.c | 32 ++++++++++++-------
 drivers/pci/controller/dwc/pcie-designware.h  |  2 +-
 drivers/pci/controller/dwc/pcie-keembay.c     |  2 +-
 drivers/pci/controller/dwc/pcie-spear13xx.c   |  2 +-
 drivers/pci/controller/dwc/pcie-tegra194.c    |  2 +-
 7 files changed, 26 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
index a174b680b2a7..e2a6e18e533c 100644
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
index 2044d191fba6..2ede426e3295 100644
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
index 49f1a786404e..33fe75a78416 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -257,8 +257,12 @@ int dw_pcie_allocate_domains(struct dw_pcie_rp *pp)
 
 static void dw_pcie_free_msi(struct dw_pcie_rp *pp)
 {
-	if (pp->msi_irq > 0)
-		irq_set_chained_handler_and_data(pp->msi_irq, NULL, NULL);
+	u32 ctrl;
+
+	for (ctrl = 0; ctrl < MAX_MSI_CTRLS; ctrl++) {
+		if (pp->msi_irq[ctrl] > 0)
+			irq_set_chained_handler_and_data(pp->msi_irq[ctrl], NULL, NULL);
+	}
 
 	irq_domain_remove(pp->msi_domain);
 	irq_domain_remove(pp->irq_domain);
@@ -369,13 +373,15 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
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
@@ -384,10 +390,12 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
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
 
 			ret = dma_set_mask(dev, DMA_BIT_MASK(32));
 			if (ret)
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 258244da5ff1..9542dda93a5d 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -188,7 +188,7 @@ struct dw_pcie_rp {
 	u32			io_size;
 	int			irq;
 	const struct dw_pcie_host_ops *ops;
-	int			msi_irq;
+	int			msi_irq[MAX_MSI_CTRLS];
 	struct irq_domain	*irq_domain;
 	struct irq_domain	*msi_domain;
 	dma_addr_t		msi_data;
diff --git a/drivers/pci/controller/dwc/pcie-keembay.c b/drivers/pci/controller/dwc/pcie-keembay.c
index 58f3caf75cff..f90f36bac018 100644
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
index 7fd698da144e..9d933e0e12e6 100644
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
index 8c63eae37c78..2694f4b0faf7 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -2263,7 +2263,7 @@ static void tegra194_pcie_shutdown(struct platform_device *pdev)
 
 	disable_irq(pcie->pci.pp.irq);
 	if (IS_ENABLED(CONFIG_PCI_MSI))
-		disable_irq(pcie->pci.pp.msi_irq);
+		disable_irq(pcie->pci.pp.msi_irq[0]);
 
 	tegra194_pcie_pme_turnoff(pcie);
 	tegra_pcie_unconfig_controller(pcie);
-- 
2.35.1

