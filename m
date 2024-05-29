Return-Path: <linux-pci+bounces-8012-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C098D34CA
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2024 12:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1BF32886E7
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2024 10:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0390217DE07;
	Wed, 29 May 2024 10:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="np0pjepo"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A720117B4FD;
	Wed, 29 May 2024 10:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716979475; cv=none; b=dg/etXkMioJ1G2wvihSQX2DiDk2nSqPrJxJI+VoSZvg8/KvkFig50ODURGgXrzmLvjp/U3ZsmS8Jx7IOd9ZgXZkyQm8rnfSUKomdGi43FAg/PK7+yv8Ae1aoT/UnKaC++sLW1diSQDiPpkDJ7k7X0UaAVC3cPT1IbIPF+41qsE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716979475; c=relaxed/simple;
	bh=w2NUtcqQzhKZrCNj5AHZJLY6Ii4aW3hyDn3AwcSEkNk=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=QpXft65zK9FVAyRXvZsnMSi0BgygIxz2T1KGpbEnAd7qaW0No0ykDDeOA6ic6PCRRXCimwQmY+Ro3vXTke6X5QFNTCiY80edWdYu1NnTbajBynSm64hLeQiwUhyounAfSZCfF9n2Sl86vjjwViN8R9ygvoBEnM7em7wsN3lysnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=np0pjepo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07607C32781;
	Wed, 29 May 2024 10:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716979475;
	bh=w2NUtcqQzhKZrCNj5AHZJLY6Ii4aW3hyDn3AwcSEkNk=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=np0pjepoSGg+tfmnkzQQQpy493Qf1VV2AL6xy/dHgphxXVYYYXe0eAHbGZmRs0wN+
	 R1pG03TKfT13mCgnEfGR0W9D+abVpRhZNwJ/ebD3x6wMuoW4xNDqXVVVOgv04v4Ly8
	 g6Gm7sxj+ao6znk0JoniHcRG9K6XWfNe8N6ri85nFajDUxVb1Y30g9c6M6tJlCPm5n
	 bvLn2Dol8agheHA5c/GhNvm+F7X73Rwh5BXpHONBEWMzM4HZ2Qm8xa0Iz9AfAlOady
	 y/vvIn/OGYic0xYR3CpV/3e0ZCgkKK+oxOoqxGtjD4Q7WsKdTrBkuEhg2TZHzLiR/z
	 OAqoUUfGI46gA==
Date: Wed, 29 May 2024 05:44:34 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>, 
 Anup Patel <apatel@ventanamicro.com>, 
 Linus Walleij <linus.walleij@linaro.org>, Guo Ren <guoren@kernel.org>, 
 Kefeng Wang <wangkefeng.wang@huawei.com>, 
 Maxime Ripard <mripard@kernel.org>, Lee Jones <lee@kernel.org>, 
 Max Filippov <jcmvbkbc@gmail.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Daniel Vetter <daniel@ffwll.ch>, linux-renesas-soc@vger.kernel.org, 
 Herve Codina <herve.codina@bootlin.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, Rich Felker <dalias@libc.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
 linux-clk@vger.kernel.org, Jacky Huang <ychuang3@nuvoton.com>, 
 devicetree@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, 
 Masahiro Yamada <masahiroy@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, Sam Ravnborg <sam@ravnborg.org>, 
 linux-fbdev@vger.kernel.org, Michael Turquette <mturquette@baylibre.com>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 Stephen Boyd <sboyd@kernel.org>, Azeem Shaikh <azeemshaikh38@gmail.com>, 
 Jiri Slaby <jirislaby@kernel.org>, Sebastian Reichel <sre@kernel.org>, 
 Arnd Bergmann <arnd@arndb.de>, 
 Javier Martinez Canillas <javierm@redhat.com>, 
 Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Heiko Stuebner <heiko.stuebner@cherry.de>, linux-serial@vger.kernel.org, 
 Guenter Roeck <linux@roeck-us.net>, linux-ide@vger.kernel.org, 
 Thomas Gleixner <tglx@linutronix.de>, Sergey Shtylyov <s.shtylyov@omp.ru>, 
 Thomas Zimmermann <tzimmermann@suse.de>, linux-sh@vger.kernel.org, 
 Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
 Chris Morgan <macromorgan@hotmail.com>, linux-pci@vger.kernel.org, 
 David Airlie <airlied@gmail.com>, Damien Le Moal <dlemoal@kernel.org>, 
 Niklas Cassel <cassel@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, 
 Baoquan He <bhe@redhat.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Helge Deller <deller@gmx.de>
In-Reply-To: <2fb214e148e74fb0acc202543dca8dd8a170a6e6.1716965617.git.ysato@users.sourceforge.jp>
References: <cover.1716965617.git.ysato@users.sourceforge.jp>
 <2fb214e148e74fb0acc202543dca8dd8a170a6e6.1716965617.git.ysato@users.sourceforge.jp>
Message-Id: <171697947326.1106773.218175911484134371.robh@kernel.org>
Subject: Re: [DO NOT MERGE v8 22/36] dt-bindings: display: smi,sm501: SMI
 SM501 binding json-schema


On Wed, 29 May 2024 17:01:08 +0900, Yoshinori Sato wrote:
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> ---
>  .../bindings/display/smi,sm501.yaml           | 443 ++++++++++++++++++
>  1 file changed, 443 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/smi,sm501.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/smi,sm501.yaml: crt: Missing additionalProperties/unevaluatedProperties constraint
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/smi,sm501.yaml: panel: Missing additionalProperties/unevaluatedProperties constraint

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/2fb214e148e74fb0acc202543dca8dd8a170a6e6.1716965617.git.ysato@users.sourceforge.jp

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


