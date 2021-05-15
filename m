Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77615381599
	for <lists+linux-pci@lfdr.de>; Sat, 15 May 2021 05:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234256AbhEODvI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 May 2021 23:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbhEODvI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 May 2021 23:51:08 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22666C06174A
        for <linux-pci@vger.kernel.org>; Fri, 14 May 2021 20:49:55 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id z24so743407ioi.3
        for <linux-pci@vger.kernel.org>; Fri, 14 May 2021 20:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y3PK4jbKqiW+XVFcq3JRydzq2tY3j6GhXoQ+R5OrsJU=;
        b=bErGrZfNSiBIanLeJOH8IYsN7n4ZrI88uz71I5DcfSACNwIYTUYMGeYo7KO3xl1+FR
         O7pPgxGsak+z+LAhuNaYhlyvCm2/nNa/OYrDH1kr2WAebbiL1nKzfAht7Q88mSRjUSpK
         +f9a1gVrv7dNeJMheIYvNy4NX2B7GY3NeJGwZgMS0KYZ71DYZZ7fPvEeUwOyAHFfZ/2M
         5CUyK51uV9Fweef7+aVJN+RSpS3h6jjAGS24Fskvzk7Y1g1F3xf9hWfAgy+w7HEBoC5U
         4GWor/R81rxXmKrptGG5Hjagx1nNVQKcUF0vjpW7M69MpdI+wpvGv8O4BkpBMaS4R6iM
         1xNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y3PK4jbKqiW+XVFcq3JRydzq2tY3j6GhXoQ+R5OrsJU=;
        b=Ir5YFeMcWPUGtMIgKeLH6iNYEIMXUBZG1o6eP0QHC0DrorMjPSYfbfD8g/gfn+70ze
         WzR/7vdqnadbT70K127q1Ysnmtjv8aFOhE7+bb6BubgyN5ugTO9ULEW+Okx6lLHe5OZ5
         zpMY8XXRFbsdQzJfDRVyOVnQRYjizRtW+wPNnl+7yRCoUNanBhBCn0/51LtjuZjrVUZD
         2KPkYK3BjaOsAI+A1GPMffvlkxdPf/JrSsNDLSQGlz6ZIvzLnIIBtOXr3yja0rkVM9TH
         sYSecR3pJRzo8Xr/aJiPb7o7VAzrvvbUVKFQ1f3zDDiEjvHdCFCuLyfQxB5Pg8eaApKI
         Yu/w==
X-Gm-Message-State: AOAM531lp6Dp65nZIG9ARZbOGOBCtbunCiYqewNSQW4UHyxhWYUDYiqp
        YllJtgdAqhuJyrDnMhVfQ1yMiTZSwF5oMIzOQlpdY9s/0jI=
X-Google-Smtp-Source: ABdhPJzsLFwp9VltRuN2fx/xkH1GaAehQPHnFn00RiBEb9oYpZtwJ2y4CSxuOBU8bzRsVlAvwgamZH9eUjrODxaTU0E=
X-Received: by 2002:a5d:8843:: with SMTP id t3mr7558340ios.148.1621050594616;
 Fri, 14 May 2021 20:49:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210514080025.1828197-4-chenhuacai@loongson.cn> <20210514153959.GA2762101@bjorn-Precision-5520>
In-Reply-To: <20210514153959.GA2762101@bjorn-Precision-5520>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Sat, 15 May 2021 11:49:43 +0800
Message-ID: <CAAhV-H4cH40d++SQ+sNXtjh_arC1ASPfRCdLsGtBoTnTWwB6aQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] PCI: Improve the mrrs quirk for LS7A
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>, huangshuai@loongson.cn
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi, Krzysztof and Bjorn

I will improve my spelling, and others see below.

