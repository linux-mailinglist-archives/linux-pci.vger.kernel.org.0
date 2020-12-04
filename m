Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 623922CF336
	for <lists+linux-pci@lfdr.de>; Fri,  4 Dec 2020 18:41:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731196AbgLDRkU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Dec 2020 12:40:20 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2211 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbgLDRkU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Dec 2020 12:40:20 -0500
Received: from fraeml738-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Cnfzj1Y3sz67F7V;
        Sat,  5 Dec 2020 01:37:37 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml738-chm.china.huawei.com (10.206.15.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 4 Dec 2020 18:39:35 +0100
Received: from localhost (10.47.77.242) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Fri, 4 Dec 2020
 17:39:34 +0000
Date:   Fri, 4 Dec 2020 17:39:12 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Ben Widawsky <ben.widawsky@intel.com>, <linux-cxl@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [RFC PATCH 3/9] cxl/mem: Add a driver for the type-3 mailbox
Message-ID: <20201204173912.00005f7f@Huawei.com>
In-Reply-To: <CAPcyv4j7iiJ7BMTiHKrtccH7K_mzvA67nNEcq8yT6k93bPnqow@mail.gmail.com>
References: <20201111054356.793390-1-ben.widawsky@intel.com>
        <20201111054356.793390-4-ben.widawsky@intel.com>
        <20201117144935.00006dee@Huawei.com>
        <CAPcyv4h1NQ_ctMAUv1Sc37uh6Mqnm-VL_+woKKAATGOuLCC0Uw@mail.gmail.com>
        <CAPcyv4j7iiJ7BMTiHKrtccH7K_mzvA67nNEcq8yT6k93bPnqow@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.77.242]
X-ClientProxiedBy: lhreml741-chm.china.huawei.com (10.201.108.191) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

...

> > > > +MODULE_IMPORT_NS(CXL);
> > > > diff --git a/drivers/cxl/pci.h b/drivers/cxl/pci.h
> > > > new file mode 100644
> > > > index 000000000000..beb03921e6da
> > > > --- /dev/null
> > > > +++ b/drivers/cxl/pci.h
> > > > @@ -0,0 +1,15 @@
> > > > +// SPDX-License-Identifier: GPL-2.0-only
> > > > +// Copyright(c) 2020 Intel Corporation. All rights reserved.
> > > > +#ifndef __CXL_PCI_H__
> > > > +#define __CXL_PCI_H__
> > > > +
> > > > +#define PCI_CLASS_MEMORY_CXL 0x050210
> > > > +
> > > > +#define PCI_EXT_CAP_ID_DVSEC 0x23
> > > > +#define PCI_DVSEC_VENDOR_CXL 0x1E98  
> > >
> > > Hmm. The magic question of what to call a vendor ID that isn't a vendor
> > > ID but just a magic number that talks like a duck and quacks like a duck
> > > (for anyone wondering what I'm talking about, there is a nice bit of legal
> > > boilerplate on this in the CXL spec)
> > >
> > > This name is definitely not accurate however.
> > >
> > > PCI_UNIQUE_VALUE_CXL maybe?  It is used for other things than DVSEC (VDMs etc),
> > > though possibly this is the only software visible use.  
> >
> > Finally working my way back through this review to make the changes.
> > If 0x1E98 becomes visible to software somewhere else then this can
> > become something like the following:
> >
> > #define PCI_DVSEC_VENDOR_CXL PCI_UNIQUE_VALUE_CXL
> >
> > ...or whatever the generic name is, but this field per the
> > specification is the DVSEC-vendor-id and calling it
> > PCI_UNIQUE_VALUE_CXL does not have any basis in the spec.

There is a big statement about it as a footnote to 3.1.2 in CXL 2.0
"The Unique Value that is provided in this specification for use in ...
Designated Vendor Specific Extended Capabilities.."  And for extra
amusement in the "Notice Regarding PCI-SIG Unique Value" that forms
part of the click through
https://www.computeexpresslink.org/download-the-specification
(that's the only use of "PCI-SIG Unique Value" that Google finds
 but I know of one other similar statement)

However, I agree it's being used in DVSEC field only (from software
point of view) so fair enough to name it after where it is used
rather than what it is.

> >
> > I will rename it though to:
> >
> > PCI_DVSEC_VENDOR_ID_CXL
> >
> > ...since include/linux/pci_ids.h includes the _ID_ part.
> >  
> > >
> > >  
> > > > +#define PCI_DVSEC_VENDOR_OFFSET      0x4
> > > > +#define PCI_DVSEC_ID_OFFSET  0x8  
> > >
> > > Put a line break here perhaps and maybe a spec reference to where to find
> > > the various DVSEC IDs.  
> >
> > Ok.
> >  
> > >  
> > > > +#define PCI_DVSEC_ID_CXL     0x0  
> > >
> > > That's definitely a confusing name as well.  
> >
> > Yeah, should be PCI_DVSEC_DEVICE_ID_CXL  
> 
> Actually, no, the spec calls this the "DVSEC id" so PCI_DVSEC_ID_CXL
> seems suitable to me. This is from:
> 
> Table 126. PCI Express DVSEC Register Settings for CXL Device
> 
> In the CXL 2.0 Specification.

The DVSEC ID naming is straight from the PCI spec so that part is fine,
my issue is this is one of a whole bunch of CXL related DVSEC ID so it
needs a more specific name.

PCI_DVSEC_ID_CXL_DEVICE would work in line with table 124.

I'm not that bothered though.

Jonathan


