Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9F8413343
	for <lists+linux-pci@lfdr.de>; Tue, 21 Sep 2021 14:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232356AbhIUMSk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Sep 2021 08:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbhIUMSk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Sep 2021 08:18:40 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30CBC061574;
        Tue, 21 Sep 2021 05:17:11 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id r5so4729477edi.10;
        Tue, 21 Sep 2021 05:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=95V6ux+YItWQAUtCiwuExzmwXQnRB/GloOPEEdZ3MdU=;
        b=GvoevMtwpeSENsO0HW4htGshZNN4RfcKHKMrFLpknFFa6zKv1xNv40X9P9usbFWHtJ
         QKLzMF9owaWe5njsnvky7MNu0mJOFyR11GpGSYHoXWtx7Ph1Q8c+NTNZHKwr80IkWO4V
         ChjMla1TYRISUvk/HwagZ97gUmgZGkyGPTxlXYUXTWFheVyNaCp+DZL7Q4+GI5VXbj1H
         8URqgcincrZM2AApQPTZDb01aWcJzb78kgYgHsMhGcn8hyZyFE0cUVjn3XPuKKpOkC78
         lH2R3gtp5RqygWKoyGh5lw/ZQt9QS43C4WSm+kruZkOmwkAaybW9EiG0C9DnAuUEf+dx
         EBCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=95V6ux+YItWQAUtCiwuExzmwXQnRB/GloOPEEdZ3MdU=;
        b=A6pZ48gt1RjfyOaKNHFDqTDx0U33m9LQ7Xcm5B68Y3t7t7jx1LYq9mNGTwdvM7YS26
         ZQ3q2cbgJywwlTcBV5pAHGoy7Rr51Zmo5tNW7b9EhEtXvvK52x+1sbwFUNaVfkrkqBYs
         PR1dphMys0LxlmW4z4dZXXkug38dq1O3dQAsm3TJCBuXzVUnSdpZJBnv+pCa8eeAp5zl
         XfJTPUMOUMfffvGazXGpwuyD+otpMT3kt0UcQ+FKkvUxWcaAjl3+HEUWVsgGBAbyt4AF
         VgdtnPypsVUkQMMjt8HyUWooAXH8fxOJ+WdZvkHHdA3cBb5GYpx7ccJB+z6Pt/pJYrEx
         qXtw==
X-Gm-Message-State: AOAM5318eeaQxj0Dca0nxGS/bIr63j3rWp3iMf8wB0u0C79zpVd10omY
        RM6K9n8bW8CNcHyvEN6JQWmJC8u+kLK3qxkdBUQ=
X-Google-Smtp-Source: ABdhPJxCfbselb+XtA+2QpgqB4YRIopMRRstTCPkUE9QXlzT6B9AoPlNAPQeuz3N18XME+ds4GKE4E2TOCkZ/RBjnkw=
X-Received: by 2002:a17:906:2887:: with SMTP id o7mr34025496ejd.425.1632226617862;
 Tue, 21 Sep 2021 05:16:57 -0700 (PDT)
MIME-Version: 1.0
References: <8003272.NyiUUSuA9g@kreacher> <1798761.CQOukoFCf9@kreacher>
 <CAHp75VdoFwH2sQT6dwz4BCorkgJgmYEBHq-+YpT18HZx2cpmrA@mail.gmail.com> <CAJZ5v0iRviZkLzRP0t2f4q5oY9y6CxRotDnyBVBt-QBt-uYReQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0iRviZkLzRP0t2f4q5oY9y6CxRotDnyBVBt-QBt-uYReQ@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 21 Sep 2021 15:16:17 +0300
Message-ID: <CAHp75VdE3gNXy+p=8iyqyY0Ja+AHjv6zFEGwWJSXQwz+A0X1TQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/5] PCI: PM: x86: Drop Intel MID PCI PM support
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        x86 Maintainers <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Len Brown <len.brown@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 20, 2021 at 1:57 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Sun, Sep 19, 2021 at 10:32 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Sun, Sep 19, 2021 at 9:01 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:

...

> > > I am going to post patches removing the rest of MID support from arch/x86/
> > > and elsewhere, but that is still quite a bit of stuff and I don't want this
> > > simple PCI PM series to depend on that work.
> >
> > This is still being used by MID with ACPI assisted (*) support.
> > Hence, not ack.
> >
> > *) ACPI layer is provided by U-Boot and can't fulfill all possible
> > features that ACPI may use in the Linux kernel.
>
> OK, good to know.
>
> I'm not sure how this PCI PM stuff works with ACPI.

It doesn't that is the point. The PCI is very interesting there and
what I meant is that the ACPI implementation I have provided via
U-Boot does not cover these. If you have any hints/ideas how it may be
handled, I am all ears!

> It looks like
> this relies on a specific ordering of arch_initcall() calls for
> correctness which is sort of fragile.

-- 
With Best Regards,
Andy Shevchenko
