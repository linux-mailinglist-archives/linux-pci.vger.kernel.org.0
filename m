Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AAF5380841
	for <lists+linux-pci@lfdr.de>; Fri, 14 May 2021 13:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232178AbhENLRF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 May 2021 07:17:05 -0400
Received: from foss.arm.com ([217.140.110.172]:47718 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232182AbhENLQ5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 14 May 2021 07:16:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8C7561713;
        Fri, 14 May 2021 04:15:45 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DDDD33F73B;
        Fri, 14 May 2021 04:15:43 -0700 (PDT)
Date:   Fri, 14 May 2021 12:15:38 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-cxl@vger.kernel.org,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Chris Browy <cbrowy@avery-design.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Linuxarm <linuxarm@huawei.com>, Fangjian <f.fangjian@huawei.com>
Subject: Re: [RFC PATCH v3 2/4] PCI/doe: Add Data Object Exchange support
Message-ID: <20210514111538.GA16218@lpieralisi>
References: <20210419165451.2176200-1-Jonathan.Cameron@huawei.com>
 <20210419165451.2176200-3-Jonathan.Cameron@huawei.com>
 <20210506215934.GJ1904484@iweiny-DESK2.sc.intel.com>
 <20210511175006.00007861@Huawei.com>
 <CAPcyv4j=uww+85b4AbWmoPNPry_+JLEpEnuywpdC8PonXmRmEg@mail.gmail.com>
 <20210514094755.00002081@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210514094755.00002081@Huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 14, 2021 at 09:47:55AM +0100, Jonathan Cameron wrote:
> On Thu, 13 May 2021 14:20:38 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > On Tue, May 11, 2021 at 9:52 AM Jonathan Cameron
> > <Jonathan.Cameron@huawei.com> wrote:
> > >
> > > On Thu, 6 May 2021 14:59:34 -0700
> > > Ira Weiny <ira.weiny@intel.com> wrote:
> > >  
> > > > On Tue, Apr 20, 2021 at 12:54:49AM +0800, Jonathan Cameron wrote:  
> > > > > +
> > > > > +static int pci_doe_send_req(struct pci_doe *doe, struct pci_doe_exchange *ex)
> > > > > +{
> > > > > +   struct pci_dev *pdev = doe->pdev;
> > > > > +   u32 val;
> > > > > +   int i;
> > > > > +
> > > > > +   /*
> > > > > +    * Check the DOE busy bit is not set. If it is set, this could indicate
> > > > > +    * someone other than Linux (e.g. firmware) is using the mailbox. Note
> > > > > +    * it is expected that firmware and OS will negotiate access rights via
> > > > > +    * an, as yet to be defined method.
> > > > > +    */
> > > > > +   pci_read_config_dword(pdev, doe->cap + PCI_DOE_STATUS, &val);
> > > > > +   if (FIELD_GET(PCI_DOE_STATUS_BUSY, val))
> > > > > +           return -EBUSY;  
> > > >
> > > > In discussion with Dan we believe that user space could also be issuing
> > > > commands and would potentially cause us to be locked out.
> > > >
> > > > We agree that firmware should be out of the way here and if it is blocking
> > > > the OS there is not much we can do about it.
> > > >
> > > > However, if user space is using the mailbox we need to synchronize with them
> > > > via pci_cfg_access_[try]lock().  This should avoid this EBUSY condition.  
> > >
> > > Hi Ira, thanks for taking a look.
> > >
> > > So the question here is whether we can ever safely work with a
> > > userspace that is accessing the DOE.  I think the answer is no we can't.
> > >
> > > We'd have no way of knowing that userspace left the DOE in a clean state
> > > without resetting every time we want to use it (which can take 1 second)
> > > or doing significant sanity checking (can we tell if something is
> > > in flight?).  Note that if userspace and kernel were talking different
> > > protocols nothing sensible could be done to prevent them receiving each
> > > other's answers (unless you can rely on userspace holding the lock until
> > > it is done - which you can't as who trusts userspace?)  
> > 
> > There is no ability for userpsace to lock out the kernel, only kernel
> > locking out userspace.
> 
> Hi Dan,
> 
> Got it. Writing userspace to code with arbitrary kernel
> breakage of exchanges userspace initialized is going to be nasty. 
> 
> > 
> > > You could do
> > > something horrible like back off after peeking at the protocol to see
> > > if it might be yours, but even that only works assuming the two are
> > > trying to talk different protocols (talking the same protocol isn't allowed
> > > but no way to enforce that using just pci_cfg_access_lock()).  
> > 
> > Wait why isn't pci_cfg_access_lock() sufficient? The userspace DOE
> > transfer is halted, the kernel validates the state of DOE, does it's
> > work and releases the lock.
> 
> It's that 'validate the state of the DOE' which is the problem.  I 'think'
> the only way to do that is to issue an abort every time and I'm really
> not liking the fact that adds a potential 1 second sleep to every
> DOE access from the kernel.

IIUC an abort would mean game over for *every* transaction in flight,
not sure that's the best way of preventing userspace from mingling
but as you mentioned I don't think there is a way around it with the
current protocol.

I don't see how a lock would solve this issue either - how would it ?

Basically you have to stop userspace from issuing requests for the
duration of a request/response (per-protocol) session, right ?

Lorenzo
