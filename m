Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 347E81EE760
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jun 2020 17:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729107AbgFDPIg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Jun 2020 11:08:36 -0400
Received: from foss.arm.com ([217.140.110.172]:45594 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728587AbgFDPIg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 4 Jun 2020 11:08:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BE3BA1FB;
        Thu,  4 Jun 2020 08:08:35 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 436823F305;
        Thu,  4 Jun 2020 08:08:33 -0700 (PDT)
Date:   Thu, 4 Jun 2020 16:08:27 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Diana Craciun <diana.craciun@oss.nxp.com>,
        Marc Zyngier <maz@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Makarand Pawagi <makarand.pawagi@nxp.com>,
        linux-acpi@vger.kernel.org,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: Re: [PATCH 10/12] of/irq: Make of_msi_map_rid() PCI bus agnostic
Message-ID: <20200604150827.GA1232@e121166-lin.cambridge.arm.com>
References: <20200521130008.8266-1-lorenzo.pieralisi@arm.com>
 <20200521130008.8266-11-lorenzo.pieralisi@arm.com>
 <CAL_JsqLTBxX_3KjiEqMfw0qMaTmj_DdPD3j-yMUvrvONPBSvjg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqLTBxX_3KjiEqMfw0qMaTmj_DdPD3j-yMUvrvONPBSvjg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 21, 2020 at 05:17:27PM -0600, Rob Herring wrote:
> On Thu, May 21, 2020 at 7:00 AM Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com> wrote:
> >
> > There is nothing PCI bus specific in the of_msi_map_rid()
> > implementation other than the requester ID tag for the input
> > ID space. Rename requester ID to a more generic ID so that
> > the translation code can be used by all busses that require
> > input/output ID translations.
> >
> > Leave a wrapper function of_msi_map_rid() in place to keep
> > existing PCI code mapping requester ID syntactically unchanged.
> >
> > No functional change intended.
> >
> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Marc Zyngier <maz@kernel.org>
> > ---
> >  drivers/of/irq.c       | 28 ++++++++++++++--------------
> >  include/linux/of_irq.h | 14 ++++++++++++--
> >  2 files changed, 26 insertions(+), 16 deletions(-)
> >
> > diff --git a/drivers/of/irq.c b/drivers/of/irq.c
> > index 48a40326984f..25d17b8a1a1a 100644
> > --- a/drivers/of/irq.c
> > +++ b/drivers/of/irq.c
> > @@ -576,43 +576,43 @@ void __init of_irq_init(const struct of_device_id *matches)
> >         }
> >  }
> >
> > -static u32 __of_msi_map_rid(struct device *dev, struct device_node **np,
> > -                           u32 rid_in)
> > +static u32 __of_msi_map_id(struct device *dev, struct device_node **np,
> > +                           u32 id_in)
> >  {
> >         struct device *parent_dev;
> > -       u32 rid_out = rid_in;
> > +       u32 id_out = id_in;
> >
> >         /*
> >          * Walk up the device parent links looking for one with a
> >          * "msi-map" property.
> >          */
> >         for (parent_dev = dev; parent_dev; parent_dev = parent_dev->parent)
> > -               if (!of_map_rid(parent_dev->of_node, rid_in, "msi-map",
> > -                               "msi-map-mask", np, &rid_out))
> > +               if (!of_map_id(parent_dev->of_node, id_in, "msi-map",
> > +                               "msi-map-mask", np, &id_out))
> >                         break;
> > -       return rid_out;
> > +       return id_out;
> >  }
> >
> >  /**
> > - * of_msi_map_rid - Map a MSI requester ID for a device.
> > + * of_msi_map_id - Map a MSI ID for a device.
> >   * @dev: device for which the mapping is to be done.
> >   * @msi_np: device node of the expected msi controller.
> > - * @rid_in: unmapped MSI requester ID for the device.
> > + * @id_in: unmapped MSI ID for the device.
> >   *
> >   * Walk up the device hierarchy looking for devices with a "msi-map"
> > - * property.  If found, apply the mapping to @rid_in.
> > + * property.  If found, apply the mapping to @id_in.
> >   *
> > - * Returns the mapped MSI requester ID.
> > + * Returns the mapped MSI ID.
> >   */
> > -u32 of_msi_map_rid(struct device *dev, struct device_node *msi_np, u32 rid_in)
> > +u32 of_msi_map_id(struct device *dev, struct device_node *msi_np, u32 id_in)
> >  {
> > -       return __of_msi_map_rid(dev, &msi_np, rid_in);
> > +       return __of_msi_map_id(dev, &msi_np, id_in);
> >  }
> >
> >  /**
> >   * of_msi_map_get_device_domain - Use msi-map to find the relevant MSI domain
> >   * @dev: device for which the mapping is to be done.
> > - * @rid: Requester ID for the device.
> > + * @id: Device ID.
> >   * @bus_token: Bus token
> >   *
> >   * Walk up the device hierarchy looking for devices with a "msi-map"
> > @@ -625,7 +625,7 @@ struct irq_domain *of_msi_map_get_device_domain(struct device *dev, u32 id,
> >  {
> >         struct device_node *np = NULL;
> >
> > -       __of_msi_map_rid(dev, &np, id);
> > +       __of_msi_map_id(dev, &np, id);
> >         return irq_find_matching_host(np, bus_token);
> >  }
> >
> > diff --git a/include/linux/of_irq.h b/include/linux/of_irq.h
> > index 7142a3722758..cf9cb1e545ce 100644
> > --- a/include/linux/of_irq.h
> > +++ b/include/linux/of_irq.h
> > @@ -55,7 +55,12 @@ extern struct irq_domain *of_msi_map_get_device_domain(struct device *dev,
> >                                                         u32 id,
> >                                                         u32 bus_token);
> >  extern void of_msi_configure(struct device *dev, struct device_node *np);
> > -u32 of_msi_map_rid(struct device *dev, struct device_node *msi_np, u32 rid_in);
> > +u32 of_msi_map_id(struct device *dev, struct device_node *msi_np, u32 id_in);
> > +static inline u32 of_msi_map_rid(struct device *dev,
> > +                                struct device_node *msi_np, u32 rid_in)
> > +{
> > +       return of_msi_map_id(dev, msi_np, rid_in);
> > +}
> >  #else
> >  static inline int of_irq_count(struct device_node *dev)
> >  {
> > @@ -93,10 +98,15 @@ static inline struct irq_domain *of_msi_map_get_device_domain(struct device *dev
> >  static inline void of_msi_configure(struct device *dev, struct device_node *np)
> >  {
> >  }
> > +static inline u32 of_msi_map_id(struct device *dev,
> > +                                struct device_node *msi_np, u32 id_in)
> > +{
> > +       return id_in;
> > +}
> >  static inline u32 of_msi_map_rid(struct device *dev,
> >                                  struct device_node *msi_np, u32 rid_in)
> 
> Move this out of the ifdef and you only need it declared once.
> 
> But again, I think I'd just kill of_msi_map_rid.

Yes I don't think there is a clear benefit in keeping the _rid
interface.

Thanks,
Lorenzo
