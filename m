Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7B93809C5
	for <lists+linux-pci@lfdr.de>; Fri, 14 May 2021 14:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233367AbhENMmv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 May 2021 08:42:51 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:2983 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232812AbhENMmq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 May 2021 08:42:46 -0400
Received: from dggems704-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FhSlC5Wh1zmVZh;
        Fri, 14 May 2021 20:39:19 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 dggems704-chm.china.huawei.com (10.3.19.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 14 May 2021 20:41:31 +0800
Received: from localhost (10.52.120.239) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2176.2; Fri, 14 May
 2021 13:41:29 +0100
Date:   Fri, 14 May 2021 13:39:42 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, <linux-cxl@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "Bjorn Helgaas" <helgaas@kernel.org>,
        Ben Widawsky <ben.widawsky@intel.com>,
        "Chris Browy" <cbrowy@avery-design.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Linuxarm <linuxarm@huawei.com>, Fangjian <f.fangjian@huawei.com>
Subject: Re: [RFC PATCH v3 2/4] PCI/doe: Add Data Object Exchange support
Message-ID: <20210514133942.00002358@Huawei.com>
In-Reply-To: <20210514111538.GA16218@lpieralisi>
References: <20210419165451.2176200-1-Jonathan.Cameron@huawei.com>
        <20210419165451.2176200-3-Jonathan.Cameron@huawei.com>
        <20210506215934.GJ1904484@iweiny-DESK2.sc.intel.com>
        <20210511175006.00007861@Huawei.com>
        <CAPcyv4j=uww+85b4AbWmoPNPry_+JLEpEnuywpdC8PonXmRmEg@mail.gmail.com>
        <20210514094755.00002081@Huawei.com>
        <20210514111538.GA16218@lpieralisi>
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

On Fri, 14 May 2021 12:15:38 +0100
Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:

> On Fri, May 14, 2021 at 09:47:55AM +0100, Jonathan Cameron wrote:
> > On Thu, 13 May 2021 14:20:38 -0700
> > Dan Williams <dan.j.williams@intel.com> wrote:
> >   
> > > On Tue, May 11, 2021 at 9:52 AM Jonathan Cameron
> > > <Jonathan.Cameron@huawei.com> wrote:  
> > > >
> > > > On Thu, 6 May 2021 14:59:34 -0700
> > > > Ira Weiny <ira.weiny@intel.com> wrote:
> > > >    
> > > > > On Tue, Apr 20, 2021 at 12:54:49AM +0800, Jonathan Cameron wrote:    
> > > > > > +
> > > > > > +static int pci_doe_send_req(struct pci_doe *doe, struct pci_doe_exchange *ex)
> > > > > > +{
> > > > > > +   struct pci_dev *pdev = doe->pdev;
> > > > > > +   u32 val;
> > > > > > +   int i;
> > > > > > +
> > > > > > +   /*
> > > > > > +    * Check the DOE busy bit is not set. If it is set, this could indicate
> > > > > > +    * someone other than Linux (e.g. firmware) is using the mailbox. Note
> > > > > > +    * it is expected that firmware and OS will negotiate access rights via
> > > > > > +    * an, as yet to be defined method.
> > > > > > +    */
> > > > > > +   pci_read_config_dword(pdev, doe->cap + PCI_DOE_STATUS, &val);
> > > > > > +   if (FIELD_GET(PCI_DOE_STATUS_BUSY, val))
> > > > > > +           return -EBUSY;    
> > > > >
> > > > > In discussion with Dan we believe that user space could also be issuing
> > > > > commands and would potentially cause us to be locked out.
> > > > >
> > > > > We agree that firmware should be out of the way here and if it is blocking
> > > > > the OS there is not much we can do about it.
> > > > >
> > > > > However, if user space is using the mailbox we need to synchronize with them
> > > > > via pci_cfg_access_[try]lock().  This should avoid this EBUSY condition.    
> > > >
> > > > Hi Ira, thanks for taking a look.
> > > >
> > > > So the question here is whether we can ever safely work with a
> > > > userspace that is accessing the DOE.  I think the answer is no we can't.
> > > >
> > > > We'd have no way of knowing that userspace left the DOE in a clean state
> > > > without resetting every time we want to use it (which can take 1 second)
> > > > or doing significant sanity checking (can we tell if something is
> > > > in flight?).  Note that if userspace and kernel were talking different
> > > > protocols nothing sensible could be done to prevent them receiving each
> > > > other's answers (unless you can rely on userspace holding the lock until
> > > > it is done - which you can't as who trusts userspace?)    
> > > 
> > > There is no ability for userpsace to lock out the kernel, only kernel
> > > locking out userspace.  
> > 
> > Hi Dan,
> > 
> > Got it. Writing userspace to code with arbitrary kernel
> > breakage of exchanges userspace initialized is going to be nasty. 
> >   
> > >   
> > > > You could do
> > > > something horrible like back off after peeking at the protocol to see
> > > > if it might be yours, but even that only works assuming the two are
> > > > trying to talk different protocols (talking the same protocol isn't allowed
> > > > but no way to enforce that using just pci_cfg_access_lock()).    
> > > 
> > > Wait why isn't pci_cfg_access_lock() sufficient? The userspace DOE
> > > transfer is halted, the kernel validates the state of DOE, does it's
> > > work and releases the lock.  
> > 
> > It's that 'validate the state of the DOE' which is the problem.  I 'think'
> > the only way to do that is to issue an abort every time and I'm really
> > not liking the fact that adds a potential 1 second sleep to every
> > DOE access from the kernel.  
> 
> IIUC an abort would mean game over for *every* transaction in flight,
> not sure that's the best way of preventing userspace from mingling
> but as you mentioned I don't think there is a way around it with the
> current protocol.
> 
> I don't see how a lock would solve this issue either - how would it ?

It would only work if symmetric (can be locked by userspace or kernel space)
and userspace was well behaved.

> 
> Basically you have to stop userspace from issuing requests for the
> duration of a request/response (per-protocol) session, right ?

Yes, but also stop the kernel from issuing requests for the duration of
a userspace request/response.  Imagine userspace issues a request for
a particular part of CDAT then kernel issues it's own request for a different
part of CDAT. Unless we can ensure the userspace request / response pair
is done, then there is no way for the kernel to verify that the response
it gets is to the request it made.  You could do some protocol specific
validation but that is horrible and you might need to read a bunch of
additional records to do it (checksum).

As currently implemented, I'm not allowing concurrent exchanges from
different protocols because it is very fiddly to do (handling the busy flag)
and I'm not convinced there is a real usecase.  Whilst in theory you can
have lots of protocols on one DOE, the protocols defined so far have had
a bunch or restrictions that mean at most you can currently collocate 2
protocols only.  If it turns out to be necessary at some future time, then
we can look at adding it.

I think the right way to do this is to put a proper interface in place
to expose the functionality to userspace via a path where mediation can
be easily handled.

Jonathan


> 
> Lorenzo

