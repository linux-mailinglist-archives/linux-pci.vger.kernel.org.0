Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5391422484
	for <lists+linux-pci@lfdr.de>; Tue,  5 Oct 2021 13:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234223AbhJELFu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Oct 2021 07:05:50 -0400
Received: from mail-oo1-f54.google.com ([209.85.161.54]:40752 "EHLO
        mail-oo1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233449AbhJELFt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Oct 2021 07:05:49 -0400
Received: by mail-oo1-f54.google.com with SMTP id j11-20020a4a92cb000000b002902ae8cb10so6274311ooh.7;
        Tue, 05 Oct 2021 04:03:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rbQR10SUFcLSb0CqZ3+0KI2N/KoBUg4lIS8MaCYfWzA=;
        b=uTRXokuJvnnt9xhRhvKk7nmg9P1L43vtMvvkzf5c7uTPaL5O6Dm116xMRTZRZLMOKD
         fojp1hYG7NkIA9hcGEnMqAxJiWVk7tjgJvK8DtXNeyQQqS7cg/EJjHrV9BvN2Z4z56jI
         auEN2JL0rm9iHJXOVNMEWGLCRuuvyLLFYQ8tBwoYpbYmm6x7Zj22BlEoIkmscDl+fdH5
         tkKXAnyEhlL7unmkR0KeV3Zd43U00mmYfnXhAZHZ7N/Cg7NpNn5s8ZZ7wN59fescRBEz
         3jXXD+sRiUyrA47RR8tx2FCxMPDbNTdNh0382at7NxCDuNjDAqqPEmXcsiaVwOmfnS8G
         P3Tg==
X-Gm-Message-State: AOAM530Ar+fZq1ruftRtomp4A+sgIEHTZi+HxKS8HktX7BrEcxPVQtJ8
        xa6J21cuzsIhE/yIGIk5ZPOdfXBlntJaqI/Ffmc=
X-Google-Smtp-Source: ABdhPJxripPRp/2cLwKftBJJECVik2j1AfoGQDmRIUHPdG4gKa29qqGW4SnWQFEZNeKgTv6jZa4cvNpPu7oUx2ePtCo=
X-Received: by 2002:a05:6820:17a:: with SMTP id k26mr12930860ood.37.1633431839035;
 Tue, 05 Oct 2021 04:03:59 -0700 (PDT)
MIME-Version: 1.0
References: <1800633.tdWV9SEqCh@kreacher> <7312660.EvYhyI6sBW@kreacher> <fe9b4f36-0b46-f8d7-4a4c-9bdefe1fbd90@gmail.com>
In-Reply-To: <fe9b4f36-0b46-f8d7-4a4c-9bdefe1fbd90@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 5 Oct 2021 13:03:42 +0200
Message-ID: <CAJZ5v0i9vyT7oU-4NkVjrtD+Mz0Udaex=4j6iR5f70ssd8AnbA@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] PCI: PM: Simplify and unify some helper functions
To:     Ferry Toth <fntoth@gmail.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Oct 3, 2021 at 10:14 PM Ferry Toth <fntoth@gmail.com> wrote:
>
> Hi,
>
> Op 29-09-2021 om 20:05 schreef Rafael J. Wysocki:
> > Hi All,
> >
> > This series is on top of the linux-next branch from linux-pm.git:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
> >
> > which should be included in linux-next.
> >
> > Two of the 3 patches in this series, [1-2/3], were included in the "PCI: ACPI:
> > Get rid of struct pci_platform_pm_ops and clean up code" series:
> >
> >   https://lore.kernel.org/linux-acpi/1800633.tdWV9SEqCh@kreacher/
> >
> > and the remaining one, [3/3] is a new version of a problematic patch from that
> > series.  The rest of that series is present in the git branch above.
> >
> > All of the 3 patches in this set need to be tested in order to verify that
> > there are no more issues that need to be addressed in them.
> >
> > Ferry, please test!
>
> This is how I tested:
> 3 patches from
> https://patchwork.kernel.org/project/linux-acpi/patch/2793105.e9J7NaK4W3@kreacher/
> on top of 5.15.0-rc2 as before
> 4 patches from v2 in the order of linux-pm.git
> then tested without, with 1/3, 1+2/3, 1+2+3/3 on top (with only 3/3 the
> new patch, 1+2/3 taken from v2 as they are unchanged).
>
> In all 4 cases I didn't find any trouble (related to this patch).
>
> Thanks for doing this!

Thank you!
