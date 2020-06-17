Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFB111FCAD6
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jun 2020 12:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgFQK0U (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Jun 2020 06:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbgFQK0D (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Jun 2020 06:26:03 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91249C061573;
        Wed, 17 Jun 2020 03:26:03 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id x13so1745645wrv.4;
        Wed, 17 Jun 2020 03:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Mh8V3Bx8waCvIBMkNX20uyDu/AK0B44RrWchoemTUhs=;
        b=Cw3j6hbEIYmFIBz3zHpxGKni+5ULrof4lVfpxpEzOY9hCF6SdwKsHtySTaVKguzbyC
         qfJ9tJhOZR41m6Ch7/3W0WgA4x45430LFIFxY4d8CHTxsbherAPF4V6Vx5B8V2DJmqOp
         zWlKXHAm/s1+ZtgxjUafwWC9tSLRtXA48M2BYwCDKcI63N0T5Man06j9vtoYC0JIvIyc
         Veco6QhZCGKmHz/CaSiAkcEYeipzIoLGlpCwYmem1JjSuEheOhssW7sCjIKJNj6Ycw59
         lawpToZ28Sh/wt0/5gJ1QLIXLtoCNetwdbziwVoKqRPduVRTzUuL102MMGQhlsm7RElN
         eTzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mh8V3Bx8waCvIBMkNX20uyDu/AK0B44RrWchoemTUhs=;
        b=ip2/uCC2wrsmKVZibYm/yk6VcmvxB5MDBli+cUQvzIFj25AvuwFcuV1NbPPx1UQj5T
         qrytf4I2nSamXvbSktzaNiaW3c7p9egAcWT8Yxf6H4dtETjlkICrVeMuAYJI6Ht8Ro75
         NpnbBnoC969iUdLedErdE4YnBiPRwR0psrAPCuQUePu35XIZwVfNJ/v+Im97NrIp/G9u
         gLk7DB9faqFTU884wpM4lg/sEVGc00VK06MjNdItovSrAy0wVF0QXTp8zWvjW4TCZuKq
         J8dJDrqHlPHT6NwDczis8fW3mXEO6acN0Y1OGZ3YYoa1ADW1oe9eKI51yBImilSntJ/K
         nkaw==
X-Gm-Message-State: AOAM532fTjkM/sdUyyRfWfpUW9AnMB+FTVrqhiHQ77vFPFYGPcINvY1Z
        0CREPK9XCPfUdU08ipBQGeE=
X-Google-Smtp-Source: ABdhPJwBlhdTnIWXh+vDsaDd6RoabQqe6p+vfUGlBnXKcI/Qp9GZlEikoDEwIdDsaNgVRbUfUTihlw==
X-Received: by 2002:a05:6000:1104:: with SMTP id z4mr7645392wrw.272.1592389562045;
        Wed, 17 Jun 2020 03:26:02 -0700 (PDT)
Received: from skynet.lan (90.red-88-20-62.staticip.rima-tde.net. [88.20.62.90])
        by smtp.gmail.com with ESMTPSA id z206sm7569847wmg.30.2020.06.17.03.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 03:26:01 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     bhelgaas@google.com, robh+dt@kernel.org, tsbogend@alpha.franken.de,
        lorenzo.pieralisi@arm.com, p.zabel@pengutronix.de,
        jiaxun.yang@flygoat.com, paulburton@kernel.org, info@metux.net,
        allison@lohutok.net, kstewart@linuxfoundation.org,
        tglx@linutronix.de, jonas.gorski@gmail.com, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH 3/3] pci: add BCM6328 PCIe controller support
Date:   Wed, 17 Jun 2020 12:25:56 +0200
Message-Id: <20200617102556.3792821-4-noltari@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200617102556.3792821-1-noltari@gmail.com>
References: <20200617102556.3792821-1-noltari@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

BCM6328 PCIe host controller is found on BCM6328, BCM6362 and BCM63268 SoCs.

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
 drivers/pci/controller/Kconfig        |   8 +
 drivers/pci/controller/Makefile       |   1 +
 drivers/pci/controller/pcie-bcm6328.c | 346 ++++++++++++++++++++++++++
 3 files changed, 355 insertions(+)
 create mode 100644 drivers/pci/controller/pcie-bcm6328.c

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index adddf21fa381..7e238c04764e 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -3,6 +3,14 @@
 menu "PCI controller drivers"
 	depends on PCI
 
+config PCIE_BCM6328
+	bool "BCM6328 PCIe controller"
+	depends on BMIPS_GENERIC || COMPILE_TEST
+	depends on OF
+	help
+	  Say Y here if you want support for the PCIe host controller found
+	  on BCM6328, BCM6362 and BCM63268 SoCs.
+
 config PCI_MVEBU
 	bool "Marvell EBU PCIe controller"
 	depends on ARCH_MVEBU || ARCH_DOVE || COMPILE_TEST
diff --git a/drivers/pci/controller/Makefile b/drivers/pci/controller/Makefile
index efd9733ead26..1c3e82575845 100644
--- a/drivers/pci/controller/Makefile
+++ b/drivers/pci/controller/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_PCIE_BCM6328) += pcie-bcm6328.o
 obj-$(CONFIG_PCIE_CADENCE) += cadence/
 obj-$(CONFIG_PCI_FTPCI100) += pci-ftpci100.o
 obj-$(CONFIG_PCI_HYPERV) += pci-hyperv.o
