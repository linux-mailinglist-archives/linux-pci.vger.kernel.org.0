Return-Path: <linux-pci+bounces-34644-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01DE3B33926
	for <lists+linux-pci@lfdr.de>; Mon, 25 Aug 2025 10:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4D451B2372F
	for <lists+linux-pci@lfdr.de>; Mon, 25 Aug 2025 08:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2862BF3CA;
	Mon, 25 Aug 2025 08:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="AUD3zR5a"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F6F2BE02C;
	Mon, 25 Aug 2025 08:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756110724; cv=pass; b=DcoWqaTnI8PFYDf3CF81eg5P2fXK20i7toplZyVFxECeKO8NZkE7K5fbRcwe8rC6epz9Cn3AiK4sQGnMzzJPBclRjCygnVu+MMAW987U1It2wkT8utkzmuqhln7JAK3/r8RtM7EyTg8URsAsGwEClwSNXKzxh24APyHFq1PhIYg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756110724; c=relaxed/simple;
	bh=P0TJnBl06k6/inD631UvdxjaoPGmS2puuKOgZipiRyU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OFfwXFSCbiXaKNEJFL+6CohKPSHt0BoNOd9lece2kwC44FmVeg3EGSohf74OUH27CYLjd9ja0VBBnoKz6++O+C5KUSh+wDuyM9A6hJCbh8mQoOolA0oHv9BFMrZmvYX9eF3x3F2oiRPmGGWMz2PrFdCPljdRH2E8tTbbFtxmpsY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=AUD3zR5a; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1756110665; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=jhiNG0lFtaTWQuU9JeWX1zIXjZ6RHIx1bvICoaRkHo1gwIpV2wpS8R8wzCRTjNWMCRijPkv0bVf5xRvBdiFG5HYFKGjysT1AmdrDywlID0aZrze9x1bz0dnrh4nm/F8JoNt/upjxPB04PEUuM1FvsKZi+NJqcf2GZndsRV3BNAk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756110665; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=oXdzLyDjy1en1noSqIeHf800Rfe5SrEuKJcIvmzNwtg=; 
	b=H3g64UWR30We/tL1i7zs1vG+5eMKeZdySDgx3wak8vWVSxEkKhL8Zy9lBVHzYiQLraJSvcdjKHrNvfyBbda4aHfS/MW3d/Hr2Q2btlQpSXp75QXeHfKZUxJPbVkuT5/eqXHLPrX6NHWtVxAi5lJTi2qbrzWvpX3R55KeXc1TtBI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756110665;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=oXdzLyDjy1en1noSqIeHf800Rfe5SrEuKJcIvmzNwtg=;
	b=AUD3zR5a6iPxgl4dKh4u88Zi1MAzoglpkZplQ3LJNp7W0TbrAVG2KkNU+qtEON4Y
	9LnHGc9bSYgon+ZN7ZQRqwYGBhDcpIwBhum32bzZasHL3ZXUdwZLnG1pen/c5YTI8NM
	xu2xTZHsIKbj63Joe1E3NU1oOevn3xVN7w2PPLOo=
Received: by mx.zohomail.com with SMTPS id 1756110662866130.9136658227335;
	Mon, 25 Aug 2025 01:31:02 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Mon, 25 Aug 2025 10:28:29 +0200
Subject: [PATCH v3 09/20] phy: rockchip-samsung-dcphy: switch to
 FIELD_PREP_WM16 macro
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250825-byeword-update-v3-9-947b841cdb29@collabora.com>
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

phy-rockchip-samsung-dcphy is actually an exemplary example, where the
similarities to FIELD_PREP were spotted and the driver local macro has
the same semantics as the new FIELD_PREP_WM16 hw_bitfield.h macro.

Still, get rid of FIELD_PREP_HIWORD now that a shared implementation
exists, replacing the two instances of it with FIELD_PREP_WM16. This
gives us slightly better error checking; the value is now checked to fit
in 16 bits.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/phy/rockchip/phy-rockchip-samsung-dcphy.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-samsung-dcphy.c b/drivers/phy/rockchip/phy-rockchip-samsung-dcphy.c
index 28a052e17366516d5a99988bec9a52e3f0f09101..4508a314727232473e90fd1649ec0f2829b65c49 100644
--- a/drivers/phy/rockchip/phy-rockchip-samsung-dcphy.c
+++ b/drivers/phy/rockchip/phy-rockchip-samsung-dcphy.c
@@ -8,6 +8,7 @@
 #include <dt-bindings/phy/phy.h>
 #include <linux/bitfield.h>
 #include <linux/clk.h>
+#include <linux/hw_bitfield.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/mfd/syscon.h>
@@ -20,12 +21,6 @@
 #include <linux/regmap.h>
 #include <linux/reset.h>
 
-#define FIELD_PREP_HIWORD(_mask, _val)		\
-	(					\
-		FIELD_PREP((_mask), (_val)) |	\
-		((_mask) << 16)			\
-	)
-
 #define BIAS_CON0		0x0000
 #define I_RES_CNTL_MASK		GENMASK(6, 4)
 #define I_RES_CNTL(x)		FIELD_PREP(I_RES_CNTL_MASK, x)
@@ -252,8 +247,8 @@
 
 /* MIPI_CDPHY_GRF registers */
 #define MIPI_DCPHY_GRF_CON0		0x0000
-#define S_CPHY_MODE			FIELD_PREP_HIWORD(BIT(3), 1)
-#define M_CPHY_MODE			FIELD_PREP_HIWORD(BIT(0), 1)
+#define S_CPHY_MODE			FIELD_PREP_WM16(BIT(3), 1)
+#define M_CPHY_MODE			FIELD_PREP_WM16(BIT(0), 1)
 
 enum hs_drv_res_ohm {
 	STRENGTH_30_OHM = 0x8,

-- 
2.51.0


