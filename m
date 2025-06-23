Return-Path: <linux-pci+bounces-30421-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A1B1AE4A57
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 18:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52A5C7AA0F3
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 16:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1812D2BCF66;
	Mon, 23 Jun 2025 16:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="hp+QnPNV"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2F828DEF0;
	Mon, 23 Jun 2025 16:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750694942; cv=pass; b=VEaDFErG0ccTOHc0/hHKfD8R+o/FX9yty97VV7rRU7HvzU/q7C8bF6KNWWHJYjFctGGbChzdLv/BgFN+nl5BM9ihPLnR0ashdnlOdO4bLX+mUOn3w8PRe2YfugRIUyyNq68hldZ4oCFgQ0kDXRBqiyZslo5LIfo3g+Z7ewddFDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750694942; c=relaxed/simple;
	bh=t5ZOgRW8UJsScp8lP+hK0SJ0A2+ZQlX/zXZWhFJX1A4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o8WM5/DKm62FU0nl+nCekMAubT5Oc/tXF7BuvVrVibqoArhOTXhm0WwopY8QYXj7Tp/ihxY8nmfprK2I6bK7UI/Qz3aFcefAFfm+98XFaJCNF3sLw0ISrLlhzqcUuAVCi2Uq6QTWdndfJGUowsTv/OCQ49W39olGOldH1WgM0bo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=hp+QnPNV; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1750694885; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=c2ZP7l3FOd36LaIlTr0F4oU7lBTpm9EaQIxYs6lpP5V7UiVjYV9dEsfs1USsQvZHBPoq1qqVFTBOEvvcKlZCQY6x6gpGvxs3vA/9ZOZKcix/UKC64udbCKDvQq8ciEA9BAgsH6LjVwYuk7+U+jasateiNkq5ScUt9qTwTwSNXq0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1750694885; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ui0dnkHbB/xS62P1xIYfc4CaEr3Ny8oiI8ueWyjyOHk=; 
	b=Ix3PxuPRh1pI1wQ7+QpM7PamcuH9zveTO59bQL4KHADEFrhkkPoRAvT1O7N48+U1Q+jU6cyDgm3xjHJfXqD9/Rh+qBZHkcNt7X8roT7FzKdzQztf18R3HAyjhzxjTYBFHbabMyDvU5PkVit0MZR6tUScb1fQ5V+RID/p1PIeRiM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1750694885;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=ui0dnkHbB/xS62P1xIYfc4CaEr3Ny8oiI8ueWyjyOHk=;
	b=hp+QnPNVjZSkUaZOhjHZdtv4de1JIjVQ6/uXuS731daWBsiuZhGXDxPQ+MkeyhhL
	bkWqT5fzi+k0sHRzlza4m88w+vvXUC+JrmR4mCxV9pa3Sb8LcrZUx+T3RpG86i93eld
	vONXnV1WmbRbcvgVlW17vVnE2+LckcNsr44TVm44=
Received: by mx.zohomail.com with SMTPS id 1750694882274858.3440412073652;
	Mon, 23 Jun 2025 09:08:02 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Mon, 23 Jun 2025 18:05:38 +0200
Subject: [PATCH v2 10/20] drm/rockchip: dw_hdmi_qp: switch to
 FIELD_PREP_WM16 macro
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250623-byeword-update-v2-10-cf1fc08a2e1f@collabora.com>
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
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
X-Mailer: b4 0.14.2

The era of hand-rolled HIWORD_UPDATE macros is over, at least for those
drivers that use constant masks.

Replace this driver's HIWORD_UPDATE with the FIELD_PREP_WM16 macro from
hw_bitfield.h. While at it, disambiguate the GRF write to SOC_CON7 by
splitting the definition into the individual bitflags. This is done
because FIELD_PREP_WM16 shifts the value for us according to the mask,
so writing the mask to itself to enable two bits is no longer something
that can be done. It should also not be done anyway because it hides the
true meaning of those two individual bit flags.

HDMI output with this patch has been tested on both RK3588 and RK3576.
On the former, with both present HDMI connectors.

Reviewed-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Tested-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c | 68 +++++++++++++-------------
 1 file changed, 33 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
