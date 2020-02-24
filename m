Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6135016A85B
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2020 15:32:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbgBXOcX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Feb 2020 09:32:23 -0500
Received: from foss.arm.com ([217.140.110.172]:37972 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727709AbgBXOcX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 24 Feb 2020 09:32:23 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A0F5630E;
        Mon, 24 Feb 2020 06:32:22 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D5A413F534;
        Mon, 24 Feb 2020 06:32:20 -0800 (PST)
Date:   Mon, 24 Feb 2020 14:32:18 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        andrew.murray@arm.com, bhelgaas@google.com, kishon@ti.com,
        thierry.reding@gmail.com, Jisheng.Zhang@synaptics.com,
        jonathanh@nvidia.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V3 4/5] PCI: dwc: Add API to notify core initialization
 completion
Message-ID: <20200224143218.GC15614@e121166-lin.cambridge.arm.com>
References: <20200217121036.3057-1-vidyas@nvidia.com>
 <20200217121036.3057-5-vidyas@nvidia.com>
 <20200224113217.GA11120@e121166-lin.cambridge.arm.com>
 <77748536-4f9a-1357-8180-91c1da2e912e@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77748536-4f9a-1357-8180-91c1da2e912e@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Feb 24, 2020 at 05:50:26PM +0530, Vidya Sagar wrote:
> 
> 
> On 2/24/2020 5:02 PM, Lorenzo Pieralisi wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > On Mon, Feb 17, 2020 at 05:40:35PM +0530, Vidya Sagar wrote:
> > > Add a new API dw_pcie_ep_init_notify() to let platform drivers
> > > call it when the core is available for initialization.
> > > 
> > > Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> > > Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
> > > ---
> > > V3:
> > > * Added Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
> > > 
> > > V2:
> > > * None
> > > 
> > >   drivers/pci/controller/dwc/pcie-designware-ep.c | 7 +++++++
> > >   drivers/pci/controller/dwc/pcie-designware.h    | 5 +++++
> > >   2 files changed, 12 insertions(+)
> > > 
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > index 84a102df9f62..dfbb806c25bf 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > @@ -19,6 +19,13 @@ void dw_pcie_ep_linkup(struct dw_pcie_ep *ep)
> > >        pci_epc_linkup(epc);
> > >   }
> > > 
> > > +void dw_pcie_ep_init_notify(struct dw_pcie_ep *ep)
> > > +{
> > > +     struct pci_epc *epc = ep->epc;
> > > +
> > > +     pci_epc_init_notify(epc);
> > > +}
> > 
> > Do we really need this wrapper ? I would drop this code and I would
> > appreciate if you could post tegra changes benefiting from this
> > series, at the moment I don't see any user of this newly added
> > infrastructure.
> I've posted that series also for review
> @ http://patchwork.ozlabs.org/project/linux-pci/list/?series=152889
> Sorry if I have to create explicit dependency by some means. I'm not
> aware of that and would like to know if that exists. All that I did was
> to mention this as a dependency for the other (Tegra change) series.

No worries - I just want to merge code that is actually used, I assume
the series above should be reposted right ? You need an ACK from Thierry
for it and we can merge the whole thing on top of Kishon's patches.

I was just referring to the wrapper above, it does not seem very
useful given that we can call pci_epc_init_notify() directly,
please correct me if I am wrong, there does not seem to be anything
DWC specific (at least for the time being) in the _notify() hook.

Thanks,
Lorenzo

> 
> Thanks,
> Vidya Sagar
> 
> > 
> > Thanks,
> > Lorenzo
> > 
> > >   static void __dw_pcie_ep_reset_bar(struct dw_pcie *pci, enum pci_barno bar,
> > >                                   int flags)
> > >   {
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> > > index b67b7f756bc2..aa98fbd50807 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > > @@ -412,6 +412,7 @@ static inline int dw_pcie_allocate_domains(struct pcie_port *pp)
> > >   void dw_pcie_ep_linkup(struct dw_pcie_ep *ep);
> > >   int dw_pcie_ep_init(struct dw_pcie_ep *ep);
> > >   int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep);
> > > +void dw_pcie_ep_init_notify(struct dw_pcie_ep *ep);
> > >   void dw_pcie_ep_exit(struct dw_pcie_ep *ep);
> > >   int dw_pcie_ep_raise_legacy_irq(struct dw_pcie_ep *ep, u8 func_no);
> > >   int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
> > > @@ -434,6 +435,10 @@ static inline int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
> > >        return 0;
> > >   }
> > > 
> > > +static inline void dw_pcie_ep_init_notify(struct dw_pcie_ep *ep)
> > > +{
> > > +}
> > > +
> > >   static inline void dw_pcie_ep_exit(struct dw_pcie_ep *ep)
> > >   {
> > >   }
> > > --
> > > 2.17.1
> > > 
