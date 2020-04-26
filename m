Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BAFF1B8FBD
	for <lists+linux-pci@lfdr.de>; Sun, 26 Apr 2020 14:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbgDZMJD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 26 Apr 2020 08:09:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:45390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbgDZMJD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 26 Apr 2020 08:09:03 -0400
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 732492084D
        for <linux-pci@vger.kernel.org>; Sun, 26 Apr 2020 12:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587902942;
        bh=XJbPyQ0kWPj4CaQWxB6bqW+XP7Iqca2kQFo8ZHuXz/c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=asvkiDZ9m8erxK342okM5Q/ZgGMhHxW8stSrzZkq91hBD1SmP9cWSDquHY+En2SOJ
         V30ZccCWQO6/ca7zqcfdLVq3p1MirbF6gXu7uLvm4Xugn4h/tWncZGlmQECLOabTTO
         z0M07NbVc9vac3KiD9T9hWREeYja2OzTO0qbVNZA=
Received: by mail-io1-f44.google.com with SMTP id z2so15768478iol.11
        for <linux-pci@vger.kernel.org>; Sun, 26 Apr 2020 05:09:02 -0700 (PDT)
X-Gm-Message-State: AGi0PuYvEFPWUp0Mar5h+8RQB1IcYGCsjjXW9aDEdVlbVfl5n2oqxV/v
        NROSJA5Y+PS/skVcxz11vDvKRYj7KzmxytoLkmc=
X-Google-Smtp-Source: APiQypIryi6/q8fo680+88QXYnbnPKnFUuYiISEUHq+BMtGM2DKzJOwnpD8lM9diVc2sc0WzNM9uq1mLOZxJ6FuRbVw=
X-Received: by 2002:a02:6a1e:: with SMTP id l30mr15739079jac.98.1587902941849;
 Sun, 26 Apr 2020 05:09:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200421162256.26887-1-ardb@kernel.org> <2fb2b8c1-89be-1e59-c82c-b63e3afa62d5@amd.com>
 <CAMj1kXE0wFtyD7YGxXzKWAx+BT6x9CYreaFyEeFfeYJFeQbo_g@mail.gmail.com>
 <CAMj1kXH3WVMehgbMwUEjBSYudAM7PtWAcAYcWspyq4eZJzBwTQ@mail.gmail.com>
 <d06a3062-ce45-fdd2-6f22-c56e2e2f8f4b@amd.com> <CAMj1kXG04ehc6WxR=YSzjrV33O07h6hcWocUAfnfdGpDG13w6g@mail.gmail.com>
 <CAMj1kXFWfhYPwfO29Qv6w1-Dk=Ph+ZZEXPgvqf5Abrg3qf2jWA@mail.gmail.com>
 <ea3f1f02-e7da-8baf-1457-ecfe3d95bd02@amd.com> <CAMj1kXEtcyOcLJ4WdcoLaV9tvLH2mvPBYjhi60po4XWk9sqw4A@mail.gmail.com>
 <59f26d64-70a0-687d-45d8-2ae1b63a7c11@amd.com>
In-Reply-To: <59f26d64-70a0-687d-45d8-2ae1b63a7c11@amd.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sun, 26 Apr 2020 14:08:50 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFA=aXWqQ2XDa=1wYKQfrMR26du76HowzUe2fdK+FBgow@mail.gmail.com>
Message-ID: <CAMj1kXFA=aXWqQ2XDa=1wYKQfrMR26du76HowzUe2fdK+FBgow@mail.gmail.com>
Subject: Re: [PATCH] PCI: allow pci_resize_resource() to be used on devices on
 the root bus
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        jon@solid-run.com, wasim.khan@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, 26 Apr 2020 at 13:27, Christian K=C3=B6nig <christian.koenig@amd.co=
m> wrote:
>
> Am 26.04.20 um 12:59 schrieb Ard Biesheuvel:
> > On Sun, 26 Apr 2020 at 12:53, Christian K=C3=B6nig <christian.koenig@am=
d.com> wrote:
> >> Am 26.04.20 um 12:46 schrieb Ard Biesheuvel:
> >>> On Sun, 26 Apr 2020 at 11:58, Ard Biesheuvel <ardb@kernel.org> wrote:
> >>>> On Sun, 26 Apr 2020 at 11:08, Christian K=C3=B6nig <christian.koenig=
@amd.com> wrote:
> >>>>> Am 25.04.20 um 19:32 schrieb Ard Biesheuvel:
> >>>>>> On Tue, 21 Apr 2020 at 19:07, Ard Biesheuvel <ardb@kernel.org> wro=
te:
> >>>>>>> On Tue, 21 Apr 2020 at 18:43, Christian K=C3=B6nig <christian.koe=
nig@amd.com> wrote:
> >>>>>>>> Am 21.04.20 um 18:22 schrieb Ard Biesheuvel:
> >>>>>>>>> When resizing a BAR, pci_reassign_bridge_resources() is invoked=
 to
