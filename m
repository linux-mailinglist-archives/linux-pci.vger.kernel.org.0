Return-Path: <linux-pci+bounces-30418-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDEECAE4A2D
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 18:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD67B7A8E20
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 16:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1180B2D3A68;
	Mon, 23 Jun 2025 16:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="D8/Ayvqf"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DEC29CB3E;
	Mon, 23 Jun 2025 16:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750694903; cv=pass; b=A6I+HNT/fULk/3fyRsfIL6IUapt9+RlK419RQHRMUGgDz8jZALv8zuCcDSqP2t+9Ljo5JrrFZdHXi/7tOMBUC3DJnr56NqdoRGy+qHHPdqa9xfiS/apNdip9gayKcNMn7EVkB6E+qXpcS/HtxlOOf0mqlKhlicsneOxmc5WALIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750694903; c=relaxed/simple;
	bh=BbSazg4DYd0tOuN0Ome+iWcDWhOV8KcWOExeMIqDwhg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kVWC3D4d9NF6qwrN2p22oSt99rMHmWnzBdEeCQu2KQUg4YI8pI4TrGkKjv6oXWs361F7Y9vcz7lmelDuAFPpzghmVo+hj4tV6h0IQUNopvTA9t9ErxUqUW+F10fY/93h/Ier0OsY4tqx908yC6bYDGmiquPoJGmDqmet3V1A8To=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=D8/Ayvqf; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1750694844; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=EIT8duZaEru2MmNFkH17+ln1IIP4IavbRzXbIiy2QiUh/d2aciJyS1Izh14Rz//qTiHKcVH+oTgOC6dgJQ6K2R57tDbCRYsBl26OMECKmDY7t5PqwBOObNcO/44mkdzZxSc9avn/J17ic0CiQh1oZ32vwlZ8S5cYGuSnf/OqsuI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1750694844; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=3vxzpmqQhtBTxrTmTd5Bzl/GtkmPJzUHuKrqn6sWqUs=; 
	b=hwxyil+U7MtLL/WuKplFKlR6zFJMyRYpOTPLNOQvC4wQ6M/QCNNxCb0wcag0xDeHTQQjar5h1i1R27DczszCZyNX6lFrddzwg6B8Inq2uMIaqJMlOuD6mH0jd5c/oFcjSm9rap3qAlSm49tklyWDwvhz1wY4TP01gl2XEaQF8hY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1750694844;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=3vxzpmqQhtBTxrTmTd5Bzl/GtkmPJzUHuKrqn6sWqUs=;
	b=D8/AyvqfleOxQ5u+HAmjai387RcB6u3Pe/Ngg0HiSeQZhBRYTWJmlKvFJiKYyLhg
	weGvQ2B+HxV6Gv5W6paN+Je7jognnkAHg5tn63e+gATBi+mMpPSy2rREt3ZgdWzSccR
	QzjdWw7RjN6RLCBO7LnbjjzqtoT3uQiLjx59TjUY=
Received: by mx.zohomail.com with SMTPS id 175069484197195.58532796051668;
	Mon, 23 Jun 2025 09:07:21 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Mon, 23 Jun 2025 18:05:35 +0200
Subject: [PATCH v2 07/20] drm/rockchip: dsi: switch to FIELD_PREP_WM16*
 macros
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250623-byeword-update-v2-7-cf1fc08a2e1f@collabora.com>
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

Remove this driver's HIWORD_UPDATE macro, and replace instances of it
with either FIELD_PREP_WM16 or FIELD_PREP_WM16_CONST, depending on
whether they're in an initializer. This gives us better error checking,
which already saved me some trouble during this refactor.

The driver's HIWORD_UPDATE macro doesn't shift up the value, but expects
a pre-shifted value. Meanwhile, FIELD_PREP_WM16 and
FIELD_PREP_WM16_CONST will shift the value for us, based on the given
mask. So a few things that used to be a HIWORD_UPDATE(VERY_LONG_FOO,
VERY_LONG_FOO) are now a somewhat more pleasant
FIELD_PREP_WM16(VERY_LONG_FOO, 1).

