Return-Path: <linux-pci+bounces-14111-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A7A99783A
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 00:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D768B283E72
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 22:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333051E32C8;
	Wed,  9 Oct 2024 22:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ff0d7Se+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37E61E32B1;
	Wed,  9 Oct 2024 22:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728511699; cv=none; b=D7xrHeToau12wpRbCY+aJKm0h6TgxEuHAm8wrCm16DO/m3kD6fD6Tv1UfhONOk06okMo6eKhy2lFWZrT/oY7VaWUDSREtGF7SdHMmzgaxNaJp56rlMmQN1P/QUH7xDCLqpzAsiMTJs+6o2x4NG3jTYdxfL99G/cjtm1rh5hoQCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728511699; c=relaxed/simple;
	bh=PEaTkfH+xslIWdqIqUfPTEaQuLORTbT+d4S6+gLRlfQ=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:To:Date; b=LmkhwMSnkr9oZSQZ9rSbzSYICz0Wj0bvpTmiNhrUApd26dLMyOfyfJzVFVKYuxXOFSf+Vl6wZsZBe1snqEUR1mbwpY0ch/x2xWNfU8ak4VNnp3UFjw0I0I9iBMcLvvEx/VDLlbUnrhpiUQ1DY/lYE0VboML7hGMsigFxsODaNRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ff0d7Se+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61BD4C4CEC3;
	Wed,  9 Oct 2024 22:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728511698;
	bh=PEaTkfH+xslIWdqIqUfPTEaQuLORTbT+d4S6+gLRlfQ=;
	h=In-Reply-To:References:Subject:From:To:Date:From;
	b=ff0d7Se+XnrLsEgWht0udGu3s7GxDnSXfQ8vrGBMBYuD2a5xnlGl6tcBveOTAyld6
	 UsEz+cA6RsvyUS/qzN2YzxR3JSQH7gDL7IN93MGkfl9gfVT9KLcpe8WNedx3DzdNdf
	 wPKU7kcQQl3/1VkTqY6lPVaOyPtAAZBpoTfu196PO+SZLAXNjVzp1tSPEbUaxpAsP3
	 /jGNZBhVPRFLRjBi25ro4JCIAhJw4iacY/RSXiWXM4kmAkXIoSIcMGP+DFhzqq8BJm
	 SC5Au17ktrpDM6Gf8RGQO3S4lHv3HeKuUA55THumPFA6JAeG4VF6O4uqYEXWYFS5+A
	 WgvjkusG0EOCA==
Message-ID: <611de50b5f083ea4c260f920ccc0e300.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <022cf4920f8147cc720eaf02fd52c0fa56f565c5.1728300189.git.andrea.porta@suse.com>
References: <cover.1728300189.git.andrea.porta@suse.com> <022cf4920f8147cc720eaf02fd52c0fa56f565c5.1728300189.git.andrea.porta@suse.com>
Subject: Re: [PATCH v2 08/14] clk: rp1: Add support for clocks provided by RP1
From: Stephen Boyd <sboyd@kernel.org>
To: Andrea della Porta <andrea.porta@suse.com>, Andrew Lunn <andrew@lunn.ch>, Arnd Bergmann <arnd@arndb.de>, Bartosz Golaszewski <brgl@bgdev.pl>, Bjorn Helgaas <bhelgaas@google.com>, Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Catalin Marinas <catalin.marinas@arm.com>, Conor Dooley <conor+dt@kernel.org>, Derek Kiernan <derek.kiernan@amd.com>, Dragan Cvetic <dragan.cvetic@amd.com>, Florian Fainelli <florian.fainelli@broadcom.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Herve Codina <herve.codina@bootlin.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Krzysztof =?utf-8?q?Wilczy=C5=84ski?= <kw@linux.com>, Linus Walleij <linus.walleij@linaro.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, Luca Ceresoli <luca.ceresoli@bootlin.com>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Masahiro Yamada <masahiroy@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, St
 efan Wahren <wahrenst@gmx.net>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Will Deacon <will@kernel.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-rpi-kernel@lists.infradead.org
Date: Wed, 09 Oct 2024 15:08:16 -0700
User-Agent: alot/0.10

Quoting Andrea della Porta (2024-10-07 05:39:51)
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index 299bc678ed1b..537019987f0c 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -88,6 +88,15 @@ config COMMON_CLK_RK808
>           These multi-function devices have two fixed-rate oscillators, c=
locked at 32KHz each.
>           Clkout1 is always on, Clkout2 can off by control register.
> =20
> +config COMMON_CLK_RP1
> +       tristate "Raspberry Pi RP1-based clock support"
> +       depends on PCI || COMPILE_TEST

A better limit would be some ARCH_* config.

> +       depends on COMMON_CLK

This is redundant as it's inside the 'if COMMON_CLK'. Please remove this
line.

> +       help
> +         Enable common clock framework support for Raspberry Pi RP1.
> +         This multi-function device has 3 main PLLs and several clock
> +         generators to drive the internal sub-peripherals.
> +
>  config COMMON_CLK_HI655X
>         tristate "Clock driver for Hi655x" if EXPERT
>         depends on (MFD_HI655X_PMIC || COMPILE_TEST)
> diff --git a/drivers/clk/clk-rp1.c b/drivers/clk/clk-rp1.c
> new file mode 100644
> index 000000000000..9016666fb27d
> --- /dev/null
> +++ b/drivers/clk/clk-rp1.c
> @@ -0,0 +1,1658 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2023 Raspberry Pi Ltd.
> + *
> + * Clock driver for RP1 PCIe multifunction chip.
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/clkdev.h>

Drop unused header.

> +#include <linux/clk.h>

Preferably this include isn't included.

> +#include <linux/debugfs.h>
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +#include <linux/math64.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>

What is this include for? Should probably be mod_devicetable.h?

> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +
> +#include <asm/div64.h>

Include math64.h instead?

