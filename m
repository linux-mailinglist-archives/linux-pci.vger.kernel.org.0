Return-Path: <linux-pci+bounces-30429-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F1CAE4ADA
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 18:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F5071B649BD
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 16:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF932DCC14;
	Mon, 23 Jun 2025 16:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="KQk6HRvB"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3892BEC55;
	Mon, 23 Jun 2025 16:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750695048; cv=pass; b=qEQH+Wjp8Wmt1s/yMxnMFp6wErqwGLKTrSrkGBtQhG5N9qbYR9KNizNNxS2i2kImGXxM/7dgWPmMDzRvas2K8E9OEym8MnLV+RaRARZIY+UaZqMmu+nTsIKTC4gwHA8PLgvRppjAa+tYGF6OEuShe0R67fP6XO7Ao4ofmtciDzw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750695048; c=relaxed/simple;
	bh=7OkayJsOZyzmTO4c+BjoC0tLCVeSk9ZcfFU/BFbuV+E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JtiyAcTPk2jOBehbItG7iTstp2YTujHgSMVnVf9QDBWlS3SzdEaHiLNHS9T63oLpN4JzacIvTFrp1g35AEUWvXd9xMLKb3/fnxRmtH6h32qYh1CBIHiOiO0YEWHpN//0UUHFwS2jDbdeh1ao5lkb4C5XsB2NByBRooS3Hz7LCHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=KQk6HRvB; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1750694988; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=cQ2N+IGixkP2aaQ5UXF6V5lMJAcXbf4VGy9C6I6eP7vadIKKKbSa6io98A+qPjwdMAG5c4Y/+yM8oASFS2+FcLHHUp44H5DSxsEH4rYdFXLSqsHZA4mPGKwRS5aenUWldjAteT2huZRwHNMRZ4rX7Uz4hL3c6q0LuYGsTTFDwwQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1750694988; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=TsAvYRXNRfH8KCEl7dLPCJt6A++zI5/qvE+2kyphiOI=; 
	b=m6DqzHn0qZp9DXv9SOq0fu9zxtAxIlcCEHJRdS13wu6vxGiOl7s60nB2g4sE0mwCAA0cxTn2/EeiGxORL3Z8xvdLrRWOQYdJjOMPcZAot62R3FiatWjFxi5MEen6MLS7y72GJ3P3wSZvIZ1+GnRZXoD2Cec7/9Uw97y5Es1l3Nw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1750694988;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=TsAvYRXNRfH8KCEl7dLPCJt6A++zI5/qvE+2kyphiOI=;
	b=KQk6HRvBD4gLQV6ahaEy7C5wl/BlNOOwSwoFRCTV7TkA3EOiW8kJzdpUlkhxiYH8
	dnCjdh1PyJGnmerfszhtnaOOdoVevYdgl7r0PB7E53ZHmJNNXRniJdFLFqNZ8AquK4F
	3ZvFZm1vsVfLVSHOb+sheSYv4IB1j3IMj9zoQ3p8=
Received: by mx.zohomail.com with SMTPS id 1750694986506634.2794375369417;
	Mon, 23 Jun 2025 09:09:46 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Mon, 23 Jun 2025 18:05:46 +0200
Subject: [PATCH v2 18/20] PM / devfreq: rockchip-dfi: switch to
 FIELD_PREP_WM16 macro
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250623-byeword-update-v2-18-cf1fc08a2e1f@collabora.com>
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

Like many other Rockchip drivers, rockchip-dfi brings with it its own
HIWORD_UPDATE macro. This variant doesn't shift the value (and like the
others, doesn't do any checking).

Remove it, and replace instances of it with hw_bitfield.h's
FIELD_PREP_WM16.  Since FIELD_PREP_WM16 requires contiguous masks and
shifts the value for us, some reshuffling of definitions needs to
happen.

This gives us better compile-time error checking, and in my opinion,
nicer code.

Tested on an RK3568 ODROID-M1 board, and an RK3588 ROCK 5B board.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/devfreq/event/rockchip-dfi.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/devfreq/event/rockchip-dfi.c b/drivers/devfreq/event/rockchip-dfi.c
index 54effb63519653d20b40eed88681330983399a77..7ba68b7b7ebe37bef71b6f78abc88e117330d8fc 100644
--- a/drivers/devfreq/event/rockchip-dfi.c
+++ b/drivers/devfreq/event/rockchip-dfi.c
@@ -20,6 +20,7 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/bitfield.h>
+#include <linux/hw_bitfield.h>
 #include <linux/bits.h>
 #include <linux/perf_event.h>
 
