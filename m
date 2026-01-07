Return-Path: <linux-pci+bounces-44229-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8E1D00047
	for <lists+linux-pci@lfdr.de>; Wed, 07 Jan 2026 21:34:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B4F23011EE7
	for <lists+linux-pci@lfdr.de>; Wed,  7 Jan 2026 20:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6625337BA2;
	Wed,  7 Jan 2026 20:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ByWrru9N"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5DF3242B3;
	Wed,  7 Jan 2026 20:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767817463; cv=none; b=NDOtBLOApUpWGkEfo/YC3DhP1WxuLYBt7SNXMXTPxy64POwvCCAk/Oemb57VmdALVMReE1oWUNTDkxPeX7TQh1+L7QVuAUK3nHZteXFgGYigojab6jZEmwXbNyDSbia0DdPQq1hrPxnvULaqHSt1FXt2nNvAbPUKKAoAufvBD+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767817463; c=relaxed/simple;
	bh=giCjZFFGJTBcP6I5Iecb0sZXSsOvzIa+ijNZAsYdFnA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=aMK+LUc7NgoZMwUXVs0Zm82MH91LI+ad5NQ6GC+r2K672U9AKPg2o/3Wh8AgxPFokbOC24Hl0Z7yoE2eYNfqT/dTaZrShD9yvGh9UDn0atEjDRWUviyRLG+4En8QMSnmWD4w62jOwsbUxBPwwHr/XwWMEQ3H/QqSlPlFfF2HI14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ByWrru9N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC5CFC4CEF1;
	Wed,  7 Jan 2026 20:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767817463;
	bh=giCjZFFGJTBcP6I5Iecb0sZXSsOvzIa+ijNZAsYdFnA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ByWrru9N9qCY/ovADdp6p6gdFwQCH3ACI3UXI1Iy+DQryQv+zfmc2fPTyP/mNaond
	 dl1J8ar+Z6Jjdwd7Um6KMP8RNds/5IS2Aie3KaziGpjqAt3q4xD4HqV3mhdH17rCCQ
	 eWbWGgWm4MGbQpkEVwxK9rLHYXcz4R2aniOcX+POYwIniD6ACrPnjo8WmHPe7ttpZJ
	 06fWwiJUQQhA7MOwu4d7Icm7D7FGtF+QFh2bOtl4AXa596sYXJ3ur4tmmpgwBQC1p9
	 3ojOXqpAmc2j5+Q+yLKpAySX9ZEVr+Yu46JP898eIGml6Fpti9GhSiJfhwBqiessah
	 iMtsZ324ewj7A==
Date: Wed, 7 Jan 2026 14:24:21 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Bjorn Helgaas <bhelgaas@google.com>, sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org, Nathaniel Roach <nroach44@gmail.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Subject: Re: [PATCH RESEND 1/1] SPARC/PCI: Correct 64-bit non-pref -> pref
 BAR resources
Message-ID: <20260107202421.GA442125@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251124170411.3709-1-ilpo.jarvinen@linux.intel.com>

[+cc Adrian]

On Mon, Nov 24, 2025 at 07:04:11PM +0200, Ilpo Järvinen wrote:
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

Originally posted as attachment in response to Adrian's pointer to
Nathaniel's regression report:

  https://lore.kernel.org/r/d221be13-f652-cc75-90d1-92cf38e0110e@linux.intel.com

This seems reasonable to me and addresses a v6.18 regression, so I put
this on pci/for-linus for v6.19.

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

The VF BARs that don't have PCI_BASE_ADDRESS_MEM_PREFETCH set is a
generic question, not anything sparc-specific, right?

As of the "Removing Prefetchable Terminology" ECN
(https://members.pcisig.com/wg/PCI-SIG/document/20839) that was
incorporated in PCIe r6.3, PCI_BASE_ADDRESS_MEM_PREFETCH (bit 3) is
deprecated.  There's a recommendation that it be set for 64-bit BARs
and cleared for 32-bit BARs, but I suppose we'll see 64-bit VF BARs
with it cleared as in this case.

We might need to rework the PCI_BASE_ADDRESS_MEM_PREFETCH handling to
accommodate this.  I suspect we'll still need to pay attention to it
at least for conventional PCI, but there might be some wiggle room for
PCIe.

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
> -- 
> 2.39.5
> 

