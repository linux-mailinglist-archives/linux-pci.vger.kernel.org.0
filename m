Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45B59246EAC
	for <lists+linux-pci@lfdr.de>; Mon, 17 Aug 2020 19:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731140AbgHQReY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Aug 2020 13:34:24 -0400
Received: from mga06.intel.com ([134.134.136.31]:23627 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388854AbgHQQhR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 17 Aug 2020 12:37:17 -0400
IronPort-SDR: q+rzcPlq90Auq/aRPLAqlDPeH5GJT3VVQz+mWjVNSDqeJKKzsh40NnKWiSgkCOSaD7WCgZTn4L
 Kl0jiT2yyU3Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9716"; a="216269420"
X-IronPort-AV: E=Sophos;i="5.76,324,1592895600"; 
   d="scan'208";a="216269420"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2020 09:36:50 -0700
IronPort-SDR: 6VDQ7tEzI4M1L/xzj1ckwh8odXomutyoBpGCJ9nkA6cYDqM3x0JDySAeufqtdAIucOWs7C+VAH
 M8OATdHytvbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,324,1592895600"; 
   d="scan'208";a="296541466"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 17 Aug 2020 09:36:48 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D68BA250; Mon, 17 Aug 2020 19:36:47 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: [PATCH v2 4/8] resource: Introduce resource_union() for overlapping resources
Date:   Mon, 17 Aug 2020 19:36:43 +0300
Message-Id: <20200817163647.48982-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817163647.48982-1-andriy.shevchenko@linux.intel.com>
References: <20200817163647.48982-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Some already present users may utilize resource_union() helper.
Provide it for them and for wider use in the future.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
---
v2: reused min/max (Rafael)
 include/linux/ioport.h | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index 50fed618d3fb..a7d50b9a3406 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -10,9 +10,10 @@
 #define _LINUX_IOPORT_H
 
 #ifndef __ASSEMBLY__
+#include <linux/bits.h>
 #include <linux/compiler.h>
+#include <linux/minmax.h>
 #include <linux/types.h>
-#include <linux/bits.h>
 /*
  * Resources are tree-like, allowing
  * nesting etc..
@@ -232,6 +233,16 @@ static inline bool resource_overlaps(struct resource *r1, struct resource *r2)
        return r1->start <= r2->end && r1->end >= r2->start;
 }
 
+static inline bool
+resource_union(struct resource *r1, struct resource *r2, struct resource *r)
+{
+	if (!resource_overlaps(r1, r2))
+		return false;
+	r->start = min(r1->start, r2->start);
+	r->end = max(r1->end, r2->end);
+	return true;
+}
+
 /* Convenience shorthand with allocation */
 #define request_region(start,n,name)		__request_region(&ioport_resource, (start), (n), (name), 0)
 #define request_muxed_region(start,n,name)	__request_region(&ioport_resource, (start), (n), (name), IORESOURCE_MUXED)
-- 
2.28.0

