Return-Path: <linux-pci+bounces-37089-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF48BA33C2
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 11:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED7A4383AA4
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 09:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB325265623;
	Fri, 26 Sep 2025 09:50:13 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C05529DB61
	for <linux-pci@vger.kernel.org>; Fri, 26 Sep 2025 09:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758880213; cv=none; b=Yr5EVn8GyOzN6iMW67IU33qf4LmzQoQHKtNcO5x1nPp8gfM/q48PcewEYZ7AvXVpQ9VwjTxHMO1uxX7aG96vFnh6hZvUjAT84n/YdHQNNrur11zLfv4nvEXUMLdwXDdhY3mKJG+4i0djIzgMCfKUyK1BjScaa/VtsJ6fEXjz76o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758880213; c=relaxed/simple;
	bh=9MP05zHbL6Vtrf5lONjgCVq9CWhR1Q+9cXrMd2Yezk0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mtRNUWDPCQGQMYYVAbWqtiCt7FMygvpbv9t+Fwc4UyhD34t+qn+++dDVseAVdJeelI/eESiHSPgan4d9JF1sKv+EpBj7Hw4VT52kxl8dPm5CGhpa/DtbS6Ck7vHkYSCJ9A7389uX63rTSrFKOvIcOW/XbeHE20tCUROkSvRA7jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-54aa6a0babeso2080132e0c.0
        for <linux-pci@vger.kernel.org>; Fri, 26 Sep 2025 02:50:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758880211; x=1759485011;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WcBsC1askobQesMf5dT3EOt6tZwDclh2s0/BCRcco7k=;
        b=OL11+lQjmTLgmLvxiRDG5/iWC8iz96F251Kmut376V6drp+6zVZ8Yn5MU8+qPSMKOS
         4Nw2PUBLYnoHLIOZnaYqYH5dqsAro7ivuMMZ/lkeClAxTEwl2otoL2Ji8oWb7IVxHE6l
         8c9Zs1Zj8MynSpl/NoEzaSDJY13q6vOk/om4EHqCyz1CcVg40XXHUpv+kXRvVgxxP6qa
         X2VzoM0sI2rvCuEHLw05x7bRO1MRKKCaaqlf27xFgcjHxqczSG5FXqFB5wZmIH5l4pJ1
         CipE2rzNB5BZuoNAWMpPl6KsGgf28yqRUkySFuHZULKJ2TnkypELz8UuDBH2e8uTiIQY
         Ngzw==
X-Forwarded-Encrypted: i=1; AJvYcCWsxnN01hVXBc7CEW8eddW6WOdQh1EXXIWSHJKwBSD2eQBqJX6y0xBcct83AMTAAGxbEHzNch324xc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6k9Wqo5Z1l3sXRTqNlYN/GIm5PlzQGuI9ksyTLlrT3wG/DuF8
	xrXBH3mWZIuHRE9wZ0RgKNHZmcjHF5pj4r0BdaO/n0qveYVdDHw3cCeKUq4Q++lG
X-Gm-Gg: ASbGncsDusF9H734WTNkHyGyu+6KVJmQh2DadAxAwhukfwzSzAK3iTQZyScXmJZNnr3
	gFTiJBeGd9XICXbN5qt0AXTel+t4Y2eey9kPLSF8D1vuRRruUb3lt4TND6ZV92U5yM3B9R2hWzi
	Tdu+3SKrNHjc2LakspTG2UgqnwbozJ85QMRzavxohcE4H2rTOTT4gVS6AeQ0PX7SebXQHFl7Vnw
	5UjQgbKVH1SW80+MWo1tzxV9fFQQnIEsIrt2mOMy5VxdEkKd4csbOrGt5m7CIrrqpENjz1sCS9Z
	4qDekz1VqdTIgdqnItDSh2V1GyTpBQxtaPdCEE1fUE+CQ5wJyP3Jxj8rJNrOi5C7A+5Vm98C/r2
	/4jbkRsmsnz8NWY6RVn3aZUny8Zi8jIDikO3pHvyHZTQ2ISfV8/m5KVMFw2d8EQ4O/4F/woCca6
	8=
X-Google-Smtp-Source: AGHT+IEN0Wm/gaAMNCX8sgfLsZP3xTdwTh+i/WsH/ndEg8cjXFsSquIMS1/2+nNKZcOXGfnRHBOxDg==
X-Received: by 2002:a05:6122:2027:b0:54a:a782:47d6 with SMTP id 71dfb90a1353d-54bed4ce580mr2387438e0c.7.1758880211228;
        Fri, 26 Sep 2025 02:50:11 -0700 (PDT)
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com. [209.85.221.175])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-54beddf1213sm808532e0c.27.2025.09.26.02.50.08
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Sep 2025 02:50:09 -0700 (PDT)
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-54aa6a0babeso2080086e0c.0
        for <linux-pci@vger.kernel.org>; Fri, 26 Sep 2025 02:50:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXe/80Smbr3yMdCbADc5cRBgvagVUOe5eoJGO6jyNK3XRIOuympz71khts0LX/jAy7iFYkSDzNLvuM=@vger.kernel.org
X-Received: by 2002:a67:e098:0:b0:59f:54cb:205a with SMTP id
 ada2fe7eead31-5ae1f222b9dmr1619909137.13.1758880208278; Fri, 26 Sep 2025
 02:50:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912122444.3870284-1-claudiu.beznea.uj@bp.renesas.com> <20250912122444.3870284-6-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20250912122444.3870284-6-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 26 Sep 2025 11:49:57 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXn-sd7CXgxRzwfHQFUUxzboyYP-2eqSTaVgmh5hjT_xA@mail.gmail.com>
X-Gm-Features: AS18NWBXsS1FJ_qFsvTSOsChWy-NgmX0zNmCcExyFfSBImph2esks2SOJO6KK2A
Message-ID: <CAMuHMdXn-sd7CXgxRzwfHQFUUxzboyYP-2eqSTaVgmh5hjT_xA@mail.gmail.com>
Subject: Re: [PATCH v4 5/6] arm64: dts: renesas: rzg3s-smarc: Enable PCIe
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org, 
	mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	magnus.damm@gmail.com, p.zabel@pengutronix.de, linux-pci@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 12 Sept 2025 at 14:24, Claudiu <claudiu.beznea@tuxon.dev> wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> The RZ Smarc Carrier-II board has PCIe headers mounted on it. Enable PCIe
> support.
>
> Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

