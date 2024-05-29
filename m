Return-Path: <linux-pci+bounces-8013-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3FB8D34D1
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2024 12:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F80A1C238BD
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2024 10:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6272617F369;
	Wed, 29 May 2024 10:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O9K3lbkl"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2170117DE34;
	Wed, 29 May 2024 10:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716979477; cv=none; b=WMzKELM5gyoB7wnNVxVvzP2/JyD3oCoPMHriiPCwdxR8yj7QV53ilpY7WHR/+gl5FFdMAbw2Kq+OoFPkztzFY9XrfZGLFtp/A9puQuWxTFQVJlIlUcqkCuuoUR3lnD/yn8frt9irWxB5ffnuqXLbZEmnyFMf9MVlR9K7G1IuyXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716979477; c=relaxed/simple;
	bh=s8KdvSWO6HOHAGUGJGDqeLCe+B13uuVSOHh4kq7jejg=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=sOCqmyku1LmOeA6fDcAM58vKG6wkdnBlsRmhftQ5gBRmhDYiMXsiNH4Ne4gqeohS7s/mEOYoX36n2I2y2p7WMkwfFtTH/A0TaJJb8gdcTrbo/imEEfcFe0tV8/axSuDcAF2tHgal36Hr3IxAuoOAnOOJU5fKPZW/JkDmmGZawzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O9K3lbkl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E84BC4AF09;
	Wed, 29 May 2024 10:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716979476;
	bh=s8KdvSWO6HOHAGUGJGDqeLCe+B13uuVSOHh4kq7jejg=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=O9K3lbklkKB2Jie3QsfACPrRW8c9tFLYnkt2tyMY+RcM+3fncWnIGqA95YTsAs6pq
	 0TJ5GwnaVa2sm1Exchz9DLbs1vX7ah6j0w9svRttzVoAy7miEcSpSFwJj+4Eo3NS63
	 SSG7q2XZ8fIizkOYQr1q/gRO85p14BNgBY/F0xQ8MXtejL9Qvb3+2Y6DNz9/d7sQUi
	 C40NMghnMIyZm5CgFiYpZL5BuEs4I2w/hXqSsFwxgttEkIbNTo0QFTIrPXormX7ptW
	 mBOMq4TNRfeYnCXCSNnTOafBydgMPca//J5IUGd3kLly0wh9soHqYlgOkexrkNY+SE
	 lqfzyYAot6hjw==
Date: Wed, 29 May 2024 05:44:35 -0500
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
Cc: Thomas Gleixner <tglx@linutronix.de>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
 Herve Codina <herve.codina@bootlin.com>, linux-clk@vger.kernel.org, 
 Rich Felker <dalias@libc.org>, Jonathan Corbet <corbet@lwn.net>, 
 Arnd Bergmann <arnd@arndb.de>, dri-devel@lists.freedesktop.org, 
 Heiko Stuebner <heiko.stuebner@cherry.de>, 
 Max Filippov <jcmvbkbc@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, linux-ide@vger.kernel.org, 
 Magnus Damm <magnus.damm@gmail.com>, Guenter Roeck <linux@roeck-us.net>, 
 Sergey Shtylyov <s.shtylyov@omp.ru>, linux-kernel@vger.kernel.org, 
 Conor Dooley <conor+dt@kernel.org>, Chris Morgan <macromorgan@hotmail.com>, 
 Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 linux-serial@vger.kernel.org, 
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>, 
 Jiri Slaby <jirislaby@kernel.org>, Daniel Vetter <daniel@ffwll.ch>, 
 Michael Turquette <mturquette@baylibre.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Sebastian Reichel <sre@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
 Jacky Huang <ychuang3@nuvoton.com>, Niklas Cassel <cassel@kernel.org>, 
 linux-fbdev@vger.kernel.org, Azeem Shaikh <azeemshaikh38@gmail.com>, 
 devicetree@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, 
 David Airlie <airlied@gmail.com>, linux-sh@vger.kernel.org, 
 Andrew Morton <akpm@linux-foundation.org>, linux-pci@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
 Helge Deller <deller@gmx.de>, Thomas Zimmermann <tzimmermann@suse.de>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 Stephen Rothwell <sfr@canb.auug.org.au>, 
 Kefeng Wang <wangkefeng.wang@huawei.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Masahiro Yamada <masahiroy@kernel.org>, 
 Javier Martinez Canillas <javierm@redhat.com>, 
 Maxime Ripard <mripard@kernel.org>, Damien Le Moal <dlemoal@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Baoquan He <bhe@redhat.com>, Guo Ren <guoren@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
 Anup Patel <apatel@ventanamicro.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lee Jones <lee@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>
In-Reply-To: <d54cb668f3f19221fdbf34a70a9123fb3a6b4004.1716965617.git.ysato@users.sourceforge.jp>
References: <cover.1716965617.git.ysato@users.sourceforge.jp>
 <d54cb668f3f19221fdbf34a70a9123fb3a6b4004.1716965617.git.ysato@users.sourceforge.jp>
Message-Id: <171697947401.1106915.1101535794733326128.robh@kernel.org>
Subject: Re: [DO NOT MERGE v8 24/36] dt-binding: sh: cpus: Add SH CPUs
 json-schema


On Wed, 29 May 2024 17:01:10 +0900, Yoshinori Sato wrote:
> Renesas SH series and compatible ISA CPUs.
> 
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> ---
>  .../devicetree/bindings/sh/cpus.yaml          | 63 +++++++++++++++++++
>  1 file changed, 63 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sh/cpus.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sh/cpus.example.dtb: cpu@0: 'clock-names', 'dcache-line-size', 'dcache-size', 'icache-line-size', 'icache-size' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/sh/cpus.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/d54cb668f3f19221fdbf34a70a9123fb3a6b4004.1716965617.git.ysato@users.sourceforge.jp

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


