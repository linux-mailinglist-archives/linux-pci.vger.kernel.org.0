Return-Path: <linux-pci+bounces-21314-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D97CA33251
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2025 23:18:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 211AE3A181A
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2025 22:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9D81FF1D6;
	Wed, 12 Feb 2025 22:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M7zrqNK0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60FB190470;
	Wed, 12 Feb 2025 22:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739398732; cv=none; b=L41gOSsQMw4I0HTV8uWb5JQWs6Dv8NjgslctdSpTZfAtJ0RMOU9rm7qabNIfDFuxWX+8hOv6g6CKIEr9DCHHxm17MtKa95AgGsTH1dpqAlbEtnRV/Up7tHgeoXn8dDqG9xCBa6MCPPzv5qdszan4hTyrfad1VvkRgFEbptYIcXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739398732; c=relaxed/simple;
	bh=52RdHhpb+l5jkCHj2GRlvoKj3szd4BEOiqrYg3TgLQg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=fbX/CcCB/hQckLxrAd3mvWaSKgffHCxwD0ZG4Q3cgYuFIIsAleYYM77MyvndCO9r95EfyREibgTUkCzpSlpWcP4s4cvg8qnckwzcok9lDqmTejld6WTUNzG5zAjw2g3w9WHCDp3tgXceNpJgO71K8AuvS5qLIau0NJtxm7NL/a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M7zrqNK0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 236DFC4CEDF;
	Wed, 12 Feb 2025 22:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739398731;
	bh=52RdHhpb+l5jkCHj2GRlvoKj3szd4BEOiqrYg3TgLQg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=M7zrqNK0MnPZbfFxObAZk5g/QPd8/E1ZL4/LnpU7IgIcfIdF+fD4Jv4d3+AkI2L6j
	 6ygTuGI8GgScKOcvkvRV1IvUq94fIHFb73hCtb+idiYGfPRFCOMuKtSmSTxKpzlKwr
	 OxwbC8htLUGoTZzeMyKfEgEzya0xFIym196oR2iNrPcRPU2aiZfY6MEfxOTN7H7qVA
	 eQ0k363EkhKNZbe47dtqWCdwqxxMvC5/WYRDNo9Z2vchZwgKkkJ8VA7/mo8DoqW89C
	 MyX5sTz0hi5liI1UnVOeRU6af09ckCqkg25ZQ46NMSI6Mv1GaPvjg/6S/MwQJheZST
	 aJyjM9N0VQ/lQ==
Date: Wed, 12 Feb 2025 16:18:49 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, mitchell.augustin@canonical.com,
	ilpo.jarvinen@linux.intel.com, david.laight.linux@gmail.com,
	Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH v2] PCI: Fix BUILD_BUG_ON usage for old gcc
Message-ID: <20250212221849.GA93700@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212185337.293023-1-alex.williamson@redhat.com>

On Wed, Feb 12, 2025 at 11:53:32AM -0700, Alex Williamson wrote:
> As reported in the below link, it seems older versions of gcc cannot
> determine that the howmany variable is known for all callers.  Include
> a test so that newer compilers can enforce this sanity check and older
> compilers can still work.  Add __always_inline attribute to give the
> compiler an even better chance to know the inputs.
> 
> Fixes: 4453f360862e ("PCI: Batch BAR sizing operations")
> Link: https://lore.kernel.org/all/20250209154512.GA18688@redhat.com
> Reported-by: Oleg Nesterov <oleg@redhat.com>
> Tested-by: Oleg Nesterov <oleg@redhat.com>
> Tested-by: Mitchell Augustin <mitchell.augustin@canonical.com>
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>

Applied to pci/for-linus for v6.14 since this fixes a build issue we
added in v6.14-rc1, thanks, Alex.

> ---
> 
> v2:
>  - Switch to statically_true (David Laight)
>  - Add __always_inline (David Laight)
>  - Included Tested-by reports
> 
>  drivers/pci/probe.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index b6536ed599c3..246744d8d268 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -339,13 +339,14 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
>  	return (res->flags & IORESOURCE_MEM_64) ? 1 : 0;
>  }
>  
> -static void pci_read_bases(struct pci_dev *dev, unsigned int howmany, int rom)
> +static __always_inline void pci_read_bases(struct pci_dev *dev,
> +					   unsigned int howmany, int rom)
>  {
>  	u32 rombar, stdbars[PCI_STD_NUM_BARS];
>  	unsigned int pos, reg;
>  	u16 orig_cmd;
>  
> -	BUILD_BUG_ON(howmany > PCI_STD_NUM_BARS);
> +	BUILD_BUG_ON(statically_true(howmany > PCI_STD_NUM_BARS));
>  
>  	if (dev->non_compliant_bars)
>  		return;
> -- 
> 2.48.1
> 

