Return-Path: <linux-pci+bounces-25630-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58FEEA8467C
	for <lists+linux-pci@lfdr.de>; Thu, 10 Apr 2025 16:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A9D9169281
	for <lists+linux-pci@lfdr.de>; Thu, 10 Apr 2025 14:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671EA284B31;
	Thu, 10 Apr 2025 14:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IXY/3B/H"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FA6202F97
	for <linux-pci@vger.kernel.org>; Thu, 10 Apr 2025 14:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744295697; cv=none; b=RNsdZXS9FPcjUykV0/cdI0b4xST232adbB3anumJpYMBfe/MAsJIxr0dQBqSb9k9vXt9HrLVyaN7j0GblqGipp4/KULRIwdPnyhX0MJEVdJkft4reCbTu5DOqIjYGSad9+M+Y4ds8VYNVnuN+XUG03tCd0Gl2D4j+6tuRzebdqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744295697; c=relaxed/simple;
	bh=y/FbEIaObcAdMypgTRXrJ4pwawBjLKceNVNrPI+wt7o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=dANwznxXUCKgF16exlzssi78y1dB8rvm6altWbch2vUeCw0daBSSjaeUVPjFXw7d4klBrNrbTc4AtE4oxGnr8aWqCD0GwbeRj0z0qva5/Bv118MVyJ1Zduq1ToMPtZKAagHFGiRq0I/syYzrfOXiYmQaXJVTES3QsVu75x5p3PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IXY/3B/H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CD41C4CEDD;
	Thu, 10 Apr 2025 14:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744295696;
	bh=y/FbEIaObcAdMypgTRXrJ4pwawBjLKceNVNrPI+wt7o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=IXY/3B/HmkDh2w2wi9FxOaoUxHIDnP/pwPpo2Q1XWe37vkSPtm51PqgARCrdeSfZu
	 9+5HNOyfYst5rAFA15UbX833VradTUA7gvfeM45YUuPgCWxyoBDa4EA4irJXUuVe3t
	 Dlz46bZVWTmTDCHa7SEkMrg7Rjs/Vwdw6dDgjBS7FwFSbcNeslX3bwv3GVs+pbLIdI
	 xP6wmq6dG37mHIff9kHKeL2F/2ZKp8z1kl3siWWl98SNvyHuDRnQK2uY1qtw9aurJg
	 GuRIBhH6eI+jRemTQPV8weDzYhqk7DQ77zLcBYLQKrhaxg8ktL/ooJKyCLqHlu1YNC
	 yhQ9GBUZvme2Q==
Date: Thu, 10 Apr 2025 09:34:55 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI: Remove pci_fixup_cardbus
Message-ID: <20250410143455.GA322129@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8de7da4c-2b16-4ee1-8c42-0d04f3c821c6@gmail.com>

On Wed, Apr 09, 2025 at 10:43:10PM +0200, Heiner Kallweit wrote:
> Since 1c7f4fe86f17 ("powerpc/pci: Remove pcibios_setup_bus_devices()")
> there's no architecture left setting pci_fixup_cardbus. Therefore
> remove support from PCI core.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Great, always nice to remove things, thanks!

Applied to pci/enumeration for v6.16.

> ---
>  drivers/pci/pci.c        | 5 -----
>  drivers/pcmcia/cardbus.c | 1 -
>  include/linux/pci.h      | 3 ---
>  3 files changed, 9 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 4d7c9f64e..c24d6f5a1 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -6806,11 +6806,6 @@ int __weak pci_ext_cfg_avail(void)
>  	return 1;
>  }
>  
> -void __weak pci_fixup_cardbus(struct pci_bus *bus)
> -{
> -}
> -EXPORT_SYMBOL(pci_fixup_cardbus);
> -
>  static int __init pci_setup(char *str)
>  {
>  	while (str) {
> diff --git a/drivers/pcmcia/cardbus.c b/drivers/pcmcia/cardbus.c
> index 45c8252c8..5e5cf2c3e 100644
> --- a/drivers/pcmcia/cardbus.c
> +++ b/drivers/pcmcia/cardbus.c
> @@ -72,7 +72,6 @@ int __ref cb_alloc(struct pcmcia_socket *s)
>  	pci_lock_rescan_remove();
>  
>  	s->functions = pci_scan_slot(bus, PCI_DEVFN(0, 0));
> -	pci_fixup_cardbus(bus);
>  
>  	max = bus->busn_res.start;
>  	for (pass = 0; pass < 2; pass++)
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 0e8e3fd77..d26e6611b 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1139,9 +1139,6 @@ resource_size_t pcibios_align_resource(void *, const struct resource *,
>  				resource_size_t,
>  				resource_size_t);
>  
> -/* Weak but can be overridden by arch */
> -void pci_fixup_cardbus(struct pci_bus *);
> -
>  /* Generic PCI functions used internally */
>  
>  void pcibios_resource_to_bus(struct pci_bus *bus, struct pci_bus_region *region,
> -- 
> 2.49.0
> 

