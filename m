Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36990456A30
	for <lists+linux-pci@lfdr.de>; Fri, 19 Nov 2021 07:26:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbhKSG3Q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Nov 2021 01:29:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbhKSG3Q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Nov 2021 01:29:16 -0500
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF46BC061574;
        Thu, 18 Nov 2021 22:26:14 -0800 (PST)
Received: by mail-ua1-x930.google.com with SMTP id ay21so19124994uab.12;
        Thu, 18 Nov 2021 22:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xp8i7VBjP9J3TedABh9bwwOFEATiZOMWEk9tx+wDLck=;
        b=V50BNKSEsGSxYz9am412TqNrydnwj1UAr+HiNW5ZKmAaHLX0y/gBfWBaL7aODBOr68
         7QZieBYZ6LNlFq2j3yP5/YMnqKurJ2IDc9xW8aegZnFRb7Iydrsk8bIJiIM1hjUYbHSf
         GmQJ9kBU1a6iQp4/SpgNXmDCSxuoNzeS70GjLevHdXYSGDWWpGBQdnMHOm7gDKYd5GzR
         0ml8xfk+kpD8rFIYbnbVoB1fnxkt5msZKkgClI/GfuG35S7a4GywYe4fhns+i/NEet++
         l/Suvx7YQtB8WC9Ynq8Yom6GjJSj3cKlKZRAZX15n+wWUn1hVjHDI0mooI6CccNnUfwU
         v20g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xp8i7VBjP9J3TedABh9bwwOFEATiZOMWEk9tx+wDLck=;
        b=4APDWC7c9MfOijdj2Wh39gd3mohxrIWRz8eMRq0NSoMuF4IYLvpu9qrsWsSdhS7QoZ
         HqSdWEmuxISRYgQn9SVzcf3mdofkqWO09rWN9IORGjJVdmuUAOx5rFMnBqu31KaTcgdq
         IiJmydBfsMgR+H+tEgl4aRwXUcVD2lAMwX4XqMLWUvXDJXP1k01rXUnPdrymzSRXLXDg
         5pvKwBnMh+EgSNSL7mI4UnI0WS4OC2lWfNDj+uDLoIvIlt0Lsfz1Ar1gOlVGEgiKiPN8
         5HeePy2rwvIuoou5IRoCRR6FDSYiJxl8CzkMYJpGXivRDn9c8P3pzgJWEPTKsCgdJ3vl
         sQhA==
X-Gm-Message-State: AOAM530W1XjdqvMGXsoIH7mcdN7XEMzFEg+ZcU3khDiVyilAF/T6Qs+6
        pnHM9l+Uw6qsf9lZhwwcPnOTvExwbrRUxHFG4zw=
X-Google-Smtp-Source: ABdhPJytUTmE8X/Lmlx0vhAlCibzsyXdmkHqIHrCtUYTT9E1+/obR80pZ5UUKWJMExlM9GF6PRS6+1L4MV+UhLZkBaQ=
X-Received: by 2002:ab0:2a8b:: with SMTP id h11mr45965796uar.98.1637303173961;
 Thu, 18 Nov 2021 22:26:13 -0800 (PST)
MIME-Version: 1.0
References: <202111180317.mNAFaXap-lkp@intel.com> <ae386c44-c358-e8c8-ab86-2e27ce72df33@infradead.org>
In-Reply-To: <ae386c44-c358-e8c8-ab86-2e27ce72df33@infradead.org>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Fri, 19 Nov 2021 07:26:02 +0100
Message-ID: <CAMhs-H8TA0S23FjSRKGKeKAWWdUxET6YnivLQoFuy_fSVJOPXw@mail.gmail.com>
Subject: Re: ERROR: modpost: "mips_cm_unlock_other" [drivers/pci/controller/pcie-mt7621.ko]
 undefined!
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Paul Burton <paulburton@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Randy,

