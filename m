Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF49343CC09
	for <lists+linux-pci@lfdr.de>; Wed, 27 Oct 2021 16:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242486AbhJ0OZm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Oct 2021 10:25:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:45092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242484AbhJ0OZf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 27 Oct 2021 10:25:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 927D860EFE;
        Wed, 27 Oct 2021 14:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635344589;
        bh=CPzZAjlgZfcODsydTy+plOqG/CAD03Tq6Btl3MWyUX4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GcB6Bt1qfvEnZYAKLS6mzc7XPrkOOUx0xNx/AoadXsUwEFM9pamuthw/FG1sX0Nro
         fpIafsgmu8gSpgyumUmoAU2+aGWp4ApeEryIGicEzIoE07O3qr5300K8v3VIzbJDgF
         lm2zh2UpkvlmlQYrXx4uRVVlZ43/jpk8HKrnTqmW7xsMPCkHQ/N3OcV9GuIErspuG1
         g+evBxC9PgGtCrqmg2yt2x1dcTX1hhu9OUC44cx+wGSukbt9WjDOHt3P/nB3MfMF/d
         neKL4jpSGWE6d9GMe00+ZbLokKpMp7tBomta2bkW8FcFZ3sGRig/jyC3pxDiEs4odL
         6SoMMu890hn7A==
Received: by pali.im (Postfix)
        id 6082B894; Wed, 27 Oct 2021 16:23:07 +0200 (CEST)
Date:   Wed, 27 Oct 2021 16:23:07 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 10/14] PCI: aardvark: Enable MSI-X support
Message-ID: <20211027142307.lrrix5yfvroxl747@pali>
References: <20211012164145.14126-1-kabel@kernel.org>
 <20211012164145.14126-11-kabel@kernel.org>
 <20211027141246.GA27543@lpieralisi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211027141246.GA27543@lpieralisi>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wednesday 27 October 2021 15:12:46 Lorenzo Pieralisi wrote:
> On Tue, Oct 12, 2021 at 06:41:41PM +0200, Marek Behún wrote:
> > From: Pali Rohár <pali@kernel.org>
> > 
> > According to PCI 3.0 specification, sending both MSI and MSI-X interrupts
> > is done by DWORD memory write operation to doorbell message address. The
> > write operation for MSI has zero upper 16 bits and the MSI interrupt number
> > in the lower 16 bits, while the write operation for MSI-X contains a 32-bit
> > value from MSI-X table.
> > 
> > Since the driver only uses interrupt numbers from range 0..31, the upper
> > 16 bits of the DWORD memory write operation to doorbell message address
> > are zero even for MSI-X interrupts. Thus we can enable MSI-X interrupts.
> 
> It is the controller driver that defines the MSI-X data field yes, what
> I don't get is why we have to add this comment in the commit log.
> 
> Basically Aardvark can support MSI-X up to 32 MSI-X vectors and you
> are enabling them with this patch.
> 
> Is there anything *else* I am missing wrt 16-bit/32-bit data fields
> that we need to know ?
> 
> > Testing proves that kernel can correctly receive MSI-X interrupts from
> > PCIe cards which supports both MSI and MSI-X interrupts.
> 
> I don't understand what you want to convey with this commit log.
> 
> To me, the whole comment does not add anything (if I understood it),
> please let me know what you want to express with it.
> 
> To me this patch enables MSI-X support because the HW can support them,
> that's it.

My understanding is that MSI-X by definition uses 32-bit write
operations to doorbell address and so, HW needs to support catching of
32-bit write operations.

Aardvark hw seems to support only 16-bit write operation to doorbell
address. But our testing proved that hw can catch also lower 16-bits of
32-bit write operation to doorbell address.

So if driver enforces that every 32-bit write operation to doorbell
address would have upper 16-bit zeroed then MSI-X should work.

In commit message I originally tried to explain it that after applying
all previous patches which are fixing MSI and Multi-MSI support (part of
them is enforcement to use only MSI numbers 0..31), it makes driver
compatible with also MSI-X interrupts.

If you want to rewrite commit message, let us know, there is no problem.

> Lorenzo
> 
> > Signed-off-by: Pali Rohár <pali@kernel.org>
> > Reviewed-by: Marek Behún <kabel@kernel.org>
> > Signed-off-by: Marek Behún <kabel@kernel.org>
> > ---
> >  drivers/pci/controller/pci-aardvark.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> > index b703b271c6b1..337b61508799 100644
> > --- a/drivers/pci/controller/pci-aardvark.c
> > +++ b/drivers/pci/controller/pci-aardvark.c
> > @@ -1274,7 +1274,7 @@ static int advk_pcie_init_msi_irq_domain(struct advk_pcie *pcie)
> >  
> >  	msi_di = &pcie->msi_domain_info;
> >  	msi_di->flags = MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
> > -		MSI_FLAG_MULTI_PCI_MSI;
> > +			MSI_FLAG_MULTI_PCI_MSI | MSI_FLAG_PCI_MSIX;
> >  	msi_di->chip = msi_ic;
> >  
> >  	pcie->msi_inner_domain =
> > -- 
> > 2.32.0
> > 
