Return-Path: <linux-pci+bounces-38760-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A159CBF1C26
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 16:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 819E44E6AA8
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 14:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6F72FC00A;
	Mon, 20 Oct 2025 14:13:23 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D88F13BC0C;
	Mon, 20 Oct 2025 14:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.175.24.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760969603; cv=none; b=S9OZTqW1lm25W6f0dqlwyTvZn8bMj6bfz/PKiGFz+EIBEtBdn4VWR1fNnl6PiXfhEyrAf0y7z6uizGvia8vKkzgpMnz2neBtK5qXYlqGgxAqUrKQlCjaeZtbSpJHRpNzmFM8d59INN79xtQOkzsgTG8OPPqh5i0k6oqNrPS98jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760969603; c=relaxed/simple;
	bh=LlUYGCMthVCehFdZICIUwVx0slH6kaNxISJiczGG1KM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aKTt6CefO6YOcTJ3nY7SjviDtrm/kIMO+KPxx+JKreikxJTTOqGT1ZboqrS0njINq6Nm0FJ/++86yPPOInKVO0n8wfgl2i8nvpZaJf/8SB1T6oIurU5FWCRbcM16igoaUNmM96wBmsOpDENVZeuBp9V2PQZhQQikAF1vXSkOsmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de; spf=pass smtp.mailfrom=alpha.franken.de; arc=none smtp.client-ip=193.175.24.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpha.franken.de
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
	id 1vAqdI-0002ei-00; Mon, 20 Oct 2025 16:13:08 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
	id 8A959C0256; Mon, 20 Oct 2025 16:12:52 +0200 (CEST)
Date: Mon, 20 Oct 2025 16:12:52 +0200
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
	"Maciej W . Rozycki" <macro@orcam.me.uk>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] MIPS: Malta: Use pcibios_align_resource() to
 block io range
Message-ID: <aPZDZJ9DtxQhRSq6@alpha.franken.de>
References: <20251017110903.1973-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251017110903.1973-1-ilpo.jarvinen@linux.intel.com>

On Fri, Oct 17, 2025 at 02:09:03PM +0300, Ilpo Järvinen wrote:
> According to Maciej W. Rozycki <macro@orcam.me.uk>, the
> mips_pcibios_init() for malta adjusts root bus IO resource start
> address to prevent interfering with PIIX4 I/O cycle decoding. Adjusting
> lower bound leaves PIIX4 IO resources outside of the root bus resource
> and assign_fixed_resource_on_bus() does not link the resources into the
> resource tree.
> 
> Prior to commit ae81aad5c2e1 ("MIPS: PCI: Use pci_enable_resources()")
> the arch specific pcibios_enable_resources() did not check if the
> resources were assigned which diverges from what PCI core checks,
> effectively hiding the PIIX4 IO resources were not properly within the
> resource tree. After starting to use pcibios_enable_resources() from
> PCI core, enabling PIIX4 fails:
> 
> ata_piix 0000:00:0a.1: BAR 0 [io  0x01f0-0x01f7]: not claimed; can't enable device
> ata_piix 0000:00:0a.1: probe with driver ata_piix failed with error -22
> 
> MIPS PCI code already has support for enforcing lower bounds using
> PCIBIOS_MIN_IO in pcibios_align_resource() without altering the IO
> window start address itself. Make malta PCI code too to use
> PCIBIOS_MIN_IO.
> 
> Fixes: ae81aad5c2e1 ("MIPS: PCI: Use pci_enable_resources()")
> Fixes: aa0980b80908 ("Fixes for system controllers for Atlas/Malta core cards.")
> Link: https://lore.kernel.org/linux-pci/9085ab12-1559-4462-9b18-f03dcb9a4088@roeck-us.net/
> Link: https://lore.kernel.org/linux-pci/alpine.DEB.2.21.2510132229120.39634@angie.orcam.me.uk/
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Suggested-by: Maciej W. Rozycki <macro@orcam.me.uk>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
> 
> v2:
> 
> - Remove if and always set PCIBIOS_MIN_IO (suggested by Maciej).
> - Minor improvement to the changelog
> 
>  arch/mips/pci/pci-malta.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/mips/pci/pci-malta.c b/arch/mips/pci/pci-malta.c
> index 6aefdf20ca05..2e35aeba45bc 100644
> --- a/arch/mips/pci/pci-malta.c
> +++ b/arch/mips/pci/pci-malta.c
> @@ -230,8 +230,7 @@ void __init mips_pcibios_init(void)
>  	}
>  
>  	/* PIIX4 ACPI starts at 0x1000 */
> -	if (controller->io_resource->start < 0x00001000UL)
> -		controller->io_resource->start = 0x00001000UL;
> +	PCIBIOS_MIN_IO = 0x1000;
>  
>  	iomem_resource.end &= 0xfffffffffULL;			/* 64 GB */
>  	ioport_resource.end = controller->io_resource->end;
> 
> base-commit: 2f2c7254931f41b5736e3ba12aaa9ac1bbeeeb92
> -- 
> 2.39.5

Acked-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]