> +
> +#include <dt-bindings/clock/raspberrypi,rp1-clocks.h>
> +
> +#define PLL_SYS_OFFSET                 0x08000
> +#define PLL_SYS_CS                     (PLL_SYS_OFFSET + 0x00)
> +#define PLL_SYS_PWR                    (PLL_SYS_OFFSET + 0x04)
> +#define PLL_SYS_FBDIV_INT              (PLL_SYS_OFFSET + 0x08)
> +#define PLL_SYS_FBDIV_FRAC             (PLL_SYS_OFFSET + 0x0c)
> +#define PLL_SYS_PRIM                   (PLL_SYS_OFFSET + 0x10)
> +#define PLL_SYS_SEC                    (PLL_SYS_OFFSET + 0x14)
> +
> +#define PLL_AUDIO_OFFSET               0x0c000
> +#define PLL_AUDIO_CS                   (PLL_AUDIO_OFFSET + 0x00)
> +#define PLL_AUDIO_PWR                  (PLL_AUDIO_OFFSET + 0x04)
> +#define PLL_AUDIO_FBDIV_INT            (PLL_AUDIO_OFFSET + 0x08)
> +#define PLL_AUDIO_FBDIV_FRAC           (PLL_AUDIO_OFFSET + 0x0c)
> +#define PLL_AUDIO_PRIM                 (PLL_AUDIO_OFFSET + 0x10)
> +#define PLL_AUDIO_SEC                  (PLL_AUDIO_OFFSET + 0x14)
> +#define PLL_AUDIO_TERN                 (PLL_AUDIO_OFFSET + 0x18)
> +
> +#define PLL_VIDEO_OFFSET               0x10000
> +#define PLL_VIDEO_CS                   (PLL_VIDEO_OFFSET + 0x00)
> +#define PLL_VIDEO_PWR                  (PLL_VIDEO_OFFSET + 0x04)
> +#define PLL_VIDEO_FBDIV_INT            (PLL_VIDEO_OFFSET + 0x08)
> +#define PLL_VIDEO_FBDIV_FRAC           (PLL_VIDEO_OFFSET + 0x0c)
> +#define PLL_VIDEO_PRIM                 (PLL_VIDEO_OFFSET + 0x10)
> +#define PLL_VIDEO_SEC                  (PLL_VIDEO_OFFSET + 0x14)
> +
> +#define GPCLK_OE_CTRL                  0x00000
> +
> +#define CLK_SYS_OFFSET                 0x00014
> +#define CLK_SYS_CTRL                   (CLK_SYS_OFFSET + 0x00)
> +#define CLK_SYS_DIV_INT                        (CLK_SYS_OFFSET + 0x04)
> +#define CLK_SYS_SEL                    (CLK_SYS_OFFSET + 0x0c)
> +
> +#define CLK_SLOW_OFFSET                        0x00024
> +#define CLK_SLOW_SYS_CTRL              (CLK_SLOW_OFFSET + 0x00)
> +#define CLK_SLOW_SYS_DIV_INT           (CLK_SLOW_OFFSET + 0x04)
> +#define CLK_SLOW_SYS_SEL               (CLK_SLOW_OFFSET + 0x0c)
> +
> +#define CLK_DMA_OFFSET                 0x00044
> +#define CLK_DMA_CTRL                   (CLK_DMA_OFFSET + 0x00)
> +#define CLK_DMA_DIV_INT                        (CLK_DMA_OFFSET + 0x04)
> +#define CLK_DMA_SEL                    (CLK_DMA_OFFSET + 0x0c)
> +
> +#define CLK_UART_OFFSET                        0x00054
> +#define CLK_UART_CTRL                  (CLK_UART_OFFSET + 0x00)
> +#define CLK_UART_DIV_INT               (CLK_UART_OFFSET + 0x04)
> +#define CLK_UART_SEL                   (CLK_UART_OFFSET + 0x0c)
> +
> +#define CLK_ETH_OFFSET                 0x00064
> +#define CLK_ETH_CTRL                   (CLK_ETH_OFFSET + 0x00)
> +#define CLK_ETH_DIV_INT                        (CLK_ETH_OFFSET + 0x04)
> +#define CLK_ETH_SEL                    (CLK_ETH_OFFSET + 0x0c)
> +
> +#define CLK_PWM0_OFFSET                        0x00074
> +#define CLK_PWM0_CTRL                  (CLK_PWM0_OFFSET + 0x00)
> +#define CLK_PWM0_DIV_INT               (CLK_PWM0_OFFSET + 0x04)
> +#define CLK_PWM0_DIV_FRAC              (CLK_PWM0_OFFSET + 0x08)
> +#define CLK_PWM0_SEL                   (CLK_PWM0_OFFSET + 0x0c)
> +
> +#define CLK_PWM1_OFFSET                        0x00084
> +#define CLK_PWM1_CTRL                  (CLK_PWM1_OFFSET + 0x00)
> +#define CLK_PWM1_DIV_INT               (CLK_PWM1_OFFSET + 0x04)
> +#define CLK_PWM1_DIV_FRAC              (CLK_PWM1_OFFSET + 0x08)
> +#define CLK_PWM1_SEL                   (CLK_PWM1_OFFSET + 0x0c)
> +
> +#define CLK_AUDIO_IN_OFFSET            0x00094
> +#define CLK_AUDIO_IN_CTRL              (CLK_AUDIO_IN_OFFSET + 0x00)
> +#define CLK_AUDIO_IN_DIV_INT           (CLK_AUDIO_IN_OFFSET + 0x04)
> +#define CLK_AUDIO_IN_SEL               (CLK_AUDIO_IN_OFFSET + 0x0c)
> +
> +#define CLK_AUDIO_OUT_OFFSET           0x000a4
> +#define CLK_AUDIO_OUT_CTRL             (CLK_AUDIO_OUT_OFFSET + 0x00)
> +#define CLK_AUDIO_OUT_DIV_INT          (CLK_AUDIO_OUT_OFFSET + 0x04)
> +#define CLK_AUDIO_OUT_SEL              (CLK_AUDIO_OUT_OFFSET + 0x0c)
> +
> +#define CLK_I2S_OFFSET                 0x000b4
> +#define CLK_I2S_CTRL                   (CLK_I2S_OFFSET + 0x00)
> +#define CLK_I2S_DIV_INT                        (CLK_I2S_OFFSET + 0x04)
> +#define CLK_I2S_SEL                    (CLK_I2S_OFFSET + 0x0c)
> +
> +#define CLK_MIPI0_CFG_OFFSET           0x000c4
> +#define CLK_MIPI0_CFG_CTRL             (CLK_MIPI0_CFG_OFFSET + 0x00)
> +#define CLK_MIPI0_CFG_DIV_INT          (CLK_MIPI0_CFG_OFFSET + 0x04)
> +#define CLK_MIPI0_CFG_SEL              (CLK_MIPI0_CFG_OFFSET + 0x0c)
> +
> +#define CLK_MIPI1_CFG_OFFSET           0x000d4
> +#define CLK_MIPI1_CFG_CTRL             (CLK_MIPI1_CFG_OFFSET + 0x00)
> +#define CLK_MIPI1_CFG_DIV_INT          (CLK_MIPI1_CFG_OFFSET + 0x04)
> +#define CLK_MIPI1_CFG_SEL              (CLK_MIPI1_CFG_OFFSET + 0x0c)
> +
> +#define CLK_PCIE_AUX_OFFSET            0x000e4
> +#define CLK_PCIE_AUX_CTRL              (CLK_PCIE_AUX_OFFSET + 0x00)
> +#define CLK_PCIE_AUX_DIV_INT           (CLK_PCIE_AUX_OFFSET + 0x04)
> +#define CLK_PCIE_AUX_SEL               (CLK_PCIE_AUX_OFFSET + 0x0c)
> +
> +#define CLK_USBH0_MICROFRAME_OFFSET    0x000f4
> +#define CLK_USBH0_MICROFRAME_CTRL      (CLK_USBH0_MICROFRAME_OFFSET + 0x=
00)
> +#define CLK_USBH0_MICROFRAME_DIV_INT   (CLK_USBH0_MICROFRAME_OFFSET + 0x=
04)
> +#define CLK_USBH0_MICROFRAME_SEL       (CLK_USBH0_MICROFRAME_OFFSET + 0x=
0c)
> +
> +#define CLK_USBH1_MICROFRAME_OFFSET    0x00104
> +#define CLK_USBH1_MICROFRAME_CTRL      (CLK_USBH1_MICROFRAME_OFFSET + 0x=
00)
> +#define CLK_USBH1_MICROFRAME_DIV_INT   (CLK_USBH1_MICROFRAME_OFFSET + 0x=
04)
> +#define CLK_USBH1_MICROFRAME_SEL       (CLK_USBH1_MICROFRAME_OFFSET + 0x=
0c)
> +
> +#define CLK_USBH0_SUSPEND_OFFSET       0x00114
> +#define CLK_USBH0_SUSPEND_CTRL         (CLK_USBH0_SUSPEND_OFFSET + 0x00)
> +#define CLK_USBH0_SUSPEND_DIV_INT      (CLK_USBH0_SUSPEND_OFFSET + 0x04)
> +#define CLK_USBH0_SUSPEND_SEL          (CLK_USBH0_SUSPEND_OFFSET + 0x0c)
> +
> +#define CLK_USBH1_SUSPEND_OFFSET       0x00124
> +#define CLK_USBH1_SUSPEND_CTRL         (CLK_USBH1_SUSPEND_OFFSET + 0x00)
> +#define CLK_USBH1_SUSPEND_DIV_INT      (CLK_USBH1_SUSPEND_OFFSET + 0x04)
> +#define CLK_USBH1_SUSPEND_SEL          (CLK_USBH1_SUSPEND_OFFSET + 0x0c)
> +
> +#define CLK_ETH_TSU_OFFSET             0x00134
> +#define CLK_ETH_TSU_CTRL               (CLK_ETH_TSU_OFFSET + 0x00)
> +#define CLK_ETH_TSU_DIV_INT            (CLK_ETH_TSU_OFFSET + 0x04)
> +#define CLK_ETH_TSU_SEL                        (CLK_ETH_TSU_OFFSET + 0x0=
c)
> +
> +#define CLK_ADC_OFFSET                 0x00144
> +#define CLK_ADC_CTRL                   (CLK_ADC_OFFSET + 0x00)
> +#define CLK_ADC_DIV_INT                        (CLK_ADC_OFFSET + 0x04)
> +#define CLK_ADC_SEL                    (CLK_ADC_OFFSET + 0x0c)
> +
> +#define CLK_SDIO_TIMER_OFFSET          0x00154
> +#define CLK_SDIO_TIMER_CTRL            (CLK_SDIO_TIMER_OFFSET + 0x00)
> +#define CLK_SDIO_TIMER_DIV_INT         (CLK_SDIO_TIMER_OFFSET + 0x04)
> +#define CLK_SDIO_TIMER_SEL             (CLK_SDIO_TIMER_OFFSET + 0x0c)
> +
> +#define CLK_SDIO_ALT_SRC_OFFSET                0x00164
> +#define CLK_SDIO_ALT_SRC_CTRL          (CLK_SDIO_ALT_SRC_OFFSET + 0x00)
> +#define CLK_SDIO_ALT_SRC_DIV_INT       (CLK_SDIO_ALT_SRC_OFFSET + 0x04)
> +#define CLK_SDIO_ALT_SRC_SEL           (CLK_SDIO_ALT_SRC_OFFSET + 0x0c)
> +
> +#define CLK_GP0_OFFSET                 0x00174
> +#define CLK_GP0_CTRL                   (CLK_GP0_OFFSET + 0x00)
> +#define CLK_GP0_DIV_INT                        (CLK_GP0_OFFSET + 0x04)
> +#define CLK_GP0_DIV_FRAC               (CLK_GP0_OFFSET + 0x08)
> +#define CLK_GP0_SEL                    (CLK_GP0_OFFSET + 0x0c)
> +
> +#define CLK_GP1_OFFSET                 0x00184
> +#define CLK_GP1_CTRL                   (CLK_GP1_OFFSET + 0x00)
> +#define CLK_GP1_DIV_INT                        (CLK_GP1_OFFSET + 0x04)
> +#define CLK_GP1_DIV_FRAC               (CLK_GP1_OFFSET + 0x08)
> +#define CLK_GP1_SEL                    (CLK_GP1_OFFSET + 0x0c)
> +
> +#define CLK_GP2_OFFSET                 0x00194
> +#define CLK_GP2_CTRL                   (CLK_GP2_OFFSET + 0x00)
> +#define CLK_GP2_DIV_INT                        (CLK_GP2_OFFSET + 0x04)
> +#define CLK_GP2_DIV_FRAC               (CLK_GP2_OFFSET + 0x08)
> +#define CLK_GP2_SEL                    (CLK_GP2_OFFSET + 0x0c)
> +
> +#define CLK_GP3_OFFSET                 0x001a4
> +#define CLK_GP3_CTRL                   (CLK_GP3_OFFSET + 0x00)
> +#define CLK_GP3_DIV_INT                        (CLK_GP3_OFFSET + 0x04)
> +#define CLK_GP3_DIV_FRAC               (CLK_GP3_OFFSET + 0x08)
> +#define CLK_GP3_SEL                    (CLK_GP3_OFFSET + 0x0c)
> +
> +#define CLK_GP4_OFFSET                 0x001b4
> +#define CLK_GP4_CTRL                   (CLK_GP4_OFFSET + 0x00)
> +#define CLK_GP4_DIV_INT                        (CLK_GP4_OFFSET + 0x04)
> +#define CLK_GP4_DIV_FRAC               (CLK_GP4_OFFSET + 0x08)
> +#define CLK_GP4_SEL                    (CLK_GP4_OFFSET + 0x0c)
> +
> +#define CLK_GP5_OFFSET                 0x001c4
> +#define CLK_GP5_CTRL                   (CLK_GP5_OFFSET + 0x00)
> +#define CLK_GP5_DIV_INT                        (CLK_GP5_OFFSET + 0x04)
> +#define CLK_GP5_DIV_FRAC               (CLK_GP5_OFFSET + 0x08)
> +#define CLK_GP5_SEL                    (CLK_GP5_OFFSET + 0x0c)
> +
> +#define CLK_SYS_RESUS_CTRL             0x0020c
> +
> +#define CLK_SLOW_SYS_RESUS_CTRL                0x00214
> +
> +#define FC0_OFFSET                     0x0021c
> +#define FC0_REF_KHZ                    (FC0_OFFSET + 0x00)
> +#define FC0_MIN_KHZ                    (FC0_OFFSET + 0x04)
> +#define FC0_MAX_KHZ                    (FC0_OFFSET + 0x08)
> +#define FC0_DELAY                      (FC0_OFFSET + 0x0c)
> +#define FC0_INTERVAL                   (FC0_OFFSET + 0x10)
> +#define FC0_SRC                                (FC0_OFFSET + 0x14)
> +#define FC0_STATUS                     (FC0_OFFSET + 0x18)
> +#define FC0_RESULT                     (FC0_OFFSET + 0x1c)
> +#define FC_SIZE                                0x20
> +#define FC_COUNT                       8
> +#define FC_NUM(idx, off)               ((idx) * 32 + (off))
> +
> +#define AUX_SEL                                1
> +
> +#define VIDEO_CLOCKS_OFFSET            0x4000
> +#define VIDEO_CLK_VEC_CTRL             (VIDEO_CLOCKS_OFFSET + 0x0000)
> +#define VIDEO_CLK_VEC_DIV_INT          (VIDEO_CLOCKS_OFFSET + 0x0004)
> +#define VIDEO_CLK_VEC_SEL              (VIDEO_CLOCKS_OFFSET + 0x000c)
> +#define VIDEO_CLK_DPI_CTRL             (VIDEO_CLOCKS_OFFSET + 0x0010)
> +#define VIDEO_CLK_DPI_DIV_INT          (VIDEO_CLOCKS_OFFSET + 0x0014)
> +#define VIDEO_CLK_DPI_SEL              (VIDEO_CLOCKS_OFFSET + 0x001c)
> +#define VIDEO_CLK_MIPI0_DPI_CTRL       (VIDEO_CLOCKS_OFFSET + 0x0020)
> +#define VIDEO_CLK_MIPI0_DPI_DIV_INT    (VIDEO_CLOCKS_OFFSET + 0x0024)
> +#define VIDEO_CLK_MIPI0_DPI_DIV_FRAC   (VIDEO_CLOCKS_OFFSET + 0x0028)
> +#define VIDEO_CLK_MIPI0_DPI_SEL                (VIDEO_CLOCKS_OFFSET + 0x=
002c)
> +#define VIDEO_CLK_MIPI1_DPI_CTRL       (VIDEO_CLOCKS_OFFSET + 0x0030)
> +#define VIDEO_CLK_MIPI1_DPI_DIV_INT    (VIDEO_CLOCKS_OFFSET + 0x0034)
> +#define VIDEO_CLK_MIPI1_DPI_DIV_FRAC   (VIDEO_CLOCKS_OFFSET + 0x0038)
> +#define VIDEO_CLK_MIPI1_DPI_SEL                (VIDEO_CLOCKS_OFFSET + 0x=
003c)
> +
> +#define DIV_INT_8BIT_MAX               GENMASK(7, 0)   /* max divide for=
 most clocks */
