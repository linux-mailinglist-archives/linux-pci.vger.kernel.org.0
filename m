Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7923624ABD
	for <lists+linux-pci@lfdr.de>; Thu, 10 Nov 2022 20:35:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbiKJTfv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Nov 2022 14:35:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiKJTfv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Nov 2022 14:35:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719292725;
        Thu, 10 Nov 2022 11:35:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 179EB61E17;
        Thu, 10 Nov 2022 19:35:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A504C433D6;
        Thu, 10 Nov 2022 19:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668108949;
        bh=GjYh2rwDQpvQh/C0cKoN4LV9KkDsi5LeuiwKpD+ulzA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=inpWH9wIbbyIbAM7D4XDb61sPMkugXsbV1XY4rY5KXQOCHI0qbJ2RTfpjFJiSU1Zc
         mwqMTv5yrBtqKGa3cY9cqf3LumXUNNlfu/ZkQ6THt2sIA5FkTsPOXD3EPB6uAqt90P
         pEHeEXhoH4cv0GWMBHkzGaWNEwzJY6LeIYKugwELhCCSJ3Mc3SjRJAzh0NNJzX0CRy
         y6lFbWHQGkQ7zQzMk0s0e1+2/fIvtvl+dNVTOJsTX6X2r3vCn98RGk5UNdC3zqWsa9
         gvz2zZ8DnET1fy/7v6NZuco3EvION5KZM2GjYFTTc0tzgFos/tx7bE7eM+El4Ol/3Z
         wxJHfU8eUXMSw==
Date:   Thu, 10 Nov 2022 13:35:47 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Wei Gong <gongwei833x@gmail.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] pci: fix device presence detection for VFs
Message-ID: <20221110193547.GA631336@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221108044819.GA861843@zander>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Wei,

I can't quite parse this.  Is the problem that you had some virtio I/O
in progress, you wrote "0" to /sys/.../sriov_numvfs, and the virtio
I/O operation hangs?

Is there any indication to the user, e.g., softlockup oops?

More questions below.

On Tue, Nov 08, 2022 at 04:52:16AM +0000, Wei Gong wrote:

> according to sriov's protocol specification vendor_id and
> device_id field in all VFs return FFFFh when read
> so when vf devs is in the pci_device_is_present,it will be
> misjudged as surprise removeal
> 
> when io is issued on the vf, normally disable virtio_blk vf
> devs,at this time the disable opration will hang. and virtio
> blk dev io hang.
>
> task:bash            state:D stack:    0 pid: 1773 ppid:  1241 flags:0x00004002
> Call Trace:
>  <TASK>
>  __schedule+0x2ee/0x900
>  schedule+0x4f/0xc0
>  blk_mq_freeze_queue_wait+0x69/0xa0
>  ? wait_woken+0x80/0x80
>  blk_mq_freeze_queue+0x1b/0x20
>  blk_cleanup_queue+0x3d/0xd0
>  virtblk_remove+0x3c/0xb0 [virtio_blk]
>  virtio_dev_remove+0x4b/0x80
>  device_release_driver_internal+0x103/0x1d0
>  device_release_driver+0x12/0x20
>  bus_remove_device+0xe1/0x150
>  device_del+0x192/0x3f0
>  device_unregister+0x1b/0x60
>  unregister_virtio_device+0x18/0x30
>  virtio_pci_remove+0x41/0x80
>  pci_device_remove+0x3e/0xb0
>  device_release_driver_internal+0x103/0x1d0
>  device_release_driver+0x12/0x20
>  pci_stop_bus_device+0x79/0xa0
>  pci_stop_and_remove_bus_device+0x13/0x20
>  pci_iov_remove_virtfn+0xc5/0x130
>  ? pci_get_device+0x4a/0x60
>  sriov_disable+0x33/0xf0
>  pci_disable_sriov+0x26/0x30
>  virtio_pci_sriov_configure+0x6f/0xa0
>  sriov_numvfs_store+0x104/0x140
>  dev_attr_store+0x17/0x30
>  sysfs_kf_write+0x3e/0x50
>  kernfs_fop_write_iter+0x138/0x1c0
>  new_sync_write+0x117/0x1b0
>  vfs_write+0x185/0x250
>  ksys_write+0x67/0xe0
>  __x64_sys_write+0x1a/0x20
>  do_syscall_64+0x61/0xb0
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x7f21bd1f3ba4
> RSP: 002b:00007ffd34a24188 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f21bd1f3ba4
> RDX: 0000000000000002 RSI: 0000560305040800 RDI: 0000000000000001
> RBP: 0000560305040800 R08: 000056030503fd50 R09: 0000000000000073
> R10: 00000000ffffffff R11: 0000000000000202 R12: 0000000000000002
> R13: 00007f21bd2de760 R14: 00007f21bd2da5e0 R15: 00007f21bd2d99e0
> 
> when virtio_blk is performing io, as long as there two stages of:
> 1. dispatch io. queue_usage_counter++;
> 2. io is completed after receiving the interrupt. queue_usage_counter--;
> 
> disable virtio_blk vfs:
>   if(!pci_device_is_present(pci_dev))
>     virtio_break_device(&vp_dev->vdev);
> virtqueue for vf devs will be marked broken.
> the interrupt notification io is end. Since it is judged that the
> virtqueue has been marked as broken, the completed io will not be
> performed.
> So queue_usage_counter will not be cleared.
> when the disk is removed at the same time, the queue will be frozen,
> and you must wait for the queue_usage_counter to be cleared.
> Therefore, it leads to the removeal of hang.

I want to follow along in the code, but I need some hints.

"queue_usage_counter" looks like it's supposed to be a symbol, but I
can't find it.

Where (which function) is the I/O dispatched and queue_usage_counter
incremented?  Where is queue_usage_counter decremented?

Prior to this change pci_device_is_present(VF) returned "false"
(because the VF Vendor ID is 0xffff); after the change it will return
"true" (because it will look at the PF Vendor ID instead).

Previously virtio_pci_remove() called virtio_break_device().  I guess
that meant the virtio I/O operation will never be completed?

But if we don't call virtio_break_device(), the virtio I/O operation
*will* be completed?

Bjorn
