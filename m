Return-Path: <linux-pci+bounces-1295-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 590B681C9FF
	for <lists+linux-pci@lfdr.de>; Fri, 22 Dec 2023 13:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0285B22A41
	for <lists+linux-pci@lfdr.de>; Fri, 22 Dec 2023 12:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51AF18038;
	Fri, 22 Dec 2023 12:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z6uTlkz8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E9B18624;
	Fri, 22 Dec 2023 12:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703248179; x=1734784179;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uopUxSQLxNwYXjsIbC+ClqKACsRbcTsdX+UmVSTtVOc=;
  b=Z6uTlkz8IxZ5uEJ+NrNTdjscP7v07R6PgYIsTQ5nClJX2uhJcTggcIWD
   JLE5giTh7LWP8g1VqlsD//WNokW03bSB6oVUfzP60/dHGHqXCsRXZJ16e
   iOJojXGbQLrdKfgVFy7bim7CMttIsDgOFrdloFLNHzale5hs60zHB1sEV
   /dItKDznMaVHHW2MjxEzCy3tV+Joo/Y4uNeLsdm34ZHOdJvPOJBwskyTw
   K7KKLEKrJQf8g7Zz9C/irq+BwqgHts5orfhe7E0jQZlj3ZraVJ+5VE8tO
   7ohz6YXoFHKRAd9O3AhahwF6xtiOhNkXSi7tL98ZPYhmb3Q/zj14xyihS
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="3195395"
X-IronPort-AV: E=Sophos;i="6.04,296,1695711600"; 
   d="scan'208";a="3195395"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 04:29:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="950263959"
X-IronPort-AV: E=Sophos;i="6.04,296,1695711600"; 
   d="scan'208";a="950263959"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.94.248.105])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 04:29:33 -0800
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
Subject: [PATCH 2/7] resource: Rename find_resource() to find_empty_resource_slot()
Date: Fri, 22 Dec 2023 14:28:56 +0200
Message-Id: <20231222122901.49538-3-ilpo.jarvinen@linux.intel.com>
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

Rename find_resource() to find_empty_resource_slot() to better describe
what the functions does. This is a preparation for exposing it beyond
resource.c which is needed by PCI core. Also rename the __ variant to
match the names.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 kernel/resource.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/kernel/resource.c b/kernel/resource.c
index 866ef3663a0b..94f67005e1e2 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -574,10 +574,9 @@ static void resource_clip(struct resource *res, resource_size_t min,
  * Find empty slot in the resource tree with the given range and
  * alignment constraints
  */
-static int __find_resource(struct resource *root, struct resource *old,
-			 struct resource *new,
-			 resource_size_t  size,
-			 struct resource_constraint *constraint)
+static int __find_empty_resource_slot(struct resource *root, struct resource *old,
+				      struct resource *new, resource_size_t size,
+				      struct resource_constraint *constraint)
 {
 	struct resource *this = root->child;
 	struct resource tmp = *new, avail, alloc;
@@ -633,11 +632,11 @@ next:		if (!this || this->end == root->end)
 /*
  * Find empty slot in the resource tree given range and alignment.
  */
-static int find_resource(struct resource *root, struct resource *new,
-			resource_size_t size,
-			struct resource_constraint  *constraint)
+static int find_empty_resource_slot(struct resource *root, struct resource *new,
+				    resource_size_t size,
+				    struct resource_constraint *constraint)
 {
-	return  __find_resource(root, NULL, new, size, constraint);
+	return  __find_empty_resource_slot(root, NULL, new, size, constraint);
 }
 
 /**
@@ -660,7 +659,7 @@ static int reallocate_resource(struct resource *root, struct resource *old,
 
 	write_lock(&resource_lock);
 
-	if ((err = __find_resource(root, old, &new, newsize, constraint)))
+	if ((err = __find_empty_resource_slot(root, old, &new, newsize, constraint)))
 		goto out;
 
 	if (resource_contains(&new, old)) {
@@ -729,7 +728,7 @@ int allocate_resource(struct resource *root, struct resource *new,
 	}
 
 	write_lock(&resource_lock);
-	err = find_resource(root, new, size, &constraint);
+	err = find_empty_resource_slot(root, new, size, &constraint);
 	if (err >= 0 && __request_resource(root, new))
 		err = -EBUSY;
 	write_unlock(&resource_lock);
-- 
2.30.2


