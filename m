Return-Path: <linux-pci+bounces-18546-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B40B99F3838
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 19:01:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A89A57A22C1
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 18:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E6720B7F1;
	Mon, 16 Dec 2024 17:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cRiu7aSa"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E544E20B200;
	Mon, 16 Dec 2024 17:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734371897; cv=none; b=C3xrbDoVhiyDrnCLM5UVkhq3Vo+eP1LHgU0RUSnyITIqbo3sqW/hfsRkipb1bzFgSjiUWnnEJZ1l8jE017T6SQZ5s4/iJ3l5cYEFCAMZgaCA4ysjhXpjVuy15tIOgar5be60pgqbJ16qGS4/P9PDbcNGBG1BYoMjLB4aHC1iSX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734371897; c=relaxed/simple;
	bh=D9uYfrOkgZrvwuRpE1K7r8XXHNZgLUYKSCOFmHcML74=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BWR5fbxS3r/PFo2/tzQcowlQbOF6FcSUk0xsylkPczrnCaVsTvrkSCRcjc8MPHw21KKS3a1uCuB9/bowjBSCNwis2Z7Xr91S027sEjn9CjYtf7EZQA50SNIji7ZQ5GSW9W5jAJtVPI3ynjnpHqI6ZRg94u5hskQYYYliPwMxkzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cRiu7aSa; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734371897; x=1765907897;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=D9uYfrOkgZrvwuRpE1K7r8XXHNZgLUYKSCOFmHcML74=;
  b=cRiu7aSaWFv6A0axaUNgs5OTOGWEPrbtOYuQTX2fxJ/AgxHvJLNh42ql
   lw1AKXsvye/MhzIE+nGhfrVYtDNsEeWKOSj4OpkbYDHiJdIdnWDlhtwlG
   YiZ5xA2nLSbsZMc8Y9wYtAmpvMSYt7IHgIBu/4mmzwO7hXA/ZCWrK/PKN
   EwOPD9UkfTJo4I6XwhkwUvfZKhobXM2n8wplufRz6z6tpv26J/l/iDk8v
   MzjPWRiSlAlwT7ZrzUfk+kIr+B9fZeqfMYinDDFemDDPua8l5H3EZprKk
   b5nE0UC3m3q++qGV7wLIqMzyHs2B7XgeTJ9yYjeE2Gwnh0C5Q+yldNojF
   g==;
X-CSE-ConnectionGUID: cFPlslI6QaCcUJuR0t7kCw==
X-CSE-MsgGUID: WN4XbcjCSeeaRwHfwulqzw==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="38544022"
X-IronPort-AV: E=Sophos;i="6.12,239,1728975600"; 
   d="scan'208";a="38544022"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 09:58:16 -0800
X-CSE-ConnectionGUID: dStXW45TTgGTsPhb4Ql6hQ==
X-CSE-MsgGUID: 7Dddt8boSoWIVyejvLP4sA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,239,1728975600"; 
   d="scan'208";a="97149756"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.29])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 09:58:13 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	=?UTF-8?q?Micha=C5=82=20Winiarski?= <michal.winiarski@intel.com>,
	Igor Mammedov <imammedo@redhat.com>,
	linux-kernel@vger.kernel.org
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 11/25] PCI: Add dev & res local variables to resource assignment funcs
Date: Mon, 16 Dec 2024 19:56:18 +0200
Message-Id: <20241216175632.4175-12-ilpo.jarvinen@linux.intel.com>
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

