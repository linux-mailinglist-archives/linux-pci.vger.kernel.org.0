Return-Path: <linux-pci+bounces-3654-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58AAB858A06
	for <lists+linux-pci@lfdr.de>; Sat, 17 Feb 2024 00:17:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C85E1C20DBA
	for <lists+linux-pci@lfdr.de>; Fri, 16 Feb 2024 23:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966891487E7;
	Fri, 16 Feb 2024 23:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qr/90Hzj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1AD1487D5
	for <linux-pci@vger.kernel.org>; Fri, 16 Feb 2024 23:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708125452; cv=none; b=qD3XTMRpjX4B9vpLDObtkowLYH8ko5Vj2RvoEpHutfB2Rre3+WHHDH+xcVswtsIIkV5RzN1pbA+j0q5ljsFr+ikYQLoLYa+ZfRn7zL6S38uZvBRgtPJLd8w63FpOD39aBj35r0aM/qbpzjCozc7t4cnfqZkojz25ssTwStop0rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708125452; c=relaxed/simple;
	bh=D9QCOncfBO+QDwhfpsna1yYGN0SAPzAPnCRxq2L50Vs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jm1PLV5WR8dKTy6IN9HlRvAfgv6kT8xb1Ri83nSY4Qhm5zqLP3wr/z/vUocvltQmxdRoTg0nU+i77Vl6YwwyAcpfy/L+wFuaG7HRAA7Jk1jL7YnbpqXeHm91+WDRhlvruLipB/QPUZKLmwrccSMp4dH9M1Ym3mQzd89Q8j17CZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qr/90Hzj; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dc742543119so1410344276.0
        for <linux-pci@vger.kernel.org>; Fri, 16 Feb 2024 15:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708125449; x=1708730249; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mQJK1I7XuB/9ZoSCV7ftUSrSgKzCTMkjrY12cIHhT/4=;
        b=qr/90Hzj96aXHo+9h1/s2lsiZe5GpkBt4TZLEGK7MgRClGuTYicRBaaSa1PFe7qjYj
         zUXBMrw3PP9NPPqEuCohno5dssoBhxXnJ3G00qZpqHZFbt+u4ScMm7rNFnyJcVNLN2i9
         fp1xAr+4h0yfhBG/rbAtzUs787AR6LpC6Ouv6Akl5R+2OaIbbTbRNLCjZlSSXybFlviQ
         qbfQVFRiZ7S7PygP0m8o+Oip9WyM6BYxAyWT3837QH+NAK48g/9CQKK1UgEOautEv3wm
         +tG4BcHtV2pQ4WmMwspWRxwCytb9AbxKkmqlh8bkd5YV9Vji+spEkb0OQ/95vCw11HND
         LOxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708125449; x=1708730249;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mQJK1I7XuB/9ZoSCV7ftUSrSgKzCTMkjrY12cIHhT/4=;
        b=R15Xx9obPBXQh0ft5QMa2iaknIliVDFUholeL20Qsa9kBMmEo7O1wP669Eh/UBtcGc
         X6MG/I90SGAA+XUr3285Lxmyg8ZS0qvqOrxLLC2xGxu0dZSDiS4vB7ijy9NDWEyf4pBv
         r819hwgJoQx1OuHdDtIxfAyA+FRkdbA0z2JVW9alaoie01OiDlqKnb7VD1z7v1GJOSYj
         Nd+G8U0BlM0IPW7eUu2MDbV9cFTEvkWKRLf93sfm8bTlA3yqelB+zOoATZtISc/EY11X
         EohMGiTDucuqEyZYLZKweOlpfMhQ1YMk+m91IGCN/ydpBwPh/EQ3JIkL3TUdCer9femV
         b9eg==
X-Forwarded-Encrypted: i=1; AJvYcCXi7NYj4ONwnwg6OxSHy/24ZYKxUBLrGixUMSjs6HDbFWp7mdgAkU6d+1Dc6YDpvz3xN+i8WdwrJ+Vn9bUYTUJXEa/cPq3TDpcw
X-Gm-Message-State: AOJu0YxRDWCidWON0aBRq5Rcfful/4k1NZdz8uZNLiCS+mkEZVuyfZ65
	sGmSp7N2zY/tuJIenVAJH2DCpNNoYVk2OKda8+zmN56y2NAN3847x2lKCL9I9uIlMKLjsuX+mwH
	2r+pJwCwBkO9dPmuBLT3WI+wYdnUHGVBl63Bw0g==
