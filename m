Return-Path: <linux-pci+bounces-487-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AB3780555B
	for <lists+linux-pci@lfdr.de>; Tue,  5 Dec 2023 14:02:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A977B1F214CA
	for <lists+linux-pci@lfdr.de>; Tue,  5 Dec 2023 13:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5827D5C8E8;
	Tue,  5 Dec 2023 13:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="cvgOgYA7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yacRC4BU"
X-Original-To: linux-pci@vger.kernel.org
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 677D385;
	Tue,  5 Dec 2023 05:01:56 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 2E2795C02C6;
	Tue,  5 Dec 2023 08:01:53 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 05 Dec 2023 08:01:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1701781313; x=1701867713; bh=Vz
	5fHcnpm58kiwXE8hZp/Ye9ElTOS3WdqAMkMGNeaRk=; b=cvgOgYA7MGSeQTnroK
	55TwaexI6T0Ar7/K3PpDbIQ/J0PV5KguP1FtgugKmTAtVlWgSKaeDt70Qbpm6NA2
	fjtBpR9W4wctFEprPmxR0FZxklq02d1JmOTx58/pVUsu+haKEvj1rkrhLWZ8Lhse
	as4s2nBA47xUgpqBf/Lw+bZ4Mh0Gs5QMo+yq7uoF3GkXPuhTTKKW+QqQED268YnK
	kF4sLhZ0HzT+UiaqkpDkgi0Ko21Sm5UzxkxHz1IsAoYoCk8/Mf3MtZNerezo5kbM
	u1e6g1fDnlJSsccZwhH3xpohgzt0KVwiT8jUdF58GIvmOpp0X7geJSAhUTfPKxyB
	TQPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1701781313; x=1701867713; bh=Vz5fHcnpm58ki
	wXE8hZp/Ye9ElTOS3WdqAMkMGNeaRk=; b=yacRC4BUn+jelBSr1r50xeLrSUMCB
	P6gWdxS8PNmXvS2lwcnI9DrOi1wvxBhoMf/rcRbUuFB9uSFgQlC8vNL90sum4vES
	5q1gG8eL1N3/1BmRTf4XZb/EQmj5fWHyvMdVvY/ZiHzXWIcpC2xpump8q1MVBWNv
	gRarAcCi277E4wzsJ91n7IkgGZgzHpjqG6XkHKiQC5zMujdFUyrNlzsRKqnr1vkP
	S3Y5IDoMX/vCYkl1ca9CMMKzPLtTt6E5P6Cxhe1WfvVhQcyzYfESDXxG/suwT7WS
	WQrFbEVBupeGfe/ARqv0OnG9byGFqiTYywlG1j0UNEzxpD48p52h5rCsw==
X-ME-Sender: <xms:Px9vZe8BGJJcjAaWpIBNmHZHQUAg5lk32PhyHWI1PPVAghG_Bel7Vg>
    <xme:Px9vZeuoPxhZ3ok-vivHK_BSKpjPpWEB3H3KnipZsv-A-LA4xvbJHzK71WgZbELkv
    LfrV8sKhSIKdBdSyU4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudejkedggeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:Px9vZUBm4v5Q7KA2WQXF-XiajbjsnXVqTq21-2-MlaAkifDTqyf91w>
    <xmx:Px9vZWd1JvaRpUqFk01U31zGT8hK5cwc_w-5CO1Xs2BI5_uYCZXc4w>
    <xmx:Px9vZTNLEiUB2a9YJPLTUaVVi1yA8GFJ9bz4xkqAkoe-d2tMhCPxaw>
    <xmx:QR9vZQla8R70Vm7nNVfKk--auJl8wCkKe6hUzvCK5V4k3_Sw8810jQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 7D516B60089; Tue,  5 Dec 2023 08:01:51 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1178-geeaf0069a7-fm-20231114.001-geeaf0069
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d76fc75e-15c8-4177-a150-6f906233b82e@app.fastmail.com>
In-Reply-To: 
 <d6c242c0ab6e25e775284ec1d4b29a1ddd888af0.1701768028.git.ysato@users.sourceforge.jp>
References: <cover.1701768028.git.ysato@users.sourceforge.jp>
 <d6c242c0ab6e25e775284ec1d4b29a1ddd888af0.1701768028.git.ysato@users.sourceforge.jp>
Date: Tue, 05 Dec 2023 14:01:31 +0100
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
Subject: Re: [DO NOT MERGE v5 35/37] sh: RTS7751R2D Plus OF defconfig
Content-Type: text/plain

On Tue, Dec 5, 2023, at 10:45, Yoshinori Sato wrote:
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> ---
>  arch/sh/configs/rts7751r2dplus-of_defconfig | 93 +++++++++++++++++++++

This is very similar to the landisk config, so it may be
easier to just have one of them that works for both, as well
as future ones.

> +CONFIG_LOG_BUF_SHIFT=14
> +CONFIG_NAMESPACES=y
> +CONFIG_EXPERT=y

You should not normally need to enable CONFIG_EXPERT in a
defconfig. Is there any particular reason for this?

    Arnd

