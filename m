Return-Path: <linux-pci+bounces-29676-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E973AD8A1A
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 13:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFB521E27E0
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 11:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A09F72D5C72;
	Fri, 13 Jun 2025 11:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g4kKdw9S"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0F72D5C63;
	Fri, 13 Jun 2025 11:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749813157; cv=none; b=SIE0oH12zaJNGQgTffdst6kxIlvMHSdHjKBEYy+I2T6tBLLm1saRCC7H6t+Oeby9jOEwmRYks9xmPIF8QrY9j0yTcZQ9MT4hLokl2PyDMnYrnU3AKhmYs+G+X3KWaJNG3W+rmJyX31Qq8VbqNmjvlQW1EWa7vNTy6dO7O9ssolU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749813157; c=relaxed/simple;
	bh=3JSffdcKG1BEdfLxDkvCLXE5WcpkgQe1rrYaCHuFNrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gxwTZXmvmzlIjd4Wtz6vucKvPu0KgqWuIKw28WuizKOHJ7y3czPBm4Rur1Ps/ffXaM7s8DybRV8AjDdtHSSR0JHY6HSTPCpnO8/dVsa/60T+DKMWwm5bopFKdY+SEnPiwvXWy++8WUKPaPr290dXLifV2tuCDI/ePYyZOb/x6sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g4kKdw9S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EE8AC4CEF1;
	Fri, 13 Jun 2025 11:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749813156;
	bh=3JSffdcKG1BEdfLxDkvCLXE5WcpkgQe1rrYaCHuFNrw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g4kKdw9SM2bno1fEAUiCi6mw5ZmG2oOwM9TdgZeIyT1IQbX7X77HcJ1LYqfuskboa
	 JGRT3GgKJU7HfdKVHhEwM6RbZVBVlK/P5c4ZU4IqGpHDoM9jVWM/ytqZuhOEoKayrO
	 xTsq76VB+ZzyRppRpOMFJJN6JOHbjdwagkrEFx3Ng0/lhqAyAceklyVmJaQug8641Q
	 JSHHo90KaBC05xuTm1/zTU/9LwbDwYf8mzg7yZYfDEuuM89nlEVvUy9Ws3qrTN5xaj
	 +W1kJlaU5hXI6P9GIWNe9FGwWwkVeh7uwqDhoiXxU9TaeL0RzbPSSxvPd6dZscVPeL
	 2OG33FATjlbqg==
Date: Fri, 13 Jun 2025 12:12:23 +0100
From: Mark Brown <broonie@kernel.org>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Shreeya Patel <shreeya.patel@collabora.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sandy Huang <hjc@rock-chips.com>,
	Andy Yan <andy.yan@rock-chips.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Qin Jian <qinjian@cqplus1.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, kernel@collabora.com,
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-phy@lists.infradead.org,
	linux-sound@vger.kernel.org, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com, linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH 14/20] ASoC: rockchip: i2s-tdm: switch to
 HWORD_UPDATE_CONST macro
Message-ID: <f38ea320-8eaa-4eea-85c1-63d44c8d359a@sirena.org.uk>
References: <20250612-byeword-update-v1-0-f4afb8f6313f@collabora.com>
 <20250612-byeword-update-v1-14-f4afb8f6313f@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EoywhozqJ8iTP5HR"
Content-Disposition: inline
In-Reply-To: <20250612-byeword-update-v1-14-f4afb8f6313f@collabora.com>
X-Cookie: Use extra care when cleaning on stairs.


--EoywhozqJ8iTP5HR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 08:56:16PM +0200, Nicolas Frattaroli wrote:
> The era of hand-rolled HIWORD_UPDATE macros is over, at least for those
> drivers that use constant masks.
>=20
> Replace the implementation of this driver's HIWORD_UPDATE macro with an
> instance of HWORD_UPDATE_CONST. The const variant is chosen here because
> some of the header defines are then used in initializers.

Acked-by: Mark Brown <broonie@kernel.org>

--EoywhozqJ8iTP5HR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmhMB5YACgkQJNaLcl1U
h9Bobgf/dsPkAlIpLO/GS4oVRLlRiPIWa/agIoUuXFfDugqesR7MdX12gZHAzJ9s
BnznMlPSuOjDnlFPdVpRCgVr4iPfs88ixFAuy/SjKEjvV8VYAUBEs1sg2JykJyMZ
SkQ69/Iii/uButuWqecqljEHZvL7j67axT7KsEimeZ1zynLexrz7vtE6t4P8p+YE
7qrc1oKA5kjXrIug8enyLvuLzI75M7MfzuRaooCPej44mc4bjqpuH6zXCxPzAWt9
0LEzYDn7kdMZ5Yn0Vp35b8uKRqPdQs1heacEsmiHmKPfvnY/klYg1G9M71t9OVpm
EE2sy3C4QrYbYl73/UBH9Z7zoN/X2A==
=9PDr
-----END PGP SIGNATURE-----

--EoywhozqJ8iTP5HR--