There are some non-trivial refactors here. A few literals needed a UL
suffix added to stop them from unintentionally overflowing as a signed
long. To make sure all of these cases are caught, and not just the ones
where the FIELD_PREP_WM16* macros use such a value as a mask, just mark
every literal that's used as a mask as unsigned.

Non-contiguous masks also have to be split into multiple
FIELD_PREP_WM16* instances, as the macro's checks and shifting logic
rely on contiguous masks.

This is compile-tested only.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c | 142 ++++++++++++------------
 1 file changed, 68 insertions(+), 74 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
index 3398160ad75e4a9629082bc47491eab473caecc0..5523911b990d93aa5b8a28acb8ffa01298c4a3b7 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/clk.h>
+#include <linux/hw_bitfield.h>
 #include <linux/iopoll.h>
 #include <linux/math64.h>
 #include <linux/mfd/syscon.h>
@@ -148,7 +149,7 @@
 #define DW_MIPI_NEEDS_GRF_CLK		BIT(1)
 
 #define PX30_GRF_PD_VO_CON1		0x0438
-#define PX30_DSI_FORCETXSTOPMODE	(0xf << 7)
+#define PX30_DSI_FORCETXSTOPMODE	(0xfUL << 7)
 #define PX30_DSI_FORCERXMODE		BIT(6)
 #define PX30_DSI_TURNDISABLE		BIT(5)
 #define PX30_DSI_LCDC_SEL		BIT(0)
@@ -167,16 +168,16 @@
 #define RK3399_DSI1_LCDC_SEL		BIT(4)
 
 #define RK3399_GRF_SOC_CON22		0x6258
-#define RK3399_DSI0_TURNREQUEST		(0xf << 12)
-#define RK3399_DSI0_TURNDISABLE		(0xf << 8)
-#define RK3399_DSI0_FORCETXSTOPMODE	(0xf << 4)
-#define RK3399_DSI0_FORCERXMODE		(0xf << 0)
+#define RK3399_DSI0_TURNREQUEST		(0xfUL << 12)
+#define RK3399_DSI0_TURNDISABLE		(0xfUL << 8)
+#define RK3399_DSI0_FORCETXSTOPMODE	(0xfUL << 4)
+#define RK3399_DSI0_FORCERXMODE		(0xfUL << 0)
 
 #define RK3399_GRF_SOC_CON23		0x625c
-#define RK3399_DSI1_TURNDISABLE		(0xf << 12)
-#define RK3399_DSI1_FORCETXSTOPMODE	(0xf << 8)
-#define RK3399_DSI1_FORCERXMODE		(0xf << 4)
-#define RK3399_DSI1_ENABLE		(0xf << 0)
+#define RK3399_DSI1_TURNDISABLE		(0xfUL << 12)
+#define RK3399_DSI1_FORCETXSTOPMODE	(0xfUL << 8)
+#define RK3399_DSI1_FORCERXMODE		(0xfUL << 4)
+#define RK3399_DSI1_ENABLE		(0xfUL << 0)
 
 #define RK3399_GRF_SOC_CON24		0x6260
 #define RK3399_TXRX_MASTERSLAVEZ	BIT(7)
@@ -186,8 +187,8 @@
 #define RK3399_TXRX_TURNREQUEST		GENMASK(3, 0)
 
 #define RK3568_GRF_VO_CON2		0x0368
-#define RK3568_DSI0_SKEWCALHS		(0x1f << 11)
-#define RK3568_DSI0_FORCETXSTOPMODE	(0xf << 4)
+#define RK3568_DSI0_SKEWCALHS		(0x1fUL << 11)
+#define RK3568_DSI0_FORCETXSTOPMODE	(0xfUL << 4)
 #define RK3568_DSI0_TURNDISABLE		BIT(2)
 #define RK3568_DSI0_FORCERXMODE		BIT(0)
 
@@ -197,18 +198,16 @@
  * come from. Name GRF_VO_CON3 is assumed.
  */
 #define RK3568_GRF_VO_CON3		0x36c
-#define RK3568_DSI1_SKEWCALHS		(0x1f << 11)
-#define RK3568_DSI1_FORCETXSTOPMODE	(0xf << 4)
+#define RK3568_DSI1_SKEWCALHS		(0x1fUL << 11)
+#define RK3568_DSI1_FORCETXSTOPMODE	(0xfUL << 4)
 #define RK3568_DSI1_TURNDISABLE		BIT(2)
 #define RK3568_DSI1_FORCERXMODE		BIT(0)
 
 #define RV1126_GRF_DSIPHY_CON		0x10220
