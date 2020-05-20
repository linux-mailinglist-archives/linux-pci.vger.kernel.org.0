Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 055C51DC252
	for <lists+linux-pci@lfdr.de>; Thu, 21 May 2020 00:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728608AbgETWsW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 May 2020 18:48:22 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:38038 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728424AbgETWsT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 May 2020 18:48:19 -0400
Received: by mail-il1-f196.google.com with SMTP id j2so5051100ilr.5;
        Wed, 20 May 2020 15:48:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=a6CsSkyyYqfJ3PWKR4lfOXJnXovm0FJ9Ug4n/bB3wGo=;
        b=uS/+oHkA0Tgg37hfjbRJZhq403HOwOn23zMVHu1lPgFeiLZEHoijn7bTJ1AYhIt5+V
         hnIZ0FSWCYGtuXfPi80IpswWFk0F0M6W9MtIlt926HWb92GUCay94hwfrxSV1SWCb5MN
         3EZfu3WYn8nfu5Nl2S2l0sAOYDCXzqn7ECHDEVFTxt8Zh+7FXFMZJHZWeXSijSDauNrv
         oklBES/pXTSR3fjMbUvPKWbsR2IUEBr9NivkdpIM4oFFv0D7yjXxnU8Am1VN7HMyX+Il
         DeSX83HgI7wQz8ZJt8vF0Up3lXtkAAnL0Jn2FdIBE3sYmJMkqLDqb6h+cYotGCsI89qA
         lEBQ==
X-Gm-Message-State: AOAM531roOLUdivNDF5lEMxByoTQp9o+Ha1e7VIxl05UJ52C7RH85Yr4
        pwj1lBkFaehkYl3mW4R4PQ==
X-Google-Smtp-Source: ABdhPJz7AEJmGD0xmO7ymFo3VwMxQRTMwG6wmqEGmjyaLRoWT7TJaCjZrFM91Sil3ymBrKdaJzQ8cw==
X-Received: by 2002:a92:3a51:: with SMTP id h78mr6415882ila.39.1590014898311;
        Wed, 20 May 2020 15:48:18 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id v15sm2051219ila.57.2020.05.20.15.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 15:48:17 -0700 (PDT)
Received: (nullmailer pid 747995 invoked by uid 1000);
        Wed, 20 May 2020 22:48:16 -0000
Date:   Wed, 20 May 2020 16:48:16 -0600
From:   Rob Herring <robh@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kthota@nvidia.com" <kthota@nvidia.com>,
        "mmaddireddy@nvidia.com" <mmaddireddy@nvidia.com>,
        "sagar.tv@gmail.com" <sagar.tv@gmail.com>,
        Alan Mikhak <alan.mikhak@sifive.com>
Subject: Re: Re: [PATCH] PCI: dwc: Warn only for non-prefetchable memory
 resource size >4GB
Message-ID: <20200520224816.GA739245@bogus>
References: <20200513190855.23318-1-vidyas@nvidia.com>
 <20200513223508.GA352288@bjorn-Precision-5520>
 <20200518155435.GA2299@e121166-lin.cambridge.arm.com>
 <cd62a9da-5c47-ceb2-10e7-4cf657f07801@nvidia.com>
 <20200519145816.GB21261@e121166-lin.cambridge.arm.com>
 <DM5PR12MB1276C836FEE46B113112FA92DAB90@DM5PR12MB1276.namprd12.prod.outlook.com>
 <20200520111717.GB2141681@ulmo>
 <b1a72abe-6da0-b782-0269-65388f663e26@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1a72abe-6da0-b782-0269-65388f663e26@nvidia.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 20, 2020 at 11:16:32PM +0530, Vidya Sagar wrote:
