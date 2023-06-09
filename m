Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF3D6728EDF
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jun 2023 06:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbjFIEVu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Jun 2023 00:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjFIEVt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Jun 2023 00:21:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC3301A1;
        Thu,  8 Jun 2023 21:21:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5CD786536E;
        Fri,  9 Jun 2023 04:21:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF1F6C4339E;
        Fri,  9 Jun 2023 04:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686284506;
        bh=Wz718jwwzmOKzord1kOyXkdwsSSbA/+VRPxHZgPAsbI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tCSgH4LH1QQ98DUYNV005dDVGw7jCt1bUTSuSTcBKbIOk28k+HhrCN4L1u3/BEapm
         iDfBk+xstJPrtav94F73RBqnUM7wJid4/yQqg2rdyb3xWHNIw0AnHfHu4Sndrj99gv
         e5ST42fokrj4vhRK1QQQRYG+pRfM95vw0JsnjZZN602RgZzSo/LRqBLrNPSa6Q3yAw
         7UdW/lFl8t4B1cYn+Lum5bPe7YtnoofQS5vH5JlBUkxQYAmRGcMcDFwImCho4iaSxf
         cJDZJ9//WvEDfhhD7kUjCyL7M82BImQVX/WOW4VUtTF+ZXyzDOrwEpwHsg6x/6Rpij
         HUu/c3IMYoB0g==
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-97454836448so204960666b.2;
        Thu, 08 Jun 2023 21:21:46 -0700 (PDT)
X-Gm-Message-State: AC+VfDwA5XQ52KU4NQrctjDEP5txmh20Gw3Od6ljpSlJYw7ikga3pzjo
        pNBtBBU/papeILwkwn5ywo3pnJxfGj90XsslkhU=
X-Google-Smtp-Source: ACHHUZ6Uvoy6d/d9OEXEsldhP+EGsWezX4Wnp2JTQ32JRxyygEJ8grppU9UOz12iF648+4a4ALWmbltc8Rr6gCVEpnI=
X-Received: by 2002:a17:906:dc95:b0:973:d27e:bd87 with SMTP id
 cs21-20020a170906dc9500b00973d27ebd87mr519930ejc.25.1686284504873; Thu, 08
 Jun 2023 21:21:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230609022047.2195689-1-maobibo@loongson.cn> <CAAhV-H7n1Z58h2qxCASDXMMQBDN6x_vq6bH_utVhB5boYoZDGQ@mail.gmail.com>
 <4cfe93cb-7713-f994-45c3-e99fe34a3f9e@loongson.cn>
In-Reply-To: <4cfe93cb-7713-f994-45c3-e99fe34a3f9e@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Fri, 9 Jun 2023 12:21:24 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7_RYzmuCunn5tMzWwKtzi_0sGqUBc5NV1F=_Hyc2X6jg@mail.gmail.com>
Message-ID: <CAAhV-H7_RYzmuCunn5tMzWwKtzi_0sGqUBc5NV1F=_Hyc2X6jg@mail.gmail.com>
Subject: Re: [PATCH v4] PCI: Align pci memory space base address with page size
To:     "bibo, mao" <maobibo@loongson.cn>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        loongarch@lists.linux.dev, loongson-kernel@lists.loongnix.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 9, 2023 at 11:47=E2=80=AFAM bibo, mao <maobibo@loongson.cn> wro=
te:
>
>
>
> =E5=9C=A8 2023/6/9 10:29, Huacai Chen =E5=86=99=E9=81=93:
> > Hi, Bibo,
> >
> > On Fri, Jun 9, 2023 at 10:20=E2=80=AFAM Bibo Mao <maobibo@loongson.cn> =
wrote:
> >>
> >> Some PCI devices have only 4K memory space size, it is normal in gener=
al
> >> machines and aligned with page size. However some architectures which
> >> support different page size, default page size on LoongArch is 16K, an=
d
> >> ARM64 supports page size varying from 4K to 64K. On machines where lar=
ger
> >> page size is use, memory space region of two different pci devices may=
 be
> >> in one page. It is not safe with mmu protection, also VFIO pci device
> >> driver requires base address of pci memory space page aligned, so that=
 it
