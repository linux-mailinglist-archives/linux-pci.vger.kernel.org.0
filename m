Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B03DD27A9F1
	for <lists+linux-pci@lfdr.de>; Mon, 28 Sep 2020 10:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgI1It5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Sep 2020 04:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbgI1It5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Sep 2020 04:49:57 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B56FC0613CE;
        Mon, 28 Sep 2020 01:49:57 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id k14so428939edo.1;
        Mon, 28 Sep 2020 01:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AsYHr74E0NgGElTzAxxwUemct7DC1VG78DhrKID3Ql0=;
        b=UcUkZnsd1sdb7pd1KBi24U3Tc4oCEsEFjk9G9Xzzbez+Ge+ei8aShr+QYUEzorbm6D
         Dlu7GXeVm28q+e0u+uLxx3SH9uOVBUaJKXCnFla1r/iAduL5iTgi900PrQDZpnFkq9hA
         8qYwM1nuK3MDwguG14cEbaH/HK4QQ5SYwEZIM2f76t1jx/6OUPKrrLvrS2GVqTKU6O+0
         lbfd4SOqzgoZ4sTrQAco4tsyLSiyRMDPoMifLUqTVEpXTg5KP3J3NXir2b2ZG/B/gO10
         oFaVPlBdGxmTYiU77JWwJtbHQFSdA6tuNKaIRM4l5qZIOzY/Wf4xb49m8x32HFGlSjwZ
         CmwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AsYHr74E0NgGElTzAxxwUemct7DC1VG78DhrKID3Ql0=;
        b=PorZuncIK9OTUNLjPkTEFDf/g2pWRFoLT8VVtAkNdGB0ihS7t3VIRsT57Z5fY49/6s
         /GDP04XPT+A2GM20fX1yj7B5bYYQNEMwRc/mWMyzQy7TbAWkvt3gRYh9HczRv0CK65/2
         syyTW5ueSQLV9nK+bsDsYlbrgQOmanQ8jIjFhErp16P3etuCqhErp9yUsDcWuVroYsHc
         kvuHu58KTpnfQrRi2EWK9c4kvnsENkVt36nGCcyy7jG5sDJCXNSMIeSjvrb//nkNv+On
         g/wUnx3wTAqiGZ7cgDsG5sDVhrLhi4QS2bmx3/YV5PdKLiJIovHjQ3XQ9e33Ndw/ZfHX
         CiAQ==
X-Gm-Message-State: AOAM533hyfvOxisFzXnyZ4QYwtLsappN5H83FnZ3kNWcEjHYMPimOSMH
        F8IgZKLSu6TduEF/X+ge5zYzObzEDNct8SPsrso=
X-Google-Smtp-Source: ABdhPJz0ERO+zCga4UcOUgBs1/DPDya3Tm/1nxbLmxoadAVAlY9LSFRbMfRZ+6Qk3hTAzbgrjlrJQpOd5iSii/3tsSk=
X-Received: by 2002:a50:cfc5:: with SMTP id i5mr522153edk.151.1601282995700;
 Mon, 28 Sep 2020 01:49:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200928040651.24937-1-haifeng.zhao@intel.com>
 <20200928040651.24937-3-haifeng.zhao@intel.com> <CAHp75VfmWDHBv9kXugLN3c=Dj27EsJ43fB=WNDrjaLnGhvrz6Q@mail.gmail.com>
In-Reply-To: <CAHp75VfmWDHBv9kXugLN3c=Dj27EsJ43fB=WNDrjaLnGhvrz6Q@mail.gmail.com>
From:   Ethan Zhao <xerces.zhao@gmail.com>
Date:   Mon, 28 Sep 2020 16:49:44 +0800
Message-ID: <CAKF3qh2a+1E9yahNT9DuTmOkW-Fn+k=kakXkk_VKxZmrUcqPqA@mail.gmail.com>
Subject: Re: [PATCH 2/5 V5] PCI: pciehp: check and wait port status out of DPC
 before handling DLLSC and PDC
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Ethan Zhao <haifeng.zhao@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, Oliver <oohall@gmail.com>,
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
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 28, 2020 at 4:45 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Mon, Sep 28, 2020 at 7:10 AM Ethan Zhao <haifeng.zhao@intel.com> wrote=
:
>
> We didn't settle on the v4, why v5?

We could fix it with v6, v5 is used to fix other things.

