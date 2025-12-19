Return-Path: <linux-pci+bounces-43423-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C32DBCD153C
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 19:19:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A729030C9E79
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 18:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781BB33E348;
	Fri, 19 Dec 2025 17:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EYAWEZM0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC30533E36E;
	Fri, 19 Dec 2025 17:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766166118; cv=none; b=caSUykau4yokVZRnzVPt8axHSjnz8/mp3B5Cq9eV/fzaWFtUxSio+9rrC2lhyxbOmOrcjlCPI0pLycrjjLKzujfwQyQ9XmSLaQ444YsGjy1V3+S8WIG4kqgMuMWZ+7iUMC44JXsKE757+Nr8dkG276xhj2PLwXvwl6/RFB89+uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766166118; c=relaxed/simple;
	bh=X7cenCZN9EHafgeIYFAYKB0YGZAFrvyjhb696q8dE04=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=agJm2+jNbN6QVuYacLY6fdGQ2RVvRWsfE9pebe1LcBQG9ko656/pFJ1+wuodwXTYaTykPXDTDpO7md/u0DJzrin2veYFA1zhiuFK+zQFBb4R2mA6iMnzFN8FXMDdK/lCnej2cSEh0C6iBDJevS7lNTfONq+l3acFCZEw5yK/p5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EYAWEZM0; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766166117; x=1797702117;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=X7cenCZN9EHafgeIYFAYKB0YGZAFrvyjhb696q8dE04=;
  b=EYAWEZM019um/aTjV1u0vwQ6HO04ROCtXsxWEPPLsq788DVUB/BUIY0t
   11cJ7z8QZn6APGhlaqLTRMaUtDX2dI8ULl1AxEWIYsSv7ScJFy88UF2Qx
   ltQXojMp4GRTkmwrLi7hvKgHZuXppLDJRwePKZEPIf6QlwOaWN+9pGO9f
   f5yUJOdvpXN2kQJEDbq/fbW1BDnjZ7c74UHjE+SJZxb2WRhzGEdMij/ry
   n5LCoUEjrJLFvpaZt/1TV0YZJFeU1Yi3YZZUVN0+W2fW+Dzex4CoEkmkO
   qt/d6RsMYAmZnGxCvra0RZTg99iVTNfTgl0d4xDL2qdZzyoYekTK6O6ko
   g==;
X-CSE-ConnectionGUID: f8B2qdNfTneRZlN/gkA6iQ==
X-CSE-MsgGUID: ZLWqpaNnQgGci1CRcvWkfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11635"; a="68062529"
X-IronPort-AV: E=Sophos;i="6.20,256,1758610800"; 
   d="scan'208";a="68062529"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2025 09:41:56 -0800
X-CSE-ConnectionGUID: c1z7FTpkTtiWwxhKTR6y6g==
X-CSE-MsgGUID: +aOxzWu4QCSqBOTWeoeR8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,161,1763452800"; 
   d="scan'208";a="199748002"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.61])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2025 09:41:53 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 08/23] PCI: Use res_to_dev_res() in reassign_resources_sorted()
Date: Fri, 19 Dec 2025 19:40:21 +0200
Message-Id: <20251219174036.16738-9-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251219174036.16738-1-ilpo.jarvinen@linux.intel.com>
References: <20251219174036.16738-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

reassign_resources_sorted() contains a search loop for a particular
resource in the head list. res_to_dev_res() already implements the same
search so use it instead.

Drop unused found_match and dev_res variables.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/setup-bus.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 90bb9baf68b9..09cc225bf107 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -414,7 +414,6 @@ static void reassign_resources_sorted(struct list_head *realloc_head,
 				      struct list_head *head)
 {
 	struct pci_dev_resource *add_res, *tmp;
-	struct pci_dev_resource *dev_res;
 	struct pci_dev *dev;
 	struct resource *res;
 	const char *res_name;
@@ -422,8 +421,6 @@ static void reassign_resources_sorted(struct list_head *realloc_head,
 	int idx;
 
 	list_for_each_entry_safe(add_res, tmp, realloc_head, list) {
-		bool found_match = false;
-
 		res = add_res->res;
 		dev = add_res->dev;
 		idx = pci_resource_num(dev, res);
@@ -437,13 +434,7 @@ static void reassign_resources_sorted(struct list_head *realloc_head,
 			goto out;
 
 		/* Skip this resource if not found in head list */
-		list_for_each_entry(dev_res, head, list) {
-			if (dev_res->res == res) {
-				found_match = true;
-				break;
-			}
-		}
-		if (!found_match) /* Just skip */
+		if (!res_to_dev_res(head, res))
 			continue;
 
 		res_name = pci_resource_name(dev, idx);
-- 
2.39.5


