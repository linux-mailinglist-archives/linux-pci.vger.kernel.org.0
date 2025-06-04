Return-Path: <linux-pci+bounces-28946-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5342ACDAAF
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 11:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EA9218920A1
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 09:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C21728C5DA;
	Wed,  4 Jun 2025 09:14:13 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A2B14C5B0;
	Wed,  4 Jun 2025 09:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749028453; cv=none; b=AzFnmpyzTEvAYmYgDZUX8Zw+f9s3R2FyiFrXEdA1aEJeCc5cG8mrmuSAz2jlaWIJOmTIVmP1g7i1f45NdVQHQnnp2aaPnNlfJZ9TQKkmnwWlK6L1AHilO+9jDbv0+8hSdVI4Q0FC155VnuOxh/7lUIC4sPo/pFwog4iF8VJChHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749028453; c=relaxed/simple;
	bh=ITTkVy9xtDGrKbNEoXW3eCCS9IfQ6H9SQSDSoAgSLjQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M0ivdMVNaYQuyG1rLYVIlnEbknhv7F5yEmxw7FUal2IMzZjNFnvUbx9NAcewO0hncm9fkBlluoocRBZaZjs+4V5I9e3j1+jyO4wDVetceKf3ZoGKe7Ucoq+WyC6lBj27fz8uG7/4c8iWPgOBVXD7H/smVe0NYt9LSnPcp5O6jP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-4e7374f2dc1so482786137.1;
        Wed, 04 Jun 2025 02:14:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749028448; x=1749633248;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SRV0Q86dcfMGK7s8qaqpOjDtaB6acLpurJwiHDkiJCQ=;
        b=shWsnGCtpfhbPBc4g6RPCurzCuVFBy4VODEmdJ4m2FL8cIDEnpUOPcrCsIV/T3uu/2
         fFH8p/7mEdDn3/0hzxnuA0sQEfQKkGOoNdg2VTLtE+ufZisWTsBfdV9ZKqM55lEs5d7a
         zmHbCq0rZ2PYRDbOGPbF+8hMYsq4DM7MltM3uLNqBuvFufUprZMpawYXIa0hKVKOz0rv
         NakquoPqIp5LuNJwbZ3sg1TmsiS6PqUkBVkTm6gMbias77EMvvADiJFJPnC21nNt88N4
         wpgHONj71KfA1PkFY6otfOnI8Y1YaLmutqUKuLZ0wVlre0SRE99CIgPpD8hFTgUdPn3M
         o86Q==
X-Forwarded-Encrypted: i=1; AJvYcCUo2Bwy6jclCbwvbnqMIeale/N2ZmXJWWLr3Z0lFlzmKmQrU7Jp5aHF9/bxECXVsDp51/xPXv/D9lRlLLvM@vger.kernel.org, AJvYcCWBFQtwA1naeAjeTLDBjWFObxkUrbXWEphHIHNXXZSq7y0IJ2ldLlRwGS2FrQkM55op/7LMFlpgWk3v@vger.kernel.org, AJvYcCX3IJlqf7fbHOzyIya0X0Cc3gKROGMGeYwusIuOtG9ZBuX2aDO+prSBR9AsgQVRthWNQz/l++vxdJ2q@vger.kernel.org, AJvYcCXAdP9PQd45F/AUm43t7cCM5uk5SuvZKm1Ww82kRGYwgDiL3v3iFaWAQfUceYbKsphTEadiBuJRqLJCy+ZI0J54G2o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnArPiGYKZCYl1u9BljfI+tYqunCz5oVWlfr0ssIex1vZP0M5+
	omgXhdwHeksonRbcrCnP67AQO6lDBwHzfxUHGJd7apNlRy+J8fQgudUeWg4LAqY0
