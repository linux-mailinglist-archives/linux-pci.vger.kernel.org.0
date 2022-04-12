Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7B3E4FEB23
	for <lists+linux-pci@lfdr.de>; Wed, 13 Apr 2022 01:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiDLXoD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Apr 2022 19:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232234AbiDLXnk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Apr 2022 19:43:40 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DAF475C02
        for <linux-pci@vger.kernel.org>; Tue, 12 Apr 2022 16:28:05 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id w20-20020a4ae9f4000000b003243aa2c71aso83966ooc.0
        for <linux-pci@vger.kernel.org>; Tue, 12 Apr 2022 16:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7qLgda0jl4fJo9a34Ft6PXSCgDo4MN7cC6u6Bn0fN1s=;
        b=JxXCDUG6dz8qCfbXlUwEz0x6omM87fluBjEhu5leFU7xXd9jvsDk75FYWHaiHZ9UsZ
         H+sR30OLjTqB5vFJeXDpZJtW1GVX6zutCiA+PXaA9g1pXvngdXEoi4p2Nt+zYfhIjL54
         V2LHmR2kAtKlGJe+fbUkRW/cKZm47mBCHS+ZjsNMAizJgqGC3O4a0ApkOrYiyMFoUuoq
         Qx0LZ3qDrXKZvuKB0OCct5WPq+3ZQQx7eTN5xUum/kejkEV/oz84iJ3MPTqd3jXEjSfY
         meGxtIGx6AbfBCeGXUkw47d1RgTGuwM6MFp52umiKHxewHrSgRwinliEY5epmZmuvqt9
         v8Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7qLgda0jl4fJo9a34Ft6PXSCgDo4MN7cC6u6Bn0fN1s=;
        b=jrMALkIoVcgdVgHoa8t0LfSDJ7BQX/ms30WDtLvHbC7UJU1Ia1f2IDAl+d295YyhAF
         vXyH9K125n/55lTPJJVdo8+osuWAiyCJQpWa/PSqqLr5GxobKQLImOuTQVD1rsFxAMA3
         n0yYHTOqqtoXNVKDllhahoajxMEA0MMFdwMFMVESDNeLjffT66NH5hl4fiMz+oDAarYS
         qghnZcoczUyJZMNieD5Xmx6Sq2Q1967pgDMva3Yrdu+tqj76JWUBq0jsaUIeTDBvbGUB
         Ctz9ZzQqSTQziRLtWPwnFH+sXakIJQFarUk2HXU2536+FQ4P2gMBd6Jq3cEV9cVQSrPR
         ojcw==
X-Gm-Message-State: AOAM5318ZH6/MdZ8QKf5X5/TVWyx92qEQgOd0E1gGfsfjyTRV3jJ+qjk
        S+d1ZKEk1wRTUsP0p8R6SsoUwKg5MwHIEMGYrH9GiryLFsTdwA==
X-Google-Smtp-Source: ABdhPJz9qAenM3p6XtIsB/evarsB6OBVUfdWRWrKwr3f5WJ4zQt3PeKiwqGQnC63657TxKrWmufKmENRqwYVOQ3gCxs=
X-Received: by 2002:a4a:e4c7:0:b0:329:afad:cb2d with SMTP id
 w7-20020a4ae4c7000000b00329afadcb2dmr6831830oov.77.1649806084283; Tue, 12 Apr
 2022 16:28:04 -0700 (PDT)
MIME-Version: 1.0
References: <164894751774.951952.9428402449668442020.stgit@dwillia2-desk3.amr.corp.intel.com>
 <164918880566.2022733.9710638662231385597.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAJZ5v0h8eOWf6fPzBtns-Nxh1jxA931uFQpPwgE_T3yeOoP3rA@mail.gmail.com>
