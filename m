Return-Path: <linux-pci+bounces-7702-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C858CA8D0
	for <lists+linux-pci@lfdr.de>; Tue, 21 May 2024 09:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2189E1C2124C
	for <lists+linux-pci@lfdr.de>; Tue, 21 May 2024 07:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE424F88A;
	Tue, 21 May 2024 07:19:53 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343684E1CB;
	Tue, 21 May 2024 07:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716275993; cv=none; b=cNjToW0I4BI16KjNYHq+liD91EW9Sf5jovfyI3Xvn83pY6FA9y98aokll29C0aYr8PGI9e5kLc6hDD4NhFAhDe5czHRULjTDKIgMAeMAg80cD4swA2SCXtUNi82EHnISK2edE0GZ9y8GSpZmpP4vQXu1lfUwICL0fLToOmnG8Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716275993; c=relaxed/simple;
	bh=kZyvE9UDLl6WTYeDxRjwfmu4Q8LQcZJTjhT/YcTyaQw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CxFOBB3MMZAaKjjB6z27UtEHJkO8R2YAvQRuJwHchiEUF5kkTm6i+bVxy51jxK28gB4wkRAQrsXDWyxRIInGDf774dRBA9Y3r/ZZHsOnQyFoqdcP7WSEJaAAsFmjU7x1PK43+tv/XcNNJMQIsrltsBLNJsgFBKxtSJ+tNR2WSaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-debaa161ae3so3297561276.1;
        Tue, 21 May 2024 00:19:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716275990; x=1716880790;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1KTzn0hU9Z4UN/kHuOvflOdET5gWXbcBejm7dn9vrh4=;
        b=b1QTzLIt9xpLobs7DRSKJLkhNER37gVfP1GNedtU/Qq5IIfhtECds5wFSQX5gBEDDA
         BM3ogB0OHT3sVV1P0ovDAsqBSLgu0jD9I7IFBXF+ygz6trc3ZRxiNI6zKqnCqLKDanQQ
         0sYOyNGJi9KrATO7rjeed4Tn7/4iDAvA5nfca/MJX3M/Zb7SnXZzGm3l/SrP1DesqKSX
         LTULJJ3oVZPi4QsGxjCqOQMGQLrbJKdKbkJTDN9dhl4LOIlDm8MPCh3NcZMcCC7ZSNcd
         KCNUfUDOgYs7WkxtNYsGPGjEMSoCSl9NLOGyJejpZWdUZ3utlZVHIFpgb5vW+GukPYtp
         8YwQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+aWS18QjTItQyG4mhfGQg+0EEWDVlRIY+00Cif46nKIVrfF/47nYigOaTxZvVqRD20Ggx2NKXksxqtP4LoLbFHbTjWlbLxleNGRsRhSYPBVjkQi3EmX2gUtOSuqmRS4wPOLSMN2Bri66GsJvtfB2mFWpwVd7neBNJLUEDbB31ZyAsAwV+VxozgRh0tpdNnGJlw7dnSe3yRS8LSJaBs4X3nWzcfdhBg/7TDRey1Ou3+0uqNSURQC7Kjazy/DO7a5i2qtuE/iFU6RPbB1tOs3L5hgcT4ZJYta5KHducCERaKFe+yL+OCDNED6dmZzCK5I/7mu7ZkLR5wMr6Cig6zlB9PYvrtdnckN3lS6IqZvFgBLH7IsyDhKJlptMFnWwtAlzJ+o446YQ2B8CROCcSZ9D05Q==
X-Gm-Message-State: AOJu0YzgqkI4XkbThQJK49Ioza1gVOWfHJs9CurXN8ggASOm46wsR5pP
	AyOuf97pqsP2UVO7Pu16uhYb42ur9f8eQmpV0bhZXeHIMvkC8ByB1pCXXBXo
