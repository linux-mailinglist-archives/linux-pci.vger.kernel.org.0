Return-Path: <linux-pci+bounces-22809-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD27A4D4A1
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 08:19:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B48A1889637
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 07:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E301FA14E;
	Tue,  4 Mar 2025 07:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DkbHXXJ4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C81A1F9AB1;
	Tue,  4 Mar 2025 07:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741072407; cv=none; b=noZo7W6xmeQXY+BLVfMUpwv/QkkRxJO5WcTQ3NbeZCbA40iNfnfNomi6G0XmRvPyP8zly8spLuNbukp76PQ5Uac3shsbIdCv+9U9xPH+HOzkOY2qisoELimRE27598R6+FdVtGSWKEbU6wUVF8EUYfTsHdqoOdY0GgtpyXwoQ+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741072407; c=relaxed/simple;
	bh=kbGFW3DXNmNaI/LJicjMxyiKRsoi7BY1jdzzyDoctOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QK3deLljQlmm74lUruekiC6m/8r4PCd7iOcpL4EoWmOSG3hUYm2k5nEUzCm924c9UrHyXs8mg9BCwXMB06hZOHOYXVXlqJXJ9qn/DjY5yJgK6UwkaHY/zZnpdbFEljagp1+wHRrUHPaAdgXAW3aIDdm0+UXjCipxyMweGSccQsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DkbHXXJ4; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-46fa764aac2so45883131cf.1;
        Mon, 03 Mar 2025 23:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741072404; x=1741677204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rrdQz9Cgs/e9JZOqG5wHg9flLJAY+0kITfj7PWOImhU=;
        b=DkbHXXJ4jVbMBFFQxElG3nVKFKMOmMvPtpixJlGuEfaGyNDN+Oae/urisrKlnglDjL
         hfNxirn7Z4aq71xGtQeGmybQtiY6n6OPzZT3JdJvqUo7hzReDoz/1VTy5NcbWjg6qRnm
         xXx96zDABditL6siAfhsOBhC6AHlREpwpYMUSQ70EVVwmRD32lW5MhRk/IUSq5E11mSU
         vgAsZMv2aLzsiVka3wCH5f+IMN8cluaJOJkxFwPwv7WmKYnAKOX+dfGpDST8a1gddG9F
         ln70PHVvHGOL4QFZg++xDwA5k+nKQcXUHHgk2EQkgCiPt0dO+hv704fPrU48yUzuQHWt
         eKVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741072404; x=1741677204;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rrdQz9Cgs/e9JZOqG5wHg9flLJAY+0kITfj7PWOImhU=;
        b=rbmpT1vb299HxJyvfvELkKznLYARLCbcNGunMDC3XUY8S3AbrZW2xOuweaextidzFZ
         rVNULaY6Gdjbf6OegwOBMBURf0bLSH/rotdUtFxVPzXzCK/NjGIem5j9xeBB6Ld3qVWr
         2n+lYg5vdScRWpOiKMg2h4RRpzAlL8uTwsFD4JVV7rt83peLvBmWEcwORTd4XFxC4L20
         g3CjORRFWX19MMZrXnvWSFuvpuM9/KREdAeklVoKQuSEd8Pa6VYU68uP1MZ8kSfB1IZO
         xT2sb2PSBuLMF/JkvqJ7SAE96mYPm0ToPEZ79X7C+NjYxWKD0/WBAGDvMf5Uwo9cFchx
         RdfQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5sMjuY3gqzFtYEQL+B/1sDiwlfm1qmryBeTPxLiB29igX/x6/JdG3a70y1W2rsfm9cFdct4B5M/aw@vger.kernel.org, AJvYcCXxzo2gmyaXDBBXVUTHYgFHHbEayPEd2rp3Qj+3gmP2YK1E15VQYRRx2AcVOdwPh/dqGbFlkeAr/saOgz5u@vger.kernel.org
X-Gm-Message-State: AOJu0YzztRucyqB2bSVU491zj0CIM15jCXLNif0Y87RW3SecHb0/pLga
	/lLEktuJlm3odk6tXjIxaL/o0PzCYUDi1s2gU0XxApcbq6FBaI+l
X-Gm-Gg: ASbGncuZ3dg+tcquqeGKBISp3FJG1X/hEknVEKIlgBgEAMPwFj6c9Yohf9hicMl4DmJ
	D+sDexeAzhHCFvuCoRJtCWvW5EXc24B9y+TRvGabZ0A+6SJePpDK3frx2DLSipAonruX6qVzh6O
	mrUaJvjtcFDwsdCsTFnsUfqenyKCJ3jXjdvAj9CtYjcqjbkcGCDbwZPhF7spitEl/kjWjOPB7fi
	KlMLV/8KS7VwIUGr1Yt0i6HFbdzCYURL+7BEpQdV8NtwaMH1NkJzRpvsJVziJWowGqps0y9fcXg
	3arooONruI1HJGbsQftD
X-Google-Smtp-Source: AGHT+IEyqWPUhMGvruobgDMmuMPk0gKDbAAIQMmUTsNb1WXjMm/eOtaru71S38A51PS4dUF/LL7KkQ==
X-Received: by 2002:a05:622a:352:b0:475:42d:ea0a with SMTP id d75a77b69052e-475042debfbmr320181cf.38.1741072403930;
        Mon, 03 Mar 2025 23:13:23 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-47500cef956sm3231951cf.54.2025.03.03.23.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 23:13:23 -0800 (PST)
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
	Johan Hovold <johan+linaro@kernel.org>,
	Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>,
	Niklas Cassel <cassel@kernel.org>
Cc: linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH 2/2] PCI: sophgo-dwc: Add Sophgo SG2044 PCIe driver
Date: Tue,  4 Mar 2025 15:12:38 +0800
Message-ID: <20250304071239.352486-3-inochiama@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250304071239.352486-1-inochiama@gmail.com>
References: <20250304071239.352486-1-inochiama@gmail.com>
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
 drivers/pci/controller/dwc/pcie-dw-sophgo.c | 270 ++++++++++++++++++++
 3 files changed, 281 insertions(+)
 create mode 100644 drivers/pci/controller/dwc/pcie-dw-sophgo.c

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index b6d6778b0698..004c384e25ad 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -381,6 +381,16 @@ config PCIE_UNIPHIER_EP
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
index 000000000000..3ed7cfe0b361
--- /dev/null
+++ b/drivers/pci/controller/dwc/pcie-dw-sophgo.c
@@ -0,0 +1,270 @@
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
+static void sophgo_intx_irq_eoi(struct irq_data *d)
+{
+}
+
+static struct irq_chip sophgo_intx_irq_chip = {
+	.name			= "INTx",
+	.irq_mask		= sophgo_intx_irq_mask,
+	.irq_unmask		= sophgo_intx_irq_unmask,
+	.irq_eoi		= sophgo_intx_irq_eoi,
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


