Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 174C0792E79
	for <lists+linux-pci@lfdr.de>; Tue,  5 Sep 2023 21:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241972AbjIETLl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Sep 2023 15:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbjIETLi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Sep 2023 15:11:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F04CFB
        for <linux-pci@vger.kernel.org>; Tue,  5 Sep 2023 12:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693940961;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1FYmV1SAUAP6clEqFptERvvV4+Mtfaips/SG+vcFGBs=;
        b=f62s2e7/ierk1C/XRVyx70fKNJ8rP5BMfhyVF0HJtICwHrru75tXNNm94jZ0KODVnJoRnh
        1MoqafIMLg9BJn/AyYTB83+FGK21ST9NE5+JonTI9Xc5RmrF6ZbKYLoJej4zf+EKFOM5/E
        AhiCzJBwPt3rJ7NzJ0oC837Q3xNi80s=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-173-TijdnIgsMMaexQ2L7J7EWQ-1; Tue, 05 Sep 2023 12:39:29 -0400
X-MC-Unique: TijdnIgsMMaexQ2L7J7EWQ-1
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-794c9992f15so1335639f.0
        for <linux-pci@vger.kernel.org>; Tue, 05 Sep 2023 09:39:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693931968; x=1694536768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1FYmV1SAUAP6clEqFptERvvV4+Mtfaips/SG+vcFGBs=;
        b=k0hrjMePN40FmMWhI4vTZObWEGDTyw0wEPbz4MAZ4AHe4ZcLPYA8sh0AH4vzQVTD9R
         j2PFH0MDa/yroBEhIFhsYzSCb/e+FXmoaJJih6739B6oVlYSZygm9SZ7QpNN4glyed77
         IP/XekhITVGPioSD3a6oDI72Qf0Pz2FOlJ1MmYyFeo9QcaOVoztTQaxufExi+NgUnhJE
         tPY23ywzugMhkRCjelkhRf1WriITCsY6VjV5Jz8TX+oULh7SL/TXSf4HbOS6yZKbCdSC
         DVd6sArVJrSC7MSU3RTowakmydDTNzUQifmfMMjdv5cw8fEojUW4puY4LWn9m98F4Z2e
         rn0A==
X-Gm-Message-State: AOJu0Yyhl6ObrnBX9nR50YrP6Cob/dJ2OGs1V8/FY2kxCLynK4/xFX64
        SqkTh2X/QCte94r+vqj7lSQGXRCHem4uFdQ/qSQPRCJZ0H9PX24ukpVMuaHvLYoNjy/y8HfzZQT
        WTdQt4HvNToCfMKIekURz
X-Received: by 2002:a05:6602:3707:b0:790:83e7:5000 with SMTP id bh7-20020a056602370700b0079083e75000mr15181200iob.2.1693931968720;
        Tue, 05 Sep 2023 09:39:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrWgqWuvOjsPoQobmizp2yeXMxuOnvBLg+UYg0lVO0d7NoPYToo5iwU98Xj9J9TSkNPuS/Gw==
X-Received: by 2002:a05:6602:3707:b0:790:83e7:5000 with SMTP id bh7-20020a056602370700b0079083e75000mr15181190iob.2.1693931968466;
        Tue, 05 Sep 2023 09:39:28 -0700 (PDT)
Received: from redhat.com ([38.15.60.12])
        by smtp.gmail.com with ESMTPSA id l14-20020a02ccee000000b0042b929d3d2fsm4177089jaq.86.2023.09.05.09.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 09:39:27 -0700 (PDT)
Date:   Tue, 5 Sep 2023 10:39:26 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     suijingfeng <suijingfeng@loongson.cn>
Cc:     Sui Jingfeng <sui.jingfeng@linux.dev>,
        nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [RFC, drm-misc-next v4 0/9] PCI/VGA: Allowing the user to
 select the primary video adapter at boot time
