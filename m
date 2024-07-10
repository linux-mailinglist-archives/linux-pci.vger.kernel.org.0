Return-Path: <linux-pci+bounces-10107-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B2A92DAA9
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 23:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D2631F236D3
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 21:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59EB484A36;
	Wed, 10 Jul 2024 21:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kKizdHGj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309F4132113;
	Wed, 10 Jul 2024 21:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720646650; cv=none; b=b9gzWVlDhhXK+8d1JnjT5T7el3UUVihGHwnjmPuY99vf+Sp72beViuPhFJq+rKiNXUyaYdFfn9BMrzs+Y+bo/wKYuRLOHzzwigBDOc5WcIzQI+e43Fb4QBsmVsBkdx1Xv5DyTt1E1t4v9icEN0pqG4+9ZU11spMsTTApPNP9hTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720646650; c=relaxed/simple;
	bh=Id7k1Bb+me0kiajDSMefCoqvP5RRCJzJ0qXt8HKdbNA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=WWqKZr0JgdDq6UHRDeEXbLFSPpJTaqyDn8ZEo6nQvSaALp+al8Hed+Ygu/ICd+V+af4UJXZhaWozJLe6d26K1JK8NeGzpQ6lWl4I5AvfRaQqkAyTuD5TRz1R83iGlEkLkwf7Rwje6r2bFF52K/Ogbiv3IgajDEDxy6rzHDiNQZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kKizdHGj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63F9BC32781;
	Wed, 10 Jul 2024 21:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720646648;
	bh=Id7k1Bb+me0kiajDSMefCoqvP5RRCJzJ0qXt8HKdbNA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=kKizdHGjA8mdF9s7OqdSqAPgkDpTXY/+dLbRJakpXqQlX0x9FdfjSrOUVvd/tEa9F
	 o1L4/rOzrMc0qw5zigc4usMnfkrYE82uIKyqBDtk6DoPA4oIGCR7Ig/nBTT7Y/nDrz
	 ZKFNamkqJw6+j7ax+ZOHA5Ict25saJuYdro5c+8RhyoX+NZUA2rozHlyS5rga7+x0+
	 xq1Fztuq4WNugU1GxNIj91cyaMKQ1qOhuvc4tDBohApUfb0IdTvUreBIscGoZY0PXa
	 Q48SWchUcZNyJJM6zCSVcDp4zfNL6JK1kMRD5MXNsoAGxyDFr8yQGQmlBa9EG0BD6l
	 g5hyRBEk7mGvw==
Date: Wed, 10 Jul 2024 16:24:06 -0500
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
Message-ID: <20240710212406.GA257375@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <283e6dd9-a8b0-4943-9ceb-3f687013c885@amd.com>

On Wed, Jul 10, 2024 at 12:16:24PM -0400, Stewart Hildebrand wrote:
> On 7/9/24 12:19, Bjorn Helgaas wrote:
> > On Tue, Jul 09, 2024 at 09:36:01AM -0400, Stewart Hildebrand wrote:
> >> Currently, it's not possible to use the IORESOURCE_STARTALIGN flag on
> >> x86 due to the alignment being overwritten in
> >> pcibios_allocate_dev_resources(). Make one small change in arch/x86 to
> >> make it work on x86.
> > 
> > Is this a regression?  I didn't look up when IORESOURCE_STARTALIGN was
> > added, but likely it was for some situation on x86, so presumably it
> > worked at one time.  If something broke it in the meantime, it would
> > be nice to identify the commit that broke it.
> 
> No, I don't have reason to believe it's a regression.
> 
> IORESOURCE_STARTALIGN was introduced in commit 884525655d07 ("PCI: clean
> up resource alignment management").

Ah, OK.  IORESOURCE_STARTALIGN is used for bridge windows, which don't
need to be aligned on their size as BARs do.  It would be terrible if
that usage was broken, which is why I was alarmed by the idea of it
not working on x86.

But this patch is only relevant for BARs.  I was a little confused
about IORESOURCE_STARTALIGN for a BAR, but I guess the point is to
force alignment on *more* than the BAR's size, e.g., to prevent
multiple BARs from being put in the same page.

Bottom line, this would need to be a little more specific so it
doesn't suggest that IORESOURCE_STARTALIGN for windows is broken.

IIUC, the main purpose of the series is to align all BARs to at least
4K.  I don't think the series relies on IORESOURCE_STARTALIGN to do
that.  But there's an issue with "pci=resource_alignment=..." that you
noticed sort of incidentally, and this patch fixes that?  If so, it's
important to mention that parameter.

> >> RFC: We don't have enough info in this function to re-calculate the
> >>      alignment value in case of IORESOURCE_STARTALIGN. Luckily our
> >>      alignment value seems to be intact, so just don't touch it...
> >>      Alternatively, we could call pci_reassigndev_resource_alignment()
> >>      after the loop. Would that be preferable?
> 
> Any comments on this? After some more thought, I think calling
> pci_reassigndev_resource_alignment() after the loop is probably more
> correct, so if there aren't any comments, I'll plan on changing it.

Sounds like this might be a separate patch unless it logically has to
be part of this one to avoid an issue.

> >> ---
> >>  arch/x86/pci/i386.c | 7 +++++--
> >>  1 file changed, 5 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/arch/x86/pci/i386.c b/arch/x86/pci/i386.c
> >> index f2f4a5d50b27..ff6e61389ec7 100644
> >> --- a/arch/x86/pci/i386.c
> >> +++ b/arch/x86/pci/i386.c
> >> @@ -283,8 +283,11 @@ static void pcibios_allocate_dev_resources(struct pci_dev *dev, int pass)
> >>  						/* We'll assign a new address later */
> >>  						pcibios_save_fw_addr(dev,
> >>  								idx, r->start);
> >> -						r->end -= r->start;
> >> -						r->start = 0;
> >> +						if (!(r->flags &
> >> +						      IORESOURCE_STARTALIGN)) {
> >> +							r->end -= r->start;
> >> +							r->start = 0;
> >> +						}

I wondered why this only touched x86 and whether other arches need a
similar change.  This is used in two paths:

  1) pcibios_resource_survey_bus(), which is only implemented by x86

  2) pcibios_resource_survey(), which is implemented by x86 and
  powerpc.  The powerpc pcibios_allocate_resources() is similar to the
  x86 pcibios_allocate_dev_resources(), but powerpc doesn't have the
  r->end and r->start updates you're making conditional.

So it looks like x86 is indeed the only place that needs this change.
None of this stuff is arch-specific, so it's a shame that we don't
have generic code for it all.  Sigh, oh well.

> >>  					}
> >>  				}
> >>  			}
> >> -- 
> >> 2.45.2
> >>
> 

