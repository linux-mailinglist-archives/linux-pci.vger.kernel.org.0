Return-Path: <linux-pci+bounces-493-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF29B805630
	for <lists+linux-pci@lfdr.de>; Tue,  5 Dec 2023 14:37:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE5651C20F7B
	for <lists+linux-pci@lfdr.de>; Tue,  5 Dec 2023 13:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 232D05D910;
	Tue,  5 Dec 2023 13:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="qJEun988";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kzomfXtM"
X-Original-To: linux-pci@vger.kernel.org
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF4141AB;
	Tue,  5 Dec 2023 05:37:15 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 3B5CC5C0073;
	Tue,  5 Dec 2023 08:37:15 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 05 Dec 2023 08:37:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1701783435; x=1701869835; bh=MS
	o40/DzILPmk4fVztq26tP1UcAt4IZ5edthROYfIeQ=; b=qJEun988LPpJTneK4B
	iOm8MG4rNWEJ2M9ylmnOyL8l6IwefIw3g+/fCxBQAzyJ7hYdhL0/vWbPNpuzsUFh
	3rJnLmNXViDWxshFEt8CsL6vb4PkVF+BORWHrbr3H58yGuLoV7d7VhDamFjpQhcT
	U/u+M5I1drvoNI3dxxKiGfFRUhtB2Ve3C1g31EZOupjooD8zk4+Mo+IjzVNeit2A
	xrIqpr9SYwC2iP4Gd4vV3r7M8WNNp6iK/T8nTedZd/kkRg34bxzcsBoYntKliqtf
	rWt81QWBmEKAovmrUW9mB6GfVJnBfIPPZu0EVRiRyoy+3Hv5hrUNpSjlpotMCzoZ
	Tfwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1701783435; x=1701869835; bh=MSo40/DzILPmk
	4fVztq26tP1UcAt4IZ5edthROYfIeQ=; b=kzomfXtMU0QNVW1G9ASuu30rLAGos
	brOM5jegxaM9w5e0E+Mx0NaBvK7yKRLW7QEFi70l9E13SQcdbmlVehN4FL8GG+v3
	7RsF2zI2Nyv6dHAMGGHfT47Lx9dGZC/A9N679EkNRrcIR+iFfssYQHIRL1Npjkbk
	eBYMVft4X3MdNIlB9Zj8bhY3LknHONoh7BVL83Nvp2HHAnfut73c+YWszU2OV3K/
	6zMPitTGR7BZjpWbzVUNxULgkm1Gk00Wy3GqEXLYAsGzKmGbotT7+uN4YvG5UW9z
	iuXVOurc69aA6dcmz84gY6uMYS+XnL6znE2Xy2uInouwlGoH3ug5OPSsw==
X-ME-Sender: <xms:iidvZSzxzQt9c1fSV60YcizLeTJiBllKOkZaAoH87W9KXaB9-0jiKg>
    <xme:iidvZeRT49Fh7djkd5qgQf2NCRjlrWgdztUMf8L5b0qdI-EFZGp5EXBPiTBQ73rXl
    eg3yUbr-dA7ideEfis>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudejkedgheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:iidvZUXouaBsV59xnbNVHKF_uXZMwp2q_wCdiiHs5wsWMnd_ACMcKw>
    <xmx:iidvZYhPVbBEyaGydQt8CbxNo52xULx8foRb9eVwP_9xGKxILkcQRA>
    <xmx:iidvZUDRajflv2u1GEbjLptgtHm7CwStnkYNNuqBvb20vTp0-pEA4g>
    <xmx:iydvZdKP1SM2yKZ3zCKMv0fokHE2VVWKyjYuf1Spzjczx5f7DTcEfA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 2D405B60089; Tue,  5 Dec 2023 08:37:13 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1178-geeaf0069a7-fm-20231114.001-geeaf0069
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <2a5ce0d0-ad0a-49d7-84a6-055c4b729eec@app.fastmail.com>
In-Reply-To: 
 <f671beae8a8ebfd361f4c903bccce713135a169f.1701768028.git.ysato@users.sourceforge.jp>
References: <cover.1701768028.git.ysato@users.sourceforge.jp>
 <f671beae8a8ebfd361f4c903bccce713135a169f.1701768028.git.ysato@users.sourceforge.jp>
