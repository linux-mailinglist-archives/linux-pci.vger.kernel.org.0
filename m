Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58E8F2B2A50
	for <lists+linux-pci@lfdr.de>; Sat, 14 Nov 2020 02:09:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726274AbgKNBJP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Nov 2020 20:09:15 -0500
Received: from mga09.intel.com ([134.134.136.24]:51301 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725885AbgKNBJO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 13 Nov 2020 20:09:14 -0500
IronPort-SDR: dPdpeaQmBAjWZm6VQoIS4yCm6zwGv9EG04jrNiDFzBsVJ3n0E1CjY6nhYIrBRL6e//lv0E9NM/
 x1YuRRmFMm+g==
X-IronPort-AV: E=McAfee;i="6000,8403,9804"; a="170723091"
X-IronPort-AV: E=Sophos;i="5.77,477,1596524400"; 
   d="scan'208";a="170723091"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2020 17:09:02 -0800
IronPort-SDR: r1mx2/qmH5gvoerYkjFGHVlbSgT48RaERWVlxtn0qkjErekeidB9KkYsxsbrfdpd/1KAqpcJf6
 erBGdGX4lQrg==
X-IronPort-AV: E=Sophos;i="5.77,477,1596524400"; 
   d="scan'208";a="309779975"
Received: from lborges-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.130.38])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2020 17:08:59 -0800
Date:   Fri, 13 Nov 2020 17:08:57 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [RFC PATCH 3/9] cxl/mem: Add a driver for the type-3 mailbox
Message-ID: <20201114010857.t77h4h3ff7ythnml@intel.com>
References: <20201111054356.793390-4-ben.widawsky@intel.com>
 <20201113181728.GA1119310@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113181728.GA1119310@bjorn-Precision-5520>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 20-11-13 12:17:28, Bjorn Helgaas wrote:
> On Tue, Nov 10, 2020 at 09:43:50PM -0800, Ben Widawsky wrote:
> > From: Dan Williams <dan.j.williams@intel.com>
> > 
> > The CXL.mem protocol allows a device to act as a provider of "System
> > RAM" and/or "Persistent Memory" that is fully coherent as if the memory
> > was attached to the typical CPU memory controller.
> > 
> > The memory range exported by the device may optionally be described by
> > the platform firmware memory map, or by infrastructure like LIBNVDIMM to
> > provision persistent memory capacity from one, or more, CXL.mem devices.
> > 
> > A pre-requisite for Linux-managed memory-capacity provisioning is this
> > cxl_mem driver that can speak the "type-3 mailbox" protocol.
> 
> "Type 3" to indicate that this is a proper adjective that can be
> looked up in the spec and to match the usage there.
> 
> The r1.1 spec I have doesn't mention "mailbox".  Is that also
> something defined in the 2.0 spec?

Yes, these device types are new to 2.0.

> 
> A URL or similar citation for the spec would be nice somewhere.
> 

Agreed. For the patches I authored at least, it seemed repetitive to put a Link:
in each one to the spec. It was meant to be in the cover letter, but obviously I
missed that. Do you have a suggestion there, is cover letter good enough?

