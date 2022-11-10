Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9B5D624B8B
	for <lists+linux-pci@lfdr.de>; Thu, 10 Nov 2022 21:17:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbiKJURI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Nov 2022 15:17:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbiKJURH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Nov 2022 15:17:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DBAB53EED
        for <linux-pci@vger.kernel.org>; Thu, 10 Nov 2022 12:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668111362;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PkpNiTy02Kl92bzGrUkAFIk/Fo/N4N8FwYswcHibr9s=;
        b=F75NC5ncTK85u2hlvmi4F7IcjisMee9DXcF+tsL62Z/TVM5kBnzK+c3pgmGV9ClA7nlRuq
        uBr+x5LFMXFCtDzMdadB7jSgwTsogr7bNi4PQj70Gyu3TUHIARvTL0bjAA/cEouVpV+LOz
        tCDHYN4dFydhPlx/qXTj6/vgQIG+dm4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-111-MhbvQ4BRM-uROACk5N8wqg-1; Thu, 10 Nov 2022 15:16:01 -0500
X-MC-Unique: MhbvQ4BRM-uROACk5N8wqg-1
Received: by mail-wr1-f69.google.com with SMTP id s7-20020adfa287000000b00236c367fcddso635840wra.6
        for <linux-pci@vger.kernel.org>; Thu, 10 Nov 2022 12:16:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PkpNiTy02Kl92bzGrUkAFIk/Fo/N4N8FwYswcHibr9s=;
        b=L4t2K5yujqXXI7/LU5djbrEgEq8Uv2r5ko/T+8+xcNefIJnlSVwwFvKU/XWD/gMO74
         Cz3DGEOYyMRn4ID8b23n1fiLXb7BsRxWTTwoDZ+IdmrVE1Zj+LKCY9bxEn2aQYxD4j4B
         1epS3WB4plYP4mUgCquUzB9E9UyoY9tbUX/jazXIfPKuZrJWlJrJ9P1kokh3Es657JJh
         T/5izjx0VASUsVGhEXxtR2LvK7a58BN+VEiTqXdLmPH2uqq7TIJETWqs7UNmTHb+v69G
         HANz6amULJf4bbwMaXtsnwsRHxj6g/cKajxcZAS7Q/G8CZos6Czry5wgWnoI+kr5zuMM
         1cwg==
X-Gm-Message-State: ACrzQf1vpB4i5OYuIJWCDWrEEOeClBoPWyL7+VhdOJGspV+CrxTRltBC
        JTimtgIWFVcUXBJ425TTB0xidIzELMzhUx8IN/yNOQzprjaudWjKE+YTrGjddqDJQosz22tnqjU
        0ZlliLRnya4+R4hJdoNyR
X-Received: by 2002:a5d:59ae:0:b0:236:6861:a89d with SMTP id p14-20020a5d59ae000000b002366861a89dmr43774499wrr.437.1668111359830;
        Thu, 10 Nov 2022 12:15:59 -0800 (PST)
X-Google-Smtp-Source: AMsMyM6S3ENztY75wDSVKFfDNx9eFsb13CNbSGZAMisdkZIMlXDXXSCYTktknl3xbMoyl64iAmazgg==
X-Received: by 2002:a5d:59ae:0:b0:236:6861:a89d with SMTP id p14-20020a5d59ae000000b002366861a89dmr43774490wrr.437.1668111359531;
        Thu, 10 Nov 2022 12:15:59 -0800 (PST)
Received: from redhat.com ([2.52.3.250])
        by smtp.gmail.com with ESMTPSA id p16-20020adfe610000000b002364c77bc96sm86110wrm.33.2022.11.10.12.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 12:15:58 -0800 (PST)
Date:   Thu, 10 Nov 2022 15:15:55 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Wei Gong <gongwei833x@gmail.com>, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] pci: fix device presence detection for VFs
Message-ID: <20221110144700-mutt-send-email-mst@kernel.org>
References: <20221108044819.GA861843@zander>
 <20221110193547.GA631336@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221110193547.GA631336@bhelgaas>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 10, 2022 at 01:35:47PM -0600, Bjorn Helgaas wrote:
> Hi Wei,
> 
> I can't quite parse this.  Is the problem that you had some virtio I/O
> in progress, you wrote "0" to /sys/.../sriov_numvfs, and the virtio
> I/O operation hangs?

I think so. I also think that just attempting to
remove the module or to unbind the driver from it
will have the same effect.

