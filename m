Return-Path: <linux-pci+bounces-44009-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B5E3CF3918
	for <lists+linux-pci@lfdr.de>; Mon, 05 Jan 2026 13:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C4DA13065DCB
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jan 2026 12:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3693338598;
	Mon,  5 Jan 2026 12:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mupTND0i"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9518F2E973F;
	Mon,  5 Jan 2026 12:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767615483; cv=none; b=cP2nlcfas40c3E7TLxSsNhVgdq9aB20ciWq3nyEgqMFx6W4SF1e7LD6TQniVgekQpnImdZD87MxAXENArG2eiD6dQDnWYkaF96Xh2oWIa+lDA8rLovCDWACWQXMY8MXV8Ky+lJZN7UD8V+IkxPeJnnknb7om/sYYjzqFRyM+/pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767615483; c=relaxed/simple;
	bh=B6aeR6wIwEFohveiIghwRfCK7TrLu3JjOBRM0J2lMiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qe3LeW5XRirhKowxYN9ipkNmFk8GxwMi/iOB6GcDvwOxWmeyZLr+k3WjZuGBKwbvXaCSCZ4OQaZ/FhN+XEGlMBsjLNoFiJEavbfcP+9VOQVBmjYwnzvgFBb+pRU7yfITp0SoXpjGMQ9QKvc+Z4OP7FvTzdQkhbhXyNX5+btG3k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mupTND0i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92C43C116D0;
	Mon,  5 Jan 2026 12:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767615483;
	bh=B6aeR6wIwEFohveiIghwRfCK7TrLu3JjOBRM0J2lMiI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mupTND0i6enmTY5XDYiiIe/IhqOsT1n7xuH4ajxnt6B54+KpPppu+1ENyf4CBKGFu
	 2AEaPSCFAShwuDafSR0kcYaa2RtzzuzY74KuvI8jCAqQ980qZyUx/YNHT88VhkkauX
	 6LKyVWH5GIetxkoO3jUGXaQjUtUJvLoAzNaKbeIGxwT83ZqIh+WcNNIKkdb2kw/X3X
	 Je/QvE5e0RoAhMRhdImwX20hWgp4OWFX+IIWox9iJYitquS1NxQkXYKb7J1CvaQAJ0
	 UwkDTQd4g7Ps8SyxagUJvzJ4MZqziUbTRkC/QBXXcq2wJq4+bHfV/1UYNzivup7gSI
	 xiz7dVjnd7xrg==
Date: Mon, 5 Jan 2026 17:47:53 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Jon Hunter <jonathanh@nvidia.com>, 
	Francesco Lavra <flavra@baylibre.com>, thierry.reding@gmail.com, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Mayank Rana <mayank.rana@oss.qualcomm.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Shradha Todi <shradha.t@samsung.com>, Thippeswamy Havalige <thippeswamy.havalige@amd.com>, 
	Inochi Amaoto <inochiama@gmail.com>, Vidya Sagar <vidyas@nvidia.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH] pci: controller: tegra194: remove dependency on Tegra194
 SoC
Message-ID: <r7gwgljfg4mes5bb4bzyty4jivpmerbe34hqauofblhfvfbxia@4xxjv6m2o3i7>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aVurA-MUECufgTw0@ryzen>

On Mon, Jan 05, 2026 at 01:13:55PM +0100, Niklas Cassel wrote:
> On Mon, Jan 05, 2026 at 05:38:34PM +0530, Manivannan Sadhasivam wrote:
> > On Mon, Jan 05, 2026 at 11:56:37AM +0000, Jon Hunter wrote:
> > > 
> > > 
> > > On 05/01/2026 09:09, Niklas Cassel wrote:
> > > > On Mon, Jan 05, 2026 at 02:09:34PM +0530, Manivannan Sadhasivam wrote:
> > > > > On Fri, Jan 02, 2026 at 10:58:15AM +0000, Jon Hunter wrote:
> > > > > > 
> > > > > > On 23/12/2025 06:45, Manivannan Sadhasivam wrote:
> > > > > > > On Wed, Nov 26, 2025 at 11:25:30AM +0100, Francesco Lavra wrote:
> > > > > > > 
> > > > > > > + Tegra maintainers
> > > > > > > 
> > > > > > > > This driver runs (for both host and endpoint operation) also on other Tegra
> > > > > > > > SoCs (e.g. Tegra234).
> > > > > > > > Replace the Kconfig dependency on ARCH_TEGRA_194_SOC with a more generic
> > > > > > > > dependency on ARCH_TEGRA; in addition, amend the Kconfig help text to
> > > > > > > > reflect the fact that this driver is no longer exclusive to Tegra194.
> > > > > > > > 
> > > > > > > 
> > > > > > > I vaguely remember asking about this a while back during some other patch review
> > > > > > > and I don't remember what we concluded.
> > > > > > > > Thierry, Jon, thoughts?
> > > > > > 
> > > > > > So ARCH_TEGRA means that this can be enabled for the legacy 32-bit Tegra
> > > > > > devices as well as the current 64-bit Tegra devices (such as Tegra194).
> > > > > > Given that this driver is only used for Tegra194 and Tegra234, it seems it
> > > > > > would be better to only enable this for Tegra194 and Tegra234 instead of any
> > > > > > Tegra.
> > > > > > 
> > > > > 
> > > > > The dependency means, whenever someone tries to enable PCIE_TEGRA194_HOST,
> > > > > ARCH_TEGRA should be enabled. So as long as someone not trying to enable
> > > > > PCIE_TEGRA194_HOST for 32bit Tegra systems, ARCH_TEGRA should work fine and
> > > > > PCIE_TEGRA194_HOST is not selected by arch/arm/configs/tegra_defconfig. So I
> > > > > don't see any blocker with this patch. In fact, many other archs do the same.
> > > > > 
> > > > > But I don't like extending the Kconfig with per SoC dependency as it won't
> > > > > scale.
> > > > 
> > > > We already have a patch from Vidya:
> > > > [PATCH V4] PCI: dwc: tegra194: Broaden architecture dependency
> > > > that was sent 2025-05-08
> > > > 
> > > > Back then, the reason why it wasn't merged was because it required a
> > > > similar change to the PHY driver to go in first:
> > > > https://lore.kernel.org/linux-pci/174722268141.85510.14696275121588719556.b4-ty@kernel.org/
> > > > 
> > > > The PHY driver change was merged in v6.16:
> > > > 0c2228731974 ("phy: tegra: p2u: Broaden architecture dependency")
> > > > 
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

Ah, I didn't notice your reply, as well as mine at that time :)

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
> 

Maybe it got missed? If Jon could confirm, I'll make the change and apply it.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

