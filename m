Return-Path: <linux-pci+bounces-3756-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E73485BA43
	for <lists+linux-pci@lfdr.de>; Tue, 20 Feb 2024 12:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 732991C218B4
	for <lists+linux-pci@lfdr.de>; Tue, 20 Feb 2024 11:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF0A664DC;
	Tue, 20 Feb 2024 11:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="bltpXq8T"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89335664B4
	for <linux-pci@vger.kernel.org>; Tue, 20 Feb 2024 11:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708428090; cv=none; b=YJzkCRrzE/LGhUk62JvYnEaUsnAS819AdN01zge1WE4vvjiLZqUVUT4ikStULZOorj++B+7sxKE7ERPp6yPfRAGNAIbFTocB8BoOMQ4mWcIr8b0Jj5b2N7wzqhjFV9Tel5WZ4jW7mw6i1kKbf81ttMtqYdJg2YzSgM7P7MAgQ68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708428090; c=relaxed/simple;
	bh=OB9Ar1NlY5I15Pk9LqCt5ZPs1bwoDukWyfFACtz4y5k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:Content-Type:
	 References; b=ojsLWzEBjQr8fAR6BgGSF96RXYCXqVR+t4pWX3ytXbNOI5aSlcpmhMFbk/34LnrY5TqgB9ZOiDvmcj3XCVCM1tsSHLyZMATEHCpRu/6MOPtTshZfvciv8PKfU4W7ugtVWshNZuGzcgl1EOqclJbJz4LGK98WFP6R8mATgaLrig4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=bltpXq8T; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240220112125epoutp0307da19b493548d9d95cadeb910cf0dc3~1jkrQdbbt2532425324epoutp03g
	for <linux-pci@vger.kernel.org>; Tue, 20 Feb 2024 11:21:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240220112125epoutp0307da19b493548d9d95cadeb910cf0dc3~1jkrQdbbt2532425324epoutp03g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1708428085;
	bh=jvqK+xgmpuJsfH4tlmkfpfJUU2IQ6JvGvMe4vn39woo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bltpXq8TkaVHm7WBr50spV7EnsCIpZV4QRH8JBAtqQ2uolPv4KW1ze5dkelJVVSx8
	 WkavtzvH5fe5vfgNyGwnyiyOX6MeP4GwVAUS7+XoZI9w+mrRmAqHQbBlB4cPhsHv9x
	 LK8ato2Y+XC1BcL1vDH3M7ZMASlXQsDaWJPmu8U8=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20240220112124epcas5p46dea8d0700649a32f10121ad57d9ea8a~1jkqSplB_0864008640epcas5p4D;
	Tue, 20 Feb 2024 11:21:24 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.176]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4TfH6B5Dlxz4x9Pp; Tue, 20 Feb
	2024 11:21:22 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	42.F3.09672.23B84D56; Tue, 20 Feb 2024 20:21:22 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20240220084120epcas5p1e8980539667c3d9da20f49fc645d8f4c~1hY6LSPEX1617016170epcas5p1g;
	Tue, 20 Feb 2024 08:41:20 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240220084120epsmtrp29fe4a883c07fd71c9d95ce8b01da3ae9~1hY6KaaLR1209712097epsmtrp2S;
	Tue, 20 Feb 2024 08:41:20 +0000 (GMT)
