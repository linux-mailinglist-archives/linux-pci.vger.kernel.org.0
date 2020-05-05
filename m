Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5883C1C62A1
	for <lists+linux-pci@lfdr.de>; Tue,  5 May 2020 23:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbgEEVJQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 May 2020 17:09:16 -0400
Received: from mga01.intel.com ([192.55.52.88]:40999 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726350AbgEEVJP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 May 2020 17:09:15 -0400
IronPort-SDR: l6AVyi6acyij8Bbd/3UDWHcHEFvyAaUbpT+MFH8DrHCjRkjDViEWkESDocEeKFCBWBnmMdNMuO
 fA7rnh4+UDWg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2020 14:09:15 -0700
IronPort-SDR: tR5H6gfso9+YUtdMqdKx1tjSAcYenZZWDu+V7lyzZxdScza+kgvEZaYMjzGNsap61llwsCPMCl
 YcQvDc83Olpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,356,1583222400"; 
   d="scan'208";a="434639700"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga005.jf.intel.com with ESMTP; 05 May 2020 14:09:15 -0700
Received: from debox1-desk1.jf.intel.com (debox1-desk1.jf.intel.com [10.7.201.137])
        by linux.intel.com (Postfix) with ESMTP id 7283F580378;
        Tue,  5 May 2020 14:09:15 -0700 (PDT)
Message-ID: <dabb105d548746f26608c5a19b6b8529cf5529b8.camel@linux.intel.com>
Subject: Re: [PATCH 3/3] platform/x86: Intel PMT Telemetry capability driver
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Andy Shevchenko <andy@infradead.org>,
        alexander.h.duyck@intel.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>
Date:   Tue, 05 May 2020 14:09:15 -0700
In-Reply-To: <CAHp75VdnVg7q-Nr-3cO-NyKzk0ckfauOso3yDM4qUF3ofSK_VQ@mail.gmail.com>
References: <20200505013206.11223-1-david.e.box@linux.intel.com>
         <20200505023149.11630-1-david.e.box@linux.intel.com>
         <20200505023149.11630-2-david.e.box@linux.intel.com>
         <CAHp75VdnVg7q-Nr-3cO-NyKzk0ckfauOso3yDM4qUF3ofSK_VQ@mail.gmail.com>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 2020-05-05 at 16:49 +0300, Andy Shevchenko wrote:
> On Tue, May 5, 2020 at 5:32 AM David E. Box <
> david.e.box@linux.intel.com> wrote:
> 
> ...
> 
> > Register mappings are not provided by the driver. Instead, a GUID
> > is read
> > from a header for each endpoint. The GUID identifies the device and
> > is to
> > be used with an XML, provided by the vendor, to discover the
> > available set
> > of metrics and their register mapping.  This allows firmware
> > updates to
> > modify the register space without needing to update the driver
> > every time
> > with new mappings. Firmware writes a new GUID in this case to
> > specify the
> > new mapping.  Software tools with access to the associated XML file
> > can
> > then interpret the changes.
> 
> Is old hardware going to support this in the future?
> (I have in mind Apollo Lake / Broxton)

I don't know of any plans for this.

> 
> > This module manages access to all PMT Telemetry endpoints on a
> > system,
> > regardless of the device exporting them. It creates an
> > intel_pmt_telem
> 
> Name is not the best we can come up with. Would anyone else use PMT?
> Would it be vendor-agnostic ABI?
> (For example, I know that MIPI standardizes tracing protocols, like
> STM, do we have any plans to standardize this one?)

Not at this time. The technology may be used as a feature on non-Intel
devices, but it is Intel owned. Hence the use of DVSEC which allows
hardware to enumerate and get driver support for IP from other vendors.

> 
> telem -> telemetry.
> 
> > class to manage the list. For each endpoint, sysfs files provide
> > GUID and
> > size information as well as a pointer to the parent device the
> > telemetry
> > comes from. Software may discover the association between endpoints
> > and
> > devices by iterating through the list in sysfs, or by looking for
> > the
> > existence of the class folder under the device of interest.  A
> > device node
> > of the same name allows software to then map the telemetry space
> > for direct
> > access.
> 
> ...
> 
> > +       tristate "Intel PMT telemetry driver"
> 
> I think user should understand what is it from the title (hint: spell
> PMT fully).
> 
> ...
> 
> >  obj-$(CONFIG_PMC_ATOM)                 += pmc_atom.o
> > +obj-$(CONFIG_INTEL_PMT_TELEM)          += intel_pmt_telem.o
> 
> Keep this and Kconfig section in order with the other stuff.
> 
> ...
> 
> bits.h?
> 
> > +#include <linux/cdev.h>
> > +#include <linux/intel-dvsec.h>
> > +#include <linux/io-64-nonatomic-lo-hi.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/pci.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/slab.h>
> > +#include <linux/uaccess.h>
> > +#include <linux/xarray.h>
> 
> ...
> 
> > +/* platform device name to bind to driver */
> > +#define TELEM_DRV_NAME         "pmt_telemetry"
> 
> Shouldn't be part of MFD header?

Can place in the dvsec header shared by MFD and drivers.

> 
> ...
> 
> > +#define TELEM_TBIR_MASK                0x7
> 
> GENMASK() ?
> 
> > +struct pmt_telem_priv {
> > +       struct device                   *dev;
> > +       struct intel_dvsec_header       *dvsec;
> > +       struct telem_header             header;
> > +       unsigned long                   base_addr;
> > +       void __iomem                    *disc_table;
> > +       struct cdev                     cdev;
> > +       dev_t                           devt;
> > +       int                             devid;
> > +};
> 
> ...
> 
> > +       unsigned long phys = priv->base_addr;
> > +       unsigned long pfn = PFN_DOWN(phys);
> > +       unsigned long psize;
> > +
> > +       psize = (PFN_UP(priv->base_addr + priv->header.size) - pfn)
> > * PAGE_SIZE;
> > +       if (vsize > psize) {
> > +               dev_err(priv->dev, "Requested mmap size is too
> > large\n");
> > +               return -EINVAL;
> > +       }
> 
> ...
> 
> 
> > +static ssize_t guid_show(struct device *dev, struct
> > device_attribute *attr,
> > +                        char *buf)
> > +{
> > +       struct pmt_telem_priv *priv = dev_get_drvdata(dev);
> > +
> > +       return sprintf(buf, "0x%x\n", priv->header.guid);
> > +}
> 
> So, it's not a GUID but rather some custom number? Can we actually do
> a real GUID / UUID here?

I wish but this is the name it was called. We should have pushed back
more on this. My concern now in calling the attribute something
different is that it will not align with public documentation.

...

> 
> > +       /* Local access and BARID only for now */
> > +       switch (priv->header.access_type) {
> > +       case TELEM_ACCESS_LOCAL:
> > +               if (priv->header.tbir) {
> > +                       dev_err(&pdev->dev,
> > +                               "Unsupported BAR index %d for
> > access type %d\n",
> > +                               priv->header.tbir, priv-
> > >header.access_type);
> > +                       return -EINVAL;
> > +               }
> > +               fallthrough;
> 
> What's the point?

The next case has the break. That case is only there to validate that
it's not the default which would be an error. Will switch this to break
though to make it explicit.

Ack on everything else. Thanks.

