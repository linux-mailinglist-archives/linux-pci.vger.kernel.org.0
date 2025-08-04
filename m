Return-Path: <linux-pci+bounces-33358-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEABDB19FB2
	for <lists+linux-pci@lfdr.de>; Mon,  4 Aug 2025 12:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 279D97A6C29
	for <lists+linux-pci@lfdr.de>; Mon,  4 Aug 2025 10:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97E11FE444;
	Mon,  4 Aug 2025 10:25:53 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BB42C1A2;
	Mon,  4 Aug 2025 10:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754303153; cv=none; b=qdHMIiFPHAKOhT1OGvLSUNfjVo70VafMamtLZaYqA72HIMEmw3ROmBybHDeqklYYXyrmzPcJ/fxoyjsP+lCuOJELVLShM4eiSHqrPvTlrzBMLWTlkQbqc8Ayzn5xWsOSnP/6rzdUTK2ONdehs1lBTX08iUUyLbaTugcMgv9y0yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754303153; c=relaxed/simple;
	bh=Gv/Yco+PLRB+eO81Xk6Z2wVlYEMcrAQFutwtK52dQYc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fSXvUmZDtVOmCtBi+EryleAUObiYY8swR2rrBmpAwpHWHMNl1ofV9Wldr5w2wUw9f6GpvHgAVvXva8Re6fuSw7s8oVilMqlOpEcATJY0Q6YkztoTy6w+OcZj09sjJEResJoX/Fp3ucf8herHJKofu8O3AwZk4hrkkoT5wd6iEUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-88ba6bb90d6so3001975241.0;
        Mon, 04 Aug 2025 03:25:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754303150; x=1754907950;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eZddScDjOIs1bcwZar1ryVoYUm2q/hDGWLi3mEU/nG4=;
        b=rjsdqISahIt9YtYeQjvBO10Rtlp+ZmHXo0cusaC6V5GYxypJaO2VmqXL9/LG5O6ZMw
         4xPFioaLPlW6CMiwWw1wl/yYsD8X2RrNcOxLcb9AQbYt7YVcLEJa94Kz7lX8AXWYu4uC
         ye44+UL76x/2IbXHM7AUja2hxjTRND34z5UKnlCfjghdigHJT4Cq89Tx3m69Y83mmu7P
         IJliIrnuqUQ3Ktif9GFNg+hYqSfeWR32PBTN6dMcb3h7h6wmDNaMfBEniBT8AlBxodhx
         Td75+Ursl1HARLUQhsC3f/Zo0S7+z8fH3BGVTp6QtiPCCQgQamkoQztnWoYnT1h9hFRo
         6SMw==
X-Forwarded-Encrypted: i=1; AJvYcCUlCS9ZM3T7cV82MW59381KmyiigiwCJUfQOj+k94rH8mR7e54krG5TlPXC3qaXHqeV8psLQhr2yXDb@vger.kernel.org, AJvYcCWUAIjVuogZXXnNUOp1eaj2jeEJqaPWHfesOjvgm9oLtjtEeFCCknBz4VsCyQwSU2F4tveJgmKuaIjU@vger.kernel.org, AJvYcCX4vO/eczw/v7nW2l8pnZCaWR4ngw3gXdlEpHsrxaTmQbltjg8uiwUB1txG+g6UnQYerXw1LQXIAin5Beed@vger.kernel.org, AJvYcCXQYZV3tPcsLqqmxLJjBYBnML1yJrfOjYyhwIFzlUftEi7fxG/iCqKZLT2Ucjz5k2lr25vRiL7GdAl1m6S6cbWJoJk=@vger.kernel.org, AJvYcCXulT5sYKrIXCvDvSyU0qNwMG9g5IFxjNshJNSNnFGLTGPX1NJiUEVvEpQQ4MGRdXBCrmiKAtm/t1Z9@vger.kernel.org
X-Gm-Message-State: AOJu0Yz60AdKImkK0zEaklfHAWTMB3b7E6ZgCFp3MdSU70/dfxKHOcQt
	EnXl7QkDknjsz9nrqU29eK/FmVVN9NvMqTfzd8HZTKUzzC3SiQ3K5uNaFXkFxn4n
X-Gm-Gg: ASbGncttezy9QDIBmNvQLITPy3qv2X+gqhmaGo2VKBVjuyN9CLEJJ46TrESccdN6S08
	jWVIZB7DgJSObrQxWnGKMNJq+mTJKmzIliUneZnbA8Eh8P0dYtyRYwJ2mjduxnaYyBHEiMMSV8M
	o5wD5QDmay/UBrWFlyLCzpR2zpDSjfFSq9NAn8a2kq+ZRMqHB8WvOMMrbqlNhe7S2D4jFCi9WgP
	ab7+N9LruonGWNbjXms93lS+t8GZBK8SYgFEVJIFHS+eC8RyjIa6S19gH7R+bkVGZF3U3H/DPeF
	AapQZKLAuRixU5KcI6bo+3xKFf2CL7MwZ4U6GVnB6MlJDc3WYUL9Bk4nE/qibaIsz+EzhxKv5jM
	ES1Ilt4f9bSTLJAW83XUmJVhjTmDHJic9UWtpsv3lLdX4GgvujCxBS6zH969i
