Return-Path: <linux-pci+bounces-5728-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98324898910
	for <lists+linux-pci@lfdr.de>; Thu,  4 Apr 2024 15:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C65F31C25BC1
	for <lists+linux-pci@lfdr.de>; Thu,  4 Apr 2024 13:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6E6128385;
	Thu,  4 Apr 2024 13:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iN6HA0FF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED27128361;
	Thu,  4 Apr 2024 13:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712238417; cv=none; b=bnytUXYrkLF8TEnKPTVNAULtaewnQ85u/nwo5buacL+b3f5gCr3/RELDfEv7QtVwhEZHXbXRF9kC2qStzOaITs0vUs41/bMBFQ24VIRmwdkmtL4LDlorRcwfJBvwEVwocEfsnDESv5qDe6e1GscQU7vVU47YpYtbrO9QarM4NPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712238417; c=relaxed/simple;
	bh=YTmuV8AU6ijpWFJ9qUSeRqsG7ZkPrskWPB28srSjA4g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=dB6E5vWxVy+SQFKQyRh8NdF9CoDH4CnuxN7ICy5dDluRnOmsB1khMHZoknJyNiLk4sGUGvUXFpd6CGQgKM0cl1qqJrpwiBHOT2fxxEQ5Hx3RTLBBwzXtLTHJIkCGNcNtmw08lKUBZEgEPQHHwjlqB7OtGtDY2lFjaOd2wyfbQDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iN6HA0FF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5D52C433F1;
	Thu,  4 Apr 2024 13:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712238417;
	bh=YTmuV8AU6ijpWFJ9qUSeRqsG7ZkPrskWPB28srSjA4g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=iN6HA0FFgz90MtiQnEAgWRdCm8zcts9f45Sxg2VSsHNeMEL//kXdgXBkuFCxtsMOp
	 X0y2UQ2sBs5OHeOqlgIbYuJM/b/jHyoWp39lX5Edh6zGWMT45nZw7x9YCR/aXpAaYu
	 eMsZjAU9wsTUkb16TrzpthEStk7WoiiiYvpnAMO7mNgtSPSrLUA6a9ZjOh+cHkPDor
	 VLvFgnj76quaNpHeaOIJBKszW0wvwkaa64/OKfiXhxW26b6XWQI2o4aIMrPbyzSfP6
	 XzMA3Be72lk7jigxbkFuwJDK5o6KLLHNbV3pMsrlxi4bNEYo8p6SRThJsQJ1fgG+nd
	 AqfZgrH4ZWYDw==
Date: Thu, 4 Apr 2024 08:46:52 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux-sh@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>, Rob Herring <robh@kernel.org>,
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
Message-ID: <20240404134652.GA1910402@bhelgaas>
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

My comments/questions from
https://lore.kernel.org/r/20231120181600.GA205977@bhelgaas
https://lore.kernel.org/r/20231016172742.GA1215127@bhelgaas
still apply.

