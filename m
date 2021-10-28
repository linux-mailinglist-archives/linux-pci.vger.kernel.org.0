Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 261BF43DFCB
	for <lists+linux-pci@lfdr.de>; Thu, 28 Oct 2021 13:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbhJ1LPc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Oct 2021 07:15:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:55456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229578AbhJ1LPc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 28 Oct 2021 07:15:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 45152610FC;
        Thu, 28 Oct 2021 11:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635419585;
        bh=b9+YpOR1GPANMElOxHPcrc3FTCU/7xAxacwsuIWJSxU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m9hbf1f80M3FB2xvQV5FxLfX9X/L3KsfJzCbkrUEX84AR1gCM2LtOLtcIjJXP19Eb
         gUowFHmODrMag99R+oU4OD3+pNcI54qHARqqzbD83WXepxMgAeU8Z8MO8TCUlQk1RD
         4Pd+EvGz1uewj4p8SMNIyBT8lc6Zx/RkoJyHfy88V74lqpuT+v9cjLt1+uI8+eAg9E
         ROXWK1Q7W0g9K6+SQv65+tT0oyj4y+To6gKueUm4FSPxfFdPy96vER/1CJtSjmpU0X
         FIGH6yPrqKrgzgsk93G7ekBAyBeEj4JomWoUrclq1yA3T+rlcxVOjp8BP2INwiZ0WF
         aGJgBVyydS7wQ==
Received: by pali.im (Postfix)
        id E001D689; Thu, 28 Oct 2021 13:13:02 +0200 (CEST)
Date:   Thu, 28 Oct 2021 13:13:02 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 10/14] PCI: aardvark: Enable MSI-X support
Message-ID: <20211028111302.gfd73ifoyudttpee@pali>
References: <20211012164145.14126-1-kabel@kernel.org>
 <20211012164145.14126-11-kabel@kernel.org>
 <20211027141246.GA27543@lpieralisi>
 <20211027142307.lrrix5yfvroxl747@pali>
 <20211028110835.GA1846@lpieralisi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211028110835.GA1846@lpieralisi>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thursday 28 October 2021 12:08:35 Lorenzo Pieralisi wrote:
> On Wed, Oct 27, 2021 at 04:23:07PM +0200, Pali Rohár wrote:
> > On Wednesday 27 October 2021 15:12:46 Lorenzo Pieralisi wrote:
> > > On Tue, Oct 12, 2021 at 06:41:41PM +0200, Marek Behún wrote:
> > > > From: Pali Rohár <pali@kernel.org>
> > > > 
> > > > According to PCI 3.0 specification, sending both MSI and MSI-X interrupts
> > > > is done by DWORD memory write operation to doorbell message address. The
> > > > write operation for MSI has zero upper 16 bits and the MSI interrupt number
> > > > in the lower 16 bits, while the write operation for MSI-X contains a 32-bit
> > > > value from MSI-X table.
> > > > 
> > > > Since the driver only uses interrupt numbers from range 0..31, the upper
> > > > 16 bits of the DWORD memory write operation to doorbell message address
> > > > are zero even for MSI-X interrupts. Thus we can enable MSI-X interrupts.
> > > 
> > > It is the controller driver that defines the MSI-X data field yes, what
> > > I don't get is why we have to add this comment in the commit log.
> > > 
> > > Basically Aardvark can support MSI-X up to 32 MSI-X vectors and you
> > > are enabling them with this patch.
> > > 
> > > Is there anything *else* I am missing wrt 16-bit/32-bit data fields
> > > that we need to know ?
> > > 
> > > > Testing proves that kernel can correctly receive MSI-X interrupts from
> > > > PCIe cards which supports both MSI and MSI-X interrupts.
> > > 
> > > I don't understand what you want to convey with this commit log.
> > > 
> > > To me, the whole comment does not add anything (if I understood it),
> > > please let me know what you want to express with it.
> > > 
> > > To me this patch enables MSI-X support because the HW can support them,
> > > that's it.
> > 
> > My understanding is that MSI-X by definition uses 32-bit write
> > operations to doorbell address and so, HW needs to support catching of
> > 32-bit write operations.
> > 
> > Aardvark hw seems to support only 16-bit write operation to doorbell
> > address. But our testing proved that hw can catch also lower 16-bits of
> > 32-bit write operation to doorbell address.
> > 
> > So if driver enforces that every 32-bit write operation to doorbell
> > address would have upper 16-bit zeroed then MSI-X should work.
> 
> That's clearer than the current commit log.
> 
> > In commit message I originally tried to explain it that after applying
> > all previous patches which are fixing MSI and Multi-MSI support (part of
> > them is enforcement to use only MSI numbers 0..31), it makes driver
> > compatible with also MSI-X interrupts.
> > 
> > If you want to rewrite commit message, let us know, there is no problem.
> 
> I think we should.
> 
> > > > Signed-off-by: Pali Rohár <pali@kernel.org>
> > > > Reviewed-by: Marek Behún <kabel@kernel.org>
> 
> By the way, this tag should be removed. Marek signed it off, that
> applies to other patches in this series as well.

Ok! Is this the only issue with this patch series? Or something other
needs to be fixed?

> Lorenzo
> 
> > > > Signed-off-by: Marek Behún <kabel@kernel.org>
> > > > ---
> > > >  drivers/pci/controller/pci-aardvark.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> > > > index b703b271c6b1..337b61508799 100644
> > > > --- a/drivers/pci/controller/pci-aardvark.c
> > > > +++ b/drivers/pci/controller/pci-aardvark.c
> > > > @@ -1274,7 +1274,7 @@ static int advk_pcie_init_msi_irq_domain(struct advk_pcie *pcie)
> > > >  
> > > >  	msi_di = &pcie->msi_domain_info;
> > > >  	msi_di->flags = MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
> > > > -		MSI_FLAG_MULTI_PCI_MSI;
> > > > +			MSI_FLAG_MULTI_PCI_MSI | MSI_FLAG_PCI_MSIX;
> > > >  	msi_di->chip = msi_ic;
> > > >  
> > > >  	pcie->msi_inner_domain =
> > > > -- 
> > > > 2.32.0
> > > > 
