Return-Path: <linux-pci+bounces-6204-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E2A8A386E
	for <lists+linux-pci@lfdr.de>; Sat, 13 Apr 2024 00:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A33401F21FEF
	for <lists+linux-pci@lfdr.de>; Fri, 12 Apr 2024 22:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF03152164;
	Fri, 12 Apr 2024 22:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RZQ9gV1L"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A15B39FD5
	for <linux-pci@vger.kernel.org>; Fri, 12 Apr 2024 22:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712959244; cv=none; b=WhzEtsLWWJ287DepjaH6ql8pRyOXOV/cINRJWm/+YLhMtDlANO9/vXd8UBypRNlcD1mkIpj6uBKsZyQ0vK4RDbXOMyOEPd2LF5vhhGHoe03yRqG7ONqz3l7IEdJNAc/03GWG831Cx2ojEAG6ajkcQqFZai1PvSn3/yHZoadrWac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712959244; c=relaxed/simple;
	bh=ZKH3KzVTUFLwzZCC+c/nh0ruTG6gvkEa8ggu7OQagqA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ngU8k5sNRQVDQgzpWTWOb1ODoDi82WvuKKqNDRI+O/JPZ1SaL+edzuQKWNnvYVxXa1/Hc+Q3Fo98M95KFeETQV2mgcQmVU17YcpOwo31nokQ2bRASuH5iTJxus3tAIG8yO2eq5p8xdu97EhTI+6XCFC4eNgKMB+QPOKDMkJOlfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RZQ9gV1L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D22F1C2BD11;
	Fri, 12 Apr 2024 22:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712959244;
	bh=ZKH3KzVTUFLwzZCC+c/nh0ruTG6gvkEa8ggu7OQagqA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=RZQ9gV1LUSC/cxhceFmKioUlqU7p9ousMNjktpWfRQZ9A1KU72H2y0Nz43XOgFXfN
	 Lz5BiqapFj8BEe3KP3+3eEL7hKGvFrftnsHWlNcAzd5M7D7uNHE0W2xYcraD/76958
	 P2JV2GIgH9gMqT5fym21tg6xyMUgWmYLGufpN+ESzw/Kw0Ftw9//wov3BL/nZbIHt+
	 XYoc481BPKSs5mNhpWjBBdHT35OhsbIGyq4qfcXk9bqZc2bLvJn+hTT8CcDEKrnqlH
	 qolq62p8JcApggYM2JjE4zluaRK2arn+RyWi4S7YIVEDeWPvRpAA4tPZlzg/6B2izR
	 VCnBkrhBiMLEw==
Date: Fri, 12 Apr 2024 17:00:42 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
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
Message-ID: <20240412220042.GA21397@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZhmqG6avmX8ZOtIX@ryzen>

On Fri, Apr 12, 2024 at 11:39:39PM +0200, Niklas Cassel wrote:
> On Fri, Apr 12, 2024 at 12:51:27PM -0500, Bjorn Helgaas wrote:
> > On Wed, Mar 13, 2024 at 11:58:00AM +0100, Niklas Cassel wrote:
> > > Ever since commit f25b5fae29d4 ("PCI: endpoint: Setting a BAR size > 4 GB
> > > is invalid if 64-bit flag is not set") it has been impossible to get the
> > > .set_bar() callback with a BAR size > 4 GB, if the BAR was also not
> > > requested to be configured as a 64-bit BAR.
> > > 
> > > It is however possible that an EPF driver configures a BAR as 64-bit,
> > > even if the requested size is < 4 GB.
> > > 
> > > Respect the requested BAR configuration, just like how it is already
> > > repected with regards to the prefetchable bit.
> > 
> > Does this (and the similar cadence patch) need a Fixes: tag for
> > f25b5fae29d4?
> 
> I don't think so.
> 
> Both patches are about respecting the configuration requested by an EPF
> driver.
> 
> So if an EPF driver requests a 64-bit BAR, the EPC driver should configure
> that. (Regardless of the size that the EPF driver requests for the BAR.)
> 
> If we really want a Fixes-tag, I would imagine that it will be the respective
> initial commits that added these drivers (pcie-cadence-ep.c and
> pcie-rockchip-ep.c), as it has been this way since then.
> 
> If you look at the EPF drivers we currently have, they will currently only
> request a 64-bit BAR if any of the BARs can only be configured as a 64-bit
> BAR because of hardware limitiations.
> 
> $ git grep only_64bit
> 
> Neither of these two drivers have any such hardware limitiations,
> so these commits are currently a bit pointless.
> 
> However, the drivers should of course do the right thing, because other
> EPC drivers might look at them and copy their code.
> 
> And who knows, maybe sometime in the future there will be an EPF driver
> that will explicitly request a 64-bit BAR, regardless of size.
> 
> TL;DR: I don't think these two commits are worth backporting.

OK, thanks!

> > > Signed-off-by: Niklas Cassel <cassel@kernel.org>
> > > ---
> > >  drivers/pci/controller/pcie-rockchip-ep.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
> > > index c9046e97a1d2..57472cf48997 100644
> > > --- a/drivers/pci/controller/pcie-rockchip-ep.c
> > > +++ b/drivers/pci/controller/pcie-rockchip-ep.c
> > > @@ -153,7 +153,7 @@ static int rockchip_pcie_ep_set_bar(struct pci_epc *epc, u8 fn, u8 vfn,
> > >  		ctrl = ROCKCHIP_PCIE_CORE_BAR_CFG_CTRL_IO_32BITS;
> > >  	} else {
> > >  		bool is_prefetch = !!(flags & PCI_BASE_ADDRESS_MEM_PREFETCH);
> > > -		bool is_64bits = sz > SZ_2G;
> > > +		bool is_64bits = !!(flags & PCI_BASE_ADDRESS_MEM_TYPE_64);
> > >  
> > >  		if (is_64bits && (bar & 1))
> > >  			return -EINVAL;
> > > -- 
> > > 2.44.0
> > > 
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip

