Return-Path: <linux-pci+bounces-43941-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F81DCEEB5B
	for <lists+linux-pci@lfdr.de>; Fri, 02 Jan 2026 14:58:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7C3ED3001BCE
	for <lists+linux-pci@lfdr.de>; Fri,  2 Jan 2026 13:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6CDB312815;
	Fri,  2 Jan 2026 13:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iAsYvtKc"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CC22DC35C
	for <linux-pci@vger.kernel.org>; Fri,  2 Jan 2026 13:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767362297; cv=none; b=G+lC0XytK/1ombtZ6twLGlyZPp0c4gGo+VUTm2um6S58pT3lUppFS76C9Wftm3R2356uhR1ozw4QIg1LZG5D66VjRaMCcGoER5W6sEuEomRq0f1h8agktSysIFyJby31TB541Zqmyi3Mqq86jyY+tGPm1y2o7JVNUTAMpLw0b7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767362297; c=relaxed/simple;
	bh=31ykytoW852VWU5JBxm2IrOAbb5cvwau/SyqJlfcMJw=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LBMbccM9WNaUVtQNpnPjWoL2C38fF492yupEHIfksx6aD2eQoCjTfiAVSDS6cxKezEN1smIXm/YUW5akSpHCGNv9PR9LrOtJJktWK4AZMwQQfvt+IkovTq4NWsbwoHVG8Klx/FyQ248GMAERWzrEr2xRss/auEqamsSb5wEkxh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iAsYvtKc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06005C4AF0F
	for <linux-pci@vger.kernel.org>; Fri,  2 Jan 2026 13:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767362297;
	bh=31ykytoW852VWU5JBxm2IrOAbb5cvwau/SyqJlfcMJw=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:From;
	b=iAsYvtKcGb0++fvAUd1CvT6obZiuJXqfZWT+4JVlUFtSUPookzCaq2Dt3pCyF8gvi
	 gfNFDKddK7vmKua3gJUpO5V+d0GNXfzckzgqUvHKi2bMWs90AP086WQh3HkzxfB8YB
	 WZq6/l101l9AxQiY8Lf8vNIWUSucwd0nbYHlduEBOXkMzSy9uCKtTKj0GCuZ6Pm6Wz
	 3jAdN86E6Tvy1SQrQYYCN/xPa1ZhlcCymi73hmBD+g8c8DTuoQw9wjHicjTU6FH72s
	 iGrHnLV0JZxIXtaqrk22f3qYOc1qhRsQxZ0iAZaTfQBobT8rAMKW0z46m8kudecW//
	 4zZ7k7LGUtZ2g==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-598f8136a24so13485647e87.3
        for <linux-pci@vger.kernel.org>; Fri, 02 Jan 2026 05:58:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV4mgUXLWGfg3vKF7mR4nExmgtQ7BWtt1ogUgxLMOJLL4JBqKqVrahq9gnASRU+U79f4RrksNHnkgc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdfpNQ9FMArZPsqQ1tNR84Og8JHQkNYViLR32ZlC3JyoT063VB
	p/JDk4C9p+vRHqkEYymdc4WH/wPaztLxD6aoK1qMIK07IJtN0LCi4Z6q34rSwgUT+VgY2ZIRd/y
	5P1SqvcggdOv/jrKFDk+LOoabvHfoFL5KslAIjnLLvw==
X-Google-Smtp-Source: AGHT+IEBVqRnjW8TA5v8Ve6PA8XvKbnhZNz5qSwKcfkioI6Th2RtaPojju4JVzaiNauZXPZION7H54IW/Ffsvg5KTbU=
X-Received: by 2002:a05:6512:3b8e:b0:59a:103d:2917 with SMTP id
 2adb3069b0e04-59a17ddc928mr14190519e87.47.1767362295592; Fri, 02 Jan 2026
 05:58:15 -0800 (PST)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 2 Jan 2026 13:58:14 +0000
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 2 Jan 2026 13:58:14 +0000
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20251229-pci-pwrctrl-rework-v3-2-c7d5918cd0db@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251229-pci-pwrctrl-rework-v3-0-c7d5918cd0db@oss.qualcomm.com> <20251229-pci-pwrctrl-rework-v3-2-c7d5918cd0db@oss.qualcomm.com>
Date: Fri, 2 Jan 2026 13:58:14 +0000
X-Gmail-Original-Message-ID: <CAMRc=Md=U_xEByDJSrYsTRVn=gtP-SR+-gjV-FynALWv64x5RA@mail.gmail.com>
X-Gm-Features: AQt7F2ovqLUZjzR05gl01dAnpi4RVt0fhD8PtaHqPrmFHCrAZ_52yiaqj2h8GIE
Message-ID: <CAMRc=Md=U_xEByDJSrYsTRVn=gtP-SR+-gjV-FynALWv64x5RA@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] PCI/pwrctrl: Add 'struct pci_pwrctrl::power_{on/off}'
 callbacks
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>, 
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@kernel.org>, 
	Brian Norris <briannorris@chromium.org>, 
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, Niklas Cassel <cassel@kernel.org>, 
	Alex Elder <elder@riscstar.com>, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Chen-Yu Tsai <wenst@chromium.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"

