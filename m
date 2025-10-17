Return-Path: <linux-pci+bounces-38486-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B58DBE9ED9
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 17:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A55CA743B2A
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 15:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66AB433291C;
	Fri, 17 Oct 2025 15:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TqmvhnCx"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3697B2F12B0;
	Fri, 17 Oct 2025 15:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760713958; cv=none; b=cebjW5IhSLFjSqmpa0Zgms8HTp0ZzJ5zds3Woh3kT0+rgQwN8e6HYxRpwmtFoZ1kLRBk05YzbrNR6uR1cycN2dKkFccTalf5Q+OcPUsJXtFvDwVDRA8MUQcqzpcd1zNvoi+LCy+XJLXP/dVtATLsVGmCXgMdM2cyMDAilVAso7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760713958; c=relaxed/simple;
	bh=1IuDydb9LVnh3/OC5wI1BZmlPhEFBAW9Ll+jAbKHxOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ogAYsYGvimzHhOemM9kDvkfVQKsCbd0YYWoFBAQl8CXcgOUHdIePUX/yeEEPEbHBpUj5Q3js1Q4EqGxDaxo4ZXWZNFtmuyaT3eOe7xF72ch+/rOcaHkSIH7w6s0HX7GxobpZ8+RyKlAxeaUd7N/vFUbS9WDgqSnYIRDAVrAUf/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TqmvhnCx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32F68C4CEF9;
	Fri, 17 Oct 2025 15:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760713958;
	bh=1IuDydb9LVnh3/OC5wI1BZmlPhEFBAW9Ll+jAbKHxOM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TqmvhnCx3DrRFih0Hvwau0ZVDoNCUJBx/O3sVu/j1ssqtkREF1YfTzvFlfcOU8RUF
	 BvcqKmld1ZylivNmpGNRG+umisrT0IU0Hmhookb0+BazONDjWGtolHdNWRmyytUZoW
	 GPo8oO/pz2i5AsSkGGDG57DxH6z572pZUF45xM7uT+RFmQ5YgDLC3/6jmzhGVOofP1
	 V6RcGG4IADuHO9+fa3Ww81AX6nfzzaZw0saKuI5pfVW/e9vZNAefSIkgRcukNsv7cE
	 nsOrylVfJ/ms0A/d1ED1auwPhg5lujqGB2UNjVyDThzlzJg7CK0GP7zbIOl9m06xet
	 f9YIKqKW9isxg==
Date: Fri, 17 Oct 2025 20:42:24 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Chester Lin <chester62515@gmail.com>, 
	Matthias Brugger <mbrugger@suse.com>, Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>, 
	NXP S32 Linux Team <s32@nxp.com>, bhelgaas@google.com, jingoohan1@gmail.com, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, krzk+dt@kernel.org, 
	Conor Dooley <conor+dt@kernel.org>, Ionut.Vicovan@nxp.com, Larisa Grigore <larisa.grigore@nxp.com>, 
	Ghennadi Procopciuc <Ghennadi.Procopciuc@nxp.com>, ciprianmarian.costea@nxp.com, 
	Bogdan Hamciuc <bogdan.hamciuc@nxp.com>, Frank Li <Frank.li@nxp.com>, 
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, imx@lists.linux.dev, Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH 1/3 v2] dt-bindings: PCI: s32g: Add NXP PCIe controller
Message-ID: <nzznoiri4n7krpid4lp4pax2dge6vwdj3eqyxqob4bzf6gmlzy@a6moyj74ehzp>
References: <20250919155821.95334-2-vincent.guittot@linaro.org>
 <iom65w7amxqf7miopujxeulyiglhkyjszjc3nd4ivknj5npcz2@bvxej6ymkecd>
 <aOU0w5Brp6uxjZDr@lpieralisi>
 <4rghtk5qv4u7vx4nogctquu3skvxis4npxfukgtqeilbofyclr@nhkrkojv3syh>
 <eba7d968-209d-4acb-ba41-4bebf03e96ba@app.fastmail.com>
 <4143977f-1e70-4a63-b23b-78f87d9fdcde@app.fastmail.com>
 <2erycpxudpckmme3k2cpn6wgti4ueyvupo2tzrvmu7aqp7tm6d@itfj7pfrpzzg>
 <3d480f73-15b4-4fb8-8d2b-f9961c1736ca@app.fastmail.com>
 <4kvo2qg2til22hlssv7lt2ugo63emr5c4hfjur5m3vnxvpdekx@jcbhaxb2d2j2>
 <839e3878-ae62-4c8b-a74b-ac4f6f060d98@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <839e3878-ae62-4c8b-a74b-ac4f6f060d98@app.fastmail.com>

On Thu, Oct 09, 2025 at 11:16:02PM +0200, Arnd Bergmann wrote:
> On Thu, Oct 9, 2025, at 20:47, Manivannan Sadhasivam wrote:
> > On Wed, Oct 08, 2025 at 07:56:44PM +0200, Arnd Bergmann wrote:
> >> On Wed, Oct 8, 2025, at 17:19, Manivannan Sadhasivam wrote:
> >>
> >> That is not my impression from reading the code: At least for
> >> the case where both devices are on the same bridge and they
> >> use map_type=PCI_P2PDMA_MAP_BUS_ADDR, I would expect the DMA
> >> to use the plain PCI bus address, not going through the
> >> dma-ranges+ranges translation that would apply when they are
> >> on different host bridges.
> >> 
> >
> > Right, but I don't get the overlap issue still. If the P2P client triggers a
> > write to a P2P PCI address (let's assume 0x8000_0000), and if that address
> > belongs to a an endpoint in a different domain, the host bridge should still
> > forward it to the endpoint without triggering write to the RAM.
> 
> If 0x8000_0000 is an endpoint in a different domain, I would expect the
> DMA transfer to go to the RAM at that address since the DMA has to leave
> the PCI host bridge upstream by following its inbound windows.
> 
> This is not the problem I'm talking about though, since cross-domain
> P2P is not particularly well-defined.
> 
> > Atleast, I don't see any concern from the outbound memory translation point of
> > view.
> >
> > Please let me know if there is any gap in my understanding.
> 
> To clarify: I don't think that programming the output translation this
> way is the problem here, but assigning memory resources to ambiguous
> addresses is. The host bridge probe uses the 'ranges' both for
> setting up the outbound window and the bus resources. 
> 
> If the PCI bus scan assigns address 0x8000_0000 to the memory BAR
> of a device, and that device or any other one in the /same/
> domain tries to DMA to DRAM at address 0x8000_0000, it would likely
> reach the memory BAR instead of DRAM. If for some reason it does reach
> DRAM after all, it would be unable to do a P2P DMA into the BAR when
> it tries.
> 

I tried to verify how the Root Port is supposed to behave in this scenario, but
I couldn't conclude on anything. So it looks like this overlapping *might*
create issues with P2PDMA and DRAM access. Thanks for spotting and also for
persisting with my lack of understanding :)

> If the PCI scan already checks for overlap between the DT "ranges"
> and other resources (DRAM or MMIO) before assigning a BAR, this may
> be a non-issue, but I haven't found the code that does this.
> Looking at pci_bus_allocate_dev_resources() it seems that it would
> attempt to assign an overlapping address to a BAR but then fail
> to claim it because of the resource conflict. If that is the
> case, it would not actually have an ambiguous DMA routing
> but instead the device would fail to be probed because of the
> conflict.
> 

AFAICS, the existing resource checks only finds out the overlap between the
resources assigned to the devices, not between the DRAM or MMIO. This is
something we should do in devm_of_pci_get_host_bridge_resources() IMO.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

