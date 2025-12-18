Return-Path: <linux-pci+bounces-43257-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E3AFFCCAB71
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 08:45:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0A2AA3022878
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 07:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4822E21C17D;
	Thu, 18 Dec 2025 07:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DFgAYlxQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2011E3762;
	Thu, 18 Dec 2025 07:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766043905; cv=none; b=m2CHaUYqjjU7sK++FdOc9UGtJDSAq53Ga6wtgjbKn2MsmScVB6YR8UgvmwZEzFRupfMs2FCIGMjAOUyhUm16i2ML0PrbGHssWC1LH4BqcTGaphid/mQJy57MKIAGOfLflbSi3Pji4DWckyoJeoxZ+Szlqhtx+We0PpGMpRvc19U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766043905; c=relaxed/simple;
	bh=ZKgGcBv2GBC+PoDasOOjrzRtbwHlWEXZ6EQCi1L4KOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bDivmTRIkhb/zxf+aRwwnUldEMggF8eVWV71Q2zBpGo9VPCm52MfSCbPPrAm7A1yaQ5NaHvmNlt0yu7UX/Kd0FkKMgAvsgiRj6oCEdWLG63tqZ1sKI0BhWyT5jubPSCkpsKfmg1Te7lS1ypIXw1YZZJNvyiLOVIPoZMNANhBL9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DFgAYlxQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83E38C4CEFB;
	Thu, 18 Dec 2025 07:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766043904;
	bh=ZKgGcBv2GBC+PoDasOOjrzRtbwHlWEXZ6EQCi1L4KOs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DFgAYlxQ9g7oI/ix95/KhK1foXdipM6e9jPz91WAu2bY8bGdAivTC13c99F6Z6E6T
	 lqdRpCZ/WdN+c7aYcCWrJwL2lYXnXdfE2VKbVcYIMymMNGd5UBqMHt8UtVzkVMum7b
	 cujI8d7Fh3PgZxToY0unIU51/u6RHDNZPKyXOWW7SaPluaqeIow2Lw1jaLSJs9ocqV
	 O3NXd3pU61MjDESzuBRcQ0i3UFLYG06ifZVGGAkRmm3UfBF8O4zbkMzLG2J0zkfs/7
	 lCGRrZ2NBIN0wHiS61THv8cVk5rt3ZiOqr8M02EIrrXGq95UY/HOAjlxiaQgT0Ga3k
	 YcX0iK5hxY1DQ==
Date: Thu, 18 Dec 2025 13:14:51 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Andrea della Porta <andrea.porta@suse.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mbrugger@suse.com, guillaume.gardet@arm.com, tiwai@suse.com, 
	Lizhi Hou <lizhi.hou@amd.com>, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4] PCI: of: Drop error message on missing of_root node
Message-ID: <jry5tvtjxalyuivb7fo3bzgmrgzqrppuumadiwllwiq53zig2m@pndd4pjdtd5v>
References: <20251110112110.10620-1-andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251110112110.10620-1-andrea.porta@suse.com>

On Mon, Nov 10, 2025 at 12:21:10PM +0100, Andrea della Porta wrote:
> When CONFIG_PCI_DYNAMIC_OF_NODES is enabled, an error message
> is generated if no 'of_root' node is defined.
> 
> On DT-based systems, this cannot happen as a root DT node is
> always present.
> On ACPI-based systems that declare an empty root DT node (e.g.
> x86 with CONFIG_OF_EARLY_FLATTREE=y), this also won't happen.
> On platforms where ACPI is mutually exclusive to DT (e.g. ARM)
> the error will be caught (and possibly shown) by drivers that
> rely on the root node.
> 
> Drop the error message altogether.
> 
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>

Acked-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

> ---
> CHANGES in V4:
> - dropped {} from the single line conditional body
> 
> V3: https://lore.kernel.org/all/20251110105415.9584-1-andrea.porta@suse.com/
> ---
>  drivers/pci/of.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index 3579265f1198..c222944eec40 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -774,10 +774,8 @@ void of_pci_make_host_bridge_node(struct pci_host_bridge *bridge)
>  	}
>  
>  	/* Check if there is a DT root node to attach the created node */
> -	if (!of_root) {
> -		pr_err("of_root node is NULL, cannot create PCI host bridge node\n");
> +	if (!of_root)
>  		return;
> -	}
>  
>  	name = kasprintf(GFP_KERNEL, "pci@%x,%x", pci_domain_nr(bridge->bus),
>  			 bridge->bus->number);
> -- 
> 2.35.3
> 

-- 
மணிவண்ணன் சதாசிவம்

