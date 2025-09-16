Return-Path: <linux-pci+bounces-36308-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D531B7D88D
	for <lists+linux-pci@lfdr.de>; Wed, 17 Sep 2025 14:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F81658365D
	for <lists+linux-pci@lfdr.de>; Tue, 16 Sep 2025 22:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99BB12E5430;
	Tue, 16 Sep 2025 22:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TdLmnpc+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9752248B0;
	Tue, 16 Sep 2025 22:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758061373; cv=none; b=ggWPSI1I2ZfGQgtVhpkJ7+rnbfJeswpviRhE3OlUYJ/K1q5EBRU5osUnXynnCGSKsT05wZt77qxi2oHfVUIWzJzQ3O3+vqnzkNg8vBb+WYUdx0+axUaqs5acPYGQsJ7LOqMWnunSqInzgmPmG95f2+N2MLIQ+EIOpQpwEVMokGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758061373; c=relaxed/simple;
	bh=r9Or6o3OMAYk+p4F3zH87XvoquFuNXXbiVA8xc/4Zng=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=cZAbe+2hrP7bn1rgBP5X6Pxp9ql4EWCbahxWOj7DDMzrKk+vMCwQhPFoOGK49LaAo+2pVOkBS6bn+k7NpX86XT9T0OS5nd0Gj+ewO1gW1ag8mMauol0mvkM5eSdxVMl+0nIbrW3eFZTgWlKnttU5bBwYHbNWHRAOxrSg5vN3ucM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TdLmnpc+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C09EEC4CEEB;
	Tue, 16 Sep 2025 22:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758061372;
	bh=r9Or6o3OMAYk+p4F3zH87XvoquFuNXXbiVA8xc/4Zng=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=TdLmnpc+UKAo7nGuEZrAZsRPqvQ44VO4DAIPvj4NTrvkEIUtoTL64I0g8yVZ8do31
	 jxyJE0l8Q56u2oWOFTjasi7o4jbVZ8nzZy01JOttBqzavdbQeuZuztp3fczINsB9aV
	 FVZmmyQdTA/3WynRgYSrepmflT/fEMzI1JKgI2yaEn0ZoNGd6G1u7vY75P5Mk0xa6Y
	 iXOB0t7LVDpwjwVPHErsGSJMuKUJyTCQFk5mkIoQwPah4t+LYuOgKH05HgbgSCenH7
	 zTcq6DyxvO+O88pnLpdpgdUuQ8BoYrWgix9OfLNPb8v54NpoXbtRihyHtKhuAibSSI
	 1HsRv+0UBpsBg==
Date: Tue, 16 Sep 2025 17:22:51 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org, Chia-Lin Kao <acelan.kao@canonical.com>
Subject: Re: Question on generic PCI ACPI/DT device property wrt ASPM
Message-ID: <20250916222251.GA1826923@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b54c5083-fd3a-40ad-98ee-f102fd28e230@gmail.com>

On Tue, Sep 16, 2025 at 10:56:26PM +0200, Heiner Kallweit wrote:
> On 9/16/2025 10:25 PM, Bjorn Helgaas wrote:
> > On Tue, Sep 16, 2025 at 09:48:06PM +0200, Heiner Kallweit wrote:
> >> There are drivers (in my case r8169) disabling ASPM for a device per default
> >> because there are known issues on a number of systems. However on other
> >> systems ASPM works flawlessly, and vendors (especially of notebooks) would
> >> like to (re-)enable ASPM for this device on such systems.
> > 
> > I would definitely love to be able to fully enable ASPM on these
> > devices everywhere and rip the ASPM code out of r8169.
> > 
> >> Reference:
> >> https://lore.kernel.org/netdev/20250912072939.2553835-1-acelan.kao@canonical.com/
> >>
> >> Realtek NICs are used on more or less every consumer device, and maintaining
> >> long DMI-based whitelists wouldn't be too nice.
> >>
> >> Therefore idea is to use a device property (working title: aspm-is-safe), that
> >> can be set via ACPI or DT. In my case it's a PCIe NIC, but in general the
> >> property could be applicable on every PCIe device.
> >> So question is to which schema such a property would belong. Here?
> >> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/Documentation/devicetree/bindings/pci/pci-ep.yaml?h=next-20250916
> > 
> > I'm not super enthused about yet more knobs to control ASPM based on
> > issues we don't completely understand.
> > 
> > Quirks that say "X is broken on this device" are to be expected, but I
> > have a hard time understanding a quirk that says "this feature works
> > as it's supposed to."
> > 
> > If ASPM works on some systems but not others, it's either because some
> > Downstream Ports leading to the NIC have defects or Linux (or BIOS) is
> > configuring ASPM incorrectly sometimes.
> > 
> > I think we just need to figure this out.
> 
> I'm tempted to say we've been having the ASPM issues with Realtek NICs
> for decades now, and so far there was no good way to "just figure this out".

Yeah, that was a little flip, sorry.

My impression (perhaps unfounded) is that we don't have much solid
data about any situation where ASPM doesn't work reliably.  I don't
remember seeing actual ASPM configurations or details from a PCIe
analyzer.  Maybe Realtek has looked at this internally; I just don't
think I've seen it.

My suspicion is that it's mostly likely a misconfiguration because the
Root Ports are almost certainly used in many other machines.  And if
the NIC works well in other machines, the NIC is most likely not
broken.

> Some issues:
> - We only see the tip of the iceberg (the users reporting ASPM issues to
>   linux kernel bugzilla)
> - These Realtek NICs are on hundreds of consumer mainboard/system types,
>   with endless chances of problematic NIC chip version / PCIe chipset / BIOS
>   issues combinations.
> 
> Therefore a whitelist property might be the least bad option.

