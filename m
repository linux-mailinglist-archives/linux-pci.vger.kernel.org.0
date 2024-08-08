Return-Path: <linux-pci+bounces-11516-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD6C94C67E
	for <lists+linux-pci@lfdr.de>; Thu,  8 Aug 2024 23:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18626B24553
	for <lists+linux-pci@lfdr.de>; Thu,  8 Aug 2024 21:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34AE15820F;
	Thu,  8 Aug 2024 21:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BSqiQlli"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90D5155A59;
	Thu,  8 Aug 2024 21:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723154012; cv=none; b=czUyY++CRjhYI12+iWsPPhx2sfX7uhdjdIclDSO1DtUekiPzCitbESyLMGigTWt6NSV/UGdBwW0rtb2/9bGsj+DQc2znYUb1R6ugdhzb0QVIxnmKp6p07TWdK/MipChteiIuDT7EN3S9HL4VpEPeuR2GwgJoMnXjnDrLy3R1dNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723154012; c=relaxed/simple;
	bh=v5eKzoiQ/fJqm4MD4HfH7D6JYuktig1GDmrJwTTjiHk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Dlwjd4EMIV2JndRqs3n0GGVhPOqdHWokLE9OR06Umy8y9nsEbPHAt2GlhMcIl0LwVrSiHe3NWYeI8YnKyu3zjgluNIkC27qMgPkjzZgEab5+miRfPAvBaJnjoqk5XjGQpjSYNAJa94mHAcujX230pOOQFU5NxGoW7ZsOslBl3pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BSqiQlli; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD92AC4AF09;
	Thu,  8 Aug 2024 21:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723154012;
	bh=v5eKzoiQ/fJqm4MD4HfH7D6JYuktig1GDmrJwTTjiHk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=BSqiQllima3fa6iHhxo2XtOMmOjXPRFugQX8JU5GD1LaAOpIG/nqqeOpYe6diLCT3
	 aqCf5BwKFb3XbafqBkAy2hcEjWFj2f8WWk7AfgwxK1nhPseZQZt0jYOqxWeg1hvfKA
	 uFzZ6hptZhYNdI50D/Wl8mGRMl21ZtvU5kQD5Sjs1Sy0zuEjpm24Ak/DI+CwwW4ZfY
	 JOVEbK3rG60tYbj6VKRfJu6t6Tig5cL6KAMs7R8iw3KZ6LK0k2Sg3nvdiFogaqVhsg
	 ZbjFqO/Mx8PGmlKSFCptyhRZ1RgUcZ6WixDisX8FeQERM2epFe91Qsr6bT1iMN8K6z
	 DkR3fHWDJzlPw==
Date: Thu, 8 Aug 2024 16:53:29 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Stewart Hildebrand <stewart.hildebrand@amd.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 8/8] PCI: Align small BARs
Message-ID: <20240808215329.GA155982@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240807151723.613742-9-stewart.hildebrand@amd.com>

On Wed, Aug 07, 2024 at 11:17:17AM -0400, Stewart Hildebrand wrote:
> In this context, "small" is defined as less than max(SZ_4K, PAGE_SIZE).
> 
> Issues observed when small BARs are not sufficiently aligned are:
> 
> 1. Devices to be passed through (to e.g. a Xen HVM guest) with small
> BARs require each memory BAR to be page aligned. Currently, the only way
> to guarantee this alignment from a user perspective is to fake the size
> of the BARs using the pci=resource_alignment= option. This is a bad user
> experience, and faking the BAR size is not always desirable. For
> example, pcitest is a tool that is useful for PCI passthrough validation
> with Xen, but pcitest fails with a fake BAR size.

I guess this is the "money" patch for the main problem you're solving,
i.e., passthrough to a guest doesn't work as you want?

Is it the case that if you have two BARs in the same page, a device
can't be passed through to a guest at all?  Or is it just that all
devices with BARs that share a page have to be passed through to the
same guest, sort of like how lack of ACS can force several devices to
be in the same IOMMU isolation group?

I think the subject should mention the problem to help motivate this.

The fact that we address this by potentially reassigning every BAR of
every device, regardless of whether the admin even wants to pass
through a device to a guest, seems a bit aggressive to me.

Previously we haven't trusted our reassignment machinery enough to
enable it all the time, so we still have the "pci=realloc" parameter.
By default, I don't think we even move devices around to make space
for a BAR that we failed to allocate.

I agree "pci=resource_alignment=" is a bit user-unfriendly, and I
don't think it solves the problem unless we apply it to every device
in the system.

> 2. Devices with multiple small BARs could have the MSI-X tables located
> in one of its small BARs. This may lead to the MSI-X tables being mapped
> in the same 4k region as other data. The PCIe 6.1 specification (section
> 7.7.2 MSI-X Capability and Table Structure) says we probably should
> avoid that.

