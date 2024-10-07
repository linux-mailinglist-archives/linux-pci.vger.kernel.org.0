Return-Path: <linux-pci+bounces-13964-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37028992C65
	for <lists+linux-pci@lfdr.de>; Mon,  7 Oct 2024 14:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBD931F2345D
	for <lists+linux-pci@lfdr.de>; Mon,  7 Oct 2024 12:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6619F1D2B1C;
	Mon,  7 Oct 2024 12:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Vtw9P60G"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454A81D1E65
	for <linux-pci@vger.kernel.org>; Mon,  7 Oct 2024 12:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728305502; cv=none; b=a6DWoEBsU7Ec1Eej/OZ5GhfGKaCbuNO5sO7asfcIBRuoTA1fIhxmZ9B7iOKPwJel+XP46NrKRheO8Frna5OHm6u5BbiqNUyD2FUmOdVg9Tp0UsMlPPk6g0nYOWAphbdLW2jmL9/5IB16gyCw+wOxL3enY/9G9fPuEKzmyA83dfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728305502; c=relaxed/simple;
	bh=ZY+AJobU3VtP9in1HQBCcNFt78s3OC/b6dpOI+pPkOI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ea+TAZRwg8fxKqcbyM5rVfJTVi31ve5Vrw5PFDTdgbxXuv4Qw0/YgpxFoHbtkjf5pWcCGpeX93hC2uLCXveAPfX/rW8VbPw/tZrxxSG1zIA0WSRI2jbYItClV/oc6OJWazUhtszghsmnetfdA3QoiOvCUDyLyT1iy8psseBDHdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Vtw9P60G; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5389e24a4d1so5243748e87.3
        for <linux-pci@vger.kernel.org>; Mon, 07 Oct 2024 05:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1728305497; x=1728910297; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CJZZqjDavpDNqoX3Dnp0JT4YOd4jBjyk18gDUm32hk8=;
        b=Vtw9P60Gsgv3KcNOVhtMZ4Qn28kREb+RxkFmejjQVmd12dRRQENJjySaT2BqEQHdIN
         FshiLxz1Vzqes4l5hbOXzD4wgH8d5bs7iAwgcDeEQf6+7OThsbfN3+vd+wZZPjnyW35O
         4mxUOcXtLRLdd87si+yBmgbvhMRbAl6NILVITo9q3CNMcSrcow/5IWqdqZoVsFe0+gik
         3B4mCzgcwoW9jekg7QffS2JytEJC23dIeaIxOH52TOqA/l+N2sD4VUoc3tAq4YQBptkV
         FejQgrtGpfK724fKpTTjTBJmeJ4z4GEbzxAXRWWzt62aLXzz3thF7qxobuXw6WdxM1ce
         TOQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728305497; x=1728910297;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CJZZqjDavpDNqoX3Dnp0JT4YOd4jBjyk18gDUm32hk8=;
        b=RR9AkxQSh87wcstNi9bZxADIVEdJK9jmsgKcznfGfjitGaMxIK8VMjcSu7vuIme3Zt
         IJHRGw7wqKso9gZ1bXoCcVx14mvwjXX0y4L6YUoY1C2Jg61si+TuiLuuK+1jPcYROlKR
         IRANHs2nsyO6ys0GFIMyscGmcwMaz9B6oL2oJoJUjdl3YbUlnxJeMvGMnVSlyhhGwZ+s
         xl/jW0lGTDH2HPvZpmHxbrCIa4oEZbiFGoo/wgSw59Pydena+iWthNW54TzAS3NfgJbu
         nkjo+Rm3/SbZcgLocdX5MqiFywCZBACxdJGPD98X+bPxRTobGrqnJDuPC1+Ic2uxin9d
         yepw==
X-Forwarded-Encrypted: i=1; AJvYcCXlZlpDKPKNX4vGTv0VCNmdgnjrPUlHJKVjDAEV3Vcblp2woXiSyliIXwpMFD7ElMDlgzkg4iRasSY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSN5lfrdC2vtT8tWGbGiyZoxGfpo6b0OPQ3JRe3Xkyh84zMMYP
	oyx6/JM+YqKYids5TZyHMFOUhHS7rVCleV6a/Cl9i48RqRq6EwwLY7EHP5yYwQ3IIoMt277Ds7w
	eL9hDX2SSaxjJ1jrM4XG9SYB9c+0/S5Wf+E/s+Q==
