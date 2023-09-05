Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B894C7928A8
	for <lists+linux-pci@lfdr.de>; Tue,  5 Sep 2023 18:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344800AbjIEQXo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Sep 2023 12:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354834AbjIEOxk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Sep 2023 10:53:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21A8618C
        for <linux-pci@vger.kernel.org>; Tue,  5 Sep 2023 07:52:48 -0700 (PDT)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-372-KjEQNOOuOhazph4PBm4FFg-1; Tue, 05 Sep 2023 10:52:45 -0400
X-MC-Unique: KjEQNOOuOhazph4PBm4FFg-1
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-34e141c5a5bso15799445ab.2
        for <linux-pci@vger.kernel.org>; Tue, 05 Sep 2023 07:52:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693925565; x=1694530365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=klLyCH+/rZQLSXpVNPH8e0sfHO/gz4bHny9eZkg3wb8=;
        b=V+2wamW84z+YBnnr26pZ9UbZIiJQ+W2947EBTnlrFIrUJvwZjlmOT8BoahGMeJEbh7
         hd38W2ES6FC24n3179KPjQvks64/RteFmGdWEys55/b6zm5QnO/0ceWNb7CtRSrfI+88
         8aX+DXZJdnuW0lDMo6YvwguJUrZuO/bCeLOExmfd9ETJUbk93DL+t6zpDOWmPRy6fQsm
         J/29Rdle4OXH2GjahEe4lKhRPxBcUC4NMpIey4wq/yjwQHVAT/ZvdWfd59+zskwDcIor
         49bHKzFACmc8FrC3/ParLRsQF+Y7FmMZqxZlxBxOyTWPJXv8eskrsWoN6lInk/zwy2WI
         ZQhw==
X-Gm-Message-State: AOJu0YxSVSj02GY8Pv3TdIQSvfpZWIZBAgcfbxIuwgRpYi3UO94Piy3A
        PxSxSeGVc5w/13tRkXnTeYYaLw/QLAQdwNpUjoTTIbOsMMHI5T6vWV2o1fggpILpcTi6AxBBDRj
        O1w4RnQOvaWjUtnZVzWXo
X-Received: by 2002:a05:6e02:f94:b0:34f:1de2:150a with SMTP id v20-20020a056e020f9400b0034f1de2150amr3311627ilo.9.1693925565024;
        Tue, 05 Sep 2023 07:52:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqMN4rRQuc7MxjlhBxrXzdipuAgTC1ZIBNcH5MY3K6vAQBnfx3fyFu0UqPkhZtlNZh3SkN8w==
X-Received: by 2002:a05:6e02:f94:b0:34f:1de2:150a with SMTP id v20-20020a056e020f9400b0034f1de2150amr3311613ilo.9.1693925564783;
        Tue, 05 Sep 2023 07:52:44 -0700 (PDT)
Received: from redhat.com ([38.15.60.12])
        by smtp.gmail.com with ESMTPSA id p8-20020a92c608000000b00345b34fcf34sm4189494ilm.38.2023.09.05.07.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 07:52:44 -0700 (PDT)
Date:   Tue, 5 Sep 2023 08:52:43 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Sui Jingfeng <sui.jingfeng@linux.dev>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Sui Jingfeng <suijingfeng@loongson.cn>,
        nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, linux-pci@vger.kernel.org
Subject: Re: [RFC, drm-misc-next v4 0/9] PCI/VGA: Allowing the user to
 select the primary video adapter at boot time
Message-ID: <20230905085243.4b22725e.alex.williamson@redhat.com>
In-Reply-To: <20230904195724.633404-1-sui.jingfeng@linux.dev>
References: <20230904195724.633404-1-sui.jingfeng@linux.dev>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue,  5 Sep 2023 03:57:15 +0800
Sui Jingfeng <sui.jingfeng@linux.dev> wrote:

> From: Sui Jingfeng <suijingfeng@loongson.cn>
> 
> On a machine with multiple GPUs, a Linux user has no control over which
> one is primary at boot time. This series tries to solve above mentioned
> problem by introduced the ->be_primary() function stub. The specific
> device drivers can provide an implementation to hook up with this stub by
> calling the vga_client_register() function.
> 
> Once the driver bound the device successfully, VGAARB will call back to
> the device driver. To query if the device drivers want to be primary or
> not. Device drivers can just pass NULL if have no such needs.
> 
> Please note that:
> 
> 1) The ARM64, Loongarch, Mips servers have a lot PCIe slot, and I would
>    like to mount at least three video cards.
> 
> 2) Typically, those non-86 machines don't have a good UEFI firmware
>    support, which doesn't support select primary GPU as firmware stage.
>    Even on x86, there are old UEFI firmwares which already made undesired
>    decision for you.
> 
> 3) This series is attempt to solve the remain problems at the driver level,
>    while another series[1] of me is target to solve the majority of the
>    problems at device level.
> 
> Tested (limited) on x86 with four video card mounted, Intel UHD Graphics
> 630 is the default boot VGA, successfully override by ast2400 with
> ast.modeset=10 append at the kernel cmd line.
> 
> $ lspci | grep VGA
> 
>  00:02.0 VGA compatible controller: Intel Corporation CoffeeLake-S GT2 [UHD Graphics 630]

