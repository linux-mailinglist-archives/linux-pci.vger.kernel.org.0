Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71E2D31191A
	for <lists+linux-pci@lfdr.de>; Sat,  6 Feb 2021 03:57:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbhBFCyz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 5 Feb 2021 21:54:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbhBFCcM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 5 Feb 2021 21:32:12 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E90C0698C4
        for <linux-pci@vger.kernel.org>; Fri,  5 Feb 2021 14:15:36 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id y11so8422242otq.1
        for <linux-pci@vger.kernel.org>; Fri, 05 Feb 2021 14:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=taGs30p9Jgf4gV/wPi9elUg7cx6ns45kdVRnxK1EwUQ=;
        b=L2F18bYfGoRMooi6v6A+IU/iaDEijwVhvsD4UVGKzPtGF37PpRXw8yFB9abbXEdGVA
         On6iD3KkqPe3J+70D3QsHMan9II/eVIIAF7BPLIxpl6vkrmUNyZy3khlyGuLDX6HOXy+
         vYB0sflij9on2vy9ccpdBMSydqoDBmQfZHdH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=taGs30p9Jgf4gV/wPi9elUg7cx6ns45kdVRnxK1EwUQ=;
        b=ThDAgnXHGHMSHHIoGW+nchYn1+1Z2wJawuxjAEp6c7saEmkskgubUIDXVMsvn/R7FX
         OThWDB35GLnqE8P0oSelWYlWapJhmAuIC7IDXwxDxPSrb3DGp71eduNIO4ylyigy/Qeq
         DjW+kXEdbX08a4L8oCGUfpoAQZu8NtFr701HC6/aKAmyM4hMJtqYBBCk371pJYdvh0J/
         G3CzuDyrueRSb9N6MPiRHu6wJKtc2r2FGbodXKZ6rCDHi/6XS5yKch4tVYJ4HBVY3KkU
         qWJNDhsuwCnlKgNCVHXYQDXdKYZY/NjQVpRuH6tjLBvVDITy/93fMnVFMr0aqGXvJDID
         7Mog==
X-Gm-Message-State: AOAM530DRedK12KFi9YCqDjWTjeKQ1VxaHhRn0YlqyVz1Bl8n5wIMTsg
        Lf1BmyUsN7cEtLsM697O2+an4OQZH8HmnEf9poSnww==
X-Google-Smtp-Source: ABdhPJy5EJ6H5/mqpNyGBkMsS4KXN0cD9B4H1vTM+rBPaFiGLK05l3urYSQR6OMu8W8lkRx0T+ayhegPEOSlFT+SUdg=
X-Received: by 2002:a9d:b85:: with SMTP id 5mr5054831oth.281.1612563335891;
 Fri, 05 Feb 2021 14:15:35 -0800 (PST)
MIME-Version: 1.0
References: <20210205194541.GA191443@bjorn-Precision-5520> <c216efcc-6c81-8a7e-a823-1ddb62ebddb7@amd.com>
 <CAKMK7uEKs=g817+ahvsQxv1qVx8yTWC3qZyu8T2ojd82yv+ayg@mail.gmail.com> <9d0929f1-c7c7-5832-8c9c-3c52084bd56a@amd.com>
In-Reply-To: <9d0929f1-c7c7-5832-8c9c-3c52084bd56a@amd.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Fri, 5 Feb 2021 23:15:25 +0100
Message-ID: <CAKMK7uF4mO91XO-9m-bAgE3wGu1WJV48hPTPWK+VCNwjfeeczg@mail.gmail.com>
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

