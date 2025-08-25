Return-Path: <linux-pci+bounces-34639-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B97FB338F0
	for <lists+linux-pci@lfdr.de>; Mon, 25 Aug 2025 10:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CE5A7A7764
	for <lists+linux-pci@lfdr.de>; Mon, 25 Aug 2025 08:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE722BD01E;
	Mon, 25 Aug 2025 08:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="WSw85IAg"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DDB29E0ED;
	Mon, 25 Aug 2025 08:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756110656; cv=pass; b=Sl1B6SVMoeFHGdhkScZnvRo9ADhwrZOOA14oX0kgp/Ab9GDMhA0Ix8KhaFfBkhrgFb3ayO//lAyrCu5xt0wVK0u0BaUhy6bfZ7QhbojPTzSsRZK+El4lC9ywTM33K1SdOUfTHoXjXRUHTm1AmU026lfj6tFF48Qzird8ndrHZAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756110656; c=relaxed/simple;
	bh=xIUiEZ+jRScXZHVYyixJoSRStbNanxOI0w8fMpQeApQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hWXbeyVgopLDfNo3HkvnPHzCpS5dtqV/hIaEIiLhUF8xcc+8r8Q3praa0Z66CfJN4joegyeSLJK6kGjtpcSHJpLlgOaBxvuF7Lt+mbzkEAsYjcx/rJWSlQUDMe4smIxGRz4wI8CPcej+nerYKBXmfUF3rCoFvfeVPZJPfYJrOTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=WSw85IAg; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1756110592; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Spu+qRK6MaAmq1ts0Wdp7J1aW+qfNBG5icK/eaqtfH+YyWxeB1NTDZ8W+G2h8udsLBsHTcXCO712hs08QJy3FK+yg8OeA9fidxT5LGGx8zwAHW/G5YPnrRxKFzYNVnm93+kKNdlHXCInRgdUqp673JPcguTydyUL6PbLdNu2UPc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756110592; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=7HWJ1BzGo111r+J/rdHN7JSVYw65Un3oVDAW30QEQWY=; 
	b=RPODsjPOe1gMzoO+qyc0qC9wLYM0FcLCdgKd5jqH9CBoZfrNdjb1Q7Kimg9m8PH/WKPi9QrxnpGDYgNDJmc0/CzDV7ZwjTqiFy8D4t1idvAWVvrHdkAnSnjVEln5W8F1wSZuCAndRP1RB04khd8eFfS/s82+kz+76IItgaNxUD0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756110592;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=7HWJ1BzGo111r+J/rdHN7JSVYw65Un3oVDAW30QEQWY=;
	b=WSw85IAgL0ojx+3BdKAuoLPuKZ/DKQa0VSIE8J1nxCtiqNVMtkoph87s+qft29AR
	NiqjGqQWdwQRPrD2R7eV6rlfkPzEYNyDEMMBhnDjHxbb/tXnKR/bQ5otFrL01V3wVwJ
	0GZOrtvGf0cJ9tmJyqDZFkfre9Xj3ZWm5aElIwP8=
Received: by mx.zohomail.com with SMTPS id 1756110590175324.62530831399624;
	Mon, 25 Aug 2025 01:29:50 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Mon, 25 Aug 2025 10:28:24 +0200
Subject: [PATCH v3 04/20] media: synopsys: hdmirx: replace macros with
 bitfield variants
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250825-byeword-update-v3-4-947b841cdb29@collabora.com>
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

Replace the UPDATE macro with bitfield.h's FIELD_PREP, to give us
additional error checking.

Also, replace the HIWORD_UPDATE macro at the same time with the new
FIELD_PREP_WM16 macro in hw_bitfield.h, which also gives us additional
error checking.

The UPDATE/HIWORD_UPDATE macros are left as wrappers around the
replacement macros, in order to not rock the boat too much, and keep the
changes easy to review.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/media/platform/synopsys/hdmirx/snps_hdmirx.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/synopsys/hdmirx/snps_hdmirx.h b/drivers/media/platform/synopsys/hdmirx/snps_hdmirx.h
index 220ab99ca61152b36b0a08b398ddefdb985709a5..b26668a98aafd1682b8342cc11f84666a13f07a3 100644
--- a/drivers/media/platform/synopsys/hdmirx/snps_hdmirx.h
+++ b/drivers/media/platform/synopsys/hdmirx/snps_hdmirx.h
@@ -8,10 +8,12 @@
 #ifndef DW_HDMIRX_H
 #define DW_HDMIRX_H
 
+#include <linux/bitfield.h>
 #include <linux/bitops.h>
+#include <linux/hw_bitfield.h>
 
-#define UPDATE(x, h, l)		(((x) << (l)) & GENMASK((h), (l)))
-#define HIWORD_UPDATE(v, h, l)	(((v) << (l)) | (GENMASK((h), (l)) << 16))
+#define UPDATE(x, h, l)		(FIELD_PREP(GENMASK((h), (l)), (x)))
+#define HIWORD_UPDATE(v, h, l)	(FIELD_PREP_WM16(GENMASK((h), (l)), (v)))
 
 /* SYS_GRF */
 #define SYS_GRF_SOC_CON1			0x0304

-- 
2.51.0


