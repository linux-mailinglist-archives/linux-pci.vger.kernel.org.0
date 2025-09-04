Return-Path: <linux-pci+bounces-35422-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C431DB43119
	for <lists+linux-pci@lfdr.de>; Thu,  4 Sep 2025 06:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BF215E144C
	for <lists+linux-pci@lfdr.de>; Thu,  4 Sep 2025 04:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31AC01F1313;
	Thu,  4 Sep 2025 04:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FQHGUQYe"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096E94437A;
	Thu,  4 Sep 2025 04:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756960181; cv=none; b=JbSy3nqKTkb/0rxULrjqfHDGtqJcLOLR2lZZ8KjbcGYvg19pxk/zZ4I710YjDDm0dhw/4LUPXQ9w/0D5ZrzpLn8dJA2o4duRymjm9VakqEx3fW+3IRQIW/lNb8hcHGwBkXDAdcT/V249K5xzt/sLfPJL1TFBc+qjpmeYvQF2ugw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756960181; c=relaxed/simple;
	bh=KFa9onPVephR8PGCicN6xc6Tz14/6IW8a75/xOowp3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UKPxZX/89JWNz8hYk5ZXeWKi1S+vE5HU8vTYptxeIrzaAPUXAAFTfCX0kCHFeffCIZmwnJjDTBoQDxXcZA3swAzhqNBihOHRpMstNV2p+Ve9JdbRDX6X+tjpwRJrx+9fL1aHrtkgnjlf9OO2RENwDCQJvPVndT8Q7uLG5wvBLEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FQHGUQYe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A021C4CEF0;
	Thu,  4 Sep 2025 04:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756960180;
	bh=KFa9onPVephR8PGCicN6xc6Tz14/6IW8a75/xOowp3s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FQHGUQYefrjRpE3p8AxYollaDC9tlVwEl0FZgz0QbaQKvempYAOsI+N1u+87VuT3A
	 riUjJJ4kWaW/6vF8Qz/shEGlBkWD+MF5tFN1bV+Nw9NHGOK4TyVQ/Amj75zCC/MhLj
	 KOaVuOzixmE8osD0uMtC/TVR1N8F2R/AAsuMxHV3OFgS5B4w9J9Rn5tXO1IJCJGClO
	 y0RyXZTciCCMCEtMephZhczjVwESXgenPn4iwahU3ohYAU+ACIep3kapH2T31t47wb
	 /bbI9RGZZGeK7m3N1auZtdnCt167xvAr2KxaQ0I8kBTFQ4uIq3V/5ohxeTh4JPHQEa
	 VEfYPPzl1PiDA==
Date: Wed, 3 Sep 2025 21:29:40 -0700
From: Kees Cook <kees@kernel.org>
To: Anders Roxell <anders.roxell@linaro.org>
Cc: bhelgaas@google.com, ojeda@kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, arnd@arndb.de,
	dan.carpenter@linaro.org, benjamin.copeland@linaro.org,
	Linux Kernel Functional Testing <lkft@linaro.org>
Subject: Re: [PATCH] drivers/pci: Fix FIELD_PREP compilation error with gcc-8
Message-ID: <202509032125.F41E71AF19@keescook>
References: <20250828101237.1359212-1-anders.roxell@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250828101237.1359212-1-anders.roxell@linaro.org>

On Thu, Aug 28, 2025 at 12:12:37PM +0200, Anders Roxell wrote:
> Commit cbc654d18d37 ("bitops: Add __attribute_const__ to generic
> ffs()-family implementations") causes a compilation failure on ARM
> footbridge_defconfig with gcc-8:
> 
>   FIELD_PREP: value too large for the field
> 
> The error occurs in pcie_set_readrq() at:
>   v = FIELD_PREP(PCI_EXP_DEVCTL_READRQ, ffs(rq) - 8);
> 
> With __attribute_const__, gcc-8 now performs wrong compile-time
> validation in FIELD_PREP and cannot guarantee that ffs(rq) - 8 will
> always produce values that fit in the 3-bit PCI_EXP_DEVCTL_READRQ field.

Thanks for examining this! It seems rather alarming -- why did it
work before?

> Avoid FIELD_PREP entirely by using direct bit manipulation. Replace
> FIELD_PREP(PCI_EXP_DEVCTL_READRQ, ffs(rq) - 8) with the equivalent
> manual bit operations: ((ffs(rq) - 8) << 12) & PCI_EXP_DEVCTL_READRQ.
> 
> This bypasses the compile-time validation while maintaining identical
> runtime behavior and functionality.

Did you dig into why this happened? It seems like a fragile situation,
so I'm worried we'll see more of these pop up.

> Fixes: cbc654d18d37 ("bitops: Add __attribute_const__ to generic ffs()-family implementations")
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Closes: https://lore.kernel.org/linux-pci/CA+G9fYuysVr6qT8bjF6f08WLyCJRG7aXAeSd2F7=zTaHHd7L+Q@mail.gmail.com/T/#u
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>  drivers/pci/pci.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index e698278229f2..9f9607bd9f51 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5893,7 +5893,8 @@ int pcie_set_readrq(struct pci_dev *dev, int rq)
>  			rq = mps;
>  	}
>  
> -	v = FIELD_PREP(PCI_EXP_DEVCTL_READRQ, ffs(rq) - 8);
> +	/* Ideally we would used FIELD_PREP() but this is a work around for gcc-8 */
> +	v = ((ffs(rq) - 8) << 12) & PCI_EXP_DEVCTL_READRQ;
>  
>  	if (bridge->no_inc_mrrs) {
>  		int max_mrrs = pcie_get_readrq(dev);

If you're sure this is okay, I'll take it with the series, but I feel
like we should justify it better. :)

-Kees

-- 
Kees Cook