-#define RV1126_DSI_FORCETXSTOPMODE	(0xf << 4)
+#define RV1126_DSI_FORCETXSTOPMODE	(0xfUL << 4)
 #define RV1126_DSI_TURNDISABLE		BIT(2)
 #define RV1126_DSI_FORCERXMODE		BIT(0)
 
-#define HIWORD_UPDATE(val, mask)	(val | (mask) << 16)
-
 enum {
 	DW_DSI_USAGE_IDLE,
 	DW_DSI_USAGE_DSI,
@@ -1484,14 +1483,13 @@ static const struct rockchip_dw_dsi_chip_data px30_chip_data[] = {
 	{
 		.reg = 0xff450000,
 		.lcdsel_grf_reg = PX30_GRF_PD_VO_CON1,
-		.lcdsel_big = HIWORD_UPDATE(0, PX30_DSI_LCDC_SEL),
-		.lcdsel_lit = HIWORD_UPDATE(PX30_DSI_LCDC_SEL,
-					    PX30_DSI_LCDC_SEL),
+		.lcdsel_big = FIELD_PREP_WM16_CONST(PX30_DSI_LCDC_SEL, 0),
+		.lcdsel_lit = FIELD_PREP_WM16_CONST(PX30_DSI_LCDC_SEL, 1),
 
 		.lanecfg1_grf_reg = PX30_GRF_PD_VO_CON1,
-		.lanecfg1 = HIWORD_UPDATE(0, PX30_DSI_TURNDISABLE |
-					     PX30_DSI_FORCERXMODE |
-					     PX30_DSI_FORCETXSTOPMODE),
+		.lanecfg1 = FIELD_PREP_WM16_CONST((PX30_DSI_TURNDISABLE |
+						PX30_DSI_FORCERXMODE |
+						PX30_DSI_FORCETXSTOPMODE), 0),
 
 		.max_data_lanes = 4,
 	},
@@ -1502,9 +1500,9 @@ static const struct rockchip_dw_dsi_chip_data rk3128_chip_data[] = {
 	{
 		.reg = 0x10110000,
 		.lanecfg1_grf_reg = RK3128_GRF_LVDS_CON0,
-		.lanecfg1 = HIWORD_UPDATE(0, RK3128_DSI_TURNDISABLE |
-					     RK3128_DSI_FORCERXMODE |
-					     RK3128_DSI_FORCETXSTOPMODE),
+		.lanecfg1 = FIELD_PREP_WM16_CONST((RK3128_DSI_TURNDISABLE |
+						RK3128_DSI_FORCERXMODE |
+						RK3128_DSI_FORCETXSTOPMODE), 0),
 		.max_data_lanes = 4,
 	},
 	{ /* sentinel */ }
@@ -1514,16 +1512,16 @@ static const struct rockchip_dw_dsi_chip_data rk3288_chip_data[] = {
 	{
 		.reg = 0xff960000,
 		.lcdsel_grf_reg = RK3288_GRF_SOC_CON6,
-		.lcdsel_big = HIWORD_UPDATE(0, RK3288_DSI0_LCDC_SEL),
-		.lcdsel_lit = HIWORD_UPDATE(RK3288_DSI0_LCDC_SEL, RK3288_DSI0_LCDC_SEL),
+		.lcdsel_big = FIELD_PREP_WM16_CONST(RK3288_DSI0_LCDC_SEL, 0),
+		.lcdsel_lit = FIELD_PREP_WM16_CONST(RK3288_DSI0_LCDC_SEL, 1),
 
 		.max_data_lanes = 4,
 	},
 	{
 		.reg = 0xff964000,
 		.lcdsel_grf_reg = RK3288_GRF_SOC_CON6,
-		.lcdsel_big = HIWORD_UPDATE(0, RK3288_DSI1_LCDC_SEL),
-		.lcdsel_lit = HIWORD_UPDATE(RK3288_DSI1_LCDC_SEL, RK3288_DSI1_LCDC_SEL),
+		.lcdsel_big = FIELD_PREP_WM16_CONST(RK3288_DSI1_LCDC_SEL, 0),
+		.lcdsel_lit = FIELD_PREP_WM16_CONST(RK3288_DSI1_LCDC_SEL, 1),
 
 		.max_data_lanes = 4,
 	},
@@ -1539,13 +1537,13 @@ static int rk3399_dphy_tx1rx1_init(struct phy *phy)
 	 * Assume ISP0 is supplied by the RX0 dphy.
 	 */
 	regmap_write(dsi->grf_regmap, RK3399_GRF_SOC_CON24,
-		     HIWORD_UPDATE(0, RK3399_TXRX_SRC_SEL_ISP0));
+		     FIELD_PREP_WM16(RK3399_TXRX_SRC_SEL_ISP0, 0));
 	regmap_write(dsi->grf_regmap, RK3399_GRF_SOC_CON24,
-		     HIWORD_UPDATE(0, RK3399_TXRX_MASTERSLAVEZ));
+		     FIELD_PREP_WM16(RK3399_TXRX_MASTERSLAVEZ, 0));
 	regmap_write(dsi->grf_regmap, RK3399_GRF_SOC_CON24,
-		     HIWORD_UPDATE(0, RK3399_TXRX_BASEDIR));
+		     FIELD_PREP_WM16(RK3399_TXRX_BASEDIR, 0));
 	regmap_write(dsi->grf_regmap, RK3399_GRF_SOC_CON23,
-		     HIWORD_UPDATE(0, RK3399_DSI1_ENABLE));
+		     FIELD_PREP_WM16(RK3399_DSI1_ENABLE, 0));
 
 	return 0;
 }
