Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B19124CDDD
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jun 2019 14:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731651AbfFTMmR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Jun 2019 08:42:17 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:42439 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731175AbfFTMmR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Jun 2019 08:42:17 -0400
Received: by mail-io1-f66.google.com with SMTP id u19so462778ior.9
        for <linux-pci@vger.kernel.org>; Thu, 20 Jun 2019 05:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oEI7F/AbEhScv3JnMYlB7Pd/hzM4EXTzmC95auXuTwE=;
        b=BWIZu1WkOi4mG09pZuVLraenQ5r3WFzHz+rr+WaW3hWkxe0XX8c1yhGBpP2xGI+8VO
         g833PXYqSzTouCtTuOa0scSHSdZmcaG937NuYsZe1WZBNaXrhDrUrnfu2i0eAUJsK2Zz
         sDMrA2iux2hUIvQREc1CjSf50GBP8mljYmtkTohchCrNO410WVTBnGpxqpEi0/TSsRiw
         XOS/wb9mID5DzAkoYJ2DCMxiS0jcHNJ/KsfvAv1KSU7AaFcTQfFK7Af86qWindUttg0d
         NKz8LUkNAwMJSx9hLW5INTOHG3dvaW03ULFRXEDR3zImfXON4wZp3wG0UyoAR64Mui7Z
         G9BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oEI7F/AbEhScv3JnMYlB7Pd/hzM4EXTzmC95auXuTwE=;
        b=Eeq+YEnTTgx6t4jBkqcv4o8TpcoU+qSbidTmgVASn40uz8vFKd3xbNiyA89pw0MDgR
         +EtL4IPXodb7gDfqq1LiQpy16nBwaRhM7tc3L3j3I1k+2Pihuhol+pLgDeD9N7UOJWYF
         R8in+vZDlAfPWs2hpDcY8l1Zqa3X0OJlhpv1hkFx4iYepViZQe+J6VAveBAfeU62J60I
         kMo5arIY9fsJiQQiCpidojC0iffoB91V/5VdXtC5BwnxI1pGqzh9ZTQIZRasww9aCeRk
         4FbB0NLayd6Yl6h9vNmzMZG3hyru+/Wzdrv7HKLAb9Ru7u33ZYeUb4ZI1QuC2I9UjrMa
         3N1g==
X-Gm-Message-State: APjAAAXSVc1aPGUTx8auGBkjGuc1kzM8p/sxQY6u1BJfxKkVRjt0qCsn
        ykOHizA96rnpTKicz9s0cmjY5GyZdK2fA5lBaQYR1A==
X-Google-Smtp-Source: APXvYqzUVpdJZiYVJc2nOtwnAx7L80BlUbFIa6SF/JjPAj5ZnIFu33ZgGDq5ZAZL6WidQZD0F1mwEhz3Zm0gCUgJiv4=
X-Received: by 2002:a02:394c:: with SMTP id w12mr154066jae.126.1561034534821;
 Thu, 20 Jun 2019 05:42:14 -0700 (PDT)
MIME-Version: 1.0
References: <1561026716-140537-1-git-send-email-john.garry@huawei.com>
In-Reply-To: <1561026716-140537-1-git-send-email-john.garry@huawei.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Thu, 20 Jun 2019 13:42:03 +0100
Message-ID: <CAOesGMg+jAae5A0LgvBH0=dF95Y208h0c5RZ6f0v6CVUhsMk4g@mail.gmail.com>
Subject: Re: [PATCH 0/5] Fixes for HiSilicon LPC driver and logical PIO code
To:     John Garry <john.garry@huawei.com>
Cc:     xuwei5@huawei.com, Bjorn Helgaas <bhelgaas@google.com>,
        Linuxarm <linuxarm@huawei.com>,
        ARM-SoC Maintainers <arm@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org, Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi John,

For patches that go to a soc maintainer for merge, we're asking that
people don't cc arm@kernel.org directly.

We prefer to keep that alias mostly for pull requests from other
maintainers and patches we might have a reason to apply directly.
Otherwise we risk essentially getting all of linux-arm-kernel into
this mailbox as well.


Thanks!

-Olof

On Thu, Jun 20, 2019 at 11:33 AM John Garry <john.garry@huawei.com> wrote:
>
> As reported in [1], the hisi-lpc driver has certain issues in handling
> logical PIO regions, specifically unregistering regions.
>
> This series add a method to unregister a logical PIO region, and fixes up
> the driver to use them.
>
> RCU usage in logical PIO code looks to always have been broken, so that
> is fixed also. This is not a major fix as the list which RCU protects is
> very rarely modified.
>
> There is another patch to simplify logical PIO registration, made possible
> by the fixes.
>
> At this point, there are still separate ongoing discussions about how to
> stop the logical PIO and PCI host bridge code leaking ranges, as in [2].
>
> Hopefully this series can go through the arm soc tree and the maintainers
> have no issue with that. I'm talking specifically about the logical PIO
> code, which went through PCI tree on only previous upstreaming.
>
> Cc. linux-pci@vger.kernel.org
>
> [1] https://lore.kernel.org/lkml/1560770148-57960-1-git-send-email-john.garry@huawei.com/
> [2] https://lore.kernel.org/lkml/4b24fd36-e716-7c5e-31cc-13da727802e7@huawei.com/
>
> John Garry (5):
>   lib: logic_pio: Fix RCU usage
>   lib: logic_pio: Add logic_pio_unregister_range()
>   bus: hisi_lpc: Unregister logical PIO range to avoid potential
>     use-after-free
>   bus: hisi_lpc: Add .remove method to avoid driver unbind crash
>   lib: logic_pio: Enforce LOGIC_PIO_INDIRECT region ops are set at
>     registration
>
>  drivers/bus/hisi_lpc.c    | 43 ++++++++++++++++++---
>  include/linux/logic_pio.h |  1 +
>  lib/logic_pio.c           | 78 ++++++++++++++++++++++++++++-----------
>  3 files changed, 95 insertions(+), 27 deletions(-)
>
> --
> 2.17.1
>
