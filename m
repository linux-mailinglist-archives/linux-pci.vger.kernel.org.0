Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0454A663E
	for <lists+linux-pci@lfdr.de>; Tue,  1 Feb 2022 21:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239207AbiBAUnK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Feb 2022 15:43:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234504AbiBAUnJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Feb 2022 15:43:09 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDCF5C06173B
        for <linux-pci@vger.kernel.org>; Tue,  1 Feb 2022 12:43:08 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id c194so4414563pfb.12
        for <linux-pci@vger.kernel.org>; Tue, 01 Feb 2022 12:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sUKsxKYyLJnPCd9Vkc/OhdjHkHizC6yszc0pr+93Sc0=;
        b=30UQHTdIJokMxKfvRNW2Fki8YvOzYVVVD0CnxEFxVniYj5+EjcLjzKS7zn8TGSz8hl
         crsZ1tnqXsAwwCD5wm0WIJwH6TAiO+HuORX743BshUW1rNcPsupX9fYcRicNE0SGyVwJ
         73EHMQ47CyRvZfptLUmldzMxZ9arZOiMeZp+9fBhSjIxxIly+bhTQZQ+Ge3vWUZ9nZJM
         pR7aCYm1Lsy2lkJTDnOE5JM6N4zgO+dRmQT6tWd6oMrrUBr+lMbLoUE+vnr/Kj3A0OUe
         pmJ11ekT6/UAYodaA4H9JBzD73rjXJYLpPQmdql+x58omZ28dEanT4VKwdRXmlBTuI5f
         hgDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sUKsxKYyLJnPCd9Vkc/OhdjHkHizC6yszc0pr+93Sc0=;
        b=Df1pCTNL1j9TB9NPpSiRNZiYNqbgdfcjlsIP0s01k57cPWun0vaxlIEpFjngRDQ5Mj
         q9W7Pj8DSkg33ZpBLDcMFNUCeD9DcX+oA2Wlnvn0m/wJw1TgO5NxSMqXbimcZAO8XWEN
         Hut9NhGddtLfEwGcL8he/lo7bYdpa9G4m9gfoiecrkJdC4L+bzImj3vAaP7+ss/6mc0G
         8/NK7NR3N/YdwUgbGoCwGYawDDxQdo3G9SR0ZE/3XBN66jtI/RwTa3y+5dEc7iqy5UER
         yk+LIF2FysU7TLjRRgdVv0lYMDFOeQdVf2yZYQwB6WiZPWvoKND5Qs66QsAZtPytOMAP
         hAWQ==
X-Gm-Message-State: AOAM5332nmgkike/9prJc7GwkB7mBlogGItcwukBOSRKWIiX8KX36IUu
        pCmjJ/ndJKip4TI5q8QaC9ZSvxb/6celoHHPJpC8iQ==
X-Google-Smtp-Source: ABdhPJwBmjJIyGuzC32xSu9YTUcf1CBogzKWa6BBuFmso3OR7aE2C94N4t7FtgjQScogP8psVTX58e7dWsx3Ix2hKG0=
X-Received: by 2002:a05:6a00:1508:: with SMTP id q8mr26566918pfu.3.1643748188272;
 Tue, 01 Feb 2022 12:43:08 -0800 (PST)
MIME-Version: 1.0
References: <164298424635.3018233.9356036382052246767.stgit@dwillia2-desk3.amr.corp.intel.com>
 <164322817812.3708001.17146719098062400994.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20220131181118.00002471@Huawei.com>
In-Reply-To: <20220131181118.00002471@Huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 1 Feb 2022 12:43:01 -0800
Message-ID: <CAPcyv4gA+QTS1vD83PjC4AmDtgCm79LDq+H47fPKwh=aN6MfVQ@mail.gmail.com>
Subject: Re: [PATCH v4 24/40] cxl/port: Add a driver for 'struct cxl_port' objects
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 31, 2022 at 10:11 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Wed, 26 Jan 2022 12:16:52 -0800
> Dan Williams <dan.j.williams@intel.com> wrote:
>
> > From: Ben Widawsky <ben.widawsky@intel.com>
> >
> > The need for a CXL port driver and a dedicated cxl_bus_type is driven b=
y
> > a need to simultaneously support 2 independent physical memory decode
> > domains (cache coherent CXL.mem and uncached PCI.mmio) that also
> > intersect at a single PCIe device node. A CXL Port is a device that
> > advertises a  CXL Component Register block with an "HDM Decoder
> > Capability Structure".
> >
> > >From Documentation/driver-api/cxl/memory-devices.rst:
> >
> >     Similar to how a RAID driver takes disk objects and assembles them =
into
> >     a new logical device, the CXL subsystem is tasked to take PCIe and =
ACPI
> >     objects and assemble them into a CXL.mem decode topology. The need =
for
> >     runtime configuration of the CXL.mem topology is also similar to RA=
ID in
> >     that different environments with the same hardware configuration ma=
y
> >     decide to assemble the topology in contrasting ways. One may choose
> >     performance (RAID0) striping memory across multiple Host Bridges an=
d
> >     endpoints while another may opt for fault tolerance and disable any
> >     striping in the CXL.mem topology.
> >
> > The port driver identifies whether an endpoint Memory Expander is
> > connected to a CXL topology. If an active (bound to the 'cxl_port'
> > driver) CXL Port is not found at every PCIe Switch Upstream port and an
> > active "root" CXL Port then the device is just a plain PCIe endpoint
> > only capable of participating in PCI.mmio and DMA cycles, not CXL.mem
> > coherent interleave sets.
> >
> > The 'cxl_port' driver lets the CXL subsystem leverage driver-core
> > infrastructure for setup and teardown of register resources and
> > communicating device activation status to userspace. The cxl_bus_type
> > can rendezvous the async arrival of platform level CXL resources (via
> > the 'cxl_acpi' driver) with the asynchronous enumeration of Memory
> > Expander endpoints, while also implementing a hierarchical locking mode=
l
> > independent of the associated 'struct pci_dev' locking model. The
> > locking for dport and decoder enumeration is now handled in the core
> > rather than callers.
> >
> > For now the port driver only enumerates and registers CXL resources
> > (downstream port metadata and decoder resources) later it will be used
> > to take action on its decoders in response to CXL.mem region
> > provisioning requests.
>
> >
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > [djbw: add theory of operation document, move enumeration infra to core=
]
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>
> Nice docs. A few comments inline
>
> All trivial though, so
>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
>
>
> ...
>
> > diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> > index 2b09d04d3568..682e7cdbcc9c 100644
> > --- a/drivers/cxl/core/port.c
> > +++ b/drivers/cxl/core/port.c
> > @@ -40,6 +40,11 @@ static int cxl_device_id(struct device *dev)
>
> ...
>
> >
> > +/*
> > + * Since root-level CXL dports cannot be enumerated by PCI they are no=
t
> > + * enumerated by the common port driver that acquires the port lock ov=
er
> > + * dport add/remove. Instead, root dports are manually added by a
> > + * platform driver and cond_port_lock() is used to take the missing po=
rt
> > + * lock in that case.
> > + */
> > +static void cond_port_lock(struct cxl_port *port)
>
> Could the naming here make it clear what the condition is?
> cxl_port_lock_if_root(), or something like that?

