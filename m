Return-Path: <linux-pci+bounces-38123-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA2CBDCB37
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 08:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 53E9A35325F
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 06:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC74E30FF02;
	Wed, 15 Oct 2025 06:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kCjeq1O8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6964D29D26E;
	Wed, 15 Oct 2025 06:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760509361; cv=none; b=lJ4U3pMujWBjYo+F2mxA1DCurJOg6h92WeMm/VOldHcSFpLI68cPET4Sn4/S9a6/d2S1mxodH9ZTUGK8E0apE4M505FdhL4eRoza8y6QCn6pS853MT3ET8y4GMKln0sTQj2cXYlxGpTr0ukZykS9gg2Vku4p8tzDcUrepoIvq+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760509361; c=relaxed/simple;
	bh=GiBaNBK3/IViNyRFvWPC3WNeXPpoK/LfTYw7Mrnj5Bs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jVexC7ii43UEBfLpPCxCIhZEW2k1NnYWVo8kXQBD/+TV+sDKv4P6bzlFbkLwZ5TLhvO2mR6V28m8x/tNQqvBRjC9juPccRgqurgl9wCbhHoe3z81ZQhkoAkaiFxdgoGx93shEyEar6ioys1Ftg/zi97LWCHWMRYR3pwFfWDav8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kCjeq1O8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E57AC4CEF8;
	Wed, 15 Oct 2025 06:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760509360;
	bh=GiBaNBK3/IViNyRFvWPC3WNeXPpoK/LfTYw7Mrnj5Bs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kCjeq1O8SKcnC5uwXJkMGFAUZ9N0PYCklm8+0Bb1n3G9rVunCQUf+gtkbky+uaXYR
	 3w32PUiWGPvCOgFRW9IpLRq5HaCoXNbp2UyffHJlwR5/n1TZh3Ft1xbCq74Lt0QhbT
	 XhfO2BHxHuKbMfAOkBBR4188Ucr22ttit/xCnc9/kND+W6Kh6D8VHKs/G7mhbruvWI
	 VoB9OgsMdnI9kiOB08eO4bX2g9g/dpOJQQG4xuZ6s226rd1vwe9tkgN1Aalkyra9uw
	 YuBoWXL8cvkMZ8rX8T+5j9U/+8okzV6hKGfZRCuEKEVLuQGb8/E81RPFJb012ucGOq
	 Dmv+lTF9PlF3w==
Date: Wed, 15 Oct 2025 11:52:25 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Dragan Simic <dsimic@manjaro.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, FUKAUMI Naoki <naoki@radxa.com>, 
	manivannan.sadhasivam@oss.qualcomm.com, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, "David E. Box" <david.e.box@linux.intel.com>, 
	Kai-Heng Feng <kai.heng.feng@canonical.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Chia-Lin Kao <acelan.kao@canonical.com>, 
	linux-rockchip@lists.infradead.org, regressions@lists.linux.dev
Subject: Re: [PATCH v2 1/2] PCI/ASPM: Override the ASPM and Clock PM states
 set by BIOS for devicetree platforms
Message-ID: <fxakjhx7lrikgs4x3nbwgnhhcwmlum3esxp2dj5d26xc5iyg22@wkbbwysh3due>
References: <20251014184905.GA896847@bhelgaas>
 <0899e629-eaaf-1000-72b5-52ad977677a8@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0899e629-eaaf-1000-72b5-52ad977677a8@manjaro.org>

