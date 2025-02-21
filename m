Return-Path: <linux-pci+bounces-21950-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 614F0A3EA2F
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 02:38:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 834F67AC04A
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 01:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A606088F;
	Fri, 21 Feb 2025 01:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XaB4Yys+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCD81ADC6F;
	Fri, 21 Feb 2025 01:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740101905; cv=none; b=BLvQYQZlc5/Lp5JNR2t9MqlvRmBt7/Kvfl20SBf9w7eo1x4QeJ8B+UGlq6espbdv9n2USWc1XJlD0Y/biZuDvqXsVctdQLx8I+GVkSMMbHEVSxvOoazUv27Hg3OYlI7x4YCwhcfX4TX3FKvASFz8dn1dp4+zY4riNMUTPsh0r38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740101905; c=relaxed/simple;
	bh=ltbm23oskEpOUHMQkDTqCc3ApposMpWkG+lxW/1271w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GLDC94lmFnJaAti39hEO98qaE0kpYJMkmQxkMvHhBjMZhtfipcqbTeid2BVLj6bBKn5cKGwx4iQquMqWx8hvOZ+X8bionMJwZ8m/2Je0qoalZxqCQoSemp4NKzzXfi74OxDd9h5Q3uVZOS0nbNnIrTi02O9kRbjUlSWqyEv2/Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XaB4Yys+; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6e41e18137bso12988076d6.1;
        Thu, 20 Feb 2025 17:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740101902; x=1740706702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qp1IP5+HElNmeU+NJ4GhzwMTUSG29HHyxLtNo1Dkjg8=;
        b=XaB4Yys+3ocMvmJH6v78NXln1uWP1aagBHHsRWC7NseWCGjLAhwaMaZra0hI+KjI4S
         Gtd5YAoGb38JFCYZPHOAIx+lJV9bNMQzTr7KerjGNVLHTjSkkb7oSdRifuDPB7KXwnCm
         pDOMf5cQYmfHy1IPizOvpmLjo3DTeyesugfEbFksEw04ibz+Aj4pFlNrKBgaa3GOJhaH
         noN88bACeY692+QK250dNy//Z7JMDdu9bAfSVQGaSzoPBpZlk6bS+N9N5dDE34DX+o/c
         rliZqln/5v4LEapds4VdGzWNsYfvU2sr/Py6GhHoB5ZjQgjN2GUpW+8Ew4e3JwAu8yTf
         wgTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740101902; x=1740706702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qp1IP5+HElNmeU+NJ4GhzwMTUSG29HHyxLtNo1Dkjg8=;
        b=cQIZux88IIzxTjhapX5j2hGdDKnC7rg/pK7saGRrkRhyr7GTHGIFLnhthWzV+7lRlI
         +O2ifo0cfV8cs3tLq+GomQVGnsuH/Es7HnnsnERnR7UBrJt2Azr9QS/J2+QkTIXZQJiv
         MhrzQGE0x7hMWNab8b7pjYbdxhC+EAMgdVlfwb6yzU7XLeYqhCi+luV3hff2U/WH3ciI
         hJg/Pbk1LK72OdhKU/ribdcyp4fRHFaoKrrYNT6EYVaBpdgUyrLtMNEgoqwQyqD2u7AF
         Frh0lerAEHHrQ9afUPeGy4WhDNPHvAJiuF72Uczwkp+xNPDwULjoNBgnvR+MQ5M54cgx
         j+ZA==
X-Forwarded-Encrypted: i=1; AJvYcCU3RrfJZdYwOeYzICGQei9VJYiVcfEIef6LUAb9mEQrHh0JjkQJrSy0clqwLhQGar2foXq6JmIhlvR0@vger.kernel.org, AJvYcCUV4d1Ffi/dZ9eHmQtTRNhjZQxkKez/vaef80xZB/ezby2BXZ3TuO1MLX/9Ba1fnyPpW6HKmQL/OKdNbNbS@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0tWW6Bb9kcdgjRCzwsAZLaK0Lp9EPCQA4kXhVm+p14eIa4VED
	WK9g32IVa6mMHSWsgZcwUSovDhMpar0q/B2oSwPSalVfKEXPnezT
X-Gm-Gg: ASbGncspTQ1MruDlvRRxnGf2qYsNzOZDQH7WwJEzT4QeRGj4eDVnDlv2ELxBQ0qCl4Y
	b3tigz8NCuQuwq51EJujf5IPCYmqhTw/uv1kCz5+tdAy9AXYXZR7HTTS8T2+BbPX53hqGYgYIUx
	n81zd5eLbV8D1UQNxFCBKJSWLJnP511AKxbG+uMM+EJkhKeaEdKigKirerszARuQG5jSEU4DojD
	BGb6OAdIm3VON7EnmmNv7QK/bOSUqT6a1pz7H8VWi1ox/qtqmz66QIIf21Q7U18OMd48vYeS76g
	9A==
