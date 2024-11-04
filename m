Return-Path: <linux-pci+bounces-15960-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC20E9BB68A
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 14:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BBE61C20A5C
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 13:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB8D33997;
	Mon,  4 Nov 2024 13:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nsVMfv2Q";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="88kWsVIp";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="n7JmT176";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CwD5wivQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87E48BEE;
	Mon,  4 Nov 2024 13:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730727797; cv=none; b=CUm7jLJvX8khggUy+M6COXYHwFKSut8B0qRhfxQF6n+NoIP+GbMvhDtiboLIWQ7/DbCJ3PKv/FplLyLc7yIvKd9+s3QJOJ67diQ8ycSVenKzlLHt1KTdMtkEtmcPPH06gJYg8mgS+jHy42FtRaJS6r7/FqctQATqQi7rRSRqZrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730727797; c=relaxed/simple;
	bh=PYIhjHMOk8RIBZ7wo/4aNnIJ8HXy5fZ/csE+KiS3r/g=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=myzzYo8YoFWEcrWjOITix6G9iGSbOduCfRD+eFRze87dVDHUd6gdGiVIbBxZ7Llo2eB3iVAX9SnBPlx3zvhuoyWCXZxPtAzCtMSj1jxZcMoZESOWCer0Rn/XMIEkbwqZYINSorHftRDFGZgXb790IdsVgIPXm2a/S6/koesF+J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nsVMfv2Q; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=88kWsVIp; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=n7JmT176; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CwD5wivQ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E750221E54;
	Mon,  4 Nov 2024 13:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730727793; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fXd1/qwLJ92Wc3Fmt+FpoQgOBFBd957Gz8AjhuZ3wM0=;
	b=nsVMfv2QK79DENO4SvqPs06Nk0modOiDrr4mWGgw/nvLju7Ihb66pmpD2bDgkFaFeb+myC
	nHGwK9NGSQvvPQQYwqBMfk0OBJs0E/O6DH1GDutFs+1pVACDrFaRDdNbHRpP8HMKmvOwJC
	zenSpPzzvjYn+vXLBQ7A5XYMGU39VQg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730727793;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fXd1/qwLJ92Wc3Fmt+FpoQgOBFBd957Gz8AjhuZ3wM0=;
	b=88kWsVIplnwDSxFREeXLmtsGZEjDx4Adp4Ic6B6v5a7iGoXJVscuvOjRFzKk/tZWWt6F8P
	jNdbNdL2LvCnA3AQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730727792; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fXd1/qwLJ92Wc3Fmt+FpoQgOBFBd957Gz8AjhuZ3wM0=;
	b=n7JmT176Cq82WCQGRqLJ/D+8GlHBABV7Pe/dH6AsxlA54nmMG53mGSPH6aw6Q8PbY/Vbnl
	mwARTGa9XkLTM9fwJx+kiuLkfuSEFg8g707lKF7/vqeLxfzBs6oVeYvLE5JN28jCPkJ1I5
	Jy9gPxS+thYegnE1TAociOEhGp1vAYk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730727792;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fXd1/qwLJ92Wc3Fmt+FpoQgOBFBd957Gz8AjhuZ3wM0=;
	b=CwD5wivQVmC3wXnAYN97U0az1lLloE305L31q7FTHTwlxdRHAm0QBcLEEs3eH0lbrH8iSA
	G5dwm8Oh+S6dH+AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3414913503;
	Mon,  4 Nov 2024 13:43:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ygczCm/PKGe7cAAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Mon, 04 Nov 2024 13:43:11 +0000
Message-ID: <c0cdfb29-1ad8-4389-b3b6-0a8b01641f59@suse.de>
Date: Mon, 4 Nov 2024 15:43:10 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/12] misc: rp1: RaspberryPi RP1 misc driver
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
 Masahiro Yamada <masahiroy@kernel.org>, Stefan Wahren <wahrenst@gmx.net>,
 Herve Codina <herve.codina@bootlin.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Andrew Lunn <andrew@lunn.ch>
References: <cover.1730123575.git.andrea.porta@suse.com>
 <66f17842775bf03defd1f5cad41fada0f2b97bdc.1730123575.git.andrea.porta@suse.com>
Content-Language: en-US
From: Stanimir Varbanov <svarbanov@suse.de>
In-Reply-To: <66f17842775bf03defd1f5cad41fada0f2b97bdc.1730123575.git.andrea.porta@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[suse.com,baylibre.com,kernel.org,broadcom.com,linux.com,linaro.org,google.com,arm.com,bgdev.pl,amd.com,arndb.de,linuxfoundation.org,vger.kernel.org,lists.infradead.org,gmx.net,bootlin.com,lunn.ch];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	FREEMAIL_ENVRCPT(0.00)[gmx.net];
	RCVD_TLS_ALL(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLuy4kgthhwuicx86wgtwa6dww)];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TAGGED_RCPT(0.00)[dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.de:mid]