X-Google-Smtp-Source: AGHT+IGEirqxTOMzWTamq9P57yxkEVKAurn6q9zbUNC7MEGZU4SMG3Vx0ppIBEhtkbjR13HGWAUNTA==
X-Received: by 2002:a25:a2c6:0:b0:de6:fe6:68a2 with SMTP id 3f1490d57ef6-dee4f33732bmr41516330276.23.1716275989735;
        Tue, 21 May 2024 00:19:49 -0700 (PDT)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-debd374406asm5367730276.29.2024.05.21.00.19.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 May 2024 00:19:48 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6209e8a0386so27044307b3.0;
        Tue, 21 May 2024 00:19:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV/AXipcXvNAzeXLV41yIXTwgiuy/Nj00R7q0HAh81YDdhdTHWw/66LBl792bKRzje/D/E4hdy7IPKn9ZtWp1owSFDG/c78+RMs9+iJrhUyVvJpn8hhYgIRxkSra90nGOrVAnsUjJMCyJT+zW7HtUcCJMJI0DxvK7TlN51H7dWgj3g0EPBzGo4JAiVc0XAmGzl2JjnggrJmQih7P4HnLZBqWP0wQFz77+iNMXz3Aj0rUlN2WMWed8G6jIwx9cQ2QKXXxisIlIVE9gnqrox1fwjJOmAo74ZdoG9u5Z3+lWc8rc/SvYl5Y1kgzV5E6eqMLytFeGnIIWk1QfTqq9BAF+zCsqxOTM7sz5fRYJ4YAtWOnIk27If4ePpYj3zA4/J8ipKPft+hdEy7XcPkxGArCJXDew==
X-Received: by 2002:a81:ae5f:0:b0:61d:fd3e:8e8f with SMTP id
 00721157ae682-622affa8b29mr418170827b3.25.1716275988366; Tue, 21 May 2024
 00:19:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1712205900.git.ysato@users.sourceforge.jp>
 <455e40c03314294f9c2e64480aa69f8261a3f2d5.camel@physik.fu-berlin.de>
 <87fruc8wg4.wl-ysato@users.sourceforge.jp> <46c11cf9f837416470c50fa678df0ddb94a0a22e.camel@physik.fu-berlin.de>
In-Reply-To: <46c11cf9f837416470c50fa678df0ddb94a0a22e.camel@physik.fu-berlin.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 21 May 2024 09:19:35 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWwhoWzeS78JKVJzxZ9B4-TTOSH8rX4eyYTdpYgaepjzQ@mail.gmail.com>
Message-ID: <CAMuHMdWwhoWzeS78JKVJzxZ9B4-TTOSH8rX4eyYTdpYgaepjzQ@mail.gmail.com>
Subject: Re: [RESEND v7 00/37] Device Tree support for SH7751 based board
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, linux-sh@vger.kernel.org, 
	Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Thomas Gleixner <tglx@linutronix.de>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Rich Felker <dalias@libc.org>, Lee Jones <lee@kernel.org>, Helge Deller <deller@gmx.de>, 
	Heiko Stuebner <heiko.stuebner@cherry.de>, Shawn Guo <shawnguo@kernel.org>, 
	Sebastian Reichel <sre@kernel.org>, Chris Morgan <macromorgan@hotmail.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	David Rientjes <rientjes@google.com>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Baoquan He <bhe@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Guenter Roeck <linux@roeck-us.net>, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, Stephen Rothwell <sfr@canb.auug.org.au>, 
	Javier Martinez Canillas <javierm@redhat.com>, Guo Ren <guoren@kernel.org>, 
	Azeem Shaikh <azeemshaikh38@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Jacky Huang <ychuang3@nuvoton.com>, 
	Herve Codina <herve.codina@bootlin.com>, 
	Manikanta Guntupalli <manikanta.guntupalli@amd.com>, Anup Patel <apatel@ventanamicro.com>, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	Sam Ravnborg <sam@ravnborg.org>, Sergey Shtylyov <s.shtylyov@omp.ru>, 
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-ide@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 20, 2024 at 5:25=E2=80=AFPM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> On Mon, 2024-05-20 at 22:06 +0900, Yoshinori Sato wrote:
> > I'll be posting v8 soon.
>
> Sounds good! Maybe we can start merging the patches that contain fixes on=
ly
> and that have already been reviewed. This way, we can reduce the overall =
size
> of the series a bit.

+1

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

