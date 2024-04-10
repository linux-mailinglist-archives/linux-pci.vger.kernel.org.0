Return-Path: <linux-pci+bounces-6028-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEDD389F304
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 14:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25AB71F27E09
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 12:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B3F175579;
	Wed, 10 Apr 2024 12:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="T0WPsyDZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB6115ECE2
	for <linux-pci@vger.kernel.org>; Wed, 10 Apr 2024 12:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712753236; cv=none; b=mBN0qt3Pyp4Rs/A6AwGifnHGpat8zKWgziv8Gu/ck/QzMCfNAnvUKuTX/6nxRB2u5oB3Ml5HxD0cK+Nl56kpCjXTKT5oSWWIHfZ6TowoKZcAdBpI5dZpL6RZNjQf0r6j2rktehj/k26mr8XdIlCaxU4hFnfPPWHsOE4i9ibTwYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712753236; c=relaxed/simple;
	bh=mT8EtEqSsc1usaT07FcKi55aNWb5O03fQyO7Z6PPFnQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oCXKgCwLR1d8ZX1O1SV+dY/hXMAR6DVffh1NOhtO6+vLZQcVQt4aGsRBcOFCPZhmfIHQAYIRHBjUlRkk1/oHxnEQN44rCFdgbQaBOwlupnLr4O52POLQLUvCLmfUoq/4BRXzIbKUklonPi0FTiVPOC9rc672EA49hpwa32KiZ44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=T0WPsyDZ; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-417c5aa35f6so757745e9.3
        for <linux-pci@vger.kernel.org>; Wed, 10 Apr 2024 05:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1712753231; x=1713358031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C9nJwjHWSN5VnvThb8/gXwDKA0GcEMuTEtkVY9Mb9jo=;
        b=T0WPsyDZOmAbW1cshFCGrZzfrjwq4Y7hRd3dNJAO+DCMd76Tox373FFMGN2yrz/BtZ
         uJyPBpzZuuAjTfwtKYo5DMDByX4PoXTqZjwtt3FWI+RIeYYtA6z6ITN6lPxE7NvbA1J/
         +9sw3pyyp0h2g3FcUS7LN/cQRBGiuTIw7bX9kVFZL8rveSg/7R36epEcjrsEy69ONJCX
         qHp/961gF4Lxe7EtWitDwZAqBsjzWj3sB6v6GNkU7UQRR8NMMEHMbMbydzsH8agyH0l4
         VeUcrKd32w8xZvV40xWjHx20VhTBvRSDoIVK6rjM1aqNdCvcOadfhuZzKWI+QM+hCLmM
         AmUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712753231; x=1713358031;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C9nJwjHWSN5VnvThb8/gXwDKA0GcEMuTEtkVY9Mb9jo=;
        b=beSsidaHwhvPYcwX42Zoa9wLp9wxwFjkqSk8WSMAyfJnttuNzZnc4PuMGZ9r4k1yZx
         1MRx/nMPWltwTw/yuYyILSLfod9NdgzW7yJ/Py10LqEg58rZYA4sYXPL/WXMeJrFFBw/
         y098XdRNM0y4RGO3H2Wgtbo8fKYaABM3qplqgX1rTQjvmVWWfDKYk6P7WmTooaGemGEd
         9ylmOIu8gUpWqCYi4rOL4GVpzwiD2dUbKkgeBOBE1aoG94XV9IKN74YkniXpo9HCBbaQ
         xA8NvkagBwHjobC8j12SKLMu+eGZw3jvqRL6w1cllpq2I/P85A60Ub6SEZGNfFzo0VyU
         +p+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXJTQ0OIhZBMXiBLHTYv8Hsa/z5iFGRh3Y+Ug2bg2B2J2uBpLzeUBn4NN9ICxeuqxfhUAn2fW8Z8PfAoS5jPlqxjCLkaBOCboj2
X-Gm-Message-State: AOJu0YwIOYxWtd2pCkMt2wwuWSPBfFqK9CFREcJPe9lw/KWshPA95Dlv
	mYyNYdBtH4VjyyafFiTjES7/q8Axv23f9KPNQRxrVd10kwR3Ebexf1a5+ODhV1s=
