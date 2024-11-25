Return-Path: <linux-pci+bounces-17287-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE3A9D8C4B
	for <lists+linux-pci@lfdr.de>; Mon, 25 Nov 2024 19:36:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C73B9B25B55
	for <lists+linux-pci@lfdr.de>; Mon, 25 Nov 2024 18:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D03B91BC07A;
	Mon, 25 Nov 2024 18:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="rSsqpz2J"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49231B87F9;
	Mon, 25 Nov 2024 18:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732559738; cv=none; b=OAsjYON+nC2//Y2GDBnPaho4x9zSpDQlHgAszojoxlV8pA8mbrswmqgW93KZJQuUDAl7z4TOh1wQp9+VeLevzcO0n7X9O1kEwY15PP+DPdHbP9/P5CXe4HwgS+WZ8MT268FAn8A0nZnUBbtzIN1oCOTHG8M/VoShHMS1O+IwiFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732559738; c=relaxed/simple;
	bh=IO4MM9F6qKWUTUGT31wdBvKAMcB3NLANy9LBwA5x+/I=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qLSu1rVrAX8J+v8uUw0FABYl5vKusn4U75F2VRKpJOwfxJvUXUrjPo9FGONM6YsE9ZnSgj5F6Ct2Uy/cgF+8gsswa0gTPcFZ93soEgKJVQ3Uexy0YNEaWZQbt899SQDBoITujkS4m5mlnjsLmssCl6ei49yXzSXqVCgQkSF+IlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=rSsqpz2J; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1732559704; x=1733164504; i=wahrenst@gmx.net;
	bh=tpZ4b/TFez/yI764ON0kNUS4oIsmYfO9+VfHcFCyYus=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=rSsqpz2J+JyVQkcZ9OVDGDg3g40bIq6NP7FGH2WfH10VhyeGmku+ib4BlEtSLyR1
	 22xvvPnBDZn6Va4C4g5w9pnaQ//NhWOzEgl3JjDsec2SL7layvInQgORSc9u5aOlj
	 EHzni0/jSBo6wmzWLjnZyw7zEAtM/fLbA+nz1UmozNQTH5l90rQw1lwEyRvH3avuc
	 fafK7AuXTDBfAlfWbFR/nt/3oyx+EIvEzttOwyEfJmxymJoL+PvGoBT7diW6nVysP
	 j+f7REhcRjhobkRivMCh7go1tnZnLo5rmOPyxyr8a2aGUZYUskcAyT+VuNL1ZCbB3
	 iXXf6p7pFVH7LGewhQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.105] ([37.4.251.153]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1My32F-1tdO4O38mt-00y7DL; Mon, 25
 Nov 2024 19:35:04 +0100
Message-ID: <c5575991-eab1-40ef-a984-b23076b09cf3@gmx.net>
Date: Mon, 25 Nov 2024 19:35:01 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/10] misc: rp1: RaspberryPi RP1 misc driver
To: Andrea della Porta <andrea.porta@suse.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Krzysztof Wilczynski <kw@linux.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Linus Walleij
 <linus.walleij@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
 Derek Kiernan <derek.kiernan@amd.com>, Dragan Cvetic
 <dragan.cvetic@amd.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Saravana Kannan <saravanak@google.com>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org,
 Masahiro Yamada <masahiroy@kernel.org>,
 Herve Codina <herve.codina@bootlin.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Andrew Lunn <andrew@lunn.ch>
