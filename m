Return-Path: <linux-pci+bounces-492-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F01805625
	for <lists+linux-pci@lfdr.de>; Tue,  5 Dec 2023 14:36:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DFE61F2154A
	for <lists+linux-pci@lfdr.de>; Tue,  5 Dec 2023 13:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539E25D90E;
	Tue,  5 Dec 2023 13:36:38 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27DE0A8;
	Tue,  5 Dec 2023 05:36:35 -0800 (PST)
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6d9ac148ca3so905528a34.0;
        Tue, 05 Dec 2023 05:36:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701783394; x=1702388194;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ATJhxmNw/sqJ3amYElSUOa0ZiBdGk96C405IzrIF1IA=;
        b=gTTY+OMAJcVP5viX+mEpCvleqctyd//MYzRAIep7B1aZdykwbm8g8N4602soShQiL2
         NvePkFSFfhVxwaadqnC2H5oYHaf9CcyoJNcaCyuyJ8Vruapus2yDA1+nKIk5Vt+X4T9X
         Wxwyb/Ue7sax3gqyOxkuYcKr64KZJb7mx8Cpj7DjcH8Pwfkk3SuxjtsVbkd/EW2RkdSa
         +y9GDlw0hT/h74MGdaFJHw1dNl2H+N9ZXL8FnyOECLoNOoGvtPLHZhxdyBxHD7yqmLJ9
         G0JBBR1xUZZ/td3kOsk2+A/CdJESg31fNYvFjOPOMPMpYPyHBahoUdgMOQl5qYg3jt72
         a32A==
X-Gm-Message-State: AOJu0YwAnPBJLeC9zrwtnd8qLtmQG5sp6m/l4bPSbJ27uAJZZjiKim+c
	XTU2QyV+m0uwbKr7LX9+lQ==
X-Google-Smtp-Source: AGHT+IHpax4H+EuTffsdMbFAaxu0ifdWtpe/c2kmwKYnFq10+iJjBG535HfA/1jEH708VOJPGAni2g==
X-Received: by 2002:a05:6871:149:b0:1fb:75a:7799 with SMTP id z9-20020a056871014900b001fb075a7799mr5314173oab.74.1701783393692;
        Tue, 05 Dec 2023 05:36:33 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id qa18-20020a056871e71200b001fb30b8bb40sm1648439oac.41.2023.12.05.05.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 05:36:33 -0800 (PST)
Received: (nullmailer pid 2871587 invoked by uid 1000);
	Tue, 05 Dec 2023 13:36:30 -0000
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
Cc: Michael Turquette <mturquette@baylibre.com>, Jiri Slaby <jirislaby@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <bhe@redhat.com>, linux-renesas-soc@vger.kernel.org, 
	Stephen Rothwell <sfr@canb.auug.org.au>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Arnd Bergmann <arnd@arndb.de>, 
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, dri-devel@lists.freedesktop.org, 
	Jacky Huang <ychuang3@nuvoton.com>, Stephen Boyd <sboyd@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, linux-sh@vger.kernel.org, 
	Max Filippov <jcmvbkbc@gmail.com>, Conor Dooley <conor+dt@kernel.org>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Magnus Damm <magnus.damm@gmail.com>, Tom Rix <trix@redhat.com>, 
	Maxime Ripard <mripard@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	Herve Codina <herve.codina@bootlin.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	David Airlie <airlied@gmail.com>, Randy Dunlap <rdunlap@infradead.org>, 
	Rob Herring <robh+dt@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Guo Ren <guoren@kernel.org>, devicetree@vger.kernel.org, 
	David Rientjes <rientjes@google.com>, Chris Morgan <macromorgan@hotmail.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Helge Deller <deller@gmx.de>, Javier Martinez Canillas <javierm@redhat.com>, 
	Lukas Bulwahn <lukas.bulwahn@gmail.com>, Sergey Shtylyov <s.shtylyov@omp.ru>, linux-clk@vger.kernel.org, 
	Rich Felker <dalias@libc.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Lee Jones <lee@kernel.org>, Sam Ravnborg <sam@ravnborg.org>, Daniel Vetter <daniel@ffwll.ch>, 
	Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Vlastimil Babka <vbabka@suse.cz>, Palmer Dabbelt <palmer@rivosinc.com>, 
	Biju Das <biju.das.jz@bp.renesas.com>, Azeem Shaikh <azeemshaikh38@gmail.com>, 
	linux-serial@vger.kernel.org, linux-fbdev@vger.kernel.org, 
	Guenter Roeck <linux@roeck-us.net>, Bin Meng <bmeng@tinylab.org>, 
	Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org
In-Reply-To: <f671beae8a8ebfd361f4c903bccce713135a169f.1701768028.git.ysato@users.sourceforge.jp>
References: <cover.1701768028.git.ysato@users.sourceforge.jp>
 <f671beae8a8ebfd361f4c903bccce713135a169f.1701768028.git.ysato@users.sourceforge.jp>
Message-Id: <170178306217.2865593.13906216780533956456.robh@kernel.org>
Subject: Re: [DO NOT MERGE v5 22/37] dt-bindings: display: smi,sm501: SMI
 SM501 binding json-schema
Date: Tue, 05 Dec 2023 07:36:30 -0600


On Tue, 05 Dec 2023 18:45:41 +0900, Yoshinori Sato wrote:
> Define SM501 functions and modes.
> 
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> ---
>  .../bindings/display/smi,sm501.yaml           | 134 ++++++++++++++++++
>  include/dt-bindings/display/sm501.h           |  25 ++++
>  2 files changed, 159 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/smi,sm501.yaml
>  create mode 100644 include/dt-bindings/display/sm501.h
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/smi,sm501.yaml: interrupt-name: missing type definition
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/smi,sm501.yaml: edid: missing type definition
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/smi,sm501.yaml: crt: missing type definition

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/f671beae8a8ebfd361f4c903bccce713135a169f.1701768028.git.ysato@users.sourceforge.jp

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


