Return-Path: <linux-pci+bounces-12076-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 505C695C939
	for <lists+linux-pci@lfdr.de>; Fri, 23 Aug 2024 11:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C2131C221AD
	for <lists+linux-pci@lfdr.de>; Fri, 23 Aug 2024 09:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D0514B97A;
	Fri, 23 Aug 2024 09:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HgFo/qYo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5EF139D00;
	Fri, 23 Aug 2024 09:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724405357; cv=none; b=kcTl9XptH1LSFbDRfC9CJDJgdDXy/MXSRIzxZ7IcJSxmgmDvzO+W9cesD2ibN6nM+yp3/UxWgLngTu7vTGiy8JGhhIg6Pj0DKfKQ+e6fW2Y0LbCTmpLsBZfCG+9TDAJgk2cd0P6qjMcfBE30YXVPJ4OIQNwxdw1y4Oki5vapM/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724405357; c=relaxed/simple;
	bh=2Yb/HipWs9Hwj3qIpBvkIqiRNPZPBVsVKcsw8IFvcmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BrUjU5/wA9ZrgA5yuaODjj9of18kORp7ykQlMfuFpL7FQFz1zuhI6CLWqyQ544tbz/U8XZna2OyGpdifqH8D4fiv77iXZcaTsDoNyBZJCx4Cr7GCCmF3XBtMm6Q21N6WnuCJfoqna71NgV53vQigj7anR2gpOsBhFZKVBg0OWi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HgFo/qYo; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5334c4cc17fso2380700e87.2;
        Fri, 23 Aug 2024 02:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724405354; x=1725010154; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HJZgnLkJ3O5ij2lr4uMh4xPM1CMCZfKHy3jKVr/xmOI=;
        b=HgFo/qYoLzAoq+HpYvLgMdKJgQseuoxiGMdFRoxkUrAr+h4nkJ/tvseYg8Bf+6qp66
         BUYMbgIWqpxXbXjeCNzB7KTJq3DjXG9CMjMYZr2pUkAptE7PCeEmY5lzVszQOWNHQnSs
         XU/nDnkuIiI262KkE2jc9XDZS3ERHMw85cjD1AeKtrJVJrlxeptmnwt0l/Jnhm8k01h2
         XmxfveTfmMSK1+tA3Yrofar0rhg7jsG4ExD0Y2Gvn12Zt4/ng1IXMT1pt+2eFmH4Wjky
         PEr/za14HsQe6J+MNwNPG5KlWWq4w9I+zbtXmStxZGAouCxg/Tzijg1DvrMHmblievQQ
         IKtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724405354; x=1725010154;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HJZgnLkJ3O5ij2lr4uMh4xPM1CMCZfKHy3jKVr/xmOI=;
        b=hfuzfQ+uVm72kM7QLOdpG15cAef0nqSCq0auCkKgSSCG3o8JUx9nHLXW++d0pTxETE
         eKAq5BaHYXNE7o//r7OaGJC8UAbfP1OboyZr29gVb1wmO5JeWFg8rW9oVicKR8tfUHf+
         4J16HPY6gD3w59q08p/tPUjDz6gMXfZ68D805jBWayvfDDgUgg4UKPVqBNkkJ4imZxY8
         4YL8Mti917ZsoVjSybDT1kKqTkBKTV0hgTn7M9FjkXOQIfbt692b65oUM0Sjzg65BX9O
         pQtJxo2kdPzcmNoAMC7FZosqRraUhBHbK172oemK+lfGLCLWO6Ek/Kab1/FrOtHTWbwe
         lIEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUC+TbkvymhQNrcuaXQXMZ8mIX1MjKEcR1PPU7pHTqSjyDGXig4uW3Bhcms3XbcQPh5xLPtbn2HmMDZhQ==@vger.kernel.org, AJvYcCUjknvbAg39I6oolWZ/KULjtdgdYzBTOrldy5sdMqUqU1s/HArPhECLa6MH3okdfr2YmdGeTtPwZ7HI4g==@vger.kernel.org, AJvYcCUld2lrUIfjCTi9grwDWOHiAG0W8d567XvcKoWZx8u7KEQxbuQToXjq9Cn9KwWCiT0XVy+FydAAsdR9WdMy@vger.kernel.org, AJvYcCVI/Q8xs5fq2pJWa3v3ucT/Dpdm2gexu+vED+/mV9Y2a3JiiCiIiwSVFJRjwbqrFOr5xuIyQi7fcLLM@vger.kernel.org, AJvYcCW/EBBDf2OzNrU+ulJFaWyNpo5Cw8hFoLc6Wk15H+gl7Hmsbc5MHXSQ/+0lvfEGFbHVKDKXBGzH@vger.kernel.org, AJvYcCW2W1+MJGJaJNCq+mcAcZ6Vi5cVjJoFqOj6bN9ALkYWjRrHColFREkjE/E/bTzv3epC5LoIrQ9w8ErX@vger.kernel.org, AJvYcCXRwrHxOQ4JCPLIJB9JMWcSYTP5ysrqXxzkmNfdkm8mKEjeVhDwLWhDKzyIjjOgHAHEkUVeFtJE9UvXSg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwzkWgATOzuYMwoaGPu4Kx0WNIxb0JHWq3p1ZBpHBLCjyGWDule
	LEnIa9f94lyRdMRSLjGSfK9/x+WZRdJ1s1T5UDDae2zyd/UyA6YM
