Return-Path: <linux-pci+bounces-3395-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9AC08532DA
	for <lists+linux-pci@lfdr.de>; Tue, 13 Feb 2024 15:19:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54E5E1F22CB1
	for <lists+linux-pci@lfdr.de>; Tue, 13 Feb 2024 14:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8185786C;
	Tue, 13 Feb 2024 14:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="QYy0ycTT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D538357330
	for <linux-pci@vger.kernel.org>; Tue, 13 Feb 2024 14:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707833983; cv=none; b=QfpPo5sR1tnLoOJS7HcvnJ20fguoxU9hM1LPOSqaxlS2wjrBOAHYVN90uouTuWW23GoMzLnkE0dB+b3OYkk/9zcLHmTXUojSfiVcC+7e5JvFfl5F7RdJUemawpN4ciHN9/Aoku+GyjJQUUkE3p/1P+J5q1zwrNORk29+vvh237o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707833983; c=relaxed/simple;
	bh=zbzPPSabaMhS5zlq5Te5dWZ0Y9LqScaRObnVnALmG+M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:Content-Type:
	 References; b=qWfRClg0xLLuCb0pO+paDYYa/IxwcMrTce+rEmnlLnuwi/YnDI8yF67bkbQuqJX9rQgq7cRVZ/OjBKH7ss2e1xiiNbibG9D+B+9530oQDkIASpVEj+zZLGrDQNGhrRLe0si7Z3AkBN5STWBx8vfjx8+9llnrPNvbfqIF9FLwA8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=QYy0ycTT; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240213141939epoutp01f90aebe837a38e0641a5bb4942072637~zcfSd2jFI2496324963epoutp01e
	for <linux-pci@vger.kernel.org>; Tue, 13 Feb 2024 14:19:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240213141939epoutp01f90aebe837a38e0641a5bb4942072637~zcfSd2jFI2496324963epoutp01e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1707833979;
	bh=3zGQ1oxr7yCITgN88Ri0vXnCSaCy2H7gBnROLiuaNKE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QYy0ycTTnJSC2wb0ZT+uLYpkTOpkHeuHXhWDqvDBYh2HHDux2vDizlhwsDWPGBfvU
	 ed8RydOX23quFDtfxC7du6pdm9n8viEsJF9RMCND5ou6KK2ZrKYgOjYQr8wPm3ruQs
	 TeNcN5u1VC+4PQQRoy3rTbgPUmsr8/tcDzsx77Zw=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20240213141938epcas5p4e0c9e26267f337bed876ee3a4c904970~zcfRyELnd0084600846epcas5p4f;
	Tue, 13 Feb 2024 14:19:38 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.181]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4TZ3P40Nh7z4x9Pv; Tue, 13 Feb
	2024 14:19:36 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	A8.A4.19369.77A7BC56; Tue, 13 Feb 2024 23:19:35 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20240213132806epcas5p43e394aea91c61797a8cc3a901e0cf574~zbyR5q_xn2842628426epcas5p4f;
	Tue, 13 Feb 2024 13:28:06 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240213132806epsmtrp28cf7afb7c47021231d8ee5626e4ca975~zbyR4h1T_2153621536epsmtrp2T;
	Tue, 13 Feb 2024 13:28:06 +0000 (GMT)
