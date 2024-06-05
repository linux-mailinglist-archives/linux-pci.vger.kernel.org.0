Return-Path: <linux-pci+bounces-8328-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 822968FCECD
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 15:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C82C2896D3
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 13:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E5819ADBF;
	Wed,  5 Jun 2024 12:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="0r4Ys5eC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596AC1993BE
	for <linux-pci@vger.kernel.org>; Wed,  5 Jun 2024 12:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717591178; cv=none; b=q+b/5pljMmME2Nn0T0ttAFxI0XUPxpE6OjEoQ5IAeeOMfyBcALro0asjgHLqXV7t6XHjjbJyoyeNN65dmfDTB3FyxR6+NFF8bFKjt0sm04Oaqwk3ANVAcEPy7lronDyZBeW6YQ3+oxRDBKG1YoEDmY+jMeRYfqiegkqybO4fGO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717591178; c=relaxed/simple;
	bh=yU1zUf+faD6JgyhE+bFIg993kTzscUEBjSG8Xzmsj+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LvECwm6CTVBLqmcfVMkXv/f7O5Hbd5QQiOOjFcW4MamEkQmstYZFWOOYX7FZrZZmmeHmjVMuQrod28j/PR/9fS4doZtxWHK4ZfTTti/7iKt0uIakoWGKyL3zFj4bKNYBrv9cUQjRbF57wux2Xzkuv2m0dIq9vhHNEtLyMNbko1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=0r4Ys5eC; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42148c0cb1aso20177935e9.3
        for <linux-pci@vger.kernel.org>; Wed, 05 Jun 2024 05:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1717591174; x=1718195974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nLJqIWJeQNkMBFWQ7v6+RLQIvbPqzd6527VcybskqUQ=;
        b=0r4Ys5eCOciGHV9E0CezTMIftDUarXkGTMULtr70tUAQ9dVopJ5PJIHDkXe/+O855m
         jaMuh2SFdJVoTWHrfmo0ypfasJDbXmovY14tPsuj8duV7mvRcGkkdjfKC1y0Dx2YdEY1
         p9Nmka51RPEPIhRIzi9q5ARZ5Dz7ldT5uahLfvP3lhk+vZC04plXXKYB6oTMiypWQjlr
         EmdslRtH83pfgNXsrhGodU4YhfF1r6oEj5ruDiI3DQRaD30jtqc15VA0xM1heX7JDN2N
         thrgEM6cUGSpPdwwSIcq8QBB6WbGKELSPAUPKulkdCXqDkA1XzuApHCK0DSeTIdikgru
         GYDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717591174; x=1718195974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nLJqIWJeQNkMBFWQ7v6+RLQIvbPqzd6527VcybskqUQ=;
        b=GZuLEZ0wXBIZrzcn555dEK0DJbIb1ohEfd2nMv5H8dHrZu+oLJaQCCXJbvBnUQFwXf
         Efrqcm+UhbAB5CKTEPwhrirv4QNCX5Hlj6/J925utqfxVFiaTkzMuT8XivEl3Crh66hb
         4YfQLkp7ByQa7eoc1CtCoMKfy9ObKEGxIp03KBFUbhAgV7EepgANLHgyrmRMFSk8thPO
         /kGuUTM2U+shY6LiByHkgWWP24O/Ovq8+U2ZpMfxwQd9lmqx08A2d3IjjEW7JIywaKWv
         iv+D9JLsjpH2MwJisLfeOZweDPppYPRAsiVMHUAolpxYA9vMeZhVKFMs0UqCZna2o/QB
         uK/w==
X-Forwarded-Encrypted: i=1; AJvYcCWkLjPhTmZbmh03KJmbLX1lhg1KqNed9Xcr6/9+Z9625aCuJZEd6kksg3lidJPjlR6MTuOdX/1VkgE5k2v2pK85EBb0WupUDFwH
X-Gm-Message-State: AOJu0YwBGEmc2eyfGrHfwvLbWIg+H/xyYSNfjq0cPfN2Qh734W6rnWse
	1RxT6YHLfh1XmiNoasf10AcO5SuanGXstWdJOKKLvyHpC/VVaOZZOLbHJYrTq0k=
