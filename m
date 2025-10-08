Return-Path: <linux-pci+bounces-37709-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 81D62BC4C2D
	for <lists+linux-pci@lfdr.de>; Wed, 08 Oct 2025 14:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 691244E8C5C
	for <lists+linux-pci@lfdr.de>; Wed,  8 Oct 2025 12:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0DC1F9F70;
	Wed,  8 Oct 2025 12:20:55 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EFA3594B
	for <linux-pci@vger.kernel.org>; Wed,  8 Oct 2025 12:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759926055; cv=none; b=d0k0XXZSIYatvH1GmrCMkm4zijgHoJe4JedVVUV00MT6CDUE2HZpNZuhEEp/Gvc0YyQNM3P73hPiJqPw3kobSH/qttfqWLCaDsezK//7r8EfK9wnoUkuWMze32uPtkSXSq2FfXfqJ7cY9dJJ40iZW+kNNwDzvbG78P0EbWRZOEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759926055; c=relaxed/simple;
	bh=o1l3n2y5YwxEXg2rM4gAYMR7pahw4lA+e2lcwHc4J4A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cMaTpFd0W4Ge3+KatHtXXVEJz7Jdb1u67NkvityQT/nyFDeACB69VLhIFTHXQOsQd0ZbJ3d7DHq78fqtMbgiS5eLh3L1oSPUeKkaAL3yIdShc9KqHGn/A/OQoieS8LJwPeSw6rd2u++nX2V1DR53glviWAAruNOW8SichR4sm4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-856701dc22aso762963185a.3
        for <linux-pci@vger.kernel.org>; Wed, 08 Oct 2025 05:20:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759926053; x=1760530853;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Brp2nrWlwG3bN8c/hrIoL4Nm2qLdFlreoXWyVG7Wt10=;
        b=cRGk8z/PZak/8jKfki7ijxLfFK2I55rSUkwJ672xiu9ztdIk1BGzugOOVkW8m9r/0j
         VBtCAzPDF84MSWAaxE4Nn/LS7QCiFRVVjRqE8fiEAVZhmKk5gTsmK2RrN/XqobTv1zoS
         fJY9CIOstmRALYxRsGq4ueT/Q7kELH+60D92xXtIdYWy/9Jklzhq0GPmeJiAObsunRcD
         Pj09t6hIWK7WHIqLqHuztXrfkoB53ZM7JZCTnzh9YdjTZB97IzNZw2FVtakipKjomfcd
         MPPD06TrR8oDBp/GDR1FA5IVt3T9lRrn3p1IEpNAc99I2sr4gWs16KYIU2doY5RtCtXs
         1IBg==
X-Forwarded-Encrypted: i=1; AJvYcCWpH1ScLIsqss4O5ZOyaH+B9KLrTxXa3kxAGyI+XiKF8NEeP8eWw1Ym3YMBoMxdV7YYerjGy+I9anQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS0VcWNEXKoOsuXJB/AycH8apkWF8IjyWhEkg4lqGiAgnzpFEQ
	OpRrhT8GfvOILZMrwZTTPXEpcnzMJ0ldxTJyuB47syL4l8tc8XFVZaJXV5cUY/FQ
X-Gm-Gg: ASbGncumNGRLuYlgPcN2IioTrBnbYo3aIA80CZwtTTWnKTJ6yC3Qyyp/4AggoVl8h1U
	edU6APP2HhBmi3NfUwhA/2vr+4f22mOdlfsPBJPNwW4yCd3UJwzPv/WqTi7mIphOH5egx4dtVh3
	/S5QXpxhn9LEK40w/OU3R2aHqK4HBx9MqydbqpbRm1zbs5yUCFYisGO91KTiYn8Gw/oO5Su9t7c
	Rltp+ggBx/iTClU2ql/fGoWCLGl1Mi7rp/ThcJRTu1m4p1RDU2XLxkSO9bEQn+nSDBiZu9oy1nb
	Cjv0k3qJcSVqHjRym0iBWZLyleSkTfB80M4eFm4pDxgyBwuoEPqyIXGfFujMvSFxJdjA5UDBXBb
	WrDHThGUbHcZDzy6czUJvjvFt+s2RsacDMrbyA3DLmsNkfXIbc1iCNN7/FrTUtoh3/hfVoD/b9x
	zts03nD5QLU53h
X-Google-Smtp-Source: AGHT+IFWbj0++gkfcbE9TlCZ9q6pZSe9yvOQ3iYm5jFtcf4gvjI2ohFNTrrmEjyd0IfUErdKfOcY8w==
X-Received: by 2002:a05:620a:3193:b0:81a:d304:e0cc with SMTP id af79cd13be357-883504a9b19mr464056485a.26.1759926052936;
        Wed, 08 Oct 2025 05:20:52 -0700 (PDT)
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com. [209.85.160.177])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-87772460ac0sm1774694585a.19.2025.10.08.05.20.52
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 05:20:52 -0700 (PDT)
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4e06163d9e9so73724121cf.3
        for <linux-pci@vger.kernel.org>; Wed, 08 Oct 2025 05:20:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXjaxHv8GoSx5d2OydinxDCS1GYVTQIF6W7GSsn0cRag2I3IkmNTqdvf/+Jdhkjg4BOnGZiarGcp5A=@vger.kernel.org
X-Received: by 2002:a05:6102:f08:b0:519:534a:6c22 with SMTP id
 ada2fe7eead31-5d5e23b4082mr1034500137.32.1759925551779; Wed, 08 Oct 2025
 05:12:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007133657.390523-1-claudiu.beznea.uj@bp.renesas.com> <20251007133657.390523-7-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20251007133657.390523-7-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 8 Oct 2025 14:12:19 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWf=AfW40m0qJ3_P=Ni=OsO=KMqDY7USdvHEXmrHM+mzw@mail.gmail.com>
X-Gm-Features: AS18NWAtQie1NbudVP3BXMcF3ZQanxK6LGXJKC21rxZI487nMAs440k_Psy4Pfs
Message-ID: <CAMuHMdWf=AfW40m0qJ3_P=Ni=OsO=KMqDY7USdvHEXmrHM+mzw@mail.gmail.com>
Subject: Re: [PATCH v5 6/6] arm64: defconfig: Enable PCIe for the Renesas
 RZ/G3S SoC
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org, 
	robh@kernel.org, bhelgaas@google.com, krzk+dt@kernel.org, conor+dt@kernel.org, 
	magnus.damm@gmail.com, p.zabel@pengutronix.de, linux-pci@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 7 Oct 2025 at 15:37, Claudiu <claudiu.beznea@tuxon.dev> wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Enable PCIe for the Renesas RZ/G3S SoC.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

