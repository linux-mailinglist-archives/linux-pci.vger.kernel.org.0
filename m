Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42F5C3112CE
	for <lists+linux-pci@lfdr.de>; Fri,  5 Feb 2021 21:53:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbhBETJB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 5 Feb 2021 14:09:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233425AbhBETIw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 5 Feb 2021 14:08:52 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC22FC06174A
        for <linux-pci@vger.kernel.org>; Fri,  5 Feb 2021 12:49:39 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id 100so1496056otg.3
        for <linux-pci@vger.kernel.org>; Fri, 05 Feb 2021 12:49:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Lr882EkfjgIsvdM1clwz3khcZW4BNBCFGiDNJJpB7Bg=;
        b=BcjUt0uYvgtCfSuiPgkFbjM7mZ+kOxsCSW2cg5TTJBgTsU5gUxboI6pamxWeOKHaGj
         KJw8GDvDO7tYzNAGkiqUdcYxpQKYYl2FuujS3ZhW3dgyiPIxFaMMyfJ+VbNt+w32vPyg
         z/UQvUDfXTuPuWlyCTCARBi33gzOzjHeSiiR8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Lr882EkfjgIsvdM1clwz3khcZW4BNBCFGiDNJJpB7Bg=;
        b=fR97zdXcoQyUf2esfaPmQyo0I1cDLgmXrgH4zs36c8coyA5BVZgcFAXK9ird2CynfG
         YjaQdcA7cUIuDKzqRWeBsUS8gsOgXWV7Y7fPDmk8LO0aPZnOFmftUB9Oxrgftu7myuDr
         dj8M+q/vhhUd3J6ljNMDK5Mn1HAfrvDuQgl15soU35MKJ2Cg8NjzHZdytQOCHX0PADj9
         N7AOa9I/YmKICsREv/C7WnJBJu1VenedZ1uElenmMd248Hc8dl10aZ//QagAikJPUna8
         Fo0RRdRaBN8yopkWq/89PafKE5cx64LLTtmCaa11O8wgU0FDTiuO1bILKNcbDVN82v46
         F0ZA==
X-Gm-Message-State: AOAM5332Zpl4Avj2aHo3mS7qxXj2+2OeC5RYiUfc6gQRBSapKHstsF1V
        xukkGcVx77MttMVRlJINUK4R5pX6BuHiiXjUieGmH9pGCQxnIw==
X-Google-Smtp-Source: ABdhPJyvdk5MQ4d2yg6RbswXWQfv0b2vgrgUc2sqpm2jKnfBOAaXytK/RCz1a3xNBD28WBomchV7JEn1knLS16vrefE=
X-Received: by 2002:a9d:2270:: with SMTP id o103mr357757ota.303.1612558178970;
 Fri, 05 Feb 2021 12:49:38 -0800 (PST)
MIME-Version: 1.0
References: <20210205194541.GA191443@bjorn-Precision-5520> <c216efcc-6c81-8a7e-a823-1ddb62ebddb7@amd.com>
In-Reply-To: <c216efcc-6c81-8a7e-a823-1ddb62ebddb7@amd.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Fri, 5 Feb 2021 21:49:27 +0100
Message-ID: <CAKMK7uEKs=g817+ahvsQxv1qVx8yTWC3qZyu8T2ojd82yv+ayg@mail.gmail.com>
Subject: Re: Avoid MMIO write access after hot unplug [WAS - Re: Question
 about supporting AMD eGPU hot plug case]
