Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F02A821619F
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jul 2020 00:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbgGFWc2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Jul 2020 18:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727057AbgGFWc0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Jul 2020 18:32:26 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F10CC08C5DF
        for <linux-pci@vger.kernel.org>; Mon,  6 Jul 2020 15:32:26 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id n23so47590380ljh.7
        for <linux-pci@vger.kernel.org>; Mon, 06 Jul 2020 15:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7jWD5vHooiaDqnTbtnYwVQHOG6k2FU8e2JhUtfDscDY=;
        b=PHUr0UIPdkWgLSJepxSrub2FtIg2X2XWPcXgvp5CWfRhIf0zvVCVAlmLPDlfRGfjWV
         ZydzybHf4FhrtbyDwGy0pM3rTAg6xRmq5dFmZ/8/Q157z6DJlScHF92HL2p1Af2ThFwL
         X08QczssEp3vy1f0JcKXWpHtWn5TQeJewcttuw3P0jnnd/2viQRlDytRJSa0c0+KSrGw
         5lLYlDaiK0VF79m0s+BT2kYwJ3RepZZe9PMNgm0Cc8o3TqLuUZz7zlYxxJpE78n5GkUC
         BkkmVbwVdsduUk9ax/y1RWZ2Lu0dk0zZDF/1Sp4oZSatL2vfgewmEsCuw8egv+yiBUps
         7Lkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7jWD5vHooiaDqnTbtnYwVQHOG6k2FU8e2JhUtfDscDY=;
        b=nfuzfayPnUotJvqZ0nG7TRTgTEd6t0Wd93/KloISOr47Ytj7AcbzSQfXCiDwiyqaWV
         s1yJtANlNMPZTTrHVuO7t0Tta7z2r2knLqh/HsLE09ntDenZCpGTM6S5bizeFdZe5eMv
         60mduDvcYOnED/xII3nZjjkXhWBMLaCL1pXtobUk8oe+nF7nd3WEaPzIlUNqTZoL70jW
         zyHrGxBUa+a8/sDihuJvkxxnz0SQxYLtgIbOVHqQMLlxrOU/uZkYddajZdveEVGyIjDq
         fsL/LCXDQ75WDr85TcPYiMWF6RHrGlzINMu+AMXOOFDcKPztJ31SRWf26QCj7AAlfpMn
         sMlQ==
X-Gm-Message-State: AOAM530E2V7IpNo1/g42cGPWkofQKIYhy3ZJnJDoN5DF0KJWaA2vPb54
        7MOcSiomYYlQ8wGGYVPrnslEbrVq5sqmzu24IyXKTg==
X-Google-Smtp-Source: ABdhPJzB21KJ4LK/FE4YW6ebuBjyCZjP1YIA1Wom+fxwjuhACfVBKSC4uOygcHbB8iMIMSJngmUbQ633jaaJQ+KyCc0=
X-Received: by 2002:a05:651c:550:: with SMTP id q16mr28254147ljp.188.1594074744364;
 Mon, 06 Jul 2020 15:32:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200630044943.3425049-3-rajatja@google.com> <20200706163805.GA120024@bjorn-Precision-5520>
In-Reply-To: <20200706163805.GA120024@bjorn-Precision-5520>
From:   Rajat Jain <rajatja@google.com>
Date:   Mon, 6 Jul 2020 15:31:47 -0700
Message-ID: <CACK8Z6FhWyZOJvkrPcHacyvJucGMupOpL=Jm8BpyO7wPrZ_DQA@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] PCI: Set "untrusted" flag for truly external
 devices only
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Krishnakumar, Lalithambika" <lalithambika.krishnakumar@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Prashant Malani <pmalani@google.com>,
        Benson Leung <bleung@google.com>,
        Todd Broch <tbroch@google.com>,
        Alex Levin <levinale@google.com>,
        Mattias Nissler <mnissler@google.com>,
        Rajat Jain <rajatxjain@gmail.com>,
        Bernie Keany <bernie.keany@intel.com>,
        Aaron Durbin <adurbin@google.com>,
        Diego Rivas <diegorivas@google.com>,
        Duncan Laurie <dlaurie@google.com>,
        Furquan Shaikh <furquan@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Christian Kellner <christian@kellner.me>,
        Alex Williamson <alex.williamson@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Saravana Kannan <saravanak@google.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

