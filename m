Return-Path: <linux-pci+bounces-39152-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4572BC01CD1
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 16:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46A673A0F9F
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 14:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E0F3148B9;
	Thu, 23 Oct 2025 14:29:31 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DF1314D14
	for <linux-pci@vger.kernel.org>; Thu, 23 Oct 2025 14:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761229771; cv=none; b=ribP4SoaYpTzBtWKN7p4hFk9dtNklSaZG6x3kZmUe1dmxBhIOVcw9VCALauwLWwg6EH43aUeIHfIoP39woTat7tAR9u6BZ2LMz678Vl19bcQrho0Aon8kc0ReawFu/2S+A16yP99PhsV0JO0NN9QHh4oa0LOi6eslbJjXib2NNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761229771; c=relaxed/simple;
	bh=TR7zlOg9lSlA9ANoIApwm25S9VrQTmkZ7BlIZp3yWzs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HMjPhPioia4s1HJ2znetl7XnjnQJBkdQ/eA1wheXZgHa5nya+pUvZWfErDm0TRIDYrJwQgJpI2nmGYpFi9psflVUT4ftSDH/oKmZszJYBWci+C2Iec8f+tkNSxzpubs2xwNCy8Le9pmDmHPglh3SoGnZ/Otz4hldK9JXDh6aBh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7b4f7a855baso676247a34.3
        for <linux-pci@vger.kernel.org>; Thu, 23 Oct 2025 07:29:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761229768; x=1761834568;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pUiJSOGezbV9/gcxRXe7vCcpv1VybDaME+fAsfjpYbw=;
        b=dcDl9k+MiX9Y+YawFo8gBT5dFdHhI93TS+SQkWfS5TgoUikMi9bjjBfWmtxKvSvfEx
         84RSskhkypedjtVBcd9Wq0GKQksCyrk6pbIJFaI32/yGt29qowbfxjh1hgSixTaHZW3f
         S675IS1MEEezB1XXdqhTP/+dbCQeFxvnirusj8pZyXVgqf6qRPlWgQBlfJIuPcDzm5qs
         VZsU+xt52xDWep1GVgDHuyoAwWzUR6ROlapZ1qsrGUJpgjLoDdBW8sLk2jI7XYqcqpaF
         +dQlEyKZFz7aY/fmbyL0ho4Oept/tDw9I9xgME/Yx/APjPks9omZ2Yv3wjiz8BThGIig
         JkJw==
X-Forwarded-Encrypted: i=1; AJvYcCX9PL12oFzXYUPsb/ksvUL6qUf1n6xEkDjlYmBf787H3Lt0b8rkZC6+BhMFiVV+ajqnmGWB1tyYeXg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy1zMIyeRl1HP7emBAqA9MGNq43my3ZOFhFOqTS6FxYcxhhEwk
	HBcikyqFIbV/UbBgUGa0MTUFuO3Wx57TvN6EwDGztft+bZbv2Fky0vsQpc91kvjQ
X-Gm-Gg: ASbGncubQmYpJciIT2093si8j3bv0XdYkfsjO20NYJm1eEOz/xILzR+N3po4SUDCF4U
	p8pXvyY1xgQzixQBgtaieme3SRHc+rvcljPL3P/5pphMQXa/ApM5PKj0IexS4cb3BMp4tRCrdGP
	ugRRJeIOzUcCofLpwYUH5t1qB0LvgVo/2T2jWyLwwRLg/t2ApuNaL5DyZCnog7V2vMljFpiX18J
	ry31gCntjRaqi6K6NZCftjtcUaPv8RnNQ/sEB5ydG8D6FKoVBYquIggDWy27SoufEHTyAHtoADu
	8ihYuApuWR5T5scvq/s/XEomkwjMwz/WvVAcB97pXAGY3hoWTfwGB//KXDqNrXwQFQbO6sJ4PqH
	LWeAYOmJcgMNx3niysSwOECsREu+3/v+OPM9KltbshB2eEvM/xF6oVf9S/HugkQvyNw4+GARJOV
	oKqbrX8EEioPtqKDeo2xcYWY/Mftpa+ayIDH4pnwKjGxM3NwA2
X-Google-Smtp-Source: AGHT+IEwmXPyCa19sKP/3yOY6LN16AjqAmEGpWGQd+ZYK85Qz7ee6QeGraWNjuASeKhjVilMkR00+g==
X-Received: by 2002:a05:6830:719e:b0:7bc:6cc3:a624 with SMTP id 46e09a7af769-7c27cbdfd9bmr12992710a34.32.1761229768150;
        Thu, 23 Oct 2025 07:29:28 -0700 (PDT)
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com. [209.85.160.51])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c51b048f6csm652695a34.28.2025.10.23.07.29.27
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 07:29:27 -0700 (PDT)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-36f13d00674so624527fac.1
        for <linux-pci@vger.kernel.org>; Thu, 23 Oct 2025 07:29:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVIHItv5a2Ippk5dkP9Okd7GTtoo8mXmms1xx5wywsbnId69kaZsFPqyAA1mRuboh5L4hwNroCilX8=@vger.kernel.org
X-Received: by 2002:a05:6102:5106:b0:5a8:4256:1f14 with SMTP id
 ada2fe7eead31-5d7dd5eb057mr7937173137.35.1761229283909; Thu, 23 Oct 2025
 07:21:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007133657.390523-1-claudiu.beznea.uj@bp.renesas.com>
 <20251007133657.390523-3-claudiu.beznea.uj@bp.renesas.com>
 <CAMuHMdXF14x68Wk5YdOBS2D2N6LtnQjfGzrsMdSJegX-gc3faQ@mail.gmail.com>
 <6c69d2a2-5dfe-450f-8a39-2ef6e7a6dbea@tuxon.dev> <CAMuHMdXLiN0kUVJtdEYVnsmnCEbN4hSs5KEhMXJhf7p29xv=0Q@mail.gmail.com>
 <f09bf940-3d45-49b1-8d7f-9c1a96acb187@tuxon.dev>
