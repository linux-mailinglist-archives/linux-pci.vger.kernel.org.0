Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B75593B198F
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jun 2021 14:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbhFWMHB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Jun 2021 08:07:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:51436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230019AbhFWMHB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 23 Jun 2021 08:07:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A01CC6044F;
        Wed, 23 Jun 2021 12:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624449883;
        bh=EcGql4AOk/Bq2QCWSdhodlfFpHz5gEaNlvEX2r9KEoI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=a9W3UzIedVNFEAbepmm7nqKZEyYId9daA4wkLOhQMAbKqTDbuU53x6BvlJT0bKudz
         gfvPeXHxIdFMO8CdrBzp7luJrBPjIgh6qTjjoe8BFB8g5NTUHRfTGDJC8O3JTE/S5j
         F2x/QfGn87rZHRP85HUYW/tPCEOo5+X4WUf2Qbd14EjKYmhEgdubWegjX+zyLRsYnX
         ec1BBLgwv6/W35KhyB20I3YCkKx+etumjDdJYmRcAc+ucXysJOFGV3BGSsuHs94NQz
         cb99AH70uE6xr0OFR5A1+qYpzFpGU09slaz95xVI/IQAytD1vPzjub9KGWaSktNnAF
         vRQkPqJT4v4ZA==
Date:   Wed, 23 Jun 2021 07:04:41 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Jon Hunter <jonathanh@nvidia.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Vidya Sagar <vidyas@nvidia.com>, linux-pci@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH] PCI: tegra: Fix shiftTooManyBitsSigned warning for
 Tegra194
Message-ID: <20210623120441.GA3355109@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210623085206.GA10593@lpieralisi>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 23, 2021 at 09:52:14AM +0100, Lorenzo Pieralisi wrote:
> On Fri, Jun 18, 2021 at 06:04:28PM -0500, Bjorn Helgaas wrote:
> > On Fri, Jun 18, 2021 at 05:02:19PM +0100, Jon Hunter wrote:
> > > The cppcheck tool issues the following warning for the Tegra194 PCIe
> > > driver ...
> > > 
> > >  $ cppcheck --enable=all drivers/pci/controller/dwc/pcie-tegra194.c
> > >  Checking drivers/pci/controller/dwc/pcie-tegra194.c ...
> > > 
> > >  drivers/pci/controller/dwc/pcie-tegra194.c:1829:23: portability:
> > > 	Shifting signed 32-bit value by 31 bits is
> > > 	implementation-defined behaviour. See condition at line 1826.
> > > 	[shiftTooManyBitsSigned]
> > > 
> > >   appl_writel(pcie, (1 << irq), APPL_MSI_CTRL_1);
> > >                       ^
> > > The above warning occurs because the '1' is treated as a signed type
> > > and so fix this by using the 'BIT' macro to ensure that this is defined
> > > as a unsigned type.
> > 
> > The subject and commit log should describe the problem we're fixing.
> > The *warning* is not the problem; the problem is the undefined
> > behavior.
> > 
> > I'll fix this up, no need to repost for this.
> 
> Hi Bjorn,
> 
> I can fix it up myself, just wanted to ask if you merged it already, it
> does not look like but I thought I'd check.

Oops, sorry, I guess I dropped the ball on this one and didn't get it
merged.  When you do, can you update the subject as well, e.g.,

  s/PCI: tegra/PCI: tegra194/

to differentiate from the other "tegra" driver?

> > > Fixes: c57247f940e8 PCI: tegra: Add support for PCIe endpoint mode in Tegra194
> > > Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> > > ---
> > >  drivers/pci/controller/dwc/pcie-tegra194.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> > > index 8fc08336f76e..3c1feeab104f 100644
> > > --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> > > +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> > > @@ -1826,7 +1826,7 @@ static int tegra_pcie_ep_raise_msi_irq(struct tegra_pcie_dw *pcie, u16 irq)
> > >  	if (unlikely(irq > 31))
> > >  		return -EINVAL;
> > >  
> > > -	appl_writel(pcie, (1 << irq), APPL_MSI_CTRL_1);
> > > +	appl_writel(pcie, BIT(irq), APPL_MSI_CTRL_1);
> > >  
> > >  	return 0;
> > >  }
> > > -- 
> > > 2.25.1
> > > 
