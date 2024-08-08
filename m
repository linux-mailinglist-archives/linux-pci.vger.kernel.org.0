Return-Path: <linux-pci+bounces-11510-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F53694C525
	for <lists+linux-pci@lfdr.de>; Thu,  8 Aug 2024 21:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB638B21A3B
	for <lists+linux-pci@lfdr.de>; Thu,  8 Aug 2024 19:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7059154C15;
	Thu,  8 Aug 2024 19:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dRd1aMA+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EEC41494CE;
	Thu,  8 Aug 2024 19:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723145295; cv=none; b=hYHaAj3zsPtvZ4tDkIcRwMsdiyypmO7a66avWodFFi1LgusZaz8aUKpY9P7lNT95eMRwOud+yIylQFq653NpTSNgPI66dWmQzY2J7+TL0+p8N2hf0ii+W7h+YH77qwP4gY1U3ZIR8ALH4lrzzqmXd8eRNhx1l5y12+qchjudo6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723145295; c=relaxed/simple;
	bh=J1B7g3T24s/rR+CifUK0LhP7Vcus+05wzBpgaieP7hQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=LOYola5z1d556bU18d9SAMXUxixOxEOdyutEdtn9bs/o4w3F38IwOW0vFsphkfIGBOgrJXCnH71PPRgYPpRN6U7UF3x3orjNz1ZdCq7+dROYBjS4sqx89WZTdwXAbX6mQrSoMyWQNiTWHm7/14gToYebXoB9dhb77N3smVD7F4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dRd1aMA+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECA10C32782;
	Thu,  8 Aug 2024 19:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723145295;
	bh=J1B7g3T24s/rR+CifUK0LhP7Vcus+05wzBpgaieP7hQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=dRd1aMA+R4MqsgfY4XbOzavsetIvh2xH4lmu2ryXVujbt0Y68pmAqEmE5AAjX3CM1
	 NV9wEJlrfxaN2NjmNM547oNynueCgwgWftgxKhZYqaNEPYgM/IVuofaS2BcMDwquoy
	 uC2zhOxMSKsKdombT7Ta4fvGAtiBl+ug5GnnYD/aFHfu8TNqZxcNjn3Uh1khI6gnke
	 uJgsrq0mbdulrh92kUsak9CQQy7K+D0xdizcc6HyCTQHIDPlbYr2r0cgMBh/ZSf6+n
	 ipBvxX+OXIJJPG9AyLHYVSTqFEPM2jSllwwBmPU3dlYXTqbtypAAHbMxC5THb2l7/f
	 5xAGpDW+jTDwg==
Date: Thu, 8 Aug 2024 14:28:12 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Stewart Hildebrand <stewart.hildebrand@amd.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/8] PCI: Restore resource alignment
Message-ID: <20240808192812.GA156171@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240807151723.613742-4-stewart.hildebrand@amd.com>

On Wed, Aug 07, 2024 at 11:17:12AM -0400, Stewart Hildebrand wrote:
> Devices with alignment specified will lose their alignment in cases when
> the bridge resources have been released, e.g. due to insufficient bridge
> window size. Restore the alignment.

I guess this fixes a problem when the user has specified
"pci=resource_alignment=..." and we've decided to release and
reallocate a bridge window?  Just looking for a bit more concrete
description of what this problem would look like to a user.

> Signed-off-by: Stewart Hildebrand <stewart.hildebrand@amd.com>
> ---
> v2->v3:
> * no change
> 
> v1->v2:
> * capitalize subject text
> ---
>  drivers/pci/setup-bus.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 23082bc0ca37..ab7510ce6917 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -1594,6 +1594,23 @@ static void __pci_bridge_assign_resources(const struct pci_dev *bridge,
>  	}
>  }
>  
> +static void restore_child_resource_alignment(struct pci_bus *bus)
> +{
> +	struct pci_dev *dev;
> +
> +	list_for_each_entry(dev, &bus->devices, bus_list) {
> +		struct pci_bus *b;
> +
> +		pci_reassigndev_resource_alignment(dev);
> +
> +		b = dev->subordinate;
> +		if (!b)
> +			continue;
> +
> +		restore_child_resource_alignment(b);
> +	}
> +}
> +
>  #define PCI_RES_TYPE_MASK \
>  	(IORESOURCE_IO | IORESOURCE_MEM | IORESOURCE_PREFETCH |\
>  	 IORESOURCE_MEM_64)
> @@ -1648,6 +1665,8 @@ static void pci_bridge_release_resources(struct pci_bus *bus,
>  		r->start = 0;
>  		r->flags = 0;
>  
> +		restore_child_resource_alignment(bus);
> +
>  		/* Avoiding touch the one without PREF */
>  		if (type & IORESOURCE_PREFETCH)
>  			type = IORESOURCE_PREFETCH;
> -- 
> 2.46.0
> 

