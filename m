Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74DFA415CD3
	for <lists+linux-pci@lfdr.de>; Thu, 23 Sep 2021 13:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240570AbhIWLcL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Sep 2021 07:32:11 -0400
Received: from mail-ot1-f45.google.com ([209.85.210.45]:37411 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238930AbhIWLcL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Sep 2021 07:32:11 -0400
Received: by mail-ot1-f45.google.com with SMTP id r43-20020a05683044ab00b0054716b40005so1162811otv.4;
        Thu, 23 Sep 2021 04:30:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mj4OxXI4XfSiJjpB6gp8VGD37CgIAndA8AQf4u3Q5R8=;
        b=wNePgff2IzH3h/elMnNhEfkl0npvguwXZ6pXYBMgkxM4Il8/j0xFnOcvtcecGtqa21
         sYguBQvunlRIxlj1JooLORcqImD1otUmJvGEr7FUi4OWerPIC/44NQzW7t/VJP7UXdTy
         bMO4pSQWA4sMIEI2FRTP7twEjYMnCRHS22eim4Nf6kVKGzi917wZY6ZH7d94mZtG4yAE
         Yna6MoO8f+jFI9H6zbhf8zScyNX1b4jfJUU7jGRxnQZFCGgQjZC7tqOwHijqppkUxN+h
         70zxtKnIZRl8fdemWwALhc42VUZK+5/rKXORhPYzV8wCZaKWj+/0VndbbG2ov9fgqc1O
         TaaA==
X-Gm-Message-State: AOAM532HKaPJwXPr7wAKPW+cBH12OVAPvPjQbci0YVQEbY5Ah39c13bP
        TkSpdobulLapx0ZDtQ6n5XsH1dnjw7+FfwSYOud2jLJFWbM=
X-Google-Smtp-Source: ABdhPJx6nGVkjtwq2y50SADaDVaDXja5cZhtZ7X90J5t0B7RFrK/17KrYhZT3Y2sH1FH6QPqxxeWGYGxQkOZuRhc8eM=
X-Received: by 2002:a9d:4d93:: with SMTP id u19mr3871082otk.86.1632396639512;
 Thu, 23 Sep 2021 04:30:39 -0700 (PDT)
MIME-Version: 1.0
References: <1800633.tdWV9SEqCh@kreacher> <8879480.rMLUfLXkoz@kreacher> <069444f7-d623-fae2-5cd0-83cbbc919aff@gmail.com>
In-Reply-To: <069444f7-d623-fae2-5cd0-83cbbc919aff@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 23 Sep 2021 13:30:28 +0200
Message-ID: <CAJZ5v0gpodPPXTagy5gFFf6mp_jCAdc864CE_giaue72ke7UyQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] PCI: ACPI: PM: Do not use pci_platform_pm_ops for ACPI
To:     Ferry Toth <fntoth@gmail.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
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

On Wed, Sep 22, 2021 at 11:31 PM Ferry Toth <fntoth@gmail.com> wrote:
>
> Hi,
> Op 20-09-2021 om 21:17 schreef Rafael J. Wysocki:
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
> > ---
> >
> > v1 -> v2:
> >      * Rebase on top of the new [1/7] and move dropping struct
> >        pci_platform_pm_ops to a separate patch.
>
> I wanted to test this series on 5.15-rc2 but this patch 2/7 doesn't
> apply (after 1/7 applied). Should I apply this on another tree?

This is on top of
https://patchwork.kernel.org/project/linux-acpi/patch/2793105.e9J7NaK4W3@kreacher/
which is not yet in any tree.

Sorry for the confusion.