X-Google-Smtp-Source: AGHT+IH7G05Oq1wAPLX81gHtA6qQkBSJyJ5ZrwLIgA5etwfjuE+nckfvQey36fZR1usFS8D2Bkq3YweS9u4X4KFlv6g=
X-Received: by 2002:a05:6512:3088:b0:52f:368:5018 with SMTP id
 2adb3069b0e04-539ab8adce3mr5552359e87.43.1728305497097; Mon, 07 Oct 2024
 05:51:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1728300189.git.andrea.porta@suse.com> <c9a7d48fefd310941330a4c9892f7218b235e0c5.1728300189.git.andrea.porta@suse.com>
In-Reply-To: <c9a7d48fefd310941330a4c9892f7218b235e0c5.1728300189.git.andrea.porta@suse.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 7 Oct 2024 14:51:25 +0200
Message-ID: <CAMRc=MePbYdanhMH4FfHN4PRXT2HAcVyCgKndfthi0hJiSxo8Q@mail.gmail.com>
Subject: Re: [PATCH v2 07/14] gpiolib: Export symbol gpiochip_set_names()
To: Andrea della Porta <andrea.porta@suse.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Derek Kiernan <derek.kiernan@amd.com>, 
	Dragan Cvetic <dragan.cvetic@amd.com>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Saravana Kannan <saravanak@google.com>, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-gpio@vger.kernel.org, Masahiro Yamada <masahiroy@kernel.org>, 
	Stefan Wahren <wahrenst@gmx.net>, Herve Codina <herve.codina@bootlin.com>, 
	Luca Ceresoli <luca.ceresoli@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	Andrew Lunn <andrew@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 2:39=E2=80=AFPM Andrea della Porta <andrea.porta@sus=
e.com> wrote:
>
> Being able to assign gpio line names dynamically is a feature
> that could be used by drivers that do not have the exact naming
> (e.g. through the DTB/DTBO) at probing time.
> An example of this is the RP1 driver that populates the DT
> at late time through a DT overlay. In this case a custom overlay
> can be loaded from userspace with the gpio line names.
>
> Export gpiochip_set_names() to allow refreshing the gpio line
> names from the driver module.
>
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> ---
>  drivers/gpio/gpiolib.c      | 3 ++-
>  include/linux/gpio/driver.h | 3 +++
>  2 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index c6afbf434366..a2aa3560094a 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -522,7 +522,7 @@ static void gpiochip_set_desc_names(struct gpio_chip =
*gc)
>   * names belong to the underlying firmware node and should not be releas=
ed
>   * by the caller.
>   */
> -static int gpiochip_set_names(struct gpio_chip *chip)
> +int gpiochip_set_names(struct gpio_chip *chip)
>  {
>         struct gpio_device *gdev =3D chip->gpiodev;
>         struct device *dev =3D &gdev->dev;
> @@ -589,6 +589,7 @@ static int gpiochip_set_names(struct gpio_chip *chip)
>
>         return 0;
>  }
> +EXPORT_SYMBOL(gpiochip_set_names);
>
>  static unsigned long *gpiochip_allocate_mask(struct gpio_chip *gc)
>  {
> diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
> index 2dd7cb9cc270..6e4cd7b7e47e 100644
> --- a/include/linux/gpio/driver.h
> +++ b/include/linux/gpio/driver.h
> @@ -679,6 +679,9 @@ bool gpiochip_line_is_open_source(struct gpio_chip *g=
c, unsigned int offset);
>  bool gpiochip_line_is_persistent(struct gpio_chip *gc, unsigned int offs=
et);
>  bool gpiochip_line_is_valid(const struct gpio_chip *gc, unsigned int off=
set);
>
> +/* Assign gpio line names from device property */
> +int gpiochip_set_names(struct gpio_chip *chip);
> +
>  /* get driver data */
>  void *gpiochip_get_data(struct gpio_chip *gc);
>
> --
> 2.35.3
>

gpiochip_set_names() is definitely not ready to be used after a GPIO
chip has been registered. Please take a look at how we handle
synchronization of struct gpio_device and struct gpio_desc. You'd
probably need to rework that first.

Bartosz

