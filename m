Return-Path: <linux-pci+bounces-27796-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC7FAB86CE
	for <lists+linux-pci@lfdr.de>; Thu, 15 May 2025 14:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B66E24E361D
	for <lists+linux-pci@lfdr.de>; Thu, 15 May 2025 12:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1652A29B795;
	Thu, 15 May 2025 12:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o3h6LnSu"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECB4297B93;
	Thu, 15 May 2025 12:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747313201; cv=none; b=Q//oYycUYo3rZr4J1sY0oojbzEOghYXKb43VVsk/tuvsR8eGPJhxD2Ct5473CkFyrChe1LPnF40PJgsYMxgMk6Mye9QTuQ34WfHxKkRmnf84/04F7MmmUpMmloCn/IbAgbEDszwF0SLFh5drCnf1Vo6qP3nr5CAAYaEJksChfQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747313201; c=relaxed/simple;
	bh=3A8EuqIeubhMNr0yMrCc9pby4qqj5GfRmkTNS440bZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EUp8Vs7RDm95KIItaYaOHkDvsMtWvDJukeTNq1XTJh9Dhnnt+urNO4SYZlvefQ3wjjcEfnp9Bs3TkKckdQrOYN3ocpA2UTxfgsWGYE/0MhfPdi1xpglVn0uil7ayzJ7sedG6IOEnEdOrlEncWWJQcLfpnFCY2//BwtwHewtkI6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o3h6LnSu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D89DBC4CEF2;
	Thu, 15 May 2025 12:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747313200;
	bh=3A8EuqIeubhMNr0yMrCc9pby4qqj5GfRmkTNS440bZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o3h6LnSub8Npdypg0UH49iz7E2CHzvr522D3g6w5Bswc3BlqQOneZbo93lZu30200
	 FGCSED0gXyZ/ypj2T4zCcaQ1+Uaag8ypJ577VMyhfQCjyWQLIXdYHGdpHMLgtaq5gL
	 zBjGAFw7qcDr66/IKDFmg1+0WlngTN+auIJI9bsvJag5/f2+DKqsmfzs+6IQBu5DCX
	 dyLLLX1tZlUiXc1xnOglKGLnXzj0VaH55vUtXCTQHmBgM4WSEe0yTtxU6e/UNwdacP
	 NlKn8TvIhFzjy3hAYR5C4v+A5VAWDdqnqyVKJF2WnrKhnt2DWqd88ZMSL/m/x3ch75
	 FMGo5Yd45lGWg==
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
Subject: [PATCH 7/7] PCI: Remove hybrid-devres hazzard warnings from doc
Date: Thu, 15 May 2025 14:46:05 +0200
Message-ID: <20250515124604.184313-9-phasta@kernel.org>
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

pci/iomap.c still contains warnings about those functions not behaving
in a managed manner if pcim_enable_device() was called. Since all hybrid
behavior that users could know about has been removed by now, those
explicit warnings are no longer necessary.

Remove the hybrid-devres warnings from the docstrings.

Signed-off-by: Philipp Stanner <phasta@kernel.org>
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


