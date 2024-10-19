Return-Path: <linux-pci+bounces-14905-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E2F9A4D00
	for <lists+linux-pci@lfdr.de>; Sat, 19 Oct 2024 13:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D0921F22C9B
	for <lists+linux-pci@lfdr.de>; Sat, 19 Oct 2024 11:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E201DFE3F;
	Sat, 19 Oct 2024 11:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="qVU66crB"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C01B1DE4CE;
	Sat, 19 Oct 2024 11:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729336577; cv=none; b=njon1o3nAL7wykFg5eYT4ZWdbMV3aSg48UVo/QEyql/U3dHY0ANtyVesj0qKbCTFPR8V9WIgY7ZRjC4gQIwYg/5MrvuXmGRK2sejRXB8PtZubGyihf63A+tOlLMljvfqGJe/6hv1rfZCiBPoiW3vHIVsEIguY3F/6vg4x43eMug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729336577; c=relaxed/simple;
	bh=liu6AH5wskPRdG1LJazp0t8ejwo/RTs1GpUY5J41pVw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GTkTs45UyRjRQcb1P4/03cQ+QkivW8T6MBP1m9Cl6iSVqYFHGzLsfvGcDEgVAysBgR6ab7/YLYVX3sn8SbDXKl5kqKemtABqxbBPaCmJW7T/fCcBQnVwl0+scPugZfXc4SZ7UhD1aBxRlbV2Ztf23O1YCnrRlOuwdTa/YGnKDhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=qVU66crB; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1729336572;
	bh=liu6AH5wskPRdG1LJazp0t8ejwo/RTs1GpUY5J41pVw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qVU66crBEtIarbBDM6UIaDebVYjVUIqq9OgLgGDj/8Plf7LeI/V/sFpOGlKHsdhph
	 5ZZYcIUQD8ImZqmXdLA3Uyyz5A9ifyoQUXHvNz3KQiZxB4kReTVC/2+OiyTZlvR77O
	 cQ8xAZRL2dFGwrzDlTQvPpu/aEnGQvg8sYFCfZIcslV8FCJyD5UGMe+G1YpdKXINCQ
	 aeNuUo4mr/DHSmje3jF2qm8scIs3dBfWutk5aTjGkaqGYNTcQvwb9He/TzdF9zPUvk
	 bZYFBJcD/znLVQxZMtcP9szYy7cxKI0bPwaeTl7zUGlann8CCS/xylJdgPozDzxAdp
	 vXBh9Ea7uMeyQ==
Received: from localhost (unknown [188.24.146.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 699C017E35CB;
	Sat, 19 Oct 2024 13:16:12 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Sat, 19 Oct 2024 14:16:00 +0300
Subject: [PATCH v4 1/4] clk: Provide devm_clk_bulk_get_all_enabled() helper
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241019-clk_bulk_ena_fix-v4-1-57f108f64e70@collabora.com>
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

Introduce devm_clk_bulk_get_all_enabled() variant, which is consistent
with devm_clk_bulk_get_all() in terms of the returned value:

 > 0 if one or more clocks have been stored
 = 0 if there are no clocks
 < 0 if an error occurred

Moreover, the naming is consistent with devm_clk_get_enabled(), i.e. use
the past form of 'enable'.

To reduce code duplication and improve patch readability, make
devm_clk_bulk_get_all_enable() use the new helper, as suggested by
Stephen Boyd.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/clk/clk-devres.c | 28 +++++++++++++++++++---------
 include/linux/clk.h      | 24 ++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/clk-devres.c b/drivers/clk/clk-devres.c
index 82ae1f26e634572b943d18b8d86267f0a69911a6..975fac29b27f3709e292531a114975c9108287db 100644
--- a/drivers/clk/clk-devres.c
+++ b/drivers/clk/clk-devres.c
@@ -220,6 +220,15 @@ static void devm_clk_bulk_release_all_enable(struct device *dev, void *res)
 
 int __must_check devm_clk_bulk_get_all_enable(struct device *dev,
 					      struct clk_bulk_data **clks)
+{
+	int ret = devm_clk_bulk_get_all_enabled(dev, clks);
+
+	return ret > 0 ? 0 : ret;
+}
+EXPORT_SYMBOL_GPL(devm_clk_bulk_get_all_enable);
+
+int __must_check devm_clk_bulk_get_all_enabled(struct device *dev,
+					       struct clk_bulk_data **clks)
 {
 	struct clk_bulk_devres *devres;
 	int ret;
@@ -230,25 +239,26 @@ int __must_check devm_clk_bulk_get_all_enable(struct device *dev,
 		return -ENOMEM;
 
 	ret = clk_bulk_get_all(dev, &devres->clks);
-	if (ret > 0) {
-		*clks = devres->clks;
-		devres->num_clks = ret;
-	} else {
+	if (ret <= 0) {
 		devres_free(devres);
 		return ret;
 	}
 
+	*clks = devres->clks;
+	devres->num_clks = ret;
+
 	ret = clk_bulk_prepare_enable(devres->num_clks, *clks);
-	if (!ret) {
-		devres_add(dev, devres);
-	} else {
+	if (ret) {
 		clk_bulk_put_all(devres->num_clks, devres->clks);
 		devres_free(devres);
+		return ret;
 	}
 
-	return ret;
+	devres_add(dev, devres);
+
+	return devres->num_clks;
 }
-EXPORT_SYMBOL_GPL(devm_clk_bulk_get_all_enable);
+EXPORT_SYMBOL_GPL(devm_clk_bulk_get_all_enabled);
 
 static int devm_clk_match(struct device *dev, void *res, void *data)
 {
diff --git a/include/linux/clk.h b/include/linux/clk.h
index 851a0f2cf42c8c1bbada49d991bc185587942155..158c5072852e36c1583dc47ca7516fcdd928fe59 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -511,6 +511,24 @@ int __must_check devm_clk_bulk_get_all(struct device *dev,
 int __must_check devm_clk_bulk_get_all_enable(struct device *dev,
 					      struct clk_bulk_data **clks);
 
+/**
+ * devm_clk_bulk_get_all_enabled - Get and enable all clocks of the consumer (managed)
+ * @dev: device for clock "consumer"
+ * @clks: pointer to the clk_bulk_data table of consumer
+ *
+ * Returns a positive value for the number of clocks obtained while the
+ * clock references are stored in the clk_bulk_data table in @clks field.
+ * Returns 0 if there're none and a negative value if something failed.
+ *
+ * This helper function allows drivers to get all clocks of the
+ * consumer and enables them in one operation with management.
+ * The clks will automatically be disabled and freed when the device
+ * is unbound.
+ */
+
+int __must_check devm_clk_bulk_get_all_enabled(struct device *dev,
+					       struct clk_bulk_data **clks);
+
 /**
  * devm_clk_get - lookup and obtain a managed reference to a clock producer.
  * @dev: device for clock "consumer"
@@ -1040,6 +1058,12 @@ static inline int __must_check devm_clk_bulk_get_all_enable(struct device *dev,
 	return 0;
 }
 
+static inline int __must_check devm_clk_bulk_get_all_enabled(struct device *dev,
+						struct clk_bulk_data **clks)
+{
+	return 0;
+}
+
 static inline struct clk *devm_get_clk_from_child(struct device *dev,
 				struct device_node *np, const char *con_id)
 {

-- 
2.47.0


