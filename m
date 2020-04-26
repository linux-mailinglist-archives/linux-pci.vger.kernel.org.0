Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1DD81B8F2C
	for <lists+linux-pci@lfdr.de>; Sun, 26 Apr 2020 12:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbgDZK7e (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 26 Apr 2020 06:59:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:41276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726116AbgDZK7d (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 26 Apr 2020 06:59:33 -0400
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F20682084D
        for <linux-pci@vger.kernel.org>; Sun, 26 Apr 2020 10:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587898773;
        bh=m44otCTVH984vcmqDDPlpDP8T3PA+pBI1Q02Ql0JqYU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EfVN9QA8dZGHzbLvHQJ0A7ZpvuRcNaqFMcISgsaPhW5LYCF8nwojq8v9wiw/BpX2O
         us/pB6K3XUS14osReCAwhKgedSgR3keNTBhuq2xafriirdkhHv7UtEDR5Qn3tXHbuo
         yvcwKM+4xzmL+B/l98ziEuirCRPOr69mRjot4RZc=
Received: by mail-io1-f44.google.com with SMTP id w4so15674038ioc.6
        for <linux-pci@vger.kernel.org>; Sun, 26 Apr 2020 03:59:32 -0700 (PDT)
X-Gm-Message-State: AGi0PuaBbh6LsO3KeX5WXCoc1lbLtWjW340pDFKIQ3IXJiis3L7VJugo
        uVsIXAlu9FHLntv0a8TOCwTQq0nJUeFrZSkfz9U=
X-Google-Smtp-Source: APiQypIJ1HIwcp7GUJFHQOC1xOqM0i7xbk+FYjDXY4GFyQUmevGZyhu+XK9V4lxp8uJhixNnii/YXTYPQ6sQwwKV+pI=
X-Received: by 2002:a5d:8045:: with SMTP id b5mr16137181ior.16.1587898772318;
 Sun, 26 Apr 2020 03:59:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200421162256.26887-1-ardb@kernel.org> <2fb2b8c1-89be-1e59-c82c-b63e3afa62d5@amd.com>
 <CAMj1kXE0wFtyD7YGxXzKWAx+BT6x9CYreaFyEeFfeYJFeQbo_g@mail.gmail.com>
 <CAMj1kXH3WVMehgbMwUEjBSYudAM7PtWAcAYcWspyq4eZJzBwTQ@mail.gmail.com>
 <d06a3062-ce45-fdd2-6f22-c56e2e2f8f4b@amd.com> <CAMj1kXG04ehc6WxR=YSzjrV33O07h6hcWocUAfnfdGpDG13w6g@mail.gmail.com>
 <CAMj1kXFWfhYPwfO29Qv6w1-Dk=Ph+ZZEXPgvqf5Abrg3qf2jWA@mail.gmail.com> <ea3f1f02-e7da-8baf-1457-ecfe3d95bd02@amd.com>
In-Reply-To: <ea3f1f02-e7da-8baf-1457-ecfe3d95bd02@amd.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sun, 26 Apr 2020 12:59:21 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEtcyOcLJ4WdcoLaV9tvLH2mvPBYjhi60po4XWk9sqw4A@mail.gmail.com>
Message-ID: <CAMj1kXEtcyOcLJ4WdcoLaV9tvLH2mvPBYjhi60po4XWk9sqw4A@mail.gmail.com>
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

On Sun, 26 Apr 2020 at 12:53, Christian K=C3=B6nig <christian.koenig@amd.co=
m> wrote:
>
> Am 26.04.20 um 12:46 schrieb Ard Biesheuvel:
> > On Sun, 26 Apr 2020 at 11:58, Ard Biesheuvel <ardb@kernel.org> wrote:
> >> On Sun, 26 Apr 2020 at 11:08, Christian K=C3=B6nig <christian.koenig@a=
md.com> wrote:
> >>> Am 25.04.20 um 19:32 schrieb Ard Biesheuvel:
> >>>> On Tue, 21 Apr 2020 at 19:07, Ard Biesheuvel <ardb@kernel.org> wrote=
:
> >>>>> On Tue, 21 Apr 2020 at 18:43, Christian K=C3=B6nig <christian.koeni=
g@amd.com> wrote:
> >>>>>> Am 21.04.20 um 18:22 schrieb Ard Biesheuvel:
> >>>>>>> When resizing a BAR, pci_reassign_bridge_resources() is invoked t=
o
> >>>>>>> bring the bridge windows of parent bridges in line with the new B=
AR
> >>>>>>> assignment.
> >>>>>>>
> >>>>>>> This assumes that the device whose BAR is being resized lives on =
a
> >>>>>>> subordinate bus, but this is not necessarily the case. A device m=
ay
> >>>>>>> live on the root bus, in which case dev->bus->self is NULL, and
> >>>>>>> passing a NULL pci_dev pointer to pci_reassign_bridge_resources()
> >>>>>>> will cause it to crash.
> >>>>>>>
> >>>>>>> So let's make the call to pci_reassign_bridge_resources() conditi=
onal
> >>>>>>> on whether dev->bus->self is non-NULL in the first place.
> >>>>>>>
> >>>>>>> Fixes: 8bb705e3e79d84e7 ("PCI: Add pci_resize_resource() for resi=
zing BARs")
> >>>>>>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> >>>>>> Sounds like it makes sense, patch is
> >>>>>> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>.
> >>>>> Thanks Christian.
> >>>>>
> >>>>>> May I ask where you found that condition?
> >>>>>>
> >>>>> In this particular case, it was on an ARM board with funky PCIe IP
> >>>>> that does not expose a root port in its bus hierarchy.
> >>>>>
> >>>>> But in the general case, PCIe endpoints can be integrated into the
> >>>>> root complex, in which case they appear on the root bus, and there =
is
> >>>>> no reason such endpoints shouldn't be allowed to have resizable BAR=
s.
> >>>> Actually, looking at this more carefully, I think
> >>>> pci_reassign_bridge_resources() needs to do /something/ to ensure th=
at
> >>>> the resources are reshuffled if needed when the resized BAR overlaps
> >>>> with another one.
> >>> The resized BAR never overlaps with an existing one since to resize a
> >>> BAR it needs to be deallocated and disabled. This is done as a
> >>> precaution to avoid potential incorrect routing and decode of memory =
access.
> >>>
> >>> The call to pci_reassign_bridge_resources() is only there to change t=
he
> >>> resources of the upstream bridge to the device which is resized and n=
ot
> >>> to adjust the resources of the device itself.
> >>>
> >> So does that mean that BAR resizing is only possible if no other BARs,
> >> either on the same device or on other ones, need to be moved?
> > OK, so obviously, the current code already releases and reassigns
> > resources on the same device.
> >
> > What I am not getting is how this works with more complex topologies, e=
.g.,
> >
> > RP 1
> > multi function device (e.g., GPU + HDMI)
> > GPU BAR 0 256M
> > GPU BAR 1 16 M
> > HDMI BAR 0 16 KB
> >
> > RP 2
> > some other endpoint using MMIO64 BARs
> >
> > So in this case, RP1 will get a prefetchable bridge BAR window of 512
> > M, and RP2 may get one that is directly adjacent to that. When
> > resizing GPU BAR 0 to 4 GB, the whole hierarchy needs to be
> > reshuffled, right?
>
> Correct, yes. Because you not only need to configure the BARs of the
> device(s), but also the bridges in between to get the routing right.
>

Right. But my point is really the RP2 is not a bridge in between.

> Just wrote another mail with an example how this works on amdgpu. What
> aids us in amdgpu is that the devices only has two 64bit BARs, the
> FB/VRAM which we want to resize and the doorbell.
>
> I can easily disable access to the doorbell BAR temporary in amdgpu,
> otherwise the whole resize wouldn't work at all.
>

OK, so the example is clear, and I understand how you have to walk the
path up to the root bus to reconfigure the bridge BARs on each
upstream bridge.

But at each level, the BAR space that is being reassigned may be in
use by another device already, no? RP2 in my example is a sibling of
RP1, so the walk up to the root will not traverse it. If RP2's  bridge
BARs conflict with the resized BAR below RP1, will the resize simply
fail?