X-Google-Smtp-Source: AGHT+IFCpMCRLZeNcDG7mwgI53MN/iZz+XnsHhltIcG36A4bX4T2fmggt2l+ZNhTWE7EE0oL5P9KTw==
X-Received: by 2002:a7b:ca53:0:b0:416:902e:51ae with SMTP id m19-20020a7bca53000000b00416902e51aemr1549746wml.17.1712753231388;
        Wed, 10 Apr 2024 05:47:11 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:75a:e000:6908:7e99:35c9:d585])
        by smtp.gmail.com with ESMTPSA id v13-20020a05600c444d00b0041663450a4asm2150929wmn.45.2024.04.10.05.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 05:47:11 -0700 (PDT)
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
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Amit Pundir <amit.pundir@linaro.org>,
	Xilin Wu <wuxilin123@gmail.com>
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
Subject: [PATCH v7 14/16] power: pwrseq: add a driver for the PMU module on the QCom WCN chipsets
Date: Wed, 10 Apr 2024 14:46:26 +0200
Message-Id: <20240410124628.171783-15-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240410124628.171783-1-brgl@bgdev.pl>
References: <20240410124628.171783-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

This adds the power sequencing driver for the PMU modules present on the
Qualcomm WCN Bluetooth and Wifi chipsets. It uses the pwrseq subsystem
and knows how to match the sequencer to the consumer device by verifying
the relevant properties and DT layout.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/power/sequencing/Kconfig           |  16 +
 drivers/power/sequencing/Makefile          |   2 +
 drivers/power/sequencing/pwrseq-qcom-wcn.c | 336 +++++++++++++++++++++
 3 files changed, 354 insertions(+)
 create mode 100644 drivers/power/sequencing/pwrseq-qcom-wcn.c

diff --git a/drivers/power/sequencing/Kconfig b/drivers/power/sequencing/Kconfig
index ba5732b1dbf8..468d58fac07d 100644
--- a/drivers/power/sequencing/Kconfig
+++ b/drivers/power/sequencing/Kconfig
@@ -10,3 +10,19 @@ menuconfig POWER_SEQUENCING
 	  during power-up.
 
 	  If unsure, say no.
+
+if POWER_SEQUENCING
+
+config POWER_SEQUENCING_QCOM_WCN
+	tristate "Qualcomm WCN family PMU driver"
+	default m if ARCH_QCOM
+	help
+	  Say U here to enable the power sequencing driver for Qualcomm
+	  WCN Bluetooth/WLAN chipsets.
+
+	  Typically, a package from the Qualcomm WCN family contains the BT
+	  and WLAN modules whose power is controlled by the PMU module. As the
+	  former two share the power-up sequence which is executed by the PMU,
+	  this driver is needed for correct power control.
+
+endif
diff --git a/drivers/power/sequencing/Makefile b/drivers/power/sequencing/Makefile
index dcdf8c0c159e..2eec2df7912d 100644
--- a/drivers/power/sequencing/Makefile
+++ b/drivers/power/sequencing/Makefile
@@ -2,3 +2,5 @@
 
 obj-$(CONFIG_POWER_SEQUENCING)		+= pwrseq-core.o
 pwrseq-core-y				:= core.o
