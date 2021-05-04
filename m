Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA75137265E
	for <lists+linux-pci@lfdr.de>; Tue,  4 May 2021 09:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbhEDHOk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 May 2021 03:14:40 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:54269 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbhEDHO2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 May 2021 03:14:28 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1N1whr-1lXGbR297Z-012KL5 for <linux-pci@vger.kernel.org>; Tue, 04 May 2021
 09:12:48 +0200
Received: by mail-wr1-f52.google.com with SMTP id m9so8147139wrx.3
        for <linux-pci@vger.kernel.org>; Tue, 04 May 2021 00:12:48 -0700 (PDT)
X-Gm-Message-State: AOAM532xXWDcHMDcvE3DDQCgO4CnxPsxSRNSFx2ox6b+gBomp+2NLWU1
        yqcRHYPhxe/Wrv2O3RpG9AQaohVamXo+QOEfBbw=
X-Google-Smtp-Source: ABdhPJz5HU14mByJukXWCMOOS2t6aRfpKc+4A0Ev9evW4LjsUK2GCXkjYcTHwTfZO8Mws19ZSvnH9zDFTktxM6HDX9Q=
X-Received: by 2002:a5d:6a52:: with SMTP id t18mr12224493wrw.361.1620112368246;
 Tue, 04 May 2021 00:12:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210503211649.4109334-1-linus.walleij@linaro.org> <20210503211649.4109334-5-linus.walleij@linaro.org>
In-Reply-To: <20210503211649.4109334-5-linus.walleij@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 4 May 2021 09:12:07 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1XtmYAfstfhRzv-y73od3u+fYkvED5LuJ5TNMOS19zZg@mail.gmail.com>
Message-ID: <CAK8P3a1XtmYAfstfhRzv-y73od3u+fYkvED5LuJ5TNMOS19zZg@mail.gmail.com>
Subject: Re: [PATCH 4/4] PCI: ixp4xx: Add a new driver for IXP4xx
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Zoltan HERPAI <wigyori@uid0.hu>,
        Raylynn Knight <rayknight@me.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:+6iJx1oGJGRDtAd2RPXM49e7mGFmFvea0zQTj/VWgR7ypR7dLSV
 stVh1NkkDniXbElhqzUFKcF/3JzdZogyaLWoxyEHBjCvecPwQ5/5TOFS6GQUN9qdSzpx9q3
 VW4xyshJqU1pCK3xoLaHo3JIZoSIv7go3X5CG2AYtjNSRB5ww3IBUehUxesyIJwUMzKLdQo
 uIovIEx5WLfBwCR0yLbUQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:bH+CoWnA1AQ=:LJVeSAsGgwmr2DSND3zJLj
 Ch7YLBK5QLjFlFVt2xj39qZSV2zX9csIQ+NKyRi0fhF8U0UM5L/znmF2u9cK13oliUR9CaSIM
 nXVoyZ5WLczTCm6qqXjhKZ3e8NPT1nwNAE5YHjc+speUtm1GATwykfeaey7BfQzYjP8il3crq
 yw+o4muLh1/L16dUgowzIk+YYG96kAtmIOEERPccN/MjpLuTy2PLfQO3FbMuMo9OplukzM4Ux
 o1g94c/7So9I10Kd3WWy+cApTFdsXuDfU2R1RF1hIL9DZzTK+DXJGcHrN1CTChkQO2vI4Kheu
 7Vvya6GELHGtUpqRg4JJM3FKVyhrdpIsi6Qp0UCV1MRQeDZoGNyhqzGnqxj/xj8gEkVPNSTdP
 EvaMS8jFtmyHVCiwu0jwhowNTviJE1lbRTF3kS0bzuCiMxsy5ag9H1PbOxH9rX4AYzo8/jD/N
 j+XJ+L12VLX7vkIa1t2EFIP2t7YuVN0bLw5I4fwWPg+zePYKd8v2uYUy+dCUfiJXF3C2lpQ20
 T6iA9VthFRdRcbvKSONlsJKE3wq5rtSyFIvqfpv9jXqYu6gZWY/fsoHUjelJT9WlOLXM6ttqK
 vE4jf0uZ8Vl8aAE8pYvgFYd1RzYVQ60XIrBsiNrlRMyn/3+zV+WYono71+iKvh9EtwQJdhOyz
 gUe0=
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 3, 2021 at 11:16 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> This adds a new PCI controller driver for the Intel IXP4xx
> (IX425, IXP435 etc), based on the XScale microarchitecture.
>
> This replaces the old driver in arch/arm/mach-ixp4xx/common-pci.c
> which utilized the ARM-specific BIOS32 PCI framework,
> and all parameterization for such things as memory and
> IO space as well as interrupt swizzling is done from the
> device tree.

Nice work!

> The __raw_writel() and __raw_readl() are used for accessing
> the PCI controller for the same reason that these accessors
> are used in the timer, IRQ and GPIO drivers: the platform
> will alter its address bus pattern based on whether the
> system is booted in big- or little-endian mode. For this
> reason all register on IXP4xx must always be accessed in
> native (CPU) endianness.

Can you add a pair of inline function that wraps these into
a driver specific helper with a comment?

> This driver supports 64MB of PCI memory space, but not the
> indirect access of 1GB that is available in the old driver.
> We can address that later if and only if there are users
> that need all 1GB of PCI address space.

> +
> +       ret = pci_scan_root_bus_bridge(host);
> +       if (ret) {
> +               dev_err(dev, "failed to scan host: %d\n", ret);
> +               return ret;
> +       }
> +
> +       p->bus = host->bus;

I don't think you need to store the bus separately, just use
host->bus everywhere.

> +       pci_bus_assign_resources(p->bus);
> +       pci_bus_add_devices(p->bus);

Can you call pci_host_probe() instead of open-coding it here?

> +
> +static struct platform_driver ixp4xx_pci_driver = {
> +       .driver = {
> +               .name = "ixp4xx-pci",
> +               .of_match_table = of_match_ptr(ixp4xx_pci_of_match),
> +               .suppress_bind_attrs = true,
> +       },
> +       .probe  = ixp4xx_pci_probe,
> +};
> +builtin_platform_driver(ixp4xx_pci_driver);

It should be possible to make it a loadable module, after Rob Herring
fixed some of the bugs around that.

        Arnd
