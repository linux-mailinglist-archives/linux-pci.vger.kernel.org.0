Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50EDE39DD5E
	for <lists+linux-pci@lfdr.de>; Mon,  7 Jun 2021 15:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbhFGNPe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Jun 2021 09:15:34 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:44693 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbhFGNPd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Jun 2021 09:15:33 -0400
Received: from mail-wm1-f42.google.com ([209.85.128.42]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1My3Ad-1lQqle2BNn-00zUeI for <linux-pci@vger.kernel.org>; Mon, 07 Jun 2021
 15:13:41 +0200
Received: by mail-wm1-f42.google.com with SMTP id n17-20020a7bc5d10000b0290169edfadac9so12690889wmk.1
        for <linux-pci@vger.kernel.org>; Mon, 07 Jun 2021 06:13:41 -0700 (PDT)
X-Gm-Message-State: AOAM532v16sLNTdxtqPzPb+RyxeY2AOah95QpGOP0SQJ+hThMshGIMQD
        KMK9eKgljMJi1DDVNZ1C+ETx9XtcOhyVEdOazFI=
X-Google-Smtp-Source: ABdhPJzVSsA4BPtIPlnUE5YjuT9At3i7SPtz91qq7EdebIc4HsMW75RnQfliTFMnahJzNUcRYnQ+g1jXQW+07UOek7I=
X-Received: by 2002:a1c:9a45:: with SMTP id c66mr12109928wme.43.1623071621240;
 Mon, 07 Jun 2021 06:13:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210607130711.3668148-1-linus.walleij@linaro.org>
In-Reply-To: <20210607130711.3668148-1-linus.walleij@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 7 Jun 2021 15:11:52 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3SigtNyEcDh=NsSD7gaoMt-Cc7b_6Ay2MGEGQGZ4ax6A@mail.gmail.com>
Message-ID: <CAK8P3a3SigtNyEcDh=NsSD7gaoMt-Cc7b_6Ay2MGEGQGZ4ax6A@mail.gmail.com>
Subject: Re: [PATCH v5] PCI: ixp4xx: Add a new driver for IXP4xx
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Zoltan HERPAI <wigyori@uid0.hu>,
        Raylynn Knight <rayknight@me.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:6qN3MqOiz+S+BYvuy1aXA29t6CYAtLXhMcw8k/lDAUMp52QQo25
 YZRQD2iohsno+HYDv81ZjvfZtelh2ZiTJou4CIdKJV3LUJX+h2mOFEcyC/w1jPm4nhTTeBj
 YpnbwFVVgdA/hKOPKDM13W0t7Pumwm8ruik8yjaNNviMKqIx1dgmtnmHcgdtrIScvWJ0bFZ
 yhtYxnQn2iE2PeFFXeLmw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:V3TxGMBQHn8=:E0B67sGqPKAkOBxQGrkso4
 DtKZTDSogQg5Hd7/reTroJV7DZbv1LX5Fl21J/Ky9EoaM6gb05XZGqdppf3usjjNTWSskn1m1
 H/wJVLiUCIHPPpDr9IKfEyFJdFXN7cLLbrV+8yus9Hi6OgNE2mBEmEVIUi1f38N+w+heIGlNm
 DSzK9sN0BLWGJI/Zo2Z5z7wpa+jlK9zuS/Avavi6o8LgEQ0XvTsmfTgWPSd2dCNsowIFCgbS+
 zkqs4nE8fL2aRTC7a4MR1gu49xSSpCQFVxRz7UYcLQsxRW2/ROyTA7W40tqXbvXgBGQnO0ykC
 uDgeBXdngFXUBOLDg3y726mx9L2vngu+oTDHh+9UFY2JNyhh2285cIIg8w+c9+tfqRnBl4rL5
 g5JF+KXe5ilq8ns0xKDACjT+KfHyX8vQN7BYX5KNw32X4EXB8UdxaMwLqXKsz/PJPpPSPFzRr
 WpFISEYY6F1Apt805EC4CsQovHYL6nF01JIJn6RIvBraIl5OkbjmNfIQxgBeXhBedscTUmBlV
 cMfooG0VpGjt3KtMIXxVAUQuKP6GhaAO34NqPTKE2CXSVhaAcQayZA7W/REL1mNbbYy8814M+
 ydxcAF4s8nE/RpSwBKvwBsEjN2I6kvAXxUjKig4kJ+o3xemMx+E/oWj87iOiES/G8Ibd+htsH
 2UMo=
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 7, 2021 at 3:07 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> This adds a new PCI controller driver for the Intel IXP4xx
> (IX425, IXP435 etc), based on the XScale microarchitecture.
>
> This replaces the old driver in arch/arm/mach-ixp4xx/common-pci.c
> which utilized the ARM-specific BIOS32 PCI framework,
> and all parameterization for such things as memory and
> IO space as well as interrupt swizzling is done from the
> device tree.
>
> The plan is to phase out and delete the old driver piecemal.
>
> The __raw_writel() and __raw_readl() are used for accessing
> the PCI controller for the same reason that these accessors
> are used in the timer, IRQ and GPIO drivers: the platform
> will alter its address bus pattern based on whether the
> system is booted in big- or little-endian mode. For this
> reason all register on IXP4xx must always be accessed in
> native (CPU) endianness.
>
> This driver supports 64MB of PCI memory space, but not the
> indirect access of 1GB that is available in the old driver.
> We can address that later if and only if there are users
> that need all 1GB of PCI address space. Krzysztof reports
> having to use indirect MMIO only once for a VGA card. There
> is work ongoing for general indirect MMIO. (In practice
> the indirect MMIO is performed by writing address and
> writing and reading values into/from a controller
> register.)
>
> Tested by booting the NSLU2, attaching a USB stick, mounting
> and browsing the drive.
>
> Link: https://lore.kernel.org/linux-arm-kernel/m37edwuv8m.fsf@t19.piap.pl/
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Imre Kaloz <kaloz@openwrt.org>
> Cc: Krzysztof Halasa <khalasa@piap.pl>
> Cc: Zoltan HERPAI <wigyori@uid0.hu>
> Cc: Raylynn Knight <rayknight@me.com>
> Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

One small detail:

> +static struct platform_driver ixp4xx_pci_driver = {
> +       .driver = {
> +               .name = "ixp4xx-pci",
> +               .suppress_bind_attrs = true,
> +               .of_match_table = of_match_ptr(ixp4xx_pci_of_match),
> +       },
> +};

That of_match_ptr() is pointless unless the ixp4xx_pci_of_match[] array
is inside of an #ifdef.

       Arnd