>
> > When root port has DPC capability and it is enabled, then triggered by
> > errors, DPC DLLSC and PDC interrupts will be sent to DPC driver, pciehp
> > driver at the same time.
> > That will cause following result:
> >
> > 1. Link and device are recovered by hardware DPC and software DPC drive=
r,
> >    device
> >    isn't removed, but the pciehp might treat it as device was hot remov=
ed.
> >
> > 2. Race condition happens bettween pciehp_unconfigure_device() called b=
y
> >    pciehp_ist() in pciehp driver and pci_do_recovery() called by
> >    dpc_handler in DPC driver. no luck, there is no lock to protect
> >    pci_stop_and_remove_bus_device()
> >    against pci_walk_bus(), they hold different samphore and mutex,
> >    pci_stop_and_remove_bus_device holds pci_rescan_remove_lock, and
> >    pci_walk_bus() holds pci_bus_sem.
> >
> > This race condition is not purely code analysis, it could be triggered =
by
> > following command series:
> >
> >   # setpci -s 64:02.0 0x196.w=3D000a // 64:02.0 rootport has DPC capabi=
lity
> >   # setpci -s 65:00.0 0x04.w=3D0544  // 65:00.0 NVMe SSD populated in p=
ort
> >   # mount /dev/nvme0n1p1 nvme
> >
> > One shot will cause system panic and NULL pointer reference happened.
> > (tested on stable 5.8 & ICS(Ice Lake SP platform, see
> > https://en.wikichip.org/wiki/intel/microarchitectures/ice_lake_(server)=
)
>
> ...
>
> >    Buffer I/O error on dev nvme0n1p1, logical block 3328, async page re=
ad
> >    BUG: kernel NULL pointer dereference, address: 0000000000000050
> >    #PF: supervisor read access in kernel mode
> >    #PF: error_code(0x0000) - not-present page
> >    PGD 0
> >    Oops: 0000 [#1] SMP NOPTI
> >    CPU: 12 PID: 513 Comm: irq/124-pcie-dp Not tainted 5.8.0 el8.x86_64+=
 #1
> >    RIP: 0010:report_error_detected.cold.4+0x7d/0xe6
> >    Code: b6 d0 e8 e8 fe 11 00 e8 16 c5 fb ff be 06 00 00 00 48 89 df e8=
 d3
> >    65 ff ff b8 06 00 00 00 e9 75 fc ff ff 48 8b 43 68 45 31 c9 <48> 8b =
50
> >    50 48 83 3a 00 41 0f 94 c1 45 31 c0 48 85 d2 41 0f 94 c0
> >    RSP: 0018:ff8e06cf8762fda8 EFLAGS: 00010246
> >    RAX: 0000000000000000 RBX: ff4e3eaacf42a000 RCX: ff4e3eb31f223c01
> >    RDX: ff4e3eaacf42a140 RSI: ff4e3eb31f223c00 RDI: ff4e3eaacf42a138
> >    RBP: ff8e06cf8762fdd0 R08: 00000000000000bf R09: 0000000000000000
> >    R10: 000000eb8ebeab53 R11: ffffffff93453258 R12: 0000000000000002
> >    R13: ff4e3eaacf42a130 R14: ff8e06cf8762fe2c R15: ff4e3eab44733828
> >    FS:  0000000000000000(0000) GS:ff4e3eab1fd00000(0000) knl
> >    GS:0000000000000000
> >    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >    CR2: 0000000000000050 CR3: 0000000f8f80a004 CR4: 0000000000761ee0
> >    DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> >    DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> >    PKRU: 55555554
> >    Call Trace:
> >    ? report_normal_detected+0x20/0x20
> >    report_frozen_detected+0x16/0x20
> >    pci_walk_bus+0x75/0x90
> >    ? dpc_irq+0x90/0x90
> >    pcie_do_recovery+0x157/0x201
> >    ? irq_finalize_oneshot.part.47+0xe0/0xe0
> >    dpc_handler+0x29/0x40
> >    irq_thread_fn+0x24/0x60
> >    irq_thread+0xea/0x170
> >    ? irq_forced_thread_fn+0x80/0x80
> >    ? irq_thread_check_affinity+0xf0/0xf0
> >    kthread+0x124/0x140
> >    ? kthread_park+0x90/0x90
> >    ret_from_fork+0x1f/0x30
> >    Modules linked in: nft_fib_inet.........
> >    CR2: 0000000000000050
>
> Do not pollute the commit messages with irrelevant information.

That is whole panic, Andy, someone like the whole Oops, If I removed someth=
ing,
Will someone say 'why not integral=EF=BC=8Cwhy removed somehting  =E2=80=98
>
> --
> With Best Regards,
> Andy Shevchenko
