Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B48356208AA
	for <lists+linux-pci@lfdr.de>; Tue,  8 Nov 2022 06:00:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbiKHFAx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Nov 2022 00:00:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiKHFAh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Nov 2022 00:00:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDAF517A91
        for <linux-pci@vger.kernel.org>; Mon,  7 Nov 2022 20:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667883517;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uQ6gtlfABe5az1M2ozVW7St+EVlelaqQ2b2/waFJ/CA=;
        b=eKSX4FhnwjUU3qrFqQHZZjLVo2U/ztpXWqRd/PLC5WAyYdBsTexNHyahJ0lQNSNjJqCtZr
        /lknHVfkyofO+XTdLhf3cKI2fzU/z/3WqDOMjEr6VXwh56xuEkm7LtCrbxlHSPFK/ugOQz
        Xh+YqyVJiV3M3Pq5ey5MI0V9tku5yq8=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-323-0V3B2wLyPHa623ouCDAc8g-1; Mon, 07 Nov 2022 23:58:27 -0500
X-MC-Unique: 0V3B2wLyPHa623ouCDAc8g-1
Received: by mail-qt1-f198.google.com with SMTP id i4-20020ac813c4000000b003a5044a818cso9490526qtj.11
        for <linux-pci@vger.kernel.org>; Mon, 07 Nov 2022 20:58:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uQ6gtlfABe5az1M2ozVW7St+EVlelaqQ2b2/waFJ/CA=;
        b=YU0mOMrVuG/bCR5q4hkh7MJk9OU0Y/jD0Rs6ByTzBb7tmdvcVpkotXZAzs+rajQMAf
         JwLRzbwg02hhae/8sm+6K+tIN5AE+YenzhaC3k0zgWe5Hf0lsV0pa8BTpDRXeNLlSE5W
         oJbrWQ22Oi/Mifpj5tiRLwENySu5OfgPMiWGvQjQc8y0rLZvUWxaVu9ILY6WxXMUSHaJ
         ffopIB4+trCDoTUkjAguhBGLBCIxbWCgNsszNxPCkRXY6GDbbDwOx+89eigQ0toslU8T
         f2DMdO3EjXEludKhbCRNsT22TU1r8X6F+Vh2+2Mm9xBbJXWLOEa21NbuKN1KJKM1+rWy
         BeFw==
X-Gm-Message-State: ACrzQf2ktyCbQIv7Jhof/nicSuhEmz9hbUhjpWeUKrP9X3/XiKzFSEuY
        C3XiVUTd9OaEJe+gxkzcIoXZFn8PQTygT2bhnue6rqxoCYnUju0K7gcecek8JOgg7qoUf5Pg8UO
        WavTXVEGz2LuENlFVoris
X-Received: by 2002:ae9:f50c:0:b0:6f9:6a80:1497 with SMTP id o12-20020ae9f50c000000b006f96a801497mr38088247qkg.516.1667883506588;
        Mon, 07 Nov 2022 20:58:26 -0800 (PST)
X-Google-Smtp-Source: AMsMyM4Ymn4pxceRXRjezHyvt65sXZZlMaTC+xv1gvTQhW+oYQUy/tW5UiofDLWdWckvvAPJAS/sjg==
X-Received: by 2002:ae9:f50c:0:b0:6f9:6a80:1497 with SMTP id o12-20020ae9f50c000000b006f96a801497mr38088238qkg.516.1667883506337;
        Mon, 07 Nov 2022 20:58:26 -0800 (PST)
Received: from redhat.com ([138.199.52.3])
        by smtp.gmail.com with ESMTPSA id y22-20020a05620a44d600b006ec62032d3dsm8879090qkp.30.2022.11.07.20.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 20:58:25 -0800 (PST)
Date:   Mon, 7 Nov 2022 23:58:21 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Wei Gong <gongwei833x@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] pci: fix device presence detection for VFs
Message-ID: <20221107235633-mutt-send-email-mst@kernel.org>
References: <20221026060912.173250-1-mst@redhat.com>
 <20221108044819.GA861843@zander>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221108044819.GA861843@zander>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 08, 2022 at 04:52:16AM +0000, Wei Gong wrote:
> O Wed, Oct 26, 2022 at 02:11:21AM -0400, Michael S. Tsirkin wrote:
> > virtio uses the same driver for VFs and PFs.  Accordingly,
> > pci_device_is_present is used to detect device presence. This function
> > isn't currently working properly for VFs since it attempts reading
> > device and vendor ID. As VFs are present if and only if PF is present,
> > just return the value for that device.
> > 
> > Reported-by: Wei Gong <gongwei833x@gmail.com>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> > 
> > Wei Gong, thanks for your testing of the RFC!
> > As I made a small change, would appreciate re-testing.
> > 
> > Thanks!
> > 
> > changes from RFC:
> > 	use pci_physfn() wrapper to make the code build without PCI_IOV
> > 
> > 
> >  drivers/pci/pci.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> 
> Tested-by: Wei Gong <gongwei833x@gmail.com>



Thanks!
Bjorn, could you queue this fix in your tree or should I queue this
in the virtio tree? I also think this would be nice to have for stable too -
do you agree?
Thanks!


> retest done and well.
> 
> I would rephrase the bug.
> 
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
> 
> 
> 
> Thanks,
> Wei Gong
> 