In-Reply-To: <CAJZ5v0h8eOWf6fPzBtns-Nxh1jxA931uFQpPwgE_T3yeOoP3rA@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 12 Apr 2022 16:27:53 -0700
Message-ID: <CAPcyv4j6NoLvbL9rGdbkJX8uV9ZzeCt5rOczsUo1fU8xUX_x9A@mail.gmail.com>
Subject: Re: [PATCH v2] PM: CXL: Disable suspend
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-cxl@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 12, 2022 at 10:02 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Tue, Apr 5, 2022 at 10:00 PM Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > The CXL specification claims S3 support at a hardware level, but at a
> > system software level there are some missing pieces. Section 9.4 (CXL
> > 2.0) rightly claims that "CXL mem adapters may need aux power to retain
> > memory context across S3", but there is no enumeration mechanism for the
> > OS to determine if a given adapter has that support. Moreover the save
> > state and resume image for the system may inadvertantly end up in a CXL
> > device that needs to be restored before the save state is recoverable.
> > I.e. a circular dependency that is not resolvable without a third party
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
> > arrives, and perhaps a spec update to clarify if the EFI memory map is
> > sufficent for determining the range of devices managed by
> > platform-firmware for S3 support.
> >
> > Per Rafael, if the CXL configuration prevents suspend then it should
> > fail early before tasks are frozen, and mem_sleep should stop showing
> > 'mem' as an option [1]. Effectively CXL augments the platform suspend
> > ->valid() op since, for example, the ACPI ops are not aware of the CXL /
> > PCI dependencies. Given the split role of platform firmware vs OS
> > provisioned CXL memory it is up to the cxl_mem driver to determine if
> > the CXL configuration has elements that platform firmware may not be
> > prepared to restore.
> >
> > Link: https://lore.kernel.org/r/CAJZ5v0hGVN_=3iU8OLpHY3Ak35T5+JcBM-qs8SbojKrpd0VXsA@mail.gmail.com [1]
> > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > Cc: Pavel Machek <pavel@ucw.cz>
> > Cc: Len Brown <len.brown@intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>
> The majority of the changes are in the CXL code, so
>
> Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> or please let me know if you want me to take this.

Thanks Rafael, I'll do one more update to return the call to
device_set_pm_not_required() since with this new scheme the CXL
dev_pm_ops are not used. I'll take this through cxl.git.

