Return-Path: <linux-pci+bounces-45043-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C8765D3167F
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 13:58:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0BD55300D280
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 12:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6C722D7B6;
	Fri, 16 Jan 2026 12:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H77XL9sH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FA51F239B;
	Fri, 16 Jan 2026 12:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768568298; cv=none; b=s5te7P62HFdohqGVa2tMxeV6J8Riw02H1sD1ftHUlGC/YM4oDWojVUXfkVtQ0nYeXhMszjdpIX5meIDRjfjkK6ah46YJBj7IfDcalPVjUaX2W61B5KALsiu9I5g53i1gYkS1OAdNiWgfAYUWkP9+OXl5cusKNz10a5411dNxjNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768568298; c=relaxed/simple;
	bh=QzALkc0FClKUjD4YmlWD7AzxG4iZBETWjIfTKmES/ps=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ibg+gyWQq0Nj8sZEh3AMNk5cT0jEpxY9Tp0rX44gcTAn2mZth/HA8JBIpj6n92sMmQ2pJE1/gA/HCqTQjA3ZBrIcoPAwf1JyRQCpc9Dn9fvm1xhX2OzCW7aPP8bYYCRK9Jk+GtXtl3OYLUOLnFsiLLpnHSJs2eJfLMJqrB4VTKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H77XL9sH; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768568289; x=1800104289;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QzALkc0FClKUjD4YmlWD7AzxG4iZBETWjIfTKmES/ps=;
  b=H77XL9sH0vKulw+0/qNyA+OpK5EUeckJ8BP72lIu+BbB3GXkmdh5VXtt
   XGrc/70KPaiEktRMnn1zxtDbzZMLn+aAiy7PQXGl7yS9rBXYjLcDAgXI4
   Tv/fUC36j5fJe1mUZLBszxy5qcU9v1Oesa2d1UiTTKX0HCVKqRA3VJkjJ
   L9gjVnjVST+RLjModtu5g0simU/xCQNRy3AWfvpcZ89CfbG0uPJVdFwYK
   EmrYwx1Y2i/GCrUVpnkD02EjMWL7DoIr8JB+4vtyrXXnMZk4XXKYm8JQ3
   n2nYWgIiVY66ll5gm4lKDUDNimnTGqhOSxjxFwnXlRrv4XNanJCk+Zzwx
   w==;
X-CSE-ConnectionGUID: R14NHzCDQA+d0nZEg3m3lA==
X-CSE-MsgGUID: ZkuL8OT9RQ+6KCbJ7XMdeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11673"; a="80603144"
X-IronPort-AV: E=Sophos;i="6.21,231,1763452800"; 
   d="scan'208";a="80603144"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2026 04:58:08 -0800
X-CSE-ConnectionGUID: iTSk9lfmTT+eBDRnrhx7jw==
X-CSE-MsgGUID: Skt5wwrRStGRDCwIhz8bCQ==
X-ExtLoop1: 1
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.178])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2026 04:58:05 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: "Jinhui Guo" <guojinhui.liam@bytedance.com>,
	Keith Busch <kbusch@kernel.org>,
	"Anthony Pighin (Nokia)" <anthony.pighin@nokia.com>,
	Alex Williamson <alex@shazbot.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 2/3] PCI: Use device_lock_assert() to verify device lock is held
Date: Fri, 16 Jan 2026 14:57:41 +0200
Message-Id: <20260116125742.1890-3-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260116125742.1890-1-ilpo.jarvinen@linux.intel.com>
References: <20260116125742.1890-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Multiple function comments say the function should be called with
device_lock held. Check that by calling device_lock_assert().

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/pci.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 29a365e2dd57..e1333539c7b7 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4970,6 +4970,7 @@ static void pci_dev_save_and_disable(struct pci_dev *dev)
 	 * races with ->remove() by the device lock, which must be held by
 	 * the caller.
 	 */
+	device_lock_assert(&dev->dev);
 	if (err_handler && err_handler->reset_prepare)
 		err_handler->reset_prepare(dev);
 	else if (dev->driver)
@@ -5040,7 +5041,9 @@ const struct pci_reset_fn_method pci_reset_fn_methods[] = {
  * device including MSI, bus mastering, BARs, decoding IO and memory spaces,
  * etc.
  *
- * Returns 0 if the device function was successfully reset or negative if the
+ * Context: The caller must hold the device lock.
+ *
+ * Return: 0 if the device function was successfully reset or negative if the
  * device doesn't support resetting a single function.
  */
 int __pci_reset_function_locked(struct pci_dev *dev)
@@ -5049,6 +5052,7 @@ int __pci_reset_function_locked(struct pci_dev *dev)
 	const struct pci_reset_fn_method *method;
 
 	might_sleep();
+	device_lock_assert(&dev->dev);
 
 	/*
 	 * A reset method returns -ENOTTY if it doesn't support this device and
@@ -5171,13 +5175,17 @@ EXPORT_SYMBOL_GPL(pci_reset_function);
  * over the reset.  It also differs from pci_reset_function() in that it
  * requires the PCI device lock to be held.
  *
- * Returns 0 if the device function was successfully reset or negative if the
+ * Context: The caller must hold the device lock.
+ *
+ * Return: 0 if the device function was successfully reset or negative if the
  * device doesn't support resetting a single function.
  */
 int pci_reset_function_locked(struct pci_dev *dev)
 {
 	int rc;
 
+	device_lock_assert(&dev->dev);
+
 	if (!pci_reset_supported(dev))
 		return -ENOTTY;
 
-- 
2.39.5


