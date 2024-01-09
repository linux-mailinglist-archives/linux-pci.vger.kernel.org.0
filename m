Return-Path: <linux-pci+bounces-1950-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE88B828CCA
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 19:42:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E097B24760
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 18:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191693D0A4;
	Tue,  9 Jan 2024 18:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q+co3ngm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1943C49D
	for <linux-pci@vger.kernel.org>; Tue,  9 Jan 2024 18:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-50e6ee8e911so3469698e87.1
        for <linux-pci@vger.kernel.org>; Tue, 09 Jan 2024 10:41:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704825712; x=1705430512; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b3kY/sI+OewHLdAt8Sws7SovwxQjp4vZRhkHLuCSn/w=;
        b=Q+co3ngm3QhNnSMVf1JtEQ9xRL+T6OdBUTkuBEfGHJ2TAHdIay644/+v4NxIXEw/R/
         AWLhihcEiHGz+ay8oUrm4TN7Un39mw91e2TiQI2kCF6bVmwDBpqN2KPeBhmrusOGu9/j
         D7pv5K3fswNu6IZynF0LyNIydwgPi4c/l4cPoggH1HzMLGxEkBEj2gsnGBpREKW7uZfO
         XEPYEge8MNe5g0RnNsvfGdqBzyGD/AjD4lEuRnxopgOEV4G6a3H8cKOQHuJ/FR2M0JzN
         Hkl41HY0GZW1ScZOzqDrEysoiEiPWGurVHDxQWAz6s5iF6Py6nKQJxKm5P8Z8W1jUjo4
         jGTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704825712; x=1705430512;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b3kY/sI+OewHLdAt8Sws7SovwxQjp4vZRhkHLuCSn/w=;
        b=RW/1Zvh4+xNkU2ti21XOjXgJwh38ge672VVepceOf/kGquT1Qqxv0dphPGnWQDcdTy
         r8NBRPFow5SqvxaXjaIsr2pxJ8VRWRWBJXfxJHRcck0tZRlTZlNPLeuH1POo519dmeWQ
         OLsRVCYks62n5pOM0wjdP2FDI69BXIP76GbP0SydgQQXhOea+g+ywK30HoixRSDbhWlp
         XEgqjM5eZkwW2myUgYj29cDkG36VpGxnXYKAjJJ5E/wnnqk0ocC1TgJUqxGcAxMqmrMc
         oqQlcYcqIpAwI/m4xDWdFRphK1bhcH5/wYRdn1Gg9/W+guIRpt+igo2iBJgBXl3eGzBm
         Axvw==
X-Gm-Message-State: AOJu0Yzednr/E7v+tLdMZiRaEpTWJZnutT5BQoUIZm7TU7ZJcgVbS7lh
	xi7uDPnAmBSGZJNiHpUmn4AVmeKQnwhd0Q==
X-Google-Smtp-Source: AGHT+IEIf5y9iCXRqGeQfwB4wQA61OuNMht8Vp0eJHsbfT3YBU5W1VDHv2z3upGwadxw7MEo4SYUBA==
X-Received: by 2002:a19:8c0a:0:b0:50e:7c08:4350 with SMTP id o10-20020a198c0a000000b0050e7c084350mr2353230lfd.42.1704825711996;
        Tue, 09 Jan 2024 10:41:51 -0800 (PST)
Received: from [192.168.1.20] ([178.197.223.112])
        by smtp.gmail.com with ESMTPSA id h22-20020a170906719600b00a2b9a6f1e9dsm242124ejk.10.2024.01.09.10.41.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jan 2024 10:41:51 -0800 (PST)
Message-ID: <3666744f-0d34-477e-83bf-737ed7a4c230@linaro.org>
Date: Tue, 9 Jan 2024 19:41:47 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [DO NOT MERGE v6 04/37] dt-bindings: interrupt-controller: Add
 header for Renesas SH3/4 INTC.
Content-Language: en-US
To: Yoshinori Sato <ysato@users.sourceforge.jp>, linux-sh@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Thomas Gleixner <tglx@linutronix.de>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Magnus Damm <magnus.damm@gmail.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Rich Felker <dalias@libc.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Lee Jones <lee@kernel.org>, Helge Deller <deller@gmx.de>,
 Heiko Stuebner <heiko@sntech.de>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Chris Morgan <macromorgan@hotmail.com>, Yang Xiwen
 <forbidden405@foxmail.com>, Sebastian Reichel <sre@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Randy Dunlap <rdunlap@infradead.org>, Arnd Bergmann <arnd@arndb.de>,
 Vlastimil Babka <vbabka@suse.cz>, Hyeonggon Yoo <42.hyeyoo@gmail.com>,
 David Rientjes <rientjes@google.com>, Baoquan He <bhe@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, Guenter Roeck
 <linux@roeck-us.net>, Stephen Rothwell <sfr@canb.auug.org.au>,
 Azeem Shaikh <azeemshaikh38@gmail.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Palmer Dabbelt <palmer@rivosinc.com>,
 Bin Meng <bmeng@tinylab.org>, Jonathan Corbet <corbet@lwn.net>,
 Jacky Huang <ychuang3@nuvoton.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>,
 Biju Das <biju.das.jz@bp.renesas.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Sam Ravnborg <sam@ravnborg.org>, Sergey Shtylyov <s.shtylyov@omp.ru>,
 Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 linux-ide@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-pci@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-fbdev@vger.kernel.org
References: <cover.1704788539.git.ysato@users.sourceforge.jp>
 <b9cea5b530a6d68ea921174fbbda60afb8dd4432.1704788539.git.ysato@users.sourceforge.jp>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <b9cea5b530a6d68ea921174fbbda60afb8dd4432.1704788539.git.ysato@users.sourceforge.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/01/2024 09:23, Yoshinori Sato wrote:
> Renesas SH7751 Interrupt controller priority register define.
> 

Still not a binding.

Some parts of my comments are implemented, others are just ignored
(dropping the file, fixing full stop in commit msg). This is confusing.
I don't know. Shall I just NAK it to make it clear?

NAK

Best regards,
Krzysztof


