Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0382828040F
	for <lists+linux-pci@lfdr.de>; Thu,  1 Oct 2020 18:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732415AbgJAQgB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Oct 2020 12:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732016AbgJAQgA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Oct 2020 12:36:00 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCCE3C0613D0;
        Thu,  1 Oct 2020 09:36:00 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id j19so2274824pjl.4;
        Thu, 01 Oct 2020 09:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wJgRdiCdKwAPzZOQSHLzYM1xBP+RpvAhHe8SfcDOWCQ=;
        b=FMQviEiop2nNX40IOELYb4bZp14f5BWgDYWIonOaZe+EqH6mB/AhZB5O0fiZ+7A5Nl
         J7QDDooYh37iUDtXoyyheEl2Li78otQHcJ4gSBh0wcGEq6TkmI8MhmDRaNRl1Mmbn8pr
         TQ79UEZI6bM7y2Ttq5WT5MhhtlssSSGTiOdAlul7d6Xtcxnq9cY48a6sG1nL1fSfJ7uj
         z9IxR6fvErbkufcn1bNCgP9M9KT6F3AU3XEd3WCMHxSn1mZYjVr8kWoJMe1ZAhwD3vWy
         Lf+zSg3Ll4TRF5CGfHGEL9G5IZmdUCiKFUqVrBA6MoKB9VUJMMhAHIkT6kgaH262VySQ
         mHMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wJgRdiCdKwAPzZOQSHLzYM1xBP+RpvAhHe8SfcDOWCQ=;
        b=s1O9mUsIdWGJMHZshwlcJbgm0hisAqw1DEnqoHZMS2ZUuXDTd7vfyjquZqXwlKBVoF
         MecJgo6vH941YgcvNSmpqPpLbTL2D3LLt1tU0HlfZWdFwm54ORd/MaSP94mKtzM1/0xI
         l0ZaYcE4TSB/jdDRh3gcgFl2mHpVVrthtC9qQwEQtb+OTII63NkNW+/r+2mcL/dG3WK/
         Lvc8FMX8hF0WwxPmubq2CPlvGK/ZX7rOOApHrpd0GWA5SnsyPTl7GCkNoEYtRzfavhbe
         V9Dim2M/lX/7N/fOkz+kCxkdgCYGi51CrZsHNb5CkvCtlFnQUG4M1LP+ShXSgOH5m/4d
         E83Q==
X-Gm-Message-State: AOAM531CQIl+Vux3HP07TJK96ON9Ikm/8slWcxeEgAKk6dGIU0qF4biv
        ub0IOZ6lv0IT2Q+dGTz300s8jaemqPHGN0fTzPQ=
X-Google-Smtp-Source: ABdhPJyhJXxJ1O/nOqwa2gkHNmjNMlGkW2vYIvPvka/GZnsH8l4+514dsPGkZiw7sWQJrwWmJIeTzoKWFwFBeF7tYYI=
X-Received: by 2002:a17:90b:fc4:: with SMTP id gd4mr754862pjb.129.1601570160261;
 Thu, 01 Oct 2020 09:36:00 -0700 (PDT)
MIME-Version: 1.0
References: <20201001014250.26987-1-david.e.box@linux.intel.com> <20201001014250.26987-6-david.e.box@linux.intel.com>
In-Reply-To: <20201001014250.26987-6-david.e.box@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 1 Oct 2020 19:35:41 +0300
Message-ID: <CAHp75VcP58Ub=gmbRVy0TPJtntKvnQZoi3tOakxE0qsEqzGPVA@mail.gmail.com>
Subject: Re: [PATCH V7 5/5] platform/x86: Intel PMT Crashlog capability driver
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        alexey.budankov@linux.intel.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 1, 2020 at 4:43 AM David E. Box <david.e.box@linux.intel.com> wrote:
> Add support for the Intel Platform Monitoring Technology crashlog
> interface. This interface provides a few sysfs values to allow for
> controlling the crashlog telemetry interface as well as a character driver
> to allow for mapping the crashlog memory region so that it can be accessed
> after a crashlog has been recorded.
>
> This driver is meant to only support the server version of the crashlog
> which is identified as crash_type 1 with a version of zero. Currently no
> other types are supported.

