Return-Path: <linux-pci+bounces-488-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5FD80556A
	for <lists+linux-pci@lfdr.de>; Tue,  5 Dec 2023 14:05:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCF981C20E21
	for <lists+linux-pci@lfdr.de>; Tue,  5 Dec 2023 13:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8315C8E4;
	Tue,  5 Dec 2023 13:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="0qIVkSg7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZM3RnFwl"
X-Original-To: linux-pci@vger.kernel.org
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14B84134;
	Tue,  5 Dec 2023 05:05:34 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 7C7245C01AF;
	Tue,  5 Dec 2023 08:05:33 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 05 Dec 2023 08:05:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1701781533; x=1701867933; bh=zv
	8E1tGkz8JRoBtprl3IIFJf3pqYhFYTFABmpiAXWAw=; b=0qIVkSg7ams/DQOYLa
	AnflRwv69frRRiDu8eF8KOOGrPD+ifn/wUrUqkDFSVze3mG2Bbo49iJXohb3RUIA
	rdB6N0YhfvfHzRmIlPw22yVtn1fyVhyDdu76q/bE+I3IDUXNBfeVfy1/HbpK8Dbd
	Iexh4+qFXwGpzu+MyKbhH1imzlSeYtKWXSQahQsRvuk3vEnynrXUm8FNu/IXeKFW
	a63pD4Z9HAFXyd9H8mJJIfxI7NRXB8i7oByhkiAozdUzrnhb3ONmfSUgBLxT++TU
	3bJV7mbTJ5rokIeB1guSHRgI8CXqu7+mGxDyFKNn888aA1MMDa6Kl00PKOBvfFjJ
	6QwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1701781533; x=1701867933; bh=zv8E1tGkz8JRo
	Btprl3IIFJf3pqYhFYTFABmpiAXWAw=; b=ZM3RnFwl9Of1m5cnmg+84caA6KjaD
	k7zpbwa/FXBoK5ZMmtNvv1DDKveEPXNQ2HUUoZ1WENXWwz3l6/fQtQRjhM8Xgt+u
	LXdCgo8wChxxa8voY3EZL8xgHa1H71+8OoVenr7bVpYW8e8SZsSos/8d4TOscRby
	IC7ghZPQaZ3BvNnOnYg0CLKZGhvooqOmhI2FdcSdO+mM1pk2SeGYc4OvjrhZ2zzq
	nXWEOVgQ7km9nYqzXTW9mOZ4/4BNg67kCKmCKoPaaTV1VK5WdZFw2EZsOYKlA6Hb
	ECVlyj4QbHY/h0Q7XtpGpI3cPGz8iedwm50JaRVPodkc6ZSfypOuKHn/A==
X-ME-Sender: <xms:HCBvZVQbdizuX9-8HF5u8pNBZwfoc9EH-gX7LJsdklqXNlB9Vk48aA>
    <xme:HCBvZew2PVyuJbKSveX_A_kVqycjcbc8rETpJxtcZMGfGHuDIaRI4n_emMcP9YKrj
    UmHm8Y37mpe96Sr6Qk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudejkedggeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:HCBvZa3CWIYZ9HuzcgVb5CdAxvCR7qzBjv_DigmXDF9ccLq2mju6LQ>
    <xmx:HCBvZdC9EbW8E8n1fLSB7-BIP9koo7d17b7QCACEivbM8BhWVCplnA>
    <xmx:HCBvZeh1GqErcX8p7dzIhBJoQU54VuEpHb8s3aXwJd24K01_s65DYA>
    <xmx:HSBvZVqNJ_yyscXm_ayvFk-5aLOMVuHa1wF13FoskAbO5-x3naFgbQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id B88B2B60089; Tue,  5 Dec 2023 08:05:32 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1178-geeaf0069a7-fm-20231114.001-geeaf0069
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <3acae2ba-e91a-46d2-8748-b2cb1b369063@app.fastmail.com>
In-Reply-To: 
 <ec01fdf9a91d9d1da9da08be83d5821353ac5a9d.1701768028.git.ysato@users.sourceforge.jp>
References: <cover.1701768028.git.ysato@users.sourceforge.jp>
 <ec01fdf9a91d9d1da9da08be83d5821353ac5a9d.1701768028.git.ysato@users.sourceforge.jp>
Date: Tue, 05 Dec 2023 14:05:11 +0100
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
Subject: Re: [DO NOT MERGE v5 10/37] sh: Common PCI Framework driver support.
Content-Type: text/plain

On Tue, Dec 5, 2023, at 10:45, Yoshinori Sato wrote:
> +
> +#if defined(CONFIG_PCI) && !defined(CONFIG_GENERIC_IOMAP)
> +void pci_iounmap(struct pci_dev *dev, void __iomem *addr)
> +{
> +	iounmap(addr);
> +}
> +EXPORT_SYMBOL(pci_iounmap);

This definition does not work for addresses that are
returned by ioport_map(), include pci_iomap() on
IORESOURCE_IO.  However, the definition in lib/pci_iomap.c
should work fine, you just need to #define ARCH_WANTS_GENERIC_PCI_IOUNMAP
to get that.

      Arnd

