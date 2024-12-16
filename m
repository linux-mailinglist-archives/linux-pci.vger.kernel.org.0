Return-Path: <linux-pci+bounces-18551-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E89C9F385B
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 19:07:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1FB21675B3
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 18:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE5A212FBA;
	Mon, 16 Dec 2024 17:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WZxlUDrJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683C9212F98;
	Mon, 16 Dec 2024 17:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734371936; cv=none; b=qnlw4zaFPhLTHnMxmg+KHFbHm83BYirENhMdBtJ8gGHFEywg8uY0ljqDF22GDkBPbROKQz1eouXH6ibfH3E2B/Jbq4TCj1O18GD0xGAsmay6zhGfb+WjPZAo7xUXyVUANqC5IsV2B0gX7io2+psGM2Rzdu7M3jWwQY9xxMu3wNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734371936; c=relaxed/simple;
	bh=FPVU3BhF8RIKsGWqmEbMzCHaik7SmiH1D7yHT/HhAmE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HjxX4tU6O9d4rg2mFzMftB5CGesu65mmeLm2Ar4Y2EO5aXmvusj35cy7DYDhRrgf14mE8SfutlZN3oUz/RIG8caSTWSShCB967y6d3R/1s6OEtOfzoOyjy0EaFLPn/FEfUXa3Nk2aNw6i3vVGT/JfXlOCffa1+zLHpeE/5c8xNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WZxlUDrJ; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734371936; x=1765907936;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FPVU3BhF8RIKsGWqmEbMzCHaik7SmiH1D7yHT/HhAmE=;
  b=WZxlUDrJd9dhzZl475JA+nnAXepuAE8CSb+FN9hcgU5FE8j8tC1kqzGF
   LawQL25T7+uss4OvXtSJWQ+FbfF6Eq7Os3firaCLGGZ8weV/XuIb5ShO4
   mqOrJd8P4XoqYP8aXHMsOpVuYjlfT3Bkh8iG9ZEaLQDiaj7OBh1RlpVkx
   qse9D3p7f8dQjlCdparqAs5EmYm1XJGQXpUwHSge0V7B3IhmMOD6rTU64
   UuLPSEm47qXL98gSGvLlk+iUvYp6vM8Hgea9Jo0mLn5G6zDrmOlFZILnA
   4OT46cyCJz2U4R4ag69kX2R3xml6jRVLolugTb5FUh3oF30yIM60pXJA0
   g==;
X-CSE-ConnectionGUID: YrgfxE8fRESHv4Phmphavw==
X-CSE-MsgGUID: v+I0gxkLQEKsCGR70ETRKQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="57251061"
X-IronPort-AV: E=Sophos;i="6.12,239,1728975600"; 
   d="scan'208";a="57251061"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 09:58:55 -0800
X-CSE-ConnectionGUID: Uo4wq7AySi6u1o8AitJ8xw==
X-CSE-MsgGUID: l6ym752sS4S4HD8QdTiGUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="101419184"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.29])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 09:58:51 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	=?UTF-8?q?Micha=C5=82=20Winiarski?= <michal.winiarski@intel.com>,
	Igor Mammedov <imammedo@redhat.com>,
	linux-kernel@vger.kernel.org
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 16/25] PCI: Consolidate assignment loop next round preparation
Date: Mon, 16 Dec 2024 19:56:23 +0200
Message-Id: <20241216175632.4175-17-ilpo.jarvinen@linux.intel.com>
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

pci_assign_unassigned_root_bus_resources() and
pci_assign_unassigned_bridge_resources() have a loop that performs a
number rounds to assign resources. The code to prepare for the next
round is identical.

Consolidate the code that prepares for the next assignment round
into pci_prepare_next_assign_round().

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/setup-bus.c | 104 ++++++++++++++++------------------------
 1 file changed, 42 insertions(+), 62 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 38dbe8b99910..7e5985543734 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -2135,6 +2135,45 @@ pci_root_bus_distribute_available_resources(struct pci_bus *bus,
 	}
 }
 