On Fri, Feb 5, 2021 at 10:24 PM Andrey Grodzovsky
<Andrey.Grodzovsky@amd.com> wrote:
>
>
>
> On 2/5/21 3:49 PM, Daniel Vetter wrote:
> > On Fri, Feb 5, 2021 at 9:42 PM Andrey Grodzovsky
> > <Andrey.Grodzovsky@amd.com> wrote:
> >>
> >>
> >>
> >> On 2/5/21 2:45 PM, Bjorn Helgaas wrote:
> >>> On Fri, Feb 05, 2021 at 11:08:45AM -0500, Andrey Grodzovsky wrote:
> >>>> On 2/5/21 10:38 AM, Bjorn Helgaas wrote:
> >>>>> On Thu, Feb 04, 2021 at 11:03:10AM -0500, Andrey Grodzovsky wrote:
> >>>>>> + linux-pci mailing list and a bit of extra details bellow.
> >>>>>>
> >>>>>> On 2/2/21 12:51 PM, Andrey Grodzovsky wrote:
> >>>>>>> Bjorn, Sergey I would also like to use this opportunity to ask yo=
u a
> >>>>>>> question on a related topic - Hot unplug.
> >>>>>>> I've been working for a while on this (see latest patchset set he=
re
> >>>>>>> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F=
%2Flists.freedesktop.org%2Farchives%2Famd-gfx%2F2021-January%2F058595.html&=
amp;data=3D04%7C01%7CAndrey.Grodzovsky%40amd.com%7C49d227022bff486d9fd008d8=
ca178ec1%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637481549831907816%7C=
Unknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiL=
CJXVCI6Mn0%3D%7C1000&amp;sdata=3DI0ma8E5vOKAOh3vPI0IcGrbZpeFeHtbjuBOkTA5mPS=
U%3D&amp;reserved=3D0).
> >>>>>>> My question is specifically regarding this patch
> >>>>>>> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F=
%2Flists.freedesktop.org%2Farchives%2Famd-gfx%2F2021-January%2F058606.html&=
amp;data=3D04%7C01%7CAndrey.Grodzovsky%40amd.com%7C49d227022bff486d9fd008d8=
ca178ec1%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637481549831917820%7C=
Unknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiL=
CJXVCI6Mn0%3D%7C1000&amp;sdata=3DAS4ahmsk%2BY1bRvkqrLWC1KfrE8oNAGhbtKqIOm5A=
UQo%3D&amp;reserved=3D0
> >>>>>>> - the idea here is to
> >>>>>>> prevent any accesses to MMIO address ranges still mapped in kerne=
l page
> >>>>>
> >>>>> I think you're talking about a PCI BAR that is mapped into a user
> >>>>> process.
> >>>>
> >>>> For user mappings, including MMIO mappings, we have a reliable
> >>>> approach where we invalidate device address space mappings for all
> >>>> user on first sign of device disconnect and then on all subsequent
> >>>> page faults from the users accessing those ranges we insert dummy
> >>>> zero page into their respective page tables. It's actually the
> >>>> kernel driver, where no page faulting can be used such as for user
> >>>> space, I have issues on how to protect from keep accessing those
> >>>> ranges which already are released by PCI subsystem and hence can be
> >>>> allocated to another hot plugging device.
> >>>
> >>> That doesn't sound reliable to me, but maybe I don't understand what
> >>> you mean by the "first sign of device disconnect."
> >>
> >> See functions drm_dev_enter, drm_dev_exit and drm_dev_unplug in drm_de=
rv.c
> >>
> >> At least from a PCI
> >>> perspective, the first sign of a surprise hot unplug is likely to be
> >>> an MMIO read that returns ~0.
> >>
> >> We set drm_dev_unplug in amdgpu_pci_remove and base all later checks
> >> with drm_dev_enter/drm_dev_exit on this
> >>
> >>>
> >>> It's true that the hot unplug will likely cause an interrupt and we
> >>> *may* be able to unbind the driver before the driver or a user progra=
m
> >>> performs an MMIO access, but there's certainly no guarantee.  The
> >>> following sequence is always possible:
> >>>
> >>>     - User unplugs PCIe device
> >>>     - Bridge raises hotplug interrupt
> >>>     - Driver or userspace issues MMIO read
> >>>     - Bridge responds with error because link to device is down
> >>>     - Host bridge receives error, fabricates ~0 data to CPU
> >>>     - Driver or userspace sees ~0 data from MMIO read
> >>>     - PCI core fields hotplug interrupt and unbinds driver
> >>>
> >>>>> It is impossible to reliably *prevent* MMIO accesses to a BAR on a
> >>>>> PCI device that has been unplugged.  There is always a window
> >>>>> where the CPU issues a load/store and the device is unplugged
> >>>>> before the load/store completes.
> >>>>>
> >>>>> If a PCIe device is unplugged, an MMIO read to that BAR will
> >>>>> complete on PCIe with an uncorrectable fatal error.  When that
> >>>>> happens there is no valid data from the PCIe device, so the PCIe
> >>>>> host bridge typically fabricates ~0 data so the CPU load
> >>>>> instruction can complete.
> >>>>>
> >>>>> If you want to reliably recover from unplugs like this, I think
> >>>>> you have to check for that ~0 data at the important points, i.e.,
> >>>>> where you make decisions based on the data.  Of course, ~0 may be
> >>>>> valid data in some cases.  You have to use your knowledge of the
> >>>>> device programming model to determine whether ~0 is possible, and
> >>>>> if it is, check in some other way, like another MMIO read, to tell
> >>>>> whether the read succeeded and returned ~0, or failed because of
> >>>>> PCIe error and returned ~0.
> >>>>
> >>>> Looks like there is a high performance price to pay for this
> >>>> approach if we protect at every possible junction (e.g. register
> >>>> read/write accessors ), I tested this by doing 1M read/writes while
> >>>> using drm_dev_enter/drm_dev_exit which is DRM's RCU based guard
> >>>> against device unplug and even then we hit performance penalty of
> >>>> 40%. I assume that with actual MMIO read (e.g.
> >>>> pci_device_is_present)  will cause a much larger performance
> >>>> penalty.
> >>>
> >>> I guess you have to decide whether you want a fast 90% solution or a
> >>> somewhat slower 100% reliable solution :)
> >>>
> >>> I don't think the checking should be as expensive as you're thinking.
> >>> You only have to check if:
> >>>
> >>>     (1) you're doing an MMIO read (there's no response for MMIO write=
s,
> >>>         so you can't tell whether they succeed),
> >>>     (2) the MMIO read returns ~0,
> >>>     (3) ~0 might be a valid value for the register you're reading, an=
d
> >>>     (4) the read value is important to your control flow.
> >>>
> >>> For example, if you do a series of reads and act on the data after al=
l
> >>> the reads complete, you only need to worry about whether the *last*
> >>> read failed.  If that last read is to a register that is known to
> >>> contain a zero bit, no additional MMIO read is required and the
> >>> checking is basically free.
> >>
> >> I am more worried about MMIO writes to avoid writing to a BAR
> >> of a newly 'just' plugged in device that got accidentally allocated so=
me
> >> part of MMIO addresses range that our 'ghost' device still using.
> >
> > We have to shut all these down before the ->remove callback has
> > finished. At least that's my understanding, before that's all done the
> > pci subsystem wont reallocate anything.
> >
> > The drm_dev_enter/exit is only meant to lock out entire code paths
> > when we know the device is gone, so that we don't spend an eternity
> > timing out every access and running lots of code for no point. The
> > other reason for drm_dev_exit is to guard the sw side from access of
> > data structures which we tear down (or have to tear down) as part of
> > ->remove callback, like io remaps, maybe timers/workers driving hw
> > access and all these things. Only the uapi objects need to stay around
> > until userspace has closed all the fd/unmapped all the mappings so
> > that we don't oops all over the place.
> >
> > Of course auditing a big driver like amdgpu for this is massive pain,
> > so where/how you sprinkle drm_dev_enter/exit over it is a bit an
> > engineering tradeoff.
> >
> > Either way (if my understanding is correct), after ->remove is
> > finished, your driver _must_ guarantee that all access to mmio ranges
> > has stopped. How you do that is kinda up to you.
> >
> > But also like Bjorn pointed out, _while_ the hotunplug is happening,
> > i.e. at any moment between when transactions start failing up to and
> > including you driver's ->remove callback having finished, you need to
> > be able to cope with the bogus all-0xff replies in your code. But
> > that's kinda an orthogonal requirement: If you've fixed the use-after
> > free you might still crash on 0xff, and even if you fixed the all the
> > crashes due to 0xff reads you might still have lots of use-after frees
> > around.
> >
> > Cheers, Daniel
>
> I see, so, to summarize and confirm I got this correct.
> We drop the per register access guards as this an overkill and hurts perf=
ormance.
> Post .remove callback I verify to guard any IOCTL (already done), block G=
PU
> scheduler threads (already done) and disable interrupts (already done), g=
uard
> against any direct IB submissions to HW rings (not done yet) and cancel a=
nd
> flush any background running threads (timers mostly probably) (not done y=
et)
> which might trigger HW programming.
>
> Correct ?

