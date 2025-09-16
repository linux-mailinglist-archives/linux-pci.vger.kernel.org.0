Return-Path: <linux-pci+bounces-36302-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F69B5A357
	for <lists+linux-pci@lfdr.de>; Tue, 16 Sep 2025 22:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 152034839B9
	for <lists+linux-pci@lfdr.de>; Tue, 16 Sep 2025 20:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF2C31BC93;
	Tue, 16 Sep 2025 20:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gpp5cQ8M"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B9931BC8F;
	Tue, 16 Sep 2025 20:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758054941; cv=none; b=G1DP1fLCMq3tTm2JmBootjmQpFKoYDBFaG699eLfYLB6Zib64krNN472NfJlDMFKSCAa7wJRs3La9MAmUJhZO2gLth0/Rtb7Cs0KXXTjHGrZza02+zvs7TCDhNY/Y7fibxDUpVsh9wUZbPs+IMzqqNSTlRY3rkjb8SrzXxdDSLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758054941; c=relaxed/simple;
	bh=KqfC65wNBi+Y/C3HaiesaaDgdsXgozVufkjtOAiu4hM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=BfzbexwznLCPkNGwbicJxk5WRPXtCeTw5eoU3oa2KIF443Ga0H6O7aD3GJgA8TOVRpXWSpptkO9pf18dMG928QP1Nkp8/LRHy3Hgcz3o7POcpBPVTRHTTkHtNrfWv7LseML17GI3irwlgsfdZaCcDecqqrq9j85oYtBWmyrBb4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gpp5cQ8M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8304C4CEEB;
	Tue, 16 Sep 2025 20:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758054940;
	bh=KqfC65wNBi+Y/C3HaiesaaDgdsXgozVufkjtOAiu4hM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=gpp5cQ8MDuThAKuE8YpdMV+sVmG1CQsK86y/CmAihJJHE7cjHFOtU+vBlylCrbI/B
	 lkY285P/FU7qaXK1zTJsd0Uy9haUzrsSnqAKTj9pxM3bxqo491TsNsOl9LfISl5v+3
	 dCUmflIjzOaN8eacQOndiOs4z+ePCcVHzgG8AQdQD2SB9IgOACAVpGSI/q18Z++lMp
	 i5FYXY9WRiRyOlU7eo3XUR7kQuJT1uYmRXwaj9L/VhQ50qoSiW9SeCH+MAImQa9z2F
	 ONE1Tn7ylJq2aVqatsdhE9zACAPUYCJw5cNPtF6AVXbcNBe+SKpSyJ/qE4CHEQMRHA
	 NHRiyZI6sn0yg==
Date: Tue, 16 Sep 2025 15:35:39 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>,
	nic_swsd@realtek.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Wang, Crag" <Crag.Wang@dell.com>,
	"Chen, Alan" <Alan.Chen6@dell.com>,
	"Alex Shen@Dell" <Yijun.Shen@dell.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] r8169: enable ASPM on Dell platforms
Message-ID: <20250916203539.GA1815401@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ec602131-ed22-44a8-a356-03729764a690@gmail.com>

[+cc linux-pci]

On Mon, Sep 15, 2025 at 09:25:39PM +0200, Heiner Kallweit wrote:
> On 9/15/2025 3:37 AM, Chia-Lin Kao (AceLan) wrote:
> > On Fri, Sep 12, 2025 at 05:30:52PM +0200, Heiner Kallweit wrote:
> >> On 9/12/2025 9:29 AM, Chia-Lin Kao (AceLan) wrote:
> >>> Enable PCIe ASPM for RTL8169 NICs on Dell platforms that have been
> >>> verified to work reliably with this power management feature. The
> >>> r8169 driver traditionally disables ASPM to prevent random link
> >>> failures and system hangs on problematic hardware.
> >>>
> >>> Dell has validated these product families to work correctly with
> >>> RTL NIC ASPM and commits to addressing any ASPM-related issues
> >>> with RTL hardware in collaboration with Realtek.
> >>>
> >>> This change enables ASPM for the following Dell product families:
> >>> - Alienware
> >>> - Dell Laptops/Pro Laptops/Pro Max Laptops
> >>> - Dell Desktops/Pro Desktops/Pro Max Desktops
> >>> - Dell Pro Rugged Laptops
> >>>
> >> I'd like to avoid DMI-based whitelists in kernel code. If more system
> >> vendors do it the same way, then this becomes hard to maintain.
> >
> > I totally understand your point; I also don’t like constantly adding DMI
> > info to the list. But this list isn’t for a single product name, it’s a
> > product family that covers a series of products, and it probably won’t
> > change anytime soon.
> > 
> >> There is already a mechanism for vendors to flag that they successfully
> >> tested ASPM. See c217ab7a3961 ("r8169: enable ASPM L1.2 if system vendor
> >> flags it as safe").
> >
> > Right, but writing the flag is not applicable for Dell manufacturing
> > processes.
> > 
> Can you elaborate on why this doesn't work for Dell?
> 
> >> Last but not least ASPM can be (re-)enabled from userspace, using sysfs.
> >
> > That doesn't sound like a good solution to push the list to userspace.
> > 
> > Dell has already been working with Canonical for more than a decade to
> > ship their products with r8169 ASPM enabled. Dell has also had lengthy
> > discussions with Realtek to have this feature enabled by default in the
> > r8169 driver. I think this is a good opportunity for Dell to work with
> > Realtek to spot bugs and refine the r8169 driver.
>
> One more option to avoid having to change kernel code with each new
> and successfully ASPM-tested system family from any system vendor:
> 
> We could define a device property which states that ASPM has been
> successfully tested on a system. This device property could be set
> via device tree or via ACPI. Then a simple device_property_present()
> in the driver would be sufficient.
> A device property would also have the advantage that vendors can
> control behavior per device, not only per device family.
> An ACPI device property could be rolled out via normal BIOS update
> for existing systems.
> 
> See also:
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/Documentation/firmware-guide/acpi/DSD-properties-rules.rst?h=v6.16.7

Related conversation:
https://lore.kernel.org/r/5b00870c-be1a-42d6-8857-48b89716d5e2@gmail.com

