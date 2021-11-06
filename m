Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F39B3446C1F
	for <lists+linux-pci@lfdr.de>; Sat,  6 Nov 2021 03:53:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232944AbhKFCzm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 5 Nov 2021 22:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232934AbhKFCzm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 5 Nov 2021 22:55:42 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B89B6C061570
        for <linux-pci@vger.kernel.org>; Fri,  5 Nov 2021 19:53:01 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id g184so9853493pgc.6
        for <linux-pci@vger.kernel.org>; Fri, 05 Nov 2021 19:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=73GtWjAWALXlaJd14hzLfT99BfdUFPXhGAhgbM95CSs=;
        b=Cfo8E4DOsyaKczHmgNCPijHYsCzYtnNE1ExmoNQZMGgRy8kF1Dk8AuydW/2QrHobGZ
         a6oNt0XiytDrNeQmgIm15lXkKB9NnU7onPhwgsEcpDh+oo6kIIWgkUsyMwlwGMr2atL8
         Ij/Havfb2tLHPCKPBcpXyqimeJhl+cYhkqqQYGmtVo3N3FlvSNj6+yvlZGFHCv0f2qdC
         uRI/Nc1NdieC3KR+mB3Zvc/DzWxCs/w1DZtoCoRArXR3gFsVaodK7KBwXC0ITIexEUqj
         Lonn2Rpz5MThpb3x5VNxkWoR8ygh9L5Q3lgJqTo8S8G6K1hDCED8wYI0/bL2OhwUhiWX
         89sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=73GtWjAWALXlaJd14hzLfT99BfdUFPXhGAhgbM95CSs=;
        b=tmddXPiNcXyrczjBcEujjJ4YImUQ+f+mybzSZxrqorArcIVINhIvciKUAQbTLDZqOG
         lrHHCQ5WPmRk8lidiNYwvA/KwA7ZBACTj9mS09XV7UPt052pfnCy2tFaR8xjoxzDvKFs
         C7t6bUOS3sh0cm3yGxx+f/nfYn7/TZ67eZwfTfOVNuX/U++O6ah4BsGEm1tJ1ToahM3D
         aFPntohFZx15S0kafKP/XOq//0ZuP7Md0wQxFtvwliJX3NCAq83qvVxaiUsbmSgAv+N8
         7WUuRdb9s2Y4QTS0UGNKxcOryYcXonUvj8R/bM9DFBwjPh3UG11Mc3ZhhNV2symV1lXK
         LOVQ==
X-Gm-Message-State: AOAM533DNaxwakSYxQdP69ixqzaFQ5zZL8+T/hcVdLxfKr6pFD9wnZ5t
        urYo/O+k6HJTe3kzfxyPmparGHKIxm6WlUWgzozcLcC3ovYAtw==
X-Google-Smtp-Source: ABdhPJze1xz5v2VBKQihystHVnzJQzUWZxufiQzMLNqrpR9Fqy63/2GxXQ0STJPUwpII2dVP8CJZMAPK3yyGUoiMRrI=
X-Received: by 2002:a63:6302:: with SMTP id x2mr30324994pgb.5.1636167180848;
 Fri, 05 Nov 2021 19:53:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210813213653.3760-1-stuart.w.hayes@gmail.com>
 <5d1eb958c13553d70e4bee7a7b342febcf1c02ee.camel@intel.com>
 <4bb26dc0-9b82-21d6-0257-d50ec206a130@gmail.com> <CAPcyv4iig5rxCNb7GyGV9akhZKLF+OeGhewSbOeAzzA6pKreRA@mail.gmail.com>
 <19dcfbea-efcd-b385-4031-23fae5c1c78b@linux.intel.com> <4cb4d599-a146-2219-6c6a-c713f022bd7c@gmail.com>
In-Reply-To: <4cb4d599-a146-2219-6c6a-c713f022bd7c@gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 5 Nov 2021 19:52:49 -0700
Message-ID: <CAPcyv4j_HH+T+Bnhqk_iV-JpemB6D=mXjk14cGMJMitkxrbjJQ@mail.gmail.com>
Subject: Re: [PATCH v3] Add support for PCIe SSD status LED management
To:     stuart hayes <stuart.w.hayes@gmail.com>
Cc:     "Tkaczyk, Mariusz" <mariusz.tkaczyk@linux.intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "kw@linux.com" <kw@linux.com>, "lukas@wunner.de" <lukas@wunner.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        Jej B <James.Bottomley@hansenpartnership.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[ add James and Martin in case they see anything here that collides
with the SES driver ]

