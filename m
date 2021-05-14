Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16E31380581
	for <lists+linux-pci@lfdr.de>; Fri, 14 May 2021 10:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233755AbhENIvO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 May 2021 04:51:14 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3687 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbhENIvB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 May 2021 04:51:01 -0400
Received: from dggems706-chm.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FhMbF3HJsz1BMPj;
        Fri, 14 May 2021 16:47:05 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 dggems706-chm.china.huawei.com (10.3.19.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 14 May 2021 16:49:45 +0800
Received: from localhost (10.52.120.239) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2176.2; Fri, 14 May
 2021 09:49:42 +0100
Date:   Fri, 14 May 2021 09:47:55 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Ira Weiny <ira.weiny@intel.com>, <linux-cxl@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Chris Browy <cbrowy@avery-design.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Linuxarm <linuxarm@huawei.com>, Fangjian <f.fangjian@huawei.com>
Subject: Re: [RFC PATCH v3 2/4] PCI/doe: Add Data Object Exchange support
Message-ID: <20210514094755.00002081@Huawei.com>
In-Reply-To: <CAPcyv4j=uww+85b4AbWmoPNPry_+JLEpEnuywpdC8PonXmRmEg@mail.gmail.com>
References: <20210419165451.2176200-1-Jonathan.Cameron@huawei.com>
        <20210419165451.2176200-3-Jonathan.Cameron@huawei.com>
        <20210506215934.GJ1904484@iweiny-DESK2.sc.intel.com>
        <20210511175006.00007861@Huawei.com>
        <CAPcyv4j=uww+85b4AbWmoPNPry_+JLEpEnuywpdC8PonXmRmEg@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.120.239]