On Fri, May 14, 2021 at 11:40 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Fri, May 14, 2021 at 04:00:23PM +0800, Huacai Chen wrote:
> > In new revision of LS7A, some pcie ports support larger value than 256,
> > but their mrrs values are not dectectable. And moreover, the current
> > loongson_mrrs_quirk() cannot avoid devices increasing its mrrs after
> > pci_enable_device(). So the only possible way is configure mrrs of all
> > devices in BIOS, and add a pci dev flag (PCI_DEV_FLAGS_NO_INCREASE_MRRS)
> > to stop the increasing mrrs operations.
>
> s/mrrs/MRRS/
> s/dectectable/detectable/
>
> This doesn't make sense to me.  MRRS "sets the maximum Read Request
> size for the Function as a Requester" (PCIe r5.0, sec 7.5.3.4).
>
> The MRRS in the Device Control register is a 3-bit RW field (or a RO
> field with value 000b).  If it's RW, software is allowed to write any
> 3-bit value to it.  There is no "maximum allowed value" for software
> to detect.
>
> The value software writes is only a *limit* on the Read Request size.
> The hardware is never obligated to generate Read Requests of that max
> size.  If software writes 101b (4096 byte max size), and the hardware
> only supports generating 128-byte Read Requests, there's no issue.
> It's perfectly fine for the hardware to generate 128-byte requests.
>
> Apparently something bad happens if software writes something "too
> large" to MRRS?  What actually happens?
>
> If the problem is that the device generates a large Read Request and
> in response, it receives a data TLP that is larger than it can handle,
> that sounds like an MPS issue, not an MRRS issue.
>
> Based on the existing loongson_mrrs_quirk(), it looks like this is a
> long-standing issue.  I'm sorry I missed this when reviewing the
> driver in the first place.  This all needs a much better explanation
> of what the real problem is.  The "h/w limitation of 256 bytes maximum
> read request size" comment just doesn't make sense from the spec point
> of view.
>
> I do know that Linux uses MRRS and MPS in ... highly unusual ways, and
> maybe we're tripping over that somehow.  If so, we need to figure out
> exactly how so we can make Linux's use of MPS and MRRS better overall.
I have discussed with Shuai Huang (the main designer of LS7A), he said
that some devices (such as Realtek 8169) usually write a large value
to MRRS in its driver. And that usually larger than LS7A bridge can
handle, the quirk in this patch is avoid device driver to increase
MRRS (and BIOS initialize a reasonable value at power on stage).

Huacai
>
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >  drivers/pci/pci.c    | 5 +++++
> >  drivers/pci/quirks.c | 6 ++++++
> >  include/linux/pci.h  | 2 ++
> >  3 files changed, 13 insertions(+)
> >
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index b717680377a9..6f0d2f5b6f30 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -5802,6 +5802,11 @@ int pcie_set_readrq(struct pci_dev *dev, int rq)
> >
> >       v = (ffs(rq) - 8) << 12;
> >
> > +     if (dev->dev_flags & PCI_DEV_FLAGS_NO_INCREASE_MRRS) {
> > +             if (rq > pcie_get_readrq(dev))
> > +                     return -EINVAL;
> > +     }
> > +
> >       ret = pcie_capability_clear_and_set_word(dev, PCI_EXP_DEVCTL,
> >                                                 PCI_EXP_DEVCTL_READRQ, v);
> >
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index 66e4bea69431..10b3b2057940 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -264,6 +264,12 @@ static void loongson_mrrs_quirk(struct pci_dev *dev)
> >                * any devices attached under these ports.
> >                */
> >               if (pci_match_id(bridge_devids, bridge)) {
> > +                     dev->dev_flags |= PCI_DEV_FLAGS_NO_INCREASE_MRRS;
> > +
> > +                     if (pcie_bus_config == PCIE_BUS_DEFAULT ||
> > +                         pcie_bus_config == PCIE_BUS_TUNE_OFF)
> > +                             break;
> > +
> >                       if (pcie_get_readrq(dev) > 256) {
> >                               pci_info(dev, "limiting MRRS to 256\n");
> >                               pcie_set_readrq(dev, 256);
> > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > index c20211e59a57..7fb2072a83b8 100644
> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -227,6 +227,8 @@ enum pci_dev_flags {
> >       PCI_DEV_FLAGS_NO_FLR_RESET = (__force pci_dev_flags_t) (1 << 10),
> >       /* Don't use Relaxed Ordering for TLPs directed at this device */
> >       PCI_DEV_FLAGS_NO_RELAXED_ORDERING = (__force pci_dev_flags_t) (1 << 11),
> > +     /* Don't increase BIOS's MRRS configuration */
> > +     PCI_DEV_FLAGS_NO_INCREASE_MRRS = (__force pci_dev_flags_t) (1 << 12),
> >  };
> >
> >  enum pci_irq_reroute_variant {
> > --
> > 2.27.0
> >
