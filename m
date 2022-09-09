Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABE5D5B3A58
	for <lists+linux-pci@lfdr.de>; Fri,  9 Sep 2022 16:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbiIIOEf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Sep 2022 10:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232233AbiIIOEJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Sep 2022 10:04:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E8914A500
        for <linux-pci@vger.kernel.org>; Fri,  9 Sep 2022 07:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662732102;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mmurUuPfY4CSsGXMopu3kXzx5e5l7+stCxGfg5MZbeg=;
        b=hsm99hw1afdrSnTKRdeuLEzm4lXmpJvxctp6d6Eap0S9/bk2F5P2Bb3YZ5lFNQO+PCJVz/
        Ksra4to1tgw3th0fKy2W6AKtFGITFa2XLjGRvYVRDIWT/xE4zO8/Vfu7d+ag+14DACmjKV
        AotnPUWEgPlupJfxuWjtC3gwxiuKNkA=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-9-SVJ5xQihOImaPiO2eWI_5w-1; Fri, 09 Sep 2022 10:01:42 -0400
X-MC-Unique: SVJ5xQihOImaPiO2eWI_5w-1
Received: by mail-ed1-f72.google.com with SMTP id y12-20020a056402358c00b00448898f1c33so1336554edc.7
        for <linux-pci@vger.kernel.org>; Fri, 09 Sep 2022 07:01:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=mmurUuPfY4CSsGXMopu3kXzx5e5l7+stCxGfg5MZbeg=;
        b=BWnoXqVj3pTCj8Fdi1+AKQnTXrIFOCEdLhxXbNrJdApYybTm9L+Ax4POIBpDUoqaQW
         XfuL+89KYSvBt9M94JfpmODJ7zqAoWS2cw1wNN/rV0Hnd5DXihnArS4VBYq8uX3teF6u
         2QtGGZ0fGhacYVfTRXuyVyILeiodtKn7jntDNm7rwUKv1w6Hd5+pkxYjaM9iKLp0zgB7
         RZVPMSgMDthJhWtLnhb6EIbViO0jaZxkf8eiyf7Y8OX4c+itHZVoeaBAIvaDz3wsHnfg
         mXEUyxUc8xnwmjj7xOYL4i9jta0566XUoJvTZODrlP0MzBSSjNmtqb1t6zDYniecU6y5
         0/Yg==
X-Gm-Message-State: ACgBeo3tW703+/bVG66vKi/Zlqg6OslhBpDPh+yeA39RA2f1jzHJ0tni
        vHcHSxPO8K7Ze9tDY+ZPAscTvnu5uLMW6AvtiZ0Njm8izpzglQLCh9Fah6gk8hk3jigOqVBwIpP
        srPF2830lYeIBO2LWkKSb9zUvGuwdGqqzD5QMIWIJkJWGKpzlwSY4vJ1ZeeK9ThqWyTBjVamx
X-Received: by 2002:a17:906:846b:b0:770:82e5:1519 with SMTP id hx11-20020a170906846b00b0077082e51519mr9690617ejc.221.1662732100745;
        Fri, 09 Sep 2022 07:01:40 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5cRBPXdEZPFZlONtBxXbkVKluQAB+eqr/N7QwxhdMBwFCwN/QJRPkdLZUifQ+2NbWPIwNn1Q==
X-Received: by 2002:a17:906:846b:b0:770:82e5:1519 with SMTP id hx11-20020a170906846b00b0077082e51519mr9690572ejc.221.1662732100345;
        Fri, 09 Sep 2022 07:01:40 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id f4-20020a17090631c400b0073d6093ac93sm353806ejf.16.2022.09.09.07.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 07:01:39 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     eahariha@linux.microsoft.com
Cc:     Deepak Rawat <drawat.floss@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Helge Deller <deller@gmx.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Easwar Hariharan <easwar.hariharan@microsoft.com>,
        Colin Ian King <colin.i.king@googlemail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        "open list:DRM DRIVER FOR HYPERV SYNTHETIC VIDEO DEVICE" 
        <linux-hyperv@vger.kernel.org>,
        "open list:DRM DRIVER FOR HYPERV SYNTHETIC VIDEO DEVICE" 
        <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
        "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 2/3] pci_ids: Add Microsoft PCI Vendor ID, and remove
 redundant definitions
