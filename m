Return-Path: <linux-pci+bounces-3642-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC4B858741
	for <lists+linux-pci@lfdr.de>; Fri, 16 Feb 2024 21:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86723289DE1
	for <lists+linux-pci@lfdr.de>; Fri, 16 Feb 2024 20:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60BF1154C0D;
	Fri, 16 Feb 2024 20:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Pb6XyWpV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F55153518
	for <linux-pci@vger.kernel.org>; Fri, 16 Feb 2024 20:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708115619; cv=none; b=IOmTSQ4AOJ5gDXC8Ze0xUPTP9PN0tdIhvgYYS4F1XMXPmqdqay5/SLS8ld8bOZg03W6eJ5bxdSpm5uT/jFgKVcw60WkxptdSPBEfeDaeTKoZXaPVSxBabg7ErwnB8R3DHmt0fdSwe5bZU18zLEm0cmL/HW0/Vjv8lsAvNMKlkCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708115619; c=relaxed/simple;
	bh=yx9oNf9d3eA1FlLSpotJY/uy8bPphhk+h+RPxHa1al0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NQyzNRVuPXrCxljD4nMKBtVq1ZBv0bLEiGT89tbKTPseQtv/UV6Hw5XjAmahn/oN0hnQUeF0t2JQsBZn0dHjJqIFSEnB0w3zICNiuJzWmFvslH7U65ozmazsmA4oHuoyp3pFZ+5/d2BMsf4A7ocxCCnPuUhn5Jq27GaNAdIY92M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Pb6XyWpV; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d1080cb9easo33168721fa.1
        for <linux-pci@vger.kernel.org>; Fri, 16 Feb 2024 12:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1708115613; x=1708720413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iiAgZXD5R5oyKE5kvpTu1Xl8SVVb50mDoXKZHDVMF3g=;
        b=Pb6XyWpVwDbIYabChrT2njYtuWzXrM7tQ4+lP6XtchjVJY/hIvgDhIk5waBW9aypVb
         4av6eZQpVGzknbr4L71sVR9W7g17bX1uZLAL4bjR5uogLyd46dbiO2TsbmiCvAeXVWy1
         o+yBvWgtxLnAjrk68YnBWTESHcXDCPi0d5b93xlU7H/l6KyQex5bHHbuXali1zfukm1l
         Dvg3PTpRg8UZh9OF4YoMqnadhLpzX2PRTi+kDmQyW5x/gQxny2Q3tGkQ2gjrufrtSMl8
         E6K11IpDvKhsqKLcdJGwN3Yb+xqen7TWGIdj0LU5vkmwVAeSS3r+O4UJ7xWzWt8CR6ZD
         DY7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708115613; x=1708720413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iiAgZXD5R5oyKE5kvpTu1Xl8SVVb50mDoXKZHDVMF3g=;
        b=ppjQ7W89sxeJGjBrRxvgBscdXuQ3gy5cHOshRVjOA883YnczrTMeBbgoQ+27jgttYn
         xY7masH04KX9N37I5nusT1WwILEtk5VWrfNqdQoUlcZWWS9jWrw3v30yELtQhh7FWkgu
         zl9D7yDzrTRDDd79TbLD0lhC3z5dnEnzO9rAeDZH3XoiLJMfs+NNfM3gnCKkxsB93YwO
         ScyUDJORrxvH0S7UMuEXUBWZiqGGKT3Y+FPvkd4gexNI26TEnRQgfGqxeDSZiq/HdnoK
         O+TPkCDO6JS00aAzDrslxVH5Mdgh3t5tkTiQ/d9g/G6BS+z/yUkZoJV828GwV8sE1fwv
         RGhA==
X-Forwarded-Encrypted: i=1; AJvYcCUnOpTSp41N5BqbfYAzFMpOYqhsn4mMTOgE60l+UtEQxq0wwBXXu8XjwbAHoUyeGZVN4x1sy/KZUjXlZGb05buR0GytTzN+9uCG
X-Gm-Message-State: AOJu0Yz+fze4CPxBueR1NMxCW0j3Ra5LdRmy921A4YB+/xHTVzVRHyzq
	dWVhccF8fDrITXgE7K/aA0fWZlH/0IaGDD8yn6cPx63GeH8ylO96m0Y5M5/EYCs=