...

> +               The crashlog<x> directory contains files for configuring an
> +               instance of a PMT crashlog device that can perform crash data
> +               recoring. Each crashlog<x> device has an associated crashlog

recording

> +               file. This file can be opened and mapped or read to access the
> +               resulting crashlog buffer. The register layout for the buffer
> +               can be determined from an XML file of specified guid for the
> +               parent device.

...

> +               (RO) The guid for this crashlog device. The guid identifies the

guid -> GUID

Please, spell check all ABI files in this series.

...

> +config INTEL_PMT_CRASHLOG
> +       tristate "Intel Platform Monitoring Technology (PMT) Crashlog driver"
> +       select INTEL_PMT_CLASS
> +       help
> +         The Intel Platform Monitoring Technology (PMT) crashlog driver provides
> +         access to hardware crashlog capabilities on devices that support the
> +         feature.

Name of the module?

...

> +       /*

> +        * Currenty we only recognize OOBMSM version 0 devices.

Currently. Please spell check all comments in the code.

> +        * We can ignore all other crashlog devices in the system.
> +        */

...

> +       /* clear control bits */

What new information readers get from this comment?

> +       control &= ~(CRASHLOG_FLAG_MASK | CRASHLOG_FLAG_DISABLE);

How does the second constant play any role here?

...

> +       /* clear control bits */

Ditto. And moreover it's ambiguous due to joined two lines below.

> +       control &= ~CRASHLOG_FLAG_MASK;
> +       control |= CRASHLOG_FLAG_EXECUTE;

...

> +       return strnlen(buf, count);

How is this different to count?

...

> +       struct crashlog_entry *entry;
> +       bool trigger;
> +       int result;
> +

> +       entry = dev_get_drvdata(dev);

You may reduce LOCs by direct assigning in the definition block above.

...

> +       result = strnlen(buf, count);

How is it different from count?

...

> +static DEFINE_XARRAY_ALLOC(crashlog_array);
> +static struct intel_pmt_namespace pmt_crashlog_ns = {
> +       .name = "crashlog",
> +       .xa = &crashlog_array,
> +       .attr_grp = &pmt_crashlog_group

Leave the comma here.

> +};

...

> +       ret = intel_pmt_dev_create(entry, &pmt_crashlog_ns, parent);
> +       if (!ret)
> +               return 0;
> +
> +       dev_err(parent, "Failed to add crashlog controls\n");
> +       intel_pmt_dev_destroy(entry, &pmt_crashlog_ns);
> +
> +       return ret;

Can we use traditional patterns?
if (ret) {
  ...
}
return ret;

...

> +       size = offsetof(struct pmt_crashlog_priv, entry[pdev->num_resources]);
> +       priv = devm_kzalloc(&pdev->dev, size, GFP_KERNEL);
> +       if (!priv)
> +               return -ENOMEM;

struct_size()

...

> +               /* initialize control mutex */
> +               mutex_init(&priv->entry[i].control_mutex);
> +
> +               disc_res = platform_get_resource(pdev, IORESOURCE_MEM, i);
> +               if (!disc_res)
> +                       goto abort_probe;
> +
> +               ret = intel_pmt_ioremap_discovery_table(entry, pdev, i);
> +               if (ret)
> +                       goto abort_probe;
> +
> +               if (!pmt_crashlog_supported(entry))
> +                       continue;
> +
> +               ret = pmt_crashlog_add_entry(entry, &pdev->dev, disc_res);
> +               if (ret)
> +                       goto abort_probe;
> +
> +               priv->num_entries++;

Are you going to duplicate this in each driver? Consider to refactor
to avoid duplication of a lot of code.

...

> +               .name   = DRV_NAME,

> +MODULE_ALIAS("platform:" DRV_NAME);

I'm not sure I have interpreted this:
        - Use 'raw' string instead of defines for device names
correctly. Can you elaborate?

--
With Best Regards,
Andy Shevchenko
