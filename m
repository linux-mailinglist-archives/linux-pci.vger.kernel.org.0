Return-Path: <linux-pci+bounces-21155-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D6EA30D3A
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 14:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F3B818875F9
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 13:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11B31F542B;
	Tue, 11 Feb 2025 13:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="A2DLbn6D"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686A61F190E
	for <linux-pci@vger.kernel.org>; Tue, 11 Feb 2025 13:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739281559; cv=none; b=TuBv7/dMMWxQoG2hG5aj+wTIU4+blblboJknythFJuXiASUQig2VZ/SSjqLPdhmBXOjyK6yGBDAwf3G6Qz3hdIfmhdbFncQ2gYIz3DzZQg/Pl7dX55eT7Ui/6ki4Lgm4Ai+mpDDUkxByiRt8SCkhSLp3E895+JIqMh47g1xmLS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739281559; c=relaxed/simple;
	bh=5Ls6ehrFuNfDtokxDzaR2J5p2+P5rZ6x9GJCMdIdOXU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IR2KREGkZD9qaG9sQyXhmTBMSyieAKcFqzvrtiRyyli2KClvyGzD9bx4cO8GSf2Bvo5d+U8uquMz0cUgiZZHMigZBE/pXxb0kHBsZDsxHl/DL2bEhc5k+n1a+98J4zV48M1ZxebrA6vzFTPYW7avIbCd71p8ddJCTRc3Pvgpzs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=A2DLbn6D; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ab7d583d2afso236293166b.0
        for <linux-pci@vger.kernel.org>; Tue, 11 Feb 2025 05:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1739281555; x=1739886355; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RkP+VyXyd2LDTq1dE/e/+i0gFwY3obdySQr3wdtK8hs=;
        b=A2DLbn6D3yiNZvfFC/1uJgUHenzjcoi+hkZfcq814JXPSlSOlPs/Qet+GZmi+76MTV
         Lu5xGnRkPKsiG0VsG7jiM6C/1ChBjq3mvshyHDa83MCd4FQ+B05gIaSQ1p7K0uM+ltxN
         NNuARlr/LY7RPhAcItmlQxmAp8qXpsVH5kEHTrBzBXGqMxkL/NwWNBz7p2bWAuC9iciq
         fK8W/yz6buao4PKvhXcSHihHdoLjidcAndLA7Xxw0tTAt2hFq6Oyl+UPDmJwF9FrLw2c
         ueckiz/HoRw6zAoLvKxraQp4js/qXehAsdcQyn1D4JMR8LshNiT0VzQsUKV0Lr2ONejI
         vY/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739281555; x=1739886355;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RkP+VyXyd2LDTq1dE/e/+i0gFwY3obdySQr3wdtK8hs=;
        b=qPS6TgygGfFVdmoeB25TXZzK1Gb7M9UnxCYeiX+0K+gVzaCcfX9KLVS51Ye0n9XOpI
         4BXisG6T+Jtx4M1gFiTWdfoYXCvY9g0VJRKRB+RJguL9IB0PdPyz6ozXmr2CcXVnf18S
         wN7dbxjmT2wiQGpFumWRSrDQx5fCm4ZtaEgeGLLSY6I4VtJJ2mIT4QRJKtTbrdHWUAbP
         Z9Wtz4PudxPqpX+rm3khF6UK3TEkxTQZDTFX6AAv0hXQhmpQzgTMRK8coskLY1mxbATw
         Wu46LNKpJXChnOccnX0Ok0cHRT9UECPiYAPsAFEFeRYEBPYRwGtjCQxX0e31DJLi8arr
         vJnw==
X-Forwarded-Encrypted: i=1; AJvYcCVVFOQ70qtycoVpKTPEttJAcp+BLFOCeno9bIQnZlIjIuThsDE+TPovxobFfS5lJrhTTJ4wmf6JJ0s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyP9VjJiTe9InBiNI9iSCrjhyP3bzCsmMaYDLeSyJA2rsdw/+h3
	5ViQTLE9j3yXi4mFS75wO6Eu9dp0YyHx9kK4bgR91nNxQfoRVQ4VhWE2ri48pmY=
X-Gm-Gg: ASbGncsX1l2vdm2PhKTb0U7eyTeI3WaC5gr/ua1tIUjCBJPV0v7Ky5k/JfspktJ/VVG
	Bk8Ifx3xzq5rkyp4Pg4hYLZMaHeeMC9Oli77vlUpgf+zdQoeMrPf9Ylz22eY8h6EvTfdyjWDM6j
	YCftCYwIXVgvgcOF6x7U/DySrLuoRtg/4DYXTOIMu52sXHYKzO9C+Lpron21DZ7DVvEG5npX4P2
	9R6zfmH5r/76vXBWUrNFQPXGJ+wVCRXqBqHdY0oYSuWuTWP9Zjov/lFwqhrye414DK+LkQFPshU
	RTb6F2er4K28+k5U56no3J2C47V+N5JuObSWoh654+AQrAwEo3c2/ct+e6o=
X-Google-Smtp-Source: AGHT+IG51KR7uQClui5T80GFu03wGjZtCbiNcOn2c2quAcoJxfpyu2MvcnnQYDV8Nd/6UX7Ol8OjhA==
X-Received: by 2002:a17:907:6ea0:b0:ab7:c11:a980 with SMTP id a640c23a62f3a-ab7db544773mr282512766b.17.1739281554584;
        Tue, 11 Feb 2025 05:45:54 -0800 (PST)
Received: from localhost (host-79-41-239-37.retail.telecomitalia.it. [79.41.239.37])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7b43ee08asm522714066b.88.2025.02.11.05.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 05:45:54 -0800 (PST)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Tue, 11 Feb 2025 14:46:53 +0100
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Andrea della Porta <andrea.porta@suse.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Wilczynski <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Saravana Kannan <saravanak@google.com>, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Herve Codina <herve.codina@bootlin.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v7 06/11] pinctrl: rp1: Implement RaspberryPi RP1 gpio
 support
