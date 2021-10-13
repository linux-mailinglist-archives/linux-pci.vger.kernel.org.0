Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B437942C0EB
	for <lists+linux-pci@lfdr.de>; Wed, 13 Oct 2021 15:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234305AbhJMNHT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Oct 2021 09:07:19 -0400
Received: from foss.arm.com ([217.140.110.172]:38856 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232645AbhJMNHS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 13 Oct 2021 09:07:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1B2DD1FB;
        Wed, 13 Oct 2021 06:05:15 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 898BA3F66F;
        Wed, 13 Oct 2021 06:05:13 -0700 (PDT)
Date:   Wed, 13 Oct 2021 14:05:11 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     linux-pci@vger.kernel.org, john@phrozen.org,
        devicetree@vger.kernel.org, tsbogend@alpha.franken.de,
        bhelgaas@google.com, matthias.bgg@gmail.com,
        gregkh@linuxfoundation.org, linux-mips@vger.kernel.org,
        linux-staging@lists.linux.dev, neil@brown.name,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] PCI: mt7621: Add MediaTek MT7621 PCIe host
 controller driver
Message-ID: <20211013130511.GB11036@lpieralisi>
References: <20210922050035.18162-1-sergio.paracuellos@gmail.com>
 <20210922050035.18162-3-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210922050035.18162-3-sergio.paracuellos@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 22, 2021 at 07:00:34AM +0200, Sergio Paracuellos wrote:
> Add driver for the PCIe controller of the MT7621 SoC.
> 
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> ---
>  arch/mips/ralink/Kconfig                      |   3 +-
>  drivers/pci/controller/Kconfig                |   8 ++
>  drivers/pci/controller/Makefile               |   1 +
>  .../controller}/pci-mt7621.c                  |   0
>  drivers/staging/Kconfig                       |   2 -
>  drivers/staging/Makefile                      |   1 -
>  drivers/staging/mt7621-pci/Kconfig            |   8 --
>  drivers/staging/mt7621-pci/Makefile           |   2 -
>  drivers/staging/mt7621-pci/TODO               |   4 -
>  .../mt7621-pci/mediatek,mt7621-pci.txt        | 104 ------------------
>  10 files changed, 11 insertions(+), 122 deletions(-)
>  rename drivers/{staging/mt7621-pci => pci/controller}/pci-mt7621.c (100%)
>  delete mode 100644 drivers/staging/mt7621-pci/Kconfig
>  delete mode 100644 drivers/staging/mt7621-pci/Makefile
>  delete mode 100644 drivers/staging/mt7621-pci/TODO
>  delete mode 100644 drivers/staging/mt7621-pci/mediatek,mt7621-pci.txt
> 
> diff --git a/arch/mips/ralink/Kconfig b/arch/mips/ralink/Kconfig
> index c800bf5559b5..120adad51d6a 100644
> --- a/arch/mips/ralink/Kconfig
> +++ b/arch/mips/ralink/Kconfig
> @@ -51,7 +51,8 @@ choice
>  		select SYS_SUPPORTS_HIGHMEM
>  		select MIPS_GIC
>  		select CLKSRC_MIPS_GIC
> -		select HAVE_PCI if PCI_MT7621
> +		select HAVE_PCI
> +		select PCI_DRIVERS_GENERIC
>  		select SOC_BUS
>  endchoice
>  
> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
> index 326f7d13024f..b76404be0360 100644
> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@ -312,6 +312,14 @@ config PCIE_HISI_ERR
>  	  Say Y here if you want error handling support
>  	  for the PCIe controller's errors on HiSilicon HIP SoCs
>  
> +config PCI_MT7621
> +	tristate "MediaTek MT7621 PCI Controller"
> +	depends on (RALINK && SOC_MT7621) || (MIPS && COMPILE_TEST)

- Is there a chance we can remove the MIPS dependency from the
  COMPILE_TEST conditional ?
- I am not a big fan of "SOC_XXX" config options dependencies, actually
  there is none in pci/controller. Is there a way to remove it ?

Lorenzo

