Return-Path: <linux-pci+bounces-2975-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DAD3846724
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 05:54:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B76A328FFA5
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 04:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B49F9C6;
	Fri,  2 Feb 2024 04:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sfZckKXs"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3D1F50D;
	Fri,  2 Feb 2024 04:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706849669; cv=none; b=qYBW+DL38Ga+oOFqRnDGj+6PK4a5apTE7SdYETCrPBtYNlx3AiB0mtrCmFMwaHP9nRPSjA+DnLKOdY+m+eP42PwZEQeyyY7mXTzZp8xfNfbOPhM6+sElwt3yeI1giLopKt5PpbfsfaRpcMKeijCzqWvEwsxaRMxZNyKyabC82AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706849669; c=relaxed/simple;
	bh=P45zUVKxLg0GSRAnp51QUGRathjmDQ8/gBq5BPY2h30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cf/v+7U1fS6hMJd+2IOPQI1olBLLFunOKiMkONPracNRonZ7o5wZ5OvpujuaUYWH6JDr/+8bO1Rsrxu6Vm3bQwk+6kAb9BgbkwBXANdFS4dFyy8PF1rEti1XU+Xf7hoON4dsBl/tGEdg8v6uHEhNDaPRWYXoJ0TmuWY7kQTvfHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sfZckKXs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 973B9C433F1;
	Fri,  2 Feb 2024 04:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706849669;
	bh=P45zUVKxLg0GSRAnp51QUGRathjmDQ8/gBq5BPY2h30=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sfZckKXscAq5mFX9knlISzDoHtWKyeI/fCPzumtqoUod5qmScWjfEFVmIHjbefVYw
	 J5crSez6FZwpAav12eKufVKVnrgVN1hnGtKQk7Nvq5XUZWKHAS7jP/Y4semINTRKxQ
	 qiotrsEoX0klAnsDuT8bVNcIUkvLuRGH5GtmjDKei5sw8SZtqkq/MGLxcmumx7bi8C
	 fy5g8fBfbE3j3K+FsNaOkhWRb0ZGaLmbLCLwnyhXncdyYF0SQQ/7QuCTorix4au7Rf
	 kKtJcf0oyetln1vmsxnXOJSYToIZwsFuog2u8RoH82f8y1SGDbl/uh/UWbO4t48EQl
	 Y1n36sdkt5uEQ==
Date: Thu, 1 Feb 2024 22:54:25 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Alex Elder <elder@linaro.org>, 
	Srini Kandagatla <srinivas.kandagatla@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Arnd Bergmann <arnd@arndb.de>, Abel Vesa <abel.vesa@linaro.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Lukas Wunner <lukas@wunner.de>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-pci@vger.kernel.org, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [RFC 4/9] power: pwrseq: add a driver for the QCA6390 PMU module
Message-ID: <ys45p7mdiur4liwzlexqm3aji7iz5panpb73ixg34wcio2qbvz@wkjcyazbzb4p>
References: <20240201155532.49707-1-brgl@bgdev.pl>
 <20240201155532.49707-5-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201155532.49707-5-brgl@bgdev.pl>

