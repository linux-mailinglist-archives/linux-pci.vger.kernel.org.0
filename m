Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9BDA3C181B
	for <lists+linux-pci@lfdr.de>; Thu,  8 Jul 2021 19:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbhGHRbW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Jul 2021 13:31:22 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3375 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbhGHRbW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Jul 2021 13:31:22 -0400
Received: from fraeml736-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GLNFH5kpbz6H9Bh;
        Fri,  9 Jul 2021 01:14:27 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml736-chm.china.huawei.com (10.206.15.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 8 Jul 2021 19:28:37 +0200
Received: from localhost (10.47.25.204) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Thu, 8 Jul 2021
 18:28:36 +0100
Date:   Thu, 8 Jul 2021 18:28:19 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        <linux-cxl@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Chris Browy <cbrowy@avery-design.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Fangjian <f.fangjian@huawei.com>, Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH v4 2/5] PCI/DOE: Add Data Object Exchange support
Message-ID: <20210708182819.00005b39@Huawei.com>
In-Reply-To: <20210708084815.GA6845@lpieralisi>
References: <20210524133938.2815206-1-Jonathan.Cameron@huawei.com>
        <20210524133938.2815206-3-Jonathan.Cameron@huawei.com>
        <CAPcyv4gBORHzouArX-Fsnhew+ZYur8pp9ySJQGwrOBrGuv+-ZQ@mail.gmail.com>
        <CAPcyv4i2ukD4ZQ_KfTaKXLyMakpSk=Y3_QJGV2P_PLHHVkPwFw@mail.gmail.com>
        <20210708084815.GA6845@lpieralisi>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.25.204]
X-ClientProxiedBy: lhreml712-chm.china.huawei.com (10.201.108.63) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 8 Jul 2021 09:48:15 +0100
Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:

> On Wed, Jul 07, 2021 at 12:54:33PM -0700, Dan Williams wrote:
> > On Thu, Jun 10, 2021 at 1:06 PM Dan Williams <dan.j.williams@intel.com> wrote:  
> > >
> > > On Mon, May 24, 2021 at 6:41 AM Jonathan Cameron
> > > <Jonathan.Cameron@huawei.com> wrote:  
> > > >
> > > > Introduced in a PCI ECN [1], DOE provides a config space based mailbox with
> > > > standard protocol discovery.  Each mailbox is accessed through a DOE
> > > > Extended Capability.
> > > >
> > > > A device may have 1 or more DOE mailboxes, each of which is allowed to
> > > > support any number of protocols (some DOE protocol specifications apply
> > > > additional restrictions).  A given protocol may be supported on more than
> > > > one DOE mailbox on a given function.
> > > >
> > > > If a driver wishes to access any number of DOE instances / protocols it
> > > > makes a single call to pci_doe_register_all() which will find available
> > > > DOEs, create the required infrastructure and cache the protocols they
> > > > support.  pci_doe_find() can then retrieve a pointer to an appropriate DOE
> > > > instance.
> > > >
> > > > A synchronous interface is provided in pci_doe_exchange_sync() to perform a
> > > > single query / response exchange.
> > > >
> > > > Testing conducted against QEMU using:
> > > >
> > > > https://lore.kernel.org/qemu-devel/1619454964-10190-1-git-send-email-cbrowy@avery-design.com/  
> > >
> > > Nice.
> > >
> > > I was hoping that by now QEMU upstream would have given us some
> > > indication that this useful work that has a chance of being merged. I
> > > fear it's only us CXL practitioner's that care. Perhaps the PCI IDE
> > > support will get them to move on at least the DOE patches?
> > >  
> > > >
> > > > [1] https://members.pcisig.com/wg/PCI-SIG/document/14143
> > > >     Data Object Exchange (DOE) - Approved 12 March 2020
> > > >
> > > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>  
> > >
> > > The core logic of this looks good to me. The interfaces for other code
> > > to make use of this I feel can lean heavier on existing mechanics. A
> > > few points come to mind:
> > >
> > > - Does this need to support anything more than queue depth 1? I know
> > > the specification seems to allow for some overlapping and queueing,
> > > but I don't think there are any use cases that are precluded if the
> > > max number of tasks in flight for a given DOE is one.

We aren't handling overlapping today, so a queue of one and wait on access
to that would work fine.  Queuing is more likely to be about multiple protocols
sharing a DOE (where allowed) as I'm not seeing a need in any individual protocol
to queue lots of things up at once. You could queue a few things in CMA as they
aren't all dependent on each other (though the order matters for building the
measurements) but I'm not sure why you would.

> > >
> > > - Once its queue depth 1 then the list of tasks can be replaced with a
> > > wait_queue_head_t where submitters wait for the previous task to
> > > finish.

I'll go with a resounding 'maybe' on that... I'm not sure I like that the
async path in the submitter could be waiting a very long time (if we think
anyone will actually do async...)  I'm probably missing something.

> > >
> > > - This appears to be the prototypical scenario for deploying the new
> > > auxiliary bus facility. Rather than custom code device-like facilities
> > > (lists and parents etc) in 'struct pci_doe' just make pci_doe a device
> > > directly (auxiliary-device) and separate the infrastructure that
> > > drives that device to a driver (auxiliary-driver). That makes the
> > > lifetime management more idiomatic, allows for user space to have
> > > typical driver-binding controls to manage kernel-user DOE conflicts,
> > > and it allows for typical driver services like devm.  
> > 
> > Hi Jonathan,
> > 
> > Are you waiting on me to take a shot at refactoring the DOE driver
> > into this proposed auxiliary device/driver organization? I am happy to
> > do that if you've moved on to looking at the kernel-side SPDM
> > implementation [1].

I wasn't really expecting you to take a shot, but if you have time, that
would be great. I've not looked at the auxiliary bus stuff yet.

Whilst I have a PoC up and running for SPDM, it's a bunch of dirty hacks and
I suspect that, even when cleaned up, it's going to keep me busy for a while.

Mostly I've developed a steadily growing hatred for the different ways in
which signatures can be stored and hand decoding records or digging in
openspdm to figure out what order and encoding things are in this time...

> > 
> > I would expect DOE,  SPDM, and IDE would be a useful topic to discuss
> > at the the Plumbers PCI Microconference assuming we do not solve all
> > the open issues before September.  
> 
> Definitely, I will make sure we schedule a slot on these topics.

+1

I'm sure there will be some issues left :)

> 
> Thanks,
> Lorenzo
> 
> > [1]: https://lore.kernel.org/r/20210629132520.00000d1f@Huawei.com  

