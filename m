Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 311A932141F
	for <lists+linux-pci@lfdr.de>; Mon, 22 Feb 2021 11:26:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbhBVK0R (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Feb 2021 05:26:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbhBVKZs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 Feb 2021 05:25:48 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C561CC06178B
        for <linux-pci@vger.kernel.org>; Mon, 22 Feb 2021 02:25:07 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id k13so953187otn.13
        for <linux-pci@vger.kernel.org>; Mon, 22 Feb 2021 02:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8PN9lZns7J1+4nVNdLUsP5pZfABQHuCQh40cXC4mRVU=;
        b=JjNqFK4gSzIei693IqlhBwRtfqfVLnXSE7H+WylDNcJ9iWnvn2v5HZQmr66dRaYaR2
         1qy0ofXUQ9Sazr3OTMvKwxsLcc+bhw7lERWk030gGX0TSIV/TOasbs9/DKvt7XoHW5NV
         X+rSaxHg9heK4QU/oT4mD4B0YbNGVJzrPs9c4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8PN9lZns7J1+4nVNdLUsP5pZfABQHuCQh40cXC4mRVU=;
        b=ZeWUCbtB3jH31kBpxkVXpM9D2PSCGSjuwnq52+ErOdrB5BUQUIv5cy55H1fmgcWQht
         VBhh709+bQuuE5yIad5TJOFpOV4L3ETEzpvzqW9FG37da2w/tPiJDZBs5idy2pSCcyea
         UJSFzwHSvkd2z1p4IQGZ0P+JoEiegYyf+kH1Ty4Lq37ZsMwaGPgDGVromnZt/eIZK39j
         g1G2SOsT8C0+Fxc1IqaquNZXhHHWaGWLD81B6042GG9cy0Gpz01J5/qwx41NMmYqGdvR
         nVqVIjJb42zpBMjfFyT2nNshYo7O73mNqO8/Uv2P1lQEpJyWXaImwAHi7n/aMJfP+Rvl
         BdAA==
X-Gm-Message-State: AOAM530wMAwpMcpAUjKWC9NS3HKj5AdZ8o+tmzUdN3P6ZgSQYDPD59Fw
        drXzYDrgmW3cVv8woggkXt3xGs25/Oi+0MnhQB+HWDwteM8=
X-Google-Smtp-Source: ABdhPJz61isp2ETWeXwVtiL//SENHDycgJJ4PyNLSgD/N7s44pHwG+wgblzkTIqc5NrUKKhFiAtR7tjIdciUtZWmuUw=
X-Received: by 2002:a9d:2265:: with SMTP id o92mr16080713ota.188.1613989507244;
 Mon, 22 Feb 2021 02:25:07 -0800 (PST)
MIME-Version: 1.0
References: <YDOGERvNuU3+2WWe@phenom.ffwll.local>
In-Reply-To: <YDOGERvNuU3+2WWe@phenom.ffwll.local>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Mon, 22 Feb 2021 11:24:56 +0100
Message-ID: <CAKMK7uHQ=6OJcRguCUtiB456RWdCfwSNEXV8pQsfsPodTJ6uxw@mail.gmail.com>
Subject: Re: [PULL] fixes around VM_PFNMAP and follow_pfn for 5.12 merge window
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux MM <linux-mm@kvack.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Cc all the mailing lists ... my usual script crashed and I had to
hand-roll the email and screwed it up ofc :-/
-Daniel

On Mon, Feb 22, 2021 at 11:23 AM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> Hi Linus,
>
> Another small pull from you to ponder.
>
> This is the first part of a patch series I've been working on for a while:
>
> https://lore.kernel.org/dri-devel/20201127164131.2244124-1-daniel.vetter@ffwll.ch/
>
> I've stumbled over this for my own learning and then realized there's a
> bunch of races around VM_PFNMAP mappings vs follow pfn.
>
> If you're happy with this then I'll follow up with the media patches to
> mark their leftover use of follow_pfn as unsafe (it's uapi, so unfixable
> issue, all we can do is a config option to harden the kernel). Plus
> hopefully kvm and vfio are then fixed too (you've been on the recent kvm
> thread where this popped up again) so that we can sunset follow_pfn usage
> completely.
>
> The last two patches have only been in linux-next in their current form
> for a week, there was some issue for platforms with HAVE_PCI_LEGACY (not
> that many) which took some sorting out. But looks all good now.
>
> Cheers, Daniel
>
> The following changes since commit 7c53f6b671f4aba70ff15e1b05148b10d58c2837:
>
>   Linux 5.11-rc3 (2021-01-10 14:34:50 -0800)
>
> are available in the Git repository at:
>
>   git://anongit.freedesktop.org/drm/drm tags/topic/iomem-mmap-vs-gup-2021-02-22
>
> for you to fetch changes up to 636b21b50152d4e203223ee337aca1cb3c1bfe53:
>
>   PCI: Revoke mappings like devmem (2021-02-11 15:59:19 +0100)
>
> ----------------------------------------------------------------
> Fixes around VM_FPNMAP and follow_pfn
>
> - replace mm/frame_vector.c by get_user_pages in misc/habana and
>   drm/exynos drivers, then move that into media as it's sole user
> - close race in generic_access_phys
> - s390 pci ioctl fix of this series landed in 5.11 already
> - properly revoke iomem mappings (/dev/mem, pci files)
>
> ----------------------------------------------------------------
> Daniel Vetter (13):
>       drm/exynos: Stop using frame_vector helpers
>       drm/exynos: Use FOLL_LONGTERM for g2d cmdlists
>       misc/habana: Stop using frame_vector helpers
>       misc/habana: Use FOLL_LONGTERM for userptr
>       mm/frame-vector: Use FOLL_LONGTERM
>       media: videobuf2: Move frame_vector into media subsystem
>       mm: Close race in generic_access_phys
>       PCI: Obey iomem restrictions for procfs mmap
>       /dev/mem: Only set filp->f_mapping
>       resource: Move devmem revoke code to resource framework
>       sysfs: Support zapping of binary attr mmaps
>       PCI: Also set up legacy files only after sysfs init
>       PCI: Revoke mappings like devmem
>
>  drivers/char/mem.c                                    | 86 +----------------------------------------------------------------
>  drivers/gpu/drm/exynos/Kconfig                        |  1 -
>  drivers/gpu/drm/exynos/exynos_drm_g2d.c               | 48 ++++++++++++++++---------------------
>  drivers/media/common/videobuf2/Kconfig                |  1 -
>  drivers/media/common/videobuf2/Makefile               |  1 +
>  {mm => drivers/media/common/videobuf2}/frame_vector.c | 55 +++++++++++++++---------------------------
>  drivers/media/common/videobuf2/videobuf2-memops.c     |  3 +--
>  drivers/media/platform/omap/Kconfig                   |  1 -
>  drivers/misc/habanalabs/Kconfig                       |  1 -
>  drivers/misc/habanalabs/common/habanalabs.h           |  6 +++--
>  drivers/misc/habanalabs/common/memory.c               | 52 +++++++++++++++-------------------------
>  drivers/pci/pci-sysfs.c                               | 11 +++++++++
>  drivers/pci/proc.c                                    |  6 +++++
>  fs/sysfs/file.c                                       | 11 +++++++++
>  include/linux/ioport.h                                |  6 +----
>  include/linux/mm.h                                    | 45 ++--------------------------------
>  include/linux/sysfs.h                                 |  2 ++
>  include/media/frame_vector.h                          | 47 ++++++++++++++++++++++++++++++++++++
>  include/media/videobuf2-core.h                        |  1 +
>  kernel/resource.c                                     | 98 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  mm/Kconfig                                            |  3 ---
>  mm/Makefile                                           |  1 -
>  mm/memory.c                                           | 46 ++++++++++++++++++++++++++++++++---
>  23 files changed, 287 insertions(+), 245 deletions(-)
>  rename {mm => drivers/media/common/videobuf2}/frame_vector.c (85%)
>  create mode 100644 include/media/frame_vector.h
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch



-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
