Return-Path: <linux-pci+bounces-29586-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5E0AD7A76
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 21:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84E2B3B634F
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 19:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF35C2D6600;
	Thu, 12 Jun 2025 18:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="RBoRJFRn"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EB129B79A;
	Thu, 12 Jun 2025 18:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749754751; cv=pass; b=AhzT29RUxDMikuIZj0y+2X4gN4ZTumeYMgiOIpwczE9vjWpVy51oBcaqnGiKebHYAK+iSHsNVcbPLEdBR03zYC0xVAqRrruwvlyGRL/mM2nU7SMm9SF/GCtZ7vYrEaiRuU9JFJxSkooS8x9eNImsGO6JgMJTWXTdMrk8g/L9o5E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749754751; c=relaxed/simple;
	bh=tnUnk90pp3QKey5k+kPF8NGnwaz7YvzmV2BWpWxvsyw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=famTalns2uhjjvjyBG5swdHreoJ1oRS7IAIbWr33yR8Q63LRu0fDQdGsrTykNeFLnR9cdWPn/jO0+hR8i+/aMmVwVFDWVAEjVHNC5smdj9PeXzwcquTf09F6q54Rk7vBJGRBR2WFW+4TCZeBptp9TOLCsuG8o5J8hZvGy1hzyeM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=RBoRJFRn; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1749754691; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Xub9id8A5fahT1qtx3/w1Cektgfx3rmVwV3jnH8ohYrJQ4GsNx/UbMcopM7KTAReDpy2KaNYNQ76jeHozNZ2gHyRMusc3eTpEKdxt7Cl8yv2fU8B0R3ND4lpYUNP9KYJLnXo0Y5Ayd51YETPiNL3WHXwkBFIxulyHk0UD0L874c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1749754691; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=8sFO4peQX3UyFjqccrErI+0FBkCQqIYlQwxLluQFKf4=; 
	b=dG7ZIB5pNfgUS55BlIzzAeo3wYYhCBjGndbPswUh0T+ycPp4MUtit5zRmdagHupHvmYLLAVHauyL0/xqjvHJDwqe5No2jR47cBI0V+pCI427jIgNU8eIjP73bgOHdUDLTqHjt6aCA1QYKyNjipgG+U+XjiZn3C3raIY5S6v3FJ0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1749754691;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=8sFO4peQX3UyFjqccrErI+0FBkCQqIYlQwxLluQFKf4=;
	b=RBoRJFRnHB1HTtsjxAfcdfD5gTSEvGLYesnzDe5omP9mUbTxwE+yfzEgvyEo7eti
	bG89yPq6znBUEmOuf5ZbbpiMtFtDVeXgAbJKZuyubml1BGdStG/bUzgrdAiaf6wHk3K
	8CUiYhPXoj5/pupWJwRSohBXcMQLqCI+2V4ZvH8M=
Received: by mx.zohomail.com with SMTPS id 1749754689426649.8206090754111;
	Thu, 12 Jun 2025 11:58:09 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Thu, 12 Jun 2025 20:56:10 +0200
Subject: [PATCH 08/20] drm/rockchip: vop2: switch to HWORD_UPDATE macro
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250612-byeword-update-v1-8-f4afb8f6313f@collabora.com>
References: <20250612-byeword-update-v1-0-f4afb8f6313f@collabora.com>
In-Reply-To: <20250612-byeword-update-v1-0-f4afb8f6313f@collabora.com>
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

Remove VOP2's HIWORD_UPDATE macro from the vop2 header file, and replace
all instances in rockchip_vop2_reg.c (the only user of this particular
HIWORD_UPDATE definition) with equivalent HWORD_UPDATE instances. This
gives us better error checking.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.h |  1 -
 drivers/gpu/drm/rockchip/rockchip_vop2_reg.c | 14 ++++++++------
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h
index fc3ecb9fcd9576d20c0fdfa8df469dfbff6605da..757232de41f609917aca679c17623c80879f3593 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h
@@ -33,7 +33,6 @@
 #define WIN_FEATURE_AFBDC		BIT(0)
 #define WIN_FEATURE_CLUSTER		BIT(1)
 
-#define HIWORD_UPDATE(v, h, l)  ((GENMASK(h, l) << 16) | ((v) << (l)))
 /*
  *  the delay number of a window in different mode.
  */