On Thu, Feb 01, 2024 at 04:55:27PM +0100, Bartosz Golaszewski wrote:
> diff --git a/drivers/power/sequencing/pwrseq-qca6390.c b/drivers/power/sequencing/pwrseq-qca6390.c
[..]
> +static int pwrseq_qca6390_power_on(struct pwrseq_device *pwrseq)
> +{
> +	struct pwrseq_qca6390_ctx *ctx = pwrseq_device_get_data(pwrseq);
> +	int ret;
> +
> +	ret = regulator_bulk_enable(ctx->pdata->num_vregs, ctx->regs);
> +	if (ret)
> +		return ret;
> +
> +	gpiod_set_value_cansleep(ctx->bt_gpio, 1);
> +	gpiod_set_value_cansleep(ctx->wlan_gpio, 1);

So it's no longer possible to power these independently?

> +
> +	if (ctx->pdata->pwup_delay_msec)
> +		msleep(ctx->pdata->pwup_delay_msec);
> +
> +	return 0;
> +}
> +
> +static int pwrseq_qca6390_power_off(struct pwrseq_device *pwrseq)
> +{
> +	struct pwrseq_qca6390_ctx *ctx = pwrseq_device_get_data(pwrseq);
> +
> +	gpiod_set_value_cansleep(ctx->bt_gpio, 0);
> +	gpiod_set_value_cansleep(ctx->wlan_gpio, 0);
> +

The answer that was provided recently was that the WiFi and BT modules
absolutely must be modelled together, because there must be a 100ms
delay between bt_gpio going low and wlan_gpio going high.

If you're not going to address that concern, then I fail to see the
reason for adding the power sequence framework - just let the BT and
PCI power control (WiFi) do their thing independently.

> +	return regulator_bulk_disable(ctx->pdata->num_vregs, ctx->regs);
> +}
> +
> +static int pwrseq_qca6390_match(struct pwrseq_device *pwrseq,
> +				struct device *dev)
> +{
> +	struct pwrseq_qca6390_ctx *ctx = pwrseq_device_get_data(pwrseq);
> +	struct device_node *dev_node = dev->of_node;
> +
> +	/*
> +	 * The PMU supplies power to the Bluetooth and WLAN modules. both
> +	 * consume the PMU AON output so check the presence of the
> +	 * 'vddaon-supply' property and whether it leads us to the right
> +	 * device.
> +	 */
> +	if (!of_property_present(dev_node, "vddaon-supply"))
> +		return 0;
> +
> +	struct device_node *reg_node __free(of_node) =
> +			of_parse_phandle(dev_node, "vddaon-supply", 0);
> +	if (!reg_node)
> +		return 0;
> +
> +	/*
> +	 * `reg_node` is the PMU AON regulator, its parent is the `regulators`
> +	 * node and finally its grandparent is the PMU device node that we're
> +	 * looking for.
> +	 */
> +	if (!reg_node->parent || !reg_node->parent->parent ||
> +	    reg_node->parent->parent != ctx->of_node)
> +		return 0;

Your DeviceTree example gives a sense that a set of supplies feeds the
PMU, which then supplies power to the BT and WiFi nodes through some
entity that can switch power on and off, and adjust the voltage level.

Then comes this function, which indicates that the DeviceTree model was
just for show.

> +
> +	return 1;
> +}
> +
> +static int pwrseq_qca6390_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct pwrseq_qca6390_ctx *ctx;
> +	struct pwrseq_config config;
> +	int ret, i;
> +
> +	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
> +	if (!ctx)
> +		return -ENOMEM;
> +
> +	ctx->of_node = dev->of_node;
> +
> +	ctx->pdata = of_device_get_match_data(dev);
> +	if (!ctx->pdata)
> +		return dev_err_probe(dev, -ENODEV,
> +				     "Failed to obtain platform data\n");
> +
> +	if (ctx->pdata->vregs) {
> +		ctx->regs = devm_kcalloc(dev, ctx->pdata->num_vregs,
> +					 sizeof(*ctx->regs), GFP_KERNEL);
> +		if (!ctx->regs)
> +			return -ENOMEM;
> +
> +		for (i = 0; i < ctx->pdata->num_vregs; i++)
> +			ctx->regs[i].supply = ctx->pdata->vregs[i].name;
> +
> +		ret = devm_regulator_bulk_get(dev, ctx->pdata->num_vregs,
> +					      ctx->regs);
> +		if (ret < 0)
> +			return dev_err_probe(dev, ret,
> +					     "Failed to get all regulators\n");
> +
> +		for (i = 0; i < ctx->pdata->num_vregs; i++) {
> +			if (!ctx->pdata->vregs[1].load_uA)
> +				continue;
> +
> +			ret = regulator_set_load(ctx->regs[i].consumer,
> +						 ctx->pdata->vregs[i].load_uA);
> +			if (ret)
> +				return dev_err_probe(dev, ret,
> +						     "Failed to set vreg load\n");
> +		}
> +	}
> +
> +	ctx->bt_gpio = devm_gpiod_get_optional(dev, "bt-enable", GPIOD_OUT_LOW);

Why are these optional? Does it make sense to have a qca6390 without
both of these gpios connected?

Regards,
Bjorn

> +	if (IS_ERR(ctx->bt_gpio))
> +		return dev_err_probe(dev, PTR_ERR(ctx->bt_gpio),
> +				     "Failed to get the Bluetooth enable GPIO\n");
> +
> +	ctx->wlan_gpio = devm_gpiod_get_optional(dev, "wlan-enable",
> +						 GPIOD_OUT_LOW);
> +	if (IS_ERR(ctx->wlan_gpio))
> +		return dev_err_probe(dev, PTR_ERR(ctx->wlan_gpio),
> +				     "Failed to get the WLAN enable GPIO\n");
> +
> +	memset(&config, 0, sizeof(config));
> +
> +	config.parent = dev;
> +	config.owner = THIS_MODULE;
> +	config.drvdata = ctx;
> +	config.match = pwrseq_qca6390_match;
> +	config.power_on = pwrseq_qca6390_power_on;
> +	config.power_off = pwrseq_qca6390_power_off;
> +
> +	ctx->pwrseq = devm_pwrseq_device_register(dev, &config);
> +	if (IS_ERR(ctx->pwrseq))
> +		return dev_err_probe(dev, PTR_ERR(ctx->pwrseq),
> +				     "Failed to register the power sequencer\n");
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id pwrseq_qca6390_of_match[] = {
> +	{
> +		.compatible = "qcom,qca6390-pmu",
> +		.data = &pwrseq_qca6390_of_data,
> +	},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, pwrseq_qca6390_of_match);
> +
> +static struct platform_driver pwrseq_qca6390_driver = {
> +	.driver = {
> +		.name = "pwrseq-qca6390",
> +		.of_match_table = pwrseq_qca6390_of_match,
> +	},
> +	.probe = pwrseq_qca6390_probe,
> +};
> +module_platform_driver(pwrseq_qca6390_driver);
> +
> +MODULE_AUTHOR("Bartosz Golaszewski <bartosz.golaszewski@linaro.org>");
> +MODULE_DESCRIPTION("QCA6390 PMU power sequencing driver");
> +MODULE_LICENSE("GPL");
> -- 
> 2.40.1
> 

