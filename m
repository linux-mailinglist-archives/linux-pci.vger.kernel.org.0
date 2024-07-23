Return-Path: <linux-pci+bounces-10635-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CACE939BB0
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jul 2024 09:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4973F1F232AC
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jul 2024 07:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C0113D609;
	Tue, 23 Jul 2024 07:22:14 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B24513C68A;
	Tue, 23 Jul 2024 07:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721719334; cv=none; b=VvYo7oWaEkCB2kIDh/9ruOAcQF65KOQGNtAzI42ehm2JNc3LVg6rxIep8uNMpDjR7BpVLaNMwUV3GuEB7jcquxDF2JzpHVGwOmlUHwVfNR87UcHxDzaTQXLDG7DthBu5sRmw/hXimJSpDgSp5RZIe9wRx7aSUDvCJCLqpIWodlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721719334; c=relaxed/simple;
	bh=yZpum7RI2rSFJ32h7kQ5YDh1/k+uXdhnbV3adDGmyec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LU8AHHPhGNstHRHTA9Wul5ctZxHhZbdoF8u6o6OwqxAX2pw80t35Q1lPXnjmKi/+xKpMJcQhlxevXWhEVkHrqidT6W6JRHiTvKFGqXJUF0vO5YyYpDwtLiYlV2gYNH8TKZRVLu9pkZFTrXvf7/ZbOsuUUy10jndAWspmLCCGp/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-66ca536621cso20293787b3.3;
        Tue, 23 Jul 2024 00:22:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721719328; x=1722324128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mTdZefJGssY1b1nFywR6a45rF6PMOv6hEJZw7jG+AFM=;
        b=gVK9RZDkzgRcpSoePuUSquCNJgA9uU87ZAGER0vn7aZG2xwLcDg8BqHiyTSnyf0bYt
         bv0yXBTvi/dVuuWiW7Z7YZkFUCmJi8oiJSLWvhPRIWYBAi2iTB0svlDz/drXKNKRWqrH
         xnNcbAtxjnp9RMs/2p3Y/wp5dnY3pGF9aSVegHxROrceNWDL0mgcNV240gbA5JWKEII6
         bI6qHKveqAYvrnvU8EzIS8jbAa69XM7Nrww0VHizMVg+oEptCPkn6L02NxD9INWXVW+e
         QDbtDNrkRpmiLFI7lNY5KaRUniV055aMpENnHnEiQD8gQppBixdUhmx+j0qYgcUZJaUH
         9B0w==
X-Forwarded-Encrypted: i=1; AJvYcCVaDJ7nfBf9VMUXPgzaEN+1hXvBBGImDdw6FYIQxjlTHyDFq17bakdDYdjx6Grxl5TG+cDdqcQE8Se0MK5c/SIK0f/IJ/O5C/uBHF2FTzJFjQTAuWbLwYK1d14VIKJbEanoJEHiePZDD39FUVFNT8N/YEjoz38Q/u66Gsr10O1filI8DmCjNf1vd7ly617S9u6RMSeIuCtR0nnA9A==
X-Gm-Message-State: AOJu0YyHbMXm4pXW4ohnyimRjBu3WKQXDxXfmxtFX4D9ocpr+X/cj1jK
	BWbyZLILMt5rUJbHnhvOh4WGYo4+ty+dN71ZcMl6+UyZVoSlsdfgyFVpUzpG
X-Google-Smtp-Source: AGHT+IH1ZQ1jGv0iZJjUNbP2rA/3hGPOiLe5y/jfgulRZ1GCFgQL8+3+6iNnBjGv9AjXradJQrTcYA==
X-Received: by 2002:a05:690c:108:b0:65f:8973:31a2 with SMTP id 00721157ae682-66e4bdbd22fmr29764037b3.13.1721719328645;
        Tue, 23 Jul 2024 00:22:08 -0700 (PDT)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-66952940dcasm19267387b3.74.2024.07.23.00.22.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 00:22:08 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-65fe1239f12so43108227b3.0;
        Tue, 23 Jul 2024 00:22:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUIFFn2GnhLIXt6eSJELVlLO6i4UOnoNVNcOqMwMiwTXmwU9/noTL9fCicKBj0fnnQNi6cAzKNQ1XgXMeTWWEnF0UWSQQkQ0aFWDspssnh1S75KhQ2rS3ob0Sh3zERJLEYhm5St9x9rsr4I59naedhEPxuj1S06lCxjyq1WApKsWAlIrLbwyYiRNmIkFXFuqzU7QOyvm65LTqd2Hg==
X-Received: by 2002:a05:690c:408f:b0:630:f6b0:6c3d with SMTP id
 00721157ae682-66e4c57cc12mr19744927b3.23.1721719326975; Tue, 23 Jul 2024
 00:22:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240627091137.370572-1-herve.codina@bootlin.com> <20240627091137.370572-3-herve.codina@bootlin.com>
In-Reply-To: <20240627091137.370572-3-herve.codina@bootlin.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 23 Jul 2024 09:21:54 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVeAK-2xRzf=kSO5Z9JGR7VTz=vEDHBW5190cctUNFj-g@mail.gmail.com>
Message-ID: <CAMuHMdVeAK-2xRzf=kSO5Z9JGR7VTz=vEDHBW5190cctUNFj-g@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] reset: mchp: sparx5: Remove dependencies and allow
 building as a module
To: Herve Codina <herve.codina@bootlin.com>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Simon Horman <horms@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Lee Jones <lee@kernel.org>, Arnd Bergmann <arnd@arndb.de>, UNGLinuxDriver@microchip.com, 
	Saravana Kannan <saravanak@google.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Lars Povlsen <lars.povlsen@microchip.com>, 
	Steen Hegelund <Steen.Hegelund@microchip.com>, Daniel Machon <daniel.machon@microchip.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Horatiu Vultur <horatiu.vultur@microchip.com>, Andrew Lunn <andrew@lunn.ch>, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	netdev@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, 
	Allan Nielsen <allan.nielsen@microchip.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Herv=C3=A9 and Cl=C3=A9ment,

On Thu, Jun 27, 2024 at 11:13=E2=80=AFAM Herve Codina <herve.codina@bootlin=
.com> wrote:
> From: Cl=C3=A9ment L=C3=A9ger <clement.leger@bootlin.com>
>
> The sparx5 reset controller depends on the SPARX5 architecture or the
> LAN966x SoC.
>
> This reset controller can be used by the LAN966x PCI device and so it
> needs to be available on all architectures.
> Also the LAN966x PCI device driver can be built as a module and this
> reset controller driver has no reason to be a builtin driver in that
> case.
>
> Signed-off-by: Cl=C3=A9ment L=C3=A9ger <clement.leger@bootlin.com>
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Thanks for your patch!

> --- a/drivers/reset/Kconfig
> +++ b/drivers/reset/Kconfig
> @@ -124,8 +124,7 @@ config RESET_LPC18XX
>           This enables the reset controller driver for NXP LPC18xx/43xx S=
oCs.
>
>  config RESET_MCHP_SPARX5
> -       bool "Microchip Sparx5 reset driver"
> -       depends on ARCH_SPARX5 || SOC_LAN966 || COMPILE_TEST
> +       tristate "Microchip Sparx5 reset driver"

This opens up the question to everyone, so I'd rather add a dependency
on MFD_LAN966X_PCI.

>         default y if SPARX5_SWITCH
>         select MFD_SYSCON
>         help

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

