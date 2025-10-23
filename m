Return-Path: <linux-pci+bounces-39134-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF76C009DF
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 13:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2EEE835898E
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 11:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9070D30AD03;
	Thu, 23 Oct 2025 11:03:10 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE60E309F1D
	for <linux-pci@vger.kernel.org>; Thu, 23 Oct 2025 11:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761217390; cv=none; b=OJk6acYXm6o8+mUOiEMtG1po6s0XgD5lshoLGXnr+n6mW6g+DnyDDG7l8OgETNhEnFuYlYxDZM7DMR0YceOHP+REyHDM+LeGpC9DJ3eAOWFqMkDSFO9P2JKFiDzfhglcXVWSvgzZhsY+SZ0i04jRwUnt9iGoN6w6Wt26ZAlDQYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761217390; c=relaxed/simple;
	bh=tg+8iAuL9v348WQn+/MKpxNJ48PFBRZL9CF/o4UEAoE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mQPbdaBeqc5IboEdtlmkQ7QBIIvPg3d8D8Vz88Pxvw+kFJsahL2uruThEDyb81i5MnLNJBFdp3g5a3gcI3E8nKmwosq9B/dH6cA/ZHAsIyIofG4JZ99x/ciPkHiOIu7qzCUctPaWtASA+qZTB36QEDDRNNuVIlgTAIFmqLYdcg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-54bbc2a8586so224157e0c.2
        for <linux-pci@vger.kernel.org>; Thu, 23 Oct 2025 04:03:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761217386; x=1761822186;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WjWvH/pQF78pnjKmIZIOC/klk9iC3EtNoJr9L6Gp1mo=;
        b=m11CbXFm+fOEfN3I5rs3dkn5PcKqbUf8QY86028qFJTxuGeXERP4r1hKFh9DnnlgFx
         auedKhNYDOPdzE3QaR9D8M4Uen2BbaZ+Q4Br6+5Ebc6YdgpFwk1p1fPEJSW5RGLqS3VS
         nnY1o0W8COh9Gxb2eAMZLiWJRB/825bj2LmilCKV783lUWFfOMMh75EI6IypM/HaRFmE
         rxdtAN/g+uqwXmMfacd+HfjZfLmdKC+qMG7tYOQRzlx1T1Nyb4QGLouO+PaAtMnFhNJw
         vb5LDk4ffpPzyeouEzALD/FmNHtDEbUe0gEepYcBncUJm/B/Bvm/w1EOsVbV4wizJiqW
         H+vg==
X-Forwarded-Encrypted: i=1; AJvYcCVqpHUfltzBNFM6aaOWlkpo5PLaKWHhWOgYW2x1qyg5EvTDV76efHkhhU7c4xtIIgHNcdaIT6U9Htg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOr+AfAqrM1bH0FUWhi8j+bYkdcd3sjYirDAtDV7J6oci0YwE9
	Z6yzk8uKQr2FQygBecUdC5uS2sSim3TAb7FpcYpbIktlEwaKMER9BPzEWZwAvW6y
X-Gm-Gg: ASbGnctXi0mR2M7qqiLZfSMFmVGFYSWTKJgd+U3dNsCB5oqgnelFCj5z5G4Wgz9YHQJ
	QUX+Uya1aBAx6+Ssdymlj9ZCFWXipdgjv67NyySlZPcLoNHKQrL/JtehIxSg+I1rEBJJv6oZhoF
	7LREn8X5gtXKvFIu80mw6udrJfFeYaJkbRhSZ5VLqNxQaPxMG0ZWLr+tuWN0cGXdvsehy1vM9v3
	95o0MX/+Vn/HBHGCXeAl9I/H0MEX72OWEw8YO0bGh8z1Zxv+6DwxU32zarn3IlF4fVTgiBlR5Yo
	ZKdyOqSARl9WuyMkpSpXi5yZCwbp9BxvMLgNMpxh64vrRzTINqjpVyW5Cr/ed+cunW4N8OTR5EC
	+O2JPR/Rw3tkoNuHSer9cnoFZQiMgG9bSAQMbmdSUKRdGFiUKxuHo9b7RQB4cCV0QUA+DJJ4wFZ
	dk/qWP5XRGVpl5P9bWYv2CRpK3oZqw87jLu5hcfctZlE/EkkAz
X-Google-Smtp-Source: AGHT+IFnmwOTftPubuQJr9hgwLRBXUwcKi19Bu6UAW+72wtEjpYMf7nVq0sqzZ6Bjb844UJPzXkKNA==
X-Received: by 2002:a05:6122:da1:b0:557:c841:14dd with SMTP id 71dfb90a1353d-557c8411534mr26783e0c.16.1761217385792;
        Thu, 23 Oct 2025 04:03:05 -0700 (PDT)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com. [209.85.217.48])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-557bdbb82e5sm610281e0c.14.2025.10.23.04.03.05
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 04:03:05 -0700 (PDT)
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-5c72dce3201so199071137.3
        for <linux-pci@vger.kernel.org>; Thu, 23 Oct 2025 04:03:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUdP1/ASAQ8ul7fxwxezR1ZFo4/4+cbjCJ1/0En+vlXaay7GwAswrhzAvi+aDhBsZ/8wOoHyvf7E6A=@vger.kernel.org
