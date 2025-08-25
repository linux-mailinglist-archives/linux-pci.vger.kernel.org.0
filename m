Return-Path: <linux-pci+bounces-34638-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A28B338E6
	for <lists+linux-pci@lfdr.de>; Mon, 25 Aug 2025 10:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 069561B232EE
	for <lists+linux-pci@lfdr.de>; Mon, 25 Aug 2025 08:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A93D29CB3C;
	Mon, 25 Aug 2025 08:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="kXag4U9R"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369991DE4CE;
	Mon, 25 Aug 2025 08:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756110641; cv=pass; b=NFueORplINv+nGvaK5apQptjxIu2df6lX/zS1oP8I4FV9xZLuuOvxZV2jHrsZJCvT+ZIkPZPHw6XsHbfU1uJy+xNI2ZI8oO7glXs69MQjKoFectBVXjX0gvRS1zmXV1HvGyS77byRaFy34E8cy7//cTSEppulA39AFl1TJ/mQh8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756110641; c=relaxed/simple;
	bh=BPwIwL6/C9s3GmYgywgfyCHsQRm3sRNDP8jrAC4xt60=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JIU+DbZhHFnMVxg2yGzrZbcuJb72khqfE8Zj+Cxym39K9cSokgPDncrvsH+WLOLA3iUIrN9rwQwVD05U8Pv1QScZVDy1sAcoD3NicFosUePoeUI8stJdQFVgWNzcstRTNkcdkX2FyGMiMHs0MhKIjRI3SisYeTj0hTxSICUxuvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=kXag4U9R; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1756110578; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=A7TdFi310I+eOSFN1WzvyMr9oryEC4Uqn+d+DRtfPl2sGifQrOl+q2fWjaPDWhTEilR/V+vUeN1wd1mRfGKrUduRvpX9je7AdxgBxqnTJNrzK3eB0Fffh87O4ueDIxyqFPSFdLeBezZiWOAYOEF3886l7FKvE1NpBwms9L0hTjk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756110578; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=PKR7mESpgMV/NfGr0ewpCIqUeLo4rrbrxSGN542lvi4=; 
	b=Mggy3P5XUBlS79rWknqbd4ZeDPqLKcp95UBZ5RPMEmJdt2CmYTTp6yr4+6M9+yfttLs9fA+Y/39jK12MNoU8u2AyFBVIz2wGxdIeLLsOc1Lbf44oiatjtpUAlvUXrqwt6f2bEMmpOf6LHcrCOL1Gh3eeAoPm8zUFflXSvGPopb4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756110578;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=PKR7mESpgMV/NfGr0ewpCIqUeLo4rrbrxSGN542lvi4=;
	b=kXag4U9RZtp9QkCG7BE+ufhfDTDVm4nDg2RYtT248r/2Gu8OwcI1J+Nh/VKUew62
	qnTZg1KqADIVhFXvY/0vr604J+HPrvOXpG39G5I5eENuYn/bawhQYJyIHuauxM3Iqea
	xRbRIbtr4k9zSJrjcbqhFnByDUYhZ1OY7miOLgjE=
Received: by mx.zohomail.com with SMTPS id 1756110574075762.8618829218951;
	Mon, 25 Aug 2025 01:29:34 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Mon, 25 Aug 2025 10:28:23 +0200
Subject: [PATCH v3 03/20] soc: rockchip: grf: switch to
 FIELD_PREP_WM16_CONST macro
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250825-byeword-update-v3-3-947b841cdb29@collabora.com>
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

Switch the rockchip grf driver to the FIELD_PREP_WM16_CONST macro, which
brings with it more error checking while still being able to be used in
initializers.

All HIWORD_UPDATE instances and its definition are removed from the
driver, as the conversion here is obvious, and static_asserts were used
during development to make sure the ones greater than one bit in width
were really equivalent.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/soc/rockchip/grf.c | 35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/drivers/soc/rockchip/grf.c b/drivers/soc/rockchip/grf.c
index 1eab4bb0eacffe19a8f0af0b71bdaa5c0b506629..344870da7675fcde38ef1d7d9dcf243fcb9711e4 100644
--- a/drivers/soc/rockchip/grf.c
+++ b/drivers/soc/rockchip/grf.c
@@ -6,13 +6,12 @@
  */
 
 #include <linux/err.h>
