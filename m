Return-Path: <linux-pci+bounces-44014-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F631CF382B
	for <lists+linux-pci@lfdr.de>; Mon, 05 Jan 2026 13:28:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED39F304C914
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jan 2026 12:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F20335551;
	Mon,  5 Jan 2026 12:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V2DF4sFE"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3211334C2F;
	Mon,  5 Jan 2026 12:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767615712; cv=none; b=jiVpTgfj+evs4SZ06/NDkRLJ/PbE8sgcwRjA6HxrUztAEacbqlIDjlMDAGrkdfzKCxaRDM3T6kaY9ORiySXPqhacxWyEb6qfNEki67W4vwD/Ej/Nl29vyrGOaHqAfisrBKtQvTgUCZ6kgRNWImi0C/tCWheh1rJP4LcZneoLhvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767615712; c=relaxed/simple;
	bh=uxx99CMgbHnEytb+BsuxoiP4FLdziAW2KxjSiDGBebA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aH5akttSmDpcrrfwM3eii9kJP/8wpuIB+rI4SWsPDVjGDuH3sm4/6Uy7h74YXSbiXis62+wNWGr3YGT9GoZhuqCtDR15lO2epnhxM/A8QKyKHcUOOa71aMkRWgWYfsxuYqOahyto7jX1f97w+sd/t8hwto6DmKx823LfNpmd888=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V2DF4sFE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F114AC19421;
	Mon,  5 Jan 2026 12:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767615712;
	bh=uxx99CMgbHnEytb+BsuxoiP4FLdziAW2KxjSiDGBebA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V2DF4sFENG6PrKdXd5tH9tjAY1+sE2/ljzfwKL+UeJnfnT3Cs81Z94bsO9Pug9IZM
	 Bww/ySfZZ7mIpURkTEUL7SHHHBPeJnWQIRpFB4jOZxnVWcrpy5RIDo5CvrHY059eka
	 hsnUBIN/GiQQn/dJz+vhPFjOtzJ3EX7va69JHjr3SLTgvrmjbVojyPPun/vY7F7tiM
	 +JzD0YGen7bvCgmtNiaZj4kTqDjrQintgWfZOJMSbNI5jl6WThvCJT5o5rVMvtv+t7
	 yt/RNgzC6lrC04WbhMKZhLa+NmcS7LT7Ubduz4Lsqh3jNk6zzGExIfXFvNE8eqsLMK
	 oBUab4AUdOyZQ==
Date: Mon, 5 Jan 2026 13:21:46 +0100
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
Message-ID: <aVus2urjJ3AoHMv3@ryzen>
References: <20251126102530.4110067-1-flavra@baylibre.com>
 <xh2att7wpqowricyifxmoaijbhtrtoht25pomu4voosfctf36e@4p27y7rezz22>
 <e900f082-fb3e-45c6-a94b-935132190249@nvidia.com>
 <5cwg6tg2y2q4mkns5zblenvhhovnz52dp5bo4uyghs4yledh3v@7apj6wwy3kjf>
 <aVt_t3kxtT99wbwi@ryzen>
 <7bfb3ebc-2e8b-4fcc-8d13-a6f3e0b7141e@nvidia.com>
 <q2iezy4uydlvwgo6m6yv2nlucafyvxgonm2o5q3g32p73vemwb@x33rmfffnwlu>
 <aVurA-MUECufgTw0@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aVurA-MUECufgTw0@ryzen>

On Mon, Jan 05, 2026 at 01:14:01PM +0100, Niklas Cassel wrote:
> > > > So, I think we could just merge:
> > > > https://lore.kernel.org/linux-pci/20250508051922.4134041-1-vidyas@nvidia.com/
> > > > 
> > > > (Assuming it still applies.)
> > > 
> > > Yes it does and applying Sagar's patch is fine with me. So it you want to
> > > apply Sagar's patch please add my ...
> > > 
> > 
> > Don't we need:
> > 
> > 	depends on (ARCH_TEGRA && ARM64) || COMPILE_TEST
> 
> This is exactly what I originally suggested to Vidya:
> https://lore.kernel.org/linux-pci/Z6XjWJd9jm0HHNXW@ryzen/
> 
> 
> > 
> > in the above patch?
> 
> The above patch instead has:
> 
> depends on ARCH_TEGRA && (ARM64 || COMPILE_TEST)
> 
> I don't know why Vidya did not use my suggestion exactly, but I guess I
> assumed that he had a reason not to use my suggestion exactly.


Looking at drivers/pci/controller/dwc/Kconfig,
there are a lot of:

depends on OF && (ARM64 || COMPILE_TEST)

So I think Vidya simply followed this pattern and instead did:
depends on ARCH_TEGRA && (ARM64 || COMPILE_TEST)


But, since we don't have an explicit "depends on OF"
in these entries, I do think that:

depends on (ARCH_TEGRA && ARM64) || COMPILE_TEST

is slightly more correct. (Since if there was a hard requirement on OF,
it would have been there already).


Kind regards,
Niklas