+static void pci_prepare_next_assign_round(struct list_head *fail_head,
+					  int tried_times,
+					  enum release_type rel_type)
+{
+	struct pci_dev_resource *fail_res;
+
+	pr_info("PCI: No. %d try to assign unassigned res\n", tried_times + 1);
+
+	/*
+	 * Try to release leaf bridge's resources that aren't big
+	 * enough to contain child device resources.
+	 */
+	list_for_each_entry(fail_res, fail_head, list) {
+		pci_bus_release_bridge_resources(fail_res->dev->bus,
+						 fail_res->flags & PCI_RES_TYPE_MASK,
+						 rel_type);
+	}
+
+	/* Restore size and flags */
+	list_for_each_entry(fail_res, fail_head, list) {
+		struct resource *res = fail_res->res;
+		struct pci_dev *dev = fail_res->dev;
+		int idx = pci_resource_num(dev, res);
+
+		res->start = fail_res->start;
+		res->end = fail_res->end;
+		res->flags = fail_res->flags;
+
+		if (!pci_is_bridge(dev))
+			continue;
+
+		if (idx >= PCI_BRIDGE_RESOURCES &&
+		    idx <= PCI_BRIDGE_RESOURCE_END)
+			res->flags = 0;
+	}
+
+	free_list(fail_head);
+}
+
 /*
  * First try will not touch PCI bridge res.
  * Second and later try will clear small leaf bridge res.
@@ -2148,7 +2187,6 @@ void pci_assign_unassigned_root_bus_resources(struct pci_bus *bus)
 	int tried_times = 0;
 	enum release_type rel_type = leaf_only;
 	LIST_HEAD(fail_head);
-	struct pci_dev_resource *fail_res;
 	int pci_try_num = 1;
 	enum enable_type enable_local;
 
@@ -2199,40 +2237,11 @@ void pci_assign_unassigned_root_bus_resources(struct pci_bus *bus)
 			break;
 		}
 
-		dev_info(&bus->dev, "No. %d try to assign unassigned res\n",
-			 tried_times + 1);
-
 		/* Third times and later will not check if it is leaf */
 		if (tried_times + 1 > 2)
 			rel_type = whole_subtree;
 
-		/*
-		 * Try to release leaf bridge's resources that doesn't fit
-		 * resource of child device under that bridge.
-		 */
-		list_for_each_entry(fail_res, &fail_head, list) {
-			pci_bus_release_bridge_resources(fail_res->dev->bus,
-							 fail_res->flags & PCI_RES_TYPE_MASK,
-							 rel_type);
-		}
-
-		/* Restore size and flags */
-		list_for_each_entry(fail_res, &fail_head, list) {
-			struct resource *res = fail_res->res;
-			int idx;
-
-			res->start = fail_res->start;
-			res->end = fail_res->end;
-			res->flags = fail_res->flags;
-
-			if (pci_is_bridge(fail_res->dev)) {
-				idx = pci_resource_num(fail_res->dev, res);
-				if (idx >= PCI_BRIDGE_RESOURCES &&
-				    idx <= PCI_BRIDGE_RESOURCE_END)
-					res->flags = 0;
-			}
-		}
-		free_list(&fail_head);
+		pci_prepare_next_assign_round(&fail_head, tried_times, rel_type);
 	}
 
 	pci_bus_dump_resources(bus);
@@ -2258,7 +2267,6 @@ void pci_assign_unassigned_bridge_resources(struct pci_dev *bridge)
 	LIST_HEAD(add_list);
 	int tried_times = 0;
 	LIST_HEAD(fail_head);
-	struct pci_dev_resource *fail_res;
 	int ret;
 
 	while (1) {
@@ -2284,36 +2292,8 @@ void pci_assign_unassigned_bridge_resources(struct pci_dev *bridge)
 			break;
 		}
 
-		printk(KERN_DEBUG "PCI: No. %d try to assign unassigned res\n",
-				 tried_times + 1);
-
-		/*
-		 * Try to release leaf bridge's resources that aren't big
-		 * enough to contain child device resources.
-		 */
-		list_for_each_entry(fail_res, &fail_head, list) {
-			pci_bus_release_bridge_resources(fail_res->dev->bus,
-							 fail_res->flags & PCI_RES_TYPE_MASK,
-							 whole_subtree);
-		}
-
-		/* Restore size and flags */
-		list_for_each_entry(fail_res, &fail_head, list) {
-			struct resource *res = fail_res->res;
-			int idx;
-
-			res->start = fail_res->start;
-			res->end = fail_res->end;
-			res->flags = fail_res->flags;
-
-			if (pci_is_bridge(fail_res->dev)) {
-				idx = pci_resource_num(fail_res->dev, res);
-				if (idx >= PCI_BRIDGE_RESOURCES &&
-				    idx <= PCI_BRIDGE_RESOURCE_END)
-					res->flags = 0;
-			}
-		}
-		free_list(&fail_head);
+		pci_prepare_next_assign_round(&fail_head, tried_times,
+					      whole_subtree);
 	}
 
 	ret = pci_reenable_device(bridge);
-- 
2.39.5


