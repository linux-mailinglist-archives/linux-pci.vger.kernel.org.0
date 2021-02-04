Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48DFC30F077
	for <lists+linux-pci@lfdr.de>; Thu,  4 Feb 2021 11:25:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235336AbhBDKVq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Feb 2021 05:21:46 -0500
Received: from foss.arm.com ([217.140.110.172]:55356 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235317AbhBDKVo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 4 Feb 2021 05:21:44 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 080B711D4;
        Thu,  4 Feb 2021 02:20:59 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E063A3F719;
        Thu,  4 Feb 2021 02:20:57 -0800 (PST)
Date:   Thu, 4 Feb 2021 10:20:53 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Daire.McNamara@microchip.com
Cc:     bhelgaas@google.com, robh@kernel.org, linux-pci@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        david.abdurachmanov@gmail.com, Cyril.Jean@microchip.com
Subject: Re: [PATCH v21 3/4] PCI: microchip: Add host driver for Microchip
 PCIe controller
Message-ID: <20210204102052.GA28134@e121166-lin.cambridge.arm.com>
References: <20210125162934.5335-1-daire.mcnamara@microchip.com>
 <20210125162934.5335-4-daire.mcnamara@microchip.com>
 <20210201190541.GA5894@e121166-lin.cambridge.arm.com>
 <MN2PR11MB42691AE1B54DEAB5C1BAA11D96B59@MN2PR11MB4269.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <MN2PR11MB42691AE1B54DEAB5C1BAA11D96B59@MN2PR11MB4269.namprd11.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 02, 2021 at 09:06:31AM +0000, Daire.McNamara@microchip.com wrote:
> 
> 
> ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
> From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Sent: Monday 1 February 2021 19:05
> To: Daire McNamara - X61553 <Daire.McNamara@microchip.com>
> Cc: bhelgaas@google.com <bhelgaas@google.com>; robh@kernel.org
> <robh@kernel.org>; linux-pci@vger.kernel.org <linux-pci@vger.kernel.org>;
> robh+dt@kernel.org <robh+dt@kernel.org>; devicetree@vger.kernel.org
> <devicetree@vger.kernel.org>; david.abdurachmanov@gmail.com
> <david.abdurachmanov@gmail.com>; Cyril Jean - M31571 <Cyril.Jean@microchip.com>
> Subject: Re: [PATCH v21 3/4] PCI: microchip: Add host driver for Microchip PCIe
> controller
>  
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the
> content is safe
> 
> On Mon, Jan 25, 2021 at 04:29:33PM +0000, daire.mcnamara@microchip.com wrote:
> > From: Daire McNamara <daire.mcnamara@microchip.com>
> >
> > Add support for the Microchip PolarFire PCIe controller when
> > configured in host (Root Complex) mode.
> >
> > Signed-off-by: Daire McNamara <daire.mcnamara@microchip.com>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > ---
> >  drivers/pci/controller/Kconfig               |   10 +
> >  drivers/pci/controller/Makefile              |    1 +
> >  drivers/pci/controller/pcie-microchip-host.c | 1114 ++++++++++++++++++
> >  3 files changed, 1125 insertions(+)
> >  create mode 100644 drivers/pci/controller/pcie-microchip-host.c
> >
> > diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
> > index 64e2f5e379aa..bca2f8949510 100644
> > --- a/drivers/pci/controller/Kconfig
> > +++ b/drivers/pci/controller/Kconfig
> > @@ -298,6 +298,16 @@ config PCI_LOONGSON
> >         Say Y here if you want to enable PCI controller support on
> >         Loongson systems.
> >
> > +config PCIE_MICROCHIP_HOST
> > +     bool "Microchip AXI PCIe host bridge support"
> > +     depends on PCI_MSI && OF
> > +     select PCI_MSI_IRQ_DOMAIN
> > +     select GENERIC_MSI_IRQ_DOMAIN
> > +     select PCI_HOST_COMMON
> > +     help
> > +       Say Y here if you want kernel to support the Microchip AXI PCIe
> > +       Host Bridge driver.
> > +
> >  config PCIE_HISI_ERR
> >       depends on ACPI_APEI_GHES && (ARM64 || COMPILE_TEST)
> >       bool "HiSilicon HIP PCIe controller error handling driver"
> > diff --git a/drivers/pci/controller/Makefile b/drivers/pci/controller/
> Makefile
> > index 04c6edc285c5..b85fcd574ff6 100644
> > --- a/drivers/pci/controller/Makefile
> > +++ b/drivers/pci/controller/Makefile
> > @@ -28,6 +28,7 @@ obj-$(CONFIG_PCIE_ROCKCHIP_EP) += pcie-rockchip-ep.o
> >  obj-$(CONFIG_PCIE_ROCKCHIP_HOST) += pcie-rockchip-host.o
> >  obj-$(CONFIG_PCIE_MEDIATEK) += pcie-mediatek.o
> >  obj-$(CONFIG_PCIE_TANGO_SMP8759) += pcie-tango.o
> > +obj-$(CONFIG_PCIE_MICROCHIP_HOST) += pcie-microchip-host.o
> >  obj-$(CONFIG_VMD) += vmd.o
> >  obj-$(CONFIG_PCIE_BRCMSTB) += pcie-brcmstb.o
> >  obj-$(CONFIG_PCI_LOONGSON) += pci-loongson.o
> > diff --git a/drivers/pci/controller/pcie-microchip-host.c b/drivers/pci/
> controller/pcie-microchip-host.c
> > new file mode 100644
> > index 000000000000..0ef2beab185b
> > --- /dev/null
> > +++ b/drivers/pci/controller/pcie-microchip-host.c
> > @@ -0,0 +1,1114 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Microchip AXI PCIe Bridge host controller driver
> > + *
> > + * Copyright (c) 2018 - 2020 Microchip Corporation. All rights reserved.
> 2021 - I will update it for you if that's OK.
> 
> Yes, please, that would be great.
> 
> > + * Author: Daire McNamara <daire.mcnamara@microchip.com>
> > + *
> > + * Based on:
> > + *   pcie-rcar.c
> > + *   pcie-xilinx.c
> > + *   pcie-altera.c
> 
> Can I remove these references please ? I said that before, let me know
> please, do not respost another version.
> 
> Yes, please.  Sorry I must have missed the question before.

Replies must be quoted and you must not send HTML format on ML,
(this was rejected by the ML and all the related tools) and that's
not the first time I mentioned that.

You must NOT do it and that's the last time I am saying that.

Please read:

https://kernelnewbies.org/PatchCulture

It is your maintainer responsibility to follow the ML and act
responsibly following the email etiquette, I don't have this HW and you
are the one that from now onwards is in charge of maintaining this code
which implies reviewing patches and actively following mailing lists.

Having said that, let's proceed with upstreaming the code, keep this
in mind please.

Thanks,
Lorenzo
