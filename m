Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 084984FF7C8
	for <lists+linux-pci@lfdr.de>; Wed, 13 Apr 2022 15:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235814AbiDMNkZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Apr 2022 09:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235816AbiDMNkX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Apr 2022 09:40:23 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B977B5F240;
        Wed, 13 Apr 2022 06:38:01 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id c1so1607535qvl.3;
        Wed, 13 Apr 2022 06:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BG2CzCPsxTacBK2Hm53pzASbB7sL/kn/FNomuFfzr4s=;
        b=GCUNnePEjrXP7EsqiO7hJ0SYR2SMrq2z9jcgA//gFjxr0v5s2jE2o68g+9Cc0LRM6I
         tIXhsLHNJilFnPkNTrNY5zNjpA/Y22cgvAykzHKJKux2R6kE9ozK2xHjnizUW+bbQ0aN
         aaXOl4XM2Aq5hfWHiq6F06A2dbZURvoZt3lT/0U62thvkuTUz6k1l+M1uXTlctCHEoE/
         bsXsuYSa9AMtCEIvZeP9tXC9MK/a2FINyFvfBmbYciT25058gwhqbdF6v9QHPTT35bf1
         74IElBS/My/TUTCp3aC3wuKki1dBC1qR9XozrYvLTKbZ3Ukry6/qUd5yDjp/02+0eYHk
         3u7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BG2CzCPsxTacBK2Hm53pzASbB7sL/kn/FNomuFfzr4s=;
        b=E1+NlOdAYMKFPuZcQ9ndTofElsvbP//yEojOCoLODGMOF63oQpAvp2PnpGkQ8ZfFpy
         aAgMrEoTYZOSnvrbn/Uk0S+8i3eaBQy90lL43nxLhXDioTaqJM2vdnDs4xSveL5/jPLw
         zXPaPwyWRGQvePas4CO6biHtr8fpwVQqpWn9VkufM4z9YD7JnB90eXIQ2XngziRf3is7
         j1vOgzbP3SPRJhhXxOf+KeY/rLSKBMEzp7j1F/bAgi8e1vsUI0Jpnp++AGm6ejqYR5T/
         XFLJ61YTFyXWDmmayQdt7H1XZEZgJnjqTf1QP3jwSKtOCfdRnfqjeRrlsKlDH8B9shUu
         WGAQ==
X-Gm-Message-State: AOAM533HmvXU41iBaCVWdqY0Z1+DrXzLN3TVzoPJ1yeYqnVi31yvOq8y
        nsRL+uzGOr2G9TESR2+1r7A=
X-Google-Smtp-Source: ABdhPJxtrkeHLH5/aBPflSAvm/9GsIMSUWd9xlXbmNLpZwXqAxEI9l7arktBHaS14DMzxpoxQR9X7g==
X-Received: by 2002:a0c:c692:0:b0:443:f22e:520 with SMTP id d18-20020a0cc692000000b00443f22e0520mr33358025qvj.96.1649857080634;
        Wed, 13 Apr 2022 06:38:00 -0700 (PDT)
Received: from master-x64.sparksnet ([2601:153:980:85b1::10])
        by smtp.gmail.com with ESMTPSA id 143-20020a370795000000b0069c59e1b8eesm790584qkh.10.2022.04.13.06.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 06:38:00 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     linux-rockchip@lists.infradead.org,
        Peter Geis <pgwipeout@gmail.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] PCI: dwc: rockchip: add legacy interrupt support
Date:   Wed, 13 Apr 2022 09:37:29 -0400
Message-Id: <20220413133731.242870-3-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220413133731.242870-1-pgwipeout@gmail.com>
References: <20220413133731.242870-1-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The legacy interrupts on the rk356x pcie controller are handled by a
single muxed interrupt. Add irq domain support to the pcie-dw-rockchip
driver to support the virtual domain.

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 123 +++++++++++++++++-
 1 file changed, 121 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index c9b341e55cbb..a8b1dc03d3cc 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -10,9 +10,12 @@
 
 #include <linux/clk.h>
 #include <linux/gpio/consumer.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/irqdomain.h>
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
+#include <linux/of_irq.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
@@ -36,10 +39,13 @@
 #define PCIE_LINKUP			(PCIE_SMLH_LINKUP | PCIE_RDLH_LINKUP)
 #define PCIE_L0S_ENTRY			0x11
 #define PCIE_CLIENT_GENERAL_CONTROL	0x0
+#define PCIE_CLIENT_INTR_STATUS_LEGACY	0x8
+#define PCIE_CLIENT_INTR_MASK_LEGACY	0x1c
 #define PCIE_CLIENT_GENERAL_DEBUG	0x104
-#define PCIE_CLIENT_HOT_RESET_CTRL      0x180
+#define PCIE_CLIENT_HOT_RESET_CTRL	0x180
 #define PCIE_CLIENT_LTSSM_STATUS	0x300
