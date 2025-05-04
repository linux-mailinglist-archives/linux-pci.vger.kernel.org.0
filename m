Return-Path: <linux-pci+bounces-27115-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C445CAA8374
	for <lists+linux-pci@lfdr.de>; Sun,  4 May 2025 02:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C60C189C836
	for <lists+linux-pci@lfdr.de>; Sun,  4 May 2025 00:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB04935970;
	Sun,  4 May 2025 00:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fb18gqjp"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0574925771;
	Sun,  4 May 2025 00:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746319492; cv=none; b=s7X1BxgZJlw+Wj3LIiYBzvWLnfjQ1GdbwYzVoXJG5AkTq2hnrxpX1M/v2GIRRx23mObZwGLgy4nP4csxyKW/YruCLGjiOgXHI3bgiyJikVyAiWQeuRT0seng0lYvjokodJtw2nmtE4txH46aAFQ5dUY2YZp1bqnQgm4RweNaOVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746319492; c=relaxed/simple;
	bh=yUYPRZNceFGQgxL2ceNChKMjrehxlJP8oyZRPIWJJTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oR6Mejy6fvf12NERxhttjHlYQdiinJCi6ZJtfjqhhYMXb/c3i1zSgGyAEwNk8pRIcQQTQizvcqX+Ga9A9DwGk3ezuBttTvuUyvR8Us38hl+PgHzR4HiFOY3XcFjyE6bivKquyA5A3h8YGVg8QnnqWv9vOfHWSkRun5JPhqmreys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fb18gqjp; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4774d68c670so57656221cf.0;
        Sat, 03 May 2025 17:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746319490; x=1746924290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=glUJtReybeSU9UMmM2aC3jiSRkxCBYujyIZYYLRpM4Q=;
        b=Fb18gqjpXArOb8vvgaG7cB4h9Yu6V+i2HSRTeXuFDklk2XcMYmS8MsIAMLC5Wajnbw
         Jglwxo3OmVoNMe8ysREaqVObaKssSZGO9AEUF1L9tCCerVrEo4YjV6XQqQEEQbjUH3IE
         iTRF309VSLP7Fj1AaoOu1pFErqutYsk54MSQOy2frvu/qTPDg5ngKyGX3Rw2PVCe2AY8
         UlS2EdfXFxz5TV47J74dTfro2GcNWlu764oA5SZwNT9b4pnxMnPgGYGwCSp1Q3qBMFJB
         1QSKiwbJJlITyDjAZb/8Bi2VY5rThPoIAouJK1VScM39wb8FmylOx9Ko4L9jNIVvtJU6
         8i3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746319490; x=1746924290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=glUJtReybeSU9UMmM2aC3jiSRkxCBYujyIZYYLRpM4Q=;
        b=UBoQHMkcJC3guR07llrzTYmux5hAQGhZtm+vlojlBdjjihNMXiHXCAJwtj5ZEGdo2Q
         YNTcsjj5K0NsryfV7sY594A2WMIRrGSAazj3HsLQIGjtuUH7stwTvp07fEgtkDB+yqIW
         +tLJRKLrktDKc5tnUM9PQtT/MIUZ2kvr8sXrXMLZeAIg0MS/y1Q5mjvnKoM9yRQc3ri2
         t1Q06NEluoyqm8X7lTisD2ADKigyt+NSj2O97DNEsVatENqN3YMUIShcFK1sJ3Pp8JUq
         guCturssg9BwKudRP1aM9Z2r6zj1+gSj5lec/a2BLVrrN+w0ehHInrrbAjT8Z0Su2a0r
         cMhw==
