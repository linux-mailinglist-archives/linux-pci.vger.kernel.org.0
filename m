Return-Path: <linux-pci+bounces-490-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84BB38055DC
	for <lists+linux-pci@lfdr.de>; Tue,  5 Dec 2023 14:26:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35E86281AC3
	for <lists+linux-pci@lfdr.de>; Tue,  5 Dec 2023 13:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37D85D8E9;
	Tue,  5 Dec 2023 13:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="bLrkhj0k";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d4gOIy6q"
X-Original-To: linux-pci@vger.kernel.org
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 305031B6;
	Tue,  5 Dec 2023 05:26:35 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 7C1375C02B6;
	Tue,  5 Dec 2023 08:26:34 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 05 Dec 2023 08:26:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1701782794; x=1701869194; bh=W3
	qjdlXCrGJYdFNLku/WKxa0Yd1q1gu7loL3v5KHYRM=; b=bLrkhj0kwVDlhhm0+R
	pQOLQFBz3kV22n0WjqMPaeVJUuBarW8pHH0nK37J/5f8lyTuxsz2iWa8ZqFmKkvC
	bjX8ZUvMEM99/GWgx/ImY4aW2B57xjYC7/4m+Dym3fOqkaAUClDVHUysbFmA4/+f
	g0JG0o8FYgwLMFnPUTyVGmFLBD6DNdJtY1XaHdWWii/IZIvzbjKUGI6OaxpYXP6Z
	yZRpeA+UMpBUnu7aWcUsxpkYmwwSrbJn+s4gTCc6wXq9dlUUPeCkKdlld4bHJXo3
	Ww6yrjXgSQc3NvsAH7/Mg32qSWdf7+l7p0V5xYztDOfDopVj1g7QejZd/AjfsI7U
	vUFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1701782794; x=1701869194; bh=W3qjdlXCrGJYd
	FNLku/WKxa0Yd1q1gu7loL3v5KHYRM=; b=d4gOIy6qFdfd4X8LITm6s20dSvrO3
	aP93Rin/2ZeuMjOa7bvPlovch3EgW5aTuq97NwuYM580SBPIeKLfKfWWLPIY2Zqu
	s8WF+rnjnMldz+/cS//YOStmVRB73mjLgxqySiQLavRbCMjDBJF1dMx9lLYAofmI
	/+ydkW25kJ7+a5+Bsb7TxEieR6l4x2X0sfXzscZycM+TGUhHXExj4kKU2PTy6e52
	UmWDBdh2eXtqipjevJgcwI5ux44TvC2fK8Pc3DCbjd0261VPdxUk/VcNq+0kF9VZ
	pxiKtzUo4Jcz9yyCOlmZkjLQvz0PsF70LMMLU9IT+0En9R60z3S16ajzQ==
X-ME-Sender: <xms:CSVvZR2yRWRM5O1avSn_FLQL1ZguZi5cyvJ3Q30j3VQ9Tj5UY5_qyg>
    <xme:CSVvZYEAZfA6rLSD12L9wcO3DBami0p64gbC8wZ3jCddYdMPUnPuwmnEwFILejz_E
    xQdApVNGNeVSZumTaE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudejkedghedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:CSVvZR51wWVSOf2-nUeOHEczOECInaM4vVT544JLIAMl3sKnxuosGw>
    <xmx:CSVvZe09I2NIDTQR1ESj5jIGD_9NCkdsw6MKwKhW7u15kV7bwBoZng>
    <xmx:CSVvZUEQZLjFoOsXzzyqAPMTxnAtPJl4K2IX_aangTCdPuMBPp13_Q>
    <xmx:CiVvZX9-AQzVLkA6ea-YgRw-YGkkLQnJ6Hy4ABssclTqSGV6IzWEDg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 7D795B6008D; Tue,  5 Dec 2023 08:26:33 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1178-geeaf0069a7-fm-20231114.001-geeaf0069
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <2ef81211-9525-4f96-a6b2-3fcfbed0c6e5@app.fastmail.com>
In-Reply-To: 
 <602e1ba4f02489fcbc47e8f9904f3c1db1c9f14a.1701768028.git.ysato@users.sourceforge.jp>
