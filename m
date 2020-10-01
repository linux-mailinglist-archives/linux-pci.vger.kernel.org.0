Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69AFF280430
	for <lists+linux-pci@lfdr.de>; Thu,  1 Oct 2020 18:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732299AbgJAQqi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Oct 2020 12:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732274AbgJAQqi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Oct 2020 12:46:38 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F0AC0613D0;
        Thu,  1 Oct 2020 09:46:38 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id q1so6781156ilt.6;
        Thu, 01 Oct 2020 09:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+1JUkO3QCGoe44LoRPf6LoiKyh+E2Tmq//NtAEjkplw=;
        b=S7s40mmk6t0Wqt0W5AbDBwjYW3G/WTDn3hPKIrxoltDbGXZ9wQGaTKtR18YhifrQE+
         zzGtLOgQqMBzq+SSxoPy+KKsWMokL+LDpQz2uiosRao0q101vpI+ziKKhkrtAxKmiKwO
         OxW6pADOvnYf7vTZgENUy1kAfT0a7x7wdfNOMQ97cCHGLao7VXGyrgsW6DR/nkgSBjzw
         xyQeFw+iiShhi9F/4Heh4BfDXjuygWe58ng5H4PHCzyVjWVT7y/ZVCZod+G3BlryFqKC
         YiPDMkYzM8utJeLAxcIhpakGRbu8phkUbMhWFTEWvtygvijqUBqYDMVSnjMILVwcGnqO
         KEEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+1JUkO3QCGoe44LoRPf6LoiKyh+E2Tmq//NtAEjkplw=;
        b=ErdtS9Zc3qMevvUQuiZS0RNW6DTz3hVZJWoTOT/nxpa/7hYwEE8tRsEfZetTpc9dOJ
         86YX+qhysokwrndhZ3CKVWNaIVkcm94UOPThj8PnxnWTMDVgH0kuBlu7JGqwSU3EWj/F
         7kKMW/6nh8W1YBSm38OSEzKzCtTguW/o4ybP6UjAJph+sBzRKg3CX7QYgJveSGuTKpWk
         iyK7sdO//p/v8P2G/T/b0Jf/rXxwb5MR7Ly4oWN9f0gNB3tQ9CxSlJp49wNUuAywgBm+
         LdrVwgdP1khsrpqyz0TICEu8mJq/o4yfMksycyaBTCsUa49rdj45+IDAUd4oN1aRYBLu
         Eptg==
X-Gm-Message-State: AOAM531+M5oZ3iKtsRz2jXTYoFTzIL/r9Wv8NOPboW6YZJgjYI0UL3fC
        T/ROyAyKWSYZZjM7ypuN9vPwH8FQIwNaNCYDi7U=
X-Google-Smtp-Source: ABdhPJySkXGVvzlLtuibxEhmC5gJlHATz519uol0/U1KIrMD6UhO6+eVc4Eq5vC++e/Z1fshO/XSsoSe4JXQsfm0dlg=
X-Received: by 2002:a92:950d:: with SMTP id y13mr3222543ilh.42.1601570797364;
 Thu, 01 Oct 2020 09:46:37 -0700 (PDT)
MIME-Version: 1.0
References: <20201001014250.26987-1-david.e.box@linux.intel.com>
 <20201001014250.26987-5-david.e.box@linux.intel.com> <CAHp75VfcXbedZbbF3KATWYMR1SPXusuaU+vrkvM1zsRpYzDFiA@mail.gmail.com>
In-Reply-To: <CAHp75VfcXbedZbbF3KATWYMR1SPXusuaU+vrkvM1zsRpYzDFiA@mail.gmail.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Thu, 1 Oct 2020 09:46:26 -0700
Message-ID: <CAKgT0UcJXEeC4ZNQ0vq6Q6gBQeUe9uaFDHoDNoTjL0eYWaYUEA@mail.gmail.com>
Subject: Re: [PATCH V7 4/5] platform/x86: Intel PMT Telemetry capability driver
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

On Thu, Oct 1, 2020 at 9:03 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Thu, Oct 1, 2020 at 4:43 AM David E. Box <david.e.box@linux.intel.com> wrote:
> >
> > From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> >
> > PMT Telemetry is a capability of the Intel Platform Monitoring Technology.
> > The Telemetry capability provides access to device telemetry metrics that
> > provide hardware performance data to users from read-only register spaces.
> >
> > With this driver present the intel_pmt directory can be populated with
> > telem<x> devices. These devices will contain the standard intel_pmt sysfs
> > data and a "telem" binary sysfs attribute which can be used to access the
> > telemetry data.
>
> ...
>
> > +static DEFINE_XARRAY_ALLOC(telem_array);
> > +static struct intel_pmt_namespace pmt_telem_ns = {
> > +       .name = "telem",
> > +       .xa = &telem_array
>
> Leave comma at the end.
>
> > +};
> > +
> > +/*
> > + * driver initialization
> > + */
>
> This is a useless comment.
>
> > +       size = offsetof(struct pmt_telem_priv, entry[pdev->num_resources]);
> > +       priv = devm_kzalloc(&pdev->dev, size, GFP_KERNEL);
> > +       if (!priv)
> > +               return -ENOMEM;
>
> Please, use struct_size() from overflow.h instead of custom approach.
>
> ...

So all of the above make sense and can be fixed shortly and pushed as
a v8 for both the telemetry and crashlog drivers.

> > +static struct platform_driver pmt_telem_driver = {
> > +       .driver = {
> > +               .name   = TELEM_DEV_NAME,
>
> I'm not sure I have interpreted this:
>         - Use 'raw' string instead of defines for device names
> correctly. Can you elaborate?

Can you point me to a reference of that? I'm not sure what you are referring to.

> > +       },
> > +       .remove = pmt_telem_remove,
> > +       .probe  = pmt_telem_probe,
> > +};
>
> ...
>
> > +MODULE_ALIAS("platform:" TELEM_DEV_NAME);
>
> Ditto.

This doesn't make sense to me. Are you saying we are expected to use
"pmt_telemetry" everywhere instead of the define? It seems like that
would be much more error prone. It seems like common practice to use
DRV_NAME throughout a driver for these sort of things so if you are
wanting us to rename it to that I am fine with that, but I am not sure
getting rid of the use of a define makes sense.
