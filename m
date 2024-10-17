Return-Path: <linux-pci+bounces-14829-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB309A3140
	for <lists+linux-pci@lfdr.de>; Fri, 18 Oct 2024 01:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F6381C22F7F
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 23:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427772296FE;
	Thu, 17 Oct 2024 23:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="SOKZq4Ok"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E5D1F4299;
	Thu, 17 Oct 2024 23:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729207076; cv=none; b=QMcuE+qypExh3r4SBlxA3C8KHLO8NUd/RI69kk0Kf3eShiXKIgvwLGyeNnqsegXfHvAfoDnNhRSbo9H/pjapSxOKqUocvBxI+hbTgFhXFjLTW5whkLa9wipXF5BgJJcGF4T1y9umFzLbV2ipXVg6J+PbowQFYu607hqdw10lUek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729207076; c=relaxed/simple;
	bh=gmHCYMEBb8C25V0D6R/CZXdticXewklOMZwOmzHOpTY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RPwPKGTXSwiBAUXuFTT7kduY/XvrCTDX7dznLCvUQOAY32gzP/zksPzQVkC1yDz7Q5nkQAqFjmWEby6YcpBfMXsf6lKrip2MT7tYk8AwTEBv62vluB2UpowIvdNhkcb3ILUgMr2TdBLIGvjeGZl/cOAdDHbFMkFtzDM0QXAi4fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=SOKZq4Ok; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1729207072;
	bh=gmHCYMEBb8C25V0D6R/CZXdticXewklOMZwOmzHOpTY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SOKZq4OkphL85FOM+b5RqVc+9FoRVEtIsgIK4tYnUc5gJRiPOl9IHaYJmjMSRU/XU
	 USiyNJWwCmrOXnNrh3RHT6nC54NFieYXzqw5hNC/OvprY2K7ztVXUfKGtb03qnemNK
	 MelolRe2QsK3LgMiNi3abaRZk5owJ9QJF2Poc9PEBYOQzrI+H4urbkwcN5ApbuIFY2
	 knvU98INGQgHbPLmrfH0NhEqk0ENi4Uf0rOnjhm4y/Mqe4xPaNsUQozayOFRBR5lvR
	 85F+nxIlNnGLQZZlVasgBmhEp/MOXd07f+0E7jhBaufwypmcm24hprNV8ZboTvevfK
	 6zHRcM/dHh+oQ==
Received: from localhost (unknown [188.24.146.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2A00217E0E01;
	Fri, 18 Oct 2024 01:17:52 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Fri, 18 Oct 2024 02:17:29 +0300
Subject: [PATCH v3 1/4] clk: Provide devm_clk_bulk_get_all_enabled() helper
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241018-clk_bulk_ena_fix-v3-1-57e8bb82460c@collabora.com>
References: <20241018-clk_bulk_ena_fix-v3-0-57e8bb82460c@collabora.com>
In-Reply-To: <20241018-clk_bulk_ena_fix-v3-0-57e8bb82460c@collabora.com>
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
 drivers/clk/clk-devres.c | 35 +++++++++++++++++++++++------------
 include/linux/clk.h      | 24 ++++++++++++++++++++++++
 2 files changed, 47 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/clk-devres.c b/drivers/clk/clk-devres.c
index 82ae1f26e634572b943d18b8d86267f0a69911a6..0d0fe364b66a8590d5e7c63dc6c1e70c59d53e89 100644
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
@@ -230,25 +239,27 @@ int __must_check devm_clk_bulk_get_all_enable(struct device *dev,
 		return -ENOMEM;
 
 	ret = clk_bulk_get_all(dev, &devres->clks);
-	if (ret > 0) {
-		*clks = devres->clks;
-		devres->num_clks = ret;
-	} else {
-		devres_free(devres);
-		return ret;
-	}
+	if (ret <= 0)
+		goto err_free_devres;
+
+	*clks = devres->clks;
+	devres->num_clks = ret;
 
 	ret = clk_bulk_prepare_enable(devres->num_clks, *clks);
-	if (!ret) {
-		devres_add(dev, devres);
-	} else {
+	if (ret) {
 		clk_bulk_put_all(devres->num_clks, devres->clks);
-		devres_free(devres);
+		goto err_free_devres;
 	}
 
+	devres_add(dev, devres);
+
+	return devres->num_clks;
+
+err_free_devres:
+	devres_free(devres);
 	return ret;
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