On Wed, Oct 15, 2025 at 01:33:35AM +0200, Dragan Simic wrote:
> Hello all,
> 
> On Tuesday, October 14, 2025 20:49 CEST, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Wed, Oct 15, 2025 at 01:30:16AM +0900, FUKAUMI Naoki wrote:
> > > I've noticed an issue on Radxa ROCK 5A/5B boards, which are based on the
> > > Rockchip RK3588(S) SoC.
> > > 
> > > When running Linux v6.18-rc1 or linux-next since 20250924, the kernel either
> > > freezes or fails to probe M.2 Wi-Fi modules. This happens with several
> > > different modules I've tested, including the Realtek RTL8852BE, MediaTek
> > > MT7921E, and Intel AX210.
> > > 
> > > I've found that reverting the following commit (i.e., the patch I'm replying
> > > to) resolves the problem:
> > > commit f3ac2ff14834a0aa056ee3ae0e4b8c641c579961
> > 
> > Thanks for the report, and sorry for the regression.
> > 
> > Since this affects several devices from different manufacturers and (I
> > assume) different drivers, it seems likely that there's some issue
> > with the Rockchip end, since ASPM probably works on these devices in
> > other systems.  So we should figure out if there's something wrong
> > with the way we configure ASPM, which we could potentially fix, or if
> > there's a hardware issue and we need some king of quirk to prevent
> > usage of ASPM on the affected platforms.
> > 
> > Can you collect a complete dmesg log when booting with
> > 
> >   ignore_loglevel pci=earlydump dyndbg="file drivers/pci/* +p"
> > 
> > and the output of "sudo lspci -vv"?
> > 
> > When the kernel freezes, can you give us any information about where,
> > e.g., a log or screenshot?
> > 
> > Do you know if any platforms other than Radxa ROCK 5A/5B have this
> > problem?
> 
> After thinking quite a bit about it, I think we should revert this
> patch and replace it with another patch that allows per-SoC, or
> maybe even per-board, opting into the forced enablement of PCIe
> ASPM.  Let me explain, please.
> 

ASPM is a PCIe device specific feature, nothing related to SoC/board. Even if
you limit it to certain platforms, there is no guarantee that it will be safe as
the users can connect a buggy device to the slot and it could lead to the same
issue.

> When a new feature is introduced, it's expected that it may fail
> on some hardware or with some specific setups, so quirking off such
> instances, as time passes, is perfectly fine.  Such a new feature
> didn't work before it was implemented, so it's acceptable that it
> fails in some instances after the introduction, and that it gets
> quirked off as time passes and more testing is performed.
> 

ASPM is not a new feature. It was introduced more than a decade before. But we
somehow procastinated the enablement for so long until we realized that if we
don't do it now, we wouldn't be able to do it anytime in the future.

> However, when some widespread feature, such as PCIe, has already
> been in production for quite a while, introducing high-risk changes
> to it in a blanket fashion, while intending to have the incompatible
> or not-yet-ready platforms quirked off over time, simply isn't the
> way to go.  Breaking stuff intentionally to find out what actually
> doesn't work is rarely a good option.
> 

The issue is due to devices exposing ASPM capability, but behaving erratically
when enabled. Until, we enable ASPM on these devices, we cannot know whether
they are working or not. To avoid mass chaos, we decided to enable it only for
devicetree platforms as a start.

> Thus, I'd suggest that this patch is replaced with nother patches,
> which would introduce an additional ASPM opt-in switch to the PCI
> binding, allowing SoCs or boards to have it enabled _after_ proper
> testing is performed.  The PCIe driver may emit a warning that ASPM
> is to be enabled at some point in the future, to "bug" people about
> the need to perform the testing, etc.

Even if we emit a "YOUR DEVICE MAY BREAK" warning, nobody would care as long as
the device works for them. We didn't decide to enable this feature overnight to
trouble users. The fact that ASPM saves runtime power, which will benefit users
and ofc the environment as a whole, should not be kept disabled.

But does that mean, we wanted to have breakages, NO. We expected breakages as
not all devices will play nicely with ASPM, but there is only one way to find
out. And we do want to disable ASPM only for those devices.

>  With all that in place, we
> could expect that in a year or two PCIe ASPM could eventually be
> enabled everywhere.  Getting everything tested is a massive endeavor,
> but that's the only way not to break stuff.
> 
> Biting the bullet and hoping that it all goes well, I'd say, isn't
> the right approach here.
> 

Your two year phased approach would never work as that's what we have hoped for
more than a decade.

- Mani


-- 
மணிவண்ணன் சதாசிவம்

