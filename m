Return-Path: <linux-pci+bounces-44438-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 108DBD0F72E
	for <lists+linux-pci@lfdr.de>; Sun, 11 Jan 2026 17:38:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D64C303E409
	for <lists+linux-pci@lfdr.de>; Sun, 11 Jan 2026 16:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56D1221554;
	Sun, 11 Jan 2026 16:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b="dt+6J3Ao"
X-Original-To: linux-pci@vger.kernel.org
Received: from aer-iport-7.cisco.com (aer-iport-7.cisco.com [173.38.203.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADA8500940;
	Sun, 11 Jan 2026 16:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.38.203.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768149488; cv=none; b=NBlIzGoUe0s8Xb0TfigsnGXOI6/bhYVq9dOzYr0HOIh/6Tle/0rcw5cFDxszfLIgIpYOyL3ZmmelLsDL3SAnDUiiAj7kCpLA8de80A3uWGzxFecsYusK3YYSuTig7rz6k1IixSraq3Wyqk/9sRbdQXjYsdrIi/2XI8gln+RCze8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768149488; c=relaxed/simple;
	bh=3M+D5Pk1RB1PXGOqbgTOism9guPOAvi8po5ooAqu74c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e20cEk9G+FIaDb13usuCN9qOqRjtLbDU0n5v4i9UIldxkXM1D0+IgR76k7phmlxGzl3vvynoupyEQ2NDHz8JpvbD3vh8wi58b1a5ZixlwaaRGAQS/hnSMJj0ROVNBGkybj1GDQXjRXMK1TefLQGHPsUEdEeTlJY78jZF9vs3Pps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=dt+6J3Ao; arc=none smtp.client-ip=173.38.203.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=1262; q=dns/txt;
  s=iport01; t=1768149487; x=1769359087;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YUycxQnVlyp92opJehN4MF3k2Mlnikk1ckvSBQWen+M=;
  b=dt+6J3Ao7St91VNM4ZwD3QrYQp3IfEOsZ8YtnG5QDMTP1tihyb+xXY49
   E7u8haRTiDw28nKfYgWvE0dPpKcY2EH8k4cMkMw0W4pSu4bPnT3Qo53mQ
   H6K/+nPiW40ThY6PisePQpkgak+IgQD0v0cMJ1l/aJ7z/L37RKC6t7u+v
   ZUTdpte9aLfdLtTKDqw+X/klaPXpXQ4xmpBvlSBEq++8U2Y60MqwNWyXv
   iLX8bkwZVsm5CGhguDGxLdR5dLodjoPWfmsiFtEcUtGw9YsTTRsUjyzUn
   lZoV+H+GN8RXEGd923VMMXZhmziUpUmNSOtoyM4KItNHgFaRL1IdczQ4/
   g==;
X-CSE-ConnectionGUID: cXsvbdh8QFSivU1m1luAsw==
X-CSE-MsgGUID: +tWFxql5SWKZh/Upn4y7kA==
X-IPAS-Result: =?us-ascii?q?A0A1AAAn0WNp/9FK/pBaHQEBAQEJARIBBQUBgXwIAQsBg?=
 =?us-ascii?q?kcPgVBCSYxzim6XKYVegX8PAQEBD1EEAQGFB4xuAiY0CQ4BAgQBAQEBAwIDA?=
 =?us-ascii?q?QEBAQEBAQEBAQELAQEFAQEBAgEHBYEOE4Zchl0rCwFGgUgIgwKCdAOuGIF5M?=
 =?us-ascii?q?4EB3j2BYwELFAGBOAGNUYVpJxUGfYEQgRWCcnaECoEGhXcEgzCKdwaJR0iBH?=
 =?us-ascii?q?gNZLAFVEw0KCwcFgWYDNRIqFW4yHYEjPheBCxsHBYItBokAD4lKejIDCxgNS?=
 =?us-ascii?q?BEsNxQbBD5uB49TgnR7E0yCHaVgnk2CRIQmoVgaM6pqAS6HZZBzpFmEaIFoP?=
 =?us-ascii?q?IFZTSMVgyJSGQ+OLRbDDjs1PAIHCwEBAwmRaoF9AQE?=
IronPort-Data: A9a23:YzOG8qNwVD3vCRfvrR3VlsFynXyQoLVcMsEvi/4bfWQNrUokgzYFm
 GMXUGuGO/rbamb2eotwaI2x9R9SucTdyoRhHXM5pCpnJ55oRWUpJjg4wmPYZX76whjrFRo/h
 ykmQoCeaphyFTmE+kvF3oHJ9RFUzbuPSqf3FNnKMyVwQR4MYCo6gHqPocZh6mJTqYb/WVrlV
 e/a+ZWFZgf8gmcsaAr41orawP9RlKWq0N8nlgRWicBj5Df2i3QTBZQDEqC9R1OQapVUBOOzW
 9HYx7i/+G7Dlz91Yj9yuu+mGqGiaue60Tmm0hK6aYD76vRxjnBaPpIACRYpQRw/ZwNlMDxG4
 I4lWZSYEW/FN0BX8QgXe0Ew/ypWZcWq9FJbSJSymZT78qHIT5fj6/5eF188MY1Iw8hMAH9zr
 PlBLC0kdQ/W0opawJrjIgVtrs0uNozveYgYoHwllWGfBvc9SpeFSKLPjTNa9G5s2oYUQKqYO
 JZfM2I+BPjDS0Un1lM/AZ4/jequiXDXeDxDo1XTrq0yi4TW5FApi+GxYIuMEjCMbYZJoWiIv
 2abxFvaMBFdCcSZlSva8Vv504cjmgu+Aur+DoaQ/P5nhFKaz3c7BxoRWl+25/K+jyaWX9NZN
 lxR+Sc0q6U23FKkQ8O7XBCipnOA+BkGVLJ4F+w89RHI0qHVyxiWC3JCTTNbbtEi8sgsSlQXO
 kShlt7zQDgqu7qPRDfFpvGfrCi5Pm4eKmpqiTI4cDbpKuLL+Okb5i8jhP46eEJpprUZwQ3N/
 g0=
IronPort-HdrOrdr: A9a23:lV9mwK8Plhn2DndjA9duk+DRI+orL9Y04lQ7vn2ZhyY4TiX+rb
 HNoB1173HJYVoqMk3I+urwW5VoP0m8yXcd2+B4VotKNzOIhILHFuxfBPPZowEJ30bFh4pgPW
 AKSdkaNOHN
X-Talos-CUID: =?us-ascii?q?9a23=3AOHPy9GmUoviYhwHWnKiuwywDjXfXOXbt12naL0/?=
 =?us-ascii?q?oMEhSSaOoEFrJ/L5NiNU7zg=3D=3D?=
X-Talos-MUID: 9a23:C//vQwl1scR78f6tdv4SdnohKPhG872qVXsysqcG/PScM3BhZDS02WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.21,219,1763424000"; 
   d="scan'208";a="40314891"
Received: from aer-l-core-08.cisco.com ([144.254.74.209])
  by aer-iport-7.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 11 Jan 2026 16:36:56 +0000
Received: from bgl-ads-6462.cisco.com (bgl-ads-6462.cisco.com [173.39.34.78])
	by aer-l-core-08.cisco.com (Postfix) with ESMTP id A5B71180001A5;
	Sun, 11 Jan 2026 16:36:54 +0000 (GMT)
From: Aadityarangan Shridhar Iyengar <adiyenga@cisco.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aadityarangan Shridhar Iyengar <adiyenga@cisco.com>
Subject: [PATCH] PCI/PTM: Fix memory leak in pcie_ptm_create_debugfs() error path
Date: Sun, 11 Jan 2026 22:06:50 +0530
Message-Id: <20260111163650.33168-1-adiyenga@cisco.com>
X-Mailer: git-send-email 2.35.6
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 173.39.34.78, bgl-ads-6462.cisco.com
X-Outbound-Node: aer-l-core-08.cisco.com

In pcie_ptm_create_debugfs(), if devm_kasprintf() fails after successfully
allocating ptm_debugfs with kzalloc(), the function returns NULL without
freeing the allocated memory, resulting in a memory leak.

Fix this by adding kfree(ptm_debugfs) before returning NULL in the
devm_kasprintf() error path.

This leak is particularly problematic during memory pressure situations
where devm_kasprintf() is more likely to fail, potentially compounding
the memory exhaustion issue.

Fixes: 132833405e61 ("PCI: Add debugfs support for exposing PTM context")
Signed-off-by: Aadityarangan Shridhar Iyengar <adiyenga@cisco.com>
---
 drivers/pci/pcie/ptm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/ptm.c b/drivers/pci/pcie/ptm.c
index ed0f9691e7d1..09c0167048a3 100644
--- a/drivers/pci/pcie/ptm.c
+++ b/drivers/pci/pcie/ptm.c
@@ -542,8 +542,10 @@ struct pci_ptm_debugfs *pcie_ptm_create_debugfs(struct device *dev, void *pdata,
 		return NULL;
 
 	dirname = devm_kasprintf(dev, GFP_KERNEL, "pcie_ptm_%s", dev_name(dev));
-	if (!dirname)
+	if (!dirname) {
+		kfree(ptm_debugfs);
 		return NULL;
+	}
 
 	ptm_debugfs->debugfs = debugfs_create_dir(dirname, NULL);
 	ptm_debugfs->pdata = pdata;
-- 
2.35.6


