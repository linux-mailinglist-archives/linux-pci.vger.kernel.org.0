Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32996466932
	for <lists+linux-pci@lfdr.de>; Thu,  2 Dec 2021 18:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231687AbhLBRfe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Dec 2021 12:35:34 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:57190 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346939AbhLBRfd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Dec 2021 12:35:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E8A262769;
        Thu,  2 Dec 2021 17:32:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73356C53FCC;
        Thu,  2 Dec 2021 17:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638466330;
        bh=G63/CPc0sGhJ6RNRjiHaXeZkOjec5feUCh0XtnNnEoo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VT+dhSIh4z36LzrFe17GmUlUweI6uGQrxyWIge6QsGFpackPpsxpo5r75fh0W+7C3
         xDY2HF90AegX5JVsupl6+3rzOT63HkP5llKqe+CD87oYFtJgSPgU6FaytpI1UF1sa6
         p/IDCuGDjQdo+Ec4J9g9fxJghB1Og7POW2UZqrSMy+PmiW5EGXTr1EnqTSkbPhidVH
         Fe0en6yr27cfvvapwN2f4kfHW+OFkSek7xJOmFwfR77033jTTSkgKY0IY7/B18limU
         NK/09U2VGF8nCIaWvswgI8HjY+BIHdK6oQhLYZVc9vN/UdXSsV6PezxInGBAxz3Yv8
         u3gBONwqkKFrw==
Received: by mail-ed1-f46.google.com with SMTP id y12so824273eda.12;
        Thu, 02 Dec 2021 09:32:10 -0800 (PST)
X-Gm-Message-State: AOAM5313IuCsI0cec5rfPRPKElnMox5cSOaa90K+14D6g5x1/3TCksRt
        uYjeNMceZjkEJJss3LQhzLUvg2ZmTTECgIDAMw==
X-Google-Smtp-Source: ABdhPJx257xFB6ufTtKdNAR1SAXyTZ0H4BZYcKhETITqQRHTuZc1I72oQHZuGGmtqyZM4MBdRLQPjsmKp2bW66syJNU=
X-Received: by 2002:a17:907:a411:: with SMTP id sg17mr16695457ejc.84.1638466327633;
 Thu, 02 Dec 2021 09:32:07 -0800 (PST)
MIME-Version: 1.0
References: <20201005215817.GA3063223@bjorn-Precision-5520> <20211202110624.143028-1-ffclaire1224@gmail.com>
In-Reply-To: <20211202110624.143028-1-ffclaire1224@gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 2 Dec 2021 11:31:55 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKNY1MKXcwKOn544Y94LSYiKLcLOhuRu2WFCw1XJh5HFg@mail.gmail.com>
Message-ID: <CAL_JsqKNY1MKXcwKOn544Y94LSYiKLcLOhuRu2WFCw1XJh5HFg@mail.gmail.com>
Subject: Re: [PATCH] PCI: Improve compile-test coverage
To:     Fan Fei <ffclaire1224@gmail.com>
Cc:     helgaas@kernel.org, bjorn@helgaas.com, bhelgaas@google.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        lorenzo.pieralisi@arm.com, pratyush.anand@gmail.com,
        thomas.petazzoni@bootlin.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 2, 2021 at 5:06 AM Fan Fei <ffclaire1224@gmail.com> wrote:
>
> Remove the "depends on OF" in Kconfig of PCI controllers. These drivers
> depends on CONFIG_OF because they use interface in of.h file, e.g.
> "of_match_ptr()". But these interface are defined as stub if CONFIG_OF is
> not set. Thus we can compile them without CONFIG_OF, instead just with
> COMPILE_TEST.
>
> Signed-off-by: Fan Fei <ffclaire1224@gmail.com>
> ---
> Hi, Bjorn,
>
> I just did as what you suggested, remove the "depends on OF" in Konfig, and
> compile it. It seems to work well. On the thread
> https://lore.kernel.org/all/20201005215817.GA3063223@bjorn-Precision-5520/
> mentioned by the task excel, there are some replacement of "of_match_ptr()",
> but this function seems to be defined even CONFIG_OF is not set. Is it
> correct to reply in this thread or shall I send it to mail list directly?
>
> Kind regards
> Fan
>
>  drivers/pci/controller/Kconfig | 24 ++++++------------------
>  1 file changed, 6 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
> index 93b141110537..6e988420f900 100644
> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@ -8,13 +8,11 @@ config PCI_MVEBU
>         depends on ARCH_MVEBU || ARCH_DOVE || COMPILE_TEST
>         depends on MVEBU_MBUS
>         depends on ARM
> -       depends on OF
>         select PCI_BRIDGE_EMUL
>
>  config PCI_AARDVARK
>         tristate "Aardvark PCIe controller"
>         depends on (ARCH_MVEBU && ARM64) || COMPILE_TEST
> -       depends on OF
>         depends on PCI_MSI_IRQ_DOMAIN
>         select PCI_BRIDGE_EMUL
>         help
> @@ -34,12 +32,11 @@ config PCIE_XILINX_NWL
>
>  config PCI_FTPCI100
>         bool "Faraday Technology FTPCI100 PCI controller"
> -       depends on OF
>         default ARCH_GEMINI
>
>  config PCI_IXP4XX
>         bool "Intel IXP4xx PCI controller"
> -       depends on ARM && OF
> +       depends on ARM
>         depends on ARCH_IXP4XX || COMPILE_TEST
>         default ARCH_IXP4XX
>         help
> @@ -85,7 +82,6 @@ config PCI_HOST_COMMON
>
>  config PCI_HOST_GENERIC
>         tristate "Generic PCI host controller"
> -       depends on OF
>         select PCI_HOST_COMMON
>         select IRQ_DOMAIN
>         help
> @@ -94,7 +90,7 @@ config PCI_HOST_GENERIC
>
>  config PCIE_XILINX
>         bool "Xilinx AXI PCIe host bridge support"
> -       depends on OF || COMPILE_TEST
> +       depends on COMPILE_TEST
>         depends on PCI_MSI_IRQ_DOMAIN
>         help
>           Say 'Y' here if you want kernel to support the Xilinx AXI PCIe
> @@ -111,7 +107,7 @@ config PCIE_XILINX_CPM
>  config PCI_XGENE
>         bool "X-Gene PCIe controller"
>         depends on ARM64 || COMPILE_TEST
> -       depends on OF || (ACPI && PCI_QUIRKS)
> +       depends on ACPI && PCI_QUIRKS

