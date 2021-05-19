Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EED23893DB
	for <lists+linux-pci@lfdr.de>; Wed, 19 May 2021 18:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347483AbhESQhF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 May 2021 12:37:05 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4539 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346964AbhESQhE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 May 2021 12:37:04 -0400
Received: from dggems704-chm.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FldhR2d2RzsRmJ;
        Thu, 20 May 2021 00:32:55 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 dggems704-chm.china.huawei.com (10.3.19.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 20 May 2021 00:35:40 +0800
Received: from localhost (10.52.121.81) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 19 May
 2021 17:35:38 +0100
Date:   Wed, 19 May 2021 17:33:52 +0100
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
        Linuxarm <linuxarm@huawei.com>, Fangjian <f.fangjian@huawei.com>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [RFC PATCH v3 2/4] PCI/doe: Add Data Object Exchange support
Message-ID: <20210519173352.000026fe@Huawei.com>
In-Reply-To: <20210519172052.00002124@Huawei.com>
References: <20210419165451.2176200-1-Jonathan.Cameron@huawei.com>
        <20210419165451.2176200-3-Jonathan.Cameron@huawei.com>
        <20210506215934.GJ1904484@iweiny-DESK2.sc.intel.com>
        <20210511175006.00007861@Huawei.com>
        <CAPcyv4j=uww+85b4AbWmoPNPry_+JLEpEnuywpdC8PonXmRmEg@mail.gmail.com>
        <20210514094755.00002081@Huawei.com>
        <CAPcyv4h_qSZq+sTAOTKDNsO3xPmq=65j8oO1iw0WdVFj8+XrOA@mail.gmail.com>
        <20210517094045.00004d58@Huawei.com>
        <CAPcyv4iQcV_U1qmQhXKM0RG9v-sAEPwtTxnv=P86yJrCH25k+w@mail.gmail.com>
        <20210518110403.000013e6@Huawei.com>
        <CAPcyv4g3JPtAHzemKdQiM44ZkZ_0u+U-UJ5mfeU3fKzRWuaDyQ@mail.gmail.com>
        <20210519161156.00003bf9@Huawei.com>
        <CAPcyv4j_oEWG1NG1wYryVt3-Gx8q2WwzP7_xhchsDARDR0zBEA@mail.gmail.com>
        <20210519172052.00002124@Huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.121.81]
