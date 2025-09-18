Return-Path: <linux-pci+bounces-36411-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B5FB83F24
	for <lists+linux-pci@lfdr.de>; Thu, 18 Sep 2025 12:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3380B2A8665
	for <lists+linux-pci@lfdr.de>; Thu, 18 Sep 2025 10:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC79A24167F;
	Thu, 18 Sep 2025 10:00:21 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF482773F0
	for <linux-pci@vger.kernel.org>; Thu, 18 Sep 2025 10:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758189621; cv=none; b=Tu0OG7PTXYz7tkpLzpPP5EAbjyn/YFAw64Hj3MXX6bqzUevPEHOr6pmNLhvyaAdJRD2381bcAajbgvJMQW2dtB9KUsuHpvej9A/qDpve6J08oMXiV55LdzSWK2195eTqSUW1Ysa3wjTLbueOGmwYB/fSBaBtYWvWom0IVO0Mgco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758189621; c=relaxed/simple;
	bh=/OBhn+PWMDqXGRrapAeq9Q3SvZxxEYXxE4Nz5bqD3Xo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QM8HvjAuyk2Vtk/kPwrBIWqLsBoZnOWZKfpf24d+TE7A9ld6fmxHfrxBNqLxzulWFRFXe1sjuQjuUKw3nbByqHFlCA5XyiYP1L4kZCyDmslaZAyaZxVxpEdlLcsEVMkUivDI/ZN0inN2AeLXUlSr5cq+c7uU9aPjDRhQDT4N3rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-890190d9f89so461239241.2
        for <linux-pci@vger.kernel.org>; Thu, 18 Sep 2025 03:00:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758189617; x=1758794417;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=heq3/GupfVYfNfyXxVtKecyYAD/tIXHJ4nXkThDhTOc=;
        b=HDLEbdhIl5L3GyHJ2H3a7hQbFkHuPg/yLLWGoSuoFFg/W7l1WTu60TcUJdJRRIQvqs
         r62Rri09ASgJbfnfgGEGl0ZTu212U9MAoSRCH14Prqu4JJaQxbQBYwPzR12DNHpYkzR5
         0act1cxMMKM0oskasDMnljvJvqrOtBGOVKxK+/pYM/ZNUMNZlAlQOzSg/c2+z3sX2mi+
         8bqLmwpoihiKlms9Nz3/Q9UtaSeWKLXTKsedvHaAUq3acsC78lvnNI1dURTBKpVZd5Qh
         2XYFQcaboVJ23NcgrmrjWWqPll4uvyg06phvVr3RH9UB9IshstrCU1IVSHBCa/hDdyzi
         GPmg==
X-Forwarded-Encrypted: i=1; AJvYcCUdTbul5HS51E/9tiUysuNpMFlJ8hFHmiqE2wSVQ4Xfi69PaoFgYQgxSP91H2DywFBnPVOzPIbrcys=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRtyVLTxMJkusSwhYU4L+OvDNR7oePP4JJV07Nd4gxYDm6ycK4
	NJdM4nx8kusqrZUVGFQEkSiY+Fhf52vRnEmmCcAn8SbFfU1lbtbyNzl4R6CY5bQU
X-Gm-Gg: ASbGnctpO4jEBqCt+D9DUzgHtjuyQ85UNxErptLfmq9XeHxUl0N93/MQmnt3ae6uzUx
	hoGZyyiu0n8RAwcTfbj2c3IPzIzOcr3YRHKg9AEtElqKrItPeht7U1sQ/FSqiVMVg7Is+wjHOE4
	OVCz7NU56IoZ4xGEhLUhV+vzMcmTVJWmPEZfSHW9SV2ST+DYn6/SkxY0qtNQE2H48Tu/C3Kvrno
	KN5weoFLULQHtmvZHTjMigiA0VTTPQKcRQ0S7ZgdpOvfY8BpM7itAKlp2Vs/x9EksaMtAnuBUmp
	tpo5/8MHGGfhlST8cfspwlaI8qd0esYOhTjp9l0JqyaxBMs9QHl7tLQuvv3jheDnymaiN1X4Lj6
	jSihcB2u4ZO54KH2gCGJKweGKNNmCPoIl3aRL3EwmF6sTitlNvt8Bsg1d6HKdxdIpXvhuEiv9+2
	eKsxU=
