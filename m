Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61AD827A9D2
	for <lists+linux-pci@lfdr.de>; Mon, 28 Sep 2020 10:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbgI1IoV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Sep 2020 04:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbgI1IoV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Sep 2020 04:44:21 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A58DC0613CE;
        Mon, 28 Sep 2020 01:44:21 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id d9so348283pfd.3;
        Mon, 28 Sep 2020 01:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gRrO3YUlgZCm6fEhcoL+qBG1AlRduPsFwHcrQgfhLF8=;
        b=QzhT+TEahDmGSNhtO+dkesxGtWqxlVSTlJfY4llgKRIV/ECHHa3Z8kzndIXfZaHw3Z
         LnOHzAcDh7X579AJDN6qdLG113mM+mUCAMq9mjhXOQKXoR0gWJbGDzCZmjEOtHoYBiZ1
         v2eq/bM4pzYsK1gBKEjAkMbdyTyiOw8ZJ370ULBX4JN0jAUzilUABjwBq5PI4vD/6pXw
         ZSd1tLdjHjeeezIklnkY+fhBW1EweYzFFqV/eXHieLQP0K7B9Q7njqp4uh5iSzdisk4Q
         hgM9UNgVbhZ54LoXYPy1KVOlb7BsFGekPHBvdrYTrfTqZZI+096jp0ksbWE5z5qEGGS5
         BSzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gRrO3YUlgZCm6fEhcoL+qBG1AlRduPsFwHcrQgfhLF8=;
        b=dZrTT3CGnP5aSbglVZMwXsLm8pjZjG6qqzfCEQ8b7M/+NIvZJbd49eL4FXzt7nqoDG
         jmdciV6XLg6NKXLUaOXUBwcLacYRh/6TC1mlOz3enWpzFu5bfdEuH0liNM8xlWqvUBWY
         ihT9dnBaiIJ+NV+rrR5FlkCB7D0llEkF7Q0nWn/acEnmI+mUQU2MvpLN7ck2Ysl8EWKP
         E/35TgSaBKjBqNuRkkCfNWzV6Gsqgy5b8q1Y9OMVUNzI3tZcoeDSQ1+KvKt/LVesVgfe
         PqGTp4K3V5xdaWelIJT41qiygHWC4/bG+Brs7YyFV4x2J/yGmRjlFRaNMDY5SFI7Gib3
         dytA==
X-Gm-Message-State: AOAM532/JkZXFb5WPNeuvZY1bO9ZnJnq9tcoFdyQ0ATJl4XlH/16Mz0g
        UqazrV3AbMIOx/cGjanR6Y6Vpm2KfeXDPqAMOsA=
X-Google-Smtp-Source: ABdhPJw7BQ/1b0Cp+vLZpa7oNBx9wJJkOl1cIlRA7iRpsDowgTj6xM07zJ0NQOZYboO22cYxirRXfnrMYoRu3+G2Mh4=
X-Received: by 2002:a63:ec4c:: with SMTP id r12mr395552pgj.74.1601282660571;
 Mon, 28 Sep 2020 01:44:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200928040651.24937-1-haifeng.zhao@intel.com> <20200928040651.24937-3-haifeng.zhao@intel.com>
In-Reply-To: <20200928040651.24937-3-haifeng.zhao@intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 28 Sep 2020 11:44:02 +0300
Message-ID: <CAHp75VfmWDHBv9kXugLN3c=Dj27EsJ43fB=WNDrjaLnGhvrz6Q@mail.gmail.com>
Subject: Re: [PATCH 2/5 V5] PCI: pciehp: check and wait port status out of DPC
 before handling DLLSC and PDC
To:     Ethan Zhao <haifeng.zhao@intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Oliver <oohall@gmail.com>,
        ruscur@russell.cc, Lukas Wunner <lukas@wunner.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Stuart Hayes <stuart.w.hayes@gmail.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        pei.p.jia@intel.com, ashok.raj@linux.intel.com,
        Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 28, 2020 at 7:10 AM Ethan Zhao <haifeng.zhao@intel.com> wrote:

We didn't settle on the v4, why v5?

