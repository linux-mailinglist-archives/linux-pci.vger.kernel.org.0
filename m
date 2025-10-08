Return-Path: <linux-pci+bounces-37707-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8768BBC4BAA
	for <lists+linux-pci@lfdr.de>; Wed, 08 Oct 2025 14:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85762189FA4E
	for <lists+linux-pci@lfdr.de>; Wed,  8 Oct 2025 12:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 287271F0994;
	Wed,  8 Oct 2025 12:15:45 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2601A31
	for <linux-pci@vger.kernel.org>; Wed,  8 Oct 2025 12:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759925745; cv=none; b=dVZs3vtHz2N0hd48eGV2BtAqGCDXpqICTLiVPEOEJkgVNLU5ZGaY+RyHcWZJzAYzyZQLieLkk0xLZXCywC+BgkqDtAyrShwqHCjJaBLlgRNmxbGcmV7kJ3HExMTDAAb0YXJcqM7dGry9nbC/0aj0k+PHuqet5LHJzgGQJEd8pBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759925745; c=relaxed/simple;
	bh=LHfdiCrUQuEcAm5u+oBtBSBCUhJhATTh4SH+rcshlXw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WJXm6feq0+yl4CwN7wmIJ2PCIc+OS91h5ez3LwV2weUeOq6h9QrHQK60wLKql+/x/akvGzyH+7cefFeEJiEDkoExU/AZsTQiANzovtR7+9Fz0++TYwweORozyWzBtgyS3iGLPoyspV/eF8iq6FcYTUbz5+cIC5Pvv9ZfA9Vj6yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-51d14932f27so3651826137.2
        for <linux-pci@vger.kernel.org>; Wed, 08 Oct 2025 05:15:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759925742; x=1760530542;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9odJo6RABd099SWeo1M5TAe6eHvzwU6j0ndjMHRUm3I=;
        b=D/nuScKWJ1xzkIP9VOi/D4Kx7Ouar9Pbda/cKKkZJx85b1oJ6GYWFUUBaKyNon3Irx
         /1imm1roiV4uQU/obFgDeRaZLpzlK/ZXVlmQBcTutbrR9C2OV6X57V8z0oLVcQtg8u8f
         Ti03l4UmVXhQoFcQLS136yUkNEFdKtOV2H0tbrxxWkEWx+0v4hQ6aZYQChvY/P9f9HCl
         F4Oz/34b9cvLNqBVfUd+UJQd3C0dGbYqWUOaKNU0pWygAmCSR9rVh1ODH3hd8mH+XCxt
         7TJMBshvnY9Bi8ymx+wA21CA2HRpzELEMguq7aELtVAeAInL06SIw4WE+iyZepbSyw64
         6pvg==
X-Forwarded-Encrypted: i=1; AJvYcCXtaiWqx2ZvX0GczFVQWMX6za3licRiDxQM+5YTvipbszMyx0zy/lSeDrWAEI+Qgyh8oabEEv6HFZg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyIhCM26hWougQ00QirGZMlojgi1nH63SdnbyirwsHCwfH4411
	n6OQiW+8ZSdi9jFhPQLdPFljnqjY9Om87oWTpCsX3IN2B8qKLaUzyigOqS1vLEcU
X-Gm-Gg: ASbGncsL4QGb9cBnAN3GcPkwaHIkU0N+5QtVQnB1fV/KIFEGihhAjYyKO78eMylcfkF
	hTsEBcafZLa5Wh+uYDnmCofzlFBJJbV/SlYew8jQg2wlBxUoGvdME2zrxiWZ4XurUgaQQr00txH
	4eIpIAUlXdQiIVgv0pgppJ6GniXb0s5NozfkO04R0K95fQoxhE9pd/E/InFF6ryaPovsofP8dbi
	wRn1HSoPeMqit5o94E43/9MW8UxvC21B1gT6e157lvr1I2RcVbJ4rlI5fi0H9d0GIVyqEXEeBjP
	N1DgfupdrM8WvlTrwXlDWt86ps5+F2+e3GTXXek1hVeCVbrpWDT6ELNwSAedRYDwUKYl15G+UwG
	AL+pThsdZh0kdB8pH1xAvyHvjDvlGmoeYqmyJkkfSq3ytVhdWrysfT7iOEnZ7tXNvfas+BIX6kr
	vDVg37AS1u
X-Google-Smtp-Source: AGHT+IELsBujY9SNBJLt4o9CpRfeG1CxgggxBRwEyXL6ylYYPhT36i9v44CHGG1iAKeuhsNwjk+iVA==
X-Received: by 2002:a05:6102:3914:b0:5be:cc35:3aae with SMTP id ada2fe7eead31-5d5e233eee3mr1189040137.16.1759925742454;
        Wed, 08 Oct 2025 05:15:42 -0700 (PDT)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com. [209.85.217.44])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5d5d39d180bsm1521983137.13.2025.10.08.05.15.36
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 05:15:39 -0700 (PDT)
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-51d14932f27so3651783137.2
        for <linux-pci@vger.kernel.org>; Wed, 08 Oct 2025 05:15:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUYzT0O4RWrmtUPob1T+hla2hVWO9ilefBTF2vzT0EmXwRbRqIatr+OyxbDXEJ2i04g8BvtbIWfBX8=@vger.kernel.org
X-Received: by 2002:a05:6102:44c9:10b0:5d5:dd07:902b with SMTP id
 ada2fe7eead31-5d5e224f3eemr892009137.13.1759925735291; Wed, 08 Oct 2025
 05:15:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007133657.390523-1-claudiu.beznea.uj@bp.renesas.com> <20251007133657.390523-5-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20251007133657.390523-5-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 8 Oct 2025 14:15:23 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXe+hU5ryDOhdyL3Ng6Dd=+Xj-S585-duRgq5kcm9SHBg@mail.gmail.com>
X-Gm-Features: AS18NWC41OCxyAm3HqpYys4LAep69bTxUP4YHs1nq_HCZwAoIiGa8nxTffJE60o
Message-ID: <CAMuHMdXe+hU5ryDOhdyL3Ng6Dd=+Xj-S585-duRgq5kcm9SHBg@mail.gmail.com>
Subject: Re: [PATCH v5 4/6] arm64: dts: renesas: rzg3s-smarc-som: Add PCIe
 reference clock
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
> Versa3 clock generator available on RZ/G3S SMARC Module provides the
> reference clock for SoC PCIe interface. Update the device tree to reflect
> this connection.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>
> Changes in v5:
> - this patch is the result of dropping the updates to dma-ranges for
>   secure area and keeping only the remaining bits

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

