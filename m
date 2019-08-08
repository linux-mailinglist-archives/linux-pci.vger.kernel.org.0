Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9F386CB1
	for <lists+linux-pci@lfdr.de>; Thu,  8 Aug 2019 23:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390361AbfHHVrd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Aug 2019 17:47:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:32810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725535AbfHHVrd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 8 Aug 2019 17:47:33 -0400
Received: from localhost (unknown [150.199.191.185])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9BA021874;
        Thu,  8 Aug 2019 21:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565300849;
        bh=vG7jKkEd8XcA9+P2LeOF6CIxzYS5OeGuGE45x2CRGSQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=opUMVt0G8O9WCbMpvtgG81GcK9OmkTHd8OQ7YfusFWIzrAVFBCybyjtsfn9Uw+7xN
         Xb1yeoZLxo4lZAHUdD2CMnGhv7CdnbDf2uFzuMrFcXQ3Pf80HWHMbaw+38Bi31odbX
         abWk6E491TFBB96Ac8IIAIBJ02cp9J3AXMvuiiVg=
Date:   Thu, 8 Aug 2019 16:47:28 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Wesley Terpstra <wesley@sifive.com>
Subject: Re: [PATCH v2] pci: Kconfig: select PCI_MSI_IRQ_DOMAIN by default on
 RISC-V
Message-ID: <20190808214728.GC7302@google.com>
References: <alpine.DEB.2.21.9999.1907251426450.32766@viisi.sifive.com>
 <20190808195546.GA7302@google.com>
 <alpine.DEB.2.21.9999.1908081349210.6414@viisi.sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.9999.1908081349210.6414@viisi.sifive.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 08, 2019 at 01:51:50PM -0700, Paul Walmsley wrote:
> On Thu, 8 Aug 2019, Bjorn Helgaas wrote:
> > On Thu, Jul 25, 2019 at 02:28:07PM -0700, Paul Walmsley wrote:
> > > From: Wesley Terpstra <wesley@sifive.com>
> > > 
> > > This is part of adding support for RISC-V systems with PCIe host 
> > > controllers that support message-signaled interrupts.
> > > 
> > > Signed-off-by: Wesley Terpstra <wesley@sifive.com>
> > > [paul.walmsley@sifive.com: wrote patch description; split this
> > >  patch from the arch/riscv patch]
> > > Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
> > > ---
> > >  drivers/pci/Kconfig | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> > > index 2ab92409210a..beb3408a0272 100644
> > > --- a/drivers/pci/Kconfig
> > > +++ b/drivers/pci/Kconfig
> > > @@ -52,7 +52,7 @@ config PCI_MSI
> > >  	   If you don't know what to do here, say Y.
> > >  
> > >  config PCI_MSI_IRQ_DOMAIN
> > > -	def_bool ARC || ARM || ARM64 || X86
> > > +	def_bool ARC || ARM || ARM64 || X86 || RISCV
> > 
> > The other arches listed here either supply their own include/asm/msi.h
> > or generate it:
> > 
> >   $ ls arch/*/include/asm/msi.h
> >   arch/x86/include/asm/msi.h
> > 
> >   $ grep msi.h arch/*/include/asm/Kbuild
> >   arch/arc/include/asm/Kbuild:generic-y += msi.h
> >   arch/arm64/include/asm/Kbuild:generic-y += msi.h
> >   arch/arm/include/asm/Kbuild:generic-y += msi.h
> >   arch/mips/include/asm/Kbuild:generic-y += msi.h
> >   arch/powerpc/include/asm/Kbuild:generic-y += msi.h
> >   arch/sparc/include/asm/Kbuild:generic-y += msi.h
> > 
> > For example, see
> > 
> >   f8430eae9f1b ("PCI/MSI: Enable PCI_MSI_IRQ_DOMAIN support for ARC")
> >   be091d468a0a ("arm64: PCI/MSI: Use asm-generic/msi.h")
> >   0ab089c2548c ("ARM: Add msi.h to Kbuild")
> > 
> > I didn't look into the details of msi.h generation, but I assume
> > RISC-V needs to do something similar?  If so, I think that should be
> > part of this patch to avoid issues.
> > 
> > If CONFIG_GENERIC_MSI_IRQ_DOMAIN is defined, include/linux/msi.h
> > #includes <asm/msi.h> and I don't see where that would come from.
> 
> Commit 251a44888183 ("riscv: include generic support for MSI irqdomains") 
> has been merged upstream for this purpose:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=251a44888183003b0380df184835a2c00bfa39d7
> 
> The original patch was split into a RISC-V component and a generic PCI 
> component to reduce the risk of merge conflicts.
> 
> Does that work for you?

Indeed, sorry I missed it.  I generally work based on -rc1, and it
looks like 251a44888183 was merged after -rc1.

Since we're after the merge window, the default target would be v5.4,
but I see some post-rc1 pull requests from you, so if you need this in
v5.3, let me know.

I applied your patch to pci/msi for v5.4 for now.

Bjorn