@@ -30,8 +31,6 @@
 
 #define DMC_MAX_CHANNELS	4
 
-#define HIWORD_UPDATE(val, mask)	((val) | (mask) << 16)
-
 /* DDRMON_CTRL */
 #define DDRMON_CTRL	0x04
 #define DDRMON_CTRL_DDR4		BIT(5)
@@ -40,9 +39,6 @@
 #define DDRMON_CTRL_LPDDR23		BIT(2)
 #define DDRMON_CTRL_SOFTWARE_EN		BIT(1)
 #define DDRMON_CTRL_TIMER_CNT_EN	BIT(0)
-#define DDRMON_CTRL_DDR_TYPE_MASK	(DDRMON_CTRL_DDR4 | \
-					 DDRMON_CTRL_LPDDR4 | \
-					 DDRMON_CTRL_LPDDR23)
 
 #define DDRMON_CH0_WR_NUM		0x20
 #define DDRMON_CH0_RD_NUM		0x24
@@ -143,29 +139,32 @@ static int rockchip_dfi_enable(struct rockchip_dfi *dfi)
 			continue;
 
 		/* clear DDRMON_CTRL setting */
-		writel_relaxed(HIWORD_UPDATE(0, DDRMON_CTRL_TIMER_CNT_EN |
-			       DDRMON_CTRL_SOFTWARE_EN | DDRMON_CTRL_HARDWARE_EN),
+		writel_relaxed(FIELD_PREP_WM16(DDRMON_CTRL_TIMER_CNT_EN, 0) |
+			       FIELD_PREP_WM16(DDRMON_CTRL_SOFTWARE_EN, 0) |
+			       FIELD_PREP_WM16(DDRMON_CTRL_HARDWARE_EN, 0),
 			       dfi_regs + i * dfi->ddrmon_stride + DDRMON_CTRL);
 
 		/* set ddr type to dfi */
 		switch (dfi->ddr_type) {
 		case ROCKCHIP_DDRTYPE_LPDDR2:
 		case ROCKCHIP_DDRTYPE_LPDDR3:
-			ctrl = DDRMON_CTRL_LPDDR23;
+			ctrl = FIELD_PREP_WM16(DDRMON_CTRL_LPDDR23, 1) |
+			       FIELD_PREP_WM16(DDRMON_CTRL_LPDDR4, 0);
 			break;
 		case ROCKCHIP_DDRTYPE_LPDDR4:
 		case ROCKCHIP_DDRTYPE_LPDDR4X:
-			ctrl = DDRMON_CTRL_LPDDR4;
+			ctrl = FIELD_PREP_WM16(DDRMON_CTRL_LPDDR23, 0) |
+			       FIELD_PREP_WM16(DDRMON_CTRL_LPDDR4, 1);
 			break;
 		default:
 			break;
 		}
 
-		writel_relaxed(HIWORD_UPDATE(ctrl, DDRMON_CTRL_DDR_TYPE_MASK),
-			       dfi_regs + i * dfi->ddrmon_stride + DDRMON_CTRL);
+		writel_relaxed(ctrl, dfi_regs + i * dfi->ddrmon_stride +
+			       DDRMON_CTRL);
 
 		/* enable count, use software mode */
-		writel_relaxed(HIWORD_UPDATE(DDRMON_CTRL_SOFTWARE_EN, DDRMON_CTRL_SOFTWARE_EN),
+		writel_relaxed(FIELD_PREP_WM16(DDRMON_CTRL_SOFTWARE_EN, 1),
 			       dfi_regs + i * dfi->ddrmon_stride + DDRMON_CTRL);
 
 		if (dfi->ddrmon_ctrl_single)
@@ -195,8 +194,8 @@ static void rockchip_dfi_disable(struct rockchip_dfi *dfi)
 		if (!(dfi->channel_mask & BIT(i)))
 			continue;
 
-		writel_relaxed(HIWORD_UPDATE(0, DDRMON_CTRL_SOFTWARE_EN),
-			      dfi_regs + i * dfi->ddrmon_stride + DDRMON_CTRL);
+		writel_relaxed(FIELD_PREP_WM16(DDRMON_CTRL_SOFTWARE_EN, 0),
+			       dfi_regs + i * dfi->ddrmon_stride + DDRMON_CTRL);
 
 		if (dfi->ddrmon_ctrl_single)
 			break;

-- 
2.50.0


