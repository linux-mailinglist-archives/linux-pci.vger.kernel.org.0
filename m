Return-Path: <linux-pci+bounces-29582-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF4EAD7A61
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 21:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 352DF7B1046
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 18:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 126E02D662B;
	Thu, 12 Jun 2025 18:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="MKyukhD9"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2321F2D6629;
	Thu, 12 Jun 2025 18:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749754698; cv=pass; b=FvkGCfc86CI+quMQHYtBezTedocdP0adNlr39Cxd9UZWJN472DP2jcwTcKxjqnsrdr+kxwwg0ZVYfkGPD8U7N/PghIOWPyI3h/8CTGUTTFP+Odw/ohOcJwrZlhw7E3ZDxjy3gx+IHHTWmP2B8+/gJvyp5lXXtrCoZGJPEXSYun8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749754698; c=relaxed/simple;
	bh=oZ43J9vdeTFKLjmcPo+eLytEk+JVxZZ7XSoA67LPgEA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=twpFRIA5atPlIEYrWJp23ImYIj+Kt3VJvAroq3fNihai9O+BlP2ZJ43yAzj3JvKyTNV0Mu3wngHX/jAxk3my/3kUn7t5RndbD+IACmyiPx8DgK3/r3VZiHySWVdjYQUHmEeg05mbiDP8u9x928IffMEilzuT+0a8WK4xgyc7cjw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=MKyukhD9; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1749754637; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=cQ/34ghqKuGjcrWPS7b1Wq9MVwd24fiYy33dfNtZnwjp0TIlEGsMMZkTkkw84nbbhyDSgqmMOg6aYVQUnswX2KLbY0zwxv0fjczYXuNmDI9AjiDoJ53+BOvo0HtFYsCaa1N4+iXE/Gt8d2kk9TDm8pR2k9zH/lnXEDwCkrRV/oc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1749754637; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=9FbAT/kFTYAJV4B26t5chvy2NGDoQ0MYqsffVQGJEKY=; 
	b=XyyXjlQtxQmWzzagFz4yGtANAwqMiepjym1NS8jMP7V5pzr6sadWHFUOWHGQQA1lmJOUo+2QVCccrPjUdAHykFtt2qVQfI5NJMoC0aurpHLczUmmCxA+FIBFmqkGSy+zMtgNP71TMcvQCucOhyMW1/vo/Z+nd2aexOPze1q130I=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1749754637;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=9FbAT/kFTYAJV4B26t5chvy2NGDoQ0MYqsffVQGJEKY=;
	b=MKyukhD9mQguSmr/ZgdeSbDoZqzeO5gjhx6xYALY/foknYyAnNv2HJdJdbqSA2Gk
	dxkFofcpizGOU+UgoFrzslUvu4X+WEoVS+h5BQsh12DO2+BCeOD6RwVJoRJvirAWqIk
	4vQvnFeC037T1+7jdCaeWd4mGVHpghNxJIBdYm7U=
Received: by mx.zohomail.com with SMTPS id 1749754636246148.0365477005737;
	Thu, 12 Jun 2025 11:57:16 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Thu, 12 Jun 2025 20:56:06 +0200
Subject: [PATCH 04/20] media: synopsys: hdmirx: replace macros with
 bitfield variants
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250612-byeword-update-v1-4-f4afb8f6313f@collabora.com>
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

Replace the UPDATE macro with bitfield.h's FIELD_PREP, to give us
additional error checking.

Also, replace the HIWORD_UPDATE macro at the same time with bitfield.h's
new HWORD_UPDATE macro, which also gives us additional error checking.

The UPDATE/HIWORD_UPDATE macros are left as wrappers around the
bitfield.h macros, in order to not rock the boat too much, and keep the
changes easy to review.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/media/platform/synopsys/hdmirx/snps_hdmirx.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/synopsys/hdmirx/snps_hdmirx.h b/drivers/media/platform/synopsys/hdmirx/snps_hdmirx.h
index 220ab99ca61152b36b0a08b398ddefdb985709a5..cd5250e282a5c9de9a75ea73f26496ed53766dff 100644
--- a/drivers/media/platform/synopsys/hdmirx/snps_hdmirx.h
+++ b/drivers/media/platform/synopsys/hdmirx/snps_hdmirx.h
@@ -8,10 +8,11 @@
 #ifndef DW_HDMIRX_H
 #define DW_HDMIRX_H
 
+#include <linux/bitfield.h>
 #include <linux/bitops.h>
 
-#define UPDATE(x, h, l)		(((x) << (l)) & GENMASK((h), (l)))
-#define HIWORD_UPDATE(v, h, l)	(((v) << (l)) | (GENMASK((h), (l)) << 16))
+#define UPDATE(x, h, l)		(FIELD_PREP(GENMASK((h), (l)), (x)))
+#define HIWORD_UPDATE(v, h, l)	(HWORD_UPDATE(GENMASK((h), (l)), (v)))
 
 /* SYS_GRF */
 #define SYS_GRF_SOC_CON1			0x0304

-- 
2.49.0