X-Google-Smtp-Source: AGHT+IHqOXJOWHb79RTihzE3on1iV74tjWvNfm3tTmK51dxtJorj4SeUP8Xl+KghIyqpPSU2ZAidYw==
X-Received: by 2002:a05:6512:ba2:b0:533:3223:df91 with SMTP id 2adb3069b0e04-53438773a9emr1245520e87.24.1724405353307;
        Fri, 23 Aug 2024 02:29:13 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5334ea5d9e6sm494618e87.226.2024.08.23.02.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 02:29:12 -0700 (PDT)
Date: Fri, 23 Aug 2024 12:29:09 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Philipp Stanner <pstanner@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>, 
	Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>, 
	Xu Yilun <yilun.xu@intel.com>, Andy Shevchenko <andy@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Alvaro Karsz <alvaro.karsz@solid-run.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Richard Cochran <richardcochran@gmail.com>, 
	Mark Brown <broonie@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Damien Le Moal <dlemoal@kernel.org>, 
	Hannes Reinecke <hare@suse.de>, Chaitanya Kulkarni <kch@nvidia.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-fpga@vger.kernel.org, 
	linux-gpio@vger.kernel.org, netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH v3 6/9] ethernet: stmicro: Simplify PCI devres usage
Message-ID: <6q4pcpyqqt6mhj422pfkgggvwu7jhweu5446y6prcjgjql6xeq@jztt7z4fr6rg>
References: <20240822134744.44919-1-pstanner@redhat.com>
 <20240822134744.44919-7-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822134744.44919-7-pstanner@redhat.com>

Hi Philipp

