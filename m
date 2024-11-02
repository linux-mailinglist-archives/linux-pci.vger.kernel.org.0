Return-Path: <linux-pci+bounces-15827-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD6AB9B9F34
	for <lists+linux-pci@lfdr.de>; Sat,  2 Nov 2024 12:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BF8B282051
	for <lists+linux-pci@lfdr.de>; Sat,  2 Nov 2024 11:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC3217166E;
	Sat,  2 Nov 2024 11:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HicdufcC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B091714A8
	for <linux-pci@vger.kernel.org>; Sat,  2 Nov 2024 11:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730545823; cv=none; b=eUOcLUE13AGoemObps37ytmgdrViuVlskXa8iBRxxRKe27wR7XxlDamT24hDvNGDneIotoNDt0rslcMwDF8e8vu8J0SjKs4X5+uaZs7xZNZ0goPCmuVZTN7LzQSTUY0aHpkjow0ZOFJsrFAEVMNA0yTnz/YCnBM7xMh91QFRxnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730545823; c=relaxed/simple;
	bh=QEAiKRBMfn7T9b+p0OODMxOHepiSst1T6MSvaThvpf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gl6eKmTq3SarnouwMLclD1i4Lg0wDyvRiZvC1yDxRZJa1jTPC/odrtscZvHagBjrxtanv9T3sG6i1JD+ZqhyGRqmr/dyPEi0wpzl5rCaQcrwrUcyIm9MvA8HLpH6Q2BxWWoZUBj832bz9Oakz9R8VbySwtm7gwWMZNjUaPMYbAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HicdufcC; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7206304f93aso2615615b3a.0
        for <linux-pci@vger.kernel.org>; Sat, 02 Nov 2024 04:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730545821; x=1731150621; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=I4eYqgILgGSnZ5FLX7em889/Olts11sj6lSUSFxZMLE=;
        b=HicdufcCl6+TlyoWCBxRnzf3HuuZD+7d6jcGFY/GvZpM2X5hDCOzsGhH/sGx9ErMtD
         jqXn/dARnZadFUGaRM0/vfS+Z13Qqgluy21nguPCVRFb+3QgRVWgtbGIdE7Dl8h/nNt0
         uZrvrEfG6eVeMP3v2oSrbYj9ZGINfS6YpcTspv/3feOmqvTIzfwg90limkJRXHUN4DVn
         0kkYujS4b1aLChy+awJKJrvvCNy5dWBqBbtYwt0nZMfaEwFlVXufCE4dC9VIzWShXlUN
         HdyBQBPXHWn6140nbP9npWkL88eNbbsgDVpBBf7tCZgdDYzhA1puYU6+jvwL1CAfiOBN
         2blw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730545821; x=1731150621;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I4eYqgILgGSnZ5FLX7em889/Olts11sj6lSUSFxZMLE=;
        b=PWLvju+ffMiGJTvcqLBOaqDa63TSbkpSyn11ZAvlfl4k8HyFUYz3KYUH5LoX5UN2WU
         zKq2Q95DkFB5yqH0GQCzB1Q9+8CdMlTVO+ALGZ3cnbBdWZUCGFqSuNKp1sNpd7U3BIqk
         iv0ZwtZDuiKAlSQpX1bRfzlWos33aExRK5dBh4xEkWiDVKFqaMHYZVOgV4j+Gd6nrgVf
         MfR8jTYBjg1FjK+VAK+jvaGwM+5Zpqkf4kur6QGWKrgOJx8T0OIiApQ8gcyhYfSr+oDW
         9PA42c/C0D6wZXTetlFu8gB/x9kqniLaGmjsmYo3M/ex28srqEvEsu3s0j+nYYyzQIJ/
         s5sg==
X-Forwarded-Encrypted: i=1; AJvYcCUi83JrlgX9QK+oqnR8e0ffTRu7boNT7bvQsiq708Kua24eiu/0Lno6d1IDimYdWsL4qO3ZGCfYEyE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjWUEdsMaeoeqpyEX+Sl3sNv9e8Fmg3y0v/uAvGNCbTlhIpmbH
	RLpWyqtUWidHfjTjTvXHBTWSk60S7noBduRwe6S+8cb1OA/LNBJMpDkIcwuWGg==
X-Google-Smtp-Source: AGHT+IGvVFzOTXxhTUFUGXA3i4FKFopxjY5r8HjaLCxA6VY9mqL2l28HzoYyqMuyQIGfn5uqAD5pRQ==
X-Received: by 2002:a05:6a00:a29:b0:71e:c0c:5996 with SMTP id d2e1a72fcca58-720c98ca200mr8339080b3a.7.1730545821219;
        Sat, 02 Nov 2024 04:10:21 -0700 (PDT)
Received: from thinkpad ([220.158.156.192])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc2f17fasm3968608b3a.180.2024.11.02.04.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Nov 2024 04:10:20 -0700 (PDT)
Date: Sat, 2 Nov 2024 16:40:12 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, alyssa@rosenzweig.io, bpf@vger.kernel.org,
	broonie@kernel.org, jgg@ziepe.ca, joro@8bytes.org,
	lgirdwood@gmail.com, maz@kernel.org, p.zabel@pengutronix.de,
	robin.murphy@arm.com, will@kernel.org
