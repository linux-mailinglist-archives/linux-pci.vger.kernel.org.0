Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41B0D1B9050
	for <lists+linux-pci@lfdr.de>; Sun, 26 Apr 2020 15:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725974AbgDZNEc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 26 Apr 2020 09:04:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:38330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725876AbgDZNEb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 26 Apr 2020 09:04:31 -0400
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 970DA2074F
        for <linux-pci@vger.kernel.org>; Sun, 26 Apr 2020 13:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587906270;
        bh=IwENmLDV5jTJSfNaMDLmI1/pnn7/xS8mK3EmKketeTk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tERoOfTmqlgV/10kvvmyOy7+jtNJFgfbTU0uszMhkq3ErlC+lHXgFZh/e2pZV2FQR
         JaPUGTzfsC4fjscYxkB+bRxaDpbXG8kKzQz0ZZvlJRrBjUXuLOBQki9lQpR7ZWNDQq
         uDF1ZPYfhAUInaA7Zit3AIjHcypDY+JCSRLyXCZI=
Received: by mail-il1-f175.google.com with SMTP id c16so14119210ilr.3
        for <linux-pci@vger.kernel.org>; Sun, 26 Apr 2020 06:04:30 -0700 (PDT)
X-Gm-Message-State: AGi0PubzsWW1wMqo8FVBtcCQQ7Sr34LSrtFq/QozccZnG3WrUiwyvzKl
        f/aUaKb2jHEJTkw8EQ86WywqAI4qwJF2wTTx4+4=
X-Google-Smtp-Source: APiQypLhEtY1AEuSLWo6E4DvQA3Xqrku5/H/rMba7ShKrmOYjnn1hr46LSZuuW+BzEpH/+WSioDT/zjdObqcdtxhXOE=
X-Received: by 2002:a92:607:: with SMTP id x7mr15526823ilg.218.1587906269940;
 Sun, 26 Apr 2020 06:04:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200421162256.26887-1-ardb@kernel.org> <2fb2b8c1-89be-1e59-c82c-b63e3afa62d5@amd.com>
 <CAMj1kXE0wFtyD7YGxXzKWAx+BT6x9CYreaFyEeFfeYJFeQbo_g@mail.gmail.com>
 <CAMj1kXH3WVMehgbMwUEjBSYudAM7PtWAcAYcWspyq4eZJzBwTQ@mail.gmail.com>
 <d06a3062-ce45-fdd2-6f22-c56e2e2f8f4b@amd.com> <CAMj1kXG04ehc6WxR=YSzjrV33O07h6hcWocUAfnfdGpDG13w6g@mail.gmail.com>
 <CAMj1kXFWfhYPwfO29Qv6w1-Dk=Ph+ZZEXPgvqf5Abrg3qf2jWA@mail.gmail.com>
 <ea3f1f02-e7da-8baf-1457-ecfe3d95bd02@amd.com> <CAMj1kXEtcyOcLJ4WdcoLaV9tvLH2mvPBYjhi60po4XWk9sqw4A@mail.gmail.com>
 <59f26d64-70a0-687d-45d8-2ae1b63a7c11@amd.com> <CAMj1kXFA=aXWqQ2XDa=1wYKQfrMR26du76HowzUe2fdK+FBgow@mail.gmail.com>
 <c740802b-8cae-dcdb-c081-e59171faf733@amd.com>
In-Reply-To: <c740802b-8cae-dcdb-c081-e59171faf733@amd.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sun, 26 Apr 2020 15:04:19 +0200
X-Gmail-Original-Message-ID: <CAMj1kXF6ae7+UCqMYsiQxmKKZgprnmfo4Ows5KCyxRFRcZK9LA@mail.gmail.com>
Message-ID: <CAMj1kXF6ae7+UCqMYsiQxmKKZgprnmfo4Ows5KCyxRFRcZK9LA@mail.gmail.com>
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

On Sun, 26 Apr 2020 at 14:55, Christian K=C3=B6nig <christian.koenig@amd.co=
m> wrote:
>
> Am 26.04.20 um 14:08 schrieb Ard Biesheuvel:
> > On Sun, 26 Apr 2020 at 13:27, Christian K=C3=B6nig <christian.koenig@am=
d.com> wrote:
> >> Am 26.04.20 um 12:59 schrieb Ard Biesheuvel:
> >>> On Sun, 26 Apr 2020 at 12:53, Christian K=C3=B6nig <christian.koenig@=
amd.com> wrote:
> >>>> Am 26.04.20 um 12:46 schrieb Ard Biesheuvel:
> >>>>> On Sun, 26 Apr 2020 at 11:58, Ard Biesheuvel <ardb@kernel.org> wrot=
e:
> >>>>>> On Sun, 26 Apr 2020 at 11:08, Christian K=C3=B6nig <christian.koen=
ig@amd.com> wrote:
> >>>>>>> Am 25.04.20 um 19:32 schrieb Ard Biesheuvel:
> >>>>>>>> On Tue, 21 Apr 2020 at 19:07, Ard Biesheuvel <ardb@kernel.org> w=
rote:
> >>>>>>>>> On Tue, 21 Apr 2020 at 18:43, Christian K=C3=B6nig <christian.k=
oenig@amd.com> wrote:
> >>>>>>>>>> Am 21.04.20 um 18:22 schrieb Ard Biesheuvel:
> >>>>>>>>>>> When resizing a BAR, pci_reassign_bridge_resources() is invok=
ed to
> >>>>>>>>>>> bring the bridge windows of parent bridges in line with the n=
ew BAR
> >>>>>>>>>>> assignment.
> >>>>>>>>>>>
> >>>>>>>>>>> This assumes that the device whose BAR is being resized lives=
 on a