On Thu, Aug 22, 2024 at 03:47:38PM +0200, Philipp Stanner wrote:
> stmicro uses PCI devres in the wrong way. Resources requested
> through pcim_* functions don't need to be cleaned up manually in the
> remove() callback or in the error unwind path of a probe() function.
> 
> Moreover, there is an unnecessary loop which only requests and ioremaps
> BAR 0, but iterates over all BARs nevertheless.
> 
> Furthermore, pcim_iomap_regions() and pcim_iomap_table() have been
> deprecated by the PCI subsystem in commit e354bb84a4c1 ("PCI: Deprecate
> pcim_iomap_table(), pcim_iomap_regions_request_all()").
> 
> Replace these functions with pcim_iomap_region().
> 
> Remove the unnecessary manual pcim_* cleanup calls.
> 
> Remove the unnecessary loop over all BARs.
> 
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>

Thanks for the series. But please note the network subsystem
dev-process requires to submit the cleanup/feature changes on top of
the net-next tree:
https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/

Just recently a Yanteng' (+cc) series
https://lore.kernel.org/netdev/cover.1723014611.git.siyanteng@loongson.cn/
was merged in which significantly refactored the Loongson MAC driver.
Seeing your patch isn't based on these changes, there is a high
probability that the patch won't get cleanly applied onto the
net-next tree. So please either rebase your patch onto the net-next
tree, or at least merge in the Yanteng' series in your tree and
rebase the patch onto it and let's hope there have been no other
conflicting patches merged in into the net-next tree.

-Serge(y)


> ---
>  .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 25 +++++--------------
>  .../net/ethernet/stmicro/stmmac/stmmac_pci.c  | 18 +++++--------
>  2 files changed, 12 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> index 9e40c28d453a..5d42a9fad672 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> @@ -50,7 +50,7 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
>  	struct plat_stmmacenet_data *plat;
>  	struct stmmac_resources res;
>  	struct device_node *np;
> -	int ret, i, phy_mode;
> +	int ret, phy_mode;
>  
>  	np = dev_of_node(&pdev->dev);
>  
> @@ -88,14 +88,11 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
>  		goto err_put_node;
>  	}
>  
> -	/* Get the base address of device */
> -	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
> -		if (pci_resource_len(pdev, i) == 0)
> -			continue;
> -		ret = pcim_iomap_regions(pdev, BIT(0), pci_name(pdev));
> -		if (ret)
> -			goto err_disable_device;
> -		break;
> +	memset(&res, 0, sizeof(res));
> +	res.addr = pcim_iomap_region(pdev, 0, pci_name(pdev));
> +	if (IS_ERR(res.addr)) {
> +		ret = PTR_ERR(res.addr);
> +		goto err_disable_device;
>  	}
>  
>  	plat->bus_id = of_alias_get_id(np, "ethernet");
> @@ -116,8 +113,6 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
>  
>  	loongson_default_data(plat);
>  	pci_enable_msi(pdev);
> -	memset(&res, 0, sizeof(res));
> -	res.addr = pcim_iomap_table(pdev)[0];
>  
>  	res.irq = of_irq_get_byname(np, "macirq");
>  	if (res.irq < 0) {
> @@ -158,18 +153,10 @@ static void loongson_dwmac_remove(struct pci_dev *pdev)
>  {
>  	struct net_device *ndev = dev_get_drvdata(&pdev->dev);
>  	struct stmmac_priv *priv = netdev_priv(ndev);
> -	int i;
>  
>  	of_node_put(priv->plat->mdio_node);
>  	stmmac_dvr_remove(&pdev->dev);
>  
> -	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
> -		if (pci_resource_len(pdev, i) == 0)
> -			continue;
> -		pcim_iounmap_regions(pdev, BIT(i));
> -		break;
> -	}
> -
>  	pci_disable_msi(pdev);
>  	pci_disable_device(pdev);
>  }
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
> index 352b01678c22..f89a8a54c4e8 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
> @@ -188,11 +188,11 @@ static int stmmac_pci_probe(struct pci_dev *pdev,
>  		return ret;
>  	}
>  
> -	/* Get the base address of device */
> +	/* Request the base address BAR of device */
>  	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
>  		if (pci_resource_len(pdev, i) == 0)
>  			continue;
> -		ret = pcim_iomap_regions(pdev, BIT(i), pci_name(pdev));
> +		ret = pcim_request_region(pdev, i, pci_name(pdev));
>  		if (ret)
>  			return ret;
>  		break;
> @@ -205,7 +205,10 @@ static int stmmac_pci_probe(struct pci_dev *pdev,
>  		return ret;
>  
>  	memset(&res, 0, sizeof(res));
> -	res.addr = pcim_iomap_table(pdev)[i];
> +	/* Get the base address of device */
> +	res.addr = pcim_iomap(pdev, i, 0);
> +	if (!res.addr)
> +		return -ENOMEM;
>  	res.wol_irq = pdev->irq;
>  	res.irq = pdev->irq;
>  
> @@ -231,16 +234,7 @@ static int stmmac_pci_probe(struct pci_dev *pdev,
>   */
>  static void stmmac_pci_remove(struct pci_dev *pdev)
>  {
> -	int i;
> -
>  	stmmac_dvr_remove(&pdev->dev);
> -
> -	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
> -		if (pci_resource_len(pdev, i) == 0)
> -			continue;
> -		pcim_iounmap_regions(pdev, BIT(i));
> -		break;
> -	}
>  }
>  
>  static int __maybe_unused stmmac_pci_suspend(struct device *dev)
> -- 
> 2.46.0
> 
> 

