Return-Path: <linux-pci+bounces-14447-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E4399C9CE
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 14:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73F122811DB
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 12:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5A119F436;
	Mon, 14 Oct 2024 12:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TOjL8u/z"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A456819D086;
	Mon, 14 Oct 2024 12:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728908011; cv=none; b=FjwoB9cxCFFawPPuVjgIApGbqz6SQL2jPi76/Rj+XogqTsOZwGx2iCLPyR6U0lgGcwBOemYHep5garAKi4hHC13rft8DbiFtjvbrgSu4pu2/4B5RBbYP5RE2JrVtRxyTkyjgqyvKIDUXOupBpxvaWePSz4UcJI/Lq3B8NmCZhN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728908011; c=relaxed/simple;
	bh=Pqcl0dwf49EdBvTszQmFGHzrd66GK6QAO4IKAI4N30Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pedsqHzY8JAD8mFXONwTwN0PWScEFvZbe2ZNwm0ujPORKQqTWNkFtl2ISpQewtXyAFKbkGOgZFgDkq/qjs8pUIWoc2EfMN3jiwYAtVOIQ8nONfsNjNLySwLcFOyvtxS3XYxRUJ4cDhBstGtMeqH+uaB5CugQ4gheTWgShUm371E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TOjL8u/z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 596EFC4CEC3;
	Mon, 14 Oct 2024 12:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728908011;
	bh=Pqcl0dwf49EdBvTszQmFGHzrd66GK6QAO4IKAI4N30Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TOjL8u/z2Kga9VObd6TWtDpF8KY3MXxRzJWYOMnMOsIC6IsMZ2dNDiieIWJDGvCce
	 nqRtUfMBZC537LmFYTarzmtsbh/LLF8IQuLoxO2JrckofKKwGvRnfeEnqDEXmxEwLl
	 N55dohhrj51rGq6szyhCsKHt+oAkrJr0Pj7Cr1beHxF+T0ipqObt+SnssA28RecQsK
	 mq2iaL81hT+C4tgZ+D6vAEZf/LhEu++7dYTcTFZdZAT3WRBf9/T71m82+h28+w84SS
	 3yvfmBOw3WaRbrWGUm7duJpTcx1aton7uzy03IzG4WhB5nJHVkkkh5eOR9Dl+MtwRt
	 wXV0BU6RxTLLA==
Date: Mon, 14 Oct 2024 13:13:24 +0100
From: Simon Horman <horms@kernel.org>
To: Philipp Stanner <pstanner@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Wu Hao <hao.wu@intel.com>,
	Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>, Andy Shevchenko <andy@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Damien Le Moal <dlemoal@kernel.org>, Hannes Reinecke <hare@suse.de>,
	Al Viro <viro@zeniv.linux.org.uk>, Keith Busch <kbusch@kernel.org>,
	Li Zetao <lizetao1@huawei.com>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org,
	linux-gpio@vger.kernel.org, netdev@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v7 4/5] gpio: Replace deprecated PCI functions
Message-ID: <20241014121324.GT77519@kernel.org>
References: <20241014075329.10400-1-pstanner@redhat.com>
 <20241014075329.10400-5-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241014075329.10400-5-pstanner@redhat.com>

On Mon, Oct 14, 2024 at 09:53:25AM +0200, Philipp Stanner wrote:
> pcim_iomap_regions() and pcim_iomap_table() have been deprecated by the
> PCI subsystem in commit e354bb84a4c1 ("PCI: Deprecate
> pcim_iomap_table(), pcim_iomap_regions_request_all()").
> 
> Replace those functions with calls to pcim_iomap_region().
> 
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> Reviewed-by: Andy Shevchenko <andy@kernel.org>
> Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/gpio/gpio-merrifield.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-merrifield.c b/drivers/gpio/gpio-merrifield.c
> index 421d7e3a6c66..274afcba31e6 100644
> --- a/drivers/gpio/gpio-merrifield.c
> +++ b/drivers/gpio/gpio-merrifield.c
> @@ -78,24 +78,24 @@ static int mrfld_gpio_probe(struct pci_dev *pdev, const struct pci_device_id *id
>  	if (retval)
>  		return retval;
>  
> -	retval = pcim_iomap_regions(pdev, BIT(1) | BIT(0), pci_name(pdev));
> -	if (retval)
> -		return dev_err_probe(dev, retval, "I/O memory mapping error\n");
> -
> -	base = pcim_iomap_table(pdev)[1];
> +	base = pcim_iomap_region(pdev, 1, pci_name(pdev));
> +	if (IS_ERR(base))
> +		return dev_err_probe(dev, PTR_ERR(base), "I/O memory mapping error\n");
>  
>  	irq_base = readl(base + 0 * sizeof(u32));
>  	gpio_base = readl(base + 1 * sizeof(u32));
>  
>  	/* Release the IO mapping, since we already get the info from BAR1 */
> -	pcim_iounmap_regions(pdev, BIT(1));
> +	pcim_iounmap_region(pdev, 1);
>  
>  	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>  	if (!priv)
>  		return -ENOMEM;
>  
>  	priv->dev = dev;
> -	priv->reg_base = pcim_iomap_table(pdev)[0];
> +	priv->reg_base = pcim_iomap_region(pdev, 0, pci_name(pdev));
> +	if (IS_ERR(priv->reg_base))
> +		return dev_err_probe(dev, PTR_ERR(base), "I/O memory mapping error\n");

Hi Philipp,

There seems to be a mismatch in the use of priv->reg_base and base above.
Should the above use PTR_ERR(priv->reg_base) instead of PTR_ERR(base)?

>  
>  	priv->pin_info.pin_ranges = mrfld_gpio_ranges;
>  	priv->pin_info.nranges = ARRAY_SIZE(mrfld_gpio_ranges);
> -- 
> 2.46.2
> 
> 

