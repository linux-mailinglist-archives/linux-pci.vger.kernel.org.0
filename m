Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D21573CAE12
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jul 2021 22:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237618AbhGOUnD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Jul 2021 16:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237111AbhGOUnA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Jul 2021 16:43:00 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E8EC06175F
        for <linux-pci@vger.kernel.org>; Thu, 15 Jul 2021 13:40:06 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id w194so8231502oie.5
        for <linux-pci@vger.kernel.org>; Thu, 15 Jul 2021 13:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fGSfQIxUY/SZO6RydNxMgeSwYGo1+66ogRNyBNN8afA=;
        b=p2ntjU/d186PHKy07rno2CAzzWuofcqkuRPS3FXM5ERvAaLglzt8T7kIxViw26EKcd
         Id702IfZjiCezR72OEomkPpv842apDViX6PciVf71LecvQQS8u/B5vByGmu5hhHj/0dB
         nJ5oavrbvofE4w15UWk4KPzoIGk7OX6MO3Wz/SIE0bUZ7iUfQcXq3vCZstSudEdgAziY
         s/1rnWx/e/GHojp/PXguZVGH5g+7Rv4DbHDFH3x2CF8Npi9hKmlL79DntXXAH7RVXH4g
         qTzDtxufKhccSufRtrg0UDa6twdGvb0/DHvKtFkJ7RrLs2sXtyBa5dPRml2ab5zgKSg1
         nHeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fGSfQIxUY/SZO6RydNxMgeSwYGo1+66ogRNyBNN8afA=;
        b=A8l822UMhrZj8vAC6UxOfXyWtMMOMAb9puQKlNIHRlERGHzDOtP8ToKXRs7aclizmf
         DWKoe4r0aQQUXAh165+BwLqTtkkCC29W6loB5VSoIkXepO8dNJcun1TNsImmeMlX+1d5
         WHLirYrXRV8JOECA80xjWNOR2whF7R3JOGL2MlsiVU2FSlmojSpGZFZryIYmVcEpZsvE
         7rGfVZi6aWC6cFExLHbdibbTNDHWZTRMGqiGwh9UHQdZqkrRsKb/o5zq+jOOeQPretlk
         6Dkut8Tfd1iYiX/kinRkX0cgHTXJrc/N+qRb3m14wYswhXYiSiven6ES5BkhhsJinG7Z
         0Dgw==
X-Gm-Message-State: AOAM5336EDZvU8jABR6BpQzjwdKr6ZRzCB0lOKQ92B45uUUbVO1O6Qef
        hG8RQCngl01XotI1dxu+aVMHhXTi42OOOTzjtfkpJBy/QlzyyA==
X-Google-Smtp-Source: ABdhPJxxKwChYFTRVcxtDTXEFsX2vqujSUW/0nIXcLvuf5E2pGUET3w2IU1+FIC1ZsljnblgJOdU1z8ogvcqyIq5QYA=
X-Received: by 2002:aca:59c3:: with SMTP id n186mr5311283oib.98.1626381606064;
 Thu, 15 Jul 2021 13:40:06 -0700 (PDT)
MIME-Version: 1.0
References: <CALdZjm6TsfsaQZRxJvr5YDh9VRn28vQjFY+JfZv-daU=gQu_Uw@mail.gmail.com>
 <20210715144952.GA1960220@bjorn-Precision-5520>
In-Reply-To: <20210715144952.GA1960220@bjorn-Precision-5520>
From:   Ruben <rubenbryon@gmail.com>
Date:   Thu, 15 Jul 2021 23:39:54 +0300
Message-ID: <CALdZjm6iDnCR7OWzfCuKOALAtN-FoVvTdxUB=XcAFqHg5Aumpw@mail.gmail.com>
Subject: Re: [question]: BAR allocation failing
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Thanks for the response, here's a link to the entire dmesg log:
https://drive.google.com/file/d/1Uau0cgd2ymYGDXNr1mA9X_UdLoMH_Azn/view

Some entries that might be of interest:

[    0.378712] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
[    0.378712] pci_bus 0000:00: root bus resource [mem 0x00000000-0xffffffffff]
[    0.378712] pci_bus 0000:00: root bus resource [bus 00-ff]
...
For GPU 1 on bus 01:00.0 the process goes like this:
[    0.676903] pci 0000:01:00.0: [10de:20b2] type 00 class 0x030200
[    0.677433] pci 0000:01:00.0: reg 0x10: [mem 0xff000000-0xffffffff]
[    0.677551] pci 0000:01:00.0: reg 0x14: [mem
0xffffffe000000000-0xffffffffffffffff 64bit pref]
[    0.677668] pci 0000:01:00.0: reg 0x1c: [mem
0xfffffffffe000000-0xffffffffffffffff 64bit pref]
...
[    1.416980] pci 0000:01:00.0: can't claim BAR 0 [mem
0xff000000-0xffffffff]: no compatible bridge window
[    1.416983] pci 0000:01:00.0: can't claim BAR 1 [mem
0xffffffe000000000-0xffffffffffffffff 64bit pref]: no compatible
bridge window
[    1.416986] pci 0000:01:00.0: can't claim BAR 3 [mem
0xfffffffffe000000-0xffffffffffffffff 64bit pref]: no compatible
bridge window
....
[    1.445156] pci 0000:01:00.0: BAR 1: assigned [mem
0x2000000000-0x3fffffffff 64bit pref]
[    1.445380] pci 0000:01:00.0: BAR 3: assigned [mem
0x1000000000-0x1001ffffff 64bit pref]
[    1.445589] pci 0000:01:00.0: BAR 0: assigned [mem 0xdb000000-0xdbffffff]

GPU 5 on bus 05:00.0 seems to have taken the last available window for
BAR 1 and 3:
[    1.461179] pci 0000:05:00.0: BAR 1: assigned [mem
0xe000000000-0xffffffffff 64bit pref]
[    1.461361] pci 0000:05:00.0: BAR 3: assigned [mem
0xd000000000-0xd001ffffff 64bit pref]
[    1.461533] pci 0000:05:00.0: BAR 0: assigned [mem 0xdf000000-0xdfffffff]

The last step fails for GPU on bus 06:00.0:
[    1.463503] pci 0000:06:00.0: BAR 1: no space for [mem size
0x2000000000 64bit pref]
[    1.463508] pci 0000:06:00.0: BAR 1: trying firmware assignment
[mem 0xffffffe000000000-0xffffffffffffffff 64bit pref]
[    1.463511] pci 0000:06:00.0: BAR 1: [mem
0xffffffe000000000-0xffffffffffffffff 64bit pref] conflicts with PCI
mem [mem 0x00000000-0xffffffffff]
[    1.463514] pci 0000:06:00.0: BAR 1: failed to assign [mem size
0x2000000000 64bit pref]
[    1.463517] pci 0000:06:00.0: BAR 3: no space for [mem size
0x02000000 64bit pref]
[    1.463519] pci 0000:06:00.0: BAR 3: trying firmware assignment
[mem 0xfffffffffe000000-0xffffffffffffffff 64bit pref]
[    1.463522] pci 0000:06:00.0: BAR 3: [mem
0xfffffffffe000000-0xffffffffffffffff 64bit pref] conflicts with PCI
mem [mem 0x00000000-0xffffffffff]
[    1.463525] pci 0000:06:00.0: BAR 3: failed to assign [mem size
0x02000000 64bit pref]
[    1.463527] pci 0000:06:00.0: BAR 0: assigned [mem 0xe0000000-0xe0ffffff]

If I understand correctly, it looks like the bridge window is 40 bits or 1024GB?
BAR 3 takes only a small section but BAR 1 skips to the next 64GB
block to take 128GB, BAR3 of GPU1 starts at 0x1000000000 so by the
time we get to GPU 6 the 1024GB is used up it seems.

It seems that increasing the window size would solve the issue at
hand, however I haven't got a clue where to start.

Thanks for your input so far, greatly appreciated!

