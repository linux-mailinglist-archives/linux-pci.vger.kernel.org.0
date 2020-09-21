Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF1E27302E
	for <lists+linux-pci@lfdr.de>; Mon, 21 Sep 2020 19:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728980AbgIUQg2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Sep 2020 12:36:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:36238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728977AbgIUQg1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 21 Sep 2020 12:36:27 -0400
Received: from localhost (52.sub-72-107-123.myvzw.com [72.107.123.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07819238EE;
        Mon, 21 Sep 2020 16:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600706186;
        bh=6dRQRkN/L3mXtliQlUgl3Vb+aLvafqsq0JF9XgTWhZ0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=GbUu5wR2bbF3NanHI4aZVK0X6SM98qKGFHLIU4Id2ugr/rzLmPqCoDmmLn8UPYBfk
         MLA2vF9JvfrkNJNTOgT5nIOGzIBAVfWjJAlJx66syHA9QDXGCmkCAItFj4qWWOcXPl
         0j+1IRLbuBsFtfFfVVKwJPRPXK0kLP52s6TFC5h0=
Date:   Mon, 21 Sep 2020 11:36:24 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>
Subject: Re: [PATCH] [-next] PCI: DWC: Fix cast truncates bits from constant
 value
Message-ID: <20200921163624.GA2117267@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM5PR12MB1276E15164E0793E623BACEBDA3A0@DM5PR12MB1276.namprd12.prod.outlook.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 21, 2020 at 11:30:48AM +0000, Gustavo Pimentel wrote:
> On Fri, Sep 18, 2020 at 8:15:48, Gustavo Pimentel <gustavo@synopsys.com> 
> wrote:
> 
> > On Thu, Sep 17, 2020 at 22:47:59, Bjorn Helgaas <helgaas@kernel.org> 
> > wrote:
> > 
> > > On Thu, Sep 17, 2020 at 11:28:03PM +0200, Gustavo Pimentel wrote:
> > > > Fixes warning given by executing "make C=2 drivers/pci/"
> > > > 
> > > > Sparse output:
> > > > CHECK drivers/pci/controller/dwc/pcie-designware.c
> > > >  drivers/pci/controller/dwc/pcie-designware.c:432:52: warning:
> > > >  cast truncates bits from constant value (ffffffff7fffffff becomes
> > > >  7fffffff)
> > > > 
> > > > Reported-by: Bjorn Helgaas <bhelgaas@google.com>
> > > > Cc: Joao Pinto <jpinto@synopsys.com>
> > > > Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> > > > ---
> > > >  drivers/pci/controller/dwc/pcie-designware.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> > > > index 3c3a4d1..dcb7108 100644
> > > > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > > > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > > > @@ -429,7 +429,7 @@ void dw_pcie_disable_atu(struct dw_pcie *pci, int index,
> > > >  	}
> > > >  
> > > >  	dw_pcie_writel_dbi(pci, PCIE_ATU_VIEWPORT, region | index);
> > > > -	dw_pcie_writel_dbi(pci, PCIE_ATU_CR2, (u32)~PCIE_ATU_ENABLE);
> > > > +	dw_pcie_writel_dbi(pci, PCIE_ATU_CR2, (u32)~0 & ~PCIE_ATU_ENABLE);
> > > 
> > > But this cure is worse than the disease.  If this is the only way to
> > > fix the warning, I think I'd rather see the warning ;)  I'm hopeful
> > > there's a nicer way, but I'm not a language lawyer.
> > 
> > I don't like it either, I tried to see if were another way a clean way 
> > that didn't imply creating a temporary variable, but I didn't found.
> > The issue here is that PCIE_ATU_ENABLE is defined as BIT(31) on 
> > pcie-designware.h. The macro BIT changes its size from u32 to u64 
> > according to the architecture and by inverting the value on the 64 bits 
> > architecture causes the value to be transformed into 0xffffffff7fffffff.
> > 
> > The other possibility implies the creation of a temporary u32 variable to 
> > overcome this issue. It's a little bit overkill, but please share your 
> > thoughts about it.
> > 
> > void dw_pcie_disable_atu(struct dw_pcie *pci, int index,
> >                          enum dw_pcie_region_type type)
> >  {
> > -       int region;
> > +       u32 atu = PCIE_ATU_ENABLE;
> > +       u32 region;
> > 
> >         switch (type) {
> >         case DW_PCIE_REGION_INBOUND:
> > @@ -429,7 +430,7 @@ void dw_pcie_disable_atu(struct dw_pcie *pci, int 
> > index,
> >         }
> > 
> >         dw_pcie_writel_dbi(pci, PCIE_ATU_VIEWPORT, region | index);
> > -       dw_pcie_writel_dbi(pci, PCIE_ATU_CR2, (u32)~PCIE_ATU_ENABLE);
> > +       dw_pcie_writel_dbi(pci, PCIE_ATU_CR2, ~atu);
> >  }
> 
> Hi Bjorn,
> 
> What is your verdict on this?
> If you prefer this approach I can send the corresponding patch.

Having a u32 temporary with no obvious reason for existence is kind of
unpleasant, too.  Surely this is a common situation?  Maybe other
instances just live with the warning, too?

I'd say leave this alone for now.

Bjorn
