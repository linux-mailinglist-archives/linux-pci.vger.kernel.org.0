Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDFBE2B7E7E
	for <lists+linux-pci@lfdr.de>; Wed, 18 Nov 2020 14:46:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbgKRNqN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Nov 2020 08:46:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:60760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726110AbgKRNqM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 18 Nov 2020 08:46:12 -0500
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4143B2469D;
        Wed, 18 Nov 2020 13:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605707171;
        bh=LxdYtUYZUuk07ZFVlNZklKV8jP/+COcN5ep+396FCR4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nQPYWpP62EGi4INY7Ai/rs97dcsPVYCDpcRuXqmRnZNsGBE1OkcBq/1EAG1q8vOuE
         arlGvVDtoT1LnWLC21bM8oK+TVB5ci87OAtzJwikDdrmg+nMr9iyDguvYr+ZUYEiRT
         n5tt1H3ZLpyFNBZZ4x3xGlYu+fDUPR88QhrNPQKw=
Received: by mail-oi1-f182.google.com with SMTP id m143so2202709oig.7;
        Wed, 18 Nov 2020 05:46:11 -0800 (PST)
X-Gm-Message-State: AOAM5338t27psOSFfX07NTMj3Jl4CKESK+Q4g++EKyESu979uGKh3wT/
        4dW6h61G8CawHa0YOcy1P5E6zdjOSJONJBhz1ek=
X-Google-Smtp-Source: ABdhPJzOD/hsPgqboQ/BixZQYEYFb61osRX6kWYRlkeouCLzDAUreSVsDIY9jSa5NAyDLtYePkPSPV99ZOe0c56HX5Y=
X-Received: by 2002:aca:c60c:: with SMTP id w12mr76520oif.174.1605707170260;
 Wed, 18 Nov 2020 05:46:10 -0800 (PST)
MIME-Version: 1.0
References: <20201117134214.970-1-chenbaozi@phytium.com.cn> <20201117185720.GA1397876@bjorn-Precision-5520>
In-Reply-To: <20201117185720.GA1397876@bjorn-Precision-5520>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 18 Nov 2020 14:45:57 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEzst3PqpbyfbGwrAXzufrBAmJHmEdBvkibtqSdAKVMDA@mail.gmail.com>
Message-ID: <CAMj1kXEzst3PqpbyfbGwrAXzufrBAmJHmEdBvkibtqSdAKVMDA@mail.gmail.com>
Subject: Re: [RFC PATCH V2] acpi/irq: Add stacked IRQ domain support to PCI
 interrupt link
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Chen Baozi <chenbaozi@phytium.com.cn>,
        Hanjun Guo <guohanjun@huawei.com>,
        Marc Zyngier <maz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 17 Nov 2020 at 19:57, Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> Nit: please don't just make up random styles for the subject.  Run
