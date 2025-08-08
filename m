Return-Path: <linux-pci+bounces-33633-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF044B1E81D
	for <lists+linux-pci@lfdr.de>; Fri,  8 Aug 2025 14:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B6BE1C22877
	for <lists+linux-pci@lfdr.de>; Fri,  8 Aug 2025 12:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772FE27602B;
	Fri,  8 Aug 2025 12:13:46 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B981A26D4FC;
	Fri,  8 Aug 2025 12:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754655226; cv=none; b=t5QbslXQ+n9HngXyPraqIUXqC61Bm9y69/9ZP3oY1Zis7J9lkPebrp1c6zu53J7vLB3Qpo9BtEcEmo+AppkJLnQxEo74txn36Fvf7Rklg9W4H7SoY2GN4zoqa8sM188ldJJxL4oate+0ExmBx0FHKvDmTHcMTArblNBB2pcVka4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754655226; c=relaxed/simple;
	bh=QK8g7ngnJYW5nvW8US1c1dEvOFH4rtqw0CUFFjx8TMk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pnV7s+5n2caO4p9XjEdbPT1UCJP0XD8cIWd8AtJhcE1mHUw+mxEDe+F6bOGLGzCT5Diw8IE4Y7JbNrt1ItEMriOgyK7zleW/geF7FloHyaT2lfWu4QYZFGbki7cHxzh1XhQ+99XSB7zYVNfRVJj+VvR99E0XNzwkio7zUNtaAAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-5067f6b30adso297138137.3;
        Fri, 08 Aug 2025 05:13:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754655223; x=1755260023;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TeUQG1VkSQkZJejGzniJ85mMFqiHeVxBeYS5KK1IWx0=;
        b=KxlVn1XFdinYKQV9qkj4wed6AoxKSpmM0QXj/spYtvDCwUntPvMo3Jw1/NXnI8WheB
         5+LfGhiUR7Lb9GzC0N/fsYA4c3/qJJdKnjK4LAmE9J/bG/I2uJCDNbJYheKNzdd2wjZg
         UcAx+iwbIz8/pb+mqgmpIuMOkNPy+OV2X4PY+VUx7J2xQ+kbIIgQUYgAqT31NECmLZ64
         fG80oEYMKRXpEG6B7041oF6KxUcIfC9w0mWZ6iZC9YEvp8JIgHUuK5VwC09YcLpgAXS4
         5D9LI2DDsC/kNhU2LTmLpe8roJi2LRb58uC+eZhdzm2l/p5XtISThqvWlBWlXXy99ARW
         MMmg==
X-Forwarded-Encrypted: i=1; AJvYcCUIWVBCgcAq+GL1TYla4pZkGr52FCuMM51VAZWAzeDkJjuT6JdLC8IIDEC4HA2vhfQdsrrCuVh5ocyA8fCj@vger.kernel.org, AJvYcCVUPmwvJSkhY/uwvbfPT+FwmLQf0Cq6X/9mutjPffO0MK+IW1LZGe9Hff7A4sC0TuPbkZR9pMOz9Ehi@vger.kernel.org, AJvYcCWKlrS90P+VFj7z30CsEVbHX4GpgHK9FfcvU7LaldiJRyjj1GXU+kQXtSGWDc1ipDtQQzuUFHX0npVb@vger.kernel.org, AJvYcCX7xfOSWgRq0gER2JAqYrWPAzmG5Dv+9Aswm+ff0fHtU9uO5ewxqkVdAoE/RoTJuxnUP472+a5OL2y68kZiakSzWEk=@vger.kernel.org, AJvYcCXkT7GyZcKK9dcFB8psKNqC3G3jf6rGl2auRHcGVfnE93w5IWbi4G854YDaRUYLvCy5cjyyqqO3bhYB@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr2Yq8RjbQ7WP9wDkFhvQXAXx/vl4LRjZ7bXkvSqSGQk1t1kpP
	Bqu3XQljXmljRL+zKZQi7/UYYn034ltw4s8U7+v/hCzJ4pQCL0L558OcUR8mCDjl
X-Gm-Gg: ASbGncvHry4vOSbbdFmJ3yaWn6No1Zd7aFwfyzVPTmTwm2rHFTXN/YuMIB3I84O96zK
	YxVfmEoYkcBbq7/N9Qc7GfYgprrkb98jFzHapgkCw4RcNfyP/6ovR/8Q5UgYpqPq+r+kEVQuSMT
	KeEDxNTVdJ1TYsA1jTREtkErZOxXLrEmJnv9fQWpOVfJ1ZIGWoH+ZBIRwjzvUjXNaOD1FZWoL00
	njSgtVpn7IYbaOT+hSv28MZlCrcGxrYD7RN6jFKu7qAo3ZZDYR25Xr+f1+1Ejk8AX4cGgMRWVkL
	rVRCVJhYnsTgsOXLrVepKcHeMs9aaDWyYZm2Vkr6CeokG4XROiQ70Ljr4KvrM/9EasLCDM1QXCR
	gQWb9mmmxKyomhHoBEz3hdbuVgIOEzzhmwENoi0hD3R5/dtkVF4WIU2/M9Aw6
