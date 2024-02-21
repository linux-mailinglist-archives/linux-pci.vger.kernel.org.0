Return-Path: <linux-pci+bounces-3845-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D5F85ED0C
	for <lists+linux-pci@lfdr.de>; Thu, 22 Feb 2024 00:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C60D7B20ECE
	for <lists+linux-pci@lfdr.de>; Wed, 21 Feb 2024 23:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430D685290;
	Wed, 21 Feb 2024 23:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bnHNLGYi"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD963E470
	for <linux-pci@vger.kernel.org>; Wed, 21 Feb 2024 23:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708558408; cv=none; b=sjsD5AauxLLij1aAdk7mrfenX5UsZz5WCkRnDfxdvikbDeNUGkWlBz27/q/XNGsjlLrpeFCWdvo2Dq7Ai1eMz2WWTpm2qWJc7W/ENFzlS4cifzt+UuvSiIQ+Px6zFGfVwqKieYTOqXQaPItcBriyS53Ifl8ikz3pWkxbcgIZ+z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708558408; c=relaxed/simple;
	bh=oek7yMxAZVYzST3tZKKbzp+4bnsbv669D9ZZTh7z9Nk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=BjjCv8XrV9GrpBVjHHIHbr4rGnYic+TFHGoyYP4T9fygnOs3NHt63IBPqzS7xONZe3RPY7HU7y6JvwXNkEid/jKyIHCejHCDrUk7Zo+xgwWfrly2RSgWjOJHF6yXzq1Nw9YZU5Ji+48l2rde6OZUuRlNCNO8YA9GCvvuEne4DX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bnHNLGYi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 799B6C433F1;
	Wed, 21 Feb 2024 23:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708558407;
	bh=oek7yMxAZVYzST3tZKKbzp+4bnsbv669D9ZZTh7z9Nk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=bnHNLGYihBqBfQLCEfd3GjCg/Qa1C8D3xFhquSzSeBzw/lhnDDcAG6VSzIerwfMTO
	 HA17D0lKg73tkJJm9ohoD1+vra3S0DuJsXZgtyCQ56WfkLh0CjXd1WJq5Bl5wCdUjV
	 PZDhHyK1UJ7kYjOssyZ4A79x9q7GF4xq2YFBNw6sQtSK/j4rGyCbZDpfCj2BAEh8tj
	 KzqpeY+7Y9Ds743TtbPPAmyd67oCEkGtyDv35jy6S3oSDEu1JPJc6ljd9dSug+ueWA
	 8yoY1wosHzOW9ZJ+oauZMW0fnuS41MnUHpQyLyUQSYw0fjH5BxodgNkSrspQwkagC8
	 yrWW3rj6m6UGQ==
Date: Wed, 21 Feb 2024 17:33:25 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Matthew W Carlis <mattc@purestorage.com>, bhelgaas@google.com,
	kbusch@kernel.org, linux-pci@vger.kernel.org, lukas@wunner.de,
	mika.westerberg@linux.intel.com,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/1] PCI/portdrv: Allow DPC if the OS controls AER
 natively.
Message-ID: <20240221233325.GA1595083@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221231102.GA1547668@bhelgaas>

[+cc Mahesh, Oliver, linuxppc-dev, since I mentioned powerpc below.
Probably not of interest since this is about the ACPI EDR feature, but
just FYI]

