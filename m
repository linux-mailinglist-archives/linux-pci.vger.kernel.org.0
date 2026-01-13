Return-Path: <linux-pci+bounces-44609-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1717AD19416
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 15:02:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7ECA03035CCD
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 14:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98829392B63;
	Tue, 13 Jan 2026 14:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nUqO98mK"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C4A392831
	for <linux-pci@vger.kernel.org>; Tue, 13 Jan 2026 14:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768312839; cv=none; b=spZTJCoMe6tgyiOS74J8wjyyC5yferRHgevIPYz8EfB6VsTiI/Kgopa4BqGhYlE1zQn/oBX1H0YlRh0n7YoXhm1ibGKfnX4nxnWwckGEOqB6bbehV2ihow2+VdARLkoWIrmTTdFYlPFTGYFV0V3uCeC6DrfwvibJk8+5noSM12g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768312839; c=relaxed/simple;
	bh=X8mXhJTgAGq9IOf4F3jJlDw/W05b42TP8HpZ/2Vdrwg=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HA0iekQduAk2Er+HSKR1jev6rmcJReGE/NMR3J/UgNjPh/0/HbMnkgbGMlkyCiSpc9xcf9Fg5KFxX1L2cmrug5ORqEkzt5ST3H+NFMpwZWCEv5JXVttHfa3BHe5s/ifKZCD59r8L9H7L8BSz/yguObTjPxGBWmtDUZm7omQNEbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nUqO98mK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 228B7C2BC86
	for <linux-pci@vger.kernel.org>; Tue, 13 Jan 2026 14:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768312839;
	bh=X8mXhJTgAGq9IOf4F3jJlDw/W05b42TP8HpZ/2Vdrwg=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:From;
	b=nUqO98mKJE7NXi7FLSuiAtTZXAqYxZ1nyDsJZzG7jWaaPs2Hy4EO/Y3i3mieoa7p+
	 KN5m6yAgwsjf/88I+ElOWZElAVlfvtWoVohX2rXGsdq/xejw4/8YWFTQTmEZryzsIg
	 HbmCLngM24fUzxvLJgyXm57Ppwr8+TwuUdAGb0qAJuUPHPTK2AFvVD3EgoNiymJlmZ
	 uB4GfrHwgPeUzSGYayJrFSLyGPIEpbuq9qfoA7yx5tW7hlErFUditSkIqSEh/jFwty
	 SAhH/SQ4wMYQluc0fAkdfY9HSpZG/mWKRaCfeJish4i12UcX24vqxEq16jRrkuOdeQ
	 74ndcQTjSb1hg==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-59b6df3d6b4so7695865e87.0
        for <linux-pci@vger.kernel.org>; Tue, 13 Jan 2026 06:00:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWEFSLIFYRRcP9EqgUp1x8yAiym5rg/1U1UPn0GvF9ds9ldKlyZMn/RCPzrreUm3MnXpUCDGaKLBjI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1ADK2ZdQEpqVtBVvXkim5vGtJXDDDFFCGccSbn5VP2ZT/HW8P
	U4k2wBwwCmPd6xqM9mpPsC34DfnMzX0Juj/qzMNYZ9uqcDEkVCW9zsbbwKfxIXD6loBf2PjGLhd
	Al+TqeQVveoUNACEU/GvZU5sy1ke6g1y3yvnPGdKp3A==
