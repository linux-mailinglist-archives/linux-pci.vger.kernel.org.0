Return-Path: <linux-pci+bounces-3072-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BBDD8490E7
	for <lists+linux-pci@lfdr.de>; Sun,  4 Feb 2024 22:52:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06EB4B22426
	for <lists+linux-pci@lfdr.de>; Sun,  4 Feb 2024 21:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7914B249F7;
	Sun,  4 Feb 2024 21:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IYim0ZDY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834472C68F
	for <linux-pci@vger.kernel.org>; Sun,  4 Feb 2024 21:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707083572; cv=none; b=Gzxm8VbulybUBGMt+WoX6hL1nC/p9hGTa1wGhunV8mBD6IUEEhP1buixf7b8+b235vMfGI0Tjgw+Vj84t2zZQ+chlfFdvATCnvLAnjMd60iGvIoNU5ilyETRkzgegT9YQrfjIzryDLwwBbrS0N1d7RFw0ZYeOJC+XkdUXYcBT2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707083572; c=relaxed/simple;
	bh=2ixbZLaCeZ/ZDlBWbZq8BWjaueHP2Ey7QFL4/SsC9fg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BhefWuiDX+80pV2y8ulttd5gedy/AOGM/HHl2WKc1bm9Ufqe5m4PH9e3s3r2PeXsv6LTiYh6M68jIr5LyYQQm82zw1YOvqSwO21CBEq3+bnlQMY8YX/eL4WHSTiJCIybzHCR216XDl4egNkiAiD5A19DoTThoaw7UowfrPD+IvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IYim0ZDY; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-51109060d6aso5354683e87.2
        for <linux-pci@vger.kernel.org>; Sun, 04 Feb 2024 13:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707083568; x=1707688368; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zuiUj1ce6u5WC8yJYcA2F7eIoP+TpA1trOScy5PHCQM=;
        b=IYim0ZDYJAXj4HjlSuS7Kbiu19NDsurDgMcbL1z0wJWmaqtIIJYyRiZsFTWAgJ7t8G
         /cYgsv+GQQ8IfzlXUlTc2ePK2+bMVUE8y3rgS0867qV8UmAPx/bhf1H+H8gOeEv2L+Hk
         sqp1CJ9gRspt9MDJ3lsMMCQS+pEgmf1T28IanLD4tTUZ9USU64Qpk/7ot8dXok6PmrBq
         4VsVds/X+joH5Qv6bm94od0qshK2hQAFuWHQQwOFZLx5pP1S4JXfFdLX8HD7whlGO9f+
         yV6Ar0Og0Qr4Y9148rZS05jrJiMYPeF2FtyeohFXWFvHrLBFhF0aHri6PSx+iGa/hm9s
         9TuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707083568; x=1707688368;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zuiUj1ce6u5WC8yJYcA2F7eIoP+TpA1trOScy5PHCQM=;
        b=MSfcbSSAUU+bIaf+n4uh2shlAOTarCAwPJKGdAmIfxodyC0wvOElzYvvkzSfjpIiHO
         tNb+tf/WdsJLXuRk/KnhIdou3zp9zQtvm/vAw+6XOiHsleFbzPx3liYthe+EYBGIDIy1
         zfKDdaKbroYwUws0wH/hCbszekfXeKbOnS5oPY56dKJ3Rm1wXEIZe3FiseP7XRDq8WL+
         +SzbLWCUy414FvuWnNKVu4cuU49XWuSa1WyqJDtfdygahqHoRCWMTKV1Uyn9mzcQQ+vp
         GSTNLUgqI+EKfz3HYDpQEAxfVRKMg9AJx8syuAbhIw85YQFviaXOfVwL9b9lkeW3lwCN
         PXNA==
X-Gm-Message-State: AOJu0YzK0JxwmVPuNnHanx0XjhTl7gFulDBz4jsoyTLEb+8LCiRVIXAE
	1cddF3uTveB1CQiR7+/iVPBKWRzPlEPe6z/fD8Q/9aEX2bKTox6GFrYlr6BYIL4=
