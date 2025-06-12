Return-Path: <linux-pci+bounces-29592-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C368AAD7A9F
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 21:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0BAE3B1090
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 19:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB6B2D8788;
	Thu, 12 Jun 2025 19:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="eao41fQd"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CA92D4B58;
	Thu, 12 Jun 2025 19:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749754843; cv=pass; b=oJmS3EXuprPfxqKNwsSps2MdFKv7TKskt/hdM47cOF1dtxsV7cWC00N5h5jISHAxNsvk9XOx4yONlaJxbDc61GW4cyV4tRGypdfsyYg8h/W6MMb8I0nMPVkkGYnR/B/nVWyuVXx2gQjcWqbm2XRNYYS4hZXfyarDP7i11mNLN1k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749754843; c=relaxed/simple;
	bh=gl8bn9XG7zG0d1JHH66NRST0umUJLJQlfCPkWFS9u9k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ds8xZ58bEDi7FM4n6G9OWH4Ek/szHkYBtbGIR9tx1ym4YdR93789L3srO/BAZ2Y0KA+du6Z6dDskARqMgz1zIGFLEVVbrRXMT6Cy2I+uJlCMcbryNhQth32RNy0a8NvzvhZhoc3OQbMY9Q0VeKV6ZaJalYWFr6WlfDWMn0axsyA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=eao41fQd; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1749754770; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Z0DXjCfd3efZliCDFcqsVoAS+gJAU+g2CRWUu+35nhjhZxo3v1SYly5p5A1apRfDbaejdHE3h5fZFZLWPf9LXi/dA0QORUF3xyCl9dAnNwWx8qC/zSlatzzQM5fYFt3HledlkE5Res8Cm48bGGIOgOhHpLgOaenxv7CWnq3Hx0o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1749754770; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=BKmiKHxsyC9s74dEZUCVhW0dLCt+4VJJ4UwOh+/H/sE=; 
	b=SHqOdpFeVaOAQpBfB094uwG8oa8J3ZlKNBUp46pmqNmLrDjud7P6HSAvrpr9xOph36QDBQZ3EUzhar8GLUOVBD1KsBqPLJg5DT64iNMzCl442h4cZCA7Dt3lquUFdSlQc36HTD4JFOFCcy38eo10BQevwoFf+hzp46nthQKyXDI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1749754770;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=BKmiKHxsyC9s74dEZUCVhW0dLCt+4VJJ4UwOh+/H/sE=;
	b=eao41fQdWmTPedrJvNMP+rvhBs+KDltNtF8BUjnvDWykLdBvTbFfCb3yGSAa/Q8X
	UbtJhJBjfHcgjdbtAXNxdBYaLShBTwJa3qlh/+K6Yn9oE1+gNXop57MXrRiYLAO2i2X
	Bp6MxMDYM08zRCNAbyFAXCSI+vMdL8hM76dxkVH0=
Received: by mx.zohomail.com with SMTPS id 1749754768033111.35290409790514;
	Thu, 12 Jun 2025 11:59:28 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Thu, 12 Jun 2025 20:56:16 +0200
Subject: [PATCH 14/20] ASoC: rockchip: i2s-tdm: switch to
 HWORD_UPDATE_CONST macro
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250612-byeword-update-v1-14-f4afb8f6313f@collabora.com>
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

Replace the implementation of this driver's HIWORD_UPDATE macro with an
instance of HWORD_UPDATE_CONST. The const variant is chosen here because
some of the header defines are then used in initializers.

This gives us some compile-time error checking, while keeping the diff
very small and easy to review.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 sound/soc/rockchip/rockchip_i2s_tdm.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/rockchip/rockchip_i2s_tdm.h b/sound/soc/rockchip/rockchip_i2s_tdm.h
index 0aa1c6da1e2c0ebb70473b1bcd1f6e0c1fb90df3..6efb76fbff9c158b79a87cdea02ef9db335cf700 100644
--- a/sound/soc/rockchip/rockchip_i2s_tdm.h
+++ b/sound/soc/rockchip/rockchip_i2s_tdm.h
@@ -10,6 +10,8 @@
 #ifndef _ROCKCHIP_I2S_TDM_H
 #define _ROCKCHIP_I2S_TDM_H
 
+#include <linux/bitfield.h>
+
 /*
  * TXCR
  * transmit operation control register
@@ -285,7 +287,7 @@ enum {
 #define I2S_TDM_RXCR	(0x0034)
 #define I2S_CLKDIV	(0x0038)
 
-#define HIWORD_UPDATE(v, h, l)	(((v) << (l)) | (GENMASK((h), (l)) << 16))
+#define HIWORD_UPDATE(v, h, l)	(HWORD_UPDATE_CONST(GENMASK((h), (l)), (v)))
 
 /* PX30 GRF CONFIGS */
 #define PX30_I2S0_CLK_IN_SRC_FROM_TX		HIWORD_UPDATE(1, 13, 12)

-- 
2.49.0


