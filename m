Return-Path: <linux-pci+bounces-21024-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0488DA2D6C1
	for <lists+linux-pci@lfdr.de>; Sat,  8 Feb 2025 15:59:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91130188A6EF
	for <lists+linux-pci@lfdr.de>; Sat,  8 Feb 2025 14:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7AB82475F9;
	Sat,  8 Feb 2025 14:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="bvi4/Ntj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4AC014F9CF;
	Sat,  8 Feb 2025 14:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739026740; cv=none; b=TRU2j1Llo8YtvOc86TXUk5YTiMM4smGQn2C8OhVxqRgbvt3agDNW0Iqv/bu4ww02UvV6odXcM86JWYWnMnMOv3EN/CsgaaP/95eHqO5Gh/gtlExzI0mC3Aqr+Z0zNv/2cg6mMVNInuCWdM8HhpGE4jFxM+G7BVMyoVWeR0lSjnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739026740; c=relaxed/simple;
	bh=62NGnh0ynBeHaDMODJlGo+NigivkE/PRq3HSc0cTjz4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=C9Avct1AUvy27by+yGBy5TbbQDoPQXD3IcMvKtCwi/OQpGPGeK0lLQ3kYs2LUcRBsb954+IyFYfB7ddkIbnsAfdFQqVGgV49reZqANJnRPo7Ui7GfhD8nWZxc/gK1U3ClCi73gmgsSK3vCyvBV+/DHWx32NCCRxqNqfqnKEd688=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=bvi4/Ntj; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1739026734; x=1739631534; i=wahrenst@gmx.net;
	bh=4t/QRhdvCX2CMAW4ROzgacenEwPlnwy9OHTYJohzSDI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=bvi4/NtjjqpU4qmshXEXKSQxcMW5LZa92BI9KQrc66IFsH4V8orjdZb+/9tH76Pi
	 RHlxe2obRONUlGOKiMUDALINR+e4rUaWNqiVOPpP8wtotZjAx2oAZmmy50ReaYH5f
	 zOFuBKrwaZw52PSqGq68+Art7U+M50SkDZeoD/+V1ALovbSoCyoGaclaZCLjgXFSr
	 nyhaRMskd0S14TBE/jfFH1sssW6rieMO0HT6pK6vrSwLMai59bVkxQKeCV8yv9lAz
	 +oYcpRKFCir4Qc1NC9DkIsSA6PIy8LU3Zdn8Olc7x1Sg7mUKNshGb0Z0glGNxsuDU
	 yqm3Fbcgl7bwuLHpMQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.107] ([37.4.251.153]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N2V0B-1tGhgQ3QVT-00zPfU; Sat, 08
 Feb 2025 15:58:54 +0100
Message-ID: <0ef80d00-7213-47c8-9876-1d32011d8d3d@gmx.net>
Date: Sat, 8 Feb 2025 15:58:51 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 05/11] clk: rp1: Add support for clocks provided by RP1
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
 <4da2f1106ea6b239eba9c117bf6c129fbdb3ee87.1738963156.git.andrea.porta@suse.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
Autocrypt: addr=wahrenst@gmx.net; keydata=
 xjMEZ1dOJBYJKwYBBAHaRw8BAQdA7H2MMG3q8FV7kAPko5vOAeaa4UA1I0hMgga1j5iYTTvN
 IFN0ZWZhbiBXYWhyZW4gPHdhaHJlbnN0QGdteC5uZXQ+wo8EExYIADcWIQT3FXg+ApsOhPDN
 NNFuwvLLwiAwigUCZ1dOJAUJB4TOAAIbAwQLCQgHBRUICQoLBRYCAwEAAAoJEG7C8svCIDCK
 JQ4BAP4Y9uuHAxbAhHSQf6UZ+hl5BDznsZVBJvH8cZe2dSZ6AQCNgoc1Lxw1tvPscuC1Jd1C
 TZomrGfQI47OiiJ3vGktBc44BGdXTiQSCisGAQQBl1UBBQEBB0B5M0B2E2XxySUQhU6emMYx
 f5QR/BrEK0hs3bLT6Hb9WgMBCAfCfgQYFggAJhYhBPcVeD4Cmw6E8M000W7C8svCIDCKBQJn
 V04kBQkHhM4AAhsMAAoJEG7C8svCIDCKJxoA/i+kqD5bphZEucrJHw77ujnOQbiKY2rLb0pE
 aHMQoiECAQDVbj827W1Yai/0XEABIr8Ci6a+/qZ8Vz6MZzL5GJosAA==
In-Reply-To: <4da2f1106ea6b239eba9c117bf6c129fbdb3ee87.1738963156.git.andrea.porta@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XgWx6FSzi9WUnA/EmBjAPS9AWVTwQHCYurk1EgCgNh1stuyRPGu
 k3rcZw8cDVTV0gFen/gEHzWNIu5p9+qtv0RspENPS5vIfK+ftB+seXQf+3NlXYaDCKwej7d
 6JLqwXo3h/hjNNGFeZFnf6PLl5+JTgrcvA9yBRSP6weJo9ihdQ0GeqQ8jisUHIcZJjESugF
 Ac7SpeoTolWuu/L43A7Gg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:WczScuruUdA=;Wv/uZdEHJvCWtMmF/PyVi05X0DB
 89qVePsaYV8Zz8YqSzLMcvVTJRygJzL26BB2LnozoF/J9MpJ+77Tw3NhxqZCL3rtxIs91Ca5s
 REuGIBAN2nELv5Cc2RSvLpBWvHwnU4ah5yfKO+19vf5O4r0tHubCNTmxPI/bTzC+C8TnWTH9b
 epUD7/EIwbtvrZT689U2EqWqarBseXzDMQder8EJD3wefHM9I4SmGgIGb1pZPwgXbURiL7jAI
 me8Oqmz3oZrn+jbjKqFjL7tYb4y+gCbq+jabFMvWqamaj/AXT/v2px7R/0vTFLwP0cXA0UAa9
 lkonIxbhnbstBdckIPMgbbL4oyMcOh4wCnsUtPvIBm19l9EecPa0MNULgK5zhuoT5azYBritS
 JUKLREzwWAg+2Z8GOSjzDakJRIFCCmmGiKSRZzHYfpxbSjFbQTn9MSji7pHaGinAcegGOERQO
 VQBIjTH0YlciWeibWZhlDAn2zPiDCn6U8gCIB1BUHUxQLv5+NHp2EVIFkZgXCUUijvvxpO8vW
 beTDU8BPUdpukNk69vmbB00NKCsXpHUriFUM0oixrNXzVjgZh72pHzB14TGLfab5qgW9PKFWm
 Fn2DlDaqci/7Vs1oChqZznaBe6/mg1QE0K9yF8NKhUtH8hgJRF3NyrHNPkik+kG5vMQug76hH
 rJIjTww2MlA9FhzDA47ghtP0dFIerr7yLBysKudeaclWomgH5EGtpjyZVLtpVikrE1QRhOmym
 T/fZCXuiqbjLGTd8mC35TKn1PYvPxMxYNMhRGz/YDEGSCmbX10eJGRI31v8tm5Fq7Sx7bx/Tu
 stQheXJFO+kDZvmrVRhJZIGU6K0IGs6cI8stR5AIpjDFBEvu1xyG7SfYuE1Wr7vhTaAS5EXie
 cNFTc7cj/5V2wXAYSAlIg7DnYggqE2VEaQ9kN+2UQr92oJ5Pej0a36G93sEzIs8tCGJcTDbrV
 rf5NPPpJVMdfTUyUu7Ph8I6/sf1UXg3e/sbSt8UtjMOpGqt76DsObb4uS/a78qqAZlmuSlk+r
 3vLwEXHz0yHHFRU2fUfuW5k+qwJXVHqhB9qoOZ2D1mB7kvPZuXYGzts997uEGkxZ8rpEGEnPV
 yc4k+Fc0CbOIxe0HrkXyLTAbl6+36vPT3oWOA9uMtoGPGJ7z04u1PzrfAvUIhMVl8snpeZs2j
 4oX5DG983iyI7EZBL1+m8dt+R07h1dtxXHqkLlQ9YbtErFG5K+Ws/JGtp1XAzbZjOdIrJIeBc
 1Uy2zgLv1hJMDbBtM+e1lWMPmEfsZphpY8B6I9Lu1RGApMPQf5V/MS0fBrBv5J4ySrFOTFo5F
 Nj52eOZFqkKEeEu5K1NgWtIE/YlGWZVDRlH7p6eFEE3UtnQE0PYz2n9rUd7v5j2XNumTGMbTd
 g0+5dzRaUyeQaH1xw3Om4nV1BJky3fkobM1zpR5UPF6NhaSg5s2M6qx4sJ