X-ClientProxiedBy: lhreml730-chm.china.huawei.com (10.201.108.81) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 19 May 2021 17:20:52 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Wed, 19 May 2021 08:29:58 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > On Wed, May 19, 2021 at 8:14 AM Jonathan Cameron
> > <Jonathan.Cameron@huawei.com> wrote:  
> > >
> > > On Wed, 19 May 2021 07:18:28 -0700
> > > Dan Williams <dan.j.williams@intel.com> wrote:
> > >    
> > > > On Tue, May 18, 2021 at 3:06 AM Jonathan Cameron
> > > > <Jonathan.Cameron@huawei.com> wrote:    
> > > > >
> > > > > On Mon, 17 May 2021 10:21:14 -0700
> > > > > Dan Williams <dan.j.williams@intel.com> wrote:
> > > > >    
> > > > > > On Mon, May 17, 2021 at 1:42 AM Jonathan Cameron
> > > > > > <Jonathan.Cameron@huawei.com> wrote:    
> > > > > > >
> > > > > > > On Fri, 14 May 2021 11:37:12 -0700
> > > > > > > Dan Williams <dan.j.williams@intel.com> wrote:
> > > > > > >    
> > > > > > > > On Fri, May 14, 2021 at 1:50 AM Jonathan Cameron
> > > > > > > > <Jonathan.Cameron@huawei.com> wrote:
> > > > > > > > [..]    
> > > > > > > > > > If it simplifies the kernel implementation to assume single
> > > > > > > > > > kernel-initiator then I think that's more than enough reason to block
> > > > > > > > > > out userspace, and/or provide userspace a method to get into the
> > > > > > > > > > kernel's queue for service.    
> > > > > > > > >
> > > > > > > > > This last suggestion makes sense to me. Let's provide a 'right' way
> > > > > > > > > to access the DOE from user space. I like the idea if it being possible
> > > > > > > > > to run CXL compliance tests from userspace whilst the driver is loaded.    
> > > > > > > >
> > > > > > > > Ah, and I like your observation that once the kernel provides a
> > > > > > > > "right" way to access DOE then userspace direct-access of DOE is
> > > > > > > > indeed a "you get to keep the pieces" event like any other unwanted
> > > > > > > > userspace config-write.
> > > > > > > >    
> > > > > > > > > Bjorn, given this would be a generic PCI thing, any preference for what
> > > > > > > > > this interface might look like?   /dev/pcidoe[xxxxxx].i with ioctls similar
> > > > > > > > > to those for the BAR based CXL mailboxes?    
> > > > > > > >
> > > > > > > > (warning, anti-ioctl bias incoming...)    
> > > > > > >
> > > > > > > I feel very similar about ioctls - my immediate thought was to shove this in
> > > > > > > debugfs, but that feels the wrong choice if we are trying to persuade people
> > > > > > > to use it instead of writing code that directly accesses the config space.
> > > > > > >    
> > > > > > > >
> > > > > > > > Hmm, DOE has an enumeration capability, could the DOE driver use a
> > > > > > > > scheme to have a sysfs bin_attr per discovered object type? This would
> > > > > > > > make it simliar to the pci-vpd sysfs interface.    
> > > > > > >
> > > > > > > We can discover the protocols, but anything beyond that is protocol
> > > > > > > specific.  I don't think there is a enough info available by any standards
> > > > > > > defined method. Also part of the reason to allow a safe userspace interface
> > > > > > > would be to provide a generic interface for vendor protocols and things like
> > > > > > > CXL compliance tests where we will almost certainly never provide a more
> > > > > > > specific kernel interface.
> > > > > > >
> > > > > > > Whilst sysfs would work for CDAT, some protocols are challenge response rather
> > > > > > > than simple read back and that really doesn't fit well for sysfs model.
> > > > > > > If we get other protocols that are simple data read back, then I would
> > > > > > > advocate giving them a simple sysfs interface much like proposed for CDAT
> > > > > > > as it will always be simpler to use + self describing.
> > > > > > >
> > > > > > > On a lesser note it might be helpful to provide sysfs attrs for
> > > > > > > what protocols are supported.  The alternative is to let userspace run
> > > > > > > the discovery protocol. Perhaps we can do this as a later phase.
> > > > > > >    
> > > > > > > >
> > > > > > > > Then the kernel could cache objects like CDAT that don't change
> > > > > > > > outside of some invalidation event.    
> > > > > > >
> > > > > > > It's been a while since I last saw any conversation on sysfs bin_attrs
> > > > > > > but mostly I thought the feeling was pretty strongly against them for anything
> > > > > > > but a few niche usecases.
> > > > > > >
> > > > > > > Feels to me like it would break most of the usual rules in a way vpd does
> > > > > > > not (IIRC VPD is supposed to be a simple in the sense that if you write a value
> > > > > > > to a writable part, you will read back the same value).
> > > > > > >
> > > > > > > +CC Greg who is a fount of knowledge in this area (and regularly + correctly
> > > > > > > screams at the ways I try to abuse sysfs :)  Note I don't think Dan was
> > > > > > > suggesting implementing response / request directly, but I think that is
> > > > > > > all we could do given DOE protocols can be vendor specific and the standard
> > > > > > > discovery protocol doesn't let us know the fine grained support (what commands
> > > > > > > within a given protocol).    
> > > > > >
> > > > > > I'm not all that interested in supporting vendor defined DOE
> > > > > > shenanigans. There's more than enough published DOE protocols that the
> > > > > > kernel could limit its support to the known set. This is similar to
> > > > > > how ACPI DSMs are not generically supported, but when they appear in a
> > > > > > published specification the kernel may then grow the support. The
> > > > > > supported protocols could be limited to: CDAT, PCIe IDE, CXL
> > > > > > Compliance, etc...
> > > > > >
> > > > > > Vendor specific DOE is in the same class as unfettered /dev/mem
> > > > > > access, first you need to disable the kernel's integrity and
> > > > > > confidentiality protections, and then you can do whatever you want. If
> > > > > > a vendor wants a DOE protocol supported in the "trusted" set they can
> > > > > > simply publish the specification and send the proper support patches.    
> > > > >
> > > > > Fair enough, though the interface should be root only, so a vendor shooting
> > > > > themselves in the foot this way would be no different to using pcitools
> > > > > to access the device directly (we are just providing safety from concurrency
> > > > > point of view).
> > > > >
> > > > > Anyway, I can see two options for how to do this.
> > > > >
> > > > > 1) Per protocol interface. Would not be generic, as these work in entirely
> > > > >    different ways (some are simple read back of tables, some require complex
> > > > >    cycles of operations in the right order with data flowing in both directions)
> > > > > 2) White list those protocols we are going to let through a generic interface
> > > > >    Not including CXL compliance for instance as that has nasty side effects!
> > > > >
> > > > > If we want to enable userspace DOE access, I prefer option 2.
> > > > >
> > > > > Note that I wasn't that keen on a userspace interface in the first place as
> > > > > in my view these should all be handled in kernel.
> > > > > Ultimately we should have case 1 if userspace access make sense.
> > > > > However, if we do this we shouldn't pretend we are providing userspace
> > > > > access to the DOE at all.  We are providing interfaces to things that just
> > > > > happen to be implemented using DOE under the hood.
> > > > >
> > > > > I have a prototype of a trivial ioctl based interface. I'll send it out
> > > > > as an RFC later this week.  Might add a white list, depending on where
> > > > > this discussion goes.
> > > > >    
> > > >
> > > > I'd say let's do this in typical Linux fashion and not solve future
> > > > problems before they need to be solved. I.e. start small and build
> > > > incrementally. To me that looks like a sysfs interface to convey a
> > > > cached copy of a CDAT with an internal interface for a driver to
> > > > trigger invalidations and re-reads on the next access. This would
> > > > assume that userspace may have left the DOE in an indeterminate state
> > > > and an abort cycle may be needed. A 1 second delay for the rare case
> > > > where a collision is detected seems reasonable for just CDAT
> > > > retrieval.    
> > >
> > > The problem is you can not detect a collision.    
> > 
> > This discussion started because Ira questioned the handling of the
> > busy status. If the DOE is busy and the kernel did not make it busy
> > then there was a collision, no?  
> 
> True, but not complete. Not having busy set does not mean there
> wasn't a collision. Busy is an indication that the EP can't recieve
> a new request (no space in buffer or similar), not that there is a response
> still to be sent back.  We have no way to tell if there is a response
> going to come back in the future. There is no 'exchange in flight' flag.

