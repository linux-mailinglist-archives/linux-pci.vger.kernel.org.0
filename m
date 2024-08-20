Return-Path: <linux-pci+bounces-11906-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA4895913F
	for <lists+linux-pci@lfdr.de>; Wed, 21 Aug 2024 01:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11D32B214C2
	for <lists+linux-pci@lfdr.de>; Tue, 20 Aug 2024 23:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC1391C0DCA;
	Tue, 20 Aug 2024 23:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cO++ETYR"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DA315749C
	for <linux-pci@vger.kernel.org>; Tue, 20 Aug 2024 23:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724196989; cv=none; b=u7f+N+gAQeLu4PhDr0J/KJn9xoXqEnakf5SLXTD+76Le6chxy1+rhYLERa8Ucyph6TYVt4SDTTZuKmEaBsSbu7x3Td8YQ4zUIaZ+UG3bWSXW2iDbZmWgcIGMZjRo6LRcbHTzJ8IegGQQ55uhO24Xs9kQ+Z5sbsMdkja2hLaVZIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724196989; c=relaxed/simple;
	bh=nrxYC7MYBVP6yrkmuQ56vm+idk6HmQgqPynfey76LrU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=urpbA6e0u8pUANytjzHhV/sOOskA2t5g2VYCiJV6y2UQtet/pvTyR0IblLx1lQ2IIwSgEDg36kWn0wqQ+gWyYd95DIMbTyYYoVHkMi3ZUsH0BiUn0GjTZ8D6uQ6wtST0nVCk3Vi0mVgJ/RYPf3hgKKl5PxWh4/F0lxsQie4USrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cO++ETYR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0D10C4AF0B;
	Tue, 20 Aug 2024 23:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724196989;
	bh=nrxYC7MYBVP6yrkmuQ56vm+idk6HmQgqPynfey76LrU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=cO++ETYR15YwZzx0BJOQZsCJswFuu1i9pjc5E2ptrQGL7vjDiXv6UkpdPva/YFpqa
	 tMjz9DfLmu4rGWmnM3qVCbXMxdC8FueGu0VovJL4deuX0aWc4vQOSAfBCihO+UI7fL
	 JAj3aDPbx3wZHHCv4ZdEJc6kEvz0hmfp3CkCioPXjGjcUvRnbWxxhpfRT5xKUAcLYX
	 LHsfMhSiRjZBxjoQnxWZ4sYRU1TatS9aUle/Pf+HoeeaLNifBrEIP1a36L0KlU32wC
	 sgc8y6sqIVwgkhHYJmeKglwQxu+++76H6xk+B81QKnWj+WUtjKdr+oHhA9OcizAOrU
	 L3VBOahH3aq1A==
Date: Tue, 20 Aug 2024 18:36:27 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH] x86/PCI: Fix Null pointer dereference after call to
 pcie_find_root_port()
Message-ID: <20240820233627.GA230972@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812202659.1649121-1-samasth.norway.ananda@oracle.com>

On Mon, Aug 12, 2024 at 01:26:59PM -0700, Samasth Norway Ananda wrote:
> If pcie_find_root_port() is unable to locate a root port, it will return
> NULL. This NULL pointer needs to be handled before trying to dereference.
> 
> Fixes: 7d08f21f8c63 ("x86/PCI: Avoid PME from D3hot/D3cold for AMD Rembrandt and Phoenix USB4")
> Signed-off-by: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>

Applied with Mario's Reviewed-by to pci/misc for v6.12, thank you!

> ---
>  arch/x86/pci/fixup.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
> index b33afb240601..98a9bb92d75c 100644
> --- a/arch/x86/pci/fixup.c
> +++ b/arch/x86/pci/fixup.c
> @@ -980,7 +980,7 @@ static void amd_rp_pme_suspend(struct pci_dev *dev)
>  		return;
>  
>  	rp = pcie_find_root_port(dev);
> -	if (!rp->pm_cap)
> +	if (!rp || !rp->pm_cap)
>  		return;
>  
>  	rp->pme_support &= ~((PCI_PM_CAP_PME_D3hot|PCI_PM_CAP_PME_D3cold) >>
> @@ -994,7 +994,7 @@ static void amd_rp_pme_resume(struct pci_dev *dev)
>  	u16 pmc;
>  
>  	rp = pcie_find_root_port(dev);
> -	if (!rp->pm_cap)
> +	if (!rp || !rp->pm_cap)
>  		return;
>  
>  	pci_read_config_word(rp, rp->pm_cap + PCI_PM_PMC, &pmc);
> -- 
> 2.45.2
> 

