Return-Path: <linux-pci+bounces-22035-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B5EA4015D
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 21:53:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE0A819C68F3
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 20:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68FF7253B65;
	Fri, 21 Feb 2025 20:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="SF8IWEYQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838FB2512FC
	for <linux-pci@vger.kernel.org>; Fri, 21 Feb 2025 20:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740171225; cv=none; b=JTtnpAkzL1kX1EjrnJyhHMbM3boorlCLjYMHQwoRgzLlm1X9d9I1ID+Q5uz4g/Lpv9M/Cd5ES4fqycpIxYqBZM+ojuXfdH9NRs7b51yhdrpXVdSakuol8GBH3Co4UjBR32tNDfgWW4xa02dXK5H/71seZjhSfAEF1gfggajYmT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740171225; c=relaxed/simple;
	bh=dSU/Y3o79Oen+g1y/O2ttt6++fluDHaGys/I35lxh6k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S/bGSdtM0JSSwjudHXHWs9wXeWNNh1lUU2xCFE+tvMSbksQp+l4e3o9ChetrnxAajeyvSh4qnvqZNBBl29Iq8Lb0J5vAcPbQIXvtMLgVAxLqIH2x8SkvNWXNV2+jphLYjLGuNQwDzKqtctKx6TQm+XqaVmWSAivgyFUDQSMBFs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=SF8IWEYQ; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-54838cd334cso1382144e87.1
        for <linux-pci@vger.kernel.org>; Fri, 21 Feb 2025 12:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1740171220; x=1740776020; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UITCx65oXgxoWzlkKQSoCgIUC5y2VPjQ1zm26AHbirA=;
        b=SF8IWEYQsSj+XugpzSYdcWrLU+pyPwXutM8Xw3ZtOoTMFS6s0HLaoWvbvZI8qwWNNU
         DtzcLZn9wr2oDWmKX89/FOwuq9Y9Yj9q/fAwCe4U+89kVy7b8tTrfTCtsJ5/uFYh9RV3
         UPHuXCeVgvujLFdlQ7zGPYKqKzlRUChO2TTex9OtYeYFIpBOyZy9+9siYGf13rZ3xQWB
         WRuUNMTxYuMnaaJ0Iefmi7lVj+DRnmLgXqVZ6RGedV3YRAS+lMJMvtCEZLbajYmr4gyK
         5CN+4Uayo+MKi4sO3URdRcmNeVcCq87cmkujk1ZWKyCM2qMauq35YTkrBqy76wqWkuOQ
         QkcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740171220; x=1740776020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UITCx65oXgxoWzlkKQSoCgIUC5y2VPjQ1zm26AHbirA=;
        b=VayGUNM2QTqSQC+e+TL1abz5QZHrOVoSsC+TGnupWi+zaQPQKOjOYVc1MAMsQmz+9p
         Q4PjPM+D3JKT8rha8vmLMOQcX7y5zu1QmK5nLNu9IxhVZAgCFnETsW42xxQpD6Cp6p0g
         dqKNWsChaGTX2cFU0HhnEOcAN3D/JE1Dy2LZbVuvbjWxZirKDiLAuU+YnCkrZNO/xvMq
         hKjOMVKZi/lfJ90hNEr3XtGm9X8sms0fBBoYZuHE3sgOKAUWPUZ61OpcmeLhm34vi457
         IXYKw39IkT1ZTGomya6T6qztewj2ugjYtgFfYtYfdWDKgVxsdrcDgdrRuPDYx1e6S1xN
         k16w==
X-Forwarded-Encrypted: i=1; AJvYcCWkGKPSUxl1SlY2Lekn/KLgyGvzaiqICa3V2czorAp8f9J43ZbIIF9Xk1KSR/RmOP5roPpgUoeCo14=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGkkuAClIJwwnuKsdB4ILnc2gA90crKrqbxKLD1MAFVHcgBDBd
	txqHujokanAlfA9fqHxu4CRAQ2Q5lTNFOkaLzWeTVNULFIhDaOvNGnL1SHNi8gvMHTHA40PTOuy
	ZRjo8yyP9K9jNMYv5arlKqAOT9Y+ZIb909+A0QQ==
