Return-Path: <linux-pci+bounces-1937-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E47828AE4
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 18:18:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF8931F24FEB
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 17:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F4E3A8F6;
	Tue,  9 Jan 2024 17:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XCcR/f1H"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97A63B195;
	Tue,  9 Jan 2024 17:18:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41427C433F1;
	Tue,  9 Jan 2024 17:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704820693;
	bh=rTSF6jHsJ5Bms5qWgXfRjwBeSbdqBmaf+xJbPhMtxXo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XCcR/f1HpwXjBL3+JzDA3cYTWF4cOKjY4w2ed/u5jR++Bs8BN5zPVONS9Q3+PnPAb
	 pb8PKJO4yb/0nUsPYFDSmdRKvGurUE4/MCJvQiijN9vQFLmbMRXGMvUPl4HAGVQWYA
	 QMBFEAoIMTyJHlknhQ5ZEGIG0QTdPO6ncBWSdQ4XwKZOT1mQAM2uaRusNY9o4FbI8x
	 zdGZxJ0bgaKbALZMhjViShPBo6gwQTkPiNGEvWgjPt3etYDhvJqaij2AjavyN1IHts
	 XuYqWl2YWLiREDZ+ZVW2lbnzZTn9WzxSx6IbGlHfgv0g8oahfXZYkod5O5B9LIQ8rK
	 y6arbFMfhluYA==
Received: (nullmailer pid 2791151 invoked by uid 1000);
	Tue, 09 Jan 2024 17:18:07 -0000
Date: Tue, 9 Jan 2024 11:18:07 -0600
From: Rob Herring <robh@kernel.org>
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux-sh@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Thomas Gleixner <tglx@linutronix.de>, Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Bjorn Helgaas <bhelgaas@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Lee Jones <lee@kernel.org>, Helge Deller <deller@gmx.de>, Heiko Stuebner <heiko@sntech.de
 >, Jernej Skrabec <jernej.skrabec@gmail.com>, Chris Morgan <macromorgan@hotmail.com>, Yang Xiwen <forbidden405@foxmail.com>, Sebastian Reichel <sre@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Randy Dunlap <rdunlap@infradead.org>, Arnd Bergmann <arnd@arndb.de>, Vlastimil Babka <vbabka@suse.cz>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, David Rientjes <rientjes@google.com>, Baoquan He <bhe@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Guenter Roeck <linux@roeck-us.net>, Stephen Rothwell <sfr@canb.auug.org.au>, Azeem Shaikh <azeemshaikh38@gmail.com>, Javier Martinez Canillas <javierm@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>, Palmer Dabbelt <palmer@rivosinc.com>, Bin Meng <bmeng@tinylab.org>, Jonathan Corbet <corbet@lwn.net>, Jacky Huang <ychuang3@nuvoton.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Sam Ravnborg <sam@ravnborg.org>, Sergey Shtylyov <s.shtyl
 yov@omp.ru>, Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org, linux-serial@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: Re: [DO NOT MERGE v6 19/37] dt-bindings: interrupt-controller:
 renesas,sh7751-irl-ext: Add json-schema
Message-ID: <20240109171807.GA2783042-robh@kernel.org>
References: <cover.1704788539.git.ysato@users.sourceforge.jp>
 <a801115c277e65341da079c318a1b970f8d9e671.1704788539.git.ysato@users.sourceforge.jp>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a801115c277e65341da079c318a1b970f8d9e671.1704788539.git.ysato@users.sourceforge.jp>

On Tue, Jan 09, 2024 at 05:23:16PM +0900, Yoshinori Sato wrote:
> Renesas SH7751 external interrupt encoder json-schema.
> 
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> ---
>  .../renesas,sh7751-irl-ext.yaml               | 72 +++++++++++++++++++
>  1 file changed, 72 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/renesas,sh7751-irl-ext.yaml
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/renesas,sh7751-irl-ext.yaml b/Documentation/devicetree/bindings/interrupt-controller/renesas,sh7751-irl-ext.yaml
> new file mode 100644
> index 000000000000..541b582b94ce
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,sh7751-irl-ext.yaml
> @@ -0,0 +1,72 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/interrupt-controller/renesas,sh7751-irl-ext.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Renesas SH7751 external interrupt encoder with enable regs.
> +
> +maintainers:
> +  - Yoshinori Sato <ysato@users.sourceforge.jp>
> +
> +description:
> +  This is the generally used external interrupt encoder on SH7751 based boards.
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: renesas,sh7751-irl-ext
> +
> +  reg: true

Must define how many entries and what they are if more than one.

> +
> +  interrupt-controller: true
> +
> +  '#interrupt-cells':
> +    const: 1
> +
> +  '#address-cells':
> +    const: 0
> +
> +  renesas,set-to-disable:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: Invert enable registers. Setting the bit to 0 enables interrupts.

Why is this a property? Does it change per board or instance? If not, it 
should be implied by compatible.

> +
> +  renesas,enable-bit:
> +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
> +    description: |
> +      IRQ enable register bit mapping
> +      1st word interrupt level
> +      2nd word bit index of enable register

Same question here.

If it remains, then you need:

items:
  items:
    - description: interrupt level (does that mean high/low?)
    - description: bit index of enable register

Plus any constraints on the values if possible.


> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupt-controller
> +  - '#interrupt-cells'
> +  - renesas,enable-bit
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    r2dintc: sh7751irl_encoder@a4000000 {

interrupt-controller@a4000000 {

> +        compatible = "renesas,sh7751-irl-ext";
> +        reg = <0xa4000000 0x02>;
> +        interrupt-controller;
> +        #address-cells = <0>;
> +        #size-cells = <0>;
> +        #interrupt-cells = <1>;
> +        renesas,enable-bit = <0 11>,            /* PCI INTD */
> +                             <1 9>,             /* CF IDE */
> +                             <2 8>,             /* CF CD */
> +                             <3 12>,            /* PCI INTC */
> +                             <4 10>,            /* SM501 */
> +                             <5 6>,             /* KEY */
> +                             <6 5>,             /* RTC ALARM */
> +                             <7 4>,             /* RTC T */
> +                             <8 7>,             /* SDCARD */
> +                             <9 14>,            /* PCI INTA */
> +                             <10 13>,           /* PCI INTB */
> +                             <11 0>,            /* EXT */
> +                             <12 15>;           /* TP */

Looks like 'interrupt level' is just the index of the values? Why not 
make this an array?

Rob

