Return-Path: <linux-pci+bounces-39906-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 042CBC23FE0
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 10:05:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9715C3ABF3A
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 09:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE5332E6AD;
	Fri, 31 Oct 2025 09:00:44 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CAA32D7E6
	for <linux-pci@vger.kernel.org>; Fri, 31 Oct 2025 09:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761901244; cv=none; b=gUlQPxo9hAkSeQhoGKPP5pxmjhmrpErw9yW4Tk9RdQrUcYMlejs0fLoqg8QB1cafuS7uiGSt2iuucq6ctHEKjxOah+u55UIs3sY//bY4fB9QLggg43boNGKgNC1Yo+6ctzzU+1ymhIwLa+7NzI5A0gEvcjfypGKlNB3kNHHPH2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761901244; c=relaxed/simple;
	bh=NYbl8HJcgb3R5SVJ9GXGI/Jq2+mOIag8w0HzHBPHPoY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M6o2UucWaKlgiJ5BI9u+HaIto6eBTY5z+YY5WSCYlmiOBSalkZiJsXXpTaVKy2/OgcqKriVnb/Rd9R2xjoxNnP3+qv2mnJTBzW78HV8RUeM3llhFbhIqgrq0dOZBgQi8KQriZLcPaVvkcarCA7goINutwiNT4ONoL23fHUAPhwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8801e4da400so18709246d6.3
        for <linux-pci@vger.kernel.org>; Fri, 31 Oct 2025 02:00:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761901241; x=1762506041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lQVVX5c2GB+a2QgL3UYe6DKU+bmVaydohzEFkpxq/1c=;
        b=LzsbSNTNhmm5Um4PPwpfFpGbN8fmrh+Zz3LZ8Pe01kxZnQp83aYdVY+4VlmqE4kXeN
         fQ5iHepKP4ZOo2kxdOYtlOO/sdElXIhng/NO8iwvHRqyuy/BDfAmqvVLjCJ+vQ68BKan
         A6xDh78M07nt8ZlrPzT24dK+MilRBBo1Hv8QzpbjJxFtfTfBDBBlNaJriWCnrHSvM4JT
         hMDjUdJL+M1n0pzSxrRjau0q4Ik2WmAvnbeV9cD+v7sUlpiLPhuDIKtndp7bVzDy9bE9
         FFw2G+fXmbbOjGQ2oJ9rLLwcHSNz4laut/nJVRzb2FmYrx2vOoFr4OBYOVXF5gGEx9gs
         LqHw==
X-Forwarded-Encrypted: i=1; AJvYcCVW0sEDGtF6xllshyguX/dE1atYAduIQx0oAbWEQDog9RnLp5UDLEe/g1VQ4iD55jsmLFRInjp4wac=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPrCADr5nXVUvWq2srcCdDZkQr29mrUUuRQOqcfRI1m22WiJJ4
	lGISd/RvP+ZKNDmA8PbQBzCd8YXNUtvyzXwF54ldAfvHlomqWzTTjOdkfNVJylIO
X-Gm-Gg: ASbGnctqK7BnP79B4pPJXXYl+rgy2fOVkVXe0aOtIWcB3AALBld49GwzjhbGHYGLTzL
	gi+UEXA6UOIHwG5oAE9AD1SwP8l6fswLVfpPDk6ZuCnDQDjS6iuTppjjEBOScS5DEvmcOfMLBco
	YXpoC9z2RynKd8S7Sg298gDg2pP8IpHJqaf4jjzv4PXb55TnuwUhZxmhDZ9dc1AORvOSx6iBbnU
	BWEd7xPQ7z64qvSe5ewGjvX8/7uLpLAOW0/MLNrvKmxOUX++gSjBz0eORt/HXcqkJDYCW+cNrZh
	1WC1Vz+Xl5Xgk+wAwMWiRh/RjhDuvGbL8dcd0i8RMxqyLWmMosG4yfi0TciJZ90+bCgBACs/vB8
	iA81D77lMdu+JuT1IW7z8IqC1Cxy2mv+uqW2iWZlJWxw41LcAkb52nSAT+qRsfBJji24N8Y8FwA
	Yy20Ush5sL6gQuH9WbH6HM0ma4XeHEj6FUI4ZM2g==