> >> can be memory mapped to qemu user space when it is passed-through to v=
m.
> >>
> >> It consumes more pci memory resource with page size alignment requirem=
ent,
> >> here extra option PCI_MEMRES_PAGE_ALIGN is added, it can be enabled by
> >> different architectures.
> >>
> >> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> >> ---
> >> Change history
> >> v4: add extra kernel option PCI_MEMRES_PAGE_ALIGN to set memory resour=
ce
> >>     page aligned.
> >>
> >> v3: move alignment requirement to generic pci code
> >>
> >> v2: add pci resource alignment requirement in arch specified function
> >>     pcibios_align_resource on arm64/LoongArch platforms
> >>
> >> ---
> >>  arch/loongarch/Kconfig  | 1 +
> >>  drivers/pci/Kconfig     | 3 +++
> >>  drivers/pci/setup-res.c | 7 +++++++
> >>  3 files changed, 11 insertions(+)
> >>
> >> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> >> index d38b066fc931..65b2f6ba9f8e 100644
> >> --- a/arch/loongarch/Kconfig
> >> +++ b/arch/loongarch/Kconfig
> >> @@ -142,6 +142,7 @@ config LOONGARCH
> >>         select PCI_LOONGSON
> >>         select PCI_MSI_ARCH_FALLBACKS
> >>         select PCI_QUIRKS
> >> +       select PCI_MEMRES_PAGE_ALIGN
> >>         select PERF_USE_VMALLOC
> >>         select RTC_LIB
> >>         select SMP
> >> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> >> index 9309f2469b41..9be5f85ff9dc 100644
> >> --- a/drivers/pci/Kconfig
> >> +++ b/drivers/pci/Kconfig
> >> @@ -128,6 +128,9 @@ config PCI_LOCKLESS_CONFIG
> >>  config PCI_BRIDGE_EMUL
> >>         bool
> >>
> >> +config PCI_MEMRES_PAGE_ALIGN
> >> +       bool
> >> +
> >>  config PCI_IOV
> >>         bool "PCI IOV support"
> >>         select PCI_ATS
> >> diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
> >> index 967f9a758923..6ad76734a670 100644
> >> --- a/drivers/pci/setup-res.c
> >> +++ b/drivers/pci/setup-res.c
> >> @@ -339,6 +339,13 @@ int pci_assign_resource(struct pci_dev *dev, int =
resno)
> >>                 return -EINVAL;
> >>         }
> >>
> >> +#ifdef CONFIG_PCI_MEMRES_PAGE_ALIGN
> >> +       /*
> >> +        * force minimum page alignment for vfio pci usage
> >> +        */
> >> +       if (res->flags & IORESOURCE_MEM)
> >> +               align =3D max_t(resource_size_t, PAGE_SIZE, align);
> >> +#endif
> > Does this really have its effect? The common version of
> > pcibios_align_resource() simply returns res->start, and doesn't care
> > about the 'align' parameter.
> yes, it works. The is output of command " lspci -vvv | grep Region" on my
> 3C5000+7A2000 box. After the patch base address of all pci mem resource
> is aligned with 16K.
>
> output without the patch:
>         Region 0: Memory at e0045240000 (64-bit, non-prefetchable) [size=
=3D32K]
>         Region 0: Memory at e0045248000 (64-bit, non-prefetchable) [size=
=3D32K]
>         Region 0: Memory at e0045250000 (64-bit, non-prefetchable) [size=
=3D32K]
>         Region 0: Memory at e0045258000 (64-bit, non-prefetchable) [size=
=3D32K]
>         Region 0: Memory at e0045260000 (64-bit, non-prefetchable) [size=
=3D32K]
>         Region 0: Memory at e0045271400 (64-bit, non-prefetchable) [size=
=3D256]
>         Region 2: Memory at e0040000000 (64-bit, non-prefetchable) [size=
=3D64M]
>         Region 4: Memory at e0045200000 (64-bit, non-prefetchable) [size=
=3D64K]
>         Region 0: Memory at e0045210000 (64-bit, non-prefetchable) [size=
=3D64K]
>         Region 0: Memory at e0045220000 (64-bit, non-prefetchable) [size=
=3D64K]
>         Region 0: Memory at e0045230000 (64-bit, non-prefetchable) [size=
=3D64K]
>         Region 5: Memory at e0045271000 (32-bit, non-prefetchable) [size=
=3D1K]
>         Region 0: Memory at e0045268000 (64-bit, non-prefetchable) [size=
=3D4K]
>         Region 0: Memory at e0045269000 (64-bit, non-prefetchable) [size=
=3D4K]
>         Region 0: Memory at e004526a000 (64-bit, non-prefetchable) [size=
=3D4K]
>         Region 0: Memory at e004526b000 (64-bit, non-prefetchable) [size=
=3D4K]
>         Region 0: Memory at e004526c000 (64-bit, non-prefetchable) [size=
=3D4K]
>         Region 0: Memory at e004526d000 (64-bit, non-prefetchable) [size=
=3D4K]
>         Region 0: Memory at e004526e000 (64-bit, non-prefetchable) [size=
=3D4K]
>         Region 0: Memory at e004526f000 (64-bit, non-prefetchable) [size=
=3D4K]
>         Region 0: Memory at e0045270000 (64-bit, non-prefetchable) [size=
=3D4K]
>         Region 2: Memory at e0044000000 (64-bit, non-prefetchable) [size=
=3D16M]
>         Region 0: Memory at e0045100000 (64-bit, non-prefetchable) [size=
=3D1M]
>         Region 0: Memory at e0045000000 (64-bit, non-prefetchable) [size=
=3D16K]
>
> out put with the patch:
>         Region 0: Memory at e0045240000 (64-bit, non-prefetchable) [size=
=3D32K]
>         Region 0: Memory at e0045248000 (64-bit, non-prefetchable) [size=
=3D32K]
>         Region 0: Memory at e0045250000 (64-bit, non-prefetchable) [size=
=3D32K]
>         Region 0: Memory at e0045258000 (64-bit, non-prefetchable) [size=
=3D32K]
>         Region 0: Memory at e0045260000 (64-bit, non-prefetchable) [size=
=3D32K]
>         Region 0: Memory at e0045290000 (64-bit, non-prefetchable) [size=
=3D256]
>         Region 2: Memory at e0040000000 (64-bit, non-prefetchable) [size=
=3D64M]
>         Region 4: Memory at e0045200000 (64-bit, non-prefetchable) [size=
=3D64K]
>         Region 0: Memory at e0045210000 (64-bit, non-prefetchable) [size=
=3D64K]
>         Region 0: Memory at e0045220000 (64-bit, non-prefetchable) [size=
=3D64K]
>         Region 0: Memory at e0045230000 (64-bit, non-prefetchable) [size=
=3D64K]
>         Region 5: Memory at e004528c000 (32-bit, non-prefetchable) [size=
=3D1K]
>         Region 0: Memory at e0045268000 (64-bit, non-prefetchable) [size=
=3D4K]
>         Region 0: Memory at e004526c000 (64-bit, non-prefetchable) [size=
=3D4K]
>         Region 0: Memory at e0045270000 (64-bit, non-prefetchable) [size=
=3D4K]
>         Region 0: Memory at e0045274000 (64-bit, non-prefetchable) [size=
=3D4K]
>         Region 0: Memory at e0045278000 (64-bit, non-prefetchable) [size=
=3D4K]
>         Region 0: Memory at e004527c000 (64-bit, non-prefetchable) [size=
=3D4K]
>         Region 0: Memory at e0045280000 (64-bit, non-prefetchable) [size=
=3D4K]
>         Region 0: Memory at e0045284000 (64-bit, non-prefetchable) [size=
=3D4K]
>         Region 0: Memory at e0045288000 (64-bit, non-prefetchable) [size=
=3D4K]
>         Region 2: Memory at e0044000000 (64-bit, non-prefetchable) [size=
=3D16M]
>         Region 0: Memory at e0045100000 (64-bit, non-prefetchable) [size=
=3D1M]
>         Region 0: Memory at e0045000000 (64-bit, non-prefetchable) [size=
=3D16K]
OK, thanks.

Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>

>
> Regards
> Bibo, Mao
> >
> > Huacai
> >>         size =3D resource_size(res);
> >>         ret =3D _pci_assign_resource(dev, resno, size, align);
> >>
> >> --
> >> 2.27.0
> >>
>
