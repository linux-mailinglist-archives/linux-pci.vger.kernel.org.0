Return-Path: <linux-pci+bounces-17722-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C23219E4A24
	for <lists+linux-pci@lfdr.de>; Thu,  5 Dec 2024 00:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5AF716228C
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 23:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF492066CE;
	Wed,  4 Dec 2024 23:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lbvnWolI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3949B1F7090;
	Wed,  4 Dec 2024 23:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733355923; cv=none; b=RjYVc71kyyH28gKkmwQZk1Ez3DYpe6ev0x2ZMREXQWGgIsEEepbgeiK9N1mcJpYDn6yjgT3zs/3ZMHbCFPVHZ1O291QKtb8IBo52AJgd0FBetXP8eXUXznRGGKW6V3vtG1jx4W/oZfe9+dW67b3BVqMJnhhFEeMsKLnoYoQRlCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733355923; c=relaxed/simple;
	bh=z7AWWg34fLrhF9G3JhauMZtLU2MAusRLa3ZDUkavrd8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=D6soTs7YgzTa6YDZm6zru7e7vLzjfcf4c7RNKrbqj99xqDQjrsnYFeAC3azKrNvqeX3f04RZ6FSIJdRV52WGoNKhce64gyVaGkGXrurqB8dvTWVI9wlIjGzWQr2Eb5dHtgDp7+4lMxWn82rfCYp8IDRLgIPnRHbOp5Z3FANG5yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lbvnWolI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 942FFC4CECD;
	Wed,  4 Dec 2024 23:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733355922;
	bh=z7AWWg34fLrhF9G3JhauMZtLU2MAusRLa3ZDUkavrd8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=lbvnWolIH8D/c3+N2z/nrC6h6Qebbdk7Cj6tj2mbukK3K/yNeoj9BbsY8d2p7ebbL
	 2MXKx4dxTDM9z+13wkte9qREpZlm3R3YMdFIpEM2K/TRxk/XeLvC1GnFhIVa7sUcNR
	 oYqVpNtrjFkUblJLOKq4AzFRV/rmGJoKBXAOGJqtrp9nsmpte4Zl2VztNhG8VfIXzx
	 51CaghtyTvlfM+x+TqtH4Ouzm0RaQDgjUvlQy6npSWl9ZZB7JtkpzEvJslZrZQ9tLz
	 cZWnbtZ6xt/CSUg72427fd8YTKERcqqyib4YqV0WT4PSjU11VwUSmbRiy1NxG1mvbe
	 6CGzVAaPbz9Yw==
Date: Wed, 4 Dec 2024 17:45:21 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mario Limonciello <superm1@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"open list : PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list : USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
	Daniel Drake <drake@endlessos.org>, Gary Li <Gary.Li@amd.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v5 0/5] Verify devices transition from D3cold to D0
Message-ID: <20241204234521.GA3028067@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaac430f-ba1a-47ee-a290-0bb1559dcf24@kernel.org>

On Wed, Dec 04, 2024 at 11:30:51AM -0600, Mario Limonciello wrote:
> On 8/23/2024 10:40, Mario Limonciello wrote:
> > From: Mario Limonciello <mario.limonciello@amd.com>
> > 
> > Gary has reported that when a dock is plugged into a system at the same
> > time the autosuspend delay has tripped that the USB4 stack malfunctions.
> > 
> > Messages show up like this:
> > 
> > ```
> > thunderbolt 0000:e5:00.6: ring_interrupt_active: interrupt for TX ring 0 is already enabled
> > ```
> > 
> > Furthermore the USB4 router is non-functional at this point.
> > 
> > Those messages happen because the device is still in D3cold at the time
> > that the PCI core handed control back to the USB4 connection manager
> > (thunderbolt).
> > 
> > The issue is that it takes time for a device to enter D3cold and do a
> > conventional reset, and then more time for it to exit D3cold.
> > 
> > This appears not to be a new problem; previously there were very similar
> > reports from Ryzen XHCI controllers.  Quirks were added for those.
> > Furthermore; adding extra logging it's apparent that other PCI devices
> > in the system can take more than 10ms to recover from D3cold as well.
> > 
> > This series add a wait into pci_power_up() specifically for D3cold exit and
> > then drops the quirks that were previously used for the Ryzen XHCI controllers.
> > 
> > Mario Limonciello (5):
> >    PCI: Use an enum for reset type in pci_dev_wait()
> >    PCI: Check PCI_PM_CTRL instead of PCI_COMMAND in pci_dev_wait()
> >    PCI: Verify functions currently in D3cold have entered D0
> >    PCI: Allow Ryzen XHCI controllers into D3cold and drop delays
> >    PCI: Drop Radeon quirk for Macbook Pro 8.2
> > 
> >   drivers/pci/pci-driver.c    |  2 +-
> >   drivers/pci/pci.c           | 70 +++++++++++++++++++++++++++----------
> >   drivers/pci/pci.h           | 13 ++++++-
> >   drivers/pci/pcie/dpc.c      |  2 +-
> >   drivers/pci/quirks.c        | 25 -------------
> >   drivers/usb/host/xhci-pci.c | 11 ------
> >   6 files changed, 66 insertions(+), 57 deletions(-)
> 
> Bjorn,
> 
> This series has stalled a while.
> 
> Mika and I went back and forth and I think are generally in agreement so I
> think it's waiting on your feedback.
> 
> Can you take another look?
> 
> The alternative is to add some more piles of quirks, but I'm hoping that we
> can go this direction and drop a bunch of the old ones instead.
> 
> LMK if you want me to rebase it on 6.13-rc1 and resend a v6.

I'm still stuck on patch 2/5 because I'm not aware of any spec
language about polling PCI_PM_CTRL to wait for a power state
transition, so it seems really ad hoc.

If you do rebase to v6.13-rc1, in the 2/5 commit log,
s/evices/devices/.

I guess that whole patch and commit log needs updating since the RRS
code was added to pci_dev_wait() in the interim, so the "device that
has gone through a reset may return a value in PCI_COMMAND but that
doesn't mean it's finished transitioning to D0" doesn't directly apply
anymore.

Bjorn