> 
> 
> On 20-May-20 4:47 PM, Thierry Reding wrote:
> > On Tue, May 19, 2020 at 10:08:54PM +0000, Gustavo Pimentel wrote:
> > > On Tue, May 19, 2020 at 15:58:16, Lorenzo Pieralisi
> > > <lorenzo.pieralisi@arm.com> wrote:
> > > 
> > > > On Tue, May 19, 2020 at 07:25:02PM +0530, Vidya Sagar wrote:
> > > > > 
> > > > > 
> > > > > On 18-May-20 9:24 PM, Lorenzo Pieralisi wrote:
> > > > > > External email: Use caution opening links or attachments
> > > > > > 
> > > > > > 
> > > > > > On Wed, May 13, 2020 at 05:35:08PM -0500, Bjorn Helgaas wrote:
> > > > > > > [+cc Alan; please cc authors of relevant commits,
> > > > > > > updated Andrew's email address]
> > > > > > > 
> > > > > > > On Thu, May 14, 2020 at 12:38:55AM +0530, Vidya Sagar wrote:
> > > > > > > > commit 9e73fa02aa009 ("PCI: dwc: Warn if MEM resource size exceeds max for
> > > > > > > > 32-bits") enables warning for MEM resources of size >4GB but prefetchable
> > > > > > > >    memory resources also come under this category where sizes can go beyond
> > > > > > > > 4GB. Avoid logging a warning for prefetchable memory resources.
> > > > > > > > 
> > > > > > > > Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> > > > > > > > ---
> > > > > > > >    drivers/pci/controller/dwc/pcie-designware-host.c | 3 ++-
> > > > > > > >    1 file changed, 2 insertions(+), 1 deletion(-)
> > > > > > > > 
> > > > > > > > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > > > > > index 42fbfe2a1b8f..a29396529ea4 100644
> > > > > > > > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > > > > > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > > > > > @@ -366,7 +366,8 @@ int dw_pcie_host_init(struct pcie_port *pp)
> > > > > > > >                       pp->mem = win->res;
> > > > > > > >                       pp->mem->name = "MEM";
> > > > > > > >                       mem_size = resource_size(pp->mem);
> > > > > > > > -                   if (upper_32_bits(mem_size))
> > > > > > > > +                   if (upper_32_bits(mem_size) &&
> > > > > > > > +                       !(win->res->flags & IORESOURCE_PREFETCH))
> > > > > > > >                               dev_warn(dev, "MEM resource size exceeds max for 32 bits\n");
> > > > > > > >                       pp->mem_size = mem_size;
> > > > > > > >                       pp->mem_bus_addr = pp->mem->start - win->offset;
> > > > > > 
> > > > > > That warning was added for a reason - why should not we log legitimate
> > > > > > warnings ? AFAIU having resources larger than 4GB can lead to undefined
> > > > > > behaviour given the current ATU programming API.
> > > > > Yeah. I'm all for a warning if the size is larger than 4GB in case of
> > > > > non-prefetchable window as one of the ATU outbound translation
> > > > > channels is being used,
> > > > 
> > > > Is it true for all DWC host controllers ? Or there may be another
> > > > exception whereby we would be forced to disable this warning altogether
> > > > ?
> > > > 
> > > > > but, we are not employing any ATU outbound translation channel for
> > > > 
> > > > What does this mean ? "we are not employing any ATU outbound...", is
> > > > this the tegra driver ? And what guarantees that this warning is not
> > > > legitimate on DWC host controllers that do use the ATU outbound
> > > > translation for prefetchable windows ?
> > > > 
> > > > Can DWC maintainers chime in and clarify please ?
> > > 
> > > Before this code section, there is the following function call
> > > pci_parse_request_of_pci_ranges(), which performs a simple validation for
> > > the IORESOURCE_MEM resource type.
> > > This validation checks if the resource is marked as prefetchable, if so,
> > > an error message "non-prefetchable memory resource required" is given and
> > > a return code with the -EINVAL value.
> > 
> > That's not what the code is doing. pci_parse_request_of_pci_range() will
> > traverse over the whole list of resources that it can find for the given
> > host controller and checks whether one of the resources defines prefetch
> > memory (note the res_valid |= ...). The error will only be returned if
> > no prefetchable memory region was found.
> > 
> > dw_pcie_host_init() will then again traverse the list of resources and
> > it will typically encounter two resource of type IORESOURCE_MEM, one for
> > non-prefetchable memory and another for prefetchable memory.
> > 
> > Vidya's patch is to differentiate between these two resources and allow
> > prefetchable memory regions to exceed sizes of 4 GiB.
> > 
> > That said, I wonder if there isn't a bigger problem at hand here. From
> > looking at the code it doesn't seem like the DWC driver makes any
> > distinction between prefetchable and non-prefetchable memory. Or at
> > least it doesn't allow both to be stored in struct pcie_port.
> > 
> > Am I missing something? Or can anyone explain how we're programming the
> > apertures for prefetchable vs. non-prefetchable memory? Perhaps this is
> > what Vidya was referring to when he said: "we are not using an outbound
> > ATU translation channel for prefetchable memory".
> > 
> > It looks to me like we're also getting partially lucky, or perhaps that
> > is by design, in that Tegra194 defines PCI regions in the following
> > order: I/O, prefetchable memory, non-prefetchable memory. That means
> > that the DWC core code will overwrite prefetchable memory data with that
> > of non-prefetchable memory and hence the non-prefetchable region ends up
> > stored in struct pcie_port and is then used to program the ATU outbound
> > channel.
> Well,it is by design. I mean, since the code is not differentiating between
> prefetchable and non-prefetchable regions, I ordered the entries in 'ranges'
> property in such a way that 'prefetchable' comes first followed by
> 'non-prefetchable' entry so that ATU region is used for generating the
> translation required for 'non-prefetchable' region (which is a non 1-to-1
> mapping)

You are getting lucky with your 'design'. Relying on order is fragile 
(except of course in the places in DT where order is defined, but ranges 
is not one of them).

Rob
