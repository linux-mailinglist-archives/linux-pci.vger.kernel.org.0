Return-Path: <linux-pci+bounces-38517-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D38EABEBE41
	for <lists+linux-pci@lfdr.de>; Sat, 18 Oct 2025 00:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BA62C4E6924
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 22:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4032D4801;
	Fri, 17 Oct 2025 22:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UYUvH6g/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3098E280328;
	Fri, 17 Oct 2025 22:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760739126; cv=none; b=like2Lw4jo+rp1+DwXwAYlGdJXks3eqCXBzD7t371VZdrr7jBCxju14qKNUq9LZRgSwn2sVbDjGrLzP4GyNhOAQNyVehjVkviljA8bjp9rcu25G/cJaxcvGAn5TaiOnYverV87affRE+D2flJL+Fm52usjAtoJWGnMtQnycVj/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760739126; c=relaxed/simple;
	bh=VbITHlse1BuS678Ou1dYutgpFgxm/qqrQ4OxMn+C6F8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=u9GVjunnT/VOhCoUzIWvNmBfMS2d2Wc7sEy/Z+lqaMyM4ge3SmIWmyS3ijfC911DdDtE+ZGormOaeoK58BTVyf3T5qrSy1cj+4kuiBzpAtmCEDmt5ad21+nLfv4Pobcz0/Aj0Cy/s6Gy5lhESxQgeF95IRl8NeIiglQQGZxo61c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UYUvH6g/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4E80C4CEE7;
	Fri, 17 Oct 2025 22:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760739126;
	bh=VbITHlse1BuS678Ou1dYutgpFgxm/qqrQ4OxMn+C6F8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=UYUvH6g/+HhUzItYNDIgZNNKZ1g20ytj427deTlRIu/a9f4Rjg3k/Cf7t5P7SLVG4
	 hH6dgigkUAC0J9NFycHwhpFRc00GOLwrCUHPYN5z3MSM6wRpFIkFtDnbSZaiMqrA56
	 tyAmHoYgXpoEhHCsJxsHUSj4c617V5OMplO5oqOyHW6WACLeYS0yCjRxugzzHeODvH
	 3SN6IE3EhoWTQZ4Css/RHWu9haDuQtpOkl5ZnY06l0DUy3eENrFbT8emo+4BBaKtXo
	 lB16QlBxWfnVI6tjnEuVbqDnPVOtNL0xZf5iW7Pi9PULfE8+s8k8uU1vL6ZmPko6Wg
	 mNwqRz5VvRXvA==
Date: Fri, 17 Oct 2025 17:12:04 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-pci@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
	"Maciej W . Rozycki" <macro@orcam.me.uk>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] MIPS: Malta: Use pcibios_align_resource() to
 block io range
Message-ID: <20251017221204.GA1050107@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

Since ae81aad5c2e1 ("MIPS: PCI: Use pci_enable_resources()") came
through the PCI tree, I'd be happy to merge this as well, given your
ack, Thomas.  It would be ideal to have a tested-by from Guenter.

I provisionally put it on pci/for-linus to facilitate testing.  If it
doesn't solve the problem or you'd rather take it, Thomas, I'll be
glad to drop it.

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
> 

