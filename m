Return-Path: <linux-pci+bounces-38307-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B54BE2148
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 10:03:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DBEB14E5E8E
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 08:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE76F30103C;
	Thu, 16 Oct 2025 08:02:22 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9CC2FFF9B
	for <linux-pci@vger.kernel.org>; Thu, 16 Oct 2025 08:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760601742; cv=none; b=TqF05fsnyD55nOUgydk0bib+CKH7WuZZdXmG6JUKxpI2T06n9M59p2vzwJg1vPKO/mEYsn6jZVHUHkgMg/1DQvuz6nwG5C4UKtGBhmPJ1k31UUNGEBBNFJ1MyfoL/8iBsQTg4wuZt3GLqJm/KiISrqsw3kQ5zxOOCqDoP5wZelY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760601742; c=relaxed/simple;
	bh=1eGQTAnWNGY3mGah0Neq02H/T5/f9gtIvSd+fn8FW2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bUqEY2pZ2rvVJRbLQnmW3LV/ZwI3GJzJxVLa06lTyUk6XXxRDGsWk9G6iqiBk6HYR3FyoyEPNkWL8Epromap0p+szq2ZucDmgN10awbMe6u4xo+KxDgLNSYqzokOnRBxEgdZVUbGV4kMM8Gu14ugxmOK6aB/iLwdUMYCadiF90M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-81efcad9c90so8394896d6.0
        for <linux-pci@vger.kernel.org>; Thu, 16 Oct 2025 01:02:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760601740; x=1761206540;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kd9DhXGFTz7VluvF3CXaOYryMfT47ujx56ubcyYXsIw=;
        b=cWuF+2k89MEvYWrSosO+bmPpx5mmxDgYEgqj7C0i6Q7a3d2DbVBACv+NtAvbwt0AEL
         YtCLJOlShuxfFX2etE0v15+qj6gWkN45Q92KTqgOW8XFgyVYsYIBHyN0MO6zCBiGxIZk
         SEkDUc1djUEers5Qap5y/tODTnJ9mvlFQKTVSHao6+02k20j8fH3ThexldC9NgPXU/hW
         DtKeOVXKF7TWDayx1RpcHD0RDKBtj6dpmQ3TJmr+nqIjm3lOQJTUcAsbYydRNLAi9iUP
         ZvfkCo0aKbbt4uriyCKQcdwyo0Jhnon/9BSl5qjgh4FUL1A7BicG5k5kfYaRYYVPoPKL
         WwVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdBs50OqyRw0viswR1Ra0VwKvwi9u4vM2Jz+pJGcONYxToE/YiQ9nunA0caGscyCP29s1fYvyso7A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzcMtqSxhgFSoEuOOqjAZHVTLkC++kkkWbuc/TTo2g2JA/mVay
	iTT0m/HkabumfXgDt2lr5lprxEAwLqgqmsailX4kSorGgqpXocB2U+AVPqixDgHu
X-Gm-Gg: ASbGnctCO5BDX4L0hzJTUrmP6EOJ4WSPFVctm3rD28vJJ7gfbuQdkNqZkIz8e+7vBCI
	u3LIgOOm8MdR0GYc31SxlbtUg3akWvEC7Gf3Bhlmi90tH671W5GEpb+PhVRnSpqyyBb7vYJ+mwQ
	1UqQjPgm1feuKz1nlzn4ZZ84JbQYfx0ho43+s6Khblbv5MOfbsTsdskrx3PzT4RwoziXmzGKVJh
	PjfABfqaLeHmjaCZCigu9Q2tmywvA07VJh6gi3tD9TaEa0K+CW+o9PdhA18RCXiODDgakjsqFej
	EtEZcAwpCENKX70EanvXg00ydrhP2PbEBADMNTDuB7lWmr4LYI7wYI09uEAh0baxVC83NbzQrr9
	r3fOcB/ZmsceYm+kvFRZMp8oHmyAChvtlPKQtGQZgkp0pO92twwJUDstO6MohAIgYbEmKrPwt5t
	Dig6so5QyhGH0/ajDOVpTjiLDXB+KcVCZBHYAAdvbjlg==
X-Google-Smtp-Source: AGHT+IEqqa5KIf7byEgln2Si2X7CndrabFa7FpME6/LARqIj/l0w9dy1uEqd4ZYZIm13LO0poyuNuQ==
X-Received: by 2002:a05:6214:e4a:b0:87a:a83:e706 with SMTP id 6a1803df08f44-87b21015289mr439732546d6.14.1760601739646;
        Thu, 16 Oct 2025 01:02:19 -0700 (PDT)
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com. [209.85.222.172])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87c012a79f9sm34587826d6.53.2025.10.16.01.02.19
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 01:02:19 -0700 (PDT)
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-85e76e886a0so62251085a.1
        for <linux-pci@vger.kernel.org>; Thu, 16 Oct 2025 01:02:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW2aYyZs3X8QBzW+k/UcXVQ+vMiRu8RGRdJLmEI53NlNO8plCgY0kYFQiPsN3ToakJQs28B61AE3zo=@vger.kernel.org
X-Received: by 2002:a05:6102:512a:b0:519:534a:6c20 with SMTP id
 ada2fe7eead31-5d5e23afcd1mr10705349137.30.1760601430958; Thu, 16 Oct 2025
 00:57:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015232015.846282-1-robh@kernel.org>
In-Reply-To: <20251015232015.846282-1-robh@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 16 Oct 2025 09:56:59 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVBDN8-gWVs1f=1E2NgD6Dp4=ZFUnyzqHaQj9JWPpZepw@mail.gmail.com>
X-Gm-Features: AS18NWDjBoTWi0arzS-uHQaIyzTZ8PYUb4ECqZaEUF0sSO-4JEe-m7M7qjhxsvY
Message-ID: <CAMuHMdVBDN8-gWVs1f=1E2NgD6Dp4=ZFUnyzqHaQj9JWPpZepw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: Fix inconsistent quoting
To: "Rob Herring (Arm)" <robh@kernel.org>
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

Hi Rob,

On Thu, 16 Oct 2025 at 01:20, Rob Herring (Arm) <robh@kernel.org> wrote:
> yamllint has gained a new check which checks for inconsistent quoting
> (mixed " and ' quotes within a file). Fix all the cases yamllint found
> so we can enable the check (once the check is in a release). Use
> whichever quoting is dominate in the file.
>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Thanks for your patch!

Since you are mentioning mixed quotes, is one or the other preferred?
Shouldn't we try to be consistent across all files?

> --- a/Documentation/devicetree/bindings/pinctrl/renesas,pfc.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/renesas,pfc.yaml
> @@ -129,7 +129,7 @@ additionalProperties:
>
>      - type: object
>        additionalProperties:
> -        $ref: "#/additionalProperties/anyOf/0"
> +        $ref: '#/additionalProperties/anyOf/0'
>
>  examples:
>    - |
> @@ -190,7 +190,7 @@ examples:
>
>              sdhi0_pins: sd0 {
>                      groups = "sdhi0_data4", "sdhi0_ctrl";
> -                    function = "sdhi0";
> +                    function = "sdhi0';

Huh?

>                      power-source = <3300>;
>              };
>      };

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

