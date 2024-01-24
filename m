Return-Path: <linux-pci+bounces-2519-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB4D83A87C
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jan 2024 12:49:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4097B21F0D
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jan 2024 11:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9962C6A1;
	Wed, 24 Jan 2024 11:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Zx3Sgs3f"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DAA059173
	for <linux-pci@vger.kernel.org>; Wed, 24 Jan 2024 11:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706096873; cv=none; b=uk3keTkvYmsqoeznahlwT/NxOX1rhAQTebxyRRBZpd32LmQ+NOzqZIeL2ROJShKl6QLRcU/ltVsHZt0MXGn57a7u5HsRJgTQl09vLD40VGrR5wGzFvGKPpZ6Mvdn1iWBcZTYz2rIVGwS75I5LbcjHQsDhSK0AJwhC1lXVosKk+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706096873; c=relaxed/simple;
	bh=Q2Lv21q+LPYK+1GamQvuvIuUxtbkeVPHvD2B7RxGgdg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:Content-Type:
	 References; b=CA+/OPeD07TDZ1rQeW9xgWNJzpnmnyESYk3ymnRNOzN1/fK/ffEiJpnvxCzkoCfEt8ths+cL6cLLb+JKnDIiDVVMwu5JuGj0PvVJfJTesVTmGMw9bDazG0bahbs6M8Kc4Mji0Hy7r2YIUk9PqCgyI98rqxDE0/upSD3UpYummUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Zx3Sgs3f; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240124114749epoutp0438e3078de9fbc2de2d1a048826c5340b~tRhBG5G_i1012210122epoutp04y
	for <linux-pci@vger.kernel.org>; Wed, 24 Jan 2024 11:47:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240124114749epoutp0438e3078de9fbc2de2d1a048826c5340b~tRhBG5G_i1012210122epoutp04y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1706096869;
	bh=O+tABnUnHrJhacFqwRIfEaygao34+wSqrWI/LqRW9yA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zx3Sgs3fErkJhtj11/K5XGyPlpx6jR8LJwuioedMyAO7bYVEEPuS1P+gh+lgMiZ3T
	 NVt7o7SzJhjecNLlLGUcf6RYbX26Y1P24pHsT3dXplzrQqLd7vNhsdlYo+hBCDT/Qo
	 XsFRrgq0j2iSeyNF42e/wN2qeKvn8PEopgdN1FX8=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20240124114748epcas5p19c19c7a52bd78878d3be50572c99e215~tRhAKg7AO0246702467epcas5p1C;
	Wed, 24 Jan 2024 11:47:48 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.181]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4TKhz65RwRz4x9Px; Wed, 24 Jan
	2024 11:47:46 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	F5.35.09634.2E8F0B56; Wed, 24 Jan 2024 20:47:46 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20240124103855epcas5p27400bd95df42f36b9547a4e28aa26f5d~tQk2i396z2401024010epcas5p21;
	Wed, 24 Jan 2024 10:38:55 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240124103855epsmtrp2a7f6b1794ef3de4fae42c9c2e1221ff7~tQk2h0d2j2380723807epsmtrp2P;
	Wed, 24 Jan 2024 10:38:55 +0000 (GMT)
X-AuditID: b6c32a49-159fd700000025a2-69-65b0f8e2a0ec
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	3F.2E.07368.EB8E0B56; Wed, 24 Jan 2024 19:38:54 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
	[107.109.115.53]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240124103852epsmtip251e8ba5a9680c4140a2a0264c5f62669~tQk0CbMz_0276602766epsmtip2a;
	Wed, 24 Jan 2024 10:38:52 +0000 (GMT)
From: Shradha Todi <shradha.t@samsung.com>
To: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org
Cc: mturquette@baylibre.com, sboyd@kernel.org, jingoohan1@gmail.com,
	lpieralisi@kernel.org, kw@linux.com, robh@kernel.org, bhelgaas@google.com,
	krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com,
	linux@armlinux.org.uk, m.szyprowski@samsung.com,
	manivannan.sadhasivam@linaro.org, pankaj.dubey@samsung.com, Shradha Todi
	<shradha.t@samsung.com>
