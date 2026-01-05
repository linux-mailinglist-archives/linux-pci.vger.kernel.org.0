Return-Path: <linux-pci+bounces-44000-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6ABCF344E
	for <lists+linux-pci@lfdr.de>; Mon, 05 Jan 2026 12:32:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A66AE3009221
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jan 2026 11:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3801A33858E;
	Mon,  5 Jan 2026 11:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nAYck1k2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FA0338581
	for <linux-pci@vger.kernel.org>; Mon,  5 Jan 2026 11:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767611202; cv=none; b=nAmyCQQMxQXdslmUYMBCzzxa5mlqtAoReAI/W6jK2y1PWCFfWAiVA3Tt65ER2myuD5xvr3xl8DMZV7a3MuvG+W7t7MwVWX11p7+6b4d3KELPqnEu+E89fuNCiWELdOKlSIjRWLd4/TSSUMXRNdwsB98BmYNoYQbDMeZCNMvUv8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767611202; c=relaxed/simple;
	bh=57FWld+XwI+aYRqi/11GRuJ3H7SFEpiahq4Vv+hSAis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=odKdC5KjX4s0+9CTTxX+VD+t/L/y+3QqArCp/MQYy1yIFnoFFY9MEvnuiJrIp8F2AeiSG/WQtI1eIwjeingNC/O02sXmKij88Egbrqvin3zkg+XZJnIqgjxQoL/gpHKAduV8kvyLpakJNdjQwU/DH2+598l+LYUYfkVHTsEYtck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nAYck1k2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34029C116D0;
	Mon,  5 Jan 2026 11:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767611201;
	bh=57FWld+XwI+aYRqi/11GRuJ3H7SFEpiahq4Vv+hSAis=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nAYck1k2vKcDTAqP+069tcejmUNnbPtiCb9QbrOGHi9M4yAf9tQGSI7m4nC4evcMQ
	 1uTyHTshrpX9Pz9gz2JNEpdnmpbniH6s5795zH0tLIeYcx0Xho1gc1ieHGJSf7YHdi
	 HtDu9d8MSbHyJlUSPnMXKtTbwy8nyxrqCVBufkcwuvW7I1JjWTmjmvpZN2hqxmr8QQ
	 Alv/hi0Lwo0DvntHiCpubi7nwMbnD8tsquv9/iEZFM8AmqZqpifdzXX+sv8YOONyCc
	 PJMK87bopQ0aHstWLOAkxoOVRGuxx7nV4XdPoYQG0tMGD2vY1d+hu9QPEf/Lv6tpkb
	 c3qQLXNeB4QPw==
Date: Mon, 5 Jan 2026 12:06:37 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>,
	Manivannan Sadhasivam <mani@kernel.org>
Cc: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Frank Li <Frank.Li@nxp.com>, Damien Le Moal <dlemoal@kernel.org>,
	Koichiro Den <den@valinux.co.jp>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: dwc: ep: Cache MSI outbound iATU mapping
Message-ID: <aVubPUphGP59bH09@ryzen>
References: <20251210071358.2267494-2-cassel@kernel.org>
 <8e00bd1c-29ae-43fd-90e8-ea0943cb02b6@oss.qualcomm.com>
 <s5mbvhnummcegksauc7kyb2442ao27dwc63gyryetuvxojnxfj@a67nopel52tx>
 <aUknSzSpNxLeEN5o@ryzen>
 <3b34aa66-a418-4f6b-930a-0728d87d79b6@oss.qualcomm.com>
 <aUlA7y95SUC-QA4T@ryzen>
 <a24a5d8b-5818-4e11-bc09-47090de164c7@rock-chips.com>
 <63321b7d-74a7-448f-ab20-08cc771beb5d@oss.qualcomm.com>
 <424133b7-bd6b-4602-96ea-4413ce4f985d@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <424133b7-bd6b-4602-96ea-4413ce4f985d@rock-chips.com>

Hello all,

On Tue, Dec 23, 2025 at 02:23:39PM +0800, Shawn Lin wrote:
> > > I checked the IP configurtion parameters for RK3588 DM controller for
> > > sure, it sets MSIX_TABLE_EN=1.
> > > 
> > > Looking into dw_pcie_ep_raise_msix_irq_doorbell(), it doesn't seem to
> > > match the dwc databook. No matter for non-AXI mode or AXI access mode,
> > > shouldn't we need to generate a MSI-X table RAM with data/address/
> > > vector/TC in advanced? Am I missing anything because I didn't look
> > The MSI-X table will updated automatically when host updates the MSI-X
> > table, when MSI-X is enabled
> > by host.
> 
> Thanks for these details.
> I re-read the databook, especially "Figure 3-49 iMSIX-TX: MSIX
> Transmit ". Yes, it's updated automatically when host write access
> it, which either comes from RX or local DBI(for debug purpose).

With the help of Shawn, I managed to get dw_pcie_ep_raise_msix_irq_doorbell()
to work on RK3588.

By default, on RK3588, the MSI-X table is stored in BAR4 at offset 0x4000.

There seems to be a limitation that the iMSIX-TX doorbell feature only
works when the MSI-X table is stored in this default location.


As you know, by default, pci-epf-test stores the MSI-X table in BAR0,
after the registers defined by pci-epf-test itself.
This works fine when triggering a MSI-X using dw_pcie_ep_raise_msix_irq(),
but does not work when using dw_pcie_ep_raise_msix_irq_doorbell() (at least
not or RK3588).

Additionally, on RK3588, at offset 0x0 in BAR4, the eDMA registers are
mapped, so we cannot simply use BAR4 as test_reg_bar, as that would conflict
with the registers defined by pci-epf-test-itself.


The solution here is most likely to let EPC drivers define a
"HW limitation" of the MSI-X table (BAR number and offset), and create a new
API in the PCI endpoint framework that exposes this, and modify all EPF
drivers to use this API before calling pci_epc_set_msix().


Personally, I'm too busy to work on this right now.
For our use case with the NVMe PCI EPF, we can simply force it to only
use MSI (instead of MSI-X).

But... I could submit a WARN() in dw_pcie_ep_raise_msix_irq() that explains
that this function is broken, and that dw_pcie_ep_raise_msix_irq_doorbell()
should be used instead, on platforms that support it.

Or, if it is preferred, we could simply modify all DWC based drivers that is
not using dw_pcie_ep_raise_msix_irq_doorbell() (i.e. all except layerspace)
to simply not set "msix_capable = true" in epc_features, as we know that all
drivers that are using dw_pcie_ep_raise_msix_irq() are broken.

Thoughts?


Kind regards,
Niklas

