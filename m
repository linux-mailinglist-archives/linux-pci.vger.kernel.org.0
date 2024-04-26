Return-Path: <linux-pci+bounces-6693-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B03068B3A3A
	for <lists+linux-pci@lfdr.de>; Fri, 26 Apr 2024 16:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65CDA1F24702
	for <lists+linux-pci@lfdr.de>; Fri, 26 Apr 2024 14:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E8D13F43A;
	Fri, 26 Apr 2024 14:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l4OaxQCx"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD5713A257;
	Fri, 26 Apr 2024 14:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714142445; cv=none; b=NU8G20d44y9LySAspvgqK/JbLsxJY4SiwWT6ba/7mRX/pXMZnnRQcCTPX5QqhJ5RyepVXXsjg/0Ad7OY2Ca63ijrn26mPQFRDF5LI3+uKzwkqeh3ZZWvD7K0vMj5UhgzdtzO7KBtIO5Bw48m3M5vdu9Nwz7hmNuP2zogv6bWaR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714142445; c=relaxed/simple;
	bh=Qi1xos48u92PTgN9V46JqEiIClxAHAsrNJ9V8CaZ4Gs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eIGjcwvC3MdO3GvHimmpg8S2EG3Awz7JFD+QPjIbOsRpi5tEzMuvpZfgQsNFZgejswwVovCxGwDH1qumywFpIWF/s4vYwjsvLORoe28yVfb3IpV3/8x8rQ3cmMGrSsCFmNakR2GefVCAvBfCKZlCpTlePfp+CBOs4HuFLRS4W8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l4OaxQCx; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714142444; x=1745678444;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Qi1xos48u92PTgN9V46JqEiIClxAHAsrNJ9V8CaZ4Gs=;
  b=l4OaxQCxQkJeXNqm6pMFp0zFuHjrt5IuQUIyJLeX0ZuLdH4kQ0md7igb
   Xg/XOkQR3Tt9fyKLq0gqJ4Y7tQOvx6cWn6OHrU0w/9oxOcZyPe2sDQ5Vy
   xRe8xPtYExDjdPHcxonQmaacRvZwijnksKIAReFjjKz+bWK7DZaf6O5VV
   pVyEDhR4AH85lM1UdXZ/26hj4F6cJTM9/3TKOt2lzRUJ0fiY49beP76Tp
   0ZgsrDSsk8zHXRPm/+OkvYkXrEqU+D+aTo7qoAO9AOYAxw6pS68wPVmeN
   aFPR/REeB6sCOHiV1lUifMPtWUfnaM5g2qXlCJDunU192bOHO0RatTFvI
   g==;
X-CSE-ConnectionGUID: Rux980dbSOC3ZK/7mDuMVw==
X-CSE-MsgGUID: +MWXaCEBTxmLQeX2c1l4Mg==
X-IronPort-AV: E=McAfee;i="6600,9927,11056"; a="9746319"
X-IronPort-AV: E=Sophos;i="6.07,232,1708416000"; 
   d="scan'208";a="9746319"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 07:40:43 -0700
X-CSE-ConnectionGUID: 1YGmTji+SNy2dc1F81SCcA==
X-CSE-MsgGUID: cyeZJljuQGqP9y2oztmNHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,232,1708416000"; 
   d="scan'208";a="48673627"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa002.fm.intel.com with ESMTP; 26 Apr 2024 07:40:42 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id E84B821A; Fri, 26 Apr 2024 17:40:40 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] PCI/MSI: Make error path handling follow the standard pattern
Date: Fri, 26 Apr 2024 17:40:39 +0300
Message-ID: <20240426144039.557907-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make error path handling follow the standard pattern, i.e.
checking for errors first. This makes code much more easier
to read and understand despite being a bit longer.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pci/msi/msi.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index 682fa877478f..c5625dd9bf49 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -86,9 +86,11 @@ static int pcim_setup_msi_release(struct pci_dev *dev)
 		return 0;
 
 	ret = devm_add_action(&dev->dev, pcim_msi_release, dev);
-	if (!ret)
-		dev->is_msi_managed = true;
-	return ret;
+	if (ret)
+		return ret;
+
+	dev->is_msi_managed = true;
+	return 0;
 }
 
 /*
@@ -99,9 +101,10 @@ static int pci_setup_msi_context(struct pci_dev *dev)
 {
 	int ret = msi_setup_device_data(&dev->dev);
 
-	if (!ret)
-		ret = pcim_setup_msi_release(dev);
-	return ret;
+	if (ret)
+		return ret;
+
+	return pcim_setup_msi_release(dev);
 }
 
 /*
-- 
2.43.0.rc1.1336.g36b5255a03ac


