Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 385A25B1C83
	for <lists+linux-pci@lfdr.de>; Thu,  8 Sep 2022 14:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbiIHMM4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Sep 2022 08:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbiIHMMy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Sep 2022 08:12:54 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2468895F6
        for <linux-pci@vger.kernel.org>; Thu,  8 Sep 2022 05:12:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 2BE6ECE1F1B
        for <linux-pci@vger.kernel.org>; Thu,  8 Sep 2022 12:12:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92570C433C1;
        Thu,  8 Sep 2022 12:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662639169;
        bh=/R0CREhYsB8ovqHQV72g6/yEs8h6aqnDsP3z+cPrH3Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=WaJAcdvebR3foRP6Hu9RhSpw1xO8RtJrdgeUo3VH1qdlahzbBbdQ7eVnaI06fQQNN
         Ax0N+yHA0g1akWDerfwMTV1NzKSIECz1w4E744sbKo6Nk5gFOaWYpWiaIl0nsjTlMG
         V44EEu6HDacxUNpbPuYGztwNAU3xd1cL/+AzC/LcBuKcbO7vHzj/QaO+o8xc69zfit
         ZVTlNDShLah6xv9fBtAx71DY+7nzF0+17k/zciquG4HeMSzkeL1w9guFK/5rY0jWqq
         PELUFRz02IajyWlttaPQn5o3f65Xa10XJGwXqMRcS3pYivAlHvelcZ4JYHw5hCYFPh
         osc73TJjh+dBQ==
Date:   Thu, 8 Sep 2022 07:12:48 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Daniel Gomez <daniel@qtec.com>
Cc:     linux-pci@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: PCI/MSI: kernel NULL pointer dereference
Message-ID: <20220908121248.GA190779@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH1Ww+TS2sdQc4PewxYjGNp94=uGWjh0Z13cjLbVhSWQMOij0w@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 08, 2022 at 12:41:00PM +0200, Daniel Gomez wrote:
> Hi,
> 
> I have the following error whenever I remove the fglrx module from the
> latest 6.0-rc4.

You bisected to 93296cd1325d; I don't see a commit with a "Fixes:"
that references that.  If you can reproduce this with an in-tree
driver, we can certainly fix it, but it's harder for an out-of-tree
driver.

I cc'd some AMD graphics folks in case they have a pointer for where
to get fglrx support.

