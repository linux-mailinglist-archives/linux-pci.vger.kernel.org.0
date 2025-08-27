Return-Path: <linux-pci+bounces-34885-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 626AEB37BF1
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 09:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 893921BA1E3E
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 07:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2557B31A062;
	Wed, 27 Aug 2025 07:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="RHfVaqBi"
X-Original-To: linux-pci@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6DA319843;
	Wed, 27 Aug 2025 07:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756280293; cv=none; b=YJm9KeumMozASkOBwyLV2Nl0v37iY6IWaMa4NqJUmggWI7/WGKjoV6CvO2jwUIqVCfYgkeu7W2eG3xbjvFqStTjAttPhvpAEpe8kqNuJVY9Rnf/p9/KFv8W5otrysBO3kI5zzFjERYsOYum5fyaeTsXta4efFrEzArInFvpF78c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756280293; c=relaxed/simple;
	bh=A0g4115fIgBE403Cl3EfktmE7DlY2fExfjJG9NOynE8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tBDayGV+5dXf/9ghOmDNdi1c9HSa77pMyFDPKMOXMEDbuqwIfsisklB8k2F4/0Op/GDn/6qX1Nm/NQfvT94ETaEUGeenGpHoSD6GtVZE0FeSY1sIuJSIYXh4+VMZcIRNDVNn/t0p57TrCBFH2MVq4wXPnEWOkqc7cGRzeU2rVR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=RHfVaqBi; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=A0g4115fIgBE403Cl3EfktmE7DlY2fExfjJG9NOynE8=; b=RHfVaqBiuWv5qA9rEDSV76B74j
	/VRQEQEMJq+nrAYoEUfkbgqWaVFcKadDL23pvoNbN9HYno5c4fVFKKfHkm22CaOkniiuJytlbHD4H
	7K/s0kBWZ2gDHfzNqBy15zPAWfeIvhakAsL7tyUP4aCcAMp4Yn0l/l8ZevpodPz8FWhwZsoGGwVSb
	Z5HU/Cr/JFL/2E6StotztE4Bn9Fz07uO+kKVaugdC58pSD1jdkeB9Rpu6Mjm+PA/A5gNKITUdtDmd
	bazV4H7WtQdO5d1VmNDBiBkWutZ6vOrDBqE7JVQExXP7kAkhWocTvSvaKBVGHGuRUNaEos8Aep0E6
	n6v0sEgQ==;
Received: from [213.244.170.152] (helo=phil.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1urAj0-0007uF-FN; Wed, 27 Aug 2025 09:37:42 +0200
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
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Subject:
 Re: [PATCH v3 13/20] drm/rockchip: dw_hdmi: switch to FIELD_PREP_WM16* macros
Date: Wed, 27 Aug 2025 09:37:41 +0200
Message-ID: <18528244.tv2OnDr8pf@phil>
In-Reply-To: <20250825-byeword-update-v3-13-947b841cdb29@collabora.com>
References:
 <20250825-byeword-update-v3-0-947b841cdb29@collabora.com>
 <20250825-byeword-update-v3-13-947b841cdb29@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Montag, 25. August 2025, 10:28:33 Mitteleurop=C3=A4ische Sommerzeit schr=
ieb Nicolas Frattaroli:
> The era of hand-rolled HIWORD_UPDATE macros is over, at least for those
> drivers that use constant masks.
>=20
> Remove this driver's very own HIWORD_UPDATE macro, and replace all
> instances of it with equivalent instantiations of FIELD_PREP_WM16 or
> FIELD_PREP_WM16_CONST, depending on whether it's in an initializer.
>=20
> This gives us better error checking, and a centrally agreed upon
> signature for this macro, to ease in code comprehension.
>=20
> Because FIELD_PREP_WM16/FIELD_PREP_WM16_CONST shifts the value to the
> mask (like FIELD_PREP et al do), a lot of macro instantiations get
> easier to read.
>=20
> This was tested on an RK3568 ODROID M1, as well as an RK3399 ROCKPro64.
>=20
> Reviewed-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> Tested-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>



