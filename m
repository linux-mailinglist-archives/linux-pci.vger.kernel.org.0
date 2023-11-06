Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 009FE7E214D
	for <lists+linux-pci@lfdr.de>; Mon,  6 Nov 2023 13:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbjKFMZj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Nov 2023 07:25:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbjKFMZi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Nov 2023 07:25:38 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6308A97;
        Mon,  6 Nov 2023 04:25:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699273536; x=1730809536;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=2pR8X4BMVcOGKWPNkgcioekUqSx5/pk8Jhwvb4ict+4=;
  b=i1ILJryameQME2wCRiiRbVH+TQb/wd1dauLPCNARzBp00uPXWi8Scw5z
   1PKdTA9jabyoy9/DLJWxDsU7i/1t6mIraTua7+YHkF1YFmd08tQG/YkQV
   6kFQqMUsV1QpBQWl/sZQgBvOhG9I/lKWHAE7A9q3mHG+T2H5qxzphMs9n
   oh6mFO4jU8hLWO/cUJbHw+mKEi5KH1u9gGVexCfS6s5eh05rAz9nATEK5
   XY4U9JB6/7PRs+pryVjUn0EXe3hOFhEAAgMNFLY2XjPWxuDS4s+2QGZyn
   voVw4s1RDMdkqSQd8ObwX6ioj8qAPohuGbclSgHI6FrqzVTsVcTLA1e58
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="420376184"
X-IronPort-AV: E=Sophos;i="6.03,281,1694761200"; 
   d="scan'208";a="420376184"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 04:25:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="828193825"
X-IronPort-AV: E=Sophos;i="6.03,281,1694761200"; 
   d="scan'208";a="828193825"
Received: from rmstoi-mobl.ger.corp.intel.com ([10.251.216.76])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 04:25:27 -0800
Date:   Mon, 6 Nov 2023 14:25:24 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
cc:     Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?ISO-8859-15?Q?Christian_K=F6nig?= <christian.koenig@amd.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Danilo Krummrich <dakr@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Xinhui Pan <Xinhui.Pan@amd.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Mark Gross <markgross@kernel.org>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        =?ISO-8859-15?Q?Pali_Roh=E1r?= <pali@kernel.org>,
        =?ISO-8859-15?Q?Marek_Beh=FAn?= <kabel@kernel.org>,
        "Maciej W . Rozycki" <macro@orcam.me.uk>,
        Manivannan Sadhasivam <mani@kernel.org>,
        "open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS" 
        <dri-devel@lists.freedesktop.org>,
        "open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS" 
        <nouveau@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:RADEON and AMDGPU DRM DRIVERS" 
        <amd-gfx@lists.freedesktop.org>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>,
        "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>,
        "open list:THUNDERBOLT DRIVER" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH v2 1/9] drm/nouveau: Switch from pci_is_thunderbolt_attached()
 to dev_is_removable()
In-Reply-To: <20231103190758.82911-2-mario.limonciello@amd.com>
Message-ID: <55563d57-60c3-1789-1e7c-5e618fbd6253@linux.intel.com>
References: <20231103190758.82911-1-mario.limonciello@amd.com> <20231103190758.82911-2-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 3 Nov 2023, Mario Limonciello wrote:

> pci_is_thunderbolt_attached() only works for Intel TBT devices. Switch to
> using dev_is_removable() to be able to detect USB4 devices as well.

Please extend this with more details. I had to lookup the TBT change to 
be able to make any guess why you're doing this (and it's still a guess 
at best).

-- 
 i.


> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpu/drm/nouveau/nouveau_vga.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nouveau_vga.c b/drivers/gpu/drm/nouveau/nouveau_vga.c
> index f8bf0ec26844..14215b7ca187 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_vga.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_vga.c
> @@ -94,8 +94,8 @@ nouveau_vga_init(struct nouveau_drm *drm)
>  
>  	vga_client_register(pdev, nouveau_vga_set_decode);
>  
> -	/* don't register Thunderbolt eGPU with vga_switcheroo */
> -	if (pci_is_thunderbolt_attached(pdev))
> +	/* don't register USB4/Thunderbolt eGPU with vga_switcheroo */
> +	if (dev_is_removable(&pdev->dev))
>  		return;
>  
>  	vga_switcheroo_register_client(pdev, &nouveau_switcheroo_ops, runtime);
> @@ -118,7 +118,7 @@ nouveau_vga_fini(struct nouveau_drm *drm)
>  
>  	vga_client_unregister(pdev);
>  
> -	if (pci_is_thunderbolt_attached(pdev))
> +	if (dev_is_removable(&pdev->dev))
>  		return;
>  
>  	vga_switcheroo_unregister_client(pdev);
> 