X-Received: by 2002:a05:6102:2acc:b0:520:a44f:3ddf with SMTP id
 ada2fe7eead31-5d7dd5a3793mr5929967137.10.1761217385274; Thu, 23 Oct 2025
 04:03:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007133657.390523-1-claudiu.beznea.uj@bp.renesas.com>
 <20251007133657.390523-3-claudiu.beznea.uj@bp.renesas.com>
 <CAMuHMdXF14x68Wk5YdOBS2D2N6LtnQjfGzrsMdSJegX-gc3faQ@mail.gmail.com> <6c69d2a2-5dfe-450f-8a39-2ef6e7a6dbea@tuxon.dev>
In-Reply-To: <6c69d2a2-5dfe-450f-8a39-2ef6e7a6dbea@tuxon.dev>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 23 Oct 2025 13:02:54 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXLiN0kUVJtdEYVnsmnCEbN4hSs5KEhMXJhf7p29xv=0Q@mail.gmail.com>
X-Gm-Features: AWmQ_bm3rJeUf0KSNhlRfvLpl1M_xWwhhcqbJogOZCts4Aa1eBeKq-NYF1bmLWY
Message-ID: <CAMuHMdXLiN0kUVJtdEYVnsmnCEbN4hSs5KEhMXJhf7p29xv=0Q@mail.gmail.com>
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

On Thu, 23 Oct 2025 at 12:54, Claudiu Beznea <claudiu.beznea@tuxon.dev> wrote:
> On 10/23/25 11:00, Geert Uytterhoeven wrote:
> > On Tue, 7 Oct 2025 at 15:37, Claudiu <claudiu.beznea@tuxon.dev> wrote:
> >> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >>
> >> The Renesas RZ/G3S features a PCIe IP that complies with the PCI Express
> >> Base Specification 4.0 and supports speeds of up to 5 GT/s. It functions
> >> only as a root complex, with a single-lane (x1) configuration. The
> >> controller includes Type 1 configuration registers, as well as IP
> >> specific registers (called AXI registers) required for various adjustments.
> >>
> >> Hardware manual can be downloaded from the address in the "Link" section.
> >> The following steps should be followed to access the manual:
> >> 1/ Click the "User Manual" button
> >> 2/ Click "Confirm"; this will start downloading an archive
> >> 3/ Open the downloaded archive
> >> 4/ Navigate to r01uh1014ej*-rzg3s-users-manual-hardware -> Deliverables
> >> 5/ Open the file r01uh1014ej*-rzg3s.pdf
> >>
> >> Link: https://www.renesas.com/en/products/rz-g3s?queryID=695cc067c2d89e3f271d43656ede4d12
> >> Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> >> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >
> > Thanks for your patch!
> >
> >> --- /dev/null
> >> +++ b/drivers/pci/controller/pcie-rzg3s-host.c
> >
> >> +static void rzg3s_pcie_irq_compose_msi_msg(struct irq_data *data,
> >> +                                          struct msi_msg *msg)
> >> +{
> >> +       struct rzg3s_pcie_msi *msi = irq_data_get_irq_chip_data(data);
> >> +       struct rzg3s_pcie_host *host = rzg3s_msi_to_host(msi);
> >> +       u32 drop_mask = RZG3S_PCI_MSIRCVWADRL_ENA |
> >> +                       RZG3S_PCI_MSIRCVWADRL_MSG_DATA_ENA;
> >
> > This should include bit 2 (which is hardwired to zero (for now)),
> > so I think you better add
> >
> >     #define RZG3S_PCI_MSIRCVWADRL_ADDR  GENMASK(31, 3)
> >
> >> +       u32 lo, hi;
> >> +
> >> +       /*
> >> +        * Enable and msg data enable bits are part of the address lo. Drop
> >> +        * them.
> >> +        */
> >> +       lo = readl_relaxed(host->axi + RZG3S_PCI_MSIRCVWADRL) & ~drop_mask;
> >
> > ... and use FIELD_GET() with the new definition here.
>
> Bits 31..3 of RZG3S_PCI_MSIRCVWADRL contains only bits 31..3 of the MSI
> receive window address low, AFAIU. Using FIELD_GET() for bits 31..3 on the
> value read from RZG3S_PCI_MSIRCVWADRL and passing this value to
> msg->address_lo will lead to an NVMe device not working.

Oops, yes you are right, I went a bit too far with the FIELD_GET()
suggestion. But replacing drop_mask by RZG3S_PCI_MSIRCVWADRL_ADDR
would still be worthwhile, IMHO.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

