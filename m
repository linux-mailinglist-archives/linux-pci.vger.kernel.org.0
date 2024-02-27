Return-Path: <linux-pci+bounces-4133-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B63869B99
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 17:07:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3197528324F
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 16:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15CD514690A;
	Tue, 27 Feb 2024 16:07:20 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E571468FF;
	Tue, 27 Feb 2024 16:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709050040; cv=none; b=QgF8TxbakqucrjTLtrqXQdW4g75Q3iWsEv3g5I3a55cifhQ11F9f9i+UBXjosWHArxQ7+1SREIzxmlLfdC2vEom2O3QgmHgcFVtUuyf9nYy+GtQ9wosbIR5OH82PrD1RzbmTkNArPmGhgJOr3p7ZoRPxh2JHVT+QT7OLJCxMZIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709050040; c=relaxed/simple;
	bh=0eMZGYC3Obzp7NPifMc1wZQmW1MjzPdlblY+FimfEZ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ElDxVw8oKpnCzoa91nZVCxFeR6P6HSErUQQkEGQbEPmJ5DaYzlx9M2LXc4u1Q5EpGu/2tjih8M4qzbB3g4mw8RkFpy2NebOihlL6dRcKVJQ9ywpbAPxsvgTzeTY/1pRdtw4NjUiYLyhqv80DWpZBa8DWVCFPe4+ZvIjleyGtDDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-607e54b6cf5so30881707b3.0;
        Tue, 27 Feb 2024 08:07:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709050036; x=1709654836;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LHoeDfHGuL96HTfNJMCJ2+Eu2KeeOnl/Onf9zZl0DK4=;
        b=Ry6Xn8rOh85MZTr34gAT8nTAsEDBUSbUBiiNY82yOWDL3KCLz1mrsamKK1bacHqt8o
         /o6H/uT6hOZbTR3gvkAT9VOqRIzCw/VASdIH7YaPToczsDqODtUH0/N9ydm05GfXYuku
         oTb7DDKLshxBmFKkDOUx27spNjEjeAfAgR2S2Z8BgU7FEAvqJ3zieioXSE7LrMiTbuH3
         XEBncJ39duya1c45cwVg/V0DZGivXTIqhOGw5OHyI/7XsWF8yLzLsh6VeO0LvL+w4Xjl
         NnQq88gtN7lVXpIewgdlke+WfBkSKXKvCIQ5ZwISKeMhx5YecJwNFXgCpS12GXzqO/2r
         qW8A==
X-Forwarded-Encrypted: i=1; AJvYcCWx/XNft0W/4F/6UjqiG9O0mdvBMVieZKz+cYsjO9plbNdLQQy1KUoOYGX3rfiHcma/BSXx2lWwjbKVll86xdMi+szAOzQ8CI2jdxha1lNcMGWf358q5o6rHnOEQfx1FKEG7ZlAC+PVk9gJdzil97k9SLy7hy0KquW4CoLbN9FTGz2PEj0s5IID0AX6KuMDBanDRMocDJicHz6fEkqgGfxYL18fDF3bTL9bmWRVlid1Gy9dm5nt30E/Dr+Yefg7Zy+s2GeU+1gvbb+0Ep9tP2CjRp7tUR/7JWC9Hrz1rkSHZF9QNp+tTVUmk0sK/JpP8wLn4tVZNPyXdold1qIwZv9mGZ0+iYFZ1kKLyWRPgDyT3/r5zC9MTXI=
X-Gm-Message-State: AOJu0YwlQqnez9RI5JvFumeLV6TrEsgi+q7+8PehBHVua2BmGptBab6x
	nvV208MvLUVGE3/LRnfG9WbvK5DmpqayRIk7iF9jrberGea3wtVV7ZNbEukuewEpPw==
