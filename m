Return-Path: <linux-pci+bounces-37658-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A62FEBC0DDF
	for <lists+linux-pci@lfdr.de>; Tue, 07 Oct 2025 11:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6137A3AB1BE
	for <lists+linux-pci@lfdr.de>; Tue,  7 Oct 2025 09:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D872253F13;
	Tue,  7 Oct 2025 09:38:12 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D40165F16
	for <linux-pci@vger.kernel.org>; Tue,  7 Oct 2025 09:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759829892; cv=none; b=cHiCco7XPzUnGDiCw+LPGRGfWoPlArzT+Aw6balZA6FeAcnQu5xy1UzqfVudxZncJGD1Y0Dd3WmHr8KIRn23Mm4OI05d1gHMUR6d0tEQhRjqyqIjZVUPxmVmP1ZPJKf8p4BakM2UE+yR9CmSi5xfgu85HGiLj5BbCCANtR92xDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759829892; c=relaxed/simple;
	bh=vM8pMTuLE07i2LEgmF4lMZLaKCtkOjD8GlbT6u/BICc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U1s5kL4/W1Y6l9yEmzTp8IltAeGL51PIJRO3t6LaOGeN/frXMfEX7ZeLALsfHixBZ7KWCUuidcasxciIATnxGr4pV00D7OorseCYwShrJzVAwBuBFdOu110e7GkdekzGMzykS+DngbXDDar/PfBRKGAwsUwP64n0xU53I44j97o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-54aa789f9b5so4596972e0c.1
        for <linux-pci@vger.kernel.org>; Tue, 07 Oct 2025 02:38:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759829888; x=1760434688;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3q+QEIFXqBPYZCCIeDe/OpyZelbNarCGc2Hc+hYBZL4=;
        b=YIKXOzsjwH0xQ4yBF52eC8DNobsIZ98XsfE5rgLJOKn3IKDBA8CWFmUwt3cU4nISdO
         X8njhoj79DA3uq578i2CAb1XzGJzPo9bVQKnilP8/2GdGSL57sgumZYgSwHswI1yKCcF
         kVxn+n3rxxD/VyFmmaHxsRUDlKEgb3PUgfMBy4KxXEBpxZKeP4DB5VaFM8jMMNmKj98g
         qRBxcWrmj3T46D0ioRVrNFTxA7Ja5HV9yWuvkVrY5iCQCd6lnvVl+NGZa6Ipo3R4SzvL
         lpbSoyuz39DOB8ZfXvl9a0vw3mHpKFLCoqjWT4ujY0WIy25ou1ezux41DYONtR5LIYli
         Ep4g==
X-Forwarded-Encrypted: i=1; AJvYcCVVl0L6DYYF53xj/PoyjYuH2feN0fGb/WepniJI072sX94bLHGselL65KLMtFkEipUXYMPGOi8YYho=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMoIAzCZG7cC2dIai3yrKbxpRuwPMegPKTIxlmFSPx1LjvWQFY
	KSH9CqjIIL9uFzansr39nFyp/Pg8DKdwxI2Hl6gqmDDa8XqxgCiFjGw6tUS30YGr
X-Gm-Gg: ASbGncsS9faV7c8H7W4xXk/ToAY5KzAGEHSXigdbUfkwpjhsWBFrrUG102udrap1Gn1
	/LkzGQzO8YkwAIuzgCWaIY1LPDMT00l1YYW8YrH2AWhRqKB7dJFa+9LpyAqoakLALXjN+NNaw8G
	XcUYmJAuidu9MzC6oIooE0u2omPkRqtmHZJV5NJS1Ebe3RkJSuGqmUjCv+X3LRNzJLTzgJYxgJl
	kl/ZA6P5HsSUbpyEQOycxE2kAR0Gk73FjLlwH+nqFVVN6N2lFcQReGus3OorY+YTTQjQ9fnS3pw
	o7K10w9cANxFCKaRpPYvGazuK+bTHdj3tuKBkfiXSPLee+5uiCt+8ZktE5kj4XQUK5yXx/f478/
	oBkgfmrK3k8A8CrDcxboU7k8t5Pyro1slcw0Z+UwlCqAoFLYTGn+hOZVZUezcPIozwPj/CL4Gsk
	WsMm2jFVpwyF30+SYYe6s=
X-Google-Smtp-Source: AGHT+IEMt+WCyKY2luBtXbHhSNYI89GabuhqcW9BQdDtBMPkpyL8i93pLkAT2mr64opjZO5V0AXpVg==
X-Received: by 2002:a05:6122:3544:b0:554:afe3:1fbd with SMTP id 71dfb90a1353d-554afe32141mr330812e0c.11.1759829888538;
        Tue, 07 Oct 2025 02:38:08 -0700 (PDT)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5523ce6430asm3653010e0c.7.2025.10.07.02.38.08
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 02:38:08 -0700 (PDT)
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-580144a31b0so3112502137.0
        for <linux-pci@vger.kernel.org>; Tue, 07 Oct 2025 02:38:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU+d2RACLtmYQOdglxhjfFHVgffAVGhCjCAEDN4vpz4IFItcTGQR3pcnHngAWC4en3zXy1UCZWgQyE=@vger.kernel.org
X-Received: by 2002:a05:6102:292a:b0:5be:57a1:3eda with SMTP id
 ada2fe7eead31-5d41d020b48mr6240729137.2.1759829888107; Tue, 07 Oct 2025
 02:38:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007092313.755856-1-daniel@thingy.jp> <20251007092313.755856-4-daniel@thingy.jp>
In-Reply-To: <20251007092313.755856-4-daniel@thingy.jp>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 7 Oct 2025 11:37:57 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWDfNgUUh-uU7ZFKmmAccEMqDdfDpwRXQYmwjMG6O_Trg@mail.gmail.com>
X-Gm-Features: AS18NWCsRb9Pc5BA4Gs-2WvP7BRo3Mx4GNtWy6MFkPi8rKNsMmOdkKU4tfHRGL8
Message-ID: <CAMuHMdWDfNgUUh-uU7ZFKmmAccEMqDdfDpwRXQYmwjMG6O_Trg@mail.gmail.com>
Subject: Re: [RFC PATCH 3/5] m68k: amiga: Allow PCI
To: Daniel Palmer <daniel@thingy.jp>
Cc: linux-m68k@lists.linux-m68k.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Daniel,

On Tue, 7 Oct 2025 at 11:33, Daniel Palmer <daniel@thingy.jp> wrote:
> The Amiga has various options for adding a PCI bus so select HAVE_PCI.
>
> Signed-off-by: Daniel Palmer <daniel@thingy.jp>

Thanks for your patch!

> --- a/arch/m68k/Kconfig.machine
> +++ b/arch/m68k/Kconfig.machine
> @@ -7,6 +7,7 @@ config AMIGA
>         bool "Amiga support"
>         depends on MMU
>         select LEGACY_TIMER_TICK
> +       select HAVE_PCI
>         help
>           This option enables support for the Amiga series of computers. If
>           you plan to use this kernel on an Amiga, say Y here and browse the

This doesn't make much sense without upstream support for actual
PCI host bridge controllers.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