+
+obj-$(CONFIG_POWER_SEQUENCING_QCOM_WCN)	+= pwrseq-qcom-wcn.o
diff --git a/drivers/power/sequencing/pwrseq-qcom-wcn.c b/drivers/power/sequencing/pwrseq-qcom-wcn.c
new file mode 100644
index 000000000000..380305227b3f
--- /dev/null
+++ b/drivers/power/sequencing/pwrseq-qcom-wcn.c
@@ -0,0 +1,336 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2024 Linaro Ltd.
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/gpio/consumer.h>
+#include <linux/jiffies.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
+#include <linux/pwrseq/provider.h>
+#include <linux/string.h>
+#include <linux/types.h>
+
+struct pwrseq_qcom_wcn_pdata {
+	const char *const *vregs;
+	size_t num_vregs;
+	unsigned int pwup_delay_msec;
+	unsigned int gpio_enable_delay;
+};
+
+struct pwrseq_qcom_wcn_ctx {
+	struct pwrseq_device *pwrseq;
+	struct device_node *of_node;
+	const struct pwrseq_qcom_wcn_pdata *pdata;
+	struct regulator_bulk_data *regs;
+	struct gpio_desc *bt_gpio;
+	struct gpio_desc *wlan_gpio;
+	struct clk *clk;
+	unsigned long last_gpio_enable;
+};
+
+static void pwrseq_qcom_wcn_ensure_gpio_delay(struct pwrseq_qcom_wcn_ctx *ctx)
+{
+	unsigned long diff_jiffies;
+	unsigned int diff_msecs;
+
+	if (!ctx->pdata->gpio_enable_delay)
+		return;
+
+	diff_jiffies = jiffies - ctx->last_gpio_enable;
+	diff_msecs = jiffies_to_msecs(diff_jiffies);
+
+	if (diff_msecs < ctx->pdata->gpio_enable_delay)
+		msleep(ctx->pdata->gpio_enable_delay - diff_msecs);
+}
+
+static int pwrseq_qcom_wcn_vregs_enable(struct pwrseq_device *pwrseq)
+{
+	struct pwrseq_qcom_wcn_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
+
+	return regulator_bulk_enable(ctx->pdata->num_vregs, ctx->regs);
+}
+
+static int pwrseq_qcom_wcn_vregs_disable(struct pwrseq_device *pwrseq)
+{
+	struct pwrseq_qcom_wcn_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
+
+	return regulator_bulk_disable(ctx->pdata->num_vregs, ctx->regs);
+}
+
+static const struct pwrseq_unit_data pwrseq_qcom_wcn_vregs_unit_data = {
+	.name = "regulators-enable",
+	.enable = pwrseq_qcom_wcn_vregs_enable,
+	.disable = pwrseq_qcom_wcn_vregs_disable,
+};
+
+static int pwrseq_qcom_wcn_clk_enable(struct pwrseq_device *pwrseq)
+{
+	struct pwrseq_qcom_wcn_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
+
+	return clk_prepare_enable(ctx->clk);
+}
+
+static int pwrseq_qcom_wcn_clk_disable(struct pwrseq_device *pwrseq)
+{
+	struct pwrseq_qcom_wcn_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
+
+	clk_disable_unprepare(ctx->clk);
+
+	return 0;
+}
+
+static const struct pwrseq_unit_data pwrseq_qcom_wcn_clk_unit_data = {
+	.name = "clock-enable",
+	.enable = pwrseq_qcom_wcn_clk_enable,
+	.disable = pwrseq_qcom_wcn_clk_disable,
+};
+
+static const struct pwrseq_unit_data *pwrseq_qcom_wcn_unit_deps[] = {
+	&pwrseq_qcom_wcn_vregs_unit_data,
+	&pwrseq_qcom_wcn_clk_unit_data,
+	NULL
+};
+
+static int pwrseq_qcom_wcn_bt_enable(struct pwrseq_device *pwrseq)
+{
+	struct pwrseq_qcom_wcn_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
+
+	pwrseq_qcom_wcn_ensure_gpio_delay(ctx);
+	gpiod_set_value_cansleep(ctx->bt_gpio, 1);
+	ctx->last_gpio_enable = jiffies;
+
+	return 0;
+}
+
+static int pwrseq_qcom_wcn_bt_disable(struct pwrseq_device *pwrseq)
+{
+	struct pwrseq_qcom_wcn_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
+
+	gpiod_set_value_cansleep(ctx->bt_gpio, 0);
+
+	return 0;
+}
+
+static const struct pwrseq_unit_data pwrseq_qcom_wcn_bt_unit_data = {
+	.name = "bluetooth-enable",
+	.deps = pwrseq_qcom_wcn_unit_deps,
+	.enable = pwrseq_qcom_wcn_bt_enable,
+	.disable = pwrseq_qcom_wcn_bt_disable,
+};
+
+static int pwrseq_qcom_wcn_wlan_enable(struct pwrseq_device *pwrseq)
+{
+	struct pwrseq_qcom_wcn_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
+
+	pwrseq_qcom_wcn_ensure_gpio_delay(ctx);
+	gpiod_set_value_cansleep(ctx->wlan_gpio, 1);
+	ctx->last_gpio_enable = jiffies;
+
+	return 0;
+}
+
+static int pwrseq_qcom_wcn_wlan_disable(struct pwrseq_device *pwrseq)
+{
+	struct pwrseq_qcom_wcn_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
+
+	gpiod_set_value_cansleep(ctx->wlan_gpio, 0);
+
+	return 0;
+}
+
+static const struct pwrseq_unit_data pwrseq_qcom_wcn_wlan_unit_data = {
+	.name = "wlan-enable",
+	.deps = pwrseq_qcom_wcn_unit_deps,
+	.enable = pwrseq_qcom_wcn_wlan_enable,
+	.disable = pwrseq_qcom_wcn_wlan_disable,
+};
+
+static int pwrseq_qcom_wcn_pwup_delay(struct pwrseq_device *pwrseq)
+{
+	struct pwrseq_qcom_wcn_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
+
+	if (ctx->pdata->pwup_delay_msec)
+		msleep(ctx->pdata->pwup_delay_msec);
+
+	return 0;
+}
+
+static const struct pwrseq_target_data pwrseq_qcom_wcn_bt_target_data = {
+	.name = "bluetooth",
+	.unit = &pwrseq_qcom_wcn_bt_unit_data,
+	.post_enable = pwrseq_qcom_wcn_pwup_delay,
+};
+
+static const struct pwrseq_target_data pwrseq_qcom_wcn_wlan_target_data = {
+	.name = "wlan",
+	.unit = &pwrseq_qcom_wcn_wlan_unit_data,
+	.post_enable = pwrseq_qcom_wcn_pwup_delay,
+};
+
+static const struct pwrseq_target_data *pwrseq_qcom_wcn_targets[] = {
+	&pwrseq_qcom_wcn_bt_target_data,
+	&pwrseq_qcom_wcn_wlan_target_data,
+	NULL
+};
+
+static const char *const pwrseq_qca6390_vregs[] = {
+	"vddio",
+	"vddaon",
+	"vddpmu",
+	"vddrfa0p95",
+	"vddrfa1p3",
+	"vddrfa1p9",
+	"vddpcie1p3",
+	"vddpcie1p9",
+};
+
+static const struct pwrseq_qcom_wcn_pdata pwrseq_qca6390_of_data = {
+	.vregs = pwrseq_qca6390_vregs,
+	.num_vregs = ARRAY_SIZE(pwrseq_qca6390_vregs),
+	.pwup_delay_msec = 60,
+	.gpio_enable_delay = 100,
+};
+
+static const char *const pwrseq_wcn7850_vregs[] = {
+	"vdd",
+	"vddio",
+	"vddio1p2",
+	"vddaon",
+	"vdddig",
+	"vddrfa1p2",
+	"vddrfa1p8",
+};
+
+static const struct pwrseq_qcom_wcn_pdata pwrseq_wcn7850_of_data = {
+	.vregs = pwrseq_wcn7850_vregs,
+	.num_vregs = ARRAY_SIZE(pwrseq_wcn7850_vregs),
+	.pwup_delay_msec = 50,
+};
+
+static int pwrseq_qcom_wcn_match(struct pwrseq_device *pwrseq,
+				 struct device *dev)
+{
+	struct pwrseq_qcom_wcn_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
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
+	struct device_node *reg_node __free(device_node) =
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
+static int pwrseq_qcom_wcn_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct pwrseq_qcom_wcn_ctx *ctx;
+	struct pwrseq_config config;
+	int i, ret;
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
+	ctx->regs = devm_kcalloc(dev, ctx->pdata->num_vregs,
+				 sizeof(*ctx->regs), GFP_KERNEL);
+	if (!ctx->regs)
+		return -ENOMEM;
+
+	for (i = 0; i < ctx->pdata->num_vregs; i++)
+		ctx->regs[i].supply = ctx->pdata->vregs[i];
+
+	ret = devm_regulator_bulk_get(dev, ctx->pdata->num_vregs, ctx->regs);
+	if (ret < 0)
+		return dev_err_probe(dev, PTR_ERR(ctx->regs),
+				     "Failed to get all regulators\n");
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
+	ctx->clk = devm_clk_get_optional(dev, NULL);
+	if (IS_ERR(ctx->clk))
+		return dev_err_probe(dev, PTR_ERR(ctx->clk),
+				     "Failed to get the reference clock\n");
+
+	memset(&config, 0, sizeof(config));
+
+	config.parent = dev;
+	config.owner = THIS_MODULE;
+	config.drvdata = ctx;
+	config.match = pwrseq_qcom_wcn_match;
+	config.targets = pwrseq_qcom_wcn_targets;
+
+	ctx->pwrseq = devm_pwrseq_device_register(dev, &config);
+	if (IS_ERR(ctx->pwrseq))
+		return dev_err_probe(dev, PTR_ERR(ctx->pwrseq),
+				     "Failed to register the power sequencer\n");
+
+	return 0;
+}
+
+static const struct of_device_id pwrseq_qcom_wcn_of_match[] = {
+	{
+		.compatible = "qcom,qca6390-pmu",
+		.data = &pwrseq_qca6390_of_data,
+	},
+	{
+		.compatible = "qcom,wcn7850-pmu",
+		.data = &pwrseq_wcn7850_of_data,
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, pwrseq_qcom_wcn_of_match);
+
+static struct platform_driver pwrseq_qcom_wcn_driver = {
+	.driver = {
+		.name = "pwrseq-qcom_wcn",
+		.of_match_table = pwrseq_qcom_wcn_of_match,
+	},
+	.probe = pwrseq_qcom_wcn_probe,
+};
+module_platform_driver(pwrseq_qcom_wcn_driver);
+
+MODULE_AUTHOR("Bartosz Golaszewski <bartosz.golaszewski@linaro.org>");
+MODULE_DESCRIPTION("Qualcomm WCN PMU power sequencing driver");
+MODULE_LICENSE("GPL");
-- 
2.40.1


