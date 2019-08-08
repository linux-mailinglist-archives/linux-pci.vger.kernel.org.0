Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1D186BE5
	for <lists+linux-pci@lfdr.de>; Thu,  8 Aug 2019 22:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390287AbfHHUvx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Aug 2019 16:51:53 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39200 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731038AbfHHUvx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Aug 2019 16:51:53 -0400
Received: by mail-ot1-f67.google.com with SMTP id r21so118201235otq.6
        for <linux-pci@vger.kernel.org>; Thu, 08 Aug 2019 13:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=MYiXtYDqJwotW34VbL1gNPhcfMp5HVF3/UwPQRs2BZ8=;
        b=E5VqcLm1TM2dFLlFksMh4Glkk8vf9CShPiNi2v/7qR+H6sMT72hy6Eva/LC9w1fWsa
         IP8Ik8LeqyfEKoU08bpvPPfw/CmoGB9yfo1ck//6p2R5WTpHyfX/i4YKtiUWLvPCfdH9
         bY72iFacAWC2XWP8SGouaRcA635yqcljhSUIeqGhfjGRb/Jm/jc3l066I1a05Bn0v6Ly
         SAHdAuDnOaQ0wi5bi+0bKNQ/DrWIHPiK5P5eWq+siSrx19YPb50D0AYTNndu2Ls/ceSt
         wGkXkLcUMMdL8K972+d740G62BVqLwkutB5qypnujz+TOZLxu6OIObPDmmU0+hI1FSDs
         1cjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=MYiXtYDqJwotW34VbL1gNPhcfMp5HVF3/UwPQRs2BZ8=;
        b=jfI5Y02t0Ztnuf67LCwhKHWAWQlXO6WKZa7/CIMXnn1pnu7VapwI4N6SBP+L6xOwTX
         ZthQ7a7WnIBY2jAokq0sxKkHZIixjXM9fvMZiGGUK2nREYrgSnGejmteZO0WbP93/BMX
         ghdI7t6YQwgUIl2TbKM8tJfqtbEb1uksKk4CU870Dfy93fFMGILK/rNV2ZZayZr5fzWU
         IckbIzLC1knmeZx/33G+CpbrnruXWxfxCMTDxgqt48It3ldDyE6CR1d4ZabnDGWrhivn
         sqz3N9ZA7xQ0prNgqk51rZkg83GWMtHoG17HV9nmAZqNyrBGlw0oCbIQWFRZ0flwnzjk
         hUsg==
X-Gm-Message-State: APjAAAVr0U+S1GpSwPQJoK2UcRVyXSQOLDrv/1EtBVgq3u84rCM2smZZ
        K56d3i0T07WlcJ1N2ZzgqRA6xF+BKCM=
X-Google-Smtp-Source: APXvYqwg5Pl4senspTBLLXh2DoiIY98sJyIj+ipD/rz0g87+UZib96GWjWiieV8LkxipSEZor5ZyVQ==
X-Received: by 2002:a6b:f906:: with SMTP id j6mr17177807iog.26.1565297512230;
        Thu, 08 Aug 2019 13:51:52 -0700 (PDT)
Received: from localhost (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id h18sm73602337iob.80.2019.08.08.13.51.51
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 08 Aug 2019 13:51:51 -0700 (PDT)
Date:   Thu, 8 Aug 2019 13:51:50 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Bjorn Helgaas <helgaas@kernel.org>
cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Wesley Terpstra <wesley@sifive.com>
Subject: Re: [PATCH v2] pci: Kconfig: select PCI_MSI_IRQ_DOMAIN by default
 on RISC-V
In-Reply-To: <20190808195546.GA7302@google.com>
Message-ID: <alpine.DEB.2.21.9999.1908081349210.6414@viisi.sifive.com>
References: <alpine.DEB.2.21.9999.1907251426450.32766@viisi.sifive.com> <20190808195546.GA7302@google.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On Thu, 8 Aug 2019, Bjorn Helgaas wrote:

> On Thu, Jul 25, 2019 at 02:28:07PM -0700, Paul Walmsley wrote:
> > From: Wesley Terpstra <wesley@sifive.com>
> > 
> > This is part of adding support for RISC-V systems with PCIe host 
> > controllers that support message-signaled interrupts.
> > 
> > Signed-off-by: Wesley Terpstra <wesley@sifive.com>
> > [paul.walmsley@sifive.com: wrote patch description; split this
> >  patch from the arch/riscv patch]
> > Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
> > ---
> >  drivers/pci/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> > index 2ab92409210a..beb3408a0272 100644
> > --- a/drivers/pci/Kconfig
> > +++ b/drivers/pci/Kconfig
> > @@ -52,7 +52,7 @@ config PCI_MSI
> >  	   If you don't know what to do here, say Y.
> >  
> >  config PCI_MSI_IRQ_DOMAIN
> > -	def_bool ARC || ARM || ARM64 || X86
> > +	def_bool ARC || ARM || ARM64 || X86 || RISCV
> 
> The other arches listed here either supply their own include/asm/msi.h
> or generate it:
> 
>   $ ls arch/*/include/asm/msi.h
>   arch/x86/include/asm/msi.h
> 
>   $ grep msi.h arch/*/include/asm/Kbuild
>   arch/arc/include/asm/Kbuild:generic-y += msi.h
>   arch/arm64/include/asm/Kbuild:generic-y += msi.h
>   arch/arm/include/asm/Kbuild:generic-y += msi.h
>   arch/mips/include/asm/Kbuild:generic-y += msi.h
>   arch/powerpc/include/asm/Kbuild:generic-y += msi.h
>   arch/sparc/include/asm/Kbuild:generic-y += msi.h
> 
> For example, see
> 
>   f8430eae9f1b ("PCI/MSI: Enable PCI_MSI_IRQ_DOMAIN support for ARC")
>   be091d468a0a ("arm64: PCI/MSI: Use asm-generic/msi.h")
>   0ab089c2548c ("ARM: Add msi.h to Kbuild")
> 
> I didn't look into the details of msi.h generation, but I assume
> RISC-V needs to do something similar?  If so, I think that should be
> part of this patch to avoid issues.
> 
> If CONFIG_GENERIC_MSI_IRQ_DOMAIN is defined, include/linux/msi.h
> #includes <asm/msi.h> and I don't see where that would come from.

Commit 251a44888183 ("riscv: include generic support for MSI irqdomains") 
has been merged upstream for this purpose:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=251a44888183003b0380df184835a2c00bfa39d7

The original patch was split into a RISC-V component and a generic PCI 
component to reduce the risk of merge conflicts.

Does that work for you?


- Paul
