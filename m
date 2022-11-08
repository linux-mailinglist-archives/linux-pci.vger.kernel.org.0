Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C907362086D
	for <lists+linux-pci@lfdr.de>; Tue,  8 Nov 2022 05:52:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbiKHEwX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Nov 2022 23:52:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbiKHEwX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Nov 2022 23:52:23 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1293715808;
        Mon,  7 Nov 2022 20:52:22 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id d13-20020a17090a3b0d00b00213519dfe4aso12354804pjc.2;
        Mon, 07 Nov 2022 20:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Onv7bSlWpyTP3sxZ0pOzA253Q/Pxzf8qUPwaqMOQQ24=;
        b=aSl+rELEGLxsZlEPqaeGzOeLZ+7VeOmH54HVX9HMgoCUURzvIrZLrcCqgSlRK3Cnw8
         FK+igmBRI7YEMaq6bKjlHP7JZzY88Hzr1+hYGLgWTxjyAJNaQvGF6VkHJZT5BwZ+r0AP
         NSmciHiaKiSHoD45SBKxtQ5VC6LpUxa0V9M52QDwrKHu5mpERUeBOPt1wACiKA37XwGG
         2kRdx37z7kB4nRFtKMYvi5hfIKxwJpyBRMFVnPhvmVQr0CL8Dp+AO9LKZPTJFbHBHRtS
         mi6tMmgKN0EJeXVUFeVPq/bmskGVxGSgJQT/MCEM/S0/ed+I7ePtoAPMdXg6U/KWItfl
         GeBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Onv7bSlWpyTP3sxZ0pOzA253Q/Pxzf8qUPwaqMOQQ24=;
        b=BV6zdZVJy/MCvcHO0vVRtQ9P75AbU49QL63HrUUBzCLhHzvb/FUShDQqBcMjeJQJXW
         IZI3VX8Aq8rFoKvq1ih9SKIDsSMHzsxSq4ooW3Cc7qzIvoj7h73+lN3FepmsIDWDC5ky
         B/Q4YEJSMTUQsayE6pFpk1y4bLLN6AAOmIZ/UwnzuUmfsSC8F0OU5MD98ZMkRWBKYoPb
         XxhpaN4zTNkJOzLQVQTGIXWlWwo1LAUAIGb0Fe0OK8r6Z4NFk7myangsHlcwHd9hOHdB
         cTy4wNhD8WYUhTkSnSs1ZJZFAJiM1Uyg7bMfdS2vD6tWjJEPAq2oizB5uaUcvFGWKj0X
         aK6Q==
X-Gm-Message-State: ACrzQf2cIdyKQ2fDueRkxpyisWUxbpeNIL9SLJ9Du1VcjamKvrP6FxEo
        XGNEaQxWN6ZxCWrmjKlNWxk=
X-Google-Smtp-Source: AMsMyM7Lt7EkowLEo7ErOIZWKlwa/4dIYV43oYT0gHtV91gjlMcTIzh5X95uNF2/lIO0RCIclcalZQ==
X-Received: by 2002:a17:90b:1056:b0:212:dc2f:7ee7 with SMTP id gq22-20020a17090b105600b00212dc2f7ee7mr879602pjb.172.1667883141489;
        Mon, 07 Nov 2022 20:52:21 -0800 (PST)
Received: from localhost ([36.152.119.226])
        by smtp.gmail.com with ESMTPSA id 186-20020a6205c3000000b0052d4b0d0c74sm5342515pff.70.2022.11.07.20.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 20:52:20 -0800 (PST)
Date:   Tue, 8 Nov 2022 04:52:16 +0000
From:   Wei Gong <gongwei833x@gmail.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] pci: fix device presence detection for VFs
Message-ID: <20221108044819.GA861843@zander>
References: <20221026060912.173250-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221026060912.173250-1-mst@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

