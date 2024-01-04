Return-Path: <linux-pci+bounces-1673-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 704BB82425F
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jan 2024 14:06:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71CA41C23DAA
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jan 2024 13:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D792233A;
	Thu,  4 Jan 2024 13:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="dH8srkkZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A4524B44
	for <linux-pci@vger.kernel.org>; Thu,  4 Jan 2024 13:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3367f8f8cb0so442310f8f.2
        for <linux-pci@vger.kernel.org>; Thu, 04 Jan 2024 05:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1704373335; x=1704978135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3E4Vbkb/LrKV7uJsCtqtIqNAbn7WFp6GN2T7jU5w+KA=;
        b=dH8srkkZC12Yni1cdQmwYzTHLQPkXZNRUh5Opjrh+o80Wt0pEMRfUghmtWh/0N/P29
         qvNRDlWe13YKYOQLVhGbYd6/lmRnj60zmPhArYWzhraqy0cMT4WjRiCLrRZ3j1OSvADE
         c+rtAMqhImveO5kli7DtpD+09Pnv9ogfpf5ErACTwu6qyca5unzBIFRYL147jHbas3zX
         6GHlQW3raMYx5J5rV+UN9Ttkc5W7c9HwuLqZwdQoAW2/NYnGmyVxbqlYng+qqABPeCHi
         kIM3l29YIyi4zAipG58ab1QSwCGrY0CSIwoWX1RLDq3OvEY5H9v+504B9HaOHoi94M7A
         oSZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704373335; x=1704978135;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3E4Vbkb/LrKV7uJsCtqtIqNAbn7WFp6GN2T7jU5w+KA=;
        b=TqUqJdW3Oz7mwSAVb94uaBffc2K3wLM4ny8o47IIjDYjv0ifxJO6nMkbrSEj462/Bl
         o/YRqxZ9iu5C2nyJyVfQHeYS6/TE3oeBXn6QOTEKvMpG8dJ87f77nQjFZyrkELXuhZFR
         D6dxa1dEdjH+r4uFGRGwgp/ZIgkx7fIY+CHVmSsnf7KUlYcCKGU8D/95VBY7HUROyL/U
         ITHhqJWB0Wm0TWuRT1ku2TDC457acG49nPGz67IulHP1Us6DS0SODQ1DlL7jBn20jTQj
         /a6aiSWRBeT1ELuj6Zg69VtKJOPsjEIeLjUMcjReuHfLu8QE9ng5Zj/IGt9sC8wtY/9Z
         swRw==
X-Gm-Message-State: AOJu0YzDFQvPaENVkpkEpvNcgC4n+L/5YSMT92kdA/7G3k65bVICZw3B
	tEgR3KmF3eA7FzfrOs1Z9XZSvS6NlpxUoA==
X-Google-Smtp-Source: AGHT+IHHXVpRs7QMqS9kg1ok0JTc8TTEP2DuD/O7GN8bhaZdGEhV9MHAS2mTz+G8GWP6ubM9PTmRyw==
X-Received: by 2002:a05:600c:300b:b0:40d:f9c8:887f with SMTP id j11-20020a05600c300b00b0040df9c8887fmr331173wmh.51.1704373334899;
        Thu, 04 Jan 2024 05:02:14 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:5b69:3768:8459:8fee])
        by smtp.gmail.com with ESMTPSA id w5-20020a5d5445000000b0033660f75d08sm32887387wrv.116.2024.01.04.05.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 05:02:14 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Kalle Valo <kvalo@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Chris Morgan <macromorgan@hotmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Arnd Bergmann <arnd@arndb.de>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	=?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= <nfraprado@collabora.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Peng Fan <peng.fan@nxp.com>,
	Robert Richter <rrichter@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Alex Elder <elder@linaro.org>,
	Srini Kandagatla <srinivas.kandagatla@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [RFC 8/9] PCI/pwrseq: add a pwrseq driver for QCA6390
Date: Thu,  4 Jan 2024 14:01:22 +0100
Message-Id: <20240104130123.37115-9-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240104130123.37115-1-brgl@bgdev.pl>
References: <20240104130123.37115-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Add a PCIe power sequencing driver that's capable of correctly powering
up the ath11k module on QCA6390 using the PCIe pwrseq functionality.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/pci/pcie/pwrseq/Kconfig               |  11 +
 drivers/pci/pcie/pwrseq/Makefile              |   1 +
 drivers/pci/pcie/pwrseq/pcie-pwrseq-qca6390.c | 197 ++++++++++++++++++
 3 files changed, 209 insertions(+)
 create mode 100644 drivers/pci/pcie/pwrseq/pcie-pwrseq-qca6390.c

