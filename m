Return-Path: <linux-pci+bounces-8187-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A46028D86AE
	for <lists+linux-pci@lfdr.de>; Mon,  3 Jun 2024 17:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BED5B24272
	for <lists+linux-pci@lfdr.de>; Mon,  3 Jun 2024 15:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ACAD132124;
	Mon,  3 Jun 2024 15:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TW4lU+On"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFC7131736;
	Mon,  3 Jun 2024 15:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717430112; cv=none; b=OGACf7maD/fXtTj/O/9U8i4572FHHRLHqn0GG1a1A2QLIfrpHpoBhNJK8rVxu3RBP+hmRI1UCjqLWgBZToZ/nxlVM89TsjRkdTPPo9AFlTQhhP4I3pAp7Oi/Wtmw8JDUtqm3aIT8jJdiy9CJK/ihFE3xQhCRB4r1U3eiNkL/F6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717430112; c=relaxed/simple;
	bh=ReQXmTcvg08RqCaBOPd0ceRbHCmA79vsnPwpqNQ/OWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dJ998Exgzww4610rs8iJERsllNiZvrxaW+r0ng3PYB18v7gDZcXsT3nc0vRVY/60NISsEiG0mGl2Nom08Xb+Tn1z9vGGPDHBxd0HQtoFBocSdunw0in3p8+YPnKQvdI1r/MHv+NVzg4MVi1qTb6uTVJy8j2u6XbI+qBfwel+Sng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TW4lU+On; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6ACBC2BD10;
	Mon,  3 Jun 2024 15:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717430111;
	bh=ReQXmTcvg08RqCaBOPd0ceRbHCmA79vsnPwpqNQ/OWs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TW4lU+OnMLar1IkIptx6eovxmB4sv5QKfLrew2PGPPZ+6BD0EIZZZmfgPtlTXcJtA
	 UbSb4lL4Kh4+KTQIRL4yL2m+v4o9lEQ5iHqLr68Ko3fxznlnn+qHpDi3MYmyxEhi4Z
	 UFVf3ZGpzDBYi/mI+pDoizSK2aUiFzrF2XrTNLOWkNp2Yc02tBrOe3E7wrHs4joDzs
	 Wsre3VN1F+4IQsCowKmGcRC3ke3K+kQrU2by149l+IwTvXMiNfyPwvM5Y+GExAKKFT
	 xAL+dlm6hLv7BQAjEN/qVtl1hWLWqoc9J7cNH1urPkOPIW/mFGU1ZZyakOjZIlYU31
	 miadAsHe6IvzQ==
Date: Mon, 3 Jun 2024 10:55:08 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Sebastian Reichel <sre@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Rich Felker <dalias@libc.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Javier Martinez Canillas <javierm@redhat.com>,
	linux-renesas-soc@vger.kernel.org,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Maxime Ripard <mripard@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-fbdev@vger.kernel.org,
	Chris Morgan <macromorgan@hotmail.com>,
	Jiri Slaby <jirislaby@kernel.org>, Baoquan He <bhe@redhat.com>,
	Helge Deller <deller@gmx.de>, David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-kernel@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sam Ravnborg <sam@ravnborg.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Guo Ren <guoren@kernel.org>, linux-pci@vger.kernel.org,
	Anup Patel <apatel@ventanamicro.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Jacky Huang <ychuang3@nuvoton.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Azeem Shaikh <azeemshaikh38@gmail.com>,
	Niklas Cassel <cassel@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Max Filippov <jcmvbkbc@gmail.com>, linux-ide@vger.kernel.org,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Stephen Boyd <sboyd@kernel.org>, linux-serial@vger.kernel.org,
	Sergey Shtylyov <s.shtylyov@omp.ru>, devicetree@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Guenter Roeck <linux@roeck-us.net>, linux-sh@vger.kernel.org,
	Heiko Stuebner <heiko.stuebner@cherry.de>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, dri-devel@lists.freedesktop.org,
	Lee Jones <lee@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-clk@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>,
	Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [DO NOT MERGE v8 21/36] dt-bindings: serial: renesas,scif: Add
 scif-sh7751.
Message-ID: <171743010672.507323.12704296584097795619.robh@kernel.org>
References: <cover.1716965617.git.ysato@users.sourceforge.jp>
 <76fffb1383820a701e0c787dcb3a25da52f6e8b7.1716965617.git.ysato@users.sourceforge.jp>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76fffb1383820a701e0c787dcb3a25da52f6e8b7.1716965617.git.ysato@users.sourceforge.jp>


On Wed, 29 May 2024 17:01:07 +0900, Yoshinori Sato wrote:
> Add Renesas SH7751 SCIF.
> 
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  Documentation/devicetree/bindings/serial/renesas,scif.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