X-Google-Smtp-Source: AGHT+IGjc+ZOrJOoedtuQfQwzPzmSx42eD9dHecav+yqcyZozhI97VmJsl78M391IXv9wxa288VN2g==
X-Received: by 2002:a05:6102:6ce:b0:4ec:c513:f3d with SMTP id ada2fe7eead31-506104d859emr918395137.25.1754655223432;
        Fri, 08 Aug 2025 05:13:43 -0700 (PDT)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com. [209.85.217.41])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-88e028f6a8dsm694635241.14.2025.08.08.05.13.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Aug 2025 05:13:41 -0700 (PDT)
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-5067f6b30adso297089137.3;
        Fri, 08 Aug 2025 05:13:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV/gdk/wIhzkWsgxU8TeYLl+ZkHmdTd0FoZ2kNmelA5fkLFixOVrN9lR4d6CwY/Dqz/EweTlmlXfQ2i@vger.kernel.org, AJvYcCV1T/NoI8ECLkmmnzrdYPiSRhUsqOD68/MRXpZWB1UayLwpE8/hfSVoyStdMvowJBRRMd6b4wqR/ra4@vger.kernel.org, AJvYcCV8CAOfLCXggQV2azyi6ViU7iUcTZS2gzaCrMbajpkrJkSy2Knh0qwouSUPupwH7BiZTeqBAq9f4kvF@vger.kernel.org, AJvYcCWEIKyMVpfS8tLtXeovUazwxSnTUrH7lqtBA3NwXNQLd/PvzuN1WDtPHwgFk5IzC0+IIgxxe/Ob5+KM7HTd@vger.kernel.org, AJvYcCWN0oKzPTBU+Pqh5SAJRWg076biAbxABPNf2bQ0FbyYH1Qh2ESJFe5I85WqUuVRI61y3eczNt/NBMyNkuB9/eGK0z4=@vger.kernel.org
X-Received: by 2002:a05:6102:5cc9:b0:4fb:142:1ff5 with SMTP id
 ada2fe7eead31-506104d8812mr1032620137.26.1754655220395; Fri, 08 Aug 2025
 05:13:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250704161410.3931884-1-claudiu.beznea.uj@bp.renesas.com> <20250704161410.3931884-7-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20250704161410.3931884-7-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 8 Aug 2025 14:13:29 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUGOJHFaCUd7qjtGmRhwU0EPXpVVBuP31JgbCEADNF3ew@mail.gmail.com>
X-Gm-Features: Ac12FXzM8iJwkzA-RFb9JbCrkQWoOo3N-HyMUTOszuGFrs4cxQKU_50xLXL2bB0
Message-ID: <CAMuHMdUGOJHFaCUd7qjtGmRhwU0EPXpVVBuP31JgbCEADNF3ew@mail.gmail.com>
Subject: Re: [PATCH v3 6/9] arm64: dts: renesas: r9a08g045s33: Add PCIe node
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

Hi Claudiu,

On Fri, 4 Jul 2025 at 18:14, Claudiu <claudiu.beznea@tuxon.dev> wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> The RZ/G3S SoC has a variant (R9A08G045S33) which support PCIe. Add the

supports

> PCIe node.
>
> Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Thanks for your patch!

> --- a/arch/arm64/boot/dts/renesas/r9a08g045s33.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r9a08g045s33.dtsi
> @@ -12,3 +12,63 @@
>  / {
>         compatible = "renesas,r9a08g045s33", "renesas,r9a08g045";
>  };
> +
> +&soc {
> +       pcie: pcie@11e40000 {
> +               compatible = "renesas,r9a08g045s33-pcie";

In light of the discussion on "[PATCH v3 4/9] dt-bindings: PCI:
renesas,r9a08g045s33-pcie: Add documentation for the PCIe IP on Renesas
RZ/G3S", this should be "renesas,r9a08g045-pcie", and the device node
should be added to the base r9a08g045.dtsi instead (else everything
has to be duplicated in r9a08g045s{13,17,37}.dtsi).  When support for
the variants without PCIe is added, the pcie node should be deleted
using /delete-node/ in r9a08g045s{11,15,31,35}.dtsi.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

