Return-Path: <linux-pci+bounces-27963-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E89ABBC6A
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 13:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70A96170492
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 11:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5785278758;
	Mon, 19 May 2025 11:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lY4cbMiM"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF45278756;
	Mon, 19 May 2025 11:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747654244; cv=none; b=rbHGWClqkMsLq6YZBAGMV+U5eb0e5tugiaR8nIy76ZZNu/atTNXFYN2ofncnq3KKI9Y2QQpRyxZBovBSwsW33YkKm7/v7JI0sFO3jmbLKYDoSqUhNjTRUkuBAAibwRkJmMJ9/bR49g1nMYzVRpE8OaDh+IBufYNQRCA3JmD1gM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747654244; c=relaxed/simple;
	bh=Dmbm1Nsz0mLac3rVEQyjSTWhEKqeKGKYB7oPAJpKuco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vEbGPiae9v2vSbLlj68tQiFc7M44hkB3Wj/ZaTWm+R0CPDLMWiNL8Xl27vC/8nDpaiYlGhZtGEEk7NsmAMEUBTJYVmFZrBbSoUA9OuICaSTYpN9bz1UTWZH+51PWvXurU5hQrhueqE7tKkAoRSVAWwrzp5qK27/16kPWqiJQkR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lY4cbMiM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26FC2C4CEE4;
	Mon, 19 May 2025 11:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747654244;
	bh=Dmbm1Nsz0mLac3rVEQyjSTWhEKqeKGKYB7oPAJpKuco=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lY4cbMiMv6Z+P9EKta3qTSi8UgTM02ZQ2FlgtSfE5Qo6GK1tS6l9VBjTemm8fVs2S
	 mS661TIhZ3d61gbOvIdGyTWe1ZaD7Y1LUrdclpqhP1GEWNMZRx7WRuemtIXuGGU3pL
	 n+rv5P8VY+OZRLqvvvpz2WHS56VIMDsbcgw3IOzMc7AUG4ZiPSK7bD4ZFhMxz4y1KK
	 RbsJMWfBtkSrU20pC0YV4EXqRNcx5w8T+TLnZu4CN4KBRXEjEfF7X8MbtyLLFYD1UW
	 5OHIDWgUlQjb7yByJz3sf5fa/+uaSd6Yw0MMJh2NvhZfCdcA/IiwANnQtyw5sjeHuW
	 LczAisYgykAEg==
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
Subject: [PATCH v3 6/6] PCI: Remove hybrid-devres hazzard warnings from doc
Date: Mon, 19 May 2025 13:30:00 +0200
Message-ID: <20250519112959.25487-8-phasta@kernel.org>
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

pci/iomap.c still contains warnings about those functions not behaving
in a managed manner if pcim_enable_device() was called. Since all hybrid
behavior that users could know about has been removed by now, those
explicit warnings are no longer necessary.

Remove the hybrid-devres warnings from the docstrings.

Signed-off-by: Philipp Stanner <phasta@kernel.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
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