@@ -1559,21 +1557,20 @@ static int rk3399_dphy_tx1rx1_power_on(struct phy *phy)
 	usleep_range(100, 150);
 
 	regmap_write(dsi->grf_regmap, RK3399_GRF_SOC_CON24,
-		     HIWORD_UPDATE(0, RK3399_TXRX_MASTERSLAVEZ));
+		     FIELD_PREP_WM16(RK3399_TXRX_MASTERSLAVEZ, 0));
 	regmap_write(dsi->grf_regmap, RK3399_GRF_SOC_CON24,
-		     HIWORD_UPDATE(RK3399_TXRX_BASEDIR, RK3399_TXRX_BASEDIR));
+		     FIELD_PREP_WM16(RK3399_TXRX_BASEDIR, 1));
 
 	regmap_write(dsi->grf_regmap, RK3399_GRF_SOC_CON23,
-		     HIWORD_UPDATE(0, RK3399_DSI1_FORCERXMODE));
+		     FIELD_PREP_WM16(RK3399_DSI1_FORCERXMODE, 0));
 	regmap_write(dsi->grf_regmap, RK3399_GRF_SOC_CON23,
-		     HIWORD_UPDATE(0, RK3399_DSI1_FORCETXSTOPMODE));
+		     FIELD_PREP_WM16(RK3399_DSI1_FORCETXSTOPMODE, 0));
 
 	/* Disable lane turn around, which is ignored in receive mode */
 	regmap_write(dsi->grf_regmap, RK3399_GRF_SOC_CON24,
-		     HIWORD_UPDATE(0, RK3399_TXRX_TURNREQUEST));
+		     FIELD_PREP_WM16(RK3399_TXRX_TURNREQUEST, 0));
 	regmap_write(dsi->grf_regmap, RK3399_GRF_SOC_CON23,
-		     HIWORD_UPDATE(RK3399_DSI1_TURNDISABLE,
-				   RK3399_DSI1_TURNDISABLE));
+		     FIELD_PREP_WM16(RK3399_DSI1_TURNDISABLE, 0xf));
 	usleep_range(100, 150);
 
 	dsi_write(dsi, DSI_PHY_TST_CTRL0, PHY_TESTCLK | PHY_UNTESTCLR);
