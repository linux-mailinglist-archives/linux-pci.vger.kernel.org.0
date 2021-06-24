Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB4AB3B399D
	for <lists+linux-pci@lfdr.de>; Fri, 25 Jun 2021 01:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232300AbhFXXEL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Jun 2021 19:04:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:36116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229971AbhFXXEL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 Jun 2021 19:04:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5D43E6135C;
        Thu, 24 Jun 2021 23:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624575711;
        bh=DT72+9YpesSZCjP2Od+U7q5g0nuLrSl3UPjJ4Q0biZU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=iWWrtR02UDxpextmKJ4dLZ3B+csC6xtQv5Pjb2kxihK9fnWSsW4viIfbZ98cVjhGR
         OD8VcO63DNWcNqV4NtDycqysBuTMWfwhpNUNpANAvcs6sBxJkGDYcVB5/OziMbqtlO
         lRgDvX1KEzKFsidwPuwo9MuMkr4EAJaLdKC0z//MwIWCMVcFYDkZeyl/nDvMlrCxGI
         ShrNpjZmb5qM29o2PAD1HOyqG6cudzFn1is7wPze3Yj5f+46tNTmUzNRwV1TgfYK4w
         H5nBhv5ckariVtqO1cC31px7Kp14aoGTs/QNdfDPIqICoAY1WThQicHeWjZ9WrrzJe
         8U/EUZjQ6ns2Q==
Date:   Thu, 24 Jun 2021 18:01:50 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Vidya Sagar <vidyas@nvidia.com>, linux-pci@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH] PCI: tegra: Fix shiftTooManyBitsSigned warning for
 Tegra194
Message-ID: <20210624230150.GA3574555@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210618230428.GA3231877@bjorn-Precision-5520>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 18, 2021 at 06:04:28PM -0500, Bjorn Helgaas wrote:
> On Fri, Jun 18, 2021 at 05:02:19PM +0100, Jon Hunter wrote:
> > The cppcheck tool issues the following warning for the Tegra194 PCIe
> > driver ...
> > 
> >  $ cppcheck --enable=all drivers/pci/controller/dwc/pcie-tegra194.c
> >  Checking drivers/pci/controller/dwc/pcie-tegra194.c ...
> > 
> >  drivers/pci/controller/dwc/pcie-tegra194.c:1829:23: portability:
> > 	Shifting signed 32-bit value by 31 bits is
> > 	implementation-defined behaviour. See condition at line 1826.
> > 	[shiftTooManyBitsSigned]
> > 
> >   appl_writel(pcie, (1 << irq), APPL_MSI_CTRL_1);
> >                       ^
> > The above warning occurs because the '1' is treated as a signed type
> > and so fix this by using the 'BIT' macro to ensure that this is defined
> > as a unsigned type.
> 
> The subject and commit log should describe the problem we're fixing.
> The *warning* is not the problem; the problem is the undefined
> behavior.
> 
> I'll fix this up, no need to repost for this.

I merged this from Lorenzo's branch, but I updated the commit log like
this because the undefined behavior is the real problem:

    PCI: tegra194: Fix tegra_pcie_ep_raise_msi_irq() ill-defined shift

    tegra_pcie_ep_raise_msi_irq() shifted a signed 32-bit value left by 31
    bits.  The behavior of this is implementation-defined.

    Replace the shift by BIT(), which is well-defined.

    Found by cppcheck:

      $ cppcheck --enable=all drivers/pci/controller/dwc/pcie-tegra194.c
      Checking drivers/pci/controller/dwc/pcie-tegra194.c ...

      drivers/pci/controller/dwc/pcie-tegra194.c:1829:23: portability: Shifting signed 32-bit value by 31 bits is implementation-defined behaviour. See condition at line 1826.  [shiftTooManyBitsSigned]

      appl_writel(pcie, (1 << irq), APPL_MSI_CTRL_1);
                         ^

    [bhelgaas: commit log]
    Link: https://lore.kernel.org/r/20210618160219.303092-1-jonathanh@nvidia.com
    Fixes: c57247f940e8 ("PCI: tegra: Add support for PCIe endpoint mode in Tegra194")
    Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
    Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

> > Fixes: c57247f940e8 PCI: tegra: Add support for PCIe endpoint mode in Tegra194
> > Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> > ---
> >  drivers/pci/controller/dwc/pcie-tegra194.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> > index 8fc08336f76e..3c1feeab104f 100644
> > --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> > +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> > @@ -1826,7 +1826,7 @@ static int tegra_pcie_ep_raise_msi_irq(struct tegra_pcie_dw *pcie, u16 irq)
> >  	if (unlikely(irq > 31))
> >  		return -EINVAL;
> >  
> > -	appl_writel(pcie, (1 << irq), APPL_MSI_CTRL_1);
> > +	appl_writel(pcie, BIT(irq), APPL_MSI_CTRL_1);
> >  
> >  	return 0;
> >  }
> > -- 
> > 2.25.1
> > 
