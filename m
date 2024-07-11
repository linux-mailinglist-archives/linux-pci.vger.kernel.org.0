Return-Path: <linux-pci+bounces-10179-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ABAD92EF8C
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jul 2024 21:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAC5228381E
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jul 2024 19:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA16012FF7B;
	Thu, 11 Jul 2024 19:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T3lyQIBA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B58450FA
	for <linux-pci@vger.kernel.org>; Thu, 11 Jul 2024 19:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720725674; cv=none; b=IVPdp06nHhOoN+/Q1TNpFOPhGY6fX/sI291tfzUwUTv3ng86z3OOG3wLxJhyRbf8v7ykh/3FVFKvpe3tKQPSVUSwbDaN61OCs3d74T13hMF/iV/fNq/hqfKGC62V60CTOC1rMGzHrbLKAa2KmWIrWw+B3XoyHsfE2KwAdxPUZLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720725674; c=relaxed/simple;
	bh=EpLdOhyWMiohbo5j9HTIOnR1ZNoBS0xknQ6rNxZOYwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L3HGYdumTTOOsnSKIoJU3HGHSI0GQSW07t3YZJUk9yJpxt/wYesdFGyDM3r2rvyAsawE0pGz98QKDwww0EywXyLeB22VrjOR4iGKjt/SzDXXHaVhkU4TBsFNYtdcRV+ZXeVCrTTjaiBhXyl1l3nDBE5gctxFY7lIO39v4FZd7L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T3lyQIBA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9CBEC116B1;
	Thu, 11 Jul 2024 19:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720725674;
	bh=EpLdOhyWMiohbo5j9HTIOnR1ZNoBS0xknQ6rNxZOYwk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T3lyQIBAUpF1pRaS8uP8QDao5hy6wOFuxc7sLT94TqmsfQXGhq8cuaSckUJVxqlU3
	 tFLtrKUhgmtnO4O4a/dnSOugGE+GiCBBgbVfFYQDXYbeKdZoV12HgQXXYCiwVxykGS
	 /ntQNCJsID6wuANCJlDcGclhPUlPb0G9ZcjJ17MKskvIxj3vvCbVdmy54rVav2Xo2d
	 /nETOn4ihQKSoaYWdTAs7r0Jp97jwOrn7X3Svd0NhzW0wLHBdetdBr68ctrA8iyC9W
	 cAV1iKuspF9M19jOOrhafatjZ/5GwahH3j2qGztJtBrCUhbZW9o6DMtwvawrBUixXc
	 WPiKzYnNYm1Xg==
Date: Thu, 11 Jul 2024 13:21:11 -0600
From: Keith Busch <kbusch@kernel.org>
To: Keith Busch <kbusch@meta.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com, kwilczynski@kernel.org,
	Dan Williams <dan.j.williams@intel.com>
Subject: Re: [RESEND PATCH] PCI: fix recursive device locking
Message-ID: <ZpAwp7K3YtZqg2NZ@kbusch-mbp.dhcp.thefacebook.com>
References: <20240709195716.3354637-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709195716.3354637-1-kbusch@meta.com>

On Tue, Jul 09, 2024 at 12:57:16PM -0700, Keith Busch wrote:
> @@ -5488,9 +5488,10 @@ static void pci_bus_lock(struct pci_bus *bus)
>  
>  	pci_dev_lock(bus->self);
>  	list_for_each_entry(dev, &bus->devices, bus_list) {
> -		pci_dev_lock(dev);
>  		if (dev->subordinate)
>  			pci_bus_lock(dev->subordinate);
> +		else
> +			pci_dev_lock(dev);
>  	}
>  }
>  
> @@ -5502,7 +5503,8 @@ static void pci_bus_unlock(struct pci_bus *bus)
>  	list_for_each_entry(dev, &bus->devices, bus_list) {
>  		if (dev->subordinate)
>  			pci_bus_unlock(dev->subordinate);
> -		pci_dev_unlock(dev);
> +		else
> +			pci_dev_unlock(dev);
>  	}
>  	pci_dev_unlock(bus->self);
>  }

I realized pci_slot_lock() has the same problem. I wasn't able to test
that path from not having a pcie topology with a subordinate on the slot
device, but it follows the same pattern. Same thing with
pci_bus_trylock() for that matter, so I will make a new version.

