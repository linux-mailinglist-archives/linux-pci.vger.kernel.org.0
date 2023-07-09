Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E51674C1AC
	for <lists+linux-pci@lfdr.de>; Sun,  9 Jul 2023 11:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbjGIJUO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 9 Jul 2023 05:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjGIJUN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 9 Jul 2023 05:20:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54646B8;
        Sun,  9 Jul 2023 02:20:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D090560B95;
        Sun,  9 Jul 2023 09:20:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 324E6C433C9;
        Sun,  9 Jul 2023 09:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688894411;
        bh=VG+B59vQ3VEnkB+utkmYw7yH2sF0ifQ8bgRSUsIRrD4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=giPC6nD8Iw48PL9IvQU6ZlfTc/BvgX+J1y3vztdJaRELuMvhj2UZZzaEwcRW2IBGh
         ukKZiZteXeH2EkWAM67gGtt3bpksR1dJr89s14rJoibbXQHP6b84pGggH4gZhS6xG4
         C60m1ot+V5NsoG7FPRuSWV/pS97WgG+okbEffbxj32BAEkz6tlyo6CtVbuOCzhoOuD
         EqoxxUKMsOD2n1dbbkGUlWTPjWUt5h3+e5IFoEOn2Fnb9drZDhZr0zNEj2XCBt7jCV
         bCD7zoEL+0IOq8ZqEnVKFv1XVXLjQE4Y0XV9DBEwrLN609WLkKTKto7jsAP3DEdWbV
         On6dg6t5i0nDA==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-51e56749750so269921a12.0;
        Sun, 09 Jul 2023 02:20:11 -0700 (PDT)
X-Gm-Message-State: ABy/qLYovaT2CSfyCwqNKp3jhf7zv/0dyAt8yQGaoMRxxPOW1PzlghR8
        2jjtUZlTl96rmcYu1yLGJi1K0MDwf4wsJDQC748=
X-Google-Smtp-Source: APBJJlExm8T9L2cQk2V06VYJo7Ahe9vTilfZXIMQGDzfjxB9UrSfHkE/BZ68TpSdKojhk/SWFAEPTkZnWsHxiToKxCw=
X-Received: by 2002:aa7:c7d7:0:b0:51d:acda:2f4a with SMTP id
 o23-20020aa7c7d7000000b0051dacda2f4amr256334eds.37.1688894409342; Sun, 09 Jul
 2023 02:20:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230619014715.3792883-1-maobibo@loongson.cn> <f676d9e0-bb88-283a-5189-f1ae945ee4dd@loongson.cn>
 <bdc6eb71-482d-5dd6-d527-c2f2f68dfb38@loongson.cn>
In-Reply-To: <bdc6eb71-482d-5dd6-d527-c2f2f68dfb38@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Sun, 9 Jul 2023 17:19:57 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7_Rjv-ySorjbw0f4OiV4J0-N75fmUNBCmeJbeeydJu4Q@mail.gmail.com>
Message-ID: <CAAhV-H7_Rjv-ySorjbw0f4OiV4J0-N75fmUNBCmeJbeeydJu4Q@mail.gmail.com>
Subject: Re: [PATCH v5] PCI: Align pci memory space base address with page size
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     Will Deacon <will@kernel.org>, loongson-kernel@lists.loongnix.cn,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        loongarch@lists.linux.dev, Huacai Chen <chenhuacai@loongson.cn>
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

On Fri, Jul 7, 2023 at 10:47=E2=80=AFAM bibo mao <maobibo@loongson.cn> wrot=
e:
>
> Bjourn, Hucai,
>
> ping again.
>
> The is such issue on only LoongArch system since 16K page size is used.
>
> Should we add code in general framework  or in LoongArch specified code
> in v1?
Though I still don't know why others have no problems. But it is
surely a bug on LoongArch. So if Bjorn has no objections, please use
the old method (just like v1 but you can simply align to page size
unconditionally).

