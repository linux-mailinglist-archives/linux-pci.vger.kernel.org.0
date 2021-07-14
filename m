Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94BE73C9327
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jul 2021 23:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbhGNVfg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Jul 2021 17:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbhGNVff (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Jul 2021 17:35:35 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1742DC061760
        for <linux-pci@vger.kernel.org>; Wed, 14 Jul 2021 14:32:43 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id u11so3981375oiv.1
        for <linux-pci@vger.kernel.org>; Wed, 14 Jul 2021 14:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=8rNw5tcrVaOy7wt3VvNCQriFJfYYtAj31h3TOjp8+jY=;
        b=HpqRorOSoc8h1an4yU77gBT8y+YuLTunxBmGx3clGs6VhnHAYcippZ+auEagJv7Q7s
         cxVH+Ihr3nLC6o4bi+MNqffxHdY/zAlVbpauEgZXgxSnp+eFQGwlITt8AWyl5BY+21Cd
         dayBM5IVatoyJfablzkb+i2x71c4oGeJW0s+/77s7+fbR65TcqxTcitgqiiaifFtfcDi
         Oa1z9WwzSszkonKcHhgPAAzhaf7+HUmqJ7OQitsCDdd8eqVaFlpfnqeGVdzh+Yo+iHsC
         KWrcWUeUTlqxjNfc2FM6a7gLCOPRQ3eQLAjtCqec7eAlRdH4LfF9IK4MHAaevSB/P13u
         o67Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=8rNw5tcrVaOy7wt3VvNCQriFJfYYtAj31h3TOjp8+jY=;
        b=LxdNBBVVOITqYdlpXyMv6eRCSZaV7On0AovY8jD4v68XALTJPJNM4acHLWydZzQvst
         BhTTNxiXU5cUE1g7QuGztMdg9GoghtDmO5Tk6S6XGRceEAoMkc69NiUhMl5XdwB56HtL
         oHWFeaJlrmakLA0lEdiQ3+5Tg9mU+RR9H4EwKDSbMbZdcqUEAV9i0nCtw79GpuwMB7NE
         oU0sQSH+m42A9oqaY0vLeY0Yuc5P619dMtxwA3Qtvnjl2e6ihnSzlYK2P6GiNuA5H2CW
         2SgQA1dV3IoszAfbbspMNBlA0iTDoBI2Ss9XpU6mZK91Vl9DbXH0TANCFI8SXl23WrIl
         SXdw==
X-Gm-Message-State: AOAM533SiVe/WWvn17OIWiLzr+mSliyVqrAo1GJBl1Q1Utkl6yT6pwg+
        RBbf9tpymmmcj9ZRBDI2Fpsn5Raca8V75qvDr6kYowjdsOGF6w==
X-Google-Smtp-Source: ABdhPJz0DN1ItGgy/+kvbZl0zcy0VcVvZr8//e34Y1NmHaS1DaR2HeIWUOpJjBlt7YZLFTwWnrD/My4+cgcjPu/he+c=
X-Received: by 2002:aca:c346:: with SMTP id t67mr1547448oif.124.1626298362474;
 Wed, 14 Jul 2021 14:32:42 -0700 (PDT)
MIME-Version: 1.0
From:   Ruben <rubenbryon@gmail.com>
Date:   Thu, 15 Jul 2021 00:32:30 +0300
Message-ID: <CALdZjm7v3WaaS_ispa20PkjUnLq1t1Zdr29wKw_rZkQYExK-3w@mail.gmail.com>
Subject: [question]: BAR allocation failing
To:     linux-pci@vger.kernel.org
Cc:     bhelgaas@google.com, alex.williamson@redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

I am experiencing an issue with virtualizing a machine which contains
8 NVidia A100 80GB cards.
As a bare metal host, the machine behaves as expected, the GPUs are
connected to the host with a PLX chip PEX88096, which connects 2 GPUs
to 16 lanes on the CPU (using the same NVidia HGX Delta baseboard).
When passing through all GPUs and NVLink bridges to a VM, a problem
arises in that the system can only initialize 4-5 of the 8 GPUs.

The dmesg log shows failed attempts for assiging BAR space to the GPUs
that are not getting initialized.

Things that were tried:
Q35-i440fx with and without UEFI
Qemu 5.x, Qemu 6.0
Host Ubuntu 20.04 host with Qemu/libvirt
Now running proxmox 7 on debian 11, host kernel 5.11.22-2, VM kernel 5.4.0-77
VM kernel parameters pci=nocrs pci=realloc=on/off

------------------------------------

lspci -v:
01:00.0 3D controller: NVIDIA Corporation Device 20b2 (rev a1)
        Memory at db000000 (32-bit, non-prefetchable) [size=16M]
        Memory at 2000000000 (64-bit, prefetchable) [size=128G]
        Memory at 1000000000 (64-bit, prefetchable) [size=32M]

02:00.0 3D controller: NVIDIA Corporation Device 20b2 (rev a1)
        Memory at dc000000 (32-bit, non-prefetchable) [size=16M]
        Memory at 4000000000 (64-bit, prefetchable) [size=128G]
        Memory at 6000000000 (64-bit, prefetchable) [size=32M]

...

0c:00.0 3D controller: NVIDIA Corporation Device 20b2 (rev a1)
        Memory at e0000000 (32-bit, non-prefetchable) [size=16M]
        Memory at <ignored> (64-bit, prefetchable)
        Memory at <ignored> (64-bit, prefetchable)

...

------------------------------------

root@a100:~# dmesg | grep 01:00
[    0.674363] pci 0000:01:00.0: [10de:20b2] type 00 class 0x030200
[    0.674884] pci 0000:01:00.0: reg 0x10: [mem 0xff000000-0xffffffff]
[    0.675010] pci 0000:01:00.0: reg 0x14: [mem
0xffffffe000000000-0xffffffffffffffff 64bit pref]
[    0.675129] pci 0000:01:00.0: reg 0x1c: [mem
0xfffffffffe000000-0xffffffffffffffff 64bit pref]
[    0.675416] pci 0000:01:00.0: Max Payload Size set to 128 (was 256, max 256)
[    0.675567] pci 0000:01:00.0: Enabling HDA controller
[    0.676324] pci 0000:01:00.0: PME# supported from D0 D3hot
[    1.377980] pci 0000:01:00.0: can't claim BAR 0 [mem
0xff000000-0xffffffff]: no compatible bridge window
[    1.377983] pci 0000:01:00.0: can't claim BAR 1 [mem
0xffffffe000000000-0xffffffffffffffff 64bit pref]: no compatible
bridge window
[    1.377986] pci 0000:01:00.0: can't claim BAR 3 [mem
0xfffffffffe000000-0xffffffffffffffff 64bit pref]: no compatible
bridge window
[    1.403889] pci 0000:01:00.0: BAR 1: assigned [mem
0x2000000000-0x3fffffffff 64bit pref]
[    1.404120] pci 0000:01:00.0: BAR 3: assigned [mem
0x1000000000-0x1001ffffff 64bit pref]
[    1.404335] pci 0000:01:00.0: BAR 0: assigned [mem 0xcf000000-0xcfffffff]
[    4.214191] nvidia 0000:01:00.0: enabling device (0000 -> 0002)
[   15.185625] [drm] Initialized nvidia-drm 0.0.0 20160202 for
0000:01:00.0 on minor 1

