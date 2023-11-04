Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBC197E0D64
	for <lists+linux-pci@lfdr.de>; Sat,  4 Nov 2023 04:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234926AbjKDDMf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Nov 2023 23:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234725AbjKDDMe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Nov 2023 23:12:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D07D42;
        Fri,  3 Nov 2023 20:12:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10FBCC433C9;
        Sat,  4 Nov 2023 03:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699067552;
        bh=oI0QedCsOnC8Jw7SXQdJ46me22RoBpkAwcj3jrvSNwE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=A3D92dsfYdiPd9aSrKm3J5sxnKBpbBkEsH8bXJVjXwIwQSGj42cdE1r92dHJgHdgx
         bKzNhD17fmHLt+4Lqgc9qom4YMq5nBcK5IdJrxTFUBqA4KArdoMYBaBg1LdaErJEI3
         DHB3JCS2XnRbCtDgKqGAYM4+0+aPjmZQ2mLEW81QjL7bqGO/BhsCMgAnQM/ODtwvu0
         YVJm4DmVGNH23PQV7ou316W6YJjfVrE4mhAcCRa4soiD3eY789R4yihOLvMMJgLcS4
         2tFcBqoIA6sqYZUbPn1ZyZRt2bB3CdgaSe2lly4760N32SwrlyCbPL68PQJUt5/N/r
         VRjy6U1N0PYvg==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-9db6cf8309cso373658066b.0;
        Fri, 03 Nov 2023 20:12:32 -0700 (PDT)
X-Gm-Message-State: AOJu0YzknupsSJawLgttBS4C2abNAceytrgV8fDPePs+YWVXy/Aqy0gF
        X0ES6XSTug5BWXV9LrcXtTvA8X1wt59uT1bi/nw=
X-Google-Smtp-Source: AGHT+IFEzA0jYVYe46njXNrOwelVMkm00a0rVzjZ0X18HAMZq/Uj9IcMTrJQaZ092NhSYg7o+LTvhC2J6JJwsLLdvIA=
X-Received: by 2002:a17:907:97cd:b0:9b8:7746:f176 with SMTP id
 js13-20020a17090797cd00b009b87746f176mr8142759ejc.34.1699067550501; Fri, 03
 Nov 2023 20:12:30 -0700 (PDT)
MIME-Version: 1.0
References: <20231101114957.309902-1-jiaxun.yang@flygoat.com>
In-Reply-To: <20231101114957.309902-1-jiaxun.yang@flygoat.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Sat, 4 Nov 2023 11:12:18 +0800
X-Gmail-Original-Message-ID: <CAAhV-H41Jwz2AuGxFJfq1f6nOkSJVASOjN8R6dxDqtDhGTs-Ug@mail.gmail.com>
Message-ID: <CAAhV-H41Jwz2AuGxFJfq1f6nOkSJVASOjN8R6dxDqtDhGTs-Ug@mail.gmail.com>
Subject: Re: [PATCH fixes v4] pci: loongson: Workaround MIPS firmware MRRS settings
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     linux-pci@vger.kernel.org, lpieralisi@kernel.org, kw@linux.com,
        robh@kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 1, 2023 at 11:27=E2=80=AFPM Jiaxun Yang <jiaxun.yang@flygoat.co=
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
> It must be done at device enablement stage because hardware will
> reset MRRS to inavlid value if a device got disabled.
>
> Cc: stable@vger.kernel.org
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D217680
> Fixes: 8b3517f88ff2 ("PCI: loongson: Prevent LS7A MRRS increases")
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
> v4: Improve commit message
>
> This is a partial revert of the origin quirk so there shouldn't
> be any drama.
> ---
>  drivers/pci/controller/pci-loongson.c | 38 +++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>
> diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controll=
er/pci-loongson.c
> index d45e7b8dc530..d184d7b97e54 100644
> --- a/drivers/pci/controller/pci-loongson.c
> +++ b/drivers/pci/controller/pci-loongson.c
> @@ -108,6 +108,44 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
>                         DEV_LS7A_PCIE_PORT6, loongson_mrrs_quirk);
>
> +#ifdef CONFIG_MIPS
> +static void loongson_old_mrrs_quirk(struct pci_dev *pdev)
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
> +DECLARE_PCI_FIXUP_ENABLE(PCI_ANY_ID, PCI_ANY_ID, loongson_old_mrrs_quirk=
);
> +#endif
Rename it to loongson_set_min_mrrs() and move it before
loongson_mrrs_quirk() may be better.

Huacai

> +
>  static void loongson_pci_pin_quirk(struct pci_dev *pdev)
>  {
>         pdev->pin =3D 1 + (PCI_FUNC(pdev->devfn) & 3);
> --
> 2.34.1
>
