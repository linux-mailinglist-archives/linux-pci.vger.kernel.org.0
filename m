Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3CC43AFB38
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jun 2021 04:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbhFVC6t (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Jun 2021 22:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbhFVC6t (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Jun 2021 22:58:49 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF54C061574
        for <linux-pci@vger.kernel.org>; Mon, 21 Jun 2021 19:56:31 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id w21so22039487qkb.9
        for <linux-pci@vger.kernel.org>; Mon, 21 Jun 2021 19:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o7WniBxc7u8I3jtLWFb2QyQubQrJgur3uSaTIY2hHpY=;
        b=IlhIu8fFZb/00DISAJcThl4zsHWxZQu1Oa/M3ahKUhWaxlkRjELVIGBWjVa/lOqm5w
         R8ijcCQtXUjJKTXjsyL8XC9IeSNYcoE/hXhy0707xoE6Bp7mwCrtqvMSIwg7XRSkNIE+
         41oC8qsSXK/w+ICTlHHEk6csKeMmNkBnGKqC4mrBOzIjGGVZUX6Nspzkfc0P0dg2TAX0
         qGjTjgj9xBimf62Siz9ycYnskVpQcN4f68bXYa47M7lrcmqv9sUfStAIPZ+oYS0gQPSS
         axREBBohkOyHxdZVxh0tmhTQ6DCvRJCFxRlsELoVQjr6rZofiDiCLzoIC+fkMke5eZXb
         KOyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o7WniBxc7u8I3jtLWFb2QyQubQrJgur3uSaTIY2hHpY=;
        b=lpSeDYj9GpNs6i3wBL2B8ytMrYcnvUBUXYmgHIp9ccqBsBpdE7d5FK7cgtlhjqy0Pz
         2o2iHMvool29t6K1WDi57TPJZwoUtKjuwQDQv3hG0y67JjbF0+ABoyLXa/f+hNqKxsHc
         3qvJ0TxMsXfaW4PrVZo0pfHVl9UYBjTNIUiNyaqmoe3DF411QtQPg/RyvPEY9nHvQaL1
         fbJW1IOtl6H0yMCyS8lgjFv6VXKzdClXIcq2+6b/TCB6FV309z34AnhDXZB+K4TtcTEA
         zbci/y039Br9DtF3v8di9vXDwzE7gwRFMg/5jtWTiH/DSEC5NOw6No21yGHKNokjo/EN
         QKnw==
X-Gm-Message-State: AOAM530K4NRYdSuC24Qb28VdSjMuGp7fv1a4meBoo+N7m7NV9HXbvZW5
        rGY9VAS9zV04sNlA5POg95drk9CCNB5jl1xDM0oD+A==
X-Google-Smtp-Source: ABdhPJyQjeT6WzR5lehTnPxseq2wdji+PgNfDU28Fwy5MqjJ3yxJk8R8kSGnjCwg/Kmk7+Pz3hc0ucfFrwGQ91Xpnkk=
X-Received: by 2002:a25:bcb:: with SMTP id 194mr1812975ybl.32.1624330590627;
 Mon, 21 Jun 2021 19:56:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210621235248.2521620-1-dianders@chromium.org> <20210621165230.4.Id84a954e705fcad3fdb35beb2bc372e4bf2108c7@changeid>
In-Reply-To: <20210621165230.4.Id84a954e705fcad3fdb35beb2bc372e4bf2108c7@changeid>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 21 Jun 2021 19:55:52 -0700
Message-ID: <CAGETcx-dZ_Wwjafk+5akWJwbrFx2rYNKZAU8tWhFUunEyn8sqQ@mail.gmail.com>
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
        rajatja@google.com, joel@joelfernandes.org,
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

If iommu.strict is not set in the command line, upstream treats it as
iommu.strict=1. Meaning, no drivers can override it.

If I understand it correctly, with your series, if iommu.strict=1 is
not set, drivers can override the "default strict mode" and ask for
non-strict mode for their domain. So if this series gets in and future
driver changes start asking for non-strict mode, systems that are
expected to operate in fully strict mode will now have devices
operating in non-strict mode.

That's breaking backward compatibility for the kernel command line
param. It looks like what you really need is to change iommu.strict
from 0/1 to lazy (previously 0), strict preferred, strict enforced
(previously 1) and you need to default it to "enforced".

Alternately (and potentially a better option?), you really should be
changing/extending dev_is_untrusted() so that it applies for any
struct device (not just PCI device) and then have this overridden in
DT (or ACPI or any firmware) to indicate a specific device is safe to
use non-strict mode on. What you are trying to capture (if the device
safe enough) really isn't a function of the DMA device's driver, but a
function of the DMA device.



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