X-Google-Smtp-Source: AGHT+IEb6a7Bd5VuoZnxYlYIATgP0FQjULwTFEBTZ5xQm6f07KtBAzHdP4x3XKxt2V8CJPIinTxpjA==
X-Received: by 2002:a05:6102:3199:b0:4ee:5244:6607 with SMTP id ada2fe7eead31-4fc1014a862mr5910437137.11.1754303150292;
        Mon, 04 Aug 2025 03:25:50 -0700 (PDT)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com. [209.85.222.46])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-88d8f44b688sm2252555241.26.2025.08.04.03.25.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Aug 2025 03:25:49 -0700 (PDT)
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-88bc19ddfe3so1183667241.1;
        Mon, 04 Aug 2025 03:25:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU+Bt+EMxBqYZFRQaNicB4iFSaJz6hY5u9q40HPFoDdadyFGGpEGxcoJXhYDAIp/oPyU0oBe3JGC7jv@vger.kernel.org, AJvYcCV97rVL+yn17FTwTzZ4Cu0lEIv4wLsgFgXIzp9TzefQSGXmxQ3fVQZMmwj+Hqd5K+amj1swe3gEOz3m@vger.kernel.org, AJvYcCVuPaQgxukZFJmxD0tHg5sQ2++opDcjFeQIB56/ciwWI0MG0/K3ETLv6E+Sk1IHBnIIx+vMgL5M61/DZJyaiKBESOc=@vger.kernel.org, AJvYcCW/KoEtkE74xwoFSxGuUMe3Fvl5eS64/+EDF3ih+uVXONTnFXJfWNovprz/2iBAUP5zZYpuZULQgf+G@vger.kernel.org, AJvYcCXgCepwEedYcQLbeJl9k57f+ZbUWCbYoeoEl8YFwKT/kBgN1fhc1wmZfjDzKtGYHHz7rm+DXpYVv6o8xzM5@vger.kernel.org
X-Received: by 2002:a05:6102:6102:10b0:4fb:f495:43ec with SMTP id
 ada2fe7eead31-4fc1014a568mr4289741137.12.1754303149196; Mon, 04 Aug 2025
 03:25:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250704161410.3931884-1-claudiu.beznea.uj@bp.renesas.com> <20250704161410.3931884-3-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20250704161410.3931884-3-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 4 Aug 2025 12:25:38 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVrbOPrzwMMP0+HHqh01nwDfoUx8Mx0nZ=24ZU9XkFqgQ@mail.gmail.com>
X-Gm-Features: Ac12FXwFJTXzLRJiS_KcBRTI0cWrJpi5fbuV92Ri-bNxlf-GM9ClQh0GwvKc4cU
Message-ID: <CAMuHMdVrbOPrzwMMP0+HHqh01nwDfoUx8Mx0nZ=24ZU9XkFqgQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/9] clk: renesas: r9a08g045: Add clocks and resets
 support for PCIe
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org, 
	mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	magnus.damm@gmail.com, catalin.marinas@arm.com, will@kernel.org, 
	mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de, 
	lizhi.hou@amd.com, linux-pci@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-clk@vger.kernel.org, Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 4 Jul 2025 at 18:14, Claudiu <claudiu.beznea@tuxon.dev> wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Add clocks and resets for the PCIe IP available on the Renesas RZ/G3S SoC.
> The clkl1pm clock is required for PCIe link power management (PM) control
> and should be enabled based on the state of the CLKREQ# pin. Therefore,
> mark it as a no_pm clock to allow the PCIe driver to manage it during link
> PM transitions.
>
> Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Thanks for your patch!

> --- a/drivers/clk/renesas/r9a08g045-cpg.c
> +++ b/drivers/clk/renesas/r9a08g045-cpg.c
> @@ -289,6 +289,10 @@ static const struct rzg2l_mod_clk r9a08g045_mod_clks[] = {
>                                         MSTOP(BUS_MCPU2, BIT(14))),
>         DEF_MOD("tsu_pclk",             R9A08G045_TSU_PCLK, R9A08G045_CLK_TSU, 0x5ac, 0,
>                                         MSTOP(BUS_MCPU2, BIT(15))),
> +       DEF_MOD("pci_aclk",             R9A08G045_PCI_ACLK, R9A08G045_CLK_M0, 0x608, 0,
> +                                       MSTOP(BUS_PERI_COM, BIT(10))),
> +       DEF_MOD("pci_clk1pm",           R9A08G045_PCI_CLKL1PM, R9A08G045_CLK_ZT, 0x608, 1,

pci_clkl1pm

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-clk for v6.18, with the above fixed.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

