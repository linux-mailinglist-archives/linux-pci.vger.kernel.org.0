Return-Path: <linux-pci+bounces-37773-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96DE7BCA98E
	for <lists+linux-pci@lfdr.de>; Thu, 09 Oct 2025 20:47:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E904B1A63CC2
	for <lists+linux-pci@lfdr.de>; Thu,  9 Oct 2025 18:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B010F220F5C;
	Thu,  9 Oct 2025 18:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rp8AjoJg"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FCEA31;
	Thu,  9 Oct 2025 18:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760035633; cv=none; b=lW3kRAbqJ3pdOLEtsFwZ+RiCcepFhsnkesHXCwIbSYXWbOe1hx4qbFQQbZ5H1Vgx3x9f/HuvtVn6+rTCrb16f2SQMCcbWXaXisIK6WJPS5bqo98Sl7cg11s5VY51aVnZ8cCy4I9gktZkDS6tuCxq4mxFvJM6BHRYIfWL6ihIElg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760035633; c=relaxed/simple;
	bh=ivEfJjQfgHVzt9APPBEebTAqsUUoYx7xt2ip5PmKFLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iS/BbrNZDBXdV5vc/vDmYuOE9ipn9ZwHCR9PM/8rc52rjC4I6HLOh/8zsSL4MyaOdFme/lUXcS0vQtFY+mn6yXGTObVuuxrXbxpHz5+qaL9EXaXad6IyH0AJFPMKE3A34igCjy/fzTl9QEsu2jpGiJgBwwOdwHj/PgaxXVXukAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rp8AjoJg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8CF6C4CEE7;
	Thu,  9 Oct 2025 18:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760035633;
	bh=ivEfJjQfgHVzt9APPBEebTAqsUUoYx7xt2ip5PmKFLU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rp8AjoJg86r6iBIoiXsIAaAiHDGnJ0sI0dBT+DjtNnbE8hXpjulRkeuxuYpe3hT0v
	 JfKAh7Q7pLW15CAG9L6KbuUQF9M+TKg2Z/JaL6OzJoQQ06i9f+/mpFlE/o+u0Hsfre
	 SnrxeK9AzcMtsRkzkLjAXrZU8LGWuw55Qry6lPLDlSEcGITrWg8ZBaOb3kgDNfiwsy
	 DAQuilVdgBk2viPy7J/bU3upb0m2+k8YrZbB0q6wdHHr52o1Pl/JUkaVCqNZDtaOso
	 yUwyf9rncO0hG+TV4SKztW3LYBjXwGFYvSKOpLolfBdAzt7LQeBdq9xJxYFN8fc5OP
	 8yUOd7amoOrEA==
Date: Thu, 9 Oct 2025 11:47:09 -0700
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
Message-ID: <4kvo2qg2til22hlssv7lt2ugo63emr5c4hfjur5m3vnxvpdekx@jcbhaxb2d2j2>
References: <20250919155821.95334-1-vincent.guittot@linaro.org>
 <20250919155821.95334-2-vincent.guittot@linaro.org>
 <iom65w7amxqf7miopujxeulyiglhkyjszjc3nd4ivknj5npcz2@bvxej6ymkecd>
 <aOU0w5Brp6uxjZDr@lpieralisi>
 <4rghtk5qv4u7vx4nogctquu3skvxis4npxfukgtqeilbofyclr@nhkrkojv3syh>
 <eba7d968-209d-4acb-ba41-4bebf03e96ba@app.fastmail.com>
 <4143977f-1e70-4a63-b23b-78f87d9fdcde@app.fastmail.com>
 <2erycpxudpckmme3k2cpn6wgti4ueyvupo2tzrvmu7aqp7tm6d@itfj7pfrpzzg>
 <3d480f73-15b4-4fb8-8d2b-f9961c1736ca@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3d480f73-15b4-4fb8-8d2b-f9961c1736ca@app.fastmail.com>

On Wed, Oct 08, 2025 at 07:56:44PM +0200, Arnd Bergmann wrote:
> On Wed, Oct 8, 2025, at 17:19, Manivannan Sadhasivam wrote:
> > On Wed, Oct 08, 2025 at 10:35:34AM +0200, Arnd Bergmann wrote:
> >> On Wed, Oct 8, 2025, at 10:26, Arnd Bergmann wrote:
> >> > the physical addresses for RAM at 0x80000000 and on-chip devices
> >> > at 0x40000000. This probably works fine as long as the total
> >> > PCI memory space assignment stays below 0x40000000 but would
> >> > fail once addresses actually start clashing.
> >> 
> >> I got confused here myself, but what I should have said is that
> >> having the DMA address for the RAM overlap the BAR space
> >> as seen from PCI is problematic as the PCI host bridge
> >> cannot tell PCI P2P transfers from DMA to RAM, so one
> >> of them will be broken here.
> >> 
> >
> > No. The IP just sets up the outbound mapping here for the entire 'ranges'. When
> > P2P happens, it will use the inbound mapping translation.
> 
> That is not my impression from reading the code: At least for
> the case where both devices are on the same bridge and they
> use map_type=PCI_P2PDMA_MAP_BUS_ADDR, I would expect the DMA
> to use the plain PCI bus address, not going through the
> dma-ranges+ranges translation that would apply when they are
> on different host bridges.
> 

Right, but I don't get the overlap issue still. If the P2P client triggers a
write to a P2P PCI address (let's assume 0x8000_0000), and if that address
belongs to a an endpoint in a different domain, the host bridge should still
forward it to the endpoint without triggering write to the RAM.

Atleast, I don't see any concern from the outbound memory translation point of
view.

Please let me know if there is any gap in my understanding.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

