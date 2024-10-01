Return-Path: <linux-pci+bounces-13698-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5479F98C705
	for <lists+linux-pci@lfdr.de>; Tue,  1 Oct 2024 22:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1462F285A92
	for <lists+linux-pci@lfdr.de>; Tue,  1 Oct 2024 20:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5AD1CEAB0;
	Tue,  1 Oct 2024 20:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JHYPWGLC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7632B9A5;
	Tue,  1 Oct 2024 20:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727815826; cv=none; b=AnePauK71VRokex4nmGFQxhI3LLePOUoqJYwz8NkDHEk/1EPnbZ4pkAETsI47fS3OoVJOehYenlvVJ2/FOnoqDgw9K0BAcIGlGWmi9A7xtbMfafH3TAYzAL911lVbTGGzyLm1YXZMbHZqt5nTeu78YTOVsdRY5+4lS1OnYffzB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727815826; c=relaxed/simple;
	bh=RGYD+lSrWpjlxjP9kK31COyuKfnHDtUBJufoN8/YVFU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=entaFdh/s/7hp/wntijNRQESyogljk42xGdQkCH2NGw0aWZWCs5WftaUA/FZZfiqNwRm7VO6YTrIpRUegN0XxH5ZuYEdbqIlLmIxE10Qe5Hz4PAcRMFqXPXx+Ps1J9zf60qUNXFTyM39GuQV+g4osfk7jelPJcYmtveCISWdX1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JHYPWGLC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A03DAC4CEC6;
	Tue,  1 Oct 2024 20:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727815825;
	bh=RGYD+lSrWpjlxjP9kK31COyuKfnHDtUBJufoN8/YVFU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=JHYPWGLCtacTCX2BcsQb7q90MSkzii05Dfh8Cq5u+YDIDgqaVedwhaEeyL3M8MI30
	 p28sN29bBN6tRlA6gfZdw4MhoFvqXx5vnYhp9CUd5J3CKWBeGjv9Icf7Fwd77yHiwJ
	 loc0V4bYyQPCMp42wCZ/vvP1mslzRbrutkIO2JK0ap4M8jUD/NK7jDDn6vJPOoLRYh
	 EprPiCalxX4SNfXvM+QtExV4LLNniwlNHKAvxE+nQy6fo3jBusApSEB+xDqOmg97fC
	 WykpXp/zcdYkU3WoBcp+YSIRlJK1/AkIbzJmcBfdhc77CBMM6g5YKiyEKjlE6EfWW2
	 chBvYnN8nsm8w==
Date: Tue, 1 Oct 2024 15:50:24 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc: linux-pci@vger.kernel.org, rafael@kernel.org, lenb@kernel.org,
	bhelgaas@google.com, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: acpiphp_ampere_altra: Switch back to struct
 platform_driver::remove()
Message-ID: <20241001205024.GA226037@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240927092449.44628-1-sergio.paracuellos@gmail.com>

On Fri, Sep 27, 2024 at 11:24:49AM +0200, Sergio Paracuellos wrote:
> After commit 0edb555a65d1 ("platform: Make platform_driver::remove()
> return void") .remove() is (again) the right callback to implement for
> platform drivers.
> 
> Convert all PCI controller drivers to use .remove(), with the eventual goal
> to drop struct platform_driver::remove_new(). As .remove() and .remove_new()
> have the same prototypes, conversion is done by just changing the structure
> member name in the driver initializer.
> 
> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>

Applied to pci/driver-remove for v6.13, thanks.

I also moved the controller patch to this branch so they're all
together.

> ---
>  drivers/pci/hotplug/acpiphp_ampere_altra.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Hi Bjorn,
> 
> This is the last 'remove_new' inside 'drivers/pci' folder. Since it is
> not in controller I preferred to sent this patch alone.
> 
> Thanks,
>    Sergio Paracuellos
> 
> diff --git a/drivers/pci/hotplug/acpiphp_ampere_altra.c b/drivers/pci/hotplug/acpiphp_ampere_altra.c
> index f5c9e741c1d4..70dbc0431fc6 100644
> --- a/drivers/pci/hotplug/acpiphp_ampere_altra.c
> +++ b/drivers/pci/hotplug/acpiphp_ampere_altra.c
> @@ -119,7 +119,7 @@ static struct platform_driver altra_led_driver = {
>  		.acpi_match_table = altra_led_ids,
>  	},
>  	.probe = altra_led_probe,
> -	.remove_new = altra_led_remove,
> +	.remove = altra_led_remove,
>  };
>  module_platform_driver(altra_led_driver);
>  
> -- 
> 2.25.1
> 

