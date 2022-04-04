Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A93364F1CE2
	for <lists+linux-pci@lfdr.de>; Mon,  4 Apr 2022 23:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382395AbiDDV3c (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Apr 2022 17:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379853AbiDDSSK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Apr 2022 14:18:10 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C2153EA8F
        for <linux-pci@vger.kernel.org>; Mon,  4 Apr 2022 11:16:14 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 2so2334895pjw.2
        for <linux-pci@vger.kernel.org>; Mon, 04 Apr 2022 11:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aZId2gcp4e7uRWUeoN/wi2O4R6KKYYzYuF+W5VbNu0E=;
        b=C0HtoFQ2InO3oQg2qVHi89N0wihVTgwcGFZw31nn4aiTSa1wsZqB+3ZOlCd4IBddeV
         9T6+DXvuWagp5u34Y8vLPxvoGK1fHuXNzA1qCvPF2z6XHvJST/ZX6VYYvZ8YiCqUIssq
         pDr0PQG8fV3Q/dyJyGHR7McGfEvCxlPkGsJWswUJMXQz6jyaT7d6AmtrUSkSNz7TSXLX
         vm0cTgrhRE3syzzlcNte3oArMkqH51Xx3RMvgRhemW1/CCaMS+p+xeYHaxX0G0wjxG1p
         TT1ZkOl8cgl5ewzWAj3Q9EeCu0C7MsOTHEHI/QckpyM9o75Qf384mceoSe7VO5QfChMn
         MlRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aZId2gcp4e7uRWUeoN/wi2O4R6KKYYzYuF+W5VbNu0E=;
        b=BqBHLXDfZtq5fqHelqoZVz7SPG1YlIxBDPNmgtQbjb1o4LdNzQd7UlUF53O0Efkaee
         aJVw0YPK6drmYX+92qoSa8WiFoqhTwPsvwYYeUvAerFfAYAREVJ/9dQCNYOIaJinXgkF
         ukdwgJfeUTvStpWmA74zqaG3MiD7hYnRGOB50j8gtBhGZVwz6fLP6sab5dOvmLhALX95
         V8bHuLFODukQLJHJibdXUyEs/fo9j7lE2yaITZ8z4hhLhDEjTP/1pC9ZYPEX8P6u/Knd
         1xsy3zzNykrMNIVNHB9JJFoM3C9egQQCkVzxQFQZi2XkY6mGCRmyiOaMnAg2cOPxhuA2
         P0Jg==
X-Gm-Message-State: AOAM531LYqQUjJu5bMAsQcDBxRyOrSIAB3Ogfyiw1ieDl4MchM3QgRj3
        ouVT+Pb1gEMT4SrbzefQFgrD8cE1h6W1QUia/40Yjw==
X-Google-Smtp-Source: ABdhPJx6j1Pg3MxMS2E19o2abZ+CeX8qs8j8egUimFsz+9vTChQguK4uSt6rbvCWV9Vp2G3/F+C7L6kc/kQLJtRJDjY=
X-Received: by 2002:a17:90a:ca:b0:1ca:5253:b625 with SMTP id
 v10-20020a17090a00ca00b001ca5253b625mr474110pjd.220.1649096173906; Mon, 04
 Apr 2022 11:16:13 -0700 (PDT)
MIME-Version: 1.0
References: <164894751774.951952.9428402449668442020.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAJZ5v0hGVN_=3iU8OLpHY3Ak35T5+JcBM-qs8SbojKrpd0VXsA@mail.gmail.com>
In-Reply-To: <CAJZ5v0hGVN_=3iU8OLpHY3Ak35T5+JcBM-qs8SbojKrpd0VXsA@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 4 Apr 2022 11:16:03 -0700
Message-ID: <CAPcyv4hCseKbr_XXyeOACYmm0defeSet0LX3YWLKGRnCMS=MFQ@mail.gmail.com>
Subject: Re: [PATCH] cxl/mem: Disable suspend
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-cxl@vger.kernel.org, Linux PCI <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Apr 4, 2022 at 9:00 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Sun, Apr 3, 2022 at 2:58 AM Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > The CXL specification claims S3 support at a hardware level, but at a
> > system software level there are some missing pieces. Section 9.4 rightly
> > claims that "CXL mem adapters may need aux power to retain memory
> > context across S3", but there is no enumeration mechanism for the OS to
> > determine if a given adapter has that support. Moreover the save state
> > and resume image for the system may inadvertantly end up in a CXL device
> > that needs to be restored before the save state is recoverable. I.e. a
> > circular dependency that is not resolvable without a third party
> > save-area.
> >
> > Arrange for the cxl_mem driver to fail S3 attempts. This still nominaly
> > allows for suspend, but requires unbinding all CXL memory devices before
> > the suspend to ensure the typical DRAM flow is taken. The cxl_mem unbind
> > flow is intended to also tear down all CXL memory regions associated
> > with a given cxl_memdev.
> >
> > It is reasonable to assume that any device participating in a System RAM
> > range published in the EFI memory map is covered by aux power and
> > save-area outside the device itself. So this restriction can be
> > minimized in the future once pre-existing region enumeration support
> > arrives, and perhaps a spec update to clarify if the EFI memory is
> > sufficent for determining the range of devices managed by
> > platform-firmware for S3 support.
> >
> > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>
> A few thoughts:
>
> 1. I don't think it is necessary to fail suspend-to-idle too (which
> the driver will do after the patch AFAICS).