X-Google-Smtp-Source: AGHT+IGmxg2joe/XoJEsFqk6v8MYcjGD+1xKcwbiFDMxnAvSsr7kMr34jrUMGa9e0utB19dSNMFr5A==
X-Received: by 2002:a05:6214:4c43:b0:880:32f6:5f0 with SMTP id 6a1803df08f44-88032f607a6mr16951096d6.64.1761901241249;
        Fri, 31 Oct 2025 02:00:41 -0700 (PDT)
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com. [209.85.219.41])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-880362d3c69sm8111326d6.29.2025.10.31.02.00.40
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Oct 2025 02:00:40 -0700 (PDT)
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-78f30dac856so23115216d6.2
        for <linux-pci@vger.kernel.org>; Fri, 31 Oct 2025 02:00:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVxrkTNES9197yg6SR8vdDaf7N9RUbTZp/Kd7ZCY4rc5st9GKeo86KYaMQBrP7Rx/bqUJP5whJxxgs=@vger.kernel.org
X-Received: by 2002:a05:6102:c13:b0:5d5:f6ae:38c6 with SMTP id
 ada2fe7eead31-5dbb136ecc7mr717064137.37.1761900747573; Fri, 31 Oct 2025
 01:52:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015071420.1173068-1-herve.codina@bootlin.com> <20251015071420.1173068-6-herve.codina@bootlin.com>
In-Reply-To: <20251015071420.1173068-6-herve.codina@bootlin.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 31 Oct 2025 09:52:16 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVnsWMB24BTFKwggEXKOtqJ96GWZh2Xz+ogocQHM+=+6Q@mail.gmail.com>
X-Gm-Features: AWmQ_bm5vGlc5XXZic8RvnXrZNNcCRnf0-7M9Km7uh4sqx0Aign1FjKoX2MZmow
Message-ID: <CAMuHMdVnsWMB24BTFKwggEXKOtqJ96GWZh2Xz+ogocQHM+=+6Q@mail.gmail.com>
Subject: Re: [PATCH v4 05/29] dt-bindings: bus: Add simple-platform-bus
To: Herve Codina <herve.codina@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Peter Rosin <peda@axentia.se>, 
	Arnd Bergmann <arnd@arndb.de>, Saravana Kannan <saravanak@google.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Charles Keepax <ckeepax@opensource.cirrus.com>, 
	Richard Fitzgerald <rf@opensource.cirrus.com>, David Rhodes <david.rhodes@cirrus.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Mark Brown <broonie@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Len Brown <lenb@kernel.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>, 
	Dave Jiang <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	Dan Williams <dan.j.williams@intel.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Wolfram Sang <wsa@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-clk@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-sound@vger.kernel.org, 
	patches@opensource.cirrus.com, linux-gpio@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org, 
	Allan Nielsen <allan.nielsen@microchip.com>, Horatiu Vultur <horatiu.vultur@microchip.com>, 
	Steen Hegelund <steen.hegelund@microchip.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Herv=C3=A9,

On Wed, 15 Oct 2025 at 09:17, Herve Codina <herve.codina@bootlin.com> wrote=
:
> A Simple Platform Bus is a transparent bus that doesn't need a specific
> driver to perform operations at bus level.
>
> Similar to simple-bus, a Simple Platform Bus allows to automatically
> instantiate devices connected to this bus.
>
> Those devices are instantiated only by the Simple Platform Bus probe
> function itself.
>
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Thanks for your patch!

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/bus/simple-platform-bus.yaml
> @@ -0,0 +1,50 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/bus/simple-platform-bus.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Simple Platform Bus
> +
> +maintainers:
> +  - Herve Codina <herve.codina@bootlin.com>
> +
> +description: |
> +  A Simple Platform Bus is a transparent bus that doesn't need a specifi=
c
> +  driver to perform operations at bus level.
> +
> +  Similar to simple-bus, a Simple Platform Bus allows to automatically
> +  instantiate devices connected to this bus. Those devices are instantia=
ted
> +  only by the Simple Platform Bus probe function itself.

So what are the differences with simple-bus? That its children are
instantiated "only by the Simple Platform Bus probe function itself"?
If that is the case, in which other places are simple-bus children
instantiated?

Do we need properties related to power-management (clocks, power-domains),
or will we need a "simple-pm-platform-bus" later? ;-)

FTR, I still think we wouldn't have needed the distinction between
"simple-bus" and "simple-pm-bus"...

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