On Mon, 29 Dec 2025 18:26:53 +0100, Manivannan Sadhasivam via B4 Relay
<devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org> said:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
>
> To allow the pwrctrl core to control the power on/off sequences of the
> pwrctrl drivers, add the 'struct pci_pwrctrl::power_{on/off}' callbacks and
> populate them in the respective pwrctrl drivers.
>
> The pwrctrl drivers still power on the resources on their own now. So there
> is no functional change.
>
> Co-developed-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> Tested-by: Chen-Yu Tsai <wenst@chromium.org>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
>  drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c | 27 +++++++++++++++---
>  drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c | 20 +++++++++----
>  drivers/pci/pwrctrl/slot.c               | 48 ++++++++++++++++++++++----------
>  include/linux/pci-pwrctrl.h              |  4 +++
>  4 files changed, 75 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c b/drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c
> index 4e664e7b8dd2..0fb9038a1d18 100644
> --- a/drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c
> +++ b/drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c
> @@ -52,11 +52,27 @@ static const struct pci_pwrctrl_pwrseq_pdata pci_pwrctrl_pwrseq_qcom_wcn_pdata =
>  	.validate_device = pci_pwrctrl_pwrseq_qcm_wcn_validate_device,
>  };
>
> +static int pci_pwrctrl_pwrseq_power_on(struct pci_pwrctrl *ctx)
> +{
> +	struct pci_pwrctrl_pwrseq_data *data = container_of(ctx, struct pci_pwrctrl_pwrseq_data,
> +							    ctx);
> +
> +	return pwrseq_power_on(data->pwrseq);
> +}
> +
> +static void pci_pwrctrl_pwrseq_power_off(struct pci_pwrctrl *ctx)
> +{
> +	struct pci_pwrctrl_pwrseq_data *data = container_of(ctx, struct pci_pwrctrl_pwrseq_data,
> +							    ctx);
> +
> +	pwrseq_power_off(data->pwrseq);
> +}
> +
>  static void devm_pci_pwrctrl_pwrseq_power_off(void *data)
>  {
> -	struct pwrseq_desc *pwrseq = data;
> +	struct pci_pwrctrl_pwrseq_data *pwrseq_data = data;
>
> -	pwrseq_power_off(pwrseq);
> +	pci_pwrctrl_pwrseq_power_off(&pwrseq_data->ctx);
>  }
>
>  static int pci_pwrctrl_pwrseq_probe(struct platform_device *pdev)
> @@ -85,16 +101,19 @@ static int pci_pwrctrl_pwrseq_probe(struct platform_device *pdev)
>  		return dev_err_probe(dev, PTR_ERR(data->pwrseq),
>  				     "Failed to get the power sequencer\n");
>
> -	ret = pwrseq_power_on(data->pwrseq);
> +	ret = pci_pwrctrl_pwrseq_power_on(&data->ctx);
>  	if (ret)
>  		return dev_err_probe(dev, ret,
>  				     "Failed to power-on the device\n");
>
>  	ret = devm_add_action_or_reset(dev, devm_pci_pwrctrl_pwrseq_power_off,
> -				       data->pwrseq);
> +				       data);
>  	if (ret)
>  		return ret;
>
> +	data->ctx.power_on = pci_pwrctrl_pwrseq_power_on;
> +	data->ctx.power_off = pci_pwrctrl_pwrseq_power_off;
> +
>  	pci_pwrctrl_init(&data->ctx, dev);
>
>  	ret = devm_pci_pwrctrl_device_set_ready(dev, &data->ctx);
> diff --git a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c b/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
> index 0a63add84d09..0393af2a099c 100644
> --- a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
> +++ b/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
> @@ -434,15 +434,20 @@ static int tc9563_pwrctrl_parse_device_dt(struct tc9563_pwrctrl_ctx *ctx, struct
>  	return 0;
>  }
>
> -static void tc9563_pwrctrl_power_off(struct tc9563_pwrctrl_ctx *ctx)
> +static void tc9563_pwrctrl_power_off(struct pci_pwrctrl *pwrctrl)
>  {
> +	struct tc9563_pwrctrl_ctx *ctx = container_of(pwrctrl,
> +					struct tc9563_pwrctrl_ctx, pwrctrl);
> +
>  	gpiod_set_value(ctx->reset_gpio, 1);
>
>  	regulator_bulk_disable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
>  }
>
> -static int tc9563_pwrctrl_bring_up(struct tc9563_pwrctrl_ctx *ctx)
> +static int tc9563_pwrctrl_power_on(struct pci_pwrctrl *pwrctrl)
>  {
> +	struct tc9563_pwrctrl_ctx *ctx = container_of(pwrctrl,
> +					struct tc9563_pwrctrl_ctx, pwrctrl);
>  	struct tc9563_pwrctrl_cfg *cfg;
>  	int ret, i;
>
> @@ -502,7 +507,7 @@ static int tc9563_pwrctrl_bring_up(struct tc9563_pwrctrl_ctx *ctx)
>  		return 0;
>
>  power_off:
> -	tc9563_pwrctrl_power_off(ctx);
> +	tc9563_pwrctrl_power_off(&ctx->pwrctrl);
>  	return ret;
>  }
>
> @@ -591,7 +596,7 @@ static int tc9563_pwrctrl_probe(struct platform_device *pdev)
>  			goto remove_i2c;
>  	}
>
> -	ret = tc9563_pwrctrl_bring_up(ctx);
> +	ret = tc9563_pwrctrl_power_on(&ctx->pwrctrl);
>  	if (ret)
>  		goto remove_i2c;
>
> @@ -601,6 +606,9 @@ static int tc9563_pwrctrl_probe(struct platform_device *pdev)
>  			goto power_off;
>  	}
>
> +	ctx->pwrctrl.power_on = tc9563_pwrctrl_power_on;
> +	ctx->pwrctrl.power_off = tc9563_pwrctrl_power_off;
> +
>  	ret = devm_pci_pwrctrl_device_set_ready(dev, &ctx->pwrctrl);
>  	if (ret)
>  		goto power_off;
> @@ -610,7 +618,7 @@ static int tc9563_pwrctrl_probe(struct platform_device *pdev)
>  	return 0;
>
>  power_off:
> -	tc9563_pwrctrl_power_off(ctx);
> +	tc9563_pwrctrl_power_off(&ctx->pwrctrl);
>  remove_i2c:
>  	i2c_unregister_device(ctx->client);
>  	put_device(&ctx->adapter->dev);
> @@ -621,7 +629,7 @@ static void tc9563_pwrctrl_remove(struct platform_device *pdev)
>  {
>  	struct tc9563_pwrctrl_ctx *ctx = platform_get_drvdata(pdev);
>
> -	tc9563_pwrctrl_power_off(ctx);
> +	tc9563_pwrctrl_power_off(&ctx->pwrctrl);
>  	i2c_unregister_device(ctx->client);
>  	put_device(&ctx->adapter->dev);
>  }
> diff --git a/drivers/pci/pwrctrl/slot.c b/drivers/pci/pwrctrl/slot.c
> index 3320494b62d8..14701f65f1f2 100644
> --- a/drivers/pci/pwrctrl/slot.c
> +++ b/drivers/pci/pwrctrl/slot.c
> @@ -17,13 +17,36 @@ struct pci_pwrctrl_slot_data {
>  	struct pci_pwrctrl ctx;
>  	struct regulator_bulk_data *supplies;
>  	int num_supplies;
> +	struct clk *clk;
>  };
>
> -static void devm_pci_pwrctrl_slot_power_off(void *data)
> +static int pci_pwrctrl_slot_power_on(struct pci_pwrctrl *ctx)
>  {
> -	struct pci_pwrctrl_slot_data *slot = data;
> +	struct pci_pwrctrl_slot_data *slot = container_of(ctx, struct pci_pwrctrl_slot_data, ctx);
> +	int ret;
> +
> +	ret = regulator_bulk_enable(slot->num_supplies, slot->supplies);
> +	if (ret < 0) {
> +		dev_err(slot->ctx.dev, "Failed to enable slot regulators\n");
> +		return ret;
> +	}
> +
> +	return clk_prepare_enable(slot->clk);
> +}
> +
> +static void pci_pwrctrl_slot_power_off(struct pci_pwrctrl *ctx)
> +{
> +	struct pci_pwrctrl_slot_data *slot = container_of(ctx, struct pci_pwrctrl_slot_data, ctx);
>
>  	regulator_bulk_disable(slot->num_supplies, slot->supplies);
> +	clk_disable_unprepare(slot->clk);
> +}
> +
> +static void devm_pci_pwrctrl_slot_release(void *data)
> +{
> +	struct pci_pwrctrl_slot_data *slot = data;
> +
> +	pci_pwrctrl_slot_power_off(&slot->ctx);
>  	regulator_bulk_free(slot->num_supplies, slot->supplies);
>  }
>
> @@ -31,7 +54,6 @@ static int pci_pwrctrl_slot_probe(struct platform_device *pdev)
>  {
>  	struct pci_pwrctrl_slot_data *slot;
>  	struct device *dev = &pdev->dev;
> -	struct clk *clk;
>  	int ret;
>
>  	slot = devm_kzalloc(dev, sizeof(*slot), GFP_KERNEL);
> @@ -46,23 +68,21 @@ static int pci_pwrctrl_slot_probe(struct platform_device *pdev)
>  	}
>
>  	slot->num_supplies = ret;
> -	ret = regulator_bulk_enable(slot->num_supplies, slot->supplies);
> -	if (ret < 0) {
> -		dev_err_probe(dev, ret, "Failed to enable slot regulators\n");
> -		regulator_bulk_free(slot->num_supplies, slot->supplies);
> -		return ret;
> -	}
>
> -	ret = devm_add_action_or_reset(dev, devm_pci_pwrctrl_slot_power_off,
> +	ret = devm_add_action_or_reset(dev, devm_pci_pwrctrl_slot_release,
>  				       slot);
>  	if (ret)
>  		return ret;
>
> -	clk = devm_clk_get_optional_enabled(dev, NULL);
> -	if (IS_ERR(clk)) {
> -		return dev_err_probe(dev, PTR_ERR(clk),
> +	slot->clk = devm_clk_get_optional(dev, NULL);
> +	if (IS_ERR(slot->clk))
> +		return dev_err_probe(dev, PTR_ERR(slot->clk),
>  				     "Failed to enable slot clock\n");
> -	}
> +
> +	pci_pwrctrl_slot_power_on(&slot->ctx);
> +
> +	slot->ctx.power_on = pci_pwrctrl_slot_power_on;
> +	slot->ctx.power_off = pci_pwrctrl_slot_power_off;
>
>  	pci_pwrctrl_init(&slot->ctx, dev);
>
> diff --git a/include/linux/pci-pwrctrl.h b/include/linux/pci-pwrctrl.h
> index 4aefc7901cd1..bd0ee9998125 100644
> --- a/include/linux/pci-pwrctrl.h
> +++ b/include/linux/pci-pwrctrl.h
> @@ -31,6 +31,8 @@ struct device_link;
>  /**
>   * struct pci_pwrctrl - PCI device power control context.
>   * @dev: Address of the power controlling device.
> + * @power_on: Callback to power on the power controlling device.
> + * @power_off: Callback to power off the power controlling device.
>   *
>   * An object of this type must be allocated by the PCI power control device and
>   * passed to the pwrctrl subsystem to trigger a bus rescan and setup a device
> @@ -38,6 +40,8 @@ struct device_link;
>   */
>  struct pci_pwrctrl {
>  	struct device *dev;
> +	int (*power_on)(struct pci_pwrctrl *pwrctrl);
> +	void (*power_off)(struct pci_pwrctrl *pwrctrl);

I'd say that returning int here would not hurt and could spare you changing
the code in the future if anyone requires error reporting.

Bart

>
>  	/* private: internal use only */
>  	struct notifier_block nb;
>
> --
> 2.48.1
>
>
>

