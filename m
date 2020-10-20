Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66709293D80
	for <lists+linux-pci@lfdr.de>; Tue, 20 Oct 2020 15:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407577AbgJTNlp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Oct 2020 09:41:45 -0400
Received: from foss.arm.com ([217.140.110.172]:52028 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407526AbgJTNlp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Oct 2020 09:41:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8F47D31B;
        Tue, 20 Oct 2020 06:41:42 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B47B03F719;
        Tue, 20 Oct 2020 06:41:40 -0700 (PDT)
Date:   Tue, 20 Oct 2020 14:41:34 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Vidya Sagar <vidyas@nvidia.com>, robh@kernel.org
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        bhelgaas@google.com, amurray@thegoodpenguin.co.uk,
        treding@nvidia.com, jonathanh@nvidia.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH] PCI: dwc: Use ATU regions to map memory regions
Message-ID: <20201020134134.GA26320@e121166-lin.cambridge.arm.com>
References: <20201005121351.32516-1-vidyas@nvidia.com>
 <e633d496-0c4b-f6f5-00a9-c98fb3ed9f61@nvidia.com>
 <20201020132037.GB25784@e121166-lin.cambridge.arm.com>
 <85e0d8f8-9dfe-b71b-f039-96eaf8f4c350@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85e0d8f8-9dfe-b71b-f039-96eaf8f4c350@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 20, 2020 at 07:03:59PM +0530, Vidya Sagar wrote:
> 
> 
> On 10/20/2020 6:50 PM, Lorenzo Pieralisi wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > On Mon, Oct 19, 2020 at 11:21:54AM +0530, Vidya Sagar wrote:
> > > Hi Lorenzo, Rob, Gustavo,
> > > Could you please review this change?
> > 
> > Next cycle - we are in the middle of the merge window and I am not
> > queueing any more patches.
> 
> Thanks for the update.
> FWIW, PCIe is broken on Tegra194 with Rob's patches (which got accepted
> already) and without the current patch.

Ah, that changes the picture then, it was not clear, this requires
immediate attention then.

Thanks,
Lorenzo

