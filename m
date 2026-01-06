Return-Path: <linux-pci+bounces-44095-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 51837CF8373
	for <lists+linux-pci@lfdr.de>; Tue, 06 Jan 2026 13:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9E736304F2C7
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jan 2026 12:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5944A327C19;
	Tue,  6 Jan 2026 12:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="wK34FX6C"
X-Original-To: linux-pci@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D25322FDFF;
	Tue,  6 Jan 2026 12:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767701142; cv=none; b=ESuN5a3+8oAnmZ0Rjy52uLbmRX1dDwUpu94NClLLwrqvd+sj8FqSOkO4KOgem5fkFVjSJBdbVwHIBVi6WXeVkW+hZx4CRiujHcQ5f3wwZFOoAXI0YM5fXyxTHCC1SFZEKxVB7Jit5qTh5acXeB8Ne3twOpsSHGCwDk54K9BYHYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767701142; c=relaxed/simple;
	bh=O3H+0yw1sQpl5rfJ+NLCqvTl4Lgj70HibLqhNrFko+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uK5tTupwiFcAXvNa4sqoVpiZi/D1KrTVm3MdgpNyCbYiAS2xr8EiqfdjfqwqY4+L0uHtl1bN/FWe50mR2Au+I7kEyRqoDEqlYouWGe3OozxiSuKn/im2/C2etegdlnMW5g2V4FSBuU2fhQd/fRbBC15rwzKQ8T9yXu70Iu5CAcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=wK34FX6C; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:Reply-To:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=gsG6P3zWly8vLTuESt9EJZDFaR2Os0q+VjdE1w7JWd0=;
	t=1767701140; x=1768133140; b=wK34FX6C96G+AEj2VD8uh3jSiRC2Xx63rUKAx85YT7ezC8Y
	RXib6UqwxO1JC5L2110zqMJr5TPFdteUFgE0whY70dvyj1SttvbOyl4KW41qK2yxLcLPIp2IIycpI
	zGq68ZxMhYycuZkxlm0JGu6/wdb8fkiHZRzB8J3JDnUmFdbwNKAwUh1OzPXOYOYmdarZspChr+AbO
	PhAvDNCXSdueQ6Pce8SC2tnsp2jP6RKDkwiKWSH960/G1l+6fDU8il4H0+nQJVBeomH9wQut3PO4P
	zTo9KmeE88zYF22XuC0lcBEYQaCJKG2UuurALEnmFoTOTF5L4Hu7/dXHEZWjgOWQ==;
Received: from [2a02:8108:8984:1d00:a0cf:1912:4be:477f]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
	id 1vd5oe-004aJN-29;
	Tue, 06 Jan 2026 13:05:36 +0100
Message-ID: <6d788abe-3176-426a-a640-e30c03d25972@leemhuis.info>
Date: Tue, 6 Jan 2026 13:05:35 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: [PATCH RESEND 1/1] SPARC/PCI: Correct 64-bit non-pref -> pref BAR
 resources
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>, Bjorn Helgaas <bhelgaas@google.com>,
 sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Nathaniel Roach <nroach44@gmail.com>
References: <20251124170411.3709-1-ilpo.jarvinen@linux.intel.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <20251124170411.3709-1-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1767701140;0ec1c30e;
X-HE-SMSGID: 1vd5oe-004aJN-29

[top-posting to facilitate processing]

The issue fixed by below patch is still on my list of tracked
regression, which got me wondering what's up here. Did it fall through
the cracks? Is there some good reason why this approach was dropped? Or
Was the regression maybe fixed already and I just missed it?

Ciao, Thorsten

