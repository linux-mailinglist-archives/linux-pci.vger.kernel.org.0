Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7C6A57976E
	for <lists+linux-pci@lfdr.de>; Tue, 19 Jul 2022 12:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234329AbiGSKQ7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Tue, 19 Jul 2022 06:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234156AbiGSKQ5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Jul 2022 06:16:57 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BDA51EED1;
        Tue, 19 Jul 2022 03:16:55 -0700 (PDT)
Received: from mail-yb1-f175.google.com ([209.85.219.175]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1M1YxX-1oFgMQ1lcZ-0031vq; Tue, 19 Jul 2022 12:16:53 +0200
Received: by mail-yb1-f175.google.com with SMTP id i206so25632606ybc.5;
        Tue, 19 Jul 2022 03:16:53 -0700 (PDT)
X-Gm-Message-State: AJIora/Wzy4xy30TVZ+Wg9ZzRmOwDd/Jy+GdBmrF0JXNmqOZyufBobrX
        qaGzbOuKlAnpXNXPfS3LTbwsx79t4G3uQwr6oXY=
X-Google-Smtp-Source: AGRyM1ubUAN76zpgIRG/xXMeM9/Iaf5rCoaQuQqgmDkgW3aRsOAONqEMP0JapwejADTBc5iRrEQHpIlhTT6j48C15IQ=
X-Received: by 2002:a25:808c:0:b0:670:7d94:f2a with SMTP id
 n12-20020a25808c000000b006707d940f2amr3683944ybk.452.1658225812009; Tue, 19
 Jul 2022 03:16:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220718202843.6766-1-maukka@ext.kapsi.fi> <20220718202843.6766-4-maukka@ext.kapsi.fi>
 <CAK8P3a042yoLR0eqt4Bm0KH4X9SJhUsjKDh1S9M+MF6mU1mPNw@mail.gmail.com> <20220719094649.pzyrqdvm3fm5fqh2@pali>
In-Reply-To: <20220719094649.pzyrqdvm3fm5fqh2@pali>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 19 Jul 2022 12:16:34 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1RpMQ5zdiH_jkydxDOCm6WyD7qqdN+5T+503tN4SnOqw@mail.gmail.com>
Message-ID: <CAK8P3a1RpMQ5zdiH_jkydxDOCm6WyD7qqdN+5T+503tN4SnOqw@mail.gmail.com>
Subject: Re: [PATCH 2/2] PCI: mvebu: add support for orion5x
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Mauri Sandberg <maukka@ext.kapsi.fi>,
        linux-pci <linux-pci@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:jIxbetmla4q4Itug1nQpXGCdgfiBnGKqj5IWNlD8ZHEwNg1gm7J
 xzHMemTB9zJeZn89YejyrMAvVQQKp9OfP6nkoXTND5X1X1eoUAdtS1z8CJABovlA11Xf/ia
 ahA3iy40oIeueB67eR3PAMdA4+7dh5k88PAOp6V1ociWfDPr20r/iKGCTfuRNFR7mwJH0SC
 I9d4PDMsnQFLO/StNIkaA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1d8yY9ZiAco=:5qdDRYATVGnReQc41jKSmM
 TLYnc1czNFG/hwKNsPa2KnkuUh5h1bLHJX1t3Ah2aoN3cPlwRtSh+nrnFwEsR2Uze1KfBJ2kS
 bDOguiiEgvi9z6wCFeoThosMgA/klfVzkYtkeFrJ+3wsUnDsBrJ9kPjFa4DqaFA72M5x1uoSo
 ss993GSTdKzS2WbkxpZ7ulh62QLSLSz2Tihi+c/ttFtR+X1ZGXBFebXuq5y4hsoq7pNd8sR3w
 pbZzf8/G5GwzDsJDg5OC6v5h/o+WILICoOuIc1DHcxnEsIj21UjITfN1OakShD6xMmhxczBcB
 YJiKeZmXQbz7xNz21YA9KnsfUvGBlSXeRoaT7L8hxP2h0CDgnflarfoj3tH/LNvt7M8vYRPeR
 y3ZH7/kZ5b7RHBQlQzcKs8Ey3fdlcS59DCejLrmPNGG4cWsQp+W6hboJDrvLKyXS/FZxqrAVC
 lHM2gd8GQOl5irxaO/DNM9k+woqrhKnayrL2QQe3DtnuUPNIMl/+tg9XqXGMYMH2uxVkVpYDk
 FpOkvQJJZWbnLtVoWshUx73LSRaddSkR1jw7KGlbFWtfzqvhJF+ohsN269QxgZGt7OBhiisz5
 9FI8oKvZDXTQ/KnQ71Gm92JHGOkjB/o7xpq7Yt9uQU5F7UPe09BoANPxaoLW0x/82lRhp52po
 dxjeWnq4ORq0V6RFPZpufGFSAAeS8xL6DmdiDKeahoGa+JnT8Qu1d5x43cJHlOM6JXenTgzjQ
 PjfejlWmf0of3q/wsTRIqK+5ffnR2dC+IkZbuN22xNYlVgubMVH4RqJxCAu+IdrJTucdy0Hay
 0cop7nFLK/ZAnYn8LNhZgd/wiKhvqS3qQBq8Hpu+qJpHlmGe8UFwl7VOL7AwD/Q02koE/Afq3
 PqW8ieCUjuW+gjfHYXQQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 19, 2022 at 11:46 AM Pali Rohár <pali@kernel.org> wrote:
> On Tuesday 19 July 2022 10:05:28 Arnd Bergmann wrote:
> > > +/* Relevant only for Orion-1/Orion-NAS */
> > > +#define ORION5X_PCIE_WA_PHYS_BASE      0xf0000000
> > > +#define ORION5X_PCIE_WA_VIRT_BASE      IOMEM(0xfd000000)
> >
> > You should not need to hardcode these here. The ORION5X_PCIE_WA_PHYS_BASE
> > should already be part of the DT binding.
>
> Of course! But the issue is that we do not know how to do this DT
> binding. I have already wrote email with asking for help in which
> property and which format should be this config range defined, but no
> answer yet: https://lore.kernel.org/linux-pci/20220710225108.bgedria6igtqpz5l@pali/

Ah, I had not seen that email. Quoting from there:

> So my question is: How to properly define config space range in device
> tree file? In which device tree property and in which format? Please
> note that this memory range of config space is PCIe root port specific
> and it requires its own MBUS_ID() like memory range of PCIe MEM and PCIe
> IO mapping. Please look e.g. at armada-385.dtsi how are MBUS_ID() used:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/armada-385.dtsi

This is probably a question for Rob as the mvebu driver is a rather special
case. Normally this would just be a 'reg' property of the host bridge,
but I think
in your case the root device is imaginary, and the ports under it are the
actual hardware devices, so you'll probably have to do the same thing as
the armada-385, translating the mbus ranges for the config space in the
"ranges" property of the parent, and then referring to them by PCI
MMIO addresses using the assigned-addresses property to pass the
config-space registers as a second set of registers in addition to the
first set.

> > There is little practical difference
> > here, but I see no value in taking the shortcut here either.
> >
> > For the ORION5X_PCIE_WA_VIRT_BASE, you rely on this to match the
> > definition in arch/arm/mach-orion5x/common.c, and this is rather fragile.
> >
> > Instead, please use ioremap() to create a mapping at runtime. The ioremap()
> > implementation on ARM is smart enough to reuse the address from the static
> > mapping in common.c, but will also keep working if that should go away.
>
> I'm planning to work with Mauri on this, but current blocker is DT.

Ok. It should not be hard to do this first, as you just need to pass the
same physical address that you pass in the mbus setup, but I agree
it's easier to do this afterwards to avoid having to rewrite it again.

> > This is probably good enough here, though I think you could also use
> > the trick from drivers/pci/ecam.c and map each bus at a time.
> >
> Yes, there are also helper functions like map bus and etc. which could
> simplify this code. I'm planning to do cleanups once we have fully
> working driver for Orion.

Ok. This is probably not worth the effort if the old driver doesn't already
do provide access to the high registers.

      Arnd
