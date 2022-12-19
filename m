Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0C0650765
	for <lists+linux-pci@lfdr.de>; Mon, 19 Dec 2022 06:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbiLSF5O (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Dec 2022 00:57:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiLSF5N (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Dec 2022 00:57:13 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 458215FF7
        for <linux-pci@vger.kernel.org>; Sun, 18 Dec 2022 21:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671429383;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1YVIFG5ASLDJsVejZ6lyd9CLA6aU0mKibk4ZoX9A1ok=;
        b=jQG1EnDEYoGU8lWFeSBjatpkNcpff10MQQUCZR6nNU4XZOriGutdK4oXw7/XJt6ZA0+qRq
        cyPzWrQWuTr0yTidFG0mnTi61pHR7eaR+1v/iTzArGoiTbbXmacc+DpkA8o/zt1y4UnxU9
        AyD5+/wm1Qck9p9szeeLtZnSPxpjt+o=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-502-EMm4IgwtNL6IfbW6ViQbUw-1; Mon, 19 Dec 2022 00:56:22 -0500
X-MC-Unique: EMm4IgwtNL6IfbW6ViQbUw-1
Received: by mail-qt1-f200.google.com with SMTP id k4-20020ac84784000000b003a96744cee6so3623000qtq.7
        for <linux-pci@vger.kernel.org>; Sun, 18 Dec 2022 21:56:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1YVIFG5ASLDJsVejZ6lyd9CLA6aU0mKibk4ZoX9A1ok=;
        b=qu/SjDHm0quNr5A61uvksubT5Pl3jZ+xnQIyN7OOWWYy9141+18I9fhehDKUpirA9x
         Y73fshNWKefGkXmde/ISsV3NKA1geOyVZPqIK8vNTN1ZaeM/Op0qxSxnibXd8KViMCS+
         EcWFHQNemSeaYxRparye1LeWOEXI3Y3Be8FIuYLoQxjmNy3tR87dlLPjub46r8qkE75t
         WYVUBcg7sP3fArJvUUZ4dIdNHz4SkOzZ7x+1DNcipeIYrR0+dZXvCZG1fXdSFfz8bpFx
         GK0ujDzh10ulHnAHQpui2K9JwSHFCX0mtkTFuPFOX8LYpVCmthU56Kp3KQxMpl7ydpc6
         w1Ow==
X-Gm-Message-State: AFqh2kquV7ynigeK/6HMa+vwwGn+EbZ+FQRiP5+bCtRXZBTzlmby0dcL
        s0DMoTjJ5h6SBFRSg16kL3o4mxa76tY1XEOznHSzZer7Cc1fLiR1c9X3KXDQWyjc7SCJW9Y1QpU
        Dpr/Yi3Xb9BBnEblbxDl3
X-Received: by 2002:a05:6214:3806:b0:4c7:a44:4843 with SMTP id ns6-20020a056214380600b004c70a444843mr11127663qvb.10.1671429381592;
        Sun, 18 Dec 2022 21:56:21 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsGT+Jx+wLtUrPbCzsIYqfziIyY7UkyBDh/VVwJMzg21tldwd7XzQhDQ3XYPGEo+48DT9kAGg==
X-Received: by 2002:a05:6214:3806:b0:4c7:a44:4843 with SMTP id ns6-20020a056214380600b004c70a444843mr11127651qvb.10.1671429381337;
        Sun, 18 Dec 2022 21:56:21 -0800 (PST)
Received: from redhat.com ([45.144.113.29])
        by smtp.gmail.com with ESMTPSA id c24-20020a05620a11b800b006fc2cee4486sm6351630qkk.62.2022.12.18.21.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Dec 2022 21:56:20 -0800 (PST)
Date:   Mon, 19 Dec 2022 00:56:15 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Parav Pandit <parav@nvidia.com>
Cc:     Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>,
        Wei Gong <gongwei833x@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2] pci: fix device presence detection for VFs
Message-ID: <20221219005553-mutt-send-email-mst@kernel.org>
References: <20221110144700-mutt-send-email-mst@kernel.org>
 <20221111234219.GA763705@bhelgaas>
 <20221113034519-mutt-send-email-mst@kernel.org>
 <20221116111619.GA5804@wunner.de>
 <PH0PR12MB54811F4658F068C46E071E81DC069@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR12MB54811F4658F068C46E071E81DC069@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 17, 2022 at 05:36:48AM +0000, Parav Pandit wrote:
> 
> > From: Lukas Wunner <lukas@wunner.de>
> > Sent: Wednesday, November 16, 2022 6:16 AM
> > 
> > [cc += Parav Pandit, author of 43bb40c5b926]
> > 
> > On Sun, Nov 13, 2022 at 03:46:06AM -0500, Michael S. Tsirkin wrote:
> > > On Fri, Nov 11, 2022 at 05:42:19PM -0600, Bjorn Helgaas wrote:
> > > > On Thu, Nov 10, 2022 at 03:15:55PM -0500, Michael S. Tsirkin wrote:
> > > > > On Thu, Nov 10, 2022 at 01:35:47PM -0600, Bjorn Helgaas wrote:
> > > > > > Prior to this change pci_device_is_present(VF) returned "false"
> > > > > > (because the VF Vendor ID is 0xffff); after the change it will
> > > > > > return "true" (because it will look at the PF Vendor ID instead).
> > > > > >
> > > > > > Previously virtio_pci_remove() called virtio_break_device().  I
> > > > > > guess that meant the virtio I/O operation will never be completed?
> > > > > >
> > > > > > But if we don't call virtio_break_device(), the virtio I/O
> > > > > > operation
> > > > > > *will* be completed?
> > >
> > > Just making sure - pci_device_is_present *is* the suggested way to
> > > distinguish between graceful and surprise removal, isn't it?
> > 
> > No, it's not.  Instead of !pci_device_is_present() you really want to call
> > pci_dev_is_disconnected() instead.
> > 
> > While the fix Bjorn applied for v6.2 may solve the issue and may make sense
> > on it's own, it's not the solution you're looking for.  You want to swap the
> > call to !pci_device_is_present() with pci_dev_is_disconnected(), move
> > pci_dev_is_disconnected() from drivers/pci/pci.h to include/linux/pci.h and
> > add a Fixes tag referencing 43bb40c5b926.
> > 
> > If you don't want to move pci_dev_is_disconnected(), you can alternatively
> > check for "pdev->error_state == pci_channel_io_perm_failure" or call
> > pci_channel_offline().  The latter will also return true though on transient
> > inaccessibility of the device (e.g. if it's being reset).
> > 
> pci_device_is_present() is calling pci_dev_is_disconnected().
> pci_dev_is_disconnected() avoids reading the vendor id.
> So pci_dev_is_disconnected() looks less strong check.
> I see that it can return a valid value on recoverable error case.
> 
> In that case, is pci_channel_offline() a more precise way to check that covers transient and permanent error?
> 
> And if that is the right check, we need to fix all the callers, mainly widely used nvme driver [1].
> 
> [1] https://elixir.bootlin.com/linux/v6.1-rc5/source/drivers/nvme/host/pci.c#L3228
> 
> Also, we need to add API documentation on when to use this API in context of hotplug, so that all related drivers can consistently use single API.

Bjorn, Lukas, what's your take on this idea?
Thanks!


> > The theory of operation is as follows:  The PCI layer does indeed know
> > whether the device was surprise removed or gracefully removed and that
> > information is passed in the "presence" flag to pciehp_unconfigure_device()
> > (in drivers/pci/hotplug/pciehp_pci.c).  That function does the following:
> > 
> > 	if (!presence)
> > 		pci_walk_bus(parent, pci_dev_set_disconnected, NULL);
> > 
> > In other words, pdev->error_state is set to pci_channel_io_perm_failure on
> > the entire hierarchy below the hotplug port.  And pci_dev_is_disconnected()
> > simply checks whether that's the device's error_state.
> > 
> > pci_dev_is_disconnected() makes sense if you definitely know the device is
> > gone and want to skip certain steps or delays on device teardown.
> > However be aware that the device may be hot-removed after graceful
> > removal was initiated.  In such a situation, pci_dev_is_disconnected() may
> > return false and you'll try to access the device as normal, even though it was
> > yanked from the slot after the pci_dev_is_disconnected() call was
> > performed.  Ideally you should be able to cope with such scenarios as well.
> > 
> > For some more background info, refer to this LWN article (scroll down to the
> > "Surprise removal" section):
> > https://lwn.net/Articles/767885/
> > 
> > Thanks,
> > 
> > Lukas