X-Google-Smtp-Source: AGHT+IFkU9V1vqVoPhWtT14MJgaDv5EWKjQeJi+58c7DX4CmjM2wKHZTP6VmBQXo0ZrXi3nXBSbLmw==
X-Received: by 2002:a05:600c:1c84:b0:420:173f:e1e9 with SMTP id 5b1f17b1804b1-421562dc3b6mr18874035e9.21.1717591173573;
        Wed, 05 Jun 2024 05:39:33 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:75a:e000:d3dd:423:e1eb:d88b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42158148f66sm21992535e9.32.2024.06.05.05.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 05:39:33 -0700 (PDT)
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
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH v9 2/2] power: pwrseq: add a driver for the PMU module on the QCom WCN chipsets
Date: Wed,  5 Jun 2024 14:38:50 +0200
Message-ID: <20240605123850.24857-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605123850.24857-1-brgl@bgdev.pl>
References: <20240605123850.24857-1-brgl@bgdev.pl>
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
the relevant properties and DT layout. Using this driver will allow the
BT and WLAN drivers to respect the required delays between enabling the
two modules.

Tested-by: Amit Pundir <amit.pundir@linaro.org>
Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8550-QRD, SM8650-QRD & SM8650-HDK
Tested-by: Caleb Connolly <caleb.connolly@linaro.org> # OnePlus 8T
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/power/sequencing/Kconfig           |  17 ++
 drivers/power/sequencing/Makefile          |   2 +
 drivers/power/sequencing/pwrseq-qcom-wcn.c | 336 +++++++++++++++++++++
 3 files changed, 355 insertions(+)
 create mode 100644 drivers/power/sequencing/pwrseq-qcom-wcn.c

diff --git a/drivers/power/sequencing/Kconfig b/drivers/power/sequencing/Kconfig
index ba5732b1dbf8..c9f1cdb66524 100644
--- a/drivers/power/sequencing/Kconfig
+++ b/drivers/power/sequencing/Kconfig
@@ -10,3 +10,20 @@ menuconfig POWER_SEQUENCING
 	  during power-up.
 
 	  If unsure, say no.
+
+if POWER_SEQUENCING
+
+config POWER_SEQUENCING_QCOM_WCN
+	tristate "Qualcomm WCN family PMU driver"
+	default m if ARCH_QCOM
+	help
+	  Say Y here to enable the power sequencing driver for Qualcomm
+	  WCN Bluetooth/WLAN chipsets.
+
+	  Typically, a package from the Qualcomm WCN family contains the BT
+	  and WLAN modules whose power is controlled by the PMU module. As the
+	  former two share the power-up sequence which is executed by the PMU,
+	  this driver is needed for correct power control or else we'd risk not
+	  respecting the required delays between enabling Bluetooth and WLAN.
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
index 000000000000..42dacfda745e
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
+	unsigned int pwup_delay_ms;
+	unsigned int gpio_enable_delay_ms;
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
+	unsigned long last_gpio_enable_jf;
+};
+
+static void pwrseq_qcom_wcn_ensure_gpio_delay(struct pwrseq_qcom_wcn_ctx *ctx)
+{
+	unsigned long diff_jiffies;
+	unsigned int diff_msecs;
+
+	if (!ctx->pdata->gpio_enable_delay_ms)
+		return;
+
+	diff_jiffies = jiffies - ctx->last_gpio_enable_jf;
+	diff_msecs = jiffies_to_msecs(diff_jiffies);
+
+	if (diff_msecs < ctx->pdata->gpio_enable_delay_ms)
+		msleep(ctx->pdata->gpio_enable_delay_ms - diff_msecs);
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
+	ctx->last_gpio_enable_jf = jiffies;
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
+	ctx->last_gpio_enable_jf = jiffies;
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
+	if (ctx->pdata->pwup_delay_ms)
+		msleep(ctx->pdata->pwup_delay_ms);
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
+	.pwup_delay_ms = 60,
+	.gpio_enable_delay_ms = 100,
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
+	.pwup_delay_ms = 50,
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
+		return dev_err_probe(dev, ret,
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


