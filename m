Return-Path: <linux-pci+bounces-6203-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 544988A37F7
	for <lists+linux-pci@lfdr.de>; Fri, 12 Apr 2024 23:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDD531F22865
	for <lists+linux-pci@lfdr.de>; Fri, 12 Apr 2024 21:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD39152175;
	Fri, 12 Apr 2024 21:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rvlgo99E"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47F339FD5
	for <linux-pci@vger.kernel.org>; Fri, 12 Apr 2024 21:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712957985; cv=none; b=aMZ22z7DIptDcQ32Kn07EDsVCEc58mpyJyLrf6Jl1JfkkZJkgPzuxHnlpOrvKJDznVqw00U6MMI7hh6EreG8cBKMJJhxuBkidHNRK3gwhA1pgYSXZ4DB7thQQng6agJChKZCrHWMiG7jzIuNFTFhvq5J4awgOyzWvPJ9kxoREXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712957985; c=relaxed/simple;
	bh=StRJuGJHX5iauCPjJNLmRUJ//vqsBQy0hLFpKuERmhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f4gD50d1tI9F4yF3Vv70UX/InDcFA6r768tmX4bSoG/nttUg5cU7gHBbUayB1MjmdIBHgQzH/R2QRq3j8WL78iIrtcoVuBLrVqnM9aqdNGkePFx539GMsJ/N4rzRMJs9j5WC/RGFUvM8XKxdWN5PcV4hqnuH8UvpIZ9ZgmlsucM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rvlgo99E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 702EBC2BD11;
	Fri, 12 Apr 2024 21:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712957985;
	bh=StRJuGJHX5iauCPjJNLmRUJ//vqsBQy0hLFpKuERmhU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rvlgo99ErNnDhg98e7amVSEoduth588jCU5MZCuerHGA0kFtSFXweE4TU2xp8wuc6
	 kb6SCDGn22VN8VsYxFvOApM1oTjEeioKUoUdCIFsD48l1kN/LCsFzl/anTSrlDnxYi
	 VZbHIr6vPQVpc90WkincsveIGyUhSrhTXoJ/z0FTbOZRgIfPt8j4a/K4LVV9WPdruY
	 Rv3N2pHN0K5WbdN/it06v6dcMCblSwkV4Hst2VehrRWnwEvhJXwpOQHpfhb1AHdl8I
	 YJCfGyHpkuU4if9LVwp9KCTVLmjC82Pa/GJb8y0XGBqVgAC+2kPDDzrEIpYZm3DbwP
	 qP71fwrI9U0eg==
Date: Fri, 12 Apr 2024 23:39:39 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Shradha Todi <shradha.t@samsung.com>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 8/9] PCI: rockchip-ep: Set a 64-bit BAR if requested
Message-ID: <ZhmqG6avmX8ZOtIX@ryzen>
References: <20240313105804.100168-9-cassel@kernel.org>
 <20240412175127.GA8613@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412175127.GA8613@bhelgaas>

On Fri, Apr 12, 2024 at 12:51:27PM -0500, Bjorn Helgaas wrote:
> On Wed, Mar 13, 2024 at 11:58:00AM +0100, Niklas Cassel wrote:
> > Ever since commit f25b5fae29d4 ("PCI: endpoint: Setting a BAR size > 4 GB
> > is invalid if 64-bit flag is not set") it has been impossible to get the
> > .set_bar() callback with a BAR size > 4 GB, if the BAR was also not
> > requested to be configured as a 64-bit BAR.
> > 
> > It is however possible that an EPF driver configures a BAR as 64-bit,
> > even if the requested size is < 4 GB.
> > 
> > Respect the requested BAR configuration, just like how it is already
> > repected with regards to the prefetchable bit.
> 
> Does this (and the similar cadence patch) need a Fixes: tag for
> f25b5fae29d4?

I don't think so.

Both patches are about respecting the configuration requested by an EPF
driver.

So if an EPF driver requests a 64-bit BAR, the EPC driver should configure
that. (Regardless of the size that the EPF driver requests for the BAR.)

If we really want a Fixes-tag, I would imagine that it will be the respective
initial commits that added these drivers (pcie-cadence-ep.c and
pcie-rockchip-ep.c), as it has been this way since then.

If you look at the EPF drivers we currently have, they will currently only
request a 64-bit BAR if any of the BARs can only be configured as a 64-bit
BAR because of hardware limitiations.

$ git grep only_64bit

Neither of these two drivers have any such hardware limitiations,
so these commits are currently a bit pointless.

However, the drivers should of course do the right thing, because other
EPC drivers might look at them and copy their code.

And who knows, maybe sometime in the future there will be an EPF driver
that will explicitly request a 64-bit BAR, regardless of size.

TL;DR: I don't think these two commits are worth backporting.


> 
> > Signed-off-by: Niklas Cassel <cassel@kernel.org>
> > ---
> >  drivers/pci/controller/pcie-rockchip-ep.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
> > index c9046e97a1d2..57472cf48997 100644
> > --- a/drivers/pci/controller/pcie-rockchip-ep.c
> > +++ b/drivers/pci/controller/pcie-rockchip-ep.c
> > @@ -153,7 +153,7 @@ static int rockchip_pcie_ep_set_bar(struct pci_epc *epc, u8 fn, u8 vfn,
> >  		ctrl = ROCKCHIP_PCIE_CORE_BAR_CFG_CTRL_IO_32BITS;
> >  	} else {
> >  		bool is_prefetch = !!(flags & PCI_BASE_ADDRESS_MEM_PREFETCH);
> > -		bool is_64bits = sz > SZ_2G;
> > +		bool is_64bits = !!(flags & PCI_BASE_ADDRESS_MEM_TYPE_64);
> >  
> >  		if (is_64bits && (bar & 1))
> >  			return -EINVAL;
> > -- 
> > 2.44.0
> > 

