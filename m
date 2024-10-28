Return-Path: <linux-pci+bounces-15500-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 578939B3D98
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2024 23:18:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88F281C21667
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2024 22:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6B71EBA14;
	Mon, 28 Oct 2024 22:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BhvBuG7R"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98341E0B63
	for <linux-pci@vger.kernel.org>; Mon, 28 Oct 2024 22:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730153930; cv=none; b=CCCqLwMZaC7/vFGEFWY+57KG07kaAJh4HMQLirlXR3Iv7a+SSJ2swd66YhGO3CAHVgBCXZD9AIBp/a6tdkM4MoZQHBWIM55VQnja8/SJP9KJFjEe4D+pqQdjRrjuKhAvu8W+kct9M3r/tlZQKhsXsMkhH4zjkDTa3jTPwCCWRIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730153930; c=relaxed/simple;
	bh=fyDzP1KDNX4YUcpzq6bZDMAMYCXTmjZ5IQwgWmqRgvE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KwKnfX7VWCxmiySd2ui6hb4ag8S5UJuirTKRcfV3KDG50vx1YWUdRhAQ94WS1mlMtC7NYzJTLaqMaWJPKp+Dh+eP5XyoIxJqtcU7NqO4kyhjoeEBKwwH8vrT4SjPs3IuY1gh7XIt7ER/7xu99iyES+EXLonRenxkZyIOjijrRjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BhvBuG7R; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2fb561f273eso43233851fa.2
        for <linux-pci@vger.kernel.org>; Mon, 28 Oct 2024 15:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730153927; x=1730758727; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Se9iykGyBG/chmZUoFvEpKM3NIz9y6V7vYmAmFmIKg=;
        b=BhvBuG7RO4OmO67/x4sJ/xTIjH/D5lvsAqSvJ2S9uLwRhhxl21fJ+BYWVRnfQVYrKR
         uKIsmfHcZt0nsZapDx+Vo0XUHHB65gvvb5z5YL5WmJg3BUy8oe20Zm/FixIWGLhJQffy
         0w++IT0fGuwvKFJ7dFfL+JRRSm8A/E03KGQzUT+8dXZJcNq33H6auF9moaS7bABPlbvO
         ehHwQG5+ghl0qTieKnMjTrMaNpVysS0FdHNceaSANTwsa0hfajDU+LflxUCPu6PCEyDr
         gEosHgOhrwBh8HwxZXQJjxEMsSwN5heebon3PhN7kL7uBA2bGq8L5Sjs2ORr+ATQBG8I
         b7xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730153927; x=1730758727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Se9iykGyBG/chmZUoFvEpKM3NIz9y6V7vYmAmFmIKg=;
        b=wA9zrQxKcfvOMG43Gv5GVMyhxmksijf8zd7JlUwU5DdVjNFwPpiQImeIyW+CSGaz2j
         bWbEtDdBtSrBdBfTnYo5eemLIJCTU14+hsG+1RRSBITo4Xb7hHR+5qbEiNrZWj9Nazfl
         M7whQo8tYnF0qAV+AOxmU3ABQHJBvmJNxdZJXyNxxuSo0Sgv3tNmxBz1DuCZnK9cDINi
         5X/cNDuXCkvJqtgnHBfSVcSLgXqmReGMqAve201evJyz9B7ANOpwcxxwb37fwpDzUsuq
         VeU9E3e5Ldidugop+5DRNikoMcUVYALCbaQIl2snJatDS9b2iIfdz6U7EGYcOzxNTVg7
         xFTg==
X-Forwarded-Encrypted: i=1; AJvYcCWjMghv+flixFgTWssT3v9BuCHOH40bJz0vO3yJg5qb15pWKNyhEncXJ47QLbG8ogyzTPJI9A7BL3c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFOUTlhPctJklCHLjfkbibf55goLX57mDxckEI+c49Mg4P1VjQ
	AqSmaNJTSp0GJHsluX1pO+pZzJKoGKiHYNmkyF6Ofsp9rjdUZsEgX0GQdzYMcpT5c+no55BkGYS
	bjQR5WIbX97fU5DlEtXy3P0WxPOqSQBGwbtfB0g==
X-Google-Smtp-Source: AGHT+IHaahqy5DPShaY8Y+oAdhFIt+zH9Ye+ooBv20FjvxHxSAXvsJDg8v4Gn3ijuKz+t3/EBWpVyq1RsiK+6mnMrto=
X-Received: by 2002:a2e:be9f:0:b0:2fb:5bb8:7c00 with SMTP id
 38308e7fff4ca-2fcbdf5f01emr41441461fa.2.1730153927011; Mon, 28 Oct 2024
 15:18:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1730123575.git.andrea.porta@suse.com> <b189173d893f300e81b18844a1c164fe4ad5bc20.1730123575.git.andrea.porta@suse.com>
In-Reply-To: <b189173d893f300e81b18844a1c164fe4ad5bc20.1730123575.git.andrea.porta@suse.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 28 Oct 2024 23:18:36 +0100
Message-ID: <CACRpkdajY9efD_DMwoE0wpKDVf=+kcWzYQXOQMHC+pQS-ntsvA@mail.gmail.com>
Subject: Re: [PATCH v3 08/12] pinctrl: rp1: Implement RaspberryPi RP1 gpio support
To: Andrea della Porta <andrea.porta@suse.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof Wilczynski <kw@linux.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Derek Kiernan <derek.kiernan@amd.com>, 
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

On Mon, Oct 28, 2024 at 3:07=E2=80=AFPM Andrea della Porta
<andrea.porta@suse.com> wrote:

> +config PINCTRL_RP1
> +       bool "Pinctrl driver for RP1"
> +       select PINMUX
> +       select PINCONF
> +       select GENERIC_PINCONF
> +       select GPIOLIB
> +       select GPIOLIB_IRQCHIP

Just a quick thing:

You don't happen to want:
depends on MISC_RP1
default MISC_RP1

So it will always come in tandem with
MISC_RP1?

Yours,
Linus Walleij

