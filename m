Return-Path: <linux-pci+bounces-7639-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96BAF8C9016
	for <lists+linux-pci@lfdr.de>; Sat, 18 May 2024 11:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 284CE282579
	for <lists+linux-pci@lfdr.de>; Sat, 18 May 2024 09:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD7DC125CC;
	Sat, 18 May 2024 09:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="JIXWx0jc"
X-Original-To: linux-pci@vger.kernel.org
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58337C8D1;
	Sat, 18 May 2024 09:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716023334; cv=none; b=Mf3ugzPE8j8UldbYwNSdm/4Eqq9n/tXVOt7ZkbgIbnpUwgZjWVsTP24mT/1UNuI1++6gc2w+dEoD7ykgS5tSaZ/rvYgTZpM+nS8eetV/PddhIGJ6f2KayAatSgFKF+6HJuRYVVENP1NM6qI1vw8nR6REot0fRe1KN0QC09Y3F2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716023334; c=relaxed/simple;
	bh=bVysb/cwrM9Pn6QGUWbl+Ro5RzhkM5yqNN7jrETzyyA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hzi8UEq1HgrIRhFvMWjJJEhZGpAggC1EABncXm70uas0u6kgENz6mvwS+kksvCBfHtDGeWSWGdmPeF5mcYjZP8l8/ULYI241RUD79bMps69JGWhaOVvdNfUFBdCk0dXSN9C08cXePOpsmk1mW01+R36jXKt3gxQBxF7X3082B9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=JIXWx0jc; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=1a0C79DkdyNfWuSIhpXXfpQISUKfKWxaR+an4LJg0Cw=; t=1716023330; x=1716628130; 
	b=JIXWx0jctZvXnqcErr+3sSV5apKLlSgTQjonmBZVS45oZcpMNbwEebER5UZJBEzSMGhZDCP7PJN
	h5jiab7J2xtO7IWJdAdJ1aBJr82y6tZpQ8r7xy+H5ViKn9mzObyFUNO/F9FgWOGFMOhRz2gR0vVr5
	0/zNv4s2F8amm03ZFsrEnj/EfmsVG+ExiraqgiYRrKam9IKGg+UCC0i2EQDexL4Qz77kXbesE6eUx
	itj9aMYp28rMvdB7y5sbfMwyGk4kMm6XSyjPdpG9H8EhFTS66NPvRGkOA2beiqLBDPiFkqLGgBQsI
	L4gAr4tS2+2d1U/BI1N6cAKfkJZU1xRUxXMQ==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.97)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1s8G3N-00000002L83-1Dc1; Sat, 18 May 2024 11:08:33 +0200
Received: from dynamic-077-188-054-221.77.188.pool.telefonica.de ([77.188.54.221] helo=[192.168.178.20])
          by inpost2.zedat.fu-berlin.de (Exim 4.97)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1s8G3M-00000003h1e-3i5d; Sat, 18 May 2024 11:08:33 +0200
Message-ID: <455e40c03314294f9c2e64480aa69f8261a3f2d5.camel@physik.fu-berlin.de>
Subject: Re: [RESEND v7 00/37] Device Tree support for SH7751 based board
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Yoshinori Sato <ysato@users.sourceforge.jp>, linux-sh@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>, Michael Turquette
 <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, David Airlie
 <airlied@gmail.com>,  Daniel Vetter <daniel@ffwll.ch>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Thomas Gleixner
 <tglx@linutronix.de>, Bjorn Helgaas <bhelgaas@google.com>, Lorenzo
 Pieralisi <lpieralisi@kernel.org>, Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?=
 <kw@linux.com>,  Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri
 Slaby <jirislaby@kernel.org>, Magnus Damm <magnus.damm@gmail.com>,  Daniel
 Lezcano <daniel.lezcano@linaro.org>, Rich Felker <dalias@libc.org>, Lee
 Jones <lee@kernel.org>, Helge Deller <deller@gmx.de>, Heiko Stuebner
 <heiko.stuebner@cherry.de>, Shawn Guo <shawnguo@kernel.org>,  Sebastian
 Reichel <sre@kernel.org>, Chris Morgan <macromorgan@hotmail.com>, Linus
 Walleij <linus.walleij@linaro.org>, Arnd Bergmann <arnd@arndb.de>, David
 Rientjes <rientjes@google.com>, Hyeonggon Yoo <42.hyeyoo@gmail.com>,
 Vlastimil Babka <vbabka@suse.cz>, Baoquan He <bhe@redhat.com>, Andrew
 Morton <akpm@linux-foundation.org>, Guenter Roeck <linux@roeck-us.net>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Stephen Rothwell
 <sfr@canb.auug.org.au>,  Javier Martinez Canillas <javierm@redhat.com>, Guo
 Ren <guoren@kernel.org>, Azeem Shaikh <azeemshaikh38@gmail.com>, Max
 Filippov <jcmvbkbc@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Jacky
 Huang <ychuang3@nuvoton.com>, Herve Codina <herve.codina@bootlin.com>,
 Manikanta Guntupalli <manikanta.guntupalli@amd.com>,  Anup Patel
 <apatel@ventanamicro.com>, Biju Das <biju.das.jz@bp.renesas.com>, Uwe
 =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Sam
 Ravnborg <sam@ravnborg.org>, Sergey Shtylyov <s.shtylyov@omp.ru>, Laurent
 Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
 linux-ide@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-pci@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-fbdev@vger.kernel.org
Date: Sat, 18 May 2024 11:08:30 +0200
In-Reply-To: <cover.1712205900.git.ysato@users.sourceforge.jp>
References: <cover.1712205900.git.ysato@users.sourceforge.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Yoshinori,

On Thu, 2024-04-04 at 14:14 +0900, Yoshinori Sato wrote:
> Sorry. previus mail is thread broken.
>=20
> This is an updated version of something I wrote about 7 years ago.
> Minimum support for R2D-plus and LANDISK.
> I think R2D-1 will work if you add AX88796 to dts.
> And board-specific functions and SCI's SPI functions are not supported.
>=20
> You can get it working with qemu found here.
> https://gitlab.com/yoshinori.sato/qemu/-/tree/landisk
>=20
> v7 changes.
> - sh/kernel/setup.c: fix kernel parameter handling.
> - clk-sh7750.c: cleanup.
> - sh_tmu.c: cleanup.
> - irq-renesas-sh7751.c: IPR definition move to code.
> - irq-renesas-sh7751irl.c: update register definition.
> - pci-sh7751.c: Register initialization fix.=20
> - sm501 and sm501fb: Re-design Device Tree properties.

Could you push your v7 version to your Gitlab [1] repository so I can fetch
it from there?

Thanks,
Adrian

> [1] https://gitlab.com/yoshinori.sato/linux

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

