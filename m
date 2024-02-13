Return-Path: <linux-pci+bounces-3394-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E44FC8532D5
	for <lists+linux-pci@lfdr.de>; Tue, 13 Feb 2024 15:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14F841C20F42
	for <lists+linux-pci@lfdr.de>; Tue, 13 Feb 2024 14:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0785733B;
	Tue, 13 Feb 2024 14:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ue+Uhuca"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E83B56B6A
	for <linux-pci@vger.kernel.org>; Tue, 13 Feb 2024 14:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707833960; cv=none; b=RYKDETOhG1Fh1WIaEEbWbQJpnYdYTpygvshi5/0PAWFd7t588QFHDwbY3MxnyLNE9Nb2Kn4kmSdFi+MT0wPI3cFeUE14yW4xGYyADdA33geLJpjf9wWA4pgF0eKHhV7UJQzYhP2DjG5OLdT1dQGYKHJMvlUehrGVpRfV7yTDIIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707833960; c=relaxed/simple;
	bh=XLMbgpPxKs6nZIg4i0hUeBHypGjLhHRIJjFph+4LgWY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:References; b=WXhZIGeyn+aBDcHc1M8tOC9oHsE6X0bevf1fZH/sEXMDOKBFO7wPyevvMwpRS5nNs8CoBY70gVxPnVhxj48BHgF/eZu4oOlgdEEmPHGPO1IInB37Hr/UtZrBb9p1OTqdJie1oyorhYzfQPLWWg3cNwN7lOTTPa9AVzkiQgFT9Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ue+Uhuca; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240213141914epoutp016ccce6397199a37add2a6a17b2a1e4ee~zce7XzoOG2496324963epoutp01b
	for <linux-pci@vger.kernel.org>; Tue, 13 Feb 2024 14:19:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240213141914epoutp016ccce6397199a37add2a6a17b2a1e4ee~zce7XzoOG2496324963epoutp01b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1707833954;
	bh=uILFgGO0TM9PDxvRkmFO/3dPB4/T//4OL4gPS7QNllw=;
	h=From:To:Cc:Subject:Date:References:From;
	b=ue+Uhuca/wLmQi4G071TYruMRnW8bEVwID4ah81qVvnInKrMKRN3sC1EQNL1ICoL1
	 vRk4//z6D6lB2tuT+KTYllE8hTtxZz+wnphDOZJnFbHyauggHE1ecr2YeB+ijRodYM
	 hUu6yH26HYEcNQDtG96bK9uYgoJPndvCSamFhOow=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20240213141913epcas5p398960dbe2c122016560562ecd5e53139~zce6zbWgn0171201712epcas5p3f;
	Tue, 13 Feb 2024 14:19:13 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.180]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4TZ3Nb4bPKz4x9Pv; Tue, 13 Feb
	2024 14:19:11 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	0E.80.08567.C5A7BC56; Tue, 13 Feb 2024 23:19:08 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20240213132759epcas5p4896fd9d0b1af7762ff98ae9e586492dc~zbyMHWueF2842628426epcas5p4e;
	Tue, 13 Feb 2024 13:27:59 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240213132759epsmtrp242439ce4bb944f565b3f71b978c01e1a~zbyMGZctb2153621536epsmtrp2J;
	Tue, 13 Feb 2024 13:27:59 +0000 (GMT)
