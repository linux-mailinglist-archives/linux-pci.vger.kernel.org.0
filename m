Return-Path: <linux-pci+bounces-34896-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F24DAB37CCF
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 10:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B707F3AF4A5
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 08:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8220322551;
	Wed, 27 Aug 2025 08:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="mtrPPwqa"
X-Original-To: linux-pci@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB890321435;
	Wed, 27 Aug 2025 08:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756281893; cv=none; b=OPVFi5ZBdYQRfQCGI3i3grsc+VnoeNoJ0cQUDRxs48BeqWSTrvz3KdbjqhAO+DoLumBWfbOAw6rB8irU/zH56whs1cN/19QVZReEsor1A3OMFARq33gZOLSOoYKidY2otns21BVjqod9pGdybutb690gE91uVJAu5RHBnNL69E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756281893; c=relaxed/simple;
	bh=H5XGGOqUvDfBDNoA9c9ChXTIWyKSBsmEcQMHpNsNPDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bYSiHTHgxECWN1SqmCw3zJjY0odwbT3pTwQ0bzGf+5tqOQ0X6VtftUypZerlIeUYut51slSh5OVrwOzBheEJ3SgiuXSEWNVNG9AhuGBOcSYt8KAvkyijxvWVx1tyXHxV4f8IL2cP/J3w5e6BByA3geXTXOZ/SnVtm1r3bojHjFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=mtrPPwqa; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=H5XGGOqUvDfBDNoA9c9ChXTIWyKSBsmEcQMHpNsNPDE=; b=mtrPPwqaUs12AGu5L+ainiAjWo
	LG0fGbIszK398JZ0KY0dLQFqHUEgpa78WPcICY29z9haXF2gu+qet2U9oar/B9EYUcWGS5mDVmVQ5
	FfdRptzZ2FTbaPLUYUE/DLwXpS2IBNRzVirIN+r0eD9Vx3WLDIuiC+j04MoDiy8oiUvghbsyFgJl6
	xhHxZtck6KVDZTQ637deyTTvZvoCndnNCfAUU1vzr/vdCDtsvL4+O1XywZZrjEQ3ksrhSd67FgZUX
	o6tiItZt/sCBeB/pcYbqDQThCgSrW42QOZe/NgxaFzLAMuSytJPKBkiLAGsDanxEmkdVRs78asGSa
	ZB48o00Q==;
Received: from [213.244.170.152] (helo=phil.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1urB8s-0007SN-IS; Wed, 27 Aug 2025 10:04:26 +0200
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
Subject:
 Re: [PATCH v3 20/20] phy: rockchip-pcie: switch to FIELD_PREP_WM16 macro
Date: Wed, 27 Aug 2025 10:04:24 +0200
Message-ID: <5143535.KlZ2vcFHjT@phil>
In-Reply-To: <20250825-byeword-update-v3-20-947b841cdb29@collabora.com>
References:
 <20250825-byeword-update-v3-0-947b841cdb29@collabora.com>
 <20250825-byeword-update-v3-20-947b841cdb29@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Montag, 25. August 2025, 10:28:40 Mitteleurop=C3=A4ische Sommerzeit schr=
ieb Nicolas Frattaroli:
> The era of hand-rolled HIWORD_UPDATE macros is over, at least for those
> drivers that use constant masks.
>=20
> The Rockchip PCIe PHY driver, used on the RK3399, has its own definition
> of HIWORD_UPDATE.
>=20
> Remove it, and replace instances of it with hw_bitfield.h's
> FIELD_PREP_WM16. To achieve this, some mask defines are reshuffled, as
> FIELD_PREP_WM16 uses the mask as both the mask of bits to write and to
> derive the shift amount from in order to shift the value.
>=20
> In order to ensure that the mask is always a constant, the inst->index
> shift is performed after the FIELD_PREP_WM16, as this is a runtime
> value.
>=20
> From this, we gain compile-time error checking, and in my humble opinion
> nicer code, as well as a single definition of this macro across the
> entire codebase to aid in code comprehension.
>=20
> Tested on a RK3399 ROCKPro64, where PCIe still works as expected when
> accessing an NVMe drive.
>=20
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>


Reviewed-by: Heiko Stuebner <heiko@sntech.de>