X-Google-Smtp-Source: AGHT+IGhZl/N4STVFVAAaDLTG1/F+S0zR94f1PsVA0f9mmC1AZfChV3CA8f756jwCAgg85Mhd6VcLQ==
X-Received: by 2002:a81:5749:0:b0:609:2fbb:96fb with SMTP id l70-20020a815749000000b006092fbb96fbmr785251ywb.8.1709050036308;
        Tue, 27 Feb 2024 08:07:16 -0800 (PST)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id p2-20020a815b02000000b006079f55766bsm1831057ywb.68.2024.02.27.08.07.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 08:07:15 -0800 (PST)
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dbed179f0faso2696644276.1;
        Tue, 27 Feb 2024 08:07:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW1V6P1cQSqqc/sR+3StMok/gHJFsd4v4Fue08kfyBON/a79tgRnI7A6UpgSRoB3QdlUjsfTaazFtmjc6foS7jCjEa+tILuEO9qs4gS1Fk4/Sn7oi4F1yZ3yAK2a5MzBSPoWqrtm+dHeU+h0NtPzYMDcJHIXJdF+mbVrUvZbEZosBgfA1DFtWCWBoEloQBOiPPdwz9N3anwleIeiHR+euX59hF9Oh94a6fpacda1PCMh3Yr0oQ27g4MfLUzie6JCg4uB4Gtz8yH0Nq2L1Gfp1LUKLh7OU+ZSHlI4YUnBlI9wrYrcwLXhUWuHQD5TCaRlIKfLHCGMrP4pcV4rXcLnqrxWtQm91dD1BVyoqB5MJcuH6psHoxIk44=
X-Received: by 2002:a25:d6d6:0:b0:dc6:daa4:e808 with SMTP id
 n205-20020a25d6d6000000b00dc6daa4e808mr1755203ybg.12.1709050035153; Tue, 27
 Feb 2024 08:07:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1704788539.git.ysato@users.sourceforge.jp> <22c41c392762f282752b2f31deeaf8f1f2254061.1704788539.git.ysato@users.sourceforge.jp>
In-Reply-To: <22c41c392762f282752b2f31deeaf8f1f2254061.1704788539.git.ysato@users.sourceforge.jp>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 27 Feb 2024 17:07:03 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUK6fKZuFN2kqrnzfvxcnJZS=YQm3oeQRczAjRG66ebMg@mail.gmail.com>
Message-ID: <CAMuHMdUK6fKZuFN2kqrnzfvxcnJZS=YQm3oeQRczAjRG66ebMg@mail.gmail.com>
Subject: Re: [DO NOT MERGE v6 33/37] sh: j2_mimas_v2.dts update
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux-sh@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Thomas Gleixner <tglx@linutronix.de>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Lee Jones <lee@kernel.org>, 
	Helge Deller <deller@gmx.de>, Heiko Stuebner <heiko@sntech.de>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Chris Morgan <macromorgan@hotmail.com>, 
	Yang Xiwen <forbidden405@foxmail.com>, Sebastian Reichel <sre@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Arnd Bergmann <arnd@arndb.de>, Vlastimil Babka <vbabka@suse.cz>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
	David Rientjes <rientjes@google.com>, Baoquan He <bhe@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Guenter Roeck <linux@roeck-us.net>, 
	Stephen Rothwell <sfr@canb.auug.org.au>, Azeem Shaikh <azeemshaikh38@gmail.com>, 
	Javier Martinez Canillas <javierm@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>, 
	Palmer Dabbelt <palmer@rivosinc.com>, Bin Meng <bmeng@tinylab.org>, 
	Jonathan Corbet <corbet@lwn.net>, Jacky Huang <ychuang3@nuvoton.com>, 
	Lukas Bulwahn <lukas.bulwahn@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	Sam Ravnborg <sam@ravnborg.org>, Sergey Shtylyov <s.shtylyov@omp.ru>, 
	Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>, 
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-ide@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sato-san,

On Tue, Jan 9, 2024 at 9:24=E2=80=AFAM Yoshinori Sato
<ysato@users.sourceforge.jp> wrote:
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>

Thanks for your patch!

Please enhance the one-line summary, e.g.

    sh: j2_mimas_v2: Update CPU compatible value

For the actual changes:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

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

