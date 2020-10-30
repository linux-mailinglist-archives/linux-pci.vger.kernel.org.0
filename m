Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34F4F2A0C5D
	for <lists+linux-pci@lfdr.de>; Fri, 30 Oct 2020 18:26:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbgJ3R0I (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Oct 2020 13:26:08 -0400
Received: from mga06.intel.com ([134.134.136.31]:57807 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726814AbgJ3R0H (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 30 Oct 2020 13:26:07 -0400
IronPort-SDR: ndwxYtgZMSpMB/VPiZ0p/eeYX4KBJ8xeU8Y+mOmgn0ri+b/poid6Y/+BxzglACJfGZ9U0yVsyw
 dk66R9qeaQFg==
X-IronPort-AV: E=McAfee;i="6000,8403,9790"; a="230276204"
X-IronPort-AV: E=Sophos;i="5.77,434,1596524400"; 
   d="scan'208";a="230276204"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 10:26:06 -0700
IronPort-SDR: PO9Rxe2POxWF8JKjpCzkqBGqSyYOm120Fdsm5hCO3NQFMgmgFT0/wVbXmYbf87NyIlpNH6flaA
 JduKGRCFqlgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,434,1596524400"; 
   d="scan'208";a="537135871"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 30 Oct 2020 10:26:04 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 79A83567; Fri, 30 Oct 2020 19:26:03 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: [PATCH v3 3/6] resource: Introduce resource_union() for overlapping resources
Date:   Fri, 30 Oct 2020 19:25:53 +0200
Message-Id: <20201030172556.21686-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201030172556.21686-1-andriy.shevchenko@linux.intel.com>
References: <20201030172556.21686-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 include/linux/ioport.h | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index df4581107536..40320eb5bc0e 100644
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
@@ -235,6 +236,16 @@ static inline bool resource_overlaps(struct resource *r1, struct resource *r2)
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

