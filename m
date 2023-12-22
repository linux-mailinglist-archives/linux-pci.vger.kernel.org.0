Return-Path: <linux-pci+bounces-1298-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5059781CA07
	for <lists+linux-pci@lfdr.de>; Fri, 22 Dec 2023 13:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15913287945
	for <lists+linux-pci@lfdr.de>; Fri, 22 Dec 2023 12:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC16312E70;
	Fri, 22 Dec 2023 12:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aqHQFIXK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FDC1A5A3;
	Fri, 22 Dec 2023 12:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703248216; x=1734784216;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tV8ZA6+9dVotj+4bWIAu5XQOfKl/tj4X1maAI3jCdoY=;
  b=aqHQFIXKctmYpZLQVTMnWNeFSGYbZ+cqyCFGWaTKGN6uytd+n4+xBZcA
   ttN1z12lwm/+oj1MSsXE2ZF4DnEdtRL/O6gzgBkMnFPE00hjU/hCcIQQ+
   8/EmYw9cLQMNHZEEQG1IS/V/ZP0Boj+HntTaDMv7KrLFFuIUwXIAqYXi0
   ENzPsY39NcrKNHh9QrdbdWKTrxfEJnMB50Pq8DYt/22AdVMcoVwNvNHZ/
   MYAymt0iPB6q2Cxz8P2TKlRSg9knwAfZb4/DhAZgjwDmAu686bxoKc+Im
   MOacT8iAM/E6QbPLychAXyY2VwEUmdsQnA9UmUpFY//R4527d/R2K80qY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="2957180"
X-IronPort-AV: E=Sophos;i="6.04,296,1695711600"; 
   d="scan'208";a="2957180"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 04:30:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,296,1695711600"; 
   d="scan'208";a="19016876"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.94.248.105])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 04:30:10 -0800
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
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 5/7] resource: Handle simple alignment inside __find_empty_resource_slot()
Date: Fri, 22 Dec 2023 14:28:59 +0200
Message-Id: <20231222122901.49538-6-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231222122901.49538-1-ilpo.jarvinen@linux.intel.com>
References: <20231222122901.49538-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

allocate_resource() accepts alignf callback to perform custom alignment
beyond constraint->align. If alignf is NULL, simple_align_resource() is
used which only returns avail->start (no change).

Using avail->start directly is natural and can be done with a
conditional in __find_empty_resource_slot() instead which avoids
unnecessarily using callback. It makes the code inside
__find_empty_resource_slot() more obvious and removes the need for the
caller to provide constraint->alignf unnecessarily.

This is preparation for exporting find_empty_resource_slot().

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 kernel/resource.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/kernel/resource.c b/kernel/resource.c
index 9d7920104120..80d64b6467b3 100644
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
@@ -618,8 +611,13 @@ static int __find_empty_resource_slot(struct resource *root, struct resource *ol
 		avail.flags = new->flags & ~IORESOURCE_UNSET;
 		if (avail.start >= tmp.start) {
 			alloc.flags = avail.flags;
-			alloc.start = constraint->alignf(constraint->alignf_data, &avail,
-					size, constraint->align);
+			if (alignf) {
+				alloc.start = alignf(constraint->alignf_data,
+						     &avail, size,
+						     constraint->align);
+			} else {
+				alloc.start = avail.start;
+			}
 			alloc.end = alloc.start + size - 1;
 			if (alloc.start <= alloc.end &&
 			    resource_contains(&avail, &alloc)) {
@@ -730,9 +728,6 @@ int allocate_resource(struct resource *root, struct resource *new,
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


