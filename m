Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCFD337FA1C
	for <lists+linux-pci@lfdr.de>; Thu, 13 May 2021 16:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234746AbhEMO4l (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 May 2021 10:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234526AbhEMO4L (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 May 2021 10:56:11 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14042C06174A
        for <linux-pci@vger.kernel.org>; Thu, 13 May 2021 07:55:02 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id g15-20020a9d128f0000b02902a7d7a7bb6eso23798339otg.9
        for <linux-pci@vger.kernel.org>; Thu, 13 May 2021 07:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qrJdG6JOEDIyKXDsMaiBz9FHd/jZFTat1KlsJneAkF8=;
        b=nEQxhnGeaidKuXxeZC5t6JxRf+p6UYkFBD634fUJ2peO3WrzBTHujNMWm1tODW7S76
         Kqlk2jEG0c+4ljxIP7aqgfLBxvovMYTUbYNFm8TkIVRyIesP6jJgdiTEnLz+6EExgSL9
         PfMft0EPAzu6kkSzU3UQ7p0WONbNOC2722AAvO0V9Al19tRpaNgXw2ni33M1uU97J0ZV
         Sj1vf98+gjuJeCdlx8o//MIwsD5QeXV6+H5wbieG8mHSFFQrE0pYUnBGSibqjN3jfi2f
         pWld1Oc9/ds3dcRBjyDqGAGpB2EPhQqjXW88dJ1cdITfVjjQvpDu6vO42y4PrmVH1otL
         6CVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qrJdG6JOEDIyKXDsMaiBz9FHd/jZFTat1KlsJneAkF8=;
        b=CG5n+R/V1cjtaxF21Bx/YO1+MCzDPWWoaF9OV5OnfQqwlSPNuMvCGlitETNBcvUNZL
         6sqKvQ18tTyrDV6biuSZJNwRljBOIog7FBcjaIR34ey3faPNrxVxCWjznUS2/unCn4nt
         7BTYSB9P9GqjsfdfiWAPbvszG2MDtVWnt5tQQ3qUTIEhwwhvCd5/MIv8+jut0zl7GbZD
         NsKowWVuwO9lM1DbzCucgVZJ1oMGpZGfARMPCqu/k/4NNRu4IBWnP5apoKJjRarSouJU
         LtpmAMkIX/mSXavwUQ9mJo2OFC2szZqutStVc5CoJcRE0Faomy1vboKIfremhS35Lfi7
         0A1Q==
X-Gm-Message-State: AOAM532Fa0zwMdpHV5iFaUrC+/GPF6R3nE7cdTT02lmsi6zTpZDNCF2E
        /FqliqG28BLQOsCcQtFjjWBTVP/OeZX6hwgssus=
X-Google-Smtp-Source: ABdhPJzIoC4OuxMXae6sMY4uWiNbNK+pdXJlAX6Xqx5tYaFLpvA2smCINmO+s9ZQy764LKCJ74/TPnQbkZsigkhVnqw=
X-Received: by 2002:a9d:57cd:: with SMTP id q13mr33490465oti.23.1620917701119;
 Thu, 13 May 2021 07:55:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210512142648.666476-1-andrey.grodzovsky@amd.com>
 <20210512142648.666476-10-andrey.grodzovsky@amd.com> <CADnq5_P7stZJCnE2AyrAFLrE6Gn089gJVftRKHDFj25sAkp44Q@mail.gmail.com>
 <0150a6d9-f502-ad21-0832-819c95cb9e7a@amd.com> <CADnq5_Otc=K2+UeHWRa_Vy3a62rX8OyvTkeATFgpF8f1Pe6jBw@mail.gmail.com>
 <270e0937-9af5-7b96-888c-b2d3de0814d8@amd.com>
In-Reply-To: <270e0937-9af5-7b96-888c-b2d3de0814d8@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 13 May 2021 10:54:50 -0400
Message-ID: <CADnq5_NOkOk6QdkixwuByrw5FzyYdLY+nWqTMR1T9aNvpT+csA@mail.gmail.com>
Subject: Re: [PATCH v7 09/16] drm/amdgpu: Guard against write accesses after
 device removal
To:     Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Cc:     Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        "Wentland, Harry" <Harry.Wentland@amd.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Kuehling, Felix" <Felix.Kuehling@amd.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 13, 2021 at 10:47 AM Andrey Grodzovsky
<andrey.grodzovsky@amd.com> wrote:
>
>
>
> On 2021-05-12 4:50 p.m., Alex Deucher wrote:
> > On Wed, May 12, 2021 at 4:30 PM Andrey Grodzovsky
> > <andrey.grodzovsky@amd.com> wrote:
> >>
> >>
> >>
> >> On 2021-05-12 4:17 p.m., Alex Deucher wrote:
> >>> On Wed, May 12, 2021 at 10:27 AM Andrey Grodzovsky
> >>> <andrey.grodzovsky@amd.com> wrote:
> >>>>
> >>>> This should prevent writing to memory or IO ranges possibly
> >>>> already allocated for other uses after our device is removed.
> >>>>
> >>>> v5:
> >>>> Protect more places wher memcopy_to/form_io takes place
> >>>
> >>> where
> >>>
> >>>> Protect IB submissions
> >>>>
> >>>> v6: Switch to !drm_dev_enter instead of scoping entire code
> >>>> with brackets.
> >>>>
> >>>> v7:
> >>>> Drop guard of HW ring commands emission protection since they
> >>>> are in GART and not in MMIO.
> >>>>
> >>>> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> >>>
> >>> I think you could split out the psp_fw_copy changes as a separate
> >>> cleanup patch.  That's a nice clean up in general.  What about the SMU
> >>> code (e.g., amd/pm/powerplay and amd/pm/swsmu)?  There are a bunch of
> >>> shared memory areas we interact with in the driver.
> >>
> >> Can you point me to it ? Are they VRAM and not GART ?
> >> I searched for all memcpy_to/from_io in our code. Maybe missed some.
> >>
> >
> > Mostly vram.  A quick grep shows:
> >
> > $ grep -r -I AMDGPU_GEM_DOMAIN drivers/gpu/drm/amd/pm/
> > drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c:
> >    PAGE_SIZE, AMDGPU_GEM_DOMAIN_GTT,
> > drivers/gpu/drm/amd/pm/powerplay/smumgr/smu7_smumgr.c:
> > AMDGPU_GEM_DOMAIN_VRAM,
> > drivers/gpu/drm/amd/pm/powerplay/smumgr/smu7_smumgr.c:
> > AMDGPU_GEM_DOMAIN_VRAM,
> > drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c:
> > AMDGPU_GEM_DOMAIN_VRAM,
> > drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c:
> > AMDGPU_GEM_DOMAIN_VRAM,
> > drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c:
> > AMDGPU_GEM_DOMAIN_VRAM,
> > drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c:
> >   AMDGPU_GEM_DOMAIN_VRAM,
> > drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c:
> > AMDGPU_GEM_DOMAIN_VRAM,
> > drivers/gpu/drm/amd/pm/powerplay/smumgr/smu8_smumgr.c:
> > AMDGPU_GEM_DOMAIN_VRAM,
> > drivers/gpu/drm/amd/pm/powerplay/smumgr/smu8_smumgr.c:
> > AMDGPU_GEM_DOMAIN_VRAM,
> > drivers/gpu/drm/amd/pm/powerplay/smumgr/vega12_smumgr.c:
> > AMDGPU_GEM_DOMAIN_VRAM,
> > drivers/gpu/drm/amd/pm/powerplay/smumgr/vega12_smumgr.c:
> >         AMDGPU_GEM_DOMAIN_VRAM,
> > drivers/gpu/drm/amd/pm/powerplay/smumgr/vega12_smumgr.c:
> >             AMDGPU_GEM_DOMAIN_VRAM,
> > drivers/gpu/drm/amd/pm/powerplay/smumgr/vega12_smumgr.c:
> >         AMDGPU_GEM_DOMAIN_VRAM,
> > drivers/gpu/drm/amd/pm/powerplay/smumgr/vega12_smumgr.c:
> >         AMDGPU_GEM_DOMAIN_VRAM,
> > drivers/gpu/drm/amd/pm/powerplay/smumgr/vega12_smumgr.c:
> >         AMDGPU_GEM_DOMAIN_VRAM,
> > drivers/gpu/drm/amd/pm/powerplay/smumgr/vega20_smumgr.c:
> > AMDGPU_GEM_DOMAIN_VRAM,
> > drivers/gpu/drm/amd/pm/powerplay/smumgr/vega20_smumgr.c:
> > AMDGPU_GEM_DOMAIN_VRAM,
> > drivers/gpu/drm/amd/pm/powerplay/smumgr/vega20_smumgr.c:
> > AMDGPU_GEM_DOMAIN_VRAM,
> > drivers/gpu/drm/amd/pm/powerplay/smumgr/vega20_smumgr.c:
> > AMDGPU_GEM_DOMAIN_VRAM,
> > drivers/gpu/drm/amd/pm/powerplay/smumgr/vega20_smumgr.c:
> > AMDGPU_GEM_DOMAIN_VRAM,
> > drivers/gpu/drm/amd/pm/powerplay/smumgr/vega20_smumgr.c:
> > AMDGPU_GEM_DOMAIN_VRAM,
> > drivers/gpu/drm/amd/pm/powerplay/smumgr/smu10_smumgr.c:
> > AMDGPU_GEM_DOMAIN_VRAM,
> > drivers/gpu/drm/amd/pm/powerplay/smumgr/smu10_smumgr.c:
> > AMDGPU_GEM_DOMAIN_VRAM,
> > drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c:        PAGE_SIZE,
> > AMDGPU_GEM_DOMAIN_VRAM);
> > drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c:        PAGE_SIZE,
> > AMDGPU_GEM_DOMAIN_VRAM);
> > drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c:        PAGE_SIZE,
> > AMDGPU_GEM_DOMAIN_VRAM);
> > drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c:
> > PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
> > drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c:
> > PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
> > drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c:
> > PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
> > drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c:
> > PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
> > drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c:
> > PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
> > drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c:
> > PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
> > drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c:
> > AMDGPU_GEM_DOMAIN_VRAM);
> > drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c:
> > PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
> > drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c:
> > PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
> > drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c:
> > PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
> > drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c:
> > PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
> > drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c:
> > PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
> > drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c:
> > PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
> > drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c:
> >      AMDGPU_GEM_DOMAIN_VRAM);
> > drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c:
> > PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
> > drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c:
> > PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
> > drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c:
> > PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
> > drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c:
> > PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
> > drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c:
> > PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
> > drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c:
> > PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
> > drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c:
> > PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
> > drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c:
> > PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
> > drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c:
> > PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
> > drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c:
> > PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
> > drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c:
> > AMDGPU_GEM_DOMAIN_VRAM);
> > drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c:
> > PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
> > drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c:
> > PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
> > drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c:
> > PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
> > drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c:
> > PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
> > drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c:    driver_table->domain =
> > AMDGPU_GEM_DOMAIN_VRAM;
> > drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c:    memory_pool->domain =
> > AMDGPU_GEM_DOMAIN_GTT;
> > drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c:
> > dummy_read_1_table->domain = AMDGPU_GEM_DOMAIN_VRAM;
> >
> > In general, the driver puts shared structures in vram and then either
> > updates them and asks the SMU to read them, or requests that the SMU
> > write to them by writing a message to the SMU via MMIO.  You'll need
> > to look for places where those shared buffers are accessed.
> >
> > Alex
>
> There are indeed multiple memcpy in the pm folder and other places.
> The thing is I never hit them during testing. I invalidate all MMIO
> ranges (VRAM and Regs) at the end of amdgpu_pci_remove so if any of them
> was hit post device unplug i would see a page fault oops.
> The fact they are not hit means that either they are accessed before
> pci remove code ends and then they are ok, sysfs accessors as you
> pointed to me earlier - in which case also that cannot be accessed
> post pci remove as all device related sysfs is gone or possible real
> places that i didn't catch in my tests.
> I feel like guarding all of them with drm_dev_enter/exit will really
> clutter the code and that the right approach is the one we eventually
> working toward preventing any HW accessing code to run post
> amdgpu_pci_remove coupled with force retiring fences.
> Invalidation of all MMIO mappings that I added as the last patch in
> this series also guarantees that in any new unguarded code that
> actually happens post device unplug will be quickly catched
> and identified by page fault and can be specifically addressed.
>

