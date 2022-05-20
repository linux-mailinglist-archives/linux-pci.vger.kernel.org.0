Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A55252F2C1
	for <lists+linux-pci@lfdr.de>; Fri, 20 May 2022 20:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352737AbiETSbz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 May 2022 14:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350126AbiETSbx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 May 2022 14:31:53 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F0D15FEF
        for <linux-pci@vger.kernel.org>; Fri, 20 May 2022 11:31:20 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id w14so15703766lfl.13
        for <linux-pci@vger.kernel.org>; Fri, 20 May 2022 11:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ehKk4ge3DC9pykbdkeYI6agoIdBh2fm+WXac8dMgbuk=;
        b=RsNJsAoO2U7e6heVUepbYxwGvu5Cbm3FWTgFvKqKnrlDKK5/tg3pr7baK/5RlW9HOc
         IU9JJCVvZBh0taS7K4R+OCtfwt735iIdv/otwQVia8mCOVhn0fWmcYnmqwZESKbV+PAr
         TOHS/3x6odWW82RXs2MH2fq7v3ZAgri9ioGMi3IaCpIegRYd/DCgIXQJRXrZEWJLL/Fz
         Xn0dVujWsLhjBY8wuOPHqIPCe2lECquC2CpaIjPkmel6rwuZHy0hSjhU1s4R61n7PRBj
         rRysajYZ5rAK/un8Tzpcv6P8NAhlb0dHvzla3PGlR2OHGidMSKAB3Mcowz9z1SO35ZEy
         RBbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ehKk4ge3DC9pykbdkeYI6agoIdBh2fm+WXac8dMgbuk=;
        b=PEZYvNXYOLaSIjX76H4dZles+ZppmQKQ9EXSrDEJzqnD8bu/EbgQ2QuuIF+8c2wRy/
         7JSQw05/7nb5fmBFC/93V7Tdm/up+hlawYRvlG8Lp131iD9m/I7ylbmb3w7LusYQKi/w
         pu7VwmeJ3QRFMoGBcbw++qDjdGPHCL7xpXmu/41ZEXzioNftoBVNsOkEV/FQYQD9mxaP
         ISi7RK9cj5tUDhKXBMXKUir5vmvoV3bBR+pkwWdQH30lwPfT8D0C07dU6ar7MO62nbwg
         9EU50W/r3WEnWGAAlaht/nrXyKwvBYFnYBnolU2Vgxoa00H6QtuWVFlLQ7JRr3e5w2hq
         VxYQ==
X-Gm-Message-State: AOAM530XYGCElbjm7/LQmQz5F5IHkY0B9h8pyfYHcidMbahMpPTQScID
        AAZ7hkrei2Ji1l7wHWbZBU5PEQ==
X-Google-Smtp-Source: ABdhPJz5DYkp5Ae7cFMYg9nBzKsIWBR55YDrF0SrvdINp0SEbNEO3CaKydcRKBLAJIsOywkPlyNdAQ==
X-Received: by 2002:ac2:4e6c:0:b0:477:b6c7:25fd with SMTP id y12-20020ac24e6c000000b00477b6c725fdmr7669591lfs.240.1653071479160;
        Fri, 20 May 2022 11:31:19 -0700 (PDT)
Received: from eriador.lan ([2001:470:dd84:abc0::8a5])
        by smtp.gmail.com with ESMTPSA id t22-20020a2e9556000000b0024f3d1daef4sm392951ljh.124.2022.05.20.11.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 11:31:18 -0700 (PDT)
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
Subject: [PATCH v11 1/7] PCI: dwc: Convert msi_irq to the array
Date:   Fri, 20 May 2022 21:31:08 +0300
Message-Id: <20220520183114.1356599-2-dmitry.baryshkov@linaro.org>
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
index af91fe69f542..8dd913f69de7 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -257,8 +257,11 @@ int dw_pcie_allocate_domains(struct pcie_port *pp)
 
 static void dw_pcie_free_msi(struct pcie_port *pp)
 {
-	if (pp->msi_irq > 0)
-		irq_set_chained_handler_and_data(pp->msi_irq, NULL, NULL);
+	u32 ctrl;
+
+	for (ctrl = 0; ctrl < MAX_MSI_CTRLS; ctrl++)
+		if (pp->msi_irq[ctrl] > 0)
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
index cc2678490162..7056072637ab 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -2262,7 +2262,7 @@ static void tegra194_pcie_shutdown(struct platform_device *pdev)
 
 	disable_irq(pcie->pci.pp.irq);
 	if (IS_ENABLED(CONFIG_PCI_MSI))
-		disable_irq(pcie->pci.pp.msi_irq);
+		disable_irq(pcie->pci.pp.msi_irq[0]);
 
 	tegra194_pcie_pme_turnoff(pcie);
 	tegra_pcie_unconfig_controller(pcie);
-- 
2.35.1