On Wed, Feb 21, 2024 at 05:11:04PM -0600, Bjorn Helgaas wrote:
> On Tue, Jan 23, 2024 at 09:59:21AM -0600, Bjorn Helgaas wrote:
> > On Mon, Jan 22, 2024 at 06:37:48PM -0800, Kuppuswamy Sathyanarayanan wrote:
> > > On 1/22/24 11:32 AM, Bjorn Helgaas wrote:
> > > > On Mon, Jan 08, 2024 at 05:15:08PM -0700, Matthew W Carlis wrote:
> > > >> A small part is probably historical; we've been using DPC on PCIe
> > > >> switches since before there was any EDR support in the kernel. It
> > > >> looks like there was a PCIe DPC ECN as early as Feb 2012, but this
> > > >> EDR/DPC fw ECN didn't come in till Jan 2019 & kernel support for ECN
> > > >> was even later. Its not immediately clear I would want to use EDR in
> > > >> my newer architecures & then there are also the older architecures
> > > >> still requiring support. When I submitted this patch I came at it
> > > >> with the approach of trying to keep the old behavior & still support
> > > >> the newer EDR behavior. Bjorns patch from Dec 28 2023 would seem to
> > > >> change the behavior for both root ports & switch ports, requiring
> > > >> them to set _OSC Control Field bit 7 (DPC) and _OSC Support Field
> > > >> bit 7 (EDR) or a kernel command line value. I think no matter what,
> > > >> we want to ensure that PCIe Root Ports and PCIe switches arrive at
> > > >> the same policy here.
> > > > Is there an approved DPC ECN to the PCI Firmware spec that adds DPC
> > > > control negotiation, but does *not* add the EDR requirement?
> > > >
> > > > I'm looking at
> > > > https://members.pcisig.com/wg/PCI-SIG/document/previewpdf/12888, which
> > > > seems to be the final "Downstream Port Containment Related
> > > > Enhancements" ECN, which is dated 1/28/2019 and applies to the PCI
> > > > Firmware spec r3.2.
> > > >
> > > > It adds bit 7, "PCI Express Downstream Port Containment Configuration
> > > > control", to the passed-in _OSC Control field, which indicates that
> > > > the OS supports both "native OS control and firmware ownership models
> > > > (i.e. Error Disconnect Recover notification) of Downstream Port
> > > > Containment."
> > > >
> > > > It also adds the dependency that "If the OS sets bit 7 of the Control
> > > > field, it must set bit 7 of the Support field, indicating support for
> > > > the Error Disconnect Recover event."
> > > >
> > > > So I'm trying to figure out if the "support DPC but not EDR" situation
> > > > was ever a valid place to be.  Maybe it's a mistake to have separate
> > > > CONFIG_PCIE_DPC and CONFIG_PCIE_EDR options.
> > > 
> > > My understanding is also similar. I have raised the same point in
> > > https://lore.kernel.org/all/3c02a6d6-917e-486c-ad41-bdf176639ff2@linux.intel.com/
> > 
> > Ah, sorry, I missed that.
> > 
> > > IMO, we don't need a separate config for EDR. I don't think user can
> > > gain anything with disabling EDR and enabling DPC. As long as
> > > firmware does not user EDR support, just compiling the code should
> > > be harmless.
> > > 
> > > So we can either remove it, or select it by default if user selects
> > > DPC config.
> > > 
> > > > CONFIG_PCIE_EDR depends on CONFIG_ACPI, so the situation is a little
> > > > bit murky on non-ACPI systems that support DPC.
> > > 
> > > If we are going to remove the EDR config, it might need #ifdef
> > > CONFIG_ACPI changes in edr.c to not compile ACPI specific code.
> > > Alternative choice is to compile edr.c with CONFIG_ACPI.
> > 
> > Right.  I think we should probably remove CONFIG_PCIE_EDR completely
> > and make everything controlled by CONFIG_PCIE_DPC.
> 
> In the PCI Firmware spec, r3.3, sec 4.5.1, table 4-4, the description
> of "Error Disconnect Recover Supported" hints at the possibility for
> an OS to support EDR but not DPC:
> 
>   In the context of PCIe, support for Error Disconnect Recover implies
>   that the operating system will invalidate the software state
>   associated with child devices of the port without attempting to
>   access the child device hardware. *If* the operating system supports
>   Downstream Port Containment (DPC), ..., the operating system shall
>   attempt to recover the child devices if the port implements the
>   Downstream Port Containment Extended Capability.
> 
> On the other hand, sec 4.6.12 and the implementation note there with
> the EDR flow seem to assume the OS *does* support DPC and can clear
> error status and bring ports out of DPC even if the OS hasn't been
> granted control of DPC.
> 
> EDR is an ACPI feature, and I guess it might be theoretically possible
> to use EDR on an ACPI system with some non-DPC error containment
> feature like powerpc EEH.  But obviously powerpc doesn't use ACPI, and
> a hypothetical ACPI system with non-DPC error containment would have
> to add support for that containment in edr_handle_event().
> 
> So while I'm not 100% sure that making CONFIG_PCIE_DPC control both
> DPC and EDR is completely correct, I guess for now I still think using
> CONFIG_PCIE_DPC for both DPC and EDR seems like a reasonable plan
> because we have no support for EDR *without* DPC.
> 
> Bjorn