> +#define DIV_INT_16BIT_MAX              GENMASK(15, 0)  /* max divide for=
 GPx, PWM */
> +#define DIV_INT_24BIT_MAX               GENMASK(23, 0) /* max divide for=
 CLK_SYS */
> +
> +#define FC0_STATUS_DONE                        BIT(4)
> +#define FC0_STATUS_RUNNING             BIT(8)
> +#define FC0_RESULT_FRAC_SHIFT          5
> +
> +#define PLL_PRIM_DIV1_SHIFT            16
> +#define PLL_PRIM_DIV1_WIDTH            3
> +#define PLL_PRIM_DIV1_MASK             GENMASK(PLL_PRIM_DIV1_SHIFT + \
> +                                               PLL_PRIM_DIV1_WIDTH - 1, \
> +                                               PLL_PRIM_DIV1_SHIFT)
> +#define PLL_PRIM_DIV2_SHIFT            12
> +#define PLL_PRIM_DIV2_WIDTH            3
> +#define PLL_PRIM_DIV2_MASK             GENMASK(PLL_PRIM_DIV2_SHIFT + \
> +                                               PLL_PRIM_DIV2_WIDTH - 1, \
> +                                               PLL_PRIM_DIV2_SHIFT)
> +
> +#define PLL_SEC_DIV_SHIFT              8
> +#define PLL_SEC_DIV_WIDTH              5
> +#define PLL_SEC_DIV_MASK               GENMASK(PLL_SEC_DIV_SHIFT + \
> +                                               PLL_SEC_DIV_WIDTH - 1, \
> +                                               PLL_SEC_DIV_SHIFT)
> +
> +#define PLL_CS_LOCK                    BIT(31)
> +#define PLL_CS_REFDIV_SHIFT            0
> +
> +#define PLL_PWR_PD                     BIT(0)
> +#define PLL_PWR_DACPD                  BIT(1)
> +#define PLL_PWR_DSMPD                  BIT(2)
> +#define PLL_PWR_POSTDIVPD              BIT(3)
> +#define PLL_PWR_4PHASEPD               BIT(4)
> +#define PLL_PWR_VCOPD                  BIT(5)
> +#define PLL_PWR_MASK                   GENMASK(5, 0)
> +
> +#define PLL_SEC_RST                    BIT(16)
> +#define PLL_SEC_IMPL                   BIT(31)
> +
> +/* PLL phase output for both PRI and SEC */
> +#define PLL_PH_EN                      BIT(4)
> +#define PLL_PH_PHASE_SHIFT             0
> +
> +#define RP1_PLL_PHASE_0                        0
> +#define RP1_PLL_PHASE_90               1
> +#define RP1_PLL_PHASE_180              2
> +#define RP1_PLL_PHASE_270              3
> +
> +/* Clock fields for all clocks */
> +#define CLK_CTRL_ENABLE                        BIT(11)
> +#define CLK_CTRL_AUXSRC_SHIFT          5
> +#define CLK_CTRL_AUXSRC_WIDTH          5
> +#define CLK_CTRL_AUXSRC_MASK           GENMASK(CLK_CTRL_AUXSRC_SHIFT + \
> +                                               CLK_CTRL_AUXSRC_WIDTH - 1=
, \
> +                                               CLK_CTRL_AUXSRC_SHIFT)
> +#define CLK_CTRL_SRC_SHIFT             0
> +#define CLK_DIV_FRAC_BITS              16
> +
> +#define KHz                            1000
> +#define MHz                            (KHz * KHz)

I think we have these macros now. See include/linux/units.h.

> +#define LOCK_TIMEOUT_NS                        100000000
> +#define FC_TIMEOUT_NS                  100000000
> +
> +#define MAX_CLK_PARENTS                        16
> +
> +/*
> + * Secondary PLL channel output divider table.
> + * Divider values range from 8 to 19.
> + * Invalid values default to 19
> + */
> +static const struct clk_div_table pll_sec_div_table[] =3D {
> +       { 0x00, 19 },
> +       { 0x01, 19 },
> +       { 0x02, 19 },
> +       { 0x03, 19 },
> +       { 0x04, 19 },
> +       { 0x05, 19 },
> +       { 0x06, 19 },
> +       { 0x07, 19 },
> +       { 0x08,  8 },
> +       { 0x09,  9 },
> +       { 0x0a, 10 },
> +       { 0x0b, 11 },
> +       { 0x0c, 12 },
> +       { 0x0d, 13 },
> +       { 0x0e, 14 },
> +       { 0x0f, 15 },
> +       { 0x10, 16 },
> +       { 0x11, 17 },
> +       { 0x12, 18 },
> +       { 0x13, 19 },
> +       { 0x14, 19 },
> +       { 0x15, 19 },
> +       { 0x16, 19 },
> +       { 0x17, 19 },
> +       { 0x18, 19 },
> +       { 0x19, 19 },
> +       { 0x1a, 19 },
> +       { 0x1b, 19 },
> +       { 0x1c, 19 },
> +       { 0x1d, 19 },
> +       { 0x1e, 19 },
> +       { 0x1f, 19 },
> +       { 0 }
> +};
> +
> +struct rp1_clockman {
> +       struct device *dev;
> +       void __iomem *regs;
> +       spinlock_t regs_lock; /* spinlock for all clocks */
> +       struct clk_hw *hw_xosc; /* reference clock */
> +
> +       /* Must be last */
> +       struct clk_hw_onecell_data onecell;
> +};
> +
> +struct rp1_pll_core_data {
> +       const char *name;
> +       u32 cs_reg;
> +       u32 pwr_reg;
> +       u32 fbdiv_int_reg;
> +       u32 fbdiv_frac_reg;
> +       unsigned long flags;
> +       u32 fc0_src;
> +};
> +
> +struct rp1_pll_data {
> +       const char *name;
> +       const char *source_pll;
> +       u32 ctrl_reg;
> +       unsigned long flags;
> +       u32 fc0_src;
> +};
> +
> +struct rp1_pll_ph_data {
> +       const char *name;
> +       const char *source_pll;
> +       unsigned int phase;
> +       unsigned int fixed_divider;
> +       u32 ph_reg;
> +       unsigned long flags;
> +       u32 fc0_src;
> +};
> +
> +struct rp1_pll_divider_data {
> +       const char *name;
> +       const char *source_pll;
> +       u32 sec_reg;
> +       unsigned long flags;
> +       u32 fc0_src;
> +};
> +
> +struct rp1_clock_data {
> +       const char *name;
> +       const char *const parents[MAX_CLK_PARENTS];
> +       int num_std_parents;
> +       int num_aux_parents;
> +       unsigned long flags;
> +       u32 oe_mask;
> +       u32 clk_src_mask;
> +       u32 ctrl_reg;
> +       u32 div_int_reg;
> +       u32 div_frac_reg;
> +       u32 sel_reg;
> +       u32 div_int_max;
> +       unsigned long max_freq;
> +       u32 fc0_src;
> +};
> +
> +struct rp1_pll_core {
> +       struct clk_hw hw;
> +       struct rp1_clockman *clockman;
> +       unsigned long cached_rate;
> +       const struct rp1_pll_core_data *data;
> +};
> +
> +struct rp1_pll {
> +       struct clk_hw hw;
> +       struct rp1_clockman *clockman;
> +       struct clk_divider div;
> +       unsigned long cached_rate;
> +       const struct rp1_pll_data *data;
> +};
> +
> +struct rp1_pll_ph {
> +       struct clk_hw hw;
> +       struct rp1_clockman *clockman;
> +       const struct rp1_pll_ph_data *data;
> +};
> +
> +struct rp1_clock {
> +       struct clk_hw hw;
> +       struct rp1_clockman *clockman;
> +       unsigned long cached_rate;
> +       const struct rp1_clock_data *data;
> +};
> +
> +struct rp1_clk_change {
> +       struct clk_hw *hw;
> +       unsigned long new_rate;
> +};
> +
> +struct rp1_clk_desc {
> +       struct clk_hw *(*clk_register)(struct rp1_clockman *clockman,
> +                                      const void *data);
> +       const void *data;
> +};
> +
> +static void rp1_debugfs_regset(struct rp1_clockman *clockman, u32 base,
> +                              const struct debugfs_reg32 *regs,
> +                              size_t nregs, struct dentry *dentry)
> +{
> +       struct debugfs_regset32 *regset;
> +
> +       regset =3D devm_kzalloc(clockman->dev, sizeof(*regset), GFP_KERNE=
L);
> +       if (!regset)
> +               return;
> +
> +       regset->regs =3D regs;
> +       regset->nregs =3D nregs;
> +       regset->base =3D clockman->regs + base;
> +
> +       debugfs_create_regset32("regdump", 0444, dentry, regset);
> +}
> +
> +static inline u32 set_register_field(u32 reg, u32 val, u32 mask, u32 shi=
ft)
> +{
> +       reg &=3D ~mask;
> +       reg |=3D (val << shift) & mask;
> +       return reg;
> +}

Can you use FIELD_PREP() and friends?

