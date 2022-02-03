Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 601AC4A8B29
	for <lists+linux-pci@lfdr.de>; Thu,  3 Feb 2022 19:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233598AbiBCSFk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Feb 2022 13:05:40 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4669 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353197AbiBCSFj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Feb 2022 13:05:39 -0500
Received: from fraeml741-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JqRLx4Bnzz67lMW;
        Fri,  4 Feb 2022 02:01:45 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml741-chm.china.huawei.com (10.206.15.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 3 Feb 2022 19:05:36 +0100
Received: from localhost (10.47.78.15) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Thu, 3 Feb
 2022 18:05:36 +0000
Date:   Thu, 3 Feb 2022 18:05:32 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>,
        "Linux NVDIMM" <nvdimm@lists.linux.dev>
Subject: Re: [PATCH v3 31/40] cxl/memdev: Add numa_node attribute
Message-ID: <20220203180532.00007083@Huawei.com>
In-Reply-To: <CAPcyv4gJozea7aDg+KyKdwEbSO5PV-rUUGC5u-6NNTHA755etA@mail.gmail.com>
References: <164298411792.3018233.7493009997525360044.stgit@dwillia2-desk3.amr.corp.intel.com>
        <164298428430.3018233.16409089892707993289.stgit@dwillia2-desk3.amr.corp.intel.com>
        <20220131184126.00002a47@Huawei.com>
        <CAPcyv4iYpj7MH4kKMP57ouHb85GffEmhXPupq5i1mwJwzFXr0w@mail.gmail.com>
        <20220202094437.00003c03@Huawei.com>
        <CAPcyv4hwdMetDJ-+yL9-2rY92g2C4wWPqpRiQULaX_M6ZQPMtA@mail.gmail.com>
        <20220203094123.000049e6@Huawei.com>
        <CAPcyv4gJozea7aDg+KyKdwEbSO5PV-rUUGC5u-6NNTHA755etA@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.78.15]
X-ClientProxiedBy: lhreml731-chm.china.huawei.com (10.201.108.82) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 3 Feb 2022 08:59:44 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> On Thu, Feb 3, 2022 at 1:41 AM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> >
> > On Wed, 2 Feb 2022 07:44:37 -0800
> > Dan Williams <dan.j.williams@intel.com> wrote:
> >  
> > > On Wed, Feb 2, 2022 at 1:45 AM Jonathan Cameron
> > > <Jonathan.Cameron@huawei.com> wrote:  
> > > >
> > > > On Tue, 1 Feb 2022 15:57:10 -0800
> > > > Dan Williams <dan.j.williams@intel.com> wrote:
> > > >  
> > > > > On Mon, Jan 31, 2022 at 10:41 AM Jonathan Cameron
> > > > > <Jonathan.Cameron@huawei.com> wrote:  
> > > > > >
> > > > > > On Sun, 23 Jan 2022 16:31:24 -0800
> > > > > > Dan Williams <dan.j.williams@intel.com> wrote:
> > > > > >  
> > > > > > > While CXL memory targets will have their own memory target node,
> > > > > > > individual memory devices may be affinitized like other PCI devices.
> > > > > > > Emit that attribute for memdevs.
> > > > > > >
> > > > > > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>  
> > > > > >
> > > > > > Hmm. Is this just duplicating what we can get from
> > > > > > the PCI device?  It feels a bit like overkill to have it here
> > > > > > as well.  
> > > > >
> > > > > Not all cxl_memdevs are associated with PCI devices.  
> > > >
> > > > Platform devices have numa nodes too...  
> > >
> > > So what's the harm in having a numa_node attribute local to the memdev?
> > >  
> >
> > I'm not really against, it just wanted to raise the question of
> > whether we want these to go further than the granularity at which
> > numa nodes can be assigned.  
> 
> What is the "granularity at which numa nodes can be assigned"? It
> sounds like you are referencing a standard / document, so maybe I
> missed something. Certainly Proximity Domains != Linux NUMA nodes so
> it's not ACPI.

Sure, it's the fusion of a number of possible sources, one of which
is ACPI. If there is a reason why it differs to the parent device
(which can be ACPI, or can just be from a bunch of other places which
I'm sure will keep growing) then it definitely makes sense to expose
it at that level. 

> 
> >  Right now that at platform_device or
> > PCI EP (from ACPI anyway).  Sure the value might come from higher
> > up a hierarchy but at least in theory it can be assigned to
> > individual devices.
> >
> > This is pushing that description beyond that point so is worth discussing.  
> 
> To me, any device that presents a driver interface can declare its CPU
> affinity with a numa_node leaf attribute. Once you start walking the
> device tree to infer the node from parent information you also need to
> be worried about whether the Linux device topology follows the NUMA
> topology. The leaf attribute removes that ambiguity.
I'll go with 'maybe'...

Either way I'm fine with this change, just wanted to bring attention to
the duplication as it wasn't totally clear to me it was a good idea.

FWIW

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