>
> Thanks!
>
> > ---
> >  drivers/Makefile           |    2 +-
> >  drivers/cxl/Kconfig        |    4 ++++
> >  drivers/cxl/Makefile       |    2 +-
> >  drivers/cxl/core/Makefile  |    1 +
> >  drivers/cxl/core/memdev.c  |    1 -
> >  drivers/cxl/core/suspend.c |   23 +++++++++++++++++++++++
> >  drivers/cxl/cxlmem.h       |   11 +++++++++++
> >  drivers/cxl/mem.c          |   22 +++++++++++++++++++++-
> >  include/linux/pm.h         |    9 +++++++++
> >  kernel/power/hibernate.c   |    2 +-
> >  kernel/power/main.c        |    5 ++++-
> >  kernel/power/suspend.c     |    3 ++-
> >  12 files changed, 78 insertions(+), 7 deletions(-)
> >  create mode 100644 drivers/cxl/core/suspend.c
> >
> > diff --git a/drivers/Makefile b/drivers/Makefile
> > index 020780b6b4d2..f735c4955143 100644
> > --- a/drivers/Makefile
> > +++ b/drivers/Makefile
> > @@ -72,9 +72,9 @@ obj-$(CONFIG_PARPORT)         += parport/
> >  obj-y                          += base/ block/ misc/ mfd/ nfc/
> >  obj-$(CONFIG_LIBNVDIMM)                += nvdimm/
> >  obj-$(CONFIG_DAX)              += dax/
> > -obj-$(CONFIG_CXL_BUS)          += cxl/
> >  obj-$(CONFIG_DMA_SHARED_BUFFER) += dma-buf/
> >  obj-$(CONFIG_NUBUS)            += nubus/
> > +obj-y                          += cxl/
> >  obj-y                          += macintosh/
> >  obj-y                          += scsi/
> >  obj-y                          += nvme/
> > diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> > index b88ab956bb7c..f64e3984689f 100644
> > --- a/drivers/cxl/Kconfig
> > +++ b/drivers/cxl/Kconfig
> > @@ -98,4 +98,8 @@ config CXL_PORT
> >         default CXL_BUS
> >         tristate
> >
> > +config CXL_SUSPEND
> > +       def_bool y
> > +       depends on SUSPEND && CXL_MEM
> > +
> >  endif
> > diff --git a/drivers/cxl/Makefile b/drivers/cxl/Makefile
> > index ce267ef11d93..a78270794150 100644
> > --- a/drivers/cxl/Makefile
> > +++ b/drivers/cxl/Makefile
> > @@ -1,5 +1,5 @@
> >  # SPDX-License-Identifier: GPL-2.0
> > -obj-$(CONFIG_CXL_BUS) += core/
> > +obj-y += core/
> >  obj-$(CONFIG_CXL_PCI) += cxl_pci.o
> >  obj-$(CONFIG_CXL_MEM) += cxl_mem.o
> >  obj-$(CONFIG_CXL_ACPI) += cxl_acpi.o
> > diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
> > index 6d37cd78b151..9d35085d25af 100644
> > --- a/drivers/cxl/core/Makefile
> > +++ b/drivers/cxl/core/Makefile
> > @@ -1,5 +1,6 @@
> >  # SPDX-License-Identifier: GPL-2.0
> >  obj-$(CONFIG_CXL_BUS) += cxl_core.o
> > +obj-$(CONFIG_CXL_SUSPEND) += suspend.o
> >
> >  ccflags-y += -I$(srctree)/drivers/cxl
> >  cxl_core-y := port.o
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
> > diff --git a/drivers/cxl/core/suspend.c b/drivers/cxl/core/suspend.c
> > new file mode 100644
> > index 000000000000..88bdbe30a1df
> > --- /dev/null
> > +++ b/drivers/cxl/core/suspend.c
> > @@ -0,0 +1,23 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/* Copyright(c) 2022 Intel Corporation. All rights reserved. */
> > +#include <linux/atomic.h>
> > +#include <linux/export.h>
> > +
> > +static atomic_t mem_active;
> > +
> > +bool cxl_mem_active(void)
> > +{
> > +       return atomic_read(&mem_active) != 0;
> > +}
> > +
> > +void cxl_mem_active_inc(void)
> > +{
> > +       atomic_inc(&mem_active);
> > +}
> > +EXPORT_SYMBOL_NS_GPL(cxl_mem_active_inc, CXL);
> > +
> > +void cxl_mem_active_dec(void)
> > +{
> > +       atomic_dec(&mem_active);
> > +}
> > +EXPORT_SYMBOL_NS_GPL(cxl_mem_active_dec, CXL);
> > diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> > index 243dd86a8b46..7235d2f976e5 100644
> > --- a/drivers/cxl/cxlmem.h
> > +++ b/drivers/cxl/cxlmem.h
> > @@ -353,6 +353,17 @@ int cxl_mem_create_range_info(struct cxl_dev_state *cxlds);
> >  struct cxl_dev_state *cxl_dev_state_create(struct device *dev);
> >  void set_exclusive_cxl_commands(struct cxl_dev_state *cxlds, unsigned long *cmds);
> >  void clear_exclusive_cxl_commands(struct cxl_dev_state *cxlds, unsigned long *cmds);
> > +#ifdef CONFIG_CXL_SUSPEND
> > +void cxl_mem_active_inc(void);
> > +void cxl_mem_active_dec(void);
> > +#else
> > +static inline void cxl_mem_active_inc(void)
> > +{
> > +}
> > +static inline void cxl_mem_active_dec(void)
> > +{
> > +}
> > +#endif
> >
> >  struct cxl_hdm {
> >         struct cxl_component_regs regs;
> > diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> > index 49a4b1c47299..0576d2d3df07 100644
> > --- a/drivers/cxl/mem.c
> > +++ b/drivers/cxl/mem.c
> > @@ -129,6 +129,11 @@ __mock bool cxl_dvsec_decode_init(struct cxl_dev_state *cxlds)
> >         return do_hdm_init;
> >  }
> >
> > +static void enable_suspend(void *data)
> > +{
> > +       cxl_mem_active_dec();
> > +}
> > +
> >  static int cxl_mem_probe(struct device *dev)
> >  {
> >         struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> > @@ -207,7 +212,22 @@ static int cxl_mem_probe(struct device *dev)
> >  out:
> >         cxl_device_unlock(&parent_port->dev);
> >         put_device(&parent_port->dev);
> > -       return rc;
> > +
> > +       /*
> > +        * The kernel may be operating out of CXL memory on this device,
> > +        * there is no spec defined way to determine whether this device
> > +        * preserves contents over suspend, and there is no simple way
> > +        * to arrange for the suspend image to avoid CXL memory which
> > +        * would setup a circular dependency between PCI resume and save
> > +        * state restoration.
> > +        *
> > +        * TODO: support suspend when all the regions this device is
> > +        * hosting are locked and covered by the system address map,
> > +        * i.e. platform firmware owns restoring the HDM configuration
> > +        * that it locked.
> > +        */
> > +       cxl_mem_active_inc();
> > +       return devm_add_action_or_reset(dev, enable_suspend, NULL);
> >  }
> >
> >  static struct cxl_driver cxl_mem_driver = {
> > diff --git a/include/linux/pm.h b/include/linux/pm.h
> > index e65b3ab28377..7911c4c9a7be 100644
> > --- a/include/linux/pm.h
> > +++ b/include/linux/pm.h
> > @@ -36,6 +36,15 @@ static inline void pm_vt_switch_unregister(struct device *dev)
> >  }
> >  #endif /* CONFIG_VT_CONSOLE_SLEEP */
> >
> > +#ifdef CONFIG_CXL_SUSPEND
> > +bool cxl_mem_active(void);
> > +#else
> > +static inline bool cxl_mem_active(void)
> > +{
> > +       return false;
> > +}
> > +#endif
> > +
> >  /*
> >   * Device power management
> >   */
> > diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> > index 938d5c78b421..20a66bf9f465 100644
> > --- a/kernel/power/hibernate.c
> > +++ b/kernel/power/hibernate.c
> > @@ -83,7 +83,7 @@ bool hibernation_available(void)
> >  {
> >         return nohibernate == 0 &&
> >                 !security_locked_down(LOCKDOWN_HIBERNATION) &&
> > -               !secretmem_active();
> > +               !secretmem_active() && !cxl_mem_active();
> >  }
> >
> >  /**
> > diff --git a/kernel/power/main.c b/kernel/power/main.c
> > index 7e646079fbeb..3e6be1c33e0b 100644
> > --- a/kernel/power/main.c
> > +++ b/kernel/power/main.c
> > @@ -127,7 +127,9 @@ static ssize_t mem_sleep_show(struct kobject *kobj, struct kobj_attribute *attr,
> >         char *s = buf;
> >         suspend_state_t i;
> >
> > -       for (i = PM_SUSPEND_MIN; i < PM_SUSPEND_MAX; i++)
> > +       for (i = PM_SUSPEND_MIN; i < PM_SUSPEND_MAX; i++) {
> > +               if (i >= PM_SUSPEND_MEM && cxl_mem_active())
> > +                       continue;
> >                 if (mem_sleep_states[i]) {
> >                         const char *label = mem_sleep_states[i];
> >
> > @@ -136,6 +138,7 @@ static ssize_t mem_sleep_show(struct kobject *kobj, struct kobj_attribute *attr,
> >                         else
> >                                 s += sprintf(s, "%s ", label);
> >                 }
> > +       }
> >
> >         /* Convert the last space to a newline if needed. */
> >         if (s != buf)
> > diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> > index 6fcdee7e87a5..827075944d28 100644
> > --- a/kernel/power/suspend.c
> > +++ b/kernel/power/suspend.c
> > @@ -236,7 +236,8 @@ EXPORT_SYMBOL_GPL(suspend_valid_only_mem);
> >
> >  static bool sleep_state_supported(suspend_state_t state)
> >  {
> > -       return state == PM_SUSPEND_TO_IDLE || valid_state(state);
> > +       return state == PM_SUSPEND_TO_IDLE ||
> > +              (valid_state(state) && !cxl_mem_active());
> >  }
> >
> >  static int platform_suspend_prepare(suspend_state_t state)
> >
