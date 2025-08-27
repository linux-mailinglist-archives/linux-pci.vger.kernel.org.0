Return-Path: <linux-pci+bounces-34877-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 921DAB37B6C
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 09:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D6A636707F
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 07:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B383E3176F4;
	Wed, 27 Aug 2025 07:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="paqG0/bt"
X-Original-To: linux-pci@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC001E8342;
	Wed, 27 Aug 2025 07:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756279358; cv=none; b=uGX6ynxlyr209styAtdI7XkVGo0MJQu61yorK1jiI370xH7YKODeAdEBqCM3Cgwm14GuecTlmjJxqdkSIqpNWY7/1LKwnPezT7bub5G5fcULgHtusopYsXEyMEDsLMLtkeWkkmRjxEARVlro9OXCl+8ny7xve3LSZhr+9dMbAhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756279358; c=relaxed/simple;
	bh=G+hmXrHggGQu/DFm2iaN9YOAsgDAVtUlcX4wbDIaTAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gT2CqTUhQB7mj9sfaXFwIqSImjC1VU/VzP0rnOvm3DTWKqtxp8Byk6M8sWACmQlywhIFkHa6R8p9KG44WEQdPBJXlygFB1DZoBjko89DgTF2fdBCWOelIACLgR/5q6biqt8q/UaQx+c2p6gW6QPGpDIYgxofYUqjsHaFq4fQ8ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=paqG0/bt; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=G+hmXrHggGQu/DFm2iaN9YOAsgDAVtUlcX4wbDIaTAM=; b=paqG0/btPjpriUue1ZLq40xLBd
	GBgOWrFL05XOmF286hGkQVhrhfZqZimImLzlqfvnvVlVMHo57pYqqanZe5p+RWyExLLfK8pM6Q5Cq
	xdTc0nJjioWVaXjKpM6xHGG33hNdJlVOqRRL+S4OzGg7IrzrmTrdXDfSV/OniMWb8NfMr7hViTPqT
	qh4CArG3EfgYiwDGIxDxzDICg/hr95MIGKc/d2Fy1Rh+nq9Okcnz7bP4oClR/Liyw76jtlNxiWYgk
	upeAZRYX6mfLnf/YA7pnADtT8ZXvkmab4GGfHfUpjyupzxU/QmqBCPG9/xLHsUBttuD7WbfOzPmK7
	upjPzyNA==;
Received: from [213.244.170.152] (helo=phil.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1urATt-00078I-85; Wed, 27 Aug 2025 09:22:05 +0200
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
 Re: [PATCH v3 07/20] drm/rockchip: dsi: switch to FIELD_PREP_WM16* macros
Date: Wed, 27 Aug 2025 09:22:04 +0200
Message-ID: <4886676.atdPhlSkOF@phil>
In-Reply-To: <20250825-byeword-update-v3-7-947b841cdb29@collabora.com>
References:
 <20250825-byeword-update-v3-0-947b841cdb29@collabora.com>
 <20250825-byeword-update-v3-7-947b841cdb29@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Montag, 25. August 2025, 10:28:27 Mitteleurop=C3=A4ische Sommerzeit schr=
ieb Nicolas Frattaroli:
> The era of hand-rolled HIWORD_UPDATE macros is over, at least for those
> drivers that use constant masks.
>=20
> Remove this driver's HIWORD_UPDATE macro, and replace instances of it
> with either FIELD_PREP_WM16 or FIELD_PREP_WM16_CONST, depending on
> whether they're in an initializer. This gives us better error checking,
> which already saved me some trouble during this refactor.
>=20
> The driver's HIWORD_UPDATE macro doesn't shift up the value, but expects
> a pre-shifted value. Meanwhile, FIELD_PREP_WM16 and
> FIELD_PREP_WM16_CONST will shift the value for us, based on the given
> mask. So a few things that used to be a HIWORD_UPDATE(VERY_LONG_FOO,
> VERY_LONG_FOO) are now a somewhat more pleasant
> FIELD_PREP_WM16(VERY_LONG_FOO, 1).
>=20
> There are some non-trivial refactors here. A few literals needed a UL
> suffix added to stop them from unintentionally overflowing as a signed
> long. To make sure all of these cases are caught, and not just the ones
> where the FIELD_PREP_WM16* macros use such a value as a mask, just mark
> every literal that's used as a mask as unsigned.
>=20
> Non-contiguous masks also have to be split into multiple
> FIELD_PREP_WM16* instances, as the macro's checks and shifting logic
> rely on contiguous masks.
>=20
> This is compile-tested only.
>=20
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>



