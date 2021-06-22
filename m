Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 951423B0D28
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jun 2021 20:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232633AbhFVSsE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Jun 2021 14:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232623AbhFVSsD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Jun 2021 14:48:03 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D6DC061760
        for <linux-pci@vger.kernel.org>; Tue, 22 Jun 2021 11:45:46 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id i1so10577178lfe.6
        for <linux-pci@vger.kernel.org>; Tue, 22 Jun 2021 11:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UmuRYxjET5EALM+FCT07y3AoMfWe7cxAE7p3HDo8x9A=;
        b=VzmzR6LCQB9s+J6u+Ao3+LmOdty+YPR7YmBp3X2hI8TbwEEk/ar3YTRCx9B/LT66Pf
         jBxcuU7PBhl/9joavTTcEIv0KIjyX8MgzBrWkO9OfbjTAjtVXBoq/WACzgfo8D7VRNVU
         GJpB+HdujoRkwmeLlmN3Hika9QSoTAoUhnxau2GtMI4ec0KLiNYWSIyfepWt9b2VdCgY
         lwDvQXxHH5v24ck7fvHS4cFrGgCKG192xepc9KRUfqp6dTOPrbKIj5XeBjR0LGo1JaOQ
         hVNDP5DWzygmDKqUgUnGB5dbYAhKOH4lCEEOrJZKF6+fPmqNS0Gj7tsS5l2mYSnoaSv4
         /1ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UmuRYxjET5EALM+FCT07y3AoMfWe7cxAE7p3HDo8x9A=;
        b=UvFKROEtrKebC75W2n7BhuAIjWwtiaE4cb2waKamkWs3Vo4hWcVzJHvY6lsC9of+za
         BcSzR0pjRGTRSOVVzCavgyHsMp6f7ksSRFggkz3qr7ijOvdWKgeZH847912Q3NFv3Qs0
         EdMhcPUElkaBIDVeaZXJpjo2jjJYt+gM6pYXsFmO4c7RVsBJsiZSjrKNll1QWkXrKp2+
         5HZ9OVDLO7MDYhQ39uXCZO71Fr5wXBWVaZ1MGhqQ/GcPVlqjgtmnIS+vf33QJAtZXWkX
         /avMRgM8Kd4bxbBdmq6v/FD/l7xlwSDEHds1ZAR5JnOorTY3xMKMwy0AvFwZvuzO5aNL
         Ohng==
X-Gm-Message-State: AOAM530fZZFFrj8NKaYx0n9VyBBpGeB1TsQHfCGGXQpZtAX+PN/+TOa0
        w6BGBNkZ8X0AvsXd4a84l1uvQhnCKcPf/MtbyDrHlw==
X-Google-Smtp-Source: ABdhPJz3y5Lck2F4f7THKOpZIcz1XSUJ+0RoljLMYdPiKKLuwBXCT/AqNHBFGoy6ZFXZQT9TlUO8qDUNhaWEm+sp2DE=
X-Received: by 2002:a05:6512:baa:: with SMTP id b42mr3799463lfv.487.1624387544227;
 Tue, 22 Jun 2021 11:45:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210621235248.2521620-1-dianders@chromium.org> <20210621165230.4.Id84a954e705fcad3fdb35beb2bc372e4bf2108c7@changeid>
In-Reply-To: <20210621165230.4.Id84a954e705fcad3fdb35beb2bc372e4bf2108c7@changeid>
From:   Rajat Jain <rajatja@google.com>
Date:   Tue, 22 Jun 2021 11:45:03 -0700
Message-ID: <CACK8Z6EVmnMx4X8ZF7QSm58KCMMAkgSa+S9YkH+mC5RfmeyYoA@mail.gmail.com>
Subject: Re: [PATCH 4/6] iommu: Combine device strictness requests with the
 global default
