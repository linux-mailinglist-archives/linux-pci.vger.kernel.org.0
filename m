Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1BC723525
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jun 2023 04:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233748AbjFFCRy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Jun 2023 22:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233706AbjFFCRw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Jun 2023 22:17:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB2901A7;
        Mon,  5 Jun 2023 19:17:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F0F84614D8;
        Tue,  6 Jun 2023 02:17:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59467C433EF;
        Tue,  6 Jun 2023 02:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686017869;
        bh=PwAxfEO6U+WKSxEaEYXu3C2Un1n6Ggfy5FOFAmLtwcI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Fe9mMIpYFB6cIcBpLMM5q2WcJyh/joZeOme7/DfuQtFJ2VYT6KAI0Gkh74//69+23
         9Cs42dhFPfEBOTZUrN4YJ2xaha3+sGOfYVhtV8VEQO1hnw9qAcN42VK+pugeyFY510
         YFevXn+8Nmh7H62gGlN/b2BCrGPVCD7d/XNgcUi+2jdDzVo80HDrJsqMK1I4NTCZHI
         U8BHJwwcBwfkO7bK4nlSdiRN/UWnmknXtvnc7v+zueM2jxaathkYf492vf0JrAiP6C
         hmy/WaombE0amn1d23d6x/9DeWQKuW9du52TnGnidzVER8xJMNOFfMi0OylVu/GfcX
         1CQRse8FootMg==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-976a0a1a92bso585066166b.1;
        Mon, 05 Jun 2023 19:17:49 -0700 (PDT)
X-Gm-Message-State: AC+VfDw4PtbXeguzzSixR/GXTtLJ3qdFWDwZhMKVQAWpb8kNPe25YZrT
        5rZvPeoQ631VhbggMYDE97jM6Z4laX2IaAaJw+c=
X-Google-Smtp-Source: ACHHUZ5sgA0ZKrm3D7nww13G21t1yiGVku/UHWR3Fvcyc85cCBGbT3NUOF+icKMh0DS3B5IEC+CVqLGgvuHwaoAI8FU=
X-Received: by 2002:a17:907:16a5:b0:978:6be4:7efb with SMTP id
 hc37-20020a17090716a500b009786be47efbmr679173ejc.7.1686017867509; Mon, 05 Jun
 2023 19:17:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230605034423.1528206-1-maobibo@loongson.cn> <CAAhV-H6O+_EnmDU6kE-19PP+8tD3wwbzzuakE_vHZGCtjZWDbg@mail.gmail.com>
 <749898e2-01c2-9f74-f939-fac36227431a@loongson.cn>
In-Reply-To: <749898e2-01c2-9f74-f939-fac36227431a@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Tue, 6 Jun 2023 10:17:35 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6o8Dx0g+UaNjh9JfAVv=aAU=GFkUS9aO6tsBim3mYZjQ@mail.gmail.com>
Message-ID: <CAAhV-H6o8Dx0g+UaNjh9JfAVv=aAU=GFkUS9aO6tsBim3mYZjQ@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: Align pci memory space base address with page size
To:     "bibo, mao" <maobibo@loongson.cn>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, helgaas@kernel.org,
        linux-pci@vger.kernel.org, Jianmin Lv <lvjianmin@loongson.cn>,
        WANG Xuerui <kernel@xen0n.name>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        loongarch@lists.linux.dev
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

On Mon, Jun 5, 2023 at 2:31=E2=80=AFPM bibo, mao <maobibo@loongson.cn> wrot=
e:
>
>
>
> =E5=9C=A8 2023/6/5 11:58, Huacai Chen =E5=86=99=E9=81=93:
> > Hi, Bibo,
> >
> > Three suggestions:
> > 1, split to two patches.
> will do.
> > 2, the "(align < PAGE_SIZE)" condition can be removed.
> With  "(align < PAGE_SIZE)" condition, there is little modification compa=
red
> to the weak function.
> resource_size_t __weak pcibios_align_resource(void *data,
>                                               const struct resource *res,
>                                               resource_size_t size,
>                                               resource_size_t align)
> {
>        return res->start;
> }
Why? I think "align > PAGE_SIZE" doesn't ensure res->start is aligned here.

