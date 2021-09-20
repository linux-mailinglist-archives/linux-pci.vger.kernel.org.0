Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE081411334
	for <lists+linux-pci@lfdr.de>; Mon, 20 Sep 2021 12:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234421AbhITLAK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Sep 2021 07:00:10 -0400
Received: from mail-oi1-f172.google.com ([209.85.167.172]:37661 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232312AbhITLAJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Sep 2021 07:00:09 -0400
Received: by mail-oi1-f172.google.com with SMTP id w206so12532507oiw.4;
        Mon, 20 Sep 2021 03:58:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MYrBWTqRqmFwyjRt4MjdtbzQLcVjOOJiZq8OrBBEMY0=;
        b=O+tU0tRu7JZhQVObRwTSQVe8ApU/YNH85W8TPZuOPcS4SqA+VtEIvtfwFxnCpGUx9A
         seFPvCVH1tTFQqfpsRarZBJHPJmGajeaWbU2Be5ABwRdFm9boIBD3MSZ6Um8QrTwlWsf
         milfJhY99KPKyCgT63fItHhAj5peGChJik2LOsM6aSRSCTzaYurLuHjIob1JvbUXspHW
         nuyU5gJh3yowG1D5TU/6ecT4EM9fMQJPlbCS+mdto0V7fXbnDR9sTIPGmukGxvNH2x6p
         nM908zY9VrbkzHoTy6Wpj5NGGKVpNNZg2LesePtZXm0YXACJC1abVuMFgk5cnfuhI2+5
         Sdrg==
X-Gm-Message-State: AOAM5301BC0ssWOrahbgrQC+JV2IVyfyTvBhn+Onj+jupQgeXHf6IJrh
        2hP6mgcyIhxbs/eDlMFgi7T1inYNs9WxQgA5dPA=
X-Google-Smtp-Source: ABdhPJwKSlKE6VPxmFyhVKDluNKCLco6WzbfdtQIa3vuSJ70sKyXjaZJ48Z8+ukg9D/z5dpVbC7wCBbSzcnZtmM1+c4=
X-Received: by 2002:a05:6808:10c1:: with SMTP id s1mr12204133ois.69.1632135522178;
 Mon, 20 Sep 2021 03:58:42 -0700 (PDT)
MIME-Version: 1.0
References: <8003272.NyiUUSuA9g@kreacher> <1798761.CQOukoFCf9@kreacher> <70cc742c-f015-9e14-9584-c3415e15085a@gmail.com>
In-Reply-To: <70cc742c-f015-9e14-9584-c3415e15085a@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 20 Sep 2021 12:58:27 +0200
Message-ID: <CAJZ5v0htRJ-r4LeajQXn2VwkfBjJ3K0yBYo9KWp9Zu5m-=kpVw@mail.gmail.com>
Subject: Re: [PATCH v1 1/5] PCI: PM: x86: Drop Intel MID PCI PM support
To:     Ferry Toth <fntoth@gmail.com>
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

On Sun, Sep 19, 2021 at 11:11 PM Ferry Toth <fntoth@gmail.com> wrote:
>
> Hi,
>
> Op 18-09-2021 om 15:21 schreef Rafael J. Wysocki:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Support for Intel MID platforms has mostly gone away with the SFI
> > support removal in commit 4590d98f5a4f ("sfi: Remove framework for
> > deprecated firmware"), but there are some pieces of it still in the
> > tree.  One of them is the MID PCI PM support code which gets in the
> > way of subsequent PCI PM simplifications and trying to update it is
> > rather pointless, so get rid of it completely along with the arch
> > code pieces that are only used by it.
>
> Removing PM support for MID will break (among others) Intel Edison,
> which is currently in use and running up to date vanilla kernel (v5.14)
> and user space.
>
> I would happily test updates PM when they appear.

Thanks for the information, I'll use a different approach then.