X-Gm-Gg: ASbGncv+CCIIfMesD0C7xPycIca1drSEBWfMxHqZl0990pb5PKlMFlvLyb48uM/Tugg
	iZ4rlh3K4zDWhwwwcy/n9ML8sSJit/xbqLNrC2kWmIzu0DgCUZbhxmnVJ4ad8+doRIqpV7RslbW
	EhR83aHzr1EqB30JyaDgdmIFBelNMR3p8Qc7pvC0BbO/L14DMFk5KK8mlGRJRaRDBVCJaucQ+6f
	EYi9tNtBsINJa+QCEjCK1GOBg4G48UHHCUOl1S4lEuQQPDi6jZjq8/uwSMaNreFZjZVPvItZLX8
	zGUuTH3WU6WZXrHh9k5NBXRpKWGj2lp74aiXxtKUNiF2Zk6zSrZHc0AmrXwOI9GR3JkZrBBjMa8
	7wE4xakbZ9v1AMhIImka+rjkqk6jT
X-Google-Smtp-Source: AGHT+IECDKK78AUAupFMjnt0SWq8kLYaNTC5uMXie+1C94b0Hed3oFQmTJbJaRACwSaBIl/52ZLl0w==
X-Received: by 2002:a05:6102:2acf:b0:4e5:9323:d2b9 with SMTP id ada2fe7eead31-4e746ce3628mr1060050137.2.1749028447998;
        Wed, 04 Jun 2025 02:14:07 -0700 (PDT)
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com. [209.85.221.175])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-87e2a2a2eb2sm8793677241.11.2025.06.04.02.14.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jun 2025 02:14:07 -0700 (PDT)
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-530c7ef7226so191330e0c.3;
        Wed, 04 Jun 2025 02:14:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWuUJAHH16FmZ2q0oe2AYoSbLW9gkQaGMYY2mOpnbmODzzts0/UZvSySi4yR/oVcjVof7S5B6VTu1XGyXci@vger.kernel.org, AJvYcCWwJ9ZaFsduSFjSU1UNcV8jspc9fBRzhiKj2jD7Ll5dbG2woZcycYBjjF0XmRLcQbv0RVvc3/PE4IYR@vger.kernel.org, AJvYcCWwvI9+WpPY38GVFbikKF/SQSfHCVfCZo72Ag8taIwuCSkkmzW5GxGWOhfQ+z5gaw4YCzPRqop8LSan@vger.kernel.org, AJvYcCXEpY3nj25Hi8NKrDcegQ+XKUsijWRoNLYKl+AL7gYSAEi4113A9FigRh1jpHsTeXJmY4vbW/Xb+3sqijALcwG3pmI=@vger.kernel.org
X-Received: by 2002:a05:6102:4192:b0:4e6:d784:3f7 with SMTP id
 ada2fe7eead31-4e746de3672mr1008327137.15.1749028447356; Wed, 04 Jun 2025
 02:14:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250530225504.55042-1-marek.vasut+renesas@mailbox.org> <20250530225504.55042-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250530225504.55042-2-marek.vasut+renesas@mailbox.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 4 Jun 2025 11:13:54 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVMnjryv6nfP=7DTmsCtucuw7RAuYxW_zTRhCnwFxR34A@mail.gmail.com>
X-Gm-Features: AX0GCFv3oImgu85Rwzjgo0touyo51sp9hBFNSI5sTOBJmChOTLWl5fT7ekg_o3E
Message-ID: <CAMuHMdVMnjryv6nfP=7DTmsCtucuw7RAuYxW_zTRhCnwFxR34A@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] arm64: dts: renesas: r8a779g0: Describe root port
 on R-Car V4H
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-arm-kernel@lists.infradead.org, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Bjorn Helgaas <bhelgaas@google.com>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Rob Herring <robh@kernel.org>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Marek,

On Sat, 31 May 2025 at 00:55, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
> Add node which describes the root port into PCIe controller DT node.
> This can be used together with pwrctrl driver to control clock and
> power supply to a PCIe slot. For example usage, refer to V4H Sparrow
> Hawk board.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Thanks for your patch!

LGTM, so
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

I will wait a bit for more comments (if any) before applying.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