Hi Andrea,

Am 07.02.25 um 22:31 schrieb Andrea della Porta:
> RaspberryPi RP1 is an MFD providing, among other peripherals, several
> clock generators and PLLs that drives the sub-peripherals.
> Add the driver to support the clock providers.
>
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> ---
>   MAINTAINERS           |    1 +
>   drivers/clk/Kconfig   |    9 +
>   drivers/clk/Makefile  |    1 +
>   drivers/clk/clk-rp1.c | 1511 +++++++++++++++++++++++++++++++++++++++++
>   4 files changed, 1522 insertions(+)
>   create mode 100644 drivers/clk/clk-rp1.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 21a818def180..a4a9555c07c5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19755,6 +19755,7 @@ F:	Documentation/devicetree/bindings/clock/raspb=
errypi,rp1-clocks.yaml
>   F:	Documentation/devicetree/bindings/misc/pci1de4,1.yaml
>   F:	Documentation/devicetree/bindings/pci/pci-ep-bus.yaml
>   F:	Documentation/devicetree/bindings/pinctrl/raspberrypi,rp1-gpio.yaml
> +F:	drivers/clk/clk-rp1.c
>   F:	include/dt-bindings/clock/rp1.h
>   F:	include/dt-bindings/misc/rp1.h
>
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index 713573b6c86c..cff90de71409 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -88,6 +88,15 @@ config COMMON_CLK_RK808
>   	  These multi-function devices have two fixed-rate oscillators, clock=
ed at 32KHz each.
>   	  Clkout1 is always on, Clkout2 can off by control register.
>
> +config COMMON_CLK_RP1
> +	tristate "Raspberry Pi RP1-based clock support"
> +	depends on MISC_RP1 || COMPILE_TEST
> +	default MISC_RP1
> +	help
> +	  Enable common clock framework support for Raspberry Pi RP1.
> +	  This multi-function device has 3 main PLLs and several clock
> +	  generators to drive the internal sub-peripherals.
> +
>   config COMMON_CLK_HI655X
>   	tristate "Clock driver for Hi655x" if EXPERT
>   	depends on (MFD_HI655X_PMIC || COMPILE_TEST)
> diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
> index bf4bd45adc3a..ff3993ed7e09 100644
> --- a/drivers/clk/Makefile
> +++ b/drivers/clk/Makefile
> @@ -84,6 +84,7 @@ obj-$(CONFIG_CLK_LS1028A_PLLDIG)	+=3D clk-plldig.o
>   obj-$(CONFIG_COMMON_CLK_PWM)		+=3D clk-pwm.o
>   obj-$(CONFIG_CLK_QORIQ)			+=3D clk-qoriq.o
>   obj-$(CONFIG_COMMON_CLK_RK808)		+=3D clk-rk808.o
> +obj-$(CONFIG_COMMON_CLK_RP1)            +=3D clk-rp1.o
>   obj-$(CONFIG_COMMON_CLK_HI655X)		+=3D clk-hi655x.o
>   obj-$(CONFIG_COMMON_CLK_S2MPS11)	+=3D clk-s2mps11.o
>   obj-$(CONFIG_COMMON_CLK_SCMI)           +=3D clk-scmi.o
> diff --git a/drivers/clk/clk-rp1.c b/drivers/clk/clk-rp1.c
> new file mode 100644
> index 000000000000..278f6df455a0
> --- /dev/null
> +++ b/drivers/clk/clk-rp1.c
> @@ -0,0 +1,1511 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2023 Raspberry Pi Ltd.
> + *
> + * Clock driver for RP1 PCIe multifunction chip.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/clk-provider.h>
> +#include <linux/regmap.h>
> +#include <linux/math64.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/units.h>
> +
> +#include <dt-bindings/clock/raspberrypi,rp1-clocks.h>
> +
> +#define PLL_SYS_OFFSET			0x08000
> +#define PLL_SYS_CS			(PLL_SYS_OFFSET + 0x00)
> +#define PLL_SYS_PWR			(PLL_SYS_OFFSET + 0x04)
> +#define PLL_SYS_FBDIV_INT		(PLL_SYS_OFFSET + 0x08)
> +#define PLL_SYS_FBDIV_FRAC		(PLL_SYS_OFFSET + 0x0c)
> +#define PLL_SYS_PRIM			(PLL_SYS_OFFSET + 0x10)
> +#define PLL_SYS_SEC			(PLL_SYS_OFFSET + 0x14)
> +
> +#define PLL_AUDIO_OFFSET		0x0c000
> +#define PLL_AUDIO_CS			(PLL_AUDIO_OFFSET + 0x00)
> +#define PLL_AUDIO_PWR			(PLL_AUDIO_OFFSET + 0x04)
> +#define PLL_AUDIO_FBDIV_INT		(PLL_AUDIO_OFFSET + 0x08)
> +#define PLL_AUDIO_FBDIV_FRAC		(PLL_AUDIO_OFFSET + 0x0c)
> +#define PLL_AUDIO_PRIM			(PLL_AUDIO_OFFSET + 0x10)
> +#define PLL_AUDIO_SEC			(PLL_AUDIO_OFFSET + 0x14)
> +#define PLL_AUDIO_TERN			(PLL_AUDIO_OFFSET + 0x18)
> +
> +#define PLL_VIDEO_OFFSET		0x10000
> +#define PLL_VIDEO_CS			(PLL_VIDEO_OFFSET + 0x00)
> +#define PLL_VIDEO_PWR			(PLL_VIDEO_OFFSET + 0x04)
> +#define PLL_VIDEO_FBDIV_INT		(PLL_VIDEO_OFFSET + 0x08)
> +#define PLL_VIDEO_FBDIV_FRAC		(PLL_VIDEO_OFFSET + 0x0c)
> +#define PLL_VIDEO_PRIM			(PLL_VIDEO_OFFSET + 0x10)
> +#define PLL_VIDEO_SEC			(PLL_VIDEO_OFFSET + 0x14)
> +
> +#define GPCLK_OE_CTRL			0x00000
> +
> +#define CLK_SYS_OFFSET			0x00014
> +#define CLK_SYS_CTRL			(CLK_SYS_OFFSET + 0x00)
> +#define CLK_SYS_DIV_INT			(CLK_SYS_OFFSET + 0x04)
> +#define CLK_SYS_SEL			(CLK_SYS_OFFSET + 0x0c)
> +
> +#define CLK_SLOW_OFFSET			0x00024
> +#define CLK_SLOW_SYS_CTRL		(CLK_SLOW_OFFSET + 0x00)
> +#define CLK_SLOW_SYS_DIV_INT		(CLK_SLOW_OFFSET + 0x04)
> +#define CLK_SLOW_SYS_SEL		(CLK_SLOW_OFFSET + 0x0c)
> +
> +#define CLK_DMA_OFFSET			0x00044
> +#define CLK_DMA_CTRL			(CLK_DMA_OFFSET + 0x00)
> +#define CLK_DMA_DIV_INT			(CLK_DMA_OFFSET + 0x04)
> +#define CLK_DMA_SEL			(CLK_DMA_OFFSET + 0x0c)
> +
> +#define CLK_UART_OFFSET			0x00054
> +#define CLK_UART_CTRL			(CLK_UART_OFFSET + 0x00)
> +#define CLK_UART_DIV_INT		(CLK_UART_OFFSET + 0x04)
> +#define CLK_UART_SEL			(CLK_UART_OFFSET + 0x0c)
> +
> +#define CLK_ETH_OFFSET			0x00064
> +#define CLK_ETH_CTRL			(CLK_ETH_OFFSET + 0x00)
> +#define CLK_ETH_DIV_INT			(CLK_ETH_OFFSET + 0x04)
> +#define CLK_ETH_SEL			(CLK_ETH_OFFSET + 0x0c)
> +
> +#define CLK_PWM0_OFFSET			0x00074
> +#define CLK_PWM0_CTRL			(CLK_PWM0_OFFSET + 0x00)
> +#define CLK_PWM0_DIV_INT		(CLK_PWM0_OFFSET + 0x04)
> +#define CLK_PWM0_DIV_FRAC		(CLK_PWM0_OFFSET + 0x08)
> +#define CLK_PWM0_SEL			(CLK_PWM0_OFFSET + 0x0c)
> +
> +#define CLK_PWM1_OFFSET			0x00084
> +#define CLK_PWM1_CTRL			(CLK_PWM1_OFFSET + 0x00)
> +#define CLK_PWM1_DIV_INT		(CLK_PWM1_OFFSET + 0x04)
> +#define CLK_PWM1_DIV_FRAC		(CLK_PWM1_OFFSET + 0x08)
> +#define CLK_PWM1_SEL			(CLK_PWM1_OFFSET + 0x0c)
> +
> +#define CLK_AUDIO_IN_OFFSET		0x00094
> +#define CLK_AUDIO_IN_CTRL		(CLK_AUDIO_IN_OFFSET + 0x00)
> +#define CLK_AUDIO_IN_DIV_INT		(CLK_AUDIO_IN_OFFSET + 0x04)
> +#define CLK_AUDIO_IN_SEL		(CLK_AUDIO_IN_OFFSET + 0x0c)
> +
> +#define CLK_AUDIO_OUT_OFFSET		0x000a4
> +#define CLK_AUDIO_OUT_CTRL		(CLK_AUDIO_OUT_OFFSET + 0x00)
> +#define CLK_AUDIO_OUT_DIV_INT		(CLK_AUDIO_OUT_OFFSET + 0x04)
> +#define CLK_AUDIO_OUT_SEL		(CLK_AUDIO_OUT_OFFSET + 0x0c)
> +
> +#define CLK_I2S_OFFSET			0x000b4
> +#define CLK_I2S_CTRL			(CLK_I2S_OFFSET + 0x00)
> +#define CLK_I2S_DIV_INT			(CLK_I2S_OFFSET + 0x04)
> +#define CLK_I2S_SEL			(CLK_I2S_OFFSET + 0x0c)
> +
> +#define CLK_MIPI0_CFG_OFFSET		0x000c4
> +#define CLK_MIPI0_CFG_CTRL		(CLK_MIPI0_CFG_OFFSET + 0x00)
> +#define CLK_MIPI0_CFG_DIV_INT		(CLK_MIPI0_CFG_OFFSET + 0x04)
> +#define CLK_MIPI0_CFG_SEL		(CLK_MIPI0_CFG_OFFSET + 0x0c)
> +
> +#define CLK_MIPI1_CFG_OFFSET		0x000d4
> +#define CLK_MIPI1_CFG_CTRL		(CLK_MIPI1_CFG_OFFSET + 0x00)
> +#define CLK_MIPI1_CFG_DIV_INT		(CLK_MIPI1_CFG_OFFSET + 0x04)
> +#define CLK_MIPI1_CFG_SEL		(CLK_MIPI1_CFG_OFFSET + 0x0c)
> +
> +#define CLK_PCIE_AUX_OFFSET		0x000e4
> +#define CLK_PCIE_AUX_CTRL		(CLK_PCIE_AUX_OFFSET + 0x00)
> +#define CLK_PCIE_AUX_DIV_INT		(CLK_PCIE_AUX_OFFSET + 0x04)
> +#define CLK_PCIE_AUX_SEL		(CLK_PCIE_AUX_OFFSET + 0x0c)
> +
> +#define CLK_USBH0_MICROFRAME_OFFSET	0x000f4
> +#define CLK_USBH0_MICROFRAME_CTRL	(CLK_USBH0_MICROFRAME_OFFSET + 0x00)
> +#define CLK_USBH0_MICROFRAME_DIV_INT	(CLK_USBH0_MICROFRAME_OFFSET + 0x0=
4)
> +#define CLK_USBH0_MICROFRAME_SEL	(CLK_USBH0_MICROFRAME_OFFSET + 0x0c)
> +
> +#define CLK_USBH1_MICROFRAME_OFFSET	0x00104
> +#define CLK_USBH1_MICROFRAME_CTRL	(CLK_USBH1_MICROFRAME_OFFSET + 0x00)
> +#define CLK_USBH1_MICROFRAME_DIV_INT	(CLK_USBH1_MICROFRAME_OFFSET + 0x0=
4)
> +#define CLK_USBH1_MICROFRAME_SEL	(CLK_USBH1_MICROFRAME_OFFSET + 0x0c)
> +
> +#define CLK_USBH0_SUSPEND_OFFSET	0x00114
> +#define CLK_USBH0_SUSPEND_CTRL		(CLK_USBH0_SUSPEND_OFFSET + 0x00)
> +#define CLK_USBH0_SUSPEND_DIV_INT	(CLK_USBH0_SUSPEND_OFFSET + 0x04)
> +#define CLK_USBH0_SUSPEND_SEL		(CLK_USBH0_SUSPEND_OFFSET + 0x0c)
> +
> +#define CLK_USBH1_SUSPEND_OFFSET	0x00124
> +#define CLK_USBH1_SUSPEND_CTRL		(CLK_USBH1_SUSPEND_OFFSET + 0x00)
> +#define CLK_USBH1_SUSPEND_DIV_INT	(CLK_USBH1_SUSPEND_OFFSET + 0x04)
> +#define CLK_USBH1_SUSPEND_SEL		(CLK_USBH1_SUSPEND_OFFSET + 0x0c)
> +
> +#define CLK_ETH_TSU_OFFSET		0x00134
> +#define CLK_ETH_TSU_CTRL		(CLK_ETH_TSU_OFFSET + 0x00)
> +#define CLK_ETH_TSU_DIV_INT		(CLK_ETH_TSU_OFFSET + 0x04)
> +#define CLK_ETH_TSU_SEL			(CLK_ETH_TSU_OFFSET + 0x0c)
> +
> +#define CLK_ADC_OFFSET			0x00144
> +#define CLK_ADC_CTRL			(CLK_ADC_OFFSET + 0x00)
> +#define CLK_ADC_DIV_INT			(CLK_ADC_OFFSET + 0x04)
> +#define CLK_ADC_SEL			(CLK_ADC_OFFSET + 0x0c)
> +
> +#define CLK_SDIO_TIMER_OFFSET		0x00154
> +#define CLK_SDIO_TIMER_CTRL		(CLK_SDIO_TIMER_OFFSET + 0x00)
> +#define CLK_SDIO_TIMER_DIV_INT		(CLK_SDIO_TIMER_OFFSET + 0x04)
> +#define CLK_SDIO_TIMER_SEL		(CLK_SDIO_TIMER_OFFSET + 0x0c)
> +
> +#define CLK_SDIO_ALT_SRC_OFFSET		0x00164
> +#define CLK_SDIO_ALT_SRC_CTRL		(CLK_SDIO_ALT_SRC_OFFSET + 0x00)
> +#define CLK_SDIO_ALT_SRC_DIV_INT	(CLK_SDIO_ALT_SRC_OFFSET + 0x04)
> +#define CLK_SDIO_ALT_SRC_SEL		(CLK_SDIO_ALT_SRC_OFFSET + 0x0c)
> +
> +#define CLK_GP0_OFFSET			0x00174
> +#define CLK_GP0_CTRL			(CLK_GP0_OFFSET + 0x00)
> +#define CLK_GP0_DIV_INT			(CLK_GP0_OFFSET + 0x04)
> +#define CLK_GP0_DIV_FRAC		(CLK_GP0_OFFSET + 0x08)
> +#define CLK_GP0_SEL			(CLK_GP0_OFFSET + 0x0c)
> +
> +#define CLK_GP1_OFFSET			0x00184
> +#define CLK_GP1_CTRL			(CLK_GP1_OFFSET + 0x00)
> +#define CLK_GP1_DIV_INT			(CLK_GP1_OFFSET + 0x04)
> +#define CLK_GP1_DIV_FRAC		(CLK_GP1_OFFSET + 0x08)
> +#define CLK_GP1_SEL			(CLK_GP1_OFFSET + 0x0c)
> +
> +#define CLK_GP2_OFFSET			0x00194
> +#define CLK_GP2_CTRL			(CLK_GP2_OFFSET + 0x00)
> +#define CLK_GP2_DIV_INT			(CLK_GP2_OFFSET + 0x04)
> +#define CLK_GP2_DIV_FRAC		(CLK_GP2_OFFSET + 0x08)
> +#define CLK_GP2_SEL			(CLK_GP2_OFFSET + 0x0c)
> +
> +#define CLK_GP3_OFFSET			0x001a4
> +#define CLK_GP3_CTRL			(CLK_GP3_OFFSET + 0x00)
> +#define CLK_GP3_DIV_INT			(CLK_GP3_OFFSET + 0x04)
> +#define CLK_GP3_DIV_FRAC		(CLK_GP3_OFFSET + 0x08)
> +#define CLK_GP3_SEL			(CLK_GP3_OFFSET + 0x0c)
> +
> +#define CLK_GP4_OFFSET			0x001b4
> +#define CLK_GP4_CTRL			(CLK_GP4_OFFSET + 0x00)
> +#define CLK_GP4_DIV_INT			(CLK_GP4_OFFSET + 0x04)
> +#define CLK_GP4_DIV_FRAC		(CLK_GP4_OFFSET + 0x08)
> +#define CLK_GP4_SEL			(CLK_GP4_OFFSET + 0x0c)
> +
> +#define CLK_GP5_OFFSET			0x001c4
> +#define CLK_GP5_CTRL			(CLK_GP5_OFFSET + 0x00)
> +#define CLK_GP5_DIV_INT			(CLK_GP5_OFFSET + 0x04)
> +#define CLK_GP5_DIV_FRAC		(CLK_GP5_OFFSET + 0x08)
> +#define CLK_GP5_SEL			(CLK_GP5_OFFSET + 0x0c)
> +
> +#define CLK_SYS_RESUS_CTRL		0x0020c
> +
> +#define CLK_SLOW_SYS_RESUS_CTRL		0x00214
> +
> +#define FC0_OFFSET			0x0021c
> +#define FC0_REF_KHZ			(FC0_OFFSET + 0x00)
> +#define FC0_MIN_KHZ			(FC0_OFFSET + 0x04)
> +#define FC0_MAX_KHZ			(FC0_OFFSET + 0x08)
> +#define FC0_DELAY			(FC0_OFFSET + 0x0c)
> +#define FC0_INTERVAL			(FC0_OFFSET + 0x10)
> +#define FC0_SRC				(FC0_OFFSET + 0x14)
> +#define FC0_STATUS			(FC0_OFFSET + 0x18)
> +#define FC0_RESULT			(FC0_OFFSET + 0x1c)
> +#define FC_SIZE				0x20
> +#define FC_COUNT			8
> +#define FC_NUM(idx, off)		((idx) * 32 + (off))
> +
> +#define AUX_SEL				1
> +
> +#define VIDEO_CLOCKS_OFFSET		0x4000
> +#define VIDEO_CLK_VEC_CTRL		(VIDEO_CLOCKS_OFFSET + 0x0000)
> +#define VIDEO_CLK_VEC_DIV_INT		(VIDEO_CLOCKS_OFFSET + 0x0004)
> +#define VIDEO_CLK_VEC_SEL		(VIDEO_CLOCKS_OFFSET + 0x000c)
> +#define VIDEO_CLK_DPI_CTRL		(VIDEO_CLOCKS_OFFSET + 0x0010)
> +#define VIDEO_CLK_DPI_DIV_INT		(VIDEO_CLOCKS_OFFSET + 0x0014)
> +#define VIDEO_CLK_DPI_SEL		(VIDEO_CLOCKS_OFFSET + 0x001c)
> +#define VIDEO_CLK_MIPI0_DPI_CTRL	(VIDEO_CLOCKS_OFFSET + 0x0020)
> +#define VIDEO_CLK_MIPI0_DPI_DIV_INT	(VIDEO_CLOCKS_OFFSET + 0x0024)
> +#define VIDEO_CLK_MIPI0_DPI_DIV_FRAC	(VIDEO_CLOCKS_OFFSET + 0x0028)
> +#define VIDEO_CLK_MIPI0_DPI_SEL		(VIDEO_CLOCKS_OFFSET + 0x002c)
> +#define VIDEO_CLK_MIPI1_DPI_CTRL	(VIDEO_CLOCKS_OFFSET + 0x0030)
> +#define VIDEO_CLK_MIPI1_DPI_DIV_INT	(VIDEO_CLOCKS_OFFSET + 0x0034)
> +#define VIDEO_CLK_MIPI1_DPI_DIV_FRAC	(VIDEO_CLOCKS_OFFSET + 0x0038)
> +#define VIDEO_CLK_MIPI1_DPI_SEL		(VIDEO_CLOCKS_OFFSET + 0x003c)
> +
> +#define DIV_INT_8BIT_MAX		GENMASK(7, 0)	/* max divide for most clocks *=
/
> +#define DIV_INT_16BIT_MAX		GENMASK(15, 0)	/* max divide for GPx, PWM */
> +#define DIV_INT_24BIT_MAX               GENMASK(23, 0)	/* max divide fo=
r CLK_SYS */
> +
> +#define FC0_STATUS_DONE			BIT(4)
> +#define FC0_STATUS_RUNNING		BIT(8)
> +#define FC0_RESULT_FRAC_SHIFT		5
> +
> +#define PLL_PRIM_DIV1_MASK		GENMASK(18, 16)
> +#define PLL_PRIM_DIV2_MASK		GENMASK(14, 12)
> +
> +#define PLL_SEC_DIV_MASK		GENMASK(12, 8)
> +
> +#define PLL_CS_LOCK			BIT(31)
> +#define PLL_CS_REFDIV_MASK		BIT(1)
> +
> +#define PLL_PWR_PD			BIT(0)
> +#define PLL_PWR_DACPD			BIT(1)
> +#define PLL_PWR_DSMPD			BIT(2)
> +#define PLL_PWR_POSTDIVPD		BIT(3)
> +#define PLL_PWR_4PHASEPD		BIT(4)
> +#define PLL_PWR_VCOPD			BIT(5)
> +#define PLL_PWR_MASK			GENMASK(5, 0)
> +
> +#define PLL_SEC_RST			BIT(16)
> +#define PLL_SEC_IMPL			BIT(31)
> +
> +/* PLL phase output for both PRI and SEC */
> +#define PLL_PH_EN			BIT(4)
> +#define PLL_PH_PHASE_SHIFT		0
> +
> +#define RP1_PLL_PHASE_0			0
> +#define RP1_PLL_PHASE_90		1
> +#define RP1_PLL_PHASE_180		2
> +#define RP1_PLL_PHASE_270		3
> +
> +/* Clock fields for all clocks */
> +#define CLK_CTRL_ENABLE			BIT(11)
> +#define CLK_CTRL_AUXSRC_MASK		GENMASK(9, 5)
> +#define CLK_CTRL_SRC_SHIFT		0
> +#define CLK_DIV_FRAC_BITS		16
> +
> +#define LOCK_TIMEOUT_US			100000
> +#define LOCK_POLL_DELAY_US		5
> +
> +#define MAX_CLK_PARENTS			16
> +
> +/*
> + * Secondary PLL channel output divider table.
> + * Divider values range from 8 to 19.
> + * Invalid values default to 19
Maybe it's worth to add a short define for this invalid value?
> + */
> +static const struct clk_div_table pll_sec_div_table[] =3D {
> +	{ 0x00, 19 },
> +	{ 0x01, 19 },
> +	{ 0x02, 19 },
> +	{ 0x03, 19 },
> +	{ 0x04, 19 },
> +	{ 0x05, 19 },
> +	{ 0x06, 19 },
> +	{ 0x07, 19 },
> +	{ 0x08,  8 },
> +	{ 0x09,  9 },
> +	{ 0x0a, 10 },
> +	{ 0x0b, 11 },
> +	{ 0x0c, 12 },
> +	{ 0x0d, 13 },
> +	{ 0x0e, 14 },
> +	{ 0x0f, 15 },
> +	{ 0x10, 16 },
> +	{ 0x11, 17 },
> +	{ 0x12, 18 },
> +	{ 0x13, 19 },
> +	{ 0x14, 19 },
> +	{ 0x15, 19 },
> +	{ 0x16, 19 },
> +	{ 0x17, 19 },
> +	{ 0x18, 19 },
> +	{ 0x19, 19 },
> +	{ 0x1a, 19 },
> +	{ 0x1b, 19 },
> +	{ 0x1c, 19 },
> +	{ 0x1d, 19 },
> +	{ 0x1e, 19 },
> +	{ 0x1f, 19 },
> +	{ 0 }
> +};
> +
> +struct rp1_clockman {
> +	struct device *dev;
> +	void __iomem *regs;
> +	struct regmap *regmap;
> +	spinlock_t regs_lock; /* spinlock for all clocks */
> +
> +	/* Must be last */
> +	struct clk_hw_onecell_data onecell;
> +};
> +
> +struct rp1_pll_core_data {
> +	u32 cs_reg;
> +	u32 pwr_reg;
> +	u32 fbdiv_int_reg;
> +	u32 fbdiv_frac_reg;
> +	u32 fc0_src;
> +};
> +
> +struct rp1_pll_data {
> +	u32 ctrl_reg;
> +	u32 fc0_src;
> +};
> +
> +struct rp1_pll_ph_data {
> +	unsigned int phase;
> +	unsigned int fixed_divider;
> +	u32 ph_reg;
> +	u32 fc0_src;
> +};
> +
> +struct rp1_pll_divider_data {
> +	u32 sec_reg;
> +	u32 fc0_src;
> +};
> +
> +struct rp1_clock_data {
> +	int num_std_parents;
> +	int num_aux_parents;
> +	u32 oe_mask;
> +	u32 clk_src_mask;
> +	u32 ctrl_reg;
> +	u32 div_int_reg;
> +	u32 div_frac_reg;
> +	u32 sel_reg;
> +	u32 div_int_max;
> +	unsigned long max_freq;
> +	u32 fc0_src;
> +};
> +
> +struct rp1_clk_desc {
> +	struct clk_hw *(*clk_register)(struct rp1_clockman *clockman,
> +				       struct rp1_clk_desc *desc);
> +	const void *data;
> +	struct clk_hw hw;
> +	struct rp1_clockman *clockman;
> +	unsigned long cached_rate;
> +	struct clk_divider div;
> +};
> +
> +static inline
> +void clockman_write(struct rp1_clockman *clockman, u32 reg, u32 val)
> +{
> +	regmap_write(clockman->regmap, reg, val);
> +}
> +
> +static inline u32 clockman_read(struct rp1_clockman *clockman, u32 reg)
> +{
> +	u32 val;
> +
> +	regmap_read(clockman->regmap, reg, &val);
> +
> +	return val;
> +}
> +
> +static int rp1_pll_core_is_on(struct clk_hw *hw)
> +{
> +	struct rp1_clk_desc *pll_core =3D container_of(hw, struct rp1_clk_desc=
, hw);
> +	struct rp1_clockman *clockman =3D pll_core->clockman;
> +	const struct rp1_pll_core_data *data =3D pll_core->data;
> +
Please drop this empty line
> +	u32 pwr =3D clockman_read(clockman, data->pwr_reg);
> +
> +	return (pwr & PLL_PWR_PD) || (pwr & PLL_PWR_POSTDIVPD);
> +}
> +
> +static int rp1_pll_core_on(struct clk_hw *hw)
> +{
> +	struct rp1_clk_desc *pll_core =3D container_of(hw, struct rp1_clk_desc=
, hw);
> +	struct rp1_clockman *clockman =3D pll_core->clockman;
> +	const struct rp1_pll_core_data *data =3D pll_core->data;
> +
ditto
> +	u32 fbdiv_frac, val;
> +	int ret;
> +
> +	spin_lock(&clockman->regs_lock);
> +
> +	if (!(clockman_read(clockman, data->cs_reg) & PLL_CS_LOCK)) {
> +		/* Reset to a known state. */
> +		clockman_write(clockman, data->pwr_reg, PLL_PWR_MASK);
> +		clockman_write(clockman, data->fbdiv_int_reg, 20);
> +		clockman_write(clockman, data->fbdiv_frac_reg, 0);
> +		clockman_write(clockman, data->cs_reg, PLL_CS_REFDIV_MASK);
> +	}
> +
> +	/* Come out of reset. */
> +	fbdiv_frac =3D clockman_read(clockman, data->fbdiv_frac_reg);
> +	clockman_write(clockman, data->pwr_reg, fbdiv_frac ? 0 : PLL_PWR_DSMPD=
);
> +	spin_unlock(&clockman->regs_lock);
> +
> +	/* Wait for the PLL to lock. */
> +	ret =3D regmap_read_poll_timeout(clockman->regmap, data->cs_reg, val,
> +				       val & PLL_CS_LOCK,
> +				       LOCK_POLL_DELAY_US, LOCK_TIMEOUT_US);
> +	if (ret)
> +		dev_err(clockman->dev, "%s: can't lock PLL\n",
> +			clk_hw_get_name(hw));
> +
> +	return ret;
> +}
> +
> +static void rp1_pll_core_off(struct clk_hw *hw)
> +{
> +	struct rp1_clk_desc *pll_core =3D container_of(hw, struct rp1_clk_desc=
, hw);
> +	struct rp1_clockman *clockman =3D pll_core->clockman;
> +	const struct rp1_pll_core_data *data =3D pll_core->data;
> +
> +	spin_lock(&clockman->regs_lock);
> +	clockman_write(clockman, data->pwr_reg, 0);
> +	spin_unlock(&clockman->regs_lock);
> +}
> +
> +static inline unsigned long get_pll_core_divider(struct clk_hw *hw,
> +						 unsigned long rate,
> +						 unsigned long parent_rate,
> +						 u32 *div_int, u32 *div_frac)
> +{
> +	u32 fbdiv_int, fbdiv_frac;
> +	unsigned long calc_rate;
> +	u64 shifted_fbdiv_int;
> +	u64 div_fp64; /* 32.32 fixed point fraction. */
> +
> +	/* Factor of reference clock to VCO frequency. */
> +	div_fp64 =3D (u64)(rate) << 32;
> +	div_fp64 =3D DIV_ROUND_CLOSEST_ULL(div_fp64, parent_rate);
> +
> +	/* Round the fractional component at 24 bits. */
> +	div_fp64 +=3D 1 << (32 - 24 - 1);
> +
> +	fbdiv_int =3D div_fp64 >> 32;
> +	fbdiv_frac =3D (div_fp64 >> (32 - 24)) & 0xffffff;
> +
> +	shifted_fbdiv_int =3D (u64)fbdiv_int << 24;
> +	calc_rate =3D (u64)parent_rate * (shifted_fbdiv_int + fbdiv_frac);
> +	calc_rate +=3D BIT(23);
> +	calc_rate >>=3D 24;
> +
> +	*div_int =3D fbdiv_int;
> +	*div_frac =3D fbdiv_frac;
> +
> +	return calc_rate;
> +}
> +
> +static int rp1_pll_core_set_rate(struct clk_hw *hw,
> +				 unsigned long rate, unsigned long parent_rate)
> +{
> +	struct rp1_clk_desc *pll_core =3D container_of(hw, struct rp1_clk_desc=
, hw);
> +	struct rp1_clockman *clockman =3D pll_core->clockman;
> +	const struct rp1_pll_core_data *data =3D pll_core->data;
> +
> +	unsigned long calc_rate;
> +	u32 fbdiv_int, fbdiv_frac;
> +
> +	/* Disable dividers to start with. */
> +	spin_lock(&clockman->regs_lock);
> +	clockman_write(clockman, data->fbdiv_int_reg, 0);
> +	clockman_write(clockman, data->fbdiv_frac_reg, 0);
> +	spin_unlock(&clockman->regs_lock);
> +
> +	calc_rate =3D get_pll_core_divider(hw, rate, parent_rate,
> +					 &fbdiv_int, &fbdiv_frac);
> +
> +	spin_lock(&clockman->regs_lock);
> +	clockman_write(clockman, data->pwr_reg, fbdiv_frac ? 0 : PLL_PWR_DSMPD=
);
> +	clockman_write(clockman, data->fbdiv_int_reg, fbdiv_int);
> +	clockman_write(clockman, data->fbdiv_frac_reg, fbdiv_frac);
> +	spin_unlock(&clockman->regs_lock);
> +
> +	/* Check that reference frequency is no greater than VCO / 16. */
> +	if (WARN_ON_ONCE(parent_rate > (rate / 16)))
> +		return -ERANGE;
> +
> +	pll_core->cached_rate =3D calc_rate;
> +
> +	spin_lock(&clockman->regs_lock);
> +	/* Don't need to divide ref unless parent_rate > (output freq / 16) */
> +	clockman_write(clockman, data->cs_reg,
> +		       clockman_read(clockman, data->cs_reg) |
> +				     PLL_CS_REFDIV_MASK);
> +	spin_unlock(&clockman->regs_lock);
> +
> +	return 0;
> +}
> +
> +static unsigned long rp1_pll_core_recalc_rate(struct clk_hw *hw,
> +					      unsigned long parent_rate)
> +{
> +	struct rp1_clk_desc *pll_core =3D container_of(hw, struct rp1_clk_desc=
, hw);
> +	struct rp1_clockman *clockman =3D pll_core->clockman;
> +	const struct rp1_pll_core_data *data =3D pll_core->data;
> +
> +	u32 fbdiv_int, fbdiv_frac;
> +	unsigned long calc_rate;
> +	u64 shifted_fbdiv_int;
> +
> +	fbdiv_int =3D clockman_read(clockman, data->fbdiv_int_reg);
> +	fbdiv_frac =3D clockman_read(clockman, data->fbdiv_frac_reg);
> +
> +	shifted_fbdiv_int =3D (u64)fbdiv_int << 24;
> +	calc_rate =3D (u64)parent_rate * (shifted_fbdiv_int + fbdiv_frac);
> +	calc_rate +=3D BIT(23);
> +	calc_rate >>=3D 24;
> +
> +	return calc_rate;
> +}
> +
> +static long rp1_pll_core_round_rate(struct clk_hw *hw, unsigned long ra=
te,
> +				    unsigned long *parent_rate)
> +{
> +	u32 fbdiv_int, fbdiv_frac;
> +
> +	return get_pll_core_divider(hw, rate, *parent_rate,
> +				    &fbdiv_int, &fbdiv_frac);
> +}
> +
> +static void get_pll_prim_dividers(unsigned long rate, unsigned long par=
ent_rate,
> +				  u32 *divider1, u32 *divider2)
> +{
> +	unsigned int div1, div2;
> +	unsigned int best_div1 =3D 7, best_div2 =3D 7;
> +	unsigned long best_rate_diff =3D
> +		abs_diff(DIV_ROUND_CLOSEST(parent_rate, best_div1 * best_div2), rate)=
;
> +	unsigned long rate_diff, calc_rate;
> +
> +	for (div1 =3D 1; div1 <=3D 7; div1++) {
> +		for (div2 =3D 1; div2 <=3D div1; div2++) {
> +			calc_rate =3D DIV_ROUND_CLOSEST(parent_rate, div1 * div2);
> +			rate_diff =3D abs_diff(calc_rate, rate);
> +
> +			if (calc_rate =3D=3D rate) {
> +				best_div1 =3D div1;
> +				best_div2 =3D div2;
> +				goto done;
> +			} else if (rate_diff < best_rate_diff) {
> +				best_div1 =3D div1;
> +				best_div2 =3D div2;
> +				best_rate_diff =3D rate_diff;
> +			}
> +		}
> +	}
> +
> +done:
> +	*divider1 =3D best_div1;
> +	*divider2 =3D best_div2;
> +}
> +
> +static int rp1_pll_set_rate(struct clk_hw *hw,
> +			    unsigned long rate, unsigned long parent_rate)
> +{
> +	struct rp1_clk_desc *pll =3D container_of(hw, struct rp1_clk_desc, hw)=
;
> +	struct rp1_clockman *clockman =3D pll->clockman;
> +	const struct rp1_pll_data *data =3D pll->data;
> +
> +	u32 prim, prim_div1, prim_div2;
> +
> +	get_pll_prim_dividers(rate, parent_rate, &prim_div1, &prim_div2);
> +
> +	spin_lock(&clockman->regs_lock);
> +	prim =3D clockman_read(clockman, data->ctrl_reg);
> +	prim &=3D ~PLL_PRIM_DIV1_MASK;
> +	prim |=3D FIELD_PREP(PLL_PRIM_DIV1_MASK, prim_div1);
> +	prim &=3D ~PLL_PRIM_DIV2_MASK;
> +	prim |=3D FIELD_PREP(PLL_PRIM_DIV2_MASK, prim_div2);
> +	clockman_write(clockman, data->ctrl_reg, prim);
> +	spin_unlock(&clockman->regs_lock);
> +
> +	return 0;
> +}
> +
> +static unsigned long rp1_pll_recalc_rate(struct clk_hw *hw,
> +					 unsigned long parent_rate)
> +{
> +	struct rp1_clk_desc *pll =3D container_of(hw, struct rp1_clk_desc, hw)=
;
> +	struct rp1_clockman *clockman =3D pll->clockman;
> +	const struct rp1_pll_data *data =3D pll->data;
> +	u32 prim, prim_div1, prim_div2;
> +
> +	prim =3D clockman_read(clockman, data->ctrl_reg);
> +	prim_div1 =3D FIELD_GET(PLL_PRIM_DIV1_MASK, prim);
> +	prim_div2 =3D FIELD_GET(PLL_PRIM_DIV2_MASK, prim);
> +
> +	if (!prim_div1 || !prim_div2) {
> +		dev_err(clockman->dev, "%s: (%s) zero divider value\n",
> +			__func__, clk_hw_get_name(hw));
> +		return 0;
> +	}
> +
> +	return DIV_ROUND_CLOSEST(parent_rate, prim_div1 * prim_div2);
> +}
> +
> +static long rp1_pll_round_rate(struct clk_hw *hw, unsigned long rate,
> +			       unsigned long *parent_rate)
> +{
> +	u32 div1, div2;
> +
> +	get_pll_prim_dividers(rate, *parent_rate, &div1, &div2);
> +
> +	return DIV_ROUND_CLOSEST(*parent_rate, div1 * div2);
> +}
> +
> +static int rp1_pll_ph_is_on(struct clk_hw *hw)
> +{
> +	struct rp1_clk_desc *pll_ph =3D container_of(hw, struct rp1_clk_desc, =
hw);
> +	struct rp1_clockman *clockman =3D pll_ph->clockman;
> +	const struct rp1_pll_ph_data *data =3D pll_ph->data;
> +
> +	return !!(clockman_read(clockman, data->ph_reg) & PLL_PH_EN);
> +}
> +
> +static int rp1_pll_ph_on(struct clk_hw *hw)
> +{
> +	struct rp1_clk_desc *pll_ph =3D container_of(hw, struct rp1_clk_desc, =
hw);
> +	struct rp1_clockman *clockman =3D pll_ph->clockman;
> +	const struct rp1_pll_ph_data *data =3D pll_ph->data;
> +	u32 ph_reg;
> +
> +	/* TODO: ensure pri/sec is enabled! */
Please extend this TODO. Primary/secondary of what
> +	spin_lock(&clockman->regs_lock);
> +	ph_reg =3D clockman_read(clockman, data->ph_reg);
> +	ph_reg |=3D data->phase << PLL_PH_PHASE_SHIFT;
> +	ph_reg |=3D PLL_PH_EN;
> +	clockman_write(clockman, data->ph_reg, ph_reg);
> +	spin_unlock(&clockman->regs_lock);
> +
> +	return 0;
> +}
> +
> +static void rp1_pll_ph_off(struct clk_hw *hw)
> +{
> +	struct rp1_clk_desc *pll_ph =3D container_of(hw, struct rp1_clk_desc, =
hw);
> +	struct rp1_clockman *clockman =3D pll_ph->clockman;
> +	const struct rp1_pll_ph_data *data =3D pll_ph->data;
> +
> +	spin_lock(&clockman->regs_lock);
> +	clockman_write(clockman, data->ph_reg,
> +		       clockman_read(clockman, data->ph_reg) & ~PLL_PH_EN);
> +	spin_unlock(&clockman->regs_lock);
> +}
> +
> +static unsigned long rp1_pll_ph_recalc_rate(struct clk_hw *hw,
> +					    unsigned long parent_rate)
> +{
> +	struct rp1_clk_desc *pll_ph =3D container_of(hw, struct rp1_clk_desc, =
hw);
> +	const struct rp1_pll_ph_data *data =3D pll_ph->data;
> +
> +	return parent_rate / data->fixed_divider;
> +}
> +
> +static long rp1_pll_ph_round_rate(struct clk_hw *hw, unsigned long rate=
,
> +				  unsigned long *parent_rate)
> +{
> +	struct rp1_clk_desc *pll_ph =3D container_of(hw, struct rp1_clk_desc, =
hw);
> +	const struct rp1_pll_ph_data *data =3D pll_ph->data;
> +
> +	return *parent_rate / data->fixed_divider;
> +}
> +
> +static int rp1_pll_divider_is_on(struct clk_hw *hw)
> +{
> +	struct rp1_clk_desc *divider =3D container_of(hw, struct rp1_clk_desc,=
 div.hw);
> +	struct rp1_clockman *clockman =3D divider->clockman;
> +	const struct rp1_pll_data *data =3D divider->data;
> +
> +	return !(clockman_read(clockman, data->ctrl_reg) & PLL_SEC_RST);
> +}
> +
> +static int rp1_pll_divider_on(struct clk_hw *hw)
> +{
> +	struct rp1_clk_desc *divider =3D container_of(hw, struct rp1_clk_desc,=
 div.hw);
> +	struct rp1_clockman *clockman =3D divider->clockman;
> +	const struct rp1_pll_data *data =3D divider->data;
> +
> +	spin_lock(&clockman->regs_lock);
> +	/* Check the implementation bit is set! */
> +	WARN_ON(!(clockman_read(clockman, data->ctrl_reg) & PLL_SEC_IMPL));
> +	clockman_write(clockman, data->ctrl_reg,
> +		       clockman_read(clockman, data->ctrl_reg) & ~PLL_SEC_RST);
> +	spin_unlock(&clockman->regs_lock);
> +
> +	return 0;
> +}
> +
> +static void rp1_pll_divider_off(struct clk_hw *hw)
> +{
> +	struct rp1_clk_desc *divider =3D container_of(hw, struct rp1_clk_desc,=
 div.hw);
> +	struct rp1_clockman *clockman =3D divider->clockman;
> +	const struct rp1_pll_data *data =3D divider->data;
> +
> +	spin_lock(&clockman->regs_lock);
> +	clockman_write(clockman, data->ctrl_reg,
> +		       clockman_read(clockman, data->ctrl_reg) | PLL_SEC_RST);
> +	spin_unlock(&clockman->regs_lock);
> +}
> +
> +static int rp1_pll_divider_set_rate(struct clk_hw *hw,
> +				    unsigned long rate,
> +				    unsigned long parent_rate)
> +{
> +	struct rp1_clk_desc *divider =3D container_of(hw, struct rp1_clk_desc,=
 div.hw);
> +	struct rp1_clockman *clockman =3D divider->clockman;
> +	const struct rp1_pll_data *data =3D divider->data;
> +	u32 div, sec;
> +
> +	div =3D DIV_ROUND_UP_ULL(parent_rate, rate);
> +	div =3D clamp(div, 8u, 19u);
> +
> +	spin_lock(&clockman->regs_lock);
> +	sec =3D clockman_read(clockman, data->ctrl_reg);
> +	sec &=3D ~PLL_SEC_DIV_MASK;
> +	sec |=3D FIELD_PREP(PLL_SEC_DIV_MASK, div);
> +
> +	/* Must keep the divider in reset to change the value. */
> +	sec |=3D PLL_SEC_RST;
> +	clockman_write(clockman, data->ctrl_reg, sec);
> +
> +	/* TODO: must sleep 10 pll vco cycles */
> +	sec &=3D ~PLL_SEC_RST;
> +	clockman_write(clockman, data->ctrl_reg, sec);
> +	spin_unlock(&clockman->regs_lock);
> +
> +	return 0;
> +}
> +
> +static unsigned long rp1_pll_divider_recalc_rate(struct clk_hw *hw,
> +						 unsigned long parent_rate)
> +{
> +	return clk_divider_ops.recalc_rate(hw, parent_rate);
> +}
> +
> +static long rp1_pll_divider_round_rate(struct clk_hw *hw,
> +				       unsigned long rate,
> +				       unsigned long *parent_rate)
> +{
> +	return clk_divider_ops.round_rate(hw, rate, parent_rate);
> +}
> +
> +static int rp1_clock_is_on(struct clk_hw *hw)
> +{
> +	struct rp1_clk_desc *clock =3D container_of(hw, struct rp1_clk_desc, h=
w);
> +	struct rp1_clockman *clockman =3D clock->clockman;
> +	const struct rp1_clock_data *data =3D clock->data;
> +
> +	return !!(clockman_read(clockman, data->ctrl_reg) & CLK_CTRL_ENABLE);
> +}
> +
> +static unsigned long rp1_clock_recalc_rate(struct clk_hw *hw,
> +					   unsigned long parent_rate)
> +{
> +	struct rp1_clk_desc *clock =3D container_of(hw, struct rp1_clk_desc, h=
w);
> +	struct rp1_clockman *clockman =3D clock->clockman;
> +	const struct rp1_clock_data *data =3D clock->data;
> +	u64 calc_rate;
> +	u64 div;
> +
Please drop empty line
> +	u32 frac;
> +
> +	div =3D clockman_read(clockman, data->div_int_reg);
> +	frac =3D (data->div_frac_reg !=3D 0) ?
> +		clockman_read(clockman, data->div_frac_reg) : 0;
> +
> +	/* If the integer portion of the divider is 0, treat it as 2^16 */
> +	if (!div)
> +		div =3D 1 << 16;
> +
> +	div =3D (div << CLK_DIV_FRAC_BITS) | (frac >> (32 - CLK_DIV_FRAC_BITS)=
);
> +
> +	calc_rate =3D (u64)parent_rate << CLK_DIV_FRAC_BITS;
> +	calc_rate =3D div64_u64(calc_rate, div);
> +
> +	return calc_rate;
> +}
> +
> +static int rp1_clock_on(struct clk_hw *hw)
> +{
> +	struct rp1_clk_desc *clock =3D container_of(hw, struct rp1_clk_desc, h=
w);
> +	struct rp1_clockman *clockman =3D clock->clockman;
> +	const struct rp1_clock_data *data =3D clock->data;
> +
> +	spin_lock(&clockman->regs_lock);
> +	clockman_write(clockman, data->ctrl_reg,
> +		       clockman_read(clockman, data->ctrl_reg) | CLK_CTRL_ENABLE);
> +	/* If this is a GPCLK, turn on the output-enable */
> +	if (data->oe_mask)
> +		clockman_write(clockman, GPCLK_OE_CTRL,
> +			       clockman_read(clockman, GPCLK_OE_CTRL) | data->oe_mask);
> +	spin_unlock(&clockman->regs_lock);
> +
> +	return 0;
> +}
> +
> +static void rp1_clock_off(struct clk_hw *hw)
> +{
> +	struct rp1_clk_desc *clock =3D container_of(hw, struct rp1_clk_desc, h=
w);
> +	struct rp1_clockman *clockman =3D clock->clockman;
> +	const struct rp1_clock_data *data =3D clock->data;
> +
> +	spin_lock(&clockman->regs_lock);
> +	clockman_write(clockman, data->ctrl_reg,
> +		       clockman_read(clockman, data->ctrl_reg) & ~CLK_CTRL_ENABLE);
> +	/* If this is a GPCLK, turn off the output-enable */
> +	if (data->oe_mask)
> +		clockman_write(clockman, GPCLK_OE_CTRL,
> +			       clockman_read(clockman, GPCLK_OE_CTRL) & ~data->oe_mask);
> +	spin_unlock(&clockman->regs_lock);
> +}
> +
> +static u32 rp1_clock_choose_div(unsigned long rate, unsigned long paren=
t_rate,
> +				const struct rp1_clock_data *data)
> +{
> +	u64 div;
> +
> +	/*
> +	 * Due to earlier rounding, calculated parent_rate may differ from
> +	 * expected value. Don't fail on a small discrepancy near unity divide=
.
> +	 */
> +	if (!rate || rate > parent_rate + (parent_rate >> CLK_DIV_FRAC_BITS))
> +		return 0;
> +
> +	/*
> +	 * Always express div in fixed-point format for fractional division;
> +	 * If no fractional divider is present, the fraction part will be zero=
.
> +	 */
> +	if (data->div_frac_reg) {
> +		div =3D (u64)parent_rate << CLK_DIV_FRAC_BITS;
> +		div =3D DIV_ROUND_CLOSEST_ULL(div, rate);
> +	} else {
> +		div =3D DIV_ROUND_CLOSEST_ULL(parent_rate, rate);
> +		div <<=3D CLK_DIV_FRAC_BITS;
> +	}
> +
> +	div =3D clamp(div,
> +		    1ull << CLK_DIV_FRAC_BITS,
> +		    (u64)data->div_int_max << CLK_DIV_FRAC_BITS);
> +
> +	return div;
> +}
> +
> +static u8 rp1_clock_get_parent(struct clk_hw *hw)
> +{
> +	struct rp1_clk_desc *clock =3D container_of(hw, struct rp1_clk_desc, h=
w);
> +	struct rp1_clockman *clockman =3D clock->clockman;
> +	const struct rp1_clock_data *data =3D clock->data;
> +	u32 sel, ctrl;
> +	u8 parent;
> +
> +	/* Sel is one-hot, so find the first bit set */
> +	sel =3D clockman_read(clockman, data->sel_reg);
> +	parent =3D ffs(sel) - 1;
> +
> +	/* sel =3D=3D 0 implies the parent clock is not enabled yet. */
> +	if (!sel) {
> +		/* Read the clock src from the CTRL register instead */
> +		ctrl =3D clockman_read(clockman, data->ctrl_reg);
> +		parent =3D (ctrl & data->clk_src_mask) >> CLK_CTRL_SRC_SHIFT;
> +	}
> +
> +	if (parent >=3D data->num_std_parents)
> +		parent =3D AUX_SEL;
> +
> +	if (parent =3D=3D AUX_SEL) {
> +		/*
> +		 * Clock parent is an auxiliary source, so get the parent from
> +		 * the AUXSRC register field.
> +		 */
> +		ctrl =3D clockman_read(clockman, data->ctrl_reg);
> +		parent =3D FIELD_GET(CLK_CTRL_AUXSRC_MASK, ctrl);
> +		parent +=3D data->num_std_parents;
> +	}
> +
> +	return parent;
> +}
> +
> +static int rp1_clock_set_parent(struct clk_hw *hw, u8 index)
> +{
> +	struct rp1_clk_desc *clock =3D container_of(hw, struct rp1_clk_desc, h=
w);
> +	struct rp1_clockman *clockman =3D clock->clockman;
> +	const struct rp1_clock_data *data =3D clock->data;
> +	u32 ctrl, sel;
> +
> +	spin_lock(&clockman->regs_lock);
> +	ctrl =3D clockman_read(clockman, data->ctrl_reg);
> +
> +	if (index >=3D data->num_std_parents) {
> +		/* This is an aux source request */
> +		if (index >=3D data->num_std_parents + data->num_aux_parents) {
> +			spin_unlock(&clockman->regs_lock);
> +			return -EINVAL;
> +		}
> +
> +		/* Select parent from aux list */
> +		ctrl &=3D ~CLK_CTRL_AUXSRC_MASK;
> +		ctrl |=3D FIELD_PREP(CLK_CTRL_AUXSRC_MASK, index - data->num_std_pare=
nts);
> +		/* Set src to aux list */
> +		ctrl &=3D ~data->clk_src_mask;
> +		ctrl |=3D (AUX_SEL << CLK_CTRL_SRC_SHIFT) & data->clk_src_mask;
> +	} else {
> +		ctrl &=3D ~data->clk_src_mask;
> +		ctrl |=3D (index << CLK_CTRL_SRC_SHIFT) & data->clk_src_mask;
> +	}
> +
> +	clockman_write(clockman, data->ctrl_reg, ctrl);
> +	spin_unlock(&clockman->regs_lock);
> +
> +	sel =3D rp1_clock_get_parent(hw);
> +	WARN(sel !=3D index, "(%s): Parent index req %u returned back %u\n",
> +	     clk_hw_get_name(hw), index, sel);
I don't think such an important clock callback should emit WARN(),
because this might cause a message flood.

So i think either a WARN_ONCE() or dev_warn_once() might be better.
> +
> +	return 0;
> +}
> +
> +static int rp1_clock_set_rate_and_parent(struct clk_hw *hw,
> +					 unsigned long rate,
> +					 unsigned long parent_rate,
> +					 u8 parent)
> +{
> +	struct rp1_clk_desc *clock =3D container_of(hw, struct rp1_clk_desc, h=
w);
> +	struct rp1_clockman *clockman =3D clock->clockman;
> +	const struct rp1_clock_data *data =3D clock->data;
> +	u32 div =3D rp1_clock_choose_div(rate, parent_rate, data);
> +
> +	WARN(rate > 4000000000ll, "rate is -ve (%d)\n", (int)rate);
This looks suspicious. Is this is a limit? Except of this, casting to
int is wrong.

In case this is not possible please make it a WARN_ONCE() or dev_warn_once=
()
> +
> +	if (WARN(!div,
> +		 "clk divider calculated as 0! (%s, rate %ld, parent rate %ld)\n",
> +		 clk_hw_get_name(hw), rate, parent_rate))
> +		div =3D 1 << CLK_DIV_FRAC_BITS;
Same here
> +
> +	spin_lock(&clockman->regs_lock);
> +
> +	clockman_write(clockman, data->div_int_reg, div >> CLK_DIV_FRAC_BITS);
> +	if (data->div_frac_reg)
> +		clockman_write(clockman, data->div_frac_reg, div << (32 - CLK_DIV_FRA=
C_BITS));
> +
> +	spin_unlock(&clockman->regs_lock);
> +
> +	if (parent !=3D 0xff)
> +		rp1_clock_set_parent(hw, parent);
> +
> +	return 0;
> +}
> +
>