Date: Tue, 05 Dec 2023 14:36:53 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Yoshinori Sato" <ysato@users.sourceforge.jp>, linux-sh@vger.kernel.org
Cc: "Damien Le Moal" <dlemoal@kernel.org>,
 "Rob Herring" <robh+dt@kernel.org>,
 "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
 "Conor Dooley" <conor+dt@kernel.org>,
 "Geert Uytterhoeven" <geert+renesas@glider.be>,
 "Michael Turquette" <mturquette@baylibre.com>,
 "Stephen Boyd" <sboyd@kernel.org>, "Dave Airlie" <airlied@gmail.com>,
 "Daniel Vetter" <daniel@ffwll.ch>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
 "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 "Bjorn Helgaas" <bhelgaas@google.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Jiri Slaby" <jirislaby@kernel.org>,
 "Magnus Damm" <magnus.damm@gmail.com>,
 "Daniel Lezcano" <daniel.lezcano@linaro.org>,
 "Rich Felker" <dalias@libc.org>,
 "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
 "Lee Jones" <lee@kernel.org>, "Helge Deller" <deller@gmx.de>,
 =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 "Jernej Skrabec" <jernej.skrabec@gmail.com>,
 "Chris Morgan" <macromorgan@hotmail.com>,
 "Linus Walleij" <linus.walleij@linaro.org>,
 "Randy Dunlap" <rdunlap@infradead.org>,
 "Hyeonggon Yoo" <42.hyeyoo@gmail.com>,
 "David Rientjes" <rientjes@google.com>,
 "Vlastimil Babka" <vbabka@suse.cz>, "Baoquan He" <bhe@redhat.com>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Guenter Roeck" <linux@roeck-us.net>,
 "Stephen Rothwell" <sfr@canb.auug.org.au>, guoren <guoren@kernel.org>,
 "Javier Martinez Canillas" <javierm@redhat.com>,
 "Azeem Shaikh" <azeemshaikh38@gmail.com>,
 "Palmer Dabbelt" <palmer@rivosinc.com>, "Bin Meng" <bmeng@tinylab.org>,
 "Max Filippov" <jcmvbkbc@gmail.com>, "Tom Rix" <trix@redhat.com>,
 "Herve Codina" <herve.codina@bootlin.com>,
 "Jacky Huang" <ychuang3@nuvoton.com>,
 "Lukas Bulwahn" <lukas.bulwahn@gmail.com>,
 "Jonathan Corbet" <corbet@lwn.net>,
 "Biju Das" <biju.das.jz@bp.renesas.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 "Sam Ravnborg" <sam@ravnborg.org>,
 "Michael Karcher" <kernel@mkarcher.dialup.fu-berlin.de>,
 "Sergey Shtylyov" <s.shtylyov@omp.ru>,
 "Laurent Pinchart" <laurent.pinchart+renesas@ideasonboard.com>,
 linux-ide@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-pci@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-fbdev@vger.kernel.org
Subject: Re: [DO NOT MERGE v5 22/37] dt-bindings: display: smi,sm501: SMI SM501 binding
 json-schema
Content-Type: text/plain

On Tue, Dec 5, 2023, at 10:45, Yoshinori Sato wrote:
> Define SM501 functions and modes.
>
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> ---
>  .../bindings/display/smi,sm501.yaml           | 134 ++++++++++++++++++
>  include/dt-bindings/display/sm501.h           |  25 ++++

It looks like we already have a binding at
Documentation/devicetree/bindings/display/sm501fb.txt

> +  little-endian:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: available on big endian systems, to set different 
> foreign endian.
> +  big-endian:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: available on little endian systems, to set different 
> foreign endian.
> +
> +  swap-fb-endian:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: swap framebuffer byteorder.

Why do you need both the "swap" and the specific little/big
properties?

> +  crt:
> +    description: CRT output control
> +
> +  panel:
> +    description: Panel output control

What type are these?

> +  smi,misc-timing:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Miscellaneous Timing reg value.
> +
> +  smi,misc-control:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Miscellaneous Control reg value.
> +
> +  smi,gpio-low:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: GPIO0 to 31 Control reg value.
> +
> +  smi,gpio-high:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: GPIO32 to 63 Control reg value.

Register values should generally not go into DT


> +
> +  smi,gpio-i2c:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    minItems: 5
> +    description: |
> +      GPIO I2C bus number
> +      1st field - I2C bus number
> +      2nd Field - GPIO SDA
> +      3rd Field - GPIO SCL
> +      4th Field - Timeout
> +      5th Field - udelay

Instead of a bus number and other fields, I think
this should reference an i2c device.

      Arnd