To:     Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "s.miroshnichenko@yadro.com" <s.miroshnichenko@yadro.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Antonovitch, Anatoli" <Anatoli.Antonovitch@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Feb 5, 2021 at 9:42 PM Andrey Grodzovsky
<Andrey.Grodzovsky@amd.com> wrote:
>
>
>
> On 2/5/21 2:45 PM, Bjorn Helgaas wrote:
> > On Fri, Feb 05, 2021 at 11:08:45AM -0500, Andrey Grodzovsky wrote:
> >> On 2/5/21 10:38 AM, Bjorn Helgaas wrote:
> >>> On Thu, Feb 04, 2021 at 11:03:10AM -0500, Andrey Grodzovsky wrote:
> >>>> + linux-pci mailing list and a bit of extra details bellow.
> >>>>
> >>>> On 2/2/21 12:51 PM, Andrey Grodzovsky wrote:
> >>>>> Bjorn, Sergey I would also like to use this opportunity to ask you =
a
> >>>>> question on a related topic - Hot unplug.
> >>>>> I've been working for a while on this (see latest patchset set here
> >>>>> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2=
Flists.freedesktop.org%2Farchives%2Famd-gfx%2F2021-January%2F058595.html&am=
p;data=3D04%7C01%7CAndrey.Grodzovsky%40amd.com%7C67eb867f5714488f604608d8ca=
0ea0c8%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637481511484863191%7CUn=
known%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJ=
XVCI6Mn0%3D%7C1000&amp;sdata=3DsPRG9cnJDUPR%2FJ1%2Bls0zM6Bidut6bbT%2BpCYuuf=
nc24Q%3D&amp;reserved=3D0).
> >>>>> My question is specifically regarding this patch
> >>>>> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2=
Flists.freedesktop.org%2Farchives%2Famd-gfx%2F2021-January%2F058606.html&am=
p;data=3D04%7C01%7CAndrey.Grodzovsky%40amd.com%7C67eb867f5714488f604608d8ca=
0ea0c8%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637481511484863191%7CUn=
known%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJ=
XVCI6Mn0%3D%7C1000&amp;sdata=3DYsGsXwyK%2FtiErUONC9BbcXcceGcljtbnOBWb131kl%=
2FI%3D&amp;reserved=3D0
> >>>>> - the idea here is to
> >>>>> prevent any accesses to MMIO address ranges still mapped in kernel =
page
> >>>
> >>> I think you're talking about a PCI BAR that is mapped into a user
> >>> process.
> >>
> >> For user mappings, including MMIO mappings, we have a reliable
> >> approach where we invalidate device address space mappings for all
> >> user on first sign of device disconnect and then on all subsequent
> >> page faults from the users accessing those ranges we insert dummy
> >> zero page into their respective page tables. It's actually the
> >> kernel driver, where no page faulting can be used such as for user
> >> space, I have issues on how to protect from keep accessing those
> >> ranges which already are released by PCI subsystem and hence can be
> >> allocated to another hot plugging device.
> >
> > That doesn't sound reliable to me, but maybe I don't understand what
> > you mean by the "first sign of device disconnect."
>
> See functions drm_dev_enter, drm_dev_exit and drm_dev_unplug in drm_derv.=
c
>
> At least from a PCI
> > perspective, the first sign of a surprise hot unplug is likely to be
> > an MMIO read that returns ~0.
>
> We set drm_dev_unplug in amdgpu_pci_remove and base all later checks
> with drm_dev_enter/drm_dev_exit on this
>
> >
> > It's true that the hot unplug will likely cause an interrupt and we
> > *may* be able to unbind the driver before the driver or a user program
> > performs an MMIO access, but there's certainly no guarantee.  The
> > following sequence is always possible:
> >
> >    - User unplugs PCIe device
> >    - Bridge raises hotplug interrupt
> >    - Driver or userspace issues MMIO read
> >    - Bridge responds with error because link to device is down
> >    - Host bridge receives error, fabricates ~0 data to CPU
> >    - Driver or userspace sees ~0 data from MMIO read
> >    - PCI core fields hotplug interrupt and unbinds driver
> >
> >>> It is impossible to reliably *prevent* MMIO accesses to a BAR on a
> >>> PCI device that has been unplugged.  There is always a window
> >>> where the CPU issues a load/store and the device is unplugged
> >>> before the load/store completes.
> >>>
> >>> If a PCIe device is unplugged, an MMIO read to that BAR will
> >>> complete on PCIe with an uncorrectable fatal error.  When that
> >>> happens there is no valid data from the PCIe device, so the PCIe
> >>> host bridge typically fabricates ~0 data so the CPU load
> >>> instruction can complete.
> >>>
> >>> If you want to reliably recover from unplugs like this, I think
> >>> you have to check for that ~0 data at the important points, i.e.,
> >>> where you make decisions based on the data.  Of course, ~0 may be
> >>> valid data in some cases.  You have to use your knowledge of the
> >>> device programming model to determine whether ~0 is possible, and
> >>> if it is, check in some other way, like another MMIO read, to tell
> >>> whether the read succeeded and returned ~0, or failed because of
> >>> PCIe error and returned ~0.
> >>
> >> Looks like there is a high performance price to pay for this
> >> approach if we protect at every possible junction (e.g. register
> >> read/write accessors ), I tested this by doing 1M read/writes while
> >> using drm_dev_enter/drm_dev_exit which is DRM's RCU based guard
> >> against device unplug and even then we hit performance penalty of
> >> 40%. I assume that with actual MMIO read (e.g.
> >> pci_device_is_present)  will cause a much larger performance
> >> penalty.
> >
> > I guess you have to decide whether you want a fast 90% solution or a
> > somewhat slower 100% reliable solution :)
> >
> > I don't think the checking should be as expensive as you're thinking.
> > You only have to check if:
> >
> >    (1) you're doing an MMIO read (there's no response for MMIO writes,
> >        so you can't tell whether they succeed),
> >    (2) the MMIO read returns ~0,
> >    (3) ~0 might be a valid value for the register you're reading, and
> >    (4) the read value is important to your control flow.
> >
> > For example, if you do a series of reads and act on the data after all
> > the reads complete, you only need to worry about whether the *last*
> > read failed.  If that last read is to a register that is known to
> > contain a zero bit, no additional MMIO read is required and the
> > checking is basically free.
>
> I am more worried about MMIO writes to avoid writing to a BAR
> of a newly 'just' plugged in device that got accidentally allocated some
> part of MMIO addresses range that our 'ghost' device still using.

