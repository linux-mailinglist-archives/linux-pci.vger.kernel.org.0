Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7C52806A8
	for <lists+linux-pci@lfdr.de>; Thu,  1 Oct 2020 20:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732415AbgJASdO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Oct 2020 14:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729993AbgJASdO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Oct 2020 14:33:14 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67443C0613D0;
        Thu,  1 Oct 2020 11:33:14 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id g7so7890650iov.13;
        Thu, 01 Oct 2020 11:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pM2EvyziJUk4j3NrVweb92RACiTlKKpPHLsnNTMRVlI=;
        b=g9KEDybQZHTUIqKMCweoBoLWUoxwKeD1M+wVwfYO/sNgGltanIiKV+dReIdePIrYGz
         oARglNMDZzyJwVWhNFOV5hIv2uKEPgyTjW90GCufkWX+8z2dXAnFRWS0DksdPbYa+tQU
         PuEcVHKs9ZsE/bLQooeOU5KG/hy5AglLsGLLS5Vxz6Zd40rHm9HlnMhwa1EA5bJUyBsb
         scZGIPtYBIJqJnuSqm4zOnSez4iWRosSs9uPe2k4zNif3e/T0otzhIdLHMcPut0gffdZ
         z6Q+PF1/GymH+MWCmNSQjoBiJHcxrT6H38/b5GULSeApoiY3FIiqc9JuU8c+D97Kg7jH
         A6WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pM2EvyziJUk4j3NrVweb92RACiTlKKpPHLsnNTMRVlI=;
        b=TzkYMzq0TsCLGJLIlSxhkx8exAmV4VevXEG6BqO2ZnuHgguXhqK2lmwGnTyyIvMb2j
         HMTKlFztdD5iUn5ag8nCq4Vz2m+uY2oZeDc5GcXgF8KBvTpqMNdpJsD8P/nREzs8XTkz
         ZvPS2f4VtJkdjJURGE7mwBf6PI9jM2nEIwWJM5LZo8XjzEM35UDaPudcd1cEjaJJKKRT
         qwbB1iy91eYoOzsDIoB7ZiFtPrnHmr0OPeYB5D1yspwrPtGTR1ZI9jkjJwBj2qwCcWVu
         0OMJ6xff1XbeelQH+/ZU+Q3RPuMf1H+QcXhErg/b2QywlVOuoCtc1bnGUwSVVoPsGCD/
         isow==
X-Gm-Message-State: AOAM533tDHJzY7u4/rABgk67UFdk+Aa7zZZ65z7El/LQwHg9niX1qYhg
        1QK5MLmNMpR7FGwfrFDmUQ5E95X7JWHwHQwRtQ8=
X-Google-Smtp-Source: ABdhPJzx3UMJnNBCK6ZbI3RbOaUn+hvSYdvsQGW0J45RkEDUwcQdmBUHLqm5edkWy0Yh/eKAu0w6+pHZ6+rd2pqXbvs=
X-Received: by 2002:a02:c004:: with SMTP id y4mr7443470jai.121.1601577193278;
 Thu, 01 Oct 2020 11:33:13 -0700 (PDT)
MIME-Version: 1.0
References: <20201001014250.26987-1-david.e.box@linux.intel.com>
 <20201001014250.26987-6-david.e.box@linux.intel.com> <CAHp75VcP58Ub=gmbRVy0TPJtntKvnQZoi3tOakxE0qsEqzGPVA@mail.gmail.com>
In-Reply-To: <CAHp75VcP58Ub=gmbRVy0TPJtntKvnQZoi3tOakxE0qsEqzGPVA@mail.gmail.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Thu, 1 Oct 2020 11:33:01 -0700
Message-ID: <CAKgT0Udk4ZdtAisB=edcUfnBqwNFtY8K54CF+9yEF6MZL1Th6Q@mail.gmail.com>
Subject: Re: [PATCH V7 5/5] platform/x86: Intel PMT Crashlog capability driver
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "David E. Box" <david.e.box@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 1, 2020 at 9:37 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Thu, Oct 1, 2020 at 4:43 AM David E. Box <david.e.box@linux.intel.com> wrote:
> > Add support for the Intel Platform Monitoring Technology crashlog
> > interface. This interface provides a few sysfs values to allow for
> > controlling the crashlog telemetry interface as well as a character driver
> > to allow for mapping the crashlog memory region so that it can be accessed
> > after a crashlog has been recorded.
> >
> > This driver is meant to only support the server version of the crashlog
> > which is identified as crash_type 1 with a version of zero. Currently no
> > other types are supported.
>
> ...
>
> > +               The crashlog<x> directory contains files for configuring an
> > +               instance of a PMT crashlog device that can perform crash data
> > +               recoring. Each crashlog<x> device has an associated crashlog
>
> recording
>
> > +               file. This file can be opened and mapped or read to access the
> > +               resulting crashlog buffer. The register layout for the buffer
> > +               can be determined from an XML file of specified guid for the
> > +               parent device.
>
> ...
>
> > +               (RO) The guid for this crashlog device. The guid identifies the
>
> guid -> GUID
>
> Please, spell check all ABI files in this series.