References: <cover.1732444746.git.andrea.porta@suse.com>
 <c48e6b9b178cdaa01b92ae82e8fd24c2ba5f170c.1732444746.git.andrea.porta@suse.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <c48e6b9b178cdaa01b92ae82e8fd24c2ba5f170c.1732444746.git.andrea.porta@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:ln/h6s/CGlAD0ehdrJ6Oki5LJ2tHts1Wy6PTJYLK0sPoMRtO1Q6
 rZHnNo2OAfNShlaRYDZPeeQ95ah7GnRuS1t8J3VNogLtNK+gdltiRdwOJI79FHsv9E4yZSe
 yJf8M7yBi7NJCw21HO+lEEaSolyQoa0YSenjji1EIFuBCU57tQHyF9eoCR/3ls0k1C0Z6dk
 /QSliTBZ4CqSQF2ALCCvQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:JVxwtyaNaA0=;WNEv7x90XjsQSV4RMiJld96G/Ed
 fBSYHaRPFuQXQ9E/f93mNPrE0/8Cbr25U/dQEFiveEqqSPT5BYfWK32k00mzLWwuSyRF0V5PG
 4Nt8S/cT9ZdFtdB+Rk2CbEzpJO1/BjvimAFdyfwW6HHbvMupOmjxB2wto4LaEMV1ZdQxxxd6a
 RnR7ZZ3gNlNXrvfnitfPHqQec1CGSYlIKHmFI4BX5SvuQFXJy5JFyz+/Ga1YrSWGJmOVjyMNE
 Rjbf7dVqyuowdeybtZYMgyiZmt/NVyKbMKHoK8BoBHY/uYzXXWkyyTzNys+p2RbK+OFHKk6LF
 w0VzMh69+KXEEAp0PuNV26KDEs8CAQEMsZmuCEI0csdBLqw6mKw+Yf1B7A6aZOkAkJIoW/dzK
 J44ScrbBoBW6RIi0nmLrxkI1iNJFN3KqF4ZCEhLGs4tTD9ETiaofCMzYUPeavrMGoTYG4iwKa
 1cE/jd46Rtovn2hvs1MzUsLYNzX4cf1j21PJpWUCNFqIfBPZBMxYiw2KGEitKS5uovR3+WS3E
 cZaxtYEvBuJVndOgFs0PXEbCjAcWBpB9hR2vlNl3MPJCWVWyxgCsNmW77zy3T8tcPrZ2O1e9k
 8wRJig3u0LCx6LnkcfYIQMfB5RCOw7tPg6VuGG6MDaLBAfXKdVS8+fA9kKdC+HKbIOxmrnPG8
 R4DX/HCuSEqcGAyhZ06es2HUKWqPRZYYIYgz+rto/75nmcCdl30zE0ludEoxJNB6xTMviXPtg
 JnNteOfTBAk5x8QdXzKTduEixxyUy0KoVvvYwe0N4qFgXIuFBku6wjPSdZWfJ2iQFfy9DVW3e
 Pjpu5aQODaQF+ekZnEBL8d8T/pTxz1G01swlfuoxFh/4fNb2OWJPhvKYi/sOVd6qM2KklU/BG
 tukWug6Tyb11wZSwjUfLt5+5kSpgwM/vWbGRRF32D/3hhfgHmtMcwItGp6OVn+7vPZG/rvipA
 K9/7RAff3prLSWCagtI2fRxesDAmHhmjTk5V9yMTvbSyVYlO8MSjfeQK45Xrz00F30A+FPaXp
 wsXhg4/mtOdkm8HPWhm8tOifHLIC0YcLZTBMk0+jOgEG5BjulYQ/IO34EoXlhYaz/vPtyEiNj
 JLQi8x82NrCARHVWVwqc+90YTUGAG7

Hi Andrea,

