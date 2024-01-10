Return-Path: <linux-pci+bounces-1988-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C77829890
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jan 2024 12:17:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB1DC285E5A
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jan 2024 11:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B207B4777E;
	Wed, 10 Jan 2024 11:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="GorskU85"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18E247773
	for <linux-pci@vger.kernel.org>; Wed, 10 Jan 2024 11:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240110111718epoutp03d8a358dc0dcb886c7cef8fd99b74f471~o_EXr7K6Z1778617786epoutp03B
	for <linux-pci@vger.kernel.org>; Wed, 10 Jan 2024 11:17:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240110111718epoutp03d8a358dc0dcb886c7cef8fd99b74f471~o_EXr7K6Z1778617786epoutp03B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1704885438;
	bh=5oVmRhw2DfUJW61C/c9zwKTKzkdVt14suKM8C/BBVEY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GorskU85DYGrPGHrFSSOGGWqYfUVdu/wh2OYQ1kU1UQqP5VSpm3mV/kwdKurLxAuy
	 OjvoiVYG6oe+58PITzAbzi0iAUPanX2EiP2mSIw+9lIiTlBdTcINVVZV0QVwDOiGB/
	 lnV+n+WmfBW5TLQiPFUfcs/IwgILPUIjwwEbGExA=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20240110111717epcas5p183dc719452830456683bf33f66b9b428~o_EWnxG_l3020330203epcas5p19;
	Wed, 10 Jan 2024 11:17:17 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.177]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4T94yM2zMwz4x9Pp; Wed, 10 Jan
	2024 11:17:15 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	62.98.10009.BBC7E956; Wed, 10 Jan 2024 20:17:15 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240110110156epcas5p36bac4093be0fa6eaa501d7eaed4d43d3~o929HlXk90210902109epcas5p33;
	Wed, 10 Jan 2024 11:01:56 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240110110156epsmtrp25c8f09c24cebfbf0b2aad59d9d9cacab~o929Gty2p2407724077epsmtrp25;
	Wed, 10 Jan 2024 11:01:56 +0000 (GMT)