> +
> +static inline
> +void clockman_write(struct rp1_clockman *clockman, u32 reg, u32 val)
> +{
> +       writel(val, clockman->regs + reg);
> +}
> +
> +static inline u32 clockman_read(struct rp1_clockman *clockman, u32 reg)
> +{
> +       return readl(clockman->regs + reg);
> +}
> +
> +static int rp1_pll_core_is_on(struct clk_hw *hw)
> +{
> +       struct rp1_pll_core *pll_core =3D container_of(hw, struct rp1_pll=
_core, hw);
> +       struct rp1_clockman *clockman =3D pll_core->clockman;
> +       const struct rp1_pll_core_data *data =3D pll_core->data;
> +       u32 pwr =3D clockman_read(clockman, data->pwr_reg);
> +
> +       return (pwr & PLL_PWR_PD) || (pwr & PLL_PWR_POSTDIVPD);
> +}
> +
> +static int rp1_pll_core_on(struct clk_hw *hw)
> +{
> +       struct rp1_pll_core *pll_core =3D container_of(hw, struct rp1_pll=
_core, hw);
> +       struct rp1_clockman *clockman =3D pll_core->clockman;
> +       const struct rp1_pll_core_data *data =3D pll_core->data;
> +       u32 fbdiv_frac;
> +       ktime_t timeout;
> +
> +       spin_lock(&clockman->regs_lock);
> +
> +       if (!(clockman_read(clockman, data->cs_reg) & PLL_CS_LOCK)) {
> +               /* Reset to a known state. */
> +               clockman_write(clockman, data->pwr_reg, PLL_PWR_MASK);
> +               clockman_write(clockman, data->fbdiv_int_reg, 20);
> +               clockman_write(clockman, data->fbdiv_frac_reg, 0);
> +               clockman_write(clockman, data->cs_reg, 1 << PLL_CS_REFDIV=
_SHIFT);
> +       }
> +
> +       /* Come out of reset. */
> +       fbdiv_frac =3D clockman_read(clockman, data->fbdiv_frac_reg);
> +       clockman_write(clockman, data->pwr_reg, fbdiv_frac ? 0 : PLL_PWR_=
DSMPD);
> +       spin_unlock(&clockman->regs_lock);
> +
> +       /* Wait for the PLL to lock. */
> +       timeout =3D ktime_add_ns(ktime_get(), LOCK_TIMEOUT_NS);
> +       while (!(clockman_read(clockman, data->cs_reg) & PLL_CS_LOCK)) {
> +               if (ktime_after(ktime_get(), timeout)) {
> +                       dev_err(clockman->dev, "%s: can't lock PLL\n",
> +                               clk_hw_get_name(hw));
> +                       return -ETIMEDOUT;
> +               }
> +               cpu_relax();
> +       }

Is this readl_poll_timeout()?

> +
> +       return 0;
> +}
> +
> +static void rp1_pll_core_off(struct clk_hw *hw)
> +{
> +       struct rp1_pll_core *pll_core =3D container_of(hw, struct rp1_pll=
_core, hw);
> +       struct rp1_clockman *clockman =3D pll_core->clockman;
> +       const struct rp1_pll_core_data *data =3D pll_core->data;
> +
> +       spin_lock(&clockman->regs_lock);
> +       clockman_write(clockman, data->pwr_reg, 0);
> +       spin_unlock(&clockman->regs_lock);
> +}
> +
> +static inline unsigned long get_pll_core_divider(struct clk_hw *hw,
> +                                                unsigned long rate,
> +                                                unsigned long parent_rat=
e,
> +                                                u32 *div_int, u32 *div_f=
rac)
> +{
> +       unsigned long calc_rate;
> +       u32 fbdiv_int, fbdiv_frac;
> +       u64 div_fp64; /* 32.32 fixed point fraction. */
> +
> +       /* Factor of reference clock to VCO frequency. */
> +       div_fp64 =3D (u64)(rate) << 32;
> +       div_fp64 =3D DIV_ROUND_CLOSEST_ULL(div_fp64, parent_rate);
> +
> +       /* Round the fractional component at 24 bits. */
> +       div_fp64 +=3D 1 << (32 - 24 - 1);
> +
> +       fbdiv_int =3D div_fp64 >> 32;
> +       fbdiv_frac =3D (div_fp64 >> (32 - 24)) & 0xffffff;
> +
> +       calc_rate =3D
> +               ((u64)parent_rate * (((u64)fbdiv_int << 24) + fbdiv_frac)=
 + (1 << 23)) >> 24;
> +
> +       *div_int =3D fbdiv_int;
> +       *div_frac =3D fbdiv_frac;
> +
> +       return calc_rate;
> +}
> +
> +static int rp1_pll_core_set_rate(struct clk_hw *hw,
> +                                unsigned long rate, unsigned long parent=
_rate)
> +{
> +       struct rp1_pll_core *pll_core =3D container_of(hw, struct rp1_pll=
_core, hw);
> +       struct rp1_clockman *clockman =3D pll_core->clockman;
> +       const struct rp1_pll_core_data *data =3D pll_core->data;
> +       unsigned long calc_rate;
> +       u32 fbdiv_int, fbdiv_frac;
> +
> +       /* Disable dividers to start with. */
> +       spin_lock(&clockman->regs_lock);
> +       clockman_write(clockman, data->fbdiv_int_reg, 0);
> +       clockman_write(clockman, data->fbdiv_frac_reg, 0);
> +       spin_unlock(&clockman->regs_lock);
> +
> +       calc_rate =3D get_pll_core_divider(hw, rate, parent_rate,
> +                                        &fbdiv_int, &fbdiv_frac);
> +
> +       spin_lock(&clockman->regs_lock);
> +       clockman_write(clockman, data->pwr_reg, fbdiv_frac ? 0 : PLL_PWR_=
DSMPD);
> +       clockman_write(clockman, data->fbdiv_int_reg, fbdiv_int);
> +       clockman_write(clockman, data->fbdiv_frac_reg, fbdiv_frac);
> +       spin_unlock(&clockman->regs_lock);
> +
> +       /* Check that reference frequency is no greater than VCO / 16. */

Why is '16' special?

> +       if (WARN_ON_ONCE(parent_rate > (rate / 16)))
> +               return -ERANGE;
> +
> +       pll_core->cached_rate =3D calc_rate;
> +
> +       spin_lock(&clockman->regs_lock);
> +       /* Don't need to divide ref unless parent_rate > (output freq / 1=
6) */
> +       clockman_write(clockman, data->cs_reg,
> +                      clockman_read(clockman, data->cs_reg) |
> +                                    (1 << PLL_CS_REFDIV_SHIFT));
> +       spin_unlock(&clockman->regs_lock);
> +
> +       return 0;
> +}
> +
> +static unsigned long rp1_pll_core_recalc_rate(struct clk_hw *hw,
> +                                             unsigned long parent_rate)
> +{
> +       struct rp1_pll_core *pll_core =3D container_of(hw, struct rp1_pll=
_core, hw);
> +       struct rp1_clockman *clockman =3D pll_core->clockman;
> +       const struct rp1_pll_core_data *data =3D pll_core->data;
> +       u32 fbdiv_int, fbdiv_frac;
> +       unsigned long calc_rate;
> +
> +       fbdiv_int =3D clockman_read(clockman, data->fbdiv_int_reg);
> +       fbdiv_frac =3D clockman_read(clockman, data->fbdiv_frac_reg);
> +       calc_rate =3D
> +               ((u64)parent_rate * (((u64)fbdiv_int << 24) + fbdiv_frac)=
 + (1 << 23)) >> 24;

Where does '24' come from? Can you simplify this line somehow? Maybe
break it up into multiple lines?

> +
> +       return calc_rate;
> +}
> +
> +static long rp1_pll_core_round_rate(struct clk_hw *hw, unsigned long rat=
e,
> +                                   unsigned long *parent_rate)
> +{
> +       u32 fbdiv_int, fbdiv_frac;
> +       long calc_rate;
> +
> +       calc_rate =3D get_pll_core_divider(hw, rate, *parent_rate,
> +                                        &fbdiv_int, &fbdiv_frac);
> +       return calc_rate;

return get_pll_core_divider(...);

> +}
> +
> +static void rp1_pll_core_debug_init(struct clk_hw *hw, struct dentry *de=
ntry)
> +{
> +       struct rp1_pll_core *pll_core =3D container_of(hw, struct rp1_pll=
_core, hw);
> +       struct rp1_clockman *clockman =3D pll_core->clockman;
> +       const struct rp1_pll_core_data *data =3D pll_core->data;
> +       struct debugfs_reg32 *regs;
> +
> +       regs =3D devm_kcalloc(clockman->dev, 4, sizeof(*regs), GFP_KERNEL=
);
> +       if (!regs)
> +               return;
> +
> +       regs[0].name =3D "cs";
> +       regs[0].offset =3D data->cs_reg;
> +       regs[1].name =3D "pwr";
> +       regs[1].offset =3D data->pwr_reg;
> +       regs[2].name =3D "fbdiv_int";
> +       regs[2].offset =3D data->fbdiv_int_reg;
> +       regs[3].name =3D "fbdiv_frac";
> +       regs[3].offset =3D data->fbdiv_frac_reg;
> +
> +       rp1_debugfs_regset(clockman, 0, regs, 4, dentry);
> +}

This can go behind CONFIG_DEBUG_FS so it isn't compiled unless debugfs
is enabled.