X-Spam-Flag: NO
X-Spam-Level: 

On 10/28/24 16:07, Andrea della Porta wrote:
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
>  MAINTAINERS                   |   1 +
>  drivers/misc/Kconfig          |   1 +
>  drivers/misc/Makefile         |   1 +
>  drivers/misc/rp1/Kconfig      |  21 ++
>  drivers/misc/rp1/Makefile     |   3 +
>  drivers/misc/rp1/rp1-pci.dtso |   8 +
>  drivers/misc/rp1/rp1_pci.c    | 357 ++++++++++++++++++++++++++++++++++
>  drivers/misc/rp1/rp1_pci.h    |  14 ++
>  drivers/pci/quirks.c          |   1 +
>  include/linux/pci_ids.h       |   3 +
>  10 files changed, 410 insertions(+)
>  create mode 100644 drivers/misc/rp1/Kconfig
>  create mode 100644 drivers/misc/rp1/Makefile
>  create mode 100644 drivers/misc/rp1/rp1-pci.dtso
>  create mode 100644 drivers/misc/rp1/rp1_pci.c
>  create mode 100644 drivers/misc/rp1/rp1_pci.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 510a071ede78..032678fb2470 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19389,6 +19389,7 @@ F:	Documentation/devicetree/bindings/misc/pci1de4,1.yaml
>  F:	Documentation/devicetree/bindings/pci/pci-ep-bus.yaml
>  F:	Documentation/devicetree/bindings/pinctrl/raspberrypi,rp1-gpio.yaml
>  F:	drivers/clk/clk-rp1.c
> +F:	drivers/misc/rp1/
>  F:	drivers/pinctrl/pinctrl-rp1.c
>  F:	include/dt-bindings/clock/rp1.h
>  F:	include/dt-bindings/misc/rp1.h
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index 3fe7e2a9bd29..ac85cb154100 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -628,4 +628,5 @@ source "drivers/misc/uacce/Kconfig"
>  source "drivers/misc/pvpanic/Kconfig"
>  source "drivers/misc/mchp_pci1xxxx/Kconfig"
>  source "drivers/misc/keba/Kconfig"
> +source "drivers/misc/rp1/Kconfig"
>  endmenu
> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> index a9f94525e181..ae86d69997b4 100644
> --- a/drivers/misc/Makefile
> +++ b/drivers/misc/Makefile
> @@ -72,3 +72,4 @@ obj-$(CONFIG_TPS6594_PFSM)	+= tps6594-pfsm.o
>  obj-$(CONFIG_NSM)		+= nsm.o
>  obj-$(CONFIG_MARVELL_CN10K_DPI)	+= mrvl_cn10k_dpi.o
>  obj-y				+= keba/
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
> index 000000000000..30d7a15dc7f1
> --- /dev/null
> +++ b/drivers/misc/rp1/rp1_pci.c
> @@ -0,0 +1,357 @@
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

How those interrupts are supposed to be used by rp1-pci.dtso (or from
rp1.dtso)?

include/dt-bindings/interrupt-controller/raspberrypi,rp1-interrupts.h ?

