Return-Path: <linux-pci+bounces-15469-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C29629B3818
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2024 18:47:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3BEE1C22265
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2024 17:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91EDE1DFD95;
	Mon, 28 Oct 2024 17:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EGiiEgnQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F0320103A;
	Mon, 28 Oct 2024 17:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730137270; cv=none; b=IkXzMJisemV64uyY7BzhCzSbPod/vFwUFdpyg8ovf1wE5pXfn7E1wQ6KaHlz4accfl7wmsKtxYtTuezb28J+5GI8/A1P17SfYpyBZa3U5lrPyHvmv2n7WdCwATkkaI2yoLRQQCu7NZMQNbXPzKq2NZ9km0L30rGk+um/Tm5JW7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730137270; c=relaxed/simple;
	bh=4qPJ8bGlM4XwX/2GRsRwuZqwEguKLSacMHyZ7tm+Y9M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f8X48bxXGhZ0v3boSnjH0damGJ/ZQy4gMSmCi/q+AmKmpigdy+gF1VPqszTdYJN8tVJm8vMXmA3Y0rEuJSqS1piK74uZmyp5IqECttWoaQfzX9CrVSLMWxulLmAGBlRvr0dklJaANdOsdsUsvZ1qlCfjooUbcWsTtW7HSnoH2sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EGiiEgnQ; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730137269; x=1761673269;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4qPJ8bGlM4XwX/2GRsRwuZqwEguKLSacMHyZ7tm+Y9M=;
  b=EGiiEgnQVyhBDQMoO4EivVKWUbiYg1HQXdhe4YkDWxBHWYL3G3qK0Gs+
   6kOwQFnbkXYqIKgmyiJxKY9gEM51sM/L00WHJf1Id1AwFNPSwsyxZEDHi
   nU9yw+WwhFF+ADPjze5D0EZyFveGXibfB1+lbJXO/uksTgce4bZIeAfkx
   k+HjyQ6fYO3O1Pc4AqNRXmojnoU0fWg+TP5qmEnWzrPkkq7rUlhLqCGoI
   ThhGVieF20mvqrkLecMghpDAPTGSHPE/6IddWJYXO2PDtOkT7Gq7BGMzz
   QRZgSxzTiUtNHx/7XORHb5BFNQFJ70U/6DcITYASM+Ixz9mj6NEirHfhH
   Q==;
X-CSE-ConnectionGUID: iHpScUlETxKcm1VVXp4X9g==
X-CSE-MsgGUID: IzlGN83xQDW6MFP1hu7qCQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="33440563"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="33440563"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 10:41:09 -0700
X-CSE-ConnectionGUID: psOkLGTBTVWFZkiyUNcy4g==
X-CSE-MsgGUID: 6GQ59nj2RYKlcXSU9bpEmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="105015026"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.203])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 10:41:06 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 2/3] PCI/sysfs: Use __free() in reset_method_store()
Date: Mon, 28 Oct 2024 19:40:45 +0200
Message-Id: <20241028174046.1736-3-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241028174046.1736-1-ilpo.jarvinen@linux.intel.com>
References: <20241028174046.1736-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Use __free() from  cleanup.h to handle freeing options in
reset_method_store() as it simplifies the code flow.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/pci-sysfs.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 507478082454..74e4e0917898 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -13,6 +13,7 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/cleanup.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/pci.h>
@@ -1430,7 +1431,7 @@ static ssize_t reset_method_store(struct device *dev,
 				  const char *buf, size_t count)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
-	char *options, *tmp_options, *name;
+	char *tmp_options, *name;
 	int m, n;
 	u8 reset_methods[PCI_NUM_RESET_METHODS] = { 0 };
 
@@ -1445,7 +1446,7 @@ static ssize_t reset_method_store(struct device *dev,
 		return count;
 	}
 
-	options = kstrndup(buf, count, GFP_KERNEL);
+	char *options __free(kfree) = kstrndup(buf, count, GFP_KERNEL);
 	if (!options)
 		return -ENOMEM;
 
@@ -1457,20 +1458,21 @@ static ssize_t reset_method_store(struct device *dev,
 
 		name = strim(name);
 
+		/* Leave previous methods unchanged if input is invalid */
 		m = reset_method_lookup(name);
 		if (!m) {
 			pci_err(pdev, "Invalid reset method '%s'", name);
-			goto error;
+			return -EINVAL;
 		}
 
 		if (pci_reset_fn_methods[m].reset_fn(pdev, PCI_RESET_PROBE)) {
 			pci_err(pdev, "Unsupported reset method '%s'", name);
-			goto error;
+			return -EINVAL;
 		}
 
 		if (n == PCI_NUM_RESET_METHODS - 1) {
 			pci_err(pdev, "Too many reset methods\n");
-			goto error;
+			return -EINVAL;
 		}
 
 		reset_methods[n++] = m;
@@ -1483,13 +1485,7 @@ static ssize_t reset_method_store(struct device *dev,
 	    reset_methods[0] != 1)
 		pci_warn(pdev, "Device-specific reset disabled/de-prioritized by user");
 	memcpy(pdev->reset_methods, reset_methods, sizeof(pdev->reset_methods));
-	kfree(options);
 	return count;
-
-error:
-	/* Leave previous methods unchanged */
-	kfree(options);
-	return -EINVAL;
 }
 static DEVICE_ATTR_RW(reset_method);
 
-- 
2.39.5