This is wrong because now it will only build if ACPI && PCI_QUIRKS.
Maybe that condition can be dropped too.

>         help
>           Say Y here if you want internal PCI support on APM X-Gene SoC.
>           There are 5 internal PCIe ports available. Each port is GEN3 capable
> @@ -128,7 +124,6 @@ config PCI_XGENE_MSI
>
>  config PCI_V3_SEMI
>         bool "V3 Semiconductor PCI controller"
> -       depends on OF
>         depends on ARM || COMPILE_TEST
>         default ARCH_INTEGRATOR_AP
>
> @@ -146,7 +141,6 @@ config PCIE_IPROC
>  config PCIE_IPROC_PLATFORM
>         tristate "Broadcom iProc PCIe platform bus driver"
>         depends on ARCH_BCM_IPROC || (ARM && COMPILE_TEST)
> -       depends on OF
>         select PCIE_IPROC
>         default ARCH_BCM_IPROC
>         help
> @@ -190,7 +184,7 @@ config PCIE_ALTERA_MSI
>  config PCI_HOST_THUNDER_PEM
>         bool "Cavium Thunder PCIe controller to off-chip devices"
>         depends on ARM64 || COMPILE_TEST
> -       depends on OF || (ACPI && PCI_QUIRKS)
> +       depends on ACPI && PCI_QUIRKS

Same here

>         select PCI_HOST_COMMON
>         help
>           Say Y here if you want PCIe support for CN88XX Cavium Thunder SoCs.
> @@ -198,7 +192,7 @@ config PCI_HOST_THUNDER_PEM
>  config PCI_HOST_THUNDER_ECAM
>         bool "Cavium Thunder ECAM controller to on-chip devices on pass-1.x silicon"
>         depends on ARM64 || COMPILE_TEST
> -       depends on OF || (ACPI && PCI_QUIRKS)
> +       depends on ACPI && PCI_QUIRKS

And here.

>         select PCI_HOST_COMMON
>         help
>           Say Y here if you want ECAM support for CN88XX-Pass-1.x Cavium Thunder SoCs.
> @@ -210,7 +204,6 @@ config PCIE_ROCKCHIP
>  config PCIE_ROCKCHIP_HOST
>         tristate "Rockchip PCIe host controller"
>         depends on ARCH_ROCKCHIP || COMPILE_TEST
> -       depends on OF
>         depends on PCI_MSI_IRQ_DOMAIN
>         select MFD_SYSCON
>         select PCIE_ROCKCHIP
> @@ -222,7 +215,6 @@ config PCIE_ROCKCHIP_HOST
>  config PCIE_ROCKCHIP_EP
>         bool "Rockchip PCIe endpoint controller"
>         depends on ARCH_ROCKCHIP || COMPILE_TEST
> -       depends on OF
>         depends on PCI_ENDPOINT
>         select MFD_SYSCON
>         select PCIE_ROCKCHIP
> @@ -234,7 +226,6 @@ config PCIE_ROCKCHIP_EP
>  config PCIE_MEDIATEK
>         tristate "MediaTek PCIe controller"
>         depends on ARCH_MEDIATEK || COMPILE_TEST
> -       depends on OF
>         depends on PCI_MSI_IRQ_DOMAIN
>         help
>           Say Y here if you want to enable PCIe controller support on
> @@ -272,7 +263,6 @@ config PCIE_BRCMSTB
>         tristate "Broadcom Brcmstb PCIe host controller"
>         depends on ARCH_BRCMSTB || ARCH_BCM2835 || ARCH_BCM4908 || \
>                    BMIPS_GENERIC || COMPILE_TEST
> -       depends on OF
>         depends on PCI_MSI_IRQ_DOMAIN
>         default ARCH_BRCMSTB
>         help
> @@ -289,7 +279,6 @@ config PCI_HYPERV_INTERFACE
>  config PCI_LOONGSON
>         bool "LOONGSON PCI Controller"
>         depends on MACH_LOONGSON64 || COMPILE_TEST
> -       depends on OF
>         depends on PCI_QUIRKS
>         default MACH_LOONGSON64
>         help
> @@ -298,7 +287,7 @@ config PCI_LOONGSON
>
>  config PCIE_MICROCHIP_HOST
>         bool "Microchip AXI PCIe host bridge support"
> -       depends on PCI_MSI && OF
> +       depends on PCI_MSI
>         select PCI_MSI_IRQ_DOMAIN
>         select GENERIC_MSI_IRQ_DOMAIN
>         select PCI_HOST_COMMON
> @@ -321,7 +310,6 @@ config PCIE_APPLE_MSI_DOORBELL_ADDR
>  config PCIE_APPLE
>         tristate "Apple PCIe controller"
>         depends on ARCH_APPLE || COMPILE_TEST
> -       depends on OF
>         depends on PCI_MSI_IRQ_DOMAIN
>         select PCI_HOST_COMMON
>         help
> --
> 2.25.1
>