References: <cover.1701768028.git.ysato@users.sourceforge.jp>
 <602e1ba4f02489fcbc47e8f9904f3c1db1c9f14a.1701768028.git.ysato@users.sourceforge.jp>
Date: Tue, 05 Dec 2023 14:26:13 +0100
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
Subject: Re: [DO NOT MERGE v5 11/37] pci: pci-sh7751: Add SH7751 PCI driver
Content-Type: text/plain

On Tue, Dec 5, 2023, at 10:45, Yoshinori Sato wrote:

> +#include <asm/addrspace.h>
> +#include "pci-sh7751.h"
> +
> +#define pcic_writel(val, base, reg) __raw_writel(val, base + (reg))
> +#define pcic_readl(base, reg) __raw_readl(base + (reg))

__raw_writel()/__raw_readl() has a number of problems with
atomicity (the compiler may split or merge pointer
dereferences), barriers and endianess. You should normally
always use readl()/writel() instead.

> +	memset(pci_config, 0, sizeof(pci_config));
> +	if (of_property_read_u32_array(np, "renesas,config",
> +				       pci_config, SH7751_NUM_CONFIG) == 0) {
> +		for (i = 0; i < SH7751_NUM_CONFIG; i++) {
> +			r = pci_config[i * 2];
> +			/* CONFIG0 is read-only, so make it a sentinel. */
> +			if (r == 0)
> +				break;
> +			pcic_writel(pci_config[i * 2 + 1], pcic, r * 4);
> +		}
> +	}

the config property seems a little too specific to this
implementation of the driver. Instead of encoding register
values in DT, I think these should either be described
in named properties where needed, or hardcoded in the driver
if there is only one sensible value.

> +/*
> + * We need to avoid collisions with `mirrored' VGA ports
> + * and other strange ISA hardware, so we always want the
> + * addresses to be allocated in the 0x000-0x0ff region
> + * modulo 0x400.
> + */
> +#define IO_REGION_BASE 0x1000
> +resource_size_t pcibios_align_resource(void *data, const struct 
> resource *res,
> +				resource_size_t size, resource_size_t align)
> +{

You can't have these generic functions in a driver, as that
prevents you from building more than one such driver.

The logic you have here is neither architecture nor
driver specific.

> +static int sh7751_pci_probe(struct platform_device *pdev)
> +{
> +	struct resource *res, *bscres;
> +	void __iomem *pcic;
> +	void __iomem *bsc;
> +	u32 memory[2];
> +	u16 vid, did;
> +	u32 word;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (IS_ERR(res))
> +		return PTR_ERR(res);
> +	pcic = (void __iomem *)res->start;

This cast is invalid, as res->start is a physical address
that you would need to ioremap() to turn into an __iomem
pointer.

> +	bscres = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +	bsc = devm_ioremap_resource(&pdev->dev, bscres);
> +	if (IS_ERR(bsc))
> +		return PTR_ERR(bsc);
> +
> +	if (of_property_read_u32_array(pdev->dev.of_node,
> +				       "renesas,memory", memory, 2) < 0) {
> +		/*
> +		 * If no memory range is specified,
> +		 *  the entire main memory will be targeted for DMA.
> +		 */
> +		memory[0] = memory_start;
> +		memory[1] = memory_end - memory_start;
> +	}

There is a generic "dma-ranges" proerty for describing
which memory is visible by a bus.

> diff --git a/drivers/pci/controller/pci-sh7751.h 
> b/drivers/pci/controller/pci-sh7751.h
> new file mode 100644
> index 000000000000..540cee7095c6
> --- /dev/null
> +++ b/drivers/pci/controller/pci-sh7751.h
> @@ -0,0 +1,76 @@

If the header is only included from one file, just removed
it and add the register definitions to the driver directly.

     Arnd