Perhaps useful to add a quote from the DOE ECN here.
This is in an implementation note on Page 6.

"The DOE Busy bit can be used to indicate that the DOE responder is
 temporarily unable to accept a data object. It is necessary for a
 DOE requester to ensure that individual data object transfers are
 completed, and that a request/response contract is completed, for
 example using a mutex mechanism to block other conflicting traffic
 for cases where such conflicts are possible."

Given you must not issue a second request to a given protocol until
the response is received (unless you issue an abort) you can't safely
do anything if we assume userspace might be using the DOE directly
other than by issuing an abort every time.

I had previously missed that a DOE busy clear can cause an interrupt
but that would only avoid us polling for busy (probably not worth
the handling code). It doesn't help us with this problem.

> 
> >   
> > > Hence it's a reset every
> > > time you use the DOE from in the kernel.    
> > 
> > I would expect:
> > 
> > pci_cfg_access_lock()
> > if (busy)
> >     reset();  
> 
> No, it would need to be unconditional, or you might get a response
> to a previously issued request mid way through your operation, and you
> can't in general tell that it wasn't the response to your request.
> For example you might get the wrong part of CDAT. You'd need to read
> the whole of CDAT to then verify the checksum to detect this had happened.
> 
> > do_doe_operation();
> > pci_cfg_access_unlock();
> >   
> > > Personally I think that this
> > > is fixing a problem that doesn't exist.    
> > 
> > Again this is all stemming from the driver handling "busy" especially
> > with the knowledged that it did not busy it itself.  
> 
> As above, busy doesn't do what it's name might suggest. It doesn't
> mean there is a request / response pair in flight.
> 
> >   
> > > Userspace should not access
> > > the DOE when a driver is loaded in exactly the same way it shouldn't
> > > be writing to anywhere else in config space under normal circumstances.    
> > 
> > DOE has data that is similar to what can be retrieved via config read,
> > it just so happens that reading that data triggers writes. DOE is in a
> > different class than other configuration writes in terms of the
> > userspace motivation to access it.  
> 
> For CDAT yes, for other protocols, (e.g. IDE, CXL compliance) definitely not.
> Using the protocols is as destructive as a write to config space.
> 
> >   
> > > I really don't see this as special. If we think it is special then
> > > we should provide a safe interface.    
> > 
> >   
> > >
> > > Given it's nearly done, I might send out the ioctl proposal and
> > > we can can just decide to leave it unmerged for now, pending real
> > > usecases being established.    
> > 
> > Fair enough.  
> 