> +struct rp1_dev {
> +	struct pci_dev *pdev;
> +	struct device *dev;
> +	struct irq_domain *domain;
> +	struct irq_data *pcie_irqds[64];
> +	void __iomem *bar1;
> +	int ovcs_id;
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
> +		dev_dbg(rp1->dev, "MSIX IACK EN for irq %d\n", hwirq);
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
> +	.name            = "rp1_irq_chip",

tabs instead of spaces here and below.

> +	.irq_mask        = rp1_mask_irq,
> +	.irq_unmask      = rp1_unmask_irq,
> +	.irq_set_type    = rp1_irq_set_type,
> +};
> +
> +static void rp1_chained_handle_irq(struct irq_desc *desc)
> +{
> +	unsigned int hwirq = desc->irq_data.hwirq & RP1_HW_IRQ_MASK;
> +	struct rp1_dev *rp1 = irq_desc_get_handler_data(desc);
> +	struct irq_chip *chip = irq_desc_get_chip(desc);
> +	int virq;

unsigned int

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
> +	for (i = 0; i < RP1_INT_END; i++) {
> +		irq = irq_find_mapping(rp1->domain, i);
> +		irq_dispose_mapping(irq);
> +	}

new line

> +	irq_domain_remove(rp1->domain);
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
> +	rp1->dev = &pdev->dev;

rp1->dev is used only once in dev_dbg macro. You could drop it and
extract struct device from rp1->pdev.

> +
> +	if (pci_resource_len(pdev, 1) <= 0x10000) {
> +		dev_err(&pdev->dev,
> +			"Not initialised - is the firmware running?\n");

no need of a new line

> +		return -EINVAL;
> +	}
> +
> +	err = pcim_enable_device(pdev);
> +	if (err < 0) {
> +		dev_err(&pdev->dev, "Enabling PCI device has failed: %d",
> +			err);

ditto

> +		return err;
> +	}
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

ditto

> +	if (err != RP1_INT_END) {

an 'err' could be smaller then RP1_INT_END but still positive, thus
.probe will return positive error code.

> +		dev_err(&pdev->dev, "pci_alloc_irq_vectors failed - %d\n", err);
> +		return err;
> +	}
> +
> +	pci_set_drvdata(pdev, rp1);
> +	rp1->domain = irq_domain_add_linear(rp1_node, RP1_INT_END,
> +					    &rp1_domain_ops, rp1);

irq_domain_add_linear() could fail, check for error ...

> +
> +	for (i = 0; i < RP1_INT_END; i++) {
> +		int irq = irq_create_mapping(rp1->domain, i);

irq_create_mapping() returns 'unsigned int', maybe something like this:

		unsigned int irq = irq_create_mapping(rp1->domain, i);
		if (!irq) {
			err = -EINVAL; (or -ENOMEM)
			...
		}

> +
> +		if (irq < 0) {
> +			dev_err(&pdev->dev, "failed to create irq mapping\n");
> +			err = irq;
> +			goto err_unload_overlay;

			goto err_unregister_interrupts; ?

> +		}

new line, please

> +		irq_set_chip_and_handler(irq, &rp1_irq_chip, handle_level_irq);
> +		irq_set_probe(irq);
> +		irq_set_chained_handler_and_data(pci_irq_vector(pdev, i),
> +						 rp1_chained_handle_irq, rp1);
> +	}
> +
> +	err = of_overlay_fdt_apply(dtbo_start, dtbo_size, &rp1->ovcs_id, rp1_node);
> +	if (err)
> +		goto err_unregister_interrupts;
> +
> +	err = of_platform_default_populate(rp1_node, NULL, dev);
> +	if (err)
> +		goto err_unload_overlay;
> +
> +	return 0;
> +
> +err_unload_overlay:
> +	of_overlay_remove(&rp1->ovcs_id);
> +err_unregister_interrupts:
> +	rp1_unregister_interrupts(pdev);
> +
> +	return err;
> +}
> +
> +static void rp1_remove(struct pci_dev *pdev)
> +{
> +	struct rp1_dev *rp1 = pci_get_drvdata(pdev);
> +	struct device *dev = &pdev->dev;
> +
> +	of_platform_depopulate(dev);
> +	of_overlay_remove(&rp1->ovcs_id);
> +	rp1_unregister_interrupts(pdev);
> +}
> +
> +static const struct pci_device_id dev_id_table[] = {
> +	{ PCI_DEVICE(PCI_VENDOR_ID_RPI, PCI_DEVICE_ID_RPI_RP1_C0), },
> +	{ 0, }
> +};
> +MODULE_DEVICE_TABLE(pci, dev_id_table);
> +
> +static struct pci_driver rp1_driver = {
> +	.name		= RP1_DRIVER_NAME,
> +	.id_table	= dev_id_table,
> +	.probe		= rp1_probe,
> +	.remove		= rp1_remove,
> +};
> +
> +module_pci_driver(rp1_driver);
> +
> +MODULE_AUTHOR("Phil Elwell <phil@raspberrypi.com>");
> +MODULE_AUTHOR("Andrea della Porta <andrea.porta@suse.com>");
> +MODULE_DESCRIPTION("RP1 wrapper");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/misc/rp1/rp1_pci.h b/drivers/misc/rp1/rp1_pci.h
> new file mode 100644
> index 000000000000..7982f13bad9b
> --- /dev/null
> +++ b/drivers/misc/rp1/rp1_pci.h
> @@ -0,0 +1,14 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +/*
> + * Copyright (c) 2018-24 Raspberry Pi Ltd.
> + * All rights reserved.
> + */
> +
> +#ifndef _RP1_EXTERN_H_
> +#define _RP1_EXTERN_H_
> +
> +extern char __dtbo_rp1_pci_begin[];
> +extern char __dtbo_rp1_pci_end[];

Could you point me where those two variables are used outside of rp1_pci.c?

~Stan


