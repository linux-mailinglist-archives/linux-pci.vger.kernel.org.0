Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 878FB78E671
	for <lists+linux-pci@lfdr.de>; Thu, 31 Aug 2023 08:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233573AbjHaGXo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 31 Aug 2023 02:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234884AbjHaGXn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 31 Aug 2023 02:23:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 211F2E65;
        Wed, 30 Aug 2023 23:23:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 04BA2B821AD;
        Thu, 31 Aug 2023 06:22:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A49DFC433C9;
        Thu, 31 Aug 2023 06:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693462969;
        bh=NnIkxLpJHMcAeGNpbH7LMO7pryQqZWxaBW6GTtNQqU0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Dg8qbf7TmXktAwhzqLqsUy/BpGdPaW/L83G835vuDNTUSrvx0uDZP4bPAt+PjIJm0
         DyqLe6DwNGiLAqpPBAjw9usYShRvJyrpGksnqM7MOy/j6teJQnA7JWId5sePZwLVsV
         wvayQWVQm7611OCtuV9uzRgOtI0qMiyXdn1IhpbYEfU5zwP88+8sAynX+l/86LUlH0
         FsasjT9XbH/L9bRTk3KI89uPyCrqQpn+UrF7Tbb4yICNKQr/pyPYRFd1nRi5YClnmF
         h7SNOYdKdZWXuC8gHBtJRk6vXaE8RIOgeC4CtYYmwwFIBAmV1a6XTfldIuDlldLm+Z
         eV588VNEMcd0g==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-99bed101b70so41340966b.3;
        Wed, 30 Aug 2023 23:22:49 -0700 (PDT)
X-Gm-Message-State: AOJu0YwWenqt29kmF5wcpt+S7KS5NKzpsxIJ3FAQBPphgHUgdMpxvQfX
        s0WmWSiihDclPlxS12J7B6w4sqlmcDDVIXRLeNo=
X-Google-Smtp-Source: AGHT+IHDKeKoZUnXrtwQUVQn3sHN+bI5YOhGIcndZ1GL5ifhpu8EHIcYfoKbSvSWIRrUF57RE0hfYw1Vcx0wp4DHLPk=
X-Received: by 2002:a17:906:113:b0:9a5:9f8d:764 with SMTP id
 19-20020a170906011300b009a59f8d0764mr3200584eje.77.1693462967838; Wed, 30 Aug
 2023 23:22:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230725061008.1504292-1-jiaxun.yang@flygoat.com>
 <e9c103dc-98ac-9a51-7291-f5da1467b2ff@flygoat.com> <CAAhV-H7_OjTaU_wn6mUW0-JSrXS+=A2rXCiBc8cyce5ob49BLg@mail.gmail.com>
 <861a809d-3df1-327e-e033-87506f6d89e5@flygoat.com>
In-Reply-To: <861a809d-3df1-327e-e033-87506f6d89e5@flygoat.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Thu, 31 Aug 2023 14:22:35 +0800
X-Gmail-Original-Message-ID: <CAAhV-H67ehyqtm4ocOTWQPGBioWjQjLoyN5H9hALdq0oXdzWVg@mail.gmail.com>
Message-ID: <CAAhV-H67ehyqtm4ocOTWQPGBioWjQjLoyN5H9hALdq0oXdzWVg@mail.gmail.com>
Subject: Re: [PATCH v2] pci: loongson: Workaround MIPS firmware MRRS settings
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     linux-pci@vger.kernel.org, bhelgaas@google.com,
        linux-kernel@vger.kernel.org, kw@linux.com, lpieralisi@kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi, Jiaxun,