X-Google-Smtp-Source: AGHT+IGyr9vELnELjAu8Pzpw2/8mY0xvhgqmm/NnA2ZUupNrwCzdgHWMK1XrqbVzUF2sSMmWT8DkOQ==
X-Received: by 2002:a05:6512:3d88:b0:511:4e8f:e21f with SMTP id k8-20020a0565123d8800b005114e8fe21fmr1270283lfv.6.1707083568115;
        Sun, 04 Feb 2024 13:52:48 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWE7jo22+VyArtecjMPdv1YMYsKVXzPbUuPl7Dcf9si/u0T5WnbS5StVIkflUu5XrNMXt8bspmxO2gg+Cmmty2iy3OfweSH9aGdl9jNsUHIY6wWONWtLzxVu9hBJw93+WORyVYsh1YM24gR34fdPFuH+uTny9GuvEbXKC+8rfSZZWijqZr28V/YYvjm6lvsysvlM7EY+bfrqFrpVMUT5kImfjwXSgkw8OHJ6WXlZHQtx4Wua/NXRu/Yrn+Lg0TsECg6IGDL3jSyV1m3P8xXtoYlCiMxJlSui5Vg9olrrH20KVemooAepTzIpEff8vB3y6e+VgIjYQTKgZniSPl9uls9BIcGHg3mvsRqlwbl19x0TPGJBSSSvg1/GX2Fqo0=
Received: from mobilestation ([95.79.203.166])
        by smtp.gmail.com with ESMTPSA id l14-20020ac24a8e000000b005114efca6eesm179843lfp.37.2024.02.04.13.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 13:52:47 -0800 (PST)
Date: Mon, 5 Feb 2024 00:52:45 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Ajay Agarwal <ajayagarwal@google.com>, 
	Robin Murphy <robin.murphy@arm.com>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, 
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>, Manivannan Sadhasivam <mani@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Manu Gautam <manugautam@google.com>, 
	Sajid Dalvi <sdalvi@google.com>, William McVicker <willmcvicker@google.com>, 
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v3] PCI: dwc: Strengthen the MSI address allocation logic
Message-ID: <2kvgqhaitacl7atqf775vr2z3ty5qeqxuv5g3wflkmhgj4yk76@fsmrosfwobfx>
References: <20240204112425.125627-1-ajayagarwal@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240204112425.125627-1-ajayagarwal@google.com>

On Sun, Feb 04, 2024 at 04:54:25PM +0530, Ajay Agarwal wrote:
> There can be platforms that do not use/have 32-bit DMA addresses
> but want to enumerate endpoints which support only 32-bit MSI
> address. The current implementation of 32-bit IOVA allocation can
> fail for such platforms, eventually leading to the probe failure.
> 
> If there vendor driver has already setup the MSI address using
> some mechanism, use the same. This method can be used by the
> platforms described above to support EPs they wish to.
> 
> Else, if the memory region is not reserved, try to allocate a
> 32-bit IOVA. Additionally, if this allocation also fails, attempt
> a 64-bit allocation for probe to be successful. If the 64-bit MSI
> address is allocated, then the EPs supporting 32-bit MSI address
> will not work.
> 
> Signed-off-by: Ajay Agarwal <ajayagarwal@google.com>
> ---
> Changelog since v2:
>  - If the vendor driver has setup the msi_data, use the same
> 
> Changelog since v1:
>  - Use reserved memory, if it exists, to setup the MSI data
>  - Fallback to 64-bit IOVA allocation if 32-bit allocation fails
> 
>  .../pci/controller/dwc/pcie-designware-host.c | 26 ++++++++++++++-----
>  1 file changed, 20 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index d5fc31f8345f..512eb2d6591f 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -374,10 +374,18 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
>  	 * order not to miss MSI TLPs from those devices the MSI target
>  	 * address has to be within the lowest 4GB.
>  	 *

