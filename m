Return-Path: <linux-pci+bounces-2932-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 67AB8845C5A
	for <lists+linux-pci@lfdr.de>; Thu,  1 Feb 2024 16:58:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C846B29297
	for <lists+linux-pci@lfdr.de>; Thu,  1 Feb 2024 15:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF5D15B984;
	Thu,  1 Feb 2024 15:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="G9RWTJ74"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8084779FB
	for <linux-pci@vger.kernel.org>; Thu,  1 Feb 2024 15:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706802949; cv=none; b=UI3/0/mZhRrhb4xNmB47ThZMaAg3iHGP2Uuv1rCOoC2biGfluITtPZRSIq3SkTGPd9LT8Pgw0WSlZid+WvS21r/ySV8o9PbPftLyo0zdxqLWpNRWmv5CjNvLQS+AdxVvT3oldJEEro8mhGVJ8RUHBZKW4CdmUDmQe4KmHGqcha8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706802949; c=relaxed/simple;
	bh=l970XQK253auBEaf1sxyowqJp9xH8paHYFxN6sDXauI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cxmMi8AkgnQXeHWkX9Fx+5J8J4F1lsQuyj+j4gZ15BNJiy4ErPjb+C4/kAJmQikMChnBd8jMFztx7b3dd4HlsYeE7QQrgGLBIHpVnPgbkMN2y68Zi+w+MOQjs8DaLOYgBVdMEv4mMHfYWEbFsMxxyL0yNsQxI5r/mtZLpeNupzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=G9RWTJ74; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-33b1b95df3bso156589f8f.0
        for <linux-pci@vger.kernel.org>; Thu, 01 Feb 2024 07:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1706802945; x=1707407745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LiBDDlOs/2wfibbPM7pcc8BqiHTc+Y7z4AiaXyajHnk=;
        b=G9RWTJ746Il9xgpvbYa/5DB88zEYC1FN5DandYEhLoXxVacjQi7qCbIkPI6Bb3M006
         0dXeq/a9lnijUHPM+hdoe6bLrU1hViCqmHH06/Xa5H7uIkx6tKm6W3HA4lfg0GOiYGql
         TSZ/SGs57KheHbcwBhqbczLf4fnOay0iCAbRRXeAeIxQxKmU5rKg2CZel26xO27xxvqn
         q7nqcp7qF/nscWvxjoOLVhvmOJjllTufMWFssUmFKUuM2jaE6vU8NBikMYjbhXPkNOZb
         HAVBxhM49Qs36Q/vtNq/BlKmej1xiEhq+Nsu86s5h1l9/+U5rzdbtbLXanfXEw3Szbvu
         u38g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706802945; x=1707407745;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LiBDDlOs/2wfibbPM7pcc8BqiHTc+Y7z4AiaXyajHnk=;
        b=VAItv0hUNBLMJGJOQmUVzVcNCnhyip4umozAlCvu5ezutY/wuRraK7GDGbQJLRZAef
         LYhIQWTpdYcnTxsGg5R2nbQllwm7jF6ECsbbOwkqvAn+ofp6uVvph+PWxnPj6B/ju9OE
         d9MdTABRjr6uYqtzcI7XhbcK1kXvatuXV6x+1wx8KWkLiFN42VZMSJ1RbbPAPlIsKsTj
         pbk8kWCJrkzyGl7LBeH80QWASoPVU/HBf49bAXJ6jpm82uoFT7t5PDZkUnIE+ufu+GPE
         Ze+9RCqL5rBdVBJNzVvEAFDy8vwicDut7j50nGmtimufz9CTYea5NeByRR/pNTJRidaM
         1CQQ==
X-Gm-Message-State: AOJu0YxrVow7bIQzG8AquhNvs/uxL05KMhMAphO3wbDZWqEwE0pXZdDO
	AtregjzfWSNvithmoiQ8bKBp1zrutlPhFnQE7+BJSjTlCC65zW3zjGx6LrJjPUI=
