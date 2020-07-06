Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F841215B57
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jul 2020 17:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729420AbgGFP6z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Jul 2020 11:58:55 -0400
Received: from foss.arm.com ([217.140.110.172]:51924 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729358AbgGFP6y (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 6 Jul 2020 11:58:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E78281FB;
        Mon,  6 Jul 2020 08:58:53 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B293C3F68F;
        Mon,  6 Jul 2020 08:58:52 -0700 (PDT)
Date:   Mon, 6 Jul 2020 16:58:47 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Rob Herring <robh@kernel.org>
Cc:     "Chocron, Jonathan" <jonnyc@amazon.com>,
        "zhengdejin5@gmail.com" <zhengdejin5@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "thomas.petazzoni@bootlin.com" <thomas.petazzoni@bootlin.com>,
        "pratyush.anand@gmail.com" <pratyush.anand@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "tjoseph@cadence.com" <tjoseph@cadence.com>
Subject: Re: [PATCH v1] PCI: controller: Remove duplicate error message
Message-ID: <20200706155847.GA32050@e121166-lin.cambridge.arm.com>
References: <20200526150954.4729-1-zhengdejin5@gmail.com>
 <1d7703d5c29dc9371ace3645377d0ddd9c89be30.camel@amazon.com>
 <20200527132005.GA7143@nuc8i5>
 <1b54c08f759c101a8db162f4f62c6b6a8a455d3f.camel@amazon.com>
 <CAL_JsqJWKfShzb6r=pXFv03T4L+nmNrCHvt+NkEy5EFuuD1HAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqJWKfShzb6r=pXFv03T4L+nmNrCHvt+NkEy5EFuuD1HAA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 02, 2020 at 09:01:13AM -0600, Rob Herring wrote:

[...]

> > > In fact, I think its error handling is clear enough, It just goes
> > > wrong
> > > in three places, as follows:
> > >
> > > void __iomem *devm_pci_remap_cfg_resource(struct device *dev,
> > >                                           struct resource *res)
> > > {
> > >         resource_size_t size;
> > >         const char *name;
> > >         void __iomem *dest_ptr;
> > >
> > >         BUG_ON(!dev);
> > >
> > >         if (!res || resource_type(res) != IORESOURCE_MEM) {
> > >                 dev_err(dev, "invalid resource\n");
> > >                 return IOMEM_ERR_PTR(-EINVAL);
> > >         }
> > >
> > In the above error case there is no indication of which resource failed
> > (mainly relevant if the resource name is missing in the devicetree,
> > since in the drivers you are changing platform_get_resource_byname() is
> > mostly used). In the existing drivers' code, on return from this
> > function in this case, the name would be printed by the caller.
> 
> A driver should only have one call to devm_pci_remap_cfg_resource() as
> there's only 1 config space. However, it looks like this function is
> frequently used on what is not config space which is a bigger issue.

That certainly is and should be fixed.

> If this error happens, it's almost always going to be a NULL ptr as
> platform_get_resource_byname() would have set IORESOURCE_MEM. Perhaps
> a WARN here so you get a backtrace to the caller location.

+1

> > >         size = resource_size(res);
> > >         name = res->name ?: dev_name(dev);
> > >
> > >         if (!devm_request_mem_region(dev, res->start, size, name)) {
> > >                 dev_err(dev, "can't request region for resource
> > > %pR\n", res);
> > >                 return IOMEM_ERR_PTR(-EBUSY);
> > >         }
> > >
> > >         dest_ptr = devm_pci_remap_cfgspace(dev, res->start, size);
> > >         if (!dest_ptr) {
> > >                 dev_err(dev, "ioremap failed for resource %pR\n",
> > > res);
> > >                 devm_release_mem_region(dev, res->start, size);
> > >                 dest_ptr = IOMEM_ERR_PTR(-ENOMEM);
> > >         }
> > >
> > The other 2 error cases as well don't print the resource name as far as
> > I recall (they will at least print the resource start/end).
> 
> Start/end are what are important for why either of these functions
> failed.
> 
> But sure, we could add 'name' here. That's a separate patch IMO.

I agree. In sum, I think it is OK to proceed with this patch, provided
we send follow-ups as discussed here, are we in agreement ?

Lorenzo
