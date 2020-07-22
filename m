Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC198229B36
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jul 2020 17:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbgGVPV1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Jul 2020 11:21:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:46722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727778AbgGVPV1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 22 Jul 2020 11:21:27 -0400
Received: from localhost (mobile-166-175-191-139.mycingular.net [166.175.191.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B19362068F;
        Wed, 22 Jul 2020 15:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595431286;
        bh=MX48ABVUqy2xeiw9Zt3yJcZFN+gSzmjiN7Ad2W9zbaM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=fgY5qr4gCXXFoH05PL/Habl6oLCj8rFfPmXFImau3YiAZ4FNfOk3vPDdmUxiLgm9L
         nsVnNX1tAa9jFJXKPyPMoZu8Nx/XL3fMSXOjrOy1PWWjTKSeTxzZkQxV3C1N1fRfqr
         SWoQMYmLuiebIcXHfXkevGW1bkQzj+4MEpUb+V50=
Date:   Wed, 22 Jul 2020 10:21:23 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kairui Song <kasong@redhat.com>
Cc:     Baoquan He <bhe@redhat.com>,
        Deepa Dinamani <deepa.kernel@gmail.com>, jroedel@suse.de,
        Myron Stowe <myron.stowe@redhat.com>,
        linux-pci@vger.kernel.org, kexec@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Randy Wright <rwright@hpe.com>,
        Jerry Hoemann <jerry.hoemann@hpe.com>,
        Dave Young <dyoung@redhat.com>,
        Khalid Aziz <khalid@gonehiking.org>
Subject: Re: [RFC PATCH] PCI, kdump: Clear bus master bit upon shutdown in
 kdump kernel
Message-ID: <20200722152123.GA1278089@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACPcB9cpEX-uYeTp7DVEXtwDRWBCTVoPCB4dxPbyq1sDeixP_w@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 22, 2020 at 10:52:26PM +0800, Kairui Song wrote:
> On Fri, Mar 6, 2020 at 5:38 PM Baoquan He <bhe@redhat.com> wrote:
> > On 03/04/20 at 08:53pm, Deepa Dinamani wrote:
> > > On Wed, Mar 4, 2020 at 7:53 PM Baoquan He <bhe@redhat.com> wrote:
> > > > On 03/03/20 at 01:01pm, Deepa Dinamani wrote:
> > > > > I looked at this some more. Looks like we do not clear irqs
> > > > > when we do a kexec reboot. And, the bootup code maintains
> > > > > the same table for the kexec-ed kernel. I'm looking at the
> > > > > following code in
> > > >
> > > > I guess you are talking about kdump reboot here, right? Kexec
> > > > and kdump boot take the similar mechanism, but differ a
> > > > little.
> > >
> > > Right I meant kdump kernel here. And, clearly the
> > > is_kdump_kernel() case below.
> > >
> > > > > intel_irq_remapping.c:
> > > > >
> > > > >         if (ir_pre_enabled(iommu)) {
> > > > >                 if (!is_kdump_kernel()) {
> > > > >                         pr_warn("IRQ remapping was enabled on %s but
> > > > > we are not in kdump mode\n",
> > > > >                                 iommu->name);
> > > > >                         clear_ir_pre_enabled(iommu);
> > > > >                         iommu_disable_irq_remapping(iommu);
> > > > >                 } else if (iommu_load_old_irte(iommu))
> > > >
> > > > Here, it's for kdump kernel to copy old ir table from 1st kernel.
> > >
> > > Correct.
> > >
> > > > >                         pr_err("Failed to copy IR table for %s from
> > > > > previous kernel\n",
> > > > >                                iommu->name);
> > > > >                 else
> > > > >                         pr_info("Copied IR table for %s from previous kernel\n",
> > > > >                                 iommu->name);
> > > > >         }
> > > > >
> > > > > Would cleaning the interrupts(like in the non kdump path
> > > > > above) just before shutdown help here? This should clear the
> > > > > interrupts enabled for all the devices in the current
> > > > > kernel. So when kdump kernel starts, it starts clean. This
> > > > > should probably help block out the interrupts from a device
> > > > > that does not have a driver.
> > > >
> > > > I think stopping those devices out of control from continue
> > > > sending interrupts is a good idea. While not sure if only
> > > > clearing the interrupt will be enough. Those devices which
> > > > will be initialized by their driver will brake, but devices
> > > > which drivers are not loaded into kdump kernel may continue
> > > > acting. Even though interrupts are cleaning at this time, the
> > > > on-flight DMA could continue triggerring interrupt since the
> > > > ir table and iopage table are rebuilt.
> > >
> > > This should be handled by the IOMMU, right? And, hence you are
> > > getting UR. This seems like the correct execution flow to me.
> >
> > Sorry for late reply.
> > Yes, this is initializing IOMMU device.
> >
> > > Anyway, you could just test this theory by removing the
> > > is_kdump_kernel() check above and see if it solves your problem.
> > > Obviously, check the VT-d spec to figure out the exact sequence to
> > > turn off the IR.
> >
> > OK, I will talk to Kairui and get a machine to test it. Thanks for your
> > nice idea, if you have a draft patch, we are happy to test it.
> >
> > > Note that the device that is causing the problem here is a legit
> > > device. We want to have interrupts from devices we don't know about
> > > blocked anyway because we can have compromised firmware/ devices that
> > > could cause a DoS attack. So blocking the unwanted interrupts seems
> > > like the right thing to do here.
> >
> > Kairui said it's a device which driver is not loaded in kdump kernel
> > because it's not needed by kdump. We try to only load kernel modules
> > which are needed, e.g one device is the dump target, its driver has to
> > be loaded in. In this case, the device is more like a out of control
> > device to kdump kernel.
> 
> Hi Bao, Deepa, sorry for this very late response. The test machine was
> not available for sometime, and I restarted to work on this problem.
> 
> For the workaround mention by Deepa (by remote the is_kdump_kernel()
> check), it didn't work, the machine still hangs upon shutdown.
> The devices that were left in an unknown state and sending interrupt
> could be a problem, but it's irrelevant to this hanging problem.
> 
> I think I didn't make one thing clear, The PCI UR error never arrives
> in kernel, it's the iLo BMC on that HPE machine caught the error, and
> send kernel an NMI. kernel is panicked by NMI, I'm still trying to
> figure out why the NMI hanged kernel, even with panic=-1,
> panic_on_io_nmi, panic_on_unknown_nmi all set. But if we can avoid the
> NMI by shutdown the devices in right order, that's also a solution.

I'm not sure how much sympathy to have for this situation.  A PCIe UR
is fatal for the transaction and maybe even the device, but from the
overall system point of view, it *should* be a recoverable error and
we shouldn't panic.

Errors like that should be reported via the normal AER or ACPI/APEI
mechanisms.  It sounds like in this case, the platform has decided
these aren't enough and it is trying to force a reboot?  If this is
"special" platform behavior, I'm not sure how much we need to cater
for it.

Bjorn
