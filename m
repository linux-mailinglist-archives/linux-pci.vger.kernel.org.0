Return-Path: <linux-pci+bounces-1511-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B08181FA1A
	for <lists+linux-pci@lfdr.de>; Thu, 28 Dec 2023 17:58:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16F64284DC0
	for <lists+linux-pci@lfdr.de>; Thu, 28 Dec 2023 16:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3DCF50C;
	Thu, 28 Dec 2023 16:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HcWG7dvP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA2C10780;
	Thu, 28 Dec 2023 16:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703782695; x=1735318695;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3UeWqTc17b7iPzk1HVe/oYZDCXCyjBwLkhpNmmvXEjw=;
  b=HcWG7dvP1MycaW0AkFmXKH+k7N2UigDsmv+fQ94kJYfjEbpO4t87XBwb
   ISQ0FkV2KnttKjJQ6VNtDPlbezWND87Jk7OewrRVhfME3j31us2YZG5bX
   xSQkBpu8pxR2UqVZUjtEtltrPegKtqOuHH/zWlbRYldK/XRjJOxYyD87d
   pNlp5N27nrqWdj2miPFrbOwtFGn5ht1ZsmKRfifbH+LcQEWdnBi35sPdX
   pl+euJzuK0DuUqm/Lp/159mnXTHCXD1jcEuwZSEHGf7YnP2JaDxX+9DdH
   T9wNUWQpEtfL3MqOR6YMCqPmTXGdzJmVAx1wYB+Do7wQqa5dae3pCZTdU
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10937"; a="9958053"
X-IronPort-AV: E=Sophos;i="6.04,312,1695711600"; 
   d="scan'208";a="9958053"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2023 08:58:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10937"; a="951847238"
X-IronPort-AV: E=Sophos;i="6.04,312,1695711600"; 
   d="scan'208";a="951847238"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.94.250.171])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2023 08:58:09 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Igor Mammedov <imammedo@redhat.com>,
	Lukas Wunner <lukas@wunner.de>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 5/7] resource: Handle simple alignment inside __find_empty_resource_slot()
Date: Thu, 28 Dec 2023 18:57:05 +0200
Message-Id: <20231228165707.3447-6-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231228165707.3447-1-ilpo.jarvinen@linux.intel.com>
References: <20231228165707.3447-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

allocate_resource() accepts ->alignf() callback to perform custom
alignment beyond constraint->align. If alignf is NULL,
simple_align_resource() is used which only returns avail->start (no
change).

Using avail->start directly is natural and can be done with a
conditional in __find_empty_resource_slot() instead which avoids
unnecessarily using callback. It makes the code inside
__find_empty_resource_slot() more obvious and removes the need for the
caller to provide constraint->alignf unnecessarily.

This is preparation for exporting find_empty_resource_slot().

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 kernel/resource.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/kernel/resource.c b/kernel/resource.c
index 9d7920104120..f0e4d57d0c35 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -563,14 +563,6 @@ void __weak arch_remove_reservations(struct resource *avail)
 {
 }
 
-static resource_size_t simple_align_resource(void *data,
-					     const struct resource *avail,
-					     resource_size_t size,
-					     resource_size_t align)
-{
-	return avail->start;
-}
-
 static void resource_clip(struct resource *res, resource_size_t min,
 			  resource_size_t max)
 {
@@ -590,6 +582,7 @@ static int __find_empty_resource_slot(struct resource *root, struct resource *ol
 {
 	struct resource *this = root->child;
 	struct resource tmp = *new, avail, alloc;
+	resource_alignf alignf = constraint->alignf;
 
 	tmp.start = root->start;
 	/*
@@ -618,8 +611,12 @@ static int __find_empty_resource_slot(struct resource *root, struct resource *ol
 		avail.flags = new->flags & ~IORESOURCE_UNSET;
 		if (avail.start >= tmp.start) {
 			alloc.flags = avail.flags;
-			alloc.start = constraint->alignf(constraint->alignf_data, &avail,
-					size, constraint->align);
+			if (alignf) {
+				alloc.start = alignf(constraint->alignf_data,
+						     &avail, size, constraint->align);
+			} else {
+				alloc.start = avail.start;
+			}
 			alloc.end = alloc.start + size - 1;
 			if (alloc.start <= alloc.end &&
 			    resource_contains(&avail, &alloc)) {
@@ -730,9 +727,6 @@ int allocate_resource(struct resource *root, struct resource *new,
 	int err;
 	struct resource_constraint constraint;
 
-	if (!alignf)
-		alignf = simple_align_resource;
-
 	constraint.min = min;
 	constraint.max = max;
 	constraint.align = align;
-- 
2.30.2


