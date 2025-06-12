Return-Path: <linux-pci+bounces-29587-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8B7AD7A7E
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 21:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C8AE3AFD7A
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 19:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D215E2DECB2;
	Thu, 12 Jun 2025 18:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="CeWXfP7v"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD712D3206;
	Thu, 12 Jun 2025 18:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749754760; cv=pass; b=kRzex7uTw7b907EVqFUKPMp7QaHei5PeWSr97piarkJ+TIYhL2VmgJs02RqzKu9ow9Sc36XQjlNXK2dovH+xyqeBaZwtl+iHcPM7Pk89Psrmk8Mg0VVW+dg9AZfBH6ft+zetEpL7KOFfhBVSUzOxLMDRUI+RxdS4tqhG5nI20KY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749754760; c=relaxed/simple;
	bh=kyJvlLerwlPf15CmcJBtrTiMKTwo9PAYOFAR0ItU1G4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KgyvMsde2V0dUb3vUehgQdUPuTXobFqQDGfnO/OIqW/UrXLMLKePurG4Mlpyk6XEM9Ftw6ehEr9EYwd4cDA9ukqHaKZ0VxDYHQMShZuv8Gq2+FAWxS7fIdCtbY5tceIX+0Kz9f+3lz6k2egqknl4FkpBQo/O5VawiKlj0JGU2zo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=CeWXfP7v; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1749754704; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=cI/VJOz6iJRVy6Ke4ddXZCY5EqBJ4AL4k4M68S2b0hPiptTEUCC4d0Yb0ZOoNR1V7j1mgV4A0ByOh9G3U04ael5E1s+XDF1yRuc87MQSt2vf8WCID7fbzjeawtGKaYou6TmOTaGo0RcsdXmZKTl+7uEjbUJX4Z9KP3XT4KDeMk8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1749754704; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=XPgEfeDWn7zZb6b80MRD6oKIcz/PXencyibHYlKo4x4=; 
	b=Yx4JZe0B8F8t0N77FWCB7yYsoB6WPCkh0zAWKdfzfvXKM4zPO3zFWCcP6XgdmzTuyhqjAgo2i7BN8OgugnF0Utgbr1hGr+Xrq04t7PxPAj65wRmis7Y8bW1wsQDoIoy8MhRvnBhxNqN58ic1x2aSQbtuwgiaxO/zpxDVAPyR3kk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1749754704;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=XPgEfeDWn7zZb6b80MRD6oKIcz/PXencyibHYlKo4x4=;
	b=CeWXfP7vQMRhmUek6S4U1SCn1IOQDC68dC8eLaOo5bY//WywPJkZbpweBmO1kpSZ
	E/i5O8jSTcGAVgeiSOTuAhOVGveYMHg2STC/3KqlkuAQlVG3nfITu9oLcB/yW/gCwOx
	SFAy9cQt4vKGxq98BDTTG3H359iYcGMLHxvKdzoA=
Received: by mx.zohomail.com with SMTPS id 174975470269822.139624322668624;
	Thu, 12 Jun 2025 11:58:22 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Thu, 12 Jun 2025 20:56:11 +0200
Subject: [PATCH 09/20] phy: rockchip-samsung-dcphy: switch to HWORD_UPDATE
 macro
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250612-byeword-update-v1-9-f4afb8f6313f@collabora.com>
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

phy-rockchip-samsung-dcphy is actually an exemplary example, where the
similarities to FIELD_PREP were spotted and the driver local macro has
the same semantics as the new HWORD_UPDATE bitfield.h macro.

Still, get rid of FIELD_PREP_HIWORD now that a shared implementation
exists, replacing the two instances of it with HWORD_UPDATE. This gives
us slightly better error checking; the value is now checked to fit in 16
bits.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/phy/rockchip/phy-rockchip-samsung-dcphy.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-samsung-dcphy.c b/drivers/phy/rockchip/phy-rockchip-samsung-dcphy.c
index 28a052e17366516d5a99988bec9a52e3f0f09101..71e88635c95371fcc6f0f7227954e1f34dd97fc6 100644
--- a/drivers/phy/rockchip/phy-rockchip-samsung-dcphy.c
+++ b/drivers/phy/rockchip/phy-rockchip-samsung-dcphy.c
@@ -20,12 +20,6 @@
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
@@ -252,8 +246,8 @@
 
 /* MIPI_CDPHY_GRF registers */
 #define MIPI_DCPHY_GRF_CON0		0x0000
-#define S_CPHY_MODE			FIELD_PREP_HIWORD(BIT(3), 1)
-#define M_CPHY_MODE			FIELD_PREP_HIWORD(BIT(0), 1)
+#define S_CPHY_MODE			HWORD_UPDATE(BIT(3), 1)
+#define M_CPHY_MODE			HWORD_UPDATE(BIT(0), 1)
 
 enum hs_drv_res_ohm {
 	STRENGTH_30_OHM = 0x8,

-- 
2.49.0


