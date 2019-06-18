Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7AE4A3E7
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jun 2019 16:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbfFRO20 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Jun 2019 10:28:26 -0400
Received: from foss.arm.com ([217.140.110.172]:43888 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725919AbfFRO2Z (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 18 Jun 2019 10:28:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5A2EB2B;
        Tue, 18 Jun 2019 07:28:25 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C29C43F718;
        Tue, 18 Jun 2019 07:28:23 -0700 (PDT)
Date:   Tue, 18 Jun 2019 15:28:21 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        bhelgaas@google.com, Jisheng.Zhang@synaptics.com,
        thierry.reding@gmail.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com, kishon@ti.com
Subject: Re: [PATCH V4 1/2] PCI: dwc: Add API support to de-initialize host
Message-ID: <20190618142821.GC9002@e121166-lin.cambridge.arm.com>
References: <20190502170426.28688-1-vidyas@nvidia.com>
 <20190503112338.GA25649@e121166-lin.cambridge.arm.com>
 <dec5ecb2-863e-a1db-10c9-2d91f860a2c6@nvidia.com>
 <37697830-5a94-0f8e-a5cf-3347bc4850cb@nvidia.com>
 <b560f3c3-b69e-d9b5-2dae-1ede52af0ea6@nvidia.com>
 <011b52b6-9fcd-8930-1313-6b546226c7b9@nvidia.com>
 <8a6696e0-fc53-2e6b-536b-d1d2668e0f21@nvidia.com>
 <07c3dd04-cfd0-2d52-5917-25d0e40ad00b@nvidia.com>
 <20190618093657.GA30711@e121166-lin.cambridge.arm.com>
 <eb0e5b1e-7e91-4dc6-681f-b497f087c62d@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eb0e5b1e-7e91-4dc6-681f-b497f087c62d@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 18, 2019 at 04:21:17PM +0530, Vidya Sagar wrote:

[...]

> > 2) It is not related to this patch but I fail to see the reasoning
> >     behind the __ in __dw_pci_read_dbi(), there is no no-underscore
> >     equivalent so its definition is somewhat questionable, maybe
> >     we should clean-it up (for dbi2 alike).
> Separate no-underscore versions are present in pcie-designware.h for
> each width (i.e. l/w/b) as inline and are calling __ versions passing
> size as argument.

I understand - the __ prologue was added in b50b2db266d8 maybe
Kishon can help us understand the __ rationale.

I am happy to merge it as is, I was just curious about the
__ annotation (not related to this patch).

Lorenzo

> > Lorenzo
> > 
> > > Thanks,
> > > Vidya Sagar
> > > 
> > > > 
> > > > > 
> > > > > > > 
> > > > > > > > 
> > > > > > > > > 
> > > > > > > > > Thanks,
> > > > > > > > > Lorenzo
> > > > > > > > > 
> > > > > > > > > > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > > > > > > > index 77db32529319..d069e4290180 100644
> > > > > > > > > > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > > > > > > > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > > > > > > > @@ -496,6 +496,14 @@ int dw_pcie_host_init(struct pcie_port *pp)
> > > > > > > > > >        return ret;
> > > > > > > > > >    }
> > > > > > > > > > +void dw_pcie_host_deinit(struct pcie_port *pp)
> > > > > > > > > > +{
> > > > > > > > > > +    pci_stop_root_bus(pp->root_bus);
> > > > > > > > > > +    pci_remove_root_bus(pp->root_bus);
> > > > > > > > > > +    if (pci_msi_enabled() && !pp->ops->msi_host_init)
> > > > > > > > > > +        dw_pcie_free_msi(pp);
> > > > > > > > > > +}
> > > > > > > > > > +
> > > > > > > > > >    static int dw_pcie_access_other_conf(struct pcie_port *pp, struct pci_bus *bus,
> > > > > > > > > >                         u32 devfn, int where, int size, u32 *val,
> > > > > > > > > >                         bool write)
> > > > > > > > > > diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> > > > > > > > > > index deab426affd3..4f48ec78c7b9 100644
> > > > > > > > > > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > > > > > > > > > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > > > > > > > > > @@ -348,6 +348,7 @@ void dw_pcie_msi_init(struct pcie_port *pp);
> > > > > > > > > >    void dw_pcie_free_msi(struct pcie_port *pp);
> > > > > > > > > >    void dw_pcie_setup_rc(struct pcie_port *pp);
> > > > > > > > > >    int dw_pcie_host_init(struct pcie_port *pp);
> > > > > > > > > > +void dw_pcie_host_deinit(struct pcie_port *pp);
> > > > > > > > > >    int dw_pcie_allocate_domains(struct pcie_port *pp);
> > > > > > > > > >    #else
> > > > > > > > > >    static inline irqreturn_t dw_handle_msi_irq(struct pcie_port *pp)
> > > > > > > > > > @@ -372,6 +373,10 @@ static inline int dw_pcie_host_init(struct pcie_port *pp)
> > > > > > > > > >        return 0;
> > > > > > > > > >    }
> > > > > > > > > > +static inline void dw_pcie_host_deinit(struct pcie_port *pp)
> > > > > > > > > > +{
> > > > > > > > > > +}
> > > > > > > > > > +
> > > > > > > > > >    static inline int dw_pcie_allocate_domains(struct pcie_port *pp)
> > > > > > > > > >    {
> > > > > > > > > >        return 0;
> > > > > > > > > > -- 
> > > > > > > > > > 2.17.1
> > > > > > > > > > 
> > > > > > > > 
> > > > > > > 
> > > > > > 
> > > > > 
> > > > 
> > > 
> 
