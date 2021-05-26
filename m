Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE8F3919A5
	for <lists+linux-pci@lfdr.de>; Wed, 26 May 2021 16:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233770AbhEZOQp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 May 2021 10:16:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:42252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233484AbhEZOQo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 26 May 2021 10:16:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6B57E613D7;
        Wed, 26 May 2021 14:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622038513;
        bh=V9yfVGz48znBhoLYjEcvRlIp+daisCyNDfH0CN868s4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dvLySTxEZiqHBU8DH6u3hrzj/0VudX+Pm4o9KGnIC8axkD+9PaZiv2F7PbCAMhuXl
         ZeeO7mNhyyyXa9eue79WEGTCXLOOHL4gm432bZz7BcvKQV38DZvaX+GPQIxzETcm8T
         mD24awDK8Uz+0BUmBoOAbktmxDwSqKnRjK9wiYEzrSANcvvsqFHEbpWBWST4A8FTx3
         HclZI2Quz0gpF21n72viLd14SRFeky5BDhX4phZGE3Y7QzuEgUlbhAQtBrD12xLRls
         AOb2wzA2NOhnENSybyHuEQ+jbJa4Oslqju8HYAuZs9c/n3g2MwlPkKXBHIIfMYWBoL
         fbBwjsDcOveFg==
Received: by mail-ot1-f54.google.com with SMTP id u25-20020a0568302319b02902ac3d54c25eso1149846ote.1;
        Wed, 26 May 2021 07:15:13 -0700 (PDT)
X-Gm-Message-State: AOAM530RRriy6jUaRfONF7+ScC6ggAqCZsfXm3OGM4K8y8Lnu70YsqiW
        j27hVzaX+Fvl6ABV0aWZjwQqXiXMBaZumJfrRRY=
X-Google-Smtp-Source: ABdhPJwW8Rk3emRD0hkgXQcN7xcSCM6FPDi3/JYZuHbFrFSjxpSMXx/i0GLgZamflQJyw1kM6Iit6JpDO+OpdpVyfzw=
X-Received: by 2002:a05:6830:4da:: with SMTP id s26mr2542142otd.77.1622038512765;
 Wed, 26 May 2021 07:15:12 -0700 (PDT)
MIME-Version: 1.0
References: <7a1e2ebc-f7d8-8431-d844-41a9c36a8911@arm.com> <01efd004-1c50-25ca-05e4-7e4ef96232e2@arm.com>
 <87eedxbtkn.fsf@stealth> <CAMj1kXE3U+16A6bO0UHG8=sx45DE6u0FtdSnoLDvfGnFJYTDrg@mail.gmail.com>
 <877djnaq11.fsf@stealth> <CAMj1kXFk2u=tbTYpa6Vqz5ihATFq61pCDiEbfRgXL_Rw+q_9Fg@mail.gmail.com>
 <CAMdYzYo-vdJvT_MPNTYvdveG3W8na7qMVEZFL4AjyQWqcLZi=Q@mail.gmail.com>
 <CAMj1kXEBePfKDOc6eo9yjZPnVeFimX-zxR+R3As+2pP9XnZkuQ@mail.gmail.com>
 <CAMdYzYrH_M92Pc6AqTgagtATr1TPq7Pdm57hadZeAmMBF2f0nA@mail.gmail.com>
 <CAMj1kXHsGgFedbhW2CiS5gveK3=ZxhXQ5siDeHJyttkOVKBQrQ@mail.gmail.com>
 <CAMdYzYruNYtJ8hwKPBUHPed1-=tV=CWDd_oSQtRmr4BJHp=YxA@mail.gmail.com>
 <CAMj1kXHLCJbzRpic-kkdWh5wKTE=6fqkesYbB6XoeJELKn93tw@mail.gmail.com> <9b99d520-e4b1-ae44-44eb-93c2e3d0c0cb@gmail.com>
In-Reply-To: <9b99d520-e4b1-ae44-44eb-93c2e3d0c0cb@gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 26 May 2021 16:15:01 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGBEuV=OUeCWUj5iUbFmko549uKCt5eHFM_j2KW-_FNdw@mail.gmail.com>
Message-ID: <CAMj1kXGBEuV=OUeCWUj5iUbFmko549uKCt5eHFM_j2KW-_FNdw@mail.gmail.com>
Subject: Re: [BUG] rockpro64: PCI BAR reassignment broken by commit
 9d57e61bf723 ("of/pci: Add IORESOURCE_MEM_64 to resource flags for 64-bit
 memory addresses")
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc:     Peter Geis <pgwipeout@gmail.com>,
        Punit Agrawal <punitagrawal@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Leonardo Bras <leobras.c@gmail.com>,
        Rob Herring <robh@kernel.org>, PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 26 May 2021 at 15:55, Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Hi Ard,
>
> Am 25.05.21 um 19:18 schrieb Ard Biesheuvel:
> > [SNIP]
> >>> I seriously doubt that this is what is going on here.
> >>>
> >>> lspci -x will give you the bare BAR values - I suspect that those are
> >>> probably fine.
> >> lspci -x
> >> 00:00.0 PCI bridge: Fuzhou Rockchip Electronics Co., Ltd Device 3566 (=
rev 01)
> >> 00: 87 1d 66 35 07 05 10 40 01 00 04 06 00 00 01 00
> >> 10: 00 00 00 00 00 00 00 00 00 01 ff 00 10 10 00 20
> >> 20: 00 10 00 10 01 00 f1 0f 00 00 00 00 00 00 00 00
> >> 30: 00 00 00 00 40 00 00 00 00 00 00 00 5f 01 02 00
> >>
> >> 01:00.0 VGA compatible controller: Advanced Micro Devices, Inc.
> >> [AMD/ATI] Turks PRO [Radeon HD 7570]
> >> 00: 02 10 5d 67 07 00 10 20 00 00 00 03 00 00 80 00
> >> 10: 0c 00 00 00 00 00 00 00
> > This is a 64-bit prefetchable BAR programmed with bus address 0x0
> >
> >> 04 00 00 10 00 00 00 00
> > This is a 64-bit non-prefetchable BAR programmed with bus address 0x100=
0_0000
> >
> > (https://en.wikipedia.org/wiki/PCI_configuration_space describes the
> > meaning of the low order BAR bits)
>
> Sorry for jumping into the middle of the discussion and to be honest I
> haven't fully read it.
>
> This looks a bit odd since on AMD VGA hardware the non-prefetchable BAR
> is usually only 32bit, not 64bit.
>
> But this hardware generation is rather old and I'm not sure what the BAR
> assignment for that generation was. I would need to dig up the register
> description in our archives as well.
>

I have another museum piece in my AMD Seattle:

02:00.0 VGA compatible controller: Advanced Micro Devices, Inc.
[AMD/ATI] Oland XT [Radeon HD 8670 / R7 250/350] (rev 81) (prog-if 00
[VGA controller])
  Subsystem: Dell Oland XT [Radeon HD 8670 / R7 250/350]
  Flags: bus master, fast devsel, latency 0, IRQ 255
  Memory at 100000000 (64-bit, prefetchable) [size=3D4G]
  Memory at 40000000 (64-bit, non-prefetchable) [size=3D256K]
  I/O ports at 1000 [disabled] [size=3D256]
  Expansion ROM at 40060000 [disabled] [size=3D128K]
  Capabilities: <access denied>
  Kernel modules: radeon, amdgpu

So AMD/ATI ASICs definitely exist that expose a 64-bit pref and a
64-bit non-pref BAR.

--=20
Ard.
