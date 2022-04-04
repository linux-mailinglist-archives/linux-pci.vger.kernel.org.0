Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ADE34F1910
	for <lists+linux-pci@lfdr.de>; Mon,  4 Apr 2022 17:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378806AbiDDQBs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Apr 2022 12:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242759AbiDDQBs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Apr 2022 12:01:48 -0400
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E649D245A5;
        Mon,  4 Apr 2022 08:59:51 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-2e5e31c34bfso104471147b3.10;
        Mon, 04 Apr 2022 08:59:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w7ocDMuZoyG16WXF5ipj2JQf4AK4I9deIE3Jm5Bs/xc=;
        b=P/Df+aT0y9hrhXdfv/bPeNgjQqqF6kfMvONu6fRJcBsUA1hRxsve/fckaqkFgBO+vY
         aucQLxNq0AI3yryHtViHsHggd+95t46c4n1r1MtOmI9sD6NS/kdAHRKmaQ46PKLQ9KoL
         dtKxJY8xlKyHnEikzXgYwigBw5yCbPGoKoWjZCL/yNGVf4+Qkge3Z4pFvEAj7aTICltn
         eVs81PTD3UQwJdW57puke/E9qOqHrTQHYxZ0HTxCLbkRy2zKSAYi+brgC0EQiV+h1t11
         G/H9E83nzLCpxiBkAGNZ4dGkvN6lemN/E/hX8/ilrqMNApAuk3wMi6+5oEXF7HSX+N0J
         QhwA==
X-Gm-Message-State: AOAM5327IJT3oa7H8AtR1/w2mr7bXHw4qwdg55vOZswvldOgKD87ldE+
        Q68khFnlXamNCzIcZOoAtjuXwBUec8nJdwqxCwabO+7E
X-Google-Smtp-Source: ABdhPJyM8jOQfNwC1LsuoX5wt2+Tez+WgTblGOwGdMIPsSlhv9ZXF+HmUFRB3Pb+p33UR5vpweNUm7aYvABMhBWTvO0=
X-Received: by 2002:a81:36cf:0:b0:2e5:2597:a026 with SMTP id
 d198-20020a8136cf000000b002e52597a026mr567162ywa.301.1649087991154; Mon, 04
 Apr 2022 08:59:51 -0700 (PDT)
MIME-Version: 1.0
References: <164894751774.951952.9428402449668442020.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <164894751774.951952.9428402449668442020.stgit@dwillia2-desk3.amr.corp.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 4 Apr 2022 17:59:40 +0200
Message-ID: <CAJZ5v0hGVN_=3iU8OLpHY3Ak35T5+JcBM-qs8SbojKrpd0VXsA@mail.gmail.com>
Subject: Re: [PATCH] cxl/mem: Disable suspend
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Apr 3, 2022 at 2:58 AM Dan Williams <dan.j.williams@intel.com> wrote:
>
> The CXL specification claims S3 support at a hardware level, but at a
> system software level there are some missing pieces. Section 9.4 rightly
> claims that "CXL mem adapters may need aux power to retain memory
> context across S3", but there is no enumeration mechanism for the OS to
> determine if a given adapter has that support. Moreover the save state
> and resume image for the system may inadvertantly end up in a CXL device
> that needs to be restored before the save state is recoverable. I.e. a
> circular dependency that is not resolvable without a third party
> save-area.
>
> Arrange for the cxl_mem driver to fail S3 attempts. This still nominaly
> allows for suspend, but requires unbinding all CXL memory devices before
> the suspend to ensure the typical DRAM flow is taken. The cxl_mem unbind
> flow is intended to also tear down all CXL memory regions associated
> with a given cxl_memdev.
>
> It is reasonable to assume that any device participating in a System RAM
> range published in the EFI memory map is covered by aux power and
> save-area outside the device itself. So this restriction can be
> minimized in the future once pre-existing region enumeration support
> arrives, and perhaps a spec update to clarify if the EFI memory is
> sufficent for determining the range of devices managed by
> platform-firmware for S3 support.
>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

A few thoughts:

1. I don't think it is necessary to fail suspend-to-idle too (which
the driver will do after the patch AFAICS).
2. Should hibernation fail too?  From the description above it looks
like that should be the case.
3. If "deep"suspend is going to fail every time, it may be better to
prevent "deep" from being written to /sys/power/mem_sleep instead of
failing suspend in progress, especially after freezing user space.

> ---
>  drivers/cxl/core/memdev.c |    1 -
>  drivers/cxl/mem.c         |   26 ++++++++++++++++++++++++++
>  2 files changed, 26 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 1f76b28f9826..efe4d2e9bfef 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -251,7 +251,6 @@ static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
>         dev->bus = &cxl_bus_type;
>         dev->devt = MKDEV(cxl_mem_major, cxlmd->id);
>         dev->type = &cxl_memdev_type;
> -       device_set_pm_not_required(dev);
>         INIT_WORK(&cxlmd->detach_work, detach_memdev);
>
>         cdev = &cxlmd->cdev;
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 49a4b1c47299..0660bb1488cb 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -3,6 +3,7 @@
>  #include <linux/device.h>
>  #include <linux/module.h>
>  #include <linux/pci.h>
> +#include <linux/pm.h>
>
>  #include "cxlmem.h"
>  #include "cxlpci.h"
> @@ -210,10 +211,35 @@ static int cxl_mem_probe(struct device *dev)
>         return rc;
>  }
>
> +static int cxl_mem_suspend(struct device *dev)
> +{
> +       /*
> +        * The kernel may be operating out of CXL memory on this device,
> +        * there is no spec defined way to determine whether this device
> +        * preserves contents over suspend, and there is no simple way
> +        * to arrange for the suspend image to avoid CXL memory which
> +        * would setup a circular dependency between PCI resume and save
> +        * state restoration.
> +        */
> +       dev_err(dev, "CXL memory suspend not supported\n");
> +       return -EBUSY;
> +}
> +
> +static int cxl_mem_resume(struct device *dev)
> +{
> +       /* nothing to do since suspend is prevented */
> +       return 0;
> +}

This is not needed AFAICS.

> +
> +static DEFINE_SIMPLE_DEV_PM_OPS(cxl_pm_ops, cxl_mem_suspend, cxl_mem_resume);
> +
>  static struct cxl_driver cxl_mem_driver = {
>         .name = "cxl_mem",
>         .probe = cxl_mem_probe,
>         .id = CXL_DEVICE_MEMORY_EXPANDER,
> +       .drv = {
> +               .pm = &cxl_pm_ops,
> +       },
>  };
>
>  module_cxl_driver(cxl_mem_driver);
>
