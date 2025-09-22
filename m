Return-Path: <linux-pci+bounces-36690-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB03B91F8F
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 17:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBCEB427CCB
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 15:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 281662E8881;
	Mon, 22 Sep 2025 15:34:10 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB2A2E8B68
	for <linux-pci@vger.kernel.org>; Mon, 22 Sep 2025 15:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758555250; cv=none; b=lvNHm90EI79YKe2e2/6KCMSHllW2PHtz8Pr6G8gUgoK+y1Ho80elzTyfI2gB8pUzqGV4TLOEDdMYUI4gIA6DEGtc/uyIkdsTtvraazqOMEAKEc64vVGcjg14VOdtTFmTf3Z9n7MJgB5Vjzy9ybweueKS+Ugmu3il709ZjlU1B0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758555250; c=relaxed/simple;
	bh=4xEURQps1Y7XIzxTl3Xzpx+/DCz5G1g5ZSIW1rLuGto=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e5zbPNJh8RwgzjZCCa1BF9tvD2Z647OmFpmuVxlUzDE6lidk8Vq292Xiz/0qrpo2c3N0ADxOF7YExLdrjzrjgRnSoipjDJxfzHpFjkOk/PEO+GJomUXrSsSVzsYQj/DzRwAKIVkRA3C3aKEk3KeLdFjc0WUUbEEF7pbWxT2R7g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-54a80b26f88so1437038e0c.0
        for <linux-pci@vger.kernel.org>; Mon, 22 Sep 2025 08:34:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758555246; x=1759160046;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D2KkywKnUb4xechwib0lQYxoI7BDR2zdUZe/SrHNSOo=;
        b=BuWPlQ9ddQZEF7/+ymBXGE9EeobKaiDDYVy2eXmxi3oCsMaUjber8ryds0WviDqGk+
         xiDRr1yeSPBs6l92T1Hnq11YcSOzauXBmNOFUVuYSzmkKp6L6VTtbMgzizCxUavzXC0g
         +9M5rw2yBkQe57dsobgUO0ougHRIRriIxVtwvvMSFV5CyFJotx9dCZuQvKvXJ5Hnq2+9
         9gNZuJh2+oPBDVqCFWWYl+VQGJmqQE/NUt4SzlX7rR0IZTIlI+aF1fE0Lq3Rd40BnQmZ
         AFuN77JtHfkm5G66z07zp/chfcYVHlASFnWCxTlbOwg0P4HeTJ5qaBjttdgXaRbx9QyH
         QhJQ==
X-Gm-Message-State: AOJu0YyFNFijiodu5qL9fpFn5PDdFmPOKNLM9gK8dQAyh0AK+SG3fj7k
	QNgWHs6QeYCvJpQhn4dP+MyGmDHuRjt0546VnaB89M0begqseFf8If74R9t4PJl7
X-Gm-Gg: ASbGncthBgwWFMyEoVk/o1hNTi0VkenkotAUC8rB6GAawF3MvleNZ++f4w6Ir+qfYI4
	13LaAfY17mDinEqhP2FX8g5PQnENiXrNyzkYNqUWXd/9bkhehDdaBzbtERogRyh9vHxpxDuPgCX
	ABJSUCb9y7tjX4zThZd/V8Js24iIpL1xavOHvT3HaZ/UMuTNfX2eAWW09Z5oMOZsnhhDC4vj5k2
	G+RSNgTgGUQD0objSrb4UwesOtSeJUZKWu0+lL60WAhYBUjnEyLqAgUSv5ztFZ+Dn+J2nwDSn+I
	EVlUIAVt1QXJyDGXJ4cpATocLDWPkIpSOgURN7Ymt8Gd4DT3ZhjDQcmZ3g/Knk+aIUKxXMWsU2R
	/GsK+UaxcvcdEJG8LSFGFzQTxfriAS6PSUGZ/IU0WYIbTNBHJLKBqd3HK5AQRv3WWLI8RX2s=
X-Google-Smtp-Source: AGHT+IE+p9ItzVUI/Q2iW4xG4wdmNDm57tLvipH8feludMhsSHKaH4gOIMbw9yS9WAS7jQ92MlCeCg==
X-Received: by 2002:a05:6122:3c55:b0:54b:c215:8c0 with SMTP id 71dfb90a1353d-54bc2150f48mr603406e0c.0.1758555246376;
        Mon, 22 Sep 2025 08:34:06 -0700 (PDT)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com. [209.85.217.44])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-54aa15cb86dsm1002570e0c.8.2025.09.22.08.34.06
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 08:34:06 -0700 (PDT)
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-5a46c3b3a5bso235479137.0
        for <linux-pci@vger.kernel.org>; Mon, 22 Sep 2025 08:34:06 -0700 (PDT)
X-Received: by 2002:a05:6102:cd4:b0:519:534a:6c24 with SMTP id
 ada2fe7eead31-588f87db47cmr3961231137.34.1758555245870; Mon, 22 Sep 2025
 08:34:05 -0700 (PDT)
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
 <3e6544a4-a202-4a1b-8cef-a864936db5f2@mailbox.org>
In-Reply-To: <3e6544a4-a202-4a1b-8cef-a864936db5f2@mailbox.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 22 Sep 2025 17:33:54 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUZ0U4OZOgOMXVKque55JwuSjA7kxBg7htmFjzca6+DyQ@mail.gmail.com>
X-Gm-Features: AS18NWCywMmnCuPMuZKSIK-4P7APJ2tBR-slISpv3lZfcGDeCmHyGievPd41NyE
Message-ID: <CAMuHMdUZ0U4OZOgOMXVKque55JwuSjA7kxBg7htmFjzca6+DyQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: rcar-gen4: Fix inverted break condition in PHY initialization
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: linux-pci@vger.kernel.org, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Marek,

On Mon, 22 Sept 2025 at 17:17, Marek Vasut <marek.vasut@mailbox.org> wrote:
> On 9/22/25 12:10 PM, Geert Uytterhoeven wrote:
> >> I have instead posted what I think are proper fixes for that SError:
> >>
> >> PCI: rcar-gen4: Add missing 1ms delay after PWR reset assertion
> >> https://patchwork.kernel.org/project/linux-pci/patch/20250918030058.330960-1-marek.vasut+renesas@mailbox.org/
> >
> > I used v3 instead.
> > While that patch seems to fix the SError after a hard reset (hardware
> > reset), it is not sufficient after a soft reset (typing "reboot").
> >
> >> clk: renesas: cpg-mssr: Add missing 1ms delay into reset toggle callback
> >> https://patchwork.kernel.org/project/linux-clk/patch/20250918030552.331389-1-marek.vasut+renesas@mailbox.org/
> >
> > This does not fix the SError, as expected (pcie-rcar-gen4.c does not
> > call reset_control_reset(), but reset_control_{,de}assert()).
> >
> >> clk: renesas: cpg-mssr: Read back reset registers to assure values latched
> >> https://patchwork.kernel.org/project/linux-clk/patch/20250918030723.331634-1-marek.vasut+renesas@mailbox.org/
> >
> > I used v2 instead, which seems to fix the SError.
>
> Those three patches have to be used together, and this inverted break
> condition fix should be applied too.
>
> The first two are corrections which align the code behavior with
> reference manual. This inverted break fix is another correction. The
> last patch in the list above actually fixes the asynchronized reset
> behavior and turns it into synchronized reset behavior, therefore fixing
> the SError in the process.

FTR, I always had the inverted break condition fix applied.
All 3 fixes on top should be fine.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

