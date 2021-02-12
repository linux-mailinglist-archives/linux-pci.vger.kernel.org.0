Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC0B319FF1
	for <lists+linux-pci@lfdr.de>; Fri, 12 Feb 2021 14:38:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbhBLNgI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Feb 2021 08:36:08 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2561 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231424AbhBLNeu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 Feb 2021 08:34:50 -0500
Received: from fraeml711-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DcZB80s6bz67mLJ;
        Fri, 12 Feb 2021 21:30:24 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml711-chm.china.huawei.com (10.206.15.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 12 Feb 2021 14:34:07 +0100
Received: from localhost (10.47.28.230) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 12 Feb
 2021 13:34:06 +0000
Date:   Fri, 12 Feb 2021 13:33:04 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Ben Widawsky <ben.widawsky@intel.com>, <linux-cxl@vger.kernel.org>,
        "Linux ACPI" <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Christoph Hellwig <hch@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jon Masters <jcm@jonmasters.org>,
        "Rafael Wysocki" <rafael.j.wysocki@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "John Groves (jgroves)" <jgroves@micron.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>
Subject: Re: [PATCH v2 3/8] cxl/mem: Register CXL memX devices
Message-ID: <20210212133304.00001f28@Huawei.com>
In-Reply-To: <CAPcyv4hgzv7B7sv85A3No-bAgeADqfrhRySBrQBx43HVEMfnzg@mail.gmail.com>
References: <20210210000259.635748-1-ben.widawsky@intel.com>
        <20210210000259.635748-4-ben.widawsky@intel.com>
        <20210210181725.00007865@Huawei.com>
        <20210211101746.00005e8c@Huawei.com>
        <CAPcyv4hgzv7B7sv85A3No-bAgeADqfrhRySBrQBx43HVEMfnzg@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.28.230]
X-ClientProxiedBy: lhreml721-chm.china.huawei.com (10.201.108.72) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 11 Feb 2021 12:40:45 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> On Thu, Feb 11, 2021 at 2:19 AM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> >
> > On Wed, 10 Feb 2021 18:17:25 +0000
> > Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
> >  
> > > On Tue, 9 Feb 2021 16:02:54 -0800
> > > Ben Widawsky <ben.widawsky@intel.com> wrote:
> > >  
> > > > From: Dan Williams <dan.j.williams@intel.com>
> > > >
> > > > Create the /sys/bus/cxl hierarchy to enumerate:
> > > >
> > > > * Memory Devices (per-endpoint control devices)
> > > >
> > > > * Memory Address Space Devices (platform address ranges with
> > > >   interleaving, performance, and persistence attributes)
> > > >
> > > > * Memory Regions (active provisioned memory from an address space device
> > > >   that is in use as System RAM or delegated to libnvdimm as Persistent
> > > >   Memory regions).
> > > >
> > > > For now, only the per-endpoint control devices are registered on the
> > > > 'cxl' bus. However, going forward it will provide a mechanism to
> > > > coordinate cross-device interleave.
> > > >
> > > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > > > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>  
> > >
> > > One stray header, and a request for a tiny bit of reordering to
> > > make it easier to chase through creation and destruction.
> > >
> > > Either way with the header move to earlier patch I'm fine with this one.
> > >
> > > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>  
> >
> > Actually thinking more on this, what is the justification for the
> > complexity + overhead of a percpu_refcount vs a refcount  
> 
> A typical refcount does not have the block and drain semantics of a
> percpu_ref. I'm planning to circle back and make this a first class
> facility of the cdev interface borrowing the debugfs approach [1], but
> for now percpu_ref fits the bill locally.
> 
> > I don't think this is a high enough performance path for it to matter.
> > Perhaps I'm missing a usecase where it does?  
> 
> It's less about percpu_ref performance and more about the
> percpu_ref_tryget_live() facility.
> 
> [1]: http://lore.kernel.org/r/CAPcyv4jEYPsyh0bhbtKGRbK3bgp=_+=2rjx4X0gLi5-25VvDyg@mail.gmail.com

Thanks for the reference. Definitely a nasty corner to clean up so I'll
keep an eye open for a new version of that series.

Jonathan


