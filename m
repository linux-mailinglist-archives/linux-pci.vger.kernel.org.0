Return-Path: <linux-pci+bounces-27961-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E2AABBC64
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 13:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BF4416F3F3
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 11:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A8B277811;
	Mon, 19 May 2025 11:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q2HshcfL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2DC277804;
	Mon, 19 May 2025 11:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747654237; cv=none; b=CzZ4SRPED6/9XErAYuY+QzdmRs6ILldZ/JNvOTruy+/LIkHl0lY/SZWcoOc1In2Bz3v5TTkAzx/UpHtpt4dGYGY6gYE0HyBUg+71ed80eOxj7z6BJxlnJ80LHWChchYFB0ZX09ZFTIfPOWA417EcwDgwsawV1FK6KUWCI9dKjsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747654237; c=relaxed/simple;
	bh=AzoGK9e92IB4GFZK7Gp2iJJ2pTc/LyEYyg91BJBdfgM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FGocX16ixCKBZCwqAXtJNDZfH8M7fQaqJCmbF789QFI/mxqGlEHO+dLXkPIaXP32nHGrsUQam4kbZl4ZUIMruHTBF9KH8B5ZIw7hYlnQeteNI2fbYfGBjd+TEJu9SrMFfYeXx0TpKPwH/vNi5Ih8j12qmcGHEOKww0N9PP7slX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q2HshcfL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31528C4AF09;
	Mon, 19 May 2025 11:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747654237;
	bh=AzoGK9e92IB4GFZK7Gp2iJJ2pTc/LyEYyg91BJBdfgM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q2HshcfL0q1z+eqswEUIFHRJ6lyVnQwjgfGxHQA18Ul43qbbIsXUdpG6RwnqGlcwu
	 OJij3sO/iPMhhxJgS7LVlBU5cKrRqlOZUnVLAtoxOzdPOdSXvQjTurtkllSq1jRKDk
	 mRQwCpJQkgQUDMnAFj+M/+M336x87s4v+awg4fuyTeYDS6V/R9S2Kka17q1bJIZpYs
	 Vp2F8ex5e7nDhpm4Pl6f/H6fMuMjg7H4CnptorikyQbEEjbaN6tTBSl9kiX91wenlM
	 TJ1K5sgkHPJT98TnKC7LOXtBkI7XgAkdCmw3TwpaSpOOUyPY0aMoP+mU1thZIb0TTQ
	 2NT1KeAskRWQg==
From: Philipp Stanner <phasta@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mark Brown <broonie@kernel.org>,
	Philipp Stanner <phasta@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Yang Yingliang <yangyingliang@huawei.com>,
	Zijun Hu <quic_zijuhu@quicinc.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v3 4/6] PCI: Remove request_flags relict from devres
Date: Mon, 19 May 2025 13:29:58 +0200
Message-ID: <20250519112959.25487-6-phasta@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250519112959.25487-2-phasta@kernel.org>
References: <20250519112959.25487-2-phasta@kernel.org>
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
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
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


