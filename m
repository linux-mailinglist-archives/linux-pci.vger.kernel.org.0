Return-Path: <linux-pci+bounces-8020-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C99448D36DB
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2024 14:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E800A1C22921
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2024 12:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C4156FC6;
	Wed, 29 May 2024 12:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KVTQ3Yk8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EA610A03;
	Wed, 29 May 2024 12:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716987376; cv=none; b=q+8YcJ+cPGttXCf5trwTid44wvv3en2q3uxT1l1tR/iwsaH7assjczmQA+S5nTSF30X/G4lkTL8CEQ+63oOx+/YPVtKGENv9ZDZoNVMmffhplct1mpaNvzzoZ5RhX7IOZvwjbWwFsSX1XkkGHQOOQzK6vVt2hJenYO6euBROuJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716987376; c=relaxed/simple;
	bh=gz8z8N5bHTtjf1WXKP3VLR7zy+2ou75tSdQdUmX2Vx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DUb0B9xOXxoMuH01AVMLxEZlGBXuUrooLiiQuc3cCnPj37fNkeTH+RZ8w3JBtwsyy4aMfLmnvoqbQcEwAVREWF/YUiEcDl+QfZQTute1igQWYb9dfvT504BD/qHemH7O4xpcQ6EjybLqcAuA+FwHIX8kH7tFEZcRmxtOC9Kun5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KVTQ3Yk8; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716987375; x=1748523375;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gz8z8N5bHTtjf1WXKP3VLR7zy+2ou75tSdQdUmX2Vx4=;
  b=KVTQ3Yk8L6lLF0SlKKAnpEMyUVPKkDcnDzC9DQYWKx+Ee0D/j5wS8jWj
   aFE+70oEJD0vC9u1uUJTx/ampL9Tphh3THlJyyPS8Ukn4kn18vvVUsK8c
   4s9mGPkKa1XoMOK/7X+qmVpTAseosXptqqlj7jbPtCoyc8I4jDU5KSXBV
   ZHmZgTGM5Q+ATf42JFns4GxYgQrNbEb9+5wFl2g4Q6y/E4ErrTyoJrPj7
   8E8hN6wW4BQGj/jW3HIXeINSUo4GBUqncw1erGowPuuHp5DyryA0S1unS
   xhT7kAM7DoFzyHUDZK4LhEkHaj0jz1lqSUiNcammTvzyVDIKVtG8yVu1P
   g==;
X-CSE-ConnectionGUID: BSG6Xos3Sp+uL1jtf0ROkw==
X-CSE-MsgGUID: M3losH2pRy2/1+utwYVpyw==
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="13618479"
X-IronPort-AV: E=Sophos;i="6.08,198,1712646000"; 
   d="scan'208";a="13618479"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 05:56:13 -0700
X-CSE-ConnectionGUID: H5QcdFF9TbONM172UGdoGg==
X-CSE-MsgGUID: zqE6bIAkQpSvlFOcfBHkJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,198,1712646000"; 
   d="scan'208";a="35963852"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 05:56:00 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sCIqP-0000000BnVT-2SiK;
	Wed, 29 May 2024 15:55:53 +0300
Date: Wed, 29 May 2024 15:55:53 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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
	Anup Patel <apatel@ventanamicro.com>,
	Jacky Huang <ychuang3@nuvoton.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
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
Subject: Re: [DO NOT MERGE v8 08/36] clocksource: sh_tmu: CLOCKSOURCE support.
Message-ID: <Zlcl2QxRDDrGh7Ru@smile.fi.intel.com>
References: <cover.1716965617.git.ysato@users.sourceforge.jp>
 <f40e91e3f010880b0cf7a1c3a18d0c57bb55d93a.1716965617.git.ysato@users.sourceforge.jp>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f40e91e3f010880b0cf7a1c3a18d0c57bb55d93a.1716965617.git.ysato@users.sourceforge.jp>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, May 29, 2024 at 05:00:54PM +0900, Yoshinori Sato wrote:
> Allows initialization as CLOCKSOURCE.

...

> -	dev_info(&ch->tmu->pdev->dev, "ch%u: used for %s clock events\n",
> -		 ch->index, periodic ? "periodic" : "oneshot");
> +	pr_info("%s ch%u: used for %s clock events\n",
> +		ch->tmu->name, ch->index, periodic ? "periodic" : "oneshot");

This is a step back change. We should use dev_*() if we have a device
available. And I believe this is the case (at least for the previous boards),
no?

...

> -	ch->irq = platform_get_irq(tmu->pdev, index);
> +	if (tmu->np)
> +		ch->irq = of_irq_get(tmu->np, index);
> +	else if (tmu->pdev)
> +		ch->irq = platform_get_irq(tmu->pdev, index);

I found these changes counterproductive. Instead better to have up to three
files to cover:
- the common code (library)
- the platform device support
- the pure OF support.

...

> -	res = platform_get_resource(tmu->pdev, IORESOURCE_MEM, 0);
> -	if (!res) {
> -		dev_err(&tmu->pdev->dev, "failed to get I/O memory\n");
> -		return -ENXIO;
> +	if (tmu->pdev) {
> +		res = platform_get_resource(tmu->pdev, IORESOURCE_MEM, 0);
> +		if (!res) {
> +			pr_err("sh_tmu failed to get I/O memory\n");
> +			return -ENXIO;
> +		}
> +
> +		tmu->mapbase = ioremap(res->start, resource_size(res));

devm_platform_ioremap_resource() should be good to have.
Again, consider proper splitting.

>  	}
> +	if (tmu->np)
> +		tmu->mapbase = of_iomap(tmu->np, 0);

So, how many boards are non-OF compatible? Maybe makes sense to move them to OF
and drop these platform code entirely from everywhere?

...

> +	tmu->name = dev_name(&pdev->dev);
> +	tmu->clk = clk_get(&tmu->pdev->dev, "fck");

devm_ approach can help a lot in case of platform device code.

> +	if (IS_ERR(tmu->clk)) {
> +		dev_err(&tmu->pdev->dev, "cannot get clock\n");
> +		return PTR_ERR(tmu->clk);

		return dev_err_probe() ?

> +	}

-- 
With Best Regards,
Andy Shevchenko