X-Google-Smtp-Source: AGHT+IHkGbH56mpERCqebm4I83lw0PurcteLr7cgNC0e+0pRpGvxWPIiTZ7DW2io/Q37pf6iiDvx11af8oXDK5+wY0I=
X-Received: by 2002:a05:6512:239c:b0:59b:7c23:c639 with SMTP id
 2adb3069b0e04-59b7c23c757mr4838943e87.26.1768312837703; Tue, 13 Jan 2026
 06:00:37 -0800 (PST)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 13 Jan 2026 06:00:35 -0800
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 13 Jan 2026 06:00:35 -0800
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260112-pci-m2-e-v4-8-eff84d2c6d26@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260112-pci-m2-e-v4-0-eff84d2c6d26@oss.qualcomm.com> <20260112-pci-m2-e-v4-8-eff84d2c6d26@oss.qualcomm.com>
Date: Tue, 13 Jan 2026 06:00:35 -0800
X-Gmail-Original-Message-ID: <CAMRc=McBamKzNYvWDcGeNU1raq1a1fdK0Pu2Ub154nTtMhFc5A@mail.gmail.com>
X-Gm-Features: AZwV_QjzcyvwXxlEQgHd6qIWvQVbATOW0nBj5REO6Ph0AfkAJuuTNk3sa_W8efk
Message-ID: <CAMRc=McBamKzNYvWDcGeNU1raq1a1fdK0Pu2Ub154nTtMhFc5A@mail.gmail.com>
Subject: Re: [PATCH v4 8/9] power: sequencing: pcie-m2: Add support for PCIe
 M.2 Key E connectors
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>, 
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-pm@vger.kernel.org, Stephan Gerhold <stephan.gerhold@linaro.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, linux-acpi@vger.kernel.org, 
	Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas.schier@linux.dev>, Hans de Goede <hansg@kernel.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, "Derek J. Clark" <derekjohn.clark@gmail.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Bartosz Golaszewski <brgl@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 12 Jan 2026 17:26:07 +0100, Manivannan Sadhasivam via B4 Relay
<devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org> said:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
>
> Add support for handling the power sequence of the PCIe M.2 Key E
> connectors. These connectors are used to attach the Wireless Connectivity
> devices to the host machine including combinations of WiFi, BT, NFC using
> interfaces such as PCIe/SDIO for WiFi, USB/UART for BT and I2C for NFC.
>
> Currently, this driver supports only the PCIe interface for WiFi and UART
> interface for BT. The driver also only supports driving the 3.3v/1.8v power
> supplies and W_DISABLE{1/2}# GPIOs. The optional signals of the Key E
> connectors are not currently supported.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
>  drivers/power/sequencing/Kconfig          |   1 +
>  drivers/power/sequencing/pwrseq-pcie-m2.c | 110 ++++++++++++++++++++++++++++--
>  2 files changed, 104 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/power/sequencing/Kconfig b/drivers/power/sequencing/Kconfig
> index f5fff84566ba..29bd204319cc 100644
> --- a/drivers/power/sequencing/Kconfig
> +++ b/drivers/power/sequencing/Kconfig
> @@ -38,6 +38,7 @@ config POWER_SEQUENCING_TH1520_GPU
>  config POWER_SEQUENCING_PCIE_M2
>  	tristate "PCIe M.2 connector power sequencing driver"
>  	depends on OF || COMPILE_TEST
> +	depends on PCI

Now we can no longer compile-test it without PCI, I don't think this was the
goal? Maybe "depends on (PCI && OF) || COMPILE_TEST"?

