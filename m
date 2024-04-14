Return-Path: <linux-pci+bounces-6224-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF488A41E4
	for <lists+linux-pci@lfdr.de>; Sun, 14 Apr 2024 12:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4978D1C20AFC
	for <lists+linux-pci@lfdr.de>; Sun, 14 Apr 2024 10:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E332D7B8;
	Sun, 14 Apr 2024 10:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YLSq0jO5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C9F1865;
	Sun, 14 Apr 2024 10:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713091465; cv=none; b=pIQ2eFj4GTisDFNS1P9jo7G1h8ZpfoqjsZByMOCK2PPzgQ6sYNuTYR727wvljc6R/rUkFiRmQA1+F6+XvnhHlN09mVN3RqN4oZlljHsGVwJ9I6fDZcSPy9Hrx11xhrQDL6Essa164L5O4UjjSKZedXlk3hEzlNHYSIzYjmrDSdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713091465; c=relaxed/simple;
	bh=jScTQYNuKSdQRN71THl1woAyTI/mIsL2raQkX/Y0bi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nWLippfyOH72rHuyZPK44aii6cmLT7ApAAAFecYA+zvG+mTHPVPiSUih8pT4UUxM/conGxd8+FvCubp0JTV0qgPXel9nub0L4/yH8R5lIuZwpyhx02mim+lSKhSb49V4N3Iz7RBkjfvQYo4T+FckuB85ndVNdUi82Z2a6tgxM/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YLSq0jO5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CC6FC072AA;
	Sun, 14 Apr 2024 10:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713091465;
	bh=jScTQYNuKSdQRN71THl1woAyTI/mIsL2raQkX/Y0bi0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YLSq0jO5BrG1cv9zv6kr3rQyeJsfGcqSJLz+Q7xeorHaa5lcEYIxKgLs8BydAqvJP
	 q00VFElDlEjTcopyOUK1waF3ME2oKgyJyJuhNQ8v/L8qH/uHwBUxhuIj2eGfyki+TS
	 cLaDO8XBRUmtvlQO17LNXikT/+ciPNG1G1mOLE6MzEOdH1OptnO0yOhbRwnIdnsFhS
	 4KWPi5WnG8WA941iN29H2UDTT3MDtEtM6u0lugw1xKbrjNJbZqgMCGeunfLGAPErlS
	 AiJgH3QgEOBt5HNed+WHbbgABU7V7RXOdFVKKS3RjTj/GAM8+Uc4/AZvtIHjdNwcLA
	 sV8f64OIiMB0Q==
Date: Sun, 14 Apr 2024 11:44:14 +0100
From: Simon Horman <horms@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Kalle Valo <kvalo@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
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
	Xilin Wu <wuxilin123@gmail.com>, linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v7 14/16] power: pwrseq: add a driver for the PMU module
 on the QCom WCN chipsets
Message-ID: <20240414104414.GC645060@kernel.org>
References: <20240410124628.171783-1-brgl@bgdev.pl>
 <20240410124628.171783-15-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410124628.171783-15-brgl@bgdev.pl>

On Wed, Apr 10, 2024 at 02:46:26PM +0200, Bartosz Golaszewski wrote:

...

> +static int pwrseq_qcom_wcn_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct pwrseq_qcom_wcn_ctx *ctx;
> +	struct pwrseq_config config;
> +	int i, ret;
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
> +	ctx->regs = devm_kcalloc(dev, ctx->pdata->num_vregs,
> +				 sizeof(*ctx->regs), GFP_KERNEL);
> +	if (!ctx->regs)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < ctx->pdata->num_vregs; i++)
> +		ctx->regs[i].supply = ctx->pdata->vregs[i];
> +
> +	ret = devm_regulator_bulk_get(dev, ctx->pdata->num_vregs, ctx->regs);
> +	if (ret < 0)
> +		return dev_err_probe(dev, PTR_ERR(ctx->regs),
> +				     "Failed to get all regulators\n");

Hi Bartosz,

It looks like ctx->regs is not an error pointer here,
should this be:

		return dev_err_probe(dev, ret, ...

Flagged by Smatch.

> +
> +	ctx->bt_gpio = devm_gpiod_get_optional(dev, "bt-enable", GPIOD_OUT_LOW);
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
> +	ctx->clk = devm_clk_get_optional(dev, NULL);
> +	if (IS_ERR(ctx->clk))
> +		return dev_err_probe(dev, PTR_ERR(ctx->clk),
> +				     "Failed to get the reference clock\n");
> +
> +	memset(&config, 0, sizeof(config));
> +
> +	config.parent = dev;
> +	config.owner = THIS_MODULE;
> +	config.drvdata = ctx;
> +	config.match = pwrseq_qcom_wcn_match;
> +	config.targets = pwrseq_qcom_wcn_targets;
> +
> +	ctx->pwrseq = devm_pwrseq_device_register(dev, &config);
> +	if (IS_ERR(ctx->pwrseq))
> +		return dev_err_probe(dev, PTR_ERR(ctx->pwrseq),
> +				     "Failed to register the power sequencer\n");
> +
> +	return 0;
> +}

...

