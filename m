Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA381DBAA9
	for <lists+linux-pci@lfdr.de>; Wed, 20 May 2020 19:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbgETRGM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 May 2020 13:06:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:51032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726691AbgETRGM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 20 May 2020 13:06:12 -0400
Received: from localhost (mobile-166-175-190-200.mycingular.net [166.175.190.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5875D206B6;
        Wed, 20 May 2020 17:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589994371;
        bh=Aez3bt5RSI5x2M+Aq9gqw/CVQIm6EaNs/OL8Hr/iEQo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=wU9b3sPAw35AKjgGr+ow1fBYT2wlCmyPsG5sNTqLN92Mfp4BzV4us6eBvfvyusT+W
         QFh+KtYSXIIxFY9nHsJN62FFbXiCV+NEAJOM5hWJLECuXWTLoBRTdxctalNfvEikOq
         xNEaVoVJzunwhT9PArxHFqmT839CMdXQdwst6jy4=
Date:   Wed, 20 May 2020 12:06:09 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Krzysztof Wilczynski <kw@linux.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Chuhong Yuan <hslester96@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Takashi Iwai <tiwai@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 1/3] PCI: Correct the PCI quirk for the ALI M7101
 chipset
Message-ID: <20200520170609.GA1102503@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520103147.985326-2-kw@linux.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 20, 2020 at 10:31:45AM +0000, Krzysztof Wilczynski wrote:
> As per the specifications from the vendor:
> 
>   - "M1543 Preliminary Data Sheet", "M1543: Desktop South Bridge",
>     Acer Laboratories Inc., January 1998, Version 1.25, p. 78
> 
>   - "M1543C Preliminary Datasheet", "M1543C Desktop Southbridge",
>     Acer Laboratories Inc., September 1998, Version 1.10, p. 126
> 
> Both the ACPI I/O and SMB I/O registers should be mapped into I/O space,
> but the second quirk used to claimed an I/O resource from the memory
> window which is not correct.
> 
> Signed-off-by: Krzysztof Wilczynski <kw@linux.com>
> ---
>  drivers/pci/quirks.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index ca9ed5774eb1..c71fdd8bd6f8 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -654,7 +654,7 @@ DECLARE_PCI_FIXUP_CLASS_HEADER(PCI_VENDOR_ID_SYNOPSYS, PCI_ANY_ID,
>  static void quirk_ali7101_acpi(struct pci_dev *dev)
>  {
>  	quirk_io_region(dev, 0xE0, 64, PCI_BRIDGE_RESOURCES, "ali7101 ACPI");
> -	quirk_io_region(dev, 0xE2, 32, PCI_BRIDGE_RESOURCES+1, "ali7101 SMB");
> +	quirk_io_region(dev, 0xE2, 32, PCI_BRIDGE_RESOURCES, "ali7101 SMB");

Wow, this is way too subtle.  I proposed this fix, but I was wrong.

I thought PCI_BRIDGE_RESOURCES was identifying a bridge window that
the region should be claimed from: dev->resource[PCI_BRIDGE_RESOURCES]
would be the I/O port window of a bridge.

But that's not what's happening at all.  quirk_io_region() is using
that index to fill in a dev->resource[] entry with an IORESOURCE_IO
resource, and then it calls pci_claim_resource(), which looks for an
upstream bridge window that contains the resource (in
pci_find_parent_resource()).

So the use of PCI_BRIDGE_RESOURCES here is just a convenient way to
find an empty slot in dev->resource[].  We know it's empty because
the ali7101 device is not a bridge, so it has no windows.

And PCI_BRIDGE_RESOURCES+1 *looks* like a reference to a bridge's
memory window, but it's not; it's just a way to find another empty
dev->resource[] slot.

Sigh.  This is ugly and misleading.  But in the absence of good ideas,
I guess we should just leave it alone.

>  }
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL,	PCI_DEVICE_ID_AL_M7101,		quirk_ali7101_acpi);
>  
> -- 
> 2.26.2
> 
