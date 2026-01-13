Return-Path: <linux-pci+bounces-44619-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D50FBD19E2B
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 16:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 327AA3015132
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 15:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38E338FF19;
	Tue, 13 Jan 2026 15:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="db+k16Oo"
X-Original-To: linux-pci@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A47363C64;
	Tue, 13 Jan 2026 15:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768318003; cv=none; b=HzDEbY470njQ7kCdCvzMg+C08MXX+fajqBRa1krjeAeYzV5SDcDaxMFNR+KDO/oxcSCKn1pGp6WAM0uH4NPM0v2s1Y4nILwUgKJS9yWcTCvIhamh2oqu5eWDUOZyOssQ2nyzCBBevER1utTsQUQg0F0VZ4dYO07b23MkyUKOdII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768318003; c=relaxed/simple;
	bh=DAFK6ts6h5oycafq6Gc/0yiCRES3UGi7RyPEY9i83m8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=He+C3dIVxlvP9xoy3vJQ0ebd/6Ln9fog7qgaYuiiNDFQCeJWdwVX1e7ZNoJEggxLea/VzLz3zWPLaJ2cB5sIXrisdFmUJmwzKBSWB4ShJHRVerPwYGQ47KKqRsVV0+0sIRpzRMGfurwZofM3GvR0ocuW7AB+LEewWtUFUTC61Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=db+k16Oo; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2432dafc-4101-4b23-90b2-85ea5459435c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768317998;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jG0Bu8LbTPoVOj6e4IGMmcUh/bkY4GBbkm/sd8XSO1E=;
	b=db+k16OoHiSaywpFQWYsVmgGEuM+ade9mP+cAI3oNm49lUFhfW8ZAwQYAAdsHmNiUM4xX7
	LAXOUmYB0Q1pqZoIFEa7rz8MdmEJirefRM6mdtDUamHSieJarY/koc8SzZm7hp/nmUla0i
	ZKjpJui8Rd9xNxafuH+9252J3qgP5O8=
Date: Tue, 13 Jan 2026 10:26:04 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 8/9] power: sequencing: pcie-m2: Add support for PCIe
 M.2 Key E connectors
To: manivannan.sadhasivam@oss.qualcomm.com, Rob Herring <robh@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nicolas Schier <nicolas.schier@linux.dev>, Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Mark Pearson <mpearson-lenovo@squebb.ca>,
 "Derek J. Clark" <derekjohn.clark@gmail.com>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Bartosz Golaszewski <brgl@bgdev.pl>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kbuild@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
 linux-pm@vger.kernel.org, Stephan Gerhold <stephan.gerhold@linaro.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 linux-acpi@vger.kernel.org
References: <20260112-pci-m2-e-v4-0-eff84d2c6d26@oss.qualcomm.com>
 <20260112-pci-m2-e-v4-8-eff84d2c6d26@oss.qualcomm.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20260112-pci-m2-e-v4-8-eff84d2c6d26@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/12/26 11:26, Manivannan Sadhasivam via B4 Relay wrote:
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

Section 3.1.4 of the M.2 spec says that "Power Valid to PERST# input
inactive" (T_PVPGL) is "Implementation specific recommended 50 ms." So I
think we should delay for at least 50 ms for all M.2 cards.
Additionally, the PCIe CEM specifies that "Power stable to PERST#
inactive" (T_PVPERL) must be at least 100 ms. So I think we should just
delay for 100 ms regardless of the slot, perhaps making this
configurable in the devicetree if e.g. the system integrator knows the
soldered-down M.2 requires less initialization time. This is exactly
what I proposed in [1].

--Sean

[1] https://lore.kernel.org/linux-pci/20251219172222.2808195-2-sean.anderson@linux.dev/

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