X-Google-Smtp-Source: AGHT+IEAbGRWnSOKgLJXuNq9xwDRMgvjuDpj3BpstTmUkHKTNT/40wstmq+MDG9u4VdjZS+bniOt2w==
X-Received: by 2002:a05:6214:d65:b0:6e4:2f90:a9ca with SMTP id 6a1803df08f44-6e6b0036108mr15298496d6.3.1740101902516;
        Thu, 20 Feb 2025 17:38:22 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6e65d785ce5sm91783986d6.41.2025.02.20.17.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 17:38:22 -0800 (PST)
From: Inochi Amaoto <inochiama@gmail.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Niklas Cassel <cassel@kernel.org>,
	Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>
Cc: linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH 2/2] PCI: sophgo-dwc: Add Sophgo SG2044 PCIe driver
Date: Fri, 21 Feb 2025 09:37:56 +0800
Message-ID: <20250221013758.370936-3-inochiama@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250221013758.370936-1-inochiama@gmail.com>
References: <20250221013758.370936-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for DesignWare-based PCIe controller in SG2044 SoC.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 drivers/pci/controller/dwc/Kconfig          |  10 +
 drivers/pci/controller/dwc/Makefile         |   1 +
 drivers/pci/controller/dwc/pcie-dw-sophgo.c | 282 ++++++++++++++++++++
 3 files changed, 293 insertions(+)
 create mode 100644 drivers/pci/controller/dwc/pcie-dw-sophgo.c

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index b6d6778b0698..202014acf260 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -341,6 +341,16 @@ config PCIE_ROCKCHIP_DW_EP
 	  Enables support for the DesignWare PCIe controller in the
 	  Rockchip SoC (except RK3399) to work in endpoint mode.
 
+config PCIE_SOPHGO_DW
+	bool "SOPHGO DesignWare PCIe controller"
+	depends on ARCH_SOPHGO || COMPILE_TEST
+	depends on PCI_MSI
+	depends on OF
+	select PCIE_DW_HOST
+	help
+	  Enables support for the DesignWare PCIe controller in the
+	  SOPHGO SoC.
+
 config PCI_EXYNOS
 	tristate "Samsung Exynos PCIe controller"
 	depends on ARCH_EXYNOS || COMPILE_TEST
diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
index a8308d9ea986..193150056dd3 100644
--- a/drivers/pci/controller/dwc/Makefile
+++ b/drivers/pci/controller/dwc/Makefile
@@ -18,6 +18,7 @@ obj-$(CONFIG_PCIE_QCOM_EP) += pcie-qcom-ep.o
 obj-$(CONFIG_PCIE_ARMADA_8K) += pcie-armada8k.o
 obj-$(CONFIG_PCIE_ARTPEC6) += pcie-artpec6.o
 obj-$(CONFIG_PCIE_ROCKCHIP_DW) += pcie-dw-rockchip.o
+obj-$(CONFIG_PCIE_SOPHGO_DW) += pcie-dw-sophgo.o
 obj-$(CONFIG_PCIE_INTEL_GW) += pcie-intel-gw.o
 obj-$(CONFIG_PCIE_KEEMBAY) += pcie-keembay.o
 obj-$(CONFIG_PCIE_KIRIN) += pcie-kirin.o
