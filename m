Return-Path: <linux-pci+bounces-22599-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32386A48BF1
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 23:46:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FC9F188F131
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 22:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D45721CC53;
	Thu, 27 Feb 2025 22:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AAevKaEv"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E826E1AA1E4;
	Thu, 27 Feb 2025 22:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740696350; cv=none; b=GPgCF1yZUEI0AFzbMBU6NB9gOvEpwLqbIi/UEHsjTCrCFflLkJ4VKvO123wc1RUvQM47O9eHvgVm2vDgAjdQMWZeUwZH0jID4JMWFO3eyKkWHSEGjfMoDY0BQOVlOj+ocJ5zlnu+2UPPld9A49tOWigmik5puUrenceGWJ8DB78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740696350; c=relaxed/simple;
	bh=izkk5knDaziivpFQd+Hbzf8lExHq+UqhozbkipxAkoY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=T7oGlQO4E4GEcD3q36ZNYGCFuGLALo8A6JlJBWc7Hgdmart/SJIIA4/92yaBirFQC7K6iwLUiR4JJK5koovR7ZPwLKSf7ncTIsarWmQGr01DNxLKYIMMgWdWP5QmZXIsEhOSFRgjNiXypWLaZcGw09uR9SrtB+rGa0ff60Ok958=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AAevKaEv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42179C4CEDD;
	Thu, 27 Feb 2025 22:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740696349;
	bh=izkk5knDaziivpFQd+Hbzf8lExHq+UqhozbkipxAkoY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=AAevKaEv4QlnBKEzjhX26YUP7oaL6uEnCCjWTQzrna2PMbuUcAC+LNFosWu0NkHOZ
	 ADNlUiW/CHnbDFUgO7y0NpVwKonW8xbJsxAQEbyhw3Xuxo6VqnA2EPjoKfBYeSyh07
	 KpSQfCHibGoYIeuFjzjQ4wQDza2p8YFS4996/wO6ZvKRGYh3aH5A2h8lAZtOw2kpoK
	 ojd4yzQveqWasVWySmW4ayo6hQDTVP6I1yKg1z8CAqVguNjFrfGXfMbcn7tOmuVrT5
	 l6Chqnr+TJ+gtR/0QvTB/wvNRYFDMvIi+SgBuLZPZRsdQPzjGudAVbt6eXS1r67aBy
	 8aCEgyUoqzzpg==
Date: Thu, 27 Feb 2025 16:45:47 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shay Drory <shayd@nvidia.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH] PCI: Fix NULL dereference in SR-IOV VF creation error
 path
Message-ID: <20250227224547.GA22604@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250216083254.38501-1-shayd@nvidia.com>

On Sun, Feb 16, 2025 at 10:32:54AM +0200, Shay Drory wrote:
> Add proper cleanup when virtfn setup fails to prevent NULL pointer
> dereference during device removal. The kernel oops[1] occurred due to
> Incorrect error handling flow when pci_setup_device() fails.
> 
> Fix it by properly cleaning up virtfn resources when pci_setup_device()
> fails, instead of invoking pci_stop_and_remove_bus_device().
> This prevents accessing partially initialized virtfn devices during
> removal.

> Fixes: e3f30d563a38 ("PCI: Make pci_destroy_dev() concurrent safe")

It's not obvious to me how e3f30d563a38 is related.  Can you elucidate
the connection?

> CC: Keith Busch <kbusch@kernel.org>
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> Signed-off-by: Shay Drory <shayd@nvidia.com>
> ---
>  drivers/pci/iov.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index 9e4770cdd4d5..3dfcbf10e127 100644
> --- a/drivers/pci/iov.c
> +++ b/drivers/pci/iov.c
> @@ -314,8 +314,11 @@ int pci_iov_add_virtfn(struct pci_dev *dev, int id)
>  		pci_read_vf_config_common(virtfn);
>  
>  	rc = pci_setup_device(virtfn);
> -	if (rc)
> +	if (rc) {
> +		pci_bus_put(virtfn->bus);
> +		kfree(virtfn);
>  		goto failed1;
> +	}

Thanks for the fix.  The mix of error recovery styles (cleanup here at
the point of falure vs. goto different cleanup steps at the end) makes
this kind of hard to understand.

I see that this cleanup is similar to what's done in
pci_scan_device(), which does help.  Did you consider making a helper
here with structure similar to pci_scan_device(), e.g., a
pci_iov_scan_device()?  I wonder if that could make the error handling
here simpler?

>  	virtfn->dev.parent = dev->dev.parent;
>  	virtfn->multifunction = 0;
> @@ -336,14 +339,15 @@ int pci_iov_add_virtfn(struct pci_dev *dev, int id)
>  	pci_device_add(virtfn, virtfn->bus);
>  	rc = pci_iov_sysfs_link(dev, virtfn, id);
>  	if (rc)
> -		goto failed1;
> +		goto failed2;
>  
>  	pci_bus_add_device(virtfn);
>  
>  	return 0;
>  
> -failed1:
> +failed2:
>  	pci_stop_and_remove_bus_device(virtfn);
> +failed1:
>  	pci_dev_put(dev);
>  failed0:
>  	virtfn_remove_bus(dev->bus, bus);
> -- 
> 2.38.1
> 