Yeah. Well for clean design I think your ->remove callback should
guarantee that all background tasks your driver has (timers, workers,
whatever) are completely stopped. With drm_dev_enter/exit maybe only
guarding re-arming of these (since if you stop the timer/kthread maybe
also the data structure is gone entirely with kfree() that contained
these). But that's also implementation details which might go one way
or the other.
-Daniel

>
> Andrey
>
> >
> >> Andrey
> >>
> >>>
> >>>>>>> table by the driver AFTER the device is gone physically and
> >>>>>>> from the PCI  subsystem, post pci_driver.remove call back
> >>>>>>> execution. This happens because struct device (and struct
> >>>>>>> drm_device representing the graphic card) are still present
> >>>>>>> because some user clients which  are not aware of hot removal
> >>>>>>> still hold device file open and hence prevents device refcount
> >>>>>>> to drop to 0. The solution in this patch is brute force where
> >>>>>>> we try and find any place we access MMIO mapped to kernel
> >>>>>>> address space and guard against the write access with a
> >>>>>>> 'device-unplug' flag. This solution is obliviously racy
> >>>>>>> because a device can be unplugged right after checking the
> >>>>>>> falg.  I had an idea to instead not release but to keep those
> >>>>>>> ranges reserved even after pci_driver.remove, until DRM device
> >>>>>>> is destroyed when it's refcount drops to 0 and by this to
> >>>>>>> prevent new devices plugged in and allocated some of the same
> >>>>>>> MMIO address  range to get accidental writes into their
> >>>>>>> registers.  But, on dri-devel I was advised that this will
> >>>>>>> upset the PCI subsystem and so best to be avoided but I still
> >>>>>>> would like another opinion from PCI experts on whether this
> >>>>>>> approach is indeed not possible ?
> >
> >
> >



--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