> When root port has DPC capability and it is enabled, then triggered by
> errors, DPC DLLSC and PDC interrupts will be sent to DPC driver, pciehp
> driver at the same time.
> That will cause following result:
>
> 1. Link and device are recovered by hardware DPC and software DPC driver,
>    device
>    isn't removed, but the pciehp might treat it as device was hot removed.
>
> 2. Race condition happens bettween pciehp_unconfigure_device() called by
>    pciehp_ist() in pciehp driver and pci_do_recovery() called by
>    dpc_handler in DPC driver. no luck, there is no lock to protect
>    pci_stop_and_remove_bus_device()
>    against pci_walk_bus(), they hold different samphore and mutex,
>    pci_stop_and_remove_bus_device holds pci_rescan_remove_lock, and
>    pci_walk_bus() holds pci_bus_sem.
>
> This race condition is not purely code analysis, it could be triggered by
> following command series:
>
>   # setpci -s 64:02.0 0x196.w=000a // 64:02.0 rootport has DPC capability
>   # setpci -s 65:00.0 0x04.w=0544  // 65:00.0 NVMe SSD populated in port
>   # mount /dev/nvme0n1p1 nvme
>
> One shot will cause system panic and NULL pointer reference happened.
> (tested on stable 5.8 & ICS(Ice Lake SP platform, see
> https://en.wikichip.org/wiki/intel/microarchitectures/ice_lake_(server))

...

>    Buffer I/O error on dev nvme0n1p1, logical block 3328, async page read
>    BUG: kernel NULL pointer dereference, address: 0000000000000050
>    #PF: supervisor read access in kernel mode
>    #PF: error_code(0x0000) - not-present page
>    PGD 0
>    Oops: 0000 [#1] SMP NOPTI
>    CPU: 12 PID: 513 Comm: irq/124-pcie-dp Not tainted 5.8.0 el8.x86_64+ #1
>    RIP: 0010:report_error_detected.cold.4+0x7d/0xe6
>    Code: b6 d0 e8 e8 fe 11 00 e8 16 c5 fb ff be 06 00 00 00 48 89 df e8 d3
>    65 ff ff b8 06 00 00 00 e9 75 fc ff ff 48 8b 43 68 45 31 c9 <48> 8b 50
>    50 48 83 3a 00 41 0f 94 c1 45 31 c0 48 85 d2 41 0f 94 c0
>    RSP: 0018:ff8e06cf8762fda8 EFLAGS: 00010246
>    RAX: 0000000000000000 RBX: ff4e3eaacf42a000 RCX: ff4e3eb31f223c01
>    RDX: ff4e3eaacf42a140 RSI: ff4e3eb31f223c00 RDI: ff4e3eaacf42a138
>    RBP: ff8e06cf8762fdd0 R08: 00000000000000bf R09: 0000000000000000
>    R10: 000000eb8ebeab53 R11: ffffffff93453258 R12: 0000000000000002
>    R13: ff4e3eaacf42a130 R14: ff8e06cf8762fe2c R15: ff4e3eab44733828
>    FS:  0000000000000000(0000) GS:ff4e3eab1fd00000(0000) knl
>    GS:0000000000000000
>    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>    CR2: 0000000000000050 CR3: 0000000f8f80a004 CR4: 0000000000761ee0
>    DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>    DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>    PKRU: 55555554
>    Call Trace:
>    ? report_normal_detected+0x20/0x20
>    report_frozen_detected+0x16/0x20
>    pci_walk_bus+0x75/0x90
>    ? dpc_irq+0x90/0x90
>    pcie_do_recovery+0x157/0x201
>    ? irq_finalize_oneshot.part.47+0xe0/0xe0
>    dpc_handler+0x29/0x40
>    irq_thread_fn+0x24/0x60
>    irq_thread+0xea/0x170
>    ? irq_forced_thread_fn+0x80/0x80
>    ? irq_thread_check_affinity+0xf0/0xf0
>    kthread+0x124/0x140
>    ? kthread_park+0x90/0x90
>    ret_from_fork+0x1f/0x30
>    Modules linked in: nft_fib_inet.........
>    CR2: 0000000000000050

Do not pollute the commit messages with irrelevant information.

-- 
With Best Regards,
Andy Shevchenko
