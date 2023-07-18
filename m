Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7E23757FFC
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jul 2023 16:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233382AbjGROrN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Jul 2023 10:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233393AbjGROrM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Jul 2023 10:47:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 684D6121;
        Tue, 18 Jul 2023 07:47:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA0C1615F0;
        Tue, 18 Jul 2023 14:47:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45294C433C8;
        Tue, 18 Jul 2023 14:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689691627;
        bh=yKiFuGJOIwDdQPHhupJPounzK/QXjphoqIVxpQqEW4Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=U23Od0fJduI/ysk68TNZQyieGuXJWr0rZl69KTEstpmY0w5a2wl6cevPqn8hY8meQ
         vybOJuFkivpaUCYAZpMrWCXpvy1o+NfkHHejazEkW0KGs7DJjpnEKGsV78ZL+lXS6n
         wonYKO9/B8S7J0rsTR4r88sKP1OhiQGM/+dYLDQzFc8O5jpTIvU8d0UqhYZoVo0xe9
         NA8o7BzBBY0MNMrvPwv+9WmUk3faF1Eup07EBf/f682ntEMyZL4nlkNhuOr3OXZc9H
         EWaME6yxRYsuciSQrKGRSI+FJ8rAiMKZwtrG0WKeAaLLDTuIsGuXs3K6Qqv2VFS8Vz
         emHH0jrAe3dsA==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-51e56749750so7915892a12.0;
        Tue, 18 Jul 2023 07:47:07 -0700 (PDT)
X-Gm-Message-State: ABy/qLZt5sfrBVReNgGI2O4UZ+XJ2FmhLN7Q4yg8oscH4xkN8VsFxoVA
        awkd34dbeZDby00dFzDEHDrzFvB3VQX7GUCoWKE=
X-Google-Smtp-Source: APBJJlHexohWohwpizSaf3A4+UzNJ6vSKYrGFq0YOdWy1Qb47xNPXuXSkIf+KfQfEIq2x0jkvlhBbRlzivDO9gnFK9g=
X-Received: by 2002:aa7:d418:0:b0:51e:2282:e1fc with SMTP id
 z24-20020aa7d418000000b0051e2282e1fcmr157800edq.6.1689691625525; Tue, 18 Jul
 2023 07:47:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230718133259.2867432-1-jiaxun.yang@flygoat.com>
In-Reply-To: <20230718133259.2867432-1-jiaxun.yang@flygoat.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Tue, 18 Jul 2023 22:46:54 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7bv1OmzT0E-SEF6w83gPYrTwnZfc0WpWMUmBB1T1MmqQ@mail.gmail.com>
Message-ID: <CAAhV-H7bv1OmzT0E-SEF6w83gPYrTwnZfc0WpWMUmBB1T1MmqQ@mail.gmail.com>
Subject: Re: [PATCH] pci: loongson: Workaround MIPS firmware MRRS settings
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, kw@linux.com, lpieralisi@kernel.org
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

Hi, Jiaxun,

On Tue, Jul 18, 2023 at 9:33=E2=80=AFPM Jiaxun Yang <jiaxun.yang@flygoat.co=
m> wrote:
>
> This is a partial revert of commit 8b3517f88ff2 ("PCI:
> loongson: Prevent LS7A MRRS increases") for MIPS based Loongson.
>
> There are many MIPS based Loongson systems in wild that
> shipped with firmware which does not set maximum MRRS properly.
>
> Limiting MRRS to 256 for all as MIPS Loongson comes with higher
> MRRS support is considered rare.
>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D217680
> Fixes: 8b3517f88ff2 ("PCI: loongson: Prevent LS7A MRRS increases")
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>  drivers/pci/controller/pci-loongson.c | 38 +++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>
> diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controll=
er/pci-loongson.c
> index fe0f732f6e43..1cc3a5535dac 100644
> --- a/drivers/pci/controller/pci-loongson.c
> +++ b/drivers/pci/controller/pci-loongson.c
> @@ -108,6 +108,44 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
>                         DEV_LS7A_PCIE_PORT6, loongson_mrrs_quirk);
>
> +#ifdef CONFIG_MIPS
> +static void loongson_firmware_mrrs_quirk(struct pci_dev *pdev)
From my point of view, loongson_old_mrrs_quirk() may be better.

Huacai

> +{
> +       struct pci_bus *bus =3D pdev->bus;
> +       struct pci_dev *bridge;
> +       static const struct pci_device_id bridge_devids[] =3D {
> +               { PCI_VDEVICE(LOONGSON, DEV_LS2K_PCIE_PORT0) },
> +               { PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT0) },
> +               { PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT1) },
> +               { PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT2) },
> +               { PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT3) },
> +               { PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT4) },
> +               { PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT5) },
> +               { PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT6) },
> +               { 0, },
> +       };
> +
> +       /* look for the matching bridge */
> +       while (!pci_is_root_bus(bus)) {
> +               bridge =3D bus->self;
> +               bus =3D bus->parent;
> +               /*
> +                * There are still some wild MIPS Loongson firmware won't
> +                * set MRRS properly. Limiting MRRS to 256 as MIPS Loongs=
on
> +                * comes with higher MRRS support is considered rare.
> +                */
> +               if (pci_match_id(bridge_devids, bridge)) {
> +                       if (pcie_get_readrq(pdev) > 256) {
> +                               pci_info(pdev, "limiting MRRS to 256\n");
> +                               pcie_set_readrq(pdev, 256);
> +                       }
> +                       break;
> +               }
> +       }
> +}
> +DECLARE_PCI_FIXUP_ENABLE(PCI_ANY_ID, PCI_ANY_ID, loongson_firmware_mrrs_=
quirk);
> +#endif
> +
>  static void loongson_pci_pin_quirk(struct pci_dev *pdev)
>  {
>         pdev->pin =3D 1 + (PCI_FUNC(pdev->devfn) & 3);
> --
> 2.39.2
>