> +
> +static void get_pll_prim_dividers(unsigned long rate, unsigned long pare=
nt_rate,
> +                                 u32 *divider1, u32 *divider2)
> +{
> +       unsigned int div1, div2;
> +       unsigned int best_div1 =3D 7, best_div2 =3D 7;
> +       unsigned long best_rate_diff =3D
> +               abs_diff(DIV_ROUND_CLOSEST(parent_rate, best_div1 * best_=
div2), rate);
> +       unsigned long rate_diff, calc_rate;
> +
> +       for (div1 =3D 1; div1 <=3D 7; div1++) {
> +               for (div2 =3D 1; div2 <=3D div1; div2++) {
> +                       calc_rate =3D DIV_ROUND_CLOSEST(parent_rate, div1=
 * div2);
> +                       rate_diff =3D abs_diff(calc_rate, rate);
> +
> +                       if (calc_rate =3D=3D rate) {
> +                               best_div1 =3D div1;
> +                               best_div2 =3D div2;
> +                               goto done;
> +                       } else if (rate_diff < best_rate_diff) {
> +                               best_div1 =3D div1;
> +                               best_div2 =3D div2;
> +                               best_rate_diff =3D rate_diff;
> +                       }
> +               }
> +       }
> +
> +done:
> +       *divider1 =3D best_div1;
> +       *divider2 =3D best_div2;
> +}
> +
> +static int rp1_pll_set_rate(struct clk_hw *hw,
> +                           unsigned long rate, unsigned long parent_rate)
> +{
> +       struct rp1_pll *pll =3D container_of(hw, struct rp1_pll, hw);
> +       struct rp1_clockman *clockman =3D pll->clockman;
> +       const struct rp1_pll_data *data =3D pll->data;
> +       u32 prim, prim_div1, prim_div2;
> +
> +       get_pll_prim_dividers(rate, parent_rate, &prim_div1, &prim_div2);
> +
> +       spin_lock(&clockman->regs_lock);
> +       prim =3D clockman_read(clockman, data->ctrl_reg);
> +       prim =3D set_register_field(prim, prim_div1, PLL_PRIM_DIV1_MASK,
> +                                 PLL_PRIM_DIV1_SHIFT);
> +       prim =3D set_register_field(prim, prim_div2, PLL_PRIM_DIV2_MASK,
> +                                 PLL_PRIM_DIV2_SHIFT);
> +       clockman_write(clockman, data->ctrl_reg, prim);
> +       spin_unlock(&clockman->regs_lock);
> +
> +       return 0;
> +}
> +
> +static unsigned long rp1_pll_recalc_rate(struct clk_hw *hw,
> +                                        unsigned long parent_rate)
> +{
> +       struct rp1_pll *pll =3D container_of(hw, struct rp1_pll, hw);
> +       struct rp1_clockman *clockman =3D pll->clockman;
> +       const struct rp1_pll_data *data =3D pll->data;
> +       u32 prim, prim_div1, prim_div2;
> +
> +       prim =3D clockman_read(clockman, data->ctrl_reg);
> +       prim_div1 =3D (prim & PLL_PRIM_DIV1_MASK) >> PLL_PRIM_DIV1_SHIFT;
> +       prim_div2 =3D (prim & PLL_PRIM_DIV2_MASK) >> PLL_PRIM_DIV2_SHIFT;
> +
> +       if (!prim_div1 || !prim_div2) {
> +               dev_err(clockman->dev, "%s: (%s) zero divider value\n",
> +                       __func__, data->name);
> +               return 0;
> +       }
> +
> +       return DIV_ROUND_CLOSEST(parent_rate, prim_div1 * prim_div2);
> +}
> +
> +static long rp1_pll_round_rate(struct clk_hw *hw, unsigned long rate,
> +                              unsigned long *parent_rate)
> +{
> +       u32 div1, div2;
> +
> +       get_pll_prim_dividers(rate, *parent_rate, &div1, &div2);
> +
> +       return DIV_ROUND_CLOSEST(*parent_rate, div1 * div2);
> +}
> +
> +static void rp1_pll_debug_init(struct clk_hw *hw,
> +                              struct dentry *dentry)
> +{
> +       struct rp1_pll *pll =3D container_of(hw, struct rp1_pll, hw);
> +       struct rp1_clockman *clockman =3D pll->clockman;
> +       const struct rp1_pll_data *data =3D pll->data;
> +       struct debugfs_reg32 *regs;
> +
> +       regs =3D devm_kcalloc(clockman->dev, 1, sizeof(*regs), GFP_KERNEL=
);
> +       if (!regs)
> +               return;
> +
> +       regs[0].name =3D "prim";
> +       regs[0].offset =3D data->ctrl_reg;
> +
> +       rp1_debugfs_regset(clockman, 0, regs, 1, dentry);
> +}
> +
> +static int rp1_pll_ph_is_on(struct clk_hw *hw)
> +{
> +       struct rp1_pll_ph *pll =3D container_of(hw, struct rp1_pll_ph, hw=
);
> +       struct rp1_clockman *clockman =3D pll->clockman;
> +       const struct rp1_pll_ph_data *data =3D pll->data;
> +
> +       return !!(clockman_read(clockman, data->ph_reg) & PLL_PH_EN);
> +}
> +
> +static int rp1_pll_ph_on(struct clk_hw *hw)
> +{
> +       struct rp1_pll_ph *pll_ph =3D container_of(hw, struct rp1_pll_ph,=
 hw);
> +       struct rp1_clockman *clockman =3D pll_ph->clockman;
> +       const struct rp1_pll_ph_data *data =3D pll_ph->data;
> +       u32 ph_reg;
> +
> +       /* todo: ensure pri/sec is enabled! */

Capitalize TODO, or better yet do it and remove the comment.

> +       spin_lock(&clockman->regs_lock);
> +       ph_reg =3D clockman_read(clockman, data->ph_reg);
> +       ph_reg |=3D data->phase << PLL_PH_PHASE_SHIFT;
> +       ph_reg |=3D PLL_PH_EN;
> +       clockman_write(clockman, data->ph_reg, ph_reg);
> +       spin_unlock(&clockman->regs_lock);
> +
> +       return 0;
> +}
> +
> +static void rp1_pll_ph_off(struct clk_hw *hw)
> +{
> +       struct rp1_pll_ph *pll_ph =3D container_of(hw, struct rp1_pll_ph,=
 hw);
> +       struct rp1_clockman *clockman =3D pll_ph->clockman;
> +       const struct rp1_pll_ph_data *data =3D pll_ph->data;
> +
> +       spin_lock(&clockman->regs_lock);
> +       clockman_write(clockman, data->ph_reg,
> +                      clockman_read(clockman, data->ph_reg) & ~PLL_PH_EN=
);
> +       spin_unlock(&clockman->regs_lock);
> +}
> +
> +static int rp1_pll_ph_set_rate(struct clk_hw *hw,
> +                              unsigned long rate, unsigned long parent_r=
ate)
> +{
> +       struct rp1_pll_ph *pll_ph =3D container_of(hw, struct rp1_pll_ph,=
 hw);
> +       const struct rp1_pll_ph_data *data =3D pll_ph->data;
> +
> +       /* Nothing really to do here! */

Is it read-only? Don't define a set_rate function then and make the rate
determination function return the same value all the time.

> +       WARN_ON(data->fixed_divider !=3D 1 && data->fixed_divider !=3D 2);
> +       WARN_ON(rate !=3D parent_rate / data->fixed_divider);
> +
> +       return 0;
> +}
> +
> +static unsigned long rp1_pll_ph_recalc_rate(struct clk_hw *hw,
> +                                           unsigned long parent_rate)
> +{
> +       struct rp1_pll_ph *pll_ph =3D container_of(hw, struct rp1_pll_ph,=
 hw);
> +       const struct rp1_pll_ph_data *data =3D pll_ph->data;
> +
> +       return parent_rate / data->fixed_divider;
> +}
> +
> +static long rp1_pll_ph_round_rate(struct clk_hw *hw, unsigned long rate,
> +                                 unsigned long *parent_rate)
> +{
> +       struct rp1_pll_ph *pll_ph =3D container_of(hw, struct rp1_pll_ph,=
 hw);
> +       const struct rp1_pll_ph_data *data =3D pll_ph->data;
> +
> +       return *parent_rate / data->fixed_divider;
> +}
> +
> +static void rp1_pll_ph_debug_init(struct clk_hw *hw,
> +                                 struct dentry *dentry)
> +{
> +       struct rp1_pll_ph *pll_ph =3D container_of(hw, struct rp1_pll_ph,=
 hw);
> +       const struct rp1_pll_ph_data *data =3D pll_ph->data;
> +       struct rp1_clockman *clockman =3D pll_ph->clockman;
> +       struct debugfs_reg32 *regs;
> +
> +       regs =3D devm_kcalloc(clockman->dev, 1, sizeof(*regs), GFP_KERNEL=
);
> +       if (!regs)
> +               return;
> +
> +       regs[0].name =3D "ph_reg";
> +       regs[0].offset =3D data->ph_reg;
> +
> +       rp1_debugfs_regset(clockman, 0, regs, 1, dentry);
> +}
> +
> +static int rp1_pll_divider_is_on(struct clk_hw *hw)
> +{
> +       struct rp1_pll *divider =3D container_of(hw, struct rp1_pll, div.=
hw);
> +       struct rp1_clockman *clockman =3D divider->clockman;
> +       const struct rp1_pll_data *data =3D divider->data;
> +
> +       return !(clockman_read(clockman, data->ctrl_reg) & PLL_SEC_RST);
> +}
> +
> +static int rp1_pll_divider_on(struct clk_hw *hw)
> +{
> +       struct rp1_pll *divider =3D container_of(hw, struct rp1_pll, div.=
hw);
> +       struct rp1_clockman *clockman =3D divider->clockman;
> +       const struct rp1_pll_data *data =3D divider->data;
> +
> +       spin_lock(&clockman->regs_lock);
> +       /* Check the implementation bit is set! */
> +       WARN_ON(!(clockman_read(clockman, data->ctrl_reg) & PLL_SEC_IMPL)=
);
> +       clockman_write(clockman, data->ctrl_reg,
> +                      clockman_read(clockman, data->ctrl_reg) & ~PLL_SEC=
_RST);
> +       spin_unlock(&clockman->regs_lock);
> +
> +       return 0;
> +}
> +
> +static void rp1_pll_divider_off(struct clk_hw *hw)
> +{
> +       struct rp1_pll *divider =3D container_of(hw, struct rp1_pll, div.=
hw);
> +       struct rp1_clockman *clockman =3D divider->clockman;
> +       const struct rp1_pll_data *data =3D divider->data;
> +
> +       spin_lock(&clockman->regs_lock);
> +       clockman_write(clockman, data->ctrl_reg, PLL_SEC_RST);
> +       spin_unlock(&clockman->regs_lock);
> +}
> +
> +static int rp1_pll_divider_set_rate(struct clk_hw *hw,
> +                                   unsigned long rate,
> +                                   unsigned long parent_rate)
> +{
> +       struct rp1_pll *divider =3D container_of(hw, struct rp1_pll, div.=
hw);
> +       struct rp1_clockman *clockman =3D divider->clockman;
> +       const struct rp1_pll_data *data =3D divider->data;
> +       u32 div, sec;
> +
> +       div =3D DIV_ROUND_UP_ULL(parent_rate, rate);
> +       div =3D clamp(div, 8u, 19u);
> +
> +       spin_lock(&clockman->regs_lock);
> +       sec =3D clockman_read(clockman, data->ctrl_reg);
> +       sec =3D set_register_field(sec, div, PLL_SEC_DIV_MASK, PLL_SEC_DI=
V_SHIFT);
> +
> +       /* Must keep the divider in reset to change the value. */
> +       sec |=3D PLL_SEC_RST;
> +       clockman_write(clockman, data->ctrl_reg, sec);
> +
> +       // todo: must sleep 10 pll vco cycles
> +       sec &=3D ~PLL_SEC_RST;
> +       clockman_write(clockman, data->ctrl_reg, sec);
> +       spin_unlock(&clockman->regs_lock);
> +
> +       return 0;
> +}
> +
> +static unsigned long rp1_pll_divider_recalc_rate(struct clk_hw *hw,
> +                                                unsigned long parent_rat=
e)
> +{
> +       return clk_divider_ops.recalc_rate(hw, parent_rate);
> +}
> +
> +static long rp1_pll_divider_round_rate(struct clk_hw *hw,
> +                                      unsigned long rate,
> +                                      unsigned long *parent_rate)
> +{
> +       return clk_divider_ops.round_rate(hw, rate, parent_rate);
> +}
> +
> +static void rp1_pll_divider_debug_init(struct clk_hw *hw, struct dentry =
*dentry)
> +{
> +       struct rp1_pll *divider =3D container_of(hw, struct rp1_pll, div.=
hw);
> +       struct rp1_clockman *clockman =3D divider->clockman;
> +       const struct rp1_pll_data *data =3D divider->data;
> +       struct debugfs_reg32 *regs;
> +
> +       regs =3D devm_kcalloc(clockman->dev, 1, sizeof(*regs), GFP_KERNEL=
);
> +       if (!regs)
> +               return;
> +
> +       regs[0].name =3D "sec";
> +       regs[0].offset =3D data->ctrl_reg;
> +
> +       rp1_debugfs_regset(clockman, 0, regs, 1, dentry);
> +}
> +
> +static int rp1_clock_is_on(struct clk_hw *hw)
> +{
> +       struct rp1_clock *clock =3D container_of(hw, struct rp1_clock, hw=
);
> +       struct rp1_clockman *clockman =3D clock->clockman;
> +       const struct rp1_clock_data *data =3D clock->data;
> +
> +       return !!(clockman_read(clockman, data->ctrl_reg) & CLK_CTRL_ENAB=
LE);
> +}
> +
> +static unsigned long rp1_clock_recalc_rate(struct clk_hw *hw,
> +                                          unsigned long parent_rate)
> +{
> +       struct rp1_clock *clock =3D container_of(hw, struct rp1_clock, hw=
);
> +       struct rp1_clockman *clockman =3D clock->clockman;
> +       const struct rp1_clock_data *data =3D clock->data;
> +       u64 calc_rate;
> +       u64 div;
> +
> +       u32 frac;
> +
> +       div =3D clockman_read(clockman, data->div_int_reg);
> +       frac =3D (data->div_frac_reg !=3D 0) ?
> +               clockman_read(clockman, data->div_frac_reg) : 0;
> +
> +       /* If the integer portion of the divider is 0, treat it as 2^16 */
> +       if (!div)
> +               div =3D 1 << 16;
> +
> +       div =3D (div << CLK_DIV_FRAC_BITS) | (frac >> (32 - CLK_DIV_FRAC_=
BITS));
> +
> +       calc_rate =3D (u64)parent_rate << CLK_DIV_FRAC_BITS;
> +       calc_rate =3D div64_u64(calc_rate, div);
> +
> +       return calc_rate;
> +}
> +
> +static int rp1_clock_on(struct clk_hw *hw)
> +{
> +       struct rp1_clock *clock =3D container_of(hw, struct rp1_clock, hw=
);
> +       struct rp1_clockman *clockman =3D clock->clockman;
> +       const struct rp1_clock_data *data =3D clock->data;
> +
> +       spin_lock(&clockman->regs_lock);
> +       clockman_write(clockman, data->ctrl_reg,
> +                      clockman_read(clockman, data->ctrl_reg) | CLK_CTRL=
_ENABLE);
> +       /* If this is a GPCLK, turn on the output-enable */
> +       if (data->oe_mask)
> +               clockman_write(clockman, GPCLK_OE_CTRL,
> +                              clockman_read(clockman, GPCLK_OE_CTRL) | d=
ata->oe_mask);
> +       spin_unlock(&clockman->regs_lock);
> +
> +       return 0;
> +}
> +
> +static void rp1_clock_off(struct clk_hw *hw)
> +{
> +       struct rp1_clock *clock =3D container_of(hw, struct rp1_clock, hw=
);
> +       struct rp1_clockman *clockman =3D clock->clockman;
> +       const struct rp1_clock_data *data =3D clock->data;
> +
> +       spin_lock(&clockman->regs_lock);
> +       clockman_write(clockman, data->ctrl_reg,
> +                      clockman_read(clockman, data->ctrl_reg) & ~CLK_CTR=
L_ENABLE);
> +       /* If this is a GPCLK, turn off the output-enable */
> +       if (data->oe_mask)
> +               clockman_write(clockman, GPCLK_OE_CTRL,
> +                              clockman_read(clockman, GPCLK_OE_CTRL) & ~=
data->oe_mask);
> +       spin_unlock(&clockman->regs_lock);
> +}
> +
> +static u32 rp1_clock_choose_div(unsigned long rate, unsigned long parent=
_rate,
> +                               const struct rp1_clock_data *data)
> +{
> +       u64 div;
> +
> +       /*
> +        * Due to earlier rounding, calculated parent_rate may differ from
> +        * expected value. Don't fail on a small discrepancy near unity d=
ivide.
> +        */
> +       if (!rate || rate > parent_rate + (parent_rate >> CLK_DIV_FRAC_BI=
TS))
> +               return 0;
> +
> +       /*
> +        * Always express div in fixed-point format for fractional divisi=
on;
> +        * If no fractional divider is present, the fraction part will be=
 zero.
> +        */
> +       if (data->div_frac_reg) {
> +               div =3D (u64)parent_rate << CLK_DIV_FRAC_BITS;
> +               div =3D DIV_ROUND_CLOSEST_ULL(div, rate);
> +       } else {
> +               div =3D DIV_ROUND_CLOSEST_ULL(parent_rate, rate);
> +               div <<=3D CLK_DIV_FRAC_BITS;
> +       }
> +
> +       div =3D clamp(div,
> +                   1ull << CLK_DIV_FRAC_BITS,
> +                   (u64)data->div_int_max << CLK_DIV_FRAC_BITS);
> +
> +       return div;
> +}
> +
> +static u8 rp1_clock_get_parent(struct clk_hw *hw)
> +{
> +       struct rp1_clock *clock =3D container_of(hw, struct rp1_clock, hw=
);
> +       struct rp1_clockman *clockman =3D clock->clockman;
> +       const struct rp1_clock_data *data =3D clock->data;
> +       u32 sel, ctrl;
> +       u8 parent;
> +
> +       /* Sel is one-hot, so find the first bit set */
> +       sel =3D clockman_read(clockman, data->sel_reg);
> +       parent =3D ffs(sel) - 1;
> +
> +       /* sel =3D=3D 0 implies the parent clock is not enabled yet. */
> +       if (!sel) {
> +               /* Read the clock src from the CTRL register instead */
> +               ctrl =3D clockman_read(clockman, data->ctrl_reg);
> +               parent =3D (ctrl & data->clk_src_mask) >> CLK_CTRL_SRC_SH=
IFT;
> +       }
> +
> +       if (parent >=3D data->num_std_parents)
> +               parent =3D AUX_SEL;
> +
> +       if (parent =3D=3D AUX_SEL) {
> +               /*
> +                * Clock parent is an auxiliary source, so get the parent=
 from
> +                * the AUXSRC register field.
> +                */
> +               ctrl =3D clockman_read(clockman, data->ctrl_reg);
> +               parent =3D (ctrl & CLK_CTRL_AUXSRC_MASK) >> CLK_CTRL_AUXS=
RC_SHIFT;
> +               parent +=3D data->num_std_parents;
> +       }
> +
> +       return parent;
> +}
> +
> +static int rp1_clock_set_parent(struct clk_hw *hw, u8 index)
> +{
> +       struct rp1_clock *clock =3D container_of(hw, struct rp1_clock, hw=
);
> +       struct rp1_clockman *clockman =3D clock->clockman;
> +       const struct rp1_clock_data *data =3D clock->data;
> +       u32 ctrl, sel;
> +
> +       spin_lock(&clockman->regs_lock);
> +       ctrl =3D clockman_read(clockman, data->ctrl_reg);
> +
> +       if (index >=3D data->num_std_parents) {
> +               /* This is an aux source request */
> +               if (index >=3D data->num_std_parents + data->num_aux_pare=
nts) {
> +                       spin_unlock(&clockman->regs_lock);
> +                       return -EINVAL;
> +               }
> +
> +               /* Select parent from aux list */
> +               ctrl =3D set_register_field(ctrl, index - data->num_std_p=
arents,
> +                                         CLK_CTRL_AUXSRC_MASK,
> +                                         CLK_CTRL_AUXSRC_SHIFT);
> +               /* Set src to aux list */
> +               ctrl =3D set_register_field(ctrl, AUX_SEL, data->clk_src_=
mask,
> +                                         CLK_CTRL_SRC_SHIFT);
> +       } else {
> +               ctrl =3D set_register_field(ctrl, index, data->clk_src_ma=
sk,
> +                                         CLK_CTRL_SRC_SHIFT);
> +       }
> +
> +       clockman_write(clockman, data->ctrl_reg, ctrl);
> +       spin_unlock(&clockman->regs_lock);
> +
> +       sel =3D rp1_clock_get_parent(hw);
> +       WARN(sel !=3D index, "(%s): Parent index req %u returned back %u\=
n",
> +            data->name, index, sel);
> +
> +       return 0;
> +}
> +
> +static int rp1_clock_set_rate_and_parent(struct clk_hw *hw,
> +                                        unsigned long rate,
> +                                        unsigned long parent_rate,
> +                                        u8 parent)
> +{
> +       struct rp1_clock *clock =3D container_of(hw, struct rp1_clock, hw=
);
> +       struct rp1_clockman *clockman =3D clock->clockman;
> +       const struct rp1_clock_data *data =3D clock->data;
> +       u32 div =3D rp1_clock_choose_div(rate, parent_rate, data);
> +
> +       WARN(rate > 4000000000ll, "rate is -ve (%d)\n", (int)rate);
> +
> +       if (WARN(!div,
> +                "clk divider calculated as 0! (%s, rate %ld, parent rate=
 %ld)\n",
> +                data->name, rate, parent_rate))
> +               div =3D 1 << CLK_DIV_FRAC_BITS;
> +
> +       spin_lock(&clockman->regs_lock);
> +
> +       clockman_write(clockman, data->div_int_reg, div >> CLK_DIV_FRAC_B=
ITS);
> +       if (data->div_frac_reg)
> +               clockman_write(clockman, data->div_frac_reg, div << (32 -=
 CLK_DIV_FRAC_BITS));
