Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0F9E33D1E6
	for <lists+linux-pci@lfdr.de>; Tue, 16 Mar 2021 11:40:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236703AbhCPKjb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Mar 2021 06:39:31 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2701 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236699AbhCPKjF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Mar 2021 06:39:05 -0400
Received: from fraeml742-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4F08lH3NJKz680gf;
        Tue, 16 Mar 2021 18:33:31 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml742-chm.china.huawei.com (10.206.15.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 16 Mar 2021 11:38:04 +0100
Received: from localhost (10.47.94.123) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Tue, 16 Mar
 2021 10:38:03 +0000
Date:   Tue, 16 Mar 2021 10:36:47 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>,
        "Ben Widawsky" <ben.widawsky@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "Chris Browy" <cbrowy@avery-design.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>,
        Linuxarm <linuxarm@huawei.com>, Fangjian <f.fangjian@huawei.com>
Subject: Re: [RFC PATCH 2/2] cxl/mem: Add CDAT table reading from DOE
Message-ID: <20210316103647.00002f4b@Huawei.com>
In-Reply-To: <CAPcyv4jq-KovQcEqesA=kCdzdDNtQ9y8g2aBCSXqQv7cvmABtg@mail.gmail.com>
References: <20210310180306.1588376-1-Jonathan.Cameron@huawei.com>
        <20210310180306.1588376-3-Jonathan.Cameron@huawei.com>
        <20210310181459.000005c7@huawei.com>
        <CAPcyv4jq-KovQcEqesA=kCdzdDNtQ9y8g2aBCSXqQv7cvmABtg@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.94.123]
X-ClientProxiedBy: lhreml733-chm.china.huawei.com (10.201.108.84) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 15 Mar 2021 15:00:08 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> On Wed, Mar 10, 2021 at 10:15 AM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> >
> > On Thu, 11 Mar 2021 02:03:06 +0800
> > Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> >  
> > > This patch simply provides some debug print outs of the entries
> > > at probe time + a sysfs binary attribute to allow dumping of the
> > > whole table.
> > >
> > > Binary dumping is modelled on /sys/firmware/ACPI/tables/
> > >
> > > The ability to dump this table will be very useful for emulation of
> > > real devices once they become available as QEMU CXL type 3 device
> > > emulation will be able to load this file in.
> > >
> > > Open questions:
> > > * No support here for table updates. Worth including these from the
> > >   start, or leave that complexity for later?
> > > * Worth logging the reported info for debug, or is the binary attribute
> > >   sufficient?  Larger open question of whether to expose this info to
> > >   userspace or not left for another day!
> > > * Where to put the CDAT file?  Is it worth a subdirectory?
> > > * What is maximum size of the SSLBIS entry - I haven't quite managed
> > >   to figure that out and this is the record with largest size.
> > >   We could support dynamic allocation of the record size, but it
> > >   would add complexity that seems unnecessary.
> > >   It would not be compliant with the specification for a type 3 memory
> > >   device to report this record anyway so I'm not that worried about this
> > >   for now.  It will become relevant once we have support for reading
> > >   CDAT from CXL switches.
> > > * cdat.h is formatted in a similar style to pci_regs.h on basis that
> > >   it may well be helpful to share this header with userspace tools.
> > > * Move the generic parts of this out to driver/cxl/cdat.c or leave that
> > >   until we have other CXL drivers wishing to use this?  
> >
> > Naturally I remembered another open question within 10 seconds of sending :(
> >
> >   * Do we want to add any sort of header to the RAW dump of CDAT to aid
> >     tooling?  Whilst it looks a little like an ACPI table it doesn't have
> >     a signature.
> >
> > My gut feeling is no, because the CDAT specification doesn't define one but
> > I can see that it might be very convenient to have something that identified
> > the data once it was put in a file.  
> 
> I'm not yet convinced raw dumping is worth it for the same reason that
> command payload logging was eliminated from the v5.12-rc1 submission.
> There's not much userspace can do with the information besides debug
> the kernel behavior. If the kernel assigns a numa node to target a
> given CXL memory range with NUMA apis then HMEM_REPORTING should
> enumerate the properties. In other words, don't expand the userspace
> ABI problem, funnel users to the canonical source for such data.

As someone who finds raw dumping of ACPI tables extremely helpful in every
day use for debugging of some of our 'interesting' hardware, I know I'm going
to end up carrying that element locally anyway.  I don't have a particular
problem doing so if we decide to not to upstream it.

Much like the ACPI table dumping, it's not an interface you expect userspace
to ever use and I fully agree that we should expose things properly as you
describe.

Short term my interest here is to get the DOE code upstream as step 1 of
moving to a full solution.  The printing and dumping is really just PoC element
to prove out the interface.  Any issue with putting the prints under _dbg()?

Jonathan


