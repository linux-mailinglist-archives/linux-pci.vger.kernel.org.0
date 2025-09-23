Return-Path: <linux-pci+bounces-36739-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCAB7B94B34
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 09:09:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7301F3B2E07
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 07:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABBC330C36A;
	Tue, 23 Sep 2025 07:05:05 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BDD30FC09
	for <linux-pci@vger.kernel.org>; Tue, 23 Sep 2025 07:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758611105; cv=none; b=lFiQRLg50mDsrls6Sf4Cu9MQQXHb00/WCFFPxoEwSJB29m/6Rk/IQjIvlxASAmacDhg7JFWqh0Jbbpdur5ISZP5zLaIf3m1g1sotpwGF444JkOAS5aWPlx4L8ilrZ/QUO+KTXpA8u1aG/+xW3CPXQ+aTaatgqw8xd/V+6in3fkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758611105; c=relaxed/simple;
	bh=o2uBmggyCnP3RASSdv7vq3M9mUEKNXKMw4hsc2V3Qxs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lKz1gsyeddKfTegSAPb18ZFj4ZT+kgUSAoFbbdL9L6DMe/3B8mFqfPp/so3mTgR1olZs/y2j0PwWd9EmoE17beGQYPinlofetHpF2sgsj9xt/zgJH+J8/tgjPmDaBlQQiiYYaL7IxcP4W2ndwv5tV49E9o8hoXsNhzazUR7Mv6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-54bbe260539so603605e0c.0
        for <linux-pci@vger.kernel.org>; Tue, 23 Sep 2025 00:05:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758611102; x=1759215902;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cTSa9ZrFX35P20ri8x54pvG4hV62yKGbElIfp1uaYxc=;
        b=xOYKnbwagHopQSqUcdQhuRko+YnyUeGGAg6aJc3A/8h0WDsUp//T9Q/xjXgFwkIfay
         kGmpDR5y92Ndf2TYgb5Vu4ySNCwV/V5BMVI11EvPfdvTNBji3C1mvWVSgaGGo9ktg3CZ
         vuZ6HaHjir1uMU/ICA/bzqoLCsstnI6bi1Wi96tb4/+1mRTj3hX7WyYuX8/e/0o9RUGA
         Fg63tAhVMy3FxPHi7ZNbiHuO5DUEJDdPZrmlNwXjumFhpEMs9re7oAOldnrAIfojxsV4
         47P+hiPDJogwZA6HAieCO24dnk6Kdp8GJpjOXs/AfHGT2EyMYEzFM/P+zM11hkhcC/32
         BBwg==
X-Gm-Message-State: AOJu0Yyf7qAIyoiE1TJR0mZh/n0QDp8UwoeYgB3Z4Vf/yyd4EBvdQEbm
	coDgaIM6u/WKXyMUOy8WBoQ+VHm8R9QlHTSl1FgRYSQLJ/DgBsPTTIzZyNnDG+Os
X-Gm-Gg: ASbGncsQ09KyLAAh6NOix0wq8pGOIBIRpl/lvfiFS4csF8HNZYHUformKBLcwVJb9r8
	5awa40Wy5R0LHGG+/UNqfrgqI1EZ7TeAQ22WhFATLLiHxWQ4k5KBacPIR4DVX9ntemCjeZAhYUL
	2zpyRQdd5Jwpj+mQGR5l2lMiVUc0Q915IPOd62IXLgu/DLb+S8tvXvHgIcPxvJY/ue2EvQm1CZ3
	YcU+OIUlHLtB5PISdBHjKbD2ojWFs3gSMe5ZKZsT3kYCDQ2Et60ynN8wDuh6/Kanh91Fa9WQJlP
	vNzIQDs2CA5NdgYBK3EQPI/En9lYcP58PZLU1DYfKHk4MwkyJA1J/+B5i+z6X3LNQ4igwEcrMWr
	KRsKIVlTLCvQrJg89IXSG7yf8GzLz04cmEYbMeqakQAabEWWOYRhk1HILuLss
X-Google-Smtp-Source: AGHT+IHapYFNU2W+xGo88twY1DOFkV8XcaUM1pXuE0OuOzVt2aQgLp7EnISFkYv1kjMLmkZ7MSaSUw==
X-Received: by 2002:a05:6102:3a06:b0:521:27b:bea4 with SMTP id ada2fe7eead31-5a57e67e50bmr394142137.6.1758611102340;
        Tue, 23 Sep 2025 00:05:02 -0700 (PDT)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com. [209.85.217.48])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-8e3e7afbb79sm2347608241.17.2025.09.23.00.05.01
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 00:05:01 -0700 (PDT)
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-59c662bd660so1126189137.3
        for <linux-pci@vger.kernel.org>; Tue, 23 Sep 2025 00:05:01 -0700 (PDT)