X-AuditID: b6c32a44-3abff70000002177-44-65cb7a5c2184
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	F4.C1.08755.F5E6BC56; Tue, 13 Feb 2024 22:27:59 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
	[107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240213132757epsmtip1dea7f6a38eea4362c023f4a38a4e1b8e~zbyJZdfoC1530215302epsmtip1N;
	Tue, 13 Feb 2024 13:27:56 +0000 (GMT)
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
Subject: [PATCH v5 0/2] Add helper function to get and enable all bulk
 clocks
Date: Tue, 13 Feb 2024 18:57:49 +0530
Message-Id: <20240213132751.46813-1-shradha.t@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJJsWRmVeSWpSXmKPExsWy7bCmpm5M1elUg8NvVC0ezNvGZrGkKcPi
	5oGdTBYrvsxkt9j7eiu7RUPPb1aLTY+vsVp87LnHanF51xw2i7PzjrNZzDi/j8ni0NS9jBYt
	f1pYLNYeuctucbelk9Xi4ilXi0Vbv7Bb/N+zg93i37WNLBa9h2sdRDwuX7vI7PH+Riu7x85Z
	d9k9Fmwq9di0qpPN4861PWweT65MZ/LYvKTeo2/LKkaPz5vkAriism0yUhNTUosUUvOS81My
	89JtlbyD453jTc0MDHUNLS3MlRTyEnNTbZVcfAJ03TJzgH5TUihLzCkFCgUkFhcr6dvZFOWX
	lqQqZOQXl9gqpRak5BSYFOgVJ+YWl+al6+WlllgZGhgYmQIVJmRnnH85ibXgEVdF648ZrA2M
	jzm6GDk5JARMJJa+ucfaxcjFISSwm1Gipe0dM4TziVHi15TPUJlvjBKPGvYxwrR0XNnHBmIL
	CexllJg/TxmiqJVJ4vTt9SwgCTYBLYnGr11go0QEFjNK3NqxGWwUs8AvJol9jZuYQKqEBfwl
	Jj6+BjaKRUBVYsapD6wgNq+AlcS5xdPYIdbJS6zecABskoTAWg6JX+v7WSASLhIHz/WwQtjC
	Eq+Ob4FqkJL4/G4vG4SdLrFy8wxmCDtH4tvmJUwQtr3EgStzgOZwAF2kKbF+lz5EWFZi6ql1
	YCXMAnwSvb+fQJXzSuyYB2MrS3z5uwfqBEmJeccus4KMkRDwkJg5LQkSKrEStzbPY5zAKDsL
	YcECRsZVjJKpBcW56anJpgWGeanl8JhKzs/dxAhOs1ouOxhvzP+nd4iRiYPxEKMEB7OSCO+l
	GSdShXhTEiurUovy44tKc1KLDzGaAoNsIrOUaHI+MNHnlcQbmlgamJiZmZlYGpsZKonzvm6d
	myIkkJ5YkpqdmlqQWgTTx8TBKdXAtDI+MPnorEUylo/q22/7pm4M2tSvFDPtkXCwWq3P3w7x
	p7WMgpoVtsZW516fTjavefRirqTVguVCN7S3+EZG7vXPvrjBe82WbfMmPOSo2FzMuiJjz+/K
	9Px/HKxzzP9ukxApfPLu01QfRZ18pghzo9pVZUd1ZnL0GjDy2cfGdWn7lvNZmcxI0xfUzlq9
	2yzFt7M7MrcyxSbUWNzm2Oos7lU8065LGwld23Lby6bCR/BB2MNDuxqy/CtZPHS+vfFIuVsY
	UNB2atLOrGveH53977z/Zey62L3PfMaabumns48cqVn3Ys+dO0puXGcjrt3yn9TovuvJfjPv
	u2u1fk8XT97wVjqlf5tbGsOdU3uUWIozEg21mIuKEwHmIJ28PAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCLMWRmVeSWpSXmKPExsWy7bCSnG583ulUg6Nr9SwezNvGZrGkKcPi
	5oGdTBYrvsxkt9j7eiu7RUPPb1aLTY+vsVp87LnHanF51xw2i7PzjrNZzDi/j8ni0NS9jBYt
	f1pYLNYeuctucbelk9Xi4ilXi0Vbv7Bb/N+zg93i37WNLBa9h2sdRDwuX7vI7PH+Riu7x85Z
	d9k9Fmwq9di0qpPN4861PWweT65MZ/LYvKTeo2/LKkaPz5vkAriiuGxSUnMyy1KL9O0SuDLO
	v5zEWvCIq6L1xwzWBsbHHF2MnBwSAiYSHVf2sYHYQgK7GSW2HFaAiEtKfL64jgnCFpZY+e85
	excjF1BNM5NE58J7jCAJNgEticavXcwgCRGB5YwSP08+BetgFuhhljjQGgJiCwv4Sqz9e5wF
	xGYRUJWYceoDK4jNK2AlcW7xNHaIDfISqzccYJ7AyLOAkWEVo2RqQXFuem6xYYFhXmq5XnFi
	bnFpXrpecn7uJkZwwGtp7mDcvuqD3iFGJg7GQ4wSHMxKIryXZpxIFeJNSaysSi3Kjy8qzUkt
	PsQozcGiJM4r/qI3RUggPbEkNTs1tSC1CCbLxMEp1cCUE6o4Xdx6fVFQSWOoV7nNoWVrau4Y
	7H+9+NklhUNq1/X1xBb5bpLNCV/8o7Tx1Ev5uXJiHOETFhw6k5J3/o78h9Pn+/QWFLqLVq4s
	mrNIjHvLIxO99EtKX/wmbzV4ccr0sldzyN+83JUT570qVzlyVDijNePwsg6pOrdzCVtOnfNQ
	kzfq21Ozx2jTp48K9+8Gf29Ztajx9fSi0qVbNU+Gf73m4zvvkdrDurkvqgvzHnaGHJm4Lr7/
	/wnD60sae1lE8+W5vnTsWi5zWP9+0/bn52o2cKivUXkV9JgtydHUSjIwmHWbr46i9YEaK56Y
	FUHzI1ZPYGWU4kjiEr0StTTtRrzG8tYJzn80WCSWixUosRRnJBpqMRcVJwIA49QBgOcCAAA=
X-CMS-MailID: 20240213132759epcas5p4896fd9d0b1af7762ff98ae9e586492dc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240213132759epcas5p4896fd9d0b1af7762ff98ae9e586492dc
References: <CGME20240213132759epcas5p4896fd9d0b1af7762ff98ae9e586492dc@epcas5p4.samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Create a managed API wrapper to get all the bulk clocks and enable them
as it is a very common practice in many drivers. The second patch uses
this API to adapt to clk_bulk_* APIs in the exynos driver.
v1:
 - https://lore.kernel.org/lkml/20231009062216.6729-1-shradha.t@samsung.com/
v2:
 - https://lore.kernel.org/lkml/20231115065621.27014-1-shradha.t@samsung.com/
 - Addressed Manivannan's comments to improve patch
v3:
 - https://lore.kernel.org/all/20240110110115.56270-1-shradha.t@samsung.com/
 - Took Marek's suggestion to make a common bulk clk wrapper and use it in
   the exynos driver
v4:
 - https://lore.kernel.org/all/20240124103838.32478-1-shradha.t@samsung.com/
 - Addressed Alim and Manivannan's comments
 - Changed enabled->enable and disabled->disable in function name
 - Remove num_clks out parameter as it is not required by user
 - Removed exit callback and used function name directly in release
v5:
 - Rephrased comments for better readability

Shradha Todi (2):
  clk: Provide managed helper to get and enable bulk clocks
  PCI: exynos: Adapt to clk_bulk_* APIs

 drivers/clk/clk-devres.c                | 40 ++++++++++++++++++
 drivers/pci/controller/dwc/pci-exynos.c | 54 ++-----------------------
 include/linux/clk.h                     | 23 +++++++++++
 3 files changed, 67 insertions(+), 50 deletions(-)

-- 
2.17.1


