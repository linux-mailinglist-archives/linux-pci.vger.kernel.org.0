Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B701B387603
	for <lists+linux-pci@lfdr.de>; Tue, 18 May 2021 12:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243039AbhERKHN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 May 2021 06:07:13 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:3018 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239454AbhERKHN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 May 2021 06:07:13 -0400
Received: from dggems706-chm.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Fks5j1TxDzlgBY;
        Tue, 18 May 2021 18:03:37 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 dggems706-chm.china.huawei.com (10.3.19.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 18 May 2021 18:05:50 +0800
Received: from localhost (10.52.121.12) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 18 May
 2021 11:05:48 +0100
Date:   Tue, 18 May 2021 11:04:03 +0100
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
Message-ID: <20210518110403.000013e6@Huawei.com>
In-Reply-To: <CAPcyv4iQcV_U1qmQhXKM0RG9v-sAEPwtTxnv=P86yJrCH25k+w@mail.gmail.com>
References: <20210419165451.2176200-1-Jonathan.Cameron@huawei.com>
        <20210419165451.2176200-3-Jonathan.Cameron@huawei.com>
        <20210506215934.GJ1904484@iweiny-DESK2.sc.intel.com>
        <20210511175006.00007861@Huawei.com>
        <CAPcyv4j=uww+85b4AbWmoPNPry_+JLEpEnuywpdC8PonXmRmEg@mail.gmail.com>
        <20210514094755.00002081@Huawei.com>
        <CAPcyv4h_qSZq+sTAOTKDNsO3xPmq=65j8oO1iw0WdVFj8+XrOA@mail.gmail.com>
        <20210517094045.00004d58@Huawei.com>
        <CAPcyv4iQcV_U1qmQhXKM0RG9v-sAEPwtTxnv=P86yJrCH25k+w@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.121.12]
X-ClientProxiedBy: lhreml725-chm.china.huawei.com (10.201.108.76) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 17 May 2021 10:21:14 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> On Mon, May 17, 2021 at 1:42 AM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> >
> > On Fri, 14 May 2021 11:37:12 -0700
> > Dan Williams <dan.j.williams@intel.com> wrote:
> >  
> > > On Fri, May 14, 2021 at 1:50 AM Jonathan Cameron
> > > <Jonathan.Cameron@huawei.com> wrote:
> > > [..]  
> > > > > If it simplifies the kernel implementation to assume single
> > > > > kernel-initiator then I think that's more than enough reason to block
> > > > > out userspace, and/or provide userspace a method to get into the
> > > > > kernel's queue for service.  
> > > >
> > > > This last suggestion makes sense to me. Let's provide a 'right' way
> > > > to access the DOE from user space. I like the idea if it being possible
> > > > to run CXL compliance tests from userspace whilst the driver is loaded.  
> > >
> > > Ah, and I like your observation that once the kernel provides a
> > > "right" way to access DOE then userspace direct-access of DOE is
> > > indeed a "you get to keep the pieces" event like any other unwanted
> > > userspace config-write.
> > >  
> > > > Bjorn, given this would be a generic PCI thing, any preference for what
> > > > this interface might look like?   /dev/pcidoe[xxxxxx].i with ioctls similar
> > > > to those for the BAR based CXL mailboxes?  
> > >
> > > (warning, anti-ioctl bias incoming...)  
> >
> > I feel very similar about ioctls - my immediate thought was to shove this in
> > debugfs, but that feels the wrong choice if we are trying to persuade people
> > to use it instead of writing code that directly accesses the config space.
> >  
> > >
> > > Hmm, DOE has an enumeration capability, could the DOE driver use a
> > > scheme to have a sysfs bin_attr per discovered object type? This would
> > > make it simliar to the pci-vpd sysfs interface.  
> >
> > We can discover the protocols, but anything beyond that is protocol
> > specific.  I don't think there is a enough info available by any standards
> > defined method. Also part of the reason to allow a safe userspace interface
> > would be to provide a generic interface for vendor protocols and things like
> > CXL compliance tests where we will almost certainly never provide a more
> > specific kernel interface.
> >
> > Whilst sysfs would work for CDAT, some protocols are challenge response rather
> > than simple read back and that really doesn't fit well for sysfs model.
> > If we get other protocols that are simple data read back, then I would
> > advocate giving them a simple sysfs interface much like proposed for CDAT
> > as it will always be simpler to use + self describing.
> >
> > On a lesser note it might be helpful to provide sysfs attrs for
> > what protocols are supported.  The alternative is to let userspace run
> > the discovery protocol. Perhaps we can do this as a later phase.
> >  
> > >
> > > Then the kernel could cache objects like CDAT that don't change
> > > outside of some invalidation event.  
> >
> > It's been a while since I last saw any conversation on sysfs bin_attrs
> > but mostly I thought the feeling was pretty strongly against them for anything
> > but a few niche usecases.
> >
> > Feels to me like it would break most of the usual rules in a way vpd does
> > not (IIRC VPD is supposed to be a simple in the sense that if you write a value
> > to a writable part, you will read back the same value).
> >
> > +CC Greg who is a fount of knowledge in this area (and regularly + correctly
> > screams at the ways I try to abuse sysfs :)  Note I don't think Dan was
> > suggesting implementing response / request directly, but I think that is
> > all we could do given DOE protocols can be vendor specific and the standard
> > discovery protocol doesn't let us know the fine grained support (what commands
> > within a given protocol).  
> 
> I'm not all that interested in supporting vendor defined DOE
> shenanigans. There's more than enough published DOE protocols that the
> kernel could limit its support to the known set. This is similar to
> how ACPI DSMs are not generically supported, but when they appear in a
> published specification the kernel may then grow the support. The
> supported protocols could be limited to: CDAT, PCIe IDE, CXL
> Compliance, etc...
> 
> Vendor specific DOE is in the same class as unfettered /dev/mem
> access, first you need to disable the kernel's integrity and
> confidentiality protections, and then you can do whatever you want. If
> a vendor wants a DOE protocol supported in the "trusted" set they can
> simply publish the specification and send the proper support patches.

Fair enough, though the interface should be root only, so a vendor shooting
themselves in the foot this way would be no different to using pcitools
to access the device directly (we are just providing safety from concurrency
point of view).

Anyway, I can see two options for how to do this.

1) Per protocol interface. Would not be generic, as these work in entirely
   different ways (some are simple read back of tables, some require complex
   cycles of operations in the right order with data flowing in both directions)
2) White list those protocols we are going to let through a generic interface
   Not including CXL compliance for instance as that has nasty side effects!

If we want to enable userspace DOE access, I prefer option 2.

Note that I wasn't that keen on a userspace interface in the first place as
in my view these should all be handled in kernel.
Ultimately we should have case 1 if userspace access make sense.
However, if we do this we shouldn't pretend we are providing userspace
access to the DOE at all.  We are providing interfaces to things that just
happen to be implemented using DOE under the hood.

I have a prototype of a trivial ioctl based interface. I'll send it out
as an RFC later this week.  Might add a white list, depending on where
this discussion goes.

Jonathan


