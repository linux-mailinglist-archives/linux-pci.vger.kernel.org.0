Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3CF7715A1
	for <lists+linux-pci@lfdr.de>; Sun,  6 Aug 2023 16:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbjHFObB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 6 Aug 2023 10:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjHFObB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 6 Aug 2023 10:31:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC3AE49;
        Sun,  6 Aug 2023 07:30:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6087761058;
        Sun,  6 Aug 2023 14:30:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2137C433CA;
        Sun,  6 Aug 2023 14:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691332258;
        bh=JrZfNdw9wgAZfBMUuRYMyGJexeF+fKE8GZDmCA/BpeI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YTU8MC0+gH8TfbrhCBbJqavhqTyGGPF5Aj0sHrJy2mtO7ljXuMzZf24h7rzwkyUFx
         1wef7z7KMC8U+vBOUBfugecKv0/UDYWO4DUMbrrcB9K10vJdsmA3o17DlUsNRnUYWX
         x0nR97kCUgpt236K1p6/yaQ4y2dEZksHu1+iD0d+muqLDVhNVzlE4TsnzSCzWHQPTX
         rBzFwzVi9siE+/ch+JgCHLJl6TcBxEb7mTfEdX5+spqRianM65dTpfwLlK3O4Oldx1
         MEGPe3CngMeknvMdwpLV4oqEnz0zezluRumRkkxO6Y5Xwzy7oaObB70Ft911L0BEvR
         YU4yQzAQ6eUoQ==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-52229f084beso5324284a12.2;
        Sun, 06 Aug 2023 07:30:58 -0700 (PDT)
X-Gm-Message-State: AOJu0YxjPvNp2XUp7Fx4Rl3w2zu3W0B3TwdpN45LvYrv69zetn5Gsviv
        YpmJuvCMeiibexJ99kluAutEBB2R5c6vc/CCA3w=
X-Google-Smtp-Source: AGHT+IHnNYeNlB/J6SJY/CFDzA2RFqR6M0U8Ki5KshBuuCYRCLBknJAiKZxM+4l7ASuSyVx1k5af/FCZI4gVt9alZo4=
X-Received: by 2002:aa7:de96:0:b0:522:2aee:682c with SMTP id
 j22-20020aa7de96000000b005222aee682cmr5517074edv.2.1691332256931; Sun, 06 Aug
 2023 07:30:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230725061008.1504292-1-jiaxun.yang@flygoat.com> <e9c103dc-98ac-9a51-7291-f5da1467b2ff@flygoat.com>
In-Reply-To: <e9c103dc-98ac-9a51-7291-f5da1467b2ff@flygoat.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Sun, 6 Aug 2023 22:30:45 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7_OjTaU_wn6mUW0-JSrXS+=A2rXCiBc8cyce5ob49BLg@mail.gmail.com>
Message-ID: <CAAhV-H7_OjTaU_wn6mUW0-JSrXS+=A2rXCiBc8cyce5ob49BLg@mail.gmail.com>
Subject: Re: [PATCH v2] pci: loongson: Workaround MIPS firmware MRRS settings
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     linux-pci@vger.kernel.org, bhelgaas@google.com,
        linux-kernel@vger.kernel.org, kw@linux.com, lpieralisi@kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi, Jiaxun,

On Sun, Aug 6, 2023 at 10:20=E2=80=AFAM Jiaxun Yang <jiaxun.yang@flygoat.co=
m> wrote:
>
>
>
> =E5=9C=A8 2023/7/25 14:10, Jiaxun Yang =E5=86=99=E9=81=93:
> > This is a partial revert of commit 8b3517f88ff2 ("PCI:
> > loongson: Prevent LS7A MRRS increases") for MIPS based Loongson.
> >
> > There are many MIPS based Loongson systems in wild that
> > shipped with firmware which does not set maximum MRRS properly.
> >
> > Limiting MRRS to 256 for all as MIPS Loongson comes with higher
> > MRRS support is considered rare.
> >
> > Cc: stable@vger.kernel.org
> > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D217680
> > Fixes: 8b3517f88ff2 ("PCI: loongson: Prevent LS7A MRRS increases")
> > Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>
> Ping?
> I expect this patch to go through PCI fixes tree.
Can we do it like this by modifying the existing loongson_mrrs_quirk()?

static void loongson_mrrs_quirk(struct pci_dev *pdev)
{
        /*
         * Some Loongson PCIe ports have h/w limitations of maximum read
         * request size. They can't handle anything larger than this. So
         * force this limit on any devices attached under these ports.
         */
        struct pci_host_bridge *bridge =3D pci_find_host_bridge(pdev->bus);

#ifdef CONFIG_MIPS
        set_pcie_ports_to_mrrs_256_to_emulate_the_firmware_behavior();
#endif

        bridge->no_inc_mrrs =3D 1;
}

>
> Thanks
> - Jiaxun
>
> > ---
> > v2: Rename quirk name to: loongson_old_mrrs_quirk
> > ---
> >   drivers/pci/controller/pci-loongson.c | 38 ++++++++++++++++++++++++++=
+
> >   1 file changed, 38 insertions(+)
> >
> > diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/contro=
ller/pci-loongson.c
> > index fe0f732f6e43..d0f68b102d10 100644
> > --- a/drivers/pci/controller/pci-loongson.c
> > +++ b/drivers/pci/controller/pci-loongson.c
> > @@ -108,6 +108,44 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
> >   DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
> >                       DEV_LS7A_PCIE_PORT6, loongson_mrrs_quirk);
> >
> > +#ifdef CONFIG_MIPS
> > +static void loongson_old_mrrs_quirk(struct pci_dev *pdev)
> > +{
> > +     struct pci_bus *bus =3D pdev->bus;
> > +     struct pci_dev *bridge;
> > +     static const struct pci_device_id bridge_devids[] =3D {
> > +             { PCI_VDEVICE(LOONGSON, DEV_LS2K_PCIE_PORT0) },
> > +             { PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT0) },
> > +             { PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT1) },
> > +             { PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT2) },
> > +             { PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT3) },
> > +             { PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT4) },
> > +             { PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT5) },
> > +             { PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT6) },
> > +             { 0, },
> > +     };
> > +
> > +     /* look for the matching bridge */
> > +     while (!pci_is_root_bus(bus)) {
> > +             bridge =3D bus->self;
> > +             bus =3D bus->parent;
> > +             /*
> > +              * There are still some wild MIPS Loongson firmware won't
> > +              * set MRRS properly. Limiting MRRS to 256 as MIPS Loongs=
on
> > +              * comes with higher MRRS support is considered rare.
> > +              */
> > +             if (pci_match_id(bridge_devids, bridge)) {
> > +                     if (pcie_get_readrq(pdev) > 256) {
> > +                             pci_info(pdev, "limiting MRRS to 256\n");
> > +                             pcie_set_readrq(pdev, 256);
> > +                     }
> > +                     break;
> > +             }
> > +     }
> > +}
> > +DECLARE_PCI_FIXUP_ENABLE(PCI_ANY_ID, PCI_ANY_ID, loongson_old_mrrs_qui=
rk);
> > +#endif
> > +
> >   static void loongson_pci_pin_quirk(struct pci_dev *pdev)
> >   {
> >       pdev->pin =3D 1 + (PCI_FUNC(pdev->devfn) & 3);
>
