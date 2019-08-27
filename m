Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 088329E4BF
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2019 11:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728639AbfH0Jsb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Aug 2019 05:48:31 -0400
Received: from foss.arm.com ([217.140.110.172]:41822 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726972AbfH0Jsb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Aug 2019 05:48:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4024F337;
        Tue, 27 Aug 2019 02:48:30 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8EACE3F718;
        Tue, 27 Aug 2019 02:48:29 -0700 (PDT)
Date:   Tue, 27 Aug 2019 10:48:28 +0100
From:   Andrew Murray <andrew.murray@arm.com>
To:     "Chocron, Jonathan" <jonnyc@amazon.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        "Hanoch, Uri" <hanochu@amazon.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
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
Subject: Re: [PATCH v4 7/7] PCI: dwc: Add validation that PCIe core is set to
 correct mode
Message-ID: <20190827094827.GJ14582@e119886-lin.cambridge.arm.com>
References: <20190821153545.17635-1-jonnyc@amazon.com>
 <20190821154745.31834-3-jonnyc@amazon.com>
 <20190822111315.GN23903@e119886-lin.cambridge.arm.com>
 <f8fca74c8d252f000d60c52ead3fc41ed5d50b6d.camel@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8fca74c8d252f000d60c52ead3fc41ed5d50b6d.camel@amazon.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 22, 2019 at 04:30:09PM +0000, Chocron, Jonathan wrote:
> On Thu, 2019-08-22 at 12:13 +0100, Andrew Murray wrote:
> > On Wed, Aug 21, 2019 at 06:47:45PM +0300, Jonathan Chocron wrote:
> > > Some PCIe controllers can be set to either Host or EP according to
> > > some
> > > early boot FW. To make sure there is no discrepancy (e.g. FW
> > > configured
> > > the port to EP mode while the DT specifies it as a host bridge or
> > > vice
> > > versa), a check has been added for each mode.
> > > 
> > > Signed-off-by: Jonathan Chocron <jonnyc@amazon.com>
> > > Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> > > ---
> > >  drivers/pci/controller/dwc/pcie-designware-ep.c   | 8 ++++++++
> > >  drivers/pci/controller/dwc/pcie-designware-host.c | 8 ++++++++
> > >  2 files changed, 16 insertions(+)
> > > 
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > index 2bf5a35c0570..00e59a134b93 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > @@ -531,6 +531,7 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> > >  	int ret;
> > >  	u32 reg;
> > >  	void *addr;
> > > +	u8 hdr_type;
> > >  	unsigned int nbars;
> > >  	unsigned int offset;
> > >  	struct pci_epc *epc;
> > > @@ -543,6 +544,13 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> > >  		return -EINVAL;
> > >  	}
> > >  
> > > +	hdr_type = dw_pcie_readb_dbi(pci, PCI_HEADER_TYPE);
> > > +	if (hdr_type != PCI_HEADER_TYPE_NORMAL) {
> > > +		dev_err(pci->dev, "PCIe controller is not set to EP
> > > mode (hdr_type:0x%x)!\n",
> > > +			hdr_type);
> > > +		return -EIO;
> > > +	}
> > > +
> > >  	ret = of_property_read_u32(np, "num-ib-windows", &ep-
> > > >num_ib_windows);
> > >  	if (ret < 0) {
> > >  		dev_err(dev, "Unable to read *num-ib-windows*
> > > property\n");
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c
> > > b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > index f93252d0da5b..d2ca748e4c85 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > @@ -323,6 +323,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
> > >  	struct pci_bus *child;
> > >  	struct pci_host_bridge *bridge;
> > >  	struct resource *cfg_res;
> > > +	u8 hdr_type;
> > >  	int ret;
> > >  
> > >  	raw_spin_lock_init(&pci->pp.lock);
> > > @@ -396,6 +397,13 @@ int dw_pcie_host_init(struct pcie_port *pp)
> > >  		}
> > >  	}
> > >  
> > > +	hdr_type = dw_pcie_readb_dbi(pci, PCI_HEADER_TYPE);
> > 
> > Do we know if it's always safe to read these registers at this point
> > in time?
> > 
> > Later in dw_pcie_host_init we call pp->ops->host_init - looking at
> > the
> > implementations of .host_init I can see:
> > 
> >  - resets being performed (qcom_ep_reset_assert,
> >    artpec6_pcie_assert_core_reset, imx6_pcie_assert_core_reset)
> >  - changes to config space registers (ks_pcie_init_id,
> > dw_pcie_setup_rc)
> >    including setting PCI_CLASS_DEVICE
> >  - and clocks being enabled (qcom_pcie_init_1_0_0)
> > 
> Good point! This indeed might break host drivers which actually setup
> the rc in the kernel, and don't depend on early boot FW. So the
> validation should probably be moved to after pp->ops->host_init() (and
> similarly after ep->ops->ep_init() for the ep driver), right?