X-Google-Smtp-Source: AGHT+IGY1HpdOQgLyTXe1oXFmR8TCIAfORjghx01Zhdg2V5HydNh4Ln1oFBM+mldq0g4wVV8ZQne81kOndbIqhzAK1U=
X-Received: by 2002:a81:91d5:0:b0:607:8475:23 with SMTP id i204-20020a8191d5000000b0060784750023mr6108723ywg.20.1708125449117;
 Fri, 16 Feb 2024 15:17:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240216203215.40870-1-brgl@bgdev.pl> <20240216203215.40870-17-brgl@bgdev.pl>
In-Reply-To: <20240216203215.40870-17-brgl@bgdev.pl>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 17 Feb 2024 01:17:17 +0200
Message-ID: <CAA8EJpo=LFcw8PbFRvGwd9nS5ECazOHiBMWRsqfEpY-v0iQLLA@mail.gmail.com>
Subject: Re: [PATCH v5 16/18] power: pwrseq: add a driver for the QCA6390 PMU module
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kalle Valo <kvalo@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Saravana Kannan <saravanak@google.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Arnd Bergmann <arnd@arndb.de>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Alex Elder <elder@linaro.org>, 
	Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Abel Vesa <abel.vesa@linaro.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Lukas Wunner <lukas@wunner.de>, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 16 Feb 2024 at 22:33, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> This adds the power sequencing driver for the QCA6390's PMU module. It
> uses the pwrseq subsystem and knows how to match the sequencer to the
> consumer device by verifying the relevant properties and DT layout.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/power/sequencing/Kconfig          |  16 +
>  drivers/power/sequencing/Makefile         |   2 +
>  drivers/power/sequencing/pwrseq-qca6390.c | 353 ++++++++++++++++++++++
>  3 files changed, 371 insertions(+)
>  create mode 100644 drivers/power/sequencing/pwrseq-qca6390.c
>
> diff --git a/drivers/power/sequencing/Kconfig b/drivers/power/sequencing/Kconfig
> index ba5732b1dbf8..84ddf3b4ae56 100644
> --- a/drivers/power/sequencing/Kconfig
> +++ b/drivers/power/sequencing/Kconfig
> @@ -10,3 +10,19 @@ menuconfig POWER_SEQUENCING
>           during power-up.
>
>           If unsure, say no.
> +
> +if POWER_SEQUENCING
> +
> +config POWER_SEQUENCING_QCA6390
> +       tristate "QCA6390 PMU driver"
> +       default m if ARCH_QCOM
> +       help
> +         Say U here to enable the power sequencing driver for Qualcomm
> +         QCA6390.
> +
> +         The QCA6390 package contains the BT and WLAN modules whose power
> +         is controlled by the PMU module. As the former two share the power-up
> +         sequence which is executed by the PMU, this driver is needed for
> +         correct power control.
> +
> +endif
> diff --git a/drivers/power/sequencing/Makefile b/drivers/power/sequencing/Makefile
> index dcdf8c0c159e..628345c4e7ae 100644
> --- a/drivers/power/sequencing/Makefile
> +++ b/drivers/power/sequencing/Makefile
> @@ -2,3 +2,5 @@
>
>  obj-$(CONFIG_POWER_SEQUENCING)         += pwrseq-core.o
>  pwrseq-core-y                          := core.o
> +
> +obj-$(CONFIG_POWER_SEQUENCING_QCA6390) += pwrseq-qca6390.o
> diff --git a/drivers/power/sequencing/pwrseq-qca6390.c b/drivers/power/sequencing/pwrseq-qca6390.c
> new file mode 100644
> index 000000000000..5f254f9c71d7
> --- /dev/null
> +++ b/drivers/power/sequencing/pwrseq-qca6390.c
> @@ -0,0 +1,353 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2024 Linaro Ltd.
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/jiffies.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/pwrseq/provider.h>
> +#include <linux/string.h>
> +#include <linux/types.h>
> +
> +struct pwrseq_qca6390_vreg {
> +       const char *name;
> +       unsigned int load_uA;
> +};
> +
> +struct pwrseq_qca6390_pdata {
> +       const struct pwrseq_qca6390_vreg *vregs_common;
> +       size_t num_vregs_common;
> +       const struct pwrseq_qca6390_vreg *vregs_wlan;
> +       size_t num_vregs_wlan;
> +       unsigned int pwup_delay_msec;
> +};
> +
> +struct pwrseq_qca6390_ctx {
> +       struct pwrseq_device *pwrseq;
> +       struct device_node *of_node;
> +       const struct pwrseq_qca6390_pdata *pdata;
> +       struct regulator_bulk_data *regs_common;
> +       struct regulator_bulk_data *regs_wlan;
> +       struct gpio_desc *bt_gpio;
> +       struct gpio_desc *wlan_gpio;
> +       unsigned long last_gpio_enable;
> +};
> +
> +static const struct pwrseq_qca6390_vreg pwrseq_qca6390_vregs_common[] = {
> +       {
> +               .name = "vddio",
> +               .load_uA = 20000,
> +       },
> +       {
> +               .name = "vddaon",
> +               .load_uA = 100000,
> +       },
> +       {
> +               .name = "vddpmu",
> +               .load_uA = 1250000,
> +       },
> +       {
> +               .name = "vddrfa0p95",
> +               .load_uA = 200000,
> +       },
> +       {
> +               .name = "vddrfa1p3",
> +               .load_uA = 400000,
> +       },
> +       {
> +               .name = "vddrfa1p9",
> +               .load_uA = 400000,
> +       },
> +};
> +
> +static const struct pwrseq_qca6390_vreg pwrseq_qca6390_vregs_wlan[] = {
> +       {
> +               .name = "vddpcie1p3",
> +               .load_uA = 35000,
> +       },
> +       {
> +               .name = "vddpcie1p9",
> +               .load_uA = 15000,
> +       },
> +};

