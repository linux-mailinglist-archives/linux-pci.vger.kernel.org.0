Return-Path: <linux-pci+bounces-34643-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22FB2B33922
	for <lists+linux-pci@lfdr.de>; Mon, 25 Aug 2025 10:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2FF917BDA7
	for <lists+linux-pci@lfdr.de>; Mon, 25 Aug 2025 08:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F4429E112;
	Mon, 25 Aug 2025 08:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="cWmepJ5/"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1C123AB8B;
	Mon, 25 Aug 2025 08:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756110713; cv=pass; b=U+U9pXakhdUjdYa09FNcDRafcsMazvG3OUVSslE7Cw8mxxaJYWu+WXBTnwh3X5XeEESUQav5PF6JEsEPWQHinxWD6MgxV47xF7E13c658NEZr2TVKqzpuzUPeJr9VpDLyy5JI/tOtuXqm0uHLON4f9kP/cB4MX2f+gvq3qDmXts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756110713; c=relaxed/simple;
	bh=1QfSaKM8ECDVnke2dKM6Zoke25Fp/xA51LemwRgrn24=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kBQYlfCNlEUIBlOPOUOdRxpVPF8oWJu3AVXg8eKLhw5EXcmxJfqYUwTc2rhtrbPhc3nHLYy4Z7YOtmZ4mIyhGT497CKDjHDJcTDr3LMLGRU2h9nd0nTjQNJP85vxz2jy5eMqCJq+EU4KtmeLZedqhbYw+xAXTv9+AqmLBfv86nI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=cWmepJ5/; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1756110651; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=LLBZJNShM/scNbNd2FBGDgo/l8Vy6SGWp/z1oZFxe4pKUxxNm9W5Jsb3/QnmN6H0GxcDbNG0izhIDixr0s8yFI63AsdEFZHcE0WfetHT5IU7fLn7mtfCsGGIFzK9LlHdkWNEwQsFbUzt6T4zQvg/uC/1jhu3Cw7vwe5qAsGoO88=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756110651; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Km6AYdZ3WI+Rp52C1yBfbDSZEmIVJgexAgpXKrteI14=; 
	b=l7iCv194zYVQ20Y+MDFtkP5zVOvU6M8AwOMbev9sRh8kP67Q8qNUVdMgxrmpE5r6NF6zwrGX0j84/NFEdn1cgMIpj7Jd25nnePw8GkRdmJrWBpiWMSEKAK1uHEKFKtUIuOqnHIIfFlirLUOw+hhrKXaJJZ4rhwxMGsz4G4kaTxc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756110651;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=Km6AYdZ3WI+Rp52C1yBfbDSZEmIVJgexAgpXKrteI14=;
	b=cWmepJ5/uJCSY2WSAzlcCM8KbtvbvnNTdkH+4qBIhXTVRp2wD2f8gOaEufHUbi4K
	ruQLCt1bL/Y3M4kxOs6s7pD7aD5fdBSXrpCo1TT4sCIS0zyzc2HyuwaPDa+bb57k2zO
	UYqi/MqDwRusj5Rny9+wmJbm72pV4S/Jan2PVVGg=
Received: by mx.zohomail.com with SMTPS id 1756110648569933.3258387690506;
	Mon, 25 Aug 2025 01:30:48 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Mon, 25 Aug 2025 10:28:28 +0200
Subject: [PATCH v3 08/20] drm/rockchip: vop2: switch to FIELD_PREP_WM16
 macro
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250825-byeword-update-v3-8-947b841cdb29@collabora.com>
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
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
X-Mailer: b4 0.14.2

The era of hand-rolled HIWORD_UPDATE macros is over, at least for those
drivers that use constant masks.

Remove VOP2's HIWORD_UPDATE macro from the vop2 header file, and replace
all instances in rockchip_vop2_reg.c (the only user of this particular
HIWORD_UPDATE definition) with equivalent FIELD_PREP_WM16 instances. This
gives us better error checking.

Reviewed-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Tested-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.h |  1 -
 drivers/gpu/drm/rockchip/rockchip_vop2_reg.c | 15 +++++++++------
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h
index fa5c56f16047e3493e82fbedaced221459696dcc..9124191899baca764e4e362f86bbc2bb1f319577 100644
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
index 45c5e39878133163ee05c25a6a99004313f5ed19..38c49030c7ab6416c4af6b5c7be7b241e3c9db18 100644
--- a/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
+++ b/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
@@ -7,6 +7,7 @@
 #include <linux/bitfield.h>
 #include <linux/kernel.h>
 #include <linux/component.h>
