Return-Path: <linux-pci+bounces-13648-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D9598A4BE
	for <lists+linux-pci@lfdr.de>; Mon, 30 Sep 2024 15:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3D4D1F24171
	for <lists+linux-pci@lfdr.de>; Mon, 30 Sep 2024 13:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5023B18FDBE;
	Mon, 30 Sep 2024 13:23:55 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B11D18EFE0;
	Mon, 30 Sep 2024 13:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727702635; cv=none; b=UoOwMGW6goQn/ZhrmXaHXtHsMggu9cUsGTli3IXPUzNSyXONBnLB/SVHtLJZWcvJFPQm4LWoSKsI538MumRpAoEpMceqrXq64K/83nKwSvD61vt1pPADzNxx75AqX2z5V8WofwoJUTIeF7/vSl33l3k6ojx/A3fcuKOk3i7zoOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727702635; c=relaxed/simple;
	bh=NP8jjB23QLX+S3BSx5sj/XPrv18+qsyiocQiyL4WsKQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qOYeOeWGkMo+mIAjrr+NdVYJ9fN/5V1dcKN+xtaPj3VPwNyovDVtB4vqXqfQw43ZJykdcSMbEtK+p4RdTTTUeRjlk9S5278bRzqY0VzxD8ngUibLsHTSL2IbezdGRaN03pJ//GQVqIYHmPnt1p4QiOywClqn5szdkYjpjDQAzdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6e25f3748e0so13168407b3.0;
        Mon, 30 Sep 2024 06:23:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727702632; x=1728307432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XZEBwxrpoLE/VvANGlwD0fZQRFkLr5Jij21iFhSOg0E=;
        b=Ny+brfuRI0mD5jGft+XwV0ns+QULBfUaRHokH4l6opSGxQ/Ts2IFunUdOwcxcMYqvR
         BPnB7yWoTgQD01gTouoSukmJzk2q4R35oOV1FWsPhVY68aleH6ZE1PYj50JAoafVqSMh
         IHuGvhyav1/86KhMnBEQaRT7XK5PNqJRAM7OJckism28eAmwQl/dOnc8aPirtMM6zXH3
         09IzTcxVRKQ9TfykgxzH8YF25pr6gK1HiHA0vJRFPFYp52/v6vPalO9PDsiIhU0vhrDh
         uFBVq7jjWmcorMfzYOYMPsInZ+jk3A6FuBml2l1BZgpL17kG+SYvTptf36bv74mbPkWY
         liwg==
X-Forwarded-Encrypted: i=1; AJvYcCUTFkfjpjQnAtssSdAFa/xHw2hPa9G9GfmfUKBQIBFRzr1PQrAsI8ntYKQEfiYwz3gDe4B9UVC3ZPmp@vger.kernel.org, AJvYcCWFCvipBFthvROU+Y9wWOa3DdPlRUqAW3qBvFGYZAwFoh5X5vjGwYCJyCVZNzgxYo3OTU+m+hVX@vger.kernel.org, AJvYcCWGVMSwRWvi1oLDt4f1qO2vPN5fZu7Mi/65iYjcYdv6WpSk39lFrKcjpa8ctvsStHL93AbLgra1w9/WuUl4@vger.kernel.org, AJvYcCXBqxI43nFQ2jyBlYocJoingNPDbER3E8lwL7RjGoVUzt4av+K9EJZl1W0fOAYxxGlkmO8U+9WEJ23E@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2s3hMwR4s6i4G3kBAJliUZg7lYB2z+a8Gox/T1bVk7XBHGzaE
	qK3TFmCK/Ln+QkjrsvzxzAqFKs5ZyNjM49GO47d29J8mp1xDqNd1r8p/DrYK