+#include <linux/hw_bitfield.h>
 #include <linux/mfd/syscon.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 
-#define HIWORD_UPDATE(val, mask, shift) \
-		((val) << (shift) | (mask) << ((shift) + 16))
 
 struct rockchip_grf_value {
 	const char *desc;
@@ -32,7 +31,7 @@ static const struct rockchip_grf_value rk3036_defaults[] __initconst = {
 	 * Disable auto jtag/sdmmc switching that causes issues with the
 	 * clock-framework and the mmc controllers making them unreliable.
 	 */
-	{ "jtag switching", RK3036_GRF_SOC_CON0, HIWORD_UPDATE(0, 1, 11) },
+	{ "jtag switching", RK3036_GRF_SOC_CON0, FIELD_PREP_WM16_CONST(BIT(11), 0) },
 };
 
 static const struct rockchip_grf_info rk3036_grf __initconst = {
@@ -44,8 +43,8 @@ static const struct rockchip_grf_info rk3036_grf __initconst = {
 #define RK3128_GRF_SOC_CON1		0x144
 
 static const struct rockchip_grf_value rk3128_defaults[] __initconst = {
-	{ "jtag switching", RK3128_GRF_SOC_CON0, HIWORD_UPDATE(0, 1, 8) },
-	{ "vpu main clock", RK3128_GRF_SOC_CON1, HIWORD_UPDATE(0, 1, 10) },
+	{ "jtag switching", RK3128_GRF_SOC_CON0, FIELD_PREP_WM16_CONST(BIT(8), 0) },
+	{ "vpu main clock", RK3128_GRF_SOC_CON1, FIELD_PREP_WM16_CONST(BIT(10), 0) },
 };
 
 static const struct rockchip_grf_info rk3128_grf __initconst = {
@@ -56,7 +55,7 @@ static const struct rockchip_grf_info rk3128_grf __initconst = {
 #define RK3228_GRF_SOC_CON6		0x418
 
 static const struct rockchip_grf_value rk3228_defaults[] __initconst = {
-	{ "jtag switching", RK3228_GRF_SOC_CON6, HIWORD_UPDATE(0, 1, 8) },
+	{ "jtag switching", RK3228_GRF_SOC_CON6, FIELD_PREP_WM16_CONST(BIT(8), 0) },
 };
 
 static const struct rockchip_grf_info rk3228_grf __initconst = {
@@ -68,8 +67,8 @@ static const struct rockchip_grf_info rk3228_grf __initconst = {
 #define RK3288_GRF_SOC_CON2		0x24c
 
 static const struct rockchip_grf_value rk3288_defaults[] __initconst = {
-	{ "jtag switching", RK3288_GRF_SOC_CON0, HIWORD_UPDATE(0, 1, 12) },
-	{ "pwm select", RK3288_GRF_SOC_CON2, HIWORD_UPDATE(1, 1, 0) },
+	{ "jtag switching", RK3288_GRF_SOC_CON0, FIELD_PREP_WM16_CONST(BIT(12), 0) },
+	{ "pwm select", RK3288_GRF_SOC_CON2, FIELD_PREP_WM16_CONST(BIT(0), 1) },
 };
 
 static const struct rockchip_grf_info rk3288_grf __initconst = {
@@ -80,7 +79,7 @@ static const struct rockchip_grf_info rk3288_grf __initconst = {
 #define RK3328_GRF_SOC_CON4		0x410
 
 static const struct rockchip_grf_value rk3328_defaults[] __initconst = {
-	{ "jtag switching", RK3328_GRF_SOC_CON4, HIWORD_UPDATE(0, 1, 12) },
+	{ "jtag switching", RK3328_GRF_SOC_CON4, FIELD_PREP_WM16_CONST(BIT(12), 0) },
 };
 
 static const struct rockchip_grf_info rk3328_grf __initconst = {
@@ -91,7 +90,7 @@ static const struct rockchip_grf_info rk3328_grf __initconst = {
 #define RK3368_GRF_SOC_CON15		0x43c
 
 static const struct rockchip_grf_value rk3368_defaults[] __initconst = {
-	{ "jtag switching", RK3368_GRF_SOC_CON15, HIWORD_UPDATE(0, 1, 13) },
+	{ "jtag switching", RK3368_GRF_SOC_CON15, FIELD_PREP_WM16_CONST(BIT(13), 0) },
 };
 
 static const struct rockchip_grf_info rk3368_grf __initconst = {
@@ -102,7 +101,7 @@ static const struct rockchip_grf_info rk3368_grf __initconst = {
 #define RK3399_GRF_SOC_CON7		0xe21c
 
 static const struct rockchip_grf_value rk3399_defaults[] __initconst = {
-	{ "jtag switching", RK3399_GRF_SOC_CON7, HIWORD_UPDATE(0, 1, 12) },
+	{ "jtag switching", RK3399_GRF_SOC_CON7, FIELD_PREP_WM16_CONST(BIT(12), 0) },
 };
 
 static const struct rockchip_grf_info rk3399_grf __initconst = {
@@ -113,9 +112,9 @@ static const struct rockchip_grf_info rk3399_grf __initconst = {
 #define RK3566_GRF_USB3OTG0_CON1	0x0104
 
 static const struct rockchip_grf_value rk3566_defaults[] __initconst = {
-	{ "usb3otg port switch", RK3566_GRF_USB3OTG0_CON1, HIWORD_UPDATE(0, 1, 12) },
-	{ "usb3otg clock switch", RK3566_GRF_USB3OTG0_CON1, HIWORD_UPDATE(1, 1, 7) },
-	{ "usb3otg disable usb3", RK3566_GRF_USB3OTG0_CON1, HIWORD_UPDATE(1, 1, 0) },
+	{ "usb3otg port switch", RK3566_GRF_USB3OTG0_CON1, FIELD_PREP_WM16_CONST(BIT(12), 0) },
+	{ "usb3otg clock switch", RK3566_GRF_USB3OTG0_CON1, FIELD_PREP_WM16_CONST(BIT(7), 1) },
+	{ "usb3otg disable usb3", RK3566_GRF_USB3OTG0_CON1, FIELD_PREP_WM16_CONST(BIT(0), 1) },
 };
 
 static const struct rockchip_grf_info rk3566_pipegrf __initconst = {
@@ -126,8 +125,8 @@ static const struct rockchip_grf_info rk3566_pipegrf __initconst = {
 #define RK3576_SYSGRF_SOC_CON1		0x0004
 
 static const struct rockchip_grf_value rk3576_defaults_sys_grf[] __initconst = {
-	{ "i3c0 weakpull", RK3576_SYSGRF_SOC_CON1, HIWORD_UPDATE(3, 3, 6) },
-	{ "i3c1 weakpull", RK3576_SYSGRF_SOC_CON1, HIWORD_UPDATE(3, 3, 8) },
+	{ "i3c0 weakpull", RK3576_SYSGRF_SOC_CON1, FIELD_PREP_WM16_CONST(GENMASK(7, 6), 3) },
+	{ "i3c1 weakpull", RK3576_SYSGRF_SOC_CON1, FIELD_PREP_WM16_CONST(GENMASK(9, 8), 3) },
 };
 
 static const struct rockchip_grf_info rk3576_sysgrf __initconst = {
@@ -138,7 +137,7 @@ static const struct rockchip_grf_info rk3576_sysgrf __initconst = {
 #define RK3576_IOCGRF_MISC_CON		0x04F0
 
 static const struct rockchip_grf_value rk3576_defaults_ioc_grf[] __initconst = {
-	{ "jtag switching", RK3576_IOCGRF_MISC_CON, HIWORD_UPDATE(0, 1, 1) },
+	{ "jtag switching", RK3576_IOCGRF_MISC_CON, FIELD_PREP_WM16_CONST(BIT(1), 0) },
 };
 
 static const struct rockchip_grf_info rk3576_iocgrf __initconst = {
@@ -149,7 +148,7 @@ static const struct rockchip_grf_info rk3576_iocgrf __initconst = {
 #define RK3588_GRF_SOC_CON6		0x0318
 
 static const struct rockchip_grf_value rk3588_defaults[] __initconst = {
-	{ "jtag switching", RK3588_GRF_SOC_CON6, HIWORD_UPDATE(0, 1, 14) },
+	{ "jtag switching", RK3588_GRF_SOC_CON6, FIELD_PREP_WM16_CONST(BIT(14), 0) },
 };
 
 static const struct rockchip_grf_info rk3588_sysgrf __initconst = {

-- 
2.51.0