To:     Douglas Anderson <dianders@chromium.org>
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        rafael.j.wysocki@intel.com, will@kernel.org, robin.murphy@arm.com,
        joro@8bytes.org, bjorn.andersson@linaro.org,
        ulf.hansson@linaro.org, adrian.hunter@intel.com,
        bhelgaas@google.com, robdclark@chromium.org,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        quic_c_gdjako@quicinc.com, iommu@lists.linux-foundation.org,
        sonnyrao@chromium.org, saiprakash.ranjan@codeaurora.org,
        linux-mmc@vger.kernel.org, vbadigan@codeaurora.org,
        saravanak@google.com, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 21, 2021 at 4:53 PM Douglas Anderson <dianders@chromium.org> wrote:
>
> In the patch ("drivers: base: Add bits to struct device to control
> iommu strictness") we add the ability for devices to tell us about
> their IOMMU strictness requirements. Let's now take that into account
> in the IOMMU layer.
>
> A few notes here:
> * Presumably this is always how iommu_get_dma_strict() was intended to
>   behave. Had this not been the intention then it never would have
>   taken a domain as a parameter.
> * The iommu_set_dma_strict() feels awfully non-symmetric now. That
>   function sets the _default_ strictness globally in the system
>   whereas iommu_get_dma_strict() returns the value for a given domain
>   (falling back to the default). Presumably, at least, the fact that
>   iommu_set_dma_strict() doesn't take a domain makes this obvious.
>
> The function iommu_get_dma_strict() should now make it super obvious
> where strictness comes from and who overides who. Though the function
> changed a bunch to make the logic clearer, the only two new rules
> should be:
> * Devices can force strictness for themselves, overriding the cmdline
>   "iommu.strict=0" or a call to iommu_set_dma_strict(false)).
> * Devices can request non-strictness for themselves, assuming there
>   was no cmdline "iommu.strict=1" or a call to
>   iommu_set_dma_strict(true).

Along the same lines, I believe a platform (device tree / ACPI) should
also be able to have a say in this. I assume in your proposal, a
platform would expose a property in device tree which the device
driver would need to parse and then use it to set these bits in the
"struct device"?

Thanks,

Rajat



