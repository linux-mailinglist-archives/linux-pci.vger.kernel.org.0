Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9544C625219
	for <lists+linux-pci@lfdr.de>; Fri, 11 Nov 2022 05:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232688AbiKKEDF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Nov 2022 23:03:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232685AbiKKECd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Nov 2022 23:02:33 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 331596B398;
        Thu, 10 Nov 2022 20:00:59 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id 4so3329681pli.0;
        Thu, 10 Nov 2022 20:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k2QVKBvaGZwXKF/6Y72gc6zCruKZkc4UUJVjmehPHt4=;
        b=F3t4p+7mhRirnv9Oz0Km/ENCI5TRtWAeO8Y8FJJueKgym9bv1gT7s83NnVdj+UfEH5
         sKCFt37NUNG36oiYjV03oCuYQqNluOj16+fi6DVUY29JejlKCO9BpDLoLbgqNM653Ft3
         kv0+hkw4oBiCvDVVV5uiwqwhm+QNXr8vVyQgk8NS8gEdHmFrZXkFtaCWrd9rNl0n6aBz
         lRJ7Z1cRbQeSHv+IBe75b4qzKNeXthEsmn5vySjUxZIcMQIuM9qdTskiA1QoTp7ar4Ik
         CCXg/4j7EnoK/ubSU76qXH0pfCPlNHcxxRodpiRdybaaP/H6uSoQsrC5sz+KAnzjfRRw
         G5lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k2QVKBvaGZwXKF/6Y72gc6zCruKZkc4UUJVjmehPHt4=;
        b=QclblLC7RCCX8gVt0dOJ5amXTCS/IfLD4q4ze6DbKMuqHQrhnTqxKFEyrhY82yDmFS
         UReodK1NGntiecj5099xKsXHhJ5lQlj4lZUv49uxBMe6LM4y5GnuHADK3mz4vTAgTV/U
         Mjh+76LW+nBcW9wFPL83qHuVLnJRGvJKMYUu5DH9g7Ha3VdXv2n9NXyw8Z+1jrRRq4ff
         VaQSeJwCK3J2q0gfuReF8/L0qU6sOzYX4NcYgCjtJocklWpOFCc9ts9n0Qi/+2GJ5bHF
         cav8H69M91WABwGV0lczeArkox1HxJZk98UBOZ2Itq1dxaoMa85i0JdhBPMxhHkIIw9y
         E+Hg==
X-Gm-Message-State: ACrzQf38S4lkSz6DYxg685a0tJbCi6XAyPmlfrvE2JU18v0mxq31ZTC3
        Ux8/xJcuT/Z/tj0VXoZJhX8=
X-Google-Smtp-Source: AMsMyM4T8qtWYOTfxZCyQlKYMV58HQf7vONpPHOxjYpvnn0CAkilP8h55CSniBsY+jVj0oETUMaqiA==
X-Received: by 2002:a17:90a:b702:b0:213:5c5f:f440 with SMTP id l2-20020a17090ab70200b002135c5ff440mr3400842pjr.15.1668139258490;
        Thu, 10 Nov 2022 20:00:58 -0800 (PST)
Received: from localhost ([36.152.119.226])
        by smtp.gmail.com with ESMTPSA id f18-20020a63e312000000b004582e25a595sm409351pgh.41.2022.11.10.20.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 20:00:57 -0800 (PST)
Date:   Fri, 11 Nov 2022 04:00:54 +0000
From:   Wei Gong <gongwei833x@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] pci: fix device presence detection for VFs
Message-ID: <20221111035851.GA40662@zander>
References: <20221108044819.GA861843@zander>
 <20221110193547.GA631336@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221110193547.GA631336@bhelgaas>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
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

It is, and has the same effect when unbind driver.

> 
> Is there any indication to the user, e.g., softlockup oops?

There is no more user output than the Trace stack listed below.

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
> 
> Where (which function) is the I/O dispatched and queue_usage_counter
> incremented?  Where is queue_usage_counter decremented?

queue_usage_counter is blk core q->q_usage_counter.

In blk_mq:
submit_bio
  -> submit_bio_noacct
    -> __submit_bio_noacct_mq
      -> bio_queue_enter
bio_queue_enter: q_usage_counter++


Complete io:
vp_vring_interrupt
  -> vring_interrupt (   if (vq->broken) { return; }  )
    -> virtblk_done
      -> blk_mq_complete_request
        -> virtblk_request_done
	  -> blk_mq_end_request
	    -> blk_mq_free_request
	      -> blk_queue_exit
blk_queue_exit: q_usage_counter--

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

I think so.
In virtblk I think I don't want virtio_break_device() to be called
because it need to complete, but it would be well if it could be 
called at the right time.

The problem new is that it's being called in a situation where it
shouldn't, and that's because pci_device_is_present() is giving
incorrect return.

Wei