In-Reply-To: <f09bf940-3d45-49b1-8d7f-9c1a96acb187@tuxon.dev>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 23 Oct 2025 16:21:11 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXx=5YQSmSsw1+3otw9S_Hf+Tv+N1Y1iHiU0OOTyz4bjw@mail.gmail.com>
X-Gm-Features: AWmQ_bntosPEVOR4ph6dmWLKdA_CbWSKXTDRFcmNnJAAp9ekneiOOs4jYqpQulM
Message-ID: <CAMuHMdXx=5YQSmSsw1+3otw9S_Hf+Tv+N1Y1iHiU0OOTyz4bjw@mail.gmail.com>
Subject: Re: [PATCH v5 2/6] PCI: rzg3s-host: Add Renesas RZ/G3S SoC host driver
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org, 
	robh@kernel.org, bhelgaas@google.com, krzk+dt@kernel.org, conor+dt@kernel.org, 
	magnus.damm@gmail.com, p.zabel@pengutronix.de, linux-pci@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset="UTF-8"

Hi Claudiu,

On Thu, 23 Oct 2025 at 16:13, Claudiu Beznea <claudiu.beznea@tuxon.dev> wrote:
> On 10/23/25 14:02, Geert Uytterhoeven wrote:
> > On Thu, 23 Oct 2025 at 12:54, Claudiu Beznea <claudiu.beznea@tuxon.dev> wrote:
> >> On 10/23/25 11:00, Geert Uytterhoeven wrote:
> >>> On Tue, 7 Oct 2025 at 15:37, Claudiu <claudiu.beznea@tuxon.dev> wrote:
> >>>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >>>>
> >>>> The Renesas RZ/G3S features a PCIe IP that complies with the PCI Express
> >>>> Base Specification 4.0 and supports speeds of up to 5 GT/s. It functions
> >>>> only as a root complex, with a single-lane (x1) configuration. The
> >>>> controller includes Type 1 configuration registers, as well as IP
> >>>> specific registers (called AXI registers) required for various adjustments.
> >>>>
> >>>> Hardware manual can be downloaded from the address in the "Link" section.
> >>>> The following steps should be followed to access the manual:
> >>>> 1/ Click the "User Manual" button
> >>>> 2/ Click "Confirm"; this will start downloading an archive
> >>>> 3/ Open the downloaded archive
> >>>> 4/ Navigate to r01uh1014ej*-rzg3s-users-manual-hardware -> Deliverables
> >>>> 5/ Open the file r01uh1014ej*-rzg3s.pdf
> >>>>
> >>>> Link: https://www.renesas.com/en/products/rz-g3s?queryID=695cc067c2d89e3f271d43656ede4d12
> >>>> Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> >>>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >>>
> >>> Thanks for your patch!
> >>>
> >>>> --- /dev/null
> >>>> +++ b/drivers/pci/controller/pcie-rzg3s-host.c
> >>>
> >>>> +static void rzg3s_pcie_irq_compose_msi_msg(struct irq_data *data,
> >>>> +                                          struct msi_msg *msg)
> >>>> +{
> >>>> +       struct rzg3s_pcie_msi *msi = irq_data_get_irq_chip_data(data);
> >>>> +       struct rzg3s_pcie_host *host = rzg3s_msi_to_host(msi);
> >>>> +       u32 drop_mask = RZG3S_PCI_MSIRCVWADRL_ENA |
> >>>> +                       RZG3S_PCI_MSIRCVWADRL_MSG_DATA_ENA;
> >>>
> >>> This should include bit 2 (which is hardwired to zero (for now)),
> >>> so I think you better add
> >>>
> >>>     #define RZG3S_PCI_MSIRCVWADRL_ADDR  GENMASK(31, 3)
> >>>
> >>>> +       u32 lo, hi;
> >>>> +
> >>>> +       /*
> >>>> +        * Enable and msg data enable bits are part of the address lo. Drop
> >>>> +        * them.
> >>>> +        */
> >>>> +       lo = readl_relaxed(host->axi + RZG3S_PCI_MSIRCVWADRL) & ~drop_mask;
> >>>
> >>> ... and use FIELD_GET() with the new definition here.
> >>
> >> Bits 31..3 of RZG3S_PCI_MSIRCVWADRL contains only bits 31..3 of the MSI
> >> receive window address low, AFAIU. Using FIELD_GET() for bits 31..3 on the
> >> value read from RZG3S_PCI_MSIRCVWADRL and passing this value to
> >> msg->address_lo will lead to an NVMe device not working.
> >
> > Oops, yes you are right, I went a bit too far with the FIELD_GET()
> > suggestion. But replacing drop_mask by RZG3S_PCI_MSIRCVWADRL_ADDR
> > would still be worthwhile, IMHO.
>
> OK, you mean updating it like:
>
> +#define RZG3S_PCI_MSIRCVWADRL_ADDR  GENMASK(31, 3)
>
> // ...
>
>
> -    lo = readl_relaxed(host->axi + RZG3S_PCI_MSIRCVWADRL) & ~drop_mask;
> +    lo = readl_relaxed(host->axi + RZG3S_PCI_MSIRCVWADRL) &
>           RZG3S_PCI_MSIRCVWADRL_ADDR;

Exactly.
Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