>
> or do you mean something this?
>        if (res->flags & IORESOURCE_MEM) {
>                 align =3D max_t(resource_size_t, PAGE_SIZE, align);
>                 start =3D ALIGN(start, align);
>         }
>
No, I mean use "start =3D ALIGN(start, PAGE_SIZE)" unconditionally.

Huacai
>
> > 3, you can unify the comments between ARM64 and LoongArch.
> will do.
>
> Regards
> Bibo, Mao
>
> >
> > Huacai
> >
> > On Mon, Jun 5, 2023 at 11:44=E2=80=AFAM Bibo Mao <maobibo@loongson.cn> =
wrote:
> >>
> >> Some PCI devices has only 4K memory space size, it is normal in genera=
l
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
> >> can be memory mapped to qemu user space when it is pass-through to vm.
> >>
> >> It consumes more pci memory resource with page size alignment requirem=
ent,
> >> on 64 bit system it should not be a problem. And UEFI bios set pci mem=
ory
> >> base address with 4K fixed-size aligned, the safer solution is to alig=
n
> >> with larger size on UEFI BIOS stage on these architectures, linux kern=
el
> >> can reuse resource from UEFI bios. For new devices such hotplug pci
> >> devices and sriov devices, pci resource is assigned in Linux kernel si=
de.
> >>
> >> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> >> ---
> >>  arch/arm64/kernel/pci.c  | 13 +++++++++++++
> >>  arch/loongarch/pci/pci.c | 18 ++++++++++++++++++
> >>  2 files changed, 31 insertions(+)
> >>
> >> diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
> >> index 2276689b5411..e2f7b176b156 100644
> >> --- a/arch/arm64/kernel/pci.c
> >> +++ b/arch/arm64/kernel/pci.c
> >> @@ -232,4 +232,17 @@ void pcibios_remove_bus(struct pci_bus *bus)
> >>         acpi_pci_remove_bus(bus);
> >>  }
> >>
> >> +resource_size_t pcibios_align_resource(void *data, const struct resou=
rce *res,
> >> +                               resource_size_t size, resource_size_t =
align)
> >> +{
> >> +       resource_size_t start =3D res->start;
> >> +
> >> +       /*
> >> +        * align base address of pci memory resource with page size
> >> +        */
> >> +       if ((res->flags & IORESOURCE_MEM) && (align < PAGE_SIZE))
> >> +               start =3D ALIGN(start, PAGE_SIZE);
> >> +
> >> +       return start;
> >> +}
> >>  #endif
> >> diff --git a/arch/loongarch/pci/pci.c b/arch/loongarch/pci/pci.c
> >> index 2726639150bc..943a48e60fb1 100644
> >> --- a/arch/loongarch/pci/pci.c
> >> +++ b/arch/loongarch/pci/pci.c
> >> @@ -83,6 +83,24 @@ int pcibios_alloc_irq(struct pci_dev *dev)
> >>         return acpi_pci_irq_enable(dev);
> >>  }
> >>
> >> +/*
> >> + * memory space size of some pci cards is 4K, it is separated with
> >> + * different pages for generic architectures, so that mmu protection =
can
> >> + * work with different pci cards. However page size for LoongArch sys=
tem
> >> + * is 16K, memory space of different pci cards may share the same pag=
e
> >> + * on LoongArch, it is not safe here.
> >> + */
> >> +resource_size_t pcibios_align_resource(void *data, const struct resou=
rce *res,
> >> +                               resource_size_t size, resource_size_t =
align)
> >> +{
> >> +       resource_size_t start =3D res->start;
> >> +
> >> +       if ((res->flags & IORESOURCE_MEM) && (align < PAGE_SIZE))
> >> +               start =3D ALIGN(start, PAGE_SIZE);
> >> +
> >> +       return start;
> >> +}
> >> +
> >>  static void pci_fixup_vgadev(struct pci_dev *pdev)
> >>  {
> >>         struct pci_dev *devp =3D NULL;
> >> --
> >> 2.27.0
> >>
> > _______________________________________________
> > Loongson-kernel mailing list -- loongson-kernel@lists.loongnix.cn
> > To unsubscribe send an email to loongson-kernel-leave@lists.loongnix.cn
>
