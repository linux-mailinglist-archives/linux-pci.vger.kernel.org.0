Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA17D41132E
	for <lists+linux-pci@lfdr.de>; Mon, 20 Sep 2021 12:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbhITK7J (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Sep 2021 06:59:09 -0400
Received: from mail-oi1-f171.google.com ([209.85.167.171]:36387 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbhITK7I (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Sep 2021 06:59:08 -0400
Received: by mail-oi1-f171.google.com with SMTP id y201so9433652oie.3;
        Mon, 20 Sep 2021 03:57:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WnqyCun3sAWL/kGdiirlHdl/hDdczJ+E/CKgO6jqS38=;
        b=y13OxS13paZpWBbe1U4KCYtnIbnAKe2g9EMnRb03Af4bYdd3IV9gpckGeN+KHUIdyC
         tmKqmd+g9fNWFgsJ9llEhiPFuq1gMC9d5WNINqA7jjhuxzUr4VYdaxZ/UkzsZKhlDLMx
         6aoZHvE3uAxt7LTiDzkstT+CNOO6wPmri/cS5u7HZVnr1EF/vpzFwFxEHNwM1guvQxsz
         k5IUNsKDlMo6oeBc3LpCy/sidshDP3T93/k3mgBmofz686rzm61l1/m7IlgJASaJb51F
         CQny8RlZr0t8YbSvvHjeho8SDyd+ZyZNNHiwAzNOZQQDgqML98eqHRBO9XX+o5cGJnbS
         stlA==
X-Gm-Message-State: AOAM531OJWDD0v30qNxX95uSgwNKnCQA+JOcFD++/4XPIgxg1S9+UPkg
        jj4NLyRvahbQilfIkOI67/44Yfcj13VcCsSu0xM=
X-Google-Smtp-Source: ABdhPJy0DFdqF/vT0dT9lSPmkutDMqGEzj0OeH9hqR4+zMIeJoE0khIv7pJ/76blozE0wYBPlmz98W2jw8cOaI1Au50=
X-Received: by 2002:a05:6808:10ce:: with SMTP id s14mr22555906ois.157.1632135461660;
 Mon, 20 Sep 2021 03:57:41 -0700 (PDT)
MIME-Version: 1.0
References: <8003272.NyiUUSuA9g@kreacher> <1798761.CQOukoFCf9@kreacher> <CAHp75VdoFwH2sQT6dwz4BCorkgJgmYEBHq-+YpT18HZx2cpmrA@mail.gmail.com>
In-Reply-To: <CAHp75VdoFwH2sQT6dwz4BCorkgJgmYEBHq-+YpT18HZx2cpmrA@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 20 Sep 2021 12:57:27 +0200
Message-ID: <CAJZ5v0iRviZkLzRP0t2f4q5oY9y6CxRotDnyBVBt-QBt-uYReQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/5] PCI: PM: x86: Drop Intel MID PCI PM support
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
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

On Sun, Sep 19, 2021 at 10:32 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Sun, Sep 19, 2021 at 9:01 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Support for Intel MID platforms has mostly gone away with the SFI
> > support removal in commit 4590d98f5a4f ("sfi: Remove framework for
> > deprecated firmware"), but there are some pieces of it still in the
> > tree.  One of them is the MID PCI PM support code which gets in the
> > way of subsequent PCI PM simplifications and trying to update it is
> > rather pointless, so get rid of it completely along with the arch
> > code pieces that are only used by it.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > I am going to post patches removing the rest of MID support from arch/x86/
> > and elsewhere, but that is still quite a bit of stuff and I don't want this
> > simple PCI PM series to depend on that work.
>
> This is still being used by MID with ACPI assisted (*) support.
> Hence, not ack.
>
> *) ACPI layer is provided by U-Boot and can't fulfill all possible
> features that ACPI may use in the Linux kernel.

OK, good to know.

I'm not sure how this PCI PM stuff works with ACPI.  It looks like
this relies on a specific ordering of arch_initcall() calls for
correctness which is sort of fragile.
