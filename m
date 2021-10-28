Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D09543E006
	for <lists+linux-pci@lfdr.de>; Thu, 28 Oct 2021 13:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbhJ1LdD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Oct 2021 07:33:03 -0400
Received: from foss.arm.com ([217.140.110.172]:53748 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229578AbhJ1LdD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 28 Oct 2021 07:33:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 69CF7106F;
        Thu, 28 Oct 2021 04:30:36 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B69573F5A1;
        Thu, 28 Oct 2021 04:30:35 -0700 (PDT)
Date:   Thu, 28 Oct 2021 12:30:30 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 10/14] PCI: aardvark: Enable MSI-X support
Message-ID: <20211028113030.GA2026@lpieralisi>
References: <20211012164145.14126-1-kabel@kernel.org>
 <20211012164145.14126-11-kabel@kernel.org>
 <20211027141246.GA27543@lpieralisi>
 <20211027142307.lrrix5yfvroxl747@pali>
 <20211028110835.GA1846@lpieralisi>
 <20211028111302.gfd73ifoyudttpee@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211028111302.gfd73ifoyudttpee@pali>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 28, 2021 at 01:13:02PM +0200, Pali Roh�r wrote:

[...]

> > > In commit message I originally tried to explain it that after applying
> > > all previous patches which are fixing MSI and Multi-MSI support (part of
> > > them is enforcement to use only MSI numbers 0..31), it makes driver
> > > compatible with also MSI-X interrupts.
> > > 
> > > If you want to rewrite commit message, let us know, there is no problem.
> > 
> > I think we should.
> > 
> > > > > Signed-off-by: Pali Roh�r <pali@kernel.org>
> > > > > Reviewed-by: Marek Beh�n <kabel@kernel.org>
> > 
> > By the way, this tag should be removed. Marek signed it off, that
> > applies to other patches in this series as well.
> 
> Ok! Is this the only issue with this patch series? Or something other
> needs to be fixed?

The series looks fine to me - only thing for patch[4-10] I'd like
to have evidence MarcZ is happy with the approach (you have an
ACK on patch 9, for other patches if they were discussed on
ML add a Link: tag to the relevant discussion please).

I am trying to keep the IRQ domain management in PCI controller
drivers in check, that's why I am asking.

I can definitely pull [1-3] and [11-14] since they look good to me.

Thanks,
Lorenzo

> 
> > Lorenzo
> > 
> > > > > Signed-off-by: Marek Beh�n <kabel@kernel.org>
> > > > > ---
> > > > >  drivers/pci/controller/pci-aardvark.c | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> > > > > index b703b271c6b1..337b61508799 100644
> > > > > --- a/drivers/pci/controller/pci-aardvark.c
> > > > > +++ b/drivers/pci/controller/pci-aardvark.c
> > > > > @@ -1274,7 +1274,7 @@ static int advk_pcie_init_msi_irq_domain(struct advk_pcie *pcie)
> > > > >  
> > > > >  	msi_di = &pcie->msi_domain_info;
> > > > >  	msi_di->flags = MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
> > > > > -		MSI_FLAG_MULTI_PCI_MSI;
> > > > > +			MSI_FLAG_MULTI_PCI_MSI | MSI_FLAG_PCI_MSIX;
> > > > >  	msi_di->chip = msi_ic;
> > > > >  
> > > > >  	pcie->msi_inner_domain =
> > > > > -- 
> > > > > 2.32.0
> > > > > 
