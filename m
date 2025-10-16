Return-Path: <linux-pci+bounces-38349-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8051FBE3498
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 14:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0CF65504D15
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 12:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1CF8327797;
	Thu, 16 Oct 2025 12:14:10 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1620F3254B9
	for <linux-pci@vger.kernel.org>; Thu, 16 Oct 2025 12:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760616850; cv=none; b=RlBWspIHuYQC83Heyx8St6FRY3zHAbxgkzW3CRYGjYdvRTYEEOqP+9Na2P9oB8X1zcd7otT483abX/f/hABQeXsMmPEXN5cbEuH+0PhccZ5ZCG4h9L5HrYWziBCVSg5Hdq2UWe/zwDyxB8iujmWUBSQgFcm171jtPRWHI7/Mtqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760616850; c=relaxed/simple;
	bh=Qljm2z2l5uF20OnzQWwo+pu0aWLXVl3TFALx6BWruW4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I3g5TKImBG29t5JX34vw7bOA7MY/La7Z3t154xNhPEbMdPU+SxHCQK8oj5q77n2OLYN+JT3n4bgJ9sKYQ0+mqi/QwXPBSMwVwoY/ptQaq2hdw7kzwKMdsp4bhtdUn4o1Ge00RV34Uk4aPYSfyGPR98ZKuFjA7VFx0JIwEciejdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-87c1f61ba98so1559496d6.0
        for <linux-pci@vger.kernel.org>; Thu, 16 Oct 2025 05:14:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760616848; x=1761221648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e3GThzLUFjGbl3VuQITKYi7/BLSw+ups+ZHEY60Y/84=;
        b=DN7jkgM9FvgppjeU48DfylXmRRpvlyZevpVrHpTLhcsnuZQHixtdgZhxwZ5yUWhLfs
         SzyJ23FAyD4SvAlMf63QMHlDk8ZcA4eAIoU/pXzo1TAW0aiaB4EztlU7w39nRIZjB7Hl
         tEbk/YoWZc1EkjPk52C5IF9oxUwfbyd+kkp4HXORcYeGK6tYw+ixibrT3Hd0ujn9HifH
         onXK+gxxTWx44AxjoUf8geReozlFAzul8ARWax1kjVOaWOsaIlqEDPaw6ZMT0E02Ildv
         pcmYZ88sGVUENOvAML/YOE+APquD41SXNjblu9eC+u9SourxyvZQWxe+nFLMNSnBnJwi
         Insg==
X-Forwarded-Encrypted: i=1; AJvYcCUU82C9ZiSnF8oOImMNBCAm3clhGUrEPALevNxV/QSPBvgrkxmoHgSl6aWd0fImU55fzQGt7Ws54g8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp73rqCCmZIegYhcdppQRq7NDiEfUQ0Rs5fK1PaPCboAKbP2hh
	PJvSJLjA2fmnZtoqLohoXfCB/2Qir76eEXbJ7j1SAT17M2fGFr16Y4UnMqwX+fB1
X-Gm-Gg: ASbGncsDeofOTMMX1F6EasXd2Zm9CbretzLSt19zxkt2jS4PjMkemXDuzKHjg/OGXhy
	40n0jX1nI9n7cymn+u0o7nmcbbnSvwqkjGfJJ2acbBh7YPfs8kFHgTqqu4igVU9MH+u4Tm1+5R7
	ASvviJSELZgZBP20+u6ggi/1na/5YCGHHe0vrTcCFz4QxlnxuJTFIJWob2/qqX5ekpsrAQIDoOA
	93qHfFG6BjBsg+cl0PLlCuvPKmVXLbnCsE1V22RgMjaVJCe8r8V9sboqBeaT6PWqLLDfD1kkDBG
	KC9VQbhQm1lEiIWrys7h4RMP4kmULjfO6+yJJvLyzhC+ciutc71jSnVzIb3y4M1vY6WS0Qn973j
	aETb9H+duKwOd0miMG3178lHfdbAAZwfUOu5aQROEiSK2XBQVr5CupSzWhRj79mVi9eNOEjshZs
	9Zok/jzQmKMInyUbeMFSCM5583XArJQGHLdrGahw==
