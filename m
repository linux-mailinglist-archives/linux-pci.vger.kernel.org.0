Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CDD8730FA3
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jun 2023 08:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244310AbjFOGr6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Jun 2023 02:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237002AbjFOGrW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Jun 2023 02:47:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA5E2D71;
        Wed, 14 Jun 2023 23:45:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 63D9F61E7B;
        Thu, 15 Jun 2023 06:45:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7533C433CC;
        Thu, 15 Jun 2023 06:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686811540;
        bh=jUyq9MCR5EFJXwJ9EDYffG16LnNM6FSeWeGUNewIMxU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cbV7kw2ngCC1lmiko6SGKS3SysBzaP00oiq9aYiboSSH5jy/ydr7mnnvI1QCjw/eu
         fNDPcb/kTDU6NwAFyE56VoS3JYPtyJ8g+A4wHkgA9cTCWaNW8u61tBNEVI7O6PHQQR
         Tt/lYo/t7AnT52rWNNuzE17ew4dWg95I0+dbSC3ZJf5E1msTZIH/luzE+ZQWw7a4BW
         x9Ac6dHADeq1R1GK89Ke8rJnOwkc4ivNdetxCHDFrhScGInFmufXa/SmI3cRUNM+2v
         pmuEEvtft9Sgo8LMBEezWlcr1kM7tHcoKZ3KgfHowofKfMlC25hT8QZjc4LN43quvX
         I4dyVdSNhHwuQ==
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-519608ddbf7so1702611a12.2;
        Wed, 14 Jun 2023 23:45:40 -0700 (PDT)
X-Gm-Message-State: AC+VfDyG9VTsZnwU623tnQMN3Xgq56p07tNgFisQ0E4cf8Fvwe+rO+kq
        FaSBifSWolMVz4k4pzTJ/ttpSF9RXSxKwCh4dB0=
X-Google-Smtp-Source: ACHHUZ6ON8hmFkJ8hHDv8k/o/oD3CMjEPAjJX7IUgIb2V3DLHTKtRLfNQSo06ngI8f4EC9aCuLqphXcTzMj0jQAW6Hc=
X-Received: by 2002:a05:6402:88e:b0:514:964c:4c42 with SMTP id
 e14-20020a056402088e00b00514964c4c42mr11191042edy.8.1686811538874; Wed, 14
 Jun 2023 23:45:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230609022047.2195689-1-maobibo@loongson.cn> <CAAhV-H7n1Z58h2qxCASDXMMQBDN6x_vq6bH_utVhB5boYoZDGQ@mail.gmail.com>
 <4cfe93cb-7713-f994-45c3-e99fe34a3f9e@loongson.cn> <CAAhV-H7_RYzmuCunn5tMzWwKtzi_0sGqUBc5NV1F=_Hyc2X6jg@mail.gmail.com>
In-Reply-To: <CAAhV-H7_RYzmuCunn5tMzWwKtzi_0sGqUBc5NV1F=_Hyc2X6jg@mail.gmail.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Thu, 15 Jun 2023 14:45:26 +0800
X-Gmail-Original-Message-ID: <CAAhV-H46Ngj6MewcVor4ebFxJ_P-ET=PqwZXZa9=nNL1vYUntQ@mail.gmail.com>
Message-ID: <CAAhV-H46Ngj6MewcVor4ebFxJ_P-ET=PqwZXZa9=nNL1vYUntQ@mail.gmail.com>
Subject: Re: [PATCH v4] PCI: Align pci memory space base address with page size
To:     "bibo, mao" <maobibo@loongson.cn>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        loongarch@lists.linux.dev, loongson-kernel@lists.loongnix.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi, Bjorn,

What's your opinion? This patch indeed fixes a problem on LoongArch,
and in theory other non-4K page platforms also need it. If someone
disagrees, maybe we can use the old way: provide a LoongArch-specific
pcibios_align_resource() at this time.

Huacai

On Fri, Jun 9, 2023 at 12:21=E2=80=AFPM Huacai Chen <chenhuacai@kernel.org>=
 wrote:
>
> On Fri, Jun 9, 2023 at 11:47=E2=80=AFAM bibo, mao <maobibo@loongson.cn> w=
rote:
> >
> >
> >
> > =E5=9C=A8 2023/6/9 10:29, Huacai Chen =E5=86=99=E9=81=93:
> > > Hi, Bibo,
> > >
> > > On Fri, Jun 9, 2023 at 10:20=E2=80=AFAM Bibo Mao <maobibo@loongson.cn=
> wrote:
> > >>
> > >> Some PCI devices have only 4K memory space size, it is normal in gen=
eral
> > >> machines and aligned with page size. However some architectures whic=
h
> > >> support different page size, default page size on LoongArch is 16K, =
and
> > >> ARM64 supports page size varying from 4K to 64K. On machines where l=
arger
> > >> page size is use, memory space region of two different pci devices m=
ay be
> > >> in one page. It is not safe with mmu protection, also VFIO pci devic=
e
> > >> driver requires base address of pci memory space page aligned, so th=
at it
> > >> can be memory mapped to qemu user space when it is passed-through to=
 vm.
