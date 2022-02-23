Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 464694C0FA1
	for <lists+linux-pci@lfdr.de>; Wed, 23 Feb 2022 10:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239421AbiBWJze (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Feb 2022 04:55:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234327AbiBWJzd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Feb 2022 04:55:33 -0500
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 546075004B;
        Wed, 23 Feb 2022 01:55:06 -0800 (PST)
Received: by mail-vs1-xe30.google.com with SMTP id y4so2488110vsd.11;
        Wed, 23 Feb 2022 01:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xESpIlqylwshhgf0/wvYklxZg/TWVOJPa6Nw972G0rQ=;
        b=dBeT2Mvft8gvdXts2zr4S2+q+1M/Oahxhdnung7mVq26tJL1j2oERA8IDHrKg8ezoV
         PnWid1vNNavAHHztMfYqqehhjQ2PtXvJ5jlmNHosfrJOwOIN91FQVMZQbFVad3z1EZXe
         rl3rU9JRzVvmi55qXf4X+fZOjd1L8YCXP1M6jvxim6s03V2yuBu93DRw3xsw8nAOrRbS
         5p24EdSz7fv4fBlDqv/qMMIAejrhbOnQ3S2ivqXKKMDPO9p86FrUWwGVjWUmTRfLgLw0
         WD6pzvIGEMwr9y8GpRqQVVarfE+uqloPEXHfEICv+Xk3n/MVDJEn3Gj15AhH41oNAmrd
         oyTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xESpIlqylwshhgf0/wvYklxZg/TWVOJPa6Nw972G0rQ=;
        b=KRYb39WWNPyGzxrniLfeP7KdyxSUPh82QaZkSfYuo7SH7YtLdJPb+/wKaXkTRCoGwK
         RaM+eW4kbDA7O6gr0ZFkiUpWJkycNFJXhKvY9OMBppWU0G2pC6qP1YIiOk6bkBjLHTWw
         GiYHoFREApGSqOOYiTisf6NZ0BPQJTm+1I3YbpH5L1ho8k9PAOzRnd6lXoZKe7sqQ8qT
         pKHblAL3KzOcdVpylV3LqJ6+zKBX0TVkEVVVq2NyIWqHHC+M7/Qeo8GNb1/n9EOrwLlq
         T9FVNCjOraa0adG/9sfNk1iApN4M16ylrrPJGMQbL/rihGdAhJVEMxYX/0o+MGW0qC49
         GxIA==
X-Gm-Message-State: AOAM532ea4nvNRzjz+2Dfh/ud6EIYyp+pLNE3L35c6JzSUL595HAnQto
        iVKaQRausuEnQNxOc4V29fTlTVdZq0v+tlu228o6/i3Kf79UfzJN
X-Google-Smtp-Source: ABdhPJxcWY8U1I4kaEFrpnAAV9pnwAerS1BrWSivgDJEIflnconnGztYSrjGObcE0H9ymtzbMgWmSwQuicaef50QWYk=
X-Received: by 2002:a67:f645:0:b0:31b:916e:8d92 with SMTP id
 u5-20020a67f645000000b0031b916e8d92mr12115514vso.72.1645610105224; Wed, 23
 Feb 2022 01:55:05 -0800 (PST)
MIME-Version: 1.0
References: <20220223051545.572235-1-yusisamerican@gmail.com>
In-Reply-To: <20220223051545.572235-1-yusisamerican@gmail.com>
From:   Yusuf Khan <yusisamerican@gmail.com>
Date:   Wed, 23 Feb 2022 01:54:54 -0800
Message-ID: <CAJoG2+9Tp4ZW4tqTVSgp7wukduEFKHiqOXJO-Yn17OwTvn+a+w@mail.gmail.com>
Subject: Re: [PATCH] Removed some usages of the deprecated "pci-dma-compat.h" KPI
To:     linux-kernel@vger.kernel.org
Cc:     linux-pci@vger.kernel.org, tiwai@suse.com, perex@perex.cz,
        alex.bou9@gmail.com, mporter@kernel.crashing.org,
        logang@deltatee.com, kurt.schwemmer@microsemi.com,
        Bjorn Helgaas <bhelgaas@google.com>, kw@linux.com,
        robh@kernel.org, lorenzo.pieralisi@arm.com,
        jonathan.derrick@linux.dev, nirmal.patel@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

See https://lkml.org/lkml/2022/2/23/11 Before you think of this commit!

On Tue, Feb 22, 2022 at 9:15 PM Yusuf Khan <yusisamerican@gmail.com> wrote:
>
> The inspiration for this commit comes from Christophe
> JAILLET in [1], you can find reasons for why this was removed
> linked there. This removes the use of the KPI in some pci
> components and rapidio(whatever that is) devices.
>
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux
> -next.git/patch/?id=ada3caabaf6135150077c3f729bb06e8f3b5b8f6
>
> Signed-off-by: Yusuf Khan <yusisamerican@gmail.com>
> ---
>  drivers/pci/controller/vmd.c     | 1 +
>  drivers/pci/switch/switchtec.c   | 1 +
>  drivers/rapidio/devices/tsi721.c | 8 ++++----
>  sound/pci/asihpi/hpios.c         | 1 +
>  4 files changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index cc166c683638..244dc0f2f71e 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -17,6 +17,7 @@
>  #include <linux/srcu.h>
>  #include <linux/rculist.h>
>  #include <linux/rcupdate.h>
> +#include <linux/dma-mapping.h>
>
>  #include <asm/irqdomain.h>
>
> diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
> index c36c1238c604..05a876ec1463 100644
> --- a/drivers/pci/switch/switchtec.c
> +++ b/drivers/pci/switch/switchtec.c
> @@ -15,6 +15,7 @@
>  #include <linux/wait.h>
>  #include <linux/io-64-nonatomic-lo-hi.h>
>  #include <linux/nospec.h>
> +#include <linux/dma-mapping.h>
>
>  MODULE_DESCRIPTION("Microsemi Switchtec(tm) PCIe Management Driver");
>  MODULE_VERSION("0.1");
> diff --git a/drivers/rapidio/devices/tsi721.c b/drivers/rapidio/devices/tsi721.c
> index 4dd31dd9feea..b3134744fb55 100644
> --- a/drivers/rapidio/devices/tsi721.c
> +++ b/drivers/rapidio/devices/tsi721.c
> @@ -2836,17 +2836,17 @@ static int tsi721_probe(struct pci_dev *pdev,
>         }
>
>         /* Configure DMA attributes. */
> -       if (pci_set_dma_mask(pdev, DMA_BIT_MASK(64))) {
> -               err = pci_set_dma_mask(pdev, DMA_BIT_MASK(32));
> +       if (dma_set_mask(&pdev->dev, DMA_BIT_MASK(64))) {
> +               err = dma_set_mask(&pdev->dev, DMA_BIT_MASK(32));
>                 if (err) {
>                         tsi_err(&pdev->dev, "Unable to set DMA mask");
>                         goto err_unmap_bars;
>                 }
>
> -               if (pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(32)))
> +               if (dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32)))
>                         tsi_info(&pdev->dev, "Unable to set consistent DMA mask");
>         } else {
> -               err = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(64));
> +               err = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(64));
>                 if (err)
>                         tsi_info(&pdev->dev, "Unable to set consistent DMA mask");
>         }
> diff --git a/sound/pci/asihpi/hpios.c b/sound/pci/asihpi/hpios.c
> index 6fe60d13e24b..08757c92aee5 100644
> --- a/sound/pci/asihpi/hpios.c
> +++ b/sound/pci/asihpi/hpios.c
> @@ -10,6 +10,7 @@ HPI Operating System function implementation for Linux
>  (C) Copyright AudioScience Inc. 1997-2003
>  ******************************************************************************/
>  #define SOURCEFILE_NAME "hpios.c"
> +#include <linux/dma-mapping.h>
>  #include "hpi_internal.h"
>  #include "hpidebug.h"
>  #include <linux/delay.h>
> --
> 2.25.1
>