@@ -1581,8 +1578,8 @@ static int rk3399_dphy_tx1rx1_power_on(struct phy *phy)
 
 	/* Enable dphy lanes */
 	regmap_write(dsi->grf_regmap, RK3399_GRF_SOC_CON23,
-		     HIWORD_UPDATE(GENMASK(dsi->dphy_config.lanes - 1, 0),
-				   RK3399_DSI1_ENABLE));
+		     FIELD_PREP_WM16(RK3399_DSI1_ENABLE,
+				  GENMASK(dsi->dphy_config.lanes - 1, 0)));
 
 	usleep_range(100, 150);
 
@@ -1594,7 +1591,7 @@ static int rk3399_dphy_tx1rx1_power_off(struct phy *phy)
 	struct dw_mipi_dsi_rockchip *dsi = phy_get_drvdata(phy);
 
 	regmap_write(dsi->grf_regmap, RK3399_GRF_SOC_CON23,
-		     HIWORD_UPDATE(0, RK3399_DSI1_ENABLE));
+		     FIELD_PREP_WM16(RK3399_DSI1_ENABLE, 0));
 
 	return 0;
 }
@@ -1603,15 +1600,14 @@ static const struct rockchip_dw_dsi_chip_data rk3399_chip_data[] = {
 	{
 		.reg = 0xff960000,
 		.lcdsel_grf_reg = RK3399_GRF_SOC_CON20,
-		.lcdsel_big = HIWORD_UPDATE(0, RK3399_DSI0_LCDC_SEL),
-		.lcdsel_lit = HIWORD_UPDATE(RK3399_DSI0_LCDC_SEL,
-					    RK3399_DSI0_LCDC_SEL),
+		.lcdsel_big = FIELD_PREP_WM16_CONST(RK3399_DSI0_LCDC_SEL, 0),
+		.lcdsel_lit = FIELD_PREP_WM16_CONST(RK3399_DSI0_LCDC_SEL, 1),
 
 		.lanecfg1_grf_reg = RK3399_GRF_SOC_CON22,
-		.lanecfg1 = HIWORD_UPDATE(0, RK3399_DSI0_TURNREQUEST |
-					     RK3399_DSI0_TURNDISABLE |
-					     RK3399_DSI0_FORCETXSTOPMODE |
-					     RK3399_DSI0_FORCERXMODE),
+		.lanecfg1 = FIELD_PREP_WM16_CONST((RK3399_DSI0_TURNREQUEST |
+						RK3399_DSI0_TURNDISABLE |
+						RK3399_DSI0_FORCETXSTOPMODE |
+						RK3399_DSI0_FORCERXMODE), 0),
 
 		.flags = DW_MIPI_NEEDS_PHY_CFG_CLK | DW_MIPI_NEEDS_GRF_CLK,
 		.max_data_lanes = 4,
@@ -1619,25 +1615,23 @@ static const struct rockchip_dw_dsi_chip_data rk3399_chip_data[] = {
 	{
 		.reg = 0xff968000,
 		.lcdsel_grf_reg = RK3399_GRF_SOC_CON20,
-		.lcdsel_big = HIWORD_UPDATE(0, RK3399_DSI1_LCDC_SEL),
-		.lcdsel_lit = HIWORD_UPDATE(RK3399_DSI1_LCDC_SEL,
-					    RK3399_DSI1_LCDC_SEL),
+		.lcdsel_big = FIELD_PREP_WM16_CONST(RK3399_DSI1_LCDC_SEL, 0),
+		.lcdsel_lit = FIELD_PREP_WM16_CONST(RK3399_DSI1_LCDC_SEL, 1),
+
 
 		.lanecfg1_grf_reg = RK3399_GRF_SOC_CON23,
-		.lanecfg1 = HIWORD_UPDATE(0, RK3399_DSI1_TURNDISABLE |
-					     RK3399_DSI1_FORCETXSTOPMODE |
-					     RK3399_DSI1_FORCERXMODE |
-					     RK3399_DSI1_ENABLE),
+		.lanecfg1 = FIELD_PREP_WM16_CONST((RK3399_DSI1_TURNDISABLE |
+						RK3399_DSI1_FORCETXSTOPMODE |
+						RK3399_DSI1_FORCERXMODE |
+						RK3399_DSI1_ENABLE), 0),
 
 		.lanecfg2_grf_reg = RK3399_GRF_SOC_CON24,
-		.lanecfg2 = HIWORD_UPDATE(RK3399_TXRX_MASTERSLAVEZ |
-					  RK3399_TXRX_ENABLECLK,
-					  RK3399_TXRX_MASTERSLAVEZ |
-					  RK3399_TXRX_ENABLECLK |
-					  RK3399_TXRX_BASEDIR),
+		.lanecfg2 = (FIELD_PREP_WM16_CONST(RK3399_TXRX_MASTERSLAVEZ, 1) |
+			     FIELD_PREP_WM16_CONST(RK3399_TXRX_ENABLECLK, 1) |
+			     FIELD_PREP_WM16_CONST(RK3399_TXRX_BASEDIR, 0)),
 
 		.enable_grf_reg = RK3399_GRF_SOC_CON23,
-		.enable = HIWORD_UPDATE(RK3399_DSI1_ENABLE, RK3399_DSI1_ENABLE),
+		.enable = FIELD_PREP_WM16_CONST(RK3399_DSI1_ENABLE, RK3399_DSI1_ENABLE),
 
 		.flags = DW_MIPI_NEEDS_PHY_CFG_CLK | DW_MIPI_NEEDS_GRF_CLK,
 		.max_data_lanes = 4,
@@ -1653,19 +1647,19 @@ static const struct rockchip_dw_dsi_chip_data rk3568_chip_data[] = {
 	{
 		.reg = 0xfe060000,
 		.lanecfg1_grf_reg = RK3568_GRF_VO_CON2,
-		.lanecfg1 = HIWORD_UPDATE(0, RK3568_DSI0_SKEWCALHS |
-					  RK3568_DSI0_FORCETXSTOPMODE |
-					  RK3568_DSI0_TURNDISABLE |
-					  RK3568_DSI0_FORCERXMODE),
+		.lanecfg1 = (FIELD_PREP_WM16_CONST(RK3568_DSI0_SKEWCALHS, 0) |
+			     FIELD_PREP_WM16_CONST(RK3568_DSI0_FORCETXSTOPMODE, 0) |
+			     FIELD_PREP_WM16_CONST(RK3568_DSI0_TURNDISABLE, 0) |
+			     FIELD_PREP_WM16_CONST(RK3568_DSI0_FORCERXMODE, 0)),
 		.max_data_lanes = 4,
 	},
 	{
 		.reg = 0xfe070000,
 		.lanecfg1_grf_reg = RK3568_GRF_VO_CON3,
-		.lanecfg1 = HIWORD_UPDATE(0, RK3568_DSI1_SKEWCALHS |
-					  RK3568_DSI1_FORCETXSTOPMODE |
-					  RK3568_DSI1_TURNDISABLE |
-					  RK3568_DSI1_FORCERXMODE),
+		.lanecfg1 = (FIELD_PREP_WM16_CONST(RK3568_DSI1_SKEWCALHS, 0) |
+			     FIELD_PREP_WM16_CONST(RK3568_DSI1_FORCETXSTOPMODE, 0) |
+			     FIELD_PREP_WM16_CONST(RK3568_DSI1_TURNDISABLE, 0) |
+			     FIELD_PREP_WM16_CONST(RK3568_DSI1_FORCERXMODE, 0)),
 		.max_data_lanes = 4,
 	},
 	{ /* sentinel */ }
@@ -1675,9 +1669,9 @@ static const struct rockchip_dw_dsi_chip_data rv1126_chip_data[] = {
 	{
 		.reg = 0xffb30000,
 		.lanecfg1_grf_reg = RV1126_GRF_DSIPHY_CON,
-		.lanecfg1 = HIWORD_UPDATE(0, RV1126_DSI_TURNDISABLE |
-					     RV1126_DSI_FORCERXMODE |
-					     RV1126_DSI_FORCETXSTOPMODE),
+		.lanecfg1 = (FIELD_PREP_WM16_CONST(RV1126_DSI_TURNDISABLE, 0) |
+			     FIELD_PREP_WM16_CONST(RV1126_DSI_FORCERXMODE, 0) |
+			     FIELD_PREP_WM16_CONST(RV1126_DSI_FORCETXSTOPMODE, 0)),
 		.max_data_lanes = 4,
 	},
 	{ /* sentinel */ }

-- 
2.50.0