In-Reply-To: <1662674757-31945-2-git-send-email-eahariha@linux.microsoft.com>
References: <1662674757-31945-1-git-send-email-eahariha@linux.microsoft.com>
 <1662674757-31945-2-git-send-email-eahariha@linux.microsoft.com>
Date:   Fri, 09 Sep 2022 16:01:37 +0200
Message-ID: <87leqsr6im.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

eahariha@linux.microsoft.com writes:

> From: Easwar Hariharan <easwar.hariharan@microsoft.com>
>
> Move the Microsoft PCI Vendor ID from the various drivers to the pci_ids
> file
>
> Signed-off-by: Easwar Hariharan <easwar.hariharan@microsoft.com>
> ---
>  drivers/gpu/drm/hyperv/hyperv_drm_drv.c         | 1 -
>  drivers/net/ethernet/microsoft/mana/gdma_main.c | 4 ----
>  drivers/video/fbdev/hyperv_fb.c                 | 3 ---
>  include/linux/pci_ids.h                         | 2 ++
>  4 files changed, 2 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
> index 6d11e79..61083c7 100644
> --- a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
> +++ b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
> @@ -23,7 +23,6 @@
>  #define DRIVER_MAJOR 1
>  #define DRIVER_MINOR 0
>  
> -#define PCI_VENDOR_ID_MICROSOFT 0x1414
>  #define PCI_DEVICE_ID_HYPERV_VIDEO 0x5353
>  
>  DEFINE_DRM_GEM_FOPS(hv_fops);
> diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> index 5f92401..00d8198 100644
> --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> @@ -1465,10 +1465,6 @@ static void mana_gd_shutdown(struct pci_dev *pdev)
>  	pci_disable_device(pdev);
>  }
>  
> -#ifndef PCI_VENDOR_ID_MICROSOFT
> -#define PCI_VENDOR_ID_MICROSOFT 0x1414
> -#endif
> -
>  static const struct pci_device_id mana_id_table[] = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_MICROSOFT, MANA_PF_DEVICE_ID) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_MICROSOFT, MANA_VF_DEVICE_ID) },
> diff --git a/drivers/video/fbdev/hyperv_fb.c b/drivers/video/fbdev/hyperv_fb.c
> index 886c564..a502c80 100644
> --- a/drivers/video/fbdev/hyperv_fb.c
> +++ b/drivers/video/fbdev/hyperv_fb.c
> @@ -58,7 +58,6 @@
>  
>  #include <linux/hyperv.h>
>  
> -
>  /* Hyper-V Synthetic Video Protocol definitions and structures */
>  #define MAX_VMBUS_PKT_SIZE 0x4000
>  
> @@ -74,10 +73,8 @@
>  #define SYNTHVID_DEPTH_WIN8 32
>  #define SYNTHVID_FB_SIZE_WIN8 (8 * 1024 * 1024)
>  
> -#define PCI_VENDOR_ID_MICROSOFT 0x1414
>  #define PCI_DEVICE_ID_HYPERV_VIDEO 0x5353
>  
> -
>  enum pipe_msg_type {
>  	PIPE_MSG_INVALID,
>  	PIPE_MSG_DATA,
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 6feade6..c008fda 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2079,6 +2079,8 @@
>  #define PCI_DEVICE_ID_ICE_1712		0x1712
>  #define PCI_DEVICE_ID_VT1724		0x1724
>  
> +#define PCI_VENDOR_ID_MICROSOFT  	0x1414
> +
>  #define PCI_VENDOR_ID_OXSEMI		0x1415
>  #define PCI_DEVICE_ID_OXSEMI_12PCI840	0x8403
>  #define PCI_DEVICE_ID_OXSEMI_PCIe840		0xC000

I've sent a similar patch recently:
https://lore.kernel.org/linux-hyperv/20220827130345.1320254-2-vkuznets@redhat.com/

which Wei has already queued to hyperv/fixes. Moving
PCI_DEVICE_ID_MICROSOFT_MANA_PF/VF definitions to 'pci_ids.h' does make
sense but please rebase first.

-- 
Vitaly