X-Google-Smtp-Source: AGHT+IEuflH9wQzsx8TrMcwmwhz38pYeg7QRtUYyjKydmIUvwvFOOto2iAhoyBREDsH8Oy9snBTz1A==
X-Received: by 2002:a2e:b8c6:0:b0:2d1:1dae:c562 with SMTP id s6-20020a2eb8c6000000b002d11daec562mr4928843ljp.6.1708115613459;
        Fri, 16 Feb 2024 12:33:33 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:7758:12d:16:5f19])
        by smtp.gmail.com with ESMTPSA id m5-20020a05600c4f4500b0041253d0acd6sm1420528wmq.47.2024.02.16.12.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 12:33:33 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kalle Valo <kvalo@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Saravana Kannan <saravanak@google.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Arnd Bergmann <arnd@arndb.de>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Alex Elder <elder@linaro.org>,
	Srini Kandagatla <srinivas.kandagatla@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Abel Vesa <abel.vesa@linaro.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v5 14/18] PCI/pwrctl: add a power control driver for WCN7850
Date: Fri, 16 Feb 2024 21:32:11 +0100
Message-Id: <20240216203215.40870-15-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240216203215.40870-1-brgl@bgdev.pl>
References: <20240216203215.40870-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Add a PCI power control driver that's capable of correctly powering up
the ath12k module on WCN7850 using the PCI pwrctl functionality.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/pci/pwrctl/Kconfig              |   8 +
 drivers/pci/pwrctl/Makefile             |   2 +
 drivers/pci/pwrctl/pci-pwrctl-wcn7850.c | 202 ++++++++++++++++++++++++
 3 files changed, 212 insertions(+)
 create mode 100644 drivers/pci/pwrctl/pci-pwrctl-wcn7850.c

diff --git a/drivers/pci/pwrctl/Kconfig b/drivers/pci/pwrctl/Kconfig
index 96195395af69..b91170ebfb49 100644
--- a/drivers/pci/pwrctl/Kconfig
+++ b/drivers/pci/pwrctl/Kconfig
@@ -5,4 +5,12 @@ menu "PCI Power control drivers"
 config PCI_PWRCTL
 	tristate
 
+config PCI_PWRCTL_WCN7850
+	tristate "PCI Power Control driver for WCN7850"
+	select PCI_PWRCTL
+	default m if (ATH12K && ARCH_QCOM)
+	help
+	  Enable support for the PCI power control driver for the ath12k
+	  module of the WCN7850 WLAN/BT chip.
+
 endmenu
diff --git a/drivers/pci/pwrctl/Makefile b/drivers/pci/pwrctl/Makefile
index 52ae0640ef7b..de20c3af1b78 100644
--- a/drivers/pci/pwrctl/Makefile
+++ b/drivers/pci/pwrctl/Makefile
@@ -2,3 +2,5 @@
 
 obj-$(CONFIG_PCI_PWRCTL)		+= pci-pwrctl-core.o
 pci-pwrctl-core-y			:= core.o