> -	 * Note until there is a better alternative found the reservation is
> -	 * done by allocating from the artificially limited DMA-coherent
> -	 * memory.

Why do you keep deleting this statement? The driver still uses the
DMA-coherent memory as a workaround. Your solution doesn't solve the
problem completely. This is another workaround. One more time: the
correct solution would be to allocate a 32-bit address or some range
within the 4GB PCIe bus memory with no _RAM_ or some other IO behind.
Your solution relies on the platform firmware/glue-driver doing that,
which isn't universally applicable. So please don't drop the comment.

> +	 * Check if the vendor driver has setup the MSI address already. If yes,
> +	 * pick up the same.

This is inferred from the code below. So drop it.

> This will be helpful for platforms that do not
> +	 * use/have 32-bit DMA addresses but want to use endpoints which support
> +	 * only 32-bit MSI address.

Please merge it into the first part of the comment as like: "Permit
the platforms to override the MSI target address if they have a free
PCIe-bus memory specifically reserved for that."

> +	 * Else, if the memory region is not reserved, try to allocate a 32-bit
> +	 * IOVA. Additionally, if this allocation also fails, attempt a 64-bit
> +	 * allocation. If the 64-bit MSI address is allocated, then the EPs
> +	 * supporting 32-bit MSI address will not work.

This is easily inferred from the code below. So drop it.

>  	 */

> +	if (pp->msi_data)

Note this is a physical address for which even zero value might be
valid. In this case it's the address of the PCIe bus space for which
AFAICS zero isn't reserved for something special.

> +		return 0;
> +
>  	ret = dma_set_coherent_mask(dev, DMA_BIT_MASK(32));
>  	if (ret)
>  		dev_warn(dev, "Failed to set DMA mask to 32-bit. Devices with only 32-bit MSI support may not work properly\n");
> @@ -385,9 +393,15 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
>  	msi_vaddr = dmam_alloc_coherent(dev, sizeof(u64), &pp->msi_data,
>  					GFP_KERNEL);
>  	if (!msi_vaddr) {
> -		dev_err(dev, "Failed to alloc and map MSI data\n");
> -		dw_pcie_free_msi(pp);
> -		return -ENOMEM;
> +		dev_warn(dev, "Failed to alloc 32-bit MSI data. Attempting 64-bit now\n");
> +		dma_set_coherent_mask(dev, DMA_BIT_MASK(64));
> +		msi_vaddr = dmam_alloc_coherent(dev, sizeof(u64), &pp->msi_data,
> +						GFP_KERNEL);
> +		if (!msi_vaddr) {
> +			dev_err(dev, "Failed to alloc and map MSI data\n");
> +			dw_pcie_free_msi(pp);
> +			return -ENOMEM;
> +		}

On Tue, Jan 30, 2024 at 08:40:48PM +0000, Robin Murphy wrote:
> Yeah, something like that. Personally I'd still be tempted to try some
> mildly more involved logic to just have a single dev_warn(), but I think
> that's less important than just having something which clearly works.

I guess this can be done but in a bit clumsy way. Like this:

	ret = dma_set_coherent_mask(dev, DMA_BIT_MASK(32)) ||
	      !dmam_alloc_coherent(dev, sizeof(u64), &pp->msi_data, GFP_KERNEL);
	if (ret) {
		dev_warn(dev, "Failed to allocate 32-bit MSI target address\n");

		dma_set_coherent_mask(dev, DMA_BIT_MASK(64));
		ret = !dmam_alloc_coherent(dev, sizeof(u64), &pp->msi_data, GFP_KERNEL);
		if (ret) {
			dev_err(dev, "Failed to allocate MSI target address\n");
			return -ENOMEM;
		}
	}

Not sure whether it's much better than what Ajay suggested but at
least it has a single warning string describing the error, and we can
drop the unused msi_vaddr variable.

-Serge(y)

>  	}
>  
>  	return 0;
> -- 
> 2.43.0.594.gd9cf4e227d-goog
> 

