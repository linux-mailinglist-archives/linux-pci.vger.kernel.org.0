Return-Path: <linux-pci+bounces-7669-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 087C18C9F9E
	for <lists+linux-pci@lfdr.de>; Mon, 20 May 2024 17:26:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAEE5282BDF
	for <lists+linux-pci@lfdr.de>; Mon, 20 May 2024 15:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F1A136E30;
	Mon, 20 May 2024 15:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="acRLQ7w4"
X-Original-To: linux-pci@vger.kernel.org
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33513224DD;
	Mon, 20 May 2024 15:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716218757; cv=none; b=KSGWUHJLx6djWdSAmV/+B42PpGZc/cCJK8ILvlFeNxKyICRqF5AiCudHkxriRy8Thy0dAuwaXqQG1iFC+VDRa15h47TKD24YJRv72Q9D/R8yKX81zsy+qbXz7XakjeZXyUjy4uPfr2srDVVGoYI03IxkHi9uuF8dI4bkkpP3bVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716218757; c=relaxed/simple;
	bh=GWZGq4n4rcrkEkGkrcQzBwdF/zPFjvGE48BVg0pt4hM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JbJH/E3cU+wJYkRMhxFBJ0IJRqNu6m+xF2eOeu+EF+aWEMQAEYj8q5zl+wvHqcRUg3MkAGWMUfvZO/cS6sUZWtGBzBpEkhB0L6P4JTPJGuekYlkYgrsxy1JvVqdqDuAbGxY0SCeRyayhr+WdDJZApV7OMBP2ROEQWPZwuoOCt0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=acRLQ7w4; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=jEy13TwY51IDLHTA3smgYhsxn/699IJE/oBHUE2hE0Y=; t=1716218753; x=1716823553; 
	b=acRLQ7w4/F4WlT3sUuVnnAi+PIy1DJQEx81HouctpKcWydPqJTABxzonkDOFeWPcSonKLLrUc9X
	66+ZCmyQAcGR/pp1R8ehOtdLjh4yroDwzJ79TYocRIK3TRfKycsYOH9cxLjpKiW1SFbFmRRra3LqS
	YsNod4VkeRqi/ZyNB7VH1w/ZuLYalu5RVuVWj7qYrXyYaXCRjjgAU7wXUsOLYb8b99+76HFYQn/JL
	3ZnTepQMfUouYPnycPFuHHCElT2CVtxCXC6vwTX99B8Hkh5txsPDvtwFbIfZbnNxh69tmuxYPE7Zs
	c+oPDBqL1ROj7jfswt3DQ1Ty0qtHn9nhxaWg==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.97)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1s94tS-000000012H7-2ORN; Mon, 20 May 2024 17:25:42 +0200
Received: from p57bd9a40.dip0.t-ipconnect.de ([87.189.154.64] helo=[192.168.178.20])
          by inpost2.zedat.fu-berlin.de (Exim 4.97)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1s94tS-00000001zzN-0gCb; Mon, 20 May 2024 17:25:42 +0200