On Tue, Aug 8, 2023 at 3:38=E2=80=AFPM Jiaxun Yang <jiaxun.yang@flygoat.com=
> wrote:
>
>
>
> =E5=9C=A8 2023/8/6 22:30, Huacai Chen =E5=86=99=E9=81=93:
> > Hi, Jiaxun,
> >
> > On Sun, Aug 6, 2023 at 10:20=E2=80=AFAM Jiaxun Yang <jiaxun.yang@flygoa=
t.com> wrote:
> >>
> >>
> >> =E5=9C=A8 2023/7/25 14:10, Jiaxun Yang =E5=86=99=E9=81=93:
> >>> This is a partial revert of commit 8b3517f88ff2 ("PCI:
> >>> loongson: Prevent LS7A MRRS increases") for MIPS based Loongson.
> >>>
> >>> There are many MIPS based Loongson systems in wild that
> >>> shipped with firmware which does not set maximum MRRS properly.
> >>>
> >>> Limiting MRRS to 256 for all as MIPS Loongson comes with higher
> >>> MRRS support is considered rare.
> >>>
> >>> Cc: stable@vger.kernel.org
> >>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D217680
> >>> Fixes: 8b3517f88ff2 ("PCI: loongson: Prevent LS7A MRRS increases")
> >>> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> >> Ping?
> >> I expect this patch to go through PCI fixes tree.
> > Can we do it like this by modifying the existing loongson_mrrs_quirk()?
>
> Hmm, I'm not sure this will work, since loongson_mrrs_quirk only run on
> bridges
But it is worth to try, and you can walk the children to set mrrs when
the quirk runs on bridges, I think.

> but the old quirk should run on every single device.
Your current patch has a drawback that both quirks will run for MIPS,
and their order is random (though it may cause nothing, but not
elegant).

Huacai

>
> Thanks
> Jiaxun
>
> >
> > static void loongson_mrrs_quirk(struct pci_dev *pdev)
> > {
> >          /*
> >           * Some Loongson PCIe ports have h/w limitations of maximum re=
ad
> >           * request size. They can't handle anything larger than this. =
So
> >           * force this limit on any devices attached under these ports.
> >           */
> >          struct pci_host_bridge *bridge =3D pci_find_host_bridge(pdev->=
bus);
> >
> > #ifdef CONFIG_MIPS
> >          set_pcie_ports_to_mrrs_256_to_emulate_the_firmware_behavior();
> > #endif
> >
> >          bridge->no_inc_mrrs =3D 1;
> > }
> >
> >> Thanks
> >> - Jiaxun
> >>
> >>> ---
> >>> v2: Rename quirk name to: loongson_old_mrrs_quirk
> >>> ---
> >>>    drivers/pci/controller/pci-loongson.c | 38 +++++++++++++++++++++++=
++++
> >>>    1 file changed, 38 insertions(+)
> >>>
> >>> diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/cont=
roller/pci-loongson.c
> >>> index fe0f732f6e43..d0f68b102d10 100644
> >>> --- a/drivers/pci/controller/pci-loongson.c
> >>> +++ b/drivers/pci/controller/pci-loongson.c
> >>> @@ -108,6 +108,44 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
> >>>    DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
> >>>                        DEV_LS7A_PCIE_PORT6, loongson_mrrs_quirk);
> >>>
> >>> +#ifdef CONFIG_MIPS
> >>> +static void loongson_old_mrrs_quirk(struct pci_dev *pdev)
> >>> +{
> >>> +     struct pci_bus *bus =3D pdev->bus;
> >>> +     struct pci_dev *bridge;
> >>> +     static const struct pci_device_id bridge_devids[] =3D {
> >>> +             { PCI_VDEVICE(LOONGSON, DEV_LS2K_PCIE_PORT0) },
> >>> +             { PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT0) },
> >>> +             { PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT1) },
> >>> +             { PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT2) },
> >>> +             { PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT3) },
> >>> +             { PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT4) },
> >>> +             { PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT5) },
> >>> +             { PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT6) },
> >>> +             { 0, },
> >>> +     };
> >>> +
> >>> +     /* look for the matching bridge */
> >>> +     while (!pci_is_root_bus(bus)) {
> >>> +             bridge =3D bus->self;
> >>> +             bus =3D bus->parent;
> >>> +             /*
> >>> +              * There are still some wild MIPS Loongson firmware won=
't
> >>> +              * set MRRS properly. Limiting MRRS to 256 as MIPS Loon=
gson
> >>> +              * comes with higher MRRS support is considered rare.
> >>> +              */
> >>> +             if (pci_match_id(bridge_devids, bridge)) {
> >>> +                     if (pcie_get_readrq(pdev) > 256) {
> >>> +                             pci_info(pdev, "limiting MRRS to 256\n"=
);
> >>> +                             pcie_set_readrq(pdev, 256);
> >>> +                     }
> >>> +                     break;
> >>> +             }
> >>> +     }
> >>> +}
> >>> +DECLARE_PCI_FIXUP_ENABLE(PCI_ANY_ID, PCI_ANY_ID, loongson_old_mrrs_q=
uirk);
> >>> +#endif
> >>> +
> >>>    static void loongson_pci_pin_quirk(struct pci_dev *pdev)
> >>>    {
> >>>        pdev->pin =3D 1 + (PCI_FUNC(pdev->devfn) & 3);
>
