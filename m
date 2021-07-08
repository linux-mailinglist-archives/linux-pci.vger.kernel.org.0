Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4863BF713
	for <lists+linux-pci@lfdr.de>; Thu,  8 Jul 2021 10:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbhGHIvF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Jul 2021 04:51:05 -0400
Received: from foss.arm.com ([217.140.110.172]:53882 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230414AbhGHIvE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 8 Jul 2021 04:51:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CD1D631B;
        Thu,  8 Jul 2021 01:48:22 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2A1813F5A1;
        Thu,  8 Jul 2021 01:48:21 -0700 (PDT)
Date:   Thu, 8 Jul 2021 09:48:15 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        linux-cxl@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Chris Browy <cbrowy@avery-design.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Fangjian <f.fangjian@huawei.com>, Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH v4 2/5] PCI/DOE: Add Data Object Exchange support
Message-ID: <20210708084815.GA6845@lpieralisi>
References: <20210524133938.2815206-1-Jonathan.Cameron@huawei.com>
 <20210524133938.2815206-3-Jonathan.Cameron@huawei.com>
 <CAPcyv4gBORHzouArX-Fsnhew+ZYur8pp9ySJQGwrOBrGuv+-ZQ@mail.gmail.com>
 <CAPcyv4i2ukD4ZQ_KfTaKXLyMakpSk=Y3_QJGV2P_PLHHVkPwFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4i2ukD4ZQ_KfTaKXLyMakpSk=Y3_QJGV2P_PLHHVkPwFw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 07, 2021 at 12:54:33PM -0700, Dan Williams wrote:
> On Thu, Jun 10, 2021 at 1:06 PM Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > On Mon, May 24, 2021 at 6:41 AM Jonathan Cameron
> > <Jonathan.Cameron@huawei.com> wrote:
> > >
> > > Introduced in a PCI ECN [1], DOE provides a config space based mailbox with
> > > standard protocol discovery.  Each mailbox is accessed through a DOE
> > > Extended Capability.
> > >
> > > A device may have 1 or more DOE mailboxes, each of which is allowed to
> > > support any number of protocols (some DOE protocol specifications apply
> > > additional restrictions).  A given protocol may be supported on more than
> > > one DOE mailbox on a given function.
> > >
> > > If a driver wishes to access any number of DOE instances / protocols it
> > > makes a single call to pci_doe_register_all() which will find available
> > > DOEs, create the required infrastructure and cache the protocols they
> > > support.  pci_doe_find() can then retrieve a pointer to an appropriate DOE
> > > instance.
> > >
> > > A synchronous interface is provided in pci_doe_exchange_sync() to perform a
> > > single query / response exchange.
> > >
> > > Testing conducted against QEMU using:
> > >
> > > https://lore.kernel.org/qemu-devel/1619454964-10190-1-git-send-email-cbrowy@avery-design.com/
> >
> > Nice.
> >
> > I was hoping that by now QEMU upstream would have given us some
> > indication that this useful work that has a chance of being merged. I
> > fear it's only us CXL practitioner's that care. Perhaps the PCI IDE
> > support will get them to move on at least the DOE patches?
> >
> > >
> > > [1] https://members.pcisig.com/wg/PCI-SIG/document/14143
> > >     Data Object Exchange (DOE) - Approved 12 March 2020
> > >
> > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > The core logic of this looks good to me. The interfaces for other code
> > to make use of this I feel can lean heavier on existing mechanics. A
> > few points come to mind:
> >
> > - Does this need to support anything more than queue depth 1? I know
> > the specification seems to allow for some overlapping and queueing,
> > but I don't think there are any use cases that are precluded if the
> > max number of tasks in flight for a given DOE is one.
> >
> > - Once its queue depth 1 then the list of tasks can be replaced with a
> > wait_queue_head_t where submitters wait for the previous task to
> > finish.
> >
> > - This appears to be the prototypical scenario for deploying the new
> > auxiliary bus facility. Rather than custom code device-like facilities
> > (lists and parents etc) in 'struct pci_doe' just make pci_doe a device
> > directly (auxiliary-device) and separate the infrastructure that
> > drives that device to a driver (auxiliary-driver). That makes the
> > lifetime management more idiomatic, allows for user space to have
> > typical driver-binding controls to manage kernel-user DOE conflicts,
> > and it allows for typical driver services like devm.
> 
> Hi Jonathan,
> 
> Are you waiting on me to take a shot at refactoring the DOE driver
> into this proposed auxiliary device/driver organization? I am happy to
> do that if you've moved on to looking at the kernel-side SPDM
> implementation [1].
> 
> I would expect DOE,  SPDM, and IDE would be a useful topic to discuss
> at the the Plumbers PCI Microconference assuming we do not solve all
> the open issues before September.

Definitely, I will make sure we schedule a slot on these topics.

Thanks,
Lorenzo

> [1]: https://lore.kernel.org/r/20210629132520.00000d1f@Huawei.com
