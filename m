Return-Path: <linux-pci+bounces-43987-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0BBCF27F2
	for <lists+linux-pci@lfdr.de>; Mon, 05 Jan 2026 09:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 736F43053BC2
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jan 2026 08:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6FA313E39;
	Mon,  5 Jan 2026 08:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="huNGUoAI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E646254B18;
	Mon,  5 Jan 2026 08:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767602383; cv=none; b=ilKH2VpdJIlWxlW4W+FR7Y6m0Khmi9lZCpRzl7YV+cNA9z92WJ9V/PLS16Hfq088NlOCrkEg9k5j2p/RyR6dSLJzqnuKuxvM6sy77dqlM0ZDKMyXIcve42irCzCT73zJMPJo5WALNrDVEsTManAk9wvcuQ7bnigzIhVUnqwYfss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767602383; c=relaxed/simple;
	bh=EpLu6yh77VS0IgkoZnbaTo04x8UBy2Ue0cAFWXUo//4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oU9LK0CIMG96nmdxj0ZcQH196Y+Jg1PXrU9FkzyP1fY/HxNTZa+asPjg0+K8KtjSG1M1huWmHeXyk24AOIOgnb6mGrmIwdt1XULoaPrmpsXQvhETX7h8859gUKSjbkp7JGZIeS5VP4EoockhGRV4C5XoJlFMyMbv9PGgNM6X26s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=huNGUoAI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ACADC116D0;
	Mon,  5 Jan 2026 08:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767602383;
	bh=EpLu6yh77VS0IgkoZnbaTo04x8UBy2Ue0cAFWXUo//4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=huNGUoAIy6rvXnRpwTVu78tsktqThUzG3AXNJLhEseVTJUViWEohZAa8L9gnwwHaG
	 5a6xcnNMQivYFpqbSgpW3XCGLg/3hRPCIIQGY+rHBrc5/+OSAqukv5Yp8p5D3eWHg9
	 yh/263ibMBCW26Vw/XE7AZrRStEhfHG93ppTNPUvZGGEviw9MPx7p/MNZgjI7eJkHf
	 0XjKHRyvceQR7QgF5omGOga4oHw4+EwSK6g3bY1V8gJXgjriFFU3Tb5uKWOZG1qUHg
	 U98nfNzfg1zXILA/shSsfY9wFBO/TVv6jm9i4F3Y2W7L8K/1oCNhhvve6wz2b5ReWs
	 pL00aX9cNGvsw==
Date: Mon, 5 Jan 2026 14:09:34 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Francesco Lavra <flavra@baylibre.com>, thierry.reding@gmail.com, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Mayank Rana <mayank.rana@oss.qualcomm.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Shradha Todi <shradha.t@samsung.com>, Thippeswamy Havalige <thippeswamy.havalige@amd.com>, 
	Inochi Amaoto <inochiama@gmail.com>, Vidya Sagar <vidyas@nvidia.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH] pci: controller: tegra194: remove dependency on Tegra194
 SoC
Message-ID: <5cwg6tg2y2q4mkns5zblenvhhovnz52dp5bo4uyghs4yledh3v@7apj6wwy3kjf>
References: <20251126102530.4110067-1-flavra@baylibre.com>
 <xh2att7wpqowricyifxmoaijbhtrtoht25pomu4voosfctf36e@4p27y7rezz22>
 <e900f082-fb3e-45c6-a94b-935132190249@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e900f082-fb3e-45c6-a94b-935132190249@nvidia.com>

On Fri, Jan 02, 2026 at 10:58:15AM +0000, Jon Hunter wrote:
> 
> On 23/12/2025 06:45, Manivannan Sadhasivam wrote:
> > On Wed, Nov 26, 2025 at 11:25:30AM +0100, Francesco Lavra wrote:
> > 
> > + Tegra maintainers
> > 
> > > This driver runs (for both host and endpoint operation) also on other Tegra
> > > SoCs (e.g. Tegra234).
> > > Replace the Kconfig dependency on ARCH_TEGRA_194_SOC with a more generic
> > > dependency on ARCH_TEGRA; in addition, amend the Kconfig help text to
> > > reflect the fact that this driver is no longer exclusive to Tegra194.
> > > 
> > 
> > I vaguely remember asking about this a while back during some other patch review
> > and I don't remember what we concluded.
> > > Thierry, Jon, thoughts?
> 
> So ARCH_TEGRA means that this can be enabled for the legacy 32-bit Tegra
> devices as well as the current 64-bit Tegra devices (such as Tegra194).
> Given that this driver is only used for Tegra194 and Tegra234, it seems it
> would be better to only enable this for Tegra194 and Tegra234 instead of any
> Tegra.
> 

The dependency means, whenever someone tries to enable PCIE_TEGRA194_HOST,
ARCH_TEGRA should be enabled. So as long as someone not trying to enable
PCIE_TEGRA194_HOST for 32bit Tegra systems, ARCH_TEGRA should work fine and
PCIE_TEGRA194_HOST is not selected by arch/arm/configs/tegra_defconfig. So I
don't see any blocker with this patch. In fact, many other archs do the same.

But I don't like extending the Kconfig with per SoC dependency as it won't
scale.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