I'll run through it again. I am suspecting I must have deleted the "d"
in recording with a fat fingering when I was editing something else.

> ...
>
> > +config INTEL_PMT_CRASHLOG
> > +       tristate "Intel Platform Monitoring Technology (PMT) Crashlog driver"
> > +       select INTEL_PMT_CLASS
> > +       help
> > +         The Intel Platform Monitoring Technology (PMT) crashlog driver provides
> > +         access to hardware crashlog capabilities on devices that support the
> > +         feature.
>
> Name of the module?

I will add the verbiage:
          To compile this driver as a module, choose M here: the module
          will be called intel_pmt_crashlog.


> ...
>
> > +       /*
>
> > +        * Currenty we only recognize OOBMSM version 0 devices.
>
> Currently. Please spell check all comments in the code.

I'll make another pass.

> > +        * We can ignore all other crashlog devices in the system.
> > +        */
>
> ...
>
> > +       /* clear control bits */
>
> What new information readers get from this comment?

Arguably not much. I'll drop the comment.

> > +       control &= ~(CRASHLOG_FLAG_MASK | CRASHLOG_FLAG_DISABLE);
>
> How does the second constant play any role here?

The "control" flags are bits 28-31, while the disable flag is bit 27
if I recall.

Specifically bit 31 is read only, bit 28 will clear bit 31, bit 29
will cause the crashlog to be generated and set bit 31, and bit 30 is
just reserved 0.

> ...
>
> > +       /* clear control bits */
>
> Ditto. And moreover it's ambiguous due to joined two lines below.

I'll just drop the comments.

> > +       control &= ~CRASHLOG_FLAG_MASK;
> > +       control |= CRASHLOG_FLAG_EXECUTE;
>
> ...
>
> > +       return strnlen(buf, count);
>
> How is this different to count?

I guess they should be equivalent so I can probably just switch to count.

> ...
>
> > +       struct crashlog_entry *entry;
> > +       bool trigger;
> > +       int result;
> > +
>
> > +       entry = dev_get_drvdata(dev);
>
> You may reduce LOCs by direct assigning in the definition block above.

Okay. I can move it if you prefer.

> ...
>
> > +       result = strnlen(buf, count);
>
> How is it different from count?

I'll switch it.

> ...
>
> > +static DEFINE_XARRAY_ALLOC(crashlog_array);
> > +static struct intel_pmt_namespace pmt_crashlog_ns = {
> > +       .name = "crashlog",
> > +       .xa = &crashlog_array,
> > +       .attr_grp = &pmt_crashlog_group
>
> Leave the comma here.

Already fixed based on similar comments you had for the telemetry driver.. :-)

> > +};
>
> ...
>
> > +       ret = intel_pmt_dev_create(entry, &pmt_crashlog_ns, parent);
> > +       if (!ret)
> > +               return 0;
> > +
> > +       dev_err(parent, "Failed to add crashlog controls\n");
> > +       intel_pmt_dev_destroy(entry, &pmt_crashlog_ns);
> > +
> > +       return ret;
>
> Can we use traditional patterns?
> if (ret) {
>   ...
> }
> return ret;

I can switch it if that is preferred.

> ...
>
> > +       size = offsetof(struct pmt_crashlog_priv, entry[pdev->num_resources]);
> > +       priv = devm_kzalloc(&pdev->dev, size, GFP_KERNEL);
> > +       if (!priv)
> > +               return -ENOMEM;
>
> struct_size()
>
> ...
>
> > +               /* initialize control mutex */
> > +               mutex_init(&priv->entry[i].control_mutex);
> > +
> > +               disc_res = platform_get_resource(pdev, IORESOURCE_MEM, i);
> > +               if (!disc_res)
> > +                       goto abort_probe;
> > +
> > +               ret = intel_pmt_ioremap_discovery_table(entry, pdev, i);
> > +               if (ret)
> > +                       goto abort_probe;
> > +
> > +               if (!pmt_crashlog_supported(entry))
> > +                       continue;
> > +
> > +               ret = pmt_crashlog_add_entry(entry, &pdev->dev, disc_res);
> > +               if (ret)
> > +                       goto abort_probe;
> > +
> > +               priv->num_entries++;
>
> Are you going to duplicate this in each driver? Consider to refactor
> to avoid duplication of a lot of code.

So the issue lies in the complexity of pmt_telem_add_entry versus
pmt_crashlog_add_entry. Specifically I end up needing disc_res and the
discovery table when I go to create the controls for the crashlog
device. Similarly we have a third device that we plan to add called a
watcher which will require us to keep things split up like this so we
thought it best to split it up this way.

> ...
>
> > +               .name   = DRV_NAME,
>
> > +MODULE_ALIAS("platform:" DRV_NAME);
>
> I'm not sure I have interpreted this:
>         - Use 'raw' string instead of defines for device names
> correctly. Can you elaborate?

Again I am not sure what this is in reference to. If you can point me
to some documentation somewhere I can take a look.

Thanks.

- Alex
