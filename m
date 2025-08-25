Return-Path: <linux-pci+bounces-34640-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7100B33906
	for <lists+linux-pci@lfdr.de>; Mon, 25 Aug 2025 10:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25B211690E2
	for <lists+linux-pci@lfdr.de>; Mon, 25 Aug 2025 08:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9492BD5AE;
	Mon, 25 Aug 2025 08:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="KpIwqbhX"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDB62BD034;
	Mon, 25 Aug 2025 08:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756110669; cv=pass; b=e3YmDugiQqMcRwSr0a+yQYokLdspYWRGuOJS4Pl42L8H6QRz7FuSald6o5BfMdLm11ywP6LtlYT4Uxxs0liG2UnEykOpoUWFPsawOmL5GftFdYNGVAXq1pIqiAnzkrY8mfrkzIgxbkT11hF/BFxB58gmkxDShDqtLFC5IH2LD6s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756110669; c=relaxed/simple;
	bh=eZXHmzsJueF/HW/2OiAOW7uXOvJbDUI0JMcw76IMG2w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C6Dt7KZ1POzZ1UD0fJqeHLNkKvSOhMVSY3rENMbfsSfIhjI9THg5hDpAk4Rs4yFfJuSYD3IFnKzRqGgV05Mg24EuMvtIheHaUq559AD7mzBgtpZZ6ZfAT3HmcSaUTn3z/3kmdT9M3qf43Yu+fG5VtCgQh1kwtI2wdpWB6BsIcwM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=KpIwqbhX; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1756110607; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=TLxFwVaj8qb9aW7PFlve2R3k7DbTCYp0G3jrqLIP+6Bu0sjpec21DPDTyrjr1ae/bdEXabrGJVdglsxy+VwsVk1+rX6p9zG+aplowR510MkL9LjnuKCxoxSDCQd5pxxJMI2WEVILq61nCfilafL3wmL50EFdL5OSSCV4s822igs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756110607; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=E47wu1vDL9BRcTRXWq1Zz9FjP+DJiulR/q1Em8Nuy6M=; 
	b=IeQF64QrqFpHh3NU5pdCrE216xXzNaqjCaWp/Q0kkutqj5dDDYTdxeQ1blM+q+fK0WrP291EDPGml8JjlUzy0J1W8CHSUTo8AiFQYOaPsH/+EPZcSjPsJLiAPzctnyeHoprYvVNydewrGapyHSVoviGQI8UI7WLVh75A3/X7bgQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756110607;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=E47wu1vDL9BRcTRXWq1Zz9FjP+DJiulR/q1Em8Nuy6M=;
	b=KpIwqbhXsPhJ0znCsONc9W1haxDMB6pyNH9F+3z4b8t0Jj3zU8m42TuSCH1nE9kz
	tGWf/Lfw2skU8kl+Yfxo78DhtJNap5Vd4oZd6xHQRchWp6j3iW6MvdtZ1Ke5ZqPeHvS
	enZ6uxG41QQ1AO4G4MewWDad80UzjXVuN7Gj77KA=
Received: by mx.zohomail.com with SMTPS id 17561106058831017.1383627599512;
	Mon, 25 Aug 2025 01:30:05 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Mon, 25 Aug 2025 10:28:25 +0200
Subject: [PATCH v3 05/20] drm/rockchip: lvds: switch to FIELD_PREP_WM16
 macro
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250825-byeword-update-v3-5-947b841cdb29@collabora.com>
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

Remove rockchip_lvds.h's own HIWORD_UPDATE macro, and replace all
instances of it with hw_bitfield.h's FIELD_PREP_WM16 macro, which gives
us more error checking.

For the slightly-less-trivial case of the 2-bit width instance, the
results were checked during development to match all possible input
values (0 to 3, inclusive).

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/gpu/drm/rockchip/rockchip_lvds.h | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_lvds.h b/drivers/gpu/drm/rockchip/rockchip_lvds.h
index ca83d7b6bea733588849d3ff379cf8540405462b..2d92447d819bed18adc99f84664c93c639c86a19 100644
--- a/drivers/gpu/drm/rockchip/rockchip_lvds.h
+++ b/drivers/gpu/drm/rockchip/rockchip_lvds.h
@@ -9,6 +9,9 @@
 #ifndef _ROCKCHIP_LVDS_
 #define _ROCKCHIP_LVDS_
 
+#include <linux/bits.h>
+#include <linux/hw_bitfield.h>
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
+#define   PX30_LVDS_TIE_CLKS(val)		FIELD_PREP_WM16(BIT(8), (val))
+#define   PX30_LVDS_INVERT_CLKS(val)		FIELD_PREP_WM16(BIT(9), (val))
+#define   PX30_LVDS_INVERT_DCLK(val)		FIELD_PREP_WM16(BIT(5), (val))
 
 #define PX30_LVDS_GRF_PD_VO_CON1		0x438
-#define   PX30_LVDS_FORMAT(val)			HIWORD_UPDATE(val, 14, 13)
-#define   PX30_LVDS_MODE_EN(val)		HIWORD_UPDATE(val, 12, 12)
-#define   PX30_LVDS_MSBSEL(val)			HIWORD_UPDATE(val, 11, 11)
-#define   PX30_LVDS_P2S_EN(val)			HIWORD_UPDATE(val,  6,  6)
-#define   PX30_LVDS_VOP_SEL(val)		HIWORD_UPDATE(val,  1,  1)
+#define   PX30_LVDS_FORMAT(val)			FIELD_PREP_WM16(GENMASK(14, 13), (val))
+#define   PX30_LVDS_MODE_EN(val)		FIELD_PREP_WM16(BIT(12), (val))
+#define   PX30_LVDS_MSBSEL(val)			FIELD_PREP_WM16(BIT(11), (val))
+#define   PX30_LVDS_P2S_EN(val)			FIELD_PREP_WM16(BIT(6), (val))
+#define   PX30_LVDS_VOP_SEL(val)		FIELD_PREP_WM16(BIT(1), (val))
 
 #endif /* _ROCKCHIP_LVDS_ */

-- 
2.51.0