X-Google-Smtp-Source: AGHT+IGLCnlU657xJcYU/8fHe95pp7TnjlS5Glm36BYWtS0N1BCldXcsEtAzK3PM1O9s1GCVcUaSKw==
X-Received: by 2002:a05:690c:4285:b0:6d7:f32:735b with SMTP id 00721157ae682-6e24759c116mr68881877b3.27.1727702631701;
        Mon, 30 Sep 2024 06:23:51 -0700 (PDT)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com. [209.85.128.170])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e2454a1dc9sm13480477b3.142.2024.09.30.06.23.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2024 06:23:51 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6e25f3748e0so13167997b3.0;
        Mon, 30 Sep 2024 06:23:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVMbdbgKtE3FE4bCYDvMaOinVTZJM7SY25+4sTCjhMXo6v8cidvEDvupA80tes0wkwoNqgg3P4v3yGj@vger.kernel.org, AJvYcCVeyQS82wYUgZblU2lfXUsTIRVY6ioJoCOg5MgYbOqBT2neZiHGjrSQzPNJzgJuwmX3Ry+yn6Av@vger.kernel.org, AJvYcCVxJ3KShLqjwbQn4q71izq/vp7Q0dVIUGFEebCmnI/xsAn57u5d7s86cNWDPO2kgvKPt72dyr0McXnD@vger.kernel.org, AJvYcCXDKSV3TDRNc5XBpXJu9FmQe9xeUIdPCsOmU4y6utHfABRTWWaQZAOM2SgkqtsSEQovTYEF3UYn7Phw+IuN@vger.kernel.org
X-Received: by 2002:a05:690c:26c6:b0:6e2:1b46:27c1 with SMTP id
 00721157ae682-6e24761f502mr54518597b3.45.1727702630751; Mon, 30 Sep 2024
 06:23:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930121601.172216-1-herve.codina@bootlin.com> <20240930121601.172216-3-herve.codina@bootlin.com>
In-Reply-To: <20240930121601.172216-3-herve.codina@bootlin.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 30 Sep 2024 15:23:37 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX97ESvg-htynOJC5408Hf1bKN46ji-fnuzr94wBcZSXw@mail.gmail.com>
Message-ID: <CAMuHMdX97ESvg-htynOJC5408Hf1bKN46ji-fnuzr94wBcZSXw@mail.gmail.com>
Subject: Re: [PATCH v6 2/7] reset: mchp: sparx5: Use the second reg item when
 cpu-syscon is not present
To: Herve Codina <herve.codina@bootlin.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Simon Horman <horms@kernel.org>, 
	Lee Jones <lee@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Derek Kiernan <derek.kiernan@amd.com>, 
	Dragan Cvetic <dragan.cvetic@amd.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Lars Povlsen <lars.povlsen@microchip.com>, Steen Hegelund <Steen.Hegelund@microchip.com>, 
	Daniel Machon <daniel.machon@microchip.com>, UNGLinuxDriver@microchip.com, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Horatiu Vultur <horatiu.vultur@microchip.com>, Andrew Lunn <andrew@lunn.ch>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, 
	Allan Nielsen <allan.nielsen@microchip.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Herv=C3=A9,

On Mon, Sep 30, 2024 at 2:16=E2=80=AFPM Herve Codina <herve.codina@bootlin.=
com> wrote:
> In the LAN966x PCI device use case, syscon cannot be used as syscon
> devices do not support removal [1]. A syscon device is a core "system"
> device and not a device available in some addon boards and so, it is not
> supposed to be removed.
>
> In order to remove the syscon usage, use a local mapping of a reg
> address range when cpu-syscon is not present.
>
> Link: https://lore.kernel.org/all/20240923100741.11277439@bootlin.com/ [1=
]
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Thanks for your patch!

> --- a/drivers/reset/reset-microchip-sparx5.c
> +++ b/drivers/reset/reset-microchip-sparx5.c
> @@ -114,8 +114,22 @@ static int mchp_sparx5_reset_probe(struct platform_d=
evice *pdev)
>                 return -ENOMEM;
>
>         err =3D mchp_sparx5_map_syscon(pdev, "cpu-syscon", &ctx->cpu_ctrl=
);
> -       if (err)
> +       switch (err) {
> +       case 0:
> +               break;
> +       case -ENODEV:
> +               /*
> +                * The cpu-syscon device is not available.
> +                * Fall back with IO mapping (i.e. mapping from reg prope=
rty).
> +                */
> +               err =3D mchp_sparx5_map_io(pdev, 1, &ctx->cpu_ctrl);
> +               if (err)
> +                       return err;
> +               break;
> +       default:
>                 return err;
> +       }
> +

This can be shortened to:

    if (err =3D=3D -ENODEV) {
            /*
             * The cpu-syscon device is not available.
             * Fall back with IO mapping (i.e. mapping from reg property).
             */
            err =3D mchp_sparx5_map_io(pdev, 1, &ctx->cpu_ctrl);
    }
    if (err)
            return err;

>         err =3D mchp_sparx5_map_io(pdev, 0, &ctx->gcb_ctrl);
>         if (err)
>                 return err;

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