On Tue, Nov 2, 2021 at 9:34 AM stuart hayes <stuart.w.hayes@gmail.com> wrote:
>
>
>
> On 10/7/2021 6:32 AM, Tkaczyk, Mariusz wrote:
> > On 06.10.2021 22:15, Dan Williams wrote:
> >>>>> +static struct led_state led_states[] = {
> >>>>> +       { .name = "ok",         .bit = 2 },
> >>>>> +       { .name = "locate",     .bit = 3 },
> >>>>> +       { .name = "failed",     .bit = 4 },
> >>>>> +       { .name = "rebuild",    .bit = 5 },
> >>>>> +       { .name = "pfa",        .bit = 6 },
> >>>>> +       { .name = "hotspare",   .bit = 7 },
> >>>>> +       { .name = "ica",        .bit = 8 },
> >>>>> +       { .name = "ifa",        .bit = 9 },
> >>>>> +       { .name = "invalid",    .bit = 10 },
> >>>>> +       { .name = "disabled",   .bit = 11 },
> >>>>> +};
> >>>> include/linux/enclosure.h has common ABI definitions of industry
> >>>> standard enclosure LED settings. The above looks to be open coding the
> >>>> same?
> >>>>
> >>> The LED states in inluce/linux/enclosure.h aren't exactly the same...
> >>> there are states defined in NPEM/_DSM that aren't defined in
> >>> enclosure.h.  In addition, while the enclosure driver allows "locate" to
> >>> be controlled independently, it looks like it will only allow a single
> >>> state (unsupported/ok/critical/etc) to be active at a time, while the
> >>> NPEM/_DSM allow all of the state bits to be independently set or
> >>> cleared.  Maybe only one of those states would need to be set at a time,
> >>> I don't know, but that would impose a limitation on what NPEM/_DSM can
> >>> do.  I'll take a closer look at this as an alternative to using
> >>> drivers/leds/led-class.c.
> >> Have a look. Maybe Mariusz can weigh in here with his experience with
> >> ledmon with what capabilities ledmon would need from this driver so we
> >> can decide what if any extensions need to be made to the enclosure
> >> infrastructure?
> >
> > Hmm... In ledmon we are expecting one state to be set at the time. So,
> > I would expected from kernel to work the same.
> >
> > Looking into ledmon code, all capabilities from this list could be
> > used[1].
> >
> >  >>>> +       { .name = "ok",         .bit = 2 },
> >  >>>> +       { .name = "locate",     .bit = 3 },
> >  >>>> +       { .name = "failed",     .bit = 4 },
> >  >>>> +       { .name = "rebuild",    .bit = 5 },
> >  >>>> +       { .name = "pfa",        .bit = 6 },
> >  >>>> +       { .name = "hotspare",   .bit = 7 },
> >  >>>> +       { .name = "ica",        .bit = 8 },
> >  >>>> +       { .name = "ifa",        .bit = 9 },
> >
> > [1]https://github.com/intel/ledmon/blob/master/src/ibpi.h#L60
> >
> > Thanks,
> > Mariusz
>
> I've reworked the code so it is an auxiliary driver (to nvme, and
> hopefully cxl and pcieport, but I haven't added that yet), and so it
> registers as an enclosure (instead of using the LED subsystem).
>
> I had no issues with making it an auxiliary driver... that seemed to
> work well, and it looks like it should be easy to add cxl & pcieport
> support.

Cool! Thanks for taking this on.

>
> Instead of making pcieport driver add an auxiliary device, I could make
> this driver check the parent of the NVMe device if it doesn't find the
> NPEM extended capability or _DSM on the NVMe PCIe device itself.  (I
> didn't do that, because (a) it would be taking control of part of a PCIe
> device to which a different driver was attached, and (b) the "invalid"
> state isn't usable if the LED driver is only connected by the nvme driver.)

Caveat a) does not sound too bad to me, but b) does sound unfortunate.

What about a mechanism for a downstream driver to register itself
after the fact with the active NPEM instant in its parent topology? At
least I seem to recall either enclosure or ses linking a block-device
to an enclosure slot.

> The enclosure driver isn't usable as is.  The "status" attribute for an
> enclosure component corresponds to the "status code" in the SES spec (the
> enclosure driver appears to be aligned to the SES spec)... the status code
> is not what's used to to control the drive state indicators in SES--the
> status code is read-only (in the SES spec) and reflects actual hardware
> status, and there are other bits to control the indicators.

What does this mean for the NPEM enabling?

> The enclosure driver currently only creates sysfs attributes for three
> of the state indicators (active, locate, and fault).  So I added seven
> more sysfs attributes for the other indicators (SES seems to support all
> of the NPEM/_DSM indicators other than "invalid").
>
> Below are the patches.  I wanted to post it here before I submit them,
> in case this approach doesn't look good to anyone.

If you want to get early opinions an "RFC" prefix on the submission
helps set the expectations of the implementation maturity. It's also
nicer to see patches with changelogs, but no worries, I'll take a look
at the below.

> I also wonder if a
> better name for this driver might be npem_dsm rather than ssd_leds...

I do think dropping the "SSD" connotation is useful. Either NPEM or
PCIE_EM sound ok to me. No need for the _DSM suffix I think, that's
just an implementation detail that platform firmware can get in the
way. I can also imagine a non-ACPI platform doing a similar override,
but it's all NPEM protocol in the end.

