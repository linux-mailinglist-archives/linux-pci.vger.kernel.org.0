Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26F5741CC2D
	for <lists+linux-pci@lfdr.de>; Wed, 29 Sep 2021 20:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344589AbhI2S5i (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Sep 2021 14:57:38 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:56631 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344867AbhI2S5h (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Sep 2021 14:57:37 -0400
Received: from mail-wm1-f48.google.com ([209.85.128.48]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1N5mOZ-1muZAt2JRr-017B1I; Wed, 29 Sep 2021 20:55:48 +0200
Received: by mail-wm1-f48.google.com with SMTP id t16-20020a1c7710000000b003049690d882so6134192wmi.5;
        Wed, 29 Sep 2021 11:55:48 -0700 (PDT)
X-Gm-Message-State: AOAM5330isn3L2+dLEzJqtUf/mK4C/0YiZiATI9m4L/dpZUXiIxr6oXe
        P/b17eJUp/bP0d6ODod++PyL21q1/fanZvVrpuo=
X-Google-Smtp-Source: ABdhPJyNr2bT33THpfX31NWdajTXoFODpWUSSIGCIGnzpeNbFByDEF2nWlPnzGst8L4huwqWgk1NBgXJlWWqHjP0joM=
X-Received: by 2002:a05:600c:22d4:: with SMTP id 20mr12273979wmg.82.1632941748177;
 Wed, 29 Sep 2021 11:55:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210929145509.GA20495@lpieralisi> <20210929163250.GA773921@bhelgaas>
In-Reply-To: <20210929163250.GA773921@bhelgaas>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 29 Sep 2021 20:55:31 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0Z=w6CK3EKG5LjMan3R04bO9BshLxqU1J_gm8+OLuU+Q@mail.gmail.com>
Message-ID: <CAK8P3a0Z=w6CK3EKG5LjMan3R04bO9BshLxqU1J_gm8+OLuU+Q@mail.gmail.com>
Subject: Re: [PATCH] PCI: rcar: Add missing COMMON_CLK dependency
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:2sI4t1kquHRXToBYin4c4sxBBOAKypc4c9LnUldSTiYpDDY51Dq
 q5nl6RZQq6TTpXm8/Ab2vUmjzErW1NozgqcSEqFW2Fez8VrHgzOIybJ2haslSyOidTnbzEy
 jEJwNBvs1ANtpyo3bwtY95p2H/Ya2iOvriU6HhWULKtyBNrU0fMgBRqMkCvlr64OkObJmCY
 bC4lsjgoJDg5qb3ej2Zdw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Jx8pGPzoWAY=:iwwqGlG9wm+t+CFcakRREx
 MlQVKFgSWWI2kv8kWqqv86Ap8vjyxf5tCO/eXQGdFqbLUuc6E3hRYO8v3uZmlA6Z83v5jxDbd
 jw1528+wOuvYmsPZPAoXCRAOriejIdKvoPX5ixQA2Et4Z2Qm0AKUK4EQxFEsi5z0jOyN8GnML
 s1UkQ5HM6TZZ5dqm+EhJBA7UAQKvvy9C8cPbPAMYlBEKxtXBTIVVIvb4MGSc4g6wgYL/gj95U
 9Gu6VX23ZqNN28W2OGusqVkFUK4+DYNO1BiMhL6Wl5G705fbTZcybsLkuRFeG2Pc4hCXwU+qS
 lG7Pr5zMPgZtvttdFF/kdCQIEaYSl+2cwX4ETneNJ6qtBEmXJwSkyeJs4TlcSZbxua1fHgk9F
 cbXy5SwfCmtwwd7kgXZK2wEBC3QLg7bAx7vX1BBVnhF3jidbUNHm09hAC2uIKloYGTn5HTW+t
 WiiNeEy03QeY6HkK7nYZEoMVdbNOUFMgV2sRaeAzOs30RabcQuD9ZAgGhF0FABOnGPKgPRe+w
 pKbRkywbO4cco5JTUUjV/T+wbHKA03UM8Q3hsNotI/RYAc9e1LPNe2sWOE1sHHBIMoN64pjHP
 zv+WIqqKxU9Cky4xXICsQOdH+iiUPfRgxBKsqLzyQZgrPcfBbkegzjTcNBRP+Oefg9k/28VNO
 DsoBckpva3TDNcy4LabNmMeU49+yYEBEMuV6WuL3eADgsdLYjWUY04FjbrZNza6WN46LLdD7o
 x8GY2Q4Hhx6evyapVJuvGDWpmIg6Tk/qRzxTcQ==
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 29, 2021 at 6:32 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Wed, Sep 29, 2021 at 03:55:09PM +0100, Lorenzo Pieralisi wrote:
> > On Wed, Sep 22, 2021 at 01:13:11AM +0200, Marek Vasut wrote:
> > > On 9/21/21 6:08 PM, Geert Uytterhoeven wrote:
> > >
> > > [...]
> > >
> > > > > diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
> > > > > index 326f7d13024f..ee6f5e525d3a 100644
> > > > > --- a/drivers/pci/controller/Kconfig
> > > > > +++ b/drivers/pci/controller/Kconfig
> > > > > @@ -66,6 +66,7 @@ config PCI_RCAR_GEN2
> > > > >   config PCIE_RCAR_HOST
> > > > >          bool "Renesas R-Car PCIe host controller"
> > > > >          depends on ARCH_RENESAS || COMPILE_TEST
> > > > > +       depends on COMMON_CLK
> > > >
> >
> > Bjorn, shall we pick Arnd's patch up then ? We should be fixing this in
> > one of the upcoming -rcs since we introduced it in the last merge
> > window.
>
> IIUC, a115b1bd3af0 ("PCI: rcar: Add L1 link state fix into data abort
> hook") appeared in v5.15-rc1 and added a use of __clk_is_enabled(),
> which is only available when COMMON_CLK=y.
>
> PCIE_RCAR_HOST depends on ARCH_RENESAS || COMPILE_TEST.  ARCH_RENESAS
> is an ARM64 platform, so when COMPILE_TEST is not set, I think we get
> COMMON_CLK=y via this:
>
>   config ARM64
>     select COMMON_CLK
>
> But when ARCH_RENESAS is not set and COMPILE_TEST=y, there's nothing
> that enforces the dependency on COMMON_CLK.  Personally I like the
> first hunk of Marek's patch at [1] because the dependency on
> COMMON_CLK is explicit:
>
>   config PCIE_RCAR_HOST
>     depends on ARCH_RENESAS || COMPILE_TEST
>     depends on COMMON_CLK

Agreed, Marek's version is clearer than mine, please use that.

       Arnd
