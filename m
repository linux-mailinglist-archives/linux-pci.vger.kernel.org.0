Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB6A14C0F9B
	for <lists+linux-pci@lfdr.de>; Wed, 23 Feb 2022 10:54:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238921AbiBWJyn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Feb 2022 04:54:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234327AbiBWJym (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Feb 2022 04:54:42 -0500
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8AE35004B
        for <linux-pci@vger.kernel.org>; Wed, 23 Feb 2022 01:54:14 -0800 (PST)
Received: by mail-vs1-xe2a.google.com with SMTP id i27so2486774vsr.10
        for <linux-pci@vger.kernel.org>; Wed, 23 Feb 2022 01:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:cc;
        bh=DgAVaGv5JDPGlw2yebHBtUlXSiEF4ELgQii/2e+C5gY=;
        b=SaMnDZKjQHJUGaiOQnVcOO0LABngPRR7AQ4P5v94bboJH1Xhcj5k9JN894npe0i12V
         OJ2AhYdxKsvKZjcC9VYyard5C/BrNjWiRJjOSAWj1kfbGlzqff8sTQQmjDE3oXqUGCHv
         xkv+RhaWmIsTiU7o9E4Bnst5RmBrc0Zbf3QCHHxXfaaIP+W3mLwFIr9pZepS/sKJuhiY
         CMbE7s2U/5SVSXTh8dq7FK2kYmroNkZgObc81Wsy6zbXekXk9f4NYGDM6VYkAeapqyH+
         Y5MsAxDyMcKsYqUw0OgPZQCaP4E2yLpjfz/s0c0lIB4PjsvtCIeSyTwxyGASzftd/pHN
         yKrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:cc;
        bh=DgAVaGv5JDPGlw2yebHBtUlXSiEF4ELgQii/2e+C5gY=;
        b=r+l0ILwctF5/Ubnap15Iyro6r2BbRPBF9Wt8nzef0FdJiislr2EwCWLEpg5CRmstNh
         J1AKpNLQ9k4VozHOUvOEVbnuZTIWZ9XngzdptICycFqN+CX94Vl5zlfS6sWZc4UPSpH+
         uVcs43jYPozARkmUfLFh6mZsD89Qc1AMLHHMrqz9o0N60lEi0RAXwUhymVCMVHzDMOKU
         iEekIEe/LYXZfOkL77yywhf1yqCGvdV8Nv9y0MmyxS1MnGV34/4ulmK8angP6eoKCklE
         fpWtfCu2C+AweqGHvdz3AoLXY1iD+YWuvPctw/ruONzlZhd8hqBaUTXNwkLG2IjTZz/T
         0oNw==
X-Gm-Message-State: AOAM533+puC1iSpg/zbOuWcsBgpYg0Hjvx0e5+mAEkUDYY6LG65F6Bpp
        qEAHuc9M2M0fQ0f0FpZUYPMiF2vzIU29Wp+HuvwFQoPJtVARaeRZ
X-Received: by 2002:a67:c30c:0:b0:31a:d675:fb6f with SMTP id
 r12-20020a67c30c000000b0031ad675fb6fmt12848687vsj.54.1645610053711; Wed, 23
 Feb 2022 01:54:13 -0800 (PST)
MIME-Version: 1.0
References: <20220223095104.2000061-1-yusisamerican@gmail.com>
In-Reply-To: <20220223095104.2000061-1-yusisamerican@gmail.com>
From:   Yusuf Khan <yusisamerican@gmail.com>
Date:   Wed, 23 Feb 2022 01:54:02 -0800
Message-ID: <CAJoG2+8x_dP9EGL-_T=VJPUFC52Pbcz3XAVXrzu0N=afi7CDrw@mail.gmail.com>
Subject: Re: [PATCH 7/7] Finished removing usages of "pci-dma-compat.h" KPI
Cc:     linux-pci@vger.kernel.org, tiwai@suse.com, perex@perex.cz,
        alex.bou9@gmail.com, mporter@kernel.crashing.org,
        logang@deltatee.com, kurt.schwemmer@microsemi.com,
        Bjorn Helgaas <bhelgaas@google.com>, kw@linux.com,
        robh@kernel.org, lorenzo.pieralisi@arm.com,
        jonathan.derrick@linux.dev, nirmal.patel@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,MISSING_HEADERS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This isnt the 7th patch of anything!!!!!!!!! Im such a mess!

On Wed, Feb 23, 2022 at 1:51 AM Yusuf Khan <yusisamerican@gmail.com> wrote:
>
> Im sorry to the kernel maintainers. TLDR; this patch came to early
> and I didnt expect to be working on the kernel at 1 am.
>
> https://lkml.org/lkml/2022/2/23/11 deals with much of the reasons
> of this commit and part of what should have been included here but
> is now included here(ie. this should have been 2 parts). If you
> have the time I plead that you commit that, this and another
> commit removing pci-dma-compat.h, removing the refrence at pci.h
> and replace it with a include to <linux/dma-mapping.h>. If you dont
> have the time to do this then I will do it during the next -rc but
> make sure it compiles finishes just in case(ive compiled the kernel
> 3 times to be sure but you never know). If there are any problems
> with this patch, tell me and ill send a follow up that will fix the
> issues.
>
> Signed-off-by: Yusuf Khan <yusisamerican@gmail.com>
> ---
>  drivers/char/agp/intel-gtt.c           | 23 ++++++++++++-----------
>  drivers/dma/dw/pci.c                   |  1 +
>  drivers/dma/idxd/device.c              |  1 +
>  drivers/dma/ptdma/ptdma-dmaengine.c    |  1 +
>  drivers/fpga/dfl-pci.c                 | 15 +++++----------
>  drivers/media/pci/cx18/cx18-queue.h    |  4 ++--
>  drivers/media/pci/ivtv/ivtv-queue.h    | 22 +++++++++++-----------
>  drivers/media/pci/ivtv/ivtv-udma.h     |  8 ++++----
>  drivers/pci/probe.c                    |  1 +
>  drivers/video/fbdev/hyperv_fb.c        |  1 +
>  drivers/video/fbdev/via/via-core.c     |  1 +
>  drivers/virtio/virtio_pci_legacy_dev.c |  1 +
>  drivers/virtio/virtio_pci_modern_dev.c |  1 +
>  sound/pci/ctxfi/cthw20k1.c             |  1 +
>  sound/pci/ctxfi/cthw20k2.c             |  1 +
>  sound/pci/lx6464es/lx6464es.c          |  1 +
>  16 files changed, 45 insertions(+), 38 deletions(-)
>
> diff --git a/drivers/char/agp/intel-gtt.c b/drivers/char/agp/intel-gtt.c
> index c53cc9868cd8..6d4b1b31e0b2 100644
> --- a/drivers/char/agp/intel-gtt.c
> +++ b/drivers/char/agp/intel-gtt.c
> @@ -15,6 +15,7 @@
>   * /fairy-tale-mode off
>   */
>
> +#include <linux/dma-mapping.h>
>  #include <linux/module.h>
>  #include <linux/pci.h>
>  #include <linux/kernel.h>
> @@ -111,8 +112,8 @@ static int intel_gtt_map_memory(struct page **pages,
>         for_each_sg(st->sgl, sg, num_entries, i)
>                 sg_set_page(sg, pages[i], PAGE_SIZE, 0);
>
> -       if (!pci_map_sg(intel_private.pcidev,
> -                       st->sgl, st->nents, PCI_DMA_BIDIRECTIONAL))
> +       if (!dma_map_sg(&intel_private.pcidev->dev,
> +                       st->sgl, st->nents, DMA_BIDIRECTIONAL))
>                 goto err;
>
>         return 0;
> @@ -127,8 +128,8 @@ static void intel_gtt_unmap_memory(struct scatterlist *sg_list, int num_sg)
>         struct sg_table st;
>         DBG("try unmapping %lu pages\n", (unsigned long)mem->page_count);
>
> -       pci_unmap_sg(intel_private.pcidev, sg_list,
> -                    num_sg, PCI_DMA_BIDIRECTIONAL);
> +       dma_unmap_sg(&intel_private.pcidev->dev, sg_list,
> +                    num_sg, DMA_BIDIRECTIONAL);
>
>         st.sgl = sg_list;
>         st.orig_nents = st.nents = num_sg;
> @@ -303,9 +304,9 @@ static int intel_gtt_setup_scratch_page(void)
>         set_pages_uc(page, 1);
>
>         if (intel_private.needs_dmar) {
> -               dma_addr = pci_map_page(intel_private.pcidev, page, 0,
> -                                   PAGE_SIZE, PCI_DMA_BIDIRECTIONAL);
> -               if (pci_dma_mapping_error(intel_private.pcidev, dma_addr)) {
> +               dma_addr = dma_map_page(&intel_private.pcidev->dev, page, 0,
> +                                   PAGE_SIZE, DMA_BIDIRECTIONAL);
> +               if (dma_mapping_error(&intel_private.pcidev->dev, dma_addr)) {
>                         __free_page(page);
>                         return -EINVAL;
>                 }
> @@ -552,9 +553,9 @@ static void intel_gtt_teardown_scratch_page(void)
>  {
>         set_pages_wb(intel_private.scratch_page, 1);
>         if (intel_private.needs_dmar)
> -               pci_unmap_page(intel_private.pcidev,
> +               dma_unmap_page(&intel_private.pcidev->dev,
>                                intel_private.scratch_page_dma,
> -                              PAGE_SIZE, PCI_DMA_BIDIRECTIONAL);
> +                              PAGE_SIZE, DMA_BIDIRECTIONAL);
>         __free_page(intel_private.scratch_page);
>  }
>
> @@ -1412,12 +1413,12 @@ int intel_gmch_probe(struct pci_dev *bridge_pdev, struct pci_dev *gpu_pdev,
>
>         if (bridge) {
>                 mask = intel_private.driver->dma_mask_size;
> -               if (pci_set_dma_mask(intel_private.pcidev, DMA_BIT_MASK(mask)))
> +               if (dma_set_mask(&intel_private.pcidev->dev, DMA_BIT_MASK(mask)))
>                         dev_err(&intel_private.pcidev->dev,
>                                 "set gfx device dma mask %d-bit failed!\n",
>                                 mask);
>                 else
> -                       pci_set_consistent_dma_mask(intel_private.pcidev,
> +                       dma_set_coherent_mask(&intel_private.pcidev->dev,
>                                                     DMA_BIT_MASK(mask));
>         }
>
> diff --git a/drivers/dma/dw/pci.c b/drivers/dma/dw/pci.c
> index ad2d4d012cf7..eb7b1eecbda5 100644
> --- a/drivers/dma/dw/pci.c
> +++ b/drivers/dma/dw/pci.c
> @@ -6,6 +6,7 @@
>   * Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>   */
>
> +#include <linux/dma-mapping.h>
>  #include <linux/module.h>
>  #include <linux/pci.h>
>  #include <linux/device.h>
> diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
> index 573ad8b86804..d89cac7a671e 100644
> --- a/drivers/dma/idxd/device.c
> +++ b/drivers/dma/idxd/device.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /* Copyright(c) 2019 Intel Corporation. All rights rsvd. */
> +#include <linux/dma-mapping.h>
>  #include <linux/init.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> diff --git a/drivers/dma/ptdma/ptdma-dmaengine.c b/drivers/dma/ptdma/ptdma-dmaengine.c
> index c9e52f6f2f50..45853e3bf147 100644
> --- a/drivers/dma/ptdma/ptdma-dmaengine.c
> +++ b/drivers/dma/ptdma/ptdma-dmaengine.c
> @@ -9,6 +9,7 @@
>   * Author: Gary R Hook <gary.hook@amd.com>
>   */
>
> +#include <linux/dma-mapping.h>
>  #include "ptdma.h"
>  #include "../dmaengine.h"
>  #include "../virt-dma.h"
> diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
> index 4d68719e608f..717ac9715970 100644
> --- a/drivers/fpga/dfl-pci.c
> +++ b/drivers/fpga/dfl-pci.c
> @@ -15,6 +15,7 @@
>   */
>
>  #include <linux/pci.h>
> +#include <linux/dma-mapping.h>
>  #include <linux/types.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> @@ -354,16 +355,10 @@ int cci_pci_probe(struct pci_dev *pcidev, const struct pci_device_id *pcidevid)
>
>         pci_set_master(pcidev);
>
> -       if (!pci_set_dma_mask(pcidev, DMA_BIT_MASK(64))) {
> -               ret = pci_set_consistent_dma_mask(pcidev, DMA_BIT_MASK(64));
> -               if (ret)
> -                       goto disable_error_report_exit;
> -       } else if (!pci_set_dma_mask(pcidev, DMA_BIT_MASK(32))) {
> -               ret = pci_set_consistent_dma_mask(pcidev, DMA_BIT_MASK(32));
> -               if (ret)
> -                       goto disable_error_report_exit;
> -       } else {
> -               ret = -EIO;
> +       ret = dma_set_mask_and_coherent(&pcidev->dev, DMA_BIT_MASK(64));
> +       if (ret)
> +               ret = dma_set_mask_and_coherent(&pcidev->dev, DMA_BIT_MASK(32));
> +       if (ret) {
>                 dev_err(&pcidev->dev, "No suitable DMA support available.\n");
>                 goto disable_error_report_exit;
>         }
> diff --git a/drivers/media/pci/cx18/cx18-queue.h b/drivers/media/pci/cx18/cx18-queue.h
> index e0a34bd6539e..eba5d7de2918 100644
> --- a/drivers/media/pci/cx18/cx18-queue.h
> +++ b/drivers/media/pci/cx18/cx18-queue.h
> @@ -15,14 +15,14 @@
>  static inline void cx18_buf_sync_for_cpu(struct cx18_stream *s,
>         struct cx18_buffer *buf)
>  {
> -       pci_dma_sync_single_for_cpu(s->cx->pci_dev, buf->dma_handle,
> +       dma_sync_single_for_cpu(&s->cx->pci_dev->dev, buf->dma_handle,
>                                 s->buf_size, s->dma);
>  }
>
>  static inline void cx18_buf_sync_for_device(struct cx18_stream *s,
>         struct cx18_buffer *buf)
>  {
> -       pci_dma_sync_single_for_device(s->cx->pci_dev, buf->dma_handle,
> +       dma_sync_single_for_device(&s->cx->pci_dev->dev, buf->dma_handle,
>                                 s->buf_size, s->dma);
>  }
>
> diff --git a/drivers/media/pci/ivtv/ivtv-queue.h b/drivers/media/pci/ivtv/ivtv-queue.h
> index 586b0bf63c26..41f46a575de6 100644
> --- a/drivers/media/pci/ivtv/ivtv-queue.h
> +++ b/drivers/media/pci/ivtv/ivtv-queue.h
> @@ -17,20 +17,20 @@
>
>  static inline int ivtv_might_use_pio(struct ivtv_stream *s)
>  {
> -       return s->dma == PCI_DMA_NONE || (SLICED_VBI_PIO && s->type == IVTV_ENC_STREAM_TYPE_VBI);
> +       return s->dma == DMA_NONE || (SLICED_VBI_PIO && s->type == IVTV_ENC_STREAM_TYPE_VBI);
>  }
>
>  static inline int ivtv_use_pio(struct ivtv_stream *s)
>  {
>         struct ivtv *itv = s->itv;
>
> -       return s->dma == PCI_DMA_NONE ||
> +       return s->dma == DMA_NONE ||
>             (SLICED_VBI_PIO && s->type == IVTV_ENC_STREAM_TYPE_VBI && itv->vbi.sliced_in->service_set);
>  }
>
>  static inline int ivtv_might_use_dma(struct ivtv_stream *s)
>  {
> -       return s->dma != PCI_DMA_NONE;
> +       return s->dma != DMA_NONE;
>  }
>
>  static inline int ivtv_use_dma(struct ivtv_stream *s)
> @@ -41,15 +41,15 @@ static inline int ivtv_use_dma(struct ivtv_stream *s)
>  static inline void ivtv_buf_sync_for_cpu(struct ivtv_stream *s, struct ivtv_buffer *buf)
>  {
>         if (ivtv_use_dma(s))
> -               pci_dma_sync_single_for_cpu(s->itv->pdev, buf->dma_handle,
> -                               s->buf_size + 256, s->dma);
> +               dma_sync_single_for_cpu(&s->itv->pdev->dev, buf->dma_handle,
> +                               s->buf_size + 256, (enum dma_data_direction)s->dma);
>  }
>
>  static inline void ivtv_buf_sync_for_device(struct ivtv_stream *s, struct ivtv_buffer *buf)
>  {
>         if (ivtv_use_dma(s))
> -               pci_dma_sync_single_for_device(s->itv->pdev, buf->dma_handle,
> -                               s->buf_size + 256, s->dma);
> +               dma_sync_single_for_device(&s->itv->pdev->dev, buf->dma_handle,
> +                               s->buf_size + 256, (enum dma_data_direction)s->dma);
>  }
>
>  int ivtv_buf_copy_from_user(struct ivtv_stream *s, struct ivtv_buffer *buf, const char __user *src, int copybytes);
> @@ -70,15 +70,15 @@ void ivtv_stream_free(struct ivtv_stream *s);
>  static inline void ivtv_stream_sync_for_cpu(struct ivtv_stream *s)
>  {
>         if (ivtv_use_dma(s))
> -               pci_dma_sync_single_for_cpu(s->itv->pdev, s->sg_handle,
> -                       sizeof(struct ivtv_sg_element), PCI_DMA_TODEVICE);
> +               dma_sync_single_for_cpu(&s->itv->pdev->dev, s->sg_handle,
> +                       sizeof(struct ivtv_sg_element), DMA_TO_DEVICE);
>  }
>
>  static inline void ivtv_stream_sync_for_device(struct ivtv_stream *s)
>  {
>         if (ivtv_use_dma(s))
> -               pci_dma_sync_single_for_device(s->itv->pdev, s->sg_handle,
> -                       sizeof(struct ivtv_sg_element), PCI_DMA_TODEVICE);
> +               dma_sync_single_for_device(&s->itv->pdev->dev, s->sg_handle,
> +                       sizeof(struct ivtv_sg_element), DMA_TO_DEVICE);
>  }
>
>  #endif
> diff --git a/drivers/media/pci/ivtv/ivtv-udma.h b/drivers/media/pci/ivtv/ivtv-udma.h
> index 0eef104e03b9..7cf9d188cf90 100644
> --- a/drivers/media/pci/ivtv/ivtv-udma.h
> +++ b/drivers/media/pci/ivtv/ivtv-udma.h
> @@ -23,14 +23,14 @@ void ivtv_udma_start(struct ivtv *itv);
>
>  static inline void ivtv_udma_sync_for_device(struct ivtv *itv)
>  {
> -       pci_dma_sync_single_for_device(itv->pdev, itv->udma.SG_handle,
> -               sizeof(itv->udma.SGarray), PCI_DMA_TODEVICE);
> +       dma_sync_single_for_device(&itv->pdev->dev, itv->udma.SG_handle,
> +               sizeof(itv->udma.SGarray), DMA_TO_DEVICE);
>  }
>
>  static inline void ivtv_udma_sync_for_cpu(struct ivtv *itv)
>  {
> -       pci_dma_sync_single_for_cpu(itv->pdev, itv->udma.SG_handle,
> -               sizeof(itv->udma.SGarray), PCI_DMA_TODEVICE);
> +       dma_sync_single_for_cpu(&itv->pdev->dev, itv->udma.SG_handle,
> +               sizeof(itv->udma.SGarray), DMA_TO_DEVICE);
>  }
>
>  #endif
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 17a969942d37..4a4e967ead3d 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -3,6 +3,7 @@
>   * PCI detection and setup code
>   */
>
> +#include <linux/dma-mapping.h>
>  #include <linux/kernel.h>
>  #include <linux/delay.h>
>  #include <linux/init.h>
> diff --git a/drivers/video/fbdev/hyperv_fb.c b/drivers/video/fbdev/hyperv_fb.c
> index c8e0ea27caf1..9af8d3da5e12 100644
> --- a/drivers/video/fbdev/hyperv_fb.c
> +++ b/drivers/video/fbdev/hyperv_fb.c
> @@ -45,6 +45,7 @@
>
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>
> +#include <linux/dma-mapping.h>
>  #include <linux/module.h>
>  #include <linux/kernel.h>
>  #include <linux/vmalloc.h>
> diff --git a/drivers/video/fbdev/via/via-core.c b/drivers/video/fbdev/via/via-core.c
> index 89d75079b730..a04250139ad7 100644
> --- a/drivers/video/fbdev/via/via-core.c
> +++ b/drivers/video/fbdev/via/via-core.c
> @@ -8,6 +8,7 @@
>  /*
>   * Core code for the Via multifunction framebuffer device.
>   */
> +#include <linux/dma-mapping.h>
>  #include <linux/via-core.h>
>  #include <linux/via_i2c.h>
>  #include <linux/via-gpio.h>
> diff --git a/drivers/virtio/virtio_pci_legacy_dev.c b/drivers/virtio/virtio_pci_legacy_dev.c
> index 677d1f68bc9b..f1beb0fc3857 100644
> --- a/drivers/virtio/virtio_pci_legacy_dev.c
> +++ b/drivers/virtio/virtio_pci_legacy_dev.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
>
> +#include <linux/dma-mapping.h>
>  #include "linux/virtio_pci.h"
>  #include <linux/virtio_pci_legacy.h>
>  #include <linux/module.h>
> diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
> index e8b3ff2b9fbc..e96385162d3e 100644
> --- a/drivers/virtio/virtio_pci_modern_dev.c
> +++ b/drivers/virtio/virtio_pci_modern_dev.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
>
> +#include <linux/dma-mapping.h>
>  #include <linux/virtio_pci_modern.h>
>  #include <linux/module.h>
>  #include <linux/pci.h>
> diff --git a/sound/pci/ctxfi/cthw20k1.c b/sound/pci/ctxfi/cthw20k1.c
> index 0cea4982ed7d..c207068e50c0 100644
> --- a/sound/pci/ctxfi/cthw20k1.c
> +++ b/sound/pci/ctxfi/cthw20k1.c
> @@ -11,6 +11,7 @@
>   * @Date       Jun 24 2008
>   */
>
> +#include <linux/dma-mapping.h>
>  #include <linux/types.h>
>  #include <linux/slab.h>
>  #include <linux/pci.h>
> diff --git a/sound/pci/ctxfi/cthw20k2.c b/sound/pci/ctxfi/cthw20k2.c
> index 55af8ef29838..56bd0c8cf705 100644
> --- a/sound/pci/ctxfi/cthw20k2.c
> +++ b/sound/pci/ctxfi/cthw20k2.c
> @@ -11,6 +11,7 @@
>   * @Date       May 14 2008
>   */
>
> +#include <linux/dma-mapping.h>
>  #include <linux/types.h>
>  #include <linux/slab.h>
>  #include <linux/pci.h>
> diff --git a/sound/pci/lx6464es/lx6464es.c b/sound/pci/lx6464es/lx6464es.c
> index 168a1084f730..1dd365b64d3e 100644
> --- a/sound/pci/lx6464es/lx6464es.c
> +++ b/sound/pci/lx6464es/lx6464es.c
> @@ -6,6 +6,7 @@
>   * Copyright (c) 2008, 2009 Tim Blechmann <tim@klingt.org>
>   */
>
> +#include <linux/dma-mapping.h>
>  #include <linux/module.h>
>  #include <linux/init.h>
>  #include <linux/pci.h>
> --
> 2.25.1
>
