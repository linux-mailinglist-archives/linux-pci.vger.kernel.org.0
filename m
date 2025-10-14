Return-Path: <linux-pci+bounces-38085-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE21BDB49B
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 22:39:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1D8DE4E26B2
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 20:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C81305946;
	Tue, 14 Oct 2025 20:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U59UeFU0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B39C3002B4;
	Tue, 14 Oct 2025 20:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760474348; cv=none; b=kY6R8bLrWDhy3Jjqkl/6U0FopyPmh246M0fRVbyLYuvy3ZnTH4L1rVpg58Q8UZBilbXbimjUZvbzPwez6DFafGEQK2PK5gqeBkHzpe7b4CCdjvQapWN1G0O9bzXfO9FkxBgGkTaTOUxnDvRFifspBxs3gwS4kdShY69BAA45+kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760474348; c=relaxed/simple;
	bh=gNKKSJedCDq4VTrEXDr+D3GoIVnPW42kIPJJkae+yU0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=J3JAB0GCEUoRHrDtYJMvDDpg/rVsFlKpbQkMhyweBTSUv7495RhhGPRtR/MT4eYEehNxHDcBXvKNz+EOasWnksziTxjAfVROVWxpRpJZubYiYn1etsnubYsmorjVdQyXYT+d+IVYxTTMEPeJrgnzcw6LaY6tBuWmd9pPqsMyTdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U59UeFU0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA41BC4CEE7;
	Tue, 14 Oct 2025 20:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760474348;
	bh=gNKKSJedCDq4VTrEXDr+D3GoIVnPW42kIPJJkae+yU0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=U59UeFU0TkYuuZ4zmJIHAkrDJ6ps0t8x9ef21SJpvXmgCVQ1htm2ACHffb+NGPnWZ
	 29MNS/kPB70U7X8c7e+o6c+7tyzrKsIHlSY5k3Gjz5/HNkHgUbsr26SWHJWTTopwTN
	 kJR5clRQld7iA+j6ymsz8MNgvZGSMdzs6dGKrgp09cl+WwNDEXqAZqsqnbcLbOk9N0
	 WckHl0XECmQjJpf7hD10a7AFBuvV0ompyUcYXbJBujKX1yviq03V0Nnk54pF2dJoBZ
	 HrQ5RzRgTsDUk5JG+WsthUkK+y1sXFVSz/4p7T+tlCqFgavO+XGGWa1lIU68zMtRPi
	 iec994y/FaTwg==
Date: Tue, 14 Oct 2025 15:39:06 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Val Packett <val@packett.cool>,
	Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH for-linus 1/1] PCI: Revert early bridge resource set up
Message-ID: <20251014203906.GA905971@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251014163602.17138-1-ilpo.jarvinen@linux.intel.com>

On Tue, Oct 14, 2025 at 07:36:02PM +0300, Ilpo Järvinen wrote:
> The commit a43ac325c7cb ("PCI: Set up bridge resources earlier") moved
> bridge window resources set up earlier than before. The change was
> necessary to support another change that got pulled on the last minute
> due to breaking s390 and other systems.
> 
> The presence of valid bridge window resources earlier than before
> allows pci_assign_unassigned_root_bus_resources() call from
> pci_host_probe() assign the bridge windows. Some host bridges, however,
> have to wait first for the link up event before they can enumerate
> successfully (see e.g. qcom_pcie_global_irq_thread()) and thus the bus
> has not been enumerated yet while calling pci_host_probe().
> 
> Calling pci_assign_unassigned_root_bus_resources() without results from
> enumeration can result in sizing bridge windows with too small sizes
> which cannot be later corrected after the enumeration has completed
> because bridge windows have become pinned in place by the other
> resources.
> 
> Interestingly, it seems pci_read_bridge_bases() is not called at all in
> the problematic case and the bridge window resource type setup is done
> by pci_bridge_check_ranges() and sizing by the usual resource fitting
> logic.
> 
> The root problem behind all this looks pretty generic. If resource
> fitting is called too early, the hotplug reservation and old size lower
> bounding cause the bridge windows to be assigned without children but
> with non-zero size, which leads to these pinning problems. As such,
> this can likely be solved on the general level but the solution does
> not look trivial.
> 
> As the commit a43ac325c7cb ("PCI: Set up bridge resources earlier") was
> prequisite for other change that did not end up into kernel yet, revert
> it to resolve the resource assignment failures and give time to code
> and test a generic solution.
> 
> Reported-by: Val Packett <val@packett.cool>
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Fixes: a43ac325c7cb ("PCI: Set up bridge resources earlier")
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Applied to pci/for-linus for v6.18, thanks!

> ---
> 
> This revert should go to for-linus.
> 
> 
> I'm not sure whether Guenter's case is exactly the same problem as
> described in the commit message, I only know for sure his bisection
> landed on the same commit.
> 
> My plan is to retry these changes with more supporting changes. It
> looks PCI core could delay assigning the bridge window resources if
> there are no child resource to put into the bridge windows. Or
> alternatively the resource fitting algorithm could release empty bridge
> windows as the first step. But that is too complicated change to make
> now and would benefit from time spent in -next.
> 
> ---
>  drivers/pci/probe.c | 13 +++----------
>  1 file changed, 3 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index c83e75a0ec12..0ce98e18b5a8 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -538,14 +538,10 @@ static void pci_read_bridge_windows(struct pci_dev *bridge)
>  	}
>  	if (io) {
>  		bridge->io_window = 1;
> -		pci_read_bridge_io(bridge,
> -				   pci_resource_n(bridge, PCI_BRIDGE_IO_WINDOW),
> -				   true);
> +		pci_read_bridge_io(bridge, &res, true);
>  	}
>  
> -	pci_read_bridge_mmio(bridge,
> -			     pci_resource_n(bridge, PCI_BRIDGE_MEM_WINDOW),
> -			     true);
> +	pci_read_bridge_mmio(bridge, &res, true);
>  
>  	/*
>  	 * DECchip 21050 pass 2 errata: the bridge may miss an address
> @@ -583,10 +579,7 @@ static void pci_read_bridge_windows(struct pci_dev *bridge)
>  			bridge->pref_64_window = 1;
>  	}
>  
> -	pci_read_bridge_mmio_pref(bridge,
> -				  pci_resource_n(bridge,
> -						 PCI_BRIDGE_PREF_MEM_WINDOW),
> -				  true);
> +	pci_read_bridge_mmio_pref(bridge, &res, true);
>  }
>  
>  void pci_read_bridge_bases(struct pci_bus *child)
> 
> base-commit: 2f2c7254931f41b5736e3ba12aaa9ac1bbeeeb92
> -- 
> 2.39.5
> 

