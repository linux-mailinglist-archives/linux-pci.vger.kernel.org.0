Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25EFD382786
	for <lists+linux-pci@lfdr.de>; Mon, 17 May 2021 10:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235760AbhEQIwm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 May 2021 04:52:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:36490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235665AbhEQIwl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 17 May 2021 04:52:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3351760249;
        Mon, 17 May 2021 08:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1621241485;
        bh=hId7nAD1Ib/EPcQ9/xuwnmsWXuP+XKVtIbsyoM0HVYw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bo2dUW/9HGLHTgF9GUO4zynDg4h7qtCsvUXy+KErhoHJgOeNyfzh+xVDQqphhewsu
         Z5gervQcuSdypUUDzUpTXjsdXi2nVimF3TVIALV6M8VN6v+RY3tT9nH+8T2E1C1FHs
         Pfrdf+fu+cQ9FpUfaKSm709qVOlO4FXs8xEIIGTc=
Date:   Mon, 17 May 2021 10:51:23 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-cxl@vger.kernel.org,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Chris Browy <cbrowy@avery-design.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Linuxarm <linuxarm@huawei.com>, Fangjian <f.fangjian@huawei.com>
Subject: Re: [RFC PATCH v3 2/4] PCI/doe: Add Data Object Exchange support
Message-ID: <YKIui/XSLtmQ1azU@kroah.com>
References: <20210419165451.2176200-1-Jonathan.Cameron@huawei.com>
 <20210419165451.2176200-3-Jonathan.Cameron@huawei.com>
 <20210506215934.GJ1904484@iweiny-DESK2.sc.intel.com>
 <20210511175006.00007861@Huawei.com>
 <CAPcyv4j=uww+85b4AbWmoPNPry_+JLEpEnuywpdC8PonXmRmEg@mail.gmail.com>
 <20210514094755.00002081@Huawei.com>
 <CAPcyv4h_qSZq+sTAOTKDNsO3xPmq=65j8oO1iw0WdVFj8+XrOA@mail.gmail.com>
 <20210517094045.00004d58@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210517094045.00004d58@Huawei.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 17, 2021 at 09:40:45AM +0100, Jonathan Cameron wrote:
> On Fri, 14 May 2021 11:37:12 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > On Fri, May 14, 2021 at 1:50 AM Jonathan Cameron
> > <Jonathan.Cameron@huawei.com> wrote:
> > [..]
> > > > If it simplifies the kernel implementation to assume single
> > > > kernel-initiator then I think that's more than enough reason to block
> > > > out userspace, and/or provide userspace a method to get into the
> > > > kernel's queue for service.  
> > >
> > > This last suggestion makes sense to me. Let's provide a 'right' way
> > > to access the DOE from user space. I like the idea if it being possible
> > > to run CXL compliance tests from userspace whilst the driver is loaded.  
> > 
> > Ah, and I like your observation that once the kernel provides a
> > "right" way to access DOE then userspace direct-access of DOE is
> > indeed a "you get to keep the pieces" event like any other unwanted
> > userspace config-write.
> > 
> > > Bjorn, given this would be a generic PCI thing, any preference for what
> > > this interface might look like?   /dev/pcidoe[xxxxxx].i with ioctls similar
> > > to those for the BAR based CXL mailboxes?  
> > 
> > (warning, anti-ioctl bias incoming...)
> 
> I feel very similar about ioctls - my immediate thought was to shove this in
> debugfs, but that feels the wrong choice if we are trying to persuade people
> to use it instead of writing code that directly accesses the config space.
> 
> > 
> > Hmm, DOE has an enumeration capability, could the DOE driver use a
> > scheme to have a sysfs bin_attr per discovered object type? This would
> > make it simliar to the pci-vpd sysfs interface.
> 
> We can discover the protocols, but anything beyond that is protocol
> specific.  I don't think there is a enough info available by any standards
> defined method. Also part of the reason to allow a safe userspace interface
> would be to provide a generic interface for vendor protocols and things like
> CXL compliance tests where we will almost certainly never provide a more
> specific kernel interface.
> 
> Whilst sysfs would work for CDAT, some protocols are challenge response rather
> than simple read back and that really doesn't fit well for sysfs model.
> If we get other protocols that are simple data read back, then I would
> advocate giving them a simple sysfs interface much like proposed for CDAT
> as it will always be simpler to use + self describing.
> 
> On a lesser note it might be helpful to provide sysfs attrs for
> what protocols are supported.  The alternative is to let userspace run
> the discovery protocol. Perhaps we can do this as a later phase.
> 
> > 
> > Then the kernel could cache objects like CDAT that don't change
> > outside of some invalidation event.
> 
> It's been a while since I last saw any conversation on sysfs bin_attrs
> but mostly I thought the feeling was pretty strongly against them for anything
> but a few niche usecases.
> 
> Feels to me like it would break most of the usual rules in a way vpd does
> not (IIRC VPD is supposed to be a simple in the sense that if you write a value
> to a writable part, you will read back the same value).
> 
> +CC Greg who is a fount of knowledge in this area (and regularly + correctly
> screams at the ways I try to abuse sysfs :)  Note I don't think Dan was
> suggesting implementing response / request directly, but I think that is
> all we could do given DOE protocols can be vendor specific and the standard
> discovery protocol doesn't let us know the fine grained support (what commands
> within a given protocol).

sysfs binary files are ONLY for pass-through things that go to/from
userspace/hardware without the kernel touching them at all.  Like raw
PCI config descriptors.

challenge/response type stuff, really does still fit the ioctl model, so
that is a viable solution if needed.

thanks,

greg k-h