Huacai
>
> If you do not think that it is problem, I can give up. LoongArch system
> is not only for myself own, I do not care about it also since LoongArch
> Maintainer think it is not a issue.
>
> Regards
> Bibo Mao
>
> =E5=9C=A8 2023/6/26 09:30, bibo mao =E5=86=99=E9=81=93:
> > gentle ping.
> >
> > =E5=9C=A8 2023/6/19 09:47, Bibo Mao =E5=86=99=E9=81=93:
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
> >> different architectures, currently arm64/loongarch enable this option.
> >>
> >> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> >> Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
> >> ---
> >> Change history
> >> v5: enable option PCI_MEMRES_PAGE_ALIGN on arm64. Verified on LoongArc=
h
> >> and pass to compile on arm64 with defconfig
> >>
> >> v4: add extra kernel option PCI_MEMRES_PAGE_ALIGN to set memory resour=
ce
> >>     page aligned
> >>
> >> v3: move alignment requirement to generic pci code
> >>
> >> v2: add pci resource alignment requirement in arch specified function
> >>     pcibios_align_resource on arm64/LoongArch platforms
> >>
> >> ---
> >>  arch/arm64/Kconfig      | 1 +
> >>  arch/loongarch/Kconfig  | 1 +
> >>  drivers/pci/Kconfig     | 3 +++
> >>  drivers/pci/setup-res.c | 7 +++++++
> >>  4 files changed, 12 insertions(+)
> >>
> >> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> >> index 343e1e1cae10..24858bbf2b72 100644
> >> --- a/arch/arm64/Kconfig
> >> +++ b/arch/arm64/Kconfig
> >> @@ -232,6 +232,7 @@ config ARM64
> >>      select OF_EARLY_FLATTREE
> >>      select PCI_DOMAINS_GENERIC if PCI
> >>      select PCI_ECAM if (ACPI && PCI)
> >> +    select PCI_MEMRES_PAGE_ALIGN if PCI
> >>      select PCI_SYSCALL if PCI
> >>      select POWER_RESET
> >>      select POWER_SUPPLY
> >> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> >> index d38b066fc931..7dbde5e5b351 100644
> >> --- a/arch/loongarch/Kconfig
> >> +++ b/arch/loongarch/Kconfig
> >> @@ -140,6 +140,7 @@ config LOONGARCH
> >>      select PCI_DOMAINS_GENERIC
> >>      select PCI_ECAM if ACPI
> >>      select PCI_LOONGSON
> >> +    select PCI_MEMRES_PAGE_ALIGN
> >>      select PCI_MSI_ARCH_FALLBACKS
> >>      select PCI_QUIRKS
> >>      select PERF_USE_VMALLOC
> >> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> >> index 9309f2469b41..9be5f85ff9dc 100644
> >> --- a/drivers/pci/Kconfig
> >> +++ b/drivers/pci/Kconfig
> >> @@ -128,6 +128,9 @@ config PCI_LOCKLESS_CONFIG
> >>  config PCI_BRIDGE_EMUL
> >>      bool
> >>
> >> +config PCI_MEMRES_PAGE_ALIGN
> >> +    bool
> >> +
> >>  config PCI_IOV
> >>      bool "PCI IOV support"
> >>      select PCI_ATS
> >> diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
> >> index 967f9a758923..6ad76734a670 100644
> >> --- a/drivers/pci/setup-res.c
> >> +++ b/drivers/pci/setup-res.c
> >> @@ -339,6 +339,13 @@ int pci_assign_resource(struct pci_dev *dev, int =
resno)
> >>              return -EINVAL;
> >>      }
> >>
> >> +#ifdef CONFIG_PCI_MEMRES_PAGE_ALIGN
> >> +    /*
> >> +     * force minimum page alignment for vfio pci usage
> >> +     */
> >> +    if (res->flags & IORESOURCE_MEM)
> >> +            align =3D max_t(resource_size_t, PAGE_SIZE, align);
> >> +#endif
> >>      size =3D resource_size(res);
> >>      ret =3D _pci_assign_resource(dev, resno, size, align);
> >>
> >
> > _______________________________________________
> > Loongson-kernel mailing list -- loongson-kernel@lists.loongnix.cn
> > To unsubscribe send an email to loongson-kernel-leave@lists.loongnix.cn
>
>
