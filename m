Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C068564820
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2019 16:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbfGJOTW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Jul 2019 10:19:22 -0400
Received: from foss.arm.com ([217.140.110.172]:34390 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbfGJOTV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 10 Jul 2019 10:19:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A34B72B;
        Wed, 10 Jul 2019 07:19:20 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 17BC03F71F;
        Wed, 10 Jul 2019 07:19:17 -0700 (PDT)
Date:   Wed, 10 Jul 2019 15:19:08 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com, kishon@ti.com,
        catalin.marinas@arm.com, will.deacon@arm.com, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, digetx@gmail.com,
        mperttunen@nvidia.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V13 05/12] PCI: dwc: Add ext config space capability
 search API
Message-ID: <20190710141900.GA8781@e121166-lin.cambridge.arm.com>
References: <20190710062212.1745-1-vidyas@nvidia.com>
 <20190710062212.1745-6-vidyas@nvidia.com>
 <20190710103709.GA4063@e121166-lin.cambridge.arm.com>
 <fd1fc10e-47d0-aaac-158d-1c19363ec8d3@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd1fc10e-47d0-aaac-158d-1c19363ec8d3@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 10, 2019 at 04:57:23PM +0530, Vidya Sagar wrote:
> On 7/10/2019 4:07 PM, Lorenzo Pieralisi wrote:
> > On Wed, Jul 10, 2019 at 11:52:05AM +0530, Vidya Sagar wrote:
> > > Add extended configuration space capability search API using struct dw_pcie *
> > > pointer
> > 
> > Sentences are terminated with a period and this is v13 not v1, which
> > proves that you do not read the commit logs you write.
> > 
> > I need you guys to understand that I can't rewrite commit logs all
> > the time, I do not want to go as far as not accepting your patches
> > anymore so please do pay attention to commit log details they
> > are as important as the code itself.
> > 
> > https://lore.kernel.org/linux-pci/20171026223701.GA25649@bhelgaas-glaptop.roam.corp.google.com/
> My sincere apologies.
> Since I didn't touch this patch much all through this series, I missed it.
> I'll make a point to not make such mistakes again.
> Do you want me to send a new version fixing it?

I will update it, I just wanted to get the point across, no
problems.

Lorenzo

> Thanks,
> Vidya Sagar
> 
> > 
> > Thanks,
> > Lorenzo
> > 
> > > Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> > > Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> > > Acked-by: Thierry Reding <treding@nvidia.com>
> > > ---
> > > V13:
> > > * None
> > > 
> > > V12:
> > > * None
> > > 
> > > V11:
> > > * None
> > > 
> > > V10:
> > > * None
> > > 
> > > V9:
> > > * Added Acked-by from Thierry
> > > 
> > > V8:
> > > * Changed data types of return and arguments to be inline with data being returned
> > >    and passed.
> > > 
> > > V7:
> > > * None
> > > 
> > > V6:
> > > * None
> > > 
> > > V5:
> > > * None
> > > 
> > > V4:
> > > * None
> > > 
> > > V3:
> > > * None
> > > 
> > > V2:
> > > * This is a new patch in v2 series
> > > 
> > >   drivers/pci/controller/dwc/pcie-designware.c | 41 ++++++++++++++++++++
> > >   drivers/pci/controller/dwc/pcie-designware.h |  1 +
> > >   2 files changed, 42 insertions(+)
> > > 
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> > > index 7818b4febb08..181449e342f1 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > > @@ -53,6 +53,47 @@ u8 dw_pcie_find_capability(struct dw_pcie *pci, u8 cap)
> > >   }
> > >   EXPORT_SYMBOL_GPL(dw_pcie_find_capability);
> > > +static u16 dw_pcie_find_next_ext_capability(struct dw_pcie *pci, u16 start,
> > > +					    u8 cap)
> > > +{
> > > +	u32 header;
> > > +	int ttl;
> > > +	int pos = PCI_CFG_SPACE_SIZE;
> > > +
> > > +	/* minimum 8 bytes per capability */
> > > +	ttl = (PCI_CFG_SPACE_EXP_SIZE - PCI_CFG_SPACE_SIZE) / 8;
> > > +
> > > +	if (start)
> > > +		pos = start;
> > > +
> > > +	header = dw_pcie_readl_dbi(pci, pos);
> > > +	/*
> > > +	 * If we have no capabilities, this is indicated by cap ID,
> > > +	 * cap version and next pointer all being 0.
> > > +	 */
> > > +	if (header == 0)
> > > +		return 0;
> > > +
> > > +	while (ttl-- > 0) {
> > > +		if (PCI_EXT_CAP_ID(header) == cap && pos != start)
> > > +			return pos;
> > > +
> > > +		pos = PCI_EXT_CAP_NEXT(header);
> > > +		if (pos < PCI_CFG_SPACE_SIZE)
> > > +			break;
> > > +
> > > +		header = dw_pcie_readl_dbi(pci, pos);
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +u16 dw_pcie_find_ext_capability(struct dw_pcie *pci, u8 cap)
> > > +{
> > > +	return dw_pcie_find_next_ext_capability(pci, 0, cap);
> > > +}
> > > +EXPORT_SYMBOL_GPL(dw_pcie_find_ext_capability);
> > > +
> > >   int dw_pcie_read(void __iomem *addr, int size, u32 *val)
> > >   {
> > >   	if (!IS_ALIGNED((uintptr_t)addr, size)) {
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> > > index d8c66a6827dc..11c223471416 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > > @@ -252,6 +252,7 @@ struct dw_pcie {
> > >   		container_of((endpoint), struct dw_pcie, ep)
> > >   u8 dw_pcie_find_capability(struct dw_pcie *pci, u8 cap);
> > > +u16 dw_pcie_find_ext_capability(struct dw_pcie *pci, u8 cap);
> > >   int dw_pcie_read(void __iomem *addr, int size, u32 *val);
> > >   int dw_pcie_write(void __iomem *addr, int size, u32 val);
> > > -- 
> > > 2.17.1
> > > 
> 
