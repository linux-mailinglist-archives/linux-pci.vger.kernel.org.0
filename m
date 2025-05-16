Return-Path: <linux-pci+bounces-27890-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52572ABA221
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 19:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45C03A239C4
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 17:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A480279793;
	Fri, 16 May 2025 17:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NhDGzoqd"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E12825CC77;
	Fri, 16 May 2025 17:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747417332; cv=none; b=sXnjoaNhqYPSosJbkNXuV0xZvMpWG7bEJJtk1QdjilI63/5FXmReEwSd8AYsBzURRSrsTaUpgyy+QfqQdXy9IFf1B0A6yNd/MgZCibBR1LriQkKOyin7lukfr4OEqG1D/w6L9zlA22itCRB8e7CMZpnGn/zY99HvESClduQjMuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747417332; c=relaxed/simple;
	bh=aHb4LFr3eYFJfnPvyI1wlR82Dyg/3IrBHAyHSTUXdVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JgGycn1dKbIza4Y1VipeuitXaic0JD0GLnboMTT5/q1qPZGnwzrwb8ljdYFvTlC5xyK5jp3pq83oQJJ4ey3RDZb1Bo/x1GKqd82TT9rTgwBgfrYECMCLklmVHFTY0i3ILvVfD9worZ2ClhxFClPezkJJb7u7ycoUOl88M+jXEQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NhDGzoqd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B069C4CEE4;
	Fri, 16 May 2025 17:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747417331;
	bh=aHb4LFr3eYFJfnPvyI1wlR82Dyg/3IrBHAyHSTUXdVs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NhDGzoqdjletwYuNaDgi1U4AcuQOMgW20BhwcM1wBJvkpFD36SozlJjvnGab7jR/0
	 diZuymZvQNPzh00utpf2XfPcAiaDTtYwLNFhPD+fI0EFW3nfhJfTMntJFZnylGCbmc
	 Z4jh04hbZvclFsjw3lNB7X6LqZmugieea71pV3QU2bjlwV3h9RMtc6VWtN4xiKKZNp
	 WdY/fE/x6W+BpXi9558CrnMDdQSNDv/jBt70GFD8gSuriRiomoAN7X9JjK+CL/LSnd
	 Qu4uW0tby2Gp1Nb4e67NK+apYNIqzO+pSuksCBaEocXto+Gm/x5nBXt6qGUl5YPwLB
	 SsX5+xdYz0Z2w==
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
Subject: [PATCH v2 6/6] PCI: Remove hybrid-devres hazzard warnings from doc
Date: Fri, 16 May 2025 19:41:41 +0200
Message-ID: <20250516174141.42527-7-phasta@kernel.org>
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

pci/iomap.c still contains warnings about those functions not behaving
in a managed manner if pcim_enable_device() was called. Since all hybrid
behavior that users could know about has been removed by now, those
explicit warnings are no longer necessary.

Remove the hybrid-devres warnings from the docstrings.

Signed-off-by: Philipp Stanner <phasta@kernel.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pci/iomap.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/pci/iomap.c b/drivers/pci/iomap.c
index fe706ed946df..ea86c282a386 100644
--- a/drivers/pci/iomap.c
+++ b/drivers/pci/iomap.c
@@ -25,10 +25,6 @@
  *
  * @maxlen specifies the maximum length to map. If you want to get access to
  * the complete BAR from offset to the end, pass %0 here.
- *
- * NOTE:
- * This function is never managed, even if you initialized with
- * pcim_enable_device().
  * */
 void __iomem *pci_iomap_range(struct pci_dev *dev,
 			      int bar,
@@ -76,10 +72,6 @@ EXPORT_SYMBOL(pci_iomap_range);
  *
  * @maxlen specifies the maximum length to map. If you want to get access to
  * the complete BAR from offset to the end, pass %0 here.
- *
- * NOTE:
- * This function is never managed, even if you initialized with
- * pcim_enable_device().
  * */
 void __iomem *pci_iomap_wc_range(struct pci_dev *dev,
 				 int bar,
@@ -127,10 +119,6 @@ EXPORT_SYMBOL_GPL(pci_iomap_wc_range);
  *
  * @maxlen specifies the maximum length to map. If you want to get access to
  * the complete BAR without checking for its length first, pass %0 here.
- *
- * NOTE:
- * This function is never managed, even if you initialized with
- * pcim_enable_device(). If you need automatic cleanup, use pcim_iomap().
  * */
 void __iomem *pci_iomap(struct pci_dev *dev, int bar, unsigned long maxlen)
 {
@@ -152,10 +140,6 @@ EXPORT_SYMBOL(pci_iomap);
  *
  * @maxlen specifies the maximum length to map. If you want to get access to
  * the complete BAR without checking for its length first, pass %0 here.
- *
- * NOTE:
- * This function is never managed, even if you initialized with
- * pcim_enable_device().
  * */
 void __iomem *pci_iomap_wc(struct pci_dev *dev, int bar, unsigned long maxlen)
 {
-- 
2.49.0