Sure, how about cond_cxl_root_lock()? Where the cond_ prefix is
matching other helpers like cond_resched().

>
> > +{
> > +     if (is_cxl_root(port))
> > +             cxl_device_lock(&port->dev);
> > +}
> > +
> > +static void cond_port_unlock(struct cxl_port *port)
> > +{
> > +     if (is_cxl_root(port))
> > +             cxl_device_unlock(&port->dev);
> > +}
> > +
> >  static void cxl_dport_remove(void *data)
> >  {
> >       struct cxl_dport *dport =3D data;
> >       struct cxl_port *port =3D dport->port;
> >
> > -     cxl_device_lock(&port->dev);
> > +     cond_port_lock(port);
> >       list_del_init(&dport->list);
> > -     cxl_device_unlock(&port->dev);
> > +     cond_port_unlock(port);
> >       put_device(dport->dport);
> >  }
> >
> > @@ -588,7 +615,9 @@ struct cxl_dport *devm_cxl_add_dport(struct device =
*host, struct cxl_port *port,
> >       dport->component_reg_phys =3D component_reg_phys;
> >       dport->port =3D port;
> >
> > +     cond_port_lock(port);
> >       rc =3D add_dport(port, dport);
> > +     cond_port_unlock(port);
> >       if (rc)
> >               return ERR_PTR(rc);
> >
> > @@ -887,6 +916,7 @@ static int cxl_bus_probe(struct device *dev)
> >       rc =3D to_cxl_drv(dev->driver)->probe(dev);
> >       cxl_nested_unlock(dev);
> >
> > +     dev_dbg(dev, "probe: %d\n", rc);
>
> This feels a little bit odd to see in this patch.
> I'd be tempted to drop it.

Ok.

>
>
> >       return rc;
> >  }
> >
>
> >
> >  #define MODULE_ALIAS_CXL(type) MODULE_ALIAS("cxl:t" __stringify(type) =
"*")
> >  #define CXL_MODALIAS_FMT "cxl:t%d"
> > diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> > index 103636fda198..47640f19e899 100644
> > --- a/drivers/cxl/cxlpci.h
> > +++ b/drivers/cxl/cxlpci.h
> > @@ -2,6 +2,7 @@
> >  /* Copyright(c) 2020 Intel Corporation. All rights reserved. */
> >  #ifndef __CXL_PCI_H__
> >  #define __CXL_PCI_H__
> > +#include <linux/pci.h>
>
> Why in this patch?

Oh, I'll mention this in the changelog. Up until now all the users of
cxlpci.h also included linux/pci.h on their own, but port.c did not
leading to:

drivers/cxl/cxlpci.h: In function =E2=80=98cxl_regmap_to_base=E2=80=99:
drivers/cxl/cxlpci.h:57:16: error: implicit declaration of function
=E2=80=98pci_resource_start=E2=80=99;

...since cxlpci.h ships the dependency it should also carry the include.

>
> >  #include "cxl.h"
> >
> >  #define CXL_MEMORY_PROGIF    0x10
>
>
> > diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
> > index 3045d7cba0db..3e2a529875ea 100644
> > --- a/tools/testing/cxl/Kbuild
> > +++ b/tools/testing/cxl/Kbuild
> > @@ -26,6 +26,12 @@ obj-m +=3D cxl_pmem.o
> >  cxl_pmem-y :=3D $(CXL_SRC)/pmem.o
> >  cxl_pmem-y +=3D config_check.o
> >
> > +obj-m +=3D cxl_port.o
> > +
> > +cxl_port-y :=3D $(CXL_SRC)/port.o
> > +cxl_port-y +=3D config_check.o
> > +
>
> trivial but one blank line seems like enough.

Sure.

>
> > +
> >  obj-m +=3D cxl_core.o
> >
> >  cxl_core-y :=3D $(CXL_CORE_SRC)/port.o
>
>