> Logs:
> /mnt/raid0/krops/workspace/sources/fglrx-module/module/firegl_public.c:1674
> KCL_SetPageCache_Array
> <6>[fglrx] IRQ 37 Disabled
> BUG: kernel NULL pointer dereference, address: 0000000000000010
> #PF: supervisor write access in kernel mode
> #PF: error_code(0x0002) - not-present page
> PGD 0 P4D 0
> Oops: 0002 [#1] SMP NOPTI
> CPU: 1 PID: 254 Comm: rmmod Tainted: G        W  O
> 6.0.0-rc4-qtec-standard #2
> Hardware name: QTechnology QT5022/QT5022, BIOS PM_2.1.0.309 X64 09/27/2013
> RIP: 0010:mutex_lock+0x2a/0x40
> Code: 0f 1f 44 00 00 53 be 1b 01 00 00 48 89 fb 48 c7 c7 08 81 3d 82 e8 46 2c 52
>  ff e8 01 d7 ff ff 31 c0 65 48 8b 14 25 00 ad 01 00 <f0> 48 0f b1 13 74 06 48 89
>  df 5b eb b9 5b c3 0f 1f 80 00 00 00 00
> RSP: 0018:ffffc90000b07dd8 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: 0000000000000010 RCX: 0000000000000000
> RDX: ffff888116aabb00 RSI: 000000000000011b RDI: ffffffff823d8108
> RBP: ffff8881148d20d0 R08: 0000000000000000 R09: ffffffffa053537b
> R10: ffff888149365cc0 R11: ffffea00052c5048 R12: 0000000000000000
> R13: ffff88813877c000 R14: 0000000000000000 R15: 0000000000000000
> FS:  00007f6f90b3cb80(0000) GS:ffff88815b300000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000010 CR3: 000000011e4c8000 CR4: 00000000000006e0
> Call Trace:
>  <TASK>
>  pci_disable_msi+0x34/0xe0
>  irqmgr_wrap_shutdown+0x165/0x190 [fglrx]
>  ? firegl_takedown+0x841/0x950 [fglrx]
>  ? kobject_put+0xa6/0x220
>  ? cleanup_device+0x299/0x2a0 [fglrx]
>  ? pci_unregister_driver+0x42/0xa0
>  ? firegl_cleanup_device_heads+0x65/0xa0 [fglrx]
>  ? firegl_cleanup_module+0x84/0x11c [fglrx]
>  ? __x64_sys_delete_module+0x11b/0x210
>  ? get_vtime_delta+0xe/0x40
>  ? vtime_user_exit+0x1c/0x60
>  ? __ct_user_exit+0x68/0xb0
>  ? do_syscall_64+0x3c/0x80
>  ? entry_SYSCALL_64_after_hwframe+0x63/0xcd
>  </TASK>
> Modules linked in: amdgpu fglrx(O-) ath9k ath9k_common mfd_core gpu_sched
> drm_buddy drm_ttm_helper ath9k_hw ttm drm_display_helper drm_kms_helper ath
> sp5100_tco syscopyarea sysfillrect sysimgblt fb_sys_fops video drm backlight
> ipv6
> CR2: 0000000000000010
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:mutex_lock+0x2a/0x40
> Code: 0f 1f 44 00 00 53 be 1b 01 00 00 48 89 fb 48 c7 c7 08 81 3d 82 e8 46 2c 52
>  ff e8 01 d7 ff ff 31 c0 65 48 8b 14 25 00 ad 01 00 <f0> 48 0f b1 13 74 06 48 89
>  df 5b eb b9 5b c3 0f 1f 80 00 00 00 00
> RSP: 0018:ffffc90000b07dd8 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: 0000000000000010 RCX: 0000000000000000
> RDX: ffff888116aabb00 RSI: 000000000000011b RDI: ffffffff823d8108
> RBP: ffff8881148d20d0 R08: 0000000000000000 R09: ffffffffa053537b
> R10: ffff888149365cc0 R11: ffffea00052c5048 R12: 0000000000000000
> R13: ffff88813877c000 R14: 0000000000000000 R15: 0000000000000000
> FS:  00007f6f90b3cb80(0000) GS:ffff88815b300000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000010 CR3: 000000011e4c8000 CR4: 00000000000006e0
> 
> Steps:
> insmod fglrx.ko
> clinfo
> MatrixMultiplication
> rmmod fglrx.ko
> 
> I know this is an out of tree driver from AMD but we still need that driver
> for some products because of the OpenCL stack support on it.
> 
> Note: The open-source upstream radeon does not support OpenCL.
> 
> So, doing git-bisect I found the issue is provoked by this commit [1].
> Unfortunately, I cannot revert it for testing as if I do it the system hangs
> on boot because of this other commit [2].
> 
> I understand, the driver might have some issues but shouldn't the kernel
> prevent this crash at pci_disable_msi function? Do we have a mutex
> problem here provoked by the fglrx driver?
> Does anyone have any suggestions on how we can/should proceed with this?
> 
> Thanks in advance,
> Daniel
> 
> [1] Commit 93296cd1325d1d9afede60202d8833011c9001f2:
> 93296cd1325d 2021-12-15 PCI/MSI: Allocate MSI device data on first use
> [2] Commit ffd84485e6beb9cad3e5a133d88201b995298c33:
> ffd84485e6be 2021-12-10 PCI/MSI: Let the irq code handle sysfs groups