diff --git a/drivers/pci/controller/dwc/pcie-dw-sophgo.c b/drivers/pci/controller/dwc/pcie-dw-sophgo.c
new file mode 100644
index 000000000000..a4ca4f1e26e0
--- /dev/null
+++ b/drivers/pci/controller/dwc/pcie-dw-sophgo.c
@@ -0,0 +1,282 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PCIe host controller driver for Sophgo SoCs.
+ *
+ */
+
+#include <linux/clk.h>
+#include <linux/gpio/consumer.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/irqdomain.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/phy/phy.h>
+#include <linux/property.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/reset.h>
+
+#include "pcie-designware.h"
+
+#define to_sophgo_pcie(x)		dev_get_drvdata((x)->dev)
+
+#define PCIE_INT_SIGNAL			0xc48
+#define PCIE_INT_EN			0xca0
+
+#define PCIE_SIGNAL_INTX_SHIFT		5
+
+#define PCIE_INT_EN_INTX_SHIFT		1
+#define PCIE_INT_EN_INT_SII		BIT(0)
+#define PCIE_INT_EN_INT_INTA		BIT(1)
+#define PCIE_INT_EN_INT_INTB		BIT(2)
+#define PCIE_INT_EN_INT_INTC		BIT(3)
+#define PCIE_INT_EN_INT_INTD		BIT(4)
+#define PCIE_INT_EN_INT_MSI		BIT(5)
+
+struct sophgo_pcie {
+	struct dw_pcie pci;
+	void __iomem *app_base;
+	struct clk_bulk_data *clks;
+	unsigned int clk_cnt;
+	struct reset_control *rst;
+	struct irq_domain *irq_domain;
+};
+
+static int sophgo_pcie_readl_app(struct sophgo_pcie *sophgo, u32 reg)
+{
+	return readl_relaxed(sophgo->app_base + reg);
+}
+
+static void sophgo_pcie_writel_app(struct sophgo_pcie *sophgo, u32 val, u32 reg)
+{
+	writel_relaxed(val, sophgo->app_base + reg);
+}
+
+static void sophgo_pcie_intx_handler(struct irq_desc *desc)
+{
+	struct dw_pcie_rp *pp = irq_desc_get_handler_data(desc);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct sophgo_pcie *sophgo = to_sophgo_pcie(pci);
+	unsigned long hwirq = PCIE_SIGNAL_INTX_SHIFT;
+	unsigned long reg;
+
+	chained_irq_enter(chip, desc);
+
+	reg = sophgo_pcie_readl_app(sophgo, PCIE_INT_SIGNAL);
+
+	for_each_set_bit_from(hwirq, &reg, PCI_NUM_INTX + PCIE_SIGNAL_INTX_SHIFT)
+		generic_handle_domain_irq(sophgo->irq_domain,
+					  hwirq - PCIE_SIGNAL_INTX_SHIFT);
+
+	chained_irq_exit(chip, desc);
+}
+
+static void sophgo_intx_mask(struct irq_data *d)
+{
+	struct dw_pcie_rp *pp = irq_data_get_irq_chip_data(d);
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct sophgo_pcie *sophgo = to_sophgo_pcie(pci);
+	unsigned long flags;
+	u32 val;
+
+	raw_spin_lock_irqsave(&pp->lock, flags);
+
+	val = sophgo_pcie_readl_app(sophgo, PCIE_INT_EN);
+	val &= ~BIT(d->hwirq + PCIE_INT_EN_INTX_SHIFT);
+	sophgo_pcie_writel_app(sophgo, val, PCIE_INT_EN);
+
+	raw_spin_unlock_irqrestore(&pp->lock, flags);
+};
+
+static void sophgo_intx_unmask(struct irq_data *d)
+{
+	struct dw_pcie_rp *pp = irq_data_get_irq_chip_data(d);
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct sophgo_pcie *sophgo = to_sophgo_pcie(pci);
+	unsigned long flags;
+	u32 val;
+
+	raw_spin_lock_irqsave(&pp->lock, flags);
+
+	val = sophgo_pcie_readl_app(sophgo, PCIE_INT_EN);
+	val |= BIT(d->hwirq + PCIE_INT_EN_INTX_SHIFT);
+	sophgo_pcie_writel_app(sophgo, val, PCIE_INT_EN);
+
+	raw_spin_unlock_irqrestore(&pp->lock, flags);
+};
+
+static void sophgo_intx_eoi(struct irq_data *d)
+{
+}
+
+static struct irq_chip sophgo_intx_irq_chip = {
+	.name			= "INTx",
+	.irq_mask		= sophgo_intx_mask,
+	.irq_unmask		= sophgo_intx_unmask,
+	.irq_eoi		= sophgo_intx_eoi,
+};
+
+static int sophgo_pcie_intx_map(struct irq_domain *domain, unsigned int irq,
+				irq_hw_number_t hwirq)
+{
+	irq_set_chip_and_handler(irq, &sophgo_intx_irq_chip, handle_fasteoi_irq);
+	irq_set_chip_data(irq, domain->host_data);
+
+	return 0;
+}
+
+static const struct irq_domain_ops intx_domain_ops = {
+	.map = sophgo_pcie_intx_map,
+};
+
+static int sophgo_pcie_init_irq_domain(struct dw_pcie_rp *pp)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct sophgo_pcie *sophgo = to_sophgo_pcie(pci);
+	struct device *dev = sophgo->pci.dev;
+	struct fwnode_handle *intc;
+	int irq;
+
+	intc = device_get_named_child_node(dev, "interrupt-controller");
+	if (!intc) {
+		dev_err(dev, "missing child interrupt-controller node\n");
+		return -ENODEV;
+	}
+
+	irq = fwnode_irq_get(intc, 0);
+	if (irq < 0) {
+		dev_err(dev, "failed to get INTx irq number\n");
+		fwnode_handle_put(intc);
+		return irq;
+	}
+
+	sophgo->irq_domain = irq_domain_create_linear(intc, PCI_NUM_INTX,
+						      &intx_domain_ops, sophgo);
+	fwnode_handle_put(intc);
+	if (!sophgo->irq_domain) {
+		dev_err(dev, "failed to get a INTx irq domain\n");
+		return -EINVAL;
+	}
+
+	return irq;
+}
+
+static void sophgo_pcie_msi_enable(struct dw_pcie_rp *pp)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct sophgo_pcie *sophgo = to_sophgo_pcie(pci);
+	unsigned long flags;
+	u32 val;
+
+	raw_spin_lock_irqsave(&pp->lock, flags);
+
+	val = sophgo_pcie_readl_app(sophgo, PCIE_INT_EN);
+	val |= PCIE_INT_EN_INT_MSI;
+	sophgo_pcie_writel_app(sophgo, val, PCIE_INT_EN);
+
+	raw_spin_unlock_irqrestore(&pp->lock, flags);
+}
+
+static int sophgo_pcie_host_init(struct dw_pcie_rp *pp)
+{
+	int irq;
+
+	irq = sophgo_pcie_init_irq_domain(pp);
+	if (irq < 0)
+		return irq;
+
+	irq_set_chained_handler_and_data(irq, sophgo_pcie_intx_handler,
+					 pp);
+
+	sophgo_pcie_msi_enable(pp);
+
+	return 0;
+}
+
+static const struct dw_pcie_host_ops sophgo_pcie_host_ops = {
+	.init = sophgo_pcie_host_init,
+};
+
+static int sophgo_pcie_clk_init(struct sophgo_pcie *sophgo)
+{
+	struct device *dev = sophgo->pci.dev;
+	int ret;
+
+	ret = devm_clk_bulk_get_all_enabled(dev, &sophgo->clks);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "failed to get clocks\n");
+
+	sophgo->clk_cnt = ret;
+
+	return 0;
+}
+
+static int sophgo_pcie_resource_get(struct platform_device *pdev,
+				    struct sophgo_pcie *sophgo)
+{
+	sophgo->app_base = devm_platform_ioremap_resource_byname(pdev, "app");
+	if (IS_ERR(sophgo->app_base))
+		return dev_err_probe(&pdev->dev, PTR_ERR(sophgo->app_base),
+				     "failed to map app registers\n");
+
+	return 0;
+}
+
+static int sophgo_pcie_configure_rc(struct sophgo_pcie *sophgo)
+{
+	struct dw_pcie_rp *pp;
+
+	pp = &sophgo->pci.pp;
+	pp->ops = &sophgo_pcie_host_ops;
+
+	return dw_pcie_host_init(pp);
+}
+
+static int sophgo_pcie_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct sophgo_pcie *sophgo;
+	int ret;
+
+	sophgo = devm_kzalloc(dev, sizeof(*sophgo), GFP_KERNEL);
+	if (!sophgo)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, sophgo);
+
+	sophgo->pci.dev = dev;
+
+	ret = sophgo_pcie_resource_get(pdev, sophgo);
+	if (ret)
+		return ret;
+
+	ret = sophgo_pcie_clk_init(sophgo);
+	if (ret)
+		return ret;
+
+	return sophgo_pcie_configure_rc(sophgo);
+}
+
+static const struct of_device_id sophgo_pcie_of_match[] = {
+	{ .compatible = "sophgo,sg2044-pcie" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, sophgo_pcie_acpi_match);
+
+static const struct acpi_device_id sophgo_pcie_acpi_match[] = {
+	{ "SOPHO000", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, sophgo_pcie_acpi_match);
+
+static struct platform_driver sophgo_pcie_driver = {
+	.driver = {
+		.name = "sophgo-dw-pcie",
+		.of_match_table = sophgo_pcie_of_match,
+		.acpi_match_table = sophgo_pcie_acpi_match,
+		.suppress_bind_attrs = true,
+	},
+	.probe = sophgo_pcie_probe,
+};
+builtin_platform_driver(sophgo_pcie_driver);
-- 
2.48.1


