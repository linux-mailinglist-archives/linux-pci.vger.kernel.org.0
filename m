Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7602BAEC3
	for <lists+linux-pci@lfdr.de>; Fri, 20 Nov 2020 16:24:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729602AbgKTPUj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Nov 2020 10:20:39 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2137 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728618AbgKTPUj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 Nov 2020 10:20:39 -0500
Received: from fraeml742-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Cd0Yl512Gz67D59;
        Fri, 20 Nov 2020 23:18:35 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml742-chm.china.huawei.com (10.206.15.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Fri, 20 Nov 2020 16:20:31 +0100
Received: from localhost (10.47.69.87) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1913.5; Fri, 20 Nov
 2020 15:20:30 +0000
Date:   Fri, 20 Nov 2020 15:20:18 +0000
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
Subject: Re: [RFC PATCH 8/9] cxl/mem: Register CXL memX devices
Message-ID: <20201120152018.00006121@Huawei.com>
In-Reply-To: <CAPcyv4ifDfzN=NTNZTh+xU_-b5Rm4jNOLiakQv-DPQa+6hfRaQ@mail.gmail.com>
References: <20201111054356.793390-1-ben.widawsky@intel.com>
        <20201111054356.793390-9-ben.widawsky@intel.com>
        <20201117155651.0000368b@Huawei.com>
        <CAPcyv4ifDfzN=NTNZTh+xU_-b5Rm4jNOLiakQv-DPQa+6hfRaQ@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.69.87]
X-ClientProxiedBy: lhreml705-chm.china.huawei.com (10.201.108.54) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 19 Nov 2020 18:16:19 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> On Tue, Nov 17, 2020 at 7:57 AM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> >
> > On Tue, 10 Nov 2020 21:43:55 -0800
> > Ben Widawsky <ben.widawsky@intel.com> wrote:
> >  
> > > From: Dan Williams <dan.j.williams@intel.com>
> > >
> > > Create the /sys/bus/cxl hierarchy to enumerate memory devices
> > > (per-endpoint control devices), memory address space devices (platform
> > > address ranges with interleaving, performance, and persistence
> > > attributes), and memory regions (active provisioned memory from an
> > > address space device that is in use as System RAM or delegated to
> > > libnvdimm as Persistent Memory regions).
> > >
> > > For now, only the per-endpoint control devices are registered on the
> > > 'cxl' bus.  
> >
> > Reviewing ABI without documentation is challenging even when it's simple
> > so please add that for v2.
> >
> > This patch feels somewhat unpolished, but I guess it is mainly here to
> > give an illustration of how stuff might fit together rather than
> > any expectation of detailed review.  
> 
> Yeah, this is definitely an early look in the spirit of "Release early
> / release often".
> 

Definitely a good idea.


...

> >  
> > >  static int cxl_mem_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> > >  {
> > >       struct cxl_mem *cxlm = ERR_PTR(-ENXIO);
> > >       struct device *dev = &pdev->dev;
> > > +     struct cxl_memdev *cxlmd;
> > >       int rc, regloc, i;
> > >
> > >       rc = cxl_bus_prepared(pdev);
> > > @@ -319,20 +545,31 @@ static int cxl_mem_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> > >       if (rc)
> > >               return rc;
> > >
> > > -     /* Check that hardware "looks" okay. */
> > > -     rc = cxl_mem_mbox_get(cxlm);
> > > +     rc = cxl_mem_identify(cxlm);
> > >       if (rc)
> > >               return rc;
> > > -
> > > -     cxl_mem_mbox_put(cxlm);  
> >
> > It was kind of nice to see the flow earlier, but I'm also thinking it made
> > a slightly harder to read patch.  Hmm.  Maybe just drop the version earlier
> > in favour of a todo comment that you then do here?  
> 
> Not sure I follow, but I think you're saying don't bother with an
> initial patch introducing just doing the raw cxl_mem_mbox_get() in
> this path, jump straight to cxl_mem_identify()?

Exactly.

> 
> >  
> > >       dev_dbg(&pdev->dev, "CXL Memory Device Interface Up\n");
> > > +  
> >
> > Nice to tidy that up by moving to earlier patch.  
> 
> Sure.
> 
> >  
> > >       pci_set_drvdata(pdev, cxlm);
> > >
> > > +     cxlmd = cxl_mem_add_memdev(cxlm);
> > > +     if (IS_ERR(cxlmd))
> > > +             return PTR_ERR(cxlmd);  
> >
> > Given we don't actually use cxlmd perhaps a simple return value
> > of 0 or error would be better from cxl_mem_add_memdev()
> >
> > (I guess you may have follow up patches that do something with it
> >  here, though it feels wrong to ever do so given it is now registered
> >  and hence exposed to the system).  
> 
> It's not added if IS_ERR() is true, but it would be simpler to just
> have cxl_mem_add_memdev() return an int since ->probe() doesn't use
> it.

Agreed.

> 
> >  
> > > +
> > >       return 0;
> > >  }
> > >

...