X-AuditID: b6c32a50-c99ff70000004ba9-94-65cb7a777f6b
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	77.C1.08755.56E6BC56; Tue, 13 Feb 2024 22:28:05 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
	[107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240213132803epsmtip1037fa163159be1ef1651bb5ca5bdbe8c~zbyPK56ms1216112161epsmtip1S;
	Tue, 13 Feb 2024 13:28:03 +0000 (GMT)
From: Shradha Todi <shradha.t@samsung.com>
To: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org
Cc: mturquette@baylibre.com, sboyd@kernel.org, jingoohan1@gmail.com,
	lpieralisi@kernel.org, kw@linux.com, robh@kernel.org, bhelgaas@google.com,
	krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com,
	linux@armlinux.org.uk, m.szyprowski@samsung.com,
	manivannan.sadhasivam@linaro.org, pankaj.dubey@samsung.com,
	gost.dev@samsung.com, Shradha Todi <shradha.t@samsung.com>
Subject: [PATCH v5 1/2] clk: Provide managed helper to get and enable bulk
 clocks
Date: Tue, 13 Feb 2024 18:57:50 +0530
Message-Id: <20240213132751.46813-2-shradha.t@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240213132751.46813-1-shradha.t@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOJsWRmVeSWpSXmKPExsWy7bCmhm551elUg+8rrC0ezNvGZrGkKcPi
	5oGdTBYrvsxkt9j7eiu7RUPPb1aLTY+vsVp87LnHanF51xw2i7PzjrNZzDi/j8ni0NS9jBYt
	f1pYLNYeuctucbelk9Xi4ilXi0Vbv7Bb/N+zg93i37WNLBa9h2sdRDwuX7vI7PH+Riu7x85Z
	d9k9Fmwq9di0qpPN4861PWweT65MZ/LYvKTeo2/LKkaPz5vkAriism0yUhNTUosUUvOS81My
	89JtlbyD453jTc0MDHUNLS3MlRTyEnNTbZVcfAJ03TJzgH5TUihLzCkFCgUkFhcr6dvZFOWX
	lqQqZOQXl9gqpRak5BSYFOgVJ+YWl+al6+WlllgZGhgYmQIVJmRnLJ+/gbFgv1TFwiXLGRsY
	n4p2MXJySAiYSLTPf8/WxcjFISSwh1Hif9McRgjnE6PElNf/mSGcb4wSE8/OY4ZpOdHYwQhi
	CwnsZZRoXWoCUdTKJLHz82dWkASbgJZE49cusG4RgcWMErd2bGYFcZgFfjFJ7GvcxNTFyMEh
	LBAs8eYy2CEsAqoSH1YeYwKxeQWsJDb82QW1TV5i9YYDYDangLXEge0PweZICJzhkHh0Zx0T
	RJGLxNbJr9ghbGGJV8e3QNlSEp/f7WWDsNMlVm6eATU0R+Lb5iVQvfYSB67MYQG5h1lAU2L9
	Ln2IsKzE1FMQ45kF+CR6fz+BKueV2DEPxlaW+PJ3DwuELSkx79hlVgjbQ2LqpxZooPYxSpy9
	/IVtAqPcLIQVCxgZVzFKpRYU56anJpsWGOrmpZbD4y05P3cTIzgFawXsYFy94a/eIUYmDsZD
	jBIczEoivJdmnEgV4k1JrKxKLcqPLyrNSS0+xGgKDMGJzFKiyfnALJBXEm9oYmlgYmZmZmJp
	bGaoJM77unVuipBAemJJanZqakFqEUwfEwenVANTSGa92/z/gW6aD+o33Xzk07/hfF9NgyLH
	BZPM3sO5c444zPq66Im2RdwBCxG/P8fKvapmr2dw3BMQmxH37X3q1gLxQy28f8OrWzPtrevX
	2L51+Pjwc6X8hdCzv9x+a1pwPjFM+ZhXeI3r4zl91rLftflLwvzcyqZtPrvV7u98w0ZbjfbH
	8w68k9dcZ/HD4rmqxVE7jqj6vff7VIu/i5ocK+OVlHpxIrbUQ77qTPOPqEXHlq76u7VuitW8
	Ric9l/eOt68bLX8ym9sr8DD/jhu/Jmw9ZNKpFvq1OK0uT5ntP/uVnZlWwhM38nYwlesc47uq
	abN/XuIL8cbX+wNqHbyMLs3mKyxpXz5DdHqm5A4lluKMREMt5qLiRABFnukUSgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDLMWRmVeSWpSXmKPExsWy7bCSnG5q3ulUg0NPrSwezNvGZrGkKcPi
	5oGdTBYrvsxkt9j7eiu7RUPPb1aLTY+vsVp87LnHanF51xw2i7PzjrNZzDi/j8ni0NS9jBYt
	f1pYLNYeuctucbelk9Xi4ilXi0Vbv7Bb/N+zg93i37WNLBa9h2sdRDwuX7vI7PH+Riu7x85Z
	d9k9Fmwq9di0qpPN4861PWweT65MZ/LYvKTeo2/LKkaPz5vkAriiuGxSUnMyy1KL9O0SuDKW
	z9/AWLBfqmLhkuWMDYxPRbsYOTkkBEwkTjR2MHYxcnEICexmlLg/8S4jREJS4vPFdUwQtrDE
	yn/P2SGKmpkk3mx5ww6SYBPQkmj82sUMkhARWM4o8fPkU7AOZoEeZokDrSFdjBwcwgKBEgc7
	DEHCLAKqEh9WHgMr4RWwktjwZxczxAJ5idUbDoDZnALWEge2P2QFsYWAava0r2WawMi3gJFh
	FaNkakFxbnpusWGBYV5quV5xYm5xaV66XnJ+7iZGcIRoae5g3L7qg94hRiYOxkOMEhzMSiK8
	l2acSBXiTUmsrEotyo8vKs1JLT7EKM3BoiTOK/6iN0VIID2xJDU7NbUgtQgmy8TBKdXAtH3S
	12hPj8VeX40fviou0Etb+neGwRfj+19eWBavi2s3TOjnPjXjwPQj155d4f3qH3E5J4Tp0OY0
	G9UTbrx3z/DsVHB8/0Stt8/Qr7x5ZnxwaJxFm4vD3F/Pn59ZlPbmTWyzquWq5+Zrrf5fM4nh
	b9bq2Opv2CZacF1Rl1NYSXlH7GL2olO7mDy+fNy+tmXi4Qd/HJoyFP70zt+ZumRLi1eH5fbv
	HV3zu2XeXro2M89pztqXTa1rWdj8VzCfkV096ah8xEQel809tnzbjm57//BHwUSnDwIxrcmH
	/U/Mkq9dOkf9zOuYa4yvnM3W71+wSOHDE+60aUfPCpc1isw7uUxrWtjFiIthOx5sLhFc36rE
	UpyRaKjFXFScCAArY9pa/wIAAA==
X-CMS-MailID: 20240213132806epcas5p43e394aea91c61797a8cc3a901e0cf574
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240213132806epcas5p43e394aea91c61797a8cc3a901e0cf574
References: <20240213132751.46813-1-shradha.t@samsung.com>
	<CGME20240213132806epcas5p43e394aea91c61797a8cc3a901e0cf574@epcas5p4.samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Provide a managed devm_clk_bulk* wrapper to get and enable all
bulk clocks in order to simplify drivers that keeps all clocks
enabled for the time of driver operation.

Suggested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>
Signed-off-by: Shradha Todi <shradha.t@samsung.com>
---
 drivers/clk/clk-devres.c | 40 ++++++++++++++++++++++++++++++++++++++++
 include/linux/clk.h      | 23 +++++++++++++++++++++++
 2 files changed, 63 insertions(+)

diff --git a/drivers/clk/clk-devres.c b/drivers/clk/clk-devres.c
index 4fb4fd4b06bd..cbbd2cc339c3 100644
--- a/drivers/clk/clk-devres.c
+++ b/drivers/clk/clk-devres.c
@@ -182,6 +182,46 @@ int __must_check devm_clk_bulk_get_all(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(devm_clk_bulk_get_all);
 
+static void devm_clk_bulk_release_all_enable(struct device *dev, void *res)
+{
+	struct clk_bulk_devres *devres = res;
+
+	clk_bulk_disable_unprepare(devres->num_clks, devres->clks);
+	clk_bulk_put_all(devres->num_clks, devres->clks);
+}
+
+int __must_check devm_clk_bulk_get_all_enable(struct device *dev,
+					      struct clk_bulk_data **clks)
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
+	if (ret > 0) {
+		*clks = devres->clks;
+		devres->num_clks = ret;
+	} else {
+		devres_free(devres);
+		return ret;
+	}
+
+	ret = clk_bulk_prepare_enable(devres->num_clks, *clks);
+	if (!ret) {
+		devres_add(dev, devres);
+	} else {
+		clk_bulk_put_all(devres->num_clks, devres->clks);
+		devres_free(devres);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(devm_clk_bulk_get_all_enable);
+
 static int devm_clk_match(struct device *dev, void *res, void *data)
 {
 	struct clk **c = res;
diff --git a/include/linux/clk.h b/include/linux/clk.h
index 1ef013324237..85a9330d5a5a 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -438,6 +438,22 @@ int __must_check devm_clk_bulk_get_optional(struct device *dev, int num_clks,
 int __must_check devm_clk_bulk_get_all(struct device *dev,
 				       struct clk_bulk_data **clks);
 
+/**
+ * devm_clk_bulk_get_all_enable - Get and enable all clocks of the consumer (managed)
+ * @dev: device for clock "consumer"
+ * @clks: pointer to the clk_bulk_data table of consumer
+ *
+ * Returns success (0) or negative errno.
+ *
+ * This helper function allows drivers to get all clocks of the
+ * consumer and enables them in one operation with management.
+ * The clks will automatically be disabled and freed when the device
+ * is unbound.
+ */
+
+int __must_check devm_clk_bulk_get_all_enable(struct device *dev,
+					      struct clk_bulk_data **clks);
+
 /**
  * devm_clk_get - lookup and obtain a managed reference to a clock producer.
  * @dev: device for clock "consumer"
@@ -960,6 +976,13 @@ static inline int __must_check devm_clk_bulk_get_all(struct device *dev,
 	return 0;
 }
 
+static inline int __must_check devm_clk_bulk_get_all_enable(struct device *dev,
+						struct clk_bulk_data **clks)
+{
+
+	return 0;
+}
+
 static inline struct clk *devm_get_clk_from_child(struct device *dev,
 				struct device_node *np, const char *con_id)
 {
-- 
2.17.1