> "git log --oneline" on the file and/or the directory and try to follow
> the existing convention.  Using random styles adds noise to the
> system.
>
> On Tue, Nov 17, 2020 at 09:42:14PM +0800, Chen Baozi wrote:
> > Some PCIe designs require software to do extra acknowledgements for
> > legacy INTx interrupts. If the driver is written only for device tree,
> > things are simple. In that case, a new driver can be written under
> > driver/pci/controller/ with a DT node of PCIe host written like:
> >
> >   pcie {
> >     ...
> >     interrupt-map = <0 0 0  1  &pcie_intc 0>,
> >                     <0 0 0  2  &pcie_intc 1>,
> >                     <0 0 0  3  &pcie_intc 2>,
> >                     <0 0 0  4  &pcie_intc 3>;
> >
> >     pcie_intc: legacy-interrupt-controller {
> >       interrupt-controller;
> >       #interrupt-cells = <1>;
> >       interrupt-parent = <&gic>;
> >       interrupts = <0 226 4>;
> >     };
> >   };
> >
> > Similar designs can be found on Aardvark, MediaTek Gen2 and Socionext
> > UniPhier PCIe controller at the moment. Essentially, those designs are
> > supported by inserting an extra interrupt controller between PCIe host
> > and GIC and parse the topology in a DT-based PCI controller driver.
>
> If I understand correctly, we previously ignored the Resource Source
> field of an Extended Interrupt Descriptor in the _PRS method of
> PNP0C0F PCI Interrupt Link devices, and this patch adds support for
> it.
>
> If that's true, this has nothing to do with DT, other than DT being
> another way to describe the same topology, and the above details
> really aren't relevant to this patch.
>
> > As we turn to ACPI, All the PCIe hosts are described the same ID of
> > "PNP0A03" and share driver/acpi/pci_root.c. It comes to be a problem
> > to make this kind of PCI INTx work under ACPI.
>
> s/All the PCIe/all the PCIe/
>
> But this paragraph should probably just go away in favor of something
> about implementing Resource Source support.
>
> > Therefore, we introduce an stacked IRQ domain support to PCI interrupt
> > link for ACPI. With this support, we can populate the ResourceSource
> > to refer to a device object that describes an interrupt controller.
> > That would allow us to refer to a dedicated driver which implements
> > the logic needed to manage the interrupt state. With this patch,
> > those PCI interrupt links can be supported by describing the INTx
> > in ACPI table as the following example:
>
> "Stacked IRQ domain" sounds like a detail of how you're implementing
> support for the Resource Source field for PCI Interrupt Links.
>
> I don't know what the dedicated driver refers to.  This *should* be
> all generic code the follows the ACPI spec (which is pretty sketchy in
> this area).  But I assume that there's no special driver needed for
> devices like \SB.IXIU, and the logic associated with the interrupt
> controller is in the AML associated with IXIU.  It would probably be
> useful to mention the relevant methods in the IXIU methods in the
> example below.
>

As I understand it, the intent is to provide a driver for \SB.IXIU
that acknowledges the legacy INTx interrupts in a SoC specific way,
and I don't see how AML could be involved here.

That also explains why the routines are exported to modules - the IXIU
driver could be modularized.


> From ACPI v6.3, Table 6-200, it looks like this patch should include
> changes to acpi_bus_osc_support() to advertise "Interrupt
> ResourceSource support".
>

I assume this covers all uses of ResourceSource, right? Not only in
the context if PCIe legacy interrupts?

