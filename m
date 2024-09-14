Return-Path: <linux-pci+bounces-13218-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D119792DC
	for <lists+linux-pci@lfdr.de>; Sat, 14 Sep 2024 20:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C86771C2135B
	for <lists+linux-pci@lfdr.de>; Sat, 14 Sep 2024 18:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C79B1D319B;
	Sat, 14 Sep 2024 18:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="PiLdGvn1"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7B71D1F68;
	Sat, 14 Sep 2024 18:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726337137; cv=none; b=O1beia1fkOkTPNLH/RbuntUF6Cu6DaxvSPr+St5nnI8VNqY+gA2g+OWySKwtc/yLpGSJQF7XkkIgcOLJzvlVT+w8s8DTm4SG3OPfRDWhRWrN0q2TBETICOcNhgONCLSh1pq3kriT17SspYTZLi3Ng13vHWJXiPybZMVpmyqY+bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726337137; c=relaxed/simple;
	bh=bX3hfSvdivSwqj787dVv//EFjHQaHvkTiKg8rAMVnOA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=adN/PMw4l+Ga50LgxDlUCrktuXVE4NNctJ9wies+GyKnizvj6MtKCsTuanNHM0awIbSKFoZE3PCHG8j8QLID7ZfRc1bZ5NNtCgnBt7Z6hsQOfRTXA9zG6Cb6R1TyLYAaLJRobUeZyUDG6rmfVhS8O1veiX6ihTrFpeahj1OHHPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=PiLdGvn1; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1726337133;
	bh=bX3hfSvdivSwqj787dVv//EFjHQaHvkTiKg8rAMVnOA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PiLdGvn1mF6o4/igmFmYwt5NOUNLrTMBo7g10pSJbl3riizN5P9WV2t2abw5+N255
	 aO1EQTfE76P2tfpvQZQk+L3/VHoMZY8W5ghfjmBZ2tQ5F195dUQe91afNPmrJmudjL
	 SWyfRqs6wd5mKbN0RbolVG1gGKW2GsmKo7Y+N+HktoHBx9siqcljeiIfKrQFXj2PdV
	 OV3+QjiSUq1qFFDir/FJSFq/BrgvB+uLn56QVKmhPpj2FmGXPxHrAiA8QF07TalXIu
	 sx3VltxJ7gjejJniMqPAiLqeDEVHdg5WiH0pqh+uT72zfLYbRYHwAXyKRxn9MzgIr6
	 KXvLG5dFRG1aw==
Received: from localhost (unknown [188.27.55.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7F83C17E360F;
	Sat, 14 Sep 2024 20:05:33 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Sat, 14 Sep 2024 21:04:57 +0300
Subject: [PATCH 4/4] clk: Drop obsolete devm_clk_bulk_get_all_enable()
 helper
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240914-clk_bulk_ena_fix-v1-4-ce3537585c06@collabora.com>
References: <20240914-clk_bulk_ena_fix-v1-0-ce3537585c06@collabora.com>
In-Reply-To: <20240914-clk_bulk_ena_fix-v1-0-ce3537585c06@collabora.com>
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
2.46.0