+#include <linux/hw_bitfield.h>
 #include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include <linux/of.h>
@@ -1695,8 +1696,9 @@ static unsigned long rk3588_set_intf_mux(struct vop2_video_port *vp, int id, u32
 		die |= RK3588_SYS_DSP_INFACE_EN_HDMI0 |
 			    FIELD_PREP(RK3588_SYS_DSP_INFACE_EN_EDP_HDMI0_MUX, vp->id);
 		val = rk3588_get_hdmi_pol(polflags);
-		regmap_write(vop2->vop_grf, RK3588_GRF_VOP_CON2, HIWORD_UPDATE(1, 1, 1));
-		regmap_write(vop2->vo1_grf, RK3588_GRF_VO1_CON0, HIWORD_UPDATE(val, 6, 5));
+		regmap_write(vop2->vop_grf, RK3588_GRF_VOP_CON2, FIELD_PREP_WM16(BIT(1), 1));
+		regmap_write(vop2->vo1_grf, RK3588_GRF_VO1_CON0,
+			     FIELD_PREP_WM16(GENMASK(6, 5), val));
 		break;
 	case ROCKCHIP_VOP2_EP_HDMI1:
 		div &= ~RK3588_DSP_IF_EDP_HDMI1_DCLK_DIV;
@@ -1707,8 +1709,9 @@ static unsigned long rk3588_set_intf_mux(struct vop2_video_port *vp, int id, u32
 		die |= RK3588_SYS_DSP_INFACE_EN_HDMI1 |
 			    FIELD_PREP(RK3588_SYS_DSP_INFACE_EN_EDP_HDMI1_MUX, vp->id);
 		val = rk3588_get_hdmi_pol(polflags);
-		regmap_write(vop2->vop_grf, RK3588_GRF_VOP_CON2, HIWORD_UPDATE(1, 4, 4));
-		regmap_write(vop2->vo1_grf, RK3588_GRF_VO1_CON0, HIWORD_UPDATE(val, 8, 7));
+		regmap_write(vop2->vop_grf, RK3588_GRF_VOP_CON2, FIELD_PREP_WM16(BIT(4), 1));
+		regmap_write(vop2->vo1_grf, RK3588_GRF_VO1_CON0,
+			     FIELD_PREP_WM16(GENMASK(8, 7), val));
 		break;
 	case ROCKCHIP_VOP2_EP_EDP0:
 		div &= ~RK3588_DSP_IF_EDP_HDMI0_DCLK_DIV;
@@ -1718,7 +1721,7 @@ static unsigned long rk3588_set_intf_mux(struct vop2_video_port *vp, int id, u32
 		die &= ~RK3588_SYS_DSP_INFACE_EN_EDP_HDMI0_MUX;
 		die |= RK3588_SYS_DSP_INFACE_EN_EDP0 |
 			   FIELD_PREP(RK3588_SYS_DSP_INFACE_EN_EDP_HDMI0_MUX, vp->id);
-		regmap_write(vop2->vop_grf, RK3588_GRF_VOP_CON2, HIWORD_UPDATE(1, 0, 0));
+		regmap_write(vop2->vop_grf, RK3588_GRF_VOP_CON2, FIELD_PREP_WM16(BIT(0), 1));
 		break;
 	case ROCKCHIP_VOP2_EP_EDP1:
 		div &= ~RK3588_DSP_IF_EDP_HDMI1_DCLK_DIV;
@@ -1728,7 +1731,7 @@ static unsigned long rk3588_set_intf_mux(struct vop2_video_port *vp, int id, u32
 		die &= ~RK3588_SYS_DSP_INFACE_EN_EDP_HDMI1_MUX;
 		die |= RK3588_SYS_DSP_INFACE_EN_EDP1 |
 			   FIELD_PREP(RK3588_SYS_DSP_INFACE_EN_EDP_HDMI1_MUX, vp->id);
-		regmap_write(vop2->vop_grf, RK3588_GRF_VOP_CON2, HIWORD_UPDATE(1, 3, 3));
+		regmap_write(vop2->vop_grf, RK3588_GRF_VOP_CON2, FIELD_PREP_WM16(BIT(3), 1));
 		break;
 	case ROCKCHIP_VOP2_EP_MIPI0:
 		div &= ~RK3588_DSP_IF_MIPI0_PCLK_DIV;

-- 
2.51.0


