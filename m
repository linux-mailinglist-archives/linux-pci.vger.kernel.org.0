Return-Path: <linux-pci+bounces-2050-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6340F82AD9F
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jan 2024 12:36:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 015B7283CCE
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jan 2024 11:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64B61549E;
	Thu, 11 Jan 2024 11:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IvFJ3gZn"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B48915482;
	Thu, 11 Jan 2024 11:35:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69AFEC433F1;
	Thu, 11 Jan 2024 11:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704972955;
	bh=aBdXrdu7Fc3ywB3LGukHqXOp/HVe7tj8vpqYpP1GRMc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IvFJ3gZnJZmOW4n1hDb23BAssZ0EUOybEz7w/eZDwzNSg5bilSn8XI9BXJJ93D/0d
	 o09I04nLNlA3Cow6eZT+PujIFuptFMcf9eUDNW4/nTJCqwOl7iWyVUTZwo9hs+OXin
	 y2gDzAAfeTSFB0im9juwXFPOpR4dsX9yshWNxTXZwcnDMtps8uQPbeU+EDjq3ElIrY
	 N1XqwjNc02YboOdua/+DnwuYUdKah9CSZ6vhEAsofIaGvd1HDRccJAh4DUTdcHVwZ5
	 0FPsse1MSDcaCS6sx5uUIBSOScPpXiJbtYDqM44o/fGRMiRUn8P9XMVj1QSBKga5eF
	 hhSYZuH+NvKCA==
Date: Thu, 11 Jan 2024 11:35:41 +0000
From: Lee Jones <lee@kernel.org>
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux-sh@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Thomas Gleixner <tglx@linutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Helge Deller <deller@gmx.de>, Heiko Stuebner <heiko@sntech.de>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Chris Morgan <macromorgan@hotmail.com>,
	Yang Xiwen <forbidden405@foxmail.com>,
	Sebastian Reichel <sre@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Randy Dunlap <rdunlap@infradead.org>, Arnd Bergmann <arnd@arndb.de>,
	Vlastimil Babka <vbabka@suse.cz>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	David Rientjes <rientjes@google.com>, Baoquan He <bhe@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Azeem Shaikh <azeemshaikh38@gmail.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Palmer Dabbelt <palmer@rivosinc.com>, Bin Meng <bmeng@tinylab.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Jacky Huang <ychuang3@nuvoton.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Sam Ravnborg <sam@ravnborg.org>,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	linux-ide@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-pci@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-fbdev@vger.kernel.org
Subject: Re: [DO NOT MERGE v6 23/37] mfd: sm501: Convert platform_data to OF
 property
Message-ID: <20240111113541.GH1678981@google.com>
References: <cover.1704788539.git.ysato@users.sourceforge.jp>
 <569f0bfb4fa3fcec8fbd64f67fc4fd2d1cba3f77.1704788539.git.ysato@users.sourceforge.jp>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <569f0bfb4fa3fcec8fbd64f67fc4fd2d1cba3f77.1704788539.git.ysato@users.sourceforge.jp>

On Tue, 09 Jan 2024, Yoshinori Sato wrote:

> Various parameters of SM501 can be set using platform_data,
> so parameters cannot be passed in the DeviceTree target.
> Expands the parameters set in platform_data so that they can be
> specified using DeviceTree properties.
> 
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> ---
>  drivers/mfd/sm501.c           | 436 ++++++++++++++++++++++++++++++++++

How has this grown from 99 lines to 436 lines?

Most of it almost certainly needs moving (back?) out to the leaf
drivers.  A great deal of the properties parsed in here are only
relevant to a single device (display for instance).  Please move all
non-generic handling out to the relevant subsystems.

>  drivers/video/fbdev/sm501fb.c | 106 +++++++++
>  2 files changed, 542 insertions(+)

-- 
Lee Jones [李琼斯]

