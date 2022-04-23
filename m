Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D04CF50CBB9
	for <lists+linux-pci@lfdr.de>; Sat, 23 Apr 2022 17:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233399AbiDWP1K (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 23 Apr 2022 11:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233329AbiDWP1H (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 23 Apr 2022 11:27:07 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B159734B98;
        Sat, 23 Apr 2022 08:24:10 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d9so7542489qty.12;
        Sat, 23 Apr 2022 08:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rU0TJJku8+YENusDzm4l45KX4x5KwoK0t+MJowhYnC8=;
        b=VhIL0BFeAIoyBNQoDbCkYQDVSKWPAq63XnGyZExo4QeUAVQYKYhRFuDUrPVLJ8LSZJ
         Z0zy9KjcYwJu7FkVNa7lyZyqVhMXyeRHwJExNxxE75SpTNAumJEru3RVn6Ppk5ctjJ1j
         WWtlmeggmhiB4ZNSvH5K51kFedIdy0wFPLXv5HAyUq8GYNvpocWqHGGoIff4qCqWgDNn
         CYVL465diUUsCxnq9f1ui0mwhmJ08fPzXlLxyTPUqBlBrKo3uKTJwpmrRye0B5grOn1M
         woTBPrLtnJ+HP9YynTh2EDJvpPpiCIFapYXU06enq3XIJtvCE72JQuFwO5KM//C2kuxd
         R9Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rU0TJJku8+YENusDzm4l45KX4x5KwoK0t+MJowhYnC8=;
        b=o69CKZ49CnN8qNa9XejFdI2U62xU0oYbbfewlJdceXcvKdjB0RVGJy6JQ2QzQ7PLBW
         SzF8cDt3enkCd/7f5ee06JPt3DVfYPihUifVHseGDzAJ5qiG3EPxeKFrAAWG33c2Bikn
         rA6RqQwHmhiOtkBvgLWfds9CLq/LHhwkNAsBww6MWJr3YL3nvilbV44pDQK+SVZWwDFI
         hh0KsznHEdw9qC8LNcOIBxtr/xmTdFl5OQJnUTL/THb/fklJKIcO4xNsIpVDM29z1+gv
         yC7CoITgywcnaIAnf8VYEaJGGZ/8aC0L7ILMLBUXRxz6G43hlhKRdiqrLgQIAaiIEeVu
         1stQ==
X-Gm-Message-State: AOAM5301BGvNNzsSONAHUf+YJ7E07Wf0fOUJNJUUvwdAsBqgADJbFa8l
        fEM9LTLpdJsZXOTkH07HS5lc7EAmJjXaKw==
X-Google-Smtp-Source: ABdhPJxSACknhS4BS8uZnPnHXXRH3m70HA1DfFwJtQR5X4zDul3MOBemOAWhZrDurCSAYqDgPWELTA==
X-Received: by 2002:a05:622a:1706:b0:2f1:f945:1c39 with SMTP id h6-20020a05622a170600b002f1f9451c39mr6812261qtk.417.1650727449823;
        Sat, 23 Apr 2022 08:24:09 -0700 (PDT)
Received: from master-x64.sparksnet ([2601:153:980:85b1::10])
        by smtp.gmail.com with ESMTPSA id y6-20020a05622a004600b002f33ba280cbsm3184165qtw.8.2022.04.23.08.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 08:24:09 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     linux-rockchip@lists.infradead.org,
        Peter Geis <pgwipeout@gmail.com>,
        Marc Zyngier <maz@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 3/5] PCI: dwc: rockchip: add legacy interrupt support
Date:   Sat, 23 Apr 2022 11:24:01 -0400
Message-Id: <20220423152403.1681222-4-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220423152403.1681222-1-pgwipeout@gmail.com>
References: <20220423152403.1681222-1-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 94 ++++++++++++++++++-
 1 file changed, 91 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index d67ed811e752..b00832d653ea 100644
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
@@ -26,6 +29,7 @@
  */
 #define HIWORD_UPDATE(mask, val) (((mask) << 16) | (val))
 #define HIWORD_UPDATE_BIT(val)	HIWORD_UPDATE(val, val)
+#define HIWORD_DISABLE_BIT(val)	HIWORD_UPDATE(val, ~val)
 
 #define to_rockchip_pcie(x) dev_get_drvdata((x)->dev)
 
@@ -36,10 +40,12 @@
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
+#define PCIE_LTSSM_ENABLE_ENHANCE	BIT(4)
 #define PCIE_LTSSM_STATUS_MASK		GENMASK(5, 0)
 
 struct rockchip_pcie {
@@ -51,6 +57,7 @@ struct rockchip_pcie {
 	struct reset_control		*rst;
 	struct gpio_desc		*rst_gpio;
 	struct regulator                *vpcie3v3;
+	struct irq_domain		*irq_domain;
 };
 
 static int rockchip_pcie_readl_apb(struct rockchip_pcie *rockchip,
@@ -65,6 +72,76 @@ static void rockchip_pcie_writel_apb(struct rockchip_pcie *rockchip,
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
+	for_each_set_bit(hwirq, &reg, 4)
+		generic_handle_domain_irq(rockchip->irq_domain, hwirq);
+
+	chained_irq_exit(chip, desc);
+}
+
+static void rockchip_intx_mask(struct irq_data *data)
+{
+	rockchip_pcie_writel_apb(irq_data_get_irq_chip_data(data), HIWORD_UPDATE_BIT(BIT(data->hwirq)),
+				 PCIE_CLIENT_INTR_MASK_LEGACY);
+};
+
+static void rockchip_intx_unmask(struct irq_data *data)
+{
+	rockchip_pcie_writel_apb(irq_data_get_irq_chip_data(data), HIWORD_DISABLE_BIT(BIT(data->hwirq)),
+				 PCIE_CLIENT_INTR_MASK_LEGACY);
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
@@ -111,7 +188,19 @@ static int rockchip_pcie_host_init(struct pcie_port *pp)
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
@@ -158,7 +247,6 @@ static int rockchip_pcie_resource_get(struct platform_device *pdev,
 				     "failed to get reset lines\n");
 
 	return reset_control_assert(rockchip->rst);
-
 }
 
 static int rockchip_pcie_phy_init(struct rockchip_pcie *rockchip)
-- 
2.25.1

