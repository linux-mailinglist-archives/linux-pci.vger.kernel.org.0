Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 918DD728DF9
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jun 2023 04:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjFICaJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Jun 2023 22:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjFICaI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Jun 2023 22:30:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E0E184;
        Thu,  8 Jun 2023 19:30:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E95C65328;
        Fri,  9 Jun 2023 02:30:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 776C5C4339B;
        Fri,  9 Jun 2023 02:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686277806;
        bh=lFODl6QKIv49kcz8dOO9K/tHqzGHNLQJ2rXjJtuw2EE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AqzWx0G5buMX45W3K+sM4xQ/cEdkRfSHIpus62lBGCmx2MShFQ0rEnv36+fS6J0Cd
         QnYq/gfxYlQytVBRJn5y6JjJIf/BOFDnJJQu5N6dr3nfEiqQgtQ94hNYhMcQguPKsc
         0nEPiMU0lWEE5DrnxTCxVo3/RDkc5hX9SpB6wMx3iy5OJ9Aa4P5FZIRO1g6Vb2I6VV
         HLvx93iczcQ2A3oJ//3JHbk8eeHSI0q6w3BPZuSIIM67S83q7hr7fMSq0XSRhGTL6n
         rgZ4eiQYYvh9N4plgimMnETrAs9d3gyss19lOep5jGo51fzlHsTETykt/aSRMzgB4G
         SjcPmYzrZfYEw==
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-51491b87565so2236817a12.1;
        Thu, 08 Jun 2023 19:30:06 -0700 (PDT)
X-Gm-Message-State: AC+VfDyYTRV88pSVzvY4KFplSH7VtkIH3CF1qmvCTR4kZH/qFBZ+Rr1F
        XEwala64KA1eI3zlFb+ZRugemiwPM7RG3MP+iX8=
X-Google-Smtp-Source: ACHHUZ777zj3UeQ+dgcHObu2L3r2HUnMRbo0DQbGQeFHfEaURr2zk4uIYA4fA1CCGP0ruh8y5dCBTMVIeM8/3FERr80=
X-Received: by 2002:a17:907:7207:b0:957:17c5:8705 with SMTP id
 dr7-20020a170907720700b0095717c58705mr302799ejc.51.1686277804594; Thu, 08 Jun
 2023 19:30:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230609022047.2195689-1-maobibo@loongson.cn>
In-Reply-To: <20230609022047.2195689-1-maobibo@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Fri, 9 Jun 2023 10:29:52 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7n1Z58h2qxCASDXMMQBDN6x_vq6bH_utVhB5boYoZDGQ@mail.gmail.com>
Message-ID: <CAAhV-H7n1Z58h2qxCASDXMMQBDN6x_vq6bH_utVhB5boYoZDGQ@mail.gmail.com>
Subject: Re: [PATCH v4] PCI: Align pci memory space base address with page size
To:     Bibo Mao <maobibo@loongson.cn>
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

Hi, Bibo,

On Fri, Jun 9, 2023 at 10:20=E2=80=AFAM Bibo Mao <maobibo@loongson.cn> wrot=
e:
>
> Some PCI devices have only 4K memory space size, it is normal in general
> machines and aligned with page size. However some architectures which
> support different page size, default page size on LoongArch is 16K, and
> ARM64 supports page size varying from 4K to 64K. On machines where larger
> page size is use, memory space region of two different pci devices may be
> in one page. It is not safe with mmu protection, also VFIO pci device
> driver requires base address of pci memory space page aligned, so that it
> can be memory mapped to qemu user space when it is passed-through to vm.
>
> It consumes more pci memory resource with page size alignment requirement=
,
> here extra option PCI_MEMRES_PAGE_ALIGN is added, it can be enabled by
> different architectures.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
> Change history
> v4: add extra kernel option PCI_MEMRES_PAGE_ALIGN to set memory resource
>     page aligned.
>
> v3: move alignment requirement to generic pci code
>
> v2: add pci resource alignment requirement in arch specified function
>     pcibios_align_resource on arm64/LoongArch platforms
>
> ---
>  arch/loongarch/Kconfig  | 1 +
>  drivers/pci/Kconfig     | 3 +++
>  drivers/pci/setup-res.c | 7 +++++++
>  3 files changed, 11 insertions(+)
>
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index d38b066fc931..65b2f6ba9f8e 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -142,6 +142,7 @@ config LOONGARCH
>         select PCI_LOONGSON
>         select PCI_MSI_ARCH_FALLBACKS
>         select PCI_QUIRKS
> +       select PCI_MEMRES_PAGE_ALIGN
>         select PERF_USE_VMALLOC
>         select RTC_LIB
>         select SMP
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index 9309f2469b41..9be5f85ff9dc 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -128,6 +128,9 @@ config PCI_LOCKLESS_CONFIG
>  config PCI_BRIDGE_EMUL
>         bool
>
> +config PCI_MEMRES_PAGE_ALIGN
> +       bool
> +
>  config PCI_IOV
>         bool "PCI IOV support"
>         select PCI_ATS
> diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
> index 967f9a758923..6ad76734a670 100644
> --- a/drivers/pci/setup-res.c
> +++ b/drivers/pci/setup-res.c
> @@ -339,6 +339,13 @@ int pci_assign_resource(struct pci_dev *dev, int res=
no)
>                 return -EINVAL;
>         }
>
> +#ifdef CONFIG_PCI_MEMRES_PAGE_ALIGN
> +       /*
> +        * force minimum page alignment for vfio pci usage
> +        */
> +       if (res->flags & IORESOURCE_MEM)
> +               align =3D max_t(resource_size_t, PAGE_SIZE, align);
> +#endif
Does this really have its effect? The common version of
pcibios_align_resource() simply returns res->start, and doesn't care
about the 'align' parameter.

Huacai
>         size =3D resource_size(res);
>         ret =3D _pci_assign_resource(dev, resno, size, align);
>
> --
> 2.27.0
>
