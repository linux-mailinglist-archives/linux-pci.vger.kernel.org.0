Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 657EA8607B
	for <lists+linux-pci@lfdr.de>; Thu,  8 Aug 2019 12:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731178AbfHHK60 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Aug 2019 06:58:26 -0400
Received: from foss.arm.com ([217.140.110.172]:60070 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731122AbfHHK60 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 8 Aug 2019 06:58:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D98E228;
        Thu,  8 Aug 2019 03:58:25 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BBD723F694;
        Thu,  8 Aug 2019 03:58:23 -0700 (PDT)
Date:   Thu, 8 Aug 2019 11:58:21 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     "Chocron, Jonathan" <jonnyc@amazon.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        "Hanoch, Uri" <hanochu@amazon.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "Wasserstrom, Barak" <barakw@amazon.com>,
        "Saidi, Ali" <alisaidi@amazon.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "Hawa, Hanna" <hhhawa@amazon.com>,
        "Shenhar, Talel" <talel@amazon.com>,
        "Krupnik, Ronen" <ronenk@amazon.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>
Subject: Re: [PATCH v3 8/8] PCI: dw: Add support for
 PCI_PROBE_ONLY/PCI_REASSIGN_ALL_BUS flags
Message-ID: <20190808105821.GB30230@e121166-lin.cambridge.arm.com>
References: <20190723092529.11310-1-jonnyc@amazon.com>
 <20190723092711.11786-4-jonnyc@amazon.com>
 <20190807163654.GC16214@e121166-lin.cambridge.arm.com>
 <67c58ded2177beca030450c25d742d35890eb48a.camel@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67c58ded2177beca030450c25d742d35890eb48a.camel@amazon.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Side note, run:

git log --oneline on drivers/pci/controller/dwc existing files and
make sure commit subjects are in line with those.

Eg PCI: dw: should be PCI: dwc:

On Thu, Aug 08, 2019 at 09:30:05AM +0000, Chocron, Jonathan wrote:
> On Wed, 2019-08-07 at 17:36 +0100, Lorenzo Pieralisi wrote:
> > On Tue, Jul 23, 2019 at 12:27:11PM +0300, Jonathan Chocron wrote:
> > > This basically aligns the usage of PCI_PROBE_ONLY and
> > > PCI_REASSIGN_ALL_BUS in dw_pcie_host_init() with the logic in
> > > pci_host_common_probe().
> > > 
> > > Now it will be possible to control via the devicetree whether to
> > > just
> > > probe the PCI bus (in cases where FW already configured it) or to
> > > fully
> > > configure it.
> > > 
> > > Signed-off-by: Jonathan Chocron <jonnyc@amazon.com>
> > > ---
> > >  .../pci/controller/dwc/pcie-designware-host.c | 23
> > > +++++++++++++++----
> > >  1 file changed, 19 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c
> > > b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > index d2ca748e4c85..0a294d8aa21a 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > @@ -342,6 +342,8 @@ int dw_pcie_host_init(struct pcie_port *pp)
> > >  	if (!bridge)
> > >  		return -ENOMEM;
> > >  
> > > +	of_pci_check_probe_only();
> > > +
> > >  	ret = devm_of_pci_get_host_bridge_resources(dev, 0, 0xff,
> > >  					&bridge->windows, &pp-
> > > >io_base);
> > >  	if (ret)
> > > @@ -474,6 +476,10 @@ int dw_pcie_host_init(struct pcie_port *pp)
> > >  
> > >  	pp->root_bus_nr = pp->busn->start;
> > >  
> > > +	/* Do not reassign bus nums if probe only */
> > > +	if (!pci_has_flag(PCI_PROBE_ONLY))
> > > +		pci_add_flags(PCI_REASSIGN_ALL_BUS);
> > 
> > This changes the default for bus reassignment on all DWC host (that
> > are
> > !PCI_PROBE_ONLY), we should drop this line, it can trigger
> > regressions.
> > 
> Will be dropped as part of v4. There might also be a behavioral
> difference below where I added the if (pci_has_flag(PCI_PROBE_ONLY)).
> Is that still ok?

That's true but I doubt any DWC host has a DT firmware with
"linux,pci-probe-only" in it.

It is trial and error I am afraid, please make sure all DWC
maintainers are copied in.

> As I pointed out in the cover letter, since PCI_PROBE_ONLY is a system
> wide flag, does it make sense to call of_pci_check_probe_only() here,
> in the context of a specific driver (including the existing invocation
> in pci_host_common_probe()), as opposed to a platform/arch context?

It is an ongoing discussion to define how we should handle
PCI_PROBE_ONLY. Adding this code into DWC I do not think it
would hurt but if we can postpone it for the next (v5.5) merge
window after we debate this at LPC within the PCI microconference
it would be great.

Please sync with Benjamin as a first step, I trust he would ask
you to do the right thing.

> > If we still want to merge it as a separate change we must test it on
> > all
> > DWC host bridges to make sure it does not trigger any issues with
> > current set-ups, that's not going to be easy though.
> > 
> Just out of curiosity, how are such exhaustive tests achieved when a
> patch requires them?

CC DWC host bridge maintainers and ask them to test it. I do not have
the HW (and FW) required, I am sorry, that's the only option I can give
you. -next coverage would help too but to a minor extent.

Thanks,
Lorenzo

> 
> > Lorenzo
> > 
> > > +
> > >  	bridge->dev.parent = dev;
> > >  	bridge->sysdata = pp;
> > >  	bridge->busnr = pp->root_bus_nr;
> > > @@ -490,11 +496,20 @@ int dw_pcie_host_init(struct pcie_port *pp)
> > >  	if (pp->ops->scan_bus)
> > >  		pp->ops->scan_bus(pp);
> > >  
> > > -	pci_bus_size_bridges(pp->root_bus);
> > > -	pci_bus_assign_resources(pp->root_bus);
> > > +	/*
> > > +	 * We insert PCI resources into the iomem_resource and
> > > +	 * ioport_resource trees in either pci_bus_claim_resources()
> > > +	 * or pci_bus_assign_resources().
> > > +	 */
> > > +	if (pci_has_flag(PCI_PROBE_ONLY)) {
> > > +		pci_bus_claim_resources(pp->root_bus);
> > > +	} else {
> > > +		pci_bus_size_bridges(pp->root_bus);
> > > +		pci_bus_assign_resources(pp->root_bus);
> > >  
> > > -	list_for_each_entry(child, &pp->root_bus->children, node)
> > > -		pcie_bus_configure_settings(child);
> > > +		list_for_each_entry(child, &pp->root_bus->children,
> > > node)
> > > +			pcie_bus_configure_settings(child);
> > > +	}
> > >  
> > >  	pci_bus_add_devices(pp->root_bus);
> > >  	return 0;
> > > -- 
> > > 2.17.1
> > > 