root@a100:~# dmesg | grep 06:00
[    0.724589] pci 0000:06:00.0: [10de:20b2] type 00 class 0x030200
[    0.724975] pci 0000:06:00.0: reg 0x10: [mem 0xff000000-0xffffffff]
[    0.725069] pci 0000:06:00.0: reg 0x14: [mem
0xffffffe000000000-0xffffffffffffffff 64bit pref]
[    0.725146] pci 0000:06:00.0: reg 0x1c: [mem
0xfffffffffe000000-0xffffffffffffffff 64bit pref]
[    0.725343] pci 0000:06:00.0: Max Payload Size set to 128 (was 256, max 256)
[    0.725471] pci 0000:06:00.0: Enabling HDA controller
[    0.726051] pci 0000:06:00.0: PME# supported from D0 D3hot
[    1.378149] pci 0000:06:00.0: can't claim BAR 0 [mem
0xff000000-0xffffffff]: no compatible bridge window
[    1.378151] pci 0000:06:00.0: can't claim BAR 1 [mem
0xffffffe000000000-0xffffffffffffffff 64bit pref]: no compatible
bridge window
[    1.378154] pci 0000:06:00.0: can't claim BAR 3 [mem
0xfffffffffe000000-0xffffffffffffffff 64bit pref]: no compatible
bridge window
[    1.421549] pci 0000:06:00.0: BAR 1: no space for [mem size
0x2000000000 64bit pref]
[    1.421553] pci 0000:06:00.0: BAR 1: trying firmware assignment
[mem 0xffffffe000000000-0xffffffffffffffff 64bit pref]
[    1.421556] pci 0000:06:00.0: BAR 1: [mem
0xffffffe000000000-0xffffffffffffffff 64bit pref] conflicts with PCI
mem [mem 0x00000000-0xffffffffff]
[    1.421559] pci 0000:06:00.0: BAR 1: failed to assign [mem size
0x2000000000 64bit pref]
[    1.421562] pci 0000:06:00.0: BAR 3: no space for [mem size
0x02000000 64bit pref]
[    1.421564] pci 0000:06:00.0: BAR 3: trying firmware assignment
[mem 0xfffffffffe000000-0xffffffffffffffff 64bit pref]
[    1.421567] pci 0000:06:00.0: BAR 3: [mem
0xfffffffffe000000-0xffffffffffffffff 64bit pref] conflicts with PCI
mem [mem 0x00000000-0xffffffffff]
[    1.421570] pci 0000:06:00.0: BAR 3: failed to assign [mem size
0x02000000 64bit pref]
[    1.421573] pci 0000:06:00.0: BAR 0: assigned [mem 0xd4000000-0xd4ffffff]
[   15.013778] nvidia 0000:06:00.0: enabling device (0000 -> 0002)
[   15.191872] [drm] Initialized nvidia-drm 0.0.0 20160202 for
0000:06:00.0 on minor 6
[   26.946648] NVRM: GPU 0000:06:00.0: RmInitAdapter failed! (0x22:0xffff:662)
[   26.948225] NVRM: GPU 0000:06:00.0: rm_init_adapter failed, device
minor number 5
[   26.982183] NVRM: GPU 0000:06:00.0: RmInitAdapter failed! (0x22:0xffff:662)
[   26.983434] NVRM: GPU 0000:06:00.0: rm_init_adapter failed, device
minor number 5

------------------------------------

I have (blindly) messed with parameters like pref64-reserve for the
pcie-root-port but to be frank I have little clue what I'm doing so my
question would be suggestions on what I can try.
This server will not be running an 8 GPU VM in production but I have a
few days left to test before it goes to work. I was hoping to learn
how to overcome this issue in the future.
Please be aware that my knowledge regarding virtualization and the
Linux kernel does not reach far.

Thanks in advance for your time!
