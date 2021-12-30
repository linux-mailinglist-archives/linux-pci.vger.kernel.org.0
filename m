Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E116481A7C
	for <lists+linux-pci@lfdr.de>; Thu, 30 Dec 2021 08:46:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233273AbhL3Hq6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Dec 2021 02:46:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231688AbhL3Hq6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Dec 2021 02:46:58 -0500
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D403AC061574
        for <linux-pci@vger.kernel.org>; Wed, 29 Dec 2021 23:46:57 -0800 (PST)
Received: by mail-ua1-x92f.google.com with SMTP id p2so41032428uad.11
        for <linux-pci@vger.kernel.org>; Wed, 29 Dec 2021 23:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P6Nx7pKRfOXxRTDSc5fat2rVIi8irKZ4fTXz3GCHr54=;
        b=BDAiEUW5tNIC/4GAd86omeehgKxD48uR8TmGZGn/iiCiixLroQFa6GcpzDo2kmZb+K
         LbxOHqUTXjNFNvSrmgm299A1WopwPJo3g00imtqEHXsTCIKAH+z9Efj6Y3i27lP/+yBH
         Be6uPZe+gDjyeyFoHkb3nU+a2LiX9fVlrLmNzixpRJVVxGy7WSdk/nkiDWJGcRcucxcK
         /7yX0dnto2qBekZwgPI0XHAI4hjBS8mnuqtoniNsO3EZhlTEd1wBZSsXdoSNlZEpwQwU
         IHsO0z7GWi6zgWijQimya8x6/svceecZhHDDRgx8EotGVHFVW+cXe3E9TRnHe66A8HhQ
         RfYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P6Nx7pKRfOXxRTDSc5fat2rVIi8irKZ4fTXz3GCHr54=;
        b=pRV6bxe3b1aDth3IMejwmwkanI21VK10AbRVGMSGgqnOaWhIayzeePPPRgfoyyVFSl
         9nboauufl3KA0LhK83AUAHFowNg5eL/qAWxZzgack9s8Y6YZZt44mAZJzCfQEMFHAwRl
         3RezZJZgwRlQ4fwmyO4AAxFLI5uILpP+m91F7XB0vF/J5R9dlHviDUQ4vdoSE3fmx5iJ
         HzyzEwxEQjER3yuASwXkLLGSbc08u95CPPhsWN3HQXb8OXQMnwObYxbrDGG5w/RrqgTQ
         Bqhx6rcl9Fr8xlBy17nvTcGvsoWFFoMIrTq/Fgx5MfhbuDhb81Bgb/tEJnTMK7OIaWib
         aSlQ==
X-Gm-Message-State: AOAM5307dExl6P4B/FUhOzbBa55C29VDlb8vbdWnGXQwUWkSJ6uT16V8
        HRUzu/YR+1Av7L//qvceUDjMoFtqvLInRFKKaJbls7ARdoI=
X-Google-Smtp-Source: ABdhPJyyCo2cFRBQb0L9ZLLc77idUgVs/rT6BSBTdxr/nqpqkiJhQgmw5IageaCQOu8a6tiFmF0ymDxKDlGSWOZTZ30=
X-Received: by 2002:a05:6102:38ce:: with SMTP id k14mr9013310vst.70.1640850416912;
 Wed, 29 Dec 2021 23:46:56 -0800 (PST)
MIME-Version: 1.0
References: <20211230054713.1562260-1-weirongguang@kylinos.cn>
In-Reply-To: <20211230054713.1562260-1-weirongguang@kylinos.cn>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Thu, 30 Dec 2021 08:46:45 +0100
Message-ID: <CAMhs-H-79=2v1oS1640HQRmdxQk3rAGi-YXb8A3OLN0Oc33WHw@mail.gmail.com>
Subject: Re: [PATCH] PCI: mt7621: Fix the compile error in cross complication
To:     weirongguang <weirongguang@kylinos.cn>
Cc:     "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi weirongguang,

[+cc linux-pci]

On Thu, Dec 30, 2021 at 6:47 AM weirongguang <weirongguang@kylinos.cn> wrote:

Your subject is a bit generic I think it would be better:

s/Fix the compile error in cross complication/Add missing arch include
'asm/mips-cps.h' to avoid implicit function declarations/

