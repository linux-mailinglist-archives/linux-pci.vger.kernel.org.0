Return-Path: <linux-pci+bounces-39699-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48EBBC1CB93
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 19:15:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 318C0583AEE
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 17:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A1935470F;
	Wed, 29 Oct 2025 17:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WefDjtFQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8765F354AE2;
	Wed, 29 Oct 2025 17:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761760609; cv=none; b=iIpP5QTg4/47geivGUqYvUyBmDu40lmc77F+B0pSZzmMvJyf3/xKlUhbuqG7P0Y2QAI8i5XxcaOOw7N8pG+TdcWl5t6gxQlnNbhmLpwRB7CN/ar9vbhDYGhBwaWfcXWjA907aXgitqQvH97j63nRlOlXDJNHOHVl4W+TRtl1H0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761760609; c=relaxed/simple;
	bh=VzK5oAorESm47QWMsddWXTePfWCCmkkIk79NLObV5bc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=DQOLV2l9Xo05FROP7Qwq5xZozdGExnglxWyZmyxF4T1Qp76c2vmyaQLd0thKtkOXMUqEI1CwOhB4iblAWQyVgs3ZEyl0Aezq8SzSbcOE9pikqivpmUsUueMPdx8xqfJKUT9IJSgDyASpT6mLhljbEvKxTU2xOl0KiVdUYs8U2xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WefDjtFQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA482C4CEF7;
	Wed, 29 Oct 2025 17:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761760609;
	bh=VzK5oAorESm47QWMsddWXTePfWCCmkkIk79NLObV5bc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=WefDjtFQxaqNITeCzyBwduPSq6eq7KGJtsT2AF0tpE+HPH+tjK4IzpZavlRn/5XsQ
	 bAqy+ezFjPZQf9TOZPQl6LXTvXW9IfgUJjbAoy5vs36s3bfKfYzKQg/z1bubPH73jh
	 1ItJud1AeLXZlnq4bcVqu3rpaUAMlJkdHmPuONikaXEvzkph5eumYyBiA1nwLpgQr4
	 QSEpHgWx8G4kOS7ej8Kp+v5EZVkYD3yl7v3+XLUa3lNShkcaOmr1AUVB0MzBpFpGOj
	 pC344FC62eHwyUuXg2zk98jn071eznE2X1eDI8XnNdAIINuY4R7ZrZ6Wl5YCNKdj1p
	 /8lus9PKvBXYA==
Date: Wed, 29 Oct 2025 12:56:47 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>, x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, linux-mips@vger.kernel.org,
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-sh@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/7] clk: ingenic: tcu: Use contextual data instead of
 global variable
Message-ID: <20251029175647.GA1572736@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029163336.2785270-5-thierry.reding@gmail.com>

On Wed, Oct 29, 2025 at 05:33:33PM +0100, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Pass the driver-specific data via the syscore struct and use it in the
> syscore ops.

Some of these things in drivers/clk/ are also platform_device drivers
(though not this one) and use generic power management, e.g.,

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/clk/qcom/q6sstop-qcs404.c?id=v6.17#n209

I have no idea if that's desirable or practical here, but using the
platform_device model instead of syscore could have advantages in
terms of modeling device dependencies and ordering.

> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
> Changes in v3:
> - adjust for API changes and update commit message
> 
>  drivers/clk/ingenic/tcu.c | 63 +++++++++++++++++++--------------------
>  1 file changed, 30 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/clk/ingenic/tcu.c b/drivers/clk/ingenic/tcu.c
> index bc6a51da2072..8c6337d8e831 100644
> --- a/drivers/clk/ingenic/tcu.c
> +++ b/drivers/clk/ingenic/tcu.c
> @@ -53,9 +53,9 @@ struct ingenic_tcu {
>  	struct clk *clk;
>  
>  	struct clk_hw_onecell_data *clocks;
> -};
>  
> -static struct ingenic_tcu *ingenic_tcu;
> +	struct syscore syscore;
> +};
>  
>  static inline struct ingenic_tcu_clk *to_tcu_clk(struct clk_hw *hw)
>  {
> @@ -332,6 +332,29 @@ static const struct of_device_id __maybe_unused ingenic_tcu_of_match[] __initcon
>  	{ /* sentinel */ }
>  };
>  
> +static int __maybe_unused tcu_pm_suspend(void *data)
> +{
> +	struct ingenic_tcu *tcu = data;
> +
> +	if (tcu->clk)
> +		clk_disable(tcu->clk);
> +
> +	return 0;
> +}
> +
> +static void __maybe_unused tcu_pm_resume(void *data)
> +{
> +	struct ingenic_tcu *tcu = data;
> +
> +	if (tcu->clk)
> +		clk_enable(tcu->clk);
> +}
> +
> +static const struct syscore_ops tcu_pm_ops __maybe_unused = {
> +	.suspend = tcu_pm_suspend,
> +	.resume = tcu_pm_resume,
> +};
> +
>  static int __init ingenic_tcu_probe(struct device_node *np)
>  {
>  	const struct of_device_id *id = of_match_node(ingenic_tcu_of_match, np);
> @@ -430,7 +453,11 @@ static int __init ingenic_tcu_probe(struct device_node *np)
>  		goto err_unregister_ost_clock;
>  	}
>  
> -	ingenic_tcu = tcu;
> +	if (IS_ENABLED(CONFIG_PM_SLEEP)) {
> +		tcu->syscore.ops = &tcu_pm_ops;
> +		tcu->syscore.data = tcu;
> +		register_syscore(&tcu->syscore);
> +	}
>  
>  	return 0;
>  
> @@ -455,42 +482,12 @@ static int __init ingenic_tcu_probe(struct device_node *np)
>  	return ret;
>  }
>  
> -static int __maybe_unused tcu_pm_suspend(void *data)
> -{
> -	struct ingenic_tcu *tcu = ingenic_tcu;
> -
> -	if (tcu->clk)
> -		clk_disable(tcu->clk);
> -
> -	return 0;
> -}
> -
> -static void __maybe_unused tcu_pm_resume(void *data)
> -{
> -	struct ingenic_tcu *tcu = ingenic_tcu;
> -
> -	if (tcu->clk)
> -		clk_enable(tcu->clk);
> -}
> -
> -static const struct syscore_ops __maybe_unused tcu_pm_ops = {
> -	.suspend = tcu_pm_suspend,
> -	.resume = tcu_pm_resume,
> -};
> -
> -static struct syscore __maybe_unused tcu_pm = {
> -	.ops = &tcu_pm_ops,
> -};
> -
>  static void __init ingenic_tcu_init(struct device_node *np)
>  {
>  	int ret = ingenic_tcu_probe(np);
>  
>  	if (ret)
>  		pr_crit("Failed to initialize TCU clocks: %d\n", ret);
> -
> -	if (IS_ENABLED(CONFIG_PM_SLEEP))
> -		register_syscore(&tcu_pm);
>  }
>  
>  CLK_OF_DECLARE_DRIVER(jz4740_cgu, "ingenic,jz4740-tcu", ingenic_tcu_init);
> -- 
> 2.51.0
> 

