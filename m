Return-Path: <linux-pci+bounces-6705-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 151A18B4209
	for <lists+linux-pci@lfdr.de>; Sat, 27 Apr 2024 00:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 850C91F22DC9
	for <lists+linux-pci@lfdr.de>; Fri, 26 Apr 2024 22:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E65B2C6B7;
	Fri, 26 Apr 2024 22:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FX0v2uej"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFBF1DA58;
	Fri, 26 Apr 2024 22:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714169120; cv=none; b=CrGBnu4XTw0/xV16wKMSPHpuFgKhvO6hK4Y9k7HvaMtT3ZiJZcvNVpRp2oHj9oVk0a/ROcoPQEL1O1rD/k8O1Ek4XulPR2WZn7ZeaRv/cM5WBDXgJvcA4OEqd6ptUHlGW0IdsfS0+cSxsWq4wfkT4mLyixO5HM8OKCpQF6cPinU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714169120; c=relaxed/simple;
	bh=VyS48PH4ud8RtFzaXZ3ON83gF15PZu0jVfnp77DittY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=o9PuiF0pfHbDAsE+6LCz2Jr6swX4pHn0CRU3nYDiqlAJstZKE3NY5b82Q6jIBfPeMXoJl04/eFLSU1mrZZzqimR5mhutLLGbF+yhUveeVFxRYw99l2IbK1mf2AqFS0ThyJXUkJ16oyVUX38vEaMY+RVFBm7hSKCU6UbxLdQ35Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FX0v2uej; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E6CBC113CD;
	Fri, 26 Apr 2024 22:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714169119;
	bh=VyS48PH4ud8RtFzaXZ3ON83gF15PZu0jVfnp77DittY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=FX0v2uejd8DLUN0rvJ9OGxQAv4Exdi1srQY658DvzNnrdxp0arbVZO5pyOZCgMJ1V
	 bgGJ1Gp9NAGx/5VJK8shPJF6Bd/W9esIkIWA7MGyZ7OpGl5GOSjFN0OdE4OTSQG04o
	 5zvtrgvLq2dFRIR5vLLFMcUSrh6MzfMVNtoIA4NX8GhVs4zYQrWQt4YxaW+ZRpH0We
	 l+gtupzUi963nqGn14xYFypXRvvRLQqKjAm6e0L554/RWQGy84mWBlQlKcLD4y77dK
	 nFINtvzct0zafhqBHUT6uO5JZzxCXmUP78LFp5ISf8GhAq0GPwKgnqgTMB3+EHbxfU
	 QYYEIIvHeSZFQ==
Date: Fri, 26 Apr 2024 17:05:17 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v1 1/1] PCI/MSI: Make error path handling follow the
 standard pattern
Message-ID: <20240426220517.GA609655@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240426144039.557907-1-andriy.shevchenko@linux.intel.com>

On Fri, Apr 26, 2024 at 05:40:39PM +0300, Andy Shevchenko wrote:
> Make error path handling follow the standard pattern, i.e.
> checking for errors first. This makes code much more easier
> to read and understand despite being a bit longer.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied to pci/msi for v6.10, thanks!

I like this style much better too.

> ---
>  drivers/pci/msi/msi.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
> index 682fa877478f..c5625dd9bf49 100644
> --- a/drivers/pci/msi/msi.c
> +++ b/drivers/pci/msi/msi.c
> @@ -86,9 +86,11 @@ static int pcim_setup_msi_release(struct pci_dev *dev)
>  		return 0;
>  
>  	ret = devm_add_action(&dev->dev, pcim_msi_release, dev);
> -	if (!ret)
> -		dev->is_msi_managed = true;
> -	return ret;
> +	if (ret)
> +		return ret;
> +
> +	dev->is_msi_managed = true;
> +	return 0;
>  }
>  
>  /*
> @@ -99,9 +101,10 @@ static int pci_setup_msi_context(struct pci_dev *dev)
>  {
>  	int ret = msi_setup_device_data(&dev->dev);
>  
> -	if (!ret)
> -		ret = pcim_setup_msi_release(dev);
> -	return ret;
> +	if (ret)
> +		return ret;
> +
> +	return pcim_setup_msi_release(dev);
>  }
>  
>  /*
> -- 
> 2.43.0.rc1.1336.g36b5255a03ac
> 

