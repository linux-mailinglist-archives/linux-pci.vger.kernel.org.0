Return-Path: <linux-pci+bounces-27888-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 539FDABA218
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 19:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61BB5A06553
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 17:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D75F27876D;
	Fri, 16 May 2025 17:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hC0rQ8QT"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D292741CD;
	Fri, 16 May 2025 17:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747417324; cv=none; b=UpmcHCR4AgBzQiOJq4yyrsfo0PuKBk2wRncSCWa9iIfOXv1e223qHR/LmZq0kfY/pKKSdw8XYZrtkmoNjLhKtbjW8bQcbZ5qiPU8vbw9fPBSoIeLrc4Wy1e8h0uhkZDSCJdRgMSxXS5qhAyAQ782OKgDofyvskIqhYYuhm+jc6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747417324; c=relaxed/simple;
	bh=GU4MOVdN8oQjUQHsT+2DBnOtiOsxgXpBZ4DC2Y4gtzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c6cTHIqGuqcQZ4l0SpE9DySnmil+s3AfPRIyK4xZjfoSa8w0mj7MGM75c9wDiazXxRCabcOKzyIO3oo8CwE21bkR4uS0/SskjMS240IxbWaK3EYWpC4LpiQKwlPDbxRJxRfuxpAaO3SJJQ2Mmk+hSqFtXgEBKwvixDwy9jqJkwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hC0rQ8QT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52017C4CEE4;
	Fri, 16 May 2025 17:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747417324;
	bh=GU4MOVdN8oQjUQHsT+2DBnOtiOsxgXpBZ4DC2Y4gtzY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hC0rQ8QTsj46e6u5Rs2P7D48OuG1/AEL87VtzEn6EmPjNrYP9uhSNyxoegzwGO62d
	 3vc7GGdCMQtY8Htn/iFox0Hn54c7rMccbIV5aoX7TjIhEtNdpB55hdBD5VZcOnxBq5
	 0cm0hlj/BcCAFvxPBP6QO0FJdCqxy13LyduvIpvxehWwiMWHl6Rq1FAyzukyn+HlgO
	 fUJjXK3NDN6Nbydl7/8Ir4Dp2LyKmGER0kSWXwSXwjGP7HRE57QVlhoyk1d2FZO/QF
	 q/+dtnfHxC9teQLtSPSjDpJ/Q3xdKulm8MvX+hR1dTeYslWll43SvlD4Gia+Qk2xDF
	 heDcUBrj3QXCA==
From: Philipp Stanner <phasta@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Stanner <phasta@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Zijun Hu <quic_zijuhu@quicinc.com>,
	Yang Yingliang <yangyingliang@huawei.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v2 4/6] PCI: Remove request_flags relict from devres
Date: Fri, 16 May 2025 19:41:39 +0200
Message-ID: <20250516174141.42527-5-phasta@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250516174141.42527-1-phasta@kernel.org>
References: <20250516174141.42527-1-phasta@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pcim_request_region_exclusive(), the only user in PCI devres that needed
exclusive region requests, has been removed.

All features related to exclusive requests can, therefore, be removed,
too. Remove them.

Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 drivers/pci/devres.c | 46 +++++++++++++++++++-------------------------
 1 file changed, 20 insertions(+), 26 deletions(-)

diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
index 769b92f4f66a..ae79e5f95c8a 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -808,31 +808,6 @@ int pcim_iomap_regions(struct pci_dev *pdev, int mask, const char *name)
 }
 EXPORT_SYMBOL(pcim_iomap_regions);
 
-static int _pcim_request_region(struct pci_dev *pdev, int bar, const char *name,
-				int request_flags)
-{
-	int ret;
-	struct pcim_addr_devres *res;
-
-	if (!pci_bar_index_is_valid(bar))
-		return -EINVAL;
-
-	res = pcim_addr_devres_alloc(pdev);
-	if (!res)
-		return -ENOMEM;
-	res->type = PCIM_ADDR_DEVRES_TYPE_REGION;
-	res->bar = bar;
-
-	ret = __pcim_request_region(pdev, bar, name, request_flags);
-	if (ret != 0) {
-		pcim_addr_devres_free(res);
-		return ret;
-	}
-
-	devres_add(&pdev->dev, res);
-	return 0;
-}
-
 /**
  * pcim_request_region - Request a PCI BAR
  * @pdev: PCI device to request region for
@@ -848,7 +823,26 @@ static int _pcim_request_region(struct pci_dev *pdev, int bar, const char *name,
  */
 int pcim_request_region(struct pci_dev *pdev, int bar, const char *name)
 {
-	return _pcim_request_region(pdev, bar, name, 0);
+	int ret;
+	struct pcim_addr_devres *res;
+
+	if (!pci_bar_index_is_valid(bar))
+		return -EINVAL;
+
+	res = pcim_addr_devres_alloc(pdev);
+	if (!res)
+		return -ENOMEM;
+	res->type = PCIM_ADDR_DEVRES_TYPE_REGION;
+	res->bar = bar;
+
+	ret = __pcim_request_region(pdev, bar, name, 0);
+	if (ret != 0) {
+		pcim_addr_devres_free(res);
+		return ret;
+	}
+
+	devres_add(&pdev->dev, res);
+	return 0;
 }
 EXPORT_SYMBOL(pcim_request_region);
 
-- 
2.49.0