X-Google-Smtp-Source: AGHT+IHxONjLYq+jzZhOLqBDb8Gde9vLS8rl0OD8rTABSRercwHSWNE8jCpnLlSK2NSuoUdjMDgg3A==
X-Received: by 2002:a05:6000:192:b0:33a:eeec:88a0 with SMTP id p18-20020a056000019200b0033aeeec88a0mr3985658wrx.37.1706802945207;
        Thu, 01 Feb 2024 07:55:45 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUaySnrCpckAG9NxaYAlvPP8d7ea+hPHInzet8cV6mP05yLPA3X3eVUPeRSd5tyEQTjEK2RfI6Z000TtduQHxFZjajbUTJgSZP0SnKkTxq0Sp36jZ6hvtpOv5UFAmBcVZEMi+S7ALmOf8UOhS5EWeh8pCP6sFcTY+DvNDzyOmEJbZXFECyWPvvKZ7G3Vk6kiQ3Un4lnyIRxrAajgBOo+IuFMXFOxpNkVavcaixTnLVHxjyxAK/A/rG9mSHEaT1ENyNcloNiC9jFsxAjnyQNJ03sgIa3/CX2+vaMHcGK78oAFSItGyZszpE0Eq+uTd1Xv5QRoeDnaEXmXt3hh+dabnLxLO05r55BaLKduYH8q09ulAd7Qr7kBJi4cSNZ7Dwk/T5kWj1Z/rGFY5ZhDmJ0JA/eYJ6LP9wakINW7EAanza0r40cKFRl9vFzSJ66dXuJbbb9YiOvRpT/jsTi1U48tzrjkAvvs22Bg0Dzx31P7R8Hhk+Q6qnILQ58sm/j9q0suSh+jc+mj7qjX1UQmS441o/wiuSBTETLvJkiXp998mBM5mG8rAMudS8YmVv/tvnQxbnsXgiFrzXlr8MFE5oC8NS1FFrvBw4W/bB/0ASIK3YqBaWV+BNvrqjq2jznDQ5nwYRaHGQz9jP6yjMFni0M6qBiC9xTNhjN60oN4xdJUTAN3/m+4eM7g9qjy1MfZWktNv9KxVt44o+R
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:dd01:5dec:43e3:b607])
        by smtp.gmail.com with ESMTPSA id ce2-20020a5d5e02000000b0033af4848124sm9650318wrb.109.2024.02.01.07.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 07:55:44 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Alex Elder <elder@linaro.org>,
	Srini Kandagatla <srinivas.kandagatla@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Abel Vesa <abel.vesa@linaro.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lukas Wunner <lukas@wunner.de>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [RFC 4/9] power: pwrseq: add a driver for the QCA6390 PMU module
Date: Thu,  1 Feb 2024 16:55:27 +0100
Message-Id: <20240201155532.49707-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240201155532.49707-1-brgl@bgdev.pl>
References: <20240201155532.49707-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

This adds the power sequencing driver for the QCA6390's PMU module. It
uses the pwrseq subsystem and knows how to match the sequencer to the
consumer device by verifying the relevant properties and DT layout.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/power/sequencing/Kconfig          |  16 ++
 drivers/power/sequencing/Makefile         |   2 +
 drivers/power/sequencing/pwrseq-qca6390.c | 232 ++++++++++++++++++++++
 3 files changed, 250 insertions(+)
 create mode 100644 drivers/power/sequencing/pwrseq-qca6390.c

diff --git a/drivers/power/sequencing/Kconfig b/drivers/power/sequencing/Kconfig
index ba5732b1dbf8..84ddf3b4ae56 100644
--- a/drivers/power/sequencing/Kconfig
+++ b/drivers/power/sequencing/Kconfig
@@ -10,3 +10,19 @@ menuconfig POWER_SEQUENCING
 	  during power-up.
 
 	  If unsure, say no.