Am 24.11.24 um 11:51 schrieb Andrea della Porta:
> The RaspberryPi RP1 is a PCI multi function device containing
> peripherals ranging from Ethernet to USB controller, I2C, SPI
> and others.
>
> Implement a bare minimum driver to operate the RP1, leveraging
> actual OF based driver implementations for the on-board peripherals
> by loading a devicetree overlay during driver probe.
>
> The peripherals are accessed by mapping MMIO registers starting
> from PCI BAR1 region.
>
> With the overlay approach we can achieve more generic and agnostic
> approach to managing this chipset, being that it is a PCI endpoint
> and could possibly be reused in other hw implementations. The
> presented approach is also used by Bootlin's Microchip LAN966x
> patchset (see link) as well, for a similar chipset.
>
> Since the gpio line names should be provided by the user, there
> is an interface through configfs that allows the userspace to
> load a DT overlay that will provide gpio-line-names property.
> The interface can be invoked like this:
>
> cat rpi-rp1-gpios-5-b.dtbo > /sys/kernel/config/rp1-cfg/gpio_set_names
>
> and is designed to be similar to what users are already used to
> from distro with downstream kernel.
>
> For reasons why this driver is contained in drivers/misc, please
> check the links.
>
> This driver is heavily based on downstream code from RaspberryPi
> Foundation, and the original author is Phil Elwell.
>
> Link: https://datasheets.raspberrypi.com/rp1/rp1-peripherals.pdf
> Link: https://lore.kernel.org/all/20240612140208.GC1504919@google.com/
> Link: https://lore.kernel.org/all/83f7fa09-d0e6-4f36-a27d-cee08979be2a@app.fastmail.com/
> Link: https://lore.kernel.org/all/2024081356-mutable-everyday-6f9d@gregkh/
> Link: https://lore.kernel.org/all/20240808154658.247873-1-herve.codina@bootlin.com/
>
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> ---
>   MAINTAINERS                   |   1 +
>   drivers/misc/Kconfig          |   1 +
>   drivers/misc/Makefile         |   1 +
>   drivers/misc/rp1/Kconfig      |  21 ++
>   drivers/misc/rp1/Makefile     |   3 +
>   drivers/misc/rp1/rp1-pci.dtso |   8 +
>   drivers/misc/rp1/rp1_pci.c    | 366 ++++++++++++++++++++++++++++++++++
>   drivers/misc/rp1/rp1_pci.h    |  14 ++
>   drivers/pci/quirks.c          |   1 +
>   include/linux/pci_ids.h       |   3 +
>   10 files changed, 419 insertions(+)
>   create mode 100644 drivers/misc/rp1/Kconfig
>   create mode 100644 drivers/misc/rp1/Makefile
>   create mode 100644 drivers/misc/rp1/rp1-pci.dtso
>   create mode 100644 drivers/misc/rp1/rp1_pci.c
>   create mode 100644 drivers/misc/rp1/rp1_pci.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 510a071ede78..032678fb2470 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19389,6 +19389,7 @@ F:	Documentation/devicetree/bindings/misc/pci1de4,1.yaml
>   F:	Documentation/devicetree/bindings/pci/pci-ep-bus.yaml
>   F:	Documentation/devicetree/bindings/pinctrl/raspberrypi,rp1-gpio.yaml
>   F:	drivers/clk/clk-rp1.c
> +F:	drivers/misc/rp1/
>   F:	drivers/pinctrl/pinctrl-rp1.c
>   F:	include/dt-bindings/clock/rp1.h
>   F:	include/dt-bindings/misc/rp1.h
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index 3fe7e2a9bd29..ac85cb154100 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -628,4 +628,5 @@ source "drivers/misc/uacce/Kconfig"
>   source "drivers/misc/pvpanic/Kconfig"
>   source "drivers/misc/mchp_pci1xxxx/Kconfig"
>   source "drivers/misc/keba/Kconfig"
> +source "drivers/misc/rp1/Kconfig"
>   endmenu
> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> index a9f94525e181..ae86d69997b4 100644
> --- a/drivers/misc/Makefile
> +++ b/drivers/misc/Makefile
> @@ -72,3 +72,4 @@ obj-$(CONFIG_TPS6594_PFSM)	+= tps6594-pfsm.o
>   obj-$(CONFIG_NSM)		+= nsm.o
>   obj-$(CONFIG_MARVELL_CN10K_DPI)	+= mrvl_cn10k_dpi.o
>   obj-y				+= keba/
> +obj-$(CONFIG_MISC_RP1)		+= rp1/
> diff --git a/drivers/misc/rp1/Kconfig b/drivers/misc/rp1/Kconfig
> new file mode 100644
> index 000000000000..39c4aa4bf634
> --- /dev/null
> +++ b/drivers/misc/rp1/Kconfig
> @@ -0,0 +1,21 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# RaspberryPi RP1 misc device
> +#
> +
> +config MISC_RP1
> +        tristate "RaspberryPi RP1 PCIe support"
> +        depends on OF_IRQ && PCI_MSI && PCI_QUIRKS
> +        select OF_OVERLAY
> +        select PCI_DYNAMIC_OF_NODES
> +        help
> +          Support the RP1 peripheral chip found on Raspberry Pi 5 board.
> +
> +          This device supports several sub-devices including e.g. Ethernet
> +	  controller, USB controller, I2C, SPI and UART.
> +
> +          The driver is responsible for enabling the DT node once the PCIe
> +	  endpoint has been configured, and handling interrupts.
> +
> +          This driver uses an overlay to load other drivers to support for
> +	  RP1 internal sub-devices.
Please fix up the leading whitespace here
> diff --git a/drivers/misc/rp1/Makefile b/drivers/misc/rp1/Makefile
> new file mode 100644
> index 000000000000..508b4cb05627
> --- /dev/null
> +++ b/drivers/misc/rp1/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +obj-$(CONFIG_MISC_RP1)		+= rp1-pci.o
> +rp1-pci-objs			:= rp1_pci.o rp1-pci.dtbo.o
> diff --git a/drivers/misc/rp1/rp1-pci.dtso b/drivers/misc/rp1/rp1-pci.dtso
> new file mode 100644
> index 000000000000..0bf2f4bb18e6
> --- /dev/null
> +++ b/drivers/misc/rp1/rp1-pci.dtso
> @@ -0,0 +1,8 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +
> +/* the dts overlay is included from the dts directory so
> + * it can be possible to check it with CHECK_DTBS while
> + * also compile it from the driver source directory.
> + */
> +
> +#include "arm64/broadcom/rp1.dtso"
> diff --git a/drivers/misc/rp1/rp1_pci.c b/drivers/misc/rp1/rp1_pci.c
> new file mode 100644
> index 000000000000..440909a070ed
> --- /dev/null
> +++ b/drivers/misc/rp1/rp1_pci.c
> @@ -0,0 +1,366 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2018-24 Raspberry Pi Ltd.
> + * All rights reserved.
> + */
> +
> +#include <linux/err.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/irqchip/chained_irq.h>
> +#include <linux/irqdomain.h>
> +#include <linux/module.h>
> +#include <linux/msi.h>
> +#include <linux/of_platform.h>
> +#include <linux/pci.h>
> +#include <linux/platform_device.h>
> +
> +#include "rp1_pci.h"
> +
> +#define RP1_DRIVER_NAME		"rp1"
> +
> +#define RP1_HW_IRQ_MASK		GENMASK(5, 0)
> +
> +#define REG_SET			0x800
> +#define REG_CLR			0xc00
> +
> +/* MSI-X CFG registers start at 0x8 */
> +#define MSIX_CFG(x) (0x8 + (4 * (x)))
> +
> +#define MSIX_CFG_IACK_EN        BIT(3)
> +#define MSIX_CFG_IACK           BIT(2)
> +#define MSIX_CFG_ENABLE         BIT(0)
> +
> +/* Address map */
> +#define RP1_PCIE_APBS_BASE	0x108000
> +
> +/* Interrupts */
> +#define RP1_INT_IO_BANK0	0
> +#define RP1_INT_IO_BANK1	1
> +#define RP1_INT_IO_BANK2	2
> +#define RP1_INT_AUDIO_IN	3
> +#define RP1_INT_AUDIO_OUT	4
> +#define RP1_INT_PWM0		5
> +#define RP1_INT_ETH		6
> +#define RP1_INT_I2C0		7
> +#define RP1_INT_I2C1		8
> +#define RP1_INT_I2C2		9
> +#define RP1_INT_I2C3		10
> +#define RP1_INT_I2C4		11
> +#define RP1_INT_I2C5		12
> +#define RP1_INT_I2C6		13
> +#define RP1_INT_I2S0		14
> +#define RP1_INT_I2S1		15
> +#define RP1_INT_I2S2		16
> +#define RP1_INT_SDIO0		17
> +#define RP1_INT_SDIO1		18
> +#define RP1_INT_SPI0		19
> +#define RP1_INT_SPI1		20
> +#define RP1_INT_SPI2		21
> +#define RP1_INT_SPI3		22
> +#define RP1_INT_SPI4		23
> +#define RP1_INT_SPI5		24
> +#define RP1_INT_UART0		25
> +#define RP1_INT_TIMER_0		26
> +#define RP1_INT_TIMER_1		27
> +#define RP1_INT_TIMER_2		28
> +#define RP1_INT_TIMER_3		29
> +#define RP1_INT_USBHOST0	30
> +#define RP1_INT_USBHOST0_0	31
> +#define RP1_INT_USBHOST0_1	32
> +#define RP1_INT_USBHOST0_2	33
> +#define RP1_INT_USBHOST0_3	34
> +#define RP1_INT_USBHOST1	35
> +#define RP1_INT_USBHOST1_0	36
> +#define RP1_INT_USBHOST1_1	37
> +#define RP1_INT_USBHOST1_2	38
> +#define RP1_INT_USBHOST1_3	39
> +#define RP1_INT_DMA		40
> +#define RP1_INT_PWM1		41
> +#define RP1_INT_UART1		42
> +#define RP1_INT_UART2		43
> +#define RP1_INT_UART3		44
> +#define RP1_INT_UART4		45
> +#define RP1_INT_UART5		46
> +#define RP1_INT_MIPI0		47
> +#define RP1_INT_MIPI1		48
> +#define RP1_INT_VIDEO_OUT	49
> +#define RP1_INT_PIO_0		50
> +#define RP1_INT_PIO_1		51
> +#define RP1_INT_ADC_FIFO	52
> +#define RP1_INT_PCIE_OUT	53
> +#define RP1_INT_SPI6		54
> +#define RP1_INT_SPI7		55
> +#define RP1_INT_SPI8		56
> +#define RP1_INT_SYSCFG		58
> +#define RP1_INT_CLOCKS_DEFAULT	59
> +#define RP1_INT_VBUSCTRL	60
> +#define RP1_INT_PROC_MISC	57
> +#define RP1_INT_END		61
> +
> +struct rp1_dev {
> +	struct pci_dev *pdev;
> +	struct irq_domain *domain;
> +	struct irq_data *pcie_irqds[64];
> +	void __iomem *bar1;
> +	int ovcs_id;
/* overlay changeset id */
> +	bool level_triggered_irq[RP1_INT_END];
> +};
> +
> +static void msix_cfg_set(struct rp1_dev *rp1, unsigned int hwirq, u32 value)
> +{
> +	iowrite32(value, rp1->bar1 + RP1_PCIE_APBS_BASE + REG_SET + MSIX_CFG(hwirq));
> +}
> +
> +static void msix_cfg_clr(struct rp1_dev *rp1, unsigned int hwirq, u32 value)
> +{
> +	iowrite32(value, rp1->bar1 + RP1_PCIE_APBS_BASE + REG_CLR + MSIX_CFG(hwirq));
> +}
> +
> +static void rp1_mask_irq(struct irq_data *irqd)
> +{
> +	struct rp1_dev *rp1 = irqd->domain->host_data;
> +	struct irq_data *pcie_irqd = rp1->pcie_irqds[irqd->hwirq];
> +
> +	pci_msi_mask_irq(pcie_irqd);
> +}
> +
> +static void rp1_unmask_irq(struct irq_data *irqd)
> +{
> +	struct rp1_dev *rp1 = irqd->domain->host_data;
> +	struct irq_data *pcie_irqd = rp1->pcie_irqds[irqd->hwirq];
> +
> +	pci_msi_unmask_irq(pcie_irqd);
> +}
> +
> +static int rp1_irq_set_type(struct irq_data *irqd, unsigned int type)
> +{
> +	struct rp1_dev *rp1 = irqd->domain->host_data;
> +	unsigned int hwirq = (unsigned int)irqd->hwirq;
> +
> +	switch (type) {
> +	case IRQ_TYPE_LEVEL_HIGH:
> +		dev_dbg(&rp1->pdev->dev, "MSIX IACK EN for irq %d\n", hwirq);
> +		msix_cfg_set(rp1, hwirq, MSIX_CFG_IACK_EN);
> +		rp1->level_triggered_irq[hwirq] = true;
> +	break;
> +	case IRQ_TYPE_EDGE_RISING:
> +		msix_cfg_clr(rp1, hwirq, MSIX_CFG_IACK_EN);
> +		rp1->level_triggered_irq[hwirq] = false;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static struct irq_chip rp1_irq_chip = {
> +	.name		= "rp1_irq_chip",
> +	.irq_mask	= rp1_mask_irq,
> +	.irq_unmask	= rp1_unmask_irq,
> +	.irq_set_type	= rp1_irq_set_type,
> +};
> +
> +static void rp1_chained_handle_irq(struct irq_desc *desc)
> +{
> +	unsigned int hwirq = desc->irq_data.hwirq & RP1_HW_IRQ_MASK;
> +	struct rp1_dev *rp1 = irq_desc_get_handler_data(desc);
> +	struct irq_chip *chip = irq_desc_get_chip(desc);
> +	unsigned int virq;
> +
> +	chained_irq_enter(chip, desc);
> +
> +	virq = irq_find_mapping(rp1->domain, hwirq);
> +	generic_handle_irq(virq);
> +	if (rp1->level_triggered_irq[hwirq])
> +		msix_cfg_set(rp1, hwirq, MSIX_CFG_IACK);
> +
> +	chained_irq_exit(chip, desc);
> +}
> +
> +static int rp1_irq_xlate(struct irq_domain *d, struct device_node *node,
> +			 const u32 *intspec, unsigned int intsize,
> +			 unsigned long *out_hwirq, unsigned int *out_type)
> +{
> +	struct rp1_dev *rp1 = d->host_data;
> +	struct irq_data *pcie_irqd;
> +	unsigned long hwirq;
> +	int pcie_irq;
> +	int ret;
> +
> +	ret = irq_domain_xlate_twocell(d, node, intspec, intsize,
> +				       &hwirq, out_type);
> +	if (ret)
> +		return ret;
> +
> +	pcie_irq = pci_irq_vector(rp1->pdev, hwirq);
> +	pcie_irqd = irq_get_irq_data(pcie_irq);
> +	rp1->pcie_irqds[hwirq] = pcie_irqd;
> +	*out_hwirq = hwirq;
> +
> +	return 0;
> +}
> +
> +static int rp1_irq_activate(struct irq_domain *d, struct irq_data *irqd,
> +			    bool reserve)
> +{
> +	struct rp1_dev *rp1 = d->host_data;
> +
> +	msix_cfg_set(rp1, (unsigned int)irqd->hwirq, MSIX_CFG_ENABLE);
> +
> +	return 0;
> +}
> +
> +static void rp1_irq_deactivate(struct irq_domain *d, struct irq_data *irqd)
> +{
> +	struct rp1_dev *rp1 = d->host_data;
> +
> +	msix_cfg_clr(rp1, (unsigned int)irqd->hwirq, MSIX_CFG_ENABLE);
> +}
> +
> +static const struct irq_domain_ops rp1_domain_ops = {
> +	.xlate      = rp1_irq_xlate,
> +	.activate   = rp1_irq_activate,
> +	.deactivate = rp1_irq_deactivate,
> +};
> +
> +static void rp1_unregister_interrupts(struct pci_dev *pdev)
> +{
> +	struct rp1_dev *rp1 = pci_get_drvdata(pdev);
> +	int irq, i;
> +
> +	if (rp1->domain) {
> +		for (i = 0; i < RP1_INT_END; i++) {
> +			irq = irq_find_mapping(rp1->domain, i);
> +			irq_dispose_mapping(irq);
> +		}
> +
> +		irq_domain_remove(rp1->domain);
> +	}
> +
> +	pci_free_irq_vectors(pdev);
> +}
> +
> +static int rp1_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> +{
> +	u32 dtbo_size = __dtbo_rp1_pci_end - __dtbo_rp1_pci_begin;
> +	void *dtbo_start = __dtbo_rp1_pci_begin;
> +	struct device *dev = &pdev->dev;
> +	struct device_node *rp1_node;
> +	struct rp1_dev *rp1;
> +	int err  = 0;
Please remove the extra space after err
> +	int i;
> +
> +	rp1_node = dev_of_node(dev);
> +	if (!rp1_node) {
> +		dev_err(dev, "Missing of_node for device\n");
> +		return -EINVAL;
> +	}
> +
> +	rp1 = devm_kzalloc(&pdev->dev, sizeof(*rp1), GFP_KERNEL);
> +	if (!rp1)
> +		return -ENOMEM;
> +
> +	rp1->pdev = pdev;
> +
> +	if (pci_resource_len(pdev, 1) <= 0x10000) {
> +		dev_err(&pdev->dev,
> +			"Not initialised - is the firmware running?\n");
> +		return -EINVAL;
> +	}
> +
> +	err = pcim_enable_device(pdev);
> +	if (err < 0)
> +		return dev_err_probe(&pdev->dev, err,
> +				     "Enabling PCI device has failed");
> +
> +	rp1->bar1 = pcim_iomap(pdev, 1, 0);
> +	if (!rp1->bar1) {
> +		dev_err(&pdev->dev, "Cannot map PCI BAR\n");
> +		return -EIO;
> +	}
> +
> +	pci_set_master(pdev);
> +
> +	err = pci_alloc_irq_vectors(pdev, RP1_INT_END, RP1_INT_END,
> +				    PCI_IRQ_MSIX);
> +	if (err < 0)
> +		return dev_err_probe(&pdev->dev, err,
> +				     "pci_alloc_irq_vectors failed");
> +	else if (err != RP1_INT_END) {
Please add braces for the if case
> +		dev_err(&pdev->dev, "Cannot allocate enough interrupts\n");
> +		return -EINVAL;
> +	}
> +
>

