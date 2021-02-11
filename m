Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8957A3187D1
	for <lists+linux-pci@lfdr.de>; Thu, 11 Feb 2021 11:11:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbhBKKKf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Feb 2021 05:10:35 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2544 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbhBKKIb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Feb 2021 05:08:31 -0500
Received: from fraeml715-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Dbsd6739dz67mrk;
        Thu, 11 Feb 2021 18:02:50 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml715-chm.china.huawei.com (10.206.15.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 11 Feb 2021 11:07:48 +0100
Received: from localhost (10.47.31.44) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2106.2; Thu, 11 Feb
 2021 10:07:47 +0000
Date:   Thu, 11 Feb 2021 10:06:46 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Ben Widawsky <ben.widawsky@intel.com>, <linux-cxl@vger.kernel.org>,
        "Linux ACPI" <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "Chris Browy <cbrowy@avery-design.com>, Christoph Hellwig
        <hch@infradead.org>, Dan Williams <dan.j.williams@intel.com>, David
        Hildenbrand <david@redhat.com>, David Rientjes" <rientjes@google.com>,
        "Jon Masters <jcm@jonmasters.org>, Rafael Wysocki
        <rafael.j.wysocki@intel.com>, Randy Dunlap" <rdunlap@infradead.org>,
        "John Groves (jgroves)" <jgroves@micron.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        "kernel test robot" <lkp@intel.com>,
        Dan Williams <dan.j.willams@intel.com>
Subject: Re: [PATCH v2 4/8] cxl/mem: Add basic IOCTL interface
Message-ID: <20210211100646.00007dcc@Huawei.com>
In-Reply-To: <CAPcyv4hRUB3jxdCV06y0kYMbKbGroEW6F9yOQ4KB_z6YgWBZ4Q@mail.gmail.com>
References: <20210210000259.635748-1-ben.widawsky@intel.com>
        <20210210000259.635748-5-ben.widawsky@intel.com>
        <20210210184540.00007536@Huawei.com>
        <CAPcyv4hRUB3jxdCV06y0kYMbKbGroEW6F9yOQ4KB_z6YgWBZ4Q@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.31.44]
X-ClientProxiedBy: lhreml709-chm.china.huawei.com (10.201.108.58) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 10 Feb 2021 20:40:52 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> On Wed, Feb 10, 2021 at 10:47 AM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> [..]
> > > +#define CXL_CMDS                                                          \
> > > +     ___C(INVALID, "Invalid Command"),                                 \
> > > +     ___C(IDENTIFY, "Identify Command"),                               \
> > > +     ___C(MAX, "Last command")
> > > +
> > > +#define ___C(a, b) CXL_MEM_COMMAND_ID_##a
> > > +enum { CXL_CMDS };
> > > +
> > > +#undef ___C
> > > +#define ___C(a, b) { b }
> > > +static const struct {
> > > +     const char *name;
> > > +} cxl_command_names[] = { CXL_CMDS };
> > > +#undef ___C  
> >
> > Unless there are going to be a lot of these, I'd just write them out long hand
> > as much more readable than the macro magic.  
> 
> This macro magic isn't new to Linux it was introduced with ftrace:
> 
> See "cpp tricks and treats": https://lwn.net/Articles/383362/

Yeah. I've dealt with that one a few times. It's very cleaver and compact
but a PITA to debug build errors related to it.

> 
> >
> > enum {
> >         CXL_MEM_COMMAND_ID_INVALID,
> >         CXL_MEM_COMMAND_ID_IDENTIFY,
> >         CXL_MEM_COMMAND_ID_MAX
> > };
> >
> > static const struct {
> >         const char *name;
> > } cxl_command_names[] = {
> >         [CXL_MEM_COMMAND_ID_INVALID] = { "Invalid Command" },
> >         [CXL_MEM_COMMAND_ID_IDENTIFY] = { "Identify Comamnd" },
> >         /* I hope you never need the Last command to exist in here as that sounds like a bug */
> > };
> >
> > That's assuming I actually figured the macro fun out correctly.
> > To my mind it's worth doing this stuff for 'lots' no so much for 3.  
> 
> The list will continue to expand, and it eliminates the "did you
> remember to update cxl_command_names" review burden permanently.

How about a compromise.  Add a comment giving how the first entry expands to
avoid people (me at least :) having to think their way through it every time?

Jonathan