> >   Device (IXIU) {
> >     ...
> >   }
> >
> >   Device(LINKA) {
> >     Name(_HID, EISAID("PNP0C0F"))
> >     Name(_PRS, ResourceTemplate(){
> >       Interrupt(ResourceProducer, Level, ActiveHigh, Exclusive, 0, "\\SB.IXIU")
> >         { 60 }
> >     })
> >     ...
> >   }
> >
> >   Device(PCI0) {
> >     ...
> >     Name(_PRT, Package{
> >       Package{ 0x0000FFFF, 0, LINKA, 0 }
> >       ...
> >     })
> >   }
> >
> > Signed-off-by: Chen Baozi <chenbaozi@phytium.com.cn>
> > ---
> >  drivers/acpi/irq.c          | 22 +++++++++++++++++++++-
> >  drivers/acpi/pci_irq.c      |  6 ++++--
> >  drivers/acpi/pci_link.c     | 17 +++++++++++++++--
> >  include/acpi/acpi_drivers.h |  2 +-
> >  include/linux/acpi.h        |  4 ++++
> >  5 files changed, 45 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/acpi/irq.c b/drivers/acpi/irq.c
> > index e209081d644b..e78a44815c44 100644
> > --- a/drivers/acpi/irq.c
> > +++ b/drivers/acpi/irq.c
> > @@ -81,6 +81,25 @@ void acpi_unregister_gsi(u32 gsi)
> >  }
> >  EXPORT_SYMBOL_GPL(acpi_unregister_gsi);
> >
> > +int acpi_register_irq(struct device *dev, u32 irq, int trigger,
> > +                   int polarity, struct fwnode_handle *domain_id)
> > +{
> > +     struct irq_fwspec fwspec;
> > +
> > +     if (WARN_ON(!domain_id)) {
> > +             pr_warn("GSI: No registered irqchip, giving up\n");
>
> This message could contain more information, e.g., by using
> dev_warn(), including the irq value, etc.
>
> > +             return -EINVAL;
> > +     }
> > +
> > +     fwspec.fwnode = domain_id;
> > +     fwspec.param[0] = irq;
> > +     fwspec.param[1] = acpi_dev_get_irq_type(trigger, polarity);
> > +     fwspec.param_count = 2;
> > +
> > +     return irq_create_fwspec_mapping(&fwspec);
> > +}
> > +EXPORT_SYMBOL_GPL(acpi_register_irq);
>
> Why does this need to be exported?  You only call it from
> acpi_pci_irq_enable(), which cannot be a module.
>
> >  /**
> >   * acpi_get_irq_source_fwhandle() - Retrieve fwhandle from IRQ resource source.
> >   * @source: acpi_resource_source to use for the lookup.
> > @@ -92,7 +111,7 @@ EXPORT_SYMBOL_GPL(acpi_unregister_gsi);
> >   * Return:
> >   * The referenced device fwhandle or NULL on failure
> >   */
> > -static struct fwnode_handle *
> > +struct fwnode_handle *
> >  acpi_get_irq_source_fwhandle(const struct acpi_resource_source *source)
> >  {
> >       struct fwnode_handle *result;
> > @@ -115,6 +134,7 @@ acpi_get_irq_source_fwhandle(const struct acpi_resource_source *source)
> >       acpi_bus_put_acpi_device(device);
> >       return result;
> >  }
> > +EXPORT_SYMBOL_GPL(acpi_get_irq_source_fwhandle);
>
> This doesn't look like it needs to be exported either.
>
> >  /*
> >   * Context for the resource walk used to lookup IRQ resources.
> > diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
> > index 14ee631cb7cf..19296d70c95c 100644
> > --- a/drivers/acpi/pci_irq.c
> > +++ b/drivers/acpi/pci_irq.c
> > @@ -410,6 +410,7 @@ int acpi_pci_irq_enable(struct pci_dev *dev)
> >       char *link = NULL;
> >       char link_desc[16];
> >       int rc;
> > +     struct fwnode_handle *irq_domain;
> >
> >       pin = dev->pin;
> >       if (!pin) {
> > @@ -438,7 +439,8 @@ int acpi_pci_irq_enable(struct pci_dev *dev)
> >                       gsi = acpi_pci_link_allocate_irq(entry->link,
> >                                                        entry->index,
> >                                                        &triggering, &polarity,
> > -                                                      &link);
> > +                                                      &link,
> > +                                                      &irq_domain);
> >               else
> >                       gsi = entry->index;
> >       } else
> > @@ -462,7 +464,7 @@ int acpi_pci_irq_enable(struct pci_dev *dev)
> >               return 0;
> >       }
> >
> > -     rc = acpi_register_gsi(&dev->dev, gsi, triggering, polarity);
> > +     rc = acpi_register_irq(&dev->dev, gsi, triggering, polarity, irq_domain);
> >       if (rc < 0) {
> >               dev_warn(&dev->dev, "PCI INT %c: failed to register GSI\n",
> >                        pin_name(pin));
> > diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
> > index fb4c5632a232..219a644d739a 100644
> > --- a/drivers/acpi/pci_link.c
> > +++ b/drivers/acpi/pci_link.c
> > @@ -59,6 +59,7 @@ struct acpi_pci_link_irq {
> >       u8 resource_type;
> >       u8 possible_count;
> >       u32 possible[ACPI_PCI_LINK_MAX_POSSIBLE];
> > +     struct acpi_resource_source resource_source;
> >       u8 initialized:1;
> >       u8 reserved:7;
> >  };
> > @@ -120,6 +121,8 @@ static acpi_status acpi_pci_link_check_possible(struct acpi_resource *resource,
> >               {
> >                       struct acpi_resource_extended_irq *p =
> >                           &resource->data.extended_irq;
> > +                     struct acpi_resource_source *rs =
> > +                         &link->irq.resource_source;
> >                       if (!p || !p->interrupt_count) {
> >                               printk(KERN_WARNING PREFIX
> >                                             "Blank _PRS EXT IRQ resource\n");
> > @@ -140,6 +143,12 @@ static acpi_status acpi_pci_link_check_possible(struct acpi_resource *resource,
> >                       link->irq.triggering = p->triggering;
> >                       link->irq.polarity = p->polarity;
> >                       link->irq.resource_type = ACPI_RESOURCE_TYPE_EXTENDED_IRQ;
> > +                     if (p->resource_source.string_length) {
> > +                             rs->index = p->resource_source.index;
> > +                             rs->string_length = p->resource_source.string_length;
> > +                             rs->string_ptr = kmalloc(rs->string_length, GFP_KERNEL);
> > +                             strcpy(rs->string_ptr, p->resource_source.string_ptr);
> > +                     }
> >                       break;
> >               }
> >       default:
> > @@ -326,7 +335,8 @@ static int acpi_pci_link_set(struct acpi_pci_link *link, int irq)
> >                       resource->res.data.extended_irq.shareable = ACPI_SHARED;
> >               resource->res.data.extended_irq.interrupt_count = 1;
> >               resource->res.data.extended_irq.interrupts[0] = irq;
> > -             /* ignore resource_source, it's optional */
> > +             resource->res.data.extended_irq.resource_source =
> > +                     link->irq.resource_source;
> >               break;
> >       default:
> >               printk(KERN_ERR PREFIX "Invalid Resource_type %d\n", link->irq.resource_type);
> > @@ -612,7 +622,7 @@ static int acpi_pci_link_allocate(struct acpi_pci_link *link)
> >   * failure: return -1
> >   */
> >  int acpi_pci_link_allocate_irq(acpi_handle handle, int index, int *triggering,
> > -                            int *polarity, char **name)
> > +                            int *polarity, char **name, struct fwnode_handle **irq_domain)
> >  {
> >       int result;
> >       struct acpi_device *device;
> > @@ -656,6 +666,9 @@ int acpi_pci_link_allocate_irq(acpi_handle handle, int index, int *triggering,
> >               *polarity = link->irq.polarity;
> >       if (name)
> >               *name = acpi_device_bid(link->device);
> > +     if (irq_domain)
> > +             *irq_domain = acpi_get_irq_source_fwhandle(&link->irq.resource_source);
> > +
> >       ACPI_DEBUG_PRINT((ACPI_DB_INFO,
> >                         "Link %s is referenced\n",
> >                         acpi_device_bid(link->device)));
> > diff --git a/include/acpi/acpi_drivers.h b/include/acpi/acpi_drivers.h
> > index 5eb175933a5b..6ff1ea76d476 100644
> > --- a/include/acpi/acpi_drivers.h
> > +++ b/include/acpi/acpi_drivers.h
> > @@ -68,7 +68,7 @@
> >
> >  int acpi_irq_penalty_init(void);
> >  int acpi_pci_link_allocate_irq(acpi_handle handle, int index, int *triggering,
> > -                            int *polarity, char **name);
> > +                            int *polarity, char **name, struct fwnode_handle **irq_domain);
> >  int acpi_pci_link_free_irq(acpi_handle handle);
> >
> >  /* ACPI PCI Device Binding (pci_bind.c) */
> > diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> > index 39263c6b52e1..5f1d7d3192fb 100644
> > --- a/include/linux/acpi.h
> > +++ b/include/linux/acpi.h
> > @@ -324,6 +324,8 @@ extern int sbf_port;
> >  extern unsigned long acpi_realmode_flags;
> >
> >  int acpi_register_gsi (struct device *dev, u32 gsi, int triggering, int polarity);
> > +int acpi_register_irq(struct device *dev, u32 gsi, int trigger,
> > +                   int polarity, struct fwnode_handle *domain_id);
>
> It looks like this declaration should be in drivers/acpi/internal.h,
> since it's only used inside drivers/acpi/.
>
> >  int acpi_gsi_to_irq (u32 gsi, unsigned int *irq);
> >  int acpi_isa_irq_to_gsi (unsigned isa_irq, u32 *gsi);
> >
> > @@ -336,6 +338,8 @@ struct irq_domain *acpi_irq_create_hierarchy(unsigned int flags,
> >                                            const struct irq_domain_ops *ops,
> >                                            void *host_data);
> >
> > +struct fwnode_handle *acpi_get_irq_source_fwhandle(const struct acpi_resource_source *source);
> > +
> >  #ifdef CONFIG_X86_IO_APIC
> >  extern int acpi_get_override_irq(u32 gsi, int *trigger, int *polarity);
> >  #else
> > --
> > 2.28.0
> >
