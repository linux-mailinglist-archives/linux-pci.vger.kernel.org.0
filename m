Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C74EB2F3E6B
	for <lists+linux-pci@lfdr.de>; Wed, 13 Jan 2021 01:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394307AbhALWHv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Jan 2021 17:07:51 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2331 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390994AbhALWHu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Jan 2021 17:07:50 -0500
Received: from fraeml712-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DFl3G271fz67Y2y;
        Wed, 13 Jan 2021 06:04:10 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml712-chm.china.huawei.com (10.206.15.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 12 Jan 2021 23:07:07 +0100
Received: from localhost (10.47.64.210) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Tue, 12 Jan
 2021 22:07:06 +0000
Date:   Tue, 12 Jan 2021 22:06:28 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Ben Widawsky <ben.widawsky@intel.com>, <linux-cxl@vger.kernel.org>,
        "Vishal Verma" <vishal.l.verma@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "linux-acpi@vger.kernel.org, Ira Weiny" <ira.weiny@intel.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Jon Masters <jcm@jonmasters.org>,
        "Chris Browy" <cbrowy@avery-design.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        <daniel.lll@alibaba-inc.com>,
        "Moore, Robert" <robert.moore@intel.com>,
        "Kaneda, Erik" <erik.kaneda@intel.com>
Subject: Re: [RFC PATCH v3 02/16] cxl/acpi: Add an acpi_cxl module for the
 CXL interconnect
Message-ID: <20210112220628.000037fb@Huawei.com>
In-Reply-To: <CAPcyv4hcppMZ2L8W8arUKmbCo0r=_yZggrnsj3w-Jgszjn=ZoA@mail.gmail.com>
References: <20210111225121.820014-1-ben.widawsky@intel.com>
        <20210111225121.820014-3-ben.widawsky@intel.com>
        <20210112184355.00007632@Huawei.com>
        <CAPcyv4hcppMZ2L8W8arUKmbCo0r=_yZggrnsj3w-Jgszjn=ZoA@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.64.210]
X-ClientProxiedBy: lhreml711-chm.china.huawei.com (10.201.108.62) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 12 Jan 2021 11:43:31 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> On Tue, Jan 12, 2021 at 10:44 AM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> >
> > On Mon, 11 Jan 2021 14:51:06 -0800
> > Ben Widawsky <ben.widawsky@intel.com> wrote:
> >  
> > > From: Vishal Verma <vishal.l.verma@intel.com>
> > >
> > > Add an acpi_cxl module to coordinate the ACPI portions of the CXL
> > > (Compute eXpress Link) interconnect. This driver binds to ACPI0017
> > > objects in the ACPI tree, and coordinates access to the resources
> > > provided by the ACPI CEDT (CXL Early Discovery Table).
> > >
> > > It also coordinates operations of the root port _OSC object to notify
> > > platform firmware that the OS has native support for the CXL
> > > capabilities of endpoints.
> > >
> > > Note: the actbl1.h changes are speculative. The expectation is that they
> > > will arrive through the ACPICA tree in due time.  
> >
> > I would pull the ACPICA changes out into a precursor patch.  
> 
> 
> >  
> > >
> > > Cc: Ben Widawsky <ben.widawsky@intel.com>
> > > Cc: Dan Williams <dan.j.williams@intel.com>
> > > Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> > > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>  
> >
> > Hi,
> >
> > I think it would be good to also add CEDT to the list in drivers/acpi/tables.c
> > so that we can dump it from /sys/firmware/acpi/tables/ and potentially
> > override it from an initrd.  
> 
> ACPICA changes will eventually come through the ACPI tree not this patch set.

That particular file isn't from ACPICA though I value in the entry will be.

> 
> 
> >
> > https://elixir.bootlin.com/linux/v5.11-rc3/source/drivers/acpi/tables.c#L482
> > Can be very helpful whilst debugging.  Related to that, anyone know if anyone
> > has acpica patches so we can have iasl -d work on the table?  Would probably
> > be useful but I'd rather not duplicate work if it's already done.
> >  
> 
> The supplemental tables described here:
> 
> https://www.uefi.org/acpi
> 
> ...do eventually make there way into ACPICA. Added Bob and Erik in
> case they can comment on when CEDT and CDAT support will be picked up.
...
