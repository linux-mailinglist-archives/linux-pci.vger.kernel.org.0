Return-Path: <linux-pci+bounces-29311-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 755AAAD3432
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 12:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B16C13B83DD
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 10:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6713628D8DF;
	Tue, 10 Jun 2025 10:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mK2j1j3o"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C602928D8E2;
	Tue, 10 Jun 2025 10:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749553118; cv=none; b=VlHh+se7JTk2zrojq6EQw4fJZ0PiYvVE3utncMGVMTQRWBQ4tRRUiInB+3nwI5/bJsqHbFkh9umtf9Owq3BXx6qrMnyvWJBTpjB/t/MQ+M0LKdckOiFAyABooOCCSQPWASCIVcmVz+hGRvuaf2SiJZ5OGaog/hVv6khSs2SutlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749553118; c=relaxed/simple;
	bh=Oizh2j0boq5VJPW2Uex+c53fPrquqBrXQu/zIaJ9f7M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t3rLmLylxLNRrwC0MWmXBziygF/yxzFTF6uh3Pq9gXcdZ9XKtNq7OsrusWliH3PXR9F546+MROnJteIQhDkIjWK3UEWinPHgzWUI+22bXt6/3FxDAeSgSLbWddWwbQdgF+EGyBpJnAZZk55/ZVkRU6xPbYEibHUZqmgyDv1onxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mK2j1j3o; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749553116; x=1781089116;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Oizh2j0boq5VJPW2Uex+c53fPrquqBrXQu/zIaJ9f7M=;
  b=mK2j1j3owl4x4RrQjL3JJ0wmwMyGZeLeAmNKRUQL5JfoVcecdiLnRYI8
   XSvsho3bNIZL6Gndoj/dIKnQiGonR/52jbKeAmPYQfo66b71IZjMwNgHw
   OPjr0KPZMT7KAyPK0Y8AanDCN+WRzm+vs2yfudyeuIEfi2bF1NaaPWSS0
   a148ruK50QaevYm/pLXZAbwKcZTteknBe18GT2M0F4mZIsS8qKOlk/5cg
   H2fOkLRPeCSJMUI2ARU2YQk8CKsE8U/6rlIAtrIhhg8BrBz8iIwUgxMEm
   f1RhCk6RE5dxc8//9EGQA8aWQMPDfDJfseZ/ri+tGp1cRsJFE80AF5NrQ
   w==;
X-CSE-ConnectionGUID: YoXE92kqSdOd1UzXcbUESw==
X-CSE-MsgGUID: 2eR9niHUS2mUhFFheaj61w==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="50764329"
X-IronPort-AV: E=Sophos;i="6.16,224,1744095600"; 
   d="scan'208";a="50764329"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 03:58:36 -0700
X-CSE-ConnectionGUID: BkBJdjIZRnijO0pOAZa8Lw==
X-CSE-MsgGUID: B6qk7N2hQJaoW5B1xfQbbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,224,1744095600"; 
   d="scan'208";a="169979635"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.196])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 03:58:34 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 2/3] PCI: Cleanup early_dump_pci_device()
Date: Tue, 10 Jun 2025 13:58:19 +0300
Message-Id: <20250610105820.7126-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250610105820.7126-1-ilpo.jarvinen@linux.intel.com>
References: <20250610105820.7126-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Convert 256 to PCI_CFG_SPACE_SIZE and 4 to sizeof(u32) and
avoid i / 4 construct by changing the iteration.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/probe.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index c00634e5a2ed..f08e754c404b 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -3,6 +3,7 @@
  * PCI detection and setup code
  */
 
+#include <linux/array_size.h>
 #include <linux/kernel.h>
 #include <linux/delay.h>
 #include <linux/init.h>
@@ -1912,16 +1913,16 @@ static int pci_intx_mask_broken(struct pci_dev *dev)
 
 static void early_dump_pci_device(struct pci_dev *pdev)
 {
-	u32 value[256 / 4];
+	u32 value[PCI_CFG_SPACE_SIZE / sizeof(u32)];
 	int i;
 
 	pci_info(pdev, "config space:\n");
 
-	for (i = 0; i < 256; i += 4)
-		pci_read_config_dword(pdev, i, &value[i / 4]);
+	for (i = 0; i < ARRAY_SIZE(value); i++)
+		pci_read_config_dword(pdev, i * sizeof(u32), &value[i]);
 
 	print_hex_dump(KERN_INFO, "", DUMP_PREFIX_OFFSET, 16, 1,
-		       value, 256, false);
+		       value, ARRAY_SIZE(value) * sizeof(u32), false);
 }
 
 static const char *pci_type_str(struct pci_dev *dev)
-- 
2.39.5