> > For now just land the driver boiler-plate and fill it in with
> > functionality in subsequent commits.
> > 
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > ---
> >  drivers/cxl/Kconfig  | 20 +++++++++++
> >  drivers/cxl/Makefile |  2 ++
> >  drivers/cxl/mem.c    | 82 ++++++++++++++++++++++++++++++++++++++++++++
> >  drivers/cxl/pci.h    | 15 ++++++++
> >  4 files changed, 119 insertions(+)
> >  create mode 100644 drivers/cxl/mem.c
> >  create mode 100644 drivers/cxl/pci.h
> > 
> > diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> > index dd724bd364df..15548f5c77ff 100644
> > --- a/drivers/cxl/Kconfig
> > +++ b/drivers/cxl/Kconfig
> > @@ -27,4 +27,24 @@ config CXL_ACPI
> >  	  resources described by the CEDT (CXL Early Discovery Table)
> >  
> >  	  Say 'y' to enable CXL (Compute Express Link) drivers.
> > +
> > +config CXL_MEM
> > +        tristate "CXL.mem Device Support"
> > +        depends on PCI && CXL_BUS_PROVIDER != n
> > +        default m if CXL_BUS_PROVIDER
> > +        help
> > +          The CXL.mem protocol allows a device to act as a provider of
> > +          "System RAM" and/or "Persistent Memory" that is fully coherent
> > +          as if the memory was attached to the typical CPU memory
> > +          controller.
> > +
> > +          Say 'y/m' to enable a driver named "cxl_mem.ko" that will attach
> > +          to CXL.mem devices for configuration, provisioning, and health
> > +          monitoring, the so called "type-3 mailbox". Note, this driver
> 
> "Type 3"
> 
> > +          is required for dynamic provisioning of CXL.mem attached
> > +          memory, a pre-requisite for persistent memory support, but
> > +          devices that provide volatile memory may be fully described by
> > +          existing platform firmware memory enumeration.
> > +
> > +          If unsure say 'n'.
> >  endif
> > diff --git a/drivers/cxl/Makefile b/drivers/cxl/Makefile
> > index d38cd34a2582..97fdffb00f2d 100644
> > --- a/drivers/cxl/Makefile
> > +++ b/drivers/cxl/Makefile
> > @@ -1,5 +1,7 @@
> >  # SPDX-License-Identifier: GPL-2.0
> >  obj-$(CONFIG_CXL_ACPI) += cxl_acpi.o
> > +obj-$(CONFIG_CXL_MEM) += cxl_mem.o
> >  
> >  ccflags-y += -DDEFAULT_SYMBOL_NAMESPACE=CXL
> >  cxl_acpi-y := acpi.o
> > +cxl_mem-y := mem.o
> > diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> > new file mode 100644
> > index 000000000000..aa7d881fa47b
> > --- /dev/null
> > +++ b/drivers/cxl/mem.c
> > @@ -0,0 +1,82 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +// Copyright(c) 2020 Intel Corporation. All rights reserved.
> > +#include <linux/module.h>
> > +#include <linux/pci.h>
> > +#include <linux/io.h>
> > +#include "acpi.h"
> > +#include "pci.h"
> > +
> > +struct cxl_mem {
> > +	void __iomem *regs;
> > +};
> 
> Unused, maybe move it to the patch that adds the use?
> 

This is a remnant from when Dan gave me the basis to do the mmio work. I agree
it can be removed now.

> > +static int cxl_mem_dvsec(struct pci_dev *pdev, int dvsec)
> > +{
> > +	int pos;
> > +
> > +	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_DVSEC);
> > +	if (!pos)
> > +		return 0;
> > +
> > +	while (pos) {
> > +		u16 vendor, id;
> > +
> > +		pci_read_config_word(pdev, pos + PCI_DVSEC_VENDOR_OFFSET, &vendor);
> > +		pci_read_config_word(pdev, pos + PCI_DVSEC_ID_OFFSET, &id);
> > +		if (vendor == PCI_DVSEC_VENDOR_CXL && dvsec == id)
> > +			return pos;
> > +
> > +		pos = pci_find_next_ext_capability(pdev, pos, PCI_EXT_CAP_ID_DVSEC);
> > +	}
> > +
> > +	return 0;
> > +}
> 
> I assume we'll refactor and move this into the PCI core after we
> resolve the several places this is needed.  When we do that, the
> vendor would be passed in, so maybe we should do that here to make it
> simpler to move this to the PCI core.
> 

