Return-Path: <linux-pci+bounces-33481-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B19BB1CDFE
	for <lists+linux-pci@lfdr.de>; Wed,  6 Aug 2025 22:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F002518C6C24
	for <lists+linux-pci@lfdr.de>; Wed,  6 Aug 2025 20:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E223D2248AF;
	Wed,  6 Aug 2025 20:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tInrIZuQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B734821A440
	for <linux-pci@vger.kernel.org>; Wed,  6 Aug 2025 20:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754513024; cv=none; b=VE10iy5S4TtiSnusBpROtlxjuaGxdRymzwC4uJloZtxhRTzAQb9EXKn/lmQeqiqHoiBz4KtpZXpeU23irOZDt/mffrnmsR1GHRG9QQkaUI5F4yKZfGl9bUhOLDg8tFZGBxS0vcyqUt+MSrGPQy2AGkezHJH6/UtnDKU/OkDQV0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754513024; c=relaxed/simple;
	bh=2y1jhf0ogqJgkw6mTe5Xe7w+kuS3PeMjSg7W0XEq6Qc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=c9mpssOPNtg0HRF3Kqm00svFpKHB3WhVAtLDz5MU+RC3+S3OdVR/ZhPMOpmWrRLaD1w/5n+3X9eP2OdgqCAk+JilbxRXAqHuxAS/dUIi4q6DRwszqwBfEvUSjRI+JqHSDMj7+KoUVxScf+xfyDMwn1iahMmm3cOrhzf2IvaeG2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tInrIZuQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14F6DC4CEE7;
	Wed,  6 Aug 2025 20:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754513023;
	bh=2y1jhf0ogqJgkw6mTe5Xe7w+kuS3PeMjSg7W0XEq6Qc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=tInrIZuQ4/zenlT3WjyfdeJ1N9qK6NZ0pgCzuKSFJloSdzdrOEaql2Ilt6MegMzKM
	 c3o76Bvh04Elk1bDaVPmSQgqDp3XDOQYBpixS8dCMdzjhHdcxR1tyy+38udOZ0+ZmC
	 q5cHSYOH6bLX9orKpMXNFQlOWy4Pa/gQCq/rCMtOoZCZs+OM8qokKftF5dzLJ5ofNa
	 Yo8deqZssi5PSHta6ToPwsewfoUgttoLYBf5Q4HEFl7AJhZT0AofN65FGYvk5BRw5S
	 nbWZh5rpiRhqef6vHsJGA589POTxPWr2XgQf/cOVggWrx3QgBa2rMNPtxBoExszvRQ
	 C5lTRaa3HYu8A==
Date: Wed, 6 Aug 2025 15:43:41 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Li Jun <lijun01@kylinos.cn>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH] pci: Fix kernel coding style
Message-ID: <20250806204341.GA17141@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250731023326.542847-1-lijun01@kylinos.cn>

On Thu, Jul 31, 2025 at 10:33:26AM +0800, Li Jun wrote:
> These changes just fix Linux Kernel Coding Style, no functuional
> improve.
> 
> -Missing a blank line after declarations
> -space required after that ','
> 
> Signed-off-by: Li Jun <lijun01@kylinos.cn>

Applied to pci/misc for v6.18, thanks.

> ---
>  drivers/pci/setup-bus.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 7853ac6999e2..119f97b96480 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -1402,6 +1402,7 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
>  
>  	list_for_each_entry(dev, &bus->devices, bus_list) {
>  		struct pci_bus *b = dev->subordinate;
> +
>  		if (!b)
>  			continue;
>  
> @@ -1784,6 +1785,7 @@ static void pci_bus_release_bridge_resources(struct pci_bus *bus,
>  
>  	list_for_each_entry(dev, &bus->devices, bus_list) {
>  		struct pci_bus *b = dev->subordinate;
> +
>  		if (!b)
>  			continue;
>  
> @@ -2136,7 +2138,7 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
>  		res = &dev->resource[PCI_BRIDGE_MEM_WINDOW];
>  		align = pci_resource_alignment(dev, res);
>  		resource_set_size(&mmio,
> -				  ALIGN_DOWN_IF_NONZERO(mmio_per_b,align));
> +				  ALIGN_DOWN_IF_NONZERO(mmio_per_b, align));
>  		mmio.start -= resource_size(res);
>  
>  		res = &dev->resource[PCI_BRIDGE_PREF_MEM_WINDOW];
> -- 
> 2.25.1
> 

