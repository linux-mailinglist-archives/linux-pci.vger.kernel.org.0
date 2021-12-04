Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F05A468604
	for <lists+linux-pci@lfdr.de>; Sat,  4 Dec 2021 16:48:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346220AbhLDPve (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 4 Dec 2021 10:51:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345456AbhLDPvd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 4 Dec 2021 10:51:33 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4872FC0613F8
        for <linux-pci@vger.kernel.org>; Sat,  4 Dec 2021 07:48:08 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id j5-20020a17090a318500b001a6c749e697so6933704pjb.1
        for <linux-pci@vger.kernel.org>; Sat, 04 Dec 2021 07:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nqvUnLCeeLpcW3ZBr0ywbOsPqI+fmnZMQ3P0UPZpPKg=;
        b=tlaXlEwomAuWx9h/uaJApTdyOVtR8ryT1Q1c7a3CU7vv7cTal1+tPXOyCmpZwnpj3K
         KZX97pPY3lxAjJMgEdkdO82dqXwqR38/EHtDM6UvC4AH+OstXCHm1FJodAtunOrVUW43
         w3LiNZT0M6n8tGmiH8TEGbRF/At9ObfxhoRDrqGUT5hgFV3vhzd8HIS+uuA74tyyDsMl
         Z9Jdbfnw95UqdTH9m44uCvzY+Dy1+d34nUgNfDX7KgulIY/M+YPLNzdSbbsoJmvZYiOc
         9HZAtuPhd+EGaFCrfDRa6Zxykz4U+OydaESWuENVrV99UavZngocsKLC3ktwexZBJsRS
         zbmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nqvUnLCeeLpcW3ZBr0ywbOsPqI+fmnZMQ3P0UPZpPKg=;
        b=MZGWngONrQwjT/onq5UNCGWQl7BqL+BbzPZm/3RJ2L1atiSfeQoo4ms/KSI6P5ekqF
         LYm4w+EpV9Sq284XJzhufpfMf5bb4MO5zJ+m/2fnZtHLLth2m7E9AUrohCCiw0GXl8Nb
         eti73khep1eZ49ILU1Xz/0QhWjx5ECWMgV/CFuyXdLt4M2lHowHW/Tjc7S8wX95ww1ko
         wVfrszBmGB0bhVLfdRBVrPT17LTuAbJNOcQhRgn9oafYD3VfbOvZl1aqmpbPtyIyoYMM
         pU4cqu7I80X64eKFuN7+oba61FQYcTm7rCYKrpLOgmd4G9+r38zFOVE4302VQneNG4V5
         OYiw==
X-Gm-Message-State: AOAM530eIzzxEikq+EnADDzCJI0TZ2QqXeC5xhWzsx1ldUrN1s7DwYR3
        AdcshTkBovhH5Ls9BRv4VC4RLmhjVcJtN3CzT8uvnQ==
X-Google-Smtp-Source: ABdhPJypUw1RJ24mraYt00mmnHI1tJ8IeYN+GP2arfZGc62aIddYcxI2xmDWJwVniM170HvCrBJqFzuYMDFX9vpRQfc=
X-Received: by 2002:a17:902:7fcd:b0:142:8ab3:ec0e with SMTP id
 t13-20020a1709027fcd00b001428ab3ec0emr30455448plb.4.1638632887487; Sat, 04
 Dec 2021 07:48:07 -0800 (PST)
MIME-Version: 1.0
References: <CAPcyv4hDTitnqasVwLTV4QPJqW_ykoJc+hRVRm8aLzG4xBxVag@mail.gmail.com>
 <20211203235617.GA3036259@bhelgaas>
In-Reply-To: <20211203235617.GA3036259@bhelgaas>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sat, 4 Dec 2021 07:47:59 -0800
Message-ID: <CAPcyv4h8Rns_55gqPvn0huvhO4E=iy_PJQ_dKJxxOG=dOOKw9Q@mail.gmail.com>
Subject: Re: [PATCH 2/5] PCI/DOE: Add Data Object Exchange Aux Driver
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Weiny, Ira" <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-cxl@vger.kernel.org,
        Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 3, 2021 at 3:56 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Fri, Dec 03, 2021 at 12:48:18PM -0800, Dan Williams wrote:
> > On Tue, Nov 16, 2021 at 3:48 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > On Fri, Nov 05, 2021 at 04:50:53PM -0700, ira.weiny@intel.com wrote:
> > > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > >
> > > > Introduced in a PCI ECN [1], DOE provides a config space based mailbox
> > > > with standard protocol discovery.  Each mailbox is accessed through a
> > > > DOE Extended Capability.
> > > >
> > > > Define an auxiliary device driver which control DOE auxiliary devices
> > > > registered on the auxiliary bus.
> > >
> > > What do we gain by making this an auxiliary driver?
> > >
> > > This doesn't really feel like a "driver," and apparently it used to be
> > > a library.  I'd like to see the rationale and benefits of the driver
> > > approach (in the eventual commit log as well as the current email
> > > thread).
> >
> > I asked Ira to use the auxiliary bus for DOE primarily for the ABI it
> > offers for userspace to manage kernel vs userspace access to a device.
> > CONFIG_IO_STRICT_DEVMEM set the precedent that userspace can not
> > clobber mmio space that is actively claimed by a kernel driver. I
> > submit that DOE merits the same protection for DOE instances that the
> > kernel consumes.
> >
> > Unlike other PCI configuration registers that root userspace has no
> > reason to touch unless it wants to actively break things, DOE is a
> > mechanism that root userspace may need to access directly in some
> > cases. There are a few examples that come to mind.
>
> It's useful for root to read/write config registers with setpci, e.g.,
> to test ASPM configuration, test power management behavior, etc.  That
> can certainly break things and interfere with kernel access (and IMO
> should taint the kernel) but we have so far accepted that risk.  I
> think the same will be true for DOE.

I think DOE is a demonstrable step worse than those examples and
pushes into the unacceptable risk category. It invites a communication
protocol with an unbounded range of side effects (especially when
controlling a device like a CXL memory expander that affects "System
RAM" directly). Part of what drives platform / device vendors to the
standards negotiation table is the OS encouraging common interfaces.
If Linux provides an unfettered DOE interface it reduces an incentive
for device vendors to collaborate with the kernel community.

I do like the taint proposal though, if I can't convince you that DOE
merits explicit root userspace lockout beyond
CONFIG_LOCK_DOWN_KERNEL_FORCE_INTEGRITY, I would settle for the kernel
warning loudly about DOE usage that falls outside the kernel's
expectations.

> In addition, I would think you might want a safe userspace interface
> via sysfs, e.g., something like the "vpd" file, but I missed that if
> it was in this series.

I do not think the kernel is well served by a generic userspace
passthrough for DOE for the same reason that there is no generic
passthrough for the ACPI _DSM facility. When the kernel becomes a
generic pipe to a vendor specific interface it impedes the kernel from
developing standard interfaces across vendors. Each vendor will ship
their own quirky feature and corresponding vendor-specific tool with
minimal incentive to coordinate with other vendors doing similar
things. At a minimum the userspace interface for DOE should be at a
level above the raw transport and be enabled per standardized /
published DOE protocol.  I.e. a userspace interface to read the CDAT
table retrieved over DOE, or a userspace interface to enumerate IDE
capabilities, etc.

> > CXL Compliance Testing (see CXL 2.0 14.16.4 Compliance Mode DOE)
> > offers a mechanism to set different test modes for a DOE device. The
> > kernel has no reason to ever use that interface, and it has strong
> > reasons to want to block access to it in production. However, hardware
> > vendors also use debug Linux builds for hardware bringup. So I would
> > like to be able to say that the mechanism to gain access to the
> > compliance DOE is to detach the aux DOE driver from the right aux DOE
> > device. Could we build a custom way to do the same for the DOE
> > library, sure, but why re-invent the wheel when udev and the driver
> > model can handle this type of policy question already?
> >
> > Another use case is SPDM where an agent can establish a secure message
> > passing channel to a device, or paravirtualized device to exchange
> > protected messages with the hypervisor. My expectation is that in
> > addition to the kernel establishing SPDM sessions for PCI IDE and
> > CXL.cachemem IDE (link Integrity and Data Encryption) there will be
> > use cases for root userspace to establish their own SPDM session. In
> > that scenario as well the kernel can be told to give up control of a
> > specific DOE instance by detaching the aux device for its driver, but
> > otherwise the kernel driver can be assured that userspace will not
> > clobber its communications with its own attempts to talk over the DOE.
>
> I assume the kernel needs to control access to DOE in all cases,
> doesn't it?  For example, DOE can generate interrupts, and only the
> kernel can field them.  Maybe if I saw the userspace interface this
> would make more sense to me.  I'm hoping there's a reasonable "send
> this query and give me the response" primitive that can be implemented
> in the kernel, used by drivers, and exposed safely to userspace.

A DOE can generate interrupts, but I have yet to see a protocol that
demands that. The userspace interface in the patches is just a binary
attribute to dump the "CDAT" table retrieved over DOE. No generic
passthrough is provided per the concerns above.

> > Lastly, and perhaps this is minor, the PCI core is a built-in object
> > and aux-bus allows for breaking out device library functionality like
> > this into a dedicated module. But yes, that's not a good reason unto
> > itself because you could "auxify" almost anything past the point of
> > reason just to get more modules.
> >
> > > > A DOE mailbox is allowed to support any number of protocols while some
> > > > DOE protocol specifications apply additional restrictions.
> > >
> > > This sounds something like a fancy version of VPD, and VPD has been a
> > > huge headache.  I hope DOE avoids that ;)
> >
> > Please say a bit more, I think DOE is a rather large headache as
> > evidenced by us fine folks grappling with how to architect the Linux
> > enabling.
>
> VPD is not widely used, so gets poor testing.  The device doesn't tell
> us how much VPD it has, so we have to read until the end.  The data is
> theoretically self-describing (series of elements, each containing a
> type and size), but of course some devices don't format it correctly,
> so we read to the absolute limit, which takes a long time.
>
> Typical contents of unimplemented or uninitialized VPD are all 0x00 or
> all 0xff, neither of which is defined as a valid "end of VPD" signal,
> so we have hacky "this doesn't look like VPD" code.
>
> The PCI core doesn't need VPD itself and should only need to look for
> the size of each element and the "end" tag, but it works around some
> issues by doing more interpretation of the data.  The spec is a little
> ambiguous and leaves room for vendors to use types not mentioned in
> the spec.
>
> Some devices share VPD hardware across functions but don't protect it
> correctly (a hardware defect, granted).
>
> VPD has address/data registers, so it requires locking, polling for
> completion, and timeouts.

Yikes, yes, that sounds like a headache.
