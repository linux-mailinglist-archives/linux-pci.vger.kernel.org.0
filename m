Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95D4D7B27C3
	for <lists+linux-pci@lfdr.de>; Thu, 28 Sep 2023 23:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbjI1V4r (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Sep 2023 17:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232521AbjI1V4r (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Sep 2023 17:56:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33031AD;
        Thu, 28 Sep 2023 14:56:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61D58C433C7;
        Thu, 28 Sep 2023 21:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695938205;
        bh=CCOmPtaIPAksl9FwVME2X9kGTjH7x0T2LVT+vz1R4gI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=s4LDK5ARohl7qAnovUvynqNIvU0/b3bTTmaLsUmuJtrcWtxe92gX+eqwyvILh6IHq
         uDpLdB+qdEj1x/WA1mYpzeaCdaYK5cvYmK4HX1T5kemXL2PcdefesTsa+WhXnqesjE
         WMjak6vKupls/2afH4o7RKu3w8LANEbobTxzY9l6fo6iK+op3M/5KYbo0c8KyxZH0O
         719btZeOdZf4US21Wm0jATfP1Sh3NI8phBKTfiTYSgm1yEyEojpkG+T9oWSV8CXvuz
         bQHoyPhW2ITiU9HDQNup/JW99w6piiXTnTMEwLWomQAwUzRwdkvdOxMPrZ3BV1Sj/y
         XgYHOwGXxa/8Q==
Date:   Thu, 28 Sep 2023 16:56:43 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sui Jingfeng <sui.jingfeng@linux.dev>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        nouveau@lists.freedesktop.org, linux-pci@vger.kernel.org,
        alsa-devel@alsa-project.org, Sui Jingfeng <suijingfeng@loongson.cn>
Subject: Re: [PATCH 0/5] Add the pci_get_base_class() helper and use it
Message-ID: <20230928215643.GA506151@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230825062714.6325-1-sui.jingfeng@linux.dev>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 25, 2023 at 02:27:09PM +0800, Sui Jingfeng wrote:
> From: Sui Jingfeng <suijingfeng@loongson.cn>
> 
> There is no function that can be used to get all PCI(e) devices in a
> system by matching against its the PCI base class code only, while keep
> the sub-class code and the programming interface ignored. Therefore, add
> the pci_get_base_class() function to suit the need.
> 
> For example, if an application want to process all PCI(e) display devices
> in a system, it can achieve such goal by writing the code as following:
> 
>     pdev = NULL;
>     do {
>         pdev = pci_get_base_class(PCI_BASE_CLASS_DISPLAY, pdev);
>         if (!pdev)
>             break;
> 
>         do_something_for_pci_display_device(pdev);
>     } while (1);
> 
> Sui Jingfeng (5):
>   PCI: Add the pci_get_base_class() helper
>   ALSA: hda/intel: Use pci_get_base_class() to reduce duplicated code
>   drm/nouveau: Use pci_get_base_class() to reduce duplicated code
>   drm/amdgpu: Use pci_get_base_class() to reduce duplicated code
>   drm/radeon: Use pci_get_base_class() to reduce duplicated code
> 
>  drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 11 +++------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 20 ++++-----------
>  drivers/gpu/drm/nouveau/nouveau_acpi.c   | 11 +++------
>  drivers/gpu/drm/radeon/radeon_bios.c     | 20 ++++-----------
>  drivers/pci/search.c                     | 31 ++++++++++++++++++++++++
>  include/linux/pci.h                      |  5 ++++
>  sound/pci/hda/hda_intel.c                | 16 ++++--------
>  7 files changed, 59 insertions(+), 55 deletions(-)

Applied to pci/enumeration for v6.7, thanks.
