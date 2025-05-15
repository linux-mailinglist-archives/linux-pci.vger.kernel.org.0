Return-Path: <linux-pci+bounces-27793-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B81AB86CB
	for <lists+linux-pci@lfdr.de>; Thu, 15 May 2025 14:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 861323BB36E
	for <lists+linux-pci@lfdr.de>; Thu, 15 May 2025 12:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E0E29A9FA;
	Thu, 15 May 2025 12:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SNzhjmZs"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A42629B76A;
	Thu, 15 May 2025 12:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747313190; cv=none; b=pcnYtTY5HwxZVv7rJfG1jxEXyAYvFe6YzyOYm3Acy+AXYqvp8g7K+E+vp1wEFCtBKkmBbfnnCgUZFZ8HPhKfWiJIYDUW5/VIWONWYf405qtcz5aPayRepk7bWef2LzK67aH94n41sc23aiNczMctPNSmiIFZaGMpQBgjxZWdIE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747313190; c=relaxed/simple;
	bh=GU4MOVdN8oQjUQHsT+2DBnOtiOsxgXpBZ4DC2Y4gtzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o2PNZh3o0N8elw+49MfsMXLe39Yot6qzjs7aGfrkWgWmUQCLtcfVVj+gw/q6+SimxvduHQchWpxGMGTjlW4JrCOpz2DhB5yUwbctVQh5R+0yXD/eGkWFc/O+DTCV2v4VAAxO+RBfeR89GS6LI4lo0CkcYlEvsQBryLCVE3k9UJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SNzhjmZs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83B23C4CEEB;
	Thu, 15 May 2025 12:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747313190;
	bh=GU4MOVdN8oQjUQHsT+2DBnOtiOsxgXpBZ4DC2Y4gtzY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SNzhjmZshn9faqlOO/UXUdkROEcpyoGl06usHmEI6Rs6DEakxPDxYM3LHRADfhA9Q
	 fxtvD7kqCW1Tt8TLxF6SpktCP3T2jbVB21qz9dz3E+3DOlYukoFr88hYYaDLuGaRIJ
	 ArXxFcsc357ppXX3UOj1czz28s7VYrTxCN7ZKmpjop+ART4i6koNW/nqn+gjGWYc4B
	 3+GBrzu8HL0LKnbdHkwenW5MNaiuTaUyOJAXc6O68sqCARwudX/4vIKo+RHlqW7WPk
	 SwBZzRPO3KkKxMdMY0jaP71jbrxlgQG1KRIauBCZ4DYfkK+7pQKLM9Sn06Al7AQLZf
	 vSPoEMaSJg50w==
From: Philipp Stanner <phasta@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Stanner <phasta@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Zijun Hu <quic_zijuhu@quicinc.com>,
	Yang Yingliang <yangyingliang@huawei.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH 4/7] PCI: Remove request_flags relict from devres
Date: Thu, 15 May 2025 14:46:02 +0200
Message-ID: <20250515124604.184313-6-phasta@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250515124604.184313-2-phasta@kernel.org>
References: <20250515124604.184313-2-phasta@kernel.org>
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


