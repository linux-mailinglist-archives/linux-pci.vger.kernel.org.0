Return-Path: <linux-pci+bounces-30430-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 879B9AE4ADF
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 18:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEC8318877AF
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 16:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3682BFC74;
	Mon, 23 Jun 2025 16:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="LBdDBBwU"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D38229B78B;
	Mon, 23 Jun 2025 16:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750695072; cv=pass; b=kHWwtMWdQxQySzNk/FxCQMBn86QVw0UVlnuWigwF7o1hFUhsL0xUanUkzZC35yxARD3jmRTHR4f74ZJ/KI4j9rXNqufLyXw35+EeUfUIAgfhywGMTdEyspIYKujDuBn12XDWqkD44k1AClXPrMce+DgiFtF1Q0W5bXDhb3RyBDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750695072; c=relaxed/simple;
	bh=pMASCVJfLA02n2MC3CtkPgvvnGEd5oNJ77gJisTfSGM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f59OEpCMemPGtE0YToHbEVF2zI5Gr0GXYW40j7Wr72RiEGD+Bz0VIPW6AZBfcmxq+51L3cxzvAHH00xCRtf8slJHGrAnjmGgxd5MTNK7yRvc/J6Cp/CxZdrQraxZlbRFdAy8Qk4QTYGri67Og977fYEKe/2waXcdyKKRTQHnYjY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=LBdDBBwU; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1750695002; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=PgXfIBkPHA9f27VFLwxOYJgkyCM3EWFX65nnrQp6gBNi0yPeQxSboZ7NcwDUjNKOpyfU8eV4dLsDVexE5SDf/a0yoX/Vxtxv8SINTYo5A52K5UGwMceaKdLNOBojBJHIa+ebi5ii+whpaKHvyOcwHeI6T6CwSkFKJLONmHPIjEE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1750695002; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=wouUtu5JNS6hmlFMcIWOfhlk7sMUedB6ugwxUWid1DE=; 
	b=ViXrbkeWVt+b759tU3V8QMut/PCCZClamlYwqUa7ORSrGwUahvK+BUigw0Uega4Mu0F2cYQzEngJZ0uJ12ylGN2ga73NPOPchCe+d0MCvQXP3X29ZOAuLFoNxTuDRuvUozMQ7Xo/0B0+OIjdoup4abNeoTI93i3Uon94hGn72rU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1750695002;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=wouUtu5JNS6hmlFMcIWOfhlk7sMUedB6ugwxUWid1DE=;
	b=LBdDBBwUAtBbQO4mcEelS1Fox1wTav7sXxA1h9gduNFpYQUbX4PQpxZWGT23c06f
	j6LqtZEFEjbfm/7qRimz6i6jwA6v4cclvkZegHr5FalbPCFkRolIGJ8mJWfKIA7w9hk
	Q/DLKRVdLlBSj2CiaX/LDYoil0LFVPyy3AYCaPBo=
Received: by mx.zohomail.com with SMTPS id 1750694999725441.5543859229797;
	Mon, 23 Jun 2025 09:09:59 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Mon, 23 Jun 2025 18:05:47 +0200
Subject: [PATCH v2 19/20] clk: sp7021: switch to FIELD_PREP_WM16 macro
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250623-byeword-update-v2-19-cf1fc08a2e1f@collabora.com>
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

The sp7021 clock driver has its own shifted high word mask macro,
similar to the ones many Rockchip drivers have.

Remove it, and replace instances of it with hw_bitfield.h's
FIELD_PREP_WM16 macro, which does the same thing except in a common
macro that also does compile-time error checking.

This was compile-tested with 32-bit ARM with Clang, no runtime tests
were performed as I lack the hardware. However, I verified that fix
commit 5c667d5a5a3e ("clk: sp7021: Adjust width of _m in HWM_FIELD_PREP()")
is not regressed. No warning is produced.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/clk/clk-sp7021.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/clk/clk-sp7021.c b/drivers/clk/clk-sp7021.c
index 7cb7d501d7a6ebffe002f80dfa937365e04d356a..233259a5997b1f5d5f1c7c101b9e1bddf2083e36 100644
--- a/drivers/clk/clk-sp7021.c
+++ b/drivers/clk/clk-sp7021.c
@@ -7,6 +7,7 @@
 #include <linux/clk-provider.h>
 #include <linux/of.h>
 #include <linux/bitfield.h>
+#include <linux/hw_bitfield.h>
 #include <linux/slab.h>
 #include <linux/io.h>
 #include <linux/err.h>
@@ -38,13 +39,6 @@ enum {
 #define MASK_DIVN	GENMASK(7, 0)
 #define MASK_DIVM	GENMASK(14, 8)
 
-/* HIWORD_MASK FIELD_PREP */
-#define HWM_FIELD_PREP(mask, value)		\
-({						\
-	u64 _m = mask;				\
-	(_m << 16) | FIELD_PREP(_m, value);	\
-})
-
 struct sp_pll {
 	struct clk_hw hw;
 	void __iomem *reg;
@@ -313,15 +307,15 @@ static int plltv_set_rate(struct sp_pll *clk)
 	u32 r0, r1, r2;
 
 	r0  = BIT(clk->bp_bit + 16);
-	r0 |= HWM_FIELD_PREP(MASK_SEL_FRA, clk->p[SEL_FRA]);
-	r0 |= HWM_FIELD_PREP(MASK_SDM_MOD, clk->p[SDM_MOD]);
-	r0 |= HWM_FIELD_PREP(MASK_PH_SEL, clk->p[PH_SEL]);
-	r0 |= HWM_FIELD_PREP(MASK_NFRA, clk->p[NFRA]);
+	r0 |= FIELD_PREP_WM16(MASK_SEL_FRA, clk->p[SEL_FRA]);
+	r0 |= FIELD_PREP_WM16(MASK_SDM_MOD, clk->p[SDM_MOD]);
+	r0 |= FIELD_PREP_WM16(MASK_PH_SEL, clk->p[PH_SEL]);
+	r0 |= FIELD_PREP_WM16(MASK_NFRA, clk->p[NFRA]);
 
-	r1  = HWM_FIELD_PREP(MASK_DIVR, clk->p[DIVR]);
+	r1  = FIELD_PREP_WM16(MASK_DIVR, clk->p[DIVR]);
 
-	r2  = HWM_FIELD_PREP(MASK_DIVN, clk->p[DIVN] - 1);
-	r2 |= HWM_FIELD_PREP(MASK_DIVM, clk->p[DIVM] - 1);
+	r2  = FIELD_PREP_WM16(MASK_DIVN, clk->p[DIVN] - 1);
+	r2 |= FIELD_PREP_WM16(MASK_DIVM, clk->p[DIVM] - 1);
 
 	spin_lock_irqsave(&clk->lock, flags);
 	writel(r0, clk->reg);

-- 
2.50.0


