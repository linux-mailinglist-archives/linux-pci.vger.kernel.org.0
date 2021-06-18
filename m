Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7AC3ACF4D
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jun 2021 17:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231570AbhFRPkX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Jun 2021 11:40:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:60998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230334AbhFRPkX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 18 Jun 2021 11:40:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 659906120A;
        Fri, 18 Jun 2021 15:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624030693;
        bh=NBYVUudg2TC6uEDxyQraTGf1mIgODtniMozlgM4CEeM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=jvHfrl+VGRvhFfNBeETCkVwSoPDtZQQP6H+c7rz810/X41Bm2/oNzaymYBFPn8VUA
         jYMGecI93nXlgbkVxYMYVnVzKbZlUHa0rrq9h7r3ey9Siqzk26hMODPtsQ9Geh9vnj
         w6Rm9MjpNGFfTWx+F2JmqsL0OVub+eCUJKPjeyA/sz/PgJhLayrIf4MrOD7rnLqGn/
         FGLGBc/GZKuUeS8TFMil+omYY6AZJrRZOkyS1U2BcVWLEVNLqB7lZK3w1bGEvahEqU
         yABsWgFp8nNZ831tOsuP+IIQ2ManH8SGbMzw/55gf1pMTfHwTXwOrl+gfG/L1UP1Xk
         BjEe55leUExnQ==
Date:   Fri, 18 Jun 2021 10:38:12 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Thierry Reding <treding@nvidia.com>,
        kernel test robot <lkp@intel.com>,
        Vidya Sagar <vidyas@nvidia.com>, linux-pci@vger.kernel.org
Subject: Re: [pci:for-linus] BUILD SUCCESS WITH WARNING
 15ac366c3d20ce1e08173f1de393a8ce95a1facf
Message-ID: <20210618153812.GA3192337@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8a022e4-15b3-1339-7128-fdcc5ba1f7e8@nvidia.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 18, 2021 at 03:49:39PM +0100, Jon Hunter wrote:
> 
> On 18/06/2021 15:48, Thierry Reding wrote:
> > On Fri, Jun 18, 2021 at 03:03:24PM +0100, Jon Hunter wrote:
> >> Hi Bjorn,
> >>
> >> On 18/06/2021 14:13, Bjorn Helgaas wrote:
> >>> [+to Jon, +cc Thierry]
> >>>
> >>> On Fri, Jun 18, 2021 at 06:34:20PM +0800, kernel test robot wrote:
> >>>> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git for-linus
> >>>> branch HEAD: 15ac366c3d20ce1e08173f1de393a8ce95a1facf  PCI: aardvark: Fix kernel panic during PIO transfer
> >>>>
> >>>> possible Warning in current branch:
> >>>>
> >>>> drivers/pci/controller/dwc/pcie-tegra194.c:1829:23: warning: Shifting signed 32-bit value by 31 bits is undefined behaviour. See condition at line 1826. [shiftTooManyBitsSigned]
> >>>
> >>> This looks like a legit warning, but I think the only commit that
> >>> could be related is this one:
> >>>
> >>>   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/?h=for-linus&id=99ab5996278379a02d5a84c4a7ac33a2ebfdb29e
> >>>
> >>> which doesn't touch that code.
> >>>
> >>> It does *move* some code, so maybe this was an existing warning that
> >>> moved enough that the robot thought it was new?
> >>
> >>
> >> I guessing that this is now happening because we are now compiling the
> >> bulk of the code in the driver. However, yes looks like it has been
> >> there for a while. 
> >>
> >> I wonder if the '(1 << irq)' is being treated as a signed type.
> >>
> >>> How can we reproduce this to make sure we fix it?
> >>
> >> I was able to reproduce it by ...
> >>
> >> $ cppcheck --force --enable=all drivers/pci/controller/dwc/pcie-tegra194.c 
> >> Checking drivers/pci/controller/dwc/pcie-tegra194.c ...
> >>
> >> drivers/pci/controller/dwc/pcie-tegra194.c:1829:23: portability: Shifting signed 32-bit value by 31 bits is implementation-defined behaviour. See condition at line 1826. [shiftTooManyBitsSigned]
> >>  appl_writel(pcie, (1 << irq), APPL_MSI_CTRL_1);
> >>                       ^
> >> drivers/pci/controller/dwc/pcie-tegra194.c:1826:19: note: Assuming that condition 'irq>31' is not redundant
> >>  if (unlikely(irq > 31))
> >>                   ^
> >> drivers/pci/controller/dwc/pcie-tegra194.c:1829:23: note: Shift
> >>  appl_writel(pcie, (1 << irq), APPL_MSI_CTRL_1);
> >>
> >>
> >> I was able to fix this by ...
> >>
> >> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> >> index 8fc08336f76e..05d6a8da190b 100644
> >> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> >> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> >> @@ -1826,7 +1826,7 @@ static int tegra_pcie_ep_raise_msi_irq(struct tegra_pcie_dw *pcie, u16 irq)
> >>         if (unlikely(irq > 31))
> >>                 return -EINVAL;
> >>  
> >> -       appl_writel(pcie, (1 << irq), APPL_MSI_CTRL_1);
> >> +       appl_writel(pcie, (BIT(1) << irq), APPL_MSI_CTRL_1);
> >>  
> >>         return 0;
> >>  }
> >>
> >> I can send this as a patch.
> > 
> > I think that's not the same anymore. The equivalent would rather be:
> > 
> > 	appl_writel(pcie, (BIT(0) << irq), APPL_MSI_CTRL_1);
> 
> Yes indeed!
> 
> > But I think this can be achieved more easily by doing this:
> > 
> > 	appl_writel(pcie, 1UL << irq, APPL_MSI_CTRL_1);
> > 
> > Which is what BIT(0) would effectively end up doing. Actually, this
> > sounds like it should really have been this all along:
> > 
> > 	appl_writel(pcie, BIT(irq), APPL_MSI_CTRL_1);
> > 
> > Which should also get rid of that warning.
> 
> Yes it does. I will send a patch with the above.

Please also let me know what changed that made this show up now.

We need to figure out whether this fix should be squashed into
"PCI: tegra194: Fix MCFG quirk build regressions", applied before it
on for-linus for v5.13, or applied for v5.14.

Bjorn
