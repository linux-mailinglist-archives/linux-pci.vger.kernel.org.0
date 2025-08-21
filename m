Return-Path: <linux-pci+bounces-34463-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF330B2FE08
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 17:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F8E51772C0
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 15:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7853287503;
	Thu, 21 Aug 2025 15:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TP4Sc0qT"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB49D2874F5;
	Thu, 21 Aug 2025 15:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755789036; cv=none; b=AMKc51DyI4xiOMbUnW9AGsh6w+8Qp6jH/Fw6ahttEoU1YKNFBzCY3Xs1m5ExZXAM7FrFZ+iTiAGgdIo4An/3zwEzZEQftaUMpAeBLNUcUMzUoV/vuq79IwV7+gHo5ZQQb/0b4zwFsLU0bpr+fHn4/Wtywtv8tlclaKTdH9CnTZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755789036; c=relaxed/simple;
	bh=KOujws6yZ+fxbp80saJb/gh64MlmouP1oh4UgzwtmBg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=HJVz2FOZl1j68N4Jpd308AZ8qHd5m7XxwEEJl1DEE8W/hphWYUCsQx5sApZzo4ucVVYTxSsc4LTnSwkB7CD6dQQuWcGoJRwoPVIVe7yLDmLO2O62qHueL6QPAuVfyyWdbN7kSmtOb5aKH9UujFTxJLsJI2wamoWMu1iAeosG6FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TP4Sc0qT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 772DAC4CEEB;
	Thu, 21 Aug 2025 15:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755789036;
	bh=KOujws6yZ+fxbp80saJb/gh64MlmouP1oh4UgzwtmBg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=TP4Sc0qTaHew6YZ17l1M+m3kWQTlVlUqH3fO1WOyL+67IcfgKPogXIyN6YkLA+agX
	 uwZkjo5PqR3oCOlfpkBY7Y8PXsJ+473MRTGkppoE2fICjU+G127b61kWrZO/qhvjkw
	 7Nzn3lIgwoitC6DGgPMYBNoBLTfezbqcjels7/a/78AoKbPY8xxD0ob9hd4kuULO15
	 /Y3L6kcjeDcy3JTbsiDTAYcZNADFZOLAuEjqzqwMfH4VUdCaMfeB7rOerjGXptDy3K
	 M2lESZ5XAUBQJZKKqoqXbRXt7y+H92LdPeQjVTGpefkxI4Ro6UC1VZ5LuFsoAgpIt6
	 SwDZ5xDpR3kEQ==
Date: Thu, 21 Aug 2025 10:10:35 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>, Rio <rio@r26.me>,
	D Scott Phillips <scott@os.amperecomputing.com>,
	linux-kernel@vger.kernel.org,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/3] PCI: Relaxed tail alignment should never increase
 min_align
Message-ID: <20250821151035.GA674429@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250630142641.3516-2-ilpo.jarvinen@linux.intel.com>

On Mon, Jun 30, 2025 at 05:26:39PM +0300, Ilpo Järvinen wrote:
> When using relaxed tail alignment for the bridge window,
> pbus_size_mem() also tries to minimize min_align, which can under
> certain scenarios end up increasing min_align from that found by
> calculate_mem_align().
> 
> Ensure min_align is not increased by the relaxed tail alignment.
> 
> Eventually, it would be better to add calculate_relaxed_head_align()
> similar to calculate_mem_align() which finds out what alignment can be
> used for the head without introducing any gaps into the bridge window
> to give flexibility on head address too. But that looks relatively
> complex algorithm so it requires much more testing than fixing the
> immediate problem causing a regression.
> 
> Fixes: 67f9085596ee ("PCI: Allow relaxed bridge window tail sizing for optional resources")
> Reported-by: Rio <rio@r26.me>

Was there a regression report URL we could include here?

> Tested-by: Rio <rio@r26.me>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Cc: <stable@vger.kernel.org>
> ---
>  drivers/pci/setup-bus.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 07c3d021a47e..f90d49cd07da 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -1169,6 +1169,7 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
>  	resource_size_t children_add_size = 0;
>  	resource_size_t children_add_align = 0;
>  	resource_size_t add_align = 0;
> +	resource_size_t relaxed_align;
>  
>  	if (!b_res)
>  		return -ENOSPC;
> @@ -1246,8 +1247,9 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
>  	if (bus->self && size0 &&
>  	    !pbus_upstream_space_available(bus, mask | IORESOURCE_PREFETCH, type,
>  					   size0, min_align)) {
> -		min_align = 1ULL << (max_order + __ffs(SZ_1M));
> -		min_align = max(min_align, win_align);
> +		relaxed_align = 1ULL << (max_order + __ffs(SZ_1M));
> +		relaxed_align = max(relaxed_align, win_align);
> +		min_align = min(min_align, relaxed_align);
>  		size0 = calculate_memsize(size, min_size, 0, 0, resource_size(b_res), win_align);
>  		pci_info(bus->self, "bridge window %pR to %pR requires relaxed alignment rules\n",
>  			 b_res, &bus->busn_res);
> @@ -1261,8 +1263,9 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
>  		if (bus->self && size1 &&
>  		    !pbus_upstream_space_available(bus, mask | IORESOURCE_PREFETCH, type,
>  						   size1, add_align)) {
> -			min_align = 1ULL << (max_order + __ffs(SZ_1M));
> -			min_align = max(min_align, win_align);
> +			relaxed_align = 1ULL << (max_order + __ffs(SZ_1M));
> +			relaxed_align = max(min_align, win_align);
> +			min_align = min(min_align, relaxed_align);
>  			size1 = calculate_memsize(size, min_size, add_size, children_add_size,
>  						  resource_size(b_res), win_align);
>  			pci_info(bus->self,
> -- 
> 2.39.5
> 