Message-ID: <46c11cf9f837416470c50fa678df0ddb94a0a22e.camel@physik.fu-berlin.de>
Subject: Re: [RESEND v7 00/37] Device Tree support for SH7751 based board
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux-sh@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>, Niklas
 Cassel <cassel@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>,  Geert Uytterhoeven <geert+renesas@glider.be>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>,  David Airlie <airlied@gmail.com>, Daniel Vetter
 <daniel@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,  Thomas Zimmermann
 <tzimmermann@suse.de>, Thomas Gleixner <tglx@linutronix.de>, Bjorn Helgaas
 <bhelgaas@google.com>,  Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, Magnus
 Damm <magnus.damm@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 Rich Felker <dalias@libc.org>, Lee Jones <lee@kernel.org>, Helge Deller
 <deller@gmx.de>, Heiko Stuebner <heiko.stuebner@cherry.de>, Shawn Guo
 <shawnguo@kernel.org>, Sebastian Reichel <sre@kernel.org>, Chris Morgan
 <macromorgan@hotmail.com>, Linus Walleij <linus.walleij@linaro.org>, Arnd
 Bergmann <arnd@arndb.de>, David Rientjes <rientjes@google.com>, Hyeonggon
 Yoo <42.hyeyoo@gmail.com>, Vlastimil Babka <vbabka@suse.cz>, Baoquan He
 <bhe@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Guenter Roeck
 <linux@roeck-us.net>, Kefeng Wang <wangkefeng.wang@huawei.com>, Stephen
 Rothwell <sfr@canb.auug.org.au>,  Javier Martinez Canillas
 <javierm@redhat.com>, Guo Ren <guoren@kernel.org>, Azeem Shaikh
 <azeemshaikh38@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>, Jonathan
 Corbet <corbet@lwn.net>, Jacky Huang <ychuang3@nuvoton.com>, Herve Codina
 <herve.codina@bootlin.com>, Manikanta Guntupalli
 <manikanta.guntupalli@amd.com>,  Anup Patel <apatel@ventanamicro.com>, Biju
 Das <biju.das.jz@bp.renesas.com>, Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=
 <u.kleine-koenig@pengutronix.de>, Sam Ravnborg <sam@ravnborg.org>, Sergey
 Shtylyov <s.shtylyov@omp.ru>, Laurent Pinchart
 <laurent.pinchart+renesas@ideasonboard.com>,  linux-ide@vger.kernel.org,
 devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org,  linux-clk@vger.kernel.org,
 dri-devel@lists.freedesktop.org,  linux-pci@vger.kernel.org,
 linux-serial@vger.kernel.org,  linux-fbdev@vger.kernel.org
Date: Mon, 20 May 2024 17:25:39 +0200
In-Reply-To: <87fruc8wg4.wl-ysato@users.sourceforge.jp>
References: <cover.1712205900.git.ysato@users.sourceforge.jp>
	 <455e40c03314294f9c2e64480aa69f8261a3f2d5.camel@physik.fu-berlin.de>
	 <87fruc8wg4.wl-ysato@users.sourceforge.jp>
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

On Mon, 2024-05-20 at 22:06 +0900, Yoshinori Sato wrote:
> On Sat, 18 May 2024 18:08:30 +0900,
> John Paul Adrian Glaubitz wrote:
> >=20
> > Hi Yoshinori,
> >=20
> > On Thu, 2024-04-04 at 14:14 +0900, Yoshinori Sato wrote:
> > > Sorry. previus mail is thread broken.
> > >=20
> > > This is an updated version of something I wrote about 7 years ago.
> > > Minimum support for R2D-plus and LANDISK.
> > > I think R2D-1 will work if you add AX88796 to dts.
> > > And board-specific functions and SCI's SPI functions are not supporte=
d.
> > >=20
> > > You can get it working with qemu found here.
> > > https://gitlab.com/yoshinori.sato/qemu/-/tree/landisk
> > >=20
> > > v7 changes.
> > > - sh/kernel/setup.c: fix kernel parameter handling.
> > > - clk-sh7750.c: cleanup.
> > > - sh_tmu.c: cleanup.
> > > - irq-renesas-sh7751.c: IPR definition move to code.
> > > - irq-renesas-sh7751irl.c: update register definition.
> > > - pci-sh7751.c: Register initialization fix.=20
> > > - sm501 and sm501fb: Re-design Device Tree properties.
> >=20
> > Could you push your v7 version to your Gitlab [1] repository so I can f=
etch
> > it from there?
>=20
> updated it.

Thanks!

> I'll be posting v8 soon.

Sounds good! Maybe we can start merging the patches that contain fixes only
and that have already been reviewed. This way, we can reduce the overall si=
ze
of the series a bit.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

