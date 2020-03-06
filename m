Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0712217B967
	for <lists+linux-pci@lfdr.de>; Fri,  6 Mar 2020 10:38:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbgCFJiq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Mar 2020 04:38:46 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58654 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725923AbgCFJiq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 Mar 2020 04:38:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583487524;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I99v9Lz9WEACFzOBHGx8xZ3mdresfCD73R6Fnd1GKl8=;
        b=go63/OO4Vur6mv6pkPdlshFBI1jeAlbsuUOqD+UoaVPhtmfRXWmtxsnNkZMMwj5GiEFnN8
        sMshYxDbH4ID6G2/+5I2CnJbupZe9H+fWE6rJdb4FkK0B2FJo+APPasJZNGqkfXXbwEJMT
        yDNLAa4eS0ZqwAfvs9ZTEl1eIO+jolk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-476-hg8RFOuoNCSEBVIMNva_9Q-1; Fri, 06 Mar 2020 04:38:40 -0500
X-MC-Unique: hg8RFOuoNCSEBVIMNva_9Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ADDFB1084B02;
        Fri,  6 Mar 2020 09:38:38 +0000 (UTC)
Received: from localhost (ovpn-12-25.pek2.redhat.com [10.72.12.25])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B4FD85C54A;
        Fri,  6 Mar 2020 09:38:31 +0000 (UTC)
Date:   Fri, 6 Mar 2020 17:38:29 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     Kairui Song <kasong@redhat.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Khalid Aziz <khalid@gonehiking.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org, kexec@lists.infradead.org,
        Jerry Hoemann <jerry.hoemann@hpe.com>,
        Randy Wright <rwright@hpe.com>, Dave Young <dyoung@redhat.com>,
        Myron Stowe <myron.stowe@redhat.com>, jroedel@suse.de
Subject: Re: [RFC PATCH] PCI, kdump: Clear bus master bit upon shutdown in
 kdump kernel
Message-ID: <20200306093829.GA27711@MiWiFi-R3L-srv>
References: <20191225192118.283637-1-kasong@redhat.com>
 <20200222165631.GA213225@google.com>
 <CACPcB9dv1YPhRmyWvtdt2U4g=XXU7dK4bV4HB1dvCVMTpPFdzA@mail.gmail.com>
 <CABeXuvqm1iUGt1GWC9eujuoaACdPiZ2X=3LjKJ5JXKZcXD_z_g@mail.gmail.com>
 <CABeXuvonZpwWfcUef4PeihTJkgH2ZC_RCKuLR3rH3Re4hx36Aw@mail.gmail.com>
 <20200305035329.GD4433@MiWiFi-R3L-srv>
 <CABeXuvogFGv8-i4jsJYN5ya0hjf35EXLkmPqYWayDUvXaBKidA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABeXuvogFGv8-i4jsJYN5ya0hjf35EXLkmPqYWayDUvXaBKidA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 03/04/20 at 08:53pm, Deepa Dinamani wrote:
> On Wed, Mar 4, 2020 at 7:53 PM Baoquan He <bhe@redhat.com> wrote:
> >
> > +Joerg to CC.
> >
> > On 03/03/20 at 01:01pm, Deepa Dinamani wrote:
> > > I looked at this some more. Looks like we do not clear irqs when we do
> > > a kexec reboot. And, the bootup code maintains the same table for the
> > > kexec-ed kernel. I'm looking at the following code in
> >
> > I guess you are talking about kdump reboot here, right? Kexec and kdump
> > boot take the similar mechanism, but differ a little.
> 
> Right I meant kdump kernel here. And, clearly the is_kdump_kernel() case below.
> 
> >
> > > intel_irq_remapping.c:
> > >
> > >         if (ir_pre_enabled(iommu)) {
> > >                 if (!is_kdump_kernel()) {
> > >                         pr_warn("IRQ remapping was enabled on %s but
> > > we are not in kdump mode\n",
> > >                                 iommu->name);
> > >                         clear_ir_pre_enabled(iommu);
> > >                         iommu_disable_irq_remapping(iommu);
> > >                 } else if (iommu_load_old_irte(iommu))
> >
> > Here, it's for kdump kernel to copy old ir table from 1st kernel.
> 
> Correct.
> 
> > >                         pr_err("Failed to copy IR table for %s from
> > > previous kernel\n",
> > >                                iommu->name);
> > >                 else
> > >                         pr_info("Copied IR table for %s from previous kernel\n",
> > >                                 iommu->name);
> > >         }
> > >
> > > Would cleaning the interrupts(like in the non kdump path above) just
> > > before shutdown help here? This should clear the interrupts enabled
> > > for all the devices in the current kernel. So when kdump kernel
> > > starts, it starts clean. This should probably help block out the
> > > interrupts from a device that does not have a driver.
> >
> > I think stopping those devices out of control from continue sending
> > interrupts is a good idea. While not sure if only clearing the interrupt
> > will be enough. Those devices which will be initialized by their driver
> > will brake, but devices which drivers are not loaded into kdump kernel
> > may continue acting. Even though interrupts are cleaning at this time,
> > the on-flight DMA could continue triggerring interrupt since the ir
> > table and iopage table are rebuilt.
> 
> This should be handled by the IOMMU, right? And, hence you are getting
> UR. This seems like the correct execution flow to me.

Sorry for late reply.
Yes, this is initializing IOMMU device.

> 
> Anyway, you could just test this theory by removing the
> is_kdump_kernel() check above and see if it solves your problem.
> Obviously, check the VT-d spec to figure out the exact sequence to
> turn off the IR.

OK, I will talk to Kairui and get a machine to test it. Thanks for your
nice idea, if you have a draft patch, we are happy to test it.

> 
> Note that the device that is causing the problem here is a legit
> device. We want to have interrupts from devices we don't know about
> blocked anyway because we can have compromised firmware/ devices that
> could cause a DoS attack. So blocking the unwanted interrupts seems
> like the right thing to do here.

Kairui said it's a device which driver is not loaded in kdump kernel
because it's not needed by kdump. We try to only load kernel modules
which are needed, e.g one device is the dump target, its driver has to
be loaded in. In this case, the device is more like a out of control
device to kdump kernel.