> Is there any indication to the user, e.g., softlockup oops?
> 
> More questions below.
> 
> On Tue, Nov 08, 2022 at 04:52:16AM +0000, Wei Gong wrote:
> 
> > according to sriov's protocol specification vendor_id and
> > device_id field in all VFs return FFFFh when read
> > so when vf devs is in the pci_device_is_present,it will be
> > misjudged as surprise removeal
> > 
> > when io is issued on the vf, normally disable virtio_blk vf
> > devs,at this time the disable opration will hang. and virtio
> > blk dev io hang.
> >
> > task:bash            state:D stack:    0 pid: 1773 ppid:  1241 flags:0x00004002
> > Call Trace:
> >  <TASK>
> >  __schedule+0x2ee/0x900
> >  schedule+0x4f/0xc0
> >  blk_mq_freeze_queue_wait+0x69/0xa0
> >  ? wait_woken+0x80/0x80
> >  blk_mq_freeze_queue+0x1b/0x20
> >  blk_cleanup_queue+0x3d/0xd0
> >  virtblk_remove+0x3c/0xb0 [virtio_blk]
> >  virtio_dev_remove+0x4b/0x80
> >  device_release_driver_internal+0x103/0x1d0
> >  device_release_driver+0x12/0x20
> >  bus_remove_device+0xe1/0x150
> >  device_del+0x192/0x3f0
> >  device_unregister+0x1b/0x60
> >  unregister_virtio_device+0x18/0x30
> >  virtio_pci_remove+0x41/0x80
> >  pci_device_remove+0x3e/0xb0
> >  device_release_driver_internal+0x103/0x1d0
> >  device_release_driver+0x12/0x20
> >  pci_stop_bus_device+0x79/0xa0
> >  pci_stop_and_remove_bus_device+0x13/0x20
> >  pci_iov_remove_virtfn+0xc5/0x130
> >  ? pci_get_device+0x4a/0x60
> >  sriov_disable+0x33/0xf0
> >  pci_disable_sriov+0x26/0x30
> >  virtio_pci_sriov_configure+0x6f/0xa0
> >  sriov_numvfs_store+0x104/0x140
> >  dev_attr_store+0x17/0x30
> >  sysfs_kf_write+0x3e/0x50
> >  kernfs_fop_write_iter+0x138/0x1c0
> >  new_sync_write+0x117/0x1b0
> >  vfs_write+0x185/0x250
> >  ksys_write+0x67/0xe0
> >  __x64_sys_write+0x1a/0x20
> >  do_syscall_64+0x61/0xb0
> >  entry_SYSCALL_64_after_hwframe+0x44/0xae
> > RIP: 0033:0x7f21bd1f3ba4
> > RSP: 002b:00007ffd34a24188 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
> > RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f21bd1f3ba4
> > RDX: 0000000000000002 RSI: 0000560305040800 RDI: 0000000000000001
> > RBP: 0000560305040800 R08: 000056030503fd50 R09: 0000000000000073
> > R10: 00000000ffffffff R11: 0000000000000202 R12: 0000000000000002
> > R13: 00007f21bd2de760 R14: 00007f21bd2da5e0 R15: 00007f21bd2d99e0
> > 
> > when virtio_blk is performing io, as long as there two stages of:
> > 1. dispatch io. queue_usage_counter++;
> > 2. io is completed after receiving the interrupt. queue_usage_counter--;
> > 
> > disable virtio_blk vfs:
> >   if(!pci_device_is_present(pci_dev))
> >     virtio_break_device(&vp_dev->vdev);
> > virtqueue for vf devs will be marked broken.
> > the interrupt notification io is end. Since it is judged that the
> > virtqueue has been marked as broken, the completed io will not be
> > performed.
> > So queue_usage_counter will not be cleared.
> > when the disk is removed at the same time, the queue will be frozen,
> > and you must wait for the queue_usage_counter to be cleared.
> > Therefore, it leads to the removeal of hang.
> 
> I want to follow along in the code, but I need some hints.
> 
> "queue_usage_counter" looks like it's supposed to be a symbol, but I
> can't find it.

I think it refers to q->q_usage_counter in blk core.

> Where (which function) is the I/O dispatched and queue_usage_counter
> incremented?  Where is queue_usage_counter decremented?
> 
> Prior to this change pci_device_is_present(VF) returned "false"
> (because the VF Vendor ID is 0xffff); after the change it will return
> "true" (because it will look at the PF Vendor ID instead).
> 
> Previously virtio_pci_remove() called virtio_break_device().  I guess
> that meant the virtio I/O operation will never be completed?
> 
> But if we don't call virtio_break_device(), the virtio I/O operation
> *will* be completed?
> 
> Bjorn

It's completed anyway - nothing special happened at the device
level - but driver does not detect it.

Calling virtio_break_device will mark all queues as broken, as
a result attempts to check whether operation completed
will return false.

This probably means we need to work on handling surprise removal
better in virtio blk - since it looks like actual suprise
removal will hang too. But that I think is a separate issue.

-- 
MST

