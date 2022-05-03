Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E09C6518975
	for <lists+linux-pci@lfdr.de>; Tue,  3 May 2022 18:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239247AbiECQRx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 May 2022 12:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239137AbiECQRw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 May 2022 12:17:52 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D50E43A195;
        Tue,  3 May 2022 09:14:18 -0700 (PDT)
Received: from fraeml744-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Kt4hJ65g4z67tG2;
        Wed,  4 May 2022 00:11:12 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml744-chm.china.huawei.com (10.206.15.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 3 May 2022 18:14:16 +0200
Received: from localhost (10.202.226.42) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 3 May
 2022 17:14:15 +0100
Date:   Tue, 3 May 2022 17:14:13 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     "Weiny, Ira" <ira.weiny@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        <linux-cxl@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: [PATCH V8 04/10] cxl/pci: Create auxiliary devices for each DOE
 mailbox
Message-ID: <20220503171413.00001297@Huawei.com>
In-Reply-To: <CAPcyv4huH2TPnVEzMmsKR=EGXv5A-4wd38M2nzRa-tkxeECV_Q@mail.gmail.com>
References: <20220414203237.2198665-1-ira.weiny@intel.com>
        <20220414203237.2198665-5-ira.weiny@intel.com>
        <20220427181942.00003492@Huawei.com>
        <YmsCfHf/HMuqBkTk@iweiny-server>
        <20220429173843.00006dcd@Huawei.com>
        <CAPcyv4huH2TPnVEzMmsKR=EGXv5A-4wd38M2nzRa-tkxeECV_Q@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhreml723-chm.china.huawei.com (10.201.108.74) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 29 Apr 2022 10:01:09 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> On Fri, Apr 29, 2022 at 9:39 AM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> >
> > On Thu, 28 Apr 2022 14:09:38 -0700
> > ira.weiny@intel.com wrote:
> >  
> > > On Wed, Apr 27, 2022 at 06:19:42PM +0100, Jonathan Cameron wrote:  
> > > > On Thu, 14 Apr 2022 13:32:31 -0700
> > > > ira.weiny@intel.com wrote:
> > > >  
> > > > > From: Ira Weiny <ira.weiny@intel.com>
> > > > >
> > > > > CXL kernel drivers optionally need to access DOE mailbox capabilities.
> > > > > Access to mailboxes for things such as CDAT, SPDM, and IDE are needed by
> > > > > the kernel while other access is designed towards user space usage.  An
> > > > > example of this is for CXL Compliance Testing (see CXL 2.0 14.16.4
> > > > > Compliance Mode DOE) which offers a mechanism to set different test
> > > > > modes for a device.
> > > > >
> > > > > There is no anticipated need for the kernel to share an individual
> > > > > mailbox with user space.  Thus developing an interface to marshal access
> > > > > between the kernel and user space for a single mailbox is unnecessary
> > > > > overhead.  However, having the kernel relinquish some mailboxes to be
> > > > > controlled by user space is a reasonable compromise to share access to
> > > > > the device.
> > > > >
> > > > > The auxiliary bus provides an elegant solution for this.  Each DOE
> > > > > capability is given its own auxiliary device.  This device is controlled
> > > > > by a kernel driver by default which restricts access to the mailbox.
> > > > > Unbinding the driver from a single auxiliary device (DOE mailbox
> > > > > capability) frees the mailbox for user space access.  This architecture
> > > > > also allows a clear picture on which mailboxes are kernel controlled vs
> > > > > not.
> > > > >
> > > > > Iterate each DOE mailbox capability and create auxiliary bus devices.
> > > > > Follow on patches will define a driver for the newly created devices.
> > > > >
> > > > > sysfs shows the devices.
> > > > >
> > > > > $ ls -l /sys/bus/auxiliary/devices/
> > > > > total 0
> > > > > lrwxrwxrwx 1 root root 0 Mar 24 10:47 cxl_pci.doe.0 -> ../../../devices/pci0000:bf/0000:bf:00.0/0000:c0:00.0/cxl_pci.doe.0
> > > > > lrwxrwxrwx 1 root root 0 Mar 24 10:47 cxl_pci.doe.1 -> ../../../devices/pci0000:bf/0000:bf:01.0/0000:c1:00.0/cxl_pci.doe.1
> > > > > lrwxrwxrwx 1 root root 0 Mar 24 10:47 cxl_pci.doe.2 -> ../../../devices/pci0000:35/0000:35:00.0/0000:36:00.0/cxl_pci.doe.2
> > > > > lrwxrwxrwx 1 root root 0 Mar 24 10:47 cxl_pci.doe.3 -> ../../../devices/pci0000:35/0000:35:01.0/0000:37:00.0/cxl_pci.doe.3
> > > > > lrwxrwxrwx 1 root root 0 Mar 24 10:47 cxl_pci.doe.4 -> ../../../devices/pci0000:35/0000:35:00.0/0000:36:00.0/cxl_pci.doe.4
> > > > > lrwxrwxrwx 1 root root 0 Mar 24 10:47 cxl_pci.doe.5 -> ../../../devices/pci0000:bf/0000:bf:00.0/0000:c0:00.0/cxl_pci.doe.5
> > > > > lrwxrwxrwx 1 root root 0 Mar 24 10:47 cxl_pci.doe.6 -> ../../../devices/pci0000:35/0000:35:01.0/0000:37:00.0/cxl_pci.doe.6
> > > > > lrwxrwxrwx 1 root root 0 Mar 24 10:47 cxl_pci.doe.7 -> ../../../devices/pci0000:bf/0000:bf:01.0/0000:c1:00.0/cxl_pci.doe.7
> > > > >
> > > > > Signed-off-by: Ira Weiny <ira.weiny@intel.com>  
> > > >
> > > > I'm not 100% happy with effectively having one solution for CXL
> > > > and probably a different one for DOEs on switch ports
> > > > (which I just hacked into a port service driver to convince
> > > > myself there was at least one plausible way of doing that) but if
> > > > this effectively separates the two discussions then I guess I can
> > > > live with it for now ;)  
> > >
> > > I took some time this morning to mull this over and talk to Dan...
> > >
> > > :-(
> > >
> > > Truthfully the aux driver does very little except provide a way for admins to
> > > trigger the driver to stop/start accessing the Mailbox.
> > >
> > > I suppose a simple sysfs interface could be done to do the same?
> > >
> > > I'll let Dan weigh in here.  
> >
> > I wonder if best short term option is to not provide a means of
> > removing it at all (separate from the PCI driver that is).
> > Then we can take our time to decide on the interface if we ever
> > get much demand for one.
> >  
> > >  
> > > >
> > > > Once this is merged we can start the discussion about how to
> > > > handle switch ports with DOEs both for CDAT and SPDM.  
> > >
> > > I'm ok with that too.  However, I was thinking that this was not a user ABI.
> > > But it really is.  If user space starts writing script to unbind drivers and
> > > then we drop the aux driver support it will break them...
> > >  
> > > >
> > > > I'll send out an RFC that is so hideous it will get people to
> > > > suggestion how to do it better!  
> > >
> > > I think I'd like to see that.  
> >
> > Fair enough. It may muddy the waters a bit :( I'll send an RFC
> > next week.  I've not looked at how the CXL region code etc would
> > actually get to the latency / bandwidth info from the driver yet
> > it just goes as far as reading a CDAT length. I also want to actually
> > hook up some decent switch CDAT emulation in the QEMU code
> > (right now it's giving the same default table as for a type 3 device).
> >
> > I just hope we don't bikeshed around the RFC in a fashion that slows
> > this series moving forwards.  
> 
> I think we have time in the sense that the worst that happens is that
> tooling picks the wrong CFMWS to dynamically create a region and the
> performance ends up being sub-optimal. That's tolerable to work around
> in userspace in the near term. I want to get some wider confidence in
> the DOE ABI with respect to the known protocols and what to do about
> the vendor-specific protocols that may conflict and will be driven
> from userspace issued config-cycles. 
Hi Dan,

Ok, though I would like to try to push the conversation forwards beyond where
we got to last year. IIRC the general conclusion was that all protocols
sharing a DOE instance (and more generally because they all share
discovery) must be mediated by the kernel and that we would not be
supporting a generic access interface (there was one in a much earlier
version of this patch set).  Whilst it's far from the only thing that needs
resolving, this DOE question is also a blocker on getting anywhere with
CMA/SPDM.  Unbinding a driver as the means to stop the kernel accessing
a DOE is reliant on the host driver not deciding to do any more protocol
discovery - we can probably rely on that but it's not pretty.

> That likely means that no DOE ABI
> is the best ABI to start which means not moving forward with
> aux-devices so scripts do not become attached to something that is not
> fully committed to being carried forward.

This isn't really DOE ABI we are currently discussing, it's a CXL subsystem ABI.
If we decided to only expose the DOE as an internal implementation
detail (calls made directly from appropriate existing CXL driver) then
there wouldn't be an ABI question. We would be limiting DOE access
for other protocols but personally I don't see that as a problem
in the short to medium term.

Things may be more 'interesting' for the PCIe port services driver though
(see RFC just sent out)
https://lore.kernel.org/linux-cxl/20220503153449.4088-1-Jonathan.Cameron@huawei.com/T/#t
Perhaps if we can resolve what that should look like, the CXL EP side
of things will be much easier to figure out?

> 
> I still want to refresh the request_config_region() support for at
> least having the kernel warn on userspace conflicting configuration
> writes to config areas claimed by a driver.

Great, that seems like a sensible step to do in parallel.

Jonathan


