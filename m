Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC697A4CAF
	for <lists+linux-pci@lfdr.de>; Mon, 18 Sep 2023 17:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbjIRPio convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Mon, 18 Sep 2023 11:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjIRPin (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Sep 2023 11:38:43 -0400
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0534B30CB;
        Mon, 18 Sep 2023 08:37:20 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-58dce1f42d6so77857367b3.0;
        Mon, 18 Sep 2023 08:37:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695051179; x=1695655979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4usGc9aalGjopd8uzawCJLzJGsJptzLIU24rQ6XhnjI=;
        b=CJC+Dzuyx0hBIgzj0+XXED1FolP+ueNadQqrPdT3AxP6t2uX0ut4MwaVcuMxnExCw4
         MuMsj9oS3gf3KGX/ggW+9ArpZuVD+gB3XHVOXx+tbITx3SNG12oev/GL2wPV4p9t8H7g
         xq8C674Yjh0/8qNI4fpPGqQAeCBM/jCUVOTvZJ5NjNP9rfyT/6VUFY9Z0w+83hA0P8CC
         ZJwOGMGOzb2ETWXAFmixuh0TC6f1Ul+5YNtMhadx2R6cwpYm2HBxRRJcL13Fom0Ii2PG
         qoGsn+gCVw7OnuNG9rXBrho9GEU1n9ur6bxGSetyhs1X7HmzchIkKyKwOTgkZyUSoNfV
         75wg==
X-Gm-Message-State: AOJu0YxE6dn19xjtxqemIUUlj7rWOub2htay8rTVr1WqEccSVVWfMtLx
        TWo7gHL+U42MngAVfne09O96XtLAh0bfxQ==
X-Google-Smtp-Source: AGHT+IG91vIgu8arEHRAiDnDxKlmz2nE3NJ80tnQhQgtrk4W/ltJPWRk9m/iW8HRoBEe7WiPA/IdGA==
X-Received: by 2002:a0d:d60e:0:b0:583:8c61:de8 with SMTP id y14-20020a0dd60e000000b005838c610de8mr11001999ywd.16.1695051179089;
        Mon, 18 Sep 2023 08:32:59 -0700 (PDT)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id s66-20020a0dd045000000b00589e68edac6sm2657593ywd.39.2023.09.18.08.32.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 08:32:58 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-59e6ebdf949so27286677b3.0;
        Mon, 18 Sep 2023 08:32:58 -0700 (PDT)
X-Received: by 2002:a81:8301:0:b0:59b:d5eb:3a83 with SMTP id
 t1-20020a818301000000b0059bd5eb3a83mr13424998ywf.16.1695051178689; Mon, 18
 Sep 2023 08:32:58 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1694596125.git.ysato@users.sourceforge.jp> <7f25af9e93fbb84c8e4fe6da3c0c13b0a6be2c73.1694596125.git.ysato@users.sourceforge.jp>
In-Reply-To: <7f25af9e93fbb84c8e4fe6da3c0c13b0a6be2c73.1694596125.git.ysato@users.sourceforge.jp>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 18 Sep 2023 17:32:46 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX0enQeLcLO6hmKFXqMeZVfoT0qrz3XTCWuUUTWwS-vHw@mail.gmail.com>
Message-ID: <CAMuHMdX0enQeLcLO6hmKFXqMeZVfoT0qrz3XTCWuUUTWwS-vHw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 07/30] drivers/pci: SH7751 PCI Host bridge
 controller driver.
To:     Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     linux-sh@vger.kernel.org, glaubitz@physik.fu-berlin.de,
        linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Sato-san,

On Wed, Sep 13, 2023 at 11:35 AM Yoshinori Sato
<ysato@users.sourceforge.jp> wrote:
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>

Thanks for your patch!

