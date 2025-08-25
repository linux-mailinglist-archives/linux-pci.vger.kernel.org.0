Return-Path: <linux-pci+bounces-34650-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F111DB33954
	for <lists+linux-pci@lfdr.de>; Mon, 25 Aug 2025 10:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC2B4189A6F5
	for <lists+linux-pci@lfdr.de>; Mon, 25 Aug 2025 08:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C8E62BDC1E;
	Mon, 25 Aug 2025 08:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="P7TuEx/U"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708FE29E0E8;
	Mon, 25 Aug 2025 08:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756110813; cv=pass; b=kopo+R82XhxEtj09C4O8PV3MqfQHZxWfsR/3RXPnka2dElBK2cZOXx/UqFK9bdy/eqgqWpunTCCc7Sxy8YPYEb8ta8ufp0pN1+t4zPCwyYdAYlMz3lTb7ev8XpuAndLCo6/KkthWB/5P08/Df9ru0clwVur/tP/5iVisi/eQYDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756110813; c=relaxed/simple;
	bh=qLbDNkhT4Jc8+LGEt2Nkh/QbLYdTIrfYRf8Qu2COsjI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t2LYQFON0wXxo+0j0xKAOd2KclM1ZVx+lwZOTcDJW3ODwFDakCQLXJ8NcUlb6alKbl3zPjTz66DMZXIWmrhIJCHWUTbxbSGQ2M0EcotVA8tINjH5Tv3RVhL9eRXHsVLgp8FFMsYAWBbRWMOYcZcgeviPObqkq90z+SjJSZeIQf4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=P7TuEx/U; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1756110750; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=CXyTKlt6pZ2nseKenhkB5b8hdvvwAae1SOMca72O66Q3cJj3T4OK/t0aR6s3qUHEXjgj4hKg4VhWTrUrP5nlT4nFr9DTFtA1AD6MO8FtYNmPq53M5UbXW/Wkif6IKyidBDi+kBMJChBM4WboMZRa7TeHNRdqwht/7MmliImVOD4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756110750; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=YPAtusKlN6eqdYG3bgmczV1EypJC/IejzFNhAelA5Kk=; 
	b=VwqPwxS5SV+h4mYyQqNi/XGd3oPOLDuceCJ5aydMVdtL5+99BJhNN7Sm88JDFJP1vBFL/PbPxR+eWwLALSr7vqZtKyJd5x9fRWA8NB58wncqazVekJ7wGHCooxUIJp7yFZjkaN6TV1wFlPtBuy1MkwK26/edC5yGpDUU8TezcTI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756110750;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=YPAtusKlN6eqdYG3bgmczV1EypJC/IejzFNhAelA5Kk=;
	b=P7TuEx/Uqi+3S53TlXs35nOePsIHr6ObIdXv5VmrVT7iOSW6Q/iJ7yll//p0oa7O
	4DWqDcEfDPrlW9ldGpngBSWYHhDCimJiOB9DojHeJKUqberyBV26y48mjUO+Q8ipvQH
	JF7Q7wXkkGMe1ryTxdqsKHe1SkWEpJRxkYbkqC/Q=
Received: by mx.zohomail.com with SMTPS id 1756110748821283.62188569936666;
	Mon, 25 Aug 2025 01:32:28 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Mon, 25 Aug 2025 10:28:35 +0200
Subject: [PATCH v3 15/20] net: stmmac: dwmac-rk: switch to FIELD_PREP_WM16
 macro
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250825-byeword-update-v3-15-947b841cdb29@collabora.com>
References: <20250825-byeword-update-v3-0-947b841cdb29@collabora.com>
In-Reply-To: <20250825-byeword-update-v3-0-947b841cdb29@collabora.com>
To: Yury Norov <yury.norov@gmail.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Ulf Hansson <ulf.hansson@linaro.org>, Heiko Stuebner <heiko@sntech.de>, 
 Shreeya Patel <shreeya.patel@collabora.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Sandy Huang <hjc@rock-chips.com>, Andy Yan <andy.yan@rock-chips.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Shawn Lin <shawn.lin@rock-chips.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Chanwoo Choi <cw00.choi@samsung.com>, 
 MyungJoo Ham <myungjoo.ham@samsung.com>, 
 Kyungmin Park <kyungmin.park@samsung.com>, Qin Jian <qinjian@cqplus1.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: kernel@collabora.com, linux-kernel@vger.kernel.org, 
 linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-phy@lists.infradead.org, 
 linux-sound@vger.kernel.org, netdev@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, linux-pci@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, llvm@lists.linux.dev, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.14.2

The era of hand-rolled HIWORD_UPDATE macros is over, at least for those
drivers that use constant masks.

Like many other Rockchip drivers, dwmac-rk has its own HIWORD_UPDATE
macro. Its semantics allow us to redefine it as a wrapper to the shared
hw_bitfield.h FIELD_PREP_WM16 macros though.

Replace the implementation of this driver's very own HIWORD_UPDATE macro
with an instance of FIELD_PREP_WM16 from hw_bitfield.h. This keeps the
diff easily reviewable, while giving us more compile-time error
checking.

The related GRF_BIT macro is left alone for now; any attempt to rework
the code to not use its own solution here would likely end up harder to
review and less pretty for the time being.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index 9fc41207cc459313e575a2b00236b82611ad9603..c500194de3cc303f68fdd8a2466a81a63d4601d8 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/stmmac.h>
+#include <linux/hw_bitfield.h>
 #include <linux/bitops.h>
 #include <linux/clk.h>
 #include <linux/phy.h>
@@ -149,7 +150,7 @@ static int rk_set_clk_mac_speed(struct rk_priv_data *bsp_priv,
 }
 
 #define HIWORD_UPDATE(val, mask, shift) \
-		((val) << (shift) | (mask) << ((shift) + 16))
+		(FIELD_PREP_WM16((mask) << (shift), (val)))
 
 #define GRF_BIT(nr)	(BIT(nr) | BIT(nr+16))
 #define GRF_CLR_BIT(nr)	(BIT(nr+16))

-- 
2.51.0


