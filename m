Return-Path: <linux-pci+bounces-34458-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A799B2FD38
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 16:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D42F41BC14C4
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 14:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6635A2E3B0E;
	Thu, 21 Aug 2025 14:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l8esBDFW"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E9D2E040A;
	Thu, 21 Aug 2025 14:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755786742; cv=none; b=npiozC/no/Tg4ANXG0AlcMf9+z48XLG67Y4erMiyyX8IUhXC6p8BZr2hVVQ14to64Myxyv3aKvuNzVz05EYH1qCXkuVUbKxud8idoZNwjvQqQjTy1jwFaZLyN5bqdXOnXR+SdSCody1dsGX6CR7yXC8Z5OQsYxXs51j04H3nfLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755786742; c=relaxed/simple;
	bh=n+5U3Ajo9CPdPYE9OkkNwNh9TdRRM7/xm0O4mUb7XA0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=MdvTyNQHpBqSnBV5T0o2fSzx4A2e7S0ioAuYswioBTX0Nq9ft91MuxDYeVif96tS+EZbqI8fhYVJWXTIv2CWl/mzuqE9p8hTim1+qEcs0Nv13tl23OvulPl0c083J8D02nnIhWu2ZBFHpVQBv2yFJsnaCuB/i3QOKH+mwoK3zVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l8esBDFW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A558C4CEEB;
	Thu, 21 Aug 2025 14:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755786741;
	bh=n+5U3Ajo9CPdPYE9OkkNwNh9TdRRM7/xm0O4mUb7XA0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=l8esBDFWkdo5FMXizHgOaA3Pu7BewNIy2MTdYBeGm+MekBPAlKM5dIurjSb8oXLUi
	 rN3C9gvxyyZkApNaGMjka/oS3F/Af1eoBfVgKbDt3KRK9eVOQu8CymbkjIl1MY+Ixk
	 2L5g5qJ3PMa8zbxaXBEwc1QhQr9O2Kmj81bs59s/DEMQLxxoaxaZC5ES2Q45spxFec
	 Pc0zsYrd6P3EFpyHZZLYixYbwDgoahmiE90lHEJC2jFnmRwKfyqbJNsrOq4Ypp7829
	 uqADlwavkWuTHZa7rCDnNd1Lw6Xq9vrD775tja73LnF5L4HNRUnZuJKs4N/z8ccrtm
	 FjfktkxYnX7hg==
Date: Thu, 21 Aug 2025 09:32:20 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Marcos Del Sol Vives <marcos@orca.pet>
Cc: linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Michael Walle <mwalle@kernel.org>, Lee Jones <lee@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-gpio@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 1/3] gpio: gpio-regmap: add flags to control some
 behaviour
Message-ID: <20250821143220.GA672670@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821101902.626329-2-marcos@orca.pet>

Not my area, but consider making the subject more specific, e.g.,
"add flag to set direction before value"

On Thu, Aug 21, 2025 at 12:18:57PM +0200, Marcos Del Sol Vives wrote:
> The Vortex86 family of SoCs need the direction set before the value, else
> writes to the DATA ports are ignored.
> 
> This commit adds a new "flags" field plus a flag to change the default
> behaviour, which is to set first the direction and then the value.

This sounds like the default behavior is to set direction, then value.
But from the patch, it looks like:

  - default: set value, then direction

  - with GPIO_REGMAP_DIR_BEFORE_SET: set direction, then value

> Signed-off-by: Marcos Del Sol Vives <marcos@orca.pet>
> ---
>  drivers/gpio/gpio-regmap.c  | 17 ++++++++++++++++-
>  include/linux/gpio/regmap.h | 17 +++++++++++++++++
>  2 files changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpio/gpio-regmap.c b/drivers/gpio/gpio-regmap.c
> index e8a32dfebdcb..24cefbd57637 100644
> --- a/drivers/gpio/gpio-regmap.c
> +++ b/drivers/gpio/gpio-regmap.c
> @@ -31,6 +31,7 @@ struct gpio_regmap {
>  	unsigned int reg_clr_base;
>  	unsigned int reg_dir_in_base;
>  	unsigned int reg_dir_out_base;
> +	unsigned int flags;
>  
>  	int (*reg_mask_xlate)(struct gpio_regmap *gpio, unsigned int base,
>  			      unsigned int offset, unsigned int *reg,
> @@ -196,7 +197,20 @@ static int gpio_regmap_direction_input(struct gpio_chip *chip,
>  static int gpio_regmap_direction_output(struct gpio_chip *chip,
>  					unsigned int offset, int value)
>  {
> -	gpio_regmap_set(chip, offset, value);
> +	struct gpio_regmap *gpio = gpiochip_get_data(chip);
> +	int ret;
> +
> +	if (gpio->flags & GPIO_REGMAP_DIR_BEFORE_SET) {
> +		ret = gpio_regmap_set_direction(chip, offset, true);
> +		if (ret)
> +			return ret;
> +
> +		return gpio_regmap_set(chip, offset, value);
> +	}
> +
> +	ret = gpio_regmap_set(chip, offset, value);
> +	if (ret)
> +		return ret;
>  
>  	return gpio_regmap_set_direction(chip, offset, true);
>  }
> @@ -247,6 +261,7 @@ struct gpio_regmap *gpio_regmap_register(const struct gpio_regmap_config *config
>  	gpio->reg_clr_base = config->reg_clr_base;
>  	gpio->reg_dir_in_base = config->reg_dir_in_base;
>  	gpio->reg_dir_out_base = config->reg_dir_out_base;
> +	gpio->flags = config->flags;
>  
>  	chip = &gpio->gpio_chip;
>  	chip->parent = config->parent;
> diff --git a/include/linux/gpio/regmap.h b/include/linux/gpio/regmap.h
> index c722c67668c6..aea107e71fec 100644
> --- a/include/linux/gpio/regmap.h
> +++ b/include/linux/gpio/regmap.h
> @@ -12,6 +12,20 @@ struct regmap;
>  #define GPIO_REGMAP_ADDR_ZERO ((unsigned int)(-1))
>  #define GPIO_REGMAP_ADDR(addr) ((addr) ? : GPIO_REGMAP_ADDR_ZERO)
>  
> +
> +/**
> + * enum gpio_regmap_flags - flags to control GPIO operation
> + */
> +enum gpio_regmap_flags {
> +	/**
> +	 * @GPIO_REGMAP_DIR_BEFORE_SET: when setting a pin as an output, set
> +	 * its direction before the value. The output value will be undefined
> +	 * for a short time which may have unwanted side effects, but some
> +	 * hardware requires this.
> +	 */
> +	GPIO_REGMAP_DIR_BEFORE_SET	= BIT(0),
> +};
> +
>  /**
>   * struct gpio_regmap_config - Description of a generic regmap gpio_chip.
>   * @parent:		The parent device
> @@ -23,6 +37,8 @@ struct regmap;
>   *			If not given, the name of the device is used.
>   * @ngpio:		(Optional) Number of GPIOs
>   * @names:		(Optional) Array of names for gpios
> + * @flags:		(Optional) A bitmask of flags from
> + * 			&enum gpio_regmap_flags
>   * @reg_dat_base:	(Optional) (in) register base address
>   * @reg_set_base:	(Optional) set register base address
>   * @reg_clr_base:	(Optional) clear register base address
> @@ -68,6 +84,7 @@ struct gpio_regmap_config {
>  	const char *label;
>  	int ngpio;
>  	const char *const *names;
> +	unsigned int flags;
>  
>  	unsigned int reg_dat_base;
>  	unsigned int reg_set_base;
> -- 
> 2.34.1
> 