X-AuditID: b6c32a4b-60bfd700000025c8-f0-65d48b329a2e
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	E9.8B.07368.0B564D56; Tue, 20 Feb 2024 17:41:20 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
	[107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240220084118epsmtip1ddb341e7fee780d897731ff35c16f49b~1hY3kkhI_3013230132epsmtip1G;
	Tue, 20 Feb 2024 08:41:18 +0000 (GMT)
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
Subject: [PATCH v6 1/2] clk: Provide managed helper to get and enable bulk
 clocks
Date: Tue, 20 Feb 2024 14:10:45 +0530
Message-Id: <20240220084046.23786-2-shradha.t@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240220084046.23786-1-shradha.t@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGJsWRmVeSWpSXmKPExsWy7bCmhq5R95VUg4NHVSwezNvGZrGkKcPi
	5oGdTBYrvsxkt9j7eiu7RUPPb1aLTY+vsVp87LnHanF51xw2i7PzjrNZzDi/j8ni0NS9jBYt
	f1pYLNYeuctucbelk9Xi4ilXi0Vbv7Bb/N+zg93i37WNLBa9h2sdRDwuX7vI7PH+Riu7x85Z
	d9k9Fmwq9di0qpPN4861PWweT65MZ/LYvKTeo2/LKkaPz5vkAriism0yUhNTUosUUvOS81My
	89JtlbyD453jTc0MDHUNLS3MlRTyEnNTbZVcfAJ03TJzgH5TUihLzCkFCgUkFhcr6dvZFOWX
	lqQqZOQXl9gqpRak5BSYFOgVJ+YWl+al6+WlllgZGhgYmQIVJmRnrH7fwlzQJF0x5+c+pgbG
	pWJdjJwcEgImElMWX2ABsYUEdjNKXN0m2MXIBWR/YpS4/ew8C4TzjVHiweX17DAdmxb8YYJI
	7GWU2LVgJTOE08ok0fl2OzNIFZuAlkTj1y6whIjAYkaJWzs2s4I4zAK/mCT2NW5iAqkSFgiW
	uPDlINhcFgFVidWvtoLZvAJWEt8mbILaJy+xesMBoEkcHJwC1hJXl2WCzJEQOMEhMX/ZSVaI
	GheJc7sesUHYwhKvjm+B6pWS+PxuL1Q8XWLl5hnMEHaOxLfNS5ggbHuJA1fmsIDMZxbQlFi/
	Sx8iLCsx9dQ6sBJmAT6J3t9PoMp5JXbMg7GVJb783cMCYUtKzDt2GeocD4nZf0+xQ0Klj1Hi
	c+dCxgmMcrMQVixgZFzFKJlaUJybnlpsWmCcl1oOj7bk/NxNjOAErOW9g/HRgw96hxiZOBgP
	MUpwMCuJ8LKUX0kV4k1JrKxKLcqPLyrNSS0+xGgKDL+JzFKiyfnAHJBXEm9oYmlgYmZmZmJp
	bGaoJM77unVuipBAemJJanZqakFqEUwfEwenVAMT07RtZipe8SYXOldyZy1bpqXIn3XSbpHV
	rZMf3bfc1xZ9tVuzNJXN2u/JlL7nXDWztb9r1zlPzGud8b7+u6GylLRB9ek9O18bWPuu73pS
	q2RSK1rbVikemGP+4sSLB3VLkhx3eWw7V5MtMLN9h43LvOiN1w45r0+qnf18YSIn3yqfq+e/
	fp7ponspOvC9xKowk+nfK8R5WWW4uadJv/FfN2XxrdkL861Efm6Ie8Y8q+XjEW6bvn7za0//
	SSreTeOuUGd/deTOwVkLJkal7Wm5PXWanr3af8cJCjpX2qyv3964xVD6C+e7rK8m7WfSJt4q
	O/+an/Hh23+GUVMjj8ytvnp0ytpzMd+vRvcGvStxVWIpzkg01GIuKk4EAKmgospJBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNLMWRmVeSWpSXmKPExsWy7bCSnO6G1CupBr+Omlg8mLeNzWJJU4bF
	zQM7mSxWfJnJbrH39VZ2i4ae36wWmx5fY7X42HOP1eLyrjlsFmfnHWezmHF+H5PFoal7GS1a
	/rSwWKw9cpfd4m5LJ6vFxVOuFou2fmG3+L9nB7vFv2sbWSx6D9c6iHhcvnaR2eP9jVZ2j52z
	7rJ7LNhU6rFpVSebx51re9g8nlyZzuSxeUm9R9+WVYwenzfJBXBFcdmkpOZklqUW6dslcGWs
	ft/CXNAkXTHn5z6mBsalYl2MnBwSAiYSmxb8Yepi5OIQEtjNKLH9/B42iISkxOeL65ggbGGJ
	lf+es4PYQgLNTBIrG8BsNgEticavXcwgzSICyxklfp58CtbALNDDLHGgNQTEFhYIlNjZuRBs
	KIuAqsTqV1vBmnkFrCS+TdjEDrFAXmL1hgNAgzg4OAWsJa4uy4TYZSXx/+Eu5gmMfAsYGVYx
	SqYWFOem5yYbFhjmpZbrFSfmFpfmpesl5+duYgTHh5bGDsZ78//pHWJk4mA8xCjBwawkwuve
	dCFViDclsbIqtSg/vqg0J7X4EKM0B4uSOK/hjNkpQgLpiSWp2ampBalFMFkmDk6pBiaD4tXd
	rgzzDd+ddt7neLCTbfHNzfbiHRkahkf0N/u+M3ziteDfiZmGn3vTYxfueZCm2zxn+pRtW/yX
	PFm3RbWzP99E/Uvsj88+578LvpyRZr4qwGTPphK3eVczfyedTVLdKFl96t33oynZv3+7iTRL
	yU3k9OxbV6lntrnggF/B6U8zNabprQyfrC3SKnwgwTvwv9bt93Pi2GQ2PHq2IkSzuFvTJTD+
	wf/6ZDW/KTrKrXs3t8yY+C7dcskx3QMfhDREz5nPd/zLx1/XLcw3q3lH+41FkeYXLpx1FVnh
	8mz5/gCV4pzK6FapzPuGGR9vsqdlTMkwiZ4tWXg5bHdq2r3iqW9/JvcZzIv6G5THPU2JpTgj
	0VCLuag4EQDPjVxx/gIAAA==
X-CMS-MailID: 20240220084120epcas5p1e8980539667c3d9da20f49fc645d8f4c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240220084120epcas5p1e8980539667c3d9da20f49fc645d8f4c
References: <20240220084046.23786-1-shradha.t@samsung.com>
	<CGME20240220084120epcas5p1e8980539667c3d9da20f49fc645d8f4c@epcas5p1.samsung.com>
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
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Shradha Todi <shradha.t@samsung.com>
---
 drivers/clk/clk-devres.c | 40 ++++++++++++++++++++++++++++++++++++++++
 include/linux/clk.h      | 22 ++++++++++++++++++++++
 2 files changed, 62 insertions(+)

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
index 1ef013324237..a8e6b045b848 100644
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
@@ -960,6 +976,12 @@ static inline int __must_check devm_clk_bulk_get_all(struct device *dev,
 	return 0;
 }
 
+static inline int __must_check devm_clk_bulk_get_all_enable(struct device *dev,
+						struct clk_bulk_data **clks)
+{
+	return 0;
+}
+
 static inline struct clk *devm_get_clk_from_child(struct device *dev,
 				struct device_node *np, const char *con_id)
 {
-- 
2.17.1


