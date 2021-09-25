Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8BD4183F0
	for <lists+linux-pci@lfdr.de>; Sat, 25 Sep 2021 20:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbhIYSKr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 25 Sep 2021 14:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbhIYSKq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 25 Sep 2021 14:10:46 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94098C061570;
        Sat, 25 Sep 2021 11:09:11 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id r8so9016069uap.0;
        Sat, 25 Sep 2021 11:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WXQl6xYHyo7VmGkogOZ2uCBbLxqiVuqGmz8mDC3PsVE=;
        b=RyN3JIcFIRv5HcRDNmaJXs0sPVG3iaG8G4p6T/woxXGgGDJyMVky1Qb/UdpUe30KJp
         +hwj4SYJX0Tw1JdrdDpGF/QUcAK+lytw0/3KVJ9fUqYtKMmkuOFVTog++LIeIaMjRxS7
         MZyJiwfHQKgjw8GA1vEN/Hl+oWlY0zowHuq/qzYf3/OFMlDArg8wn5JMV5u42l16ffzp
         0ABIgaTD7jLtYx9l8N0BMAGl1kORu+SiMXzfANpYHmATBYEk8Um3/gLgPVnsbWycguiI
         3qNezo/MTSpomvZBgS72bkv5xg9MStyz0oYiGvuAtJn2HxHVPU1uFS29ywB9WDpIQE8z
         kNzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WXQl6xYHyo7VmGkogOZ2uCBbLxqiVuqGmz8mDC3PsVE=;
        b=riK0wT1tPyVChYuQ6rhtX+rgpdfYeG5I+r2C/nRX72xmRLResokX5gKU7T5/YT63uD
         fASR0huV6CWB/0UXznM7UzAaAMfWabZj37hLHsI+X06wfpo8RkVef/HZzrOWo2CxEphe
         37ydko7wlJ52YsVyARr4epg1rUv7ji7LCFvQkI+OHWIwqejWB4aYv4iLlZXipRW4lYAN
         P6tpn3dlzz4qRM70tm0oU5DvRTqsTRHE39jLd6hvQl/C6ndUD60im2V+IW1vkKpsRx+d
         e0XClttxJMZuDPYjI/PB9iQXGnBhmTbl+FQMz0KTKHKtN7h7Ba+aqyv6PHkXkQvly0Fm
         G85A==
X-Gm-Message-State: AOAM532For2f81c2ZytlWFLJ1Bh2dVsnqEdYNGeo5jYSM5Jl7UGG6/Mj
        hI8LvXgp9Xf3d55VufcqPhz0bPAwGZOOcZYTczzW6dROKmY=
X-Google-Smtp-Source: ABdhPJxwiExLM3hzBCAfYUgeYdy55lPTeSgDo0znsn0D+vbB/KiyL4ObpmWFiOfukFEJXqJwZjiYBdvVrKix1Is/cIc=
X-Received: by 2002:ab0:538b:: with SMTP id k11mr11610115uaa.131.1632593350651;
 Sat, 25 Sep 2021 11:09:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210924211139.3477-1-sergio.paracuellos@gmail.com>
 <20210924211139.3477-6-sergio.paracuellos@gmail.com> <CAK8P3a3SpuioCVBfQpHFGuNQoXG7g8w9VL+V8rYd8Q80Od89HA@mail.gmail.com>
In-Reply-To: <CAK8P3a3SpuioCVBfQpHFGuNQoXG7g8w9VL+V8rYd8Q80Od89HA@mail.gmail.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Sat, 25 Sep 2021 20:08:58 +0200
Message-ID: <CAMhs-H8jF10NpTgCP=_FEaBcedTN75b6MoyrEVrrayJEAdufwA@mail.gmail.com>
Subject: Re: [PATCH 5/6] MIPS: implement architecture dependent 'pci_remap_iospace()'
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Rob Herring <robh@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        gregkh <gregkh@linuxfoundation.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-staging@lists.linux.dev, NeilBrown <neil@brown.name>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Arnd,

On Sat, Sep 25, 2021 at 7:32 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Fri, Sep 24, 2021 at 11:11 PM Sergio Paracuellos
> <sergio.paracuellos@gmail.com> wrote:
> >
> > To make PCI IO work we need to properly virtually map IO cpu physical address
> > and set this virtual address as the address of the first PCI IO port which
> > is set using function 'set_io_port_base()'.
> >
> > Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Thanks!

>
> > +int pci_remap_iospace(const struct resource *res, phys_addr_t phys_addr)
> > +{
> > +       size_t size = (res->end - res->start) + 1;
> > +       unsigned long vaddr = (unsigned long)ioremap(phys_addr, size);
> > +
> > +       set_io_port_base(vaddr);
> > +       return 0;
> > +}
>
> It might be good to check that res->start is zero here, otherwise
> the io_port_base would be off. That could happen if you ever have more
> than one bridge.

Do you mean something like the following?

int pci_remap_iospace(const struct resource *res, phys_addr_t phys_addr)
{
    unsigned long vaddr;
    size_t size;

    if (res->start != 0) {
         // Should I WARN_ONCE or just show an error/warning message??
         WARN_ONCE(1, "resource start must be zero\n");
         return -ENODEV;
   }

     size = (res->end - res->start) + 1;
     vaddr = (unsigned long)ioremap(phys_addr, size);
     return 0;
}

Thanks,
    Sergio Paracuellos
>
>         Arnd