Many PCI resource allocation related functions process struct
pci_dev_resource items which hold the struct pci_dev and resource
pointers. Reduce the number of lines that need indirection by adding
'dev' and 'res' local variable to hold the pointers.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/setup-bus.c | 66 +++++++++++++++++++++++------------------
 1 file changed, 37 insertions(+), 29 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 8831365418d6..6b4318da1147 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -216,10 +216,11 @@ static inline void reset_resource(struct resource *res)
 static void reassign_resources_sorted(struct list_head *realloc_head,
 				      struct list_head *head)
 {
-	struct resource *res;
-	const char *res_name;
 	struct pci_dev_resource *add_res, *tmp;
 	struct pci_dev_resource *dev_res;
+	struct pci_dev *dev;
+	struct resource *res;
+	const char *res_name;
 	resource_size_t add_size, align;
 	int idx;
 
@@ -227,6 +228,7 @@ static void reassign_resources_sorted(struct list_head *realloc_head,
 		bool found_match = false;
 
 		res = add_res->res;
+		dev = add_res->dev;
 
 		/* Skip resource that has been reset */
 		if (!res->flags)
@@ -242,20 +244,19 @@ static void reassign_resources_sorted(struct list_head *realloc_head,
 		if (!found_match) /* Just skip */
 			continue;
 
-		idx = pci_resource_num(add_res->dev, res);
-		res_name = pci_resource_name(add_res->dev, idx);
+		idx = pci_resource_num(dev, res);
+		res_name = pci_resource_name(dev, idx);
 		add_size = add_res->add_size;
 		align = add_res->min_align;
 		if (!resource_size(res)) {
 			resource_set_range(res, align, add_size);
-			if (pci_assign_resource(add_res->dev, idx))
+			if (pci_assign_resource(dev, idx))
 				reset_resource(res);
 		} else {
 			res->flags |= add_res->flags &
 				 (IORESOURCE_STARTALIGN|IORESOURCE_SIZEALIGN);
-			if (pci_reassign_resource(add_res->dev, idx,
-						  add_size, align))
-				pci_info(add_res->dev, "%s %pR: failed to add %llx\n",
+			if (pci_reassign_resource(dev, idx, add_size, align))
+				pci_info(dev, "%s %pR: failed to add %llx\n",
 					 res_name, res,
 					 (unsigned long long) add_size);
 		}
@@ -278,18 +279,20 @@ static void reassign_resources_sorted(struct list_head *realloc_head,
 static void assign_requested_resources_sorted(struct list_head *head,
 				 struct list_head *fail_head)
 {
-	struct resource *res;
 	struct pci_dev_resource *dev_res;
+	struct resource *res;
+	struct pci_dev *dev;
 	int idx;
 
 	list_for_each_entry(dev_res, head, list) {
 		res = dev_res->res;
-		idx = pci_resource_num(dev_res->dev, res);
+		dev = dev_res->dev;
+		idx = pci_resource_num(dev, res);
 
 		if (!resource_size(res))
 			continue;
 
-		if (pci_assign_resource(dev_res->dev, idx)) {
+		if (pci_assign_resource(dev, idx)) {
 			if (fail_head) {
 				/*
 				 * If the failed resource is a ROM BAR and
@@ -298,8 +301,7 @@ static void assign_requested_resources_sorted(struct list_head *head,
 				 */
 				if (!((idx == PCI_ROM_RESOURCE) &&
 				      (!(res->flags & IORESOURCE_ROM_ENABLE))))
-					add_to_list(fail_head,
-						    dev_res->dev, res,
+					add_to_list(fail_head, dev, res,
 						    0 /* don't care */,
 						    0 /* don't care */);
 			}
@@ -377,6 +379,7 @@ static void __assign_resources_sorted(struct list_head *head,
 	LIST_HEAD(local_fail_head);
 	struct pci_dev_resource *save_res;
 	struct pci_dev_resource *dev_res, *tmp_res, *dev_res2;
+	struct resource *res;
 	unsigned long fail_type;
 	resource_size_t add_align, align;
 
@@ -394,8 +397,9 @@ static void __assign_resources_sorted(struct list_head *head,
 
 	/* Update res in head list with add_size in realloc_head list */
 	list_for_each_entry_safe(dev_res, tmp_res, head, list) {
-		dev_res->res->end += get_res_add_size(realloc_head,
-							dev_res->res);
+		res = dev_res->res;
+
+		res->end += get_res_add_size(realloc_head, res);
 
 		/*
 		 * There are two kinds of additional resources in the list:
@@ -403,10 +407,10 @@ static void __assign_resources_sorted(struct list_head *head,
 		 * 2. SR-IOV resource  -- IORESOURCE_SIZEALIGN
 		 * Here just fix the additional alignment for bridge
 		 */
-		if (!(dev_res->res->flags & IORESOURCE_STARTALIGN))
+		if (!(res->flags & IORESOURCE_STARTALIGN))
 			continue;
 
-		add_align = get_res_add_align(realloc_head, dev_res->res);
+		add_align = get_res_add_align(realloc_head, res);
 
 		/*
 		 * The "head" list is sorted by alignment so resources with
@@ -415,9 +419,8 @@ static void __assign_resources_sorted(struct list_head *head,
 		 * need to reorder the list by alignment to make it
 		 * consistent.
 		 */
-		if (add_align > dev_res->res->start) {
-			resource_set_range(dev_res->res, add_align,
-					   resource_size(dev_res->res));
+		if (add_align > res->start) {
+			resource_set_range(res, add_align, resource_size(res));
 
 			list_for_each_entry(dev_res2, head, list) {
 				align = pci_resource_alignment(dev_res2->dev,
@@ -448,24 +451,29 @@ static void __assign_resources_sorted(struct list_head *head,
 	/* Check failed type */
 	fail_type = pci_fail_res_type_mask(&local_fail_head);
 	/* Remove not need to be released assigned res from head list etc */
-	list_for_each_entry_safe(dev_res, tmp_res, head, list)
-		if (dev_res->res->parent &&
-		    !pci_need_to_release(fail_type, dev_res->res)) {
+	list_for_each_entry_safe(dev_res, tmp_res, head, list) {
+		res = dev_res->res;
+
+		if (res->parent && !pci_need_to_release(fail_type, res)) {
 			/* Remove it from realloc_head list */
-			remove_from_list(realloc_head, dev_res->res);
-			remove_from_list(&save_head, dev_res->res);
+			remove_from_list(realloc_head, res);
+			remove_from_list(&save_head, res);
 			list_del(&dev_res->list);
 			kfree(dev_res);
 		}
+	}
 
 	free_list(&local_fail_head);
 	/* Release assigned resource */
-	list_for_each_entry(dev_res, head, list)
-		if (dev_res->res->parent)
-			release_resource(dev_res->res);
+	list_for_each_entry(dev_res, head, list) {
+		res = dev_res->res;
+
+		if (res->parent)
+			release_resource(res);
+	}
 	/* Restore start/end/flags from saved list */
 	list_for_each_entry(save_res, &save_head, list) {
-		struct resource *res = save_res->res;
+		res = save_res->res;
 
 		res->start = save_res->start;
 		res->end = save_res->end;
-- 
2.39.5


