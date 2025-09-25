Return-Path: <linux-pci+bounces-37026-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D05BA185C
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 23:21:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2331A741A3D
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 21:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F104A31D733;
	Thu, 25 Sep 2025 21:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rm/TAEQy"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8105279358;
	Thu, 25 Sep 2025 21:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758835280; cv=none; b=t/zr5s44XqkPVCMh4K6yoZckKsAOKQEvIiRbDMO93rVAyRclSPqPuPLbVi+wtOUr9FtMm3cx3yo7mPX+eNVPo+EwHFsO8+vBoh+qDtrRtef8rVHpoDlmNo9D2SXInFJM5xwRNRD/DBxpfpeyxdVI+S0JdAGu5d7TDc/15opQUbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758835280; c=relaxed/simple;
	bh=0XpdOcBiZPVxftYSGPQHYODDbCy9pMHCxBIVH2dxn2g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=AIlY4bYBscgGu6XrNQwlgdO0YPthGt9GEvxj0QpPiBbwAaoEyHOAeVx0O1HaK5IsvS5cOHVU3RFsF197Io0Eez1QqrlrFdEOTMRE7mnZdMRLlUme3CBb2p106qxd0caIqGA+FkWNysDVmDhSgBhBNT03uWtyyPBqM4FfO614xZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rm/TAEQy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37623C4CEF0;
	Thu, 25 Sep 2025 21:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758835279;
	bh=0XpdOcBiZPVxftYSGPQHYODDbCy9pMHCxBIVH2dxn2g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Rm/TAEQyAXLhJIKtcLHGOxeYL/Zi8T+jGCLcJyKyXnQbAh3lrfk3f2x/u7/krN4Ln
	 Np7DpLL7Ek+tf4pmtm8OvFAC76PTinumxkAfFFYK8zrdenUTzJRaF6k2B53QMQD3LS
	 QLcGgmLGzSxY2zUBqGxfsJDNrM4Xw6UCF/rfIg7pCYuwq9AT+PBmSlC0rn3SWuphhN
	 x0m1FKnEJtkX+ntKt7ygpRMUMCpYctPWD3eDdWb1POvoSDLaNW/Slw9byqcOXdsBny
	 nJyXhfmBXx56dRW3dqdUjJUJ8OQ+fPpa6V2Z0SLflC2pnOJIPoWm0YkI3CCrjrO32D
	 sDuMUUwhCqTig==
Date: Thu, 25 Sep 2025 16:21:17 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-kernel@vger.kernel.org,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: Re: [PATCH 2/2] PCI: Resources outside their window must set
 IORESOURCE_UNSET
Message-ID: <20250925212117.GA2204498@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250924134228.1663-3-ilpo.jarvinen@linux.intel.com>

On Wed, Sep 24, 2025 at 04:42:28PM +0300, Ilpo Järvinen wrote:
> PNP resources are checked for conflicts with the other resource in the
> system by quirk_system_pci_resources() that walks through all PCI
> resources. quirk_system_pci_resources() correctly filters out resource
> with IORESOURCE_UNSET.
> 
> Resources that do not reside within their bridge window, however, are
> not properly initialized with IORESOURCE_UNSET resulting in bogus
> conflicts detected in quirk_system_pci_resources():
> 
> pci 0000:00:02.0: VF BAR 2 [mem 0x00000000-0x1fffffff 64bit pref]
> pci 0000:00:02.0: VF BAR 2 [mem 0x00000000-0xdfffffff 64bit pref]: contains BAR 2 for 7 VFs
> ...
> pci 0000:03:00.0: VF BAR 2 [mem 0x00000000-0x1ffffffff 64bit pref]
> pci 0000:03:00.0: VF BAR 2 [mem 0x00000000-0x3dffffffff 64bit pref]: contains BAR 2 for 31 VFs
> ...
> pnp 00:04: disabling [mem 0xfc000000-0xfc00ffff] because it overlaps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
> pnp 00:05: disabling [mem 0xc0000000-0xcfffffff] because it overlaps 0000:00:02.0 BAR 9 [mem 0x00000000-0xdfffffff 64bit pref]
> pnp 00:05: disabling [mem 0xfedc0000-0xfedc7fff] because it overlaps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
> pnp 00:05: disabling [mem 0xfeda0000-0xfeda0fff] because it overlaps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
> pnp 00:05: disabling [mem 0xfeda1000-0xfeda1fff] because it overlaps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
> pnp 00:05: disabling [mem 0xc0000000-0xcfffffff disabled] because it overlaps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
> pnp 00:05: disabling [mem 0xfed20000-0xfed7ffff] because it overlaps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
> pnp 00:05: disabling [mem 0xfed90000-0xfed93fff] because it overlaps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
> pnp 00:05: disabling [mem 0xfed45000-0xfed8ffff] because it overlaps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
> pnp 00:05: disabling [mem 0xfee00000-0xfeefffff] because it overlaps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
> 
> Mark resources that are not contained within their bridge window with
> IORESOURCE_UNSET in __pci_read_base() which resolves the false
> positives for the overlap check in quirk_system_pci_resources().
> 
> Fixes: f7834c092c42 ("PNP: Don't check for overlaps with unassigned PCI BARs")
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
> 
> This change uses resource_contains() which will reject partial overlaps.
> I don't know for sure if partial overlaps should be allowed or not (but
> they feel as something FW didn't set things up properly so I chose to
> mark them UNSET as well).
> 
>  drivers/pci/probe.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 7f9da8c41620..097389f25853 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -205,6 +205,26 @@ static void __pci_size_rom(struct pci_dev *dev, unsigned int pos, u32 *sizes)
>  	__pci_size_bars(dev, 1, pos, sizes, true);
>  }
>  
> +static struct resource *pbus_select_window_for_res_addr(
> +					const struct pci_bus *bus,
> +					const struct resource *res)
> +{
> +	unsigned long type = res->flags & IORESOURCE_TYPE_BITS;
> +	struct resource *r;
> +
> +	pci_bus_for_each_resource(bus, r) {
> +		if (!r || r == &ioport_resource || r == &iomem_resource)
> +			continue;
> +
> +		if ((r->flags & IORESOURCE_TYPE_BITS) != type)
> +			continue;
> +
> +		if (resource_contains(r, res))
> +			return r;
> +	}
> +	return NULL;
> +}
> +
>  /**
>   * __pci_read_base - Read a PCI BAR
>   * @dev: the PCI device
> @@ -329,6 +349,18 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
>  			 res_name, (unsigned long long)region.start);
>  	}
>  
> +	if (!(res->flags & IORESOURCE_UNSET)) {
> +		struct resource *b_res;
> +
> +		b_res = pbus_select_window_for_res_addr(dev->bus, res);
> +		if (!b_res ||
> +		    b_res->flags & (IORESOURCE_UNSET | IORESOURCE_DISABLED)) {
> +			pci_dbg(dev, "%s %pR: no initial claim (no window)\n",
> +				res_name, res);

Should this be pci_info()?  Or is there somewhere else that we
complain about a child resource that's not contained in a bridge
window?

I recently got an internal report of child BARs being reassigned, I
think because they weren't inside a bridge window, and the dmesg log
(from an older kernel) showed the BAR reassignments, but didn't say
anything about the *reason* for the reassignment.

> +			res->flags |= IORESOURCE_UNSET;
> +		}
> +	}
> +
>  	goto out;
>  
>  
> -- 
> 2.39.5
> 

