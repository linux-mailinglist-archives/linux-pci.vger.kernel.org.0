Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 054AD4FE84F
	for <lists+linux-pci@lfdr.de>; Tue, 12 Apr 2022 20:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358801AbiDLTAZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Apr 2022 15:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358811AbiDLTAX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Apr 2022 15:00:23 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEFED43AD5;
        Tue, 12 Apr 2022 11:58:02 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id 3so7058444qkj.5;
        Tue, 12 Apr 2022 11:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qOnwkaEGKViV2QJ1JXpZ5IddTHppSw1fGZxu+INfSyI=;
        b=TZmjNKf/0qJBTGgkZltGqOBKg5S0YR+tK17WaFiOwq6nHwdCxAaBYAGfGov++BIdJn
         fWeRCJmWYcXvlvE+6J4czrRnilTz5OV5S6lxmqRtjySXZ/O2LZCudqUKn6upDcU0c/7F
         /lKufz63s6XHtcTwDE8+xwa+i/MMFv3x4eitEl3bFgwOR+A4nCowudePUNSs4aBjyta6
         7GfbSoNTvvYSATbrmd9mpQX2B0nkjzQUBuZJ/D0KAYOvfi+yT/v9WL1Ti8aJCzPQP69v
         4s3SnV3HRdFPvND6TE8cQx3HuT9zZ90GM4cxgTTuf0v13lgxlClFLcU+k6abuR3sP2eW
         llmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qOnwkaEGKViV2QJ1JXpZ5IddTHppSw1fGZxu+INfSyI=;
        b=6Se5oNpNcQ2l128uU7sm0GemlExBBmaSti93mJHW9Zyq55V8GVoURhS61nH+aBFSQM
         r1Hpsz3roiHFKzTcFGqxOODaMe7brS1W9PNvhW/CJo/l49kl1qcTUdJMOfuFShKAwwvG
         qawnMaiMkgsyUdCOAnMQ9Sq39LpEWMHbBG4mLJrTVV8BGJ8VjglsO5VJzRpV2rdC9JJW
         Mk651SE2bPVFpRxLVBF4F4M02MHMug65KUm8nZDWZ4gEaordUq07JYIePyQkcQPZdrES
         TsWzuL1NKPTk5OmOkrK5KphCJPoMW6JXnUsFJ4Y0HmeG7k6CKXBFhU8jjzCiSMAzbcRl
         x3gw==
X-Gm-Message-State: AOAM532Qh8NR39fOyHGDDjwufQG0U7Uot/GYHb695NVAQTU3iq5KFToq
        vEn5kUAgn5YJE/aJD7zqB3M=
X-Google-Smtp-Source: ABdhPJytyARNf+NUo54WSUHWnNsaIESDGWaTpic2NDMrdjhU2sXrVY+MmLuxf5en5VxeRtoTpzuqjw==
X-Received: by 2002:a37:557:0:b0:69c:2490:cd06 with SMTP id 84-20020a370557000000b0069c2490cd06mr4226982qkf.724.1649789881740;
        Tue, 12 Apr 2022 11:58:01 -0700 (PDT)
Received: from master-x64.sparksnet ([2601:153:980:85b1::10])
        by smtp.gmail.com with ESMTPSA id d18-20020a05622a05d200b002f07ed88a54sm1820610qtb.46.2022.04.12.11.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 11:58:01 -0700 (PDT)
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
Subject: [PATCH v1 2/4] PCI: dwc: rockchip: add legacy interrupt support
Date:   Tue, 12 Apr 2022 14:57:49 -0400
Message-Id: <20220412185751.124783-3-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220412185751.124783-1-pgwipeout@gmail.com>
References: <20220412185751.124783-1-pgwipeout@gmail.com>
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
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 92 ++++++++++++++++++-
 1 file changed, 89 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index c9b341e55cbb..d14518039674 100644
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
@@ -36,10 +39,12 @@
 #define PCIE_LINKUP			(PCIE_SMLH_LINKUP | PCIE_RDLH_LINKUP)
 #define PCIE_L0S_ENTRY			0x11
 #define PCIE_CLIENT_GENERAL_CONTROL	0x0
+#define PCIE_CLIENT_INTR_MASK_LEGACY	0x1c
 #define PCIE_CLIENT_GENERAL_DEBUG	0x104
-#define PCIE_CLIENT_HOT_RESET_CTRL      0x180
+#define PCIE_CLIENT_HOT_RESET_CTRL	0x180
 #define PCIE_CLIENT_LTSSM_STATUS	0x300
-#define PCIE_LTSSM_ENABLE_ENHANCE       BIT(4)
+#define PCIE_LEGACY_INT_ENABLE		GENMASK(7, 0)
+#define PCIE_LTSSM_ENABLE_ENHANCE	BIT(4)
 #define PCIE_LTSSM_STATUS_MASK		GENMASK(5, 0)
 
 struct rockchip_pcie {
@@ -51,6 +56,7 @@ struct rockchip_pcie {
 	struct reset_control		*rst;
 	struct gpio_desc		*rst_gpio;
 	struct regulator                *vpcie3v3;
+	struct irq_domain		*irq_domain;
 };
 
 static int rockchip_pcie_readl_apb(struct rockchip_pcie *rockchip,
@@ -65,6 +71,68 @@ static void rockchip_pcie_writel_apb(struct rockchip_pcie *rockchip,
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
+	reg = rockchip_pcie_readl_apb(rockchip, 0x8);
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
+static int rockchip_pcie_intx_map(struct irq_domain *domain, unsigned int irq,
+				  irq_hw_number_t hwirq)
+{
+	irq_set_chip_and_handler(irq, &dummy_irq_chip, handle_simple_irq);
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
@@ -111,9 +179,27 @@ static int rockchip_pcie_host_init(struct pcie_port *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct rockchip_pcie *rockchip = to_rockchip_pcie(pci);
-	u32 val = HIWORD_UPDATE_BIT(PCIE_LTSSM_ENABLE_ENHANCE);
+	struct device *dev = rockchip->pci.dev;
+	int irq, ret;
+	u32 val;
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
+
+	/* enable legacy interrupts */
+	val = HIWORD_UPDATE_BIT(PCIE_LEGACY_INT_ENABLE);
+	val &= ~PCIE_LEGACY_INT_ENABLE;
+	rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_INTR_MASK_LEGACY);
 
 	/* LTSSM enable control mode */
+	val = HIWORD_UPDATE_BIT(PCIE_LTSSM_ENABLE_ENHANCE);
 	rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_HOT_RESET_CTRL);
 
 	rockchip_pcie_writel_apb(rockchip, PCIE_CLIENT_RC_MODE,
-- 
2.25.1