>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
>  drivers/iommu/iommu.c | 56 +++++++++++++++++++++++++++++++++----------
>  include/linux/iommu.h |  2 ++
>  2 files changed, 45 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 808ab70d5df5..0c84a4c06110 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -28,8 +28,19 @@
>  static struct kset *iommu_group_kset;
>  static DEFINE_IDA(iommu_group_ida);
>
> +enum iommu_strictness {
> +       IOMMU_DEFAULT_STRICTNESS = -1,
> +       IOMMU_NOT_STRICT = 0,
> +       IOMMU_STRICT = 1,
> +};
> +static inline enum iommu_strictness bool_to_strictness(bool strictness)
> +{
> +       return (enum iommu_strictness)strictness;
> +}
> +
>  static unsigned int iommu_def_domain_type __read_mostly;
> -static bool iommu_dma_strict __read_mostly = true;
> +static enum iommu_strictness cmdline_dma_strict __read_mostly = IOMMU_DEFAULT_STRICTNESS;
> +static enum iommu_strictness driver_dma_strict __read_mostly = IOMMU_DEFAULT_STRICTNESS;
>  static u32 iommu_cmd_line __read_mostly;
>
>  struct iommu_group {
> @@ -69,7 +80,6 @@ static const char * const iommu_group_resv_type_string[] = {
>  };
>
>  #define IOMMU_CMD_LINE_DMA_API         BIT(0)
> -#define IOMMU_CMD_LINE_STRICT          BIT(1)
>
>  static int iommu_alloc_default_domain(struct iommu_group *group,
>                                       struct device *dev);
> @@ -336,25 +346,38 @@ early_param("iommu.passthrough", iommu_set_def_domain_type);
>
>  static int __init iommu_dma_setup(char *str)
>  {
> -       int ret = kstrtobool(str, &iommu_dma_strict);
> +       bool strict;
> +       int ret = kstrtobool(str, &strict);
>
>         if (!ret)
> -               iommu_cmd_line |= IOMMU_CMD_LINE_STRICT;
> +               cmdline_dma_strict = bool_to_strictness(strict);
>         return ret;
>  }
>  early_param("iommu.strict", iommu_dma_setup);
>
>  void iommu_set_dma_strict(bool strict)
>  {
> -       if (strict || !(iommu_cmd_line & IOMMU_CMD_LINE_STRICT))
> -               iommu_dma_strict = strict;
> +       /* A driver can request strictness but not the other way around */
> +       if (driver_dma_strict != IOMMU_STRICT)
> +               driver_dma_strict = bool_to_strictness(strict);
>  }
>
>  bool iommu_get_dma_strict(struct iommu_domain *domain)
>  {
> -       /* only allow lazy flushing for DMA domains */
> -       if (domain->type == IOMMU_DOMAIN_DMA)
> -               return iommu_dma_strict;
> +       /* Non-DMA domains or anyone forcing it to strict makes it strict */
> +       if (domain->type != IOMMU_DOMAIN_DMA ||
> +           cmdline_dma_strict == IOMMU_STRICT ||
> +           driver_dma_strict == IOMMU_STRICT ||
> +           domain->force_strict)
> +               return true;
> +
> +       /* Anyone requesting non-strict (if no forces) makes it non-strict */
> +       if (cmdline_dma_strict == IOMMU_NOT_STRICT ||
> +           driver_dma_strict == IOMMU_NOT_STRICT ||
> +           domain->request_non_strict)
> +               return false;
> +
> +       /* Nobody said anything, so it's strict by default */
>         return true;
>  }
>  EXPORT_SYMBOL_GPL(iommu_get_dma_strict);
> @@ -1519,7 +1542,8 @@ static int iommu_get_def_domain_type(struct device *dev)
>
>  static int iommu_group_alloc_default_domain(struct bus_type *bus,
>                                             struct iommu_group *group,
> -                                           unsigned int type)
> +                                           unsigned int type,
> +                                           struct device *dev)
>  {
>         struct iommu_domain *dom;
>
> @@ -1534,6 +1558,12 @@ static int iommu_group_alloc_default_domain(struct bus_type *bus,
>         if (!dom)
>                 return -ENOMEM;
>
> +       /* Save the strictness requests from the device */
> +       if (dev && type == IOMMU_DOMAIN_DMA) {
> +               dom->request_non_strict = dev->request_non_strict_iommu;
> +               dom->force_strict = dev->force_strict_iommu;
> +       }
> +
>         group->default_domain = dom;
>         if (!group->domain)
>                 group->domain = dom;
> @@ -1550,7 +1580,7 @@ static int iommu_alloc_default_domain(struct iommu_group *group,
>
>         type = iommu_get_def_domain_type(dev) ? : iommu_def_domain_type;
>
> -       return iommu_group_alloc_default_domain(dev->bus, group, type);
> +       return iommu_group_alloc_default_domain(dev->bus, group, type, dev);
>  }
>
>  /**
> @@ -1721,7 +1751,7 @@ static void probe_alloc_default_domain(struct bus_type *bus,
>         if (!gtype.type)
>                 gtype.type = iommu_def_domain_type;
>
> -       iommu_group_alloc_default_domain(bus, group, gtype.type);
> +       iommu_group_alloc_default_domain(bus, group, gtype.type, NULL);
>
>  }
>
> @@ -3130,7 +3160,7 @@ static int iommu_change_dev_def_domain(struct iommu_group *group,
>         }
>
>         /* Sets group->default_domain to the newly allocated domain */
> -       ret = iommu_group_alloc_default_domain(dev->bus, group, type);
> +       ret = iommu_group_alloc_default_domain(dev->bus, group, type, dev);
>         if (ret)
>                 goto out;
>
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 32d448050bf7..0bddef77f415 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -81,6 +81,8 @@ struct iommu_domain_geometry {
>
>  struct iommu_domain {
>         unsigned type;
> +       bool force_strict:1;
> +       bool request_non_strict:1;
>         const struct iommu_ops *ops;
>         unsigned long pgsize_bitmap;    /* Bitmap of page sizes in use */
>         iommu_fault_handler_t handler;
> --
> 2.32.0.288.g62a8d224e6-goog
>
