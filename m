Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63D01316786
	for <lists+linux-pci@lfdr.de>; Wed, 10 Feb 2021 14:10:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbhBJNJT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Feb 2021 08:09:19 -0500
Received: from mail-oo1-f49.google.com ([209.85.161.49]:37710 "EHLO
        mail-oo1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbhBJNIc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 Feb 2021 08:08:32 -0500
Received: by mail-oo1-f49.google.com with SMTP id e17so478594oow.4;
        Wed, 10 Feb 2021 05:08:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XoCG1YW/SP8S4+O7Ej6kxtjBRmr0Wms3SB4iEnAbul8=;
        b=OautkmRpZ7RJ7IgHaDqcm7I62H2m1D8hGG3Aq9MPO75wUlI4IM9c28l/DC5vU4hvxZ
         caXVusuIH0fJBdvLja0F0fWvz6s+rMDN/QEWYYML6OC+5gVQ2Gbu4y5wLO9ye2Dm0A7x
         XGT7R1k5+92HDiegisOBIDbc8yBFkhMHAmBWL/fy1uFbUWvPWfv5x/tDKMZX9aHkrxZ1
         Gg/Qrw0FMnzfsSe0FtJrQqpPiH7PhgfDmI+a8A0gH9t+BbZ4ClcR04JmAMaptYhlXQTz
         zxKjkZ0LsOyVDG/lctuWtUTAxrNAJ9OfstxZRFtvoyGgD15WAaslJuU0F8lWMcW+bAg3
         cMsw==
X-Gm-Message-State: AOAM532x6NyUsbRjAvEUbCAkLqyUoWl9GFmdXDjpZM12N1FIawXcDkNv
        /pyTvW0gNFqW6DFEAGaA4g9N4OIR8lSFDePf5HM=
X-Google-Smtp-Source: ABdhPJyPtPNf0HnUnFpTLC0OslXjM9MEw/fcdA7efLfKsQQj6HAFf8gcDCNBSXQ3X/E+q0uzai8TTNwJOWI0BLI49qo=
X-Received: by 2002:a4a:ab08:: with SMTP id i8mr2028655oon.40.1612962470681;
 Wed, 10 Feb 2021 05:07:50 -0800 (PST)
MIME-Version: 1.0
References: <20210125162934.5335-1-daire.mcnamara@microchip.com> <20210125162934.5335-4-daire.mcnamara@microchip.com>
In-Reply-To: <20210125162934.5335-4-daire.mcnamara@microchip.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 10 Feb 2021 14:07:39 +0100
Message-ID: <CAMuHMdXJQF3c1b6SXyHnuyA_huO7ZiKJ-_xm1r1h7VcGsv=n9A@mail.gmail.com>
Subject: Re: [PATCH v21 3/4] PCI: microchip: Add host driver for Microchip
 PCIe controller
To:     daire.mcnamara@microchip.com
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, david.abdurachmanov@gmail.com,
        cyril.jean@microchip.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Daire,

On Mon, Jan 25, 2021 at 5:33 PM <daire.mcnamara@microchip.com> wrote:
> From: Daire McNamara <daire.mcnamara@microchip.com>
>
> Add support for the Microchip PolarFire PCIe controller when
> configured in host (Root Complex) mode.
>
> Signed-off-by: Daire McNamara <daire.mcnamara@microchip.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Thanks for your patch!

> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@ -298,6 +298,16 @@ config PCI_LOONGSON
>           Say Y here if you want to enable PCI controller support on
>           Loongson systems.
>
> +config PCIE_MICROCHIP_HOST
> +       bool "Microchip AXI PCIe host bridge support"
> +       depends on PCI_MSI && OF
> +       select PCI_MSI_IRQ_DOMAIN
> +       select GENERIC_MSI_IRQ_DOMAIN
> +       select PCI_HOST_COMMON
> +       help
> +         Say Y here if you want kernel to support the Microchip AXI PCIe
> +         Host Bridge driver.

Is this PCIe host bridge accessible only from the PolarFire RISC-V
CPU cores, or also from softcores implemented in the PolarFire FPGA?

In case of the former, we want to add a

    depends on CONFIG_SOC_MICROCHIP_POLARFIRE || COMPILE_TEST

conditional.

> +
>  config PCIE_HISI_ERR
>         depends on ACPI_APEI_GHES && (ARM64 || COMPILE_TEST)
>         bool "HiSilicon HIP PCIe controller error handling driver"

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
