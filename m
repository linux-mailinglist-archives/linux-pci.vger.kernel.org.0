Return-Path: <linux-pci+bounces-34138-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A490B29288
	for <lists+linux-pci@lfdr.de>; Sun, 17 Aug 2025 11:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C8697A3824
	for <lists+linux-pci@lfdr.de>; Sun, 17 Aug 2025 09:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792E9221FC4;
	Sun, 17 Aug 2025 09:54:03 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2EBA1B0F33;
	Sun, 17 Aug 2025 09:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755424443; cv=none; b=dZXeyg2gIemgaa4N/pfOeJgZeGIACQxWSZpq9yIEbs7+51rqBiD9sNP2sjikdFgsjbAkaZTX/Z2D3srh6JDwiiDci17Gi3AzJU4KfNAHS3Px1KBrj4DVuJmZlGzeN3Mn3RfkSCQVqQQbrAwG9oW0s+jsCy8jTSdBdeDNtmmmzAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755424443; c=relaxed/simple;
	bh=eRfsKNbBkxnUUsP07pC1a2kBKCNH/1l/vzUSBUvQwwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gmJ7H7qge9hFbYI2/YeVQC1vULGUJcsAc1wNFjAPZ7RjoBh4Fdee21gUazvVZczPv+jYM/MhuBqX+klWROyKmGDjerOtl2ytEOCBFUzD3TXH8fjQ92xO2SYBxI3B0hfuJPsu8WNLNqKa7jBPaDzTiI6ptSZJxjvzfQvD2Vvap54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 5889A2C000BF;
	Sun, 17 Aug 2025 11:45:17 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 3BF804A8C7; Sun, 17 Aug 2025 11:45:17 +0200 (CEST)
Date: Sun, 17 Aug 2025 11:45:17 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Tomita Moeko <tomitamoeko@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] x86/pci: Check signature before assigning shadow
 ROM
Message-ID: <aKGkrSWUA8BTYniZ@wunner.de>
References: <20250815162041.14826-1-tomitamoeko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815162041.14826-1-tomitamoeko@gmail.com>

On Sat, Aug 16, 2025 at 12:20:41AM +0800, Tomita Moeko wrote:
> Modern platforms without VBIOS or UEFI CSM support do not contain
> VGA ROM at 0xC0000, this is observed on Intel Ice Lake and later
> systems. Check whether the VGA ROM region is a valid PCI option ROM
> with 0xAA55 signature before assigning the shadow ROM to device.

Which spec is the 0xAA55 magic number coming from?

Could you add a spec reference for it in a code comment and the
commit message?

I note that arch/x86/kernel/probe_roms.c contains ...

  #define ROMSIGNATURE 0xaa55

... and a function romsignature() to check the signature.
I'm wondering why that existing check isn't sufficient?
Why is it necessary to check again elsewhere?

> +++ b/arch/x86/pci/fixup.c
> @@ -317,6 +317,7 @@ static void pci_fixup_video(struct pci_dev *pdev)
>  	struct pci_bus *bus;
>  	u16 config;
>  	struct resource *res;
> +	void __iomem *rom;
>  
>  	/* Is VGA routed to us? */
>  	bus = pdev->bus;
> @@ -338,9 +339,12 @@ static void pci_fixup_video(struct pci_dev *pdev)
>  		}
>  		bus = bus->parent;
>  	}
> -	if (!vga_default_device() || pdev == vga_default_device()) {
> +
> +	rom = ioremap(0xC0000, 0x20000);

There's a code comment preceding pci_fixup_video() which says that
"BIOS [is] copied to 0xC0000 in system RAM".  So this isn't MMIO,
it's system memory and you can use memremap() instead if ioremap().

Since you're only interested in the first two bytes, you don't need
to map the whole 0x20000 bytes.

Instead of amending the if-condition ...

> +	if (rom && (!vga_default_device() || pdev == vga_default_device())) {
>  		pci_read_config_word(pdev, PCI_COMMAND, &config);
> -		if (config & (PCI_COMMAND_IO | PCI_COMMAND_MEMORY)) {
> +		if ((config & (PCI_COMMAND_IO | PCI_COMMAND_MEMORY)) &&
> +		    (readw(rom) == 0xAA55)) {
>  			res = &pdev->resource[PCI_ROM_RESOURCE];

... you could just return on failure to find a valid signature, i.e.:

+	rom = memremap(0xC0000, sizeof(sig), MEMREMAP_WB);
+	if (!rom)
+		return;
+
+	memcpy(&sig, rom, sizeof(sig));
+	memunmap(rom);
+	if (sig != 0xAA55)
+		return;

May want to emit an error on failure to memremap().

Amending the if-condition makes it messier to find an offending commit
with "git blame" (more iterations needed).  And returning early reduces
indentation levels per section 1 of Documentation/process/coding-style.rst.

Thanks,

Lukas

