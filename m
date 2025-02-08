Return-Path: <linux-pci+bounces-21022-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53EC9A2D698
	for <lists+linux-pci@lfdr.de>; Sat,  8 Feb 2025 15:22:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47C213AA3CF
	for <lists+linux-pci@lfdr.de>; Sat,  8 Feb 2025 14:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3E22475D4;
	Sat,  8 Feb 2025 14:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="VYDVl/Hl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C145320328;
	Sat,  8 Feb 2025 14:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739024538; cv=none; b=dp4PJAmqrJgRhCagr3EDlzBZgR/2EszBy4RnnmcWLYfxRobUXVncpXl0nAELd/Z3OnJddmSSFyx3vWcWQ0xZcYxq3/yH7thPE8MGNgNM6EmbHHR772rg4O/80JF3lcutsQXGFUEPAwHwsXv0nwc5I+OAe6dbh7ZPfUuQMoLVfzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739024538; c=relaxed/simple;
	bh=dPIQBXCYOkhkg2GNxxt8kmHoutww6psUCAQO5JRfB/w=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=ltZHSss6H5rzgFktJpNtM/Lp6qru5QZVg/ORRMGtrOyTDFibXI4rroqeTzgVV539XdbCeZC1F3m2vtpne6CToV0EZ1ImvMGjlH/Hk7ZYH2ZAuflL8DtqW5OSHQyYyNpFZEmepgkeNwxcmutHq3DlR6AatU2hAQPo4R1xeGar4M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=VYDVl/Hl; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1739024510; x=1739629310; i=wahrenst@gmx.net;
	bh=VLhz4PC8eKhjyhnjX5A7niLy3M/er4D6/3tVbXGzgW0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:Subject:To:
	 References:In-Reply-To:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=VYDVl/Hl7ArzrPcr72CZ6U1NpQ4LBTKMO9kqk8CqBDR/YUSx5Lpnh1uytIjle1sU
	 kSIkciwdulS+a9nPsiydRx0IglnSGAO0w/ODsNWj2HT6WPQhQKfTGPenSBK0zZRzT
	 y5y3jHTatj7ntD2ghkSrNXX8O41NlYf+Aw41RcbxlNvaDFdLcSUDclER+4hZ0F+wo
	 b/gcjqecXuT692C3hg/tvZgh7dmg1hK21aqfJXI2Ywflpc89GjHHLzTlu3a28X7BH
	 JSndptZXlFUryxMmUNDAh0vXpdzznZf+QZbBWEL/1qSx066yzrw/xGo08L5zpAUhd
	 SF9QO2DgVxrK2U1X5w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.107] ([37.4.251.153]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N3bX1-1tFaDF2eUF-00scs7; Sat, 08
 Feb 2025 15:21:50 +0100
Message-ID: <87525350-b432-40b3-927c-60cd74228ea4@gmx.net>
Date: Sat, 8 Feb 2025 15:21:48 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Stefan Wahren <wahrenst@gmx.net>
Subject: Re: [PATCH v7 08/11] misc: rp1: RaspberryPi RP1 misc driver
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
References: <cover.1738963156.git.andrea.porta@suse.com>
 <d1362766e3e966f78591129de918046a4b892c18.1738963156.git.andrea.porta@suse.com>
Content-Language: en-US
In-Reply-To: <d1362766e3e966f78591129de918046a4b892c18.1738963156.git.andrea.porta@suse.com>
Autocrypt: addr=wahrenst@gmx.net; keydata=
 xjMEZ1dOJBYJKwYBBAHaRw8BAQdA7H2MMG3q8FV7kAPko5vOAeaa4UA1I0hMgga1j5iYTTvN
 IFN0ZWZhbiBXYWhyZW4gPHdhaHJlbnN0QGdteC5uZXQ+wo8EExYIADcWIQT3FXg+ApsOhPDN
 NNFuwvLLwiAwigUCZ1dOJAUJB4TOAAIbAwQLCQgHBRUICQoLBRYCAwEAAAoJEG7C8svCIDCK
 JQ4BAP4Y9uuHAxbAhHSQf6UZ+hl5BDznsZVBJvH8cZe2dSZ6AQCNgoc1Lxw1tvPscuC1Jd1C
 TZomrGfQI47OiiJ3vGktBc44BGdXTiQSCisGAQQBl1UBBQEBB0B5M0B2E2XxySUQhU6emMYx
 f5QR/BrEK0hs3bLT6Hb9WgMBCAfCfgQYFggAJhYhBPcVeD4Cmw6E8M000W7C8svCIDCKBQJn
 V04kBQkHhM4AAhsMAAoJEG7C8svCIDCKJxoA/i+kqD5bphZEucrJHw77ujnOQbiKY2rLb0pE
 aHMQoiECAQDVbj827W1Yai/0XEABIr8Ci6a+/qZ8Vz6MZzL5GJosAA==
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QlpJXZ5w0wftE7XN/5p+K5nwYK+gSjppLAWKZdw4Jd4uqdyj2w8
 HKG0+iiiC2gap9T72yP7hV7MZqLF/PviC/5aoAch31ZEUI37txA4FdtI4DKvLEZA1VxOI8r
 V4scjHlgTA1pckBFauaqVaC7R5ELAGzQfX6whrCwXraZkeKhRnRu7ZAUYvrnd0mmKM6rabh
 S5HcWyzrdTLl34ZJpzYnA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:gDBUWfqvJek=;0GsfTe+UW+bJCGQnB+JYA6hHSrL
 exOf2evXHgYnMoXTckimNJ2qEWHz2C92t5u+MA1xF+GRAfxOam+rdr/Q8+DHL46Z7TXaIUQZK
 n5A8GvA3xHN8/VEvGGLeNvEdwFHjh8+eG0tpneCjP6wrYrZ9VQdi8EiaYCrO1J9XES1jTTA0G
 eKACO9Rye0Bf+Uc1R24hrtg5rFbZsfWr54SUv4q+we6wKvKcs7EarA4JU4NZwyFQf66gZpdsr
 qBQAyQhpYYcAfM9pyeDT1lLkLz9XgKDfl6g+VjySkr6151v3oYOoftt55X2kfxR1Me6I+ucFG
 9m/yTyeMld3LtfKKlYnRFGnHbCtzvDMcTB8FSfvaTQQwfNkM1fFR05dJGz1lQUAR5VhIND73W
 rIjkaaKKJ4xyUAidm63j78O+KLQwYFN8G11HwOdWMJFnhiEZDrmRE9IMLjnYSOg9R1L13iBIf
 tKv8hf9pduvGDftBHi5D8V26L99ajimaM50AFGob3urcZPABODIzCMEaPS7QXUsiF8Ej1DQf8
 9pw1TYxCFW1Hb07UMi/beYM1+a5nTsnD+T1M0ktJzpfTD6/SG9/biAiQhA+KiCcV6wL9EpTtl
 ATFhJOe3FoWW3UQIhnrZjgT6oeF2Bzm1h6R6ILsLejAi0K5GDO7orVw9x94JCvUFp8EeSvFh9
 22h0FsOr43iHEj/lZ+Tj2Zx2MWy4BdWJemcbBm1+yzzISo6jFasT71/k5wkBPoVrjm4SR5LxP
 wTjFiIG0cIFa9TNoRvsrsgbT5QVF+/v1mIrf5Pie1a9wYPp2JndMlIZqiAA6+cAlX0/SjLsnX
 hTM/a7BHA8dLLshCGPA7Q/DBX5seH021vv2IoU7/SJpu0dhDO1Ws2rDWOyvn7AFgUp5+YFbIj
 1aTYAiI+QA1TognioeqgAFksA74Y8DAN4UA4R7xpqR1+UdVDpwmoRDB/JBsEjGvjPYqHbD5rW
 T50epNGrMNDhkcpFse/6aX0A3S7eQZRAwnyyxKGbYBjH3k3ZxQS7mGdAqscufd5sm7G52bu8c
 3u79f4IxXDHQfDasAYPc+06JlYDDoSI3UzEUQPGL8MNTXZt24yrog31hAlS0zcwKfGRu8K+cV
 6nzdUE62hTgOTFdwR5bN1Br++DGlDONnY1ohfiJPz9+wIJoL9i9/PdhhNErDnegAHAKhP9pq3
 uERAGdDrvosh1UyXB+sI0x31lneBrM7U0KOUZqXcyfR+ed9jM8S+LEFrEH/7MPYf57EGuH9Hm
 opGPDkwleQqLMTCIjmpt9speh5M+iSV1L7Dc2HwCK/De7FbmsEviNSpQTWMsByCbaPLS2+6EX
 LpfVxCSxo9fk6iWtk9wjex6RkL0xMHU4e87uFTleWStz2IKVLTtrXp9BOTrzTCtgQ2r8diXS3
 P9aBwo3iRHU+U0znd0p9i48FVOyTY8Ucmk9qrMMjeNz6GW5FnOGctS2WNvujg+2SutYLpXqRM
 aEO73Mw==

Hi Andrea,

Am 07.02.25 um 22:31 schrieb Andrea della Porta:
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
> The reason why this driver is contained in drivers/misc has
> been paved by Bootlin's LAN966X driver, which first used the
> overlay approach to implement non discoverable peripherals behind a
> PCI bus. For RP1, the same arguments apply: it's not used as an SoC
> since the driver code is not running on-chip and is not like an MFD
> since it does not really need all the MFD infrastructure (shared regs,
> etc.). So, for this particular use, misc has been proposed and deemed
> as a good choice. For further details about that please check the links.
>
> This driver is heavily based on downstream code from RaspberryPi
> Foundation, and the original author is Phil Elwell.
>
> Link:https://datasheets.raspberrypi.com/rp1/rp1-peripherals.pdf
> Link:https://lore.kernel.org/all/20240612140208.GC1504919@google.com/
> Link:https://lore.kernel.org/all/83f7fa09-d0e6-4f36-a27d-cee08979be2a@ap=
p.fastmail.com/
> Link:https://lore.kernel.org/all/2024081356-mutable-everyday-6f9d@gregkh=
/
> Link:https://lore.kernel.org/all/20240808154658.247873-1-herve.codina@bo=
otlin.com/
>
> Signed-off-by: Andrea della Porta<andrea.porta@suse.com>
> ---
>   MAINTAINERS                   |   1 +
>   drivers/misc/Kconfig          |   1 +
>   drivers/misc/Makefile         |   1 +
>   drivers/misc/rp1/Kconfig      |  20 +++
>   drivers/misc/rp1/Makefile     |   3 +
>   drivers/misc/rp1/rp1-pci.dtso |   8 +
>   drivers/misc/rp1/rp1_pci.c    | 305 ++++++++++++++++++++++++++++++++++
>   drivers/pci/quirks.c          |   1 +
>   include/linux/pci_ids.h       |   3 +
>   9 files changed, 343 insertions(+)
>   create mode 100644 drivers/misc/rp1/Kconfig
>   create mode 100644 drivers/misc/rp1/Makefile
>   create mode 100644 drivers/misc/rp1/rp1-pci.dtso
>   create mode 100644 drivers/misc/rp1/rp1_pci.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4cb38064694e..54f9e09f02ed 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19757,6 +19757,7 @@ F:	Documentation/devicetree/bindings/misc/pci1de=
4,1.yaml
>   F:	Documentation/devicetree/bindings/pci/pci-ep-bus.yaml
>   F:	Documentation/devicetree/bindings/pinctrl/raspberrypi,rp1-gpio.yaml
>   F:	drivers/clk/clk-rp1.c
> +F:	drivers/misc/rp1/
>   F:	drivers/pinctrl/pinctrl-rp1.c
>   F:	include/dt-bindings/clock/rp1.h
>   F:	include/dt-bindings/misc/rp1.h
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index 56bc72c7ce4a..af8c3be967bf 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -649,4 +649,5 @@ source "drivers/misc/uacce/Kconfig"
>   source "drivers/misc/pvpanic/Kconfig"
>   source "drivers/misc/mchp_pci1xxxx/Kconfig"
>   source "drivers/misc/keba/Kconfig"
> +source "drivers/misc/rp1/Kconfig"
>   endmenu
> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> index 545aad06d088..5df79dd90c9c 100644
> --- a/drivers/misc/Makefile
> +++ b/drivers/misc/Makefile
> @@ -75,3 +75,4 @@ lan966x-pci-objs		:=3D lan966x_pci.o
>   lan966x-pci-objs		+=3D lan966x_pci.dtbo.o
>   obj-$(CONFIG_MCHP_LAN966X_PCI)	+=3D lan966x-pci.o
>   obj-y				+=3D keba/
> +obj-$(CONFIG_MISC_RP1)		+=3D rp1/
> diff --git a/drivers/misc/rp1/Kconfig b/drivers/misc/rp1/Kconfig
> new file mode 100644
> index 000000000000..cfb02b2f186c
> --- /dev/null
> +++ b/drivers/misc/rp1/Kconfig
> @@ -0,0 +1,20 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# RaspberryPi RP1 misc device
> +#
> +
> +config MISC_RP1
> +	tristate "RaspberryPi RP1 PCIe support"
> +	depends on OF_IRQ && OF_OVERLAY && PCI_MSI && PCI_QUIRKS
> +	select PCI_DYNAMIC_OF_NODES
> +	help
> +	  Support the RP1 peripheral chip found on Raspberry Pi 5 board.
> +
> +	  This device supports several sub-devices including e.g. Ethernet
> +	  controller, USB controller, I2C, SPI and UART.
> +
> +	  The driver is responsible for enabling the DT node once the PCIe
> +	  endpoint has been configured, and handling interrupts.
> +
> +	  This driver uses an overlay to load other drivers to support for
> +	  RP1 internal sub-devices.
> diff --git a/drivers/misc/rp1/Makefile b/drivers/misc/rp1/Makefile
> new file mode 100644
> index 000000000000..508b4cb05627
> --- /dev/null
> +++ b/drivers/misc/rp1/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +obj-$(CONFIG_MISC_RP1)		+=3D rp1-pci.o
> +rp1-pci-objs			:=3D rp1_pci.o rp1-pci.dtbo.o
> diff --git a/drivers/misc/rp1/rp1-pci.dtso b/drivers/misc/rp1/rp1-pci.dt=
so
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
> index 000000000000..c2d76e01bf57
> --- /dev/null
> +++ b/drivers/misc/rp1/rp1_pci.c
> @@ -0,0 +1,305 @@
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
> +#define RP1_INT_END		61
> +
> +/* Embedded dtbo symbols created by cmd_wrap_S_dtb in scripts/Makefile.=
lib */
> +extern char __dtbo_rp1_pci_begin[];
> +extern char __dtbo_rp1_pci_end[];
> +
> +struct rp1_dev {
> +	struct pci_dev *pdev;
> +	struct irq_domain *domain;
> +	struct irq_data *pcie_irqds[64];
> +	void __iomem *bar1;
> +	int ovcs_id;	/* overlay changeset id */
> +	bool level_triggered_irq[RP1_INT_END];
> +};
> +
> +static void msix_cfg_set(struct rp1_dev *rp1, unsigned int hwirq, u32 v=
alue)
> +{
> +	iowrite32(value, rp1->bar1 + RP1_PCIE_APBS_BASE + REG_SET + MSIX_CFG(h=
wirq));
> +}
> +
> +static void msix_cfg_clr(struct rp1_dev *rp1, unsigned int hwirq, u32 v=
alue)
> +{
> +	iowrite32(value, rp1->bar1 + RP1_PCIE_APBS_BASE + REG_CLR + MSIX_CFG(h=
wirq));
> +}
> +
> +static void rp1_mask_irq(struct irq_data *irqd)
> +{
> +	struct rp1_dev *rp1 =3D irqd->domain->host_data;
> +	struct irq_data *pcie_irqd =3D rp1->pcie_irqds[irqd->hwirq];
> +
> +	pci_msi_mask_irq(pcie_irqd);
> +}
> +
> +static void rp1_unmask_irq(struct irq_data *irqd)
> +{
> +	struct rp1_dev *rp1 =3D irqd->domain->host_data;
> +	struct irq_data *pcie_irqd =3D rp1->pcie_irqds[irqd->hwirq];
> +
> +	pci_msi_unmask_irq(pcie_irqd);
> +}
> +
> +static int rp1_irq_set_type(struct irq_data *irqd, unsigned int type)
> +{
> +	struct rp1_dev *rp1 =3D irqd->domain->host_data;
> +	unsigned int hwirq =3D (unsigned int)irqd->hwirq;
> +
> +	switch (type) {
> +	case IRQ_TYPE_LEVEL_HIGH:
> +		dev_dbg(&rp1->pdev->dev, "MSIX IACK EN for irq %d\n", hwirq);
This looks a little bit inconsistent. Only this type has a debug
message. So either we drop this or add at least a message for
IRQ_TYPE_EDGE_RISING, too. Btw the format specifier looks wrong
(unsigned int vs %d).
> +		msix_cfg_set(rp1, hwirq, MSIX_CFG_IACK_EN);
> +		rp1->level_triggered_irq[hwirq] =3D true;
> +	break;
> +	case IRQ_TYPE_EDGE_RISING:
> +		msix_cfg_clr(rp1, hwirq, MSIX_CFG_IACK_EN);
> +		rp1->level_triggered_irq[hwirq] =3D false;
> +		break;
> +	default:
> +		return -EINVAL;
It would be nice to document why only IRQ_TYPE_LEVEL_HIGH and
IRQ_TYPE_EDGE_RISING are supported. In case it's a software limitation,
this function would be a good place. In case this is a hardware
limitation this should be in the binding.
> +	}
> +
> +	return 0;
> +}
> +
> +static struct irq_chip rp1_irq_chip =3D {
> +	.name		=3D "rp1_irq_chip",
> +	.irq_mask	=3D rp1_mask_irq,
> +	.irq_unmask	=3D rp1_unmask_irq,
> +	.irq_set_type	=3D rp1_irq_set_type,
> +};
> +
> +static void rp1_chained_handle_irq(struct irq_desc *desc)
> +{
> +	unsigned int hwirq =3D desc->irq_data.hwirq & RP1_HW_IRQ_MASK;
> +	struct rp1_dev *rp1 =3D irq_desc_get_handler_data(desc);
> +	struct irq_chip *chip =3D irq_desc_get_chip(desc);
> +	unsigned int virq;
> +
> +	chained_irq_enter(chip, desc);
> +
> +	virq =3D irq_find_mapping(rp1->domain, hwirq);
> +	generic_handle_irq(virq);
> +	if (rp1->level_triggered_irq[hwirq])
> +		msix_cfg_set(rp1, hwirq, MSIX_CFG_IACK);
> +
> +	chained_irq_exit(chip, desc);
> +}
> +
> +static int rp1_irq_xlate(struct irq_domain *d, struct device_node *node=
,
> +			 const u32 *intspec, unsigned int intsize,
> +			 unsigned long *out_hwirq, unsigned int *out_type)
> +{
> +	struct rp1_dev *rp1 =3D d->host_data;
> +	struct irq_data *pcie_irqd;
> +	unsigned long hwirq;
> +	int pcie_irq;
> +	int ret;
> +
> +	ret =3D irq_domain_xlate_twocell(d, node, intspec, intsize,
> +				       &hwirq, out_type);
> +	if (ret)
> +		return ret;
> +
> +	pcie_irq =3D pci_irq_vector(rp1->pdev, hwirq);
> +	pcie_irqd =3D irq_get_irq_data(pcie_irq);
> +	rp1->pcie_irqds[hwirq] =3D pcie_irqd;
> +	*out_hwirq =3D hwirq;
> +
> +	return 0;
> +}
> +
> +static int rp1_irq_activate(struct irq_domain *d, struct irq_data *irqd=
,
> +			    bool reserve)
> +{
> +	struct rp1_dev *rp1 =3D d->host_data;
> +
> +	msix_cfg_set(rp1, (unsigned int)irqd->hwirq, MSIX_CFG_ENABLE);
> +
> +	return 0;
> +}
> +
> +static void rp1_irq_deactivate(struct irq_domain *d, struct irq_data *i=
rqd)
> +{
> +	struct rp1_dev *rp1 =3D d->host_data;
> +
> +	msix_cfg_clr(rp1, (unsigned int)irqd->hwirq, MSIX_CFG_ENABLE);
> +}
> +
> +static const struct irq_domain_ops rp1_domain_ops =3D {
> +	.xlate      =3D rp1_irq_xlate,
> +	.activate   =3D rp1_irq_activate,
> +	.deactivate =3D rp1_irq_deactivate,
> +};
> +
> +static void rp1_unregister_interrupts(struct pci_dev *pdev)
> +{
> +	struct rp1_dev *rp1 =3D pci_get_drvdata(pdev);
> +	int irq, i;
> +
> +	if (rp1->domain) {
> +		for (i =3D 0; i < RP1_INT_END; i++) {
> +			irq =3D irq_find_mapping(rp1->domain, i);
> +			irq_dispose_mapping(irq);
> +		}
> +
> +		irq_domain_remove(rp1->domain);
> +	}
> +
> +	pci_free_irq_vectors(pdev);
> +}
> +
> +static int rp1_probe(struct pci_dev *pdev, const struct pci_device_id *=
id)
> +{
> +	u32 dtbo_size =3D __dtbo_rp1_pci_end - __dtbo_rp1_pci_begin;
> +	void *dtbo_start =3D __dtbo_rp1_pci_begin;
> +	struct device *dev =3D &pdev->dev;
> +	struct device_node *rp1_node;
> +	struct rp1_dev *rp1;
> +	int err =3D 0;
> +	int i;
> +
> +	rp1_node =3D dev_of_node(dev);
> +	if (!rp1_node) {
> +		dev_err(dev, "Missing of_node for device\n");
> +		return -EINVAL;
> +	}
> +
> +	rp1 =3D devm_kzalloc(&pdev->dev, sizeof(*rp1), GFP_KERNEL);
> +	if (!rp1)
> +		return -ENOMEM;
> +
> +	rp1->pdev =3D pdev;
> +
> +	if (pci_resource_len(pdev, 1) <=3D 0x10000) {
> +		dev_err(&pdev->dev,
> +			"Not initialised - is the firmware running?\n");
> +		return -EINVAL;
> +	}
> +
> +	err =3D pcim_enable_device(pdev);
> +	if (err < 0)
> +		return dev_err_probe(&pdev->dev, err,
> +				     "Enabling PCI device has failed");
> +
> +	rp1->bar1 =3D pcim_iomap(pdev, 1, 0);
> +	if (!rp1->bar1) {
> +		dev_err(&pdev->dev, "Cannot map PCI BAR\n");
> +		return -EIO;
> +	}
> +
> +	pci_set_master(pdev);
> +
> +	err =3D pci_alloc_irq_vectors(pdev, RP1_INT_END, RP1_INT_END,
> +				    PCI_IRQ_MSIX);
> +	if (err < 0) {
> +		return dev_err_probe(&pdev->dev, err,
> +				     "pci_alloc_irq_vectors failed");
> +	} else if (err !=3D RP1_INT_END) {
> +		dev_err(&pdev->dev, "Cannot allocate enough interrupts\n");
> +		return -EINVAL;
> +	}
> +
> +	pci_set_drvdata(pdev, rp1);
> +	rp1->domain =3D irq_domain_add_linear(rp1_node, RP1_INT_END,
> +					    &rp1_domain_ops, rp1);
> +	if (!rp1->domain) {
> +		dev_err(&pdev->dev, "Error creating IRQ domain\n");
> +		err =3D -ENOMEM;
> +		goto err_unregister_interrupts;
> +	}
> +
> +	for (i =3D 0; i < RP1_INT_END; i++) {
> +		unsigned int irq =3D irq_create_mapping(rp1->domain, i);
> +
> +		if (!irq) {
> +			dev_err(&pdev->dev, "failed to create irq mapping\n");
> +			err =3D -EINVAL;
> +			goto err_unregister_interrupts;
> +		}
> +
> +		irq_set_chip_and_handler(irq, &rp1_irq_chip, handle_level_irq);
> +		irq_set_probe(irq);
> +		irq_set_chained_handler_and_data(pci_irq_vector(pdev, i),
> +						 rp1_chained_handle_irq, rp1);
> +	}
> +
> +	err =3D of_overlay_fdt_apply(dtbo_start, dtbo_size, &rp1->ovcs_id, rp1=
_node);
> +	if (err)
> +		goto err_unregister_interrupts;
> +
> +	err =3D of_platform_default_populate(rp1_node, NULL, dev);
> +	if (err)
> +		goto err_unload_overlay;
I think in this case it's worth to add a suitable dev_err() here.

Thanks