>
> When I was compile the latest kernel in x86 platform and
> the build environment like this:
>
> Compiler: gcc
> Compiler version: 10
> Compiler string: mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110
> Cross-compile: mips-linux-gnu-
>
> It make a compile error:
>
> drivers/pci/controller/pcie-mt7621.c: In function 'setup_cm_memory_region':
> drivers/pci/controller/pcie-mt7621.c:224:6: error: implicit declaration of function 'mips_cps_numiocu' [-Werror=implicit-function-declaration]
>   224 |  if (mips_cps_numiocu(0)) {
>       |      ^~~~~~~~~~~~~~~~
> drivers/pci/controller/pcie-mt7621.c:232:3: error: implicit declaration of function 'write_gcr_reg1_base'; did you mean 'write_gc0_ebase'? [-Werror=implicit-function-declaration]
>   232 |   write_gcr_reg1_base(entry->res->start);
>       |   ^~~~~~~~~~~~~~~~~~~
>       |   write_gc0_ebase
> drivers/pci/controller/pcie-mt7621.c:233:3: error: implicit declaration of function 'write_gcr_reg1_mask'; did you mean 'write_gc0_pagemask'? [-Werror=implicit-function-declaration]
>   233 |   write_gcr_reg1_mask(mask | CM_GCR_REGn_MASK_CMTGT_IOCU0);
>       |   ^~~~~~~~~~~~~~~~~~~
>       |   write_gc0_pagemask
> drivers/pci/controller/pcie-mt7621.c:233:30: error: 'CM_GCR_REGn_MASK_CMTGT_IOCU0' undeclared (first use in this function)
>   233 |   write_gcr_reg1_mask(mask | CM_GCR_REGn_MASK_CMTGT_IOCU0);
>       |                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/pci/controller/pcie-mt7621.c:233:30: note: each undeclared identifier is reported only once for each function it appears in
> In file included from ./include/linux/device.h:15,
>                  from ./include/linux/of_platform.h:9,
>                  from drivers/pci/controller/pcie-mt7621.c:26:
> drivers/pci/controller/pcie-mt7621.c:235:25: error: implicit declaration of function 'read_gcr_reg1_base'; did you mean 'read_gc0_ebase'? [-Werror=implicit-function-declaration]
>   235 |     (unsigned long long)read_gcr_reg1_base(),
>       |                         ^~~~~~~~~~~~~~~~~~
> ./include/linux/dev_printk.h:110:23: note: in definition of macro 'dev_printk_index_wrap'
>   110 |   _p_func(dev, fmt, ##__VA_ARGS__);   \
>       |                       ^~~~~~~~~~~
> drivers/pci/controller/pcie-mt7621.c:234:3: note: in expansion of macro 'dev_info'
>   234 |   dev_info(dev, "PCI coherence region base: 0x%08llx, mask/settings: 0x%08llx\n",
>       |   ^~~~~~~~
> drivers/pci/controller/pcie-mt7621.c:236:25: error: implicit declaration of function 'read_gcr_reg1_mask'; did you mean 'read_gc0_pagemask'? [-Werror=implicit-function-declaration]
>   236 |     (unsigned long long)read_gcr_reg1_mask());
>       |                         ^~~~~~~~~~~~~~~~~~
> ./include/linux/dev_printk.h:110:23: note: in definition of macro 'dev_printk_index_wrap'
>   110 |   _p_func(dev, fmt, ##__VA_ARGS__);   \
>       |                       ^~~~~~~~~~~
> drivers/pci/controller/pcie-mt7621.c:234:3: note: in expansion of macro 'dev_info'
>   234 |   dev_info(dev, "PCI coherence region base: 0x%08llx, mask/settings: 0x%08llx\n",
>       |   ^~~~~~~~
> cc1: all warnings being treated as errors
>
> The problem is that the <asm/mips-cps.h> head file was missing
> and it can resolved when include the file.

True. This include header is not explicitly included because platform
Makefiles seems to add include paths for MIPS. I am using:

mipsel-unknown-linux-gnu-gcc (GCC) 9.4.1 20211208 compiled as:

../configure --target=mipsel-unknown-linux-gnu --prefix=/opt/cross \
    --enable-languages=c --without-headers \
    --with-gnu-ld --with-gnu-as \
    --disable-shared --disable-threads \
    --disable-libmudflap --disable-libgomp \
    --disable-libssp --disable-libquadmath \
    --disable-libatomic

and don't get any warning with normal compilation, but it looks like
other toolchains complain about this and fails if -Werror is set, like
your case here.
This was already reported once by kernel test robot, so I think you
should add 'Reported-by' tag also:

Reported-by: kernel test robot <lkp@intel.com>

I could not find Kernel Test Robot complaining about lore's link but
it was in a randconfig W=1 build using mips64-linux-gcc (GCC) 11.2.0.

IMHO, the correct thing to do is remove architecture specific code
from the driver side. See [0] (I mention this in PATCH 3 of the series
where Reported-by is also added [1]).

>
> Fix: <2bdd5238e756> ("PCI: mt7621: Add MediaTek MT7621 PCIe host controller driver")

This is not the correct way of "Fixes" tag. It should be:

Fixes: 2bdd5238e756 ("PCI: mt7621: Add MediaTek MT7621 PCIe host
controller driver").

> Signed-off-by: weirongguang <weirongguang@kylinos.cn>

I don't know if "weirongguang" is a valid name or not for a
'Signed-off-by' tag, but just in case I mention it. Is this the name
you use to sign documents? (sorry, I don't want to be rude, but I
don't really know the way chinese names should be used in kernel).


> ---
>  drivers/pci/controller/pcie-mt7621.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/pci/controller/pcie-mt7621.c b/drivers/pci/controller/pcie-mt7621.c
> index b60dfb45ef7b..8a009e427a25 100644
> --- a/drivers/pci/controller/pcie-mt7621.c
> +++ b/drivers/pci/controller/pcie-mt7621.c
> @@ -29,6 +29,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/reset.h>
>  #include <linux/sys_soc.h>
> +#include <asm/mips-cps.h>
>
>  /* MediaTek-specific configuration registers */
>  #define PCIE_FTS_NUM                   0x70c
> --
> 2.25.1

As I said, there is a proper approach of removing all the MIPS
specific code from the driver and moving into RALINK platform code
which is the proper place for this arch code here [0]. This should be
material for 5.17. If Lorenzo or Bjorn prefer to add this PATCH
before, you can add my:

Acked-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>

when you submit v2 and I will send a revert when the real fix is added.

[0]: https://lore.kernel.org/linux-pci/20211207104924.21327-1-sergio.paracuellos@gmail.com/
[1]: https://lore.kernel.org/linux-pci/20211207104924.21327-4-sergio.paracuellos@gmail.com/

Best regards,
    Sergio Paracuellos



>
>
> No virus found
>                 Checked by Hillstone Network AntiVirus