X-Google-Smtp-Source: AGHT+IHUiZT58IMbynfa6qzmFoaJmri3bapMfn/0FpMju5YvFzDTgqVzXinwzS94lvqkI8FDI6AfWQ==
X-Received: by 2002:a05:6214:262d:b0:874:cfff:f6f5 with SMTP id 6a1803df08f44-87b2103b3ebmr522822076d6.28.1760616847623;
        Thu, 16 Oct 2025 05:14:07 -0700 (PDT)
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com. [209.85.219.50])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87c012b165asm38716046d6.59.2025.10.16.05.14.07
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 05:14:07 -0700 (PDT)
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-791fd6bffbaso11388136d6.3
        for <linux-pci@vger.kernel.org>; Thu, 16 Oct 2025 05:14:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVKNnLTTT9wtxgETjeeKtu3VaPXaCkDJP0TPp3QOr1Jx903sSpFtCaUZITe5X04irkoTNIUVRP+XaM=@vger.kernel.org
X-Received: by 2002:a05:6102:6c2:b0:4fb:ebe1:7db1 with SMTP id
 ada2fe7eead31-5d5e220448dmr12281536137.12.1760616407229; Thu, 16 Oct 2025
 05:06:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015232015.846282-1-robh@kernel.org> <CAMuHMdVBDN8-gWVs1f=1E2NgD6Dp4=ZFUnyzqHaQj9JWPpZepw@mail.gmail.com>
 <CAL_JsqL1KL4CvnxF5eQG2kN2VOxJ2Fh1yBx9=tqJEWOeg0DdzQ@mail.gmail.com>
In-Reply-To: <CAL_JsqL1KL4CvnxF5eQG2kN2VOxJ2Fh1yBx9=tqJEWOeg0DdzQ@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 16 Oct 2025 14:06:36 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUUZaL6qyuTZPoRc11WSuqcoRUFNksXZNJoijTeL+vfKQ@mail.gmail.com>
X-Gm-Features: AS18NWBH0cbPp0cJrT4sY267e4E8JBEuMEr4tkAtjK9DVXEqfelKr3ZBbd1AYGI
Message-ID: <CAMuHMdUUZaL6qyuTZPoRc11WSuqcoRUFNksXZNJoijTeL+vfKQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: Fix inconsistent quoting
To: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Stephen Boyd <sboyd@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Shawn Guo <shawnguo@kernel.org>, Fabio Estevam <festevam@gmail.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
	Jassi Brar <jassisinghbrar@gmail.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Lee Jones <lee@kernel.org>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Daire McNamara <daire.mcnamara@microchip.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Florian Fainelli <f.fainelli@gmail.com>, Tony Lindgren <tony@atomide.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-iio@vger.kernel.org, linux-media@vger.kernel.org, 
	netdev@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-phy@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Rob,

On Thu, 16 Oct 2025 at 13:46, Rob Herring <robh@kernel.org> wrote:
> On Thu, Oct 16, 2025 at 2:57=E2=80=AFAM Geert Uytterhoeven <geert@linux-m=
68k.org> wrote:
> > On Thu, 16 Oct 2025 at 01:20, Rob Herring (Arm) <robh@kernel.org> wrote=
:
> > > yamllint has gained a new check which checks for inconsistent quoting
> > > (mixed " and ' quotes within a file). Fix all the cases yamllint foun=
d
> > > so we can enable the check (once the check is in a release). Use
> > > whichever quoting is dominate in the file.
> > >
> > > Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> >
> > Thanks for your patch!
> >
> > Since you are mentioning mixed quotes, is one or the other preferred?
>
> I have a slight preference for single quotes.

OK, so outside human-readable descriptions, there should only be double
quotes in property values, i.e. on lines ending with a comma or a
semicolon.  Sounds like that can be scripted, or validated by scripting.

> > Shouldn't we try to be consistent across all files?
>
> I don't particularly care to change 915 files. And if the tools don't
> enforce it, I'm not going to do so in reviews.

Fair enough.

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