We have to shut all these down before the ->remove callback has
finished. At least that's my understanding, before that's all done the
pci subsystem wont reallocate anything.

The drm_dev_enter/exit is only meant to lock out entire code paths
when we know the device is gone, so that we don't spend an eternity
timing out every access and running lots of code for no point. The
other reason for drm_dev_exit is to guard the sw side from access of
data structures which we tear down (or have to tear down) as part of
->remove callback, like io remaps, maybe timers/workers driving hw
access and all these things. Only the uapi objects need to stay around
until userspace has closed all the fd/unmapped all the mappings so
that we don't oops all over the place.

Of course auditing a big driver like amdgpu for this is massive pain,
so where/how you sprinkle drm_dev_enter/exit over it is a bit an
engineering tradeoff.

Either way (if my understanding is correct), after ->remove is
finished, your driver _must_ guarantee that all access to mmio ranges
has stopped. How you do that is kinda up to you.

But also like Bjorn pointed out, _while_ the hotunplug is happening,
i.e. at any moment between when transactions start failing up to and
including you driver's ->remove callback having finished, you need to
be able to cope with the bogus all-0xff replies in your code. But
that's kinda an orthogonal requirement: If you've fixed the use-after
free you might still crash on 0xff, and even if you fixed the all the
crashes due to 0xff reads you might still have lots of use-after frees
around.

Cheers, Daniel

> Andrey
>
> >
> >>>>> table by the driver AFTER the device is gone physically and
> >>>>> from the PCI  subsystem, post pci_driver.remove call back
> >>>>> execution. This happens because struct device (and struct
> >>>>> drm_device representing the graphic card) are still present
> >>>>> because some user clients which  are not aware of hot removal
> >>>>> still hold device file open and hence prevents device refcount
> >>>>> to drop to 0. The solution in this patch is brute force where
> >>>>> we try and find any place we access MMIO mapped to kernel
> >>>>> address space and guard against the write access with a
> >>>>> 'device-unplug' flag. This solution is obliviously racy
> >>>>> because a device can be unplugged right after checking the
> >>>>> falg.  I had an idea to instead not release but to keep those
> >>>>> ranges reserved even after pci_driver.remove, until DRM device
> >>>>> is destroyed when it's refcount drops to 0 and by this to
> >>>>> prevent new devices plugged in and allocated some of the same
> >>>>> MMIO address  range to get accidental writes into their
> >>>>> registers.  But, on dri-devel I was advised that this will
> >>>>> upset the PCI subsystem and so best to be avoided but I still
> >>>>> would like another opinion from PCI experts on whether this
> >>>>> approach is indeed not possible ?



--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