On Mon, Jul 6, 2020 at 9:38 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Mon, Jun 29, 2020 at 09:49:38PM -0700, Rajat Jain wrote:
> > The "ExternalFacing" devices (root ports) are still internal devices that
> > sit on the internal system fabric and thus trusted. Currently they were
> > being marked untrusted.
> >
> > This patch uses the platform flag to identify the external facing devices
> > and then use it to mark any downstream devices as "untrusted". The
> > external-facing devices themselves are left as "trusted". This was
> > discussed here: https://lkml.org/lkml/2020/6/10/1049
>
> Use the imperative mood in the commit log, as you did for 1/7.  E.g.,
> instead of "This patch uses ...", say "Use the platform flag ...".
> That helps all the commit logs read nicely together.
>
> I think this patch makes two changes that should be separated:
>
>   - Treat "external-facing" devices as internal.
>
>   - Look for the "external-facing" or "ExternalFacing" property on
>     Switch Downstream Ports as well as Root Ports.
>
> > Signed-off-by: Rajat Jain <rajatja@google.com>
> > ---
> > v2: cosmetic changes in commit log
> >
> >  drivers/iommu/intel/iommu.c |  2 +-
> >  drivers/pci/of.c            |  2 +-
> >  drivers/pci/pci-acpi.c      | 13 +++++++------
> >  drivers/pci/probe.c         |  2 +-
> >  include/linux/pci.h         |  8 ++++++++
> >  5 files changed, 18 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> > index d759e7234e982..1ccb224f82496 100644
> > --- a/drivers/iommu/intel/iommu.c
> > +++ b/drivers/iommu/intel/iommu.c
> > @@ -4743,7 +4743,7 @@ static inline bool has_untrusted_dev(void)
> >       struct pci_dev *pdev = NULL;
> >
> >       for_each_pci_dev(pdev)
> > -             if (pdev->untrusted)
> > +             if (pdev->untrusted || pdev->external_facing)
>
> I think checking pdev->external_facing is enough for this case,
> because it's impossible to have pdev->untrusted unless a parent has
> pdev->external_facing.

Agree.

>
> IIUC, this usage is asking "might we ever have an external device?"
> as opposed to the "pdev->untrusted" uses, which are asking "is *this*
> device an external device?"

Agree.

