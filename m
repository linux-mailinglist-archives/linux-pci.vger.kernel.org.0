Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5D84680FE
	for <lists+linux-pci@lfdr.de>; Sat,  4 Dec 2021 00:58:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383513AbhLCX7p (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Dec 2021 18:59:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354194AbhLCX7o (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Dec 2021 18:59:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24107C061751;
        Fri,  3 Dec 2021 15:56:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC12462D37;
        Fri,  3 Dec 2021 23:56:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC825C339E0;
        Fri,  3 Dec 2021 23:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638575779;
        bh=4ebFvjD7ctaKPY4TFisyD53nB9ROY3SLoLJQr8EafnE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=oyv3A5Hn5byvgTdfNU6Kv/MZz5khloWI836IXW1dz+NPIFf1mwDeV03zhI0Q1em1+
         oZhgvqyw0QtlHrDgnAE4seFCvs+pRecwq+rHQyh+uQbwCD2ZNu78dSBQDo0+o+VBhf
         R6kRfuv83JNZqueSZtne44b3CePZGz0CM8lhTEFaZUMvLHr3kCkOcbLOvRwJ6ofyB0
         5EB4DNSiS+KgBGvVLO7pyvWFC3nXsAsIPUu0rFuxFqiemDIB6Jq+iuS0gtgmTp3gwB
         dB7amK5gyEQLIiiWx6sgj1+1wIeL/lmx3VQ6cTe9rMLyduasP6GaVHOCCTEGhdBH01
         cnfOM/hOfD4RQ==
Date:   Fri, 3 Dec 2021 17:56:17 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     "Weiny, Ira" <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-cxl@vger.kernel.org,
        Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 2/5] PCI/DOE: Add Data Object Exchange Aux Driver
Message-ID: <20211203235617.GA3036259@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4hDTitnqasVwLTV4QPJqW_ykoJc+hRVRm8aLzG4xBxVag@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 03, 2021 at 12:48:18PM -0800, Dan Williams wrote:
> On Tue, Nov 16, 2021 at 3:48 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Fri, Nov 05, 2021 at 04:50:53PM -0700, ira.weiny@intel.com wrote:
> > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > >
> > > Introduced in a PCI ECN [1], DOE provides a config space based mailbox
> > > with standard protocol discovery.  Each mailbox is accessed through a
> > > DOE Extended Capability.
> > >
> > > Define an auxiliary device driver which control DOE auxiliary devices
> > > registered on the auxiliary bus.
> >
> > What do we gain by making this an auxiliary driver?
> >
> > This doesn't really feel like a "driver," and apparently it used to be
> > a library.  I'd like to see the rationale and benefits of the driver
> > approach (in the eventual commit log as well as the current email
> > thread).
> 
> I asked Ira to use the auxiliary bus for DOE primarily for the ABI it
> offers for userspace to manage kernel vs userspace access to a device.
> CONFIG_IO_STRICT_DEVMEM set the precedent that userspace can not
> clobber mmio space that is actively claimed by a kernel driver. I
> submit that DOE merits the same protection for DOE instances that the
> kernel consumes.
>
> Unlike other PCI configuration registers that root userspace has no
> reason to touch unless it wants to actively break things, DOE is a
> mechanism that root userspace may need to access directly in some
> cases. There are a few examples that come to mind.

It's useful for root to read/write config registers with setpci, e.g.,
to test ASPM configuration, test power management behavior, etc.  That
can certainly break things and interfere with kernel access (and IMO
should taint the kernel) but we have so far accepted that risk.  I
think the same will be true for DOE.

In addition, I would think you might want a safe userspace interface
via sysfs, e.g., something like the "vpd" file, but I missed that if
it was in this series.

> CXL Compliance Testing (see CXL 2.0 14.16.4 Compliance Mode DOE)
> offers a mechanism to set different test modes for a DOE device. The
> kernel has no reason to ever use that interface, and it has strong
> reasons to want to block access to it in production. However, hardware
> vendors also use debug Linux builds for hardware bringup. So I would
> like to be able to say that the mechanism to gain access to the
> compliance DOE is to detach the aux DOE driver from the right aux DOE
> device. Could we build a custom way to do the same for the DOE
> library, sure, but why re-invent the wheel when udev and the driver
> model can handle this type of policy question already?
> 
> Another use case is SPDM where an agent can establish a secure message
> passing channel to a device, or paravirtualized device to exchange
> protected messages with the hypervisor. My expectation is that in
> addition to the kernel establishing SPDM sessions for PCI IDE and
> CXL.cachemem IDE (link Integrity and Data Encryption) there will be
> use cases for root userspace to establish their own SPDM session. In
> that scenario as well the kernel can be told to give up control of a
> specific DOE instance by detaching the aux device for its driver, but
> otherwise the kernel driver can be assured that userspace will not
> clobber its communications with its own attempts to talk over the DOE.

I assume the kernel needs to control access to DOE in all cases,
doesn't it?  For example, DOE can generate interrupts, and only the
kernel can field them.  Maybe if I saw the userspace interface this
would make more sense to me.  I'm hoping there's a reasonable "send
this query and give me the response" primitive that can be implemented
in the kernel, used by drivers, and exposed safely to userspace.

> Lastly, and perhaps this is minor, the PCI core is a built-in object
> and aux-bus allows for breaking out device library functionality like
> this into a dedicated module. But yes, that's not a good reason unto
> itself because you could "auxify" almost anything past the point of
> reason just to get more modules.
> 
> > > A DOE mailbox is allowed to support any number of protocols while some
> > > DOE protocol specifications apply additional restrictions.
> >
> > This sounds something like a fancy version of VPD, and VPD has been a
> > huge headache.  I hope DOE avoids that ;)
> 
> Please say a bit more, I think DOE is a rather large headache as
> evidenced by us fine folks grappling with how to architect the Linux
> enabling.

VPD is not widely used, so gets poor testing.  The device doesn't tell
us how much VPD it has, so we have to read until the end.  The data is
theoretically self-describing (series of elements, each containing a
type and size), but of course some devices don't format it correctly,
so we read to the absolute limit, which takes a long time.

Typical contents of unimplemented or uninitialized VPD are all 0x00 or
all 0xff, neither of which is defined as a valid "end of VPD" signal,
so we have hacky "this doesn't look like VPD" code.

The PCI core doesn't need VPD itself and should only need to look for
the size of each element and the "end" tag, but it works around some
issues by doing more interpretation of the data.  The spec is a little
ambiguous and leaves room for vendors to use types not mentioned in
the spec.

Some devices share VPD hardware across functions but don't protect it
correctly (a hardware defect, granted).

VPD has address/data registers, so it requires locking, polling for
completion, and timeouts.

Bjorn
