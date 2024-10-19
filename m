Return-Path: <linux-pci+bounces-14907-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FE09A4D09
	for <lists+linux-pci@lfdr.de>; Sat, 19 Oct 2024 13:16:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C4882842F8
	for <lists+linux-pci@lfdr.de>; Sat, 19 Oct 2024 11:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3AE81E04BC;
	Sat, 19 Oct 2024 11:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="bWe+LYlJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00101DFDBF;
	Sat, 19 Oct 2024 11:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729336578; cv=none; b=hV2SYimvwkf0G0tzgXg5e29gIt8T0B1L89d5vz/Yx6C2py1ix4ElL7l+3NSqSkJoKVj/moASOahQdn0f2TCgKTFz0XaoAMiuoJdyfCn1SKpgj9x7X5ePznrBZWxnzEUZIpqmj1aSRHiCrOhcMld+CU0EpTNEGrxFWeknyuELZ6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729336578; c=relaxed/simple;
	bh=nwnH2KnIkk1D0r4Y5YjAkX/ex3xblGmY05q5UghzuYc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nLy8GN9BQGtUzBwtwBm3koVzyzbf2zr9Yp7IddcPfuhM4TMcV4ZPvwv/YDLyZkLkIfuFh69unjQo4llmV7ihhsgl1trdhmAjzOgQT7muqEC+SEa1iaJvJPuTgPrMnn9737DdOXxPzxIFSaaRhaKjsbo5feFHZHyzk94V49yhce0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=bWe+LYlJ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1729336574;
	bh=nwnH2KnIkk1D0r4Y5YjAkX/ex3xblGmY05q5UghzuYc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bWe+LYlJ+pQOag0E5xHE7EuueK+0GVC8RcVxylv8YC87PqUsSZm9vt4yZxVZiaPsH
	 9QBMh68gROeNvwwTxJggCHvEvRu0SJywBsp0KflY9zmDZdCUIqLSPigU7ePrJ+Wfhu
	 0hoQPGY4g4i704gw3dStPBsAGp3IlHpP7Op1A3pycDrwXgrNVuMt2aLFQAlCVRjtk6
	 WjCCNyNdDGYd+KO4SliUXTDSF3bIVNKEMM1PyW6fZALEZFvny0LNhUl/QlShjfrGEm
	 TwMv5ia2KYeUyGZsqQ5/2stzj4hJsljgakdei/fwbq0bi31wFPNmNOXZKCvPngIbDw
	 11AnIgf7CRZ/w==
Received: from localhost (unknown [188.24.146.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C188C17E35E0;
	Sat, 19 Oct 2024 13:16:14 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Sat, 19 Oct 2024 14:16:03 +0300
Subject: [PATCH v4 4/4] clk: Drop obsolete devm_clk_bulk_get_all_enable()
 helper
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241019-clk_bulk_ena_fix-v4-4-57f108f64e70@collabora.com>
References: <20241019-clk_bulk_ena_fix-v4-0-57f108f64e70@collabora.com>
In-Reply-To: <20241019-clk_bulk_ena_fix-v4-0-57f108f64e70@collabora.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Russell King <linux@armlinux.org.uk>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Jingoo Han <jingoohan1@gmail.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: kernel@collabora.com, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-pci@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org
X-Mailer: b4 0.14.2

Commit 265b07df758a ("clk: Provide managed helper to get and enable bulk
clocks") added devm_clk_bulk_get_all_enable() function, but missed to
return the number of clocks stored in the clk_bulk_data table referenced
by the clks argument.  Without knowing the number, it's not possible to
iterate these clocks when needed, hence the argument is useless and
could have been simply removed.

A new helper devm_clk_bulk_get_all_enabled() has been introduced, which
is consistent with devm_clk_bulk_get_all() in terms of the returned
value.

Drop the obsolete function since all users switched to the new helper.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/clk/clk-devres.c |  9 ---------
 include/linux/clk.h      | 22 ----------------------
 2 files changed, 31 deletions(-)

diff --git a/drivers/clk/clk-devres.c b/drivers/clk/clk-devres.c
index 975fac29b27f3709e292531a114975c9108287db..0ae385403f9b08d29d0ec7cb2066f02d46cb90c9 100644
--- a/drivers/clk/clk-devres.c
+++ b/drivers/clk/clk-devres.c
@@ -218,15 +218,6 @@ static void devm_clk_bulk_release_all_enable(struct device *dev, void *res)
 	clk_bulk_put_all(devres->num_clks, devres->clks);
 }
 
-int __must_check devm_clk_bulk_get_all_enable(struct device *dev,
-					      struct clk_bulk_data **clks)
-{
-	int ret = devm_clk_bulk_get_all_enabled(dev, clks);
-
-	return ret > 0 ? 0 : ret;
-}
-EXPORT_SYMBOL_GPL(devm_clk_bulk_get_all_enable);
-
 int __must_check devm_clk_bulk_get_all_enabled(struct device *dev,
 					       struct clk_bulk_data **clks)
 {
diff --git a/include/linux/clk.h b/include/linux/clk.h
index 158c5072852e36c1583dc47ca7516fcdd928fe59..b607482ca77e987b9344c38f25ebb5c8d35c1d39 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -495,22 +495,6 @@ int __must_check devm_clk_bulk_get_optional(struct device *dev, int num_clks,
 int __must_check devm_clk_bulk_get_all(struct device *dev,
 				       struct clk_bulk_data **clks);
 
-/**
- * devm_clk_bulk_get_all_enable - Get and enable all clocks of the consumer (managed)
- * @dev: device for clock "consumer"
- * @clks: pointer to the clk_bulk_data table of consumer
- *
- * Returns success (0) or negative errno.
- *
- * This helper function allows drivers to get all clocks of the
- * consumer and enables them in one operation with management.
- * The clks will automatically be disabled and freed when the device
- * is unbound.
- */
-
-int __must_check devm_clk_bulk_get_all_enable(struct device *dev,
-					      struct clk_bulk_data **clks);
-
 /**
  * devm_clk_bulk_get_all_enabled - Get and enable all clocks of the consumer (managed)
  * @dev: device for clock "consumer"
@@ -1052,12 +1036,6 @@ static inline int __must_check devm_clk_bulk_get_all(struct device *dev,
 	return 0;
 }
 
-static inline int __must_check devm_clk_bulk_get_all_enable(struct device *dev,
-						struct clk_bulk_data **clks)
-{
-	return 0;
-}
-
 static inline int __must_check devm_clk_bulk_get_all_enabled(struct device *dev,
 						struct clk_bulk_data **clks)
 {

-- 
2.47.0