-#define PCIE_LTSSM_ENABLE_ENHANCE       BIT(4)
+#define PCIE_LEGACY_INT_ENABLE		GENMASK(3, 0)
+#define PCIE_LTSSM_ENABLE_ENHANCE	BIT(4)
 #define PCIE_LTSSM_STATUS_MASK		GENMASK(5, 0)
 
 struct rockchip_pcie {
@@ -51,6 +57,8 @@ struct rockchip_pcie {
 	struct reset_control		*rst;
 	struct gpio_desc		*rst_gpio;
 	struct regulator                *vpcie3v3;
+	struct irq_domain		*irq_domain;
+	raw_spinlock_t			irq_lock;
 };
 
 static int rockchip_pcie_readl_apb(struct rockchip_pcie *rockchip,
@@ -65,6 +73,105 @@ static void rockchip_pcie_writel_apb(struct rockchip_pcie *rockchip,
 	writel_relaxed(val, rockchip->apb_base + reg);
 }
 
+static void rockchip_pcie_legacy_int_handler(struct irq_desc *desc)
+{
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	struct rockchip_pcie *rockchip = irq_desc_get_handler_data(desc);
+	struct device *dev = rockchip->pci.dev;
+	u32 reg;
+	u32 hwirq;
+	u32 virq;
+
+	chained_irq_enter(chip, desc);
+
+	reg = rockchip_pcie_readl_apb(rockchip, PCIE_CLIENT_INTR_STATUS_LEGACY);
+
+	while (reg) {
+		hwirq = ffs(reg) - 1;
+		reg &= ~BIT(hwirq);
+
+		virq = irq_find_mapping(rockchip->irq_domain, hwirq);
+		if (virq)
+			generic_handle_irq(virq);
+		else
+			dev_err(dev, "unexpected IRQ, INT%d\n", hwirq);
+	}
+
+	chained_irq_exit(chip, desc);
+}
+
+static void rockchip_intx_mask(struct irq_data *data)
+{
+	struct rockchip_pcie *rockchip = irq_data_get_irq_chip_data(data);
+	unsigned long flags;
+	u32 val;
+
+	/* disable legacy interrupts */
+	raw_spin_lock_irqsave(&rockchip->irq_lock, flags);
+	val = HIWORD_UPDATE_BIT(PCIE_LEGACY_INT_ENABLE);
+	val |= PCIE_LEGACY_INT_ENABLE;
+	rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_INTR_MASK_LEGACY);
+	raw_spin_unlock_irqrestore(&rockchip->irq_lock, flags);
+};
+
+static void rockchip_intx_unmask(struct irq_data *data)
+{
+	struct rockchip_pcie *rockchip = irq_data_get_irq_chip_data(data);
+	unsigned long flags;
+	u32 val;
+
+	/* enable legacy interrupts */
+	raw_spin_lock_irqsave(&rockchip->irq_lock, flags);
+	val = HIWORD_UPDATE_BIT(PCIE_LEGACY_INT_ENABLE);
+	val &= ~PCIE_LEGACY_INT_ENABLE;
+	rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_INTR_MASK_LEGACY);
+	raw_spin_unlock_irqrestore(&rockchip->irq_lock, flags);
+};
+
+static struct irq_chip rockchip_intx_irq_chip = {
+	.flags			= IRQCHIP_SKIP_SET_WAKE | IRQCHIP_MASK_ON_SUSPEND,
+	.irq_mask		= rockchip_intx_mask,
+	.irq_unmask		= rockchip_intx_unmask,
+	.name			= "INTx",
+};
+
+static int rockchip_pcie_intx_map(struct irq_domain *domain, unsigned int irq,
+				  irq_hw_number_t hwirq)
+{
+	irq_set_chip_and_handler(irq, &rockchip_intx_irq_chip, handle_simple_irq);
+	irq_set_chip_data(irq, domain->host_data);
+
+	return 0;
+}
+
+static const struct irq_domain_ops intx_domain_ops = {
+	.map = rockchip_pcie_intx_map,
+};
+
+static int rockchip_pcie_init_irq_domain(struct rockchip_pcie *rockchip)
+{
+	struct device *dev = rockchip->pci.dev;
+	struct device_node *intc;
+
+	raw_spin_lock_init(&rockchip->irq_lock);
+
+	intc = of_get_child_by_name(dev->of_node, "legacy-interrupt-controller");
+	if (!intc) {
+		dev_err(dev, "missing child interrupt-controller node\n");
+		return -EINVAL;
+	}
+
+	rockchip->irq_domain = irq_domain_add_linear(intc, PCI_NUM_INTX,
+						    &intx_domain_ops, rockchip);
+	of_node_put(intc);
+	if (!rockchip->irq_domain) {
+		dev_err(dev, "failed to get a INTx IRQ domain\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static void rockchip_pcie_enable_ltssm(struct rockchip_pcie *rockchip)
 {
 	rockchip_pcie_writel_apb(rockchip, PCIE_CLIENT_ENABLE_LTSSM,
@@ -111,7 +218,19 @@ static int rockchip_pcie_host_init(struct pcie_port *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct rockchip_pcie *rockchip = to_rockchip_pcie(pci);
+	struct device *dev = rockchip->pci.dev;
 	u32 val = HIWORD_UPDATE_BIT(PCIE_LTSSM_ENABLE_ENHANCE);
+	int irq, ret;
+
+	irq = of_irq_get_byname(dev->of_node, "legacy");
+	if (irq < 0)
+		return irq;
+
+	irq_set_chained_handler_and_data(irq, rockchip_pcie_legacy_int_handler, rockchip);
+
+	ret = rockchip_pcie_init_irq_domain(rockchip);
+	if (ret < 0)
+		dev_err(dev, "failed to init irq domain\n");
 
 	/* LTSSM enable control mode */
 	rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_HOT_RESET_CTRL);
-- 
2.25.1

