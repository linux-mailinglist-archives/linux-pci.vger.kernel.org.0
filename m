Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1428A370099
	for <lists+linux-pci@lfdr.de>; Fri, 30 Apr 2021 20:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbhD3SgE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Apr 2021 14:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbhD3SgD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Apr 2021 14:36:03 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6283C06174A;
        Fri, 30 Apr 2021 11:35:11 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id b21so8578201plz.0;
        Fri, 30 Apr 2021 11:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q4QFQGXIhykAw/4JLDw3bDN7aa3oAVb41+jlAtxjgCA=;
        b=OixQfk3Gq/u0S4G7tcJWjb5zHz46vKlQxyGxNW9679LKWcMndd6kqcZFT0XJFDSG5x
         a9QDkgo7ySgdIPZ6CSCR5ZisJo4+LUf923AE0I6V2q/4v0FwRHOZkE93aX4tgxzlGtW5
         g53vlfNZNrToZ8Ji9xE0f3UvDrH4cuuM2ZiDwxUEx/TiqY91lzsRgnKcUzj7ZCODDyUh
         DYN1k/Rhdpi3UXLwW2tyeNK7uehmn6TWW28SCT0mFuqb8fAaoG522OpHWRIh/opN7BSV
         i5P/KSub7ypVL2boEdYRY35HWmQZCZm57GYP5PX64igQ/wx867tkkzjfuko0Pp84k7ch
         HmwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q4QFQGXIhykAw/4JLDw3bDN7aa3oAVb41+jlAtxjgCA=;
        b=WUbXj6OW4bxXWp9bP5yy12H+sVB0RdYgB9xWhzta28+DmFAV37Vc2YtsqXSzZHLCI7
         Pg0fkECPNxDttL1sfqnSMCZvNPQ4d+0+A/K7BWJBQFhkvvhMVP65m3KP/3+Az6yRT6ey
         IcpZzzpCobxHG8vfF5I7aY+N+yPkAZ7ReS+2UiYrJPG5Wd6wfb0JJXFO2VPs18oGMrXw
         0Otfv1/NzBWYTX3CdAzbGRFSHA+nZpIWViC7oZ1IEhJjwja4ZUlKO7MM6GxwCzW7dxl2
         1C+/wX0zthsmdCI3pqzGlPGfi26Kr91Mo2DjE8I7fUt7Y04iLKsbu6LoLxI29peGEQs+
         ZIEw==
X-Gm-Message-State: AOAM5337lvde0b656CDAnM32LZQ3Rw9RioXZfifh/DodmkSNBvDmCjsQ
        giTfGVN13+4m+44OxWy7lLb11wiYbOjzu0PAHyg=
X-Google-Smtp-Source: ABdhPJzbfKMnL+zQ8y6n+7TJjSrQeF7FzmUD31QF0cQgEe2x46yJ+iL9hUUEUUpzmC4Chu0iO4MVARCs88qp+/zahDA=
X-Received: by 2002:a17:902:ecc6:b029:ee:af8f:899e with SMTP id
 a6-20020a170902ecc6b02900eeaf8f899emr437401plh.21.1619807711284; Fri, 30 Apr
 2021 11:35:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210421140436.3882411-1-arnd@kernel.org> <20210430175723.GA664165@bjorn-Precision-5520>
In-Reply-To: <20210430175723.GA664165@bjorn-Precision-5520>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 30 Apr 2021 21:34:55 +0300
Message-ID: <CAHp75Vchfem1OmR=2Mawiebw-zisU57BEcF64PUKcOODeiLS-g@mail.gmail.com>
Subject: Re: [PATCH] nvme: fix unused variable warning
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Prike Liang <Prike.Liang@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rajat Jain <rajatja@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 30, 2021 at 8:57 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Wed, Apr 21, 2021 at 04:04:20PM +0200, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > The function was introduced with a variable that is never referenced:
> >
> > drivers/pci/quirks.c: In function 'quirk_amd_nvme_fixup':
> > drivers/pci/quirks.c:312:25: warning: unused variable 'rdev' [-Wunused-variable]
> >
> > Fixes: 9597624ef606 ("nvme: put some AMD PCIE downstream NVME device to simple suspend/resume path")
>
> I guess this refers to https://lore.kernel.org/linux-nvme/1618458725-17164-1-git-send-email-Prike.Liang@amd.com/
>
> But I don't know what the SHA1 means; I can't find it in linux-next or
> my tree.

$ git tag --contains 9597624ef606
next-20210416
next-20210419
next-20210420

Something is wrong with your tree.

-- 
With Best Regards,
Andy Shevchenko