On Fri, Nov 19, 2021 at 5:56 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 11/17/21 11:09 AM, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   ee1703cda8dc777e937dec172da55beaf1a74919
> > commit: 2bdd5238e756aac3ecbffc7c22b884485e84062e PCI: mt7621: Add MediaTek MT7621 PCIe host controller driver
> > date:   4 weeks ago
> > config: mips-allmodconfig (attached as .config)
> > compiler: mips-linux-gcc (GCC) 11.2.0
> > reproduce (this is a W=1 build):
> >          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >          chmod +x ~/bin/make.cross
> >          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2bdd5238e756aac3ecbffc7c22b884485e84062e
> >          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> >          git fetch --no-tags linus master
> >          git checkout 2bdd5238e756aac3ecbffc7c22b884485e84062e
> >          # save the attached .config to linux build tree
> >          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross ARCH=mips
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> > All errors (new ones prefixed by >>, old ones prefixed by <<):
> >
> > ERROR: modpost: missing MODULE_LICENSE() in drivers/pci/controller/pcie-mt7621.o
> >>> ERROR: modpost: "mips_cm_unlock_other" [drivers/pci/controller/pcie-mt7621.ko] undefined!
> >>> ERROR: modpost: "mips_cpc_base" [drivers/pci/controller/pcie-mt7621.ko] undefined!
> >>> ERROR: modpost: "mips_cm_lock_other" [drivers/pci/controller/pcie-mt7621.ko] undefined!
> >>> ERROR: modpost: "mips_cm_is64" [drivers/pci/controller/pcie-mt7621.ko] undefined!
> >>> ERROR: modpost: "mips_gcr_base" [drivers/pci/controller/pcie-mt7621.ko] undefined!
>
>
> This is one way to fix these build errors. Is that what the MIPS people
> want to do or should their be APIs to access these base addresses and
> mips_cm_is64 data?

A similar patch was already sent a few weeks ago and Thomas asked for
a different approach [0].
I have sent a patch series removing mips stuff from the driver
controller. This series has not been reviewed yet [1].

[0]: https://lore.kernel.org/linux-mips/CAMhs-H8ShoaYiFOOzJaGC68nZz=V365RXN_Kjuj=fPFENGJiiw@mail.gmail.com/T/#t
[1]: https://marc.info/?l=linux-pci&m=163696011110084&w=3

Best regards,
    Sergio Paracuellos

>
> ---
> From: Randy Dunlap <rdunlap@infradead.org>
> Subject: [PATCH] mips: kernel: export mips-cm and mips-cpc data & functions for pcie-mt7621
>
> Fixes these build errors:
>
> ERROR: modpost: "mips_cm_unlock_other" [drivers/pci/controller/pcie-mt7621.ko] undefined!
> ERROR: modpost: "mips_cpc_base" [drivers/pci/controller/pcie-mt7621.ko] undefined!
> ERROR: modpost: "mips_cm_lock_other" [drivers/pci/controller/pcie-mt7621.ko] undefined!
> ERROR: modpost: "mips_cm_is64" [drivers/pci/controller/pcie-mt7621.ko] undefined!
> ERROR: modpost: "mips_gcr_base" [drivers/pci/controller/pcie-mt7621.ko] undefined!
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Cc: Paul Burton <paulburton@kernel.org>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: linux-mips@vger.kernel.org
> Cc: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org
> ---
>   arch/mips/kernel/mips-cm.c  |    6 ++++++
>   arch/mips/kernel/mips-cpc.c |    2 ++
>   2 files changed, 8 insertions(+)
>
> --- linux-next-20211118.orig/arch/mips/kernel/mips-cm.c
> +++ linux-next-20211118/arch/mips/kernel/mips-cm.c
> @@ -5,6 +5,7 @@
>    */
>
>   #include <linux/errno.h>
> +#include <linux/export.h>
>   #include <linux/percpu.h>
>   #include <linux/spinlock.h>
>
> @@ -12,8 +13,11 @@
>   #include <asm/mipsregs.h>
>
>   void __iomem *mips_gcr_base;
> +EXPORT_SYMBOL(mips_gcr_base);
> +
>   void __iomem *mips_cm_l2sync_base;
>   int mips_cm_is64;
> +EXPORT_SYMBOL(mips_cm_is64);
>
>   static char *cm2_tr[8] = {
>         "mem",  "gcr",  "gic",  "mmio",
> @@ -352,6 +356,7 @@ void mips_cm_lock_other(unsigned int clu
>          */
>         mb();
>   }
> +EXPORT_SYMBOL(mips_cm_lock_other);
>
>   void mips_cm_unlock_other(void)
>   {
> @@ -368,6 +373,7 @@ void mips_cm_unlock_other(void)
>
>         preempt_enable();
>   }
> +EXPORT_SYMBOL(mips_cm_unlock_other);
>
>   void mips_cm_error_report(void)
>   {
> --- linux-next-20211118.orig/arch/mips/kernel/mips-cpc.c
> +++ linux-next-20211118/arch/mips/kernel/mips-cpc.c
> @@ -5,6 +5,7 @@
>    */
>
>   #include <linux/errno.h>
> +#include <linux/export.h>
>   #include <linux/percpu.h>
>   #include <linux/of.h>
>   #include <linux/of_address.h>
> @@ -13,6 +14,7 @@
>   #include <asm/mips-cps.h>
>
>   void __iomem *mips_cpc_base;
> +EXPORT_SYMBOL(mips_cpc_base);
>
>   static DEFINE_PER_CPU_ALIGNED(spinlock_t, cpc_core_lock);
>
>
