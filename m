Return-Path: <linux-pci+bounces-34881-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B385CB37BCC
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 09:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5BAE1BA192A
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 07:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7732318135;
	Wed, 27 Aug 2025 07:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="hoP2Ahk2"
X-Original-To: linux-pci@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F5733EC;
	Wed, 27 Aug 2025 07:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756279984; cv=none; b=uuVETBB6t1r1dlIgO/Tej7QdwOH9f7N/47BvxrLvv8oSjBHTreNWmloJqaHfOCb4D1Q9WcfIknJgB86RvQ5vUQErp+ZNjTmh9o9G8+bMPBZacF1+bGMkUuKZqmc9AeA/tlj4GLPNVcetfFhA5501YHEuizlT26sieaZwrkHQaXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756279984; c=relaxed/simple;
	bh=csfpHjHmYUMd0X65UNDX1fL+H+H1B/gOfT575ffmaGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kRsJAnymoQtxmTRNk2L7C1eQdIhiSrC6JZj+akL6JYqCD0ffV+9QY03na0TFbpvP8X1uKxgGfqx2/QSmb28IbCH3swrK+x6QtyR8mW691r0OHNpHf0VZmtSQcWCgefK2Tom0E0z3RxB2GhB8M7etg3RX5FJZEOBrepoWNWGVVZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=hoP2Ahk2; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=csfpHjHmYUMd0X65UNDX1fL+H+H1B/gOfT575ffmaGg=; b=hoP2Ahk2JAPZOAkRsNvAGKlrru
	bFII+CNjGmCnvMOBsIRx6bMU/RJPWf/ru1JqMI7UaSocMEv8Yo4eDu7vViO9rifOWHqa0Y5ZonMgI
	XuAeSS1HEfelwMRcunyJMEgg07TLO6nBT4LKVKcmMSRkClgtR1gUAAVbCkkeC/SaF3ALB5URggZL4
	P8wZG4RWoZEzseopv1FU6hZwUt6VEjSkeeDyHSl+yGqqYSXgERRZnLWBuCUM96JeVgmekns8Y+Woi
	h73tlXiAjfpHoPOmgAnlyu+Cz+XZaw4KQREmmO/vb1Gmr3yV3zz5vNgkd7DpxWEo9qiZJQRlUxgzU
	faZYj0sA==;
Received: from [213.244.170.152] (helo=phil.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1urAdw-0004nS-Rr; Wed, 27 Aug 2025 09:32:28 +0200
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
 Re: [PATCH v3 11/20] drm/rockchip: inno-hdmi: switch to FIELD_PREP_WM16 macro
Date: Wed, 27 Aug 2025 09:32:26 +0200
Message-ID: <5006976.yKVeVyVuyW@phil>
In-Reply-To: <20250825-byeword-update-v3-11-947b841cdb29@collabora.com>
References:
 <20250825-byeword-update-v3-0-947b841cdb29@collabora.com>
 <20250825-byeword-update-v3-11-947b841cdb29@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Montag, 25. August 2025, 10:28:31 Mitteleurop=C3=A4ische Sommerzeit schr=
ieb Nicolas Frattaroli:
> The era of hand-rolled HIWORD_UPDATE macros is over, at least for those
> drivers that use constant masks.
>=20
> The inno-hdmi driver's own HIWORD_UPDATE macro is instantiated only
> twice. Remove it, and replace its uses with FIELD_PREP_WM16. Since
> FIELD_PREP_WM16 shifts the value for us, we replace using the mask as
> the value by simply using 1 instead.
>=20
> With the new FIELD_PREP_WM16 macro, we gain better error checking and a
> central shared definition.
>=20
> This has been compile-tested only as I lack hardware this old, but the
> change is trivial enough that I am fairly certain it's equivalent.
>=20
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>



