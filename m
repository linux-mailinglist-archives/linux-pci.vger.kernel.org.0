Return-Path: <linux-pci+bounces-38879-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A19ABF66B5
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 14:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 490C4541DDE
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 12:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DCA116A956;
	Tue, 21 Oct 2025 12:16:02 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412206BB5B;
	Tue, 21 Oct 2025 12:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761048962; cv=none; b=S/1Y/YP323K9u7LyL9RIUHzWSOYig0jAzamdx/eccy6wOtuieD1cmxb3NgDEGFB6v8y754wIeDVIXd+Vip0nAjj1HXEkbFDbc5Zbdju4lMJW4m8lry/iM0jpMhScH2v5Gukl42vkcfhJFMZo2qwUTEEdqgWPmO7tWvTkCXewcKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761048962; c=relaxed/simple;
	bh=EdWXsHmmqwuhqUifnjdtEASSh8bC7pcsjZQVWMANaVs=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=OmtRD0Cv7Tg/IOhbm/aVQ42ZvKp+rR0EHiI+Hq15wavw1kwmL47tASEmiQhcQqFtZUHhMCx9P7IKV+R3HqkQkAZC8gBMsOj588oH/605jF924fyBOdy1rNi4QLI+LeBDeaQmKPQg60pT7CWRraK6EydaXkP/ASarkmWT9oHBB8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 8401792009C; Tue, 21 Oct 2025 14:15:51 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 7DACD92009B;
	Tue, 21 Oct 2025 13:15:51 +0100 (BST)
Date: Tue, 21 Oct 2025 13:15:51 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Bjorn Helgaas <helgaas@kernel.org>
cc: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
    Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-pci@vger.kernel.org, 
    Guenter Roeck <linux@roeck-us.net>, Bjorn Helgaas <bhelgaas@google.com>, 
    linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] MIPS: Malta: Use pcibios_align_resource() to
 block io range
In-Reply-To: <20251020223714.GA1165320@bhelgaas>
Message-ID: <alpine.DEB.2.21.2510210145260.8377@angie.orcam.me.uk>
References: <20251020223714.GA1165320@bhelgaas>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 20 Oct 2025, Bjorn Helgaas wrote:

> > Since ae81aad5c2e1 ("MIPS: PCI: Use pci_enable_resources()") came
> > through the PCI tree, I'd be happy to merge this as well, given your
> > ack, Thomas.  It would be ideal to have a tested-by from Guenter.
> > 
> > I provisionally put it on pci/for-linus to facilitate testing.  If it
> > doesn't solve the problem or you'd rather take it, Thomas, I'll be
> > glad to drop it.
> 
> Added:
> 
>   Tested-by: Guenter Roeck <linux@roeck-us.net>
>   Tested-by: Maciej W. Rozycki <macro@orcam.me.uk>
>   Acked-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> 
> and dropped the Fixes: aa0980b80908 ("Fixes for system controllers for
> Atlas/Malta core cards.")
> 
> If the missing resource reservations (dma1, tiger, dma page reg)
> mentioned by Maciej are an issue or can be fixed up, let me know and
> we can amend this.

 NB this comes from `plat_mem_setup' in arch/mips/mti-malta/malta-setup.c 
iterating over `standard_io_resources'.  ISTR now this being my original 
reason to come up with the approach taken with commit aa0980b80908 rather 
than using PCIBIOS_MIN_IO.  Since the ranges are now owned by the PCI host 
bridge, calls to `request_resource' referring `ioport_resource' fail.

 I'm not sure offhand how to get a hold on the right handle under the new 
arrangement in this platform code, but clearly it must be doable as x86 
gets it right (and conversely Alpha gets it totally wrong).

 Also I think we should reserve the PCI port I/O window in the MMIO space 
as well; something that I pondered back those 20 years ago already.  For 
the system I've used here that'd show up as:

10000000-1affffff : MSC PCI MEM
  10000000-100fffff : 0000:00:0b.0
  [...]
  10142080-1014209f : 0000:00:0b.0
1b000000-1bffffff : MSC PCI I/O
1e000000-1e3fffff : 1e000000.flash flash@1e000000

Most non-x86 PCI host bridges have one, but I haven't come across a Linux
platform that would report it.

  Maciej

