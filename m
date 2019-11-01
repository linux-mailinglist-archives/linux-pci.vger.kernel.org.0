Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20EB7EC3A0
	for <lists+linux-pci@lfdr.de>; Fri,  1 Nov 2019 14:26:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbfKAN0d (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Nov 2019 09:26:33 -0400
Received: from foss.arm.com ([217.140.110.172]:35368 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726860AbfKAN0d (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 1 Nov 2019 09:26:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1C92C1F1;
        Fri,  1 Nov 2019 06:26:32 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 780223F71E;
        Fri,  1 Nov 2019 06:26:31 -0700 (PDT)
Date:   Fri, 1 Nov 2019 13:26:29 +0000
From:   Andrew Murray <andrew.murray@arm.com>
To:     Tom Joseph <tjoseph@cadence.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] PCI: cadence: Refactor driver to use as a core library
Message-ID: <20191101132629.GF9723@e119886-lin.cambridge.arm.com>
References: <1571252912-7354-1-git-send-email-tjoseph@cadence.com>
 <20191025134658.GZ47056@e119886-lin.cambridge.arm.com>
 <MWHPR07MB385315AA79FE4E1EE8531BCBA1600@MWHPR07MB3853.namprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR07MB385315AA79FE4E1EE8531BCBA1600@MWHPR07MB3853.namprd07.prod.outlook.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 30, 2019 at 03:03:19PM +0000, Tom Joseph wrote:
> Hi Andrew,
> 
>  I noticed that I missed to respond to your question here.
> 

> > > diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
> > > index fe9f9f1..cafbed0 100644
> > > --- a/drivers/pci/controller/Kconfig
> > > +++ b/drivers/pci/controller/Kconfig
> > > @@ -48,6 +48,34 @@ config PCIE_CADENCE_EP
> > >  	  endpoint mode. This PCIe controller may be embedded into many
> > >  	  different vendors SoCs.
> > >
> > > +config PCIE_CADENCE_PLAT
> > > +	bool
> > > +
> > > +config PCIE_CADENCE_PLAT_HOST
> > > +	bool "Cadence PCIe platform host controller"
> > > +	depends on OF
> > > +	depends on PCI
> > > +	select IRQ_DOMAIN
> > > +	select PCIE_CADENCE
> > > +	select PCIE_CADENCE_HOST
> > > +	select PCIE_CADENCE_PLAT
> > > +	help
> > > +	  Say Y here if you want to support the Cadence PCIe platform
> > controller in
> > > +	  host mode. This PCIe controller may be embedded into many
> > different
> > > +	  vendors SoCs.
> > > +
> > > +config PCIE_CADENCE_PLAT_EP
> > > +	bool "Cadence PCIe platform endpoint controller"
> > > +	depends on OF
> > > +	depends on PCI_ENDPOINT
> > > +	select PCIE_CADENCE
> > > +	select PCIE_CADENCE_EP
> > > +	select PCIE_CADENCE_PLAT
> > > +	help
> > > +	  Say Y here if you want to support the Cadence PCIe  platform
> > controller in
> > > +	  endpoint mode. This PCIe controller may be embedded into many
> > > +	  different vendors SoCs.
> > > +
> > >  endmenu
> > >
> > >  config PCIE_XILINX_NWL
> > > diff --git a/drivers/pci/controller/Makefile
> > b/drivers/pci/controller/Makefile
> > > index d56a507..676a41e 100644
> > > --- a/drivers/pci/controller/Makefile
> > > +++ b/drivers/pci/controller/Makefile
> > > @@ -2,6 +2,7 @@
> > >  obj-$(CONFIG_PCIE_CADENCE) += pcie-cadence.o
> > >  obj-$(CONFIG_PCIE_CADENCE_HOST) += pcie-cadence-host.o
> > >  obj-$(CONFIG_PCIE_CADENCE_EP) += pcie-cadence-ep.o
> > > +obj-$(CONFIG_PCIE_CADENCE_PLAT) += pcie-cadence-plat.o
> > >  obj-$(CONFIG_PCI_FTPCI100) += pci-ftpci100.o
> > 
> > I think in addition to the above hunks you also need the following:
> > 
> > --- a/drivers/pci/controller/Kconfig
> > +++ b/drivers/pci/controller/Kconfig
> > @@ -28,25 +28,16 @@ config PCIE_CADENCE
> >         bool
> > 
> >  config PCIE_CADENCE_HOST
> > -       bool "Cadence PCIe host controller"
> > +       bool
> >         depends on OF
> > -       depends on PCI
> >         select IRQ_DOMAIN
> >         select PCIE_CADENCE
> > -       help
> > -         Say Y here if you want to support the Cadence PCIe controller in host
> > -         mode. This PCIe controller may be embedded into many different
> > vendors
> > -         SoCs.
> > 
> >  config PCIE_CADENCE_EP
> > -       bool "Cadence PCIe endpoint controller"
> > +       bool
> >         depends on OF
> >         depends on PCI_ENDPOINT
> >         select PCIE_CADENCE
> > -       help
> > -         Say Y here if you want to support the Cadence PCIe  controller in
> > -         endpoint mode. This PCIe controller may be embedded into many
> > -         different vendors SoCs.
> > 
> >  config PCIE_CADENCE_PLAT
> >         bool
> > 
> > I removed the 'depends on PCI' as you get that for free seeing as the
> > "PCI controller drivers" menu depends on PCI.
> > 
> > Removing the help and text prevents anything from being shown in the
> > Kconfig
> > system - I think you need that here to avoid confusing the user (and to make
> > this just like DWC).
> > 
> > I'm happy with the above. Though just like DWC, I find this confusing. This
> > allows future Cadence based controller drivers to include support for the EP
> > or host library by 'selecting PCIE_CADENCE_(HOST,EP)' resulting in those
> > libraries being compiled in. But despite this the user can still unselect
> > PCIE_CADENCE_PLAT_HOST which simply prevents that HOST,EP library
> > functions
> > from being called - i.e. to override and disable that functionality.
> 
> Thanks for the spotting this and for the explanation . I have corrected these in v3.
> > 
> > There is no reason that this needs to look like the DWC Kconfig, if there is
> > a better way that can provide additional benefits then please feel free to
> > change it.


> > > +
> > > +	platform_set_drvdata(pdev, cdns_plat_pcie);
> > > +	if (is_rc) {
> > > +		if (!IS_ENABLED(CONFIG_PCIE_CADENCE_PLAT_HOST))
> > > +			return -ENODEV;
> > 
> > To continue my earlier point, I haven't understood why (in the DWC case)
> > this
> > isn't just CONFIG_PCIE_CADENCE_HOST - i.e. why not a single CONFIG for
> > the HOST
> > (instead of _HOST AND _PLAT_HOST)?
> > 
> 
> My understanding is that, this would be a place where SoC/platform specific code could be inserted.
> It might not be obvious here (as there is nothing much platform specific) , but just for demo purpose.
>  

Thanks for this. 

Thanks,

Andrew Murray
