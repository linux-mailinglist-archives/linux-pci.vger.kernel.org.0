Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4C511EE69D
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jun 2020 16:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728663AbgFDO1M (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Jun 2020 10:27:12 -0400
Received: from foss.arm.com ([217.140.110.172]:45180 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728496AbgFDO1M (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 4 Jun 2020 10:27:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AC7EA2B;
        Thu,  4 Jun 2020 07:27:11 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 384F03F305;
        Thu,  4 Jun 2020 07:27:09 -0700 (PDT)
Date:   Thu, 4 Jun 2020 15:27:03 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        PCI <linux-pci@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Hanjun Guo <guohanjun@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Makarand Pawagi <makarand.pawagi@nxp.com>,
        Diana Craciun <diana.craciun@oss.nxp.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: Re: [PATCH 06/12] of/iommu: Make of_map_rid() PCI agnostic
Message-ID: <20200604142703.GA476@e121166-lin.cambridge.arm.com>
References: <20200521130008.8266-1-lorenzo.pieralisi@arm.com>
 <20200521130008.8266-7-lorenzo.pieralisi@arm.com>
 <CAL_JsqK5aiEMAZpqgTmrOq=HPRSFEoQWJrpR2YA0hziEtLMwrg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqK5aiEMAZpqgTmrOq=HPRSFEoQWJrpR2YA0hziEtLMwrg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 21, 2020 at 04:47:19PM -0600, Rob Herring wrote:
> On Thu, May 21, 2020 at 7:00 AM Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com> wrote:
> >
> > There is nothing PCI specific (other than the RID - requester ID)
> > in the of_map_rid() implementation, so the same function can be
> > reused for input/output IDs mapping for other busses just as well.
> >
> > Rename the RID instances/names to a generic "id" tag and provide
> > an of_map_rid() wrapper function so that we can leave the existing
> > (and legitimate) callers unchanged.
> 
> It's not all that clear to a casual observer that RID is a PCI thing,
> so I don't know that keeping it buys much. And there's only 3 callers.

Yes I agree - I think we can remove the _rid interface.

> > No functionality change intended.
> >
> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Joerg Roedel <joro@8bytes.org>
> > Cc: Robin Murphy <robin.murphy@arm.com>
> > Cc: Marc Zyngier <maz@kernel.org>
> > ---
> >  drivers/iommu/of_iommu.c |  2 +-
> >  drivers/of/base.c        | 42 ++++++++++++++++++++--------------------
> >  include/linux/of.h       | 17 +++++++++++++++-
> >  3 files changed, 38 insertions(+), 23 deletions(-)
> >
> > diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> > index 20738aacac89..ad96b87137d6 100644
> > --- a/drivers/iommu/of_iommu.c
> > +++ b/drivers/iommu/of_iommu.c
> > @@ -145,7 +145,7 @@ static int of_fsl_mc_iommu_init(struct fsl_mc_device *mc_dev,
> >         struct of_phandle_args iommu_spec = { .args_count = 1 };
> >         int err;
> >
> > -       err = of_map_rid(master_np, mc_dev->icid, "iommu-map",
> > +       err = of_map_id(master_np, mc_dev->icid, "iommu-map",
> 
> I'm not sure this is an improvement because I'd refactor this function
> and of_pci_iommu_init() into a single function:
> 
> of_bus_iommu_init(struct device *dev, struct device_node *np, u32 id)
> 
> Then of_pci_iommu_init() becomes:
> 
> of_pci_iommu_init()
> {
>   return of_bus_iommu_init(info->dev, info->np, alias);
> }
> 
> And replace of_fsl_mc_iommu_init call with:
> err = of_bus_iommu_init(dev, master_np, to_fsl_mc_device(dev)->icid);

I will follow up on this on patch 7.

> >                          "iommu-map-mask", &iommu_spec.np,
> >                          iommu_spec.args);
> >         if (err)
> > diff --git a/drivers/of/base.c b/drivers/of/base.c
> > index ae03b1218b06..e000e17bd602 100644
> > --- a/drivers/of/base.c
> > +++ b/drivers/of/base.c
> > @@ -2201,15 +2201,15 @@ int of_find_last_cache_level(unsigned int cpu)
> >  }
> >
> >  /**
> > - * of_map_rid - Translate a requester ID through a downstream mapping.
> > + * of_map_id - Translate a requester ID through a downstream mapping.
> 
> Still a requester ID?

Fixed, thanks.

Lorenzo
