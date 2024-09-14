Return-Path: <linux-pci+bounces-13215-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 438A29792CF
	for <lists+linux-pci@lfdr.de>; Sat, 14 Sep 2024 20:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAA901F2242A
	for <lists+linux-pci@lfdr.de>; Sat, 14 Sep 2024 18:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372CF1D1F55;
	Sat, 14 Sep 2024 18:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="BWS0aQzl"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A961D0155;
	Sat, 14 Sep 2024 18:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726337135; cv=none; b=WLPHPMj3oDnqB5Qt3cUllM07iV4Zert0qYkBhaH39nWZts/8cwkLUaloUxPkYMpxZa2VaWP84ZA0LOtqh+AdPOLVnkds9gZsV9tmiaDrSB9f0ZUUsKG+tJl52pv4u9/YwW2xmmIynxGXVb+EyHmLDwMJdWWuCVK/RV+dC2QQ1Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726337135; c=relaxed/simple;
	bh=YBD7ROn/m+4hx/YE8/G04zWv2dlzT0LgAGoiccmV39I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m3stud7DJDF1cG3wjbhPSxpfSyQURPxwp26WnRgV/W8ubyXaNPMwdQ7P4Bc0HBM8AOre2M72QtXFz+46f4Im2FpiyvcE9KZXC1zBH+XE6Eb9hrLjqtV03uGnj2b0ycPyjPOwNB74jyVfQ9WxQXE8CRcvMBgxnD2J/bIp60/oQ+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=BWS0aQzl; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1726337131;
	bh=YBD7ROn/m+4hx/YE8/G04zWv2dlzT0LgAGoiccmV39I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BWS0aQzlUguFPj0Ycf7Wj9K5lKxfLxazx4z3WKI1UY6jLRH0huKQSQnhhDqPjWa9g
	 NfcX5LKO4u9/0MtO1BVZTDDPua1c5jA/EhQ48cLYKi795ApaOQFJu1rQXb+LA+iNOi
	 AZEvHsQ1XiWgFZwDXadcatZzL6V6EOgJVhDWnoUDDzazGku1CV5hNFJhxoKR6bphyp
	 pmrEoOYjRfx8G0NJyLvFkj6T4oWMb+4zGn8s3OgEMAbDOUGd+S0WhT27ldI9R4eh6/
	 oYgDTqd9XMDdj/2xerelohtedgH8VJYZUxltnoRGqaJnrIaTklwpi086keA5voklRg
	 PVyQpx1qjIKsA==
Received: from localhost (unknown [188.27.55.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0DD6717E3608;
	Sat, 14 Sep 2024 20:05:31 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Sat, 14 Sep 2024 21:04:54 +0300
Subject: [PATCH 1/4] clk: Provide devm_clk_bulk_get_all_enabled() helper
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240914-clk_bulk_ena_fix-v1-1-ce3537585c06@collabora.com>
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

Introduce devm_clk_bulk_get_all_enabled() variant, which is consistent
with devm_clk_bulk_get_all() in terms of the returned value:

 > 0 if one or more clocks have been stored
 = 0 if there are no clocks
 < 0 if an error occurred

Moreover, the naming is consistent with devm_clk_get_enabled(), i.e. use
the past form of 'enable'.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/clk/clk-devres.c | 34 ++++++++++++++++++++++++++++++++++
 include/linux/clk.h      | 24 ++++++++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/drivers/clk/clk-devres.c b/drivers/clk/clk-devres.c
index 82ae1f26e634..4203aaaa7544 100644
--- a/drivers/clk/clk-devres.c
+++ b/drivers/clk/clk-devres.c
@@ -250,6 +250,40 @@ int __must_check devm_clk_bulk_get_all_enable(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(devm_clk_bulk_get_all_enable);
 
+int __must_check devm_clk_bulk_get_all_enabled(struct device *dev,
+					       struct clk_bulk_data **clks)
+{
+	struct clk_bulk_devres *devres;
+	int ret;
+
+	devres = devres_alloc(devm_clk_bulk_release_all_enable,
+			      sizeof(*devres), GFP_KERNEL);
+	if (!devres)
+		return -ENOMEM;
+
+	ret = clk_bulk_get_all(dev, &devres->clks);
+	if (ret <= 0)
+		goto err_free_devres;
+
+	*clks = devres->clks;
+	devres->num_clks = ret;
+
+	ret = clk_bulk_prepare_enable(devres->num_clks, *clks);
+	if (ret) {
+		clk_bulk_put_all(devres->num_clks, devres->clks);
+		goto err_free_devres;
+	}
+
+	devres_add(dev, devres);
+
+	return devres->num_clks;
+
+err_free_devres:
+	devres_free(devres);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(devm_clk_bulk_get_all_enabled);
+
 static int devm_clk_match(struct device *dev, void *res, void *data)
 {
 	struct clk **c = res;
diff --git a/include/linux/clk.h b/include/linux/clk.h
index 851a0f2cf42c..158c5072852e 100644
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
2.46.0