>
> >                       return true;
> >
> >       return false;
> > diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> > index 27839cd2459f6..22727fc9558df 100644
> > --- a/drivers/pci/of.c
> > +++ b/drivers/pci/of.c
> > @@ -42,7 +42,7 @@ void pci_set_bus_of_node(struct pci_bus *bus)
> >       } else {
> >               node = of_node_get(bus->self->dev.of_node);
> >               if (node && of_property_read_bool(node, "external-facing"))
> > -                     bus->self->untrusted = true;
> > +                     bus->self->external_facing = true;
> >       }
> >
> >       bus->dev.of_node = node;
> > diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> > index 7224b1e5f2a83..492c07805caf8 100644
> > --- a/drivers/pci/pci-acpi.c
> > +++ b/drivers/pci/pci-acpi.c
> > @@ -1213,22 +1213,23 @@ static void pci_acpi_optimize_delay(struct pci_dev *pdev,
> >       ACPI_FREE(obj);
> >  }
> >
> > -static void pci_acpi_set_untrusted(struct pci_dev *dev)
> > +static void pci_acpi_set_external_facing(struct pci_dev *dev)
> >  {
> >       u8 val;
> >
> > -     if (pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT)
> > +     if (pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT &&
> > +         pci_pcie_type(dev) != PCI_EXP_TYPE_DOWNSTREAM)
>
> This looks like a change worthy of its own patch.  We used to look for
> "ExternalFacingPort" only on Root Ports; now we'll also do it for
> Switch Downstream Ports.

Can do. (please see below)

>
> Can you include DT and ACPI spec references if they exist?  I found
> this mention:
> https://docs.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports
> which actually says it should only be implemented for Root Ports.

I actually have no references. It seems to me that the microsoft spec
assumes that all external ports must be implemented on root ports, but
I think it would be equally fair for systems with PCIe switches to
implement one on one of their switch downstream ports. I don't have an
immediate use of this anyway, so if you think this should rather wait
unless someone really has this case, this can wait. Let me know.

>
> It also mentions a "DmaProperty" that looks related.  Maybe Linux
> should also pay attention to this?

Interesting. Since this is not in use currently by the kernel as well
as not exposed by (our) BIOS, I don't have an immediate use case for
this. I'd like to defer this for later (as-the-need-arises).

>
> If we do change this, should we use pcie_downstream_port(), which
> includes PCI-to-PCIe bridges as well?

Sure, can do that.

>
> >               return;
> >       if (device_property_read_u8(&dev->dev, "ExternalFacingPort", &val))
> >               return;
> >
> >       /*
> > -      * These root ports expose PCIe (including DMA) outside of the
> > -      * system so make sure we treat them and everything behind as
> > +      * These root/down ports expose PCIe (including DMA) outside of the
> > +      * system so make sure we treat everything behind them as
> >        * untrusted.
> >        */
> >       if (val)
> > -             dev->untrusted = 1;
> > +             dev->external_facing = 1;
> >  }
> >
> >  static void pci_acpi_setup(struct device *dev)
> > @@ -1240,7 +1241,7 @@ static void pci_acpi_setup(struct device *dev)
> >               return;
> >
> >       pci_acpi_optimize_delay(pci_dev, adev->handle);
> > -     pci_acpi_set_untrusted(pci_dev);
> > +     pci_acpi_set_external_facing(pci_dev);
> >       pci_acpi_add_edr_notifier(pci_dev);
> >
> >       pci_acpi_add_pm_notifier(adev, pci_dev);
> > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > index 6d87066a5ecc5..8c40c00413e74 100644
> > --- a/drivers/pci/probe.c
> > +++ b/drivers/pci/probe.c
> > @@ -1552,7 +1552,7 @@ static void set_pcie_untrusted(struct pci_dev *dev)
> >        * untrusted as well.
> >        */
> >       parent = pci_upstream_bridge(dev);
> > -     if (parent && parent->untrusted)
> > +     if (parent && (parent->untrusted || parent->external_facing))
> >               dev->untrusted = true;
> >  }
> >
> > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > index a26be5332bba6..fe1bc603fda40 100644
> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -432,6 +432,14 @@ struct pci_dev {
> >        * mappings to make sure they cannot access arbitrary memory.
> >        */
> >       unsigned int    untrusted:1;
> > +     /*
> > +      * Devices are marked as external-facing using info from platform
> > +      * (ACPI / devicetree). An external-facing device is still an internal
> > +      * trusted device, but it faces external untrusted devices. Thus any
> > +      * devices enumerated downstream an external-facing device is marked
> > +      * as untrusted.
>
> This comment has a subject/verb agreement problem.

I assume you meant s/is/are/ in last sentence. Will do.

Thanks,

Rajat


>
> > +      */
> > +     unsigned int    external_facing:1;
> >       unsigned int    broken_intx_masking:1;  /* INTx masking can't be used */
> >       unsigned int    io_window_1k:1;         /* Intel bridge 1K I/O windows */
> >       unsigned int    irq_managed:1;
> > --
> > 2.27.0.212.ge8ba1cc988-goog
> >