> +	select PHY_MT7621_PCI
> +	default SOC_MT7621
> +	help
> +	  This selects a driver for the MediaTek MT7621 PCI Controller.
> +
>  source "drivers/pci/controller/dwc/Kconfig"
>  source "drivers/pci/controller/mobiveil/Kconfig"
>  source "drivers/pci/controller/cadence/Kconfig"
> diff --git a/drivers/pci/controller/Makefile b/drivers/pci/controller/Makefile
> index aaf30b3dcc14..f42a566353cb 100644
> --- a/drivers/pci/controller/Makefile
> +++ b/drivers/pci/controller/Makefile
> @@ -37,6 +37,7 @@ obj-$(CONFIG_VMD) += vmd.o
>  obj-$(CONFIG_PCIE_BRCMSTB) += pcie-brcmstb.o
>  obj-$(CONFIG_PCI_LOONGSON) += pci-loongson.o
>  obj-$(CONFIG_PCIE_HISI_ERR) += pcie-hisi-error.o
> +obj-$(CONFIG_PCI_MT7621) += pci-mt7621.o
>  # pcie-hisi.o quirks are needed even without CONFIG_PCIE_DW
>  obj-y				+= dwc/
>  obj-y				+= mobiveil/
> diff --git a/drivers/staging/mt7621-pci/pci-mt7621.c b/drivers/pci/controller/pci-mt7621.c
> similarity index 100%
> rename from drivers/staging/mt7621-pci/pci-mt7621.c
> rename to drivers/pci/controller/pci-mt7621.c
> diff --git a/drivers/staging/Kconfig b/drivers/staging/Kconfig
> index e03627ad4460..59af251e7576 100644
> --- a/drivers/staging/Kconfig
> +++ b/drivers/staging/Kconfig
> @@ -86,8 +86,6 @@ source "drivers/staging/vc04_services/Kconfig"
>  
>  source "drivers/staging/pi433/Kconfig"
>  
> -source "drivers/staging/mt7621-pci/Kconfig"
> -
>  source "drivers/staging/mt7621-dma/Kconfig"
>  
>  source "drivers/staging/ralink-gdma/Kconfig"
> diff --git a/drivers/staging/Makefile b/drivers/staging/Makefile
> index c7f8d8d8dd11..76f413470bc8 100644
> --- a/drivers/staging/Makefile
> +++ b/drivers/staging/Makefile
> @@ -33,7 +33,6 @@ obj-$(CONFIG_KS7010)		+= ks7010/
>  obj-$(CONFIG_GREYBUS)		+= greybus/
>  obj-$(CONFIG_BCM2835_VCHIQ)	+= vc04_services/
>  obj-$(CONFIG_PI433)		+= pi433/
> -obj-$(CONFIG_PCI_MT7621)	+= mt7621-pci/
>  obj-$(CONFIG_SOC_MT7621)	+= mt7621-dma/
>  obj-$(CONFIG_DMA_RALINK)	+= ralink-gdma/
>  obj-$(CONFIG_SOC_MT7621)	+= mt7621-dts/
> diff --git a/drivers/staging/mt7621-pci/Kconfig b/drivers/staging/mt7621-pci/Kconfig
> deleted file mode 100644
> index ce58042f2f21..000000000000
> --- a/drivers/staging/mt7621-pci/Kconfig
> +++ /dev/null
> @@ -1,8 +0,0 @@
> -# SPDX-License-Identifier: GPL-2.0
> -config PCI_MT7621
> -	tristate "MediaTek MT7621 PCI Controller"
> -	depends on RALINK
> -	select PCI_DRIVERS_GENERIC
> -	help
> -	  This selects a driver for the MediaTek MT7621 PCI Controller.
> -
> diff --git a/drivers/staging/mt7621-pci/Makefile b/drivers/staging/mt7621-pci/Makefile
> deleted file mode 100644
> index f4e651cf7ce3..000000000000
> --- a/drivers/staging/mt7621-pci/Makefile
> +++ /dev/null
> @@ -1,2 +0,0 @@
> -# SPDX-License-Identifier: GPL-2.0
> -obj-$(CONFIG_PCI_MT7621)       += pci-mt7621.o
> diff --git a/drivers/staging/mt7621-pci/TODO b/drivers/staging/mt7621-pci/TODO
> deleted file mode 100644
> index d674a9ac85c1..000000000000
> --- a/drivers/staging/mt7621-pci/TODO
> +++ /dev/null
> @@ -1,4 +0,0 @@
> -
> -- general code review and cleanup
> -
> -Cc: NeilBrown <neil@brown.name>
> diff --git a/drivers/staging/mt7621-pci/mediatek,mt7621-pci.txt b/drivers/staging/mt7621-pci/mediatek,mt7621-pci.txt
> deleted file mode 100644
> index 327a68267309..000000000000
> --- a/drivers/staging/mt7621-pci/mediatek,mt7621-pci.txt
> +++ /dev/null
> @@ -1,104 +0,0 @@
> -MediaTek MT7621 PCIe controller
> -
> -Required properties:
> -- compatible: "mediatek,mt7621-pci"
> -- device_type: Must be "pci"
> -- reg: Base addresses and lengths of the PCIe subsys and root ports.
> -- bus-range: Range of bus numbers associated with this controller.
> -- #address-cells: Address representation for root ports (must be 3)
> -- pinctrl-names : The pin control state names.
> -- pinctrl-0: The "default" pinctrl state.
> -- #size-cells: Size representation for root ports (must be 2)
> -- ranges: Ranges for the PCI memory and I/O regions.
> -- #interrupt-cells: Must be 1
> -- interrupt-map-mask and interrupt-map: Standard PCI IRQ mapping properties.
> -  Please refer to the standard PCI bus binding document for a more detailed
> -  explanation.
> -- status: either "disabled" or "okay".
> -- resets: Must contain an entry for each entry in reset-names.
> -  See ../reset/reset.txt for details.
> -- reset-names: Must be "pcie0", "pcie1", "pcieN"... based on the number of
> -  root ports.
> -- clocks: Must contain an entry for each entry in clock-names.
> -  See ../clocks/clock-bindings.txt for details.
> -- clock-names: Must be "pcie0", "pcie1", "pcieN"... based on the number of
> -  root ports.
> -- reset-gpios: GPIO specs for the reset pins.
> -
> -In addition, the device tree node must have sub-nodes describing each PCIe port
> -interface, having the following mandatory properties:
> -
> -Required properties:
> -- reg: Only the first four bytes are used to refer to the correct bus number
> -      and device number.
> -- #address-cells: Must be 3
> -- #size-cells: Must be 2
> -- ranges: Sub-ranges distributed from the PCIe controller node. An empty
> -  property is sufficient.
> -- bus-range: Range of bus numbers associated with this port.
> -
> -Example for MT7621:
> -
> -	pcie: pcie@1e140000 {
> -		compatible = "mediatek,mt7621-pci";
> -        reg = <0x1e140000 0x100    /* host-pci bridge registers */
> -               0x1e142000 0x100    /* pcie port 0 RC control registers */
> -               0x1e143000 0x100    /* pcie port 1 RC control registers */
> -               0x1e144000 0x100>;  /* pcie port 2 RC control registers */
> -
> -		#address-cells = <3>;
> -		#size-cells = <2>;
> -
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&pcie_pins>;
> -
> -		device_type = "pci";
> -
> -		bus-range = <0 255>;
> -		ranges = <
> -			0x02000000 0 0x00000000 0x60000000 0 0x10000000 /* pci memory */
> -			0x01000000 0 0x00000000 0x1e160000 0 0x00010000 /* io space */
> -		>;
> -
> -		#interrupt-cells = <1>;
> -		interrupt-map-mask = <0xF0000 0 0 1>;
> -		interrupt-map = <0x10000 0 0 1 &gic GIC_SHARED 4 IRQ_TYPE_LEVEL_HIGH>,
> -				<0x20000 0 0 1 &gic GIC_SHARED 24 IRQ_TYPE_LEVEL_HIGH>,
> -				<0x30000 0 0 1 &gic GIC_SHARED 25 IRQ_TYPE_LEVEL_HIGH>;
> -
> -		status = "disabled";
> -
> -		resets = <&rstctrl 24 &rstctrl 25 &rstctrl 26>;
> -		reset-names = "pcie0", "pcie1", "pcie2";
> -		clocks = <&clkctrl 24 &clkctrl 25 &clkctrl 26>;
> -		clock-names = "pcie0", "pcie1", "pcie2";
> -
> -		reset-gpios = <&gpio 19 GPIO_ACTIVE_LOW>,
> -				<&gpio 8 GPIO_ACTIVE_LOW>,
> -				<&gpio 7 GPIO_ACTIVE_LOW>;
> -
> -		pcie@0,0 {
> -			reg = <0x0000 0 0 0 0>;
> -			#address-cells = <3>;
> -			#size-cells = <2>;
> -			ranges;
> -			bus-range = <0x00 0xff>;
> -		};
> -
> -		pcie@1,0 {
> -			reg = <0x0800 0 0 0 0>;
> -			#address-cells = <3>;
> -			#size-cells = <2>;
> -			ranges;
> -			bus-range = <0x00 0xff>;
> -		};
> -
> -		pcie@2,0 {
> -			reg = <0x1000 0 0 0 0>;
> -			#address-cells = <3>;
> -			#size-cells = <2>;
> -			ranges;
> -			bus-range = <0x00 0xff>;
> -		};
> -	};
> -
> -- 
> 2.25.1
> 