X-Google-Smtp-Source: AGHT+IHIJNIE5vAX5DyMmNyWlNb7cC3XFdk5zeq42O1xJIYlrh/rIjxWjJ+1xLtFYFd6eYA3K8r8Jg==
X-Received: by 2002:a05:6102:2d06:b0:521:f2f5:e444 with SMTP id ada2fe7eead31-56d62acfc75mr2511319137.17.1758189617451;
        Thu, 18 Sep 2025 03:00:17 -0700 (PDT)
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com. [209.85.217.52])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-579dd9085d6sm512625137.4.2025.09.18.03.00.16
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 03:00:17 -0700 (PDT)
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-552d3a17a26so231591137.2
        for <linux-pci@vger.kernel.org>; Thu, 18 Sep 2025 03:00:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXk50+YoJhfW0z+VXKkD7yFFgBejkz/oaBfJdHRTsLPup2x1XjvNXrI/su1w+viM2mcax+lSoTZvo4=@vger.kernel.org
X-Received: by 2002:a05:6102:5e89:b0:520:ec03:32e9 with SMTP id
 ada2fe7eead31-56d4ca46b90mr1938216137.3.1758189615787; Thu, 18 Sep 2025
 03:00:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912122444.3870284-1-claudiu.beznea.uj@bp.renesas.com>
 <20250912122444.3870284-5-claudiu.beznea.uj@bp.renesas.com>
 <CAMuHMdWP638eB_p9xMAqZmOnuc6n7=n31h6AqV+287uvqQEdww@mail.gmail.com> <c2fc5f6b-0e7c-464e-89a6-35dc76177d18@tuxon.dev>
In-Reply-To: <c2fc5f6b-0e7c-464e-89a6-35dc76177d18@tuxon.dev>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 18 Sep 2025 12:00:04 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWeHoUe-=7TDetnDQbLQsKGf4pDGpSdz3xEVLs_Rst9qQ@mail.gmail.com>
X-Gm-Features: AS18NWA7yJuM6P3qfqTjc7fj_WIPx-OpKuRx0s7hlxrQZNP3abmLA3cANYn1ePk
Message-ID: <CAMuHMdWeHoUe-=7TDetnDQbLQsKGf4pDGpSdz3xEVLs_Rst9qQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/6] arm64: dts: renesas: rzg3s-smarc-som: Update
 dma-ranges for PCIe
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org, 
	mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	magnus.damm@gmail.com, p.zabel@pengutronix.de, linux-pci@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset="UTF-8"

Hi Claudiu,

On Thu, 18 Sept 2025 at 11:47, Claudiu Beznea <claudiu.beznea@tuxon.dev> wrote:
> On 9/18/25 12:09, Geert Uytterhoeven wrote:
> > On Fri, 12 Sept 2025 at 14:24, Claudiu <claudiu.beznea@tuxon.dev> wrote:
> >> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >>
> >> The first 128MB of memory is reserved on this board for secure area.
> >> Secure area is a RAM region used by firmware. The rzg3s-smarc-som.dtsi
> >> memory node (memory@48000000) excludes the secure area.
> >> Update the PCIe dma-ranges property to reflect this.
> >>
> >> Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> >> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >
> > Thanks for your patch!
> >
> >> --- a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
> >> +++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
> >> @@ -214,6 +214,16 @@ &sdhi2 {
> >>  };
> >>  #endif
> >>
> >> +&pcie {
> >> +       /* First 128MB is reserved for secure area. */
> >
> > Do you really have to take that into account here?  I believe that
> > 128 MiB region will never be used anyway, as it is excluded from the
> > memory map (see memory@48000000).
> >
> >> +       dma-ranges = <0x42000000 0 0x48000000 0 0x48000000 0x0 0x38000000>;
> >
> > Hence shouldn't you add
> >
> >     dma-ranges = <0x42000000 0 0x48000000 0 0x48000000 0x0 0x38000000>;

Oops, I really meant (forgot to edit after copying it):

    dma-ranges = <0x42000000 0 0x40000000 0 0x40000000 0x0 0x40000000>;

> >
> > to the pcie node in arch/arm64/boot/dts/renesas/r9a08g045s33.dtsi
> > instead, like is done for all other Renesas SoCs that have PCIe?
>
> I chose to add it here as the rzg3s-smarc-som.dtsi is the one that defines
> the available memory for board, as the available memory is something board
> dependent.

But IMHO it is independent from the amount of memory on the board.
On other SoCs, it has a comment:

     /* Map all possible DDR as inbound ranges */

>
> If you consider it is better to have it in the SoC file, please let me know.

Hence yes please.

However, I missed you already have:

    /* Map all possible DRAM ranges (4 GB). */
    dma-ranges = <0x42000000 0 0x40000000 0 0x40000000 0x1 0x0>;

in r9a08g045.dtsi, so life's good.

+
> >> +};
> >> +
> >> +&pcie_port0 {
> >> +       clocks = <&versa3 5>;
> >> +       clock-names = "ref";
> >> +};
> >
> > This is not related.
>
> Ah, right! Could you please let me know if you prefer to have another patch
> or to update the patch description?

Given the dma-ranges changes is IMHO not needed, this can just be
a separate patch.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