> >>>>>>>>>>> subordinate bus, but this is not necessarily the case. A devi=
ce may
> >>>>>>>>>>> live on the root bus, in which case dev->bus->self is NULL, a=
nd
> >>>>>>>>>>> passing a NULL pci_dev pointer to pci_reassign_bridge_resourc=
es()
> >>>>>>>>>>> will cause it to crash.
> >>>>>>>>>>>
> >>>>>>>>>>> So let's make the call to pci_reassign_bridge_resources() con=
ditional
> >>>>>>>>>>> on whether dev->bus->self is non-NULL in the first place.
> >>>>>>>>>>>
> >>>>>>>>>>> Fixes: 8bb705e3e79d84e7 ("PCI: Add pci_resize_resource() for =
resizing BARs")
> >>>>>>>>>>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> >>>>>>>>>> Sounds like it makes sense, patch is
> >>>>>>>>>> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>.
> >>>>>>>>> Thanks Christian.
> >>>>>>>>>
> >>>>>>>>>> May I ask where you found that condition?
> >>>>>>>>>>
> >>>>>>>>> In this particular case, it was on an ARM board with funky PCIe=
 IP
> >>>>>>>>> that does not expose a root port in its bus hierarchy.
> >>>>>>>>>
> >>>>>>>>> But in the general case, PCIe endpoints can be integrated into =
the
> >>>>>>>>> root complex, in which case they appear on the root bus, and th=
ere is
> >>>>>>>>> no reason such endpoints shouldn't be allowed to have resizable=
 BARs.
> >>>>>>>> Actually, looking at this more carefully, I think
> >>>>>>>> pci_reassign_bridge_resources() needs to do /something/ to ensur=
e that
> >>>>>>>> the resources are reshuffled if needed when the resized BAR over=
laps
> >>>>>>>> with another one.
> >>>>>>> The resized BAR never overlaps with an existing one since to resi=
ze a
> >>>>>>> BAR it needs to be deallocated and disabled. This is done as a
> >>>>>>> precaution to avoid potential incorrect routing and decode of mem=
ory access.
> >>>>>>>
> >>>>>>> The call to pci_reassign_bridge_resources() is only there to chan=
ge the
> >>>>>>> resources of the upstream bridge to the device which is resized a=
nd not
> >>>>>>> to adjust the resources of the device itself.
> >>>>>>>
> >>>>>> So does that mean that BAR resizing is only possible if no other B=
ARs,
> >>>>>> either on the same device or on other ones, need to be moved?
> >>>>> OK, so obviously, the current code already releases and reassigns
> >>>>> resources on the same device.
> >>>>>
> >>>>> What I am not getting is how this works with more complex topologie=
s, e.g.,
> >>>>>
> >>>>> RP 1
> >>>>> multi function device (e.g., GPU + HDMI)
> >>>>> GPU BAR 0 256M
> >>>>> GPU BAR 1 16 M
> >>>>> HDMI BAR 0 16 KB
> >>>>>
> >>>>> RP 2
> >>>>> some other endpoint using MMIO64 BARs
> >>>>>
> >>>>> So in this case, RP1 will get a prefetchable bridge BAR window of 5=
12
> >>>>> M, and RP2 may get one that is directly adjacent to that. When
> >>>>> resizing GPU BAR 0 to 4 GB, the whole hierarchy needs to be
> >>>>> reshuffled, right?
> >>>> Correct, yes. Because you not only need to configure the BARs of the
> >>>> device(s), but also the bridges in between to get the routing right.
> >>>>
> >>> Right. But my point is really the RP2 is not a bridge in between.
> >>>
> >>>> Just wrote another mail with an example how this works on amdgpu. Wh=
at
> >>>> aids us in amdgpu is that the devices only has two 64bit BARs, the
> >>>> FB/VRAM which we want to resize and the doorbell.
> >>>>
> >>>> I can easily disable access to the doorbell BAR temporary in amdgpu,
> >>>> otherwise the whole resize wouldn't work at all.
> >>>>
> >>> OK, so the example is clear, and I understand how you have to walk th=
e
> >>> path up to the root bus to reconfigure the bridge BARs on each
> >>> upstream bridge.
> >>>
> >>> But at each level, the BAR space that is being reassigned may be in
> >>> use by another device already, no? RP2 in my example is a sibling of
> >>> RP1, so the walk up to the root will not traverse it. If RP2's  bridg=
e
> >>> BARs conflict with the resized BAR below RP1, will the resize simply
> >>> fail?
> >> Yes exactly that. When BARs on upstream bridges can't be extended
> >> because some other downstream BAR can't move around we just abort the
> >> resize.
> >>
> > OK.
> >
> > So how does this work with, e.g., other functions on the same
> > endpoint, like the audio adapter that is exposed for the audio part of
> > the HDMI port? Without releasing its BAR resource, it may end up
> > overlapping, no? And you cannot really release it without
> > collaboration from the driver, afaict.
>
> Correct yes. The trick we use with AMD GPUs is that the audio endpoint,
> GPU MMIO register etc.. are all 32bit resources. The only two 64bit
> resources we have are the FB/VRAM and the doorbell BAR.
>
> Since we usually need to resize the FB/VRAM BAR much larger than the
> 32bit/4GB limit anyway we separate the 32bit resources from the 64bit
> resources.
>
> This works since bridges have separate 32bit and 64bit windows for 32bit
> and 64bit resources.
>
> But yes if you have a mix of 64bit devices behind a single bridge this
> will currently fail rather obviously.
>

OK, thanks for confirming.

> What we could maybe do to improve this is to teach the resources
> assignment code in the PCI subsystem to take resize-able BARs into
> account. This way we could trigger resource reallocation before drivers
> load and start using the BARs in question.
>

Yes, that would probably be better.