index 7d531b6f4c098c6c548788dad487ce4613a2f32b..ed6e8f036f4b3d76425725c130394cedf039acd0 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
@@ -9,6 +9,7 @@
 
 #include <linux/clk.h>
 #include <linux/gpio/consumer.h>
+#include <linux/hw_bitfield.h>
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
@@ -66,7 +67,8 @@
 #define RK3588_HDMI1_HPD_INT_MSK	BIT(15)
 #define RK3588_HDMI1_HPD_INT_CLR	BIT(14)
 #define RK3588_GRF_SOC_CON7		0x031c
-#define RK3588_SET_HPD_PATH_MASK	GENMASK(13, 12)
+#define RK3588_HPD_HDMI0_IO_EN_MASK	BIT(12)
+#define RK3588_HPD_HDMI1_IO_EN_MASK	BIT(13)
 #define RK3588_GRF_SOC_STATUS1		0x0384
 #define RK3588_HDMI0_LEVEL_INT		BIT(16)
 #define RK3588_HDMI1_LEVEL_INT		BIT(24)
@@ -80,7 +82,6 @@
 #define RK3588_HDMI0_GRANT_SEL		BIT(10)
 #define RK3588_HDMI1_GRANT_SEL		BIT(12)
 
-#define HIWORD_UPDATE(val, mask)	((val) | (mask) << 16)
 #define HOTPLUG_DEBOUNCE_MS		150
 #define MAX_HDMI_PORT_NUM		2
 
@@ -185,11 +186,11 @@ static void dw_hdmi_qp_rk3588_setup_hpd(struct dw_hdmi_qp *dw_hdmi, void *data)
 	u32 val;
 
 	if (hdmi->port_id)
-		val = HIWORD_UPDATE(RK3588_HDMI1_HPD_INT_CLR,
-				    RK3588_HDMI1_HPD_INT_CLR | RK3588_HDMI1_HPD_INT_MSK);
+		val = (FIELD_PREP_WM16(RK3588_HDMI1_HPD_INT_CLR, 1) |
+		       FIELD_PREP_WM16(RK3588_HDMI1_HPD_INT_MSK, 0));
 	else
-		val = HIWORD_UPDATE(RK3588_HDMI0_HPD_INT_CLR,
-				    RK3588_HDMI0_HPD_INT_CLR | RK3588_HDMI0_HPD_INT_MSK);
+		val = (FIELD_PREP_WM16(RK3588_HDMI0_HPD_INT_CLR, 1) |
+		       FIELD_PREP_WM16(RK3588_HDMI0_HPD_INT_MSK, 0));
 
 	regmap_write(hdmi->regmap, RK3588_GRF_SOC_CON2, val);
 }
@@ -218,8 +219,8 @@ static void dw_hdmi_qp_rk3576_setup_hpd(struct dw_hdmi_qp *dw_hdmi, void *data)
 	struct rockchip_hdmi_qp *hdmi = (struct rockchip_hdmi_qp *)data;
 	u32 val;
 
-	val = HIWORD_UPDATE(RK3576_HDMI_HPD_INT_CLR,
-			    RK3576_HDMI_HPD_INT_CLR | RK3576_HDMI_HPD_INT_MSK);
+	val = (FIELD_PREP_WM16(RK3576_HDMI_HPD_INT_CLR, 1) |
+	       FIELD_PREP_WM16(RK3576_HDMI_HPD_INT_MSK, 0));
 
 	regmap_write(hdmi->regmap, RK3576_IOC_MISC_CON0, val);
 	regmap_write(hdmi->regmap, 0xa404, 0xffff0102);