On 11/24/25 18:04, Ilpo JÃ¤rvinen wrote:
> SPARC T5-2 dts describes some PCI BARs as 64-bit resources without
> pref(etchable) bit (0x83... vs 0xc3... in assigned-addresses) for
> address ranges above the 4G threshold. Such resources cannot be placed
> into a non-prefetchable PCI bridge window that is capable only to
> 32-bit addressing. As such, it looks the platform is improperly
> describe by dts.
> 
> Kernel detect this problem (see the IORESOURCE_PREFETCH check in
> pci_find_parent_resource()) and fails to assign these BAR resources to
> the resource tree due to lack of a compatible bridge window.
> 
> Prior to the commit 754babaaf333 ("sparc/PCI: Remove
> pcibios_enable_device() as they do nothing extra") SPARC arch code did
> not test whether device resources were successfully in the resource
> tree when enabling a device, effectively hiding the problem. After
> removing the arch specific enable code, PCI core's
> pci_enable_resources() refuses to enable the device when it finds not
> all mem resources are assigned, and therefore mpt3sas can't be enabled:
> 
> pci 0001:04:00.0: reg 0x14: [mem 0x801110000000-0x80111000ffff 64bit]
> pci 0001:04:00.0: reg 0x1c: [mem 0x801110040000-0x80111007ffff 64bit]
> pci 0001:04:00.0: BAR 1 [mem 0x801110000000-0x80111000ffff 64bit]: can't claim; no compatible bridge window
> pci 0001:04:00.0: BAR 3 [mem 0x801110040000-0x80111007ffff 64bit]: can't claim; no compatible bridge window
> mpt3sas 0001:04:00.0: BAR 1 [mem size 0x00010000 64bit]: not assigned; can't enable device
> 
> For clarity, this filtered log only shows failures for one mpt3sas
> device but other devices fail similarly. In the reported case, the end
> result with all the failures is an unbootable system.
> 
> Things appeared to "work" before the commit 754babaaf333 ("sparc/PCI:
> Remove pcibios_enable_device() as they do nothing extra") because the
> resource tree is agnostic to whether PCI BAR resources are properly in
> the tree or not. So as long as there was a parent resource (e.g. a root
> bus resource) that contains the address range, the resource tree code
> just places resource request underneath it without any consideration to
> the intermediate BAR resource. While it worked, it's incorrect setup
> still.
> 
> Add of fixup to set IORESOURCE_PREFETCH flag for a 64-bit PCI resource
> that has the end address above 4G requiring placement into the
> prefetchable window. Also log the issue.
> 
> Fixes: 754babaaf333 ("sparc/PCI: Remove pcibios_enable_device() as they do nothing extra")
> Reported-by: Nathaniel Roach <nroach44@gmail.com>
> Tested-by: Nathaniel Roach <nroach44@gmail.com>
> Closes: https://github.com/sparclinux/issues/issues/22
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
> 
> Resending with linux-pci@ ML.
> 
> Any comments on the approach are welcome. E.g., is the fixup done at a
> correct level? Should it be targeted specifically to the known failures
> (how?) to avoid hiding more platform description problems?
> 
> It seems VF BARs still have 64-bit non-pref despite this change, AFAICT,
> those are read directly from the device's config space so would require
> ordinary quirks. None of them result in device enable failing though so the
> issue is orthogonal to the one being fixed here.
> 
> If suggesting a different approach, please do realize my knowledge
> about OF code is generally very limited (and I'm not sure how directly
> the fixup code in other archs, mainly ppc, can be used as an example
> how to do fixups with sparc).
> ---
>  arch/sparc/kernel/pci.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
> index a9448088e762..b290107170e9 100644
> --- a/arch/sparc/kernel/pci.c
> +++ b/arch/sparc/kernel/pci.c
> @@ -181,6 +181,28 @@ static int __init ofpci_debug(char *str)
>  
>  __setup("ofpci_debug=", ofpci_debug);
>  
> +static void of_fixup_pci_pref(struct pci_dev *dev, int index,
> +			      struct resource *res)
> +{
> +	struct pci_bus_region region;
> +
> +	if (!(res->flags & IORESOURCE_MEM_64))
> +		return;
> +
> +	if (!resource_size(res))
> +		return;
> +
> +	pcibios_resource_to_bus(dev->bus, &region, res);
> +	if (region.end <= ~((u32)0))
> +		return;
> +
> +	if (!(res->flags & IORESOURCE_PREFETCH)) {
> +		res->flags |= IORESOURCE_PREFETCH;
> +		pci_info(dev, "reg 0x%x: fixup: pref added to 64-bit resource\n",
> +			 index);
> +	}
> +}
> +
>  static unsigned long pci_parse_of_flags(u32 addr0)
>  {
>  	unsigned long flags = 0;
> @@ -244,6 +266,7 @@ static void pci_parse_of_addrs(struct platform_device *op,
>  		res->end = op_res->end;
>  		res->flags = flags;
>  		res->name = pci_name(dev);
> +		of_fixup_pci_pref(dev, i, res);
>  
>  		pci_info(dev, "reg 0x%x: %pR\n", i, res);
>  	}
> 
> base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787


