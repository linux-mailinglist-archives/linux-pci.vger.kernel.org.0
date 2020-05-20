Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30D9A1DB0FF
	for <lists+linux-pci@lfdr.de>; Wed, 20 May 2020 13:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgETLGv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 May 2020 07:06:51 -0400
Received: from foss.arm.com ([217.140.110.172]:53228 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726403AbgETLGu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 20 May 2020 07:06:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 86DA431B;
        Wed, 20 May 2020 04:06:47 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BFF0A3F68F;
        Wed, 20 May 2020 04:06:45 -0700 (PDT)
Date:   Wed, 20 May 2020 12:06:40 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Cc:     Vidya Sagar <vidyas@nvidia.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kthota@nvidia.com" <kthota@nvidia.com>,
        "mmaddireddy@nvidia.com" <mmaddireddy@nvidia.com>,
        "sagar.tv@gmail.com" <sagar.tv@gmail.com>,
        Alan Mikhak <alan.mikhak@sifive.com>
Subject: Re: [PATCH] PCI: dwc: Warn only for non-prefetchable memory resource
 size >4GB
Message-ID: <20200520110640.GA5300@e121166-lin.cambridge.arm.com>
References: <20200513190855.23318-1-vidyas@nvidia.com>
 <20200513223508.GA352288@bjorn-Precision-5520>
 <20200518155435.GA2299@e121166-lin.cambridge.arm.com>
 <cd62a9da-5c47-ceb2-10e7-4cf657f07801@nvidia.com>
 <20200519145816.GB21261@e121166-lin.cambridge.arm.com>
 <DM5PR12MB1276C836FEE46B113112FA92DAB90@DM5PR12MB1276.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM5PR12MB1276C836FEE46B113112FA92DAB90@DM5PR12MB1276.namprd12.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 19, 2020 at 10:08:54PM +0000, Gustavo Pimentel wrote:

[...]

> > > > > > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > > > index 42fbfe2a1b8f..a29396529ea4 100644
> > > > > > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > > > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > > > @@ -366,7 +366,8 @@ int dw_pcie_host_init(struct pcie_port *pp)
> > > > > >                      pp->mem = win->res;
> > > > > >                      pp->mem->name = "MEM";
> > > > > >                      mem_size = resource_size(pp->mem);
> > > > > > -                   if (upper_32_bits(mem_size))
> > > > > > +                   if (upper_32_bits(mem_size) &&
> > > > > > +                       !(win->res->flags & IORESOURCE_PREFETCH))
> > > > > >                              dev_warn(dev, "MEM resource size exceeds max for 32 bits\n");
> > > > > >                      pp->mem_size = mem_size;
> > > > > >                      pp->mem_bus_addr = pp->mem->start - win->offset;
> > > > 
> > > > That warning was added for a reason - why should not we log legitimate
> > > > warnings ? AFAIU having resources larger than 4GB can lead to undefined
> > > > behaviour given the current ATU programming API.
> > > Yeah. I'm all for a warning if the size is larger than 4GB in case of
> > > non-prefetchable window as one of the ATU outbound translation
> > > channels is being used,
> > 
> > Is it true for all DWC host controllers ? Or there may be another
> > exception whereby we would be forced to disable this warning altogether
> > ?
> > 
> > > but, we are not employing any ATU outbound translation channel for
> > 
> > What does this mean ? "we are not employing any ATU outbound...", is
> > this the tegra driver ? And what guarantees that this warning is not
> > legitimate on DWC host controllers that do use the ATU outbound
> > translation for prefetchable windows ?
> > 
> > Can DWC maintainers chime in and clarify please ?
> 
> Before this code section, there is the following function call 
> pci_parse_request_of_pci_ranges(), which performs a simple validation for 
> the IORESOURCE_MEM resource type.
> This validation checks if the resource is marked as prefetchable, if so, 
> an error message "non-prefetchable memory resource required" is given and 
> a return code with the -EINVAL value.

That code checks if there is *at least* a non-prefetchable resource,
that's all it does.

> In other words, to reach the code that Vidya is changing, it can be only 
> if the resource is a non-prefetchable, any prefetchable resource will be 
> blocked by the previous call, if I'm not mistaken.

I think you are mistaken sorry.

> Having this in mind, Vidya's change will not make the expected result 
> aimed by him.

I think Vidya's patch does what he expects, the question is whether
it is widely applicable to ALL DWC hosts, that's what I want to know.

> I don't see any problem by having resources larger than 4GB, from what 
> I'm seeing in the databook there isn't any restricting related to that as 
> long they don't consume the maximum space that is addressable by the 
> system (depending on if they are 32-bit or 64-bit system address).
> 
> To be honest, I'm not seeing a system that could have this resource 
> larger than 4GB, but it might exist some exception that I don't know of, 
> that's why I accepted Alan's patch to warn the user that the resource 
> exceeds the maximum for the 32 bits so that he can be aware that he 
> *might* be consuming the maximum space addressable.

I think it is most certainly a possibility to have > 4GB prefetchable
address spaces so we ought to fix this for good. I still have to
understand how the DWC host detects the memory region to be programmed
into the ATU given that there is more than one but only 1 ATU memory
region AFAICS.

Lorenzo