X-Forwarded-Encrypted: i=1; AJvYcCUPodas8k4hiOm4rWmP7t+vp0863qiVU62aFFFTgA06SEZdMW1twH3F421mnc+x7hxGKvsPAArPUXEw7Ikr@vger.kernel.org, AJvYcCXjKFzWe1t12YnxyXoQb1foyx+5zAEfJfKOl+sAlo4X0wf7zZnceF4SkUepHEU2Sue0Hx+3icRdpM/B@vger.kernel.org
X-Gm-Message-State: AOJu0Ywkeho41RS4WZl9up4qxjqaaom09RucRJdzD0rlftndwZwtN3FK
	zpVt4tqvLot0hIO2bWa2a1FqAqzYEHiQ5xBJK3hvsEE2CccBwjTV
X-Gm-Gg: ASbGnctF4NtZ+5SZ266hF91n6ig5+DXBdQoXLexvZ+4Sc6UCInmnvEZUhetUP035g76
	6B4Q38XLHs+jqQzDNJu0gmRzMxuC3hY/IELPFodgzA+LmT2QZvzwHNpgot2wmIsPX9T1e1ejHmO
	2XXWWplX7VO6sqHxDUGIez5lsEKqNuyMrvT6eIInYtTJbuSTAEk1hhcpbba3r2aug8DUQJBkHcD
	NBPAPuklTpjdCkVIThkQ8lp9trxYTVLY6VNbuBjS4ACEYkz8Ub1/uNx0iGGkLS/PaTV4pBn2Io4
	g+A0JiuhPPoxhFvQ
X-Google-Smtp-Source: AGHT+IH7/DZ/pctM9PXgMnRa9IZ+/9tnpxbAJ1vWO6J4mbNoekyJ4ajeyrdsTwYwdx6Y6MlNlT03GA==
X-Received: by 2002:ac8:7dc2:0:b0:47a:eade:95eb with SMTP id d75a77b69052e-48e00f625abmr24684061cf.40.1746319489727;
        Sat, 03 May 2025 17:44:49 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-48b966d8b7csm39551881cf.27.2025.05.03.17.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 May 2025 17:44:49 -0700 (PDT)
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
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Niklas Cassel <cassel@kernel.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Shradha Todi <shradha.t@samsung.com>,
	Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
	Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>
Cc: linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH v3 2/2] PCI: sophgo-dwc: Add Sophgo SG2044 PCIe driver
Date: Sun,  4 May 2025 08:44:19 +0800
Message-ID: <20250504004420.202685-3-inochiama@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250504004420.202685-1-inochiama@gmail.com>
References: <20250504004420.202685-1-inochiama@gmail.com>
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
 drivers/pci/controller/dwc/pcie-dw-sophgo.c | 258 ++++++++++++++++++++
 3 files changed, 269 insertions(+)
 create mode 100644 drivers/pci/controller/dwc/pcie-dw-sophgo.c

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index d9f0386396ed..b5b53e5a4cbf 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -402,6 +402,16 @@ config PCIE_UNIPHIER_EP
 	  Say Y here if you want PCIe endpoint controller support on
 	  UniPhier SoCs. This driver supports Pro5 SoC.
 
+config PCIE_SOPHGO_DW
+	bool "Sophgo DesignWare PCIe controller"
+	depends on ARCH_SOPHGO || COMPILE_TEST
+	depends on PCI_MSI
+	depends on OF
+	select PCIE_DW_HOST
+	help
+	  Enables support for the DesignWare PCIe controller in the
+	  Sophgo SoC.
+
 config PCIE_SPEAR13XX
 	bool "STMicroelectronics SPEAr PCIe controller"
 	depends on ARCH_SPEAR13XX || COMPILE_TEST
diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
index 908cb7f345db..510abb4e04c4 100644
--- a/drivers/pci/controller/dwc/Makefile
+++ b/drivers/pci/controller/dwc/Makefile
@@ -20,6 +20,7 @@ obj-$(CONFIG_PCIE_QCOM_EP) += pcie-qcom-ep.o
 obj-$(CONFIG_PCIE_ARMADA_8K) += pcie-armada8k.o
 obj-$(CONFIG_PCIE_ARTPEC6) += pcie-artpec6.o
 obj-$(CONFIG_PCIE_ROCKCHIP_DW) += pcie-dw-rockchip.o