> Thanks,
> Vidya Sagar
> 
> > 
> > Thanks,
> > Lorenzo
> > 
> > > Thanks,
> > > Vidya Sagar
> > > 
> > > On 10/5/2020 5:43 PM, Vidya Sagar wrote:
> > > > Use ATU region-3 and region-0 to setup mapping for prefetchable and
> > > > non-prefetchable memory regions respectively only if their respective CPU
> > > > and bus addresses are different.
> > > > 
> > > > Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> > > > ---
> > > >    .../pci/controller/dwc/pcie-designware-host.c | 44 ++++++++++++++++---
> > > >    drivers/pci/controller/dwc/pcie-designware.c  | 12 ++---
> > > >    drivers/pci/controller/dwc/pcie-designware.h  |  4 +-
> > > >    3 files changed, 48 insertions(+), 12 deletions(-)
> > > > 
> > > > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > index 317ff512f8df..cefde8e813e9 100644
> > > > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > @@ -515,9 +515,40 @@ static struct pci_ops dw_pcie_ops = {
> > > >      .write = pci_generic_config_write,
> > > >    };
> > > > +static void dw_pcie_setup_mem_atu(struct pcie_port *pp,
> > > > +                             struct resource_entry *win)
> > > > +{
> > > > +   struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > > > +
> > > > +   if (win->res->flags & IORESOURCE_PREFETCH && pci->num_viewport >= 4 &&
> > > > +       win->offset) {
> > > > +           dw_pcie_prog_outbound_atu(pci,
> > > > +                                     PCIE_ATU_REGION_INDEX3,
> > > > +                                     PCIE_ATU_TYPE_MEM,
> > > > +                                     win->res->start,
> > > > +                                     win->res->start - win->offset,
> > > > +                                     resource_size(win->res));
> > > > +   } else if (win->res->flags & IORESOURCE_PREFETCH &&
> > > > +              pci->num_viewport < 4) {
> > > > +           dev_warn(pci->dev,
> > > > +                    "Insufficient ATU regions to map Prefetchable memory\n");
> > > > +   } else if (win->offset) {
> > > > +           if (upper_32_bits(resource_size(win->res)))
> > > > +                   dev_warn(pci->dev,
> > > > +                            "Memory resource size exceeds max for 32 bits\n");
> > > > +           dw_pcie_prog_outbound_atu(pci,
> > > > +                                     PCIE_ATU_REGION_INDEX0,
> > > > +                                     PCIE_ATU_TYPE_MEM,
> > > > +                                     win->res->start,
> > > > +                                     win->res->start - win->offset,
> > > > +                                     resource_size(win->res));
> > > > +   }
> > > > +}
> > > > +
> > > >    void dw_pcie_setup_rc(struct pcie_port *pp)
> > > >    {
> > > >      u32 val, ctrl, num_ctrls;
> > > > +   struct resource_entry *win;
> > > >      struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > > >      /*
> > > > @@ -572,13 +603,14 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
> > > >       * ATU, so we should not program the ATU here.
> > > >       */
> > > >      if (pp->bridge->child_ops == &dw_child_pcie_ops) {
> > > > -           struct resource_entry *entry =
> > > > -                   resource_list_first_type(&pp->bridge->windows, IORESOURCE_MEM);
> > > > +           resource_list_for_each_entry(win, &pp->bridge->windows) {
> > > > +                   switch (resource_type(win->res)) {
> > > > +                   case IORESOURCE_MEM:
> > > > +                           dw_pcie_setup_mem_atu(pp, win);
> > > > +                           break;
> > > > +                   }
> > > > +           }
> > > > -           dw_pcie_prog_outbound_atu(pci, PCIE_ATU_REGION_INDEX0,
> > > > -                                     PCIE_ATU_TYPE_MEM, entry->res->start,
> > > > -                                     entry->res->start - entry->offset,
> > > > -                                     resource_size(entry->res));
> > > >              if (pci->num_viewport > 2)
> > > >                      dw_pcie_prog_outbound_atu(pci, PCIE_ATU_REGION_INDEX2,
> > > >                                                PCIE_ATU_TYPE_IO, pp->io_base,
> > > > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> > > > index 3c1f17c78241..6033689abb15 100644
> > > > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > > > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > > > @@ -227,7 +227,7 @@ static void dw_pcie_writel_ob_unroll(struct dw_pcie *pci, u32 index, u32 reg,
> > > >    static void dw_pcie_prog_outbound_atu_unroll(struct dw_pcie *pci, u8 func_no,
> > > >                                           int index, int type,
> > > >                                           u64 cpu_addr, u64 pci_addr,
> > > > -                                        u32 size)
> > > > +                                        u64 size)
> > > >    {
> > > >      u32 retries, val;
> > > >      u64 limit_addr = cpu_addr + size - 1;
> > > > @@ -244,8 +244,10 @@ static void dw_pcie_prog_outbound_atu_unroll(struct dw_pcie *pci, u8 func_no,
> > > >                               lower_32_bits(pci_addr));
> > > >      dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_UPPER_TARGET,
> > > >                               upper_32_bits(pci_addr));
> > > > -   dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL1,
> > > > -                            type | PCIE_ATU_FUNC_NUM(func_no));
> > > > +   val = type | PCIE_ATU_FUNC_NUM(func_no);
> > > > +   val = upper_32_bits(size - 1) ?
> > > > +           val | PCIE_ATU_INCREASE_REGION_SIZE : val;
> > > > +   dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL1, val);
> > > >      dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL2,
> > > >                               PCIE_ATU_ENABLE);
> > > > @@ -266,7 +268,7 @@ static void dw_pcie_prog_outbound_atu_unroll(struct dw_pcie *pci, u8 func_no,
> > > >    static void __dw_pcie_prog_outbound_atu(struct dw_pcie *pci, u8 func_no,
> > > >                                      int index, int type, u64 cpu_addr,
> > > > -                                   u64 pci_addr, u32 size)
> > > > +                                   u64 pci_addr, u64 size)
> > > >    {
> > > >      u32 retries, val;
> > > > @@ -310,7 +312,7 @@ static void __dw_pcie_prog_outbound_atu(struct dw_pcie *pci, u8 func_no,
> > > >    }
> > > >    void dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index, int type,
> > > > -                          u64 cpu_addr, u64 pci_addr, u32 size)
> > > > +                          u64 cpu_addr, u64 pci_addr, u64 size)
> > > >    {
> > > >      __dw_pcie_prog_outbound_atu(pci, 0, index, type,
> > > >                                  cpu_addr, pci_addr, size);
> > > > diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> > > > index 97c7063b9e89..b81a1813cf9e 100644
> > > > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > > > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > > > @@ -80,10 +80,12 @@
> > > >    #define PCIE_ATU_VIEWPORT         0x900
> > > >    #define PCIE_ATU_REGION_INBOUND           BIT(31)
> > > >    #define PCIE_ATU_REGION_OUTBOUND  0
> > > > +#define PCIE_ATU_REGION_INDEX3             0x3
> > > >    #define PCIE_ATU_REGION_INDEX2            0x2
> > > >    #define PCIE_ATU_REGION_INDEX1            0x1
> > > >    #define PCIE_ATU_REGION_INDEX0            0x0
> > > >    #define PCIE_ATU_CR1                      0x904
> > > > +#define PCIE_ATU_INCREASE_REGION_SIZE      BIT(13)
> > > >    #define PCIE_ATU_TYPE_MEM         0x0
> > > >    #define PCIE_ATU_TYPE_IO          0x2
> > > >    #define PCIE_ATU_TYPE_CFG0                0x4
> > > > @@ -295,7 +297,7 @@ void dw_pcie_upconfig_setup(struct dw_pcie *pci);
> > > >    int dw_pcie_wait_for_link(struct dw_pcie *pci);
> > > >    void dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index,
> > > >                             int type, u64 cpu_addr, u64 pci_addr,
> > > > -                          u32 size);
> > > > +                          u64 size);
> > > >    void dw_pcie_prog_ep_outbound_atu(struct dw_pcie *pci, u8 func_no, int index,
> > > >                                int type, u64 cpu_addr, u64 pci_addr,
> > > >                                u32 size);
> > > > 
