Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23AF34BEA7C
	for <lists+linux-pci@lfdr.de>; Mon, 21 Feb 2022 20:36:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbiBUS1K (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Feb 2022 13:27:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233417AbiBUS0O (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Feb 2022 13:26:14 -0500
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3813ECC2;
        Mon, 21 Feb 2022 10:25:47 -0800 (PST)
Received: by mail-yb1-f174.google.com with SMTP id j12so36110590ybh.8;
        Mon, 21 Feb 2022 10:25:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7CLmQaOvCMcQvV4r2M9aCLErvPDwRMsrYPEB5OYDfvc=;
        b=iy8HeJSDefxQLnZfCP2LG1C6oe72ffBB2czp3u0zvdnYvQRtv1nqeesNQNecXBh0fa
         tK0d3Q2+WNi3kOtedDvWoFJo9w1kZfe73isPYFQIRcun6ynI+mAT3uw/vRyjtwHWFda+
         wbp715Md6A7cf7j/W/y66Akl4slCMT40haNQ52HxUHmfwG25KtXW4ZC/qtBF2F49dLko
         BL7eHw9wW4UWhjWu/6atdeC/VKKM2Oa44Z7+LifS5P48QwREcX3J4QZ46zZVRkN4SXns
         gVlmOuXBShF8HCA2x+MC8DtruH49BvRjIX0qLsaAcg3xwRYwHgkOxh9i1hmNwd4pqn6c
         Pxjw==
X-Gm-Message-State: AOAM5324sQkJpE2hZPD9k0pC5BkE72rnaKKWaVdHzNtywVSyRHS2Vtzs
        hxVCLMdVOjX/ip/cNn6eNXkkvIpdjost4Qs185dLL/Jw
X-Google-Smtp-Source: ABdhPJz2BLZZm12UCagsI9Nu8EUrFQ6j0vK4AqIIHiwAOAIzhxT3kuPGm9cAToahDQj5WulJZFgZ9Rc7VXPxxC1uy98=
X-Received: by 2002:a25:378f:0:b0:61d:8e8b:6cf5 with SMTP id
 e137-20020a25378f000000b0061d8e8b6cf5mr18939628yba.622.1645467946376; Mon, 21
 Feb 2022 10:25:46 -0800 (PST)
MIME-Version: 1.0
References: <20211126070422.73234-1-xueshuai@linux.alibaba.com>
 <20220122052618.1074-1-xueshuai@linux.alibaba.com> <YhPXX+CSoK++9MP6@dev-arch.archlinux-ax161>
In-Reply-To: <YhPXX+CSoK++9MP6@dev-arch.archlinux-ax161>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 21 Feb 2022 19:25:35 +0100
Message-ID: <CAJZ5v0iwpvOMYt-bAAaN86+6+dzWqMRmdZnVqyw8wjhjh1Mp4w@mail.gmail.com>
Subject: Re: [PATCH v7 1/2] ACPI: APEI: explicit init HEST and GHES in apci_init
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Shuai Xue <xueshuai@linux.alibaba.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>, Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        luanshi <zhangliguang@linux.alibaba.com>,
        zhuo.song@linux.alibaba.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux PCI <linux-pci@vger.kernel.org>
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

On Mon, Feb 21, 2022 at 7:18 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> Hi Shuai,
>
> On Sat, Jan 22, 2022 at 01:26:17PM +0800, Shuai Xue wrote:
> > From commit e147133a42cb ("ACPI / APEI: Make hest.c manage the estatus
> > memory pool") was merged, ghes_init() relies on acpi_hest_init() to manage
> > the estatus memory pool. On the other hand, ghes_init() relies on
> > sdei_init() to detect the SDEI version and (un)register events. The
> > dependencies are as follows:
> >
> >     ghes_init() => acpi_hest_init() => acpi_bus_init() => acpi_init()
> >     ghes_init() => sdei_init()
> >
> > HEST is not PCI-specific and initcall ordering is implicit and not
> > well-defined within a level.
> >
> > Based on above, remove acpi_hest_init() from acpi_pci_root_init() and
> > convert ghes_init() and sdei_init() from initcalls to explicit calls in the
> > following order:
> >
> >     acpi_hest_init()
> >     ghes_init()
> >         sdei_init()
> >
> > Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> > ---
> >  drivers/acpi/apei/ghes.c    | 19 ++++++++-----------
> >  drivers/acpi/bus.c          |  2 ++
> >  drivers/acpi/pci_root.c     |  3 ---
> >  drivers/firmware/Kconfig    |  1 +
> >  drivers/firmware/arm_sdei.c | 13 ++-----------
> >  include/acpi/apei.h         |  4 +++-
> >  include/linux/arm_sdei.h    |  2 ++
> >  7 files changed, 18 insertions(+), 26 deletions(-)
> >
> > diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> > index 0c5c9acc6254..aadc0a972f18 100644
> > --- a/drivers/acpi/apei/ghes.c
> > +++ b/drivers/acpi/apei/ghes.c
> > @@ -1457,33 +1457,35 @@ static struct platform_driver ghes_platform_driver = {
> >       .remove         = ghes_remove,
> >  };
> >
> > -static int __init ghes_init(void)
> > +void __init ghes_init(void)
> >  {
> >       int rc;
> >
> > +     sdei_init();
> > +
> >       if (acpi_disabled)
> > -             return -ENODEV;
> > +             return;
> >
> >       switch (hest_disable) {
> >       case HEST_NOT_FOUND:
> > -             return -ENODEV;
> > +             return;
> >       case HEST_DISABLED:
> >               pr_info(GHES_PFX "HEST is not enabled!\n");
> > -             return -EINVAL;
> > +             return;
> >       default:
> >               break;
> >       }
> >
> >       if (ghes_disable) {
> >               pr_info(GHES_PFX "GHES is not enabled!\n");
> > -             return -EINVAL;
> > +             return;
> >       }
> >
> >       ghes_nmi_init_cxt();
> >
> >       rc = platform_driver_register(&ghes_platform_driver);
> >       if (rc)
> > -             goto err;
> > +             return;
> >
> >       rc = apei_osc_setup();
> >       if (rc == 0 && osc_sb_apei_support_acked)
> > @@ -1494,9 +1496,4 @@ static int __init ghes_init(void)
> >               pr_info(GHES_PFX "APEI firmware first mode is enabled by APEI bit.\n");
> >       else
> >               pr_info(GHES_PFX "Failed to enable APEI firmware first mode.\n");
> > -
> > -     return 0;
> > -err:
> > -     return rc;
> >  }
> > -device_initcall(ghes_init);
> > diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> > index 07f604832fd6..3f403db20f69 100644
> > --- a/drivers/acpi/bus.c
> > +++ b/drivers/acpi/bus.c
> > @@ -1331,6 +1331,8 @@ static int __init acpi_init(void)
> >
> >       pci_mmcfg_late_init();
> >       acpi_iort_init();
> > +     acpi_hest_init();
> > +     ghes_init();
> >       acpi_scan_init();
> >       acpi_ec_init();
> >       acpi_debugfs_init();
> > diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> > index b76db99cced3..6f9e75d14808 100644
> > --- a/drivers/acpi/pci_root.c
> > +++ b/drivers/acpi/pci_root.c
> > @@ -22,8 +22,6 @@
> >  #include <linux/slab.h>
> >  #include <linux/dmi.h>
> >  #include <linux/platform_data/x86/apple.h>
> > -#include <acpi/apei.h>       /* for acpi_hest_init() */
> > -
> >  #include "internal.h"
> >
> >  #define ACPI_PCI_ROOT_CLASS          "pci_bridge"
> > @@ -943,7 +941,6 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
> >
> >  void __init acpi_pci_root_init(void)
> >  {
> > -     acpi_hest_init();
> >       if (acpi_pci_disabled)
> >               return;
> >
> > diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
> > index 75cb91055c17..ad114d9cdf8e 100644
> > --- a/drivers/firmware/Kconfig
> > +++ b/drivers/firmware/Kconfig
> > @@ -40,6 +40,7 @@ config ARM_SCPI_POWER_DOMAIN
> >  config ARM_SDE_INTERFACE
> >       bool "ARM Software Delegated Exception Interface (SDEI)"
> >       depends on ARM64
> > +     select ACPI_APEI_GHES
>
> As the kernel test robot pointed out [1], you cannot do this.
> CONFIG_ACPI_APEI_GHES is a user selectable symbol that has dependencies,
> which 'select' completely overrides, resulting in build failures when
> CONFIG_ACPI_APEI is not enabled.
>
> If CONFIG_ARM_SDE_INTERFACE truly requires CONFIG_ACPI_APEI_GHES, you
> should have "depends on ACPI_APEI_GHES".
>
> If CONFIG_ARM_SDE_INTERFACE soft depends on CONFIG_ACPI_APEI_GHES for
> functionality but can work without it, you could use
> "imply ACPI_APEI_GHES", which will enable CONFIG_ACPI_APEI_GHES if its
> dependencies are met.
>
> I noticed the same error with Alpine Linux's aarch64 configuration [2]
> if you wanted a quick configuration to test with.
>
> [1]: https://lore.kernel.org/r/202202151504.jWpZGPaH-lkp@intel.com/
> [2]: https://git.alpinelinux.org/aports/plain/community/linux-edge/config-edge.aarch64

Note that I've dropped these patches from my linux-next branch now.