> --- /dev/null
> +++ b/drivers/pci/controller/pci-sh7751.c
> @@ -0,0 +1,338 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * SH7751 PCI driver
> + * Copyright (C) 2023 Yoshinori Sato
> + *
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_address.h>
> +#include <linux/of_pci.h>
> +#include <linux/of_platform.h>
> +#include <linux/pci-ecam.h>
> +#include <linux/platform_device.h>
> +#include <linux/io.h>
> +#include <asm-generic/pci.h>
> +#include "pci-sh7751.h"
> +
> +#define pcic_writel(val, reg) __raw_writel(val, pci_reg_base + (reg))
> +#define pcic_readl(reg) __raw_readl(pci_reg_base + (reg))
> +
> +DEFINE_RAW_SPINLOCK(pci_config_lock);
> +
> +/*
> + * PCIC fixups
> + */
> +
> +#define PCIMCR_MRSET 0x40000000
> +#define PCIMCR_RFSH  0x00000004
> +
> +/* board depend PCI bus fixups */
> +static void __init julian_fixup(void __iomem *pci_reg_base, void __iomem *bcr)

Please drop all the __init* annotations.
Although I no longer see invalid section warnings, all symbols tagged
with __init* are still referenced from sh7751_pci_probe(), eventually.

> +{
> +       unsigned long bcr1, mcr;
> +
> +       bcr1 = __raw_readl(bcr + SH7751_BCR1);
> +       bcr1 |= 0x00080000;     /* Enable Bit 19 BREQEN, set PCIC to slave */
> +       pcic_writel(bcr1, SH4_PCIBCR1);
> +
> +       mcr = __raw_readl(bcr + SH7751_MCR);
> +       mcr &= (~PCIMCR_MRSET) & (~PCIMCR_RFSH);
> +       pcic_writel(mcr, SH4_PCIMCR);
> +
> +       pcic_writel(0x0c000000, SH7751_PCICONF5);
> +       pcic_writel(0xd0000000, SH7751_PCICONF6);
> +       pcic_writel(0x0c000000, SH4_PCILAR0);
> +       pcic_writel(0x00000000, SH4_PCILAR1);
> +}
> +
> +static void __init r2d_fixup(void __iomem *pci_reg_base, void __iomem *bcr)
> +{
> +       unsigned long bcr1, mcr;
> +
> +       bcr1 = ioread32(bcr + SH7751_BCR1);
> +       bcr1 |= 0x40080000;     /* Enable Bit 19 BREQEN, set PCIC to slave */
> +       pcic_writel(bcr1, SH4_PCIBCR1);
> +
> +       /* Enable all interrupts, so we known what to fix */
> +       pcic_writel(0x0000c3ff, SH4_PCIINTM);
> +       pcic_writel(0x0000380f, SH4_PCIAINTM);
> +
> +       pcic_writel(0xfb900047, SH7751_PCICONF1);
> +       pcic_writel(0xab000001, SH7751_PCICONF4);
> +
> +       mcr = ioread32(bcr + SH7751_MCR);
> +       mcr &= (~PCIMCR_MRSET) & (~PCIMCR_RFSH);
> +       pcic_writel(mcr, SH4_PCIMCR);
> +
> +       pcic_writel(0x0c000000, SH7751_PCICONF5);
> +       pcic_writel(0xd0000000, SH7751_PCICONF6);
> +       pcic_writel(0x0c000000, SH4_PCILAR0);
> +       pcic_writel(0x00000000, SH4_PCILAR1);
> +}
> +
> +static const __initconst struct fixups {
> +       char *compatible;
> +       void (*fixup)(void __iomem *pci_reg_base, void __iomem *bcr);
> +} fixup_list[] = {
> +       {
> +               .compatible = "iodata,julian-pci",
> +               .fixup = julian_fixup,
> +       },
> +       {
> +               .compatible = "renesas,r2d-pci",
> +               .fixup = r2d_fixup,
> +       },
> +};

These fixups seem to be board-specific instead of specific to the
PCI block in the SoCs on these boards.

I see three options to handle this in a more appropriate way:
  1. Handle this in the bootloader.
     Not an attractive solution, as not everyone can/wants to update
     the bootloader,
  2. Use of_machine_is_compatible() in a platform-specific quirk
     handler, outside the PCI driver,
  3. Move the common parts into sh7751_pci_probe(), and the
     handle the differences through DT topology analysis and/or
     properties in DT.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
