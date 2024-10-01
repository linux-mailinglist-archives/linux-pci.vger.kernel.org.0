Return-Path: <linux-pci+bounces-13700-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF4F98C75A
	for <lists+linux-pci@lfdr.de>; Tue,  1 Oct 2024 23:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94D1D285DE6
	for <lists+linux-pci@lfdr.de>; Tue,  1 Oct 2024 21:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9AEC1CCB58;
	Tue,  1 Oct 2024 21:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZM1MnI1E"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05D61C9DF9;
	Tue,  1 Oct 2024 21:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727817064; cv=none; b=Tp/Ip2dMxlJeVOirbsFU0M3maVHwSgeuyVdINxNosTDD2wOX0DHkIUTorIa6fYLXNjWlfLb/lUKp7v0GLQFFvdE1Vq41QERSNYm2NzdjAjyRiJxv/DFZpuLAgdk8L1j5NSJq4c3nk42Gibif1WuALhFGg1CRpULDmmvpRpIJpXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727817064; c=relaxed/simple;
	bh=F3qh3+jNNbxwBTtlg4jow/okHE5IM2NSmhZ1ByaMSzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=lQgJurB7+ALG4PESAj/5Hcc8k4o/7AaBR6zcloq4Md8HDNVotLpqrvCjem7UVbPToffIo2i9d6zAXzSVRnSVax9Nn7ZJbIf6VcfoVrOXiNT/tGqDso+LRUfte9/nf3/OwbZYPJKO6/qNYHBHclNLi4h7IrGN+4GmCvR18W0Mnos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZM1MnI1E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3890C4CEC6;
	Tue,  1 Oct 2024 21:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727817064;
	bh=F3qh3+jNNbxwBTtlg4jow/okHE5IM2NSmhZ1ByaMSzQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ZM1MnI1Ejo1bFmp5NDZLhBBjWTu7FHxjuFpuptalfnBgCOJ/ut10+CRC4GQW+n33d
	 Ye/iK+5VO/udv8R0UaDABN4xSGe9ZLl4DZzRafEdt4MFma7smZr6aX+tyVm2oa21NU
	 d9xWbQnh4DdDoIj9o4onp1avDQDHx6ucW2Sg5HS2uravSBAW+nsopejJCsL3ofhdcR
	 mYFBVGuePR/KTTlSA42vYKxHQIx7rjgUa/2YdtcsKjOBi6m+E1f3NtgsMEhvPAVgjz
	 632Os9UuEon6zq5KtbnAAV5gfPerBG0bNJpMEsQt6hXgpz0I3PMfFWZsBeMXzaY9OZ
	 cu41mCFXEnPDQ==
Date: Tue, 1 Oct 2024 16:11:02 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Konrad Dybcio <konradybcio@kernel.org>
Subject: Re: [PATCH] PCI: take the rescan lock when adding devices during
 host probe
Message-ID: <20241001211102.GA227022@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240926130924.36409-1-brgl@bgdev.pl>

On Thu, Sep 26, 2024 at 03:09:23PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Since adding the PCI power control code, we may end up with a race
> between the pwrctl platform device rescanning the bus and the host
> controller probe function. The latter needs to take the rescan lock when
> adding devices or may crash.
> 
> Reported-by: Konrad Dybcio <konradybcio@kernel.org>
> Fixes: 4565d2652a37 ("PCI/pwrctl: Add PCI power control core code")
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/pci/probe.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 4f68414c3086..f1615805f5b0 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -3105,7 +3105,9 @@ int pci_host_probe(struct pci_host_bridge *bridge)
>  	list_for_each_entry(child, &bus->children, node)
>  		pcie_bus_configure_settings(child);
>  
> +	pci_lock_rescan_remove();
>  	pci_bus_add_devices(bus);
> +	pci_unlock_rescan_remove();

Seems like we do need locking here, but don't we need a more
comprehensive change?  There are many other callers of
pci_bus_add_devices(), and most of them look similarly unprotected.

>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(pci_host_probe);
> -- 
> 2.30.2
> 