Subject: [PATCH v4 1/2] clk: Provide managed helper to get and enable bulk
 clocks
Date: Wed, 24 Jan 2024 16:08:37 +0530
Message-Id: <20240124103838.32478-2-shradha.t@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240124103838.32478-1-shradha.t@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIJsWRmVeSWpSXmKPExsWy7bCmlu6jHxtSDWZdVrd4MG8bm8WSpgyL
	FV9mslvsfb2V3aKh5zerxabH11gtPvbcY7W4vGsOm8XZecfZLGac38dkcWjqXkaLlj8tLBZr
	j9xlt7jb0slqcfGUq8WirV/YLf7v2cFu8e/aRhaL3sO1DsIel69dZPZ4f6OV3WPnrLvsHgs2
	lXpsWtXJ5nHn2h42jydXpjN5bF5S79G3ZRWjx+dNcgFcUdk2GamJKalFCql5yfkpmXnptkre
	wfHO8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6ZOUBvKSmUJeaUAoUCEouLlfTtbIryS0tSFTLy
	i0tslVILUnIKTAr0ihNzi0vz0vXyUkusDA0MjEyBChOyMyYseMZYMEuq4vSGP8wNjHtFuxg5
	OCQETCSm7s/oYuTkEBLYzSjROCW3i5ELyP7EKPH4XjczhPONUeJXx3lmkCqQhlMts9kgEnsZ
	JY59uMAI4bQySTyauY4RpIpNQEui8WsXWLuIwGJGiVs7NrOCOMwCT5gkltz4ywJSJSwQLLGp
	9TwbiM0ioCrx/Gs7O4jNK2Al8X76BUaIffISqzccANvNKWAt8fncPrDdEgJHOCR6Nl2FKnKR
	uN3/nB3CFpZ4dXwLlC0l8fndXjYIO11i5eYZUE/kSHzbvIQJwraXOHBlDgsoNJgFNCXW79KH
	CMtKTD21DqyEWYBPovf3E6hyXokd82BsZYkvf/ewQNiSEvOOXWaFsD0kls7ohwZeH6PE7etn
	mCYwys1CWLGAkXEVo2RqQXFuemqxaYFhXmo5PNqS83M3MYLTrpbnDsa7Dz7oHWJk4mA8xCjB
	wawkwntDcl2qEG9KYmVValF+fFFpTmrxIUZTYABOZJYSTc4HJv68knhDE0sDEzMzMxNLYzND
	JXHe161zU4QE0hNLUrNTUwtSi2D6mDg4pRqY1CdvzGdmKZXa9uPXVvUyx8KWL0nXatRapnUw
	rjntFy2wS5V7auPmb+V3fLlfz/nSe3dWO4eWdI+FMm/Ez0bv0vjP+lPD3Pb7Pr8Qd8NfY/Is
	677DtdsZ38nMqQ/oYF3pdO382fT7zfN0ZX8FLnj6KOBsTPmu6s9zZs1rqMiXim76Ihjv/3tN
	QuO+awq77ZfE/Gye7RFodtZ2BWeag0LMmh9JRSa8ir2OfcXmjtPXico92u/Kt8/rmdmdec1y
	BvO23ljmVXY59P3vtFUtVzrKPnPektmevNIoOsrN/1PeGv4zon+Pzrvevdubq+lPq4vWovPL
	ZJ6fnsGoxrJF/96mqgMZk3zW31BbwaN9SatFiaU4I9FQi7moOBEAFGUtZ0QEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJLMWRmVeSWpSXmKPExsWy7bCSvO6+FxtSDZY9sLR4MG8bm8WSpgyL
	FV9mslvsfb2V3aKh5zerxabH11gtPvbcY7W4vGsOm8XZecfZLGac38dkcWjqXkaLlj8tLBZr
	j9xlt7jb0slqcfGUq8WirV/YLf7v2cFu8e/aRhaL3sO1DsIel69dZPZ4f6OV3WPnrLvsHgs2
	lXpsWtXJ5nHn2h42jydXpjN5bF5S79G3ZRWjx+dNcgFcUVw2Kak5mWWpRfp2CVwZExY8YyyY
	JVVxesMf5gbGvaJdjJwcEgImEqdaZrN1MXJxCAnsZpSY92IOG0RCUuLzxXVMELawxMp/z9kh
	ipqZJGZ9/soCkmAT0JJo/NrFDJIQEVjOKPHz5FMmEIdZ4AuTxKSHu8DahQUCJW5dfwRmswio
	Sjz/2s4OYvMKWEm8n36BEWKFvMTqDQeYQWxOAWuJz+f2gZ0hBFTzcUYX8wRGvgWMDKsYJVML
	inPTc5MNCwzzUsv1ihNzi0vz0vWS83M3MYJjQ0tjB+O9+f/0DjEycTAeYpTgYFYS4b0huS5V
	iDclsbIqtSg/vqg0J7X4EKM0B4uSOK/hjNkpQgLpiSWp2ampBalFMFkmDk6pBqbVU65ssfzs
	W3j0xv9ZZ8+KnT9bLhwx6aCyi5pSQlLEvotdjw5tWdLNGHtWQ+Qxu1vNpukJW2PErjKbu6ye
	v7IrevuFjH3TLr5tNdpj7Th9cfl7059r1Tq0Jjr+tdvHc4NV9NOf2f5W/XtX3p+gJZE4j3P1
	FIZnuw+a7co4cOFD5HLxHy/UnLiuaih5t5iVlb+cfaLJvf9Qe2eP5iRF5Qdakte+iJpuOVHN
	6Bqx2Uqg10NFUyM1q55Dc6nVyvZbLkwLKrNWrDBbv+6EK+e/krhV3gKPBG+ufz/XS+LSzYq0
	omO3JW5pym7XrbgaFF3yP4ZDY0kmw6PZDg3xEve6xQpeKu5vFTqYYef14oHVnCYlluKMREMt
	5qLiRABSbpLx/AIAAA==