I think we'll need to keep this in order to try to keep the dream alive of
loading a CXL kernel module on an older kernel. However, PCI code would benefit
from having it (in an ideal world, it'd only be there).

> > +static int cxl_mem_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> > +{
> > +	struct device *dev = &pdev->dev;
> > +	struct cxl_mem *cxlm;
> > +	int rc, regloc;
> > +
> > +	rc = cxl_bus_prepared(pdev);
> > +	if (rc != 0) {
> > +		dev_err(dev, "failed to acquire interface\n");
> 
> Interesting naming: apparently when cxl_bus_prepared() returns a
> non-zero ("true") value, it is actually *not* prepared?
> 

This looks like a rebase fail to me, but I'll let Dan answer.

> > +		return rc;
> > +	}
> > +
> > +	regloc = cxl_mem_dvsec(pdev, PCI_DVSEC_ID_CXL_REGLOC);
> > +	if (!regloc) {
> > +		dev_err(dev, "register location dvsec not found\n");
> > +		return -ENXIO;
> > +	}
> > +
> > +	cxlm = devm_kzalloc(dev, sizeof(*cxlm), GFP_KERNEL);
> > +	if (!cxlm)
> > +		return -ENOMEM;
> 
> Unused.  And [4/9] removes it before it's *ever* used :)
> 

Same as a few above, I think Dan was providing this for me to implement the
reset. It could go away...

> > +	return 0;
> > +}
> > +
> > +static void cxl_mem_remove(struct pci_dev *pdev)
> > +{
> > +}
> > +
> > +static const struct pci_device_id cxl_mem_pci_tbl[] = {
> > +	/* PCI class code for CXL.mem Type-3 Devices */
> > +	{ PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
> > +	  PCI_CLASS_MEMORY_CXL, 0xffffff, 0 },
> > +	{ /* terminate list */ },
> > +};
> > +MODULE_DEVICE_TABLE(pci, cxl_mem_pci_tbl);
> > +
> > +static struct pci_driver cxl_mem_driver = {
> > +	.name			= KBUILD_MODNAME,
> > +	.id_table		= cxl_mem_pci_tbl,
> > +	.probe			= cxl_mem_probe,
> > +	.remove			= cxl_mem_remove,
> > +};
> > +
> > +MODULE_LICENSE("GPL v2");
> > +MODULE_AUTHOR("Intel Corporation");
> > +module_pci_driver(cxl_mem_driver);
> > +MODULE_IMPORT_NS(CXL);
> > diff --git a/drivers/cxl/pci.h b/drivers/cxl/pci.h
> > new file mode 100644
> > index 000000000000..beb03921e6da
> > --- /dev/null
> 
> > +++ b/drivers/cxl/pci.h
> > @@ -0,0 +1,15 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +// Copyright(c) 2020 Intel Corporation. All rights reserved.
> 
> /* SPDX-... */
> /* Copyright ...*/
> 
> The SPDX rules are a bit arcane and annoyingly hard to grep for, but
> I found them in Documentation/process/license-rules.rst
> 
> > +#ifndef __CXL_PCI_H__
> > +#define __CXL_PCI_H__
> > +
> > +#define PCI_CLASS_MEMORY_CXL	0x050210
> > +
> > +#define PCI_EXT_CAP_ID_DVSEC	0x23
> > +#define PCI_DVSEC_VENDOR_CXL	0x1E98
> > +#define PCI_DVSEC_VENDOR_OFFSET	0x4
> > +#define PCI_DVSEC_ID_OFFSET	0x8
> > +#define PCI_DVSEC_ID_CXL	0x0
> > +#define PCI_DVSEC_ID_CXL_REGLOC	0x8
> 
> I assume these will go in include/linux/pci_ids.h (PCI_CLASS_...) and
> include/uapi/linux/pci_regs.h (the rest) eventually, after we get the
> merge issues sorted out.  But if they're only used in cxl/mem.c, I'd
> put them there for now.
> 
> > +#endif /* __CXL_PCI_H__ */
> > -- 
> > 2.29.2
> > 