> > >>
> > >> It consumes more pci memory resource with page size alignment requir=
ement,
> > >> here extra option PCI_MEMRES_PAGE_ALIGN is added, it can be enabled =
by
> > >> different architectures.
> > >>
> > >> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> > >> ---
> > >> Change history
> > >> v4: add extra kernel option PCI_MEMRES_PAGE_ALIGN to set memory reso=
urce
> > >>     page aligned.
> > >>
> > >> v3: move alignment requirement to generic pci code
> > >>
> > >> v2: add pci resource alignment requirement in arch specified functio=
n
> > >>     pcibios_align_resource on arm64/LoongArch platforms
> > >>
> > >> ---
> > >>  arch/loongarch/Kconfig  | 1 +
> > >>  drivers/pci/Kconfig     | 3 +++
> > >>  drivers/pci/setup-res.c | 7 +++++++
> > >>  3 files changed, 11 insertions(+)
> > >>
> > >> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> > >> index d38b066fc931..65b2f6ba9f8e 100644
> > >> --- a/arch/loongarch/Kconfig
> > >> +++ b/arch/loongarch/Kconfig
> > >> @@ -142,6 +142,7 @@ config LOONGARCH
> > >>         select PCI_LOONGSON
> > >>         select PCI_MSI_ARCH_FALLBACKS
> > >>         select PCI_QUIRKS
> > >> +       select PCI_MEMRES_PAGE_ALIGN
> > >>         select PERF_USE_VMALLOC
> > >>         select RTC_LIB
> > >>         select SMP
> > >> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> > >> index 9309f2469b41..9be5f85ff9dc 100644
> > >> --- a/drivers/pci/Kconfig
> > >> +++ b/drivers/pci/Kconfig
> > >> @@ -128,6 +128,9 @@ config PCI_LOCKLESS_CONFIG
> > >>  config PCI_BRIDGE_EMUL
> > >>         bool
> > >>
> > >> +config PCI_MEMRES_PAGE_ALIGN
> > >> +       bool
> > >> +
> > >>  config PCI_IOV
> > >>         bool "PCI IOV support"
> > >>         select PCI_ATS
> > >> diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
> > >> index 967f9a758923..6ad76734a670 100644
> > >> --- a/drivers/pci/setup-res.c
> > >> +++ b/drivers/pci/setup-res.c
> > >> @@ -339,6 +339,13 @@ int pci_assign_resource(struct pci_dev *dev, in=
t resno)
> > >>                 return -EINVAL;
> > >>         }
> > >>
> > >> +#ifdef CONFIG_PCI_MEMRES_PAGE_ALIGN
> > >> +       /*
> > >> +        * force minimum page alignment for vfio pci usage
> > >> +        */
> > >> +       if (res->flags & IORESOURCE_MEM)
> > >> +               align =3D max_t(resource_size_t, PAGE_SIZE, align);
> > >> +#endif
> > > Does this really have its effect? The common version of
> > > pcibios_align_resource() simply returns res->start, and doesn't care
> > > about the 'align' parameter.
> > yes, it works. The is output of command " lspci -vvv | grep Region" on =
my
> > 3C5000+7A2000 box. After the patch base address of all pci mem resource
> > is aligned with 16K.
> >
> > output without the patch:
> >         Region 0: Memory at e0045240000 (64-bit, non-prefetchable) [siz=
e=3D32K]
> >         Region 0: Memory at e0045248000 (64-bit, non-prefetchable) [siz=
e=3D32K]
> >         Region 0: Memory at e0045250000 (64-bit, non-prefetchable) [siz=
e=3D32K]
> >         Region 0: Memory at e0045258000 (64-bit, non-prefetchable) [siz=
e=3D32K]
> >         Region 0: Memory at e0045260000 (64-bit, non-prefetchable) [siz=
e=3D32K]
> >         Region 0: Memory at e0045271400 (64-bit, non-prefetchable) [siz=
e=3D256]
> >         Region 2: Memory at e0040000000 (64-bit, non-prefetchable) [siz=
e=3D64M]
> >         Region 4: Memory at e0045200000 (64-bit, non-prefetchable) [siz=
e=3D64K]
> >         Region 0: Memory at e0045210000 (64-bit, non-prefetchable) [siz=
e=3D64K]
> >         Region 0: Memory at e0045220000 (64-bit, non-prefetchable) [siz=
e=3D64K]
> >         Region 0: Memory at e0045230000 (64-bit, non-prefetchable) [siz=
e=3D64K]
> >         Region 5: Memory at e0045271000 (32-bit, non-prefetchable) [siz=
e=3D1K]
> >         Region 0: Memory at e0045268000 (64-bit, non-prefetchable) [siz=
e=3D4K]
> >         Region 0: Memory at e0045269000 (64-bit, non-prefetchable) [siz=
e=3D4K]
> >         Region 0: Memory at e004526a000 (64-bit, non-prefetchable) [siz=
e=3D4K]
> >         Region 0: Memory at e004526b000 (64-bit, non-prefetchable) [siz=
e=3D4K]
> >         Region 0: Memory at e004526c000 (64-bit, non-prefetchable) [siz=
e=3D4K]
> >         Region 0: Memory at e004526d000 (64-bit, non-prefetchable) [siz=
e=3D4K]
> >         Region 0: Memory at e004526e000 (64-bit, non-prefetchable) [siz=
e=3D4K]
> >         Region 0: Memory at e004526f000 (64-bit, non-prefetchable) [siz=
e=3D4K]
> >         Region 0: Memory at e0045270000 (64-bit, non-prefetchable) [siz=
e=3D4K]
> >         Region 2: Memory at e0044000000 (64-bit, non-prefetchable) [siz=
e=3D16M]
> >         Region 0: Memory at e0045100000 (64-bit, non-prefetchable) [siz=
e=3D1M]
> >         Region 0: Memory at e0045000000 (64-bit, non-prefetchable) [siz=
e=3D16K]
> >
> > out put with the patch:
> >         Region 0: Memory at e0045240000 (64-bit, non-prefetchable) [siz=
e=3D32K]
> >         Region 0: Memory at e0045248000 (64-bit, non-prefetchable) [siz=
e=3D32K]
> >         Region 0: Memory at e0045250000 (64-bit, non-prefetchable) [siz=
e=3D32K]
> >         Region 0: Memory at e0045258000 (64-bit, non-prefetchable) [siz=
e=3D32K]
> >         Region 0: Memory at e0045260000 (64-bit, non-prefetchable) [siz=
e=3D32K]
> >         Region 0: Memory at e0045290000 (64-bit, non-prefetchable) [siz=
e=3D256]
> >         Region 2: Memory at e0040000000 (64-bit, non-prefetchable) [siz=
e=3D64M]
> >         Region 4: Memory at e0045200000 (64-bit, non-prefetchable) [siz=
e=3D64K]
> >         Region 0: Memory at e0045210000 (64-bit, non-prefetchable) [siz=
e=3D64K]
> >         Region 0: Memory at e0045220000 (64-bit, non-prefetchable) [siz=
e=3D64K]
> >         Region 0: Memory at e0045230000 (64-bit, non-prefetchable) [siz=
e=3D64K]
> >         Region 5: Memory at e004528c000 (32-bit, non-prefetchable) [siz=
e=3D1K]
> >         Region 0: Memory at e0045268000 (64-bit, non-prefetchable) [siz=
e=3D4K]
> >         Region 0: Memory at e004526c000 (64-bit, non-prefetchable) [siz=
e=3D4K]
> >         Region 0: Memory at e0045270000 (64-bit, non-prefetchable) [siz=
e=3D4K]
> >         Region 0: Memory at e0045274000 (64-bit, non-prefetchable) [siz=
e=3D4K]
> >         Region 0: Memory at e0045278000 (64-bit, non-prefetchable) [siz=
e=3D4K]
> >         Region 0: Memory at e004527c000 (64-bit, non-prefetchable) [siz=
e=3D4K]
> >         Region 0: Memory at e0045280000 (64-bit, non-prefetchable) [siz=
e=3D4K]
> >         Region 0: Memory at e0045284000 (64-bit, non-prefetchable) [siz=
e=3D4K]
> >         Region 0: Memory at e0045288000 (64-bit, non-prefetchable) [siz=
e=3D4K]
> >         Region 2: Memory at e0044000000 (64-bit, non-prefetchable) [siz=
e=3D16M]
> >         Region 0: Memory at e0045100000 (64-bit, non-prefetchable) [siz=
e=3D1M]
> >         Region 0: Memory at e0045000000 (64-bit, non-prefetchable) [siz=
e=3D16K]
> OK, thanks.
>
> Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
>
> >
> > Regards
> > Bibo, Mao
> > >
> > > Huacai
> > >>         size =3D resource_size(res);
> > >>         ret =3D _pci_assign_resource(dev, resno, size, align);
> > >>
> > >> --
> > >> 2.27.0
> > >>
> >
