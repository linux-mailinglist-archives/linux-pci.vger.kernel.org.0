Return-Path: <linux-pci+bounces-10174-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8570992EF05
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jul 2024 20:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EB5CB22220
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jul 2024 18:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9784116DC0C;
	Thu, 11 Jul 2024 18:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gZgotSba"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DA754657;
	Thu, 11 Jul 2024 18:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720723238; cv=none; b=YSdD9vrA23Xn4u2ENzvpGdAUYQE8aC1vXswX+q2U+JTmkq+74XDARjPwXj6Zbtyzrppot9+y9pGnC9lNC2Vtcsnr403MynPr3MIX7lw536cxOe3R6sZAn+HUNjvbVfOxpbSzvgrrTq59VQRF2wYwu7o14vOJ/Ud93xhDKvxC3/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720723238; c=relaxed/simple;
	bh=yExZdVqBIAQfVWWzrI3974OVS4cKu6NLKKNVvN1boSY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=q4MDOUP7DkxInhXZRGfIlrdSlwk0/Dx3lRYvSWOSgCTQS22DwBiQMzZpiWAt9qFB4D/BUDWpExXJgS71Skrk10CDoZXTr55klw1LqcngJ7FYBQk97w6FrBX2D18C8MuQuQeO276/Sah/5tX3CW8f5FFVUcuKX+NMUsbLqH0KEzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gZgotSba; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BE9FC32786;
	Thu, 11 Jul 2024 18:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720723237;
	bh=yExZdVqBIAQfVWWzrI3974OVS4cKu6NLKKNVvN1boSY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=gZgotSbabuI/ysZhMOp2LT5EDwQU/ic4lMoZLJpvWDoGBoj4RWIuuzTV641iGJyNA
	 PtYeBzVevF2uD9fjF9dt1Da2QRfF4p4rECCGg0OQQlpQ8Mq+TIWUtk/nmlydM56hAn
	 QEjZpTqg9ZnS+zdEmF1N7MgsMeLCukksVGqwC15EeBybyicQ7NObU8JkaNxe0JXHlb
	 DQLXTDnAlY32CijPxMQhsTjRG8jq0TUv3PCjqJwBrXi5BTdWHj3R4hfBNlfJ9kk7EH
	 HS0IxaZsUhHuS/djAc09jl8y9NAHPCL4I+AIRWfO8pA4QfSNAFrXHbEdLVLFF/QT51
	 3PbwKFQfyjqhw==
Date: Thu, 11 Jul 2024 13:40:35 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Stewart Hildebrand <stewart.hildebrand@amd.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 4/6] x86: PCI: preserve IORESOURCE_STARTALIGN
 alignment
Message-ID: <20240711184035.GA287904@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9c7ceb4-264f-4464-9f22-597d24f74f33@amd.com>

On Wed, Jul 10, 2024 at 06:49:42PM -0400, Stewart Hildebrand wrote:
> On 7/10/24 17:24, Bjorn Helgaas wrote:
> > On Wed, Jul 10, 2024 at 12:16:24PM -0400, Stewart Hildebrand wrote:
> >> On 7/9/24 12:19, Bjorn Helgaas wrote:
> >>> On Tue, Jul 09, 2024 at 09:36:01AM -0400, Stewart Hildebrand wrote:
> >>>> Currently, it's not possible to use the IORESOURCE_STARTALIGN flag on
> >>>> x86 due to the alignment being overwritten in
> >>>> pcibios_allocate_dev_resources(). Make one small change in arch/x86 to
> >>>> make it work on x86.
> >>>
> >>> Is this a regression?  I didn't look up when IORESOURCE_STARTALIGN was
> >>> added, but likely it was for some situation on x86, so presumably it
> >>> worked at one time.  If something broke it in the meantime, it would
> >>> be nice to identify the commit that broke it.
> >>
> >> No, I don't have reason to believe it's a regression.
> >>
> >> IORESOURCE_STARTALIGN was introduced in commit 884525655d07 ("PCI: clean
> >> up resource alignment management").
> > 
> > Ah, OK.  IORESOURCE_STARTALIGN is used for bridge windows, which don't
> > need to be aligned on their size as BARs do.  It would be terrible if
> > that usage was broken, which is why I was alarmed by the idea of it
> > not working on x86> 
> > But this patch is only relevant for BARs.  I was a little confused
> > about IORESOURCE_STARTALIGN for a BAR, but I guess the point is to
> > force alignment on *more* than the BAR's size, e.g., to prevent
> > multiple BARs from being put in the same page.
> > 
> > Bottom line, this would need to be a little more specific so it
> > doesn't suggest that IORESOURCE_STARTALIGN for windows is broken.
> 
> I'll make the commit message clearer.
> 
> > IIUC, the main purpose of the series is to align all BARs to at least
> > 4K.  I don't think the series relies on IORESOURCE_STARTALIGN to do
> > that.
> 
> Yes, it does rely on IORESOURCE_STARTALIGN for BARs.

Oh, I missed that, sorry.  The only places I see that set
IORESOURCE_STARTALIGN are pci_request_resource_alignment(), which is
where I got the "pci=resource_alignment=..." connection, and
pbus_size_io(), pbus_size_mem(), and pci_bus_size_cardbus(), which are
for bridge windows, AFAICS.

Doesn't the >= 4K alignment in this series hinge on the
pcibios_default_alignment() change?  It looks like that would force at
least 4K alignment independent of IORESOURCE_STARTALIGN.

> > But there's an issue with "pci=resource_alignment=..." that you
> > noticed sort of incidentally, and this patch fixes that?
> 
> No, pci=resource_alignment= results in IORESOURCE_SIZEALIGN, which
> breaks pcitest. And we'd like pcitest to work properly for PCI
> passthrough validation with Xen, hence the need for
> IORESOURCE_STARTALIGN.