@@ -254,7 +255,7 @@ static irqreturn_t dw_hdmi_qp_rk3576_hardirq(int irq, void *dev_id)
 
 	regmap_read(hdmi->regmap, RK3576_IOC_HDMI_HPD_STATUS, &intr_stat);
 	if (intr_stat) {
-		val = HIWORD_UPDATE(RK3576_HDMI_HPD_INT_MSK, RK3576_HDMI_HPD_INT_MSK);
+		val = FIELD_PREP_WM16(RK3576_HDMI_HPD_INT_MSK, 1);
 
 		regmap_write(hdmi->regmap, RK3576_IOC_MISC_CON0, val);
 		return IRQ_WAKE_THREAD;
@@ -273,12 +274,12 @@ static irqreturn_t dw_hdmi_qp_rk3576_irq(int irq, void *dev_id)
 	if (!intr_stat)
 		return IRQ_NONE;
 
-	val = HIWORD_UPDATE(RK3576_HDMI_HPD_INT_CLR, RK3576_HDMI_HPD_INT_CLR);
+	val = FIELD_PREP_WM16(RK3576_HDMI_HPD_INT_CLR, 1);
 	regmap_write(hdmi->regmap, RK3576_IOC_MISC_CON0, val);
 	mod_delayed_work(system_wq, &hdmi->hpd_work,
 			 msecs_to_jiffies(HOTPLUG_DEBOUNCE_MS));
 
-	val = HIWORD_UPDATE(0, RK3576_HDMI_HPD_INT_MSK);
+	val = FIELD_PREP_WM16(RK3576_HDMI_HPD_INT_MSK, 0);
 	regmap_write(hdmi->regmap, RK3576_IOC_MISC_CON0, val);
 
 	return IRQ_HANDLED;
@@ -293,11 +294,9 @@ static irqreturn_t dw_hdmi_qp_rk3588_hardirq(int irq, void *dev_id)
 
 	if (intr_stat) {
 		if (hdmi->port_id)
-			val = HIWORD_UPDATE(RK3588_HDMI1_HPD_INT_MSK,
-					    RK3588_HDMI1_HPD_INT_MSK);
+			val = FIELD_PREP_WM16(RK3588_HDMI1_HPD_INT_MSK, 1);
 		else
-			val = HIWORD_UPDATE(RK3588_HDMI0_HPD_INT_MSK,
-					    RK3588_HDMI0_HPD_INT_MSK);
+			val = FIELD_PREP_WM16(RK3588_HDMI0_HPD_INT_MSK, 1);
 		regmap_write(hdmi->regmap, RK3588_GRF_SOC_CON2, val);
 		return IRQ_WAKE_THREAD;
 	}
@@ -315,20 +314,18 @@ static irqreturn_t dw_hdmi_qp_rk3588_irq(int irq, void *dev_id)
 		return IRQ_NONE;
 
 	if (hdmi->port_id)
-		val = HIWORD_UPDATE(RK3588_HDMI1_HPD_INT_CLR,
-				    RK3588_HDMI1_HPD_INT_CLR);
+		val = FIELD_PREP_WM16(RK3588_HDMI1_HPD_INT_CLR, 1);
 	else
-		val = HIWORD_UPDATE(RK3588_HDMI0_HPD_INT_CLR,
-				    RK3588_HDMI0_HPD_INT_CLR);
+		val = FIELD_PREP_WM16(RK3588_HDMI0_HPD_INT_CLR, 1);
 	regmap_write(hdmi->regmap, RK3588_GRF_SOC_CON2, val);
 
 	mod_delayed_work(system_wq, &hdmi->hpd_work,
 			 msecs_to_jiffies(HOTPLUG_DEBOUNCE_MS));
 
 	if (hdmi->port_id)
-		val |= HIWORD_UPDATE(0, RK3588_HDMI1_HPD_INT_MSK);
+		val |= FIELD_PREP_WM16(RK3588_HDMI1_HPD_INT_MSK, 0);
 	else
-		val |= HIWORD_UPDATE(0, RK3588_HDMI0_HPD_INT_MSK);
+		val |= FIELD_PREP_WM16(RK3588_HDMI0_HPD_INT_MSK, 0);
 	regmap_write(hdmi->regmap, RK3588_GRF_SOC_CON2, val);
 
 	return IRQ_HANDLED;
@@ -338,14 +335,14 @@ static void dw_hdmi_qp_rk3576_io_init(struct rockchip_hdmi_qp *hdmi)
 {
 	u32 val;
 
-	val = HIWORD_UPDATE(RK3576_SCLIN_MASK, RK3576_SCLIN_MASK) |
-	      HIWORD_UPDATE(RK3576_SDAIN_MASK, RK3576_SDAIN_MASK) |
-	      HIWORD_UPDATE(RK3576_HDMI_GRANT_SEL, RK3576_HDMI_GRANT_SEL) |
-	      HIWORD_UPDATE(RK3576_I2S_SEL_MASK, RK3576_I2S_SEL_MASK);
+	val = FIELD_PREP_WM16(RK3576_SCLIN_MASK, 1) |
+	      FIELD_PREP_WM16(RK3576_SDAIN_MASK, 1) |
+	      FIELD_PREP_WM16(RK3576_HDMI_GRANT_SEL, 1) |
+	      FIELD_PREP_WM16(RK3576_I2S_SEL_MASK, 1);
 
 	regmap_write(hdmi->vo_regmap, RK3576_VO0_GRF_SOC_CON14, val);
 
-	val = HIWORD_UPDATE(0, RK3576_HDMI_HPD_INT_MSK);
+	val = FIELD_PREP_WM16(RK3576_HDMI_HPD_INT_MSK, 0);
 	regmap_write(hdmi->regmap, RK3576_IOC_MISC_CON0, val);
 }
 
@@ -353,27 +350,28 @@ static void dw_hdmi_qp_rk3588_io_init(struct rockchip_hdmi_qp *hdmi)
 {
 	u32 val;
 
-	val = HIWORD_UPDATE(RK3588_SCLIN_MASK, RK3588_SCLIN_MASK) |
-	      HIWORD_UPDATE(RK3588_SDAIN_MASK, RK3588_SDAIN_MASK) |
-	      HIWORD_UPDATE(RK3588_MODE_MASK, RK3588_MODE_MASK) |
-	      HIWORD_UPDATE(RK3588_I2S_SEL_MASK, RK3588_I2S_SEL_MASK);
+	val = FIELD_PREP_WM16(RK3588_SCLIN_MASK, 1) |
+	      FIELD_PREP_WM16(RK3588_SDAIN_MASK, 1) |
+	      FIELD_PREP_WM16(RK3588_MODE_MASK, 1) |
+	      FIELD_PREP_WM16(RK3588_I2S_SEL_MASK, 1);
 	regmap_write(hdmi->vo_regmap,
 		     hdmi->port_id ? RK3588_GRF_VO1_CON6 : RK3588_GRF_VO1_CON3,
 		     val);
 
-	val = HIWORD_UPDATE(RK3588_SET_HPD_PATH_MASK, RK3588_SET_HPD_PATH_MASK);
+	val = FIELD_PREP_WM16(RK3588_HPD_HDMI0_IO_EN_MASK, 1) |
+	      FIELD_PREP_WM16(RK3588_HPD_HDMI1_IO_EN_MASK, 1);
 	regmap_write(hdmi->regmap, RK3588_GRF_SOC_CON7, val);
 
 	if (hdmi->port_id)
-		val = HIWORD_UPDATE(RK3588_HDMI1_GRANT_SEL, RK3588_HDMI1_GRANT_SEL);
+		val = FIELD_PREP_WM16(RK3588_HDMI1_GRANT_SEL, 1);
 	else
-		val = HIWORD_UPDATE(RK3588_HDMI0_GRANT_SEL, RK3588_HDMI0_GRANT_SEL);
+		val = FIELD_PREP_WM16(RK3588_HDMI0_GRANT_SEL, 1);
 	regmap_write(hdmi->vo_regmap, RK3588_GRF_VO1_CON9, val);
 
 	if (hdmi->port_id)
-		val = HIWORD_UPDATE(RK3588_HDMI1_HPD_INT_MSK, RK3588_HDMI1_HPD_INT_MSK);
+		val = FIELD_PREP_WM16(RK3588_HDMI1_HPD_INT_MSK, 1);
 	else
-		val = HIWORD_UPDATE(RK3588_HDMI0_HPD_INT_MSK, RK3588_HDMI0_HPD_INT_MSK);
+		val = FIELD_PREP_WM16(RK3588_HDMI0_HPD_INT_MSK, 1);
 	regmap_write(hdmi->regmap, RK3588_GRF_SOC_CON2, val);
 }
 

-- 
2.50.0