> +
> +       spin_unlock(&clockman->regs_lock);
> +
> +       if (parent !=3D 0xff)
> +               rp1_clock_set_parent(hw, parent);
> +
> +       return 0;
> +}
> +
> +static int rp1_clock_set_rate(struct clk_hw *hw, unsigned long rate,
> +                             unsigned long parent_rate)
> +{
> +       return rp1_clock_set_rate_and_parent(hw, rate, parent_rate, 0xff);
> +}
> +
> +static void rp1_clock_choose_div_and_prate(struct clk_hw *hw,
> +                                          int parent_idx,
> +                                          unsigned long rate,
> +                                          unsigned long *prate,
> +                                          unsigned long *calc_rate)
> +{
> +       struct rp1_clock *clock =3D container_of(hw, struct rp1_clock, hw=
);
> +       const struct rp1_clock_data *data =3D clock->data;
> +       struct clk_hw *parent;
> +       u32 div;
> +       u64 tmp;
> +
> +       parent =3D clk_hw_get_parent_by_index(hw, parent_idx);
> +
> +       *prate =3D clk_hw_get_rate(parent);
> +       div =3D rp1_clock_choose_div(rate, *prate, data);
> +
> +       if (!div) {
> +               *calc_rate =3D 0;
> +               return;
> +       }
> +
> +       /* Recalculate to account for rounding errors */
> +       tmp =3D (u64)*prate << CLK_DIV_FRAC_BITS;
> +       tmp =3D div_u64(tmp, div);
> +
> +       /*
> +        * Prevent overclocks - if all parent choices result in
> +        * a downstream clock in excess of the maximum, then the
> +        * call to set the clock will fail.
> +        */
> +       if (tmp > clock->data->max_freq)
> +               *calc_rate =3D 0;
> +       else
> +               *calc_rate =3D tmp;
> +}
> +
> +static int rp1_clock_determine_rate(struct clk_hw *hw,
> +                                   struct clk_rate_request *req)
> +{
> +       struct clk_hw *parent, *best_parent =3D NULL;
> +       unsigned long best_rate =3D 0;
> +       unsigned long best_prate =3D 0;
> +       unsigned long best_rate_diff =3D ULONG_MAX;
> +       unsigned long prate, calc_rate;
> +       size_t i;
> +
> +       /*
> +        * If the NO_REPARENT flag is set, try to use existing parent.
> +        */
> +       if ((clk_hw_get_flags(hw) & CLK_SET_RATE_NO_REPARENT)) {

Is this flag ever set?

> +               i =3D rp1_clock_get_parent(hw);
> +               parent =3D clk_hw_get_parent_by_index(hw, i);
> +               if (parent) {
> +                       rp1_clock_choose_div_and_prate(hw, i, req->rate, =
&prate,
> +                                                      &calc_rate);
> +                       if (calc_rate > 0) {
> +                               req->best_parent_hw =3D parent;
> +                               req->best_parent_rate =3D prate;
> +                               req->rate =3D calc_rate;
> +                               return 0;
> +                       }
> +               }
> +       }
> +
> +       /*
> +        * Select parent clock that results in the closest rate (lower or
> +        * higher)
> +        */
> +       for (i =3D 0; i < clk_hw_get_num_parents(hw); i++) {
> +               parent =3D clk_hw_get_parent_by_index(hw, i);
> +               if (!parent)
> +                       continue;
> +
> +               rp1_clock_choose_div_and_prate(hw, i, req->rate, &prate,
> +                                              &calc_rate);
> +
> +               if (abs_diff(calc_rate, req->rate) < best_rate_diff) {
> +                       best_parent =3D parent;
> +                       best_prate =3D prate;
> +                       best_rate =3D calc_rate;
> +                       best_rate_diff =3D abs_diff(calc_rate, req->rate);
> +
> +                       if (best_rate_diff =3D=3D 0)
> +                               break;
> +               }
> +       }
> +
> +       if (best_rate =3D=3D 0)
> +               return -EINVAL;
> +
> +       req->best_parent_hw =3D best_parent;
> +       req->best_parent_rate =3D best_prate;
> +       req->rate =3D best_rate;
> +
> +       return 0;
> +}
> +
> +static void rp1_clk_debug_init(struct clk_hw *hw, struct dentry *dentry)
> +{
> +       struct rp1_clock *clock =3D container_of(hw, struct rp1_clock, hw=
);
> +       struct rp1_clockman *clockman =3D clock->clockman;
> +       const struct rp1_clock_data *data =3D clock->data;
> +       struct debugfs_reg32 *regs;
> +       int i;
> +
> +       regs =3D devm_kcalloc(clockman->dev, 4, sizeof(*regs), GFP_KERNEL=
);
> +       if (!regs)
> +               return;
> +
> +       i =3D 0;
> +       regs[i].name =3D "ctrl";
> +       regs[i++].offset =3D data->ctrl_reg;
> +       regs[i].name =3D "div_int";
> +       regs[i++].offset =3D data->div_int_reg;
> +       regs[i].name =3D "div_frac";
> +       regs[i++].offset =3D data->div_frac_reg;
> +       regs[i].name =3D "sel";
> +       regs[i++].offset =3D data->sel_reg;

This time we get i but earlier it was hard-coded. Please be consistent.
I suspect hard-coded is easier to follow so just do that.

> +
> +       rp1_debugfs_regset(clockman, 0, regs, i, dentry);

I also wonder if regmap could be used? That has debugfs suport to read
registers builtin already.

> +}
> +
> +static const struct clk_ops rp1_pll_core_ops =3D {
> +       .is_prepared =3D rp1_pll_core_is_on,
> +       .prepare =3D rp1_pll_core_on,
> +       .unprepare =3D rp1_pll_core_off,
> +       .set_rate =3D rp1_pll_core_set_rate,
> +       .recalc_rate =3D rp1_pll_core_recalc_rate,
> +       .round_rate =3D rp1_pll_core_round_rate,
> +       .debug_init =3D rp1_pll_core_debug_init,
> +};
> +
> +static const struct clk_ops rp1_pll_ops =3D {
> +       .set_rate =3D rp1_pll_set_rate,
> +       .recalc_rate =3D rp1_pll_recalc_rate,
> +       .round_rate =3D rp1_pll_round_rate,
> +       .debug_init =3D rp1_pll_debug_init,
> +};
> +
> +static const struct clk_ops rp1_pll_ph_ops =3D {
> +       .is_prepared =3D rp1_pll_ph_is_on,
> +       .prepare =3D rp1_pll_ph_on,
> +       .unprepare =3D rp1_pll_ph_off,
> +       .set_rate =3D rp1_pll_ph_set_rate,
> +       .recalc_rate =3D rp1_pll_ph_recalc_rate,
> +       .round_rate =3D rp1_pll_ph_round_rate,
> +       .debug_init =3D rp1_pll_ph_debug_init,
> +};
> +
> +static const struct clk_ops rp1_pll_divider_ops =3D {
> +       .is_prepared =3D rp1_pll_divider_is_on,
> +       .prepare =3D rp1_pll_divider_on,
> +       .unprepare =3D rp1_pll_divider_off,
> +       .set_rate =3D rp1_pll_divider_set_rate,
> +       .recalc_rate =3D rp1_pll_divider_recalc_rate,
> +       .round_rate =3D rp1_pll_divider_round_rate,
> +       .debug_init =3D rp1_pll_divider_debug_init,
> +};
> +
> +static const struct clk_ops rp1_clk_ops =3D {
> +       .is_prepared =3D rp1_clock_is_on,
> +       .prepare =3D rp1_clock_on,
> +       .unprepare =3D rp1_clock_off,
> +       .recalc_rate =3D rp1_clock_recalc_rate,
> +       .get_parent =3D rp1_clock_get_parent,
> +       .set_parent =3D rp1_clock_set_parent,
> +       .set_rate_and_parent =3D rp1_clock_set_rate_and_parent,
> +       .set_rate =3D rp1_clock_set_rate,
> +       .determine_rate =3D rp1_clock_determine_rate,
> +       .debug_init =3D rp1_clk_debug_init,
> +};
> +
> +static struct clk_hw *rp1_register_pll_core(struct rp1_clockman *clockma=
n,
> +                                           const void *data)
> +{
> +       const char *ref_clk_name =3D clk_hw_get_name(clockman->hw_xosc);
> +       const struct rp1_pll_core_data *pll_core_data =3D data;
> +       struct rp1_pll_core *pll_core;
> +       struct clk_init_data init;
> +       int ret;
> +
> +       memset(&init, 0, sizeof(init));

I think struct clk_init_data init =3D { } is more the style in clk
drivers. Please do that instead of calling memset().

> +
> +       /* All of the PLL cores derive from the external oscillator. */
> +       init.parent_names =3D &ref_clk_name;
> +       init.num_parents =3D 1;
> +       init.name =3D pll_core_data->name;
> +       init.ops =3D &rp1_pll_core_ops;
> +       init.flags =3D pll_core_data->flags | CLK_IGNORE_UNUSED | CLK_IS_=
CRITICAL;
> +
> +       pll_core =3D devm_kzalloc(clockman->dev, sizeof(*pll_core), GFP_K=
ERNEL);
> +       if (!pll_core)
> +               return NULL;
> +
> +       pll_core->clockman =3D clockman;
> +       pll_core->data =3D pll_core_data;
> +       pll_core->hw.init =3D &init;
> +
> +       ret =3D devm_clk_hw_register(clockman->dev, &pll_core->hw);
> +       if (ret)
> +               return ERR_PTR(ret);
> +
> +       return &pll_core->hw;
> +}
> +
> +static struct clk_hw *rp1_register_pll(struct rp1_clockman *clockman,
> +                                      const void *data)
> +{
> +       const struct rp1_pll_data *pll_data =3D data;
> +       struct rp1_pll *pll;
> +       struct clk_init_data init;
> +       int ret;
> +
> +       memset(&init, 0, sizeof(init));
> +
> +       init.parent_names =3D &pll_data->source_pll;
> +       init.num_parents =3D 1;
> +       init.name =3D pll_data->name;
> +       init.ops =3D &rp1_pll_ops;
> +       init.flags =3D pll_data->flags | CLK_IGNORE_UNUSED | CLK_IS_CRITI=
CAL;
> +
> +       pll =3D devm_kzalloc(clockman->dev, sizeof(*pll), GFP_KERNEL);
> +       if (!pll)
> +               return NULL;
> +
> +       pll->clockman =3D clockman;
> +       pll->data =3D pll_data;
> +       pll->hw.init =3D &init;
> +
> +       ret =3D devm_clk_hw_register(clockman->dev, &pll->hw);
> +       if (ret)
> +               return ERR_PTR(ret);
> +
> +       return &pll->hw;
> +}
> +
> +static struct clk_hw *rp1_register_pll_ph(struct rp1_clockman *clockman,
> +                                         const void *data)
> +{
> +       const struct rp1_pll_ph_data *ph_data =3D data;
> +       struct rp1_pll_ph *ph;
> +       struct clk_init_data init;
> +       int ret;
> +
> +       memset(&init, 0, sizeof(init));
> +
> +       init.parent_names =3D &ph_data->source_pll;
> +       init.num_parents =3D 1;
> +       init.name =3D ph_data->name;
> +       init.ops =3D &rp1_pll_ph_ops;
> +       init.flags =3D ph_data->flags | CLK_IGNORE_UNUSED;
> +
> +       ph =3D devm_kzalloc(clockman->dev, sizeof(*ph), GFP_KERNEL);
> +       if (!ph)
> +               return NULL;
> +
> +       ph->clockman =3D clockman;
> +       ph->data =3D ph_data;
> +       ph->hw.init =3D &init;
> +
> +       ret =3D devm_clk_hw_register(clockman->dev, &ph->hw);
> +       if (ret)
> +               return ERR_PTR(ret);
> +
> +       return &ph->hw;
> +}
> +
> +static struct clk_hw *rp1_register_pll_divider(struct rp1_clockman *cloc=
kman,
> +                                              const void *data)
> +{
> +       const struct rp1_pll_data *divider_data =3D data;
> +       struct rp1_pll *divider;
> +       struct clk_init_data init;
> +       int ret;
> +
> +       memset(&init, 0, sizeof(init));
> +
> +       init.parent_names =3D &divider_data->source_pll;
> +       init.num_parents =3D 1;
> +       init.name =3D divider_data->name;
> +       init.ops =3D &rp1_pll_divider_ops;
> +       init.flags =3D divider_data->flags | CLK_IGNORE_UNUSED | CLK_IS_C=
RITICAL;
> +
> +       divider =3D devm_kzalloc(clockman->dev, sizeof(*divider), GFP_KER=
NEL);
> +       if (!divider)
> +               return NULL;
> +
> +       divider->div.reg =3D clockman->regs + divider_data->ctrl_reg;
> +       divider->div.shift =3D PLL_SEC_DIV_SHIFT;
> +       divider->div.width =3D PLL_SEC_DIV_WIDTH;
> +       divider->div.flags =3D CLK_DIVIDER_ROUND_CLOSEST;
> +       divider->div.flags |=3D CLK_IS_CRITICAL;

Is everything critical? The usage of this flag and CLK_IGNORE_UNUSED is
suspicious and likely working around some problems elsewhere.

> +       divider->div.lock =3D &clockman->regs_lock;
> +       divider->div.hw.init =3D &init;
> +       divider->div.table =3D pll_sec_div_table;
> +
> +       divider->clockman =3D clockman;
> +       divider->data =3D divider_data;
> +
> +       ret =3D devm_clk_hw_register(clockman->dev, &divider->div.hw);
> +       if (ret)
> +               return ERR_PTR(ret);
> +
> +       return &divider->div.hw;
> +}
> +
> +static struct clk_hw *rp1_register_clock(struct rp1_clockman *clockman,
> +                                        const void *data)
> +{
> +       const struct rp1_clock_data *clock_data =3D data;
> +       struct rp1_clock *clock;
> +       struct clk_init_data init;
> +       int ret;
> +
> +       if (WARN_ON_ONCE(MAX_CLK_PARENTS <
> +              clock_data->num_std_parents + clock_data->num_aux_parents))
> +               return NULL;
> +
> +       /* There must be a gap for the AUX selector */
> +       if (WARN_ON_ONCE(clock_data->num_std_parents > AUX_SEL &&
> +                        strcmp("-", clock_data->parents[AUX_SEL])))
> +               return NULL;
> +
> +       memset(&init, 0, sizeof(init));
> +       init.parent_names =3D clock_data->parents;
> +       init.num_parents =3D clock_data->num_std_parents +
> +                          clock_data->num_aux_parents;
> +       init.name =3D clock_data->name;
> +       init.flags =3D clock_data->flags | CLK_IGNORE_UNUSED;
> +       init.ops =3D &rp1_clk_ops;
> +
> +       clock =3D devm_kzalloc(clockman->dev, sizeof(*clock), GFP_KERNEL);
> +       if (!clock)
> +               return NULL;
> +
> +       clock->clockman =3D clockman;
> +       clock->data =3D clock_data;
> +       clock->hw.init =3D &init;
> +
> +       ret =3D devm_clk_hw_register(clockman->dev, &clock->hw);
> +       if (ret)
> +               return ERR_PTR(ret);
> +
> +       return &clock->hw;
> +}
> +
> +/* Assignment helper macros for different clock types. */
> +#define _REGISTER(f, ...) { .clk_register =3D f, .data =3D __VA_ARGS__ }
> +
> +#define REGISTER_PLL_CORE(...) _REGISTER(&rp1_register_pll_core,       \
> +                                         &(struct rp1_pll_core_data)   \
> +                                         {__VA_ARGS__})
> +
> +#define REGISTER_PLL(...)      _REGISTER(&rp1_register_pll,            \
> +                                         &(struct rp1_pll_data)        \
> +                                         {__VA_ARGS__})
> +
> +#define REGISTER_PLL_PH(...)   _REGISTER(&rp1_register_pll_ph,         \
> +                                         &(struct rp1_pll_ph_data)     \
> +                                         {__VA_ARGS__})
> +
> +#define REGISTER_PLL_DIV(...)  _REGISTER(&rp1_register_pll_divider,    \
> +                                         &(struct rp1_pll_data)        \
> +                                         {__VA_ARGS__})
> +
> +#define REGISTER_CLK(...)      _REGISTER(&rp1_register_clock,          \
> +                                         &(struct rp1_clock_data)      \
> +                                         {__VA_ARGS__})
> +
> +static const struct rp1_clk_desc clk_desc_array[] =3D {
> +       [RP1_PLL_SYS_CORE] =3D REGISTER_PLL_CORE(.name =3D "pll_sys_core",
> +                               .cs_reg =3D PLL_SYS_CS,
> +                               .pwr_reg =3D PLL_SYS_PWR,
> +                               .fbdiv_int_reg =3D PLL_SYS_FBDIV_INT,
> +                               .fbdiv_frac_reg =3D PLL_SYS_FBDIV_FRAC,
> +                               ),
> +
> +       [RP1_PLL_AUDIO_CORE] =3D REGISTER_PLL_CORE(.name =3D "pll_audio_c=
ore",
> +                               .cs_reg =3D PLL_AUDIO_CS,
> +                               .pwr_reg =3D PLL_AUDIO_PWR,
> +                               .fbdiv_int_reg =3D PLL_AUDIO_FBDIV_INT,
> +                               .fbdiv_frac_reg =3D PLL_AUDIO_FBDIV_FRAC,
> +                               ),
> +
> +       [RP1_PLL_VIDEO_CORE] =3D REGISTER_PLL_CORE(.name =3D "pll_video_c=
ore",
> +                               .cs_reg =3D PLL_VIDEO_CS,
> +                               .pwr_reg =3D PLL_VIDEO_PWR,
> +                               .fbdiv_int_reg =3D PLL_VIDEO_FBDIV_INT,
> +                               .fbdiv_frac_reg =3D PLL_VIDEO_FBDIV_FRAC,
> +                               ),
> +
> +       [RP1_PLL_SYS] =3D REGISTER_PLL(.name =3D "pll_sys",
> +                               .source_pll =3D "pll_sys_core",
> +                               .ctrl_reg =3D PLL_SYS_PRIM,
> +                               .fc0_src =3D FC_NUM(0, 2),
> +                               ),
> +
> +       [RP1_CLK_ETH_TSU] =3D REGISTER_CLK(.name =3D "clk_eth_tsu",
> +                               .parents =3D {"rp1-xosc"},
> +                               .num_std_parents =3D 0,
> +                               .num_aux_parents =3D 1,
> +                               .ctrl_reg =3D CLK_ETH_TSU_CTRL,
> +                               .div_int_reg =3D CLK_ETH_TSU_DIV_INT,
> +                               .sel_reg =3D CLK_ETH_TSU_SEL,
> +                               .div_int_max =3D DIV_INT_8BIT_MAX,
> +                               .max_freq =3D 50 * MHz,
> +                               .fc0_src =3D FC_NUM(5, 7),
> +                               ),
> +
> +       [RP1_CLK_SYS] =3D REGISTER_CLK(.name =3D "clk_sys",
> +                               .parents =3D {"rp1-xosc", "-", "pll_sys"},

Please use struct clk_parent_data or clk_hw directly. Don't use strings
to describe parents.

> +                               .num_std_parents =3D 3,
> +                               .num_aux_parents =3D 0,
> +                               .ctrl_reg =3D CLK_SYS_CTRL,
> +                               .div_int_reg =3D CLK_SYS_DIV_INT,
> +                               .sel_reg =3D CLK_SYS_SEL,
> +                               .div_int_max =3D DIV_INT_24BIT_MAX,
> +                               .max_freq =3D 200 * MHz,
> +                               .fc0_src =3D FC_NUM(0, 4),
> +                               .clk_src_mask =3D 0x3,
> +                               ),
> +
> +       [RP1_PLL_SYS_PRI_PH] =3D REGISTER_PLL_PH(.name =3D "pll_sys_pri_p=
h",
> +                               .source_pll =3D "pll_sys",
> +                               .ph_reg =3D PLL_SYS_PRIM,
> +                               .fixed_divider =3D 2,
> +                               .phase =3D RP1_PLL_PHASE_0,
> +                               .fc0_src =3D FC_NUM(1, 2),
> +                               ),
> +
> +       [RP1_PLL_SYS_SEC] =3D REGISTER_PLL_DIV(.name =3D "pll_sys_sec",
> +                               .source_pll =3D "pll_sys_core",
> +                               .ctrl_reg =3D PLL_SYS_SEC,
> +                               .fc0_src =3D FC_NUM(2, 2),
> +                               ),
> +};
> +
> +static int rp1_clk_probe(struct platform_device *pdev)
> +{
> +       const size_t asize =3D ARRAY_SIZE(clk_desc_array);
> +       const struct rp1_clk_desc *desc;
> +       struct device *dev =3D &pdev->dev;
> +       struct rp1_clockman *clockman;

I love the name 'clockman'!

> +       struct clk *clk_xosc;
> +       struct clk_hw **hws;
> +       unsigned int i;
> +
> +       clockman =3D devm_kzalloc(dev, struct_size(clockman, onecell.hws,=
 asize),
> +                               GFP_KERNEL);
> +       if (!clockman)
> +               return -ENOMEM;
> +
> +       spin_lock_init(&clockman->regs_lock);
> +       clockman->dev =3D dev;
> +
> +       clockman->regs =3D devm_platform_ioremap_resource(pdev, 0);
> +       if (IS_ERR(clockman->regs))
> +               return PTR_ERR(clockman->regs);
> +
> +       clk_xosc =3D devm_clk_get_enabled(dev, NULL);
> +       if (IS_ERR(clk_xosc))
> +               return PTR_ERR(clk_xosc);
> +
> +       clockman->hw_xosc =3D __clk_get_hw(clk_xosc);

Please use struct clk_parent_data::index instead.

> +       clockman->onecell.num =3D asize;
> +       hws =3D clockman->onecell.hws;
> +
> +       for (i =3D 0; i < asize; i++) {
> +               desc =3D &clk_desc_array[i];
> +               if (desc->clk_register && desc->data) {
> +                       hws[i] =3D desc->clk_register(clockman, desc->dat=
a);
> +                       if (IS_ERR_OR_NULL(hws[i]))
> +                               dev_err(dev, "Unable to register clock: %=
s\n",

Use dev_err_probe() please.

> +                                       clk_hw_get_name(hws[i]));
> +               }
> +       }
> +
> +       platform_set_drvdata(pdev, clockman);
> +
> +       return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
> +                                          &clockman->onecell);
> +}
> +
> +static const struct of_device_id rp1_clk_of_match[] =3D {
> +       { .compatible =3D "raspberrypi,rp1-clocks" },
> +       {}
> +};
> +MODULE_DEVICE_TABLE(of, rp1_clk_of_match);
> +
> +static struct platform_driver rp1_clk_driver =3D {
> +       .driver =3D {
> +               .name =3D "rp1-clk",
> +               .of_match_table =3D rp1_clk_of_match,
> +       },
> +       .probe =3D rp1_clk_probe,
> +};
> +
> +static int __init rp1_clk_driver_init(void)
> +{
> +       return platform_driver_register(&rp1_clk_driver);
> +}
> +postcore_initcall(rp1_clk_driver_init);
> +
> +static void __exit rp1_clk_driver_exit(void)
> +{
> +       platform_driver_unregister(&rp1_clk_driver);
> +}
> +module_exit(rp1_clk_driver_exit);

Can you use module_platform_driver()?

