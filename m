Return-Path: <linux-pci+bounces-1978-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4DF829439
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jan 2024 08:25:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10FD31F26FCD
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jan 2024 07:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7DF339AE0;
	Wed, 10 Jan 2024 07:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kwLNTr+s"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCB438FA6;
	Wed, 10 Jan 2024 07:25:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71E53C433C7;
	Wed, 10 Jan 2024 07:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704871516;
	bh=y0XYir9hehV1QYoG8yiAHQAvf4oF+CEU/HIxmrlgqD0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kwLNTr+szIOaRkpRZoDgbFhI9S8qYT6jpV0hXCZE5cflXXWNyOCDzFwDuK4h9slGy
	 Qg4fsDlf7+nOKVOl6YuCy3QQl8R0hc+l1J9N16iEikNi4H490UNePCs/0gsWOtIJSK
	 sYXIOLMzaRzIWpBfCkgzGgLzfUAX87+ztuN49TqFz3Ax6OpU9GvL0Oclg1imlijMXU
	 YRDUD1RyiUDumrGm0WOvf1L4FDUKylYTC9u9Y1IVMlvideoeSIq5GJAOrUfZ51Qg5W
	 //KglQA8Jm7AtnnpTE5zNayD2c5Bb1Vwk0spa6Q+D1vwfZ9Ih+RpZzCnWEx5fjAGXj
	 jN0LDsl1A6H2Q==
Message-ID: <7011f139-93c8-4b8c-9e90-dfafffd2a134@kernel.org>
Date: Wed, 10 Jan 2024 16:25:08 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [DO NOT MERGE v6 27/37] dt-bindings: ata: ata-generic: Add new
 targets
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, linux-sh@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>,
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
 <06fdb2cf7927681acf3099b826390ef75ba321af.1704788539.git.ysato@users.sourceforge.jp>
 <c2f88d7b-cded-42ab-bc5c-3d9a723daa1f@kernel.org>
 <8cae92cf-ac7f-4e73-b28b-ee543a9064d9@linaro.org>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <8cae92cf-ac7f-4e73-b28b-ee543a9064d9@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/10/24 16:19, Krzysztof Kozlowski wrote:
> On 10/01/2024 03:06, Damien Le Moal wrote:
>> On 1/9/24 17:23, Yoshinori Sato wrote:
>>> Added new ata-generic target.
>>> - iodata,usl-5p-ata
>>> - renesas,rts7751r2d-ata
>>>
>>> Each boards have simple IDE Interface. Use ATA generic driver.
>>
>> This looks OK to me, so feel free to add:
>>
>> Acked-by: Damien Le Moal <dlemoal@kernel.org>
>>
>> Note: The "DO NOT MERGE" patch prefix almost got me to immediately delete this
>> 37 patches in my inbox... If you wish to get this work merged after review,
>> please use the regular "PATCH" prefix. No worries, the series will not be merged
>> until is is reviewed :)
> 
> The point of DO NOT MERGE was that feedback was not being implemented
> and same set of patches with same issues were kept sending. :/

OK. I found that prefix unusual, but not a big deal.
Thanks.

> 
> Best regards,
> Krzysztof
> 

-- 
Damien Le Moal
Western Digital Research