In general they are only hit during runtime via sysfs (e.g., if you
are querying telemetry data via hwmon or checking the clocks).  We can
always revisit them in the future if they end up being a problem.

I can go either way on splitting out the psp_copy_fw clean up as a
separate patch.  With the typo in the commit message fixed, the patch
is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> Andrey
>
> >
> >
> >> Andrey
> >>
> >>>
> >>> Alex
> >>>
> >>>
> >>>> ---
> >>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 10 +++-
> >>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c    |  9 ++++
> >>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c    | 63 ++++++++++++++--------
> >>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h    |  2 +
> >>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c    | 31 +++++++----
> >>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c    | 11 ++--
> >>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c    | 22 +++++---
> >>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c     |  7 ++-
> >>>>    drivers/gpu/drm/amd/amdgpu/psp_v11_0.c     | 44 +++++++--------
> >>>>    drivers/gpu/drm/amd/amdgpu/psp_v12_0.c     |  8 +--
> >>>>    drivers/gpu/drm/amd/amdgpu/psp_v3_1.c      |  8 +--
> >>>>    drivers/gpu/drm/amd/amdgpu/vce_v4_0.c      | 26 +++++----
> >>>>    drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c      | 22 +++++---
> >>>>    13 files changed, 168 insertions(+), 95 deletions(-)
> >>>>
> >>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >>>> index a0bff4713672..f7cca25c0fa0 100644
> >>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >>>> @@ -71,6 +71,8 @@
> >>>>    #include <drm/task_barrier.h>
> >>>>    #include <linux/pm_runtime.h>
> >>>>
> >>>> +#include <drm/drm_drv.h>
> >>>> +
> >>>>    MODULE_FIRMWARE("amdgpu/vega10_gpu_info.bin");
> >>>>    MODULE_FIRMWARE("amdgpu/vega12_gpu_info.bin");
> >>>>    MODULE_FIRMWARE("amdgpu/raven_gpu_info.bin");
> >>>> @@ -281,7 +283,10 @@ void amdgpu_device_vram_access(struct amdgpu_device *adev, loff_t pos,
> >>>>           unsigned long flags;
> >>>>           uint32_t hi = ~0;
> >>>>           uint64_t last;
> >>>> +       int idx;
> >>>>
> >>>> +       if (!drm_dev_enter(&adev->ddev, &idx))
> >>>> +               return;
> >>>>
> >>>>    #ifdef CONFIG_64BIT
> >>>>           last = min(pos + size, adev->gmc.visible_vram_size);
> >>>> @@ -300,7 +305,7 @@ void amdgpu_device_vram_access(struct amdgpu_device *adev, loff_t pos,
> >>>>                   }
> >>>>
> >>>>                   if (count == size)
> >>>> -                       return;
> >>>> +                       goto exit;
> >>>>
> >>>>                   pos += count;
> >>>>                   buf += count / 4;
> >>>> @@ -323,6 +328,9 @@ void amdgpu_device_vram_access(struct amdgpu_device *adev, loff_t pos,
> >>>>                           *buf++ = RREG32_NO_KIQ(mmMM_DATA);
> >>>>           }
> >>>>           spin_unlock_irqrestore(&adev->mmio_idx_lock, flags);
> >>>> +
> >>>> +exit:
> >>>> +       drm_dev_exit(idx);
> >>>>    }
> >>>>
> >>>>    /*
> >>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> >>>> index 4d32233cde92..04ba5eef1e88 100644
> >>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> >>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> >>>> @@ -31,6 +31,8 @@
> >>>>    #include "amdgpu_ras.h"
> >>>>    #include "amdgpu_xgmi.h"
> >>>>
> >>>> +#include <drm/drm_drv.h>
> >>>> +
> >>>>    /**
> >>>>     * amdgpu_gmc_pdb0_alloc - allocate vram for pdb0
> >>>>     *
> >>>> @@ -151,6 +153,10 @@ int amdgpu_gmc_set_pte_pde(struct amdgpu_device *adev, void *cpu_pt_addr,
> >>>>    {
> >>>>           void __iomem *ptr = (void *)cpu_pt_addr;
> >>>>           uint64_t value;
> >>>> +       int idx;
> >>>> +
> >>>> +       if (!drm_dev_enter(&adev->ddev, &idx))
> >>>> +               return 0;
> >>>>
> >>>>           /*
> >>>>            * The following is for PTE only. GART does not have PDEs.
> >>>> @@ -158,6 +164,9 @@ int amdgpu_gmc_set_pte_pde(struct amdgpu_device *adev, void *cpu_pt_addr,
> >>>>           value = addr & 0x0000FFFFFFFFF000ULL;
> >>>>           value |= flags;
> >>>>           writeq(value, ptr + (gpu_page_idx * 8));
> >>>> +
> >>>> +       drm_dev_exit(idx);
> >>>> +
> >>>>           return 0;
> >>>>    }
> >>>>
> >>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> >>>> index 9e769cf6095b..bb6afee61666 100644
> >>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> >>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> >>>> @@ -25,6 +25,7 @@
> >>>>
> >>>>    #include <linux/firmware.h>
> >>>>    #include <linux/dma-mapping.h>
> >>>> +#include <drm/drm_drv.h>
> >>>>
> >>>>    #include "amdgpu.h"
> >>>>    #include "amdgpu_psp.h"
> >>>> @@ -39,6 +40,8 @@
> >>>>    #include "amdgpu_ras.h"
> >>>>    #include "amdgpu_securedisplay.h"
> >>>>
> >>>> +#include <drm/drm_drv.h>
> >>>> +
> >>>>    static int psp_sysfs_init(struct amdgpu_device *adev);
> >>>>    static void psp_sysfs_fini(struct amdgpu_device *adev);
> >>>>
> >>>> @@ -253,7 +256,7 @@ psp_cmd_submit_buf(struct psp_context *psp,
> >>>>                      struct psp_gfx_cmd_resp *cmd, uint64_t fence_mc_addr)
> >>>>    {
> >>>>           int ret;
> >>>> -       int index;
> >>>> +       int index, idx;
> >>>>           int timeout = 20000;
> >>>>           bool ras_intr = false;
> >>>>           bool skip_unsupport = false;
> >>>> @@ -261,6 +264,9 @@ psp_cmd_submit_buf(struct psp_context *psp,
> >>>>           if (psp->adev->in_pci_err_recovery)
> >>>>                   return 0;
> >>>>
> >>>> +       if (!drm_dev_enter(&psp->adev->ddev, &idx))
> >>>> +               return 0;
> >>>> +
> >>>>           mutex_lock(&psp->mutex);
> >>>>
> >>>>           memset(psp->cmd_buf_mem, 0, PSP_CMD_BUFFER_SIZE);
> >>>> @@ -271,8 +277,7 @@ psp_cmd_submit_buf(struct psp_context *psp,
> >>>>           ret = psp_ring_cmd_submit(psp, psp->cmd_buf_mc_addr, fence_mc_addr, index);
> >>>>           if (ret) {
> >>>>                   atomic_dec(&psp->fence_value);
> >>>> -               mutex_unlock(&psp->mutex);
> >>>> -               return ret;
> >>>> +               goto exit;
> >>>>           }
> >>>>
> >>>>           amdgpu_asic_invalidate_hdp(psp->adev, NULL);
> >>>> @@ -312,8 +317,8 @@ psp_cmd_submit_buf(struct psp_context *psp,
> >>>>                            psp->cmd_buf_mem->cmd_id,
> >>>>                            psp->cmd_buf_mem->resp.status);
> >>>>                   if (!timeout) {
> >>>> -                       mutex_unlock(&psp->mutex);
> >>>> -                       return -EINVAL;
> >>>> +                       ret = -EINVAL;
> >>>> +                       goto exit;
> >>>>                   }
> >>>>           }
> >>>>
> >>>> @@ -321,8 +326,10 @@ psp_cmd_submit_buf(struct psp_context *psp,
> >>>>                   ucode->tmr_mc_addr_lo = psp->cmd_buf_mem->resp.fw_addr_lo;
> >>>>                   ucode->tmr_mc_addr_hi = psp->cmd_buf_mem->resp.fw_addr_hi;
> >>>>           }
> >>>> -       mutex_unlock(&psp->mutex);
> >>>>
> >>>> +exit:
> >>>> +       mutex_unlock(&psp->mutex);
> >>>> +       drm_dev_exit(idx);
> >>>>           return ret;
> >>>>    }
> >>>>
> >>>> @@ -359,8 +366,7 @@ static int psp_load_toc(struct psp_context *psp,
> >>>>           if (!cmd)
> >>>>                   return -ENOMEM;
> >>>>           /* Copy toc to psp firmware private buffer */
> >>>> -       memset(psp->fw_pri_buf, 0, PSP_1_MEG);
> >>>> -       memcpy(psp->fw_pri_buf, psp->toc_start_addr, psp->toc_bin_size);
> >>>> +       psp_copy_fw(psp, psp->toc_start_addr, psp->toc_bin_size);
> >>>>
> >>>>           psp_prep_load_toc_cmd_buf(cmd, psp->fw_pri_mc_addr, psp->toc_bin_size);
> >>>>
> >>>> @@ -625,8 +631,7 @@ static int psp_asd_load(struct psp_context *psp)
> >>>>           if (!cmd)
> >>>>                   return -ENOMEM;
> >>>>
> >>>> -       memset(psp->fw_pri_buf, 0, PSP_1_MEG);
> >>>> -       memcpy(psp->fw_pri_buf, psp->asd_start_addr, psp->asd_ucode_size);
> >>>> +       psp_copy_fw(psp, psp->asd_start_addr, psp->asd_ucode_size);
> >>>>
> >>>>           psp_prep_asd_load_cmd_buf(cmd, psp->fw_pri_mc_addr,
> >>>>                                     psp->asd_ucode_size);
> >>>> @@ -781,8 +786,7 @@ static int psp_xgmi_load(struct psp_context *psp)
> >>>>           if (!cmd)
> >>>>                   return -ENOMEM;
> >>>>
> >>>> -       memset(psp->fw_pri_buf, 0, PSP_1_MEG);
> >>>> -       memcpy(psp->fw_pri_buf, psp->ta_xgmi_start_addr, psp->ta_xgmi_ucode_size);
> >>>> +       psp_copy_fw(psp, psp->ta_xgmi_start_addr, psp->ta_xgmi_ucode_size);
> >>>>
> >>>>           psp_prep_ta_load_cmd_buf(cmd,
> >>>>                                    psp->fw_pri_mc_addr,
> >>>> @@ -1038,8 +1042,7 @@ static int psp_ras_load(struct psp_context *psp)
> >>>>           if (!cmd)
> >>>>                   return -ENOMEM;
> >>>>
> >>>> -       memset(psp->fw_pri_buf, 0, PSP_1_MEG);
> >>>> -       memcpy(psp->fw_pri_buf, psp->ta_ras_start_addr, psp->ta_ras_ucode_size);
> >>>> +       psp_copy_fw(psp, psp->ta_ras_start_addr, psp->ta_ras_ucode_size);
> >>>>
> >>>>           psp_prep_ta_load_cmd_buf(cmd,
> >>>>                                    psp->fw_pri_mc_addr,
> >>>> @@ -1275,8 +1278,7 @@ static int psp_hdcp_load(struct psp_context *psp)
> >>>>           if (!cmd)
> >>>>                   return -ENOMEM;
> >>>>
> >>>> -       memset(psp->fw_pri_buf, 0, PSP_1_MEG);
> >>>> -       memcpy(psp->fw_pri_buf, psp->ta_hdcp_start_addr,
> >>>> +       psp_copy_fw(psp, psp->ta_hdcp_start_addr,
> >>>>                  psp->ta_hdcp_ucode_size);
> >>>>
> >>>>           psp_prep_ta_load_cmd_buf(cmd,
> >>>> @@ -1427,8 +1429,7 @@ static int psp_dtm_load(struct psp_context *psp)
> >>>>           if (!cmd)
> >>>>                   return -ENOMEM;
> >>>>
> >>>> -       memset(psp->fw_pri_buf, 0, PSP_1_MEG);
> >>>> -       memcpy(psp->fw_pri_buf, psp->ta_dtm_start_addr, psp->ta_dtm_ucode_size);
> >>>> +       psp_copy_fw(psp, psp->ta_dtm_start_addr, psp->ta_dtm_ucode_size);
> >>>>
> >>>>           psp_prep_ta_load_cmd_buf(cmd,
> >>>>                                    psp->fw_pri_mc_addr,
> >>>> @@ -1573,8 +1574,7 @@ static int psp_rap_load(struct psp_context *psp)
> >>>>           if (!cmd)
> >>>>                   return -ENOMEM;
> >>>>
> >>>> -       memset(psp->fw_pri_buf, 0, PSP_1_MEG);
> >>>> -       memcpy(psp->fw_pri_buf, psp->ta_rap_start_addr, psp->ta_rap_ucode_size);
> >>>> +       psp_copy_fw(psp, psp->ta_rap_start_addr, psp->ta_rap_ucode_size);
> >>>>
> >>>>           psp_prep_ta_load_cmd_buf(cmd,
> >>>>                                    psp->fw_pri_mc_addr,
> >>>> @@ -3022,7 +3022,7 @@ static ssize_t psp_usbc_pd_fw_sysfs_write(struct device *dev,
> >>>>           struct amdgpu_device *adev = drm_to_adev(ddev);
> >>>>           void *cpu_addr;
> >>>>           dma_addr_t dma_addr;
> >>>> -       int ret;
> >>>> +       int ret, idx;
> >>>>           char fw_name[100];
> >>>>           const struct firmware *usbc_pd_fw;
> >>>>
> >>>> @@ -3031,6 +3031,9 @@ static ssize_t psp_usbc_pd_fw_sysfs_write(struct device *dev,
> >>>>                   return -EBUSY;
> >>>>           }
> >>>>
> >>>> +       if (!drm_dev_enter(ddev, &idx))
> >>>> +               return -ENODEV;
> >>>> +
> >>>>           snprintf(fw_name, sizeof(fw_name), "amdgpu/%s", buf);
> >>>>           ret = request_firmware(&usbc_pd_fw, fw_name, adev->dev);
> >>>>           if (ret)
> >>>> @@ -3062,16 +3065,30 @@ static ssize_t psp_usbc_pd_fw_sysfs_write(struct device *dev,
> >>>>    rel_buf:
> >>>>           dma_free_coherent(adev->dev, usbc_pd_fw->size, cpu_addr, dma_addr);
> >>>>           release_firmware(usbc_pd_fw);
> >>>> -
> >>>>    fail:
> >>>>           if (ret) {
> >>>>                   DRM_ERROR("Failed to load USBC PD FW, err = %d", ret);
> >>>> -               return ret;
> >>>> +               count = ret;
> >>>>           }
> >>>>
> >>>> +       drm_dev_exit(idx);
> >>>>           return count;
> >>>>    }
> >>>>
> >>>> +void psp_copy_fw(struct psp_context *psp, uint8_t *start_addr, uint32_t bin_size)
> >>>> +{
> >>>> +       int idx;
> >>>> +
> >>>> +       if (!drm_dev_enter(&psp->adev->ddev, &idx))
> >>>> +               return;
> >>>> +
> >>>> +       memset(psp->fw_pri_buf, 0, PSP_1_MEG);
> >>>> +       memcpy(psp->fw_pri_buf, start_addr, bin_size);
> >>>> +
> >>>> +       drm_dev_exit(idx);
> >>>> +}
> >>>> +
> >>>> +
> >>>>    static DEVICE_ATTR(usbc_pd_fw, S_IRUGO | S_IWUSR,
> >>>>                      psp_usbc_pd_fw_sysfs_read,
> >>>>                      psp_usbc_pd_fw_sysfs_write);
> >>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> >>>> index 46a5328e00e0..2bfdc278817f 100644
> >>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> >>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> >>>> @@ -423,4 +423,6 @@ int psp_get_fw_attestation_records_addr(struct psp_context *psp,
> >>>>
> >>>>    int psp_load_fw_list(struct psp_context *psp,
> >>>>                        struct amdgpu_firmware_info **ucode_list, int ucode_count);
> >>>> +void psp_copy_fw(struct psp_context *psp, uint8_t *start_addr, uint32_t bin_size);
> >>>> +
> >>>>    #endif
> >>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> >>>> index c6dbc0801604..82f0542c7792 100644
> >>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> >>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> >>>> @@ -32,6 +32,7 @@
> >>>>    #include <linux/module.h>
> >>>>
> >>>>    #include <drm/drm.h>
> >>>> +#include <drm/drm_drv.h>
> >>>>
> >>>>    #include "amdgpu.h"
> >>>>    #include "amdgpu_pm.h"
> >>>> @@ -375,7 +376,7 @@ int amdgpu_uvd_suspend(struct amdgpu_device *adev)
> >>>>    {
> >>>>           unsigned size;
> >>>>           void *ptr;
> >>>> -       int i, j;
> >>>> +       int i, j, idx;
> >>>>           bool in_ras_intr = amdgpu_ras_intr_triggered();
> >>>>
> >>>>           cancel_delayed_work_sync(&adev->uvd.idle_work);
> >>>> @@ -403,11 +404,15 @@ int amdgpu_uvd_suspend(struct amdgpu_device *adev)
> >>>>                   if (!adev->uvd.inst[j].saved_bo)
> >>>>                           return -ENOMEM;
> >>>>
> >>>> -               /* re-write 0 since err_event_athub will corrupt VCPU buffer */
> >>>> -               if (in_ras_intr)
> >>>> -                       memset(adev->uvd.inst[j].saved_bo, 0, size);
> >>>> -               else
> >>>> -                       memcpy_fromio(adev->uvd.inst[j].saved_bo, ptr, size);
> >>>> +               if (drm_dev_enter(&adev->ddev, &idx)) {
> >>>> +                       /* re-write 0 since err_event_athub will corrupt VCPU buffer */
> >>>> +                       if (in_ras_intr)
> >>>> +                               memset(adev->uvd.inst[j].saved_bo, 0, size);
> >>>> +                       else
> >>>> +                               memcpy_fromio(adev->uvd.inst[j].saved_bo, ptr, size);
> >>>> +
> >>>> +                       drm_dev_exit(idx);
> >>>> +               }
> >>>>           }
> >>>>
> >>>>           if (in_ras_intr)
> >>>> @@ -420,7 +425,7 @@ int amdgpu_uvd_resume(struct amdgpu_device *adev)
> >>>>    {
> >>>>           unsigned size;
> >>>>           void *ptr;
> >>>> -       int i;
> >>>> +       int i, idx;
> >>>>
> >>>>           for (i = 0; i < adev->uvd.num_uvd_inst; i++) {
> >>>>                   if (adev->uvd.harvest_config & (1 << i))
> >>>> @@ -432,7 +437,10 @@ int amdgpu_uvd_resume(struct amdgpu_device *adev)
> >>>>                   ptr = adev->uvd.inst[i].cpu_addr;
> >>>>
> >>>>                   if (adev->uvd.inst[i].saved_bo != NULL) {
> >>>> -                       memcpy_toio(ptr, adev->uvd.inst[i].saved_bo, size);
> >>>> +                       if (drm_dev_enter(&adev->ddev, &idx)) {
> >>>> +                               memcpy_toio(ptr, adev->uvd.inst[i].saved_bo, size);
> >>>> +                               drm_dev_exit(idx);
> >>>> +                       }
> >>>>                           kvfree(adev->uvd.inst[i].saved_bo);
> >>>>                           adev->uvd.inst[i].saved_bo = NULL;
> >>>>                   } else {
> >>>> @@ -442,8 +450,11 @@ int amdgpu_uvd_resume(struct amdgpu_device *adev)
> >>>>                           hdr = (const struct common_firmware_header *)adev->uvd.fw->data;
> >>>>                           if (adev->firmware.load_type != AMDGPU_FW_LOAD_PSP) {
> >>>>                                   offset = le32_to_cpu(hdr->ucode_array_offset_bytes);
> >>>> -                               memcpy_toio(adev->uvd.inst[i].cpu_addr, adev->uvd.fw->data + offset,
> >>>> -                                           le32_to_cpu(hdr->ucode_size_bytes));
> >>>> +                               if (drm_dev_enter(&adev->ddev, &idx)) {
> >>>> +                                       memcpy_toio(adev->uvd.inst[i].cpu_addr, adev->uvd.fw->data + offset,
> >>>> +                                                   le32_to_cpu(hdr->ucode_size_bytes));
> >>>> +                                       drm_dev_exit(idx);
> >>>> +                               }
> >>>>                                   size -= le32_to_cpu(hdr->ucode_size_bytes);
> >>>>                                   ptr += le32_to_cpu(hdr->ucode_size_bytes);
> >>>>                           }
> >>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> >>>> index ea6a62f67e38..833203401ef4 100644
> >>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> >>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> >>>> @@ -29,6 +29,7 @@
> >>>>    #include <linux/module.h>
> >>>>
> >>>>    #include <drm/drm.h>
> >>>> +#include <drm/drm_drv.h>
> >>>>
> >>>>    #include "amdgpu.h"
> >>>>    #include "amdgpu_pm.h"
> >>>> @@ -293,7 +294,7 @@ int amdgpu_vce_resume(struct amdgpu_device *adev)
> >>>>           void *cpu_addr;
> >>>>           const struct common_firmware_header *hdr;
> >>>>           unsigned offset;
> >>>> -       int r;
> >>>> +       int r, idx;
> >>>>
> >>>>           if (adev->vce.vcpu_bo == NULL)
> >>>>                   return -EINVAL;
> >>>> @@ -313,8 +314,12 @@ int amdgpu_vce_resume(struct amdgpu_device *adev)
> >>>>
> >>>>           hdr = (const struct common_firmware_header *)adev->vce.fw->data;
> >>>>           offset = le32_to_cpu(hdr->ucode_array_offset_bytes);
> >>>> -       memcpy_toio(cpu_addr, adev->vce.fw->data + offset,
> >>>> -                   adev->vce.fw->size - offset);
> >>>> +
> >>>> +       if (drm_dev_enter(&adev->ddev, &idx)) {
> >>>> +               memcpy_toio(cpu_addr, adev->vce.fw->data + offset,
> >>>> +                           adev->vce.fw->size - offset);
> >>>> +               drm_dev_exit(idx);
> >>>> +       }
> >>>>
> >>>>           amdgpu_bo_kunmap(adev->vce.vcpu_bo);
> >>>>
> >>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> >>>> index 201645963ba5..21f7d3644d70 100644
> >>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> >>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> >>>> @@ -27,6 +27,7 @@
> >>>>    #include <linux/firmware.h>
> >>>>    #include <linux/module.h>
> >>>>    #include <linux/pci.h>
> >>>> +#include <drm/drm_drv.h>
> >>>>
> >>>>    #include "amdgpu.h"
> >>>>    #include "amdgpu_pm.h"
> >>>> @@ -275,7 +276,7 @@ int amdgpu_vcn_suspend(struct amdgpu_device *adev)
> >>>>    {
> >>>>           unsigned size;
> >>>>           void *ptr;
> >>>> -       int i;
> >>>> +       int i, idx;
> >>>>
> >>>>           cancel_delayed_work_sync(&adev->vcn.idle_work);
> >>>>
> >>>> @@ -292,7 +293,10 @@ int amdgpu_vcn_suspend(struct amdgpu_device *adev)
> >>>>                   if (!adev->vcn.inst[i].saved_bo)
> >>>>                           return -ENOMEM;
> >>>>
> >>>> -               memcpy_fromio(adev->vcn.inst[i].saved_bo, ptr, size);
> >>>> +               if (drm_dev_enter(&adev->ddev, &idx)) {
> >>>> +                       memcpy_fromio(adev->vcn.inst[i].saved_bo, ptr, size);
> >>>> +                       drm_dev_exit(idx);
> >>>> +               }
> >>>>           }
> >>>>           return 0;
> >>>>    }
> >>>> @@ -301,7 +305,7 @@ int amdgpu_vcn_resume(struct amdgpu_device *adev)
> >>>>    {
> >>>>           unsigned size;
> >>>>           void *ptr;
> >>>> -       int i;
> >>>> +       int i, idx;
> >>>>
> >>>>           for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> >>>>                   if (adev->vcn.harvest_config & (1 << i))
> >>>> @@ -313,7 +317,10 @@ int amdgpu_vcn_resume(struct amdgpu_device *adev)
> >>>>                   ptr = adev->vcn.inst[i].cpu_addr;
> >>>>
> >>>>                   if (adev->vcn.inst[i].saved_bo != NULL) {
> >>>> -                       memcpy_toio(ptr, adev->vcn.inst[i].saved_bo, size);
> >>>> +                       if (drm_dev_enter(&adev->ddev, &idx)) {
> >>>> +                               memcpy_toio(ptr, adev->vcn.inst[i].saved_bo, size);
> >>>> +                               drm_dev_exit(idx);
> >>>> +                       }
> >>>>                           kvfree(adev->vcn.inst[i].saved_bo);
> >>>>                           adev->vcn.inst[i].saved_bo = NULL;
> >>>>                   } else {
> >>>> @@ -323,8 +330,11 @@ int amdgpu_vcn_resume(struct amdgpu_device *adev)
> >>>>                           hdr = (const struct common_firmware_header *)adev->vcn.fw->data;
> >>>>                           if (adev->firmware.load_type != AMDGPU_FW_LOAD_PSP) {
> >>>>                                   offset = le32_to_cpu(hdr->ucode_array_offset_bytes);
> >>>> -                               memcpy_toio(adev->vcn.inst[i].cpu_addr, adev->vcn.fw->data + offset,
> >>>> -                                           le32_to_cpu(hdr->ucode_size_bytes));
> >>>> +                               if (drm_dev_enter(&adev->ddev, &idx)) {
> >>>> +                                       memcpy_toio(adev->vcn.inst[i].cpu_addr, adev->vcn.fw->data + offset,
> >>>> +                                                   le32_to_cpu(hdr->ucode_size_bytes));
> >>>> +                                       drm_dev_exit(idx);
> >>>> +                               }
> >>>>                                   size -= le32_to_cpu(hdr->ucode_size_bytes);
> >>>>                                   ptr += le32_to_cpu(hdr->ucode_size_bytes);
> >>>>                           }
> >>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> >>>> index 9f868cf3b832..7dd5f10ab570 100644
> >>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> >>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> >>>> @@ -32,6 +32,7 @@
> >>>>    #include <linux/dma-buf.h>
> >>>>
> >>>>    #include <drm/amdgpu_drm.h>
> >>>> +#include <drm/drm_drv.h>
> >>>>    #include "amdgpu.h"
> >>>>    #include "amdgpu_trace.h"
> >>>>    #include "amdgpu_amdkfd.h"
> >>>> @@ -1606,7 +1607,10 @@ static int amdgpu_vm_bo_update_mapping(struct amdgpu_device *adev,
> >>>>           struct amdgpu_vm_update_params params;
> >>>>           enum amdgpu_sync_mode sync_mode;
> >>>>           uint64_t pfn;
> >>>> -       int r;
> >>>> +       int r, idx;
> >>>> +
> >>>> +       if (!drm_dev_enter(&adev->ddev, &idx))
> >>>> +               return -ENODEV;
> >>>>
> >>>>           memset(&params, 0, sizeof(params));
> >>>>           params.adev = adev;
> >>>> @@ -1715,6 +1719,7 @@ static int amdgpu_vm_bo_update_mapping(struct amdgpu_device *adev,
> >>>>
> >>>>    error_unlock:
> >>>>           amdgpu_vm_eviction_unlock(vm);
> >>>> +       drm_dev_exit(idx);
> >>>>           return r;
> >>>>    }
> >>>>
> >>>> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> >>>> index 589410c32d09..2cec71e823f5 100644
> >>>> --- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> >>>> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> >>>> @@ -23,6 +23,7 @@
> >>>>    #include <linux/firmware.h>
> >>>>    #include <linux/module.h>
> >>>>    #include <linux/vmalloc.h>
> >>>> +#include <drm/drm_drv.h>
> >>>>
> >>>>    #include "amdgpu.h"
> >>>>    #include "amdgpu_psp.h"
> >>>> @@ -269,10 +270,8 @@ static int psp_v11_0_bootloader_load_kdb(struct psp_context *psp)
> >>>>           if (ret)
> >>>>                   return ret;
> >>>>
> >>>> -       memset(psp->fw_pri_buf, 0, PSP_1_MEG);
> >>>> -
> >>>>           /* Copy PSP KDB binary to memory */
> >>>> -       memcpy(psp->fw_pri_buf, psp->kdb_start_addr, psp->kdb_bin_size);
> >>>> +       psp_copy_fw(psp, psp->kdb_start_addr, psp->kdb_bin_size);
> >>>>
> >>>>           /* Provide the PSP KDB to bootloader */
> >>>>           WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_36,
> >>>> @@ -302,10 +301,8 @@ static int psp_v11_0_bootloader_load_spl(struct psp_context *psp)
> >>>>           if (ret)
> >>>>                   return ret;
> >>>>
> >>>> -       memset(psp->fw_pri_buf, 0, PSP_1_MEG);
> >>>> -
> >>>>           /* Copy PSP SPL binary to memory */
> >>>> -       memcpy(psp->fw_pri_buf, psp->spl_start_addr, psp->spl_bin_size);
> >>>> +       psp_copy_fw(psp, psp->spl_start_addr, psp->spl_bin_size);
> >>>>
> >>>>           /* Provide the PSP SPL to bootloader */
> >>>>           WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_36,
> >>>> @@ -335,10 +332,8 @@ static int psp_v11_0_bootloader_load_sysdrv(struct psp_context *psp)
> >>>>           if (ret)
> >>>>                   return ret;
> >>>>
> >>>> -       memset(psp->fw_pri_buf, 0, PSP_1_MEG);
> >>>> -
> >>>>           /* Copy PSP System Driver binary to memory */
> >>>> -       memcpy(psp->fw_pri_buf, psp->sys_start_addr, psp->sys_bin_size);
> >>>> +       psp_copy_fw(psp, psp->sys_start_addr, psp->sys_bin_size);
> >>>>
> >>>>           /* Provide the sys driver to bootloader */
> >>>>           WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_36,
> >>>> @@ -371,10 +366,8 @@ static int psp_v11_0_bootloader_load_sos(struct psp_context *psp)
> >>>>           if (ret)
> >>>>                   return ret;
> >>>>
> >>>> -       memset(psp->fw_pri_buf, 0, PSP_1_MEG);
> >>>> -
> >>>>           /* Copy Secure OS binary to PSP memory */
> >>>> -       memcpy(psp->fw_pri_buf, psp->sos_start_addr, psp->sos_bin_size);
> >>>> +       psp_copy_fw(psp, psp->sos_start_addr, psp->sos_bin_size);
> >>>>
> >>>>           /* Provide the PSP secure OS to bootloader */
> >>>>           WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_36,
> >>>> @@ -608,7 +601,7 @@ static int psp_v11_0_memory_training(struct psp_context *psp, uint32_t ops)
> >>>>           uint32_t p2c_header[4];
> >>>>           uint32_t sz;
> >>>>           void *buf;
> >>>> -       int ret;
> >>>> +       int ret, idx;
> >>>>
> >>>>           if (ctx->init == PSP_MEM_TRAIN_NOT_SUPPORT) {
> >>>>                   DRM_DEBUG("Memory training is not supported.\n");
> >>>> @@ -681,17 +674,24 @@ static int psp_v11_0_memory_training(struct psp_context *psp, uint32_t ops)
> >>>>                           return -ENOMEM;
> >>>>                   }
> >>>>
> >>>> -               memcpy_fromio(buf, adev->mman.aper_base_kaddr, sz);
> >>>> -               ret = psp_v11_0_memory_training_send_msg(psp, PSP_BL__DRAM_LONG_TRAIN);
> >>>> -               if (ret) {
> >>>> -                       DRM_ERROR("Send long training msg failed.\n");
> >>>> +               if (drm_dev_enter(&adev->ddev, &idx)) {
> >>>> +                       memcpy_fromio(buf, adev->mman.aper_base_kaddr, sz);
> >>>> +                       ret = psp_v11_0_memory_training_send_msg(psp, PSP_BL__DRAM_LONG_TRAIN);
> >>>> +                       if (ret) {
> >>>> +                               DRM_ERROR("Send long training msg failed.\n");
> >>>> +                               vfree(buf);
> >>>> +                               drm_dev_exit(idx);
> >>>> +                               return ret;
> >>>> +                       }
> >>>> +
> >>>> +                       memcpy_toio(adev->mman.aper_base_kaddr, buf, sz);
> >>>> +                       adev->hdp.funcs->flush_hdp(adev, NULL);
> >>>>                           vfree(buf);
> >>>> -                       return ret;
> >>>> +                       drm_dev_exit(idx);
> >>>> +               } else {
> >>>> +                       vfree(buf);
> >>>> +                       return -ENODEV;
> >>>>                   }
> >>>> -
> >>>> -               memcpy_toio(adev->mman.aper_base_kaddr, buf, sz);
> >>>> -               adev->hdp.funcs->flush_hdp(adev, NULL);
> >>>> -               vfree(buf);
> >>>>           }
> >>>>
> >>>>           if (ops & PSP_MEM_TRAIN_SAVE) {
> >>>> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
> >>>> index c4828bd3264b..618e5b6b85d9 100644
> >>>> --- a/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
> >>>> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
> >>>> @@ -138,10 +138,8 @@ static int psp_v12_0_bootloader_load_sysdrv(struct psp_context *psp)
> >>>>           if (ret)
> >>>>                   return ret;
> >>>>
> >>>> -       memset(psp->fw_pri_buf, 0, PSP_1_MEG);
> >>>> -
> >>>>           /* Copy PSP System Driver binary to memory */
> >>>> -       memcpy(psp->fw_pri_buf, psp->sys_start_addr, psp->sys_bin_size);
> >>>> +       psp_copy_fw(psp, psp->sys_start_addr, psp->sys_bin_size);
> >>>>
> >>>>           /* Provide the sys driver to bootloader */
> >>>>           WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_36,
> >>>> @@ -179,10 +177,8 @@ static int psp_v12_0_bootloader_load_sos(struct psp_context *psp)
> >>>>           if (ret)
> >>>>                   return ret;
> >>>>
> >>>> -       memset(psp->fw_pri_buf, 0, PSP_1_MEG);
> >>>> -
> >>>>           /* Copy Secure OS binary to PSP memory */
> >>>> -       memcpy(psp->fw_pri_buf, psp->sos_start_addr, psp->sos_bin_size);
> >>>> +       psp_copy_fw(psp, psp->sos_start_addr, psp->sos_bin_size);
> >>>>
> >>>>           /* Provide the PSP secure OS to bootloader */
> >>>>           WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_36,
> >>>> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c b/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
> >>>> index f2e725f72d2f..d0a6cccd0897 100644
> >>>> --- a/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
> >>>> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
> >>>> @@ -102,10 +102,8 @@ static int psp_v3_1_bootloader_load_sysdrv(struct psp_context *psp)
> >>>>           if (ret)
> >>>>                   return ret;
> >>>>
> >>>> -       memset(psp->fw_pri_buf, 0, PSP_1_MEG);
> >>>> -
> >>>>           /* Copy PSP System Driver binary to memory */
> >>>> -       memcpy(psp->fw_pri_buf, psp->sys_start_addr, psp->sys_bin_size);
> >>>> +       psp_copy_fw(psp, psp->sys_start_addr, psp->sys_bin_size);
> >>>>
> >>>>           /* Provide the sys driver to bootloader */
> >>>>           WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_36,
> >>>> @@ -143,10 +141,8 @@ static int psp_v3_1_bootloader_load_sos(struct psp_context *psp)
> >>>>           if (ret)
> >>>>                   return ret;
> >>>>
> >>>> -       memset(psp->fw_pri_buf, 0, PSP_1_MEG);
> >>>> -
> >>>>           /* Copy Secure OS binary to PSP memory */
> >>>> -       memcpy(psp->fw_pri_buf, psp->sos_start_addr, psp->sos_bin_size);
> >>>> +       psp_copy_fw(psp, psp->sos_start_addr, psp->sos_bin_size);
> >>>>
> >>>>           /* Provide the PSP secure OS to bootloader */
> >>>>           WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_36,
> >>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
> >>>> index 8e238dea7bef..90910d19db12 100644
> >>>> --- a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
> >>>> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
> >>>> @@ -25,6 +25,7 @@
> >>>>     */
> >>>>
> >>>>    #include <linux/firmware.h>
> >>>> +#include <drm/drm_drv.h>
> >>>>
> >>>>    #include "amdgpu.h"
> >>>>    #include "amdgpu_vce.h"
> >>>> @@ -555,16 +556,19 @@ static int vce_v4_0_hw_fini(void *handle)
> >>>>    static int vce_v4_0_suspend(void *handle)
> >>>>    {
> >>>>           struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> >>>> -       int r;
> >>>> +       int r, idx;
> >>>>
> >>>>           if (adev->vce.vcpu_bo == NULL)
> >>>>                   return 0;
> >>>>
> >>>> -       if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
> >>>> -               unsigned size = amdgpu_bo_size(adev->vce.vcpu_bo);
> >>>> -               void *ptr = adev->vce.cpu_addr;
> >>>> +       if (drm_dev_enter(&adev->ddev, &idx)) {
> >>>> +               if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
> >>>> +                       unsigned size = amdgpu_bo_size(adev->vce.vcpu_bo);
> >>>> +                       void *ptr = adev->vce.cpu_addr;
> >>>>
> >>>> -               memcpy_fromio(adev->vce.saved_bo, ptr, size);
> >>>> +                       memcpy_fromio(adev->vce.saved_bo, ptr, size);
> >>>> +               }
> >>>> +               drm_dev_exit(idx);
> >>>>           }
> >>>>
> >>>>           r = vce_v4_0_hw_fini(adev);
> >>>> @@ -577,16 +581,20 @@ static int vce_v4_0_suspend(void *handle)
> >>>>    static int vce_v4_0_resume(void *handle)
> >>>>    {
> >>>>           struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> >>>> -       int r;
> >>>> +       int r, idx;
> >>>>
> >>>>           if (adev->vce.vcpu_bo == NULL)
> >>>>                   return -EINVAL;
> >>>>
> >>>>           if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
> >>>> -               unsigned size = amdgpu_bo_size(adev->vce.vcpu_bo);
> >>>> -               void *ptr = adev->vce.cpu_addr;
> >>>>
> >>>> -               memcpy_toio(ptr, adev->vce.saved_bo, size);
> >>>> +               if (drm_dev_enter(&adev->ddev, &idx)) {
> >>>> +                       unsigned size = amdgpu_bo_size(adev->vce.vcpu_bo);
> >>>> +                       void *ptr = adev->vce.cpu_addr;
> >>>> +
> >>>> +                       memcpy_toio(ptr, adev->vce.saved_bo, size);
> >>>> +                       drm_dev_exit(idx);
> >>>> +               }
> >>>>           } else {
> >>>>                   r = amdgpu_vce_resume(adev);
> >>>>                   if (r)
> >>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> >>>> index 3f15bf34123a..df34be8ec82d 100644
> >>>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> >>>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> >>>> @@ -34,6 +34,8 @@
> >>>>    #include "vcn/vcn_3_0_0_sh_mask.h"
> >>>>    #include "ivsrcid/vcn/irqsrcs_vcn_2_0.h"
> >>>>
> >>>> +#include <drm/drm_drv.h>
> >>>> +
> >>>>    #define mmUVD_CONTEXT_ID_INTERNAL_OFFSET                       0x27
> >>>>    #define mmUVD_GPCOM_VCPU_CMD_INTERNAL_OFFSET                   0x0f
> >>>>    #define mmUVD_GPCOM_VCPU_DATA0_INTERNAL_OFFSET                 0x10
> >>>> @@ -268,16 +270,20 @@ static int vcn_v3_0_sw_init(void *handle)
> >>>>    static int vcn_v3_0_sw_fini(void *handle)
> >>>>    {
> >>>>           struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> >>>> -       int i, r;
> >>>> +       int i, r, idx;
> >>>>
> >>>> -       for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> >>>> -               volatile struct amdgpu_fw_shared *fw_shared;
> >>>> +       if (drm_dev_enter(&adev->ddev, &idx)) {
> >>>> +               for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> >>>> +                       volatile struct amdgpu_fw_shared *fw_shared;
> >>>>
> >>>> -               if (adev->vcn.harvest_config & (1 << i))
> >>>> -                       continue;
> >>>> -               fw_shared = adev->vcn.inst[i].fw_shared_cpu_addr;
> >>>> -               fw_shared->present_flag_0 = 0;
> >>>> -               fw_shared->sw_ring.is_enabled = false;
> >>>> +                       if (adev->vcn.harvest_config & (1 << i))
> >>>> +                               continue;
> >>>> +                       fw_shared = adev->vcn.inst[i].fw_shared_cpu_addr;
> >>>> +                       fw_shared->present_flag_0 = 0;
> >>>> +                       fw_shared->sw_ring.is_enabled = false;
> >>>> +               }
> >>>> +
> >>>> +               drm_dev_exit(idx);
> >>>>           }
> >>>>
> >>>>           if (amdgpu_sriov_vf(adev))
> >>>> --
> >>>> 2.25.1
> >>>>