X-Received: by 2002:a05:6102:3e1b:b0:534:cfe0:f83e with SMTP id
 ada2fe7eead31-5a57e774684mr497929137.3.1758611101246; Tue, 23 Sep 2025
 00:05:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915235910.47768-1-marek.vasut+renesas@mailbox.org>
 <CAMuHMdXAK6EhxPoNoqwqWSjGtwM24gL4qjSf6_n+NMCcpDf1HA@mail.gmail.com>
 <6fdc7d1e-8eaa-4244-a6b4-4a07e719dd73@mailbox.org> <CAMuHMdVrw1Mr_hKvgve03DQwvpqSPNaN5XUnYRJPXMeX1wvv0A@mail.gmail.com>
 <de4e4003-214f-4260-854c-d15efc81bb74@mailbox.org> <CAMuHMdVgFNb-3TgL7a+AJMYE6tqOiMpGYFDhXnQoz9R5gLz=-A@mail.gmail.com>
 <12b54030-5505-416b-9e4e-2338263c5c7a@mailbox.org> <CAMuHMdUnKqHQpaTkiuYUmR1kQ2GwVvj0SeML-9x3Rc+srtXW+w@mail.gmail.com>
 <3e6544a4-a202-4a1b-8cef-a864936db5f2@mailbox.org> <CAMuHMdUZ0U4OZOgOMXVKque55JwuSjA7kxBg7htmFjzca6+DyQ@mail.gmail.com>
 <c34424d5-b1ac-483e-a1e1-8dd8bfdc2c51@mailbox.org>
In-Reply-To: <c34424d5-b1ac-483e-a1e1-8dd8bfdc2c51@mailbox.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 23 Sep 2025 09:04:50 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUKAz67vD+5pQm-sJx64CY9fwdRpNcreHNF6Oet43-YYw@mail.gmail.com>
X-Gm-Features: AS18NWCkJPDSQ7i_rlf0FanL-iuzDqO4gQrvZfLgfjUxJp_g2BkVs26NNcSRwJo
Message-ID: <CAMuHMdUKAz67vD+5pQm-sJx64CY9fwdRpNcreHNF6Oet43-YYw@mail.gmail.com>
Subject: Re: [PATCH] PCI: rcar-gen4: Fix inverted break condition in PHY initialization
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: linux-pci@vger.kernel.org, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 22 Sept 2025 at 17:49, Marek Vasut <marek.vasut@mailbox.org> wrote:
> On 9/22/25 5:33 PM, Geert Uytterhoeven wrote:
> > On Mon, 22 Sept 2025 at 17:17, Marek Vasut <marek.vasut@mailbox.org> wrote:
> >> On 9/22/25 12:10 PM, Geert Uytterhoeven wrote:
> >>>> I have instead posted what I think are proper fixes for that SError:
> >>>>
> >>>> PCI: rcar-gen4: Add missing 1ms delay after PWR reset assertion
> >>>> https://patchwork.kernel.org/project/linux-pci/patch/20250918030058.330960-1-marek.vasut+renesas@mailbox.org/
> >>>
> >>> I used v3 instead.
> >>> While that patch seems to fix the SError after a hard reset (hardware
> >>> reset), it is not sufficient after a soft reset (typing "reboot").
> >>>
> >>>> clk: renesas: cpg-mssr: Add missing 1ms delay into reset toggle callback
> >>>> https://patchwork.kernel.org/project/linux-clk/patch/20250918030552.331389-1-marek.vasut+renesas@mailbox.org/
> >>>
> >>> This does not fix the SError, as expected (pcie-rcar-gen4.c does not
> >>> call reset_control_reset(), but reset_control_{,de}assert()).
> >>>
> >>>> clk: renesas: cpg-mssr: Read back reset registers to assure values latched
> >>>> https://patchwork.kernel.org/project/linux-clk/patch/20250918030723.331634-1-marek.vasut+renesas@mailbox.org/
> >>>
> >>> I used v2 instead, which seems to fix the SError.
> >>
> >> Those three patches have to be used together, and this inverted break
> >> condition fix should be applied too.
> >>
> >> The first two are corrections which align the code behavior with
> >> reference manual. This inverted break fix is another correction. The
> >> last patch in the list above actually fixes the asynchronized reset
> >> behavior and turns it into synchronized reset behavior, therefore fixing
> >> the SError in the process.
> >
> > FTR, I always had the inverted break condition fix applied.
> > All 3 fixes on top should be fine.
>
> Maybe I can finally properly deserve your TB on this patch with this
> option (C) , all three patches applied.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

