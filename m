Return-Path: <linux-pci+bounces-8089-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D248D50C1
	for <lists+linux-pci@lfdr.de>; Thu, 30 May 2024 19:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AABE2815A0
	for <lists+linux-pci@lfdr.de>; Thu, 30 May 2024 17:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F04847781;
	Thu, 30 May 2024 17:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M+fVHIQp"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABED46B83;
	Thu, 30 May 2024 17:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717089307; cv=none; b=O9PuDTxAynvSCMvCASyaYo1I3RecJtwTgVkpc1WmGIn52TdB8+JAU+wIF44SrGb+qE7zc93+E+boOwjL9uzO4/MMUhEIVcO4l4/yjMsMOwj4J5BNjbFTbXxnhmNfVL6VJ//ZuUT4Ifhxtr8sZ/Eu80ucEUqJ12Xk5s0t4Qt1kT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717089307; c=relaxed/simple;
	bh=URqPQnPy5FP44S2DmmqfTAsVuS00f5pQbyJiST5YKkM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=r1JkxNiOKNdJKCu1HHPrc48g0xt8DByT/2s2sk8nE8PMwKSPg/9BShmVGoB9XdtKkeqi2milVLBGy55aYG6PEu+bPSipYu2XBKLMgXmkVWMhatz3kUJoGouJN5rys4EinJkzfQLY3KIoJDjmYo6FmlLeWj5n8dZOPQK2lEbtjjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M+fVHIQp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8289C32782;
	Thu, 30 May 2024 17:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717089306;
	bh=URqPQnPy5FP44S2DmmqfTAsVuS00f5pQbyJiST5YKkM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=M+fVHIQpg0T/3eHcd7tocoywDYwP17uK8cfkJ9zDeNZG04tV2jk609zvJsgA4Hw5k
	 JWHPG8Rl9ABZDwBSelkCaspwJo+IzT70B44yyNeUkgNAcbfkvtnET3NeL2SpjlSA1F
	 hHBHeenJ3skGKNDm2yi5jpgB37DFn2OOSXSyx5TQy8VZIEfoVo195wBfpt5pQKaklJ
	 HWffN+mjUuHC0vpZiAQsmgeW2cNOaLYDhsqv0Gl3kRlhQ75j5lF3kjyN0p+zZ2LykL
	 8JZbuS9JYpvHpH2Ms4zZSpwAOi2BnRmi0dEEztlj2vh8seGJcK1FRaLwKJspFOkLwL
	 5ATVzGSbzf5sA==
Date: Thu, 30 May 2024 12:15:03 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux-sh@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
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
	Neil Armstrong <neil.armstrong@linaro.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Sebastian Reichel <sre@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Masahiro Yamada <masahiroy@kernel.org>, Baoquan He <bhe@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Azeem Shaikh <azeemshaikh38@gmail.com>, Guo Ren <guoren@kernel.org>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Jacky Huang <ychuang3@nuvoton.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Sam Ravnborg <sam@ravnborg.org>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	linux-ide@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-pci@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-fbdev@vger.kernel.org
Subject: Re: [DO NOT MERGE v8 00/36] Device Tree support for SH7751 based
 board
Message-ID: <20240530171503.GA551834@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1716965617.git.ysato@users.sourceforge.jp>

On Wed, May 29, 2024 at 05:00:46PM +0900, Yoshinori Sato wrote:
> This is an updated version of something I wrote about 7 years ago.
> Minimum support for R2D-plus and LANDISK.
> I think R2D-1 will work if you add AX88796 to dts.
> And board-specific functions and SCI's SPI functions are not supported.

I don't understand the point of this.  It's marked "DO NOT MERGE", so
what do you want me to do?  I've posted comments several times and
they've never been addressed, so I don't think there's any point in
looking at this again:

  https://lore.kernel.org/r/20240404134652.GA1910402@bhelgaas

Bjorn

