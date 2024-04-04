Return-Path: <linux-pci+bounces-5715-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94CA18981E3
	for <lists+linux-pci@lfdr.de>; Thu,  4 Apr 2024 09:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B1211F2249B
	for <lists+linux-pci@lfdr.de>; Thu,  4 Apr 2024 07:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 413585787D;
	Thu,  4 Apr 2024 07:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lLJJTmEz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CFE57310;
	Thu,  4 Apr 2024 07:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712214399; cv=none; b=cLnIjaQHXPHm2jCRd1M7hGMgBjh7Bewy5IbSc1hs+fOm6RzAzG541tvDUxZcrqDSETIe1hVmvmA5KOr5ZGG6txHPZWfigBHaCFuRXTTYuB2k1s3KBEUMPpxDu3fJoT4m0cfXgme63xbH6EfXphgDIYE+6m+CMj5/3Sojp6WCAfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712214399; c=relaxed/simple;
	bh=7wDvLbPYyMM9tMvA54Q637lo5w2wg+oz7qp0/dB26zo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HV9nE5mdDNitRCrAxUVth34+JC80OCj5Cxd1lq9i5NyYSnbQSibRjLjqG0xuNlNs2XifqQNGgWo0zvsaq25JK48OKSKP5CKdTU0PZJZhA/k/XtKuuI7xcY92P+Kp0Hu8TQcyxVvD3dYZnevGAURnTMBDs0nhGvKK3ddyYo/Kasw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lLJJTmEz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F4FAC433C7;
	Thu,  4 Apr 2024 07:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712214398;
	bh=7wDvLbPYyMM9tMvA54Q637lo5w2wg+oz7qp0/dB26zo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lLJJTmEzEGNK+wzoDFCki6hGfnJoPH2zXhWFB4ifPniz6i7aIrceshem837xezXxY
	 lv92zQPwhfmpJZPy0FwEBKtC0q4bRq6HtcVXZ0U+7qpUYYWisMw4wzvpxQGpTh70En
	 4aZvJlMSk4qe1YqCL36s0NxWqh+kAgO2clibUaNeet5rQwV1724zrRZTKNegl3ktWz
	 nwuuu1hHp8s2WSI1qD8DXWuWMKRlSA/H9tQRyb0sVsT1jbiQMyI/RcEM08WExiBct2
	 xryw+DHSPpa5YW2ZMMvi+Ej/g8RmKMs6EOJ/Whry1cQIIe1wAT6Y/rVK6qnrX3YNFh
	 aDIOkLWkHtliA==
Date: Thu, 4 Apr 2024 09:06:23 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux-sh@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Lee Jones <lee@kernel.org>, Helge Deller <deller@gmx.de>,
	Heiko Stuebner <heiko.stuebner@cherry.de>,
	Shawn Guo <shawnguo@kernel.org>, Sebastian Reichel <sre@kernel.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>, David Rientjes <rientjes@google.com>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Vlastimil Babka <vbabka@suse.cz>, Baoquan He <bhe@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Guo Ren <guoren@kernel.org>, Azeem Shaikh <azeemshaikh38@gmail.com>,
	Max Filippov <jcmvbkbc@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
	Jacky Huang <ychuang3@nuvoton.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Manikanta Guntupalli <manikanta.guntupalli@amd.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Sam Ravnborg <sam@ravnborg.org>,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	linux-ide@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-pci@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v7 00/37] Device Tree support for SH7751 based board
Message-ID: <Zg5Rb3JecqjivrIy@ryzen>
References: <cover.1712205900.git.ysato@users.sourceforge.jp>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1712205900.git.ysato@users.sourceforge.jp>

On Thu, Apr 04, 2024 at 01:59:25PM +0900, Yoshinori Sato wrote:
> This is an updated version of something I wrote about 7 years ago.
> Minimum support for R2D-plus and LANDISK.
> I think R2D-1 will work if you add AX88796 to dts.
> And board-specific functions and SCI's SPI functions are not supported.
> 
> You can get it working with qemu found here.
> https://gitlab.com/yoshinori.sato/qemu/-/tree/landisk

Why send this as one huge series?

These are the mailing lists that you have on CC:
linux-ide, devicetree, linux-kernel,
linux-renesas-soc, linux-clk, dri-devel,
linux-pci, linux-serial, linux-fbdev

I really think that you will be able to get all these changes accepted much
faster if you split this series in to one series per subsystem/mailing list.


Kind regards,
Niklas