Message-ID: <Z6tUzcCqI2xdKSQ5@apocalypse>
References: <cover.1738963156.git.andrea.porta@suse.com>
 <c4b60fda4b9c87a5efaf5103507fb568413c841a.1738963156.git.andrea.porta@suse.com>
 <8e2b0e05-cd60-4b79-8763-005c3f72a64d@gmx.net>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e2b0e05-cd60-4b79-8763-005c3f72a64d@gmx.net>

Hi Stefan,

On 15:36 Sat 08 Feb     , Stefan Wahren wrote:
> Hi Andrea,
> 
> Am 07.02.25 um 22:31 schrieb Andrea della Porta:
> > The RP1 is an MFD supporting a gpio controller and /pinmux/pinctrl.
> > Add minimum support for the gpio only portion. The driver is in
> > pinctrl folder since upcoming patches will add the pinmux/pinctrl
> > support where the gpio part can be seen as an addition.
> > 
> > Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> > Reviewed-by: Stefan Wahren <wahrenst@gmx.net>
> > ---
> >   MAINTAINERS                   |   1 +
> >   drivers/pinctrl/Kconfig       |  11 +
> >   drivers/pinctrl/Makefile      |   1 +
> >   drivers/pinctrl/pinctrl-rp1.c | 789 ++++++++++++++++++++++++++++++++++
> >   4 files changed, 802 insertions(+)
> >   create mode 100644 drivers/pinctrl/pinctrl-rp1.c
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index a4a9555c07c5..f2ba6f565d30 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -19756,6 +19756,7 @@ F:	Documentation/devicetree/bindings/misc/pci1de4,1.yaml
> >   F:	Documentation/devicetree/bindings/pci/pci-ep-bus.yaml
> >   F:	Documentation/devicetree/bindings/pinctrl/raspberrypi,rp1-gpio.yaml
> >   F:	drivers/clk/clk-rp1.c
> > +F:	drivers/pinctrl/pinctrl-rp1.c
> >   F:	include/dt-bindings/clock/rp1.h
> >   F:	include/dt-bindings/misc/rp1.h
> > 
> > diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
> > index 95a8e2b9a614..53b265cabc26 100644
> > --- a/drivers/pinctrl/Kconfig
> > +++ b/drivers/pinctrl/Kconfig
> > @@ -612,6 +612,17 @@ config PINCTRL_MLXBF3
> >   	  each pin. This driver can also be built as a module called
> >   	  pinctrl-mlxbf3.
> > 
> > +config PINCTRL_RP1
> > +	tristate "Pinctrl driver for RP1"
> > +	depends on MISC_RP1
> > +	default MISC_RP1
> > +	select PINMUX
> > +	select PINCONF
> > +	select GENERIC_PINCONF
> > +	help
> > +	  Enable the gpio and pinctrl/mux driver for RaspberryPi RP1
> > +	  multi function device.
> > +
> >   source "drivers/pinctrl/actions/Kconfig"
> >   source "drivers/pinctrl/aspeed/Kconfig"
> >   source "drivers/pinctrl/bcm/Kconfig"
> > diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
> > index fba1c56624c0..6fb77de58545 100644
> > --- a/drivers/pinctrl/Makefile
> > +++ b/drivers/pinctrl/Makefile
> > @@ -48,6 +48,7 @@ obj-$(CONFIG_PINCTRL_PIC32)	+= pinctrl-pic32.o
> >   obj-$(CONFIG_PINCTRL_PISTACHIO)	+= pinctrl-pistachio.o
> >   obj-$(CONFIG_PINCTRL_RK805)	+= pinctrl-rk805.o
> >   obj-$(CONFIG_PINCTRL_ROCKCHIP)	+= pinctrl-rockchip.o
> > +obj-$(CONFIG_PINCTRL_RP1)       += pinctrl-rp1.o
> >   obj-$(CONFIG_PINCTRL_SCMI)	+= pinctrl-scmi.o
> >   obj-$(CONFIG_PINCTRL_SINGLE)	+= pinctrl-single.o
> >   obj-$(CONFIG_PINCTRL_ST) 	+= pinctrl-st.o
> > diff --git a/drivers/pinctrl/pinctrl-rp1.c b/drivers/pinctrl/pinctrl-rp1.c
> > new file mode 100644
> > index 000000000000..0d081f75d2ec
> > --- /dev/null
> > +++ b/drivers/pinctrl/pinctrl-rp1.c
> > @@ -0,0 +1,789 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Driver for Raspberry Pi RP1 GPIO unit
> > + *
> > + * Copyright (C) 2023 Raspberry Pi Ltd.
> > + *
> > + * This driver is inspired by:
> > + * pinctrl-bcm2835.c, please see original file for copyright information
> > + */
> > +
> ...
> > +
> > +static struct irq_chip rp1_gpio_irq_chip = {
> > +	.name = MODULE_NAME,
> > +	.irq_enable = rp1_gpio_irq_enable,
> > +	.irq_disable = rp1_gpio_irq_disable,
> > +	.irq_set_type = rp1_gpio_irq_set_type,
> > +	.irq_ack = rp1_gpio_irq_ack,
> > +	.irq_mask = rp1_gpio_irq_disable,
> > +	.irq_unmask = rp1_gpio_irq_enable,
> > +	.flags = IRQCHIP_IMMUTABLE,
> Sorry not sure, but doesn't this miss GPIOCHIP_IRQ_RESOURCE_HELPERS here?

Right. Added.

Thanks,
Andrea

> 
> Thanks

