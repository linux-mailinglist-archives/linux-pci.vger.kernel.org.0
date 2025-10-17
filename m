Return-Path: <linux-pci+bounces-38466-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E87EBE89E4
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 14:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADD8C58060D
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 12:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED8B2DC328;
	Fri, 17 Oct 2025 12:42:11 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583231E32D6;
	Fri, 17 Oct 2025 12:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760704931; cv=none; b=N06T8pRJKxVrbR2XwgbmTZxqSYLERWvbkHxTWtFzulA11OyVw9AW71/GoPfNLwBa6ea54dwCZP4Ve6vYLTfUHlkQClHZVwsqMNUjjCcMMFuZ4/waewIEE0RC11gpIH7BCmIiIfkL8dUooffViz+S8brBJsJmhFwyZGIVvc1quFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760704931; c=relaxed/simple;
	bh=hNzhvWcwjxoEix9ZmhPB86fymOVEazDzXZ1GHL1XQ4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gdnyCVVfxmRrGgJALw7OrqxeQYu0L6TamTx1OQhXvukCiRlw3z/JXeW/YZl9wIHjZgmc9rVBWDLQRy94lO35c0l2Zw0a/YP36Raz4y3R9uOPoSVD0nvfFkrvC09lZHmllpojVQWMXl8Xsf0CjwWCBMX/bsCjhCsTDYr8xeFtVAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id BCA3F2C0A2CB;
	Fri, 17 Oct 2025 14:41:59 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id A76674A12; Fri, 17 Oct 2025 14:41:59 +0200 (CEST)
Date: Fri, 17 Oct 2025 14:41:59 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Tomita Moeko <tomitamoeko@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86/pci: Check signature before assigning shadow ROM
Message-ID: <aPI5l0whaAIJGaSw@wunner.de>
References: <20251016081900.7129-1-tomitamoeko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016081900.7129-1-tomitamoeko@gmail.com>

On Thu, Oct 16, 2025 at 04:19:00PM +0800, Tomita Moeko wrote:
> Recent IGD platforms without VBIOS or UEFI CSM support do not contain
> VGA ROM at 0xC0000. Check whether the VGA ROM region is a valid PCI
> option ROM with 0xAA55 signature before assigning the shadow ROM to
> the default PCI VGA controller.
[...]
> +++ b/arch/x86/pci/fixup.c
> @@ -357,6 +357,18 @@ static void pci_fixup_video(struct pci_dev *pdev)
>  	struct pci_bus *bus;
>  	u16 config;
>  	struct resource *res;
> +	void *rom;
> +	u16 sig;
> +
> +	/* Does VBIOS region contain a valid PCI ROM? */
> +	rom = memremap(0xC0000, sizeof(sig), MEMREMAP_WB);
> +	if (!rom)
> +		return;
> +
> +	memcpy(&sig, rom, sizeof(sig));
> +	memunmap(rom);
> +	if (sig != 0xAA55)
> +		return;
>  
>  	/* Is VGA routed to us? */
>  	bus = pdev->bus;

I have to ask again, in arch/x86/kernel/probe_roms.c:probe_roms(),
the signature is already verified.  If it doesn't match, the
video_rom_resource isn't added to iomem_resource.

Which makes me wonder, wouldn't it be sufficient to just do
something like:

	if (!lookup_resource(&iomem_resource, 0xC0000))
		return;

Another thought I have, I'd move the code you're inserting further
down, perhaps after the while-loop.  Actually the existing code
isn't very pretty, there should be a return after failure of the
vga_default_device checks and after the Command register check
so that the actual resource adjustment doesn't need to be indented.

Thanks,

Lukas