>
> Any feedback is appreciated, thank you!
>
>
> ---------------------------------------------------------
> Patch to add auxiliary device to NVMe driver:
> ---------------------------------------------------------
>
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 456a0e8a5718..d9acb3132f43 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -26,6 +26,7 @@
>   #include <linux/io-64-nonatomic-hi-lo.h>
>   #include <linux/sed-opal.h>
>   #include <linux/pci-p2pdma.h>
> +#include <linux/auxiliary_bus.h>
>
>   #include "trace.h"
>   #include "nvme.h"
> @@ -158,8 +159,38 @@ struct nvme_dev {
>         unsigned int nr_poll_queues;
>
>         bool attrs_added;
> +
> +       /* auxiliary_device for NPEM/_DSM driver for LEDs */
> +       struct auxiliary_device ssd_leds_auxdev;

This auxiliary device needs to be allocated out of line from 'struct
nvme_dev'. The lifetime of 'struct nvme_dev' is shorter than a 'struct
device'. Recall that an auxiliary device embeds a 'struct device', and
a 'struct device' embeds a kobject. The kobject lifetime can be
arbitrarily extended by any random kernel agent taking a reference on
the object. You can likely trigger use after free warnings with this
code if you enable CONFIG_DEBUG_KOBJECT_RELEASE.


>   };
>
> +/*
> + * register auxiliary device for PCIe NPEM/_DSM status LEDs
> + */
> +static void nvme_release_ssd_leds_aux_device(struct device *dev)
> +{

Empty device release method is among the most common bugs that Greg
finds, be sure to fix this up before sending he sees it. The above
suggestion to move the allocation of the device out of line will fix
this up too.

> +}
> +
> +static void nvme_register_ssd_leds_aux_device(struct nvme_dev *dev)
> +{
> +       struct auxiliary_device *adev;
> +       int ret;
> +
> +       adev = &dev->ssd_leds_auxdev;
> +       adev->name = "ssd_leds";
> +       adev->dev.parent = dev->dev;
> +       adev->dev.release = nvme_release_ssd_leds_aux_device;
> +       adev->id = dev->ctrl.instance;
> +
> +       ret = auxiliary_device_init(adev);
> +       if (ret < 0)
> +               return;
> +
> +       ret = auxiliary_device_add(adev);
> +       if (ret)
> +               auxiliary_device_uninit(adev);
> +}
> +
>   static int io_queue_depth_set(const char *val, const struct kernel_param *kp)
>   {
>         return param_set_uint_minmax(val, kp, NVME_PCI_MIN_QUEUE_SIZE,
> @@ -2812,6 +2843,8 @@ static void nvme_reset_work(struct work_struct *work)
>                 nvme_unfreeze(&dev->ctrl);
>         }
>
> +       nvme_register_ssd_leds_aux_device(dev);
> +
>         /*
>          * If only admin queue live, keep it to do further investigation or
>          * recovery.
>
> ---------------------------------------------------------
> Patch to add more LED attributes to the enclosure driver:
> ---------------------------------------------------------
>
> diff --git a/drivers/misc/enclosure.c b/drivers/misc/enclosure.c
> index f950d0155876..95f4f500f4af 100644
> --- a/drivers/misc/enclosure.c
> +++ b/drivers/misc/enclosure.c
> @@ -473,30 +473,6 @@ static const char *const enclosure_type[] = {
>         [ENCLOSURE_COMPONENT_ARRAY_DEVICE] = "array device",
>   };
>
> -static ssize_t get_component_fault(struct device *cdev,
> -                                  struct device_attribute *attr, char *buf)
> -{
> -       struct enclosure_device *edev = to_enclosure_device(cdev->parent);
> -       struct enclosure_component *ecomp = to_enclosure_component(cdev);
> -
> -       if (edev->cb->get_fault)
> -               edev->cb->get_fault(edev, ecomp);
> -       return snprintf(buf, 40, "%d\n", ecomp->fault);
> -}

This conversion to the LED_ATTR_RW() scheme definitely wants to be its
own lead-in cleanup patch with a changelog before adding the new NPEM
attributes. Don't smoosh it all into one patch when you reformat this
into a patch series.

> -
> -static ssize_t set_component_fault(struct device *cdev,
> -                                  struct device_attribute *attr,
> -                                  const char *buf, size_t count)
> -{
> -       struct enclosure_device *edev = to_enclosure_device(cdev->parent);
> -       struct enclosure_component *ecomp = to_enclosure_component(cdev);
> -       int val = simple_strtoul(buf, NULL, 0);
> -
> -       if (edev->cb->set_fault)
> -               edev->cb->set_fault(edev, ecomp, val);
> -       return count;
> -}
> -
>   static ssize_t get_component_status(struct device *cdev,
>                                     struct device_attribute *attr,char *buf)
>   {
> @@ -531,54 +507,6 @@ static ssize_t set_component_status(struct device *cdev,
>                 return -EINVAL;
>   }
>
> -static ssize_t get_component_active(struct device *cdev,
> -                                   struct device_attribute *attr, char *buf)
> -{
> -       struct enclosure_device *edev = to_enclosure_device(cdev->parent);
> -       struct enclosure_component *ecomp = to_enclosure_component(cdev);
> -
> -       if (edev->cb->get_active)
> -               edev->cb->get_active(edev, ecomp);
> -       return snprintf(buf, 40, "%d\n", ecomp->active);
> -}
> -
> -static ssize_t set_component_active(struct device *cdev,
> -                                   struct device_attribute *attr,
> -                                   const char *buf, size_t count)
> -{
> -       struct enclosure_device *edev = to_enclosure_device(cdev->parent);
> -       struct enclosure_component *ecomp = to_enclosure_component(cdev);
> -       int val = simple_strtoul(buf, NULL, 0);
> -
> -       if (edev->cb->set_active)
> -               edev->cb->set_active(edev, ecomp, val);
> -       return count;
> -}
> -
> -static ssize_t get_component_locate(struct device *cdev,
> -                                   struct device_attribute *attr, char *buf)
> -{
> -       struct enclosure_device *edev = to_enclosure_device(cdev->parent);
> -       struct enclosure_component *ecomp = to_enclosure_component(cdev);
> -
> -       if (edev->cb->get_locate)
> -               edev->cb->get_locate(edev, ecomp);
> -       return snprintf(buf, 40, "%d\n", ecomp->locate);
> -}
> -
> -static ssize_t set_component_locate(struct device *cdev,
> -                                   struct device_attribute *attr,
> -                                   const char *buf, size_t count)
> -{
> -       struct enclosure_device *edev = to_enclosure_device(cdev->parent);
> -       struct enclosure_component *ecomp = to_enclosure_component(cdev);
> -       int val = simple_strtoul(buf, NULL, 0);
> -
> -       if (edev->cb->set_locate)
> -               edev->cb->set_locate(edev, ecomp, val);
> -       return count;
> -}
> -
>   static ssize_t get_component_power_status(struct device *cdev,
>                                           struct device_attribute *attr,
>                                           char *buf)
> @@ -641,30 +569,157 @@ static ssize_t get_component_slot(struct device *cdev,
>         return snprintf(buf, 40, "%d\n", slot);
>   }
>
> -static DEVICE_ATTR(fault, S_IRUGO | S_IWUSR, get_component_fault,
> -                   set_component_fault);
> +/*
> + * callbacks for attrs using enum enclosure_component_setting (LEDs)
> + */
> +static ssize_t led_show(struct device *cdev,
> +                       enum enclosure_component_led led,
> +                       char *buf)
> +{
> +       struct enclosure_device *edev = to_enclosure_device(cdev->parent);
> +       struct enclosure_component *ecomp = to_enclosure_component(cdev);
> +
> +       if (edev->cb->get_led)
> +               edev->cb->get_led(edev, ecomp, led);
> +       else
> +               /*
> +                * support old callbacks for fault/active/locate
> +                */
> +               switch (led) {
> +                       case ENCLOSURE_LED_FAULT:
> +                               if (edev->cb->get_fault) {
> +                                       edev->cb->get_fault(edev, ecomp);
> +                                       ecomp->led[led] = ecomp->fault;
> +                               }
> +                               break;
> +                       case ENCLOSURE_LED_ACTIVE:
> +                               if (edev->cb->get_active) {
> +                                       edev->cb->get_active(edev, ecomp);
> +                                       ecomp->led[led] = ecomp->active;
> +                               }
> +                               break;
> +                       case ENCLOSURE_LED_LOCATE:
> +                               if (edev->cb->get_locate) {
> +                                       edev->cb->get_locate(edev, ecomp);
> +                                       ecomp->led[led] = ecomp->locate;
> +                               }
> +                               break;
> +                       default:
> +               }
> +
> +       return snprintf(buf, 40, "%d\n", ecomp->led[led]);
> +}
> +
> +static ssize_t led_set(struct device *cdev,
> +                      enum enclosure_component_led led,
> +                      const char *buf, size_t count)
> +{
> +       struct enclosure_device *edev = to_enclosure_device(cdev->parent);
> +       struct enclosure_component *ecomp = to_enclosure_component(cdev);
> +       int val = simple_strtoul(buf, NULL, 0);
> +
> +       if (edev->cb->set_led)
> +               edev->cb->set_led(edev, ecomp, led, val);
> +       else
> +               /*
> +                * support old callbacks for fault/active/locate
> +                */
> +               switch (led) {
> +                       case ENCLOSURE_LED_FAULT:
> +                               if (edev->cb->set_fault)
> +                                       edev->cb->set_fault(edev, ecomp, val);
> +                               break;
> +                       case ENCLOSURE_LED_ACTIVE:
> +                               if (edev->cb->set_active)
> +                                       edev->cb->set_active(edev, ecomp, val);
> +                               break;
> +                       case ENCLOSURE_LED_LOCATE:
> +                               if (edev->cb->set_locate)
> +                                       edev->cb->set_locate(edev, ecomp, val);
> +                               break;
> +                       default:
> +               }
> +
> +       return count;
> +}
> +
> +#define define_led_rw_attr(name)       \
> +static DEVICE_ATTR(name, 0644, show_##name, set_##name)
> +
> +#define LED_ATTR_RW(led_attr, led)             \
> +static ssize_t show_##led_attr(struct device *cdev,                    \
> +                              struct device_attribute *attr,           \
> +                              char *buf)                               \
> +{                                                                      \
> +       return led_show(cdev, led, buf);                                \
> +}                                                                      \
> +static ssize_t set_##led_attr(struct device *cdev,                     \
> +                             struct device_attribute *attr,            \
> +                             const char *buf, size_t count)            \
> +{                                                                      \
> +       return led_set(cdev, led, buf, count);                          \
> +}                                                                      \
> +define_led_rw_attr(led_attr)
> +
>   static DEVICE_ATTR(status, S_IRUGO | S_IWUSR, get_component_status,
>                    set_component_status);
> -static DEVICE_ATTR(active, S_IRUGO | S_IWUSR, get_component_active,
> -                  set_component_active);
> -static DEVICE_ATTR(locate, S_IRUGO | S_IWUSR, get_component_locate,
> -                  set_component_locate);
>   static DEVICE_ATTR(power_status, S_IRUGO | S_IWUSR, get_component_power_status,
>                    set_component_power_status);
>   static DEVICE_ATTR(type, S_IRUGO, get_component_type, NULL);
>   static DEVICE_ATTR(slot, S_IRUGO, get_component_slot, NULL);
> +LED_ATTR_RW(fault, ENCLOSURE_LED_FAULT);
> +LED_ATTR_RW(active, ENCLOSURE_LED_ACTIVE);
> +LED_ATTR_RW(locate, ENCLOSURE_LED_LOCATE);
> +LED_ATTR_RW(ok, ENCLOSURE_LED_OK);
> +LED_ATTR_RW(rebuild, ENCLOSURE_LED_REBUILD);
> +LED_ATTR_RW(prdfail, ENCLOSURE_LED_PRDFAIL);
> +LED_ATTR_RW(hotspare, ENCLOSURE_LED_HOTSPARE);
> +LED_ATTR_RW(ica, ENCLOSURE_LED_ICA);
> +LED_ATTR_RW(ifa, ENCLOSURE_LED_IFA);
> +LED_ATTR_RW(disabled, ENCLOSURE_LED_DISABLED);
>
>   static struct attribute *enclosure_component_attrs[] = {
>         &dev_attr_fault.attr,
>         &dev_attr_status.attr,
>         &dev_attr_active.attr,
>         &dev_attr_locate.attr,
> +       &dev_attr_ok.attr,
> +       &dev_attr_rebuild.attr,
> +       &dev_attr_prdfail.attr,
> +       &dev_attr_hotspare.attr,
> +       &dev_attr_ica.attr,
> +       &dev_attr_ifa.attr,
> +       &dev_attr_disabled.attr,
>         &dev_attr_power_status.attr,
>         &dev_attr_type.attr,
>         &dev_attr_slot.attr,
>         NULL
>   };
> -ATTRIBUTE_GROUPS(enclosure_component);
> +
> +static umode_t enclosure_component_visible(struct kobject *kobj,
> +                                       struct attribute *a, int n)
> +{
> +       struct device *dev = container_of(kobj, struct device, kobj);
> +       struct enclosure_component *ecomp = to_enclosure_component(dev);
> +
> +       /*
> +        * hide attrs that are only available on array devices
> +        */

Isn't this expanding the ABI for enclosures outside of NPEM? Should
there be a new ENCLOSURE_COMPONENT_NPEM or somesuch?

> +       if (ecomp->type != ENCLOSURE_COMPONENT_ARRAY_DEVICE
> +           && (a == &dev_attr_rebuild.attr
> +               || a == &dev_attr_ok.attr
> +               || a == &dev_attr_hotspare.attr
> +               || a == &dev_attr_ifa.attr
> +               || a == &dev_attr_ica.attr))
> +                       return 0;
> +       return a->mode;
> +}
> +
> +static struct attribute_group enclosure_component_group = {

const?

> +       .attrs = enclosure_component_attrs,
> +       .is_visible = enclosure_component_visible,
> +};
> +__ATTRIBUTE_GROUPS(enclosure_component);
>
>   static int __init enclosure_init(void)
>   {
> diff --git a/include/linux/enclosure.h b/include/linux/enclosure.h
> index 1c630e2c2756..db9dff77e595 100644
> --- a/include/linux/enclosure.h
> +++ b/include/linux/enclosure.h
> @@ -49,6 +49,20 @@ enum enclosure_component_setting {
>         ENCLOSURE_SETTING_BLINK_B_OFF_ON = 7,
>   };
>
> +enum enclosure_component_led {
> +       ENCLOSURE_LED_FAULT,
> +       ENCLOSURE_LED_ACTIVE,
> +       ENCLOSURE_LED_LOCATE,
> +       ENCLOSURE_LED_OK,
> +       ENCLOSURE_LED_REBUILD,
> +       ENCLOSURE_LED_PRDFAIL,
> +       ENCLOSURE_LED_HOTSPARE,
> +       ENCLOSURE_LED_ICA,
> +       ENCLOSURE_LED_IFA,
> +       ENCLOSURE_LED_DISABLED,
> +       ENCLOSURE_LED_MAX,

I didn't quite understand why this needs to be distinct from 'enum
enclosure_status'?

> +};
> +
>   struct enclosure_device;
>   struct enclosure_component;
>   struct enclosure_component_callbacks {
> @@ -72,6 +86,13 @@ struct enclosure_component_callbacks {
>         int (*set_locate)(struct enclosure_device *,
>                           struct enclosure_component *,
>                           enum enclosure_component_setting);
> +       void (*get_led)(struct enclosure_device *,
> +                       struct enclosure_component *,
> +                       enum enclosure_component_led);
> +       int (*set_led)(struct enclosure_device *,
> +                      struct enclosure_component *,
> +                      enum enclosure_component_led,
> +                      enum enclosure_component_setting);
>         void (*get_power_status)(struct enclosure_device *,
>                                  struct enclosure_component *);
>         int (*set_power_status)(struct enclosure_device *,
> @@ -80,7 +101,6 @@ struct enclosure_component_callbacks {
>         int (*show_id)(struct enclosure_device *, char *buf);
>   };
>
> -
>   struct enclosure_component {
>         void *scratch;
>         struct device cdev;
> @@ -90,6 +110,7 @@ struct enclosure_component {
>         int fault;
>         int active;
>         int locate;
> +       int led[ENCLOSURE_LED_MAX];
>         int slot;
>         enum enclosure_status status;
>         int power_status;
>
> ---------------------------------------------------------
> Patch to add LED driver:
> ---------------------------------------------------------
>
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index 85ba901bc11b..e9c3b7f5236b 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -469,6 +469,17 @@ config HISI_HIKEY_USB
>           switching between the dual-role USB-C port and the USB-A host ports
>           using only one USB controller.
>
> +config PCIE_SSD_LEDS
> +       tristate "PCIe SSD status LED support"
> +       depends on ACPI && ENCLOSURE_SERVICES

Let's find a way to gracefully fall back to NPEM-only in the case of
CONFIG_ACPI=n builds. I.e. POWERPC platforms have NPEM but not ACPI.

> +       help
> +         Auxiliary driver for PCIe SSD status LED management as described in
> +         a PCI Firmware Specification, Revision 3.2 ECN.
> +
> +         When enabled, an enclosure device will be created for each device
> +         that hast has the ACPI _DSM method described in the referenced ECN,
> +         to allow control of LED states.
> +
>   source "drivers/misc/c2port/Kconfig"
>   source "drivers/misc/eeprom/Kconfig"
>   source "drivers/misc/cb710/Kconfig"
> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> index a086197af544..8a8cb438a78c 100644
> --- a/drivers/misc/Makefile
> +++ b/drivers/misc/Makefile
> @@ -59,3 +59,4 @@ obj-$(CONFIG_UACCE)           += uacce/
>   obj-$(CONFIG_XILINX_SDFEC)    += xilinx_sdfec.o
>   obj-$(CONFIG_HISI_HIKEY_USB)  += hisi_hikey_usb.o
>   obj-$(CONFIG_HI6421V600_IRQ)  += hi6421v600-irq.o
> +obj-$(CONFIG_PCIE_SSD_LEDS)    += ssd-leds.o
> diff --git a/drivers/misc/ssd-leds.c b/drivers/misc/ssd-leds.c
> new file mode 100644
> index 000000000000..59927ebc8aa4
> --- /dev/null
> +++ b/drivers/misc/ssd-leds.c

I think this belongs in drivers/pci/ and / or drivers/acpi/. I.e the
enumeration code could enumerate either an ACPI auxdev or a PCIE
auxdev and register a separate driver accordingly with a shared NPEM
core for the common bits.

> @@ -0,0 +1,426 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Module to provide LED interfaces for PCIe SSD status LED states, as
> + * defined in the "_DSM additions for PCIe SSD Status LED Management" ECN
> + * to the PCI Firmware Specification Revision 3.2, dated 12 February 2020.
> + *
> + * The "_DSM..." spec is functionally similar to Native PCIe Enclosure
> + * Management, but uses a _DSM ACPI method rather than a PCIe extended
> + * capability.
> + *
> + * Copyright (c) 2021 Dell Inc.
> + *
> + * TODO: Add NPEM support
> + *       Add pcieport & cxl support
> + */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/acpi.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/pci.h>
> +#include <linux/enclosure.h>
> +#include <linux/auxiliary_bus.h>
> +
> +#define DRIVER_NAME    "ssd-leds"
> +#define DRIVER_VERSION "v1.0"
> +
> +/*
> + * NPEM & _DSM use the same state bits
> + */
> +#define        NPEM_STATE_OK           BIT(2)
> +#define        NPEM_STATE_LOCATE       BIT(3)
> +#define        NPEM_STATE_FAILED       BIT(4)
> +#define        NPEM_STATE_REBUILD      BIT(5)
> +#define        NPEM_STATE_PFA          BIT(6)  /* predicted failure analysis */
> +#define        NPEM_STATE_HOTSPARE     BIT(7)
> +#define        NPEM_STATE_ICA          BIT(8)  /* in a critical array */
> +#define        NPEM_STATE_IFA          BIT(9)  /* in a failed array */
> +#define        NPEM_STATE_INVALID      BIT(10)
> +#define        NPEM_STATE_DISABLED     BIT(11)
> +
> +static u32 to_npem_state[ENCLOSURE_LED_MAX];
> +
> +/*
> + * ssd_led_dev->dev could be the drive itself or its PCIe port
> + */
> +struct ssd_led_dev {
> +       struct list_head list;
> +       /* PCI device that has the LED controls */
> +       struct pci_dev *pdev;
> +       /* ops to read/set state (NPEM or _DSM) */
> +       struct drive_status_ops *ops;
> +       /* enclosure device used as sysfs interface for states */
> +       struct enclosure_device *edev;
> +       /* latest written states */
> +       u32 states;
> +       u32 supported_states;
> +};
> +
> +struct drive_status_ops {
> +       int (*get_supported_states)(struct ssd_led_dev *sldev);
> +       int (*get_current_states)(struct ssd_led_dev *sldev, u32 *states);
> +       int (*set_current_states)(struct ssd_led_dev *sldev, u32 states);
> +};
> +
> +static struct mutex drive_status_lock;
> +static struct list_head ssd_led_dev_list;
> +static int ssd_leds_exiting = 0;
> +
> +/*
> + * _DSM LED control
> + */
> +static const guid_t pcie_ssd_leds_dsm_guid =
> +       GUID_INIT(0x5d524d9d, 0xfff9, 0x4d4b,
> +                 0x8c, 0xb7, 0x74, 0x7e, 0xd5, 0x1e, 0x19, 0x4d);
> +
> +#define GET_SUPPORTED_STATES_DSM       0x01
> +#define GET_STATE_DSM                  0x02
> +#define SET_STATE_DSM                  0x03
> +
> +struct ssdleds_dsm_output {
> +       u16 status;
> +       u8 function_specific_err;
> +       u8 vendor_specific_err;
> +       u32 state;
> +};
> +
> +static void dsm_status_err_print(struct pci_dev *pdev,
> +                                struct ssdleds_dsm_output *output)
> +{
> +       switch (output->status) {
> +       case 0:
> +               break;
> +       case 1:
> +               pci_dbg(pdev, "_DSM not supported\n");
> +               break;
> +       case 2:
> +               pci_dbg(pdev, "_DSM invalid input parameters\n");
> +               break;
> +       case 3:
> +               pci_dbg(pdev, "_DSM communication error\n");
> +               break;
> +       case 4:
> +               pci_dbg(pdev, "_DSM function-specific error 0x%x\n",
> +                       output->function_specific_err);
> +               break;
> +       case 5:
> +               pci_dbg(pdev, "_DSM vendor-specific error 0x%x\n",
> +                       output->vendor_specific_err);
> +               break;
> +       default:
> +               pci_dbg(pdev, "_DSM returned unknown status 0x%x\n",
> +                       output->status);
> +       }
> +}
> +
> +static int dsm_set(struct pci_dev *pdev, u32 value)
> +{
> +       acpi_handle handle;
> +       union acpi_object *out_obj, arg3[2];
> +       struct ssdleds_dsm_output *dsm_output;
> +
> +       handle = ACPI_HANDLE(&pdev->dev);
> +       if (!handle)
> +               return -ENODEV;
> +
> +       printk("dsm_set pdev %x:%x.%d value %x\n", pdev->bus->number, PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn), value);
> +
> +       arg3[0].type = ACPI_TYPE_PACKAGE;
> +       arg3[0].package.count = 1;
> +       arg3[0].package.elements = &arg3[1];
> +
> +       arg3[1].type = ACPI_TYPE_BUFFER;
> +       arg3[1].buffer.length = 4;
> +       arg3[1].buffer.pointer = (u8 *)&value;
> +
> +       out_obj = acpi_evaluate_dsm_typed(handle, &pcie_ssd_leds_dsm_guid,
> +                               1, SET_STATE_DSM, &arg3[0], ACPI_TYPE_BUFFER);
> +       if (!out_obj)
> +               return -EIO;
> +
> +       if (out_obj->buffer.length < 8) {
> +               ACPI_FREE(out_obj);
> +               return -EIO;
> +       }
> +
> +       dsm_output = (struct ssdleds_dsm_output *)out_obj->buffer.pointer;
> +
> +       if (dsm_output->status != 0) {
> +               dsm_status_err_print(pdev, dsm_output);
> +               ACPI_FREE(out_obj);
> +               return -EIO;
> +       }
> +       ACPI_FREE(out_obj);
> +       return 0;
> +}
> +
> +static int dsm_get(struct pci_dev *pdev, u64 dsm_func, u32 *output)
> +{
> +       acpi_handle handle;
> +       union acpi_object *out_obj;
> +       struct ssdleds_dsm_output *dsm_output;
> +
> +       handle = ACPI_HANDLE(&pdev->dev);
> +       if (!handle)
> +               return -ENODEV;
> +
> +       printk("dsm_get pdev %x:%x.%d\n", pdev->bus->number, PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn));
> +
> +       out_obj = acpi_evaluate_dsm_typed(handle, &pcie_ssd_leds_dsm_guid, 0x1,
> +                                         dsm_func, NULL, ACPI_TYPE_BUFFER);
> +       if (!out_obj)
> +               return -EIO;
> +
> +       if (out_obj->buffer.length < 8) {
> +               ACPI_FREE(out_obj);
> +               return -EIO;
> +       }
> +
> +       dsm_output = (struct ssdleds_dsm_output *)out_obj->buffer.pointer;
> +       if (dsm_output->status != 0) {
> +               dsm_status_err_print(pdev, dsm_output);
> +               ACPI_FREE(out_obj);
> +               return -EIO;
> +       }
> +
> +       *output = dsm_output->state;
> +       ACPI_FREE(out_obj);
> +       printk("...got %x\n", *output);
> +       return 0;
> +}
> +
> +static int get_supported_states_dsm(struct ssd_led_dev *sldev)
> +{
> +       return dsm_get(sldev->pdev, GET_SUPPORTED_STATES_DSM, &sldev->supported_states);
> +}
> +
> +static int get_current_states_dsm(struct ssd_led_dev *sldev, u32 *states)
> +{
> +       return dsm_get(sldev->pdev, GET_STATE_DSM, states);
> +}
> +
> +static int set_current_states_dsm(struct ssd_led_dev *sldev, u32 states)
> +{
> +       return dsm_set(sldev->pdev, states);
> +}
> +
> +static bool pdev_has_dsm(struct pci_dev *pdev)
> +{
> +       acpi_handle handle = ACPI_HANDLE(&pdev->dev);
> +
> +       if (!handle)
> +               return false;
> +
> +       return acpi_check_dsm(handle, &pcie_ssd_leds_dsm_guid, 0x1,
> +                             1 << GET_SUPPORTED_STATES_DSM ||
> +                             1 << GET_STATE_DSM ||
> +                             1 << SET_STATE_DSM);
> +}
> +
> +static struct drive_status_ops dsm_drive_status_ops = {
> +       .get_supported_states = get_supported_states_dsm,
> +       .get_current_states = get_current_states_dsm,
> +       .set_current_states = set_current_states_dsm,
> +};
> +
> +/*
> + * end of _DSM code
> + */
> +
> +static void ssd_leds_get_led(struct enclosure_device *edev,
> +                            struct enclosure_component *ecomp,
> +                            enum enclosure_component_led led)
> +{
> +       struct ssd_led_dev *sldev = ecomp->scratch;
> +       u32 states = 0;
> +
> +       sldev->ops->get_current_states(sldev, &states);
> +       ecomp->led[led] = !!(states & to_npem_state[led]) ?
> +               ENCLOSURE_SETTING_ENABLED : ENCLOSURE_SETTING_DISABLED;
> +}
> +
> +static int ssd_leds_set_led(struct enclosure_device *edev,
> +                        struct enclosure_component *ecomp,
> +                        enum enclosure_component_led led,
> +                        enum enclosure_component_setting val)
> +{
> +       struct ssd_led_dev *sldev = ecomp->scratch;
> +       u32 npem_state = to_npem_state[led], states;
> +       int rc;
> +
> +       if (val != ENCLOSURE_SETTING_ENABLED
> +           && val != ENCLOSURE_SETTING_DISABLED)
> +               return -EINVAL;
> +
> +       states = sldev->states & ~npem_state;
> +       states |= val == ENCLOSURE_SETTING_ENABLED ? npem_state : 0;
> +
> +       if ((states & sldev->supported_states) != states) {
> +               printk("can't set state %x\n", states);
> +               return -EINVAL;
> +       }
> +
> +       rc = sldev->ops->set_current_states(sldev, states);
> +       /*
> +        * save last written state so it doesn't have to be re-read via NPEM/
> +        * _DSM on the next write, not only because it is faster, but because
> +        * _DSM doesn't provide a way to know if the last write has completed
> +        */
> +       if (rc == 0)
> +               sldev->states = states;
> +       return rc;
> +}
> +
> +static struct enclosure_component_callbacks ssdleds_cb = {
> +       .get_led        = ssd_leds_get_led,
> +       .set_led        = ssd_leds_set_led,
> +};
> +
> +static struct ssd_led_dev *to_ssd_led_dev(struct pci_dev *pdev)
> +{
> +       struct ssd_led_dev *sldev;
> +
> +       list_for_each_entry(sldev, &ssd_led_dev_list, list)
> +               if (pdev == sldev->pdev)
> +                       return sldev;
> +       return NULL;
> +}
> +
> +static void remove_ssd_led_dev(struct ssd_led_dev *sldev)
> +{
> +       enclosure_unregister(sldev->edev);
> +       list_del(&sldev->list);
> +       kfree(sldev);
> +}
> +
> +static int add_ssd_led_dev(struct pci_dev *pdev,
> +                               const char *name,
> +                               struct drive_status_ops *ops)
> +{
> +       struct ssd_led_dev *sldev;
> +       struct enclosure_device *edev;
> +       struct enclosure_component *ecomp;
> +       int rc = 0;
> +
> +       mutex_lock(&drive_status_lock);
> +       if (ssd_leds_exiting)
> +               goto out_unlock;
> +
> +       sldev = kzalloc(sizeof(*sldev), GFP_KERNEL);
> +       if (!sldev) {
> +               rc = -ENOMEM;
> +               goto out_unlock;
> +       }
> +       sldev->pdev = pdev;
> +       sldev->ops = ops;
> +       sldev->states = 0;
> +       INIT_LIST_HEAD(&sldev->list);
> +       if (sldev->ops->get_supported_states(sldev) != 0)
> +               goto out_free;
> +
> +       edev = enclosure_register(&pdev->dev, name, 1, &ssdleds_cb);
> +       if (!edev)
> +               goto out_free;
> +
> +       ecomp = enclosure_component_alloc(edev, 0, ENCLOSURE_COMPONENT_DEVICE, "leds");
> +       if (IS_ERR(ecomp))
> +               goto out_unreg;
> +
> +       ecomp->type = ENCLOSURE_COMPONENT_ARRAY_DEVICE;
> +       rc = enclosure_component_register(ecomp);
> +       if (rc < 0)
> +               goto out_unreg;
> +
> +       ecomp->scratch = sldev;
> +       sldev->edev = edev;
> +       list_add_tail(&sldev->list, &ssd_led_dev_list);

Why not just store sldev in the in the auxdev driver-data. I don't see
a reason for ssd_led_dev_list to exist.

> +       goto out_unlock;
> +
> +out_unreg:
> +       enclosure_unregister(edev);
> +out_free:
> +       kfree(sldev);
> +out_unlock:
> +       mutex_unlock(&drive_status_lock);
> +       return rc;
> +}
> +
> +static int ssd_leds_probe(struct auxiliary_device *adev,
> +                         const struct auxiliary_device_id *id)
> +{
> +       struct pci_dev *pdev = to_pci_dev(adev->dev.parent);
> +
> +       if (pdev_has_dsm(pdev))

This is likely an argument for separate drivers for the NPEM and ACPI
_DSM case, because it should never be the case that the code gets this
far and this check returns false. If this is false the auxdev
shouldn't have been registered in the first instance.

> +               return add_ssd_led_dev(pdev, dev_name(&adev->dev), &dsm_drive_status_ops);
> +       return 0;
> +}
> +
> +static void ssd_leds_remove(struct auxiliary_device *adev)
> +{
> +       struct pci_dev *pdev = to_pci_dev(adev->dev.parent);
> +       struct ssd_led_dev *sldev;
> +
> +       mutex_lock(&drive_status_lock);
> +       sldev = to_ssd_led_dev(pdev);
> +       if (sldev)
> +               remove_ssd_led_dev(sldev);
> +out_unlock:
> +       mutex_unlock(&drive_status_lock);
> +}
> +
> +static const struct auxiliary_device_id ssd_leds_id_table[] = {
> +       { .name = "nvme.ssd_leds", },
> +//     { .name = "pcieport.ssd_leds", },
> +//     { .name = "cxl.ssd_leds", },
> +       {},
> +};
> +
> +MODULE_DEVICE_TABLE(auxiliary, ssd_leds_id_table);
> +
> +static struct auxiliary_driver ssd_leds_driver = {
> +       .name = "ssd_leds",
> +       .probe = ssd_leds_probe,
> +       .remove = ssd_leds_remove,
> +       .id_table = ssd_leds_id_table,
> +};
> +
> +static int __init ssd_leds_init(void)
> +{
> +       mutex_init(&drive_status_lock);
> +       INIT_LIST_HEAD(&ssd_led_dev_list);
> +
> +       to_npem_state[ENCLOSURE_LED_FAULT] = NPEM_STATE_FAILED;
> +       to_npem_state[ENCLOSURE_LED_ACTIVE] = 0;
> +       to_npem_state[ENCLOSURE_LED_LOCATE] = NPEM_STATE_LOCATE;
> +       to_npem_state[ENCLOSURE_LED_OK] = NPEM_STATE_OK;
> +       to_npem_state[ENCLOSURE_LED_REBUILD] = NPEM_STATE_REBUILD;
> +       to_npem_state[ENCLOSURE_LED_PRDFAIL] = NPEM_STATE_PFA;
> +       to_npem_state[ENCLOSURE_LED_HOTSPARE] = NPEM_STATE_HOTSPARE;
> +       to_npem_state[ENCLOSURE_LED_ICA] = NPEM_STATE_ICA;
> +       to_npem_state[ENCLOSURE_LED_IFA] = NPEM_STATE_IFA;
> +       to_npem_state[ENCLOSURE_LED_DISABLED] = NPEM_STATE_DISABLED;
> +
> +       auxiliary_driver_register(&ssd_leds_driver);
> +       return 0;
> +}
> +
> +static void __exit ssd_leds_exit(void)
> +{
> +       struct ssd_led_dev *sldev, *temp;
> +
> +       mutex_lock(&drive_status_lock);
> +       ssd_leds_exiting = 1;
> +       list_for_each_entry_safe(sldev, temp, &ssd_led_dev_list, list)
> +               remove_ssd_led_dev(sldev);
> +       mutex_unlock(&drive_status_lock);
> +       auxiliary_driver_unregister(&ssd_leds_driver);
> +}
> +
> +module_init(ssd_leds_init);
> +module_exit(ssd_leds_exit);
> +
> +MODULE_AUTHOR("Stuart Hayes <stuart.w.hayes@gmail.com>");
> +MODULE_DESCRIPTION("Support for PCIe SSD Status LEDs");
> +MODULE_LICENSE("GPL");