+
+if POWER_SEQUENCING
+
+config POWER_SEQUENCING_QCA6390
+	tristate "QCA6390 PMU driver"
+	default m if ARCH_QCOM
+	help
+	  Say U here to enable the power sequencing driver for Qualcomm
+	  QCA6390.
+
+	  The QCA6390 package contains the BT and WLAN modules whose power
+	  is controlled by the PMU module. As the former two share the power-up
+	  sequence which is executed by the PMU, this driver is needed for
+	  correct power control.
+
+endif
diff --git a/drivers/power/sequencing/Makefile b/drivers/power/sequencing/Makefile
index dcdf8c0c159e..628345c4e7ae 100644
--- a/drivers/power/sequencing/Makefile
+++ b/drivers/power/sequencing/Makefile
@@ -2,3 +2,5 @@
 
 obj-$(CONFIG_POWER_SEQUENCING)		+= pwrseq-core.o
 pwrseq-core-y				:= core.o
+
+obj-$(CONFIG_POWER_SEQUENCING_QCA6390)	+= pwrseq-qca6390.o
diff --git a/drivers/power/sequencing/pwrseq-qca6390.c b/drivers/power/sequencing/pwrseq-qca6390.c
new file mode 100644
index 000000000000..6c930e3e88ec
--- /dev/null
+++ b/drivers/power/sequencing/pwrseq-qca6390.c
@@ -0,0 +1,232 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024 Linaro Ltd.
+ */
+
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/gpio/consumer.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
+#include <linux/pwrseq/provider.h>
+#include <linux/string.h>
+#include <linux/types.h>
+
+struct pwrseq_qca6390_vreg {
+	const char *name;
+	unsigned int load_uA;
+};
+
+struct pwrseq_qca6390_pdata {
+	const struct pwrseq_qca6390_vreg *vregs;
+	size_t num_vregs;
+	unsigned int pwup_delay_msec;
+};
+
+struct pwrseq_qca6390_ctx {
+	struct pwrseq_device *pwrseq;
+	struct device_node *of_node;
+	const struct pwrseq_qca6390_pdata *pdata;
+	struct regulator_bulk_data *regs;
+	struct gpio_desc *bt_gpio;
+	struct gpio_desc *wlan_gpio;
+};
+
+static const struct pwrseq_qca6390_vreg pwrseq_qca6390_vregs[] = {
+	{
+		.name = "vddio",
+		.load_uA = 20000,
+	},
+	{
+		.name = "vddaon",
+		.load_uA = 100000,
+	},
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
+	{
+		.name = "vddrfa1",
+		.load_uA = 200000,
+	},
+	{
+		.name = "vddrfa2",
+		.load_uA = 400000,
+	},
+	{
+		.name = "vddrfa3",
+		.load_uA = 400000,
+	},
+};
+
+static const struct pwrseq_qca6390_pdata pwrseq_qca6390_of_data = {
+	.vregs = pwrseq_qca6390_vregs,
+	.num_vregs = ARRAY_SIZE(pwrseq_qca6390_vregs),
+	.pwup_delay_msec = 16,
+};
+
+static int pwrseq_qca6390_power_on(struct pwrseq_device *pwrseq)
+{
+	struct pwrseq_qca6390_ctx *ctx = pwrseq_device_get_data(pwrseq);
+	int ret;
+
+	ret = regulator_bulk_enable(ctx->pdata->num_vregs, ctx->regs);
+	if (ret)
+		return ret;
+
+	gpiod_set_value_cansleep(ctx->bt_gpio, 1);
+	gpiod_set_value_cansleep(ctx->wlan_gpio, 1);
+
+	if (ctx->pdata->pwup_delay_msec)
+		msleep(ctx->pdata->pwup_delay_msec);
+
+	return 0;
+}
+
+static int pwrseq_qca6390_power_off(struct pwrseq_device *pwrseq)
+{
+	struct pwrseq_qca6390_ctx *ctx = pwrseq_device_get_data(pwrseq);
+
+	gpiod_set_value_cansleep(ctx->bt_gpio, 0);
+	gpiod_set_value_cansleep(ctx->wlan_gpio, 0);
+
+	return regulator_bulk_disable(ctx->pdata->num_vregs, ctx->regs);
+}
+
+static int pwrseq_qca6390_match(struct pwrseq_device *pwrseq,
+				struct device *dev)
+{
+	struct pwrseq_qca6390_ctx *ctx = pwrseq_device_get_data(pwrseq);
+	struct device_node *dev_node = dev->of_node;
+
+	/*
+	 * The PMU supplies power to the Bluetooth and WLAN modules. both
+	 * consume the PMU AON output so check the presence of the
+	 * 'vddaon-supply' property and whether it leads us to the right
+	 * device.
+	 */
+	if (!of_property_present(dev_node, "vddaon-supply"))
+		return 0;
+
+	struct device_node *reg_node __free(of_node) =
+			of_parse_phandle(dev_node, "vddaon-supply", 0);
+	if (!reg_node)
+		return 0;
+
+	/*
+	 * `reg_node` is the PMU AON regulator, its parent is the `regulators`
+	 * node and finally its grandparent is the PMU device node that we're
+	 * looking for.
+	 */
+	if (!reg_node->parent || !reg_node->parent->parent ||
+	    reg_node->parent->parent != ctx->of_node)
+		return 0;
+
+	return 1;
+}
+
+static int pwrseq_qca6390_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct pwrseq_qca6390_ctx *ctx;
+	struct pwrseq_config config;
+	int ret, i;
+
+	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	ctx->of_node = dev->of_node;
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
+	ctx->bt_gpio = devm_gpiod_get_optional(dev, "bt-enable", GPIOD_OUT_LOW);
+	if (IS_ERR(ctx->bt_gpio))
+		return dev_err_probe(dev, PTR_ERR(ctx->bt_gpio),
+				     "Failed to get the Bluetooth enable GPIO\n");
+
+	ctx->wlan_gpio = devm_gpiod_get_optional(dev, "wlan-enable",
+						 GPIOD_OUT_LOW);
+	if (IS_ERR(ctx->wlan_gpio))
+		return dev_err_probe(dev, PTR_ERR(ctx->wlan_gpio),
+				     "Failed to get the WLAN enable GPIO\n");
+
+	memset(&config, 0, sizeof(config));
+
+	config.parent = dev;
+	config.owner = THIS_MODULE;
+	config.drvdata = ctx;
+	config.match = pwrseq_qca6390_match;
+	config.power_on = pwrseq_qca6390_power_on;
+	config.power_off = pwrseq_qca6390_power_off;
+
+	ctx->pwrseq = devm_pwrseq_device_register(dev, &config);
+	if (IS_ERR(ctx->pwrseq))
+		return dev_err_probe(dev, PTR_ERR(ctx->pwrseq),
+				     "Failed to register the power sequencer\n");
+
+	return 0;
+}
+
+static const struct of_device_id pwrseq_qca6390_of_match[] = {
+	{
+		.compatible = "qcom,qca6390-pmu",
+		.data = &pwrseq_qca6390_of_data,
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, pwrseq_qca6390_of_match);
+
+static struct platform_driver pwrseq_qca6390_driver = {
+	.driver = {
+		.name = "pwrseq-qca6390",
+		.of_match_table = pwrseq_qca6390_of_match,
+	},
+	.probe = pwrseq_qca6390_probe,
+};
+module_platform_driver(pwrseq_qca6390_driver);
+
+MODULE_AUTHOR("Bartosz Golaszewski <bartosz.golaszewski@linaro.org>");
+MODULE_DESCRIPTION("QCA6390 PMU power sequencing driver");
+MODULE_LICENSE("GPL");
-- 
2.40.1


