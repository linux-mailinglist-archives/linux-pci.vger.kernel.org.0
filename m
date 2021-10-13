Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79C4B42B6F2
	for <lists+linux-pci@lfdr.de>; Wed, 13 Oct 2021 08:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237945AbhJMGVP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Oct 2021 02:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbhJMGU6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Oct 2021 02:20:58 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1268CC061570;
        Tue, 12 Oct 2021 23:18:56 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id y10so1256611qkp.9;
        Tue, 12 Oct 2021 23:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JcdsjTEjHPlZZyb1Dbmr1v+cGhuV1W3tnNYJBsIpCnE=;
        b=h5Y1ORQPJJD8/3xiT9opipmvbm7onqZfube15REdira6D7JFIGZYHcvePG35Vvg1EM
         wxnV3L8+nVU8Doaz3AHNVtYosj3JkeG8PEXk/BY0ECewc3sCeSjAm1G6jWMbeJuap4I5
         K56W/0pTqiUdmsT75HzkL5Dl7/DwtdxSE6U++Z7BvZf8WTDGQDqozTN6OP7gFSThqC6V
         /OOKxb4F+XOjBCLfR7qEv29zhsLSL1+6V1tPABgTIf17TM59qitA70EQ7r5PrH/Th4u3
         81rr2mtoP7lFMf/KW7eEEGbeijhkNi/PMeCrxDXC17TktJmPDQ7xRdMZfDvCb66qMvcj
         xJRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JcdsjTEjHPlZZyb1Dbmr1v+cGhuV1W3tnNYJBsIpCnE=;
        b=wKYbmiERVIY01kOpBfWYkzdQ4tA7oQAst/QPmdnkFjimHJV5KzFqF05qF0VKRPHP6+
         2QIdUVBctAdRTwycK9Gi34KQT2MCrqvfdTTHrAD9SI0lAwxQ1V1A8EV5K0Mz4igW+/ix
         FuvNMFWEXbteVPAJRj8oYEQo/Q2QoE9oyRzEoojTL89/XWxfR5ZSbhRlArxr74aZDts3
         9fxG1pWVtr9ll6IVSLAEB9YNokvw1EcxP6+cSCDRqkU49rteC21niY/r3ZQsCA/FLugt
         l13wvjJiKgJGh6eQSSzWUDlPalkOVevyL5DTcL2vM0L7JwcKePQ7ZfaIym4lbjP23MDG
         +vfA==
X-Gm-Message-State: AOAM532g7sh8Cdbpzd3/A2fhONmEeki2Vb7Q0dtvrFCNOr4iK0xvXRX8
        2gIlljm1lxnxzHuz3R5WXL9gBI0FJF1Z2tRNBSo=
X-Google-Smtp-Source: ABdhPJzNukla2kqaI6glp6RgpRUG7saizBBtMwf/fEJQoJ+tivUtj0te51DfXp+D88jI2i7TelfTL1DQDR6uzH5+vws=
X-Received: by 2002:a37:a301:: with SMTP id m1mr1088774qke.470.1634105935214;
 Tue, 12 Oct 2021 23:18:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200909112850.hbtgkvwqy2rlixst@pali> <20201006222222.GA3221382@bjorn-Precision-5520>
 <20201007081227.d6f6otfsnmlgvegi@pali> <20210407142538.GA12387@meh.true.cz>
 <20210407145147.bvtubdmz4k6nulf7@pali> <20210407153041.GA17046@meh.true.cz>
 <cd4812f0-1de3-0582-936c-ba30906595af@citymesh.com> <20210625115402.jwga35xmknmo4vdk@pali>
In-Reply-To: <20210625115402.jwga35xmknmo4vdk@pali>
From:   Dexuan-Linux Cui <dexuan.linux@gmail.com>
Date:   Tue, 12 Oct 2021 23:18:44 -0700
Message-ID: <CAA42JLZCE0CFUJHVZLT77YvPap49_cGiAMMt2E-B7X0tzST6jg@mail.gmail.com>
Subject: Re: PCI: Race condition in pci_create_sysfs_dev_files
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     Koen Vandeputte <koen.vandeputte@citymesh.com>,
        =?UTF-8?Q?Petr_=C5=A0tetiar?= <ynezz@true.cz>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Yinghai Lu <yinghai@kernel.org>,
        Dexuan Cui <decui@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 25, 2021 at 4:55 AM Pali Roh=C3=A1r <pali@kernel.org> wrote:
