Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40FE37F0A33
	for <lists+linux-pci@lfdr.de>; Mon, 20 Nov 2023 02:00:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbjKTBAr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 19 Nov 2023 20:00:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjKTBAr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 19 Nov 2023 20:00:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D63F0F2;
        Sun, 19 Nov 2023 17:00:43 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59D89C433C7;
        Mon, 20 Nov 2023 01:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700442043;
        bh=qKD5+xB13L+yKxPbKXW2Cb8GqEggWGwNhQxiXp/d6Mg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PR1N5A/TRYt+FdNBdT/aQljkYnTiuZl8FfAHUL2HtCFdsajLwd7pxreAzZy6E93Hi
         J+xQ3kEIgG3y5h0iB7E+F9BrmRDW7PvXL1KKvfFso9BTNL/ZKT1rW339I0qG3CN5yi
         cHGL8UH5UMAvU0M7dL1l6tzZ2sD+1St4yEVMadjo1qCPJThr6gDxYY6dgPYqYW6IPY
         0MFOnZXcqC92UPzz7HBkyWi/qPDq6vftiIA7j9AVfnIQr1HYsj2Mqu+mRpSp1oumKH
         KzwIjqaySyDumhLRiJ3zkpxstwahynpBU7R1PWuA6h1vl8hZRmmimzdfc0zF0kYk9C
         UrYGRSJKMZ2PQ==
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4083f61322fso12079095e9.1;
        Sun, 19 Nov 2023 17:00:43 -0800 (PST)
X-Gm-Message-State: AOJu0YzBbWooPEfHZU/1LRtZVIkwuA3b3UD8HMF7oGSs9scWMSkt3QYl
        iK03ZThmbpjQTXHwFcNVeRL6aHoliXYlJsXCklo=
X-Google-Smtp-Source: AGHT+IH1rNMohrbjoKjAMTzF4WUGMbCzZoxgcQJ3ZzPgbK4tBE9MCBt/UaR8gdUzxhVTOskSF4VuISH0zFGl3h1hjCc=
X-Received: by 2002:a5d:6105:0:b0:32d:9b32:8a7e with SMTP id
 v5-20020a5d6105000000b0032d9b328a7emr3191978wrt.71.1700442041805; Sun, 19 Nov
 2023 17:00:41 -0800 (PST)
MIME-Version: 1.0
References: <20231119215635.52810-1-jiaxun.yang@flygoat.com>
In-Reply-To: <20231119215635.52810-1-jiaxun.yang@flygoat.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Mon, 20 Nov 2023 09:00:34 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6wKMyAEJrRb4V+UzyFBjOQVtkrKCGC80D+_RoGf1h7qA@mail.gmail.com>
Message-ID: <CAAhV-H6wKMyAEJrRb4V+UzyFBjOQVtkrKCGC80D+_RoGf1h7qA@mail.gmail.com>
Subject: Re: [PATCH v5] pci: loongson: Workaround MIPS firmware MRRS settings
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     linux-pci@vger.kernel.org, lpieralisi@kernel.org, kw@linux.com,
        robh@kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

LGTM, so

Acked-by: Huacai Chen <chenhuacai@loongson.cn>

On Mon, Nov 20, 2023 at 5:56=E2=80=AFAM Jiaxun Yang <jiaxun.yang@flygoat.co=
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
> It must be done at device enablement stage because MRRS setting
> may get lost if the parent bridge lost PCI_COMMAND_MASTER, and
> we are only sure parent bridge is enabled at this point.
>
> Cc: stable@vger.kernel.org
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D217680
> Fixes: 8b3517f88ff2 ("PCI: loongson: Prevent LS7A MRRS increases")
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
> v4: Improve commit message
> v5:
>         - Improve commit message and comments.
>         - Style fix from Huacai's off-list input.
> ---
>  drivers/pci/controller/pci-loongson.c | 47 ++++++++++++++++++++++++---
>  1 file changed, 42 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controll=
er/pci-loongson.c
> index d45e7b8dc530..128cc95b236f 100644
> --- a/drivers/pci/controller/pci-loongson.c
> +++ b/drivers/pci/controller/pci-loongson.c
> @@ -80,13 +80,50 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
>                         DEV_LS7A_LPC, system_bus_quirk);
>
> +/*
> + * Some Loongson PCIe ports have h/w limitations of maximum read
> + * request size. They can't handle anything larger than this.
> + * Sane firmware will set proper MRRS at boot, so we only need
> + * no_inc_mrrs for bridges. However, some MIPS Loongson firmware
> + * won't set MRRS properly, and we have to enforce maximum safe
> + * MRRS, which is 256 bytes.
> + */
> +#ifdef CONFIG_MIPS
> +static void loongson_set_min_mrrs_quirk(struct pci_dev *pdev)
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
> +
> +               if (pci_match_id(bridge_devids, bridge)) {
> +                       if (pcie_get_readrq(pdev) > 256) {
> +                               pci_info(pdev, "limiting MRRS to 256\n");
> +                               pcie_set_readrq(pdev, 256);
> +                       }
> +                       break;
> +               }
> +       }
> +}
> +DECLARE_PCI_FIXUP_ENABLE(PCI_ANY_ID, PCI_ANY_ID, loongson_mrrs_quirk_old=
);
> +#endif
> +
>  static void loongson_mrrs_quirk(struct pci_dev *pdev)
>  {
> -       /*
> -        * Some Loongson PCIe ports have h/w limitations of maximum read
> -        * request size. They can't handle anything larger than this. So
> -        * force this limit on any devices attached under these ports.
> -        */
>         struct pci_host_bridge *bridge =3D pci_find_host_bridge(pdev->bus=
);
>
>         bridge->no_inc_mrrs =3D 1;
> --
> 2.34.1
>