I thought that we had discussed this already. According to the docs,
all PMU supplies should be powered on when the chip is being switched
on, no matter whether it is for the WiFi or for the BT.

> +
> +static void pwrseq_qca6390_ensure_gpio_delay(struct pwrseq_qca6390_ctx *ctx)
> +{
> +       unsigned long diff_jiffies = jiffies - ctx->last_gpio_enable;
> +       unsigned int diff_msecs = jiffies_to_msecs(diff_jiffies);
> +
> +       if (diff_msecs < 100)
> +               msleep(100 - diff_msecs);
> +}
> +
> +static const struct pwrseq_qca6390_pdata pwrseq_qca6390_of_data = {
> +       .vregs_common = pwrseq_qca6390_vregs_common,
> +       .num_vregs_common = ARRAY_SIZE(pwrseq_qca6390_vregs_common),
> +       .vregs_wlan = pwrseq_qca6390_vregs_wlan,
> +       .num_vregs_wlan = ARRAY_SIZE(pwrseq_qca6390_vregs_wlan),
> +       .pwup_delay_msec = 16,
> +};
> +
> +static int pwrseq_qca6390_vregs_enable(struct pwrseq_device *pwrseq)
> +{
> +       struct pwrseq_qca6390_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
> +
> +       return regulator_bulk_enable(ctx->pdata->num_vregs_common,
> +                                    ctx->regs_common);
> +}
> +
> +static int pwrseq_qca6390_vregs_disable(struct pwrseq_device *pwrseq)
> +{
> +       struct pwrseq_qca6390_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
> +
> +       return regulator_bulk_disable(ctx->pdata->num_vregs_common,
> +                                     ctx->regs_common);
> +}
> +
> +static const struct pwrseq_unit_data pwrseq_qca6390_vregs_unit_data = {
> +       .name = "regulators-enable",
> +       .enable = pwrseq_qca6390_vregs_enable,
> +       .disable = pwrseq_qca6390_vregs_disable,
> +};
> +
> +static const struct pwrseq_unit_data *pwrseq_qca6390_unit_deps[] = {
> +       &pwrseq_qca6390_vregs_unit_data,
> +       NULL
> +};
> +
> +static int pwrseq_qca6390_bt_enable(struct pwrseq_device *pwrseq)
> +{
> +       struct pwrseq_qca6390_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
> +
> +       pwrseq_qca6390_ensure_gpio_delay(ctx);
> +       gpiod_set_value_cansleep(ctx->bt_gpio, 1);
> +       ctx->last_gpio_enable = jiffies;
> +
> +       return 0;
> +}
> +
> +static int pwrseq_qca6390_bt_disable(struct pwrseq_device *pwrseq)
> +{
> +       struct pwrseq_qca6390_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
> +
> +       gpiod_set_value_cansleep(ctx->bt_gpio, 0);
> +
> +       return 0;
> +}
> +
> +static const struct pwrseq_unit_data pwrseq_qca6390_bt_unit_data = {
> +       .name = "bluetooth-enable",
> +       .deps = pwrseq_qca6390_unit_deps,

Can we call corresponding regulator_bulk functions from bt and wlan
enable/disable? This will save us from building the tree-like
structures (and possible loops inside that tree).

> +       .enable = pwrseq_qca6390_bt_enable,
> +       .disable = pwrseq_qca6390_bt_disable,
> +};
> +
> +static int pwrseq_qca6390_wlan_enable(struct pwrseq_device *pwrseq)
> +{
> +       struct pwrseq_qca6390_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
> +       int ret;
> +
> +       ret = regulator_bulk_enable(ctx->pdata->num_vregs_wlan, ctx->regs_wlan);
> +       if (ret)
> +               return ret;
> +
> +       pwrseq_qca6390_ensure_gpio_delay(ctx);
> +       gpiod_set_value_cansleep(ctx->wlan_gpio, 1);
> +       ctx->last_gpio_enable = jiffies;
> +
> +       return 0;
> +}
> +
> +static int pwrseq_qca6390_wlan_disable(struct pwrseq_device *pwrseq)
> +{
> +       struct pwrseq_qca6390_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
> +
> +       gpiod_set_value_cansleep(ctx->wlan_gpio, 0);
> +
> +       return regulator_bulk_disable(ctx->pdata->num_vregs_wlan,
> +                                     ctx->regs_wlan);
> +}
> +
> +static const struct pwrseq_unit_data pwrseq_qca6390_wlan_unit_data = {
> +       .name = "wlan-enable",
> +       .deps = pwrseq_qca6390_unit_deps,
> +       .enable = pwrseq_qca6390_wlan_enable,
> +       .disable = pwrseq_qca6390_wlan_disable,
> +};
> +
> +static int pwrseq_qca6390_pwup_delay(struct pwrseq_device *pwrseq)
> +{
> +       struct pwrseq_qca6390_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
> +
> +       if (ctx->pdata->pwup_delay_msec)
> +               msleep(ctx->pdata->pwup_delay_msec);
> +
> +       return 0;
> +}
> +
> +static const struct pwrseq_target_data pwrseq_qca6390_bt_target_data = {
> +       .name = "bluetooth",
> +       .unit = &pwrseq_qca6390_bt_unit_data,
> +       .post_enable = pwrseq_qca6390_pwup_delay,
> +};
> +
> +static const struct pwrseq_target_data pwrseq_qca6390_wlan_target_data = {
> +       .name = "wlan",
> +       .unit = &pwrseq_qca6390_wlan_unit_data,
> +       .post_enable = pwrseq_qca6390_pwup_delay,
> +};
> +
> +static const struct pwrseq_target_data *pwrseq_qca6390_targets[] = {
> +       &pwrseq_qca6390_bt_target_data,
> +       &pwrseq_qca6390_wlan_target_data,
> +       NULL
> +};
> +
> +static int pwrseq_qca6390_match(struct pwrseq_device *pwrseq,
> +                               struct device *dev)
> +{
> +       struct pwrseq_qca6390_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
> +       struct device_node *dev_node = dev->of_node;
> +
> +       /*
> +        * The PMU supplies power to the Bluetooth and WLAN modules. both
> +        * consume the PMU AON output so check the presence of the
> +        * 'vddaon-supply' property and whether it leads us to the right
> +        * device.
> +        */
> +       if (!of_property_present(dev_node, "vddaon-supply"))
> +               return 0;
> +
> +       struct device_node *reg_node __free(device_node) =
> +                       of_parse_phandle(dev_node, "vddaon-supply", 0);
> +       if (!reg_node)
> +               return 0;
> +
> +       /*
> +        * `reg_node` is the PMU AON regulator, its parent is the `regulators`
> +        * node and finally its grandparent is the PMU device node that we're
> +        * looking for.
> +        */
> +       if (!reg_node->parent || !reg_node->parent->parent ||
> +           reg_node->parent->parent != ctx->of_node)
> +               return 0;
> +
> +       return 1;
> +}
> +
> +static struct regulator_bulk_data *
> +pwrseq_qca6390_get_regs(struct device *dev, size_t num_regs,
> +                       const struct pwrseq_qca6390_vreg *pdata)
> +{
> +       struct regulator_bulk_data *regs;
> +       int ret, i;
> +
> +       regs = devm_kcalloc(dev, num_regs, sizeof(*regs), GFP_KERNEL);
> +       if (!regs)
> +               return ERR_PTR(-ENOMEM);
> +
> +       for (i = 0; i < num_regs; i++)
> +               regs[i].supply = pdata[i].name;
> +
> +       ret = devm_regulator_bulk_get(dev, num_regs, regs);
> +       if (ret < 0)
> +               return ERR_PTR(ret);
> +
> +       for (i = 0; i < num_regs; i++) {
> +               if (!pdata[i].load_uA)
> +                       continue;
> +
> +               ret = regulator_set_load(regs[i].consumer, pdata[i].load_uA);
> +               if (ret)
> +                       return ERR_PTR(ret);
> +       }
> +
> +       return regs;
> +}
> +
> +static int pwrseq_qca6390_probe(struct platform_device *pdev)
> +{
> +       struct device *dev = &pdev->dev;
> +       struct pwrseq_qca6390_ctx *ctx;
> +       struct pwrseq_config config;
> +
> +       ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
> +       if (!ctx)
> +               return -ENOMEM;
> +
> +       ctx->of_node = dev->of_node;
> +
> +       ctx->pdata = of_device_get_match_data(dev);
> +       if (!ctx->pdata)
> +               return dev_err_probe(dev, -ENODEV,
> +                                    "Failed to obtain platform data\n");
> +
> +       ctx->regs_common = pwrseq_qca6390_get_regs(dev,
> +                                                  ctx->pdata->num_vregs_common,
> +                                                  ctx->pdata->vregs_common);
> +       if (IS_ERR(ctx->regs_common))
> +               return dev_err_probe(dev, PTR_ERR(ctx->regs_common),
> +                                    "Failed to get all regulators\n");
> +
> +       ctx->regs_wlan = pwrseq_qca6390_get_regs(dev,
> +                                                ctx->pdata->num_vregs_wlan,
> +                                                ctx->pdata->vregs_wlan);
> +       if (IS_ERR(ctx->regs_wlan))
> +               return dev_err_probe(dev, PTR_ERR(ctx->regs_wlan),
> +                                    "Failed to get all regulators\n");
> +
> +       ctx->bt_gpio = devm_gpiod_get_optional(dev, "bt-enable", GPIOD_OUT_LOW);
> +       if (IS_ERR(ctx->bt_gpio))
> +               return dev_err_probe(dev, PTR_ERR(ctx->bt_gpio),
> +                                    "Failed to get the Bluetooth enable GPIO\n");
> +
> +       ctx->wlan_gpio = devm_gpiod_get_optional(dev, "wlan-enable",
> +                                                GPIOD_OUT_LOW);
> +       if (IS_ERR(ctx->wlan_gpio))
> +               return dev_err_probe(dev, PTR_ERR(ctx->wlan_gpio),
> +                                    "Failed to get the WLAN enable GPIO\n");
> +
> +       memset(&config, 0, sizeof(config));
> +
> +       config.parent = dev;
> +       config.owner = THIS_MODULE;
> +       config.drvdata = ctx;
> +       config.match = pwrseq_qca6390_match;
> +       config.targets = pwrseq_qca6390_targets;
> +
> +       ctx->pwrseq = devm_pwrseq_device_register(dev, &config);
> +       if (IS_ERR(ctx->pwrseq))
> +               return dev_err_probe(dev, PTR_ERR(ctx->pwrseq),
> +                                    "Failed to register the power sequencer\n");
> +
> +       return 0;
> +}
> +
> +static const struct of_device_id pwrseq_qca6390_of_match[] = {
> +       {
> +               .compatible = "qcom,qca6390-pmu",
> +               .data = &pwrseq_qca6390_of_data,
> +       },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(of, pwrseq_qca6390_of_match);
> +
> +static struct platform_driver pwrseq_qca6390_driver = {
> +       .driver = {
> +               .name = "pwrseq-qca6390",
> +               .of_match_table = pwrseq_qca6390_of_match,
> +       },
> +       .probe = pwrseq_qca6390_probe,
> +};
> +module_platform_driver(pwrseq_qca6390_driver);
> +
> +MODULE_AUTHOR("Bartosz Golaszewski <bartosz.golaszewski@linaro.org>");
> +MODULE_DESCRIPTION("QCA6390 PMU power sequencing driver");
> +MODULE_LICENSE("GPL");
> --
> 2.40.1
>


-- 
With best wishes
Dmitry