+
+obj-$(CONFIG_PCI_PWRCTL_WCN7850)	+= pci-pwrctl-wcn7850.o
diff --git a/drivers/pci/pwrctl/pci-pwrctl-wcn7850.c b/drivers/pci/pwrctl/pci-pwrctl-wcn7850.c
new file mode 100644
index 000000000000..e2b2c53bff29
--- /dev/null
+++ b/drivers/pci/pwrctl/pci-pwrctl-wcn7850.c
@@ -0,0 +1,202 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2024 Linaro Ltd.
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/gpio/consumer.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/pci-pwrctl.h>
+#include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+
+struct pci_pwrctl_wcn7850_vreg {
+	const char *name;
+	unsigned int load_uA;
+};
+
+struct pci_pwrctl_wcn7850_pdata {
+	struct pci_pwrctl_wcn7850_vreg *vregs;
+	size_t num_vregs;
+	unsigned int delay_msec;
+};
+
+struct pci_pwrctl_wcn7850_ctx {
+	struct pci_pwrctl pwrctl;
+	const struct pci_pwrctl_wcn7850_pdata *pdata;
+	struct regulator_bulk_data *regs;
+	struct gpio_desc *en_gpio;
+	struct clk *clk;
+};
+
+static struct pci_pwrctl_wcn7850_vreg pci_pwrctl_wcn7850_vregs[] = {
+	{
+		.name = "vdd",
+		.load_uA = 16000,
+	},
+	{
+		.name = "vddio",
+		.load_uA = 5000,
+	},
+	{
+		.name = "vddio1p2",
+		.load_uA = 16000,
+	},
+	{
+		.name = "vddaon",
+		.load_uA = 26000,
+	},
+	{
+		.name = "vdddig",
+		.load_uA = 126000,
+	},
+	{
+		.name = "vddrfa1p2",
+		.load_uA = 257000,
+	},
+	{
+		.name = "vddrfa1p8",
+		.load_uA = 302000,
+	},
+};
+
+static struct pci_pwrctl_wcn7850_pdata pci_pwrctl_wcn7850_of_data = {
+	.vregs = pci_pwrctl_wcn7850_vregs,
+	.num_vregs = ARRAY_SIZE(pci_pwrctl_wcn7850_vregs),
+	.delay_msec = 50,
+};
+
+static int pci_pwrctl_wcn7850_power_on(struct pci_pwrctl_wcn7850_ctx *ctx)
+{
+	int ret;
+
+	ret = regulator_bulk_enable(ctx->pdata->num_vregs, ctx->regs);
+	if (ret)
+		return ret;
+
+	ret = clk_prepare_enable(ctx->clk);
+	if (ret)
+		return ret;
+
+	gpiod_set_value_cansleep(ctx->en_gpio, 1);
+
+	if (ctx->pdata->delay_msec)
+		msleep(ctx->pdata->delay_msec);
+
+	return 0;
+}
+
+static int pci_pwrctl_wcn7850_power_off(struct pci_pwrctl_wcn7850_ctx *ctx)
+{
+	gpiod_set_value_cansleep(ctx->en_gpio, 0);
+	clk_disable_unprepare(ctx->clk);
+
+	return regulator_bulk_disable(ctx->pdata->num_vregs, ctx->regs);
+}
+
+static void devm_pci_pwrctl_wcn7850_power_off(void *data)
+{
+	struct pci_pwrctl_wcn7850_ctx *ctx = data;
+
+	pci_pwrctl_wcn7850_power_off(ctx);
+}
+
+static int pci_pwrctl_wcn7850_probe(struct platform_device *pdev)
+{
+	struct pci_pwrctl_wcn7850_ctx *ctx;
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
+			if (!ctx->pdata->vregs[1].load_uA)
+				continue;
+
+			ret = regulator_set_load(ctx->regs[i].consumer,
+						 ctx->pdata->vregs[i].load_uA);
+			if (ret)
+				return dev_err_probe(dev, ret,
+						     "Failed to set vreg load\n");
+		}
+	}
+
+	ctx->clk = devm_clk_get_optional(dev, NULL);
+	if (IS_ERR(ctx->clk))
+		return dev_err_probe(dev, PTR_ERR(ctx->clk),
+				     "Failed to get clock\n");
+
+	ctx->en_gpio = devm_gpiod_get_optional(dev, "enable", GPIOD_OUT_LOW);
+	if (IS_ERR(ctx->en_gpio))
+		return dev_err_probe(dev, PTR_ERR(ctx->en_gpio),
+				     "Failed to get enable the GPIO\n");
+
+	ret = pci_pwrctl_wcn7850_power_on(ctx);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to power on the device\n");
+
+	ret = devm_add_action_or_reset(dev, devm_pci_pwrctl_wcn7850_power_off,
+				       ctx);
+	if (ret)
+		return ret;
+
+	ctx->pwrctl.dev = dev;
+
+	ret = devm_pci_pwrctl_device_set_ready(dev, &ctx->pwrctl);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to register the pwrctl wrapper\n");
+
+	return 0;
+}
+
+static const struct of_device_id pci_pwrctl_wcn7850_of_match[] = {
+	{
+		.compatible = "pci17cb,1107",
+		.data = &pci_pwrctl_wcn7850_of_data,
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, pci_pwrctl_wcn7850_of_match);
+
+static struct platform_driver pci_pwrctl_wcn7850_driver = {
+	.driver = {
+		.name = "pci-pwrctl-wcn7850",
+		.of_match_table = pci_pwrctl_wcn7850_of_match,
+	},
+	.probe = pci_pwrctl_wcn7850_probe,
+};
+module_platform_driver(pci_pwrctl_wcn7850_driver);
+
+MODULE_AUTHOR("Bartosz Golaszewski <bartosz.golaszewski@linaro.org>");
+MODULE_DESCRIPTION("PCI Power Sequencing module for WCN7850");
+MODULE_LICENSE("GPL");
-- 
2.40.1


