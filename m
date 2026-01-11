Return-Path: <linux-pci+bounces-44437-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA94D0F70A
	for <lists+linux-pci@lfdr.de>; Sun, 11 Jan 2026 17:31:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B30503045F41
	for <lists+linux-pci@lfdr.de>; Sun, 11 Jan 2026 16:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B231CFBA;
	Sun, 11 Jan 2026 16:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b="DXK8f6TK"
X-Original-To: linux-pci@vger.kernel.org
Received: from aer-iport-5.cisco.com (aer-iport-5.cisco.com [173.38.203.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5836500940;
	Sun, 11 Jan 2026 16:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.38.203.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768149110; cv=none; b=jZl0vNFr+bhXMbeF/2/enCaGlUstlNmF1Y5cn+l6nxwQFERrrNtlMO0jtF1fEPl/5+AsuFlstl8+YPpsQFi6T5KU9hn8mf1EE0C1l9eUn0HusZrDEha9ILfDEUzccs3w4nSEcLTQ2XL1SrW4ExVo17JKATsbWn4adwu+YVJBDbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768149110; c=relaxed/simple;
	bh=3M+D5Pk1RB1PXGOqbgTOism9guPOAvi8po5ooAqu74c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=u/oNFoUBh4tnreVjPvmczGLRdpoNNe/u5B5gJZeaAM+Zx3QZo1/pfLOCQpZTF93u1sPcUutMvlWcp3AqUEq4AikOeslCkKcIkqnaLQpuaBTBX67N4dU85eXk5Q+HQqEqfk/bqmnUfpeaLnp5FaEnH92Bi3Rb0sF5s2QnwdpYFoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=DXK8f6TK; arc=none smtp.client-ip=173.38.203.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=1262; q=dns/txt;
  s=iport01; t=1768149109; x=1769358709;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YUycxQnVlyp92opJehN4MF3k2Mlnikk1ckvSBQWen+M=;
  b=DXK8f6TKgmOEXJg8FoDnEtNu9d9nVl+R9RAI+QXtav6FawgPhEl13jUD
   euMsNKvasfQE1CIi+Vl1cKDb7Jej9RecGRkPFfFYtV+93icMUqBGd2He/
   tEoQXsREdwjxsLlOLhJyCNcdSX+b4RFqTxPYqGKPfjhFVxl3HRasBZHgJ
   EF43fizPN19TAab4OwMsVRqEAANlWkDKChiojMkwcwwTrZkOXOhquksNo
   CU3VjJOpAFotUQuZMbp8sjxOi0OYZHIUhvqHoxRKE8cekOIFhtDdzS5bN
   +NlD+sGHDWHTzx8GHGlgp99YDnJfl8u23UgvH3yB/aBAJqQMQTVzFdSFs
   w==;
X-CSE-ConnectionGUID: 7J4yH6bBRK+4Sx9Me2YmDg==
X-CSE-MsgGUID: IeuGqIIRQIiRnqUwyZgGAg==
X-IPAS-Result: =?us-ascii?q?A0A1AAA/z2Np/8tK/pBaHQEBAQEJARIBBQUBgXwIAQsBg?=
 =?us-ascii?q?kcPgVBCSYxzim6XKYVegX8PAQEBD1EEAQGFB4xuAiY0CQ4BAgQBAQEBAwIDA?=
 =?us-ascii?q?QEBAQEBAQEBAQELAQEFAQEBAgEHBYEOE4Zchl0rCwFGgUgIgwKCdAOuIYF5M?=
 =?us-ascii?q?4EB3j2BYwELFAGBOAGNUYVpJxUGfYEQgRWCcnaECoEGhXcEgzCKdwaJR0iBH?=
 =?us-ascii?q?gNZLAFVEw0KCwcFgWYDNRIqFW4yHYEjPheBCxsHBYItBokAD4lKejIDCxgNS?=
 =?us-ascii?q?BEsNxQbBD5uB49TgnR7E0yCHaVgnk2CRIQmoVgaM6pqAS6HZZBzpFmEaIFoP?=
 =?us-ascii?q?IFZTSMVgyJSGQ+OLRbDFTs1PAIHCwEBAwmRaoF9AQE?=
IronPort-Data: A9a23:vJOiD6IVzxvxIvoEFE+RoZQlxSXFcZb7ZxGr2PjKsXjdYENS1T0Gz
 DQZDWyFOPnfMGXze913bNm+/E8CusSEy941HQUd+CA2RRqmiyZq6fd1j6vUF3nPRiEWZBs/t
 63yUvGZcoZsCCSa/kvxWlTYhSEU/bmSQbbhA/LzNCl0RAt1IA8skhsLd9QR2uaEuvDnRVnU0
 T/Oi5eHYgH9gmctajh8B5+r8XuDgtyj4Fv0gXRmDRx7lAe2v2UYCpsZOZawIxPQKqFIHvS3T
 vr017qw+GXU5X8FUrtJRZ6iLyXm6paLVeS/oiI+t5qK23CulQRuukoPD8fwXG8M49m/c3+d/
 /0W3XC4YV9B0qQhA43xWTEAe811FfUuFLMqvRFTvOTLp3AqfUcAzN0xLh0nHdMS0NxUQj115
 a09JWo8azyM0rfeLLKTEoGAh+wqIdOuOMYUvWttiGmDS/0nWpvEBa7N4Le03h9p2pwIR6uCI
 ZVFL2A3N3wsYDUXUrsTIJsynfalgHb2WzZZs1mS46Ew5gA/ySQqj+Cwb4qEJ7RmQ+10k1u3v
 0PnxV3YAyscLeGA2AiK3Vuj07qncSTTHdh6+KeD3vRqjVmcz3cIIBIRUlS/rL+yjUvWc9ZeL
 VEEvykjt64/8GS1QdTnGR61uniJulgbQdU4O+k77hydj7Lf4i6HCWUeCD1MctorsIkxXzNC6
 7OSt9rkH3lr9baSU3/Yru3SpjKpMi9TJmgHDcMZcTY4DxDYiNlbpnryohxLScZZUvWd9enM/
 g23
IronPort-HdrOrdr: A9a23:SKzEIKjrE4BSyQ7B7PMBRUYTOXBQXtMji2hC6mlwRA09TyVXra
 yTdZMgpH3JYVkqNk3I9errBEDiewK+yXcK2+gs1N6ZNWGMhILCFu5fBOXZrgEIYxefygaYvp
 0QF5SXz7bLfD1Hsfo=
X-Talos-CUID: =?us-ascii?q?9a23=3A1UuGDWklmVLvVu6KLPylGsJQ7H7XOSL/kGbwfUW?=
 =?us-ascii?q?SM0UqFIaFGHqdopJhv8U7zg=3D=3D?=
X-Talos-MUID: 9a23:YlPrHAXBfAucy3jq/B7hmR57FeZS2oWvMkYUrIoXicarHCMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.21,219,1763424000"; 
   d="scan'208";a="37057895"
Received: from aer-l-core-02.cisco.com ([144.254.74.203])
  by aer-iport-5.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 11 Jan 2026 16:30:37 +0000
Received: from bgl-ads-6462.cisco.com (bgl-ads-6462.cisco.com [173.39.34.78])
	by aer-l-core-02.cisco.com (Postfix) with ESMTP id 759E1180005F6;
	Sun, 11 Jan 2026 16:30:36 +0000 (GMT)
From: Aadityarangan Shridhar Iyengar <adiyenga@cisco.com>
To: bhelgass@google.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aadityarangan Shridhar Iyengar <adiyenga@cisco.com>
Subject: [PATCH] PCI/PTM: Fix memory leak in pcie_ptm_create_debugfs() error path
Date: Sun, 11 Jan 2026 22:00:31 +0530
Message-Id: <20260111163031.24647-1-adiyenga@cisco.com>
X-Mailer: git-send-email 2.35.6
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 173.39.34.78, bgl-ads-6462.cisco.com
X-Outbound-Node: aer-l-core-02.cisco.com

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