If you're referring to this:

  If a Base Address Register or entry in the Enhanced Allocation
  capability that maps address space for the MSI-X Table or MSI-X PBA
  also maps other usable address space that is not associated with
  MSI-X structures, locations (e.g., for CSRs) used in the other
  address space must not share any naturally aligned 4-KB address
  range with one where either MSI-X structure resides. This allows
  system software where applicable to use different processor
  attributes for MSI-X structures and the other address space.

I think this is technically a requirement about how space within a
single BAR should be organized, not about how multiple BARs should be
assigned.  I don't think this really adds to the case for what you're
doing, so we could just drop it.

> To improve the user experience (i.e. don't require the user to specify
> pci=resource_alignment=), and increase conformance to PCIe spec, set the
> default minimum resource alignment of memory BARs to the greater of 4k
> or PAGE_SIZE.
> 
> Quoting the comment in
> drivers/pci/pci.c:pci_request_resource_alignment(), there are two ways
> we can increase the resource alignment:
> 
> 1) Increase the size of the resource.  BARs are aligned on their
>    size, so when we reallocate space for this resource, we'll
>    allocate it with the larger alignment.  This also prevents
>    assignment of any other BARs inside the alignment region, so
>    if we're requesting page alignment, this means no other BARs
>    will share the page.
> 
>    The disadvantage is that this makes the resource larger than
>    the hardware BAR, which may break drivers that compute things
>    based on the resource size, e.g., to find registers at a
>    fixed offset before the end of the BAR.
> 
> 2) Retain the resource size, but use IORESOURCE_STARTALIGN and
>    set r->start to the desired alignment.  By itself this
>    doesn't prevent other BARs being put inside the alignment
>    region, but if we realign *every* resource of every device in
>    the system, none of them will share an alignment region.
> 
> Changing pcibios_default_alignment() results in the second method of
> alignment with IORESOURCE_STARTALIGN.
> 
> The new default alignment may be overridden by arches by implementing
> pcibios_default_alignment(), or by the user on a per-device basis with
> the pci=resource_alignment= option (although this reverts to using
> IORESOURCE_SIZEALIGN).
> 
> Signed-off-by: Stewart Hildebrand <stewart.hildebrand@amd.com>
> ---
> Preparatory patches in this series are prerequisites to this patch.
> 
> v2->v3:
> * new subject (was: "PCI: Align small (<4k) BARs")
> * clarify 4k vs PAGE_SIZE in commit message
> 
> v1->v2:
> * capitalize subject text
> * s/4 * 1024/SZ_4K/
> * #include <linux/sizes.h>
> * update commit message
> * use max(SZ_4K, PAGE_SIZE) for alignment value
> ---
>  drivers/pci/pci.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index af34407f2fb9..efdd5b85ea8c 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -31,6 +31,7 @@
>  #include <asm/dma.h>
>  #include <linux/aer.h>
>  #include <linux/bitfield.h>
> +#include <linux/sizes.h>
>  #include "pci.h"
>  
>  DEFINE_MUTEX(pci_slot_mutex);
> @@ -6484,7 +6485,12 @@ struct pci_dev __weak *pci_real_dma_dev(struct pci_dev *dev)
>  
>  resource_size_t __weak pcibios_default_alignment(void)
>  {
> -	return 0;
> +	/*
> +	 * Avoid MSI-X tables being mapped in the same 4k region as other data
> +	 * according to PCIe 6.1 specification section 7.7.2 MSI-X Capability
> +	 * and Table Structure.
> +	 */

I think this is sort of a "spec compliance" comment that is not the
*real* reason we want to do this, i.e., it doesn't say that by doing
this we can pass through more devices to guests.

Doing this in pcibios_default_alignment() ends up being a very
non-obvious way to make this happen.  We have to:

  - Know what the purpose of this is, and the current comment doesn't
    point to that.

  - Look at all the implementations of pcibios_default_alignment()
    (thanks, powerpc).

  - Trace up through pci_specified_resource_alignment(), which
    contains a bunch of code that is not relevant to this case and
    always just returns PAGE_SIZE.

  - Trace up again to pci_reassigndev_resource_alignment() to see
    where this finally applies to the resources we care about.  The
    comment here about "check if specified PCI is target device" is
    actively misleading for the passthrough usage.

I hate adding new kernel parameters, but I kind of think this would be
easier if we added one that mentioned passthrough or guests and tested
it directly in pci_reassigndev_resource_alignment().

This would also be a way to avoid the "Can't reassign resources to
host bridge" warning that I think we're going to see all the time.

> +	return max(SZ_4K, PAGE_SIZE);
>  }
>  
>  /*
> -- 
> 2.46.0
> 