X-Gm-Gg: ASbGnctGSdh8qMaEqrLlnnEbcJ1AUqr9Ik5qs2GPHN06wC6Ziz8HAzn0IBccafh4oXq
	eNGOElkjQGlsvWfAJ0GHs3neJczN6TuR3YS/0VvEHq2WPblA4kMrYH7UYWQGrssOJIKQG90j6dP
	D+5F8Cvr4Iyb6NArJxz0bZ0xnS+kPL/9x+2L6Qzq4=
X-Google-Smtp-Source: AGHT+IHD/faqLIAxxrUSThF+7Z4ObfCPG5tjOZ5Cb1dKYqP7WiY8zwWQ1Hl9LkauFsK7X0DzVWW2HZxHARnzix6VVHM=
X-Received: by 2002:a05:6512:3f17:b0:545:a1a:556b with SMTP id
 2adb3069b0e04-54838d3e458mr1895563e87.0.1740171220459; Fri, 21 Feb 2025
 12:53:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <9ded85ef-46f1-4682-aabd-531401b511e5@molgen.mpg.de>
In-Reply-To: <9ded85ef-46f1-4682-aabd-531401b511e5@molgen.mpg.de>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 21 Feb 2025 21:53:28 +0100
X-Gm-Features: AWEUYZmvifQGO9hr4odqPIoAEg6jEmQa9XkbaEe-eZbr42YtXkTTJk53aPtcyJY
Message-ID: <CAMRc=McJpGMgaUDM2fHZUD7YMi2PBMcWhDWN8dU0MAr911BvXw@mail.gmail.com>
Subject: Re: Linux logs new warning `gpio gpiochip0: gpiochip_add_data_with_key:
 get_direction failed: -22`
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org, 
	regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 9:40=E2=80=AFPM Paul Menzel <pmenzel@molgen.mpg.de>=
 wrote:
>
> Dear Bartosz,
>
>
> On the Intel Kaby Lake Dell XPS 13 9360, Linux 6.14-rc3+ with your
> commit 9d846b1aebbe (gpiolib: check the return value of
> gpio_chip::get_direction()) prints 52 new warnings:
>
>      $ dmesg
>      [=E2=80=A6]
>      [    0.000000] DMI: Dell Inc. XPS 13 9360/0596KF, BIOS 2.21.0
> 06/02/2022
>      [=E2=80=A6]
>      [    5.148927] pci 0000:00:1d.0: PCI bridge to [bus 3c]
>      [    5.150955] gpio gpiochip0: gpiochip_add_data_with_key:
> get_direction failed: -22
>      [50 times the same]
>      [    5.151639] gpio gpiochip0: gpiochip_add_data_with_key:
> get_direction failed: -22
>      [    5.151768] ACPI: PCI: Interrupt link LNKA configured for IRQ 11
>      [=E2=80=A6]
>      $ lspci -nn -k -s 1d.0
>      00:1d.0 PCI bridge [0604]: Intel Corporation Sunrise Point-LP PCI
> Express Root Port #9 [8086:9d18] (rev f1)
>         Subsystem: Dell Device [1028:075b]
>         Kernel driver in use: pcieport
>
> Judging from the commit messages, this is expected. But what should a
> user seeing this do now?
>
> Also, it probably should not be applied to the stable series, as people
> might monitor warnings and new warnings in stable series might be
> unexpected.
>
>
> Kind regards,
>
> Paul
>
>
> [1]:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3D9d846b1aebbe488f245f1aa463802ff9c34cc078
>

Hi!

What GPIO driver is it using? It's likely that it's not using the
provider API correctly and this change uncovered it, I'd like to take
a look at it and fix it.

Bart