X-CMS-MailID: 20240124103855epcas5p27400bd95df42f36b9547a4e28aa26f5d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240124103855epcas5p27400bd95df42f36b9547a4e28aa26f5d
References: <20240124103838.32478-1-shradha.t@samsung.com>
	<CGME20240124103855epcas5p27400bd95df42f36b9547a4e28aa26f5d@epcas5p2.samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Provide a managed devm_clk_bulk* wrapper to get and enable all
bulk clocks in order to simplify drivers that keeps all clocks
enabled for the time of driver operation.

Suggested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Shradha Todi <shradha.t@samsung.com>
---
 drivers/clk/clk-devres.c | 40 ++++++++++++++++++++++++++++++++++++++++
 include/linux/clk.h      | 24 ++++++++++++++++++++++++
 2 files changed, 64 insertions(+)

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
index 1ef013324237..a005e709b7bd 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -438,6 +438,23 @@ int __must_check devm_clk_bulk_get_optional(struct device *dev, int num_clks,
 int __must_check devm_clk_bulk_get_all(struct device *dev,
 				       struct clk_bulk_data **clks);
 
+/**
+ * devm_clk_bulk_get_all_enable - managed get multiple clk consumers and
+ *				  enable all clks
+ * @dev: device for clock "consumer"
+ * @clks: pointer to the clk_bulk_data table of consumer
+ *
+ * Returns success (0) or negative errno.
+ *
+ * This helper function allows drivers to get several clk
+ * consumers and enable all of them in one operation with management.
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
@@ -960,6 +977,13 @@ static inline int __must_check devm_clk_bulk_get_all(struct device *dev,
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


