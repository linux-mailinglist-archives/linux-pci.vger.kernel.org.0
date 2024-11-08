Return-Path: <linux-pci+bounces-16344-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E4D9C2285
	for <lists+linux-pci@lfdr.de>; Fri,  8 Nov 2024 17:57:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B85F1F235B1
	for <lists+linux-pci@lfdr.de>; Fri,  8 Nov 2024 16:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C8C2199223;
	Fri,  8 Nov 2024 16:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OSDYkbbK"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6635D1922EE;
	Fri,  8 Nov 2024 16:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731085016; cv=none; b=imLxfQ1+HOYxUtu9IfraIcYKbVVG74gvBLlWj1HpZcQ4zenTaYWBYzM+EZrNa7x28gmzPVETqOtGSID9jWxPB/9NetoiyVvH+Mi8B4X1Ro+GdqNMh9HBqa6GiV7pz6o6h2PxGRg+02rb/bw7VCCj2ksbKPqCU5EmqutQBfZD97Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731085016; c=relaxed/simple;
	bh=hjfkk2bPDC/830gBiHBjzD5EFmbHgFIcXBwd1zE5kGE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=PSuFQGsReuJU487kkeEwXUn5d7AVdNROzTo0CVJmeakp1vbo5euRmiXG7hpq4jpkBGImnHaCv8GXf6ldocOvI21bu/lzXpyx2wBh6BdXVwiEskQDH01Lkkk/5kWNH2DUiCZjPZxbff4kn8MXbo2vlpCB7Lq1qrJISrE5uZbGZ0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OSDYkbbK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B03DBC4CECD;
	Fri,  8 Nov 2024 16:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731085015;
	bh=hjfkk2bPDC/830gBiHBjzD5EFmbHgFIcXBwd1zE5kGE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=OSDYkbbKRO+AYZUWz7Sdh/5jZPwcxOt6K+qQ3Bi8Tdh8RvaGqMn+BBlP8VKDZbEKj
	 EZCdJJWpK4DpLf1qJFLIayaGJB3IVYHCc6E1uS/Qk0fNt67ztPzeNQhorC/DU6eSXq
	 woOQYbuy2hStYkSYEoNT8CAvNYWBnDAGfzOgSRWvUtNkUo+ZHI4SOOCY7hRw26qJEb
	 2eljXEp+AX/ADkBhMPlBSmj6Gywab+LA1oJMnbnvx/vBwIyruKOJ6iZLPZxbA+Kd2x
	 TVFKsr3mXTty3CPtV3FBdLmJcgfGatPWDOgYQXJvSnHY8UqMMOLyxkbxH2berrJLve
	 bgNfVoMNKS3ew==
Date: Fri, 8 Nov 2024 10:56:54 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Andrea della Porta <andrea.porta@suse.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Wilczynski <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Saravana Kannan <saravanak@google.com>, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Stefan Wahren <wahrenst@gmx.net>,
	Herve Codina <herve.codina@bootlin.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] of: address: Preserve the flags portion on 1:1
 dma-ranges mapping
Message-ID: <20241108165654.GA1665761@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae3363eb212b356d526e9cfa7775c6dfea33e372.1731060031.git.andrea.porta@suse.com>

On Fri, Nov 08, 2024 at 11:39:21AM +0100, Andrea della Porta wrote:
> A missing or empty dma-ranges in a DT node implies a 1:1 mapping for dma
> translations. In this specific case, the current behaviour is to zero out
> the entire specifier so that the translation could be carried on as an
> offset from zero.  This includes address specifier that has flags (e.g.
> PCI ranges).
> Once the flags portion has been zeroed, the translation chain is broken
> since the mapping functions will check the upcoming address specifier
> against mismatching flags, always failing the 1:1 mapping and its entire
> purpose of always succeeding.
> Set to zero only the address portion while passing the flags through.

Add blank lines between paragraphs.

> Fixes: dbbdee94734b ("of/address: Merge all of the bus translation code")
> Cc: stable@vger.kernel.org
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> Tested-by: Herve Codina <herve.codina@bootlin.com>
> ---
>  drivers/of/address.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/of/address.c b/drivers/of/address.c
> index 286f0c161e33..72b6accff21c 100644
> --- a/drivers/of/address.c
> +++ b/drivers/of/address.c
> @@ -455,7 +455,8 @@ static int of_translate_one(struct device_node *parent, struct of_bus *bus,
>  	}
>  	if (ranges == NULL || rlen == 0) {
>  		offset = of_read_number(addr, na);
> -		memset(addr, 0, pna * 4);
> +		/* copy the address while preserving the flags */

Not knowing the surrounding code, it seems strange to say "copy the
address" when the memset() fills with zero and does no copying.

The commit log says "set address to zero, pass flags through," and I
could believe *that* matches the memset().

> +		memset(addr + pbus->flag_cells, 0, (pna - pbus->flag_cells) * 4);
>  		pr_debug("empty ranges; 1:1 translation\n");
>  		goto finish;
>  	}
> -- 
> 2.35.3
> 

