Return-Path: <linux-pci+bounces-43424-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E52E9CD13E5
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 18:55:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8039730CBF6E
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 17:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2B633F37E;
	Fri, 19 Dec 2025 17:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RmZ2PZ3x"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5BF33E36E;
	Fri, 19 Dec 2025 17:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766166125; cv=none; b=ZOeXMdh5JmcHxVSmWy7w+FdVhkaC3IR4fpH0eiGhe0KQ70nHIRjT8NDkRPyfAOhyU4A/bBcxTfJnNTMwt+0ZcCez3FBsnlsHk1hNKytogABhphYRH51ecjjHabI9FSuWTXUSn7IK9hbjMGGx3Bajv99VmWZd2gRg+sXGTcgQVJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766166125; c=relaxed/simple;
	bh=om3ws1vRY8NzG2OY8m8A/ZvUw3IlUN/TkNBaTtaKbyU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mAux1+S3ilw0xdcONz0Dlo8w5M+jq0hwL3VSfkOvJUusvdpGpWPg/wZudYjvyaUg4z1+LyPr4hJQjBzEZ5MwxbZB8fUfrOwIoiYxRY7nay/gThVbLjKHr88nVYPDcyPbXdiJwCQAxj/V10idYtLg3iGVFQESlpJ2EpWe8TB/ufM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RmZ2PZ3x; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766166124; x=1797702124;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=om3ws1vRY8NzG2OY8m8A/ZvUw3IlUN/TkNBaTtaKbyU=;
  b=RmZ2PZ3x2wcLm8nAAvMZpvWi4l/GJbMtMbh33xFhle7qyEkqeGuRg8bd
   rfhtUfYznLiYiTW4j7JqhP7cttfw91S7OnHOI2UxqWbm+6nDC6v1w2P/l
   WfREz+Tkq4HCq9J9eqZZa15bsm7l8gu+av1CXgNFRouZj9TiEJ14KtQT2
   UcT8A0WmIU2BH6ZMszAuAyPL7jM3Ud2xNIg6iDM8mlITNmgcluMjBdVp3
   /+u1s3wR4y1rF77dcy5CNNLvVqhHFii3e5PfMninXrgk41yscxiFp632i
   E8y298SF1MjQN2kEzJPaDp35uWe2GGoKjFVnxR6BHAIHaG9z5oi9N5bbo
   g==;
X-CSE-ConnectionGUID: 80LjJ4ZpQmu9uuBejx1oLQ==
X-CSE-MsgGUID: Q5HwIWOmRAaSZfzXAddoCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11647"; a="68173889"
X-IronPort-AV: E=Sophos;i="6.21,161,1763452800"; 
   d="scan'208";a="68173889"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2025 09:42:04 -0800
X-CSE-ConnectionGUID: eSkGpu+MSJe6Vp0IXHIm0g==
X-CSE-MsgGUID: /avb1TblQm2VyswbmQCRmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,161,1763452800"; 
   d="scan'208";a="229597857"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.61])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2025 09:42:01 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 09/23] PCI: Fetch dev_res to local var in __assign_resources_sorted()
Date: Fri, 19 Dec 2025 19:40:22 +0200
Message-Id: <20251219174036.16738-10-ilpo.jarvinen@linux.intel.com>
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

__assign_resources_sorted() calls get_res_add_size() and
get_res_add_align(), each walking through the realloc_head list to
relocate the corresponding pci_dev_resource entry.

Fetch the pci_dev_resource entry into a local variable to avoid double
walk.

In addition, reverse logic to reduce indentation level.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/setup-bus.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 09cc225bf107..41417084ddf8 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -596,11 +596,11 @@ static void __assign_resources_sorted(struct list_head *head,
 	LIST_HEAD(local_fail_head);
 	LIST_HEAD(dummy_head);
 	struct pci_dev_resource *save_res;
-	struct pci_dev_resource *dev_res, *tmp_res, *dev_res2;
+	struct pci_dev_resource *dev_res, *tmp_res, *dev_res2, *addsize_res;
 	struct resource *res;
 	struct pci_dev *dev;
 	unsigned long fail_type;
-	resource_size_t add_align, align;
+	resource_size_t align;
 
 	if (!realloc_head)
 		realloc_head = &dummy_head;
@@ -621,8 +621,11 @@ static void __assign_resources_sorted(struct list_head *head,
 	list_for_each_entry_safe(dev_res, tmp_res, head, list) {
 		res = dev_res->res;
 
-		res->end += get_res_add_size(realloc_head, res);
+		addsize_res = res_to_dev_res(realloc_head, res);
+		if (!addsize_res)
+			continue;
 
+		res->end += addsize_res->add_size;
 		/*
 		 * There are two kinds of additional resources in the list:
 		 * 1. bridge resource  -- IORESOURCE_STARTALIGN
@@ -632,8 +635,8 @@ static void __assign_resources_sorted(struct list_head *head,
 		if (!(res->flags & IORESOURCE_STARTALIGN))
 			continue;
 
-		add_align = get_res_add_align(realloc_head, res);
-
+		if (addsize_res->min_align <= res->start)
+			continue;
 		/*
 		 * The "head" list is sorted by alignment so resources with
 		 * bigger alignment will be assigned first.  After we
@@ -641,17 +644,15 @@ static void __assign_resources_sorted(struct list_head *head,
 		 * need to reorder the list by alignment to make it
 		 * consistent.
 		 */
-		if (add_align > res->start) {
-			resource_set_range(res, add_align, resource_size(res));
-
-			list_for_each_entry(dev_res2, head, list) {
-				align = pci_resource_alignment(dev_res2->dev,
-							       dev_res2->res);
-				if (add_align > align) {
-					list_move_tail(&dev_res->list,
-						       &dev_res2->list);
-					break;
-				}
+		resource_set_range(res, addsize_res->min_align,
+				   resource_size(res));
+
+		list_for_each_entry(dev_res2, head, list) {
+			align = pci_resource_alignment(dev_res2->dev,
+						       dev_res2->res);
+			if (addsize_res->min_align > align) {
+				list_move_tail(&dev_res->list, &dev_res2->list);
+				break;
 			}
 		}
 
-- 
2.39.5


