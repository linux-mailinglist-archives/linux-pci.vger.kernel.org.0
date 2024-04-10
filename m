Return-Path: <linux-pci+bounces-6043-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A1B89FCA9
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 18:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3487F1C218E9
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 16:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2300617994B;
	Wed, 10 Apr 2024 16:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N0NE2a+/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCD3179661;
	Wed, 10 Apr 2024 16:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712765666; cv=none; b=toSQmRGGbkg10eVGT8qArQzkoxU9x9jmtzQKLhLye5g3aFsf6dE+ZglLtUlVYXn7buOugRopGvtIi1pxGKvyztWzNJcxblEBDdTdqRgQPf0KRYHbAz8nCpivDzOy94amD9EOhhvQprR6QNA/Aw2tWX775KjYqnM+CPuCD9peB0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712765666; c=relaxed/simple;
	bh=eHcJpndqtwzVN4cnsL6DiGE1t1qVRN1vvary0pO1BDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ozFjXKWqdwyFUdMlrfm0zRcMN9b8gFcOWpo/wkKmf/iZPxeRy/Nj7NjsU4SHNNLPm/e45EnKFbE1sbLTmhzjrsW8DALbqexK4CjUbAByOXNEmhavB2fSGZgnaBfc/KxrrAVBh9IsVxwnB9T8ASOGqOnl+86YZqLL3adNxYdCwQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N0NE2a+/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B322C43390;
	Wed, 10 Apr 2024 16:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712765665;
	bh=eHcJpndqtwzVN4cnsL6DiGE1t1qVRN1vvary0pO1BDY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N0NE2a+/DKgfgfuti9GGK+eIDEk0hKZ18PD1VzDiP8iyljJDxoRzb7Vc82KCHDDvF
	 JGyscqiN44sPoe4Cse1eENYPhS1dALUbxPkdOz7pWYD6ruI2t38Kp1jLnNH1ovP4BX
	 jBMnB5Re4HXGi7y2oSoyRdMEzFbZZvteW31kt0EF4VHfdiNNOU6pd7/3vQqp9qgjo0
	 WR5H1mcrRsbMYcm1Qqp5TBu4lA015E0UfNrJ2f0ev5K+J9aMVTQhNrdOKF350G+4Uu
	 O2PTIcTaq/g3UTTm5obrzRLQe+cwRn389Sf1a7pPUuMUeh/hXNoZWv0k+Hx6hmW8pr
	 IPZtXg1Sc4fjg==
Date: Wed, 10 Apr 2024 11:14:23 -0500
From: Rob Herring <robh@kernel.org>
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Azeem Shaikh <azeemshaikh38@gmail.com>,
	Sebastian Reichel <sre@kernel.org>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	linux-ide@vger.kernel.org, Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	linux-renesas-soc@vger.kernel.org, Helge Deller <deller@gmx.de>,
	linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
	Stephen Boyd <sboyd@kernel.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	David Rientjes <rientjes@google.com>, Baoquan He <bhe@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Herve Codina <herve.codina@bootlin.com>, devicetree@vger.kernel.org,
	linux-sh@vger.kernel.org, Lee Jones <lee@kernel.org>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Manikanta Guntupalli <manikanta.guntupalli@amd.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>, Guo Ren <guoren@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	David Airlie <airlied@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Niklas Cassel <cassel@kernel.org>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Linus Walleij <linus.walleij@linaro.org>, linux-pci@vger.kernel.org,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	Heiko Stuebner <heiko.stuebner@cherry.de>,
	Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Anup Patel <apatel@ventanamicro.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Jacky Huang <ychuang3@nuvoton.com>, linux-serial@vger.kernel.org,
	Chris Morgan <macromorgan@hotmail.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	linux-clk@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Rich Felker <dalias@libc.org>,
	Arnd Bergmann <arnd@arndb.de>, Maxime Ripard <mripard@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Shawn Guo <shawnguo@kernel.org>
Subject: Re: [RESEND v7 17/37] dt-bindings: interrupt-controller:
 renesas,sh7751-intc: Add json-schema
Message-ID: <171276565286.385332.7851969997819611251.robh@kernel.org>
References: <cover.1712207606.git.ysato@users.sourceforge.jp>
 <cd7aae0800d9fc97f4d265c34ad4ac8c19dfd8f3.1712207606.git.ysato@users.sourceforge.jp>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd7aae0800d9fc97f4d265c34ad4ac8c19dfd8f3.1712207606.git.ysato@users.sourceforge.jp>


On Thu, 04 Apr 2024 14:14:28 +0900, Yoshinori Sato wrote:
> Renesas SH7751 INTC json-schema.
> 
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> ---
>  .../renesas,sh7751-intc.yaml                  | 53 +++++++++++++++++++
>  1 file changed, 53 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/renesas,sh7751-intc.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>