>  	help
>  	  Say Y here to enable the power sequencing driver for PCIe M.2
>  	  connectors. This driver handles the power sequencing for the M.2
> diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/sequencing/pwrseq-pcie-m2.c
> index e01e19123415..4b85a40d7692 100644
> --- a/drivers/power/sequencing/pwrseq-pcie-m2.c
> +++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
> @@ -4,12 +4,16 @@
>   * Author: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
>   */
>
> +#include <linux/err.h>
>  #include <linux/device.h>
> +#include <linux/delay.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_graph.h>
>  #include <linux/of_platform.h>
> +#include <linux/pci.h>
>  #include <linux/platform_device.h>
>  #include <linux/pwrseq/provider.h>
>  #include <linux/regulator/consumer.h>
> @@ -25,17 +29,19 @@ struct pwrseq_pcie_m2_ctx {
>  	const struct pwrseq_pcie_m2_pdata *pdata;
>  	struct regulator_bulk_data *regs;
>  	size_t num_vregs;
> -	struct notifier_block nb;

Should this even be part of [1] at all then? It doesn't seem used now when
I looked again?

> +	struct gpio_desc *w_disable1_gpio;
> +	struct gpio_desc *w_disable2_gpio;
> +	struct device *dev;
>  };
>
> -static int pwrseq_pcie_m2_m_vregs_enable(struct pwrseq_device *pwrseq)
> +static int pwrseq_pcie_m2_vregs_enable(struct pwrseq_device *pwrseq)
>  {
>  	struct pwrseq_pcie_m2_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
>
>  	return regulator_bulk_enable(ctx->num_vregs, ctx->regs);
>  }
>
> -static int pwrseq_pcie_m2_m_vregs_disable(struct pwrseq_device *pwrseq)
> +static int pwrseq_pcie_m2_vregs_disable(struct pwrseq_device *pwrseq)
>  {
>  	struct pwrseq_pcie_m2_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
>
> @@ -44,18 +50,84 @@ static int pwrseq_pcie_m2_m_vregs_disable(struct pwrseq_device *pwrseq)
>
>  static const struct pwrseq_unit_data pwrseq_pcie_m2_vregs_unit_data = {
>  	.name = "regulators-enable",
> -	.enable = pwrseq_pcie_m2_m_vregs_enable,
> -	.disable = pwrseq_pcie_m2_m_vregs_disable,
> +	.enable = pwrseq_pcie_m2_vregs_enable,
> +	.disable = pwrseq_pcie_m2_vregs_disable,
>  };
>
> -static const struct pwrseq_unit_data *pwrseq_pcie_m2_m_unit_deps[] = {
> +static const struct pwrseq_unit_data *pwrseq_pcie_m2_unit_deps[] = {
>  	&pwrseq_pcie_m2_vregs_unit_data,
>  	NULL
>  };
>
> +static int pwrseq_pci_m2_e_uart_enable(struct pwrseq_device *pwrseq)
> +{
> +	struct pwrseq_pcie_m2_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
> +
> +	return gpiod_set_value_cansleep(ctx->w_disable2_gpio, 0);
> +}
> +
> +static int pwrseq_pci_m2_e_uart_disable(struct pwrseq_device *pwrseq)
> +{
> +	struct pwrseq_pcie_m2_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
> +
> +	return gpiod_set_value_cansleep(ctx->w_disable2_gpio, 1);
> +}
> +
> +static const struct pwrseq_unit_data pwrseq_pcie_m2_e_uart_unit_data = {
> +	.name = "uart-enable",
> +	.deps = pwrseq_pcie_m2_unit_deps,
> +	.enable = pwrseq_pci_m2_e_uart_enable,
> +	.disable = pwrseq_pci_m2_e_uart_disable,
> +};
> +
> +static int pwrseq_pci_m2_e_pcie_enable(struct pwrseq_device *pwrseq)
> +{
> +	struct pwrseq_pcie_m2_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
> +
> +	return gpiod_set_value_cansleep(ctx->w_disable1_gpio, 0);
> +}
> +
> +static int pwrseq_pci_m2_e_pcie_disable(struct pwrseq_device *pwrseq)
> +{
> +	struct pwrseq_pcie_m2_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
> +
> +	return gpiod_set_value_cansleep(ctx->w_disable1_gpio, 1);
> +}
> +
> +static const struct pwrseq_unit_data pwrseq_pcie_m2_e_pcie_unit_data = {
> +	.name = "pcie-enable",
> +	.deps = pwrseq_pcie_m2_unit_deps,
> +	.enable = pwrseq_pci_m2_e_pcie_enable,
> +	.disable = pwrseq_pci_m2_e_pcie_disable,
> +};
> +
>  static const struct pwrseq_unit_data pwrseq_pcie_m2_m_pcie_unit_data = {
>  	.name = "pcie-enable",
> -	.deps = pwrseq_pcie_m2_m_unit_deps,
> +	.deps = pwrseq_pcie_m2_unit_deps,
> +};
> +
> +static int pwrseq_pcie_m2_e_pwup_delay(struct pwrseq_device *pwrseq)
> +{
> +	/*
> +	 * FIXME: This delay is only required for some Qcom WLAN/BT cards like
> +	 * WCN7850 and not for all devices. But currently, there is no way to
> +	 * identify the device model before enumeration.
> +	 */
> +	msleep(50);
> +
> +	return 0;
> +}
> +
> +static const struct pwrseq_target_data pwrseq_pcie_m2_e_uart_target_data = {
> +	.name = "uart",
> +	.unit = &pwrseq_pcie_m2_e_uart_unit_data,
> +	.post_enable = pwrseq_pcie_m2_e_pwup_delay,
> +};
> +
> +static const struct pwrseq_target_data pwrseq_pcie_m2_e_pcie_target_data = {
> +	.name = "pcie",
> +	.unit = &pwrseq_pcie_m2_e_pcie_unit_data,
> +	.post_enable = pwrseq_pcie_m2_e_pwup_delay,
>  };
>
>  static const struct pwrseq_target_data pwrseq_pcie_m2_m_pcie_target_data = {
> @@ -63,11 +135,21 @@ static const struct pwrseq_target_data pwrseq_pcie_m2_m_pcie_target_data = {
>  	.unit = &pwrseq_pcie_m2_m_pcie_unit_data,
>  };
>
> +static const struct pwrseq_target_data *pwrseq_pcie_m2_e_targets[] = {
> +	&pwrseq_pcie_m2_e_pcie_target_data,
> +	&pwrseq_pcie_m2_e_uart_target_data,
> +	NULL
> +};
> +
>  static const struct pwrseq_target_data *pwrseq_pcie_m2_m_targets[] = {
>  	&pwrseq_pcie_m2_m_pcie_target_data,
>  	NULL
>  };
>
> +static const struct pwrseq_pcie_m2_pdata pwrseq_pcie_m2_e_of_data = {
> +	.targets = pwrseq_pcie_m2_e_targets,
> +};
> +
>  static const struct pwrseq_pcie_m2_pdata pwrseq_pcie_m2_m_of_data = {
>  	.targets = pwrseq_pcie_m2_m_targets,
>  };
> @@ -126,6 +208,16 @@ static int pwrseq_pcie_m2_probe(struct platform_device *pdev)
>  		return dev_err_probe(dev, ret,
>  				     "Failed to get all regulators\n");
>
> +	ctx->w_disable1_gpio = devm_gpiod_get_optional(dev, "w-disable1", GPIOD_OUT_HIGH);
> +	if (IS_ERR(ctx->w_disable1_gpio))
> +		return dev_err_probe(dev, PTR_ERR(ctx->w_disable1_gpio),
> +				     "Failed to get the W_DISABLE_1# GPIO\n");
> +
> +	ctx->w_disable2_gpio = devm_gpiod_get_optional(dev, "w-disable2", GPIOD_OUT_HIGH);
> +	if (IS_ERR(ctx->w_disable2_gpio))
> +		return dev_err_probe(dev, PTR_ERR(ctx->w_disable2_gpio),
> +				     "Failed to get the W_DISABLE_2# GPIO\n");
> +
>  	ctx->num_vregs = ret;
>
>  	ret = devm_add_action_or_reset(dev, pwrseq_pcie_free_resources, ctx);
> @@ -151,6 +243,10 @@ static const struct of_device_id pwrseq_pcie_m2_of_match[] = {
>  		.compatible = "pcie-m2-m-connector",
>  		.data = &pwrseq_pcie_m2_m_of_data,
>  	},
> +	{
> +		.compatible = "pcie-m2-e-connector",
> +		.data = &pwrseq_pcie_m2_e_of_data,
> +	},
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, pwrseq_pcie_m2_of_match);
>
> --
> 2.48.1
>
>
>

Otherwise LGTM.

Bart

[1] https://lore.kernel.org/all/20260107-pci-m2-v5-5-8173d8a72641@oss.qualcomm.com/

