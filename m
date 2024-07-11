Return-Path: <linux-pci+bounces-10186-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE3992F066
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jul 2024 22:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 123AA1F2290F
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jul 2024 20:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782FC16EB4E;
	Thu, 11 Jul 2024 20:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n2BUhcDG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E07F13D8B0;
	Thu, 11 Jul 2024 20:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720730126; cv=none; b=lCFECsdCqLrLbvDHYHxfPduzeyEmcNzykfY9kGCnwg/+ZwCiYr73QJY+4FOwMQO4TX0klP++XOk/AwUfXRAHGQi+g/nD475kRfHkb8zHdw34tWWWcHhcpzGwmh2JM2rRRqvfXfdGzIu7uUZqKc1Tr/0yfAjPt5kdnCKAMSm4h48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720730126; c=relaxed/simple;
	bh=iFJFYmhWImDM0jEpLxRGU6bAqYWnxSv+Rj211j1iVMU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=jv781jmK2FN/hxw6sjq2HzMfMPUMP1QVULCawR5Bn1qOAR2BVMcpYY9pchZRXP2UFYpES4UzL6s3OwlG9JYsBGMRKftDy6/41TYff3YXrw/Ou3DkyyN9r7aMVnVA8XtVfzJ/jaEbyOjOV+J1wSDsgklX1PUJfyIABSKZiSBslQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n2BUhcDG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAB9FC116B1;
	Thu, 11 Jul 2024 20:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720730125;
	bh=iFJFYmhWImDM0jEpLxRGU6bAqYWnxSv+Rj211j1iVMU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=n2BUhcDGDBEx/zUMKTuICwZAxXsv0jdftodlqY29iOmiE+5WY7ou3hc/PNCht8RJd
	 1o6eDPq5dWtu0ZA7UibOdx79hAuFJaBkyStN3G2VXFmitoxF4d/RMOCO+c91IUHU8n
	 6cuVSl3pYKagVFskS1MfrQxbTesP9LcQdAzIwGkODIfW7u8Q4Pkx4rJd0h9XYnbyLx
	 PgVAO/0KAuLQR+KVgDyYGk3FS2tzOTBNkum5+Nk7SrhghyS8xZ+hwMNQ+tZjFPPnS8
	 xFOH3zryNeS5KgBQAH+Rv0C5JKXnya02SWY03PyGBR5iGfAx/8mkxd29yLUhelhZxm
	 WDbnZclsaDY4Q==
Date: Thu, 11 Jul 2024 15:35:23 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Stewart Hildebrand <stewart.hildebrand@amd.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yongji Xie <elohimes@gmail.com>
Subject: Re: [RFC PATCH 4/6] x86: PCI: preserve IORESOURCE_STARTALIGN
 alignment
Message-ID: <20240711203523.GA292007@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eda06f77-14b3-4503-9a86-c55092ccf5b7@amd.com>

[+cc Yongji Xie]

On Thu, Jul 11, 2024 at 02:58:24PM -0400, Stewart Hildebrand wrote:
> On 7/11/24 14:40, Bjorn Helgaas wrote:
> > On Wed, Jul 10, 2024 at 06:49:42PM -0400, Stewart Hildebrand wrote:
> >> On 7/10/24 17:24, Bjorn Helgaas wrote:
> >>> On Wed, Jul 10, 2024 at 12:16:24PM -0400, Stewart Hildebrand wrote:
> >>>> On 7/9/24 12:19, Bjorn Helgaas wrote:
> >>>>> On Tue, Jul 09, 2024 at 09:36:01AM -0400, Stewart Hildebrand wrote:
> >>>>>> Currently, it's not possible to use the IORESOURCE_STARTALIGN flag on
> >>>>>> x86 due to the alignment being overwritten in
> >>>>>> pcibios_allocate_dev_resources(). Make one small change in arch/x86 to
> >>>>>> make it work on x86.
> ...

> >>> IIUC, the main purpose of the series is to align all BARs to at least
> >>> 4K.  I don't think the series relies on IORESOURCE_STARTALIGN to do
> >>> that.
> >>
> >> Yes, it does rely on IORESOURCE_STARTALIGN for BARs.
> > 
> > Oh, I missed that, sorry.  The only places I see that set
> > IORESOURCE_STARTALIGN are pci_request_resource_alignment(), which is
> > where I got the "pci=resource_alignment=..." connection, and
> > pbus_size_io(), pbus_size_mem(), and pci_bus_size_cardbus(), which are
> > for bridge windows, AFAICS.
> > 
> > Doesn't the >= 4K alignment in this series hinge on the
> > pcibios_default_alignment() change?
> 
> Yep
> 
> > It looks like that would force at
> > least 4K alignment independent of IORESOURCE_STARTALIGN.
> 
> Changing pcibios_default_alignment() (without pci=resource_alignment=
> specified) results in IORESOURCE_STARTALIGN.

Mmmm.  I guess it's this path:

  pci_device_add
    pci_reassigndev_resource_alignment
      align = pci_specified_resource_alignment(&resize)
	pcibios_default_alignment
      for (i = 0; i <= PCI_ROM_RESOURCE; i++)
	pci_request_resource_alignment(i, align, resize)
	  if (!resize)
	    r->flags |= IORESOURCE_STARTALIGN

where "resize" is false because the device wasn't mentioned in a
"pci=resource_alignment=..." parameter, so
pci_request_resource_alignment() sets IORESOURCE_STARTALIGN.

When 0a701aa63784 ("PCI: Add pcibios_default_alignment() for
arch-specific alignment control") added pcibios_default_alignment(),
we got a way to do arch-specific alignment, but if the alignment is
non-zero, the implementation *also* applies that alignment to ALL
devices in the system.

Prior to 0a701aa63784, I think pci_specified_resource_alignment()
only caused increased alignment for devices mentioned with a
"pci=resource_alignment=..." parameter.

I suppose the change to do it for all devices was intentional because
382746376993 ("powerpc/powernv: Override pcibios_default_alignment()
to force PCI devices to be page aligned") says it's for all PCI
devices on PowerNV.

Since 0a701aa63784 and 382746376993 were for VFIO, which is generic, I
kind of wish that we'd done it in a more generic way instead of making
a pcibios interface that is only implemented for PowerNV.

This series does make it generic by doing it in the weak
pcibios_default_alignment() that's used by default, so that's good.

It's ancient history now, but I'm also a little unsure about the way
pci_reassigndev_resource_alignment() is kind of tacked on at the end
in pci_device_add() and not integrated with the usual BAR sizing and
allocation machinery.

> >>> But there's an issue with "pci=resource_alignment=..." that you
> >>> noticed sort of incidentally, and this patch fixes that?
> >>
> >> No, pci=resource_alignment= results in IORESOURCE_SIZEALIGN, which
> >> breaks pcitest. And we'd like pcitest to work properly for PCI
> >> passthrough validation with Xen, hence the need for
> >> IORESOURCE_STARTALIGN.

Thanks for working on this.

Bjorn

