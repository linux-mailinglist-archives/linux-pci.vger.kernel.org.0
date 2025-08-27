Return-Path: <linux-pci+bounces-34897-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00ABFB37CEF
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 10:07:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2589A7AF418
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 08:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 547C4322C7A;
	Wed, 27 Aug 2025 08:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="lpvZbN1v"
X-Original-To: linux-pci@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E4C30CDBB;
	Wed, 27 Aug 2025 08:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756282034; cv=none; b=YahqCKfS2Yn9PU9kiA8aMNTzgU8fzeowaH97Qm57ljDM/MBinT5tsMhAYMPQT28I1lA/DdilCP21fcX1wM0jZkD4XcjrEqHpkUc6E3iKCTsYMyGiMJeaFZWvkIDvh2bW0F10QAm9tBb4rk4cx/g6xTHOXzWesr8PtJjOwR0csYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756282034; c=relaxed/simple;
	bh=nHn0/2tcQ6NKxDIG6MXiOpQl/j8R5Yoanaeftq4zEbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j6oKmw1r5jllACLrCUuvQKwS6loUciUdS5c8yU06ZEU+2cNZFMUC+IO+oG2jtrR3jt3n1S4wEWeyvgf9Nwm6DlxN0/3IZROrwj3Wd6pdwURy6xi+crd0qRcNVwy/w05JHQ0L2HkKqQVEPR/DJ3k9fkxVkCMIEtVsmGJ5lnLq9OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=lpvZbN1v; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=nHn0/2tcQ6NKxDIG6MXiOpQl/j8R5Yoanaeftq4zEbE=; b=lpvZbN1vFE1catKAjtPmzOO25D
	zQe3EYADcLN+u+VAb4HEmMxBKY5SafJaDYo/N6TNMFuP2oZom+6QyC/AcQGjJZbELGVRCEqd3EteB
	Fb13EBgEXMvzyuuYrFYrMfeYHRByJKSbUcvu3E66udd77HpJJotr8ch5V7KlYoSDEMMaTt98Gcnvd
	Wa3nuIX7IzNZjVImMGkSlLN4d6L623lauFYlOX5VWScp13JJTS9jUan+msw/NJB5G0gmicI7Kd3F9
	PhjF5C7+pBOZ2eafUWP7tC5PQRvDdbAh3Cp2DSoY0CmCakj8e/QkSktaIWTntJgsOAU9qJ6LDboUR
	m1ZKL4hQ==;
Received: from [213.244.170.152] (helo=phil.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1urBB2-0000Hv-Tf; Wed, 27 Aug 2025 10:06:40 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Yury Norov <yury.norov@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>,
 Shreeya Patel <shreeya.patel@collabora.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Sandy Huang <hjc@rock-chips.com>,
 Andy Yan <andy.yan@rock-chips.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Shawn Lin <shawn.lin@rock-chips.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Krzysztof =?UTF-8?B?V2lsY3p5xYRza2k=?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Chanwoo Choi <cw00.choi@samsung.com>,
 MyungJoo Ham <myungjoo.ham@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>, Qin Jian <qinjian@cqplus1.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: kernel@collabora.com, linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-phy@lists.infradead.org,
 linux-sound@vger.kernel.org, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-pci@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, llvm@lists.linux.dev,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Subject: Re: [PATCH v3 19/20] clk: sp7021: switch to FIELD_PREP_WM16 macro
Date: Wed, 27 Aug 2025 10:06:39 +0200
Message-ID: <5154190.bB369e8A3T@phil>
In-Reply-To: <20250825-byeword-update-v3-19-947b841cdb29@collabora.com>
References:
 <20250825-byeword-update-v3-0-947b841cdb29@collabora.com>
 <20250825-byeword-update-v3-19-947b841cdb29@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Montag, 25. August 2025, 10:28:39 Mitteleurop=C3=A4ische Sommerzeit schr=
ieb Nicolas Frattaroli:
> The sp7021 clock driver has its own shifted high word mask macro,
> similar to the ones many Rockchip drivers have.
>=20
> Remove it, and replace instances of it with hw_bitfield.h's
> FIELD_PREP_WM16 macro, which does the same thing except in a common
> macro that also does compile-time error checking.
>=20
> This was compile-tested with 32-bit ARM with Clang, no runtime tests
> were performed as I lack the hardware. However, I verified that fix
> commit 5c667d5a5a3e ("clk: sp7021: Adjust width of _m in HWM_FIELD_PREP()=
")
> is not regressed. No warning is produced.
>=20
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

While I have no connection with that specific piece of hardware,
the change itself looks correct, so

Reviewed-by: Heiko Stuebner <heiko@sntech.de>