>
> Hello!
>
> On Friday 25 June 2021 13:29:00 Koen Vandeputte wrote:
> > ...
> It is same race condition which I described in the first email of this
> email thread. I described exactly when it happens. I'm not able to
> trigger it with new kernels but as we know race conditions are hard to
> trigger...
>
> So result is that we know about it, just fix is not ready yet as it is
> not easy to fix it.
>
> Krzysztof has been working on fixing it, so maybe can provide an
> update...

I think we're seeing the same issue with a Linux VM on Hyper-V. Here
the kernel is https://git.launchpad.net/~canonical-kernel/ubuntu/+source/li=
nux-azure/+git/bionic/tree/?h=3DUbuntu-azure-5.4-5.4.0-1061.64_18.04.1

[    4.680707] hv_pci 47505500-0003-0000-3130-444531334632: PCI VMBus
probing: Using version 0x10002
[    4.730457] hv_pci 47505500-0003-0000-3130-444531334632: PCI host
bridge to bus 0003:00
[    4.735577] pci_bus 0003:00: root bus resource [mem
0x43000000-0x43ffffff window]
[    4.742189] pci_bus 0003:00: root bus resource [mem
0x1020000000-0x1031ffffff window]
[    4.747027] pci 0003:00:00.0: [10de:13f2] type 00 class 0x030000
[    4.770114] pci 0003:00:00.0: reg 0x10: [mem 0x43000000-0x43ffffff]
[    4.792153] pci 0003:00:00.0: reg 0x14: [mem
0x1020000000-0x102fffffff 64bit pref]
[    4.814022] pci 0003:00:00.0: reg 0x1c: [mem
0x1030000000-0x1031ffffff 64bit pref]
[    4.854830] pci 0003:00:00.0: Enabling HDA controller
[    4.869665] pci 0003:00:00.0: vgaarb: VGA device added:
decodes=3Dio+mem,owns=3Dmem,locks=3Dnone
[    4.879399] pci 0003:00:00.0: BAR 1: assigned [mem
0x1020000000-0x102fffffff 64bit pref]
[    4.903880] pci 0003:00:00.0: BAR 3: assigned [mem
0x1030000000-0x1031ffffff 64bit pref]
[    4.927977] pci 0003:00:00.0: BAR 0: assigned [mem 0x43000000-0x43ffffff=
]
[    4.938162] sysfs: cannot create duplicate filename
'/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A03:00/device:07/VMBUS:01/47505500-00=
03-0000-3130-444531334632/pci0003:00/0003:00:00.0/config'
[    4.951818] CPU: 0 PID: 135 Comm: kworker/0:2 Not tainted
5.4.0-1061-azure #64~18.04.1-Ubuntu
[    4.951820] Hardware name: Microsoft Corporation Virtual
Machine/Virtual Machine, BIOS 090007  06/02/2017
[    4.955812] Workqueue: hv_pri_chan vmbus_add_channel_work
[    4.955812] Call Trace:
[    4.955812]  dump_stack+0x57/0x6d
[    4.955812]  sysfs_warn_dup+0x5b/0x70
[    4.955812]  sysfs_add_file_mode_ns+0x158/0x180
[    4.955812]  sysfs_create_bin_file+0x64/0x90
[    4.955812]  pci_create_sysfs_dev_files+0x72/0x270
[    4.955812]  pci_bus_add_device+0x30/0x80
[    4.955812]  pci_bus_add_devices+0x31/0x70
[    4.955812]  hv_pci_probe+0x48c/0x650
[    4.955812]  vmbus_probe+0x3e/0x90
[    4.955812]  really_probe+0xf5/0x440
[    4.955812]  driver_probe_device+0x11b/0x130
[    4.955812]  __device_attach_driver+0x7b/0xe0
[    4.955812]  ? driver_allows_async_probing+0x60/0x60
[    4.955812]  bus_for_each_drv+0x6e/0xb0
[    4.955812]  __device_attach+0xe4/0x160
[    4.955812]  device_initial_probe+0x13/0x20
[    4.955812]  bus_probe_device+0x92/0xa0
[    4.955812]  device_add+0x402/0x690
[    4.955812]  device_register+0x1a/0x20
[    4.955812]  vmbus_device_register+0x5e/0xf0
[    4.955812]  vmbus_add_channel_work+0x2c4/0x640
[    4.955812]  process_one_work+0x209/0x400
[    4.955812]  worker_thread+0x34/0x400
[    4.955812]  kthread+0x121/0x140
[    4.955812]  ? process_one_work+0x400/0x400
[    4.955812]  ? kthread_park+0x90/0x90
[    4.955812]  ret_from_fork+0x35/0x40

Thanks,
Dexuan
