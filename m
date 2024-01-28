Return-Path: <linux-pci+bounces-2623-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2391C83F26D
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jan 2024 01:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D7A5B23B0F
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jan 2024 00:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28A381E;
	Sun, 28 Jan 2024 00:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Knd4iKg1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58D97FD
	for <linux-pci@vger.kernel.org>; Sun, 28 Jan 2024 00:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706400783; cv=none; b=P0RdsfixDzPIcL1saIa0JWS1Vc/2taNRrg7b3S7xV+MaCkkeDPWVD/anlKG20Rbdy773H3vdEg9CNOJK4hgzcqX5rGoZ9uaXAVahJTfi1IR/tLFvlzpbN635KrbbkWJiuOwtOt3RfyJEdmqzriruw13ffrdbBl1Ukwf3H60kJ7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706400783; c=relaxed/simple;
	bh=s382zJRyJ6x/m0CqRGyW8m+O+mRKPthrymTT1vXT0ds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=inUxsmIKKnpgGrXM2rpSbarASeCRHWamtFmYn14NZgRhelD4vdbmxnehCsVQ5GOMuy0NFToquRpXKyXDOp01FoUbwvAgsoYQFeLqdWjHgi+4vnp7lVB7/yU83dcwrj2mLTw0TV+TO3asviawYzhJmNeYTRCcTFiRl9fWGLm/cIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Knd4iKg1; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-602ab446cd8so16316977b3.1
        for <linux-pci@vger.kernel.org>; Sat, 27 Jan 2024 16:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706400781; x=1707005581; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s382zJRyJ6x/m0CqRGyW8m+O+mRKPthrymTT1vXT0ds=;
        b=Knd4iKg18Z4f0c8GB15trf0zkYf10XvmbfR5oXYzrrhmQUjpmU9uoDvHZvi3hWtwUy
         pallI8zTdUyh0weWLu1Gfuer47d+3tUawW4tJjSrfmOBJ4asFkkNwGp1Gz2EAPtcS1LL
         x5goR1nqRi6Ib+VCLFygbtkPW3Tqao/24HSqOOrLerpHgX9LrebCCLT3IzfntwHLSf/l
         5OaJ+ZMj6QUT8rjl4XuTnEX9B3oe9trxxKOzpFCejA/2s/x3+TNkpjvDiS5kjl0PQt9y
         d8nCeUyjIPsnwz5gh5leGsrloqmj4Uhpfy16wAUhrvrdWelLB9/4ua7VfTzuB/2tYMoJ
         5CIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706400781; x=1707005581;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s382zJRyJ6x/m0CqRGyW8m+O+mRKPthrymTT1vXT0ds=;
        b=Ks/j0p2An28m5k6kx5fgDMccrJGZAEyWJ+XV11rUhMmqdsfShXBaxYR8ZszKENHbWa
         L8cycsH6SwLWepLhuYvGG/eu6K+NRR/TmdnS+HiNHRy9aQhIqDYHvmMBLWZTnOF6JetL
         dvvu9Lq7O1oKaHacyqz2MckXMwB6/QefFjE773aTe89HNNLdgVOMGvtDeDiaroUwQpZ0
         n/9sUVTKP/kjjNNu8AsMFkmlM4spIGiOmZxIeuhS/N3tFDGpYVpEAQFr1WrxZZ/7tqJr
         R1UeLHYnaozZW4jOOFjlTH1/A7l1SYQ03FqVxE1mdk3E5yYHnyyXzzC3r3k4+sR0QSqC
         O94Q==
X-Gm-Message-State: AOJu0YxOJaW1GmA4CvkckLk5AjQOV7CuMpM5Ocit7L/qNbw0N5F+/tup
	tbzy+/F7WtMQBuWySYjkIg1lxj02mW+Q2o3AX9buK5SXkSkvGoUD50kul1v+Mb/KcjHQyl9Gc9j
	j63B/c9/6uVhl9JsCFfZu5Ybs0K0fx+MMiRrGYQ==
X-Google-Smtp-Source: AGHT+IEZVSZUzzjxzZn0Av2/7INObuTua3Mia5HKhwhoo7tJ2m/wqcv1w98aBP4XbcXGiLtyHqQ0OWN/g5UmL4382Eg=
X-Received: by 2002:a81:4426:0:b0:602:c9ad:f979 with SMTP id
 r38-20020a814426000000b00602c9adf979mr1944880ywa.75.1706400780839; Sat, 27
 Jan 2024 16:13:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240102-j7200-pcie-s2r-v1-0-84e55da52400@bootlin.com>
 <20240102-j7200-pcie-s2r-v1-1-84e55da52400@bootlin.com> <20240116074333.GO5185@atomide.com>
 <31c42f08-7d5e-4b91-87e9-bfc7e2cfdefe@bootlin.com>
In-Reply-To: <31c42f08-7d5e-4b91-87e9-bfc7e2cfdefe@bootlin.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sun, 28 Jan 2024 01:12:50 +0100
Message-ID: <CACRpkdYUVbFoDq91uLbUy8twtG_AiD+CY2+nqzCyHV7ZyBC3sA@mail.gmail.com>
Subject: Re: [PATCH 01/14] gpio: pca953x: move suspend/resume to suspend_noirq/resume_noirq
To: Thomas Richard <thomas.richard@bootlin.com>
Cc: Tony Lindgren <tony@atomide.com>, Bartosz Golaszewski <brgl@bgdev.pl>, Andy Shevchenko <andy@kernel.org>, 
	Haojian Zhuang <haojian.zhuang@linaro.org>, Vignesh R <vigneshr@ti.com>, 
	Aaro Koskinen <aaro.koskinen@iki.fi>, Janusz Krzysztofik <jmkrzyszt@gmail.com>, 
	Andi Shyti <andi.shyti@kernel.org>, Peter Rosin <peda@axentia.se>, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Tom Joseph <tjoseph@cadence.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-pci@vger.kernel.org, 
	gregory.clement@bootlin.com, theo.lebrun@bootlin.com, 
	thomas.petazzoni@bootlin.com, u-kumar1@ti.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 6:01=E2=80=AFPM Thomas Richard
<thomas.richard@bootlin.com> wrote:
> On 1/16/24 08:43, Tony Lindgren wrote:
> > * Thomas Richard <thomas.richard@bootlin.com> [240115 16:16]:
> >> Some IOs can be needed during suspend_noirq/resume_noirq.
> >> So move suspend/resume callbacks to noirq.
> >
> > So have you checked that the pca953x_save_context() and restore works
> > this way? There's i2c traffic and regulators may sleep.. I wonder if
> > you instead just need to leave gpio-pca953x enabled in some cases
> > instead?
> >
>
> Yes I tested it, and it works (with my setup).
> But this patch may have an impact for other people.
> How could I leave it enabled in some cases ?

I guess you could define both pca953x_suspend() and
pca953x_suspend_noirq() and selectively bail out on one
path on some systems?

Worst case using if (of_machine_is_compatible("my,machine"))...

Yours,
Linus Walleij

