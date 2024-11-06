Return-Path: <linux-pci+bounces-16153-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8C49BF392
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 17:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30A7CB22975
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 16:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403391E0488;
	Wed,  6 Nov 2024 16:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iI4Ih2R3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FA884039;
	Wed,  6 Nov 2024 16:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730911678; cv=none; b=YGdyo6PEhCnnDj0/4dfjUfMQ/p3LYdnVsbqyHwFtOKBU0C02uLR9iB8qZUUQ/MGGndEK4tvRHpBcQ8SYJapJ8+62hgV8Etw3VajYeGPRnPaXHI/uwaaG6tPN0HfuXWT1QIPBQ8TKCXbffHBRN3qt+O0T1iGROJmrKYo+JpOuGS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730911678; c=relaxed/simple;
	bh=8/28ZXF6liVR5ii+4iEPUl/93rvhaj5K2WgWuUMkhmA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Ot9qTiRK+QtPl4TCEu5oByCMz2jFekGDHjhHCg+6A0Z9aOiNsx9dCkPICaRlPNOWc/DdDELX+oGf2hImMXA8x4Cqq3FZv7mlOZnx+Y2NDih6MTCqNlAlMu97XEMVSD6iJ+zT4UllYayxbT7lQfJJTO+veE8PfV26UOj3Bt3bxJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iI4Ih2R3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 854F9C4CEC6;
	Wed,  6 Nov 2024 16:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730911677;
	bh=8/28ZXF6liVR5ii+4iEPUl/93rvhaj5K2WgWuUMkhmA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=iI4Ih2R3pul6EgFgyE7mMPfsh6ZyLL10RmDbg61lvNmMFKMi3IrzalREXQgp94rw2
	 RJimCTua9l37J9HTzjDe+2nDrgjPGIBQbC676ffbG962rB3aeOn4EfPNT0SprbnaZ2
	 wJhFjLW1CqfiNjB1Zfd/UbvyCJjXp70nNnX5ah5alHK27e/5F0fvuc53zQvzRmbh5J
	 Co/m5A8Hicr7H+4PMk2/yB4gfmDn1nvvbYMqlprIQ+BVNbDaUmDvYfr8dNqNZaGzIN
	 dQqa7tqQr0PB2V2qG2s7M1n043Yk+iDOCTWPjdbyaRCHROpU+gMBKCWaDu3PSIS1j7
	 2/9DDQnB8aZeA==
Date: Wed, 6 Nov 2024 10:47:55 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Lizhi Hou <lizhi.hou@amd.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 6/6] PCI: of: Create device-tree root bus node
Message-ID: <20241106164755.GA1528530@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106155353.4ffd3825@bootlin.com>

On Wed, Nov 06, 2024 at 03:53:53PM +0100, Herve Codina wrote:
> On Tue, 5 Nov 2024 12:59:01 -0600
> Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Mon, Nov 04, 2024 at 06:20:00PM +0100, Herve Codina wrote:
> > > PCI devices device-tree nodes can be already created. This was
> > > introduced by commit 407d1a51921e ("PCI: Create device tree node for
> > > bridge").  
> ...

> > > Indeed, this component is not described
> > > in a device-tree used at boot.  
> > 
> > But maybe I'm on the wrong track, because obviously PCI host
> > controllers *are* described in DTs used at boot.
> 
> They are described in a device-tree used at boot on device-tree based
> systems.
> On x86, we are on ACPI based system -> No DT used at boot -> PCI host
> controller not described in DT.

Right, I was thinking of the devicetree-based systems, where the host
controller must be described in DT.

> > > +	name = kasprintf(GFP_KERNEL, "pci-root@%x,%x", pci_domain_nr(bus),
> > > +			 bus->number);  
> > 
> > Should this be "pci%d@%x,%x" to match the typical descriptions of PCI
> > host bridges in DT?
> 
> What do you think I should use for the %d you proposed.

Based on the .dts files, I think the %d is just an index to
distinguish multiple PCI host bridges.  Maybe that's not relevant
here, I dunno.

> Also I supposed your "@%x,%x" is still pci_domain_nr(bus), bus->number.

Yes.  I think we're basically constructing a DT node to correspond to
an ACPI PNP0A03 device.  ACPI does support updating the root bus
number via _CRS/_PRS/_SRS, but Linux doesn't have support for that, so
the root bus number is basically constant.  The pci_domain_nr(bus)
should be coming from _SEG, and that's definitely constant.

Bjorn