O Wed, Oct 26, 2022 at 02:11:21AM -0400, Michael S. Tsirkin wrote:
> virtio uses the same driver for VFs and PFs.  Accordingly,
> pci_device_is_present is used to detect device presence. This function
> isn't currently working properly for VFs since it attempts reading
> device and vendor ID. As VFs are present if and only if PF is present,
> just return the value for that device.
> 
> Reported-by: Wei Gong <gongwei833x@gmail.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
> 
> Wei Gong, thanks for your testing of the RFC!
> As I made a small change, would appreciate re-testing.
> 
> Thanks!
> 
> changes from RFC:
> 	use pci_physfn() wrapper to make the code build without PCI_IOV
> 
> 
>  drivers/pci/pci.c | 5 +++++
>  1 file changed, 5 insertions(+)

Tested-by: Wei Gong <gongwei833x@gmail.com>

retest done and well.

I would rephrase the bug.

according to sriov's protocol specification vendor_id and
device_id field in all VFs return FFFFh when read
so when vf devs is in the pci_device_is_present,it will be
misjudged as surprise removeal

when io is issued on the vf, normally disable virtio_blk vf
devs,at this time the disable opration will hang. and virtio
blk dev io hang.

task:bash            state:D stack:    0 pid: 1773 ppid:  1241 flags:0x00004002
Call Trace:
 <TASK>
 __schedule+0x2ee/0x900
 schedule+0x4f/0xc0
 blk_mq_freeze_queue_wait+0x69/0xa0
 ? wait_woken+0x80/0x80
 blk_mq_freeze_queue+0x1b/0x20
 blk_cleanup_queue+0x3d/0xd0
 virtblk_remove+0x3c/0xb0 [virtio_blk]
 virtio_dev_remove+0x4b/0x80
 device_release_driver_internal+0x103/0x1d0
 device_release_driver+0x12/0x20
 bus_remove_device+0xe1/0x150
 device_del+0x192/0x3f0
 device_unregister+0x1b/0x60
 unregister_virtio_device+0x18/0x30
 virtio_pci_remove+0x41/0x80
 pci_device_remove+0x3e/0xb0
 device_release_driver_internal+0x103/0x1d0
 device_release_driver+0x12/0x20
 pci_stop_bus_device+0x79/0xa0
 pci_stop_and_remove_bus_device+0x13/0x20
 pci_iov_remove_virtfn+0xc5/0x130
 ? pci_get_device+0x4a/0x60
 sriov_disable+0x33/0xf0
 pci_disable_sriov+0x26/0x30
 virtio_pci_sriov_configure+0x6f/0xa0
 sriov_numvfs_store+0x104/0x140
 dev_attr_store+0x17/0x30
 sysfs_kf_write+0x3e/0x50
 kernfs_fop_write_iter+0x138/0x1c0
 new_sync_write+0x117/0x1b0
 vfs_write+0x185/0x250
 ksys_write+0x67/0xe0
 __x64_sys_write+0x1a/0x20
 do_syscall_64+0x61/0xb0
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f21bd1f3ba4
RSP: 002b:00007ffd34a24188 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f21bd1f3ba4
RDX: 0000000000000002 RSI: 0000560305040800 RDI: 0000000000000001
RBP: 0000560305040800 R08: 000056030503fd50 R09: 0000000000000073
R10: 00000000ffffffff R11: 0000000000000202 R12: 0000000000000002
R13: 00007f21bd2de760 R14: 00007f21bd2da5e0 R15: 00007f21bd2d99e0

when virtio_blk is performing io, as long as there two stages of:
1. dispatch io. queue_usage_counter++;
2. io is completed after receiving the interrupt. queue_usage_counter--;

disable virtio_blk vfs:
  if(!pci_device_is_present(pci_dev))
    virtio_break_device(&vp_dev->vdev);
virtqueue for vf devs will be marked broken.
the interrupt notification io is end. Since it is judged that the
virtqueue has been marked as broken, the completed io will not be
performed.
So queue_usage_counter will not be cleared.
when the disk is removed at the same time, the queue will be frozen,
and you must wait for the queue_usage_counter to be cleared.
Therefore, it leads to the removeal of hang.



Thanks,
Wei Gong