diff --git a/drivers/pci/pcie/pwrseq/Kconfig b/drivers/pci/pcie/pwrseq/Kconfig
index 010e31f432c9..f9fe555b8506 100644
--- a/drivers/pci/pcie/pwrseq/Kconfig
+++ b/drivers/pci/pcie/pwrseq/Kconfig
@@ -6,3 +6,14 @@ menuconfig PCIE_PWRSEQ
 	help
 	  Say yes here to enable support for PCIe power sequencing
 	  drivers.
+
+if PCIE_PWRSEQ
+
+config PCIE_PWRSEQ_QCA6390
+	tristate "PCIe Power Sequencing driver for QCA6390"
+	depends on ARCH_QCOM || COMPILE_TEST
+	help
+	  Enable support for the PCIe power sequencing driver for the
+	  ath11k module of the QCA6390 WLAN/BT chip.
+
+endif
diff --git a/drivers/pci/pcie/pwrseq/Makefile b/drivers/pci/pcie/pwrseq/Makefile
index da99566594f6..da3e02063404 100644
--- a/drivers/pci/pcie/pwrseq/Makefile
+++ b/drivers/pci/pcie/pwrseq/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-$(CONFIG_PCIE_PWRSEQ)		+= pwrseq.o
+obj-$(CONFIG_PCIE_PWRSEQ_QCA6390)	+= pcie-pwrseq-qca6390.o
diff --git a/drivers/pci/pcie/pwrseq/pcie-pwrseq-qca6390.c b/drivers/pci/pcie/pwrseq/pcie-pwrseq-qca6390.c
new file mode 100644
index 000000000000..e9fddbb642fe
--- /dev/null
+++ b/drivers/pci/pcie/pwrseq/pcie-pwrseq-qca6390.c
@@ -0,0 +1,197 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2023 Linaro Ltd.
+ */
+
+#include <linux/bitmap.h>
+#include <linux/gpio/consumer.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/pcie-pwrseq.h>
+#include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+
+struct pcie_pwrseq_qca6390_vreg {
+	const char *name;
+	unsigned int load_uA;
+};
+
+struct pcie_pwrseq_qca6390_pdata {
+	struct pcie_pwrseq_qca6390_vreg *vregs;
+	size_t num_vregs;
+	unsigned int delay_msec;
+};
+
+struct pcie_pwrseq_qca6390_ctx {
+	struct pcie_pwrseq pwrseq;
+	const struct pcie_pwrseq_qca6390_pdata *pdata;
+	struct regulator_bulk_data *regs;
+	struct gpio_descs *en_gpios;
+	unsigned long *en_gpios_values;
+};
+
+static struct pcie_pwrseq_qca6390_vreg pcie_pwrseq_qca6390_vregs[] = {
+	{
+		.name = "vddpmu",
+		.load_uA = 1250000,
+	},
+	{
+		.name = "vddpcie1",
+		.load_uA = 35000,
+	},
+	{
+		.name = "vddpcie2",
+		.load_uA = 15000,
+	},
+};
+
+static struct pcie_pwrseq_qca6390_pdata pcie_pwrseq_qca6390_of_data = {
+	.vregs = pcie_pwrseq_qca6390_vregs,
+	.num_vregs = ARRAY_SIZE(pcie_pwrseq_qca6390_vregs),
+	.delay_msec = 16,
+};
+
+static int pcie_pwrseq_qca6390_power_on(struct pcie_pwrseq_qca6390_ctx *ctx)
+{
+	int ret;
+
+	ret = regulator_bulk_enable(ctx->pdata->num_vregs, ctx->regs);
+	if (ret)
+		return ret;
+
+	bitmap_fill(ctx->en_gpios_values, ctx->en_gpios->ndescs);
+
+	ret = gpiod_set_array_value_cansleep(ctx->en_gpios->ndescs,
+					     ctx->en_gpios->desc,
+					     ctx->en_gpios->info,
+					     ctx->en_gpios_values);
+	if (ret) {
+		regulator_bulk_disable(ctx->pdata->num_vregs, ctx->regs);
+		return ret;
+	}
+
+	if (ctx->pdata->delay_msec)
+		msleep(ctx->pdata->delay_msec);
+
+	return 0;
+}
+
+static int pcie_pwrseq_qca6390_power_off(struct pcie_pwrseq_qca6390_ctx *ctx)
+{
+	int ret;
+
+	bitmap_zero(ctx->en_gpios_values, ctx->en_gpios->ndescs);
+
+	ret = gpiod_set_array_value_cansleep(ctx->en_gpios->ndescs,
+					     ctx->en_gpios->desc,
+					     ctx->en_gpios->info,
+					     ctx->en_gpios_values);
+	if (ret)
+		return ret;
+
+	return regulator_bulk_disable(ctx->pdata->num_vregs, ctx->regs);
+}
+
+static void devm_pcie_pwrseq_qca6390_power_off(void *data)
+{
+	struct pcie_pwrseq_qca6390_ctx *ctx = data;
+
+	pcie_pwrseq_qca6390_power_off(ctx);
+}
+
+static int pcie_pwrseq_qca6309_probe(struct platform_device *pdev)
+{
+	struct pcie_pwrseq_qca6390_ctx *ctx;
+	struct device *dev = &pdev->dev;
+	int ret, i;
+
+	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	ctx->pdata = of_device_get_match_data(dev);
+	if (!ctx->pdata)
+		return dev_err_probe(dev, -ENODEV,
+				     "Failed to obtain platform data\n");
+
+	if (ctx->pdata->vregs) {
+		ctx->regs = devm_kcalloc(dev, ctx->pdata->num_vregs,
+					 sizeof(*ctx->regs), GFP_KERNEL);
+		if (!ctx->regs)
+			return -ENOMEM;
+
+		for (i = 0; i < ctx->pdata->num_vregs; i++)
+			ctx->regs[i].supply = ctx->pdata->vregs[i].name;
+
+		ret = devm_regulator_bulk_get(dev, ctx->pdata->num_vregs,
+					      ctx->regs);
+		if (ret < 0)
+			return dev_err_probe(dev, ret,
+					     "Failed to get all regulators\n");
+
+		for (i = 0; i < ctx->pdata->num_vregs; i++) {
+			ret = regulator_set_load(ctx->regs[i].consumer,
+						 ctx->pdata->vregs[i].load_uA);
+			if (ret)
+				return dev_err_probe(dev, ret,
+						     "Failed to set vreg load\n");
+		}
+	}
+
+	ctx->en_gpios = devm_gpiod_get_array_optional(dev, "enable",
+						      GPIOD_OUT_LOW);
+	if (IS_ERR(ctx->en_gpios))
+		return dev_err_probe(dev, PTR_ERR(ctx->en_gpios),
+				     "Failed to get enable GPIOs\n");
+
+	ctx->en_gpios_values = devm_bitmap_zalloc(dev, ctx->en_gpios->ndescs,
+						  GFP_KERNEL);
+	if (!ctx->en_gpios_values)
+		return -ENOMEM;
+
+	ret = pcie_pwrseq_qca6390_power_on(ctx);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to power on the device\n");
+
+	ret = devm_add_action_or_reset(dev, devm_pcie_pwrseq_qca6390_power_off,
+				       ctx);
+	if (ret)
+		return ret;
+
+	ctx->pwrseq.dev = dev;
+
+	ret = devm_pcie_pwrseq_device_enable(dev, &ctx->pwrseq);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to register the pwrseq wrapper\n");
+
+	return 0;
+}
+
+static const struct of_device_id pcie_pwrseq_qca6309_of_match[] = {
+	{
+		.compatible = "pci17cb,1101",
+		.data = &pcie_pwrseq_qca6390_of_data,
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, pcie_pwrseq_qca6309_of_match);
+
+static struct platform_driver pcie_pwrseq_qca6309_driver = {
+	.driver = {
+		.name = "pcie-pwrseq-qca6390",
+		.of_match_table = pcie_pwrseq_qca6309_of_match,
+	},
+	.probe = pcie_pwrseq_qca6309_probe,
+};
+module_platform_driver(pcie_pwrseq_qca6309_driver);
+
+MODULE_AUTHOR("Bartosz Golaszewski <bartosz.golaszewski@linaro.org>");
+MODULE_DESCRIPTION("PCIe Power Sequencing module for QCA6390");
+MODULE_LICENSE("GPL");
-- 
2.40.1


