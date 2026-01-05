Return-Path: <linux-pci+bounces-44044-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B685BCF4FC0
	for <lists+linux-pci@lfdr.de>; Mon, 05 Jan 2026 18:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 811DC30185F0
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jan 2026 17:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE52133B95B;
	Mon,  5 Jan 2026 17:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AofVgm4I"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923B533A036;
	Mon,  5 Jan 2026 17:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767633945; cv=none; b=AubOIFWpRqv7MwN/NSoctKIg2eKkmEK1ZUbgVVm5o7EMEP6qUMTHKt32G3xu7AQc9O/dnHCHLpUBygKoKctrqkCLLNnTzR3MofUkYgr2DcjtOPpAX1SfbqL83SiFYw7rsdIKrp51gDG5KSewvLtgX0h0snM6bWxRZv8Jr/PRuiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767633945; c=relaxed/simple;
	bh=yECq9Pg5qwIQCTGjYI+cgz+yczoMQEDsLhbkf0Ix9/g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=fQJuZyMk/134vCEE2xG6t5HpoGtie35FMYX23JuMGhCURCaukbyMa3p1J/U5sLg0+he+lGlKJFJwZwzpxlC0tOUU4byo4bPWB0TY9qBju9L/RXSq6Q/7RV0gCIf7xI9qWX98Y7njeAeBSV8Z1zV3BmQakPPPyd9r9s7eK9yoJ8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AofVgm4I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E26B1C116D0;
	Mon,  5 Jan 2026 17:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767633945;
	bh=yECq9Pg5qwIQCTGjYI+cgz+yczoMQEDsLhbkf0Ix9/g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=AofVgm4INyuCrEfqjmcCQK+Rz+kAJlDEzMrErH+w9xwVYvVFiP/LJ3/EPtoo5xP2a
	 WDvS81SE99+mRj/6WHQV8U7y3tB/BQGPzMiskZXg4OpEgI/WytPH28zCjDerp85LHW
	 kXbpGYZo0lxcZDDJmZltcdjyvVxs2SFOAbeg/MZfNzFGfi9LrI4rnf5TzrsSSin8f8
	 oQK0hySnBbGyGIGoWp74sItIIsI5ckyt4IzRRGTzQDf5fTo+JsyqkLK3fHo85NQSbj
	 oqeA/GjJp4p32ReA4/rcJ7qf432O1OwnEVqfoeMfjkHFpbpgNX+v4w3PkVvKEXvgGX
	 lShUYdwzpVzRA==
Date: Mon, 5 Jan 2026 11:25:43 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Yue Wang <yue.wang@amlogic.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Linnaea Lavia <linnaea-von-lavia@live.com>,
	FUKAUMI Naoki <naoki@radxa.com>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	stable@vger.kernel.org, Ricardo Pardini <ricardo@pardini.net>
Subject: Re: [PATCH] PCI: meson: Remove meson_pcie_link_up() timeout,
 message, speed check
Message-ID: <20260105172543.GA320987@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFBinCAPpiq=M00ZQXAB4Pu2Myjo8gpXC7DByKkGN6Z_Ahqafg@mail.gmail.com>

On Mon, Jan 05, 2026 at 05:49:00PM +0100, Martin Blumenstingl wrote:
> On Thu, Dec 18, 2025 at 7:06 AM Manivannan Sadhasivam
> <manivannan.sadhasivam@oss.qualcomm.com> wrote:
> >
> >
> > On Mon, 03 Nov 2025 16:19:26 -0600, Bjorn Helgaas wrote:
> > > Previously meson_pcie_link_up() only returned true if the link was in the
> > > L0 state.  This was incorrect because hardware autonomously manages
> > > transitions between L0, L0s, and L1 while both components on the link stay
> > > in D0.  Those states should all be treated as "link is active".
> > >
> > > Returning false when the device was in L0s or L1 broke config accesses
> > > because dw_pcie_other_conf_map_bus() fails if the link is down, which
> > > caused errors like this:
> > >
> > > [...]
> >
> > Applied, thanks!
> >
> > [1/1] PCI: meson: Remove meson_pcie_link_up() timeout, message, speed check
> >       commit: 11647fc772e977c981259a63c4a2b7e2c312ea22
>
> My understanding is that this is queued for -next.
>
> Ricardo (Cc'ed) reported that this patch fixes PCI link up on his
> Odroid-HC4.  Is there a chance to get this patch into -fixes, so it
> can be pulled by Linus for one of the next -rc?

The Fixes tag is for 9c0ef6d34fdb ("PCI: amlogic: Add the Amlogic
Meson PCIe controller driver"), which appeared in v5.0 in 2019, so it
was a latent issue since then.  v5.0 kernels built with
CONFIG_PCIEASPM_POWERSAVE=y or CONFIG_PCIEASPM_POWER_SUPERSAVE=y
should show the same problem.

But I think that latent issue became obvious when the following two
commits essentially made CONFIG_PCIEASPM_POWERSAVE the default for
devicetree platforms:

  f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM states for devicetree platforms")
  df5192d9bb0e ("PCI/ASPM: Enable only L0s and L1 for devicetree platforms")

Those two commits appeared in v6.18, so I think we can make a case
that it fixes a recent problem and is thus material for the current
release.

Moved to for-linus for v6.19 and squashed your unused
WAIT_LINKUP_TIMEOUT fix.  Thanks!

Bjorn