diff --git a/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
index 32c4ed6857395a953bef8cd800b510fbdf7d9cec..ff1f3eabd1bc2cdb0b7b2aac2ca55ac9b7989d71 100644
--- a/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
+++ b/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
@@ -1695,8 +1695,9 @@ static unsigned long rk3588_set_intf_mux(struct vop2_video_port *vp, int id, u32
 		die |= RK3588_SYS_DSP_INFACE_EN_HDMI0 |
 			    FIELD_PREP(RK3588_SYS_DSP_INFACE_EN_EDP_HDMI0_MUX, vp->id);
 		val = rk3588_get_hdmi_pol(polflags);
-		regmap_write(vop2->vop_grf, RK3588_GRF_VOP_CON2, HIWORD_UPDATE(1, 1, 1));
-		regmap_write(vop2->vo1_grf, RK3588_GRF_VO1_CON0, HIWORD_UPDATE(val, 6, 5));
+		regmap_write(vop2->vop_grf, RK3588_GRF_VOP_CON2, HWORD_UPDATE(BIT(1), 1));
+		regmap_write(vop2->vo1_grf, RK3588_GRF_VO1_CON0,
+			     HWORD_UPDATE(GENMASK(6, 5), val));
 		break;
 	case ROCKCHIP_VOP2_EP_HDMI1:
 		div &= ~RK3588_DSP_IF_EDP_HDMI1_DCLK_DIV;
@@ -1707,8 +1708,9 @@ static unsigned long rk3588_set_intf_mux(struct vop2_video_port *vp, int id, u32
 		die |= RK3588_SYS_DSP_INFACE_EN_HDMI1 |
 			    FIELD_PREP(RK3588_SYS_DSP_INFACE_EN_EDP_HDMI1_MUX, vp->id);
 		val = rk3588_get_hdmi_pol(polflags);
-		regmap_write(vop2->vop_grf, RK3588_GRF_VOP_CON2, HIWORD_UPDATE(1, 4, 4));
-		regmap_write(vop2->vo1_grf, RK3588_GRF_VO1_CON0, HIWORD_UPDATE(val, 8, 7));
+		regmap_write(vop2->vop_grf, RK3588_GRF_VOP_CON2, HWORD_UPDATE(BIT(4), 1));
+		regmap_write(vop2->vo1_grf, RK3588_GRF_VO1_CON0,
+			     HWORD_UPDATE(GENMASK(8, 7), val));
 		break;
 	case ROCKCHIP_VOP2_EP_EDP0:
 		div &= ~RK3588_DSP_IF_EDP_HDMI0_DCLK_DIV;
@@ -1718,7 +1720,7 @@ static unsigned long rk3588_set_intf_mux(struct vop2_video_port *vp, int id, u32
 		die &= ~RK3588_SYS_DSP_INFACE_EN_EDP_HDMI0_MUX;
 		die |= RK3588_SYS_DSP_INFACE_EN_EDP0 |
 			   FIELD_PREP(RK3588_SYS_DSP_INFACE_EN_EDP_HDMI0_MUX, vp->id);
-		regmap_write(vop2->vop_grf, RK3588_GRF_VOP_CON2, HIWORD_UPDATE(1, 0, 0));
+		regmap_write(vop2->vop_grf, RK3588_GRF_VOP_CON2, HWORD_UPDATE(BIT(0), 1));
 		break;
 	case ROCKCHIP_VOP2_EP_EDP1:
 		div &= ~RK3588_DSP_IF_EDP_HDMI1_DCLK_DIV;
@@ -1728,7 +1730,7 @@ static unsigned long rk3588_set_intf_mux(struct vop2_video_port *vp, int id, u32
 		die &= ~RK3588_SYS_DSP_INFACE_EN_EDP_HDMI1_MUX;
 		die |= RK3588_SYS_DSP_INFACE_EN_EDP1 |
 			   FIELD_PREP(RK3588_SYS_DSP_INFACE_EN_EDP_HDMI1_MUX, vp->id);
-		regmap_write(vop2->vop_grf, RK3588_GRF_VOP_CON2, HIWORD_UPDATE(1, 3, 3));
+		regmap_write(vop2->vop_grf, RK3588_GRF_VOP_CON2, HWORD_UPDATE(BIT(3), 1));
 		break;
 	case ROCKCHIP_VOP2_EP_MIPI0:
 		div &= ~RK3588_DSP_IF_MIPI0_PCLK_DIV;

-- 
2.49.0