Yes I think so.


> 
> > I'm not sure if your changes would cause anything to break for these
> > other
> > controllers (or future controllers) as I couldn't see any other reads
> > to the
> > config.
> > 
> > Given that we are reading config space should dw_pcie_rd_own_conf be
> > used?
> 
> The config space of the DW core is located at the beginning of the DBI
> regspace. Furthermore, this would break the "symmetry" between the host
> and ep validations (since the ep has no notion of reading from config
> space nor a .read callback in struct dw_pcie_ep_ops).

This is true, though given how different the two drivers are - this is only
really 'nice to have'.


> I agree that
> there is some sort of overlap between the dw_pcie_read{/write}_dbi
> dw_pcie_rd{/wr}_own_conf APIs, when accessing the host mode config
> space, but I assume that any host driver which supplies a callback for
> .rd_own_conf() must supply an equivalent .read_dbi() one as well.
> 
> > (For example kirin_pcie_rd_own_conf does something special).
> > 
> They specifically define an equivalent kirin_pcie_read_dbi().

This may also be true. However given that the dwc framework gives host drivers
the ability to provide their own rd_own_conf callback - it's very possible
that these drivers can use the callback to handle quirks - now or in the
future. Potentially a quirk that your direct reading won't handle.

Looking at the existing drivers which provide a .rd_own_conf:

pci-exynos.c:
 - Uses dw_pcie_read to directly read from registers, sandwich'd between writes
   to set/clear PCIE_ELBI_SLV_ARMISC. This driver provides a .read_dbi which
   means dw_pcie_readb_dbi probably does the same thing as rd_own_conf.

pci-menson.c:
 - Uses dw_pcie_read to directly read from registers, it then applies a read
   quirk for the PCI_CLASS_DEVICE register. This driver doesn't provide a
   .read_dbi - thus dw_pcie_readb_dbi probably does the same thing as
   rd_own_conf provided you don't read the PCI_CLASS_DEVICE register.

pcie-hisi.c:
 - Uses dw_pcie_readl_dbi to read from registers, but the controller only
   supports 32bit aligned reads - it doesn't provide a .read_dbi. This means
   that if you used dw_pcie_readb_dbi it'd probably break because you can't
   read 1 byte at the offset where HEADER_TYPE is.

pcie-histb.c, pcie-kirin.c: looks like pci-exynos.c

It looks like we're going to have to break symmetry...

Thanks,

Andrew Murray

> 
> > Thanks,
> > 
> > Andrew Murray
> > 
> > > +	if (hdr_type != PCI_HEADER_TYPE_BRIDGE) {
> > > +		dev_err(pci->dev, "PCIe controller is not set to bridge
> > > type (hdr_type: 0x%x)!\n",
> > > +			hdr_type);
> > > +		return -EIO;
> > > +	}
> > > +
> > >  	pp->mem_base = pp->mem->start;
> > >  
> > >  	if (!pp->va_cfg0_base) {
> > > -- 
> > > 2.17.1
> > > 
