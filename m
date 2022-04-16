Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80F2A503628
	for <lists+linux-pci@lfdr.de>; Sat, 16 Apr 2022 13:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbiDPLHt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 16 Apr 2022 07:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231616AbiDPLHr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 16 Apr 2022 07:07:47 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F152137027;
        Sat, 16 Apr 2022 04:05:13 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id b189so8148148qkf.11;
        Sat, 16 Apr 2022 04:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2wd9sVHC/mmpYlhb5g3G/iw92sjMjBm/QMls3NoS/gY=;
        b=YlTGFeYjrIrumrZP+5CDlg2AkD0OJl3NYU1RSr68tmG7LUCUH6ZWffvts6Bdzo/7ca
         4XKcK8cY0tWyo5H98SRl6riGPjPy3OVOx3yqk0AGasS8mOC1CP248b2Z0avHgeJrBw6L
         dPJD2pTd+JdghXArj8o0X97w4slG3e12aAZAUO4ykL0cwUCC2NU/V5jIf+oOxPffLHPx
         wFTvM3Rx7/7jQAAailoeItdAZQizaA4My4rwfi+apYs2+lDWZNrwBycqW6fqesw7bsCq
         lYmoTkVxU6ZrIABU92zTIw7WebKZMn9lsSfoVXZQ8OoMAjKKXplwFTg/QE0dLO4+47Ww
         +qow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2wd9sVHC/mmpYlhb5g3G/iw92sjMjBm/QMls3NoS/gY=;
        b=NHkqdnSGDz186dFSMzCJ7tQj33gt1RXk/qYu4s5GOYSP/GHwVWRQoySWym8AGpZ8oa
         3UHynA2ZUGLbL3tgzKjUAFtW5wAibh98zu6TKUCWNt48/wlB7LyzQ9LJZqHlPlgwl0Xb
         EIDsxOjKE1d3hWTr8l6YHOFfKt9amc+Uugay2RHAz87rhxhFM8ESWCsvyVhwbpcVj+Pn
         jJC0vYWhtwb0QbhcnHOMvLwLtviYNgke3pQ31PQxuh2ICWExVI7m8HZPTktjCZDUQ8/A
         4WEAz3ip5gGHXuwAFh2rhZxDCZtQSnNJvfSCLlwqzWho8aRVykQAi7KF1DxuOLZDt1jm
         FE7g==
X-Gm-Message-State: AOAM530t2NxqS4h+T9nO27GGJjW8R41d7zizJ8/glLAMO5hywSVetMYi
        AgPp8Cx5qpcP/VJr2jvSiS4=
X-Google-Smtp-Source: ABdhPJzgP/Su9sVo1WAek3VOvHi3aYFIuz+vrZ6O0feP9a0D2IimwOcRKvjATzNU5fvbJKAMD3h1cQ==
X-Received: by 2002:ae9:ef55:0:b0:69e:7116:8644 with SMTP id d82-20020ae9ef55000000b0069e71168644mr1093833qkg.293.1650107113047;
        Sat, 16 Apr 2022 04:05:13 -0700 (PDT)
Received: from master-x64.sparksnet ([2601:153:980:85b1::10])
        by smtp.gmail.com with ESMTPSA id w6-20020a05622a190600b002f1f91ad3e7sm97026qtc.22.2022.04.16.04.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Apr 2022 04:05:12 -0700 (PDT)
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
Subject: [PATCH v7 2/4] PCI: dwc: rockchip: add legacy interrupt support
Date:   Sat, 16 Apr 2022 07:05:04 -0400
Message-Id: <20220416110507.642398-3-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220416110507.642398-1-pgwipeout@gmail.com>
References: <20220416110507.642398-1-pgwipeout@gmail.com>
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
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 112 +++++++++++++++++-
 1 file changed, 110 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index c9b341e55cbb..863374604fb1 100644
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
@@ -65,6 +73,94 @@ static void rockchip_pcie_writel_apb(struct rockchip_pcie *rockchip,
 	writel_relaxed(val, rockchip->apb_base + reg);
 }
 
+static void rockchip_pcie_legacy_int_handler(struct irq_desc *desc)
+{
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	struct rockchip_pcie *rockchip = irq_desc_get_handler_data(desc);
+	unsigned long reg, hwirq;
+
+	chained_irq_enter(chip, desc);
+
+	reg = rockchip_pcie_readl_apb(rockchip, PCIE_CLIENT_INTR_STATUS_LEGACY);
+
+	for_each_set_bit(hwirq, &reg, 8)
+		generic_handle_domain_irq(rockchip->irq_domain, hwirq);
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
+	.name			= "INTx",
+	.irq_mask		= rockchip_intx_mask,
+	.irq_unmask		= rockchip_intx_unmask,
+	.flags			= IRQCHIP_SKIP_SET_WAKE | IRQCHIP_MASK_ON_SUSPEND,
+};
+
+static int rockchip_pcie_intx_map(struct irq_domain *domain, unsigned int irq,
+				  irq_hw_number_t hwirq)
+{
+	irq_set_chip_and_handler(irq, &rockchip_intx_irq_chip, handle_level_irq);
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
@@ -111,7 +207,19 @@ static int rockchip_pcie_host_init(struct pcie_port *pp)
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
+	ret = rockchip_pcie_init_irq_domain(rockchip);
+	if (ret < 0)
+		dev_err(dev, "failed to init irq domain\n");
+
+	irq_set_chained_handler_and_data(irq, rockchip_pcie_legacy_int_handler, rockchip);
 
 	/* LTSSM enable control mode */
 	rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_HOT_RESET_CTRL);
-- 
2.25.1

