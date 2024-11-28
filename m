Return-Path: <linux-pci+bounces-17438-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 367159DBCA8
	for <lists+linux-pci@lfdr.de>; Thu, 28 Nov 2024 20:43:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92CFCB213AD
	for <lists+linux-pci@lfdr.de>; Thu, 28 Nov 2024 19:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342651C1F37;
	Thu, 28 Nov 2024 19:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eAUsbA6H";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8UZO/2Lo";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aU0deQYN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+9zgCbxh"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CB2AD4B;
	Thu, 28 Nov 2024 19:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732822979; cv=none; b=OyUJf5u/SEf/92xV6W7GIcvgQOQOa6FHpZsN4UpBN1WvohLwDzDiND39Eq/H0D0F9BhFV1/hEvyeRelCdD2LtQtGGMUvhCHPFqgeuqWFhMxSPhdb6B3a0D/+Z/siUxZe5OxNqWv6WFcOUf3EO9o9W1PTCi8WavDEg3RdTbY7zH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732822979; c=relaxed/simple;
	bh=XyroRPpAI4edVZZ1GDOxrNCE8LX/EuOXr66TVhTl3hI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sqpYxmUHKbdsKM6mB7tClLUgCPaWd4DJz0rXI48aSX+TrBxw5PG5V7ScVANkbP3ckXSTvZ9uxgY0cB8wdqsSVOyjbk4xWRtzAlVqB/Yj9m1qKPYFUUxgCqKqqTwzNDzz3vORMCS1Xi3rQzAR4y4CRq2Ie1D4OOsDNjiO2weN4jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=eAUsbA6H; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8UZO/2Lo; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aU0deQYN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+9zgCbxh; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from lion.mk-sys.cz (unknown [10.100.225.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 91E8B21190;
	Thu, 28 Nov 2024 19:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732822974; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u9QGgGdv77W2pOdQiAtUv+Iwdr6afjftqDVxt/e/CoM=;
	b=eAUsbA6H44fzsfyPZVAkCfOY2dQVMh81CEEiZn1ASgrjy27e4E3fNbQDtacMzRI0AggFy0
	i00+V0j/TymW0KKgRQ8FjRsQHsqjaGhfzx7PfLDsjjZzrT1XgGf4Y14/ZIU7Dg6WgkzhyQ
	U1bcR57KCUzMXSyO2i1cFxo6bXeK24w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732822974;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u9QGgGdv77W2pOdQiAtUv+Iwdr6afjftqDVxt/e/CoM=;
	b=8UZO/2Lo+8a7sa07GlQNW0yJ4VFyXdh7IkNVDZbp4jI0atLqPulMdEnyUFn6rljxi6+MpG
	yR3AkqCMjtlpCTCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732822973; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u9QGgGdv77W2pOdQiAtUv+Iwdr6afjftqDVxt/e/CoM=;
	b=aU0deQYNIvJKoHIaKI++tY1aKJshwSf10+LLBLKhI/zcgVAr9WnBuNXA57wEp7YiSJ7KsT
	WijkJt09dd9VgtdQ1IJ46w4quJ2nGWwgSXLZLzGVFysi3sfs67YrOjzU+9n1lFAIWQW5g8
	e76q88pSZsBnctFfFczAwdKUgFVb05U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732822973;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u9QGgGdv77W2pOdQiAtUv+Iwdr6afjftqDVxt/e/CoM=;
	b=+9zgCbxhh4S4CW4owkzqvtP8g7kHFSY7JD4fJHcV7e8UXHXlu6hN4MnfiaTVwsRJOJ8d3O
	gRUdySmg52l/J2BA==
Received: by lion.mk-sys.cz (Postfix, from userid 1000)
	id 7CDE22012C; Thu, 28 Nov 2024 20:42:53 +0100 (CET)
Date: Thu, 28 Nov 2024 20:42:53 +0100
From: Michal Kubecek <mkubecek@suse.cz>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, 
	Andy Shevchenko <andy.shevchenko@gmail.com>, Simon Horman <horms@kernel.org>, Lee Jones <lee@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Derek Kiernan <derek.kiernan@amd.com>, 
	Dragan Cvetic <dragan.cvetic@amd.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Lars Povlsen <lars.povlsen@microchip.com>, Steen Hegelund <Steen.Hegelund@microchip.com>, 
	Daniel Machon <daniel.machon@microchip.com>, UNGLinuxDriver@microchip.com, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Horatiu Vultur <horatiu.vultur@microchip.com>, 
	Andrew Lunn <andrew@lunn.ch>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Allan Nielsen <allan.nielsen@microchip.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v9 1/6] misc: Add support for LAN966x PCI device
Message-ID: <dywwnh7ns47ffndsttstpcsw44avxjvzcddmceha7xavqjdi77@cqdgmpdtywol>
References: <20241010063611.788527-1-herve.codina@bootlin.com>
 <20241010063611.788527-2-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="j7d5vatgnxlcdmpo"
Content-Disposition: inline
In-Reply-To: <20241010063611.788527-2-herve.codina@bootlin.com>
X-Spam-Score: -4.40
X-Spamd-Result: default: False [-4.40 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	TAGGED_RCPT(0.00)[dt];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	R_RATELIMIT(0.00)[to_ip_from(RLojywjshxai19ykpmbjx9w3ts)];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-m68k.org,gmail.com,kernel.org,arndb.de,amd.com,linuxfoundation.org,google.com,pengutronix.de,microchip.com,davemloft.net,redhat.com,lunn.ch,vger.kernel.org,lists.infradead.org,bootlin.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lion.mk-sys.cz:helo,linuxfoundation.org:email,bootlin.com:email]
X-Spam-Flag: NO
X-Spam-Level: 


--j7d5vatgnxlcdmpo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 08:36:01AM +0200, Herve Codina wrote:
> Add a PCI driver that handles the LAN966x PCI device using a device-tree
> overlay. This overlay is applied to the PCI device DT node and allows to
> describe components that are present in the device.
>=20
> The memory from the device-tree is remapped to the BAR memory thanks to
> "ranges" properties computed at runtime by the PCI core during the PCI
> enumeration.
>=20
> The PCI device itself acts as an interrupt controller and is used as the
> parent of the internal LAN966x interrupt controller to route the
> interrupts to the assigned PCI INTx interrupt.
>=20
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>	# quirks.c
> ---
>  drivers/misc/Kconfig          |  24 ++++
>  drivers/misc/Makefile         |   3 +
>  drivers/misc/lan966x_pci.c    | 215 ++++++++++++++++++++++++++++++++++
>  drivers/misc/lan966x_pci.dtso | 167 ++++++++++++++++++++++++++
>  drivers/pci/quirks.c          |   1 +
>  5 files changed, 410 insertions(+)
>  create mode 100644 drivers/misc/lan966x_pci.c
>  create mode 100644 drivers/misc/lan966x_pci.dtso
>=20
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index 3fe7e2a9bd29..8e5b06ac9b6f 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -610,6 +610,30 @@ config MARVELL_CN10K_DPI
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called mrvl_cn10k_dpi.
> =20
> +config MCHP_LAN966X_PCI
> +	tristate "Microchip LAN966x PCIe Support"
> +	depends on PCI
> +	select OF
> +	select OF_OVERLAY

Are these "select" statements what we want? When configuring current
mainline snapshot, I accidentally enabled this driver and ended up
flooded with an enormous amount of new config options, most of which
didn't make much sense on x86_64. It took quite long to investigate why.

Couldn't we rather use

	depends on PCI && OF && OF_OVERLAY

like other drivers?

Michal

> +	select IRQ_DOMAIN
> +	help
> +	  This enables the support for the LAN966x PCIe device.
> +	  This is used to drive the LAN966x PCIe device from the host system
> +	  to which it is connected.
> +
> +	  This driver uses an overlay to load other drivers to support for
> +	  LAN966x internal components.
> +	  Even if this driver does not depend on these other drivers, in order
> +	  to have a fully functional board, the following drivers are needed:
> +	    - fixed-clock (COMMON_CLK)
> +	    - lan966x-oic (LAN966X_OIC)
> +	    - lan966x-cpu-syscon (MFD_SYSCON)
> +	    - lan966x-switch-reset (RESET_MCHP_SPARX5)
> +	    - lan966x-pinctrl (PINCTRL_OCELOT)
> +	    - lan966x-serdes (PHY_LAN966X_SERDES)
> +	    - lan966x-miim (MDIO_MSCC_MIIM)
> +	    - lan966x-switch (LAN966X_SWITCH)
> +
>  source "drivers/misc/c2port/Kconfig"
>  source "drivers/misc/eeprom/Kconfig"
>  source "drivers/misc/cb710/Kconfig"
[...]

--j7d5vatgnxlcdmpo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEWN3j3bieVmp26mKO538sG/LRdpUFAmdIx7cACgkQ538sG/LR
dpU7nAf/XBbO498856QKivFIfm7fBoDun6OltBIzDjQpOY3U424Hl6ZSYNW9Bovz
KCS+Ca82RFcUPkWwtYkY1Wuu2xD2CZs2ChCPURibTrloed3inIAHnAIdplJJz1o1
jzIFZhxvquaFI2GT+PS/Rn4EK/O00YA1YznI0w0EyCYUd4GPKiRvFDjihNvAjB0a
BwFaqUpcXEMDBtwDJ7fSN2aKHllfQHfQGscAMuN6SwH9Fq1F8yEnPcOniequDyN2
Vw68yNm2tVkouUWN9yaPX2LHS+0C0cqGjgu3GpNVkavhjFM9so07iJlXOQJxgSPJ
UGMHSzZCvmGYJLZb39hHz9014QZU1g==
=DdLR
-----END PGP SIGNATURE-----

--j7d5vatgnxlcdmpo--

