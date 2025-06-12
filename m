Return-Path: <linux-pci+bounces-29583-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC70AAD7A56
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 21:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F29D17BFFB
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 19:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9419A2D3A8A;
	Thu, 12 Jun 2025 18:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="WAK+vIz2"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6208A2D3A85;
	Thu, 12 Jun 2025 18:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749754711; cv=pass; b=csy73prWz8rcePIOtVNW6XXGJ9fhwt9I8XNuRCu+ho4gP+Ox80h4Q3BnwXwYqQGg5VWfT1seoP6wNeiVrO9CXH5MEEI2HOSAvA+LYhbZDk246otFdeTz0n7mqKSton/wm+HadIXMKXluNLVVYaCxeJWa/u547bCU+0BauSUKIOc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749754711; c=relaxed/simple;
	bh=1xGQaP8sRYLlTJBVgLlNPF1sR80QN9vqA4mmdj5PaUM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lUw/caAnhHRb08cZr1HhnZLa8M5w3xw9TgIkiZx19e11QzAXFOgY+Ugw6UuadzE9BeuE+Dh+oITixI7HEv2wNiZTbHI1HJ9uEz3Xm0fG4ZAH1tgOuVdy3uLBQOr4l4mT6jF0Jr+Zic4hSxuCciyXCYZTmqG+ayRYOMvnvq9ZwOU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=WAK+vIz2; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1749754651; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=UEyFt0My6Tx57VlsVbAn+L/PzxHg0V1PVWp+0Z6S/LOPyFbP001POGENLGKzpfV1qwLIwkwh0iQQHr4u0waniFL7zjoiP2HTDvf0WRRc1x0gwqdwOKRPvGZ4F3SLj0tjLmq+5V5Qvj+l8WBkfKgMbeyiMhzQpVH70j/1y5uq+C8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1749754651; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=w61WQ83ZUwib69um1YfaUCr6dLg3DGxUyrk3WxNVqeo=; 
	b=broGtzCUfi5qaijw+A8UWX3vRc7GmFasZzqHbXFoPWkCswDJaCKgF0wrI7B8s0xW0k6g5EzcO06mrp1SUnx17q7RpgN0DGAz02RkVyGij2+88XPmmKa9T7r44M7yu2x/Cv/jsQlzAOTidFj/VI0c1LdsTgUKj/jtCqKx7GdzQpw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1749754651;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=w61WQ83ZUwib69um1YfaUCr6dLg3DGxUyrk3WxNVqeo=;
	b=WAK+vIz29CcEtw89zxcFchzJLHGQXcd15BwTiGlmKu/9+nnkbNxL3/CC3Z+7wYHk
	88C9/MQArtuBJCDDRHB3eQFukXNDGC9aKn3Ow8SBJxhcFT0eX0pGkSEeyXOLkVKtQQI
	MZuPIC4cTtR/OTq0lp7jRVstuw7kje6cnAQZP3uY=
Received: by mx.zohomail.com with SMTPS id 1749754649558158.1279376244986;
	Thu, 12 Jun 2025 11:57:29 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Thu, 12 Jun 2025 20:56:07 +0200
Subject: [PATCH 05/20] drm/rockchip: lvds: switch to HWORD_UPDATE macro
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250612-byeword-update-v1-5-f4afb8f6313f@collabora.com>
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

Remove rockchip_lvds.h's own HIWORD_UPDATE macro, and replace all
instances of it with bitfield.h's HWORD_UPDATE macro, which gives us
more error checking.

For the slightly-less-trivial case of the 2-bit width instance, the
results were checked during development to match all possible input
values (0 to 3, inclusive).

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/gpu/drm/rockchip/rockchip_lvds.h | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_lvds.h b/drivers/gpu/drm/rockchip/rockchip_lvds.h
index ca83d7b6bea733588849d3ff379cf8540405462b..568fe8d7918586581a461493d57d7b95f4c9eebc 100644
--- a/drivers/gpu/drm/rockchip/rockchip_lvds.h
+++ b/drivers/gpu/drm/rockchip/rockchip_lvds.h
@@ -9,6 +9,9 @@
 #ifndef _ROCKCHIP_LVDS_
 #define _ROCKCHIP_LVDS_
 
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+
 #define RK3288_LVDS_CH0_REG0			0x00
 #define RK3288_LVDS_CH0_REG0_LVDS_EN		BIT(7)
 #define RK3288_LVDS_CH0_REG0_TTL_EN		BIT(6)
@@ -106,18 +109,16 @@
 #define LVDS_VESA_18				2
 #define LVDS_JEIDA_18				3
 
-#define HIWORD_UPDATE(v, h, l)  ((GENMASK(h, l) << 16) | ((v) << (l)))
-
 #define PX30_LVDS_GRF_PD_VO_CON0		0x434
-#define   PX30_LVDS_TIE_CLKS(val)		HIWORD_UPDATE(val,  8,  8)
-#define   PX30_LVDS_INVERT_CLKS(val)		HIWORD_UPDATE(val,  9,  9)
-#define   PX30_LVDS_INVERT_DCLK(val)		HIWORD_UPDATE(val,  5,  5)
+#define   PX30_LVDS_TIE_CLKS(val)		HWORD_UPDATE(BIT(8), (val))
+#define   PX30_LVDS_INVERT_CLKS(val)		HWORD_UPDATE(BIT(9), (val))
+#define   PX30_LVDS_INVERT_DCLK(val)		HWORD_UPDATE(BIT(5), (val))
 
 #define PX30_LVDS_GRF_PD_VO_CON1		0x438
-#define   PX30_LVDS_FORMAT(val)			HIWORD_UPDATE(val, 14, 13)
-#define   PX30_LVDS_MODE_EN(val)		HIWORD_UPDATE(val, 12, 12)
-#define   PX30_LVDS_MSBSEL(val)			HIWORD_UPDATE(val, 11, 11)
-#define   PX30_LVDS_P2S_EN(val)			HIWORD_UPDATE(val,  6,  6)
-#define   PX30_LVDS_VOP_SEL(val)		HIWORD_UPDATE(val,  1,  1)
+#define   PX30_LVDS_FORMAT(val)			HWORD_UPDATE(GENMASK(14, 13), (val))
+#define   PX30_LVDS_MODE_EN(val)		HWORD_UPDATE(BIT(12), (val))
+#define   PX30_LVDS_MSBSEL(val)			HWORD_UPDATE(BIT(11), (val))
+#define   PX30_LVDS_P2S_EN(val)			HWORD_UPDATE(BIT(6), (val))
+#define   PX30_LVDS_VOP_SEL(val)		HWORD_UPDATE(BIT(1), (val))
 
 #endif /* _ROCKCHIP_LVDS_ */

-- 
2.49.0