Message-ID: <20230905103926.2eda2c36.alex.williamson@redhat.com>
In-Reply-To: <ce81413d-4872-8804-d816-0f1ef88b82cb@loongson.cn>
References: <20230904195724.633404-1-sui.jingfeng@linux.dev>
        <20230905085243.4b22725e.alex.williamson@redhat.com>
        <ce81413d-4872-8804-d816-0f1ef88b82cb@loongson.cn>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 6 Sep 2023 00:21:09 +0800
suijingfeng <suijingfeng@loongson.cn> wrote:

> Hi,
> 
> On 2023/9/5 22:52, Alex Williamson wrote:
> > On Tue,  5 Sep 2023 03:57:15 +0800
> > Sui Jingfeng <sui.jingfeng@linux.dev> wrote:
> >  
> >> From: Sui Jingfeng <suijingfeng@loongson.cn>
> >>
> >> On a machine with multiple GPUs, a Linux user has no control over which
> >> one is primary at boot time. This series tries to solve above mentioned
> >> problem by introduced the ->be_primary() function stub. The specific
> >> device drivers can provide an implementation to hook up with this stub by
> >> calling the vga_client_register() function.
> >>
> >> Once the driver bound the device successfully, VGAARB will call back to
> >> the device driver. To query if the device drivers want to be primary or
> >> not. Device drivers can just pass NULL if have no such needs.
> >>
> >> Please note that:
> >>
> >> 1) The ARM64, Loongarch, Mips servers have a lot PCIe slot, and I would
> >>     like to mount at least three video cards.
> >>
> >> 2) Typically, those non-86 machines don't have a good UEFI firmware
> >>     support, which doesn't support select primary GPU as firmware stage.
> >>     Even on x86, there are old UEFI firmwares which already made undesired
> >>     decision for you.
> >>
> >> 3) This series is attempt to solve the remain problems at the driver level,
> >>     while another series[1] of me is target to solve the majority of the
> >>     problems at device level.
> >>
> >> Tested (limited) on x86 with four video card mounted, Intel UHD Graphics
> >> 630 is the default boot VGA, successfully override by ast2400 with
> >> ast.modeset=10 append at the kernel cmd line.
> >>
> >> $ lspci | grep VGA
> >>
> >>   00:02.0 VGA compatible controller: Intel Corporation CoffeeLake-S GT2 [UHD Graphics 630]  
> > In all my previous experiments with VGA routing and IGD I found that
> > IGD can't actually release VGA routing and Intel confirmed the hardware
> > doesn't have the ability to do so.  It will always be primary from a
> > VGA routing perspective.  Was this actually tested with non-UEFI?  
> 
> Yes, I have tested on my aspire e471 notebook (i5 5200U),
> because that notebook using legacy firmware (also have UEFI, double firmware).
> But this machine have difficult in install ubuntu under UEFI firmware in the past.
> So I keep it using the legacy firmware.
> 
> It have two video card, IGD and nvidia video card(GFORCE 840M).
> nvidia call its video card as 3D controller (pci->class = 0x030200)
> 
> I have tested this patch and another patch mention at [1] together.
> I can tell you that the firmware framebuffer of this notebook using vesafb, not efifb.
> And the framebuffer size (lfb.size) is very small. This is very strange,
> but I don't have enough time to look in details. But still works.
> 
> I'm using and tesing my patch whenever and wherever possible.

So you're testing VGA routing using a non-VGA 3D controller through the
VESA address space?  How does that test anything about VGA routing?

> > I suspect it might only work in UEFI mode where we probably don't
> > actually have a dependency on VGA routing.  This is essentially why
> > vfio requires UEFI ROMs when assigning GPUs to VMs, VGA routing is too
> > broken to use on Intel systems with IGD.  Thanks,  
> 
> 
> What you tell me here is the side effect come with the VGA-compatible,
> but I'm focus on the arbitration itself. I think there no need to keep
> the VGA routing hardware features nowadays except that hardware vendor
> want keep the backward compatibility and/or comply the PCI VGA compatible spec.

"VGA arbitration" is the mediation of VGA routing between devices, so
I'm confused how you can be focused on the arbitration without the
routing itself.  Thanks,

Alex

