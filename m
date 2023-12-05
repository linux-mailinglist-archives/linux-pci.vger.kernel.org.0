Return-Path: <linux-pci+bounces-531-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F55180610B
	for <lists+linux-pci@lfdr.de>; Tue,  5 Dec 2023 22:49:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 913BF1C20C86
	for <lists+linux-pci@lfdr.de>; Tue,  5 Dec 2023 21:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A10F6FCD1;
	Tue,  5 Dec 2023 21:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vcx1QLG6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C9721AA
	for <linux-pci@vger.kernel.org>; Tue,  5 Dec 2023 13:48:53 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-db510605572so4564403276.0
        for <linux-pci@vger.kernel.org>; Tue, 05 Dec 2023 13:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701812932; x=1702417732; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5eP0uI2tmZM9ZtqjfsWxJwWzFVr6JH04FbBdTmyNv/w=;
        b=vcx1QLG6WwxECp6bKqCg4qzU+3z0twyYAm/fKxldOfbA0WT56rifsYRjs4CMIYCITy
         aCAuzONwK7DCLR79+Wq9XgzHQiJt5eyvZuKwUHgqqP2BVud0kuHKDyCUvYuAJ0zJmV7b
         U47iSy0ilrmbYL+Ig3V7i06FYB4fsP0hA5kxYxGpOSHVmSo4Mxz9u0AdYe8mWtTIsVXJ
         2e/UlpJMgTltzCcqk818OWNmMQPdEVbjojQQoSI8FmevbYke5EDsmrPD4AbgfVI8FEzG
         6mzfV/A3hV5n40HIiA0Xf8gYZD8L9E1rdzo4m353KTeFLzqEp627WSWrPzsrT1mZPnvX
         ns4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701812932; x=1702417732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5eP0uI2tmZM9ZtqjfsWxJwWzFVr6JH04FbBdTmyNv/w=;
        b=r07O76/JVmOZr/qsyKw5SkM1/xqZ0w+njteCXo24l1nfi+IDt7ihhdyVCd5NsO93KR
         tMVnPvtqxgxtJEnni5loD/Opp2pAkRy6YcCMQ6CfCTnEc2HEQfav2v0O0xKT4JwmbBBn
         JfXrtCK5EMhOXQrIe8XHw2oOZ8wqDU/5Z4NNM3Yspwxf692R2gXrK8yvBzI/aUy6y84v
         c/gNixHjSu28PPBUhu0wmXLgMFvmLs+ZfWGm1Bhl0ki/tNMO2kXmGaJWHnsiPNvN5S+Q
         e0Vnti7Al1dvC2u2A72glaAlufkyipM8sJyZfh4rZPOitlQnZQLX7614mYtKKSSW7AZ1
         ES3Q==
X-Gm-Message-State: AOJu0YzxDieNRMivsFKNi4M1OMo6/Rpv1ZUpnlptiLgbuKaf8+105ZhQ
	nVp04wl+r/LzNKPUYoO+s6h0peq34hFZJx9ZhtKIqQ==
X-Google-Smtp-Source: AGHT+IEC7pNshX6Y57af6XTx4hp1z/Y9MEpMHk/hv4YF7sUJybFapw88Qbjz6GB2s4WrIdgZn+IiEoCY/A4u2lTVAiA=
X-Received: by 2002:a25:aac2:0:b0:db7:dacf:59d1 with SMTP id
 t60-20020a25aac2000000b00db7dacf59d1mr4535677ybi.69.1701812932200; Tue, 05
 Dec 2023 13:48:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1701768028.git.ysato@users.sourceforge.jp>
 <602e1ba4f02489fcbc47e8f9904f3c1db1c9f14a.1701768028.git.ysato@users.sourceforge.jp>
 <2ef81211-9525-4f96-a6b2-3fcfbed0c6e5@app.fastmail.com>
In-Reply-To: <2ef81211-9525-4f96-a6b2-3fcfbed0c6e5@app.fastmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 5 Dec 2023 22:48:41 +0100
Message-ID: <CACRpkdZUAMXJ4YM9+xW2Snzt0Dx5mxWjcwHZifsXPJH9ozL5bg@mail.gmail.com>
Subject: Re: [DO NOT MERGE v5 11/37] pci: pci-sh7751: Add SH7751 PCI driver
To: Arnd Bergmann <arnd@arndb.de>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, linux-sh@vger.kernel.org, 
	Damien Le Moal <dlemoal@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Dave Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Thomas Gleixner <tglx@linutronix.de>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Lee Jones <lee@kernel.org>, 
	Helge Deller <deller@gmx.de>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Chris Morgan <macromorgan@hotmail.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
	David Rientjes <rientjes@google.com>, Vlastimil Babka <vbabka@suse.cz>, Baoquan He <bhe@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Guenter Roeck <linux@roeck-us.net>, 
	Stephen Rothwell <sfr@canb.auug.org.au>, guoren <guoren@kernel.org>, 
	Javier Martinez Canillas <javierm@redhat.com>, Azeem Shaikh <azeemshaikh38@gmail.com>, 
	Palmer Dabbelt <palmer@rivosinc.com>, Bin Meng <bmeng@tinylab.org>, 
	Max Filippov <jcmvbkbc@gmail.com>, Tom Rix <trix@redhat.com>, 
	Herve Codina <herve.codina@bootlin.com>, Jacky Huang <ychuang3@nuvoton.com>, 
	Lukas Bulwahn <lukas.bulwahn@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	Sam Ravnborg <sam@ravnborg.org>, Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>, 
	Sergey Shtylyov <s.shtylyov@omp.ru>, 
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-ide@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>, linux-clk@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 5, 2023 at 2:26=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote:
> On Tue, Dec 5, 2023, at 10:45, Yoshinori Sato wrote:

> > +     if (of_property_read_u32_array(pdev->dev.of_node,
> > +                                    "renesas,memory", memory, 2) < 0) =
{
> > +             /*
> > +              * If no memory range is specified,
> > +              *  the entire main memory will be targeted for DMA.
> > +              */
> > +             memory[0] =3D memory_start;
> > +             memory[1] =3D memory_end - memory_start;
> > +     }
>
> There is a generic "dma-ranges" proerty for describing
> which memory is visible by a bus.

It's really a headache to use, so I put a bit of documentation here:
https://elinux.org/Device_Tree_Usage#PCI_DMA_Address_Translation

Yoshinoro, you can look at these bindings and drivers that use
dma-ranges for help:
Documentation/devicetree/bindings/pci/intel,ixp4xx-pci.yaml
drivers/pci/controller/pci-ixp4xx.c
Documentation/devicetree/bindings/pci/faraday,ftpci100.yaml
drivers/pci/controller/pci-ftpci100.c

Yours,
Linus Walleij

