Return-Path: <linux-pci+bounces-30426-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4CAAE4A72
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 18:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62BA01654F4
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 16:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC262BDC36;
	Mon, 23 Jun 2025 16:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="SPN2xJNL"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0DA29AB09;
	Mon, 23 Jun 2025 16:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750695009; cv=pass; b=gfBmkkFwS7NXmGe/vQ1rJoeWX1Z/IjEK+j9rJ4iPYEjcc+gA6MQsI+FPLCa8JiMCr/r4JC5g74pUpQy02Uegw+FMXlLTLoBC8KkDAzD57inOu9XIhqwXqc1lxPtfFBkHT5WC4jl9VRXlMASmvQSFVFPUai1YNTsoSxcEN/KIl00=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750695009; c=relaxed/simple;
	bh=7JiIpaYM5hsuSVVGC+Xb9B9Y6Q9lD6c+ZVmoW5ZLVjk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BnlTeyC/9FML5K5xgyL5XrlmfTldddZ3T7jeOWV4lkzgTL3wde9xZvLjOmBACsdMcU60NxsJXoPY6zXAv6w559GQxfITYAv69JxGnG6+Wy4CRop9YDzRTn5upRexOABnwpTrWF2GQOtxpc8623sR3x1S0XoOa0FU5AbsRa9kzPw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=SPN2xJNL; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1750694949; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Tvq9SVd7ARPBWa3fMmWRP/NQGUB60EVkqslAFKjahvQebS4TyVJ0TbMc8GzLcHmDRgZ8nqISx1UelNRG7S0ZMV2WtQj0GNFESik+efS0e8UIvLIQl1A+RSa2Uj4SJ1uWxR95bm/kMOX42W4ic8OWqxcV/m6Zwh+cl8tm5JzkVGE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1750694949; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=zZ4j6JHoVwtwIfIGG4M1yLQOntpYwXzvw5iD2BBsBYw=; 
	b=HQpMzIO2Q7VOJ9fsxKOlrmGbMwQuHeL6WgB2p43aM7G9qObWrafEKNLzMHz0oC0B33njgeZ4xT76EbiZU6LE4gUtaeCNgSWUvrPjjoSjCVeB/rRgbXrxbZxR3fpJKyzW/OVOhxiEEFBA1gfKq58sRbc14YZ05pxbZ8BXGl3F1CI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1750694949;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=zZ4j6JHoVwtwIfIGG4M1yLQOntpYwXzvw5iD2BBsBYw=;
	b=SPN2xJNLAqerbm+Q1kilsEjw7Hhyn0oHtS99qhBXA69mrcCCPSV734KKL0/I0ptL
	F8mdbWJAWxcnrLbGJI7M+78keu9Ak0Qx9+ejC3A4feShF21A5PFuGVY0xpWIsmCtUJe
	WbxPs0+1woBNnpzlajh51i+rHZ8+okyeB0W/A+oo=
Received: by mx.zohomail.com with SMTPS id 1750694947682868.0196949578926;
	Mon, 23 Jun 2025 09:09:07 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Mon, 23 Jun 2025 18:05:43 +0200
Subject: [PATCH v2 15/20] net: stmmac: dwmac-rk: switch to FIELD_PREP_WM16
 macro
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250623-byeword-update-v2-15-cf1fc08a2e1f@collabora.com>
References: <20250623-byeword-update-v2-0-cf1fc08a2e1f@collabora.com>
In-Reply-To: <20250623-byeword-update-v2-0-cf1fc08a2e1f@collabora.com>
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
index 79b92130a03faafbd26a0edf1a73199ecbb6e82b..0a1a83817ec19f3a42bc2d90f8b274575d60e278 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/stmmac.h>
+#include <linux/hw_bitfield.h>
 #include <linux/bitops.h>
 #include <linux/clk.h>
 #include <linux/phy.h>
@@ -150,7 +151,7 @@ static int rk_set_clk_mac_speed(struct rk_priv_data *bsp_priv,
 }
 
 #define HIWORD_UPDATE(val, mask, shift) \
-		((val) << (shift) | (mask) << ((shift) + 16))
+		(FIELD_PREP_WM16((mask) << (shift), (val)))
 
 #define GRF_BIT(nr)	(BIT(nr) | BIT(nr+16))
 #define GRF_CLR_BIT(nr)	(BIT(nr+16))

-- 
2.50.0