+obj-$(CONFIG_PCIE_SOPHGO_DW) += pcie-dw-sophgo.o
 obj-$(CONFIG_PCIE_INTEL_GW) += pcie-intel-gw.o
 obj-$(CONFIG_PCIE_KEEMBAY) += pcie-keembay.o
 obj-$(CONFIG_PCIE_KIRIN) += pcie-kirin.o
diff --git a/drivers/pci/controller/dwc/pcie-dw-sophgo.c b/drivers/pci/controller/dwc/pcie-dw-sophgo.c
new file mode 100644
index 000000000000..89b22b3ac8d6
--- /dev/null
+++ b/drivers/pci/controller/dwc/pcie-dw-sophgo.c
@@ -0,0 +1,258 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Sophgo DesignWare based PCIe host controller driver
+ */
+
+#include <linux/bits.h>
+#include <linux/clk.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/irqdomain.h>
+#include <linux/module.h>
+#include <linux/property.h>
+#include <linux/platform_device.h>
+
+#include "pcie-designware.h"
+
+#define to_sophgo_pcie(x)		dev_get_drvdata((x)->dev)
+
+#define PCIE_INT_SIGNAL			0xc48
+#define PCIE_INT_EN			0xca0
+
+#define PCIE_INT_SIGNAL_INTX		GENMASK(8, 5)
+
+#define PCIE_INT_EN_INTX		GENMASK(4, 1)
+#define PCIE_INT_EN_INT_MSI		BIT(5)
+
+struct sophgo_pcie {
+	struct dw_pcie		pci;
+	void __iomem		*app_base;
+	struct clk_bulk_data	*clks;
+	unsigned int		clk_cnt;
+	struct irq_domain	*irq_domain;
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
+	unsigned long hwirq, reg;
+
+	chained_irq_enter(chip, desc);
+
+	reg = sophgo_pcie_readl_app(sophgo, PCIE_INT_SIGNAL);
+	reg = FIELD_GET(PCIE_INT_SIGNAL_INTX, reg);
+
+	for_each_set_bit(hwirq, &reg, PCI_NUM_INTX)
+		generic_handle_domain_irq(sophgo->irq_domain, hwirq);
+
+	chained_irq_exit(chip, desc);
+}
+
+static void sophgo_intx_irq_mask(struct irq_data *d)
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
+	val &= ~FIELD_PREP(PCIE_INT_EN_INTX, BIT(d->hwirq));
+	sophgo_pcie_writel_app(sophgo, val, PCIE_INT_EN);
+
+	raw_spin_unlock_irqrestore(&pp->lock, flags);
+};
+
+static void sophgo_intx_irq_unmask(struct irq_data *d)
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
+	val |= FIELD_PREP(PCIE_INT_EN_INTX, BIT(d->hwirq));
+	sophgo_pcie_writel_app(sophgo, val, PCIE_INT_EN);
+
+	raw_spin_unlock_irqrestore(&pp->lock, flags);
+};
+
+static struct irq_chip sophgo_intx_irq_chip = {
+	.name			= "INTx",
+	.irq_mask		= sophgo_intx_irq_mask,
+	.irq_unmask		= sophgo_intx_irq_unmask,
+};
+
+static int sophgo_pcie_intx_map(struct irq_domain *domain, unsigned int irq,
+				irq_hw_number_t hwirq)
+{
+	irq_set_chip_and_handler(irq, &sophgo_intx_irq_chip, handle_level_irq);
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
+						      &intx_domain_ops, pp);
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
+MODULE_DEVICE_TABLE(of, sophgo_pcie_of_match);
+
+static struct platform_driver sophgo_pcie_driver = {
+	.driver = {
+		.name = "sophgo-dw-pcie",
+		.of_match_table = sophgo_pcie_of_match,
+		.suppress_bind_attrs = true,
+	},
+	.probe = sophgo_pcie_probe,
+};
+builtin_platform_driver(sophgo_pcie_driver);
-- 
2.49.0


