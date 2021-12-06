Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA474695A4
	for <lists+linux-pci@lfdr.de>; Mon,  6 Dec 2021 13:28:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235286AbhLFMba (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Dec 2021 07:31:30 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4202 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232833AbhLFMba (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Dec 2021 07:31:30 -0500
Received: from fraeml744-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4J72jq2fwHz687ND;
        Mon,  6 Dec 2021 20:26:55 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml744-chm.china.huawei.com (10.206.15.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 6 Dec 2021 13:27:59 +0100
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Mon, 6 Dec
 2021 12:27:58 +0000
Date:   Mon, 6 Dec 2021 12:27:56 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Bjorn Helgaas <helgaas@kernel.org>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        "Bjorn Helgaas" <bhelgaas@google.com>, <linux-cxl@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 2/5] PCI/DOE: Add Data Object Exchange Aux Driver
Message-ID: <20211206122756.00006b31@Huawei.com>
In-Reply-To: <CAPcyv4h8Rns_55gqPvn0huvhO4E=iy_PJQ_dKJxxOG=dOOKw9Q@mail.gmail.com>
References: <CAPcyv4hDTitnqasVwLTV4QPJqW_ykoJc+hRVRm8aLzG4xBxVag@mail.gmail.com>
        <20211203235617.GA3036259@bhelgaas>
        <CAPcyv4h8Rns_55gqPvn0huvhO4E=iy_PJQ_dKJxxOG=dOOKw9Q@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-ClientProxiedBy: lhreml746-chm.china.huawei.com (10.201.108.196) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, 4 Dec 2021 07:47:59 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> On Fri, Dec 3, 2021 at 3:56 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > On Fri, Dec 03, 2021 at 12:48:18PM -0800, Dan Williams wrote:  
> > > On Tue, Nov 16, 2021 at 3:48 PM Bjorn Helgaas <helgaas@kernel.org> wrote:  
> > > > On Fri, Nov 05, 2021 at 04:50:53PM -0700, ira.weiny@intel.com wrote:  
> > > > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > >
> > > > > Introduced in a PCI ECN [1], DOE provides a config space based mailbox
> > > > > with standard protocol discovery.  Each mailbox is accessed through a
> > > > > DOE Extended Capability.
> > > > >
> > > > > Define an auxiliary device driver which control DOE auxiliary devices
> > > > > registered on the auxiliary bus.  
> > > >
> > > > What do we gain by making this an auxiliary driver?
> > > >
> > > > This doesn't really feel like a "driver," and apparently it used to be
> > > > a library.  I'd like to see the rationale and benefits of the driver
> > > > approach (in the eventual commit log as well as the current email
> > > > thread).  
> > >
> > > I asked Ira to use the auxiliary bus for DOE primarily for the ABI it
> > > offers for userspace to manage kernel vs userspace access to a device.
> > > CONFIG_IO_STRICT_DEVMEM set the precedent that userspace can not
> > > clobber mmio space that is actively claimed by a kernel driver. I
> > > submit that DOE merits the same protection for DOE instances that the
> > > kernel consumes.
> > >
> > > Unlike other PCI configuration registers that root userspace has no
> > > reason to touch unless it wants to actively break things, DOE is a
> > > mechanism that root userspace may need to access directly in some
> > > cases. There are a few examples that come to mind.  
> >
> > It's useful for root to read/write config registers with setpci, e.g.,
> > to test ASPM configuration, test power management behavior, etc.  That
> > can certainly break things and interfere with kernel access (and IMO
> > should taint the kernel) but we have so far accepted that risk.  I
> > think the same will be true for DOE.  
> 
> I think DOE is a demonstrable step worse than those examples and
> pushes into the unacceptable risk category. It invites a communication
> protocol with an unbounded range of side effects (especially when
> controlling a device like a CXL memory expander that affects "System
> RAM" directly). Part of what drives platform / device vendors to the
> standards negotiation table is the OS encouraging common interfaces.
> If Linux provides an unfettered DOE interface it reduces an incentive
> for device vendors to collaborate with the kernel community.
> 
> I do like the taint proposal though, if I can't convince you that DOE
> merits explicit root userspace lockout beyond
> CONFIG_LOCK_DOWN_KERNEL_FORCE_INTEGRITY, I would settle for the kernel
> warning loudly about DOE usage that falls outside the kernel's
> expectations.
> 
> > In addition, I would think you might want a safe userspace interface
> > via sysfs, e.g., something like the "vpd" file, but I missed that if
> > it was in this series.  
> 
> I do not think the kernel is well served by a generic userspace
> passthrough for DOE for the same reason that there is no generic
> passthrough for the ACPI _DSM facility. When the kernel becomes a
> generic pipe to a vendor specific interface it impedes the kernel from
> developing standard interfaces across vendors. Each vendor will ship
> their own quirky feature and corresponding vendor-specific tool with
> minimal incentive to coordinate with other vendors doing similar
> things. At a minimum the userspace interface for DOE should be at a
> level above the raw transport and be enabled per standardized /
> published DOE protocol.  I.e. a userspace interface to read the CDAT
> table retrieved over DOE, or a userspace interface to enumerate IDE
> capabilities, etc.

I agree with Dan that a generic pass through is a bad idea, but we
do have code for one in an earlier version...
https://lore.kernel.org/linux-pci/20210524133938.2815206-5-Jonathan.Cameron@huawei.com/

We could take the approach of an allow list for this, if we can figure
out an appropriate way to manage that list.

> 
> > > CXL Compliance Testing (see CXL 2.0 14.16.4 Compliance Mode DOE)
> > > offers a mechanism to set different test modes for a DOE device. The
> > > kernel has no reason to ever use that interface, and it has strong
> > > reasons to want to block access to it in production. However, hardware
> > > vendors also use debug Linux builds for hardware bringup. So I would
> > > like to be able to say that the mechanism to gain access to the
> > > compliance DOE is to detach the aux DOE driver from the right aux DOE
> > > device. Could we build a custom way to do the same for the DOE
> > > library, sure, but why re-invent the wheel when udev and the driver
> > > model can handle this type of policy question already?
> > >
> > > Another use case is SPDM where an agent can establish a secure message
> > > passing channel to a device, or paravirtualized device to exchange
> > > protected messages with the hypervisor. My expectation is that in
> > > addition to the kernel establishing SPDM sessions for PCI IDE and
> > > CXL.cachemem IDE (link Integrity and Data Encryption) there will be
> > > use cases for root userspace to establish their own SPDM session. In
> > > that scenario as well the kernel can be told to give up control of a
> > > specific DOE instance by detaching the aux device for its driver, but
> > > otherwise the kernel driver can be assured that userspace will not
> > > clobber its communications with its own attempts to talk over the DOE.  
> >
> > I assume the kernel needs to control access to DOE in all cases,
> > doesn't it?  For example, DOE can generate interrupts, and only the
> > kernel can field them.  Maybe if I saw the userspace interface this
> > would make more sense to me.  I'm hoping there's a reasonable "send
> > this query and give me the response" primitive that can be implemented
> > in the kernel, used by drivers, and exposed safely to userspace.  
> 
> A DOE can generate interrupts, but I have yet to see a protocol that
> demands that. The userspace interface in the patches is just a binary
> attribute to dump the "CDAT" table retrieved over DOE. No generic
> passthrough is provided per the concerns above.

I don't think it would be that hard to set up a protocol specific interface
for establishment of secure channels to cover that particular case.  As long
as we ensure userspace can see / manage the crypto elements it won't matter
if the data is passed through another interface on it's way to the DOE.

Jonathan
