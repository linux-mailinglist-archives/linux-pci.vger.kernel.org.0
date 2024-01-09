Return-Path: <linux-pci+bounces-1934-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C888289FC
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 17:29:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56732287A7F
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 16:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845963A1D3;
	Tue,  9 Jan 2024 16:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tO+b64eZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4322B3A1C2;
	Tue,  9 Jan 2024 16:29:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C550C433F1;
	Tue,  9 Jan 2024 16:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704817760;
	bh=QgGwzoys5P2Z/fVPtiI4dBsiCdvR2utj2/6oG20yU8I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=tO+b64eZxpE1divDNhiYoF0w5a3carVLU5isQEfJzuMYC7Ujt9cl6FuZJzvfO9gr1
	 Ek0j32D8E/N9c2ZpF+PncLfrZNjSd2FQgZM+2kYC1xQ0R+Xw89F0O8GkPasA+zPqnY
	 TcYSEBqUo3329T9TvIcblHnRX7YTBlcAzLppVXfT+gjgWnlfrh3lHQivbfFi5DVqOs
	 NCuJm5Oov75+0QrXdipVIqhgi8A78rfcgtBFmqiKhzLN2tiQbha10SmTHO2tg+2hlK
	 KJIWok0gjAPrbvRkttADcxAFt9q9KFQiLJklVJrdqh95LQs5enmxfTrdEwYXxWbA4Y
	 gcZfH0x+RS8yg==
Received: (nullmailer pid 2713715 invoked by uid 1000);
	Tue, 09 Jan 2024 16:29:14 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Randy Dunlap <rdunlap@infradead.org>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	Jiri Slaby <jirislaby@kernel.org>, dri-devel@lists.freedesktop.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Sam Ravnborg <sam@ravnborg.org>,
	Azeem Shaikh <azeemshaikh38@gmail.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Daniel Vetter <daniel@ffwll.ch>, linux-ide@vger.kernel.org,
	Helge Deller <deller@gmx.de>,
	Michael Turquette <mturquette@baylibre.com>,
	Yang Xiwen <forbidden405@foxmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Rientjes <rientjes@google.com>, Bin Meng <bmeng@tinylab.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Krzysztof Kozlowski <"krzyszto f.kozlowski+dt"@linaro.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Chris Morgan <macromorgan@hotmail.com>,
	linux-renesas-soc@vger.kernel.org, Rich Felker <dalias@libc.org>,
	Stephen Boyd <sboyd@kernel.org>, linux-pci@vger.kernel.org,
	Sebastian Reichel <sre@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
	Magnus Damm <magnus.damm@gmail.com>,
	=?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Stephen Rothwell <sfr@canb.auug.org.au>, devicetree@vger.kernel.org,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Rob Herring <robh+dt@kernel.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	David Airlie <airlied@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Jacky Huang <ychuang3@nuvoton.com>, Lee Jones <lee@kernel.org>,
	Baoquan He <bhe@redhat.com>, Guenter Roeck <linux@roeck-us.net>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>, linux-clk@vger.kernel.org,
	linux-serial@vger.kernel.org,
	=?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-fbdev@vger.kernel.org
In-Reply-To: <a801115c277e65341da079c318a1b970f8d9e671.1704788539.git.ysato@users.sourceforge.jp>
References: <cover.1704788539.git.ysato@users.sourceforge.jp>
 <a801115c277e65341da079c318a1b970f8d9e671.1704788539.git.ysato@users.sourceforge.jp>
Message-Id: <170481775440.2713680.11814908609719501949.robh@kernel.org>
Subject: Re: [DO NOT MERGE v6 19/37] dt-bindings: interrupt-controller:
 renesas,sh7751-irl-ext: Add json-schema
Date: Tue, 09 Jan 2024 09:29:14 -0700


On Tue, 09 Jan 2024 17:23:16 +0900, Yoshinori Sato wrote:
> Renesas SH7751 external interrupt encoder json-schema.
> 
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> ---
>  .../renesas,sh7751-irl-ext.yaml               | 72 +++++++++++++++++++
>  1 file changed, 72 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/renesas,sh7751-irl-ext.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interrupt-controller/renesas,sh7751-irl-ext.example.dtb: sh7751irl_encoder@a4000000: '#size-cells' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/interrupt-controller/renesas,sh7751-irl-ext.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/a801115c277e65341da079c318a1b970f8d9e671.1704788539.git.ysato@users.sourceforge.jp

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


