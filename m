Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61ECD41CC74
	for <lists+linux-pci@lfdr.de>; Wed, 29 Sep 2021 21:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346491AbhI2TPB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Sep 2021 15:15:01 -0400
Received: from mail-ot1-f49.google.com ([209.85.210.49]:33343 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344094AbhI2TPA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Sep 2021 15:15:00 -0400
Received: by mail-ot1-f49.google.com with SMTP id d12-20020a05683025cc00b0054d8486c6b8so4257682otu.0;
        Wed, 29 Sep 2021 12:13:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q/WQwciV4kH9qlmumlGivjLJN6ySXaV6TVusvL35OKM=;
        b=b0KEneFP+dlfGWWgMlkP2/m21k3LzxutLjZW3VYRZ4+oJjvwj8nFKndDKiM8jcEAxj
         O2Ari7sidU296ywOQ+DLvdJHr5ST7+engwT5bAJMihCguCgkSlBJ9oKWK+Q4TFOZW354
         LqxeUoFDApkZlE5N/zeO7X+0J2ixoNSS5yNfzlK7+hxeG9r7SPQV9+LYgVrn/BKsWpd9
         Wgux9+HlnTEljULevIvS8uyg28TuIugLYMqC4kjdeixnZcKsdRk9+90IZUkFCL/dFiXh
         8ZOsczrZWbnbW/4c+y9DSbsMeFVsHTSmwv2r0FCQKorlU/Yjei5PSga75fizkV1TXgq8
         D+Ng==
X-Gm-Message-State: AOAM531z2XyJAC16BbKlj6hyhNsRjA8/mshEOLWnTFnb7WhvepXpGPhH
        Qm16TgpvYUkYJRw8MqXTGrs0Fo4ux3gN2Nd7HUA=
X-Google-Smtp-Source: ABdhPJw0vt/bBZzouEmyLqdC0Zbn+/cKmyfJ3LuVcgYM2+N3TpHoEbktUk4VmZemtq4x3GdAFWsDqmWJgpw4C6e1cbw=
X-Received: by 2002:a05:6830:165a:: with SMTP id h26mr1450970otr.301.1632942798995;
 Wed, 29 Sep 2021 12:13:18 -0700 (PDT)
MIME-Version: 1.0
References: <1800633.tdWV9SEqCh@kreacher> <8879480.rMLUfLXkoz@kreacher> <YVS5k1H8KyVAk/h8@archlinux-ax161>
In-Reply-To: <YVS5k1H8KyVAk/h8@archlinux-ax161>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 29 Sep 2021 21:13:07 +0200
Message-ID: <CAJZ5v0jSOpBbt8C5ema1t7h8Fb49F7DSyrUfht5xUXibVBU2Qw@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] PCI: ACPI: PM: Do not use pci_platform_pm_ops for ACPI
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 29, 2021 at 9:08 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> On Mon, Sep 20, 2021 at 09:17:08PM +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Using struct pci_platform_pm_ops for ACPI adds unnecessary
> > indirection to the interactions between the PCI core and ACPI PM,
> > which is also subject to retpolines.
> >
> > Moreover, it is not particularly clear from the current code that,
> > as far as PCI PM is concerned, "platform" really means just ACPI
> > except for the special casess when Intel MID PCI PM is used or when
> > ACPI support is disabled (through the kernel config or command line,
> > or because there are no usable ACPI tables on the system).
> >
> > To address the above, rework the PCI PM code to invoke ACPI PM
> > functions directly as needed and drop the acpi_pci_platform_pm
> > object that is not necessary any more.
> >
> > Accordingly, update some of the ACPI PM functions in question to do
> > extra checks in case the ACPI support is disabled (which previously
> > was taken care of by avoiding to set the pci_platform_ops pointer
> > in those cases).
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> This patch as commit 9896a58cdd59 ("PCI: ACPI: PM: Do not use
> pci_platform_pm_ops for ACPI") in -next causes the following build error
> when compiling x86_64 allmodconfig with clang:
>
> drivers/pci/pci-acpi.c:1125:7: error: variable 'adev' is uninitialized when used here [-Werror,-Wuninitialized]
>         if (!adev || !acpi_device_power_manageable(adev))
>              ^~~~
> drivers/pci/pci-acpi.c:1110:26: note: initialize the variable 'adev' to silence this warning
>         struct acpi_device *adev;
>                                 ^
>                                  = NULL
> 1 error generated.
>
> Should the adev assignment be moved up

Yes, thanks!

I'll fix it up in the tree.