diff --git a/drivers/pci/controller/pcie-bcm6328.c b/drivers/pci/controller/pcie-bcm6328.c
new file mode 100644
index 000000000000..5bd86b166336
--- /dev/null
+++ b/drivers/pci/controller/pcie-bcm6328.c
@@ -0,0 +1,346 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * BCM6328 PCIe Controller Driver
+ *
+ * Copyright (C) 2020 Álvaro Fernández Rojas <noltari@gmail.com>
+ * Copyright (C) 2015 Jonas Gorski <jonas.gorski@gmail.com>
+ * Copyright (C) 2008 Maxime Bizon <mbizon@freebox.fr>
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/kernel.h>
+#include <linux/mfd/syscon.h>
+#include <linux/of_pci.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/reset.h>
+
+#include "../pci.h"
+
+#define SERDES_PCIE_EN			BIT(0)
+#define SERDES_PCIE_EXD_EN		BIT(15)
+
+#define PCIE_BUS_BRIDGE			0
+#define PCIE_BUS_DEVICE			1
+
+#define PCIE_CONFIG2_REG		0x408
+#define CONFIG2_BAR1_SIZE_EN		1
+#define CONFIG2_BAR1_SIZE_MASK		0xf
+
+#define PCIE_IDVAL3_REG			0x43c
+#define IDVAL3_CLASS_CODE_MASK		0xffffff
+#define IDVAL3_SUBCLASS_SHIFT		8
+#define IDVAL3_CLASS_SHIFT		16
+
+#define PCIE_DLSTATUS_REG		0x1048
+#define DLSTATUS_PHYLINKUP		BIT(13)
+
+#define PCIE_BRIDGE_OPT1_REG		0x2820
+#define OPT1_RD_BE_OPT_EN		BIT(7)
+#define OPT1_RD_REPLY_BE_FIX_EN		BIT(9)
+#define OPT1_PCIE_BRIDGE_HOLE_DET_EN	BIT(11)
+#define OPT1_L1_INT_STATUS_MASK_POL	BIT(12)
+
+#define PCIE_BRIDGE_OPT2_REG		0x2824
+#define OPT2_UBUS_UR_DECODE_DIS		BIT(2)
+#define OPT2_TX_CREDIT_CHK_EN		BIT(4)
+#define OPT2_CFG_TYPE1_BD_SEL		BIT(7)
+#define OPT2_CFG_TYPE1_BUS_NO_SHIFT	16
+#define OPT2_CFG_TYPE1_BUS_NO_MASK	(0xff << OPT2_CFG_TYPE1_BUS_NO_SHIFT)
+
+#define PCIE_BRIDGE_BAR0_BASEMASK_REG	0x2828
+#define BASEMASK_REMAP_EN		BIT(0)
+#define BASEMASK_SWAP_EN		BIT(1)
+#define BASEMASK_MASK_SHIFT		4
+#define BASEMASK_MASK_MASK		(0xfff << BASEMASK_MASK_SHIFT)
+#define BASEMASK_BASE_SHIFT		20
+#define BASEMASK_BASE_MASK		(0xfff << BASEMASK_BASE_SHIFT)
+
+#define PCIE_BRIDGE_BAR0_REBASE_ADDR_REG 0x282c
+#define REBASE_ADDR_BASE_SHIFT		20
+#define REBASE_ADDR_BASE_MASK		(0xfff << REBASE_ADDR_BASE_SHIFT)
+
+#define PCIE_BRIDGE_RC_INT_MASK_REG	0x2854
+#define PCIE_RC_INT_A			BIT(0)
+#define PCIE_RC_INT_B			BIT(1)
+#define PCIE_RC_INT_C			BIT(2)
+#define PCIE_RC_INT_D			BIT(3)
+
+#define PCIE_DEVICE_OFFSET		0x8000
+
+struct bcm6328_pcie {
+	void __iomem *base;
+	struct regmap *serdes;
+	struct clk *clk;
+	struct reset_control *reset;
+	struct reset_control *reset_ext;
+	struct reset_control *reset_core;
+	struct reset_control *reset_hard;
+};
+
+static struct bcm6328_pcie bcm6328_pcie;
+
+/*
+ * swizzle 32bits data to return only the needed part
+ */
+static int postprocess_read(u32 data, int where, unsigned int size)
+{
+	u32 ret = 0;
+
+	switch (size) {
+	case 1:
+		ret = (data >> ((where & 3) << 3)) & 0xff;
+		break;
+	case 2:
+		ret = (data >> ((where & 3) << 3)) & 0xffff;
+		break;
+	case 4:
+		ret = data;
+		break;
+	}
+
+	return ret;
+}
+
+static int preprocess_write(u32 orig_data, u32 val, int where,
+			    unsigned int size)
+{
+	u32 ret = 0;
+
+	switch (size) {
+	case 1:
+		ret = (orig_data & ~(0xff << ((where & 3) << 3))) |
+		      (val << ((where & 3) << 3));
+		break;
+	case 2:
+		ret = (orig_data & ~(0xffff << ((where & 3) << 3))) |
+		      (val << ((where & 3) << 3));
+		break;
+	case 4:
+		ret = val;
+		break;
+	}
+
+	return ret;
+}
+
+static int bcm6328_pcie_can_access(struct pci_bus *bus, int devfn)
+{
+	struct bcm6328_pcie *priv = &bcm6328_pcie;
+
+	switch (bus->number) {
+	case PCIE_BUS_BRIDGE:
+		return PCI_SLOT(devfn) == 0;
+	case PCIE_BUS_DEVICE:
+		if (PCI_SLOT(devfn) == 0)
+			return __raw_readl(priv->base + PCIE_DLSTATUS_REG)
+			       & DLSTATUS_PHYLINKUP;
+		/* fall through */
+	default:
+		return false;
+	}
+}
+
+static int bcm6328_pcie_read(struct pci_bus *bus, unsigned int devfn,
+			     int where, int size, u32 *val)
+{
+	struct bcm6328_pcie *priv = &bcm6328_pcie;
+	u32 data;
+	u32 reg = where & ~3;
+
+	if (!bcm6328_pcie_can_access(bus, devfn))
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	if (bus->number == PCIE_BUS_DEVICE)
+		reg += PCIE_DEVICE_OFFSET;
+
+	data = __raw_readl(priv->base + reg);
+	*val = postprocess_read(data, where, size);
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static int bcm6328_pcie_write(struct pci_bus *bus, unsigned int devfn,
+			      int where, int size, u32 val)
+{
+	struct bcm6328_pcie *priv = &bcm6328_pcie;
+	u32 data;
+	u32 reg = where & ~3;
+
+	if (!bcm6328_pcie_can_access(bus, devfn))
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	if (bus->number == PCIE_BUS_DEVICE)
+		reg += PCIE_DEVICE_OFFSET;
+
+	data = __raw_readl(priv->base + reg);
+	data = preprocess_write(data, val, where, size);
+	__raw_writel(data, priv->base + reg);
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static struct pci_ops bcm6328_pcie_ops = {
+	.read = bcm6328_pcie_read,
+	.write = bcm6328_pcie_write,
+};
+
+static struct resource bcm6328_pcie_io_resource;
+static struct resource bcm6328_pcie_mem_resource;
+static struct resource bcm6328_pcie_busn_resource;
+
+static struct pci_controller bcm6328_pcie_controller = {
+	.pci_ops = &bcm6328_pcie_ops,
+	.io_resource = &bcm6328_pcie_io_resource,
+	.mem_resource = &bcm6328_pcie_mem_resource,
+	.busn_resource = &bcm6328_pcie_busn_resource,
+};
+
+static void bcm6328_pcie_reset(struct bcm6328_pcie *priv)
+{
+	regmap_write_bits(priv->serdes, 0,
+			  SERDES_PCIE_EN | SERDES_PCIE_EXD_EN,
+			  SERDES_PCIE_EN | SERDES_PCIE_EXD_EN);
+
+	reset_control_assert(priv->reset);
+	reset_control_assert(priv->reset_core);
+	reset_control_assert(priv->reset_ext);
+	if (priv->reset_hard) {
+		reset_control_assert(priv->reset_hard);
+		mdelay(10);
+		reset_control_deassert(priv->reset_hard);
+	}
+	mdelay(10);
+
+	reset_control_deassert(priv->reset_core);
+	reset_control_deassert(priv->reset);
+	mdelay(10);
+
+	reset_control_deassert(priv->reset_ext);
+	mdelay(200);
+}
+
+static void bcm6328_pcie_setup(struct bcm6328_pcie *priv)
+{
+	u32 val;
+
+	val = __raw_readl(priv->base + PCIE_BRIDGE_OPT1_REG);
+	val |= OPT1_RD_BE_OPT_EN;
+	val |= OPT1_RD_REPLY_BE_FIX_EN;
+	val |= OPT1_PCIE_BRIDGE_HOLE_DET_EN;
+	val |= OPT1_L1_INT_STATUS_MASK_POL;
+	__raw_writel(val, priv->base + PCIE_BRIDGE_OPT1_REG);
+
+	val = __raw_readl(priv->base + PCIE_BRIDGE_RC_INT_MASK_REG);
+	val |= PCIE_RC_INT_A;
+	val |= PCIE_RC_INT_B;
+	val |= PCIE_RC_INT_C;
+	val |= PCIE_RC_INT_D;
+	__raw_writel(val, priv->base + PCIE_BRIDGE_RC_INT_MASK_REG);
+
+	val = __raw_readl(priv->base + PCIE_BRIDGE_OPT2_REG);
+	/* enable credit checking and error checking */
+	val |= OPT2_TX_CREDIT_CHK_EN;
+	val |= OPT2_UBUS_UR_DECODE_DIS;
+	/* set device bus/func for the pcie device */
+	val |= (PCIE_BUS_DEVICE << OPT2_CFG_TYPE1_BUS_NO_SHIFT);
+	val |= OPT2_CFG_TYPE1_BD_SEL;
+	__raw_writel(val, priv->base + PCIE_BRIDGE_OPT2_REG);
+
+	/* setup class code as bridge */
+	val = __raw_readl(priv->base + PCIE_IDVAL3_REG);
+	val &= ~IDVAL3_CLASS_CODE_MASK;
+	val |= (PCI_CLASS_BRIDGE_PCI << IDVAL3_SUBCLASS_SHIFT);
+	__raw_writel(val, priv->base + PCIE_IDVAL3_REG);
+
+	/* disable bar1 size */
+	val = __raw_readl(priv->base + PCIE_CONFIG2_REG);
+	val &= ~CONFIG2_BAR1_SIZE_MASK;
+	__raw_writel(val, priv->base + PCIE_CONFIG2_REG);
+
+	/* set bar0 to little endian */
+	val = (bcm6328_pcie_mem_resource.start >> 20)
+	      << BASEMASK_BASE_SHIFT;
+	val |= (bcm6328_pcie_mem_resource.end >> 20) << BASEMASK_MASK_SHIFT;
+	val |= BASEMASK_REMAP_EN;
+	__raw_writel(val, priv->base + PCIE_BRIDGE_BAR0_BASEMASK_REG);
+
+	val = (bcm6328_pcie_mem_resource.start >> 20)
+	      << REBASE_ADDR_BASE_SHIFT;
+	__raw_writel(val, priv->base + PCIE_BRIDGE_BAR0_REBASE_ADDR_REG);
+}
+
+static int bcm6328_pcie_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	struct bcm6328_pcie *priv = &bcm6328_pcie;
+	int ret;
+
+	of_pci_check_probe_only();
+
+	priv->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(priv->base))
+		return PTR_ERR(priv->base);
+
+	priv->serdes = syscon_regmap_lookup_by_phandle(np, "brcm,serdes");
+	if (IS_ERR(priv->serdes))
+		return PTR_ERR(priv->serdes);
+
+	priv->reset = devm_reset_control_get_exclusive(dev, "pcie");
+	if (IS_ERR(priv->reset))
+		return PTR_ERR(priv->reset);
+
+	priv->reset_ext = devm_reset_control_get_exclusive(dev, "pcie-ext");
+	if (IS_ERR(priv->reset_ext))
+		return PTR_ERR(priv->reset_ext);
+
+	priv->reset_core = devm_reset_control_get_exclusive(dev, "pcie-core");
+	if (IS_ERR(priv->reset_core))
+		return PTR_ERR(priv->reset_core);
+
+	priv->reset_hard = devm_reset_control_get_optional_exclusive(dev,
+		"pcie-hard");
+	if (IS_ERR(priv->reset_hard))
+		return PTR_ERR(priv->reset_hard);
+
+	priv->clk = devm_clk_get(dev, "pcie");
+	if (IS_ERR(priv->clk))
+		return PTR_ERR(priv->clk);
+
+	ret = clk_prepare_enable(priv->clk);
+	if (ret) {
+		dev_err(dev, "could not enable clock: %d\n", ret);
+		return ret;
+	}
+
+	pci_load_of_ranges(&bcm6328_pcie_controller, np);
+	if (!bcm6328_pcie_mem_resource.start)
+		return -EINVAL;
+
+	of_pci_parse_bus_range(np, &bcm6328_pcie_busn_resource);
+
+	bcm6328_pcie_reset(priv);
+	bcm6328_pcie_setup(priv);
+
+	register_pci_controller(&bcm6328_pcie_controller);
+
+	return 0;
+}
+
+static const struct of_device_id bcm6328_pcie_of_match[] = {
+	{ .compatible = "brcm,bcm6328-pcie", },
+	{ .compatible = "brcm,bcm6362-pcie", },
+	{ .compatible = "brcm,bcm63268-pcie", },
+	{ /* sentinel */ },
+};
+
+static struct platform_driver bcm6328_pcie_driver = {
+	.driver	= {
+		.name = "bcm6328-pcie",
+		.of_match_table = bcm6328_pcie_of_match,
+	},
+	.probe = bcm6328_pcie_probe,
+};
+builtin_platform_driver(bcm6328_pcie_driver);
-- 
2.27.0

