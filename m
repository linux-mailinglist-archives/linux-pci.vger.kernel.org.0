Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E89986AF3
	for <lists+linux-pci@lfdr.de>; Thu,  8 Aug 2019 21:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390202AbfHHTzt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Aug 2019 15:55:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:59186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403831AbfHHTzs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 8 Aug 2019 15:55:48 -0400
Received: from localhost (unknown [150.199.191.185])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BFF27214C6;
        Thu,  8 Aug 2019 19:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565294148;
        bh=SOl9abd2o/Qj2dBjH8ebZDl44aPBVBw4i1AVCjPY/nM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bcSQCIe8/dBRIW/bkZwTbBcOfWJ4jURkIhZlfAMVQPFrM5ExqBnMoMiU+OZP22HmH
         qtNCe2+K6MFBvvpcNJEji2ZB4Sedflcze8rLCZwt8trL2tmqUQ7s/NOAENdW8FKmls
         tkkXDZVEmglLE30DV31AOWoNN5GLRLau9OtaXi+g=
Date:   Thu, 8 Aug 2019 14:55:46 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Wesley Terpstra <wesley@sifive.com>
Subject: Re: [PATCH v2] pci: Kconfig: select PCI_MSI_IRQ_DOMAIN by default on
 RISC-V
Message-ID: <20190808195546.GA7302@google.com>
References: <alpine.DEB.2.21.9999.1907251426450.32766@viisi.sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.9999.1907251426450.32766@viisi.sifive.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Paul, Wesley,

On Thu, Jul 25, 2019 at 02:28:07PM -0700, Paul Walmsley wrote:
> From: Wesley Terpstra <wesley@sifive.com>
> 
> This is part of adding support for RISC-V systems with PCIe host 
> controllers that support message-signaled interrupts.
> 
> Signed-off-by: Wesley Terpstra <wesley@sifive.com>
> [paul.walmsley@sifive.com: wrote patch description; split this
>  patch from the arch/riscv patch]
> Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
> ---
>  drivers/pci/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index 2ab92409210a..beb3408a0272 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -52,7 +52,7 @@ config PCI_MSI
>  	   If you don't know what to do here, say Y.
>  
>  config PCI_MSI_IRQ_DOMAIN
> -	def_bool ARC || ARM || ARM64 || X86
> +	def_bool ARC || ARM || ARM64 || X86 || RISCV

The other arches listed here either supply their own include/asm/msi.h
or generate it:

  $ ls arch/*/include/asm/msi.h
  arch/x86/include/asm/msi.h

  $ grep msi.h arch/*/include/asm/Kbuild
  arch/arc/include/asm/Kbuild:generic-y += msi.h
  arch/arm64/include/asm/Kbuild:generic-y += msi.h
  arch/arm/include/asm/Kbuild:generic-y += msi.h
  arch/mips/include/asm/Kbuild:generic-y += msi.h
  arch/powerpc/include/asm/Kbuild:generic-y += msi.h
  arch/sparc/include/asm/Kbuild:generic-y += msi.h

For example, see

  f8430eae9f1b ("PCI/MSI: Enable PCI_MSI_IRQ_DOMAIN support for ARC")
  be091d468a0a ("arm64: PCI/MSI: Use asm-generic/msi.h")
  0ab089c2548c ("ARM: Add msi.h to Kbuild")

I didn't look into the details of msi.h generation, but I assume
RISC-V needs to do something similar?  If so, I think that should be
part of this patch to avoid issues.

If CONFIG_GENERIC_MSI_IRQ_DOMAIN is defined, include/linux/msi.h
#includes <asm/msi.h> and I don't see where that would come from.

>  	depends on PCI_MSI
>  	select GENERIC_MSI_IRQ_DOMAIN

Bjorn
