Return-Path: <linux-pci+bounces-40763-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E39D3C4928F
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 20:59:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA87E188A5A8
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 19:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26624289E13;
	Mon, 10 Nov 2025 19:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HaLaT3JM"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C1618A956;
	Mon, 10 Nov 2025 19:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762804756; cv=none; b=ZXh1vSBQYmdAp/WZdlMy7Zd/NwM9ESDdpEIMTHhzqyU4JtQe3lUCl+tTE9vCa4QUYUiskZzEUQBIBnyPLwFDVVz5LRTeNV+yQwj3IzrR5XO5NZw77zY5cQ3EyLkHHfU1O/P2ePmge5gp9pAimJ8o4FdCZT3WHbdpoRU/vEnnJcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762804756; c=relaxed/simple;
	bh=wTnqwKhS+4PIH92TTwaqkXzXibgTx5JR53nrD4Z6ed4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KiJ9nBm9U3Q0m62TFEqazRlvRr1At0KT8/7SINAJc5Wm7igx9hkBPctLC90b+eUj+UJrKqGDK3zmoLqFNBsloRfbSXfbUY9CNUexNr4l+qLEgLn32kSEyM3TY9DlYXw6mnUWMyOspqpVlsrqT/55wkvTK98y1dpE2qDc2mLi3KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HaLaT3JM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9D79C116B1;
	Mon, 10 Nov 2025 19:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762804755;
	bh=wTnqwKhS+4PIH92TTwaqkXzXibgTx5JR53nrD4Z6ed4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HaLaT3JMP3hIC3CDosn1iMi1gDO/ywlO3P/pwUD8CTRbVSSwNbZrKB1DME5dhEYN0
	 p1P9Dl+JZXXEdBP4rBLJ93uFiMublnmBr9MWG/g1zq6Go5+L0UPdfk3x+Tm2Epdzgz
	 pmHbp5ZVfEy6HzE7oMEKCpuxu/wcScdtQs3XKu/hy2HXEcG++sqkvPw9tMKpsTmOMz
	 6KQyP7o0g3SZpvXAPt3wCVw4UoVn8vVFj/MCEEmTljRMkYkBZwsvpw7g2qacJmuzwA
	 Tuefvy8TiAyC9r7GnuL1MGyEJ8fCsDiVypDeLEdxo4UahbFRpEo1f4TFeLdjuGnt3P
	 DRoQiSAlHQ/Tw==
Date: Mon, 10 Nov 2025 20:59:08 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, FUKAUMI Naoki <naoki@radxa.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Anand Moon <linux.amoon@gmail.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	Dragan Simic <dsimic@manjaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>
Subject: Re: [RESEND] Re: [PATCH] PCI: dw-rockchip: Skip waiting for link up
Message-ID: <aRJEDEEJr9Ic-RKN@fedora>
References: <55EB0E5F655F3AFC+136b89fd-98d4-42af-a99d-a0bb05cc93f3@radxa.com>
 <aRCI5kG16_1erMME@ryzen>
 <F8B2B6FA2884D69A+b7da13f2-0ffb-4308-b1ba-0549bc461be8@radxa.com>
 <780a4209-f89f-43a9-9364-331d3b77e61e@rock-chips.com>
 <4487DA40249CC821+19232169-a096-4737-bc6a-5cec9592d65f@radxa.com>
 <363d6b4d-c999-43d4-866e-880ef7d0dec3@rock-chips.com>
 <0C31787C387488ED+fd39bfe6-0844-4a87-bf48-675dd6d6a2df@radxa.com>
 <dc932773-af5b-4af7-a0d0-8cc72dfbd3c7@rock-chips.com>
 <aRHb4S40a7ZUDop1@ryzen>
 <2n3wamm3txxc6xbmvf3nnrvaqpgsck3w4a6omxnhex3mqeujib@2tb4svn5d3z6>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2n3wamm3txxc6xbmvf3nnrvaqpgsck3w4a6omxnhex3mqeujib@2tb4svn5d3z6>

On Mon, Nov 10, 2025 at 09:23:02PM +0530, Manivannan Sadhasivam wrote:
> > 
> > Considering what Shawn says, that the switch gets enumerated properly
> > if we simply add a msleep() in ->start_link(), which will be called
> > by dw_pcie_host_init() before pci_host_probe() is called...
> > 
> 
> Yes, that delay probably gives enough time for the link up IRQ to kick in before
> the initial bus scan happens.

I think that the problem is that even for platforms with link up IRQ,
we will always do:
1) dw_pcie_start_link() (if (!dw_pcie_link_up()))
2) pci_host_probe() from dw_pcie_host_init(), this will enumerate the bus
3) pci_rescan_bus() from the Link Up IRQ handler

Thus, in 2, when enumerating the bus, without performing any of the delays
mandated by the PCIe spec, it still seems possible to detect a device (it
must have been really quick to initialize), and to communicate with that
device, however since we have not performed the delays mandated by the spec,
it appears that the device might not yet behave properly.

Hence my suggestion to never call pci_host_probe() in dw_pcie_host_init()
for platforms with Link Up IRQ.

At least for pcie-dw-rockchip.c, we only unmask the Link Up IRQ after
dw_pcie_host_init() has returned, so I think that your theory: that Shawn's
suggested delay causes the Link Up IRQ to kick in before the initial bus
scan, is incorrect. (Since the IRQ should not be able to trigger until
dw_pcie_host_init() has returned.)


> 
> > ...we already have a delay in the link up IRQ handler, before calling
> > pci_rescan_bus().
> > 
> 
> That delay won't help in this case.

Sure, I was just saying that even though Shawn's patch made things work,
it seems incorrect, as we do not want to add "the same delay" that we
already have in the Link Up IRQ. (The delay in the Link Up IRQ should be
the only one.)


> > I think a better solution would be something like:

(snip)

> This solution will work as long as the PCIe device is powered ON before
> start_link(). For CEM and M.2 Key M connectors, the host controller can power
> manage the components. But for other specifications/keys requiring custom power
> management, a separate driver would be needed.
> 
> That's why I suggested using pwrctrl framework as it can satisfy both usecases.
> However, as I said, it needs a bit of rework and I'm close to submitting it.
> 
> But until that gets merged, either we need to revert your link up IRQ change or
> have the below patch. IMO, the revert seems simple.

Using pwrctrl framework once it can handle this use case sounds good to me.

FUKAUMI, could you please send a revert of the two patches?


Kind regards,
Niklas

