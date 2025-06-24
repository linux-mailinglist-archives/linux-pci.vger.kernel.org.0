Return-Path: <linux-pci+bounces-30484-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B6C6AE5FD3
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 10:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 124ED7AC9F4
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 08:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE529279357;
	Tue, 24 Jun 2025 08:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m1l/IGIF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA42025D201
	for <linux-pci@vger.kernel.org>; Tue, 24 Jun 2025 08:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750754821; cv=none; b=O7widtsNbWu6DaelzoDe/XihW/9Q3Xdtq+avEMWJrND7ruJiun28ZA0qaUaEInAtk75VNyqOifVl4GIThGT0krE/CG+TJQyz9RMgudDA+u+nq+K7vTp7wc+rltBMFhHLQRS7xj0IuH1XizLjkzXegDS0zhyMq+GpXuCx/gqhLlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750754821; c=relaxed/simple;
	bh=sk99YcymbIDU19hq8yXmjqecjjp1A89+tlm6gAQgGH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gmrsw01FE7auG2CIvNtr8Qmutfp8Y/5vdU4bHZr9cdjeiJgU/vW+gWfKVTK73nrWtPqgIeph3o4/KdKCb9BAkC3+jtaZMtAJitLnXR7bOH8zwmm5GUWiisCMANhx0u4w8HLXE1ZHjCtaN2nkstGqCYhQ/YcfMb6RIvAahjFTXnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m1l/IGIF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0869C4CEE3;
	Tue, 24 Jun 2025 08:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750754821;
	bh=sk99YcymbIDU19hq8yXmjqecjjp1A89+tlm6gAQgGH0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m1l/IGIFur09LbrENEiSXp+yRgP2dqYvAtNRdjv7/3LacgwqItYRniMP8/xWq+jdb
	 G/mWb32kRFU5mL7GiuL/5c8M3Y5pDf1Hd56GIca9GETux12zD0LFopuOnJRNrolIn9
	 Dwm3urw/VGWCJrqOCtCu2ZWhUgM59CJfjhauV7TV08ccpDsfqLtoqLWUg+6L/cLTmG
	 PHrhMSBcEHJZBZvGsXoiz8iHlLod6iNn4yNDJWSqFe86gqF2w0LJucsghtqnJQ+1Es
	 HJG0Lb8lnTSO/d9xi0wowqhPLi8TMyxes5Vkf03DYFH6scpJnOPbW4DkZS+mewvNWX
	 4PWzYkgvnS9lw==
Date: Tue, 24 Jun 2025 10:46:57 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-pci@vger.kernel.org, Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 2/2] PCI: endpoint: Fix configfs group removal on
 driver teardown
Message-ID: <aFpmAXWSx0zlDkkQ@ryzen>
References: <20250624081949.289664-1-dlemoal@kernel.org>
 <20250624081949.289664-3-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624081949.289664-3-dlemoal@kernel.org>

On Tue, Jun 24, 2025 at 05:19:49PM +0900, Damien Le Moal wrote:
> An endpoint driver configfs attributes group is added to the
> epf_group list of struct pci_epf_driver by pci_epf_add_cfs() but an
> added group is not removed from this list when the attribute group is
> unregistered with pci_ep_cfs_remove_epf_group().
> 
> Add the missing list_del_init() call in fpci_ep_cfs_remove_epf_group()
> to correctly remove the attribute group from the driver list.
> 
> With this change, once the loop over all attribute groups in
> pci_epf_remove_cfs() completes, the driver epf_group list should be
> empty. Add a WARN_ON() to make sure of that.
> 
> Fixes: ef1433f717a2 ("PCI: endpoint: Create configfs entry for each pci_epf_device_id table entry")
> Cc: stable@vger.kernel.org
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>  drivers/pci/endpoint/pci-ep-cfs.c   | 1 +
>  drivers/pci/endpoint/pci-epf-core.c | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/endpoint/pci-ep-cfs.c b/drivers/pci/endpoint/pci-ep-cfs.c
> index d712c7a866d2..63876537e7dc 100644
> --- a/drivers/pci/endpoint/pci-ep-cfs.c
> +++ b/drivers/pci/endpoint/pci-ep-cfs.c
> @@ -691,6 +691,7 @@ void pci_ep_cfs_remove_epf_group(struct config_group *group)
>  	if (IS_ERR_OR_NULL(group))
>  		return;
>  
> +	list_del_init(&group->group_entry);

Nit: I think this can be a list_del() since configfs_unregister_default_group()
will call kfree() on 'group', so there should be no need to set the next and
prev pointers of the removed entry itself to NULL.


>  	configfs_unregister_default_group(group);
>  }
>  EXPORT_SYMBOL(pci_ep_cfs_remove_epf_group);
> diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
> index defc6aecfdef..167dc6ee63f7 100644
> --- a/drivers/pci/endpoint/pci-epf-core.c
> +++ b/drivers/pci/endpoint/pci-epf-core.c
> @@ -338,6 +338,7 @@ static void pci_epf_remove_cfs(struct pci_epf_driver *driver)
>  	mutex_lock(&pci_epf_mutex);
>  	list_for_each_entry_safe(group, tmp, &driver->epf_group, group_entry)
>  		pci_ep_cfs_remove_epf_group(group);
> +	WARN_ON(!list_empty(&driver->epf_group));
>  	mutex_unlock(&pci_epf_mutex);
>  }
>  
> -- 
> 2.49.0
> 

Reviewed-by: Niklas Cassel <cassel@kernel.org>

