Return-Path: <linux-pci+bounces-33478-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C90EB1CD46
	for <lists+linux-pci@lfdr.de>; Wed,  6 Aug 2025 22:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7BA1189C9E8
	for <lists+linux-pci@lfdr.de>; Wed,  6 Aug 2025 20:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3407B2BD031;
	Wed,  6 Aug 2025 20:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p+cqOF8I"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0690B21ABC8;
	Wed,  6 Aug 2025 20:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754511138; cv=none; b=EUBGJIPOYU99cjYzdjcP54BCBS5+TGDaPE82/xue8wPFGfPsr/W0bC/pyM2C+eSWnVOdQW41FzRG29mfofTUswMfXkHMB26zKeW7K1ENbGXY8LI0v0MLd/e4KyAyN4ppwdRxALZKjl1+kpCY2nw8eFRHNt4M0yr8Ie1ZrckwR7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754511138; c=relaxed/simple;
	bh=fkBoDOKs7rDeslvfWcbGuJGnft5nUVALkqvQ82Jbjjo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=l3nW7XUUEYkKMF+uokheDBA+FfvsFuZwxFmSppixWBTaJ41oEwSFjzbjbwBFFAe0g8c93bnzaDD0JSA6OL2U//i31fhx04iW9WjCcKMvO3U9NF+tlwAQyhk2UuajoQGa5inv+mQww9i0vlXoIWlBBPQA3obYwF6Oh8siu+I299c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p+cqOF8I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1942C4CEE7;
	Wed,  6 Aug 2025 20:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754511137;
	bh=fkBoDOKs7rDeslvfWcbGuJGnft5nUVALkqvQ82Jbjjo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=p+cqOF8I9C5Wps2k9STftCQnLtO6NBRn/f5TDLgLZGt4VV7+ox7npoHI8f3XGRdgY
	 0eKwKnlTWCW7d1lppSkHb75XaDZjTf2dBGVBX6jaw4N7lkdv5vdn/zxeu+XjMcQ0nz
	 vulDDcpX6WXYgJWo8n7qhfcTyetMOOGhgC0HQur4ewW7SzUJ5yk3tT8OvlTk0HOztQ
	 6L0ea/0ygAxvs+ypfhEb96oSfkeaOeQZdmSdtV8SlTJwlBQZU3HLzmUWhFXWKMRNKR
	 W2njsh1hvHq0ArRCM2rBLdwxSfjG5tQpb3uB9YO8Rc+SAGLS3HG0vaWwHbFxTzwyIH
	 1nEXjnpc1rQTQ==
Date: Wed, 6 Aug 2025 15:12:16 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	linux-pci@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] PCI: cpqphp: move space in debug messages
Message-ID: <20250806201216.GA14834@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250731101036.2167812-1-colin.i.king@gmail.com>

On Thu, Jul 31, 2025 at 11:10:36AM +0100, Colin Ian King wrote:
> The space in a handful of debug messages is in the wrong place, it
> is after a %d and before the \n, move it to be before the %d.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Applied (squashed into previous) to pci/hotplug for v6.18, thanks!

> ---
>  drivers/pci/hotplug/cpqphp_pci.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/cpqphp_pci.c b/drivers/pci/hotplug/cpqphp_pci.c
> index ef7534a3ca40..88929360fe77 100644
> --- a/drivers/pci/hotplug/cpqphp_pci.c
> +++ b/drivers/pci/hotplug/cpqphp_pci.c
> @@ -1302,7 +1302,7 @@ int cpqhp_find_available_resources(struct controller *ctrl, void __iomem *rom_st
>  
>  			dbg("found io_node(base, length) = %x, %x\n",
>  					io_node->base, io_node->length);
> -			dbg("populated slot =%d \n", populated_slot);
> +			dbg("populated slot = %d\n", populated_slot);
>  			if (!populated_slot) {
>  				io_node->next = ctrl->io_head;
>  				ctrl->io_head = io_node;
> @@ -1325,7 +1325,7 @@ int cpqhp_find_available_resources(struct controller *ctrl, void __iomem *rom_st
>  
>  			dbg("found mem_node(base, length) = %x, %x\n",
>  					mem_node->base, mem_node->length);
> -			dbg("populated slot =%d \n", populated_slot);
> +			dbg("populated slot = %d\n", populated_slot);
>  			if (!populated_slot) {
>  				mem_node->next = ctrl->mem_head;
>  				ctrl->mem_head = mem_node;
> @@ -1349,7 +1349,7 @@ int cpqhp_find_available_resources(struct controller *ctrl, void __iomem *rom_st
>  			p_mem_node->length = pre_mem_length << 16;
>  			dbg("found p_mem_node(base, length) = %x, %x\n",
>  					p_mem_node->base, p_mem_node->length);
> -			dbg("populated slot =%d \n", populated_slot);
> +			dbg("populated slot = %d\n", populated_slot);
>  
>  			if (!populated_slot) {
>  				p_mem_node->next = ctrl->p_mem_head;
> @@ -1373,7 +1373,7 @@ int cpqhp_find_available_resources(struct controller *ctrl, void __iomem *rom_st
>  			bus_node->length = max_bus - secondary_bus + 1;
>  			dbg("found bus_node(base, length) = %x, %x\n",
>  					bus_node->base, bus_node->length);
> -			dbg("populated slot =%d \n", populated_slot);
> +			dbg("populated slot = %d\n", populated_slot);
>  			if (!populated_slot) {
>  				bus_node->next = ctrl->bus_head;
>  				ctrl->bus_head = bus_node;
> -- 
> 2.50.0
> 

