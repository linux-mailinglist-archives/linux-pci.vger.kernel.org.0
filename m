Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0F9418390
	for <lists+linux-pci@lfdr.de>; Sat, 25 Sep 2021 19:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbhIYReF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 25 Sep 2021 13:34:05 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:37389 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbhIYReF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 25 Sep 2021 13:34:05 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MxUfn-1mnker1G6j-00xqPp; Sat, 25 Sep 2021 19:32:28 +0200
Received: by mail-wr1-f47.google.com with SMTP id t18so37441161wrb.0;
        Sat, 25 Sep 2021 10:32:28 -0700 (PDT)
X-Gm-Message-State: AOAM532VW9e3tSTXVFytoQOU+xOIztS6vPebbvsQ+0iznf2cd9EAOhk9
        Z5ujwgzoynTyLZw0DQp3RKTPgCTzAv3q4eEOqHY=
X-Google-Smtp-Source: ABdhPJwATFoMtLfM82dbiwbfY0GKoVgPll7guJJPZ4SlMDyVpnybiZOiHpV2yuRbCNlpS7w6kjrpn7CdgtMxMmMrKi0=
X-Received: by 2002:adf:f481:: with SMTP id l1mr18158744wro.411.1632591147944;
 Sat, 25 Sep 2021 10:32:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210924211139.3477-1-sergio.paracuellos@gmail.com> <20210924211139.3477-6-sergio.paracuellos@gmail.com>
In-Reply-To: <20210924211139.3477-6-sergio.paracuellos@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 25 Sep 2021 19:32:12 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3SpuioCVBfQpHFGuNQoXG7g8w9VL+V8rYd8Q80Od89HA@mail.gmail.com>
Message-ID: <CAK8P3a3SpuioCVBfQpHFGuNQoXG7g8w9VL+V8rYd8Q80Od89HA@mail.gmail.com>
Subject: Re: [PATCH 5/6] MIPS: implement architecture dependent 'pci_remap_iospace()'
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        gregkh <gregkh@linuxfoundation.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-staging@lists.linux.dev, neil@brown.name,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:z1A2KwAlDVKgQ9R2BTxeV0qDqwwnA6UG2aXvSweb+1hWygHPTf2
 AnBx/YyA+/aCuzOWBAWKXEcvIlKAlmiYjFcFlenk8lGJdjqv7mP0U1q5WA0PngXOcsT21Ic
 g+XGEKSmGhcbMtS2OTlKpFBYicSW/R05F1UVipkeZDPAMi4W/LjLIJfwXDcj6liLCJajaE1
 snpu0joEB9Lbcu1JZejGw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:rDk+CQ70ebI=:qVrEYAsiT3PSydjldOOVBZ
 olzrxDKovhFmI2TFws3jCi1d9YtIUSk8l5ADig0QasAdu8VBOxwYfvhF5qCuTOeX5bv94c8Oz
 vmo8bYlgMrxJmCPQDeqO2fDF34CVabUNmhHsN9JRq462OVeJEOwoSIwkJ+u7R6aeKJFVqjoeZ
 HqRuu3gne8me+HWX9nAsHb2cifDWqOOlR8YiFuO2w/fhZFDKbHr7fThHQkVV/5CwQHJU89nb2
 6aI68Nuhu/QhYFZbWDwdJaPEW/FCDxtcrTTgkL4HlHclI+rH8UQwWX3zrheplEF+/6McBG6KD
 xFwAEBBT0H4qj34Z5/c80LpSy8Ld2JZbdRjLU4XF4ZGFFIFGqR0jmGgW14q7mhJuaDDTFZbo5
 1ukdeKyjpE79XKLbRGfm5ZeU/QsXhEKaU1F/Mmp6LlNIi4HQAIfpL1Z3u8Dbjtw6rMOXT4l1N
 qpxE0tqJ8gLFscnNKKwIYme0zcDgwmVxsuVYS9s1/652vbvhik2yKpSGnurnu1qv2oMpLJDET
 5d4u/P8s7nRtTTKlX7vVM9lSFvWp2POG6H56CRTbv2iMUL16bIoTvrNveJaKW4PjNllKJN4aB
 oV9ndXw9U0e34D/jM7bSZwyHlGRfQr0B3MFtjoqshsDIX4ps+h7dWztGOSCeV+KnEqScz+ZAT
 Kbqyl9FirEY5FXkNut2qM3kUa9vU5l6s1+cA35+otweVhaHf9Ug3FsnopnU5KQ+J2ZzZ6QwGl
 nAepfokNeJWYl11hQha+NwQVg3CBPBdStZUgHRVKhYEZ+m48MR/j0Y/jBgmqMmKmRghSlXOOP
 pyCBHeLHm0hQXyEgOnA/OrsO2Q8T4Ug9DE3eH/9gMmqImYkhf6yNYUoCy64txZtn1cuV/9okb
 ft14OfoWfDWgjrXBhbDQ==
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 24, 2021 at 11:11 PM Sergio Paracuellos
<sergio.paracuellos@gmail.com> wrote:
>
> To make PCI IO work we need to properly virtually map IO cpu physical address
> and set this virtual address as the address of the first PCI IO port which
> is set using function 'set_io_port_base()'.
>
> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>

> +int pci_remap_iospace(const struct resource *res, phys_addr_t phys_addr)
> +{
> +       size_t size = (res->end - res->start) + 1;
> +       unsigned long vaddr = (unsigned long)ioremap(phys_addr, size);
> +
> +       set_io_port_base(vaddr);
> +       return 0;
> +}

It might be good to check that res->start is zero here, otherwise
the io_port_base would be off. That could happen if you ever have more
than one bridge.

        Arnd
