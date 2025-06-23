Return-Path: <linux-pci+bounces-30412-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1CAAE49B9
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 18:08:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 507A03BA5D2
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 16:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F64C29B799;
	Mon, 23 Jun 2025 16:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="ETz5TV9b"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520F829B23E;
	Mon, 23 Jun 2025 16:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750694838; cv=pass; b=RuHTziVFITP8PswSYMy3HDBsQu7Cwxom0XqPphDvNlLYiCcCC1mVWhN+eRcRcHzBnhdtFPnX6trAthFmy03uvOjRVXmb7YfoN21mLS2khBtoBr/u1yiXN14tLhmo2dsZ+1XT8ufKve18ipqZNapsmyh96t6UxCgKxfog4iraOmE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750694838; c=relaxed/simple;
	bh=Rs+KTrJ92o4m+v5CF3hKsXzNwV8DvGVCg4BNzRzHNQs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cO/hcsV+4X+Mdx/svJ5KvP9v82Bf4yjQcmL77Ero2i7MgeCwFD0+mPjHAGCMzvwrVD/BV2l7jY/hz7RxYM9HqZUxNkB76rRMFAwxzlSlHz69qdQywFlVCtkVjNkZlwfC15NDqhCdrWPZazhT+/hjFlHpzGx8SB0pegf897FUiVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=ETz5TV9b; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1750694778; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=RKHqaCEzPeR4zy0teDOkQZRDqkpOv+JrYL6vZr3gblXVkFqwh8npxTDRHW5zWXOIF3/p1bjTnYqNcLJ6sXWua9h/9jQF8KB0RCRY6NnYvbFFsqvr66ZxkDkd57wfZ8hfgGe4tURMK2SRGJYo2Dx9d38Bz+5UTqgyoZJNl4Hpplc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1750694778; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=yEdxHJmCEw0Pc/7UrKzJWEnE1Ei3x3Qa8UoZFYS3K3A=; 
	b=dUYM/iWCffN7WUrXMzoXlVVVfflSkd0yeWyTHzVJZwBMoVrRVypJDpTDkBR0a+vk1ptNOh7bqwF81oXYCeq0uL58S5j5iYI+oPLO5d01Tp9ZLipbdqsFN8iiOT3fY74Tmuhhfm13MEBTRmlhrHBaVeYyIs4sewfBNxwl3kr4794=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1750694778;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=yEdxHJmCEw0Pc/7UrKzJWEnE1Ei3x3Qa8UoZFYS3K3A=;
	b=ETz5TV9bbWWNK9JkXWIDXBSDvnDvqCzI0WzI2j2JWUddTXk2s7q9lYDn5ERabOS2
	JmqWwbvDUujhTWNS5ZYvGksWpYAcIB9BeOrHyq5H0zKmwjY2Y70tB76+xjUmEGzQSyP
	8afjrwARQzts/pl7VC1JSEEqV13EyStVWN+oVtMY=
Received: by mx.zohomail.com with SMTPS id 1750694775956412.24403309942795;
	Mon, 23 Jun 2025 09:06:15 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Mon, 23 Jun 2025 18:05:30 +0200
Subject: [PATCH v2 02/20] mmc: dw_mmc-rockchip: switch to FIELD_PREP_WM16
 macro
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250623-byeword-update-v2-2-cf1fc08a2e1f@collabora.com>
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

Switch to the new FIELD_PREP_WM16 macro in hw_bitfield.h, which has
error checking. Instead of redefining the driver's HIWORD_UPDATE macro
in this case, replace the two only instances of it with the new macro,
as I could test that they result in an equivalent value.

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/mmc/host/dw_mmc-rockchip.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_mmc-rockchip.c
index baa23b51773127b4137f472581259b61649273a5..218b2072688408fffa66d593eebc1efa81ae4969 100644
--- a/drivers/mmc/host/dw_mmc-rockchip.c
+++ b/drivers/mmc/host/dw_mmc-rockchip.c
@@ -6,6 +6,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/clk.h>
+#include <linux/hw_bitfield.h>
 #include <linux/mmc/host.h>
 #include <linux/of_address.h>
 #include <linux/mmc/slot-gpio.h>
@@ -24,8 +25,6 @@
 #define ROCKCHIP_MMC_DELAYNUM_OFFSET	2
 #define ROCKCHIP_MMC_DELAYNUM_MASK	(0xff << ROCKCHIP_MMC_DELAYNUM_OFFSET)
 #define ROCKCHIP_MMC_DELAY_ELEMENT_PSEC	60
-#define HIWORD_UPDATE(val, mask, shift) \
-		((val) << (shift) | (mask) << ((shift) + 16))
 
 static const unsigned int freqs[] = { 100000, 200000, 300000, 400000 };
 
@@ -148,9 +147,11 @@ static int rockchip_mmc_set_internal_phase(struct dw_mci *host, bool sample, int
 	raw_value |= nineties;
 
 	if (sample)
-		mci_writel(host, TIMING_CON1, HIWORD_UPDATE(raw_value, 0x07ff, 1));
+		mci_writel(host, TIMING_CON1,
+			   FIELD_PREP_WM16(GENMASK(11, 1), raw_value));
 	else
-		mci_writel(host, TIMING_CON0, HIWORD_UPDATE(raw_value, 0x07ff, 1));
+		mci_writel(host, TIMING_CON0,
+			   FIELD_PREP_WM16(GENMASK(11, 1), raw_value));
 
 	dev_dbg(host->dev, "set %s_phase(%d) delay_nums=%u actual_degrees=%d\n",
 		sample ? "sample" : "drv", degrees, delay_num,

-- 
2.50.0


