Return-Path: <linux-pci+bounces-43989-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 95CB3CF2A48
	for <lists+linux-pci@lfdr.de>; Mon, 05 Jan 2026 10:11:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D822300451D
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jan 2026 09:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F06335566;
	Mon,  5 Jan 2026 09:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JMKaYput"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE47321456;
	Mon,  5 Jan 2026 09:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767604157; cv=none; b=Zow2a+caUIMFEmPNrXeFipTsLL/Rmddg7UTkw8fBR73xbRJ7xC6asuyTPZlJ95fhAjyWOiUyoeTRylGIegCJ2LDR+O8x86wViw7utuj4o826hhwLE8oI6kBOT0z5Ic1mC2LgekvaN7gzb0cJZMdiFRdDgns3X/VgFyt0g9LIu8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767604157; c=relaxed/simple;
	bh=vQaFJQZW6rzm9Bi2qDiCLebS2wb0OV9+dUExJ2gS1ak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QIqPnEXmWIGXhWPWTGPW6Mf5XwznHTxYXk/Pf7Bj7BiedAa8zOTLEFjeY4K0CQLjck3Lg2q6eBhYKKNfFJSH82qkvGDU1F8BxGLDndAtsKmkPQruGeLwPFVJT5ovl+rjAjOnzJUusOEJCW6ow+bn89D/bLGwpHt/c/4eadz0EIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JMKaYput; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C06E6C4E694;
	Mon,  5 Jan 2026 09:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767604157;
	bh=vQaFJQZW6rzm9Bi2qDiCLebS2wb0OV9+dUExJ2gS1ak=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JMKaYputzXTTUgVeMfoewGWs91E1BlQPGSmj2rr2fdwuqoW6cW/QbVyE1WUY/oEOd
	 ngqKRL76QF/kF88qqmVEiE6wPUvvHhf/sCWWSYdHAdYddBlfbVdf9HCT/vVhEkRvi1
	 L6FLm6PQzEEMF8UuAaMQ+XiVaIHgplTKJ46Bmn+ETgzEE0kGGAmwRuYUzYap5xtj75
	 /Zsfk12GfWsbYwUeMj3tKcvttaeHN5NJ3Q5RbEL1ho+Enxc+K+iExQWVNz5HzqoIQr
	 dQfsG1W3uxFImnoP+Zb8qwef5W0kQkIdTjKHmjA+h5svEgfn2byIIyBd09mhipxvWs
	 IsqWL1BwnYfpA==
Date: Mon, 5 Jan 2026 10:09:11 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Jon Hunter <jonathanh@nvidia.com>,
	Francesco Lavra <flavra@baylibre.com>, thierry.reding@gmail.com,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Mayank Rana <mayank.rana@oss.qualcomm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Shradha Todi <shradha.t@samsung.com>,
	Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Vidya Sagar <vidyas@nvidia.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH] pci: controller: tegra194: remove dependency on Tegra194
 SoC
Message-ID: <aVt_t3kxtT99wbwi@ryzen>
References: <20251126102530.4110067-1-flavra@baylibre.com>
 <xh2att7wpqowricyifxmoaijbhtrtoht25pomu4voosfctf36e@4p27y7rezz22>
 <e900f082-fb3e-45c6-a94b-935132190249@nvidia.com>
 <5cwg6tg2y2q4mkns5zblenvhhovnz52dp5bo4uyghs4yledh3v@7apj6wwy3kjf>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5cwg6tg2y2q4mkns5zblenvhhovnz52dp5bo4uyghs4yledh3v@7apj6wwy3kjf>

On Mon, Jan 05, 2026 at 02:09:34PM +0530, Manivannan Sadhasivam wrote:
> On Fri, Jan 02, 2026 at 10:58:15AM +0000, Jon Hunter wrote:
> > 
> > On 23/12/2025 06:45, Manivannan Sadhasivam wrote:
> > > On Wed, Nov 26, 2025 at 11:25:30AM +0100, Francesco Lavra wrote:
> > > 
> > > + Tegra maintainers
> > > 
> > > > This driver runs (for both host and endpoint operation) also on other Tegra
> > > > SoCs (e.g. Tegra234).
> > > > Replace the Kconfig dependency on ARCH_TEGRA_194_SOC with a more generic
> > > > dependency on ARCH_TEGRA; in addition, amend the Kconfig help text to
> > > > reflect the fact that this driver is no longer exclusive to Tegra194.
> > > > 
> > > 
> > > I vaguely remember asking about this a while back during some other patch review
> > > and I don't remember what we concluded.
> > > > Thierry, Jon, thoughts?
> > 
> > So ARCH_TEGRA means that this can be enabled for the legacy 32-bit Tegra
> > devices as well as the current 64-bit Tegra devices (such as Tegra194).
> > Given that this driver is only used for Tegra194 and Tegra234, it seems it
> > would be better to only enable this for Tegra194 and Tegra234 instead of any
> > Tegra.
> > 
> 
> The dependency means, whenever someone tries to enable PCIE_TEGRA194_HOST,
> ARCH_TEGRA should be enabled. So as long as someone not trying to enable
> PCIE_TEGRA194_HOST for 32bit Tegra systems, ARCH_TEGRA should work fine and
> PCIE_TEGRA194_HOST is not selected by arch/arm/configs/tegra_defconfig. So I
> don't see any blocker with this patch. In fact, many other archs do the same.
> 
> But I don't like extending the Kconfig with per SoC dependency as it won't
> scale.

We already have a patch from Vidya:
[PATCH V4] PCI: dwc: tegra194: Broaden architecture dependency
that was sent 2025-05-08

Back then, the reason why it wasn't merged was because it required a
similar change to the PHY driver to go in first:
https://lore.kernel.org/linux-pci/174722268141.85510.14696275121588719556.b4-ty@kernel.org/

The PHY driver change was merged in v6.16:
0c2228731974 ("phy: tegra: p2u: Broaden architecture dependency")

So, I think we could just merge:
https://lore.kernel.org/linux-pci/20250508051922.4134041-1-vidyas@nvidia.com/

(Assuming it still applies.)


Kind regards,
Niklas

