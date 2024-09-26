Return-Path: <linux-pci+bounces-13556-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DDDB9871E6
	for <lists+linux-pci@lfdr.de>; Thu, 26 Sep 2024 12:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3E2528A10E
	for <lists+linux-pci@lfdr.de>; Thu, 26 Sep 2024 10:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2191AF4C9;
	Thu, 26 Sep 2024 10:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="csL3aoqw"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648E71AE847;
	Thu, 26 Sep 2024 10:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727347439; cv=none; b=F4s0boYaDgJJDl4iNqi4bd4Afoh6UHnLQywcnsXiRvoB7kND6SJtJAx9h8zBrFkH7/T6o7nw0UZEwbkGF573QNR6bwJZNIEfW661o2Jda7NNl6vWushUtu39+UVfHiY/5TQ2C9QJasPYfEkOmqHwHo/LPHpHnnlra1KFLvLAm8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727347439; c=relaxed/simple;
	bh=QSefnkYbeJQLKEl46cPPnS84RWiz8yqsgAOOcJvZ+S8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=avj8knzNpsgrIydUEQz/irUi65RV8GSWw7TvwB+jrmDc+Tx0j+gfEvzDLikgaYGRGD2UPP6Lv2QnHtBBueoVRnTMYA57/CIYaOJy6H0KjDBg4I/+R2QHZbjqOkBhD6Wf5gvjSaSneRyQWZyH0unqs2imHFqN614VfscJx97RbX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=csL3aoqw; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1727347435;
	bh=QSefnkYbeJQLKEl46cPPnS84RWiz8yqsgAOOcJvZ+S8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=csL3aoqwJ2tZ5c2MZm1ia7VW8ud4ZlEYUx3VGM/D/VqTvUrDibvpRjS5go5uzJ+j/
	 qiqdpHDH/uVCMFT2tTRSda0PCpyM1TpDv8TRumghyVKQlpDX6GwfvHeLKXhTfAD2By
	 XjLxH3U92QeQPRzfd05wbBgYntw99aKsuVlvnoVzFvIIjFE18Lwga1a3Ar4Ya1coZu
	 RANyFomHuSrVHS+Zra/iPX/S83ubjNBjcZXDq9/P7dM0pSd2IjLsovapuVcpzHtH5Q
	 /rOKUbElLsee7nKvCABXPQnZXAkN69lUjrE9jmKNvaqzyAus5eFJNvXFQimGT28XY7
	 Ox3Y0PZ77CQlQ==
Received: from localhost (unknown [IPv6:2a01:e0a:d1a:1250:792b:136f:2a18:fd70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8BDB917E121F;
	Thu, 26 Sep 2024 12:43:55 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Thu, 26 Sep 2024 13:43:23 +0300
Subject: [PATCH v2 4/4] clk: Drop obsolete devm_clk_bulk_get_all_enable()
 helper
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240926-clk_bulk_ena_fix-v2-4-9c767510fbb5@collabora.com>
References: <20240926-clk_bulk_ena_fix-v2-0-9c767510fbb5@collabora.com>
In-Reply-To: <20240926-clk_bulk_ena_fix-v2-0-9c767510fbb5@collabora.com>
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
X-Mailer: b4 0.14.1

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
 drivers/clk/clk-devres.c | 32 --------------------------------
 include/linux/clk.h      | 22 ----------------------
 2 files changed, 54 deletions(-)

diff --git a/drivers/clk/clk-devres.c b/drivers/clk/clk-devres.c
index 4203aaaa7544..14a657f336fe 100644
--- a/drivers/clk/clk-devres.c
+++ b/drivers/clk/clk-devres.c
@@ -218,38 +218,6 @@ static void devm_clk_bulk_release_all_enable(struct device *dev, void *res)
 	clk_bulk_put_all(devres->num_clks, devres->clks);
 }
 
-int __must_check devm_clk_bulk_get_all_enable(struct device *dev,
-					      struct clk_bulk_data **clks)
-{
-	struct clk_bulk_devres *devres;
-	int ret;
-
-	devres = devres_alloc(devm_clk_bulk_release_all_enable,
-			      sizeof(*devres), GFP_KERNEL);
-	if (!devres)
-		return -ENOMEM;
-
-	ret = clk_bulk_get_all(dev, &devres->clks);
-	if (ret > 0) {
-		*clks = devres->clks;
-		devres->num_clks = ret;
-	} else {
-		devres_free(devres);
-		return ret;
-	}
-
-	ret = clk_bulk_prepare_enable(devres->num_clks, *clks);
-	if (!ret) {
-		devres_add(dev, devres);
-	} else {
-		clk_bulk_put_all(devres->num_clks, devres->clks);
-		devres_free(devres);
-	}
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(devm_clk_bulk_get_all_enable);
-
 int __must_check devm_clk_bulk_get_all_enabled(struct device *dev,
 					       struct clk_bulk_data **clks)
 {
diff --git a/include/linux/clk.h b/include/linux/clk.h
index 158c5072852e..b607482ca77e 100644
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
2.46.1


