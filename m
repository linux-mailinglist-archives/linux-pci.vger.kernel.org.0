Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCFC743E01A
	for <lists+linux-pci@lfdr.de>; Thu, 28 Oct 2021 13:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbhJ1Ljy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Oct 2021 07:39:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:37700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229578AbhJ1Ljx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 28 Oct 2021 07:39:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 880F9604AC;
        Thu, 28 Oct 2021 11:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635421046;
        bh=1UoWk8xcfH0zssVvHs6k5xelf5YnnOzV7ocEjek2IwE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HglhQPzIIS9hwwfCyyPI6+fRh1hmrL6QNvrM3l6BXSz+dnCGyF2Xvby/e/IYWxfMg
         3i3Joh0nG3IiinWAnYb4Ah4tNJF/MW14ZhyNIatgd4E6ngRm06ZOY3p+nfGYJB9bnG
         oMTVE/tSBoWnsDMhCJdCpvYYb5OrNkL54G9X88TWhPRgjYwU8gt+upe0hTpqDwPlhF
         7MWH/GKkpq3+/mp0Fb13IEHv90KZRqGqetN0QblUIsb3+qDp9RuDfyZvY6wtm509xr
         EZ1/EaBwz7fJUMes41Yt6AvtSy1G2y+FLKK3undPVkIWSDyY4JUM7giVxCOCjqQFli
         NDzWy80aMRSfQ==
Received: by pali.im (Postfix)
        id 661F0689; Thu, 28 Oct 2021 13:37:24 +0200 (CEST)
Date:   Thu, 28 Oct 2021 13:37:24 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 10/14] PCI: aardvark: Enable MSI-X support
Message-ID: <20211028113724.gm6zhqt7qcyxtgkq@pali>
References: <20211012164145.14126-1-kabel@kernel.org>
 <20211012164145.14126-11-kabel@kernel.org>
 <20211027141246.GA27543@lpieralisi>
 <20211027142307.lrrix5yfvroxl747@pali>
 <20211028110835.GA1846@lpieralisi>
 <20211028111302.gfd73ifoyudttpee@pali>
 <20211028113030.GA2026@lpieralisi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211028113030.GA2026@lpieralisi>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thursday 28 October 2021 12:30:30 Lorenzo Pieralisi wrote:
> On Thu, Oct 28, 2021 at 01:13:02PM +0200, Pali Rohár wrote:
> 
> [...]
> 
> > > > In commit message I originally tried to explain it that after applying
> > > > all previous patches which are fixing MSI and Multi-MSI support (part of
> > > > them is enforcement to use only MSI numbers 0..31), it makes driver
> > > > compatible with also MSI-X interrupts.
> > > > 
> > > > If you want to rewrite commit message, let us know, there is no problem.
> > > 
> > > I think we should.
> > > 
> > > > > > Signed-off-by: Pali Rohár <pali@kernel.org>
> > > > > > Reviewed-by: Marek Behún <kabel@kernel.org>
> > > 
> > > By the way, this tag should be removed. Marek signed it off, that
> > > applies to other patches in this series as well.
> > 
> > Ok! Is this the only issue with this patch series? Or something other
> > needs to be fixed?
> 
> The series looks fine to me - only thing for patch[4-10] I'd like
> to have evidence MarcZ is happy with the approach

Marc, could you look at patches 4-10 if you are happy with them? Link:
https://lore.kernel.org/linux-pci/20211012164145.14126-5-kabel@kernel.org/

> (you have an
> ACK on patch 9, for other patches if they were discussed on
> ML add a Link: tag to the relevant discussion please).

Only that one patch was acked in past:
https://lore.kernel.org/linux-pci/87a6p6q1r9.wl-maz@kernel.org/

> I am trying to keep the IRQ domain management in PCI controller
> drivers in check, that's why I am asking.
> 
> I can definitely pull [1-3] and [11-14] since they look good to me.

Ok!

> Thanks,
> Lorenzo
> 
> > 
> > > Lorenzo
> > > 
> > > > > > Signed-off-by: Marek Behún <kabel@kernel.org>
> > > > > > ---
> > > > > >  drivers/pci/controller/pci-aardvark.c | 2 +-
> > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > > 
> > > > > > diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> > > > > > index b703b271c6b1..337b61508799 100644
> > > > > > --- a/drivers/pci/controller/pci-aardvark.c
> > > > > > +++ b/drivers/pci/controller/pci-aardvark.c
> > > > > > @@ -1274,7 +1274,7 @@ static int advk_pcie_init_msi_irq_domain(struct advk_pcie *pcie)
> > > > > >  
> > > > > >  	msi_di = &pcie->msi_domain_info;
> > > > > >  	msi_di->flags = MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
> > > > > > -		MSI_FLAG_MULTI_PCI_MSI;
> > > > > > +			MSI_FLAG_MULTI_PCI_MSI | MSI_FLAG_PCI_MSIX;
> > > > > >  	msi_di->chip = msi_ic;
> > > > > >  
> > > > > >  	pcie->msi_inner_domain =
> > > > > > -- 
> > > > > > 2.32.0
> > > > > > 