Op do 15 jul. 2021 om 17:49 schreef Bjorn Helgaas <helgaas@kernel.org>:
>
> On Thu, Jul 15, 2021 at 01:43:17AM +0300, Ruben wrote:
> > No luck so far with "-global q35-pcihost.pci-hole64-size=2048G"
> > ("-global q35-host.pci-hole64-size=" gave an error "warning: global
> > q35-host.pci-hole64-size has invalid class name").
> > The result stays the same.
>
> Alex will have to chime in about the qemu option problem.
>
> Your dmesg excerpts don't include the host bridge window info, e.g.,
> "root bus resource [mem 0x7f800000-0xefffffff window]".  That tells
> you what PCI thinks is available for devices.  This info comes from
> ACPI, and I don't know whether the BIOS on qemu is smart enough to
> compute it based on "q35-host.pci-hole64-size=".  But dmesg will tell
> you.
>
> "pci=nocrs" tells the kernel to ignore those windows from ACPI and
> pretend everything that's not RAM is available for devices.  Of
> course, that's not true in general, so it's not really safe.
>
> PCI resources are hierarchical: an endpoint BAR must be contained
> in the Root Ports window, which must in turn be contained in the host
> bridge window.  You trimmed most of that information out from your
> dmesg log, so we can't see exactly what's wrong.
>
> > When we pass through the NVLink bridges we can have the (5 working)
> > GPUs talk at full P2P bandwidth and is described in the NVidia docs as
> > a valid option (ie. passing through all GPUs and NVlink bridges).
> > In production we have the bridges passed through to a service VM which
> > controls traffic, which is also described in their docs.
> >
> > Op do 15 jul. 2021 om 01:03 schreef Alex Williamson
> > <alex.williamson@redhat.com>:
> > >
> > > On Thu, 15 Jul 2021 00:32:30 +0300
> > > Ruben <rubenbryon@gmail.com> wrote:
> > >
> > > > I am experiencing an issue with virtualizing a machine which contains
> > > > 8 NVidia A100 80GB cards.
> > > > As a bare metal host, the machine behaves as expected, the GPUs are
> > > > connected to the host with a PLX chip PEX88096, which connects 2 GPUs
> > > > to 16 lanes on the CPU (using the same NVidia HGX Delta baseboard).
> > > > When passing through all GPUs and NVLink bridges to a VM, a problem
> > > > arises in that the system can only initialize 4-5 of the 8 GPUs.
> > > >
> > > > The dmesg log shows failed attempts for assiging BAR space to the GPUs
> > > > that are not getting initialized.
> > > >
> > > > Things that were tried:
> > > > Q35-i440fx with and without UEFI
> > > > Qemu 5.x, Qemu 6.0
> > > > Host Ubuntu 20.04 host with Qemu/libvirt
> > > > Now running proxmox 7 on debian 11, host kernel 5.11.22-2, VM kernel 5.4.0-77
> > > > VM kernel parameters pci=nocrs pci=realloc=on/off
> > > >
> > > > ------------------------------------
> > > >
> > > > lspci -v:
> > > > 01:00.0 3D controller: NVIDIA Corporation Device 20b2 (rev a1)
> > > >         Memory at db000000 (32-bit, non-prefetchable) [size=16M]
> > > >         Memory at 2000000000 (64-bit, prefetchable) [size=128G]
> > > >         Memory at 1000000000 (64-bit, prefetchable) [size=32M]
> > > >
> > > > 02:00.0 3D controller: NVIDIA Corporation Device 20b2 (rev a1)
> > > >         Memory at dc000000 (32-bit, non-prefetchable) [size=16M]
> > > >         Memory at 4000000000 (64-bit, prefetchable) [size=128G]
> > > >         Memory at 6000000000 (64-bit, prefetchable) [size=32M]
> > > >
> > > > ...
> > > >
> > > > 0c:00.0 3D controller: NVIDIA Corporation Device 20b2 (rev a1)
> > > >         Memory at e0000000 (32-bit, non-prefetchable) [size=16M]
> > > >         Memory at <ignored> (64-bit, prefetchable)
> > > >         Memory at <ignored> (64-bit, prefetchable)
> > > >
> > > > ...
> > > >
> > > ...
> > > >
> > > > ------------------------------------
> > > >
> > > > I have (blindly) messed with parameters like pref64-reserve for the
> > > > pcie-root-port but to be frank I have little clue what I'm doing so my
> > > > question would be suggestions on what I can try.
> > > > This server will not be running an 8 GPU VM in production but I have a
> > > > few days left to test before it goes to work. I was hoping to learn
> > > > how to overcome this issue in the future.
> > > > Please be aware that my knowledge regarding virtualization and the
> > > > Linux kernel does not reach far.
> > >
> > > Try playing with the QEMU "-global q35-host.pci-hole64-size=" option for
> > > the VM rather than pci=nocrs.  The default 64-bit MMIO hole for
> > > QEMU/q35 is only 32GB.  You might be looking at a value like 2048G to
> > > support this setup, but could maybe get away with 1024G if there's room
> > > in 32-bit space for the 3rd BAR.
> > >
> > > Note that assigning bridges usually doesn't make a lot of sense and
> > > NVLink is a proprietary black box, so we don't know how to virtualize
> > > it or what the guest drivers will do with it, you're on your own there.
> > > We generally recommend to use vGPUs for such cases so the host driver
> > > can handle all the NVLink aspects for GPU peer-to-peer.  Thanks,
> > >
> > > Alex
> > >