In all my previous experiments with VGA routing and IGD I found that
IGD can't actually release VGA routing and Intel confirmed the hardware
doesn't have the ability to do so.  It will always be primary from a
VGA routing perspective.  Was this actually tested with non-UEFI?

I suspect it might only work in UEFI mode where we probably don't
actually have a dependency on VGA routing.  This is essentially why
vfio requires UEFI ROMs when assigning GPUs to VMs, VGA routing is too
broken to use on Intel systems with IGD.  Thanks,

Alex

>  01:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI] Caicos XTX [Radeon HD 8490 / R5 235X OEM]
>  04:00.0 VGA compatible controller: ASPEED Technology, Inc. ASPEED Graphics Family (rev 30)
>  05:00.0 VGA compatible controller: NVIDIA Corporation GK208B [GeForce GT 720] (rev a1)
> 
> $ sudo dmesg | grep vgaarb
> 
>  pci 0000:00:02.0: vgaarb: setting as boot VGA device
>  pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
>  pci 0000:01:00.0: vgaarb: VGA device added: decodes=io+mem,owns=none,locks=none
>  pci 0000:04:00.0: vgaarb: VGA device added: decodes=io+mem,owns=none,locks=none
>  pci 0000:05:00.0: vgaarb: VGA device added: decodes=io+mem,owns=none,locks=none
>  vgaarb: loaded
>  ast 0000:04:00.0: vgaarb: Override as primary by driver
>  i915 0000:00:02.0: vgaarb: changed VGA decodes: olddecodes=io+mem,decodes=none:owns=io+mem
>  radeon 0000:01:00.0: vgaarb: changed VGA decodes: olddecodes=io+mem,decodes=none:owns=none
>  ast 0000:04:00.0: vgaarb: changed VGA decodes: olddecodes=io+mem,decodes=none:owns=none
> 
> v2:
> 	* Add a simple implemment for drm/i915 and drm/ast
> 	* Pick up all tags (Mario)
> v3:
> 	* Fix a mistake for drm/i915 implement
> 	* Fix patch can not be applied problem because of merge conflect.
> v4:
> 	* Focus on solve the real problem.
> 
> v1,v2 at https://patchwork.freedesktop.org/series/120059/
>    v3 at https://patchwork.freedesktop.org/series/120562/
> 
> [1] https://patchwork.freedesktop.org/series/122845/
> 
> Sui Jingfeng (9):
>   PCI/VGA: Allowing the user to select the primary video adapter at boot
>     time
>   drm/nouveau: Implement .be_primary() callback
>   drm/radeon: Implement .be_primary() callback
>   drm/amdgpu: Implement .be_primary() callback
>   drm/i915: Implement .be_primary() callback
>   drm/loongson: Implement .be_primary() callback
>   drm/ast: Register as a VGA client by calling vga_client_register()
>   drm/hibmc: Register as a VGA client by calling vga_client_register()
>   drm/gma500: Register as a VGA client by calling vga_client_register()
> 
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 11 +++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       | 13 ++++-
>  drivers/gpu/drm/ast/ast_drv.c                 | 31 ++++++++++
>  drivers/gpu/drm/gma500/psb_drv.c              | 57 ++++++++++++++++++-
>  .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c   | 15 +++++
>  drivers/gpu/drm/i915/display/intel_vga.c      | 15 ++++-
>  drivers/gpu/drm/loongson/loongson_module.c    |  2 +-
>  drivers/gpu/drm/loongson/loongson_module.h    |  1 +
>  drivers/gpu/drm/loongson/lsdc_drv.c           | 10 +++-
>  drivers/gpu/drm/nouveau/nouveau_vga.c         | 11 +++-
>  drivers/gpu/drm/radeon/radeon_device.c        | 10 +++-
>  drivers/pci/vgaarb.c                          | 43 ++++++++++++--
>  drivers/vfio/pci/vfio_pci_core.c              |  2 +-
>  include/linux/vgaarb.h                        |  8 ++-
>  14 files changed, 210 insertions(+), 19 deletions(-)
> 