> >>>>>>>>> bring the bridge windows of parent bridges in line with the new=
 BAR
> >>>>>>>>> assignment.
> >>>>>>>>>
> >>>>>>>>> This assumes that the device whose BAR is being resized lives o=
n a
> >>>>>>>>> subordinate bus, but this is not necessarily the case. A device=
 may
> >>>>>>>>> live on the root bus, in which case dev->bus->self is NULL, and
> >>>>>>>>> passing a NULL pci_dev pointer to pci_reassign_bridge_resources=
()
> >>>>>>>>> will cause it to crash.
> >>>>>>>>>
> >>>>>>>>> So let's make the call to pci_reassign_bridge_resources() condi=
tional
> >>>>>>>>> on whether dev->bus->self is non-NULL in the first place.
> >>>>>>>>>
> >>>>>>>>> Fixes: 8bb705e3e79d84e7 ("PCI: Add pci_resize_resource() for re=
sizing BARs")
> >>>>>>>>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> >>>>>>>> Sounds like it makes sense, patch is
> >>>>>>>> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>.
> >>>>>>> Thanks Christian.
> >>>>>>>
> >>>>>>>> May I ask where you found that condition?
> >>>>>>>>
> >>>>>>> In this particular case, it was on an ARM board with funky PCIe I=
P
> >>>>>>> that does not expose a root port in its bus hierarchy.
> >>>>>>>
> >>>>>>> But in the general case, PCIe endpoints can be integrated into th=
e
> >>>>>>> root complex, in which case they appear on the root bus, and ther=
e is
> >>>>>>> no reason such endpoints shouldn't be allowed to have resizable B=
ARs.
> >>>>>> Actually, looking at this more carefully, I think
> >>>>>> pci_reassign_bridge_resources() needs to do /something/ to ensure =
that
> >>>>>> the resources are reshuffled if needed when the resized BAR overla=
ps
> >>>>>> with another one.
> >>>>> The resized BAR never overlaps with an existing one since to resize=
 a
> >>>>> BAR it needs to be deallocated and disabled. This is done as a
> >>>>> precaution to avoid potential incorrect routing and decode of memor=
y access.
> >>>>>
> >>>>> The call to pci_reassign_bridge_resources() is only there to change=
 the
> >>>>> resources of the upstream bridge to the device which is resized and=
 not
> >>>>> to adjust the resources of the device itself.
> >>>>>
> >>>> So does that mean that BAR resizing is only possible if no other BAR=
s,
> >>>> either on the same device or on other ones, need to be moved?
> >>> OK, so obviously, the current code already releases and reassigns
> >>> resources on the same device.
> >>>
> >>> What I am not getting is how this works with more complex topologies,=
 e.g.,
> >>>
> >>> RP 1
> >>> multi function device (e.g., GPU + HDMI)
> >>> GPU BAR 0 256M
> >>> GPU BAR 1 16 M
> >>> HDMI BAR 0 16 KB
> >>>
> >>> RP 2
> >>> some other endpoint using MMIO64 BARs
> >>>
> >>> So in this case, RP1 will get a prefetchable bridge BAR window of 512
> >>> M, and RP2 may get one that is directly adjacent to that. When
> >>> resizing GPU BAR 0 to 4 GB, the whole hierarchy needs to be
> >>> reshuffled, right?
> >> Correct, yes. Because you not only need to configure the BARs of the
> >> device(s), but also the bridges in between to get the routing right.
> >>
> > Right. But my point is really the RP2 is not a bridge in between.
> >
> >> Just wrote another mail with an example how this works on amdgpu. What
> >> aids us in amdgpu is that the devices only has two 64bit BARs, the
> >> FB/VRAM which we want to resize and the doorbell.
> >>
> >> I can easily disable access to the doorbell BAR temporary in amdgpu,
> >> otherwise the whole resize wouldn't work at all.
> >>
> > OK, so the example is clear, and I understand how you have to walk the
> > path up to the root bus to reconfigure the bridge BARs on each
> > upstream bridge.
> >
> > But at each level, the BAR space that is being reassigned may be in
> > use by another device already, no? RP2 in my example is a sibling of
> > RP1, so the walk up to the root will not traverse it. If RP2's  bridge
> > BARs conflict with the resized BAR below RP1, will the resize simply
> > fail?
>
> Yes exactly that. When BARs on upstream bridges can't be extended
> because some other downstream BAR can't move around we just abort the
> resize.
>

OK.

So how does this work with, e.g., other functions on the same
endpoint, like the audio adapter that is exposed for the audio part of
the HDMI port? Without releasing its BAR resource, it may end up
overlapping, no? And you cannot really release it without
collaboration from the driver, afaict.
