Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6258A54FA3
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2019 15:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730414AbfFYNDi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Jun 2019 09:03:38 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:39481 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729846AbfFYNDh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Jun 2019 09:03:37 -0400
Received: by mail-io1-f67.google.com with SMTP id r185so2787736iod.6
        for <linux-pci@vger.kernel.org>; Tue, 25 Jun 2019 06:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AaAux+mpjiFWEqJlAiGOu1BVPLgrTOOP018VAUoSN3o=;
        b=lmRjWvzcBFajWRoBK3znbG6i3978d6nBbrRGi3suA6cnsxIj5JI2hVj20FLTyh+0yt
         zV7i5MYXlc52IXaOeYNjzP8Km02CfCbdrpobiwqLnmNIoJC484FCh1NAiy9uJzZ2p/ak
         mMguigzQ63Q61fPmyPDQzSrl6/Lar+u1ARJamNP1zlq85bKWUns0qMJT7D9GKH4/ZlQT
         MhwVKWJ4ICSk3sn5QpF8a4LT8tnmv8P23HsxXWL/TyRkmjtwMKIuQpXXavC4cWN0plke
         Vsdh3Ar8TJ70vtpE0ohBaHT9Xa2HP7pLyJMMHPfKOWuHJNMvCFUGK8z9SL/OONjvSnzz
         TTzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AaAux+mpjiFWEqJlAiGOu1BVPLgrTOOP018VAUoSN3o=;
        b=U8D6TFqtdGoRovuKT0BNUVR/b+skz9ebu/Q1diHZWqd+HptIBv8V5ewt1/H8uFzKBV
         DEZ1MJ3joW2GCoWmiBzjzqxa7os0ZIc3EEmsoX1YjbscJMT6cy0LX9qrtYApMdMzUrRa
         IgZoHwhtpJ0sCVt6QTRC4eVhJErmaqQxFL0zLyXKMqKQfjPLVo51SKw5KF9klqdSJHvf
         0tQ/J3/gYJ2FQVvsIE5Su4uM7/Y6VrGOGnYayEPUcbFAI9c9Z3aEJiKPUwXYO7Bm6VUm
         9j3dzsBiBu1NHC6GVxLyNkgD0xJhazprrzoEvZSmR7EmdyWOObY5z+KOU0nLEKLBLFUv
         JhXg==
X-Gm-Message-State: APjAAAXQgpkPk4tQlYwzwG74UveRVQlrEouAmZJSfH9Nz5Mg9kByoDih
        gg6KsOMEWOUB2pgYWJUexU5CQZx1rfWxiK1jpDTIuQ==
X-Google-Smtp-Source: APXvYqy4zCAKoPaPG2k29F7XqifxmNDOdW2j4TDAW8nqSYe5f3mVIHS3sMFRvz8ca5dxqSPtvcR/IL7ykacX2H/I+K4=
X-Received: by 2002:a02:54c1:: with SMTP id t184mr10221497jaa.10.1561467816781;
 Tue, 25 Jun 2019 06:03:36 -0700 (PDT)
MIME-Version: 1.0
References: <b89ef8f0-d102-7f78-f373-cbcc7faddee3@hisilicon.com> <20190625112148.ckj7sgdgvyeel7vy@localhost>
In-Reply-To: <20190625112148.ckj7sgdgvyeel7vy@localhost>
From:   Olof Johansson <olof@lixom.net>
Date:   Tue, 25 Jun 2019 15:03:25 +0200
Message-ID: <CAOesGMj+aNkOT1YVHTSBLkOfEujk7uer3R1AmE-sa1TwCijbBg@mail.gmail.com>
Subject: Re: [GIT PULL] Hisilicon fixes for v5.2
To:     Wei Xu <xuwei5@hisilicon.com>
Cc:     ARM-SoC Maintainers <arm@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, Linuxarm <linuxarm@huawei.com>,
        "xuwei (O)" <xuwei5@huawei.com>,
        John Garry <john.garry@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Zhangyi ac <zhangyi.ac@huawei.com>,
        "Liguozhu (Kenneth)" <liguozhu@hisilicon.com>,
        jinying@hisilicon.com, huangdaode <huangdaode@hisilicon.com>,
        Tangkunshan <tangkunshan@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Shiju Jose <shiju.jose@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Tue, Jun 25, 2019 at 2:04 PM Olof Johansson <olof@lixom.net> wrote:
>
> On Tue, Jun 25, 2019 at 11:23:21AM +0100, Wei Xu wrote:
> > Hi ARM-SoC team,
> >
> > Please consider to pull the following changes.
> > Thanks!
> >
> > Best Regards,
> > Wei
> >
> > ---
> >
> > The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:
> >
> >   Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)
> >
> > are available in the Git repository at:
> >
> >   git://github.com/hisilicon/linux-hisi.git tags/hisi-fixes-for-5.2
> >
> > for you to fetch changes up to 07c811af1c00d7b4212eac86900b023b6405a954:
> >
> >   lib: logic_pio: Enforce LOGIC_PIO_INDIRECT region ops are set at registration (2019-06-25 09:40:42 +0100)
> >
> > ----------------------------------------------------------------
> > Hisilicon fixes for v5.2-rc
> >
> > - fixed RCU usage in logical PIO
> > - Added a function to unregister a logical PIO range in logical PIO
> >   to support the fixes in the hisi-lpc driver
> > - fixed and optimized hisi-lpc driver to avoid potential use-after-free
> >   and driver unbind crash
>
> Merged to fixes, thanks.


This broke arm64 allmodconfig:

       arm64.allmodconfig:
drivers/bus/hisi_lpc.c:656:3: error: implicit declaration of function
'hisi_lpc_acpi_remove'; did you mean 'hisi_lpc_acpi_probe'?
[-Werror=implicit-function-declaration]



Please build and test your branches before you send pull requests, Wei.

I've dropped the branch again; please re-submit when fixed. I think
it's probably 5.3 material now.


-Olof
