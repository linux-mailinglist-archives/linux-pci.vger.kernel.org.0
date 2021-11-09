Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1963044AC50
	for <lists+linux-pci@lfdr.de>; Tue,  9 Nov 2021 12:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245585AbhKILMq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Nov 2021 06:12:46 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4075 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbhKILMp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 Nov 2021 06:12:45 -0500
Received: from fraeml741-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HpQ9y70xXz67ttp;
        Tue,  9 Nov 2021 19:05:10 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml741-chm.china.huawei.com (10.206.15.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Tue, 9 Nov 2021 12:09:57 +0100
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.15; Tue, 9 Nov
 2021 11:09:56 +0000
Date:   Tue, 9 Nov 2021 11:09:55 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ira Weiny <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <ben.widawsky@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 4/5] cxl/mem: Add CDAT table reading from DOE
Message-ID: <20211109110955.00000f4b@Huawei.com>
In-Reply-To: <20211108222516.GE3538886@iweiny-DESK2.sc.intel.com>
References: <20211105235056.3711389-1-ira.weiny@intel.com>
        <20211105235056.3711389-5-ira.weiny@intel.com>
        <20211108150236.00003a6c@Huawei.com>
        <20211108222516.GE3538886@iweiny-DESK2.sc.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-ClientProxiedBy: lhreml704-chm.china.huawei.com (10.201.108.53) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

...

> > We could break out of the loop early, but I want to bolt the CMA doe detection
> > in there so I'd rather we didn't.  This is all subject to whether we attempt
> > to generalize this support and move it over to the PCI side of things.  
> 
> I'm not 100% sure about moving it to the PCI side but it does make some sense
> because really the auxiliary devices are only bounded by the PCI device being
> available.  None of the CXL stuff needs to exist for the DOE driver to talk to
> the device but the pdev does need to be there...  :-/

This will become more relevant with CMA etc on top of this series as that
is not CXL specific, so definitely shouldn't live in here.

> 
> This is all part of what drove the cxl_mem rename because that structure was
> really confusing me.  Dan got me straightened out but I did not revisit this
> series after that.  Now off the top of my head I'm not sure that cxlds needs to
> be involved in the auxiliary device creation.  OTOH I was making it a central
> place for in kernel users to know where/how to get information from DOE
> mailboxes.  Hence caching which of these devices had CDAT capability.[1]
Caching a particular instance makes sense (with a reference taken).

I'd expect something similar to the divide between
pci_alloc_irq_vectors() which enumerates them in the pci core, and
actually getting for a particular instance with request_irq()

So maybe
pci_alloc_doe_instances() which adds the auxiliary devices to the bus.

and

pci_doe_get(vendor_id, protcol_id);
with the _get() implemented using auxilliary_find_device() with
appropriate match function.


> 
> Since you seem to have arrived at this conclusion before me where in the PCI
> code do you think is appropriate for this?

I'm not sure to be honest.  Given the dependency on MSI/MSIX it may be that the best
we can do is to provide some utility functions for the auxiliary device
creation and then every driver for devices with a DOE would need to call
them manually.  As this isn't dependent on the DOE driver, it would need
to be tied to the PCI core rather than that, possibly stubbed if
PCI_DOE isn't built.

> 
> Ira
> 
> [1] I'm not really sure what is going to happen if multiple DOE boxes have CDAT
> capability.  This seems like a recipe for confusion.

They will all report the same thing so just use the first one.
I can't really think why someone would do this deliberately but I can conceive of
people deciding to support multiple because they have a sneaky firmware running
somewhere and they want to avoid mediating between that and the OS. Mind you
that needs something to indicate to the OS which one it is which is still
an open problem.

Jonathan

> 
> >   
> > >  
> > > +next:
> > >  		pos = pci_find_next_ext_capability(pdev, pos, PCI_EXT_CAP_ID_DOE);
> > >  	}
> > >  
> > >  	return 0;
> > >  }
> > >    