Ah true, I missed that this would also disable suspend to idle.

> 2. Should hibernation fail too?  From the description above it looks
> like that should be the case.

Yes, any CXL address range that was provisioned by the OS would need
some off-device save area for the device-state which seems difficult
to support in the general case.

> 3. If "deep"suspend is going to fail every time, it may be better to
> prevent "deep" from being written to /sys/power/mem_sleep instead of
> failing suspend in progress, especially after freezing user space.

Yeah, that sounds much better, let me explore that option.

>
> > ---
> >  drivers/cxl/core/memdev.c |    1 -
> >  drivers/cxl/mem.c         |   26 ++++++++++++++++++++++++++
> >  2 files changed, 26 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> > index 1f76b28f9826..efe4d2e9bfef 100644
> > --- a/drivers/cxl/core/memdev.c
> > +++ b/drivers/cxl/core/memdev.c
> > @@ -251,7 +251,6 @@ static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
> >         dev->bus = &cxl_bus_type;
> >         dev->devt = MKDEV(cxl_mem_major, cxlmd->id);
> >         dev->type = &cxl_memdev_type;
> > -       device_set_pm_not_required(dev);
> >         INIT_WORK(&cxlmd->detach_work, detach_memdev);
> >
> >         cdev = &cxlmd->cdev;
> > diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> > index 49a4b1c47299..0660bb1488cb 100644
> > --- a/drivers/cxl/mem.c
> > +++ b/drivers/cxl/mem.c
> > @@ -3,6 +3,7 @@
> >  #include <linux/device.h>
> >  #include <linux/module.h>
> >  #include <linux/pci.h>
> > +#include <linux/pm.h>
> >
> >  #include "cxlmem.h"
> >  #include "cxlpci.h"
> > @@ -210,10 +211,35 @@ static int cxl_mem_probe(struct device *dev)
> >         return rc;
> >  }
> >
> > +static int cxl_mem_suspend(struct device *dev)
> > +{
> > +       /*
> > +        * The kernel may be operating out of CXL memory on this device,
> > +        * there is no spec defined way to determine whether this device
> > +        * preserves contents over suspend, and there is no simple way
> > +        * to arrange for the suspend image to avoid CXL memory which
> > +        * would setup a circular dependency between PCI resume and save
> > +        * state restoration.
> > +        */
> > +       dev_err(dev, "CXL memory suspend not supported\n");
> > +       return -EBUSY;
> > +}
> > +
> > +static int cxl_mem_resume(struct device *dev)
> > +{
> > +       /* nothing to do since suspend is prevented */
> > +       return 0;
> > +}
>
> This is not needed AFAICS.

Ok, I should have checked, but I'll circle back with sleep state
disabling rather than failing suspend.

Thanks, Rafael.
