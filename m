Return-Path: <linux-pci+bounces-44790-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A9EFD20AFC
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 18:56:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1AC853015E32
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 17:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B17A32D7F3;
	Wed, 14 Jan 2026 17:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ojI72Yvk"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F9B32D0DE;
	Wed, 14 Jan 2026 17:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768413352; cv=none; b=KFnGZbOqmkHgGDDO6iAOiZG/nLSvWExwcLv/So4ZvcXneJGcQ/1sLjZP+RWUVfbU7EN3SFnxqxxukYSi8uZ8Ff2T4Ss/rHGn5UOLOCBO2bAYZPUoannbTeG9ll+TnxUOAza4y3lAovAVdcu7YHFd7SnlRmLumTLRIdb3/NGOyvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768413352; c=relaxed/simple;
	bh=85aLRNEHEkA+y/0x+IaTA4RZZV/k53QvUVMGNx2gCqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=BE1SoFwMwt3ynS7Lm9ydoxDLtjVOHFrigW5w4OEp9gnRtSawa1VM5KzhuH6y/s6lCslTQRrxMraM4d4jIbMvrl6tzTj3VxNqn8bL2mXTuEjiSKD7Lsropsj588tlnwrmTQJ+ocO8Hv2TLqxn37QNsFnToxvUyA7OVQEBuT1wV70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ojI72Yvk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AD22C4CEF7;
	Wed, 14 Jan 2026 17:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768413352;
	bh=85aLRNEHEkA+y/0x+IaTA4RZZV/k53QvUVMGNx2gCqQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ojI72YvkODnsbzXO1TLETOdFJKj/bbWdnckgyNnKqp1QHbSQyNNdcbnAPZJwUHFhh
	 XjJQqN4AGNoQTYr05dG+lvhJ4g10vcXEpawIemjwAEm+n6o1LHZIwK7GmuCEhwLCRx
	 LMgRDEbplVjaczzM3Pjcay18RWhkLhzM1yPnmK6pwD5wNd5RmsiddF/r8B2F5Vwmqx
	 KJkryUAlNjh8MFI/9hY8yZgN7pUb2LMUlk2WuYIjAxcHwbrBSykd0to61visnYRkLu
	 htIwHR2dax9tVt0e9MITzHNuVMHOcJyCWJLcj63189Hmyu9BhgfIbtGixRkVNYGb5O
	 VPHSaHzFL5jBw==
Date: Wed, 14 Jan 2026 11:55:50 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ahmed Naseef <naseefkm@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [QUESTION] pci_read_bridge_bases: skip prefetch window if
 pref_window not set?
Message-ID: <20260114175550.GA825847@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWdG/9N2C/7L5sFQ@DESKTOP-TIT0J8O.localdomain>

On Wed, Jan 14, 2026 at 11:34:23AM +0400, Ahmed Naseef wrote:
> On Tue, Jan 13, 2026 at 03:02:59PM -0600, Bjorn Helgaas wrote:
> > On Mon, Jan 12, 2026 at 01:41:00PM +0400, Ahmed Naseef wrote:
> > >   [  160.238227] mtk-pcie 1fb83000.pcie: EN7528: port1 link trained to Gen2
> > 
> > Can we look forward to a patch to add support for EN7528?
> 
> Definitely. Someone else is working on PCIe support for EN751221
> (same SoC family). Once everything is consolidated, we plan to submit
> a unified patch to drivers/pci/controller/pcie-mediatek.c.

Great, will watch for that!

> > > PCI_PREF_MEMORY_LIMIT which both return 0x0000. This results in base = 0
> > > and limit = 0. The condition "if (base <= limit)" evaluates to true
> > > (since 0 <= 0), so a bogus prefetch window [mem 0x00000000-0x000fffff pref]
> > > is created.
> > 
> > It's too bad we didn't log this in dmesg.  It looks like we claimed
> > there was a [mem 0x28100000-0x282fffff pref] window.
> 
> Should I add logging for this as part of the patch? If so, could you
> suggest where and what format would be appropriate?

Apparently there's a place where we figured out that 01:00.0 has a
prefetchable window at [mem 0x28100000-0x282fffff pref]:

  [  160.546094] pci 0001:00:01.0:   bridge window [mem 0x28100000-0x282fffff pref]

I don't know how we figured that out if PCI_PREF_MEMORY_BASE and
PCI_PREF_MEMORY_LIMIT are hardwired to zero.  Another mystery worth
exploring.

In any event, it sounds like there's another place later where we make
a bogus [mem 0x00000000-0x000fffff pref] window?  That point, where we
change the window, is where I would think about adding a message.

> From: Ahmed Naseef <naseefkm@gmail.com>
> Subject: [PATCH] PCI: Skip bridge window reads when window is not supported
> 
> pci_read_bridge_io() and pci_read_bridge_mmio_pref() read bridge window
> registers unconditionally. If the registers are hardwired to zero
> (not implemented), both base and limit will be 0. Since (0 <= 0) is
> true, a bogus window [mem 0x00000000-0x000fffff] or [io 0x0000-0x0fff]
> gets created.
> 
> pci_read_bridge_windows() already detects unsupported windows by
> testing register writability and sets io_window/pref_window flags
> accordingly. Check these flags at the start of pci_read_bridge_io()
> and pci_read_bridge_mmio_pref() to skip reading registers when the
> window is not supported.
> 
> Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
> Signed-off-by: Ahmed Naseef <naseefkm@gmail.com>
> ---
> 
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -351,6 +351,9 @@ static void pci_read_bridge_io(struct pc
>         unsigned long io_mask, io_granularity, base, limit;
>         struct pci_bus_region region;
> 
> +       if (!dev->io_window)
> +               return;
> +
>         io_mask = PCI_IO_RANGE_MASK;
>         io_granularity = 0x1000;
>         if (dev->io_window_1k) {
> @@ -412,6 +415,9 @@ static void pci_read_bridge_mmio_pref(st
>         pci_bus_addr_t base, limit;
>         struct pci_bus_region region;
> 
> +       if (!dev->pref_window)
> +               return;
> +
>         pci_read_config_word(dev, PCI_PREF_MEMORY_BASE, &mem_base_lo);
>         pci_read_config_word(dev, PCI_PREF_MEMORY_LIMIT, &mem_limit_lo);
>         base64 = (mem_base_lo & PCI_PREF_RANGE_MASK) << 16;

This looks good.  But I guess I would like to understand better how we
figured out the addresses for the prefetchable window.  Things like
that niggle at me.

Bjorn