X-AuditID: b6c32a4a-261fd70000002719-b7-659e7cbba513
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	88.50.18939.4297E956; Wed, 10 Jan 2024 20:01:56 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
	[107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240110110153epsmtip1c77ed0ded73c66bdf11224772f4a851b~o926taL6P2247622476epsmtip1d;
	Wed, 10 Jan 2024 11:01:53 +0000 (GMT)
From: Shradha Todi <shradha.t@samsung.com>
To: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org
Cc: mturquette@baylibre.com, sboyd@kernel.org, jingoohan1@gmail.com,
	lpieralisi@kernel.org, kw@linux.com, robh@kernel.org, bhelgaas@google.com,
	krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com,
	linux@armlinux.org.uk, m.szyprowski@samsung.com,
	manivannan.sadhasivam@linaro.org, Shradha Todi <shradha.t@samsung.com>
Subject: [PATCH v3 1/2] clk: Provide managed helper to get and enable bulk
 clocks
Date: Wed, 10 Jan 2024 16:31:14 +0530
Message-Id: <20240110110115.56270-2-shradha.t@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240110110115.56270-1-shradha.t@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNJsWRmVeSWpSXmKPExsWy7bCmhu7umnmpBnMui1g8mLeNzWJJU4bF
	ii8z2S32vt7KbtHQ85vVYtPja6wWH3vusVpc3jWHzeLsvONsFjPO72OyODR1L6NFy58WFou1
	R+6yW9xt6WS1uHjK1eL/nh3sFv+ubWSx6D1c6yDkcfnaRWaP9zda2T12zrrL7rFgU6nHplWd
	bB53ru1h83hyZTqTx+Yl9R59W1YxenzeJBfAFZVtk5GamJJapJCal5yfkpmXbqvkHRzvHG9q
	ZmCoa2hpYa6kkJeYm2qr5OIToOuWmQP0kZJCWWJOKVAoILG4WEnfzqYov7QkVSEjv7jEVim1
	ICWnwKRArzgxt7g0L10vL7XEytDAwMgUqDAhO2P3hwusBT2yFScuL2NrYPwr3sXIySEhYCLx
	es47ti5GLg4hgd2MEp92LmaCcD4xSuxcvA3B6Vt0iaWLkQOs5eItGYj4TkaJWT1XGCGcViaJ
	o8e+sYPMZRPQkmj82sUMkhARWMwocWvHZlYQh1ngBFDV2W2MIFXCAsESnQ1/WUBsFgFViel9
	e9hAVvAKWEk0H5aCOFBeYvWGA8wgNqeAtcTqxbPZQeZICGzhkDh2bBETRJGLxKy20ywQtrDE
	q+Nb2CFsKYnP7/ayQdjpEis3z2CGsHMkvm1eAtVrL3Hgyhyw15gFNCXW79KHCMtKTD21DqyE
	WYBPovf3E6hyXokd82BsZYkvf/dArZWUmHfsMiuE7SFxZMYzsBeFBPoYJfZ9M5zAKDcLYcMC
	RsZVjJKpBcW56anFpgVGeanl8FhLzs/dxAhOtVpeOxgfPvigd4iRiYPxEKMEB7OSCK/C5zmp
	QrwpiZVVqUX58UWlOanFhxhNgcE3kVlKNDkfmOzzSuINTSwNTMzMzEwsjc0MlcR5X7fOTRES
	SE8sSc1OTS1ILYLpY+LglGpgYhCuzPzWWZrwvW6H2oFHPZ+ZIvNMPh9dcPi4tbaz1YwdGcXs
	Kyx9ZA/G33/4JmLRCuW9vIyHrh/PEf1W0/av/OPiIzOnSnnzbeW62H9pSorPmkaOurj6wGuX
	vzL/EgtpvZnW6Hc/cO80db93zg1Teh6rZH8PX3E+YjPf/J2X3r3sFTgq9Uy8sPTIRc/rr5cz
	unTJfpLJL7jUce8Nn2XbO9tvzxPfGJ2zrP76Lk1j3jOxGSF3pNg/loaInVo+dcFmg226fBMt
	jts+mZoUuvX0uTMTf0z0zJZzK9r0cfn6v702zafbXdm7VNO2K61+G5b4++RcvoN6l7aKb5J1
	MZqyR3bTP4+tbpGb2VvXnN5ekqbEUpyRaKjFXFScCAAufCN4PgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHLMWRmVeSWpSXmKPExsWy7bCSnK5K5bxUg3efuCwezNvGZrGkKcNi
	xZeZ7BZ7X29lt2jo+c1qsenxNVaLjz33WC0u75rDZnF23nE2ixnn9zFZHJq6l9Gi5U8Li8Xa
	I3fZLe62dLJaXDzlavF/zw52i3/XNrJY9B6udRDyuHztIrPH+xut7B47Z91l91iwqdRj06pO
	No871/aweTy5Mp3JY/OSeo++LasYPT5vkgvgiuKySUnNySxLLdK3S+DK2P3hAmtBj2zFicvL
	2BoY/4p3MXJwSAiYSFy8JdPFyMUhJLCdUWLKqf3sXYycQHFJic8X1zFB2MISK/89Z4coamaS
	aN1yD6yITUBLovFrFzNIQkRgOaPEz5NPmUAcZoEbTBKNjXPBqoQFAiXOtL4BG8UioCoxvW8P
	G8hqXgEriebDUhAb5CVWbzjADGJzClhLrF48G6xVCKhkxd7DrBMY+RYwMqxiFE0tKM5Nz00u
	MNQrTswtLs1L10vOz93ECI4CraAdjMvW/9U7xMjEwXiIUYKDWUmEV+HznFQh3pTEyqrUovz4
	otKc1OJDjNIcLErivMo5nSlCAumJJanZqakFqUUwWSYOTqkGJlNtpQlTHubf+aIudGTxX/uf
	twozHKecC7J87hwlpK3K5Xxvfan0r3Ncc3f9WGAf92Wl5duW1U/SXh0K3PQnsvpz/OeQzOTC
	99v7QtaceH6zzz71XXjDzObvgs/75CKvZpUGnf/C5f3mZ+Ru+V3HJmZ/zNdzDjsi15Fd0Mxw
	aOknnejNFUfy/m5+xPVsfur6x18br3A5NO09Pv3Jp2c/W4v228xyS+a07wjbfP7KotZnv5TD
	nRfefb92pQa3arin5PrvQYfqV3qsutIZcYXZinEGo2rqK+ulzoldCTFvjnzUUMw7xlc2XWez
	T3tOr9DtVzlB0UkiW6OOrL0nK799Dq+Ttb3cWd8fE1qicnol2JRYijMSDbWYi4oTAdwxEfHx
	AgAA
X-CMS-MailID: 20240110110156epcas5p36bac4093be0fa6eaa501d7eaed4d43d3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240110110156epcas5p36bac4093be0fa6eaa501d7eaed4d43d3
References: <20240110110115.56270-1-shradha.t@samsung.com>
	<CGME20240110110156epcas5p36bac4093be0fa6eaa501d7eaed4d43d3@epcas5p3.samsung.com>
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
 drivers/clk/clk-devres.c | 41 ++++++++++++++++++++++++++++++++++++++++
 include/linux/clk.h      | 25 ++++++++++++++++++++++++
 2 files changed, 66 insertions(+)

diff --git a/drivers/clk/clk-devres.c b/drivers/clk/clk-devres.c
index 4fb4fd4b06bd..05b0ff4bc1d4 100644
--- a/drivers/clk/clk-devres.c
+++ b/drivers/clk/clk-devres.c
@@ -102,6 +102,7 @@ EXPORT_SYMBOL_GPL(devm_clk_get_optional_enabled);
 struct clk_bulk_devres {
 	struct clk_bulk_data *clks;
 	int num_clks;
+	void (*exit)(int num_clks, const struct clk_bulk_data *clks);
 };
 
 static void devm_clk_bulk_release(struct device *dev, void *res)
@@ -182,6 +183,46 @@ int __must_check devm_clk_bulk_get_all(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(devm_clk_bulk_get_all);
 
+static void devm_clk_bulk_release_all_enabled(struct device *dev, void *res)
+{
+	struct clk_bulk_devres *devres = res;
+
+	if (devres->exit)
+		devres->exit(devres->num_clks, devres->clks);
+
+	clk_bulk_put_all(devres->num_clks, devres->clks);
+}
+
+int __must_check devm_clk_bulk_get_all_enabled(struct device *dev,
+				  struct clk_bulk_data **clks, int *num_clks)
+{
+	struct clk_bulk_devres *devres;
+	int ret;
+
+	devres = devres_alloc(devm_clk_bulk_release_all_enabled,
+			      sizeof(*devres), GFP_KERNEL);
+	if (!devres)
+		return -ENOMEM;
+
+	ret = clk_bulk_get_all(dev, &devres->clks);
+	if (ret > 0) {
+		*clks = devres->clks;
+		devres->num_clks = ret;
+		*num_clks = ret;
+		devres_add(dev, devres);
+	} else {
+		devres_free(devres);
+		return ret;
+	}
+
+	ret = clk_bulk_prepare_enable(devres->num_clks, *clks);
+	if (!ret)
+		devres->exit = clk_bulk_disable_unprepare;
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(devm_clk_bulk_get_all_enabled);
+
 static int devm_clk_match(struct device *dev, void *res, void *data)
 {
 	struct clk **c = res;
diff --git a/include/linux/clk.h b/include/linux/clk.h
index 1ef013324237..bf3e9bee5754 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -438,6 +438,24 @@ int __must_check devm_clk_bulk_get_optional(struct device *dev, int num_clks,
 int __must_check devm_clk_bulk_get_all(struct device *dev,
 				       struct clk_bulk_data **clks);
 
+/**
+ * devm_clk_bulk_get_all_enabled - managed get multiple clk consumers and
+ *					enable all clk
+ * @dev: device for clock "consumer"
+ * @clks: pointer to the clk_bulk_data table of consumer
+ * @num_clks: out parameter to store the number of clk_bulk_data
+ *
+ * Returns success (0) or negative errno.
+ *
+ * This helper function allows drivers to get several clk
+ * consumers and enable all of them in one operation with management.
+ * The clks will automatically be disabled and freed when the device
+ * is unbound.
+ */
+
+int __must_check devm_clk_bulk_get_all_enabled(struct device *dev,
+				struct clk_bulk_data **clks, int *num_clks);
+
 /**
  * devm_clk_get - lookup and obtain a managed reference to a clock producer.
  * @dev: device for clock "consumer"
@@ -960,6 +978,13 @@ static inline int __must_check devm_clk_bulk_get_all(struct device *dev,
 	return 0;
 }
 
+static inline int __must_check devm_clk_bulk_get_all_enabled(struct device *dev,
+				struct clk_bulk_data **clks, int *num_clks)
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