X-ClientProxiedBy: lhreml706-chm.china.huawei.com (10.201.108.55) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 13 May 2021 14:20:38 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> On Tue, May 11, 2021 at 9:52 AM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> >
> > On Thu, 6 May 2021 14:59:34 -0700
> > Ira Weiny <ira.weiny@intel.com> wrote:
> >  
> > > On Tue, Apr 20, 2021 at 12:54:49AM +0800, Jonathan Cameron wrote:  
> > > > +
> > > > +static int pci_doe_send_req(struct pci_doe *doe, struct pci_doe_exchange *ex)
> > > > +{
> > > > +   struct pci_dev *pdev = doe->pdev;
> > > > +   u32 val;
> > > > +   int i;
> > > > +
> > > > +   /*
> > > > +    * Check the DOE busy bit is not set. If it is set, this could indicate
> > > > +    * someone other than Linux (e.g. firmware) is using the mailbox. Note
> > > > +    * it is expected that firmware and OS will negotiate access rights via
> > > > +    * an, as yet to be defined method.
> > > > +    */
> > > > +   pci_read_config_dword(pdev, doe->cap + PCI_DOE_STATUS, &val);
> > > > +   if (FIELD_GET(PCI_DOE_STATUS_BUSY, val))
> > > > +           return -EBUSY;  
> > >
> > > In discussion with Dan we believe that user space could also be issuing
> > > commands and would potentially cause us to be locked out.
> > >
> > > We agree that firmware should be out of the way here and if it is blocking
> > > the OS there is not much we can do about it.
> > >
> > > However, if user space is using the mailbox we need to synchronize with them
> > > via pci_cfg_access_[try]lock().  This should avoid this EBUSY condition.  
> >
> > Hi Ira, thanks for taking a look.
> >
> > So the question here is whether we can ever safely work with a
> > userspace that is accessing the DOE.  I think the answer is no we can't.
> >
> > We'd have no way of knowing that userspace left the DOE in a clean state
> > without resetting every time we want to use it (which can take 1 second)
> > or doing significant sanity checking (can we tell if something is
> > in flight?).  Note that if userspace and kernel were talking different
> > protocols nothing sensible could be done to prevent them receiving each
> > other's answers (unless you can rely on userspace holding the lock until
> > it is done - which you can't as who trusts userspace?)  
> 
> There is no ability for userpsace to lock out the kernel, only kernel
> locking out userspace.

Hi Dan,

Got it. Writing userspace to code with arbitrary kernel
breakage of exchanges userspace initialized is going to be nasty. 

> 
> > You could do
> > something horrible like back off after peeking at the protocol to see
> > if it might be yours, but even that only works assuming the two are
> > trying to talk different protocols (talking the same protocol isn't allowed
> > but no way to enforce that using just pci_cfg_access_lock()).  
> 
> Wait why isn't pci_cfg_access_lock() sufficient? The userspace DOE
> transfer is halted, the kernel validates the state of DOE, does it's
> work and releases the lock.

It's that 'validate the state of the DOE' which is the problem.  I 'think'
the only way to do that is to issue an abort every time and I'm really
not liking the fact that adds a potential 1 second sleep to every
DOE access from the kernel.  There is no other way of knowing there is
no exchange already in flight that might come back and bite you even
after you think you have a clean state + I think you might be able to
construct cases where even inspecting the data isn't enough to tell.
If we are safe with today's protocols, there is no guarantee we will be
in future. If the DOE design had incorporated such a flag or counter of
exchanges in flight, then this might have been a workable approach. 

> 
> > I can't see a way to tell that the DOE might not have responded to an
> > earlier request.  DOE busy indicates the write mailbox register cannot
> > receive data at the moment.  If it's set then there is a message in
> > flight, but if it is not set there might still be a message in flight.
> > Busy only indicates if the write mailbox register can sink a request
> > which doesn't in general tell us anything about the underlying state.
> >
> > So if userspace sent a request then quit.  Kernel driver would have
> > no way of knowing if the next response was due to the request it sent
> > or some earlier one (other than matching IDs)  Note you aren't allowed
> > to have multiple requests for a single protocol in flight at the same
> > time.  With just a lock you would have no way of preventing this.
> >
> > So we are back to every request the kernel sent having to be proceeded
> > by an abort and potentially a 1 second delay whilst some chunk of the
> > device firmware reboots.
> >
> > This came up in dicussion when Dan proposed the patch
> > [PATCH] PCI: Allow drivers to claim exclusive access to config regions
> > https://lore.kernel.org/linux-pci/161663543465.1867664.5674061943008380442.stgit@dwillia2-desk3.amr.corp.intel.com/
> > Summarizing outcome of that thread.
> >
> > 1) Reads of DOE registers are always safe, so we shouldn't stop lspci
> > and similar accessing config space.
> > 2) You are on your own if any userspace writes to pci config space.
> > There are loads of ways it can break the system so it doesn't make much
> > sense to protect against one more.  
> 
> I'm not quite as enthusiastic about Greg's assertion that "we're
> already broken why not allow more breakage" as he was also the one
> supportive of /dev/mem restrictions in the face of obvious collisions.
> I'll circle back and say as much to Greg. My mistake was not realizing
> the write dependency in the protocol, so the pushback was warranted
> that the kernel does not need to block out all access.
> 
> Given that /dev/mem is optionally disabled for userspace access
> outside of kernel-lockdown scenarios, I think it is reasonable to have
> the kernel disable config writes to a register block and the request
> of a driver.
> 
> Consider that userspace can certainly trash the system by writing to
> the BAR registers, for example, but a non-malicious userspace has no
> reason to do that. Unfortunately DOE has some utility for a
> non-malicious userspace to access so there is a rationale to figure
> out a cooperation scheme.

I agree with a cooperation scheme, but I think that should take the
form of a proper interface rather than a one sided lock out.
It may well make sense to tighten access to PCI config space anyway but
I think that's a discussion that should be separate from this feature.

> 
> >
> > If there is a reason to provide a userspace interface to a DOE for a
> > device with a driver attached, then I would agree with Dan's suggestion
> > to use a proper driver for it.
> >
> > Dan briefly mentioned that temporary blocking might be needed. I'm guessing
> > that was to try and let userspace safely use the DOE.
> >
> > The driver would work fine ignoring busy entirely and would perhaps be
> > less confusing as a result.  We reset the DOE at startup anyway and that
> > would clear existing busy.  Any future times busy is set would have no
> > impact on the flow.  
> 
> If it simplifies the kernel implementation to assume single
> kernel-initiator then I think that's more than enough reason to block
> out userspace, and/or provide userspace a method to get into the
> kernel's queue for service.

This last suggestion makes sense to me. Let's provide a 'right' way
to access the DOE from user space. I like the idea if it being possible
to run CXL compliance tests from userspace whilst the driver is loaded.

Bjorn, given this would be a generic PCI thing, any preference for what
this interface might look like?   /dev/pcidoe[xxxxxx].i with ioctls similar
to those for the BAR based CXL mailboxes?

Thanks,

Jonathan

