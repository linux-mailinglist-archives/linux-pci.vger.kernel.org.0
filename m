Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77B7272354D
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jun 2023 04:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbjFFC2A (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Jun 2023 22:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233193AbjFFC17 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Jun 2023 22:27:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD5A116;
        Mon,  5 Jun 2023 19:27:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C1AEA62C94;
        Tue,  6 Jun 2023 02:27:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 293D5C433A7;
        Tue,  6 Jun 2023 02:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686018477;
        bh=8w5l++HfxzD3uHKzwQjjiajXQ1/YXpzExj4rmuGMb+g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SCNkls8wgo/SrfPPBecyRke6NPbM9EwPT4r7RepWD36UhkVTRQwUPx8zdjBlExA5D
         7GzdCR5NYpSZ2eU/hZ3vqPrlIBAnYmrCqpMfFJV6zGQE8Pah2aPx6YwFO8m+L3+/Js
         JrSP0MfZRRLHo1HJyC1wS0MDB4bmUymE4/su7FnELpoS2JDoyWaPd95Wc4mD5sQI/H
         TIiOmeAbi0jIPBQtXuTPbfwTM0YM1dSZqXPk3JZKTbW3AS8rbatellg+fo25Lc+iOe
         USOdVpnuLic7zzIWMCZMxcM3EqTaxWng7fEl8/nGII0AHj5aWBaCA1O+/UZOYSwZsP
         e9AV1kF0SjKTQ==
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-51456392cbbso13777123a12.0;
        Mon, 05 Jun 2023 19:27:57 -0700 (PDT)
X-Gm-Message-State: AC+VfDxmbEdBMT/2/5oSi2n+elM5CMxSCVAQIa1NNreYUytDFYvWsydc
        g68dQZa0TC3QXW4XmCkbFMxQRPU0bqnYzXK7nmM=
X-Google-Smtp-Source: ACHHUZ78XULWy52BiI/ISzfKx6wTP7I6WEmOAcI1Z0VqatmsI9XCYcD4ODPiCUMiLr/gZ441FN4YVD88g2EEFIrUcbI=
X-Received: by 2002:a05:6402:3582:b0:514:a5cf:745b with SMTP id
 y2-20020a056402358200b00514a5cf745bmr11687147edc.3.1686018475283; Mon, 05 Jun
 2023 19:27:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230605034423.1528206-1-maobibo@loongson.cn> <20230605145138.GH21212@willie-the-truck>
In-Reply-To: <20230605145138.GH21212@willie-the-truck>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Tue, 6 Jun 2023 10:27:43 +0800
X-Gmail-Original-Message-ID: <CAAhV-H449Kv0WVfpD-d_j1Gq0Ud-TGqZRHAn6MrjQWH76cLGCA@mail.gmail.com>
Message-ID: <CAAhV-H449Kv0WVfpD-d_j1Gq0Ud-TGqZRHAn6MrjQWH76cLGCA@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: Align pci memory space base address with page size
To:     Will Deacon <will@kernel.org>
Cc:     Bibo Mao <maobibo@loongson.cn>,
        Catalin Marinas <catalin.marinas@arm.com>, helgaas@kernel.org,
        linux-pci@vger.kernel.org, Jianmin Lv <lvjianmin@loongson.cn>,
        WANG Xuerui <kernel@xen0n.name>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
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

On Mon, Jun 5, 2023 at 10:51=E2=80=AFPM Will Deacon <will@kernel.org> wrote=
:
>
> On Mon, Jun 05, 2023 at 11:44:23AM +0800, Bibo Mao wrote:
> > Some PCI devices has only 4K memory space size, it is normal in general
> > machines and aligned with page size. However some architectures which
> > support different page size, default page size on LoongArch is 16K, and
> > ARM64 supports page size varying from 4K to 64K. On machines where larg=
er
> > page size is use, memory space region of two different pci devices may =
be
> > in one page. It is not safe with mmu protection, also VFIO pci device
> > driver requires base address of pci memory space page aligned, so that =
it
> > can be memory mapped to qemu user space when it is pass-through to vm.
> >
> > It consumes more pci memory resource with page size alignment requireme=
nt,
> > on 64 bit system it should not be a problem. And UEFI bios set pci memo=
ry
> > base address with 4K fixed-size aligned, the safer solution is to align
> > with larger size on UEFI BIOS stage on these architectures, linux kerne=
l
> > can reuse resource from UEFI bios. For new devices such hotplug pci
> > devices and sriov devices, pci resource is assigned in Linux kernel sid=
e.
> >
> > Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> > ---
> >  arch/arm64/kernel/pci.c  | 13 +++++++++++++
> >  arch/loongarch/pci/pci.c | 18 ++++++++++++++++++
> >  2 files changed, 31 insertions(+)
> >
> > diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
> > index 2276689b5411..e2f7b176b156 100644
> > --- a/arch/arm64/kernel/pci.c
> > +++ b/arch/arm64/kernel/pci.c
> > @@ -232,4 +232,17 @@ void pcibios_remove_bus(struct pci_bus *bus)
> >       acpi_pci_remove_bus(bus);
> >  }
> >
> > +resource_size_t pcibios_align_resource(void *data, const struct resour=
ce *res,
> > +                             resource_size_t size, resource_size_t ali=
gn)
> > +{
> > +     resource_size_t start =3D res->start;
> > +
> > +     /*
> > +      * align base address of pci memory resource with page size
> > +      */
> > +     if ((res->flags & IORESOURCE_MEM) && (align < PAGE_SIZE))
> > +             start =3D ALIGN(start, PAGE_SIZE);
> > +
> > +     return start;
> > +}
> >  #endif
>
> If this is needed by all architectures with !4k page size, why don't we
> instead handle the alignment in the core code, given that it is aware
> of the page size?
Agree, modifying the common weak version of pcibios_align_resource()
seems better. Maybe we can use CONFIG_VFIO_PCI to guard the align
operation.

Huacai
>
> Will
