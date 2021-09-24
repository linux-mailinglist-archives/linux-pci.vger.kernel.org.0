Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2819A417176
	for <lists+linux-pci@lfdr.de>; Fri, 24 Sep 2021 14:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244925AbhIXME3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Sep 2021 08:04:29 -0400
Received: from mail-oo1-f43.google.com ([209.85.161.43]:36561 "EHLO
        mail-oo1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244396AbhIXME2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Sep 2021 08:04:28 -0400
Received: by mail-oo1-f43.google.com with SMTP id y47-20020a4a9832000000b00290fb9f6d3fso3208097ooi.3;
        Fri, 24 Sep 2021 05:02:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GS/g2FggR1qLNQ+IlJxXRFCGsNMvMHINEIKkHLsxREc=;
        b=7SEF5QnHOM0LfkM+uEPchF8oY2D6EKGuURsVpmA/RNQqGIXUvHNy7hk9etdI8XX2MR
         VThUAMTJRd4LzyCudeQ85/IMzslygyb/kflB15VU255O0CHRXrk6cEyQV2wKZQvS+JeP
         j47XOjmuD7Uegt5h87dytouhM9gttXpoJz5tqsRgWSiTs1emTZHN6VfpX05jlvroDIZl
         /aLixG2/vvkr90TFM9ynONvL8pqesUZvcIlKm3LbTbIrtWzqSiMFxs66tFt4Xc99sANe
         xreHLBlgbgZNnQ+irw19CmgJ3agsySeMMaKuWRYHHRq3Dcv18+TFxAlFtIWMmWgoeuVc
         X9DA==
X-Gm-Message-State: AOAM5333IXyIdz5c53UEY2477syoBefCq5D4PCR8GWoHWlcEY9XJWEOR
        nsc3PYFQArQ+YS9+gxmxLwf1CQefv3hyNKX47X/hIcd6
X-Google-Smtp-Source: ABdhPJwlyOkxagJD9t33VMMfQVfBpOfAJ2LbmCZ8CH/aLPX1h3ZfQR85hOkbLtQ47jnhwwKZbitMq97JW8R7zeKzwtA=
X-Received: by 2002:a4a:6442:: with SMTP id d2mr8347545oof.37.1632484975290;
 Fri, 24 Sep 2021 05:02:55 -0700 (PDT)
MIME-Version: 1.0
References: <1800633.tdWV9SEqCh@kreacher> <8879480.rMLUfLXkoz@kreacher>
 <069444f7-d623-fae2-5cd0-83cbbc919aff@gmail.com> <CAJZ5v0gpodPPXTagy5gFFf6mp_jCAdc864CE_giaue72ke7UyQ@mail.gmail.com>
 <ab803fb5-045d-98dd-2754-688a916f8944@gmail.com> <d151c91c-cb65-2830-2453-a02057137400@gmail.com>
In-Reply-To: <d151c91c-cb65-2830-2453-a02057137400@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 24 Sep 2021 14:02:43 +0200
Message-ID: <CAJZ5v0howP_PudCf-43_HqgW48ydc29SeFVRC-wCm_RNKPBMtA@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] PCI: ACPI: PM: Do not use pci_platform_pm_ops for ACPI
To:     Ferry Toth <fntoth@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 23, 2021 at 10:32 PM Ferry Toth <fntoth@gmail.com> wrote:
>
> Hi
>
> Op 23-09-2021 om 15:51 schreef Ferry Toth:
> > Repost (with formatting removed, sorry for the noise)
> > Op 23-09-2021 om 13:30 schreef Rafael J. Wysocki:
> >> On Wed, Sep 22, 2021 at 11:31 PM Ferry Toth<fntoth@gmail.com>  wrote:
> >>> Hi,
> >>> Op 20-09-2021 om 21:17 schreef Rafael J. Wysocki:
> >>>> From: Rafael J. Wysocki<rafael.j.wysocki@intel.com>
> >>>>
> >>>> Using struct pci_platform_pm_ops for ACPI adds unnecessary
> >>>> indirection to the interactions between the PCI core and ACPI PM,
> >>>> which is also subject to retpolines.
> >>>>
> >>>> Moreover, it is not particularly clear from the current code that,
> >>>> as far as PCI PM is concerned, "platform" really means just ACPI
> >>>> except for the special casess when Intel MID PCI PM is used or when
> >>>> ACPI support is disabled (through the kernel config or command line,
> >>>> or because there are no usable ACPI tables on the system).
> >>>>
> >>>> To address the above, rework the PCI PM code to invoke ACPI PM
> >>>> functions directly as needed and drop the acpi_pci_platform_pm
> >>>> object that is not necessary any more.
> >>>>
> >>>> Accordingly, update some of the ACPI PM functions in question to do
> >>>> extra checks in case the ACPI support is disabled (which previously
> >>>> was taken care of by avoiding to set the pci_platform_ops pointer
> >>>> in those cases).
> >>>>
> >>>> Signed-off-by: Rafael J. Wysocki<rafael.j.wysocki@intel.com>
> >>>> ---
> >>>>
> >>>> v1 -> v2:
> >>>>       * Rebase on top of the new [1/7] and move dropping struct
> >>>>         pci_platform_pm_ops to a separate patch.
> >>> I wanted to test this series on 5.15-rc2 but this patch 2/7 doesn't
> >>> apply (after 1/7 applied). Should I apply this on another tree?
> >> This is on top of
> >> https://patchwork.kernel.org/project/linux-acpi/patch/2793105.e9J7NaK4W3@kreacher/
> >>
> >> which is not yet in any tree.
> >>
> >> Sorry for the confusion.
> > No problem at all. If I can I will try to report back tonight. Else,
> > will be delayed 2 due to a short break.
>
> With those 3 extra patches followed by 7 from this series it builds. But
> on boot I get:
> dwc3 dwc3.0.auto: this is not a DesignWare USB3 DRD Core
> Then after this it reboots. Nothing in the logs. Nothing else on
> console, I guess something goes wrong early.

It appears so.

Can you please try just the 3 extra patches this series is on top of?
The problem is more likely to be located in one of them.
