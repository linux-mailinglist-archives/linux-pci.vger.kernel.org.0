Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21801383B79
	for <lists+linux-pci@lfdr.de>; Mon, 17 May 2021 19:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236515AbhEQRlQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 May 2021 13:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236416AbhEQRlO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 May 2021 13:41:14 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7909CC061573
        for <linux-pci@vger.kernel.org>; Mon, 17 May 2021 10:39:55 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id o202-20020a4a2cd30000b02901fcaada0306so1639355ooo.7
        for <linux-pci@vger.kernel.org>; Mon, 17 May 2021 10:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ec4sBOvG5BiTPHnGCY0JZake08DLljj+YNJ97mOQNxI=;
        b=cJFsKuMG1megg7WR0JtVZ77rgO/ffhegbh5X5R82OA420QsPebmOqiZLvyIV/RxAEp
         Y8JE/4l4aBgCIpg900VImiB4ZWJMyhV7RZ0Nzinj7pBdv85wH/3dUZ6XqbeSfT+ag7wg
         4YXZM+vRv+vNjSAHnZ4SUReL0e3adUXoRmY58TCglsCdcTDiE7/ekn9klligXN/3wZ8w
         Tr7gruhEwMSI9bf2mceYJyDrthdoZE5Mp92HrAWJoMxJ26kKt7vQjf+BAeh8Mgm4FkRV
         hHpVAe9+lqTJi44a8QFVa1uNx1f62hPpDlKlkzIC6Bn2Q+KpI7hGGkvMAS+Bv/UovQa0
         c8HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ec4sBOvG5BiTPHnGCY0JZake08DLljj+YNJ97mOQNxI=;
        b=JH8EHF6hSyRiW7TFeZcEIIVD39KNaJHnLRPTUN2a0qlA5sRcCTEjqH2HH0ZuMRIZKb
         gKt2RNxy0lVDC/CvrSvY3qh+3zOTCaRzjKIFZU2EUMYOehXCsodc/YPYosLUPSCOi0Fp
         NAYfZewnnMyuMJlZERrRVD2KspsYTVhqhIHj0OQkat74lswxmaOkKehW1GkABJZWn+g8
         GYgY7x3CoozXsrZz+4wyA/YxvMHWe3ZVsoNvvcCcvWTyxoasdLw3UG4mXMFD0SLpMZHI
         FD8Y1btjcFdbfZWLfZ3I7FSYSgGqTeNLZhmTnFUEsf6nsqJgPdKeD9X0TtDN2jnsgNnT
         Ve0g==
X-Gm-Message-State: AOAM531IAhGjBHopGnT0rnQT4ZpEW1/ygKxts/BPkN9Dd4klF1C0AuBl
        rVy/RtpFX9qYGdJLKldm6f2KOBiRiR5ZlQkM72Q=
X-Google-Smtp-Source: ABdhPJybtZDTQ8GQ1qN/+nRmMebD4QN5H/NEF/bDyDqCdi0/ToXU0UgVsyKzKpl515Wbzu2rwaw+uJvK+swGh58kP2I=
X-Received: by 2002:a4a:d004:: with SMTP id h4mr822081oor.90.1621273195376;
 Mon, 17 May 2021 10:39:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210512142648.666476-1-andrey.grodzovsky@amd.com>
 <20210512142648.666476-13-andrey.grodzovsky@amd.com> <0e13e0fb-5cf8-30fa-6ed8-a0648f8fe50b@amd.com>
 <a589044b-8dac-e573-e864-4093e24574a3@amd.com>
In-Reply-To: <a589044b-8dac-e573-e864-4093e24574a3@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 17 May 2021 13:39:44 -0400
Message-ID: <CADnq5_NGL0eBabd8s3yvt6pMYb8w81gE=C7xSGay5Lh9sW08Dw@mail.gmail.com>
Subject: Re: [PATCH v7 12/16] drm/amdgpu: Fix hang on device removal.
To:     Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Cc:     Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        "Wentland, Harry" <Harry.Wentland@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "Kuehling, Felix" <Felix.Kuehling@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Mon, May 17, 2021 at 10:40 AM Andrey Grodzovsky
<andrey.grodzovsky@amd.com> wrote:
>
> Ping
>
> Andrey
>
> On 2021-05-14 10:42 a.m., Andrey Grodzovsky wrote:
> > Ping
> >
> > Andrey
> >
> > On 2021-05-12 10:26 a.m., Andrey Grodzovsky wrote:
> >> If removing while commands in flight you cannot wait to flush the
> >> HW fences on a ring since the device is gone.
> >>
> >> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> >> ---
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 16 ++++++++++------
> >>   1 file changed, 10 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> >> b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> >> index 1ffb36bd0b19..fa03702ecbfb 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> >> @@ -36,6 +36,7 @@
> >>   #include <linux/firmware.h>
> >>   #include <linux/pm_runtime.h>
> >> +#include <drm/drm_drv.h>
> >>   #include "amdgpu.h"
> >>   #include "amdgpu_trace.h"
> >> @@ -525,8 +526,7 @@ int amdgpu_fence_driver_init(struct amdgpu_device
> >> *adev)
> >>    */
> >>   void amdgpu_fence_driver_fini_hw(struct amdgpu_device *adev)
> >>   {
> >> -    unsigned i, j;
> >> -    int r;
> >> +    int i, r;
> >>       for (i = 0; i < AMDGPU_MAX_RINGS; i++) {
> >>           struct amdgpu_ring *ring = adev->rings[i];
> >> @@ -535,11 +535,15 @@ void amdgpu_fence_driver_fini_hw(struct
> >> amdgpu_device *adev)
> >>               continue;
> >>           if (!ring->no_scheduler)
> >>               drm_sched_fini(&ring->sched);
> >> -        r = amdgpu_fence_wait_empty(ring);
> >> -        if (r) {
> >> -            /* no need to trigger GPU reset as we are unloading */
> >> +        /* You can't wait for HW to signal if it's gone */
> >> +        if (!drm_dev_is_unplugged(&adev->ddev))
> >> +            r = amdgpu_fence_wait_empty(ring);
> >> +        else
> >> +            r = -ENODEV;
> >> +        /* no need to trigger GPU reset as we are unloading */
> >> +        if (r)
> >>               amdgpu_fence_driver_force_completion(ring);
> >> -        }
> >> +
> >>           if (ring->fence_drv.irq_src)
> >>               amdgpu_irq_put(adev, ring->fence_drv.irq_src,
> >>                          ring->fence_drv.irq_type);
> >>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
