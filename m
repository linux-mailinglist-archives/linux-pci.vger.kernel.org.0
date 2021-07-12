Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3153C66C5
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jul 2021 01:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233453AbhGLXKy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Jul 2021 19:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233227AbhGLXKy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Jul 2021 19:10:54 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8562C0613DD;
        Mon, 12 Jul 2021 16:08:04 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id x16so9195448plg.3;
        Mon, 12 Jul 2021 16:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4pQlPWeYDasqT5HSwq98XRlnC0Bt0+1EaZmNOibXW04=;
        b=Yw3FqYsR8SI3j7U39sRckJQB5mg/EWKrrV5SEZSYye2fX8jrsH4vPluQayT/7/IhXr
         6agWVqffEsFS1ZF2Df8T3XP4sAia8Z8f/53QpJOqsTVOkGrFgwfdFm6P7kLGFTRzMWfQ
         Il78xfjXKZcgDQzaI53AzPyy+vxsn8eD9UaOqGM7XSqUuu4VSYRFQv3QxeMi+N8CRS1A
         zpnztX//YHHq+8jAjdrqXr5sigfuIqTJRYVLvv+/5QO0i+rV952c1N5dmlQKn/dvdR78
         PpOlpC08tSIn/J5civ1yvwKBRlRoUffVJvqKLfU0zlhVV4DFRGKUsfiD0gdr8W4YJSia
         NKVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4pQlPWeYDasqT5HSwq98XRlnC0Bt0+1EaZmNOibXW04=;
        b=CrIwWZUn0bqvDd8p/iGCievlNco4SeOiyVDfnDQ1CKKk7kxkXqoT3b88i8s1PjdDGw
         4oIG+m39iW51/xwnKFwufD+IOM906R/VkqhHAQARYh38sI55kGq/67wm+H+G/tXipkGZ
         bqKDuvHXi0LGmIZsc3JGZPOh6cpeoGU6vYu6Y+25BAdBS7XeIwW0+bGh0e+o/zuF9+cp
         WMKrNnRNTXXjrMIl12Dtad2UjjebEluDhPcpTZBDJHSqGggH3+1zHY5AaKNmBrsP1wUc
         an/SeJHPf+XYHiW7KeGg5P70lj3LVVQlzL4syiPNaypCbtmRaaKFZ6ZZmMckEjI9+/MD
         H3Qw==
X-Gm-Message-State: AOAM530NsmQ7yoc59OkwBe86hWkJwteQ5OleMDScoUXObGIouPeoeJF/
        v9tnluOBbVi4U/xbR096U3fYMM/+JQqbc+X0G44=
X-Google-Smtp-Source: ABdhPJwl/cs7gjt7UJvM1RfNNXWnPv2JwXE2ke1+At2e0tEfL/PE79WKC/dXpX7uZcwpL8qyXTn3xOsnANHWEcUeh70=
X-Received: by 2002:a17:90a:17ad:: with SMTP id q42mr16378709pja.181.1626131284145;
 Mon, 12 Jul 2021 16:08:04 -0700 (PDT)
MIME-Version: 1.0
References: <YOwr/GMIExCoNjeZ@smile.fi.intel.com> <20210712223631.GA1682719@bjorn-Precision-5520>
In-Reply-To: <20210712223631.GA1682719@bjorn-Precision-5520>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 13 Jul 2021 02:07:27 +0300
Message-ID: <CAHp75VfDcQXqmK9=4k4rqi7t2OZaVPC13b45vLY7fELr7zBG_Q@mail.gmail.com>
Subject: Re: [Linux-kernel-mentees] [PATCH v1] gpio: ml: ioh: Convert to dev_pm_ops
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 13, 2021 at 1:36 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Mon, Jul 12, 2021 at 02:48:12PM +0300, Andy Shevchenko wrote:
> > On Thu, Jul 08, 2021 at 04:47:06PM -0500, Bjorn Helgaas wrote:
> > > On Thu, Apr 02, 2020 at 11:23:27PM +0300, Andy Shevchenko wrote:

...

> > Datasheets are publicly available (at least one may google and find some
> > information about those PCH chips). I have in possession the hardware for
> > gpio-pch. I can easily test that part at least.
>
> If you have a URL for those datasheets, can you share it?  I spent
> some time looking but all I found was 1-2 page marketing brochures.

It's a part of the so called EG20T PCH. It's part of in particular
Intel Galileo (Quark SoC) and Intel Minnowboard (v1) (Atom E6xx SoC).
Hence the easily found links:

http://minnowboard.outof.biz/MinnowBoard.html
https://www.elinux.org/Minnowboard:Minnow_Original
https://en.wikipedia.org/wiki/List_of_Intel_Atom_microprocessors

https://www.intel.com/content/www/us/en/embedded/products/quark/x1000/documentation.html?grouping=EMT_Content%20Type&sort=title:asc
(Chapter 19)

https://ark.intel.com/content/www/us/en/ark/products/codename/37567/products-formerly-tunnel-creek.html

Hmm... Funny, the document #324211 can't be downloaded
https://download.intel.com/embedded/chipsets/datasheet/324211.pdf

I guess you may ping Intel and tell them that they should play nice
when talking about "open hardware" (MinnowBoard initiative).
Nevertheless, the (Old? #457798 is a specification update under NDA.
Okay, it refers to rev 8, while Mouser, see below, provides rev 9)
copy is available on other sites, such as

https://www.mouser.tw/pdfdocs/Intel_Platform_Controller_Hub_EG20T_datasheet.pdf
(Chapter 16)

> > > that's not a trivial task, and I don't think that burden should fall
> > > on anyone who wants to make any improvements to these drivers.
> >
> > > Another alternative would be to remove legacy PCI PM usage
> > > (ioh_gpio_suspend() and ioh_gpio_resume()) from gpio-ml-ioh.  That
> > > would mean gpio-ml-ioh wouldn't support power management at all, which
> > > isn't a good thing, but maybe it would be even more motivation to
> > > unify it with gpio-pch (which has already been converted by
> > > 226e6b866d74 ("gpio: pch: Convert to dev_pm_ops"))?
> >
> > With regard to (1) probably we may exceptionally accept the fix to
> > gpio-ml-ioh, but I really prefer to do the much more _useful_ job on
> > it by unifying the two.
>
> Should Vaibhav re-post this patch, or do you want to pull it from the
> archives?  I just checked and it still applies cleanly to v5.14-rc1.
>
> Here it is for reference:
>   https://lore.kernel.org/lkml/20200402155057.30667-1-vaibhavgupta40@gmail.com/

I'll take from the archives.

> I'll post a couple small patches toward unifying them.  They don't do
> the whole job but they're baby steps.

Thanks! I look forward to seeing them soon!

-- 
With Best Regards,
Andy Shevchenko