Subject: Re: [PATCH v3 1/2] PCI: Add enable_device() and disable_device()
 callbacks for bridges
Message-ID: <20241102111012.23zwz4et2qkafyca@thinkpad>
References: <20241024-imx95_lut-v3-0-7509c9bbab86@nxp.com>
 <20241024-imx95_lut-v3-1-7509c9bbab86@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241024-imx95_lut-v3-1-7509c9bbab86@nxp.com>

On Thu, Oct 24, 2024 at 06:34:44PM -0400, Frank Li wrote:
> Some PCIe host bridges require special handling when enabling or disabling
> PCIe Endpoints. For example, the i.MX95 platform has a lookup table to map
> Requester IDs to StreamIDs, which are used by the SMMU and MSI controller
> to identify the source of DMA accesses.
> 
> Without this mapping, DMA accesses may target unintended memory, which
> would corrupt memory or read the wrong data.
> 
> Add a host bridge .enable_device() hook the imx6 driver can use to
> configure the Requester ID to StreamID mapping. The hardware table isn't
> big enough to map all possible Requester IDs, so this hook may fail if no
> table space is available. In that case, return failure from
> pci_enable_device().
> 
> It might make more sense to make pci_set_master() decline to enable bus
> mastering and return failure, but it currently doesn't have a way to return
> failure.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Change from v2 to v3
> - use Bjorn suggest's commit message.
> - call disable_device() when error happen.
> 
> Change from v1 to v2
> - move enable(disable)device ops to pci_host_bridge
> ---
>  drivers/pci/pci.c   | 23 ++++++++++++++++++++++-
>  include/linux/pci.h |  2 ++
>  2 files changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 7d85c04fbba2a..5e0cb9b6f4d4f 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -2056,6 +2056,7 @@ int __weak pcibios_enable_device(struct pci_dev *dev, int bars)
>  static int do_pci_enable_device(struct pci_dev *dev, int bars)
>  {
>  	int err;
> +	struct pci_host_bridge *host_bridge;
>  	struct pci_dev *bridge;
>  	u16 cmd;
>  	u8 pin;
> @@ -2068,9 +2069,16 @@ static int do_pci_enable_device(struct pci_dev *dev, int bars)
>  	if (bridge)
>  		pcie_aspm_powersave_config_link(bridge);
>  
> +	host_bridge = pci_find_host_bridge(dev->bus);
> +	if (host_bridge && host_bridge->enable_device) {
> +		err = host_bridge->enable_device(host_bridge, dev);
> +		if (err)
> +			return err;
> +	}

How about wrapping the enable/disable part in a helper?

	int pci_host_bridge_enable_device(dev);
	void pci_host_bridge_disable_device(dev);

The definition could be placed in drivers/pci/pci.h as an inline function.

- Mani

> +
>  	err = pcibios_enable_device(dev, bars);
>  	if (err < 0)
> -		return err;
> +		goto err_enable;
>  	pci_fixup_device(pci_fixup_enable, dev);
>  
>  	if (dev->msi_enabled || dev->msix_enabled)
> @@ -2085,6 +2093,13 @@ static int do_pci_enable_device(struct pci_dev *dev, int bars)
>  	}
>  
>  	return 0;
> +
> +err_enable:
> +	if (host_bridge && host_bridge->disable_device)
> +		 host_bridge->disable_device(host_bridge, dev);
> +
> +	return err;
> +
>  }
>  
>  /**
> @@ -2262,12 +2277,18 @@ void pci_disable_enabled_device(struct pci_dev *dev)
>   */
>  void pci_disable_device(struct pci_dev *dev)
>  {
> +	struct pci_host_bridge *host_bridge;
> +
>  	dev_WARN_ONCE(&dev->dev, atomic_read(&dev->enable_cnt) <= 0,
>  		      "disabling already-disabled device");
>  
>  	if (atomic_dec_return(&dev->enable_cnt) != 0)
>  		return;
>  
> +	host_bridge = pci_find_host_bridge(dev->bus);
> +	if (host_bridge && host_bridge->disable_device)
> +		host_bridge->disable_device(host_bridge, dev);
> +
>  	do_pci_disable_device(dev);
>  
>  	dev->is_busmaster = 0;
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 573b4c4c2be61..ac15b02e14ddd 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -578,6 +578,8 @@ struct pci_host_bridge {
>  	u8 (*swizzle_irq)(struct pci_dev *, u8 *); /* Platform IRQ swizzler */
>  	int (*map_irq)(const struct pci_dev *, u8, u8);
>  	void (*release_fn)(struct pci_host_bridge *);
> +	int (*enable_device)(struct pci_host_bridge *bridge, struct pci_dev *dev);
> +	void (*disable_device)(struct pci_host_bridge *bridge, struct pci_dev *dev);
>  	void		*release_data;
>  	unsigned int	ignore_reset_delay:1;	/* For entire hierarchy */
>  	unsigned int	no_ext_tags:1;		/* No Extended Tags */
> 
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

