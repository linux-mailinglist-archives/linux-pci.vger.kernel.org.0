Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB471242728
	for <lists+linux-pci@lfdr.de>; Wed, 12 Aug 2020 11:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbgHLJDX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Aug 2020 05:03:23 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43155 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbgHLJDW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Aug 2020 05:03:22 -0400
Received: by mail-ot1-f67.google.com with SMTP id r21so1349040ota.10;
        Wed, 12 Aug 2020 02:03:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gUAKmWocimbWFJByMnP/SETTkQ6pqljqZpa74N4jY3c=;
        b=XjNLEWlrQRZukwK8sfGRYwjeXFvlWqbdNeZOZouWhNdlsqpT32oEFHPalzuRyuFH/V
         QEb3B2JmPzHb5I1s7e5BUyy2Cqjvgx+JuG2Pv5L85GULQaxp+fFGIwEo9mdodKy8Jqib
         O3mZY+fp0Yqwriz09a4hHAq8G+ns1Ve3WNIq1KozfIWlkkAD7P3UhuW9hntQAyGhG9xK
         vj3sD5cpyozsoubYxRZ/PWqhiqgaCwrIzar2piHyle6yP8kYxK9B8AQpDGS8AkLVyLfL
         SNPwF6YdB9Q9fSzt73NQoYUrdTc6McYxcRz5+vsnbwkyelsOcbR8gpIyaVA4CgXoGlKk
         DLag==
X-Gm-Message-State: AOAM532AzBmkInFQeefZKsmftV70ZHT7JVlxzYHLmc7bmipMISvK3JlH
        9cQyqPOoIQVnFFkj6KF6chM9URehFgvtUtOZbw8=
X-Google-Smtp-Source: ABdhPJzz/L+SWk+xdR5ktmbiR9Qq6v6uAoWmIpmjcT8Qrbb1QB5w0us/LpTaAW+Q/PdpbWdBGNPRSnKICnxnB4wQDU0=
X-Received: by 2002:a9d:7d8c:: with SMTP id j12mr8529371otn.250.1597223001253;
 Wed, 12 Aug 2020 02:03:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200811140357.564-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20200811140357.564-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 12 Aug 2020 11:03:09 +0200
Message-ID: <CAMuHMdWZ+NPRWvDiM8V++UPKnvPP55OzPNHDhoP_RX0fb1Lx2Q@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: defconfig: Enable R-Car PCIe endpoint driver
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Prabhakar,

CC PCI endpoint people

On Tue, Aug 11, 2020 at 4:04 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Enable R-Car PCIe endpoint driver on RZ/G2E board, including enabling
> endpoint configurations CONFIG_PCI_ENDPOINT, CONFIG_PCI_ENDPOINT_CONFIGFS,
> CONFIG_PCI_EPF_TEST and CONFIG_PCI_ENDPOINT_TEST required to use and test
> the driver.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v1->v2
> * Made CONFIG_PCI_EPF_TEST and CONFIG_PCI_ENDPOINT_TEST as modules

Thanks for the update!

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v5.10.

However, as no core PCI code seems to depend on CONFIG_PCI_ENDPOINT, I
would like to request the PCI endpoint people to consider making all PCI
endpoint support tristate, so we can revisit this change to the arm64
defconfig later.

Thanks!

> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -208,6 +208,7 @@ CONFIG_HOTPLUG_PCI_ACPI=y
>  CONFIG_PCI_AARDVARK=y
>  CONFIG_PCI_TEGRA=y
>  CONFIG_PCIE_RCAR_HOST=y
> +CONFIG_PCIE_RCAR_EP=y
>  CONFIG_PCI_HOST_GENERIC=y
>  CONFIG_PCI_XGENE=y
>  CONFIG_PCIE_ALTERA=y
> @@ -224,6 +225,9 @@ CONFIG_PCIE_ARMADA_8K=y
>  CONFIG_PCIE_KIRIN=y
>  CONFIG_PCIE_HISI_STB=y
>  CONFIG_PCIE_TEGRA194_HOST=m
> +CONFIG_PCI_ENDPOINT=y
> +CONFIG_PCI_ENDPOINT_CONFIGFS=y
> +CONFIG_PCI_EPF_TEST=m
>  CONFIG_DEVTMPFS=y
>  CONFIG_DEVTMPFS_MOUNT=y
>  CONFIG_FW_LOADER_USER_HELPER=y
> @@ -254,6 +258,7 @@ CONFIG_BLK_DEV_NBD=m
>  CONFIG_VIRTIO_BLK=y
>  CONFIG_BLK_DEV_NVME=m
>  CONFIG_SRAM=y
> +CONFIG_PCI_ENDPOINT_TEST=m
>  CONFIG_EEPROM_AT24=m
>  CONFIG_EEPROM_AT25=m
>  CONFIG_UACCE=m

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
