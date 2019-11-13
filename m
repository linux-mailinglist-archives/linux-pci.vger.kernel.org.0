Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67653FB81F
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2019 19:54:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbfKMSy1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Nov 2019 13:54:27 -0500
Received: from mail.skyhub.de ([5.9.137.197]:35512 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727216AbfKMSy1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 13 Nov 2019 13:54:27 -0500
Received: from zn.tnic (p200300EC2F0FA700E9EFB2260700430D.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:a700:e9ef:b226:700:430d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EDD1A1EC02C1;
        Wed, 13 Nov 2019 19:54:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1573671266;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=fKB2AuyJAPcFgKm9JK8f4US/BxjyKR1akqFbBmoGVJY=;
        b=Tb4SBglwTALtQ49MfkqDXXuYebN7qrtTVw0CSjdBQ0cVIOpYhLhCI6hokl6Xdmb+WTlT7J
        2zK790PGCc+lFSy8HUPO4SPFo60ei3vNHm4SoUN+B5LJ8uKMiSqrIj4R/j56NH5uhud2pY
        PXLkUuAiIS9ABRqLD8xPUEmWjDkDUF4=
Date:   Wed, 13 Nov 2019 19:54:20 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Christoph Hellwig <hch@lst.de>
Cc:     rubini@gnudd.com, hch@infradead.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 2/2] x86/PCI: sta2x11: use default DMA address
 translation
Message-ID: <20191113185420.GC1647@zn.tnic>
References: <20191107150646.13485-1-nsaenzjulienne@suse.de>
 <20191107150646.13485-3-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191107150646.13485-3-nsaenzjulienne@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 07, 2019 at 04:06:45PM +0100, Nicolas Saenz Julienne wrote:
> The devices found behind this PCIe chip have unusual DMA mapping
> constraints as there is an AMBA interconnect placed in between them and
> the different PCI endpoints. The offset between physical memory
> addresses and AMBA's view is provided by reading a PCI config register,
> which is saved and used whenever DMA mapping is needed.
> 
> It turns out that this DMA setup can be represented by properly setting
> 'dma_pfn_offset', 'dma_bus_mask' and 'dma_mask' during the PCI device
> enable fixup. And ultimately allows us to get rid of this device's
> custom DMA functions.
> 
> Aside from the code deletion and DMA setup, sta2x11_pdev_to_mapping() is
> moved to avoid warnings whenever CONFIG_PM is not enabled.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> ---
> 
> Changed since v1:
>   - use variable to avoid recalculating AMBA's max address
>   - remove x86's dma-direct.h as it's not longer needed
> 
>  arch/x86/Kconfig                  |   1 -
>  arch/x86/include/asm/device.h     |   3 -
>  arch/x86/include/asm/dma-direct.h |   9 --
>  arch/x86/pci/sta2x11-fixup.c      | 135 ++++++------------------------
>  4 files changed, 26 insertions(+), 122 deletions(-)
>  delete mode 100644 arch/x86/include/asm/dma-direct.h

Ok, I have only 2/2 in my mbox so in the future, when sending a whole
set, make sure you Cc everybody on all the patches so that people can
see the whole thing.

Then, I went and read back all the discussion about this cleanup and
how it is hard to test it because it is not in PCs but in automotive
installations...

Long story, short, I like patches with negative diffstats :) so I could
take it through tip unless Christoph has different plans for this.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
