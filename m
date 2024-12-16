Return-Path: <linux-pci+bounces-18559-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8CB59F386A
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 19:10:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 631C416DEF7
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 18:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85EF1D45FC;
	Mon, 16 Dec 2024 18:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MIddaSYR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43732214A61;
	Mon, 16 Dec 2024 18:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734372001; cv=none; b=igW5AIDd14T6ZlH0zjwqyEZVfAnkZjjRaEsfvtdqfh9+g9irHk03GFbDH4GCuYRpqyQBMJbCOv822M1UE/t8c03omd1Au5sC4bfej1pAm9+qd47bV6eCGpQlu+GSXjJo6rgcjfAixUTXuq5/3XZLlba7evfMpvLKZMkCbRaa4yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734372001; c=relaxed/simple;
	bh=eKJfIjZN13eMf8fXbPs9Jp7cYI+gqZLyEXdz30LMlk8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AXmcIIir18+35dFXHtJGVoKtSP5rcoiaRfaNjPJRpeSYy0d62PFt4Wm+HTGm8FLcBKUzPtKHBMoldl1afh7qD1lRbsAfHRCIo2fUK+6NHkqMvLHQAi147SkmWZT7futH2WclO+7XAj1UPqUzo3fV+ZxUcqj1PzQlBpKIL9C69ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MIddaSYR; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734372000; x=1765908000;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eKJfIjZN13eMf8fXbPs9Jp7cYI+gqZLyEXdz30LMlk8=;
  b=MIddaSYRVJkaNlBJUjWhEA2Rxs32xsTshdl3L/DNIp59ZtXlKeNbrV5L
   +MZFHYR2rbDNQPudl5VGLIyiPTTQt+f+NRR+PXNrXYWAZt/AKUiiWIG3T
   SQtv/7STFyKJMNOHCBD/63CQkhd76RpDvhnnRVy/3tBMz2T98GB81a1ol
   TKzhwb4jXnidIw5G2ND4NT8KkphmjQC8axoJRr5BwqaSp7NPXdIrNZAaS
   BVvl3HW/yyeOnt6bb2XfaGQgPTK34Do8QdbDeUMi5lZJYfE9FC9HXRQ91
   xZFqqQ9aBsDASvbK55TM3w4R06EKvpbfFjI2Mwjeo1eXK/LTObzD9hk8J
   w==;
X-CSE-ConnectionGUID: NVfZwmf3TSekXId2sHbXDw==
X-CSE-MsgGUID: 8kCrqhp2T0+/5ohw2AUuUw==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="52293372"
X-IronPort-AV: E=Sophos;i="6.12,239,1728975600"; 
   d="scan'208";a="52293372"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 10:00:00 -0800
X-CSE-ConnectionGUID: 8nGrb5QMRHqal77wOLZdrw==
X-CSE-MsgGUID: AxcYsLYYT+2R+gT1sRgZtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="120532121"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.29])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 09:59:57 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	=?UTF-8?q?Micha=C5=82=20Winiarski?= <michal.winiarski@intel.com>,
	Igor Mammedov <imammedo@redhat.com>,
	linux-kernel@vger.kernel.org
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 24/25] PCI: Perform reset_resource() and build fail list in sync
Date: Mon, 16 Dec 2024 19:56:31 +0200
Message-Id: <20241216175632.4175-25-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241216175632.4175-1-ilpo.jarvinen@linux.intel.com>
References: <20241216175632.4175-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Resetting resource is problematic as it prevent attempting to allocate
the resource later, unless something in between restores the resource.
Similarly, if fail_head does not contain all resources that were reset,
those resource cannot be restored later.

The entire reset/restore cycle adds complexity and leaving resources
into reseted state causes issues to other code such as for checks done
in pci_enable_resources(). Take a small step towards not resetting
resources by delaying reset until the end of resource assignment and
build failure list (fail_head) in sync with the reset to avoid leaving
behind resources that cannot be restored (for the case where the caller
provides fail_head in the first place to allow restore somewhere in the
callchain, as is not all callers pass non-NULL fail_head).

The Expansion ROM check is temporarily left in place while building the
failure list until the upcoming change which reworks optional resource
handling.

Ideally, whole resource reset could be removed but doing that in a big
step would make the impact non-tractable due to complexity of all
related code.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/setup-bus.c | 35 +++++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index fec7d68fb971..b61f24a5cfa5 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -252,9 +252,14 @@ static void reassign_resources_sorted(struct list_head *realloc_head,
 
 		res = add_res->res;
 		dev = add_res->dev;
+		idx = pci_resource_num(dev, res);
 
-		/* Skip resource that has been reset */
-		if (!res->flags)
+		/*
+		 * Skip resource that failed the earlier assignment and is
+		 * not optional as it would just fail again.
+		 */
+		if (!res->parent && resource_size(res) &&
+		    !pci_resource_is_optional(dev, idx))
 			goto out;
 
 		/* Skip this resource if not found in head list */
@@ -267,7 +272,6 @@ static void reassign_resources_sorted(struct list_head *realloc_head,
 		if (!found_match) /* Just skip */
 			continue;
 
-		idx = pci_resource_num(dev, res);
 		res_name = pci_resource_name(dev, idx);
 		add_size = add_res->add_size;
 		align = add_res->min_align;
@@ -277,7 +281,6 @@ static void reassign_resources_sorted(struct list_head *realloc_head,
 				pci_dbg(dev,
 					"%s %pR: ignoring failure in optional allocation\n",
 					res_name, res);
-				reset_resource(res);
 			}
 		} else {
 			res->flags |= add_res->flags &
@@ -332,7 +335,6 @@ static void assign_requested_resources_sorted(struct list_head *head,
 						    0 /* don't care */,
 						    0 /* don't care */);
 			}
-			reset_resource(res);
 		}
 	}
 }
@@ -518,13 +520,34 @@ static void __assign_resources_sorted(struct list_head *head,
 
 requested_and_reassign:
 	/* Satisfy the must-have resource requests */
-	assign_requested_resources_sorted(head, fail_head);
+	assign_requested_resources_sorted(head, NULL);
 
 	/* Try to satisfy any additional optional resource requests */
 	if (!list_empty(realloc_head))
 		reassign_resources_sorted(realloc_head, head);
 
 out:
+	/* Reset any failed resource, cannot use fail_head as it can be NULL. */
+	list_for_each_entry(dev_res, head, list) {
+		res = dev_res->res;
+		dev = dev_res->dev;
+
+		if (res->parent)
+			continue;
+
+		/*
+		 * If the failed resource is a ROM BAR and it will
+		 * be enabled later, don't add it to the list.
+		 */
+		if (fail_head && !pci_resource_is_disabled_rom(res, idx)) {
+			add_to_list(fail_head, dev, res,
+				    0 /* don't care */,
+				    0 /* don't care */);
+		}
+
+		reset_resource(res);
+	}
+
 	free_list(head);
 }
 
-- 
2.39.5


