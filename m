Return-Path: <linux-pci+bounces-7657-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A668C9DE4
	for <lists+linux-pci@lfdr.de>; Mon, 20 May 2024 15:11:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3CEC283E28
	for <lists+linux-pci@lfdr.de>; Mon, 20 May 2024 13:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44BA6135A6F;
	Mon, 20 May 2024 13:11:29 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp [153.127.30.23])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32032A2D;
	Mon, 20 May 2024 13:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=153.127.30.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716210689; cv=none; b=Hr8SipDM7Vh7HJDDEMqorTDIO2Y48HgvT6hxCGV66pyb4cFGGRD8funkpcfKUGBfElo473lwC2bS6UtQ20EwE6YaJ4AUc/CdIbFiTF3XTtj5JQQ2K82UT1sycA9UJrcTJei0kfLD4DKB9tsu95LOfEVPdge6tqIEfVMYqtxhBhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716210689; c=relaxed/simple;
	bh=a9Beq8MfnmXvgVrRFuX5+jQqyI2S3FJbw4QgKto9ElA=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RYGxZmAiWdbSCI1SrWJsI89ERH3yfNPPyBQZ4VU06WKRPFgykhURjPiX+BTveRCb/42h42NPG5FNocAGSqDJMo3VHp9G6DtHZVmZJMQaBdwvj4AJo5ecv6DToGTYtJ87xde6M2z1XQAgdcxE9J+Ovr8pkFRw6DLBlrsBNFK/FSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=users.sourceforge.jp; spf=fail smtp.mailfrom=users.sourceforge.jp; arc=none smtp.client-ip=153.127.30.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=users.sourceforge.jp
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=users.sourceforge.jp
Received: from SIOS1075.ysato.ml (ZM005235.ppp.dion.ne.jp [222.8.5.235])
	by sakura.ysato.name (Postfix) with ESMTPSA id 770791C00F9;
	Mon, 20 May 2024 22:06:04 +0900 (JST)
Date: Mon, 20 May 2024 22:06:03 +0900
Message-ID: <87fruc8wg4.wl-ysato@users.sourceforge.jp>
From: Yoshinori Sato <ysato@users.sourceforge.jp>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linux-sh@vger.kernel.org,	Damien Le Moal <dlemoal@kernel.org>,	Niklas
 Cassel <cassel@kernel.org>,	Rob Herring <robh@kernel.org>,	Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,	Conor Dooley
 <conor+dt@kernel.org>,	Geert Uytterhoeven <geert+renesas@glider.be>,
	Michael Turquette <mturquette@baylibre.com>,	Stephen Boyd
 <sboyd@kernel.org>,	David Airlie <airlied@gmail.com>,	Daniel Vetter
 <daniel@ffwll.ch>,	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,	Thomas Zimmermann
 <tzimmermann@suse.de>,	Thomas Gleixner <tglx@linutronix.de>,	Bjorn Helgaas
 <bhelgaas@google.com>,	Lorenzo Pieralisi <lpieralisi@kernel.org>,	Krzysztof
 =?ISO-8859-2?Q?Wilczy=F1ski?= <kw@linux.com>,	Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,	Jiri Slaby <jirislaby@kernel.org>,	Magnus
 Damm <magnus.damm@gmail.com>,	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Rich Felker <dalias@libc.org>,	Lee Jones <lee@kernel.org>,	Helge Deller
 <deller@gmx.de>,	Heiko Stuebner <heiko.stuebner@cherry.de>,	Shawn Guo
 <shawnguo@kernel.org>,	Sebastian Reichel <sre@kernel.org>,	Chris Morgan
 <macromorgan@hotmail.com>,	Linus Walleij <linus.walleij@linaro.org>,	Arnd
 Bergmann <arnd@arndb.de>,	David Rientjes <rientjes@google.com>,	Hyeonggon
 Yoo <42.hyeyoo@gmail.com>,	Vlastimil Babka <vbabka@suse.cz>,	Baoquan He
 <bhe@redhat.com>,	Andrew Morton <akpm@linux-foundation.org>,	Guenter Roeck
 <linux@roeck-us.net>,	Kefeng Wang <wangkefeng.wang@huawei.com>,	Stephen
 Rothwell <sfr@canb.auug.org.au>,	Javier Martinez Canillas
 <javierm@redhat.com>,	Guo Ren <guoren@kernel.org>,	Azeem Shaikh
 <azeemshaikh38@gmail.com>,	Max Filippov <jcmvbkbc@gmail.com>,	Jonathan
 Corbet <corbet@lwn.net>,	Jacky Huang <ychuang3@nuvoton.com>,	Herve Codina
 <herve.codina@bootlin.com>,	Manikanta Guntupalli
 <manikanta.guntupalli@amd.com>,	Anup Patel <apatel@ventanamicro.com>,	Biju
 Das <biju.das.jz@bp.renesas.com>,	Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=
 <u.kleine-koenig@pengutronix.de>,	Sam Ravnborg <sam@ravnborg.org>,	Sergey
 Shtylyov <s.shtylyov@omp.ru>,	Laurent Pinchart
 <laurent.pinchart+renesas@ideasonboard.com>,	linux-ide@vger.kernel.org,
	devicetree@vger.kernel.org,	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,	linux-clk@vger.kernel.org,
	dri-devel@lists.freedesktop.org,	linux-pci@vger.kernel.org,
	linux-serial@vger.kernel.org,	linux-fbdev@vger.kernel.org
Subject: Re: [RESEND v7 00/37] Device Tree support for SH7751 based board
In-Reply-To: <455e40c03314294f9c2e64480aa69f8261a3f2d5.camel@physik.fu-berlin.de>
References: <cover.1712205900.git.ysato@users.sourceforge.jp>
	<455e40c03314294f9c2e64480aa69f8261a3f2d5.camel@physik.fu-berlin.de>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?ISO-8859-4?Q?Goj=F2?=) APEL-LB/10.8 EasyPG/1.0.0
 Emacs/28.2 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII

On Sat, 18 May 2024 18:08:30 +0900,
John Paul Adrian Glaubitz wrote:
> 
> Hi Yoshinori,
> 
> On Thu, 2024-04-04 at 14:14 +0900, Yoshinori Sato wrote:
> > Sorry. previus mail is thread broken.
> > 
> > This is an updated version of something I wrote about 7 years ago.
> > Minimum support for R2D-plus and LANDISK.
> > I think R2D-1 will work if you add AX88796 to dts.
> > And board-specific functions and SCI's SPI functions are not supported.
> > 
> > You can get it working with qemu found here.
> > https://gitlab.com/yoshinori.sato/qemu/-/tree/landisk
> > 
> > v7 changes.
> > - sh/kernel/setup.c: fix kernel parameter handling.
> > - clk-sh7750.c: cleanup.
> > - sh_tmu.c: cleanup.
> > - irq-renesas-sh7751.c: IPR definition move to code.
> > - irq-renesas-sh7751irl.c: update register definition.
> > - pci-sh7751.c: Register initialization fix. 
> > - sm501 and sm501fb: Re-design Device Tree properties.
> 
> Could you push your v7 version to your Gitlab [1] repository so I can fetch
> it from there?

updated it.
I'll be posting v8 soon.

> Thanks,
> Adrian
> 
> > [1] https://gitlab.com/yoshinori.sato/linux
> 
> -- 
>  .''`.  John Paul Adrian Glaubitz
> : :' :  Debian Developer
> `. `'   Physicist
>   `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
> 

-- 
Yosinori Sato

