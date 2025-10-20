Return-Path: <linux-pci+bounces-38822-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F06BF3F21
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 00:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70B76542983
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 22:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DEFA2F3605;
	Mon, 20 Oct 2025 22:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ojXXAGjM"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4B72F291E;
	Mon, 20 Oct 2025 22:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760999837; cv=none; b=Zm26QpkLPt7yqWPVTV/ByBHsOl3EN2hwbjV2bvmpsgpaZIVYFgHKEzC+BaWSHmhOGhaAbO58muIEcGTH22r2n5/7aouEdtNMtExGEpBQxsP3r9ZAnWeON5zBo6Dp5SN5jHGO86VOqMRLygJMmkWK5TO4GXe123KOslWITrMGRNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760999837; c=relaxed/simple;
	bh=X03MLlNZmvU94ilYyWwoQIQq86cMDYcS266UvkvFaP4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=IN5XYOXoSrPRCFiuY6lfFlfN8p0VuRtoXhKBDcwz3eS1N3wJ5wxM4GbWkFbz/creziD3QeVUAxk3t2P+15IJ9RZcj1kJa1UKHuYMaoBjbBFo7/X3HZ5M0Vj6cRNzM0lxtiRBOBsPeUa8tbNA9cF4R391S96WDZ+ZnEscruSxaWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ojXXAGjM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDD21C4CEFB;
	Mon, 20 Oct 2025 22:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760999836;
	bh=X03MLlNZmvU94ilYyWwoQIQq86cMDYcS266UvkvFaP4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ojXXAGjMcvVVLavA9AOYZJch/4+wbt1IikP//ZZFRZ2zHLZC86qZs3boDC5+AypyM
	 bqrvxZvEvSuIbUspGzFMinCdpryn2F41f4d/+RMzq7j77LK5h/hswUm/d0lF7ZbWgr
	 /0iETRL2RRpOBsQQJ1ABZRe/G0KwSXambwtpILOMrHz72hGFmqnWGSi5+KN53+aMr3
	 eQL4levHvEUjBxhtJ7D760Xt/S3o6mxZAw+0AvFoy1DJ6A2egeplwSA4+shbf1UOt3
	 cU9f5Zs/aJBiqkSuIEzCzgpR1Yxhme5KXDNjOcZNPt9LdJurT7vLjpuvzZfxaOaFHW
	 szDTN337qF7jg==
Date: Mon, 20 Oct 2025 17:37:14 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-pci@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
	"Maciej W . Rozycki" <macro@orcam.me.uk>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] MIPS: Malta: Use pcibios_align_resource() to
 block io range
Message-ID: <20251020223714.GA1165320@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251017221204.GA1050107@bhelgaas>

On Fri, Oct 17, 2025 at 05:12:04PM -0500, Bjorn Helgaas wrote:
> On Fri, Oct 17, 2025 at 02:09:03PM +0300, Ilpo Järvinen wrote:
> > According to Maciej W. Rozycki <macro@orcam.me.uk>, the
> > mips_pcibios_init() for malta adjusts root bus IO resource start
> > address to prevent interfering with PIIX4 I/O cycle decoding. Adjusting
> > lower bound leaves PIIX4 IO resources outside of the root bus resource
> > and assign_fixed_resource_on_bus() does not link the resources into the
> > resource tree.
> > 
> > Prior to commit ae81aad5c2e1 ("MIPS: PCI: Use pci_enable_resources()")
> > the arch specific pcibios_enable_resources() did not check if the
> > resources were assigned which diverges from what PCI core checks,
> > effectively hiding the PIIX4 IO resources were not properly within the
> > resource tree. After starting to use pcibios_enable_resources() from
> > PCI core, enabling PIIX4 fails:
> > 
> > ata_piix 0000:00:0a.1: BAR 0 [io  0x01f0-0x01f7]: not claimed; can't enable device
> > ata_piix 0000:00:0a.1: probe with driver ata_piix failed with error -22
> > 
> > MIPS PCI code already has support for enforcing lower bounds using
> > PCIBIOS_MIN_IO in pcibios_align_resource() without altering the IO
> > window start address itself. Make malta PCI code too to use
> > PCIBIOS_MIN_IO.
> > 
> > Fixes: ae81aad5c2e1 ("MIPS: PCI: Use pci_enable_resources()")
> > Fixes: aa0980b80908 ("Fixes for system controllers for Atlas/Malta core cards.")
> > Link: https://lore.kernel.org/linux-pci/9085ab12-1559-4462-9b18-f03dcb9a4088@roeck-us.net/
> > Link: https://lore.kernel.org/linux-pci/alpine.DEB.2.21.2510132229120.39634@angie.orcam.me.uk/
> > Reported-by: Guenter Roeck <linux@roeck-us.net>
> > Suggested-by: Maciej W. Rozycki <macro@orcam.me.uk>
> > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> 
> Since ae81aad5c2e1 ("MIPS: PCI: Use pci_enable_resources()") came
> through the PCI tree, I'd be happy to merge this as well, given your
> ack, Thomas.  It would be ideal to have a tested-by from Guenter.
> 
> I provisionally put it on pci/for-linus to facilitate testing.  If it
> doesn't solve the problem or you'd rather take it, Thomas, I'll be
> glad to drop it.

Added:

  Tested-by: Guenter Roeck <linux@roeck-us.net>
  Tested-by: Maciej W. Rozycki <macro@orcam.me.uk>
  Acked-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

and dropped the Fixes: aa0980b80908 ("Fixes for system controllers for
Atlas/Malta core cards.")

If the missing resource reservations (dma1, tiger, dma page reg)
mentioned by Maciej are an issue or can be fixed up, let me know and
we can amend this.

> > ---
> > 
> > v2:
> > 
> > - Remove if and always set PCIBIOS_MIN_IO (suggested by Maciej).
> > - Minor improvement to the changelog
> > 
> >  arch/mips/pci/pci-malta.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/arch/mips/pci/pci-malta.c b/arch/mips/pci/pci-malta.c
> > index 6aefdf20ca05..2e35aeba45bc 100644
> > --- a/arch/mips/pci/pci-malta.c
> > +++ b/arch/mips/pci/pci-malta.c
> > @@ -230,8 +230,7 @@ void __init mips_pcibios_init(void)
> >  	}
> >  
> >  	/* PIIX4 ACPI starts at 0x1000 */
> > -	if (controller->io_resource->start < 0x00001000UL)
> > -		controller->io_resource->start = 0x00001000UL;
> > +	PCIBIOS_MIN_IO = 0x1000;
> >  
> >  	iomem_resource.end &= 0xfffffffffULL;			/* 64 GB */
> >  	ioport_resource.end = controller->io_resource->end;
> > 
> > base-commit: 2f2c7254931f41b5736e3ba12aaa9ac1bbeeeb92
> > -- 
> > 2.39.5
> > 

