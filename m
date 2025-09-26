Return-Path: <linux-pci+bounces-37088-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 594F4BA3356
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 11:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 917EF1B27982
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 09:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF6A27602E;
	Fri, 26 Sep 2025 09:45:40 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4400F1FF7C7
	for <linux-pci@vger.kernel.org>; Fri, 26 Sep 2025 09:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758879940; cv=none; b=JY/Pyl79YNKptJJGAslV1DSSn98Mpz5nxt3x6aK1ZEaTlxrWBuytFWuDRa2bZLHH5X568Felg+lPLgfKpe+MvReEIYWuG8mAuzRziRpAgV6or2zx/nJpg/5AfZkRJw9j2NjDyYZLn8ln7ov8xbgw2eh73QkXXECgsVEzCh/CtqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758879940; c=relaxed/simple;
	bh=yNpF3gakBewbf4gWfzySUblL/HPEFTHdWDap5s8c2rw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ssmT1HVRekXbczEe1ke/dLeTz8WYwz3t8Dqj17T0waT6F7a7jAE3FnvE4mE/vA4aFjuUFlveSCNjwthS/8tX3PM+oedY6ukRXCAJCCpHGTa2buyBDLfZ7Rrw+mINfni64DMQyTxNYcLVuBwBjOLBCAThfORKfsdOoV7SXrJTzR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-8900fcc0330so1722502241.0
        for <linux-pci@vger.kernel.org>; Fri, 26 Sep 2025 02:45:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758879938; x=1759484738;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wz1Y2OO7aX1FKDkec9bCJzTd14gDBikA8iaq+l9tIyk=;
        b=qChbE43eGASiOSaEJy5jGhmDEFECPkEeDSqDSuMA5nQd+l9xgjs8QB1e5oab6npwZs
         ZcT3I6gaEtyWdLjhUUQzrxIAoiNFAHmuQwhhTXSb+ppZqc650MhEqpJ6Cf2KMI/3EH+o
         8W4/UOZCXk4sobmzJm8jABkoAkjGPBV2xOOs3dSaerXaJEuee+5ZylH7B1zuyCJgqE/m
         +KMRYsuzsgbUHGfhny5HF+0bagvXTB+i/TXOm972zA/rvL9jtMTupB9fK1CWh5z/ESYI
         q7PgPAG1HH3tO7Voz4l2+StMAQ0sMbKH+k79/uXa8K9B4aeOThs+iUaqRVEt4lqqkUh6
         hLDA==
X-Forwarded-Encrypted: i=1; AJvYcCVlXt122rjgOLUMD5ehO2MCA7DeWt0QFY2fCrMQa7trrZY1BpFAMirnsNCbR1P7QkfybdjMKKmN0ZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFDjgUyEP4oqim1gmsgJMngWS4BdVFoaSXy+jjOGVMbzM+dxAs
	A5qeCmKCUkxP0Yc468fZeGFCY/xYEXnvGkuKzIUMsLqlDYFeVBmy7w3xvzPNDalH
X-Gm-Gg: ASbGncsXTF++C9M4IGUTi3cLeK6hiWbt4YVNuiEmosUITLhY3StbWALqp5gGrQ+SQ2I
	S2ShjAYyyNFAINOosvgjKqRJ83rpmBnb3EWE8M6806lHoAWPGMNB/O64Ix2aNHTcSDyAVHRhnzN
	HKhdsdwAoC+MsgzQwrpKFg9/KMk1l6HAQRzeYfJbjnl34sMJE2tMyJAgVqz2/XFtaBgqaaEqsBc
	UwUuiKcL8D7OI4qErYDDF86Hv2Tjq8so6jtzaualiDaGyyXO6DQdkZNqFLd5Wpj+Ku6B3YVObKJ
	labpS7znv8ghPEcC3r+d6m/SW+cXwdDWAwfZydK4QbQ45ydv9tCGgyiElFtmkzCNKMxGfu15Fo0
	w17uP3PkuDossOINeuoC5IDLSwBlnXmd6JZAtv3qMFOIVzn6PVgT+k01B+cDQ
X-Google-Smtp-Source: AGHT+IEAlqTnVfXNnDZAHgtlrs4+rul0ZcRBJD2cOAlM9gGmn92iLQ2nX2v92YLibiI5P/d263pZNw==
X-Received: by 2002:a05:6102:548f:b0:530:f657:c2e with SMTP id ada2fe7eead31-5ae1bc31166mr2722331137.13.1758879937895;
        Fri, 26 Sep 2025 02:45:37 -0700 (PDT)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com. [209.85.217.41])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5ae302ee7f1sm1156277137.2.2025.09.26.02.45.37
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Sep 2025 02:45:37 -0700 (PDT)
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-5565a83f796so1548110137.1
        for <linux-pci@vger.kernel.org>; Fri, 26 Sep 2025 02:45:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWZDZtJ9+SKeVIFLefTRycgTXnyA+fp6oeIP30RAc/6LBjmz3LOJ+IXaY2ydHjsSY+RvrxQmNWveIE=@vger.kernel.org
X-Received: by 2002:a05:6102:1452:20b0:58f:1e8b:a1c1 with SMTP id
 ada2fe7eead31-5ae14991836mr1929645137.2.1758879937242; Fri, 26 Sep 2025
 02:45:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912122444.3870284-1-claudiu.beznea.uj@bp.renesas.com> <20250912122444.3870284-4-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20250912122444.3870284-4-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 26 Sep 2025 11:45:25 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWmjj_bKhGqhWcRvWap1U5izT347Ffo5wqs6OP9BvO8PA@mail.gmail.com>
X-Gm-Features: AS18NWDiRHr7QXCMqaoImEEYFri-rFsQBU5GFbqAD2ZmUrWNkjrXvGfEFMFxCMM
Message-ID: <CAMuHMdWmjj_bKhGqhWcRvWap1U5izT347Ffo5wqs6OP9BvO8PA@mail.gmail.com>
Subject: Re: [PATCH v4 3/6] arm64: dts: renesas: r9a08g045: Add PCIe node
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org, 
	mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	magnus.damm@gmail.com, p.zabel@pengutronix.de, linux-pci@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset="UTF-8"

Hi Clausiu,

On Fri, 12 Sept 2025 at 14:24, Claudiu <claudiu.beznea@tuxon.dev> wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> The RZ/G3S SoC has a variant (R9A08G045S33) which supports PCIe. Add the
> PCIe node.
>
> Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>
> Changes in v4:
> - moved the node to r9a08g045.dtsi
> - dropped the "s33" from the compatible string
> - added port node
> - re-ordered properties to have them grouped together

Thanks for the update!

> --- a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
> @@ -717,6 +717,72 @@ eth1: ethernet@11c40000 {
>                         status = "disabled";
>                 };
>
> +               pcie: pcie@11e40000 {
> +                       compatible = "renesas,r9a08g045-pcie";
> +                       reg = <0 0x11e40000 0 0x10000>;
> +                       ranges = <0x02000000 0 0x30000000 0 0x30000000 0 0x8000000>;
> +                       /* Map all possible DRAM ranges (4 GB). */
> +                       dma-ranges = <0x42000000 0 0x40000000 0 0x40000000 0x1 0x0>;

I would write the last part as "1 0x00000000", for consistency with
other 36-bit addresses and lengths.

The rest LGTM, so
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

